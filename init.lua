-- vim.cmd("set shell=/bin/zsh")
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

g.mapleader = " "

-- Hook: run TSUpdate whenever nvim-treesitter is installed or updated
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })


vim.pack.add({
  'https://github.com/folke/tokyonight.nvim',
--  'https://github.com/carlos-algms/agentic.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/github/copilot.vim',
--  'https://github.com/nvim-lua/popup.nvim',
-- 'https://github.com/sindrets/diffview.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
--  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/voldikss/vim-floaterm',
  'https://github.com/nvim-neotest/nvim-nio',
--  'https://github.com/rcarriga/nvim-dap-ui',
--  'https://github.com/microsoft/vscode-node-debug2',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/echasnovski/mini.files',
})



















require('mini.files').setup({mappings = {go_in_plus = 'l'}})
--require('cov').setup()

-- vim.g.codeium_enabled = false
-- vim.g.codeium_disable_bindings = true
-- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
-- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
-- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
-- vim.keymap.set('i', '<c-cr>', function() return vim.fn['codeium#Accept']() end, { expr = true })
-- require('packer').startup(function(use)end)
--     use 'wbthomason/packer.nvim'
--     use 'tpope/vim-commentary'
--     use 'mhartington/formatter.nvim'
--     -- use 'neovim/nvim-lspconfig'
--     use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
--     use 'nvim-lua/plenary.nvim'
--     use 'nvim-lua/popup.nvim'
--     use 'lewis6991/gitsigns.nvim'
--     use 'theHamsta/nvim-dap-virtual-text'
--     use 'ryanoasis/vim-devicons'
--     use 'David-Kunz/jester'
--     use 'David-Kunz/markid'
--     use 'David-Kunz/spotlight'
--     use {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'}}
--     use 'David-Kunz/treesitter-unit'
--     -- use 'David-Kunz/ts-quickfix'
--     use 'hrsh7th/cmp-nvim-lsp'
--     use 'hrsh7th/cmp-buffer'
--     use 'hrsh7th/nvim-cmp'
--     use 'David-Kunz/cmp-npm'
--     use 'marko-cerovac/material.nvim'
--     use 'mfussenegger/nvim-dap'
--     use 'L3MON4D3/LuaSnip'
--     use 'saadparwaiz1/cmp_luasnip'
--     use 'voldikss/vim-floaterm'
--     use 'rcarriga/nvim-dap-ui'
--     -- use 'ldelossa/litee.nvim'
--     -- use 'ldelossa/gh.nvim'
--     use 'folke/tokyonight.nvim'
--     use 'nvim-treesitter/playground'
--     use 'norcalli/nvim-colorizer.lua'
--     use 'mxsdev/nvim-dap-vscode-js'
--     use {
--         "microsoft/vscode-js-debug",
--         opt = true,
--         run = "npm install --legacy-peer-deps && npm run compile"
--     }
--     use {
--         "microsoft/vscode-node-debug2",
--         opt = true,
--         run = "npm install && NODE_OPTIONS=--no-experimental-fetch npm run build"
--     }
--     -- use {
--     --     'ggandor/leap.nvim',
--     --     config = function() require('leap').add_default_mappings() end
--     -- }
--     use {
--         "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
--         "neovim/nvim-lspconfig"
--     }
-- end)

-- default options
opt.completeopt = {
  'menu',
  'menuone',
  'noselect',
  'popup',
  'nearest'
}
opt.laststatus = 3
opt.mouse = 'a'
opt.splitright = true
opt.splitbelow = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
vim.g.markdown_recommended_style = 0
-- opt.so = 10
-- opt.relativenumber = true
vim.cmd('set nonumber')
vim.cmd('set norelativenumber')
-- set diffopt+=vertical " starts diff mode in vertical split
opt.cmdheight = 1
opt.ls = 0
-- set shortmess+=c " don't need to press enter so often
opt.signcolumn = 'yes'
opt.updatetime = 520
opt.undofile = true
cmd('filetype plugin on')
opt.backup = false
g.netrw_banner = false
g.netrw_liststyle = 3
g.markdown_fenced_languages = {'javascript', 'js=javascript', 'json=javascript'}

