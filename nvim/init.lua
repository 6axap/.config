local data_dir = vim.fn.stdpath('data') .. '/site'
local plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) > 0 then
  vim.fn.system({
    'curl', '-fLo', data_dir .. '/autoload/plug.vim', '--create-dirs', plug_url
  })
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end


-- ============================================
-- ================ PLUGINS ===================
-- ============================================
--
-- Use vim-plug to manage plugins
vim.cmd [[
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', { 'on':  'Goyo' }
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
" Plug 'itchyny/lightline.vim'
Plug 'yamatsum/nvim-cursorline'
" Plug '907th/vim-auto-save'
Plug 'tpope/vim-surround'
Plug 'jackMort/ChatGPT.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'neovim/nvim-lspconfig'
" Plug 'SmiteshP/nvim-navic'
" Plug 'MunifTanjim/nui.nvim'
" Plug 'HampusHauffman/block.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-tree/nvim-web-devicons' " If you want devicons
" Plug 'willothy/nvim-cokeline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-fugitive'
" Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" Plug 'vim-airline/vim-airline'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'        " Required for v0.4.0+
" Plug 'vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
Plug 'hrsh7th/nvim-cmp'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
]]

--
-- ============================================
-- ======= GLOBAL OPTIONS AND SETTINGS ========
-- ============================================

-- Relative Line Nr.
vim.wo.relativenumber = true

-- Enable line numbers
vim.opt.number = true

-- Set scrolling options
vim.opt.scrolloff = 4

-- Color scheme
vim.cmd('colorscheme tokyonight-night')  -- Replace 'sorbet' with your chosen theme if needed

-- Tab and indentation settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.wrap = false  -- Disable line wrapping
vim.opt.linebreak = false  -- Prevent line break at word boundaries
vim.opt.fillchars:append("eob: ")  -- Clear the end-of-buffer character for a clean look

-- Line number color (uncomment and customize if needed)
-- vim.api.nvim_set_hl(0, 'LineNr', { ctermfg = 'grey' })

-- ==================================
-- ============ KEYMAPS =============
-- ==================================

-- Set the leader key to Option (Alt).
-- vim.g.mapleader = '<A-x>'

vim.g.mapleader = " "

-- Set NvimTreeToggle to <C-ü>
vim.keymap.set('n', '<C-ü>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Toggle NERDTree
vim.keymap.set('n', '<C-p>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<D-e>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Navigation

vim.keymap.set('n', '<S-j>', 'gT')
vim.keymap.set('n', '<S-k>', 'gt')
vim.keymap.set({'n', 'v'}, '<C-j>', '4j', { silent = true })
vim.keymap.set({'n', 'v'}, '<C-k>', '4k', { silent = true })
vim.keymap.set({'n', 'v'}, '<C-h>', '4h', { silent = true })
vim.keymap.set({'n', 'v'}, '<C-l>', '4l', { silent = true })

-- FZF
vim.keymap.set('n', '<C-f>', ':Rg<CR>', { silent = true })
vim.keymap.set('n', '<Leader>f', ':Files<CR>', { silent = true })

-- Custom date/time insert
vim.keymap.set('i', '<F5>', '<C-R>=strftime("%a, %d %b %Y %H:%M:%S")<CR>')
vim.keymap.set('n', '<leader>gd', require('telescope.builtin').lsp_definitions, { noremap = true, silent = true })


-- Create a command that runs Prettier on the current file
-- vim.api.nvim_create_user_command('Format', function()
--     vim.cmd('!prettier --write ' .. vim.fn.expand('%'))
-- end, {})
-- im nnoremap <leader>p :!prettier --write %<CR>

-- Toggle hlsearch
-- vim.keymap.set({'n', 'v'}, '<Leader>h', ':nohlsearch<CR>')
vim.api.nvim_set_keymap('n', '<leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', ':!prettier --write %<CR>', { noremap = true })

-- Copy selected text to system clipboard with <C-c>
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true })

-----------------------------------------------------------------

-- Create an augroup for NERDTree mappings
vim.api.nvim_create_augroup("NERDTreeMappings", { clear = true })

