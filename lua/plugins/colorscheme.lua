return {
  -- Install all color schemes here
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    opts = {
      style = "",
      italic_comments = false,
    },
  },
  -- choose the colorscheme here
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