-- opt.path:append({ "**" })
vim.cmd([[set path=$PWD/**]])
vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>')

vim.opt.statusline = "%F Line:%l"

-- require('mini.diff').setup()
-- require('mini.git').setup()

vim.keymap.set('n', '<leader>hd',
               function() require('mini.diff').toggle_overlay() end)

-- lewis6991/gitsigns.nvim
function diffThisBranch()
    local branch = vim.fn.input("Branch: ", "")
    require"gitsigns".diffthis(branch)
end

require('gitsigns').setup({
    current_line_blame = true,
    on_attach = function(bufnr)
        -- Navigation
        -- vim.keymap.set('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
        -- vim.keymap.set('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
        vim.keymap.set('n', ']c', ':Gitsigns next_hunk<CR>')
        vim.keymap.set('n', '[c', ':Gitsigns prev_hunk<CR>')

        -- Actions
        vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
        vim.keymap.set('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
        vim.keymap.set('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
        vim.keymap.set('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
        vim.keymap.set('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
        vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
        vim.keymap.set('n', '<leader>hb', function()
            require"gitsigns".blame_line {full = true}
        end)
        vim.keymap.set('n', '<leader>tb',
                       '<cmd>Gitsigns toggle_current_line_blame<CR>')
        vim.keymap.set('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
        vim.keymap.set('n', '<leader>hD',
                       function() require"gitsigns".diffthis("~") end)
        vim.keymap.set('n', '<leader>hm',
                       function() require"gitsigns".diffthis("main") end)
        vim.keymap.set('n', '<leader>hM', diffThisBranch)
        vim.keymap.set('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

        -- Text object
        vim.keymap.set('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        vim.keymap.set('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})

-- sbdchd/neoformat
-- vim.keymap.set('n', '<leader>F', ':!prettier % --config ~/SAPDevelop/dev/cds/.prettierrc.js --write<CR>')
vim.keymap.set('n', '<leader>F', ':!biome format % --write<CR>')
vim.keymap.set('n', '<leader>fl', function() vim.lsp.buf.format() end)
-- require('formatter').setup({
--     logging = false,
--     filetype = {
--         javascript = {
--             -- prettierd
--             function()
--                 return {
--                     exe = "prettierd",
--                     args = {vim.api.nvim_buf_get_name(0)},
--                     stdin = true
--                 }
--             end
--         },
--         typescript = {
--             -- prettierd
--             function()
--                 return {
--                     exe = "prettierd",
--                     args = {vim.api.nvim_buf_get_name(0)},
--                     stdin = true
--                 }
--             end
--         },
--         json = {
--             -- prettierd
--             function()
--                 return {
--                     exe = "prettierd",
--                     args = {vim.api.nvim_buf_get_name(0)},
--                     stdin = true
--                 }
--             end
--         },
--         rust = {function() return {exe = "rustfmt", stdin = true} end},
--         lua = {function() return {exe = "lua-format", stdin = true} end},
--         sql = {
--             -- prettierd
--             function()
--                 return {
--                     exe = "sql-formatter",
--                     args = {vim.api.nvim_buf_get_name(0)},
--                     stdin = true
--                 }
--             end
--         }
--     }
-- })

_G.fzflua_find_files_in_path = function(path)
    local _path = path or vim.fn.input("Dir: ", "", "dir")
    require('fzf-lua').files({ cwd = _path })
end
_G.fzflua_live_grep_in_path = function(path)
    local _path = path or vim.fn.input("Dir: ", "", "dir")
    require('fzf-lua').live_grep({ cwd = _path })
end

require("fzf-lua").register_ui_select(function(_, items)
  local min_h, max_h = 0.15, 0.70
  local h = (#items + 4) / vim.o.lines
  if h < min_h then
    h = min_h
  elseif h > max_h then
    h = max_h
  end
  return { winopts = { height = h, width = 0.60, row = 0.40 } }
end)

vim.keymap.set('n', '<leader>fD', function() fzflua_live_grep_in_path() end)
vim.keymap.set('n', '<leader>fd', function() fzflua_find_files_in_path() end)
vim.keymap.set('n', '<leader>ft',
               function() fzflua_find_files_in_path("./tests") end)
vim.keymap.set('n', '<leader>fc', function()
    fzflua_find_files_in_path("./node_modules/@sap/cds")
end)
vim.keymap.set('n', '<leader>fC', function()
    fzflua_live_grep_in_path("./node_modules/@sap/cds")
end)
vim.keymap.set('n', '<leader>fT',
               function() fzflua_live_grep_in_path("./tests") end)
vim.keymap.set('n', '<leader>ff', ':FzfLua live_grep<CR>')
vim.keymap.set('n', '<leader>fr', ':FzfLua resume<CR>')
vim.keymap.set('n', '<leader>fz', ':FzfLua zoxide<CR>')
vim.keymap.set('n', '<leader>fG', ':FzfLua git_branches<CR>')
vim.keymap.set('n', '<leader>fg', ':FzfLua git_status<CR>')
vim.keymap.set('n', '<c-\\>', ':FzfLua buffers<CR>')
vim.keymap.set('n', '<leader>fs', ':FzfLua lsp_document_symbols<CR>')
vim.keymap.set('n', '<leader><space>', ':FzfLua files<CR>')

vim.keymap.set('n', '<leader>fy', ':let @"=expand("%") . ":" . line(".") . ":" . col(".")<CR>')
-- David-Kunz/cmp-npm
-- require('cmp-npm').setup({only_latest_version = true})

-- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)  USE DEFAULT INSTEAD ctrl-]
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end)
vim.keymap.set('n', 'gD', function() vim.lsp.buf.implementation() end)
vim.keymap.set('n', '<c-k>', function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end)
-- vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end)
-- vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end)
-- vim.keymap.set('n', 'ge', function() vim.diagnostic.goto_next() end)
-- vim.keymap.set('n', 'gE', function() vim.diagnostic.goto_prev() end)
-- vim.keymap.set('n', 'gA', ':FzfLua lsp_code_actions<CR>')

-- -- CDS
-- cmd([[
-- augroup MyCDSCode
--      autocmd!
--      autocmd BufReadPre,FileReadPre *.cds set ft=cds
-- augroup END
-- ]])
--
-- DISABLE FOR NOW
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
if not configs.sapcds_lsp then
    configs.sapcds_lsp = {
        default_config = {
            cmd = {
                vim.fn.expand(
                    "/Users/d065023/apps/cds-lsp/node_modules/.bin/cds-lsp"),
                '--stdio'
            },
            filetypes = {'cds'},
            root_dir = lspconfig.util.root_pattern('.git', 'package.json'),
            settings = {}
        }
    }
end
if lspconfig.sapcds_lsp.setup then
    lspconfig.sapcds_lsp.setup {
        -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
end

vim.keymap.set('n', '<leader><esc><esc>', ':tabclose<CR>')

-- vim.g.material_style = "darker"
-- vim.cmd 'colorscheme material'
vim.opt.fillchars = {
    horiz = '█',
    horizup = '█',
    horizdown = '█',
    vert = '█',
    vertleft = '█',
    vertright = '█',
    verthoriz = '█'
}

vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95
vim.keymap.set('n', '<leader>g', ':FloatermNew lazygit<CR>')
-- vim.keymap.set('n', '<leader>o', ':FloatermNew opencode<CR>')

-- cmd('set foldmethod=indent')
-- cmd('set foldmethod=expr')
-- cmd('set foldexpr=nvim_treesitter#foldexpr()')

-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = ""
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99
-- vim.opt.foldlevelstart = 0

vim.o.foldenable = true
vim.o.foldlevel = 99
--vim.o.foldmethod = "indent"
vim.o.foldmethod = "expr"
 vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.foldopen = "search"
vim.opt.fillchars:append({fold = " "})


vim.keymap.set('n', '<leader>n', ':tabe ~/tmp/notes.md<CR>')

-- nvim-treesitter main branch: extend the parsers table directly
require('nvim-treesitter.parsers').cds = {
    install_info = {
        url = "/Users/d065023/apps/tree-sitter-cds",
        files = {"src/parser.c", "src/scanner.c"}
    },
}
vim.treesitter.language.register('cds', {'cds', 'cdl', 'hdbcds'})


-- require('markid')
-- nvim-treesitter main branch: highlight is enabled by default via vim.treesitter
-- require'nvim-treesitter.configs'.setup is removed in the main branch

-- mxsdev/nvim-dap-vscode-js
-- require('dap-vscode-js').setup({
--     debugger_path = os.getenv('HOME') ..
--         '/.local/share/nvim/lazy/vscode-js-debug',
--     adapters = {
--         'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal',
--         'pwa-extensionHost'
--     }
-- })
-- require("dap-vscode-js").setup({
--     adapters = {
--         'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal',
--         'pwa-extensionHost'
--     }
-- })

-- valid
-- mfussenegger/nvim-dap
-- local dap = require('dap')
-- dap.adapters.node2 = {
--     type = 'executable',
--     command = 'node',
--     args = {
--         os.getenv('HOME') ..
--             '/.local/share/nvim/site/pack/core/opt/vscode-node-debug2/out/src/nodeDebug.js'
--     }
-- }
--
-- dap.adapters["pwa-node"] = {
--   type = "server",
--   host = "localhost",
--   port = "${port}", --let both ports be the same for now...
--   executable = {
--     command = "node",
--     args = { vim.fn.stdpath('data') .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
--   }
-- }
-- validend

-- for _, language in ipairs({ "typescript", "javascript" }) do
--   dap.configurations[language] = {
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Current File (pwa-node)',
--       cwd = "${workspaceFolder}", -- vim.fn.getcwd(),
--       args = { '${file}' },
--       sourceMaps = true,
--       protocol = 'inspector',
--     },
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Current File (Typescript)',
--       cwd = "${workspaceFolder}",
--       runtimeArgs = { '--loader=ts-node/esm' },
--       program = "${file}",
--       runtimeExecutable = 'node',
--       -- args = { '${file}' },
--       sourceMaps = true,
--       protocol = 'inspector',
--       outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
--       skipFiles = { '<node_internals>/**', 'node_modules/**' },
--       resolveSourceMapLocations = {
--         "${workspaceFolder}/**",
--         "!**/node_modules/**",
--       },
--     },
--   }
-- end

-- doesn't seem to work:
-- dap.adapters.node2 = {
--     type = 'server',
--     host = 'localhost',
--     port = '${port}',
--     executable = {
--       command = 'node',
--       args = {
--         '/Users/d065023/apps/js-debug/src/dapDebugServer.js',
--         '${port}',
--       }
--     }
-- }

-- args = {
-- '/Users/d065023/apps/js-debug/src/dapDebugServer.js',
--  os.getenv('HOME') ..
--      '/.local/share/nvim/lazy/vscode-node-debug2/out/src/nodeDebug.js'
-- require('dap').set_log_level('INFO')
-- valid
-- dap.defaults.fallback.terminal_win_cmd = '20split new'
-- vim.fn.sign_define('DapBreakpoint',
--                    {text = '🟥', texthl = '', linehl = '', numhl = ''})
-- vim.fn.sign_define('DapBreakpointRejected',
--                    {text = '🟦', texthl = '', linehl = '', numhl = ''})
-- vim.fn.sign_define('DapStopped',
--                    {text = '⭐️', texthl = '', linehl = '', numhl = ''})
--
-- vim.keymap.set('n', '<leader>dh',
--                function() require"dap".toggle_breakpoint() end)
-- vim.keymap.set('n', '<leader>dH',
--                ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- vim.keymap.set({'n', 't'}, '<A-k>', function() require"dap".step_out() end)
-- vim.keymap.set({'n', 't'}, "<A-l>", function() require"dap".step_into() end)
-- vim.keymap.set({'n', 't'}, '<A-j>', function() require"dap".step_over() end)
-- vim.keymap.set({'n', 't'}, '<A-h>', function() require"dap".continue() end)
-- vim.keymap.set('n', '<leader>dn', function() require"dap".run_to_cursor() end)
-- vim.keymap.set('n', '<leader>dc', function() require"dap".terminate() end)
-- vim.keymap.set('n', '<leader>dR',
--                function() require"dap".clear_breakpoints() end)
-- vim.keymap.set('n', '<leader>de',
--                function() require"dap".set_exception_breakpoints({"all"}) end)
-- vim.keymap.set('n', '<leader>da', function() require"debugHelper".attach() end)
-- vim.keymap.set('n', '<leader>dA',
--                function() require"debugHelper".attachToRemote() end)
-- vim.keymap
--     .set('n', '<leader>di', function() require"dap.ui.widgets".hover() end)
-- vim.keymap.set('n', '<leader>d?', function()
--     local widgets = require "dap.ui.widgets";
--     widgets.centered_float(widgets.scopes)
-- end)
-- vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
-- vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
-- vim.keymap.set('n', '<leader>dr',
--                ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
-- vim.keymap.set('n', '<leader>du', ':lua require"dapui".toggle()<CR>')
--
-- vim.keymap.set('n', '<leader>ds', ':FzfLua dap_frames<CR>')
-- vim.keymap.set('n', '<leader>db', ':FzfLua dap_breakpoints<CR>')
-- validend

-- require('nvim-dap-virtual-text').setup()

-- lua language server
-- local system_name
-- if vim.fn.has("mac") == 1 then
--   system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--   system_name = "Linux"
-- elseif vim.fn.has('win32') == 1 then
--   system_name = "Windows"
-- else
--   print("Unsupported system for sumneko")
-- end

-- -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
-- local sumneko_root_path = os.getenv('HOME') ..'/apps/lua-language-server'
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- require'lspconfig'.sumneko_lua.setup {
--   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {'vim'},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }

-- vim.keymap.set('n', '[b', ':bnext<CR>')
-- vim.keymap.set('n', ']b', ':bprev<CR>')

-- David-Kunz/treesitter-unit (local dev, opt-loaded)
vim.cmd.packadd('treesitter-unit')
vim.keymap.set('x', 'iu', function() require'treesitter-unit'.select() end)
vim.keymap.set('o', 'iu', function() require'treesitter-unit'.select() end)
vim.keymap.set('o', 'u',  function() require'treesitter-unit'.select(true) end)
vim.keymap.set('n', 'vu', function() require'treesitter-unit'.select(true) end)

-- custom folder icon
-- require'nvim-web-devicons'.setup({
--     override = {
--         lir_folder_icon = {
--             icon = "",
--             color = "#7ebae4",
--             name = "LirFolderNode"
--         }
--     }
-- })
-- use visual mode
-- function _G.LirSettings()
--     vim.api.nvim_buf_set_keymap(0, 'x', 'J',
--                                 ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
--                                 {noremap = true, silent = true})
--
--     -- echo cwd
--     vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
-- end
-- vim.cmd [[augroup lir-settings]]
-- vim.cmd [[  autocmd!]]
-- vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
-- vim.cmd [[augroup END]]

-- global mark I for last edit
-- vim.cmd [[autocmd InsertLeave * execute 'normal! mI']]

-- highlight on yank
vim.cmd(
    [[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}]])

-- kyazdani42/nvim-tree.lua
-- require('nvim-tree').setup({
--     hijack_cursor = true,
--     update_focused_file = {enable = true},
--     filters = {dotfiles = true},
--     view = {width = 50}
-- })
-- vim.keymap.set('n', '\\', ':NvimTreeToggle<CR>', {silent = true})
-- vim.keymap.set('n', '\\',
--                ':lua if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end<CR>',
--                {silent = true})

function MiniFilesSmartOpen()
  if not MiniFiles.close() then 
    local buf_name = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
    MiniFiles.open(path)
  end
end
vim.keymap.set('n', '\\', MiniFilesSmartOpen, {silent = true})

vim.keymap.set('n', 'gq', ':bd!<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.cmd('iabbrev :tup: 👍')
vim.cmd('iabbrev :tdo: 👎')
vim.cmd('iabbrev :smi: 😊')
vim.cmd('iabbrev :sad: 😔')
vim.cmd('iabbrev darkred #8b0000')
vim.cmd('iabbrev darkgreen #006400')
vim.cmd('iabbrev :demo: 💻 Demo')

vim.cmd('iabbrev maxdepth require(\'util\').inspect.defaultOptions.depth = 9999')

-- global table to track terminals per cwd
_G.term_buf_per_cwd = _G.term_buf_per_cwd or {}
_G.term_buf_max_nmb = _G.term_buf_max_nmb or 0

local function spawn_terminal()
    local cur_tab = vim.api.nvim_get_current_tabpage()
    local cwd = vim.fn.getcwd()

    -- delete all other terminals (different cwd)
    for other_cwd, buf in pairs(_G.term_buf_per_cwd) do
        if other_cwd ~= cwd and vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
            _G.term_buf_per_cwd[other_cwd] = nil
        end
    end

    -- spawn new terminal for current cwd
    vim.cmd('vs | terminal')
    local cur_buf = vim.api.nvim_get_current_buf()
    _G.term_buf_max_nmb = _G.term_buf_max_nmb + 1
    vim.api.nvim_buf_set_name(cur_buf, "Terminal " .. _G.term_buf_max_nmb .. " (" .. cwd .. ")")
    _G.term_buf_per_cwd[cwd] = cur_buf

    vim.cmd(':startinsert')
end

function Toggle_terminal()
    local cur_tab = vim.api.nvim_get_current_tabpage()
    local cwd = vim.fn.getcwd()
    local term_buf = _G.term_buf_per_cwd[cwd]

    if term_buf ~= nil and vim.api.nvim_buf_is_valid(term_buf) then
        local cur_buf = vim.api.nvim_get_current_buf()
        if cur_buf == term_buf then
            vim.cmd('q')
        else
            local win_list = vim.api.nvim_tabpage_list_wins(cur_tab)
            for _, win in ipairs(win_list) do
                local win_buf = vim.api.nvim_win_get_buf(win)
                if win_buf == term_buf then
                    vim.api.nvim_set_current_win(win)
                    vim.cmd(':startinsert')
                    return
                end
            end
            vim.cmd('vert sb' .. term_buf)
            vim.cmd(':startinsert')
        end
    else
        spawn_terminal()
    end
end


vim.keymap.set('n', '<c-y>', Toggle_terminal)
vim.keymap.set('i', '<c-y>', '<ESC>:lua Toggle_terminal()<CR>')
vim.keymap.set('t', '<c-y>', '<c-\\><c-n>:lua Toggle_terminal()<CR>')

cmd([[
if has('nvim')
   au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
endif]])

Send_line_to_terminal = function()
    local curr_line = vim.api.nvim_get_current_line()
    local cur_tab = vim.api.nvim_get_current_tabpage()
    local term_buf = term_buf_of_tab[cur_tab]
    if term_buf == nil then
        spawn_terminal()
        term_buf = term_buf_of_tab[cur_tab]
    end
    for _, chan in pairs(vim.api.nvim_list_chans()) do
        if chan.buffer == term_buf then chan_id = chan.id end
    end
    vim.api.nvim_chan_send(chan_id, curr_line .. '\n')
end

vim.keymap.set('n', '<leader>x', ':lua Send_line_to_terminal()<CR>')

-- require"nvim-treesitter.configs".setup {playground = {enable = true}} -- removed: configs.setup API gone in main branch

vim.keymap.set('n', '<c-o>', '<c-o>zz')
vim.keymap.set('n', '<c-i>', '<c-i>zz')

-- 'L3MON4D3/LuaSnip'
-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and
--                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
--                                                                           col)
--                    :match("%s") == nil
-- end
--
-- local ls = require("luasnip")

-- ls.add_snippets("cds", {
--     ls.snippet("field", ls.text_node("YY1_CrByIncidentMgmt_SDH")),
--     ls.snippet("topic", ls.text_node(
--                    "sap/cap/incidents/ce/sap/s4/beh/salesorder/v1/SalesOrder/Changed/v1"))
-- })
-- ls.add_snippets("json", {
--     ls.snippet("path", ls.text_node('/sap/opu/odata/sap/API_SALES_ORDER_SRV'))
-- })
-- ls.add_snippets("javascript", {
--     ls.snippet("block", ls.text_node("DeliveryBlockReason")),
--     ls.snippet("payload", ls.text_node({
--         " {", "    SalesOrderType: 'OR',", "    SalesOrganization: '1710',",
--         "   DistributionChannel: '10',", "   OrganizationDivision: '00',",
--         "   SoldToParty: '17100002',",
--         "   PurchaseOrderByCustomer: 'Incident: ' + title,",
--         "   YY1_CrByIncidentMgmt_SDH: true,", "   to_Item: orders.map(o => ({",
--         "     Material: o.product,", "     RequestedQuantity: o.quantity,",
--         "     RequestedQuantityUnit: o.unitOfMeasure", "   }))", " }"
--     }))
-- })

-- local cmp = require("cmp")

-- cmp.setup({
--     snippet = {expand = function(args) ls.lsp_expand(args.body) end},
--     mapping = {
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<CR>'] = cmp.mapping.confirm({select = false}),
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-n>'] = cmp.mapping.select_next_item({
--             behavior = cmp.SelectBehavior.Insert
--         }),
--         ['<C-p>'] = cmp.mapping.select_prev_item({
--             behavior = cmp.SelectBehavior.Insert
--         }),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if ls.expand_or_jumpable() then
--                 ls.expand_or_jump()
--             else
--                 fallback()
--             end
--         end, {"i", "s"}),

--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--             if ls.jumpable(-1) then
--                 ls.jump(-1)
--             else
--                 fallback()
--             end
--         end, {"i", "s"})
--     },
--     sources = {
--         {name = 'npm'}, {name = 'luasnip'}, {name = 'nvim_lsp'},
--         {name = 'buffer', keyword_length = 5}
--     }
--     -- formatting = {
--     --   format = lspkind.cmp_format({with_text = false, maxwidth = 50})
--     -- }
-- })

-- local t = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
--
-- _G.expand = function()
--     -- print("hurray!!")
--     if ls.expand_or_jumpable() then return t("<Plug>luasnip-expand-or-jump") end
--     return ''
-- end
--
-- _G.expand_back = function()
--     -- print("hurray!!")
--     if ls.jumpable(-1) then return t("<Plug>luasnip-jump-prev") end
--     return ''
-- end
--
-- vim.api.nvim_set_keymap('i', '<c-j>', 'v:lua.expand()', {expr = true})
-- vim.api.nvim_set_keymap('i', '<c-k>', 'v:lua.expand_back()', {expr = true})
-- vim.api.nvim_set_keymap('s', '<c-j>', 'v:lua.expand()', {expr = true})
-- vim.api.nvim_set_keymap('s', '<c-k>', 'v:lua.expand_back()', {expr = true})
--
-- vim.keymap.set('n', '<leader>ls',
--                '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>')
--

-- ldelossa/gh.nvim
-- require('litee.lib').setup()
-- require('litee.gh').setup({
--   prefer_https_remote = true
-- })

-- require("github-theme").setup({
--   theme_style = "dark",
-- })

-- vim.keymap.set('i', '<c-o>', '<esc><s-o>')
-- use option shift o instead
vim.keymap.set('n', '<leader>p', ':lua vim.pack.update()<CR>')
-- vim.api.nvim_create_autocmd('BufHidden',  {
--     pattern  = '[dap-terminal]*',
--     callback = function(arg)
--       vim.schedule(function() vim.api.nvim_buf_delete(arg.buf, { force = true }) end)
--     end
-- })

--vim.keymap.set('n', '<leader>?',
--               'orequire("/usr/local/lib/node_modules/derive-type/")(...arguments)<esc>')

-- valid
-- local dap = require("dap")
-- local dapui = require("dapui")
-- dapui.setup()
-- vim.keymap.set('n', '<leader>do', function() require("dapui").open() end)
-- vim.keymap.set('n', '<leader>dC', function() require("dapui").close() end)
-- -- dap.listeners.after.event_initialized["dapui_config"] = function()
-- --   dapui.open()
-- -- end
-- dap.listeners.before.event_terminated["dapui_config"] =
--     function() dapui.close() end
-- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
-- validend

require('mason').setup()
require("mason-lspconfig").setup()
-- require("mason-lspconfig").setup_handlers {
--     function(server_name) -- default handler (optional)
--         require("lspconfig")[server_name].setup {}
--     end,
--     ["lua_ls"] = function()
--         require("lspconfig").lua_ls.setup({
--             settings = {Lua = {diagnostics = {globals = {'vim'}}}}
--         })
--     end,
--     ["vtsls"] = function()
--         require("lspconfig").vtsls.setup({
--             settings = {
--                 typescript = {
--                     inlayHints = {
--                         includeInlayEnumMemberValueHints = true,
--                         includeInlayFunctionLikeReturnTypeHints = true,
--                         includeInlayFunctionParameterTypeHints = true,
--                         includeInlayParameterNameHints = 'all',
--                         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--                         includeInlayPropertyDeclarationTypeHints = true,
--                         includeInlayVariableTypeHints = true
--                     }
--                 },
--                 javascript = {
--                     inlayHints = {
--                         includeInlayEnumMemberValueHints = true,
--                         includeInlayFunctionLikeReturnTypeHints = true,
--                         includeInlayFunctionParameterTypeHints = true,
--                         includeInlayParameterNameHints = 'all',
--                         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--                         includeInlayPropertyDeclarationTypeHints = true,
--                         includeInlayVariableTypeHints = true
--                     }
--                 }
--             }
--         })
--     end
-- }
-- typescript.inlayHints.parameterNames.enabled


-- vim.api.nvim_create_autocmd("CursorHold", {callback = vim.lsp.buf.document_highlight})
-- vim.api.nvim_create_autocmd("CursorMoved", {callback = vim.lsp.buf.clear_references})

-- vim.api.nvim_create_autocmd("CursorMoved", {callback = require'spotlight'.run})
--
--

-- require('mini.base16').setup({
--   palette = {
--     base00 = '#dee3ea', -- background
--     base01 = '#dee3ea', -- borders,
--     base01 = '#dee3ea', -- borders,
--     base02 = '#ffffff', -- borders2 and visual
--     base03 = '#4db1ff',
--     base04 = '#0070F2', -- comments
--     base05 = '#5b738b', -- text output
--     base06 = '#0070f2', -- unknown
--     base07 = '#0070f2', -- unknown
--     base08 = '#0070F2', -- fields
--     base09 = '#0070f2', -- unknown
--     base0A = '#4db1ff', -- unknown
--     base0B = '#188918', -- strings
--     base0C = '#4db1ff', -- function calls
--     base0D = '#0070f2', -- function calls 2
--     base0E = '#7858FF', -- keywords
--     base0F = '#d30f15', -- brackets
--   }
-- })
--
-- -- palette = {
-- --   base00 = '#ffffff', -- background
-- --   base01 = '#ffffff', -- borders,
-- --   base01 = '#ffffff', -- borders,
-- --   base02 = '#ffffff', -- borders2 and visual
-- --   base03 = '#4db1ff',
-- --   base04 = '#0070F2', -- comments
-- --   base05 = '#0070F2', -- text output
-- --   base06 = '#d30f15', -- unknown
-- --   base07 = '#d30f15', -- unknown
-- --   base08 = '#0070F2', -- fields
-- --   base09 = '#d30f15', -- unknown
-- --   base0A = '#4db1ff', -- unknown
-- --   base0B = '#188918', -- strings
-- --   base0C = '#4db1ff', -- function calls
-- --   base0D = '#d30f15', -- function calls 2
-- --   base0E = '#7858FF', -- keywords
-- --   base0F = '#d30f15', -- brackets
-- -- }
--
-- vim.o.ls = 0
-- vim.o.ch = 0
--
--
-- 
--
--
--
-- require("diffview").setup({use_icons = false})

-- vim.keymap.set('n', '<leader>h', function()
--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
-- end)

-- vim.keymap.set('n', '<leader>D', ':DiffviewOpen main<CR>')


vim.cmd('abb genuuid1 a11fb6f1-36ab-46ec-b00c-d379031e817a')
vim.cmd('abb genuuid2 b22fb6f1-36ab-46ec-b00c-d379031e817a')
vim.cmd('abb genuuid3 c33fb6f1-36ab-46ec-b00c-d379031e817a')
vim.cmd('abb genuuid4 d44fb6f1-36ab-46ec-b00c-d379031e817a')

vim.cmd('abb emri ✅')
vim.cmd('abb emwr ❌')

vim.cmd('hi DiffAdd      gui=none    guifg=NONE')
vim.cmd('hi DiffChange   gui=none    guifg=NONE ')
vim.cmd('hi DiffText     gui=none    guifg=NONE ')

vim.keymap.set('i', '<c-r>', '<c-r><c-o>')
-- vim.diagnostic.config({ virtual_lines = true })
















vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})


vim.diagnostic.config({ virtual_text = { current_line = true } })
-- vim.cmd('Copilot disable')













vim.keymap.set('n', '<leader>fa', function ()
  local query = vim.fn.input("Query: ", "")
  require("fzf-lua").fzf_exec(
      "sg --context 0 --heading never --pattern '" .. query .. "' 2>/dev/null",
      {
          exec_empty_query = false,
          actions = {
              ["default"] = require "fzf-lua".actions.file_edit,
          },
          previewer = 'builtin'
      }
  )
end)

-- vim.lsp.set_log_level('DEBUG')

-- require("codecompanion").setup({
--   extensions = {
--     mcphub = {
--       callback = "mcphub.extensions.codecompanion",
--       opts = {
--         show_result_in_chat = true,  -- Show mcp tool results in chat
--         make_vars = true,            -- Convert resources to #variables
--         make_slash_commands = true,  -- Add prompts as /slash commands
--       }
--     }
--   }
-- })
--
--



-- vim.keymap.set('n', '<leader>a', ':CopilotChatToggle<CR>')
vim.keymap.set("n", "<leader>yf", function()
  local filename = vim.fn.expand("%") -- just the file name
  vim.fn.setreg("+", filename)          -- put into system clipboard
  print("Yanked file name: " .. filename)
end, { desc = "Yank current file name to clipboard" })

vim.keymap.set("n", "<leader>c", ":CoverageToggle<CR>", { desc = "Toggle coverage" })
vim.cmd [[hi @lsp.type.parameter guibg=#082b2d]]
vim.cmd [[hi @lsp.type.function guibg=#1f2b2d]]
vim.cmd [[hi @lsp.type.method guibg=#1f2b2d]]

-- also set it for methods/functions
vim.cmd [[hi @function guibg=#1f2b2d]]
vim.cmd [[hi @function.builtin guibg=#1f2b2d]]
vim.cmd [[hi @function.call guibg=#1f2b2d]]
vim.cmd [[hi @function.macro guibg=#1f2b2d]]
vim.cmd [[hi @function.method guibg=#1f2b2d]]
vim.cmd [[hi @function.method.call guibg=#1f2b2d]]

--vim.cmd [[hi @lsp.type.variable guibg=#c7c7c7]]
--vim.cmd [[hi @lsp.type.class guibg=blue]]
--vim.cmd [[hi @lsp.type.method guibg=orange]]

-- @lsp.type.class          Identifiers that declare or reference a class type
-- @lsp.type.comment        Tokens that represent a comment
-- @lsp.type.decorator      Identifiers that declare or reference decorators and annotations
-- @lsp.type.enum           Identifiers that declare or reference an enumeration type
-- @lsp.type.enumMember     Identifiers that declare or reference an enumeration property, constant, or member
-- @lsp.type.event          Identifiers that declare an event property
-- @lsp.type.function       Identifiers that declare a function
-- @lsp.type.interface      Identifiers that declare or reference an interface type
-- @lsp.type.keyword        Tokens that represent a language keyword
-- @lsp.type.macro          Identifiers that declare a macro
-- @lsp.type.method         Identifiers that declare a member function or method
-- @lsp.type.modifier       Tokens that represent a modifier
-- @lsp.type.namespace      Identifiers that declare or reference a namespace, module, or package
-- @lsp.type.number         Tokens that represent a number literal
-- @lsp.type.operator       Tokens that represent an operator
-- @lsp.type.parameter      Identifiers that declare or reference a function or method parameters
-- @lsp.type.property       Identifiers that declare or reference a member property, member field, or member variable
-- @lsp.type.regexp         Tokens that represent a regular expression literal
-- @lsp.type.string         Tokens that represent a string literal
-- @lsp.type.struct         Identifiers that declare or reference a struct type
-- @lsp.type.type           Identifiers that declare or reference a type that is not covered above
-- @lsp.type.typeParameter  Identifiers that declare or reference a type parameter
-- @lsp.type.variable       Identifiers that declare or reference a local or global variable
--
-- @lsp.mod.abstract        Types and member functions that are abstract
-- @lsp.mod.async           Functions that are marked async
-- @lsp.mod.declaration     Declarations of symbols
-- @lsp.mod.defaultLibrary  Symbols that are part of the standard library
-- @lsp.mod.definition      Definitions of symbols, for example, in header files
-- @lsp.mod.deprecated      Symbols that should no longer be used
-- @lsp.mod.documentation   Occurrences of symbols in documentation
-- @lsp.mod.modification    Variable references where the variable is assigned to
-- @lsp.mod.readonly        Readonly variables and member fields (constants)
-- @lsp.mod.static          Class members (static members)
--
--

vim.cmd[[colorscheme tokyonight]]

























-- Hook: run build for vscode-node-debug2 on install/update
-- valid
-- vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
--   local name, kind = ev.data.spec.name, ev.data.kind
--   if name == 'vscode-node-debug2' and (kind == 'install' or kind == 'update') then
--     local plug_dir = vim.fn.stdpath('data') .. '/site/pack/core/opt/vscode-node-debug2'
--     vim.fn.jobstart(
--       'npm install && NODE_OPTIONS=--no-experimental-fetch npm run build',
--       { cwd = plug_dir }
--     )
--   end
-- end })
--validend














require("vim._core.ui2").enable({})