-- Set key mappings for NERDTree
vim.api.nvim_create_autocmd("FileType", {
    group = "NERDTreeMappings",
    pattern = "nerdtree",
    callback = function()
        -- Map your fast navigation keys for NERDTree
        vim.keymap.set('n', '<S-j>', 'gT', { buffer = 0, silent = true })
        vim.keymap.set('n', '<S-k>', 'gt', { buffer = 0, silent = true })

        vim.keymap.set('n', '<C-j>', '4j', { buffer = 0, silent = true })
        vim.keymap.set('n', '<C-k>', '4k', { buffer = 0, silent = true })
        vim.keymap.set('n', '<C-h>', '4h', { buffer = 0, silent = true })
        vim.keymap.set('n', '<C-l>', '4l', { buffer = 0, silent = true })
    end,
})


-- ===================================
-- ============ MARKDOWN =============
-- ===================================

-- Concealing in Markdown and JavaScript
vim.g.markdown_syntax_conceal = 1
vim.g.vim_markdown_conceal = 1
vim.opt.conceallevel = 2

-- Enable auto-save
vim.g.auto_save = 1

-- Setup specific plugin settings
-- vim.g.vim_markdown_folding_disabled = 1
vim.g.markdown_fenced_languages = {'html', 'python', 'bash=sh', 'javascript'}
vim.g.javascript_conceal_function = "ƒ"
vim.g.javascript_conceal_null = "ø"
vim.g.javascript_conceal_this = "@"
vim.g.javascript_conceal_return = "⇚"
vim.g.javascript_conceal_undefined = "¿"
vim.g.javascript_conceal_NaN = "ℕ"
vim.g.javascript_conceal_prototype = "¶"
vim.g.javascript_conceal_static = "•"
vim.g.javascript_conceal_super = "Ω"
vim.g.javascript_conceal_arrow_function = "⇒"
vim.g.javascript_conceal_noarg_arrow_function = "🞅"
vim.g.javascript_conceal_underscore_arrow_function = "🞅"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults

require("nvim-tree").setup()

--[[ 
-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

]]

-- nvim-cursorline setup
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}


-- ==============================================
-- ============ Additional Settings =============
-- ==============================================


-- Visual settings
-- vim.opt.listchars = { tab = '> ', trail = '~', extends = '>', precedes = '<', space = '.' }
-- vim.opt.ttimeout = true
-- vim.opt.ttimeoutlen = 1
vim.opt.hlsearch = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.laststatus = 2
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.autochdir = true
vim.opt.foldenable = false  -- Show folds by default

-- Auto-save on Vim startup
-- vim.g.auto_save = 1

-- Plugin-specific settings (if necessary)
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_new_list_item_indent = 2
vim.g.vim_markdown_toc_autofit = 1
vim.g.vim_markdown_override_foldtext = 0
vim.g.vim_markdown_folding_level = 1

vim.cmd('set termguicolors')

--[[ 

local navic = require("nvim-navic")

require("lspconfig").clangd.setup {
    on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
    end
}

]]

require("scrollbar").setup()

---@field percent number  -- The change in color. 0.8 would change each box to be 20% darker than the last and 1.2 would be 20% brighter.
---@field depth number -- De depths of changing colors. Defaults to 4. After this the colors reset. Note that the first color is taken from your "Normal" highlight so a 4 is 3 new colors.
---@field automatic boolean -- Automatically turns this on when treesitter finds a parser for the current file.
---@field colors string [] | nil -- A list of colors to use instead. If this is set percent and depth are not taken into account.
---@field bg string? -- If you'd prefer to use a different color other than the default "Normal" highlight.

--[[
require("block").setup({
    percent = 0.8,
    depth = 4,
    colors = nil,
    automatic = false,
--      bg = nil,
--      colors = {
--          "#ff0000"
--          "#00ff00"
--          "#0000ff"
--      },
})
]]

local lspconfig = require('lspconfig')
lspconfig.ts_ls.setup{}  -- Configure Pyright for Python

-- ==============================================
-- ================= TREESITTER =================
-- ==============================================

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { 
    "c",
    "lua",
    "vim",
    "markdown",
    "markdown_inline",
    "javascript",
    "typescript",
    "json",
    "html",
    "css",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
  --[[ 
    indent = {
    enable = true
  },
  ]]
  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Indent Blank Line
local highlight = {
    "CursorColumn",
    "Whitespace",
}

--[[
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}
]]

require("ibl").setup()
-- require("bufferline").setup{}

-- Set the color of folded lines
vim.api.nvim_set_hl(0, "Folded", { fg = "#5c6370", bg = "#1f242d", italic = true })

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- ===================================================================
-- =============================== COC ===============================
-- ===================================================================

-- https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.lua

-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K/Q to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "Q", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})



--[[
-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
]]

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
-- keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
