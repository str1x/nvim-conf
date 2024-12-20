-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
-- local servers = { "html", "cssls" }
--
-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--   }
-- end

-- volar
lspconfig.volar.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    vue = {
      hybridMode = true,
    },
    -- typescript = {
    --   tsdk = "./node_modules/typescript/lib"
    -- }
  }
}
-- typescript
local ts_ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
local vue_ft = { table.unpack(ts_ft) }
table.insert(vue_ft, "vue")

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = vue_ft,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/home/str1x/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
        languages = vue_ft,
      },
    },
  },
}
-- eslint
lspconfig.eslint.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
--cpp
lspconfig.clangd.setup {
  -- cmd = {
  --   -- see clangd --help-hidden
  --   "clangd",
  --   "--background-index",
  --   -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
  --   -- to add more checks, create .clang-tidy file in the root directory
  --   -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
  --   "--clang-tidy",
  --   "--completion-style=bundled",
  --   "--cross-file-rename",
  --   "--header-insertion=iwyu",
  -- },
  -- init_options = {
  --   clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
  --   usePlaceholders = true,
  --   completeUnimported = true,
  --   semanticHighlighting = true,
  -- },
  on_attach = function (client, bufnr)
    -- client.server_capabilities.signatureHelpProvider = false;
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  on_init = on_init,
}
--godot script
lspconfig.gdscript.setup {}
