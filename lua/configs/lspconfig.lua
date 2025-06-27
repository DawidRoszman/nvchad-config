local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
  },
}

-- Java (jdtls)
lspconfig.jdtls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    java = {
      project = {
        lombok = {
          enabled = true,
        },
      },
    },
  },
}

-- TypeScript (ts_ls)
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  -- If you are using mason.nvim, you can get the ts_plugin_path like this
  -- local mason_registry = require('mason-registry')
  -- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
  -- init_options = {
  --   plugins = {
  --     {
  --       name = '@vue/typescript-plugin',
  --       location = vue_language_server_path,
  --       languages = { 'vue' },
  --     },
  --   },
  -- },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

-- Volar (Vue language server)
-- Note: 'volar' needs to be installed by Mason if you use it directly.
-- If 'ts_ls' with the Vue plugin is sufficient, you might not need volar.
-- If you need specific settings for volar, add them here:
lspconfig.volar.setup {
  -- on_attach = on_attach,
  -- on_init = on_init,
  -- capabilities = capabilities,
  -- ... other volar specific settings
}

-- Tailwind CSS
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html", "jsx", "tsx", "templ" },
}

-- Emmet Language Server
lspconfig.emmet_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
    "templ",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
}
