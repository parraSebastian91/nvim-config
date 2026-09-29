-- Neovim >= 0.12 (usa vim.pack). Ver README.md para instalacion.
local opt, g, map = vim.opt, vim.g, vim.keymap.set
local is_win = vim.fn.has('win32') == 1

g.mapleader = ' '
g.loaded_netrw = 1 -- nvim-tree reemplaza a netrw
g.loaded_netrwPlugin = 1

-- ── Plugins ──────────────────────────────────────────────────────────────
-- treesitter: correr :TSUpdate al instalar/actualizar
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

vim.pack.add({
  'https://github.com/folke/tokyonight.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/David-Kunz/treesitter-unit',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/github/copilot.vim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/voldikss/vim-floaterm',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/echasnovski/mini.files',
  'https://github.com/nvim-tree/nvim-tree.lua',
  'https://github.com/romgrk/barbar.nvim',
})

-- ── Opciones ─────────────────────────────────────────────────────────────
opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup', 'nearest' }
opt.laststatus = 0
opt.mouse = 'a'
opt.splitright = true
opt.splitbelow = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.number = false
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 520
opt.undofile = true
opt.termguicolors = true
opt.path:append('**')
g.netrw_banner = false
g.netrw_liststyle = 3
g.markdown_recommended_style = 0
g.markdown_fenced_languages = { 'javascript', 'js=javascript', 'json=javascript', 'typescript', 'go', 'rust' }

opt.fillchars = {
  horiz = '█', horizup = '█', horizdown = '█', vert = '█',
  vertleft = '█', vertright = '█', verthoriz = '█', fold = ' ',
}

-- folds por treesitter
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''
opt.foldopen = 'search'

-- Windows: PowerShell como shell (pwsh si existe)
if is_win then
  local sh = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
  opt.shell = sh
  opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LASTEXITCODE'
  opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LASTEXITCODE'
  opt.shellquote = ''
  opt.shellxquote = ''
end

-- ── Colores ──────────────────────────────────────────────────────────────
vim.cmd.colorscheme('tokyonight')
local function highlights()
  for _, grp in ipairs({ '@function', '@function.builtin', '@function.call', '@function.macro',
    '@function.method', '@function.method.call', '@lsp.type.function', '@lsp.type.method' }) do
    vim.api.nvim_set_hl(0, grp, { bg = '#1f2b2d' })
  end
  vim.api.nvim_set_hl(0, '@lsp.type.parameter', { bg = '#082b2d' })
  for _, grp in ipairs({ 'DiffAdd', 'DiffChange', 'DiffText' }) do
    vim.api.nvim_set_hl(0, grp, { fg = 'NONE', bold = false })
  end
end
highlights()
-- se reaplican si cambias de colorscheme
vim.api.nvim_create_autocmd('ColorScheme', { callback = highlights })

vim.api.nvim_create_autocmd('TextYankPost', { callback = function()
  vim.hl.on_yank({ higroup = 'IncSearch', timeout = 150, on_visual = true })
end })

-- ── Keymaps generales ────────────────────────────────────────────────────
map('n', '<leader>v', ':e $MYVIMRC<CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', '<Cmd>BufferClose<CR>') -- pregunta si hay cambios sin guardar
map('n', '<leader><esc><esc>', ':tabclose<CR>')
map('n', '<leader>p', function() vim.pack.update() end)
map('n', '<leader>n', function()
  vim.cmd.tabedit(vim.fn.stdpath('data') .. '/notes.md')
end)
map('n', '<c-o>', '<c-o>zz')
map('n', '<c-i>', '<c-i>zz')
map('i', '<c-r>', '<c-r><c-o>')
map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<leader>fy', function()
  vim.fn.setreg('"', vim.fn.expand('%') .. ':' .. vim.fn.line('.') .. ':' .. vim.fn.col('.'))
end)
map('n', '<leader>yf', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
  print('Yanked: ' .. vim.fn.expand('%'))
end)

-- abreviaturas
for lhs, rhs in pairs({
  [':tup:'] = '👍', [':tdo:'] = '👎', [':smi:'] = '😊', [':sad:'] = '😔',
  [':demo:'] = '💻 Demo', emri = '✅', emwr = '❌',
}) do vim.cmd(('iabbrev %s %s'):format(lhs, rhs)) end

-- ── mini.files ───────────────────────────────────────────────────────────
require('mini.files').setup({ mappings = { go_in_plus = 'l' } })
map('n', '\\', function()
  if not MiniFiles.close() then
    local name = vim.api.nvim_buf_get_name(0)
    MiniFiles.open(vim.fn.filereadable(name) == 1 and name or vim.fn.getcwd())
  end
end, { silent = true })

