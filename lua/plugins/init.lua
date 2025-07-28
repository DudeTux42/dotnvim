if true then return {} end

return {
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {},
  },

  -- LSP configuration for slint
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        slint = {
          cmd = { "slint-lsp" },
          filetypes = { "slint" },
        },
        pyright = {},
        tsserver = {}, -- tsserver with TypeScript setup
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    version = "v1.*",
  },
  {
    "williamboman/mason-lspconfig.nvim", 
    version = "v1.*",
  },
  -- CoC configuration
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- Place your Coc configuration here
    end,
  },

  -- Theme plugins
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Rust support
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    ft = "rust",
    config = function ()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require('rustaceanvim.config')

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end
  },
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  -- Debug Adapter Protocol (DAP) setup
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
  },

  -- Crates support for Cargo.toml files
  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },

  -- Troubleshooting plugin
  { "folke/trouble.nvim", opts = { use_diagnostic_signs = true } },

  -- nvim-cmp with emoji support
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- Telescope customization
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- Treesitter with extended language support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash", "html", "javascript", "json", "lua",
        "markdown", "markdown_inline", "python", "query",
        "regex", "tsx", "typescript", "vim", "yaml"
      })
    end,
  },

  -- ToggleTerm for terminal integration
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require("toggleterm").setup{}
    end
  },

  -- Lualine with custom symbol in status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- mini.starter instead of alpha for dashboard
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- JSON LSP and treesitter support
  { import = "lazyvim.plugins.extras.lang.json" },

  -- Mason for managing external tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua", "shellcheck", "shfmt", "flake8", "codelldb", "slint-lsp"
      },
    },
  },

  -- Enable syntax-based folding
  {
    config = function()
      vim.o.foldmethod = "syntax"
      vim.o.foldlevel = 99 -- Keep all blocks unfolded by default
    end
  },
}


