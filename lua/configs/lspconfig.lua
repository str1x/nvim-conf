dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local on_attach = function(_, bufnr)
end

-- disable semanticTokens
local on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require "lspconfig"

-- lua
lspconfig.lua_ls.setup({
  on_init = function(client)
    on_init(client)

    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force',  client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
-- volar
lspconfig.volar.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    vue = {
      hybridMode = true,
    },
    typescript = {
      -- tsdk = "./node_modules/typescript/lib"
    }
  },
  on_new_config = function(new_config, new_root_dir)
    local lib_path = vim.fs.find('node_modules/typescript/lib', { path = new_root_dir, upward = true })[1]
    if lib_path then
      new_config.init_options.typescript.tsdk = lib_path
    end
  end
}
-- typescript
local ts_ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
local vue_ft = { table.unpack(ts_ft) }
table.insert(vue_ft, "vue")
local volar_ts_plugin_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server";

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = vue_ft,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = volar_ts_plugin_path,
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
