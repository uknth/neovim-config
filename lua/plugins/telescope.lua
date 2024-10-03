-- custom keys configuration for telescope
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fh", require("telescope.builtin").help_tags },
  },
}
