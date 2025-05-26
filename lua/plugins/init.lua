return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "joeveiga/ng.nvim",
  },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    main = "nvim-silicon",
    opts = {
      -- Configuration here, or leave empty to use defaults
      to_clipboard = true,
      line_offset = function(args)
        return args.line1
      end,
    },
    keys = {
      mode = { "v" },
      { "<leader>s",  group = "Silicon" },
      { "<leader>sc", function() require("nvim-silicon").clip() end,  desc = "Copy code screenshot to clipboard" },
      { "<leader>sf", function() require("nvim-silicon").file() end,  desc = "Save code screenshot as file" },
      { "<leader>ss", function() require("nvim-silicon").shoot() end, desc = "Create code screenshot" },
    }
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  -- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   -- opts = {
  --   --   -- Possible configurable fields can be found on:
  --   --   -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  --   --   suggestion = {
  --   --     enable = true,
  --   --   },
  --   --   panel = {
  --   --     enable = false,
  --   --   },
  --   -- },
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         auto_trigger = true,
  --       }
  --     })
  --   end,
  -- },
  --
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     {
  --       "zbirenbaum/copilot-cmp",
  --       config = function()
  --         require("copilot_cmp").setup()
  --       end,
  --     },
  --   },
  --   opts = {
  --     sources = {
  --       { name = "nvim_lsp", group_index = 2 },
  --       { name = "copilot",  group_index = 2 },
  --       { name = "luasnip",  group_index = 2 },
  --       { name = "buffer",   group_index = 2 },
  --       { name = "nvim_lua", group_index = 2 },
  --       { name = "path",     group_index = 2 },
  --     },
  --   },
  -- },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over" },
      { "<leader>du", function() require("dap").step_out() end,          desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.open() end,         desc = "Open REPL" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("configs.nvim-dap")

      require("nvim-dap-virtual-text").setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      }

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
  {
    'nvim-java/nvim-java',
    lazy = false,
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      },
    },
    config = function()
      require('configs.java')
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim"
  },
  {
    'nvim-neotest/neotest',
    config = function()
      require("configs.neotest")
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'rcasia/neotest-java',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-jdtls'
    },
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end,                    desc = "Run Nearest Test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,  desc = "Run File Tests" },
      { "<leader>tF", function() require("neotest").run.run({ vim.fn.getcwd() }) end, desc = "Run Project Tests" },
      { "<leader>tS", function() require("neotest").run.stop() end,                   desc = "Stop Test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,             desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open() end,                desc = "Open Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,        desc = "Toggle Output Panel" },
    }
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  }
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}

