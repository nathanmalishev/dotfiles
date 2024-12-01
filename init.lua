-- Load packer.nvim (plugin manager)
vim.cmd [[packadd packer.nvim]]

-- Packer startup function
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Add nvim-treesitter with automatic parser updates
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate' -- Run :TSUpdate after installation
    }

    -- Add other plugins here as needed

    use 'neovim/nvim-lspconfig'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
    }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = { 
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
      }


    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    use({
        'ray-x/navigator.lua',
        requires = {
            { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
            { 'neovim/nvim-lspconfig' },
        },
    })

    use 'navarasu/onedark.nvim' -- Modern Lua-based Onedark theme
    use 'lewis6991/gitsigns.nvim' -- Modern Lua-based Onedark theme
    use {
      'folke/todo-comments.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('todo-comments').setup()
      end
    }

    use 'Isrothy/neominimap.nvim'
    use {"shortcuts/no-neck-pain.nvim", tag = "*" }
    use "sindrets/diffview.nvim" 
end)

-- Theme settings
vim.cmd('syntax enable')    -- Enable syntax highlighting
vim.o.termguicolors = true  -- Enable true color support
vim.cmd('colorscheme onedark') -- Set the colorscheme

-- Set the Airline theme
vim.g.airline_theme = 'onedark'

-- Set the Tmuxline theme
vim.g.tmuxline_theme = 'powerline'
vim.cmd('source ~/.config/nvim/init.vim')


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "elixir", "vim", "vimdoc", "markdown", "markdown_inline", "heex", "html" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 400 * 1024 -- 400 KB
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
local lspconfig = require('lspconfig')

-- Configure the ElixirLS Language Server
lspconfig.elixirls.setup({
  cmd = { "/Users/nathan/coding/elixir-ls/release/language_server.sh"}, -- Update this path
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    },
  },
   on_attach = function(client, bufnr)
    -- Enable formatting on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true, silent = true })

vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-g>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set("n", "<leader>fn", "<cmd>Telescope diagnostics<CR>", { desc = "LSP Diagnostics" })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
-- Keymap for finding the word under the cursor
vim.keymap.set('n', '<leader>fw', function()
  builtin.live_grep({ default_text = vim.fn.expand('<cword>') })
end, { desc = 'Telescope search for word under cursor' })
vim.keymap.set('n', '<leader>fd', function()
  local word = vim.fn.expand('<cword>')
  builtin.live_grep({ default_text = "def " .. word })
end, { desc = 'Telescope search for "def <cword>"' })


-- Lua configuration for Neovim with Neo-tree
require("neo-tree").setup({
    default_component_configs = {
        diagnostics = {
            symbols = {
                warn = "W",
            },
        },
    },
})
-- Toggle Neo-tree with <C-m>
vim.keymap.set('n', '<C-m>', function()
  vim.cmd('Neotree toggle')
end, { desc = 'Toggle Neo-tree' })

-- Find the current file in Neo-tree with <C-n>
vim.keymap.set('n', '<C-n>', function()
  vim.cmd('Neotree reveal')
end, { desc = 'Reveal file in Neo-tree' })

-- Close Neo-tree with <C-c>
vim.keymap.set('n', '<C-c>', function()
  vim.cmd('Neotree close')
end, { desc = 'Close Neo-tree' })

-- Toggle comments for the current line or selection
vim.keymap.set('n', '<leader>cs', '<Plug>(comment_toggle_linewise_current)', { desc = 'Toggle comment' })
vim.keymap.set('x', '<leader>cs', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment in visual mode' })

-- Import and configure navigator.lua
require('navigator').setup({
    -- Optional configuration options
    border = 'rounded',  -- LSP UI border style
    debug = false,       -- Enable debug output
    transparency = 100,   -- Transparency for floating windows (0-100)
    default_mapping = false, -- Set up default key mappings
    lsp = {
        diagnostic_virtual_text = false,
        colors = {
            diagnostic_virtual_text = "Comment",      -- Use Comment highlight group for diagnostics
            diagnostic_float_border = "FloatBorder", -- Use FloatBorder for diagnostics' floating borders
        },
        format_on_save = false, -- could never get it working
        enable = false,    -- Enable built-in LSP configuration
        diagnostic = {
          underline = true,
          virtual_text = true, -- show virtual for diagnostic message
          update_in_insert = false, -- update diagnostic message in insert mode
          float = {                 -- setup for floating windows style
            focusable = false,
            sytle = 'minimal',
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
          },
        },
    },
})

vim.keymap.set('n', 'gr', function() require('navigator.reference').async_ref() end, { desc = 'Find references', noremap = true, silent = true })
-- Highlight on navigator was off coloured
vim.api.nvim_set_hl(0, 'GuihuaListSelHl', { fg = '#282c34', bg = '#87d1da', bold = true }) -- Light teal background


-- Set diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

require('gitsigns').setup()

vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })


vim.keymap.set("n", "<leader>nm", "<cmd>Neominimap toggle<CR>", { desc = "Toggle global minimap" })


require("no-neck-pain").setup({
    -- The width of the focused window that will be centered. When the terminal width is less than the `width` option, the side buffers won't be created.
    --- @type integer|"textwidth"|"colorcolumn"
    width = 200,
  })

local actions = require("diffview.actions")
vim.keymap.set(
  "n",                                   
  "<leader>go",                          
  function()
    vim.cmd("DiffviewOpen")
  end,
  {  desc = "Open the file panel." } 
)
vim.keymap.set(
  "n",                                   
  "<leader>gc",                          
  function()
    vim.cmd("DiffviewClose")
  end,
  {  desc = "Close the file panel." } 
)
