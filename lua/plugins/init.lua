return {
  "nvim-lua/plenary.nvim",
  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },
  "nvzone/volt",
  "nvzone/menu",
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },
  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│", highlight = "IblChar" },
      scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },
  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
  },
  -- keybingings info
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
  },
  -- formatters
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      return require "configs.conform"
    end,
  },
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },
  -- lsp servers installer
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    lazy=false,
    opts = function()
      return require "configs.mason"
    end,
  },
  -- lsp configs
  {
    "neovim/nvim-lspconfig",
    lazy=false,
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
  },
  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "configs.luasnip"
        end,
      },
      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      -- extensions
      {
        "onsails/lspkind.nvim",
        opts = function()
          return require "configs.lspkind"
        end,
      },
      -- cmp sources plugins
      {
        "f3fora/cmp-spell",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
  },
  -- syntax highlight
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- syntax highlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vue",
        "typescript",
        "css",
        "cmake",
        "cpp",
        "markdown",
        "markdown_inline",
        "gdscript"
      },
    },
  },
  -- debugger ui
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- debugger lsp
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
    },
  },
  -- debugger
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
          args = {"--port", "${port}"},
        }
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          host = '127.0.0.1',
          port = 13000
        },
      }
    end,
  },
  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup {
        easing_function = "quadratic",
      }
    end,
  },
  -- zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
  },
  -- dimming inactive code, integrated with zenmode
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    opts = function()
      return require "configs.twilight"
    end,
  },
  -- ui notifications, command, hover
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.noice"
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }
}
