vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.g.ffs = 'unix,dos'

-- Disable netrw, recommended for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Remove whitespace on save
--vim.api.nvim_create_autocmd('BufWritePre', {
--  pattern = '*',
--  command = ":%s/\\s\\+$//e"
--})

-- Autoformat after save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { "*.cpp", "*.c", "*.h", "*.ts", "*.lua" },
    callback = function()
        vim.lsp.buf.format {
            timeout_ms = 1000,
            filter = function(clients)
                return vim.tbl_filter(function(client)
                    return pcall(function(_client)
                        return _client.config.settings.autoFixOnSave or false
                    end, client) or false
                end, clients)
            end
        }
    end,
})

-- Autoreload file when changed outside neovim
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Git related plugins
    'tpope/vim-fugitive',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- Color, easy for eyes
    "rebelot/kanagawa.nvim",

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies =
        {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Mason automatic tool installer
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                opts = {},
            },

            -- Additional lua configuration
            'folke/neodev.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies =
        {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
    },

    {
        -- Tree File Viewer
        'nvim-tree/nvim-tree.lua',
    },

    {
        -- Terminal
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true
    },

    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts =
        {
            -- See `:help gitsigns.txt`
            signs =
            {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts =
        {
            options =
            {
                icons_enabled = false,
                theme = 'onedark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            local actions = require("fzf-lua.actions")
            require("fzf-lua").setup({
                files = {
                    git_icons = false,
                    file_icons = false,
                    color_icons = false,
                },
                git = {
                    status = {
                        git_icons = false,
                        file_icons = false,
                    },
                },
                grep = {
                    git_icons = false,
                    file_icons = false,
                    color_icons = false,
                },
                winopts = {
                    fullscreen = true,
                    preview = {
                        layout = "vertical",
                    },
                },
                actions = {
                    files = {
                        true,
                        ["ctrl-x"] = actions.file_split,
                    },
                },
            })
        end
    },

    {
        -- Pretty List for showing diagnostics
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies =
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    },
}, {})

require("kanagawa").load("wave")

-- Virtual Edit, can edit on empty column
vim.o.virtualedit = 'all'

-- Encodings
vim.o.encoding = 'utf-8'

-- No swap file
vim.o.swapfile = false

-- No Writebackup
vim.o.writebackup = false

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim. Remove this option if you want your OS clipboard to remain independent.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Serach Settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- See bottom or top when scrolling
vim.o.scrolloff = 3

-- Show line and column of cursor position
vim.o.ruler = true

-- Decrease update time
vim.o.updatetime = 150
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Keymaps for better default experience in view mode
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better movement
vim.keymap.set('n', 'l', "<Space>", { silent = true })
vim.keymap.set('n', '<C-j>', "}", { silent = true })
vim.keymap.set('n', '<C-k>', "{", { silent = true })
vim.keymap.set('n', '<C-h>', "F<Space>", { silent = true })
vim.keymap.set('n', '<C-l>', "f<space>", { silent = true })
vim.keymap.set('n', '<C-b>', "0", { silent = true })
vim.keymap.set('n', '<C-e>', "$", { silent = true })
vim.keymap.set('v', '<C-j>', "}", { silent = true })
vim.keymap.set('v', '<C-k>', "{", { silent = true })

-- Save
vim.keymap.set('n', '<C-s>', ":w!<CR>", { silent = true })

-- Exit using
vim.keymap.set('i', 'jk', "<ESC>", { silent = true })

-- Remove F1
vim.keymap.set('i', '<F1>', "<ESC>", { silent = true })
vim.keymap.set('n', '<F1>', "<ESC>", { silent = true })
vim.keymap.set('v', '<F1>', "<ESC>", { silent = true })

-- Easier to type command
vim.keymap.set('n', ';', ":")
vim.keymap.set('v', ';', ":")

-- Quick switch between .h and .cpp
vim.keymap.set("", "<F4>", ":e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>")

-- Toggle Terminal
vim.keymap.set("n", "<C-t>", ":ToggleTerm direction=float<CR>")
vim.keymap.set("v", "<C-t>", ":ToggleTerm direction=float<CR>")

-- Fzf-lua
vim.keymap.set("n", "<C-p>", require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set('n', '<leader>f', require('fzf-lua').live_grep)

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    --osx, windows have issues installing help ensure_installed = { 'c', 'cpp', 'c_sharp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },
    ensure_installed = { 'c', 'cpp', 'c_sharp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}


-- LSP settings.
local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    --nmap('<leader>d', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('<leader>d', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
    --nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    --nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>r', require('fzf-lua').lsp_references, 'Goto References')
    --nmap('<leader>d', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>s', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>w', require('fzf-lua').lsp_workspace_symbols, '[W]orkspace [S]ymbols')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
local servers = {
    clangd = {},
    omnisharp = {},
    lua_ls = {},
    ts_ls = {},
    pylsp = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W291', 'W293' },
                }
            }
        }
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

-- Ensure tools that mason needed is installed
require('mason-tool-installer').setup {
    ensure_installed = {
        "clang-format",
        "clangd",
        "omnisharp",
        "python-lsp-server",
        "gopls",
        "lua-language-server",
        "typescript-language-server",
    },
    auto_update = false,
    run_on_start = true,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- Nvim-tree
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        icons = {
            web_devicons = {
                file = {
                    enable = false,
                },
                folder = {
                    enable = false,
                },
            },
            show = {
                file = false,
                folder = false,
                folder_arrow = true,
                git = false,
                modified = false,
                diagnostics = false,
                bookmarks = false,
            },
        },
    },
    filters = {
        dotfiles = true,
    },
    git = {
        enable = false,
    }
})

vim.keymap.set('n', '<F1>', ":NvimTreeToggle<CR>")

-- Vim Fugitive
vim.keymap.set('n', '<F8>', ":Gedit branch:%")
vim.keymap.set('n', '<F9>', ":Git blame<CR>")
vim.keymap.set('n', '<F10>', ":Git<CR>")
vim.keymap.set('n', '<F11>', ":Gvdiffsplit!<CR>")
vim.keymap.set('n', '<F12>', ":Gread<CR>")

-- Go to Prev and Next error
vim.keymap.set("n", "1", "<ESC><CMD>lua vim.diagnostic.goto_prev()<CR>", {})
vim.keymap.set("n", "2", "<ESC><CMD>lua vim.diagnostic.goto_next()<CR>", {})

vim.lsp.set_log_level("off")
