-- LSP / treesitter / formato para TypeScript (Angular, NestJS), Go y Rust.
local map = vim.keymap.set

-- ── LSP ──────────────────────────────────────────────────────────────────
-- nombres de nvim-lspconfig; mason-lspconfig los instala y los habilita solo
local servers = {
  'ts_ls', 'angularls', 'eslint', 'html', 'cssls', 'jsonls', 'yamlls', -- web / TS
  'gopls',                                                             -- Go
  'rust_analyzer', 'taplo',                                            -- Rust / Cargo.toml
  'lua_ls',
}
-- formateadores / linters que no son LSP
local tools = { 'prettier', 'stylua', 'goimports', 'golangci-lint' }

require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = servers, automatic_enable = true })

local reg = require('mason-registry')
reg.refresh(function()
  for _, name in ipairs(tools) do
    local ok, pkg = pcall(reg.get_package, name)
    if ok and not pkg:is_installed() then pkg:install() end
  end
end)

vim.lsp.config('gopls', { settings = { gopls = {
  gofumpt = true,
  staticcheck = true,
  analyses = { unusedparams = true, shadow = true },
  hints = { parameterNames = true, assignVariableTypes = true, compositeLiteralFields = true },
} } })

vim.lsp.config('rust_analyzer', { settings = { ['rust-analyzer'] = {
  check = { command = 'clippy' },
  cargo = { allFeatures = true },
  inlayHints = { parameterHints = { enable = true }, typeHints = { enable = true } },
} } })

local ts_hints = {
  includeInlayParameterNameHints = 'literals',
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayVariableTypeHints = false,
}
vim.lsp.config('ts_ls', { settings = { typescript = { inlayHints = ts_hints }, javascript = { inlayHints = ts_hints } } })

vim.lsp.config('lua_ls', { settings = { Lua = {
  runtime = { version = 'LuaJIT' },
  diagnostics = { globals = { 'vim' } },
  workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
  telemetry = { enable = false },
} } })

-- Angular: templates *.component.html usan el filetype htmlangular
vim.filetype.add({ pattern = { ['.*%.component%.html'] = 'htmlangular' } })

-- SAP CDS (opcional): define CDS_LSP con la ruta a cds-lsp para activarlo
if vim.env.CDS_LSP and vim.fn.executable(vim.env.CDS_LSP) == 1 then
  vim.lsp.config('sapcds_lsp', {
    cmd = { vim.env.CDS_LSP, '--stdio' },
    filetypes = { 'cds' },
    root_markers = { '.git', 'package.json' },
  })
  vim.lsp.enable('sapcds_lsp')
end

vim.api.nvim_create_autocmd('LspAttach', { callback = function(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  local function m(lhs, rhs) map('n', lhs, rhs, { buffer = ev.buf }) end
  if client:supports_method('textDocument/completion') then
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
  end
  if client:supports_method('textDocument/inlayHint') then
    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
  end
  m('gd', vim.lsp.buf.definition)
  m('gi', vim.lsp.buf.implementation)
  m('gy', vim.lsp.buf.type_definition)
  m('<c-k>', vim.lsp.buf.signature_help)
  m('<leader>ih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf }) end)
  -- por defecto en 0.11+: K hover, grr refs, grn rename, gra code action, gO simbolos, ]d [d diagnosticos
end })

vim.diagnostic.config({ virtual_text = { current_line = true } })

-- ── Treesitter (rama main) ───────────────────────────────────────────────
-- Necesita el CLI `tree-sitter` y un compilador C; ver README.
local langs = {
  'typescript', 'tsx', 'javascript', 'html', 'angular', 'css', 'scss', 'json', 'yaml',
  'go', 'gomod', 'gosum', 'gowork', 'rust', 'toml', 'lua', 'markdown', 'markdown_inline',
  'vim', 'vimdoc', 'bash', 'regex',
}
if vim.fn.executable('tree-sitter') == 1 then
  require('nvim-treesitter').install(langs)
end
vim.treesitter.language.register('angular', 'htmlangular')

-- parser propio de CDS (opcional): define TS_CDS_PATH con la ruta a tree-sitter-cds
if vim.env.TS_CDS_PATH then
  vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate', callback = function()
    require('nvim-treesitter.parsers').cds = { install_info = { path = vim.env.TS_CDS_PATH } }
  end })
  vim.treesitter.language.register('cds', { 'cds', 'cdl', 'hdbcds' })
end

-- highlight: arranca treesitter si hay parser para el filetype
vim.api.nvim_create_autocmd('FileType', { callback = function(ev)
  pcall(vim.treesitter.start, ev.buf)
end })

-- ── Formato (conform) ────────────────────────────────────────────────────
local prettier = { 'prettier' }
require('conform').setup({
  formatters_by_ft = {
    javascript = prettier, typescript = prettier, typescriptreact = prettier,
    html = prettier, htmlangular = prettier, css = prettier, scss = prettier,
    json = prettier, yaml = prettier, markdown = prettier,
    go = { 'goimports', 'gofmt' },
    rust = { 'rustfmt' },
    lua = { 'stylua' },
  },
  default_format_opts = { lsp_format = 'fallback' },
  format_on_save = { timeout_ms = 2000, lsp_format = 'fallback' },
})
map({ 'n', 'v' }, '<leader>F', function() require('conform').format() end, { desc = 'Format' })
map('n', '<leader>fl', function() require('conform').format() end, { desc = 'Format' })
