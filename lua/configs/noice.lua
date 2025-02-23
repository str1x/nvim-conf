return {
  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  ["vim.lsp.util.stylize_markdown"] = true,
  ["cmp.entry.get_documentation"] = true,
  cmdline = {
    enabled = true
  },
  messages = {
    enabled = true
  },
  popupmenu = {
    enabled = true
  },
  notify = {
    enabled = true
  },
  lsp = {
    hover = {
      --- donts show empty lsp messages
      silent = true,
    },
    signature = {
      auto_open = {
        trigger = false
      },
    },
  },
  presets = {
    lsp_doc_border = true,
  },
}
