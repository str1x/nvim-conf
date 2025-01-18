dofile(vim.g.base46_cache .. "telescope")

return {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    initial_mode = "normal",
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.87,
      height = 0.80,
      prompt_position = "top",
      vertical = {
        mirror = true,
        preview_cutoff = 0,
      },
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = { "themes", "terms" },
  extensions = {},
}
