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
end)

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
    additional_vim_regex_highlighting = { "elixir" },
  },
}
local lspconfig = require('lspconfig')

-- Configure the ElixirLS Language Server
lspconfig.elixirls.setup({
  cmd = { "/Users/nathan/coding/elixir-ls/release/language_server.sh" }, -- Update this path
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = false,
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
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- Lua configuration for Neovim with Neo-tree

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
