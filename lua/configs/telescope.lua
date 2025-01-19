dofile(vim.g.base46_cache .. "telescope")

return {
  defaults = {
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    initial_mode = "insert",
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.87,
      height = 0.80,
      prompt_position = "bottom",
      mirror = true,
      preview_height = 0.65,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
}
