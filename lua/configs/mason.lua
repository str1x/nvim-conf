dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,

  ensure_installed = {
    "lua_ls",
    "vue-language-server",
    "typescript-language-server",
    "eslint-lsp",
    "clangd",
    "clang-format",
    "codelldb",
  },

  automatic_installation = true,
}