-- ── Arbol lateral (nvim-tree) y pestañas (barbar) ────────────────────────
require('nvim-tree').setup({
  hijack_cursor = true,
  update_focused_file = { enable = true }, -- resalta el archivo actual
  renderer = { group_empty = true },
  view = { width = 30 },
  filters = { dotfiles = false },
})
map('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
map('n', '<leader>E', ':NvimTreeFindFile<CR>', { silent = true })

require('barbar').setup({
  animation = true,
  clickable = true,
  focus_on_close = 'left',
  icons = {
    gitsigns = { added = { enabled = true }, changed = { enabled = true }, deleted = { enabled = true } },
    diagnostics = { [vim.diagnostic.severity.ERROR] = { enabled = true } },
  },
  maximum_length = 30,
  sidebar_filetypes = { NvimTree = true }, -- la pestaña no se corre bajo el arbol
})
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
map('n', '<A-.>', '<Cmd>BufferNext<CR>')
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
map('n', '<A-p>', '<Cmd>BufferPin<CR>')
map('n', '<leader>bb', '<Cmd>BufferPick<CR>')
map('n', '<leader>bo', '<Cmd>BufferCloseAllButCurrentOrPinned<CR>')
for i = 1, 9 do map('n', '<A-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>') end

-- ── gitsigns ─────────────────────────────────────────────────────────────
require('gitsigns').setup({
  current_line_blame = true,
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local function m(mode, lhs, rhs) map(mode, lhs, rhs, { buffer = bufnr }) end
    m('n', ']c', function() if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gs.nav_hunk('next') end end)
    m('n', '[c', function() if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gs.nav_hunk('prev') end end)
    m({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    m({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    m('n', '<leader>hS', gs.stage_buffer)
    m('n', '<leader>hR', gs.reset_buffer)
    m('n', '<leader>hp', gs.preview_hunk)
    m('n', '<leader>hb', function() gs.blame_line({ full = true }) end)
    m('n', '<leader>tb', gs.toggle_current_line_blame)
    m('n', '<leader>hd', gs.diffthis)
    m('n', '<leader>hD', function() gs.diffthis('~') end)
    m('n', '<leader>hm', function() gs.diffthis('main') end)
    m('n', '<leader>hM', function() gs.diffthis(vim.fn.input('Branch: ')) end)
    m('n', '<leader>td', gs.toggle_deleted)
    m({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
})

-- ── fzf-lua (requiere fzf; ripgrep y fd recomendados) ────────────────────
local fzf = require('fzf-lua')
fzf.register_ui_select(function(_, items)
  local h = math.min(math.max((#items + 4) / vim.o.lines, 0.15), 0.70)
  return { winopts = { height = h, width = 0.60, row = 0.40 } }
end)
local function in_dir(fn, dir)
  return function() fzf[fn]({ cwd = dir or vim.fn.input('Dir: ', '', 'dir') }) end
end
map('n', '<leader>fd', in_dir('files'))
map('n', '<leader>fD', in_dir('live_grep'))
map('n', '<leader>ft', in_dir('files', './tests'))
map('n', '<leader>fT', in_dir('live_grep', './tests'))
map('n', '<leader>fc', in_dir('files', './node_modules/@sap/cds'))
map('n', '<leader>fC', in_dir('live_grep', './node_modules/@sap/cds'))
map('n', '<leader>ff', ':FzfLua live_grep<CR>')
map('n', '<leader>fr', ':FzfLua resume<CR>')
map('n', '<leader>fz', ':FzfLua zoxide<CR>')
map('n', '<leader>fG', ':FzfLua git_branches<CR>')
map('n', '<leader>fg', ':FzfLua git_status<CR>')
map('n', '<leader>fs', ':FzfLua lsp_document_symbols<CR>')
map('n', '<leader>fS', ':FzfLua lsp_workspace_symbols<CR>')
map('n', '<leader>fx', ':FzfLua diagnostics_workspace<CR>')
map('n', '<c-\\>', ':FzfLua buffers<CR>')
map('n', '<leader><space>', ':FzfLua files<CR>')
-- busqueda estructural con ast-grep (opcional)
map('n', '<leader>fa', function()
  local query = vim.fn.input('Query: ')
  if query == '' then return end
  fzf.fzf_exec('ast-grep run --context 0 --heading never --pattern ' .. vim.fn.shellescape(query), {
    actions = { default = fzf.actions.file_edit },
    previewer = 'builtin',
  })
end)

-- ── Terminal ─────────────────────────────────────────────────────────────
g.floaterm_width = 0.95
g.floaterm_height = 0.95
map('n', '<leader>g', ':FloatermNew lazygit<CR>')

local term_buf_per_cwd = {}
local term_count = 0

local function spawn_terminal()
  local cwd = vim.fn.getcwd()
  for other, buf in pairs(term_buf_per_cwd) do -- una terminal por cwd
    if other ~= cwd then
      if vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
      term_buf_per_cwd[other] = nil
    end
  end
  vim.cmd('vs | terminal')
  term_count = term_count + 1
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, 'Terminal ' .. term_count .. ' (' .. cwd .. ')')
  term_buf_per_cwd[cwd] = buf
  vim.cmd.startinsert()
end

local function toggle_terminal()
  local buf = term_buf_per_cwd[vim.fn.getcwd()]
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then return spawn_terminal() end
  if vim.api.nvim_get_current_buf() == buf then return vim.cmd('q') end
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_buf(win) == buf then
      vim.api.nvim_set_current_win(win)
      return vim.cmd.startinsert()
    end
  end
  vim.cmd('vert sb' .. buf)
  vim.cmd.startinsert()
end

map('n', '<c-y>', toggle_terminal)
map('i', '<c-y>', toggle_terminal)
map('t', '<c-y>', toggle_terminal)

map('n', '<leader>x', function()
  local line = vim.api.nvim_get_current_line()
  local buf = term_buf_per_cwd[vim.fn.getcwd()]
  if not (buf and vim.api.nvim_buf_is_valid(buf)) then
    spawn_terminal()
    buf = vim.api.nvim_get_current_buf()
    vim.cmd.stopinsert()
  end
  vim.api.nvim_chan_send(vim.bo[buf].channel, line .. '\r')
end)

-- ── treesitter-unit ──────────────────────────────────────────────────────
map({ 'x', 'o' }, 'iu', function() require('treesitter-unit').select() end)
map('o', 'u', function() require('treesitter-unit').select(true) end)
map('n', 'vu', function() require('treesitter-unit').select(true) end)

-- ── Desarrollo: LSP, treesitter, formato ─────────────────────────────────
require('dev')

-- UI experimental de 0.12; si cambia la API no rompe el arranque
pcall(function() require('vim._core.ui2').enable({}) end)
