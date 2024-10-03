-- All Go Related Configurations
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "goimports",
        "gofumpt",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- opts will be merged with the parent spec
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },
}
