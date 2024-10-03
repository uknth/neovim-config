return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.border = colors.comment
      end,
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>e", group = "neotree" },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
      config = function()
        require("window-picker").setup()
      end,
    },
    opts = {
      source_selector = {
        sources = {
          { source = "filesystem" },
          { source = "git_status" },
          { source = "buffers" },
        },
      },
      window = {
        mappings = {
          ["e"] = nil, -- disable auto expand; it doesn't work with edgy
          ["<tab>"] = "toggle_node",
        },
      },
    },
    keys = function(_, keys)
      local edgy = require("edgy")
      local util = require("lazyvim.util")
      local neocmd = require("neo-tree.command")
      local neomgr = require("neo-tree.sources.manager")

      -- delete the two bindings that lazy installs: <leader>e and <leader>E
      local del_key = function(lhs)
        for i, v in ipairs(keys) do
          if type(v) == "table" and v[1] == lhs then
            table.remove(keys, i)
            break
          end
        end
      end
      del_key("<leader>e")
      del_key("<leader>E")

      -- If the neotree window for the source is already open in Edgy,
      -- hidden or not, focus on the window. If Edgy is not opened, then
      -- open a new neotree window forcing Edgy open.
      local focus_or_open = function(source, open_opts)
        return function()
          local win = neomgr.get_state(source).winid
          if win ~= nil then
            local ewin = edgy.get_win(win)
            if ewin ~= nil then
              ewin:focus()
              return
            end
          end
          neocmd.execute(vim.tbl_extend("force", {
            source = source,
            toggle = false,
          }, open_opts))
        end
      end

      -- Add new mappings for each Neotree data source: filesystem, buffers,
      -- git_status, and document_symbols. These bindings will open the
      -- corresponding neotree window OR if already opened in Edgy, it will
      -- focus on that section in Edgy. This makes it very easy to direcly go
      -- to that neotree window even if opened in Edgy.
      --
      -- These new mapping are added under a new "<leader>e" menu to keep
      -- all of the neotree actions together. I find this to be intuitive.
      --
      -- NOTE: For the mappings below, the position must be unique and match
      -- the same pos defined in the Edgy open commands. If not, Neotree will
      -- close an existing window (such as the filesystem) to open another
      -- (such as the buffer list), which in turn closes the section in Edgy,
      -- leading to confusion (took me a bit to figure out what the heck was
      -- going on thus the note).
      table.insert(keys, {
        "<leader>ee",
        focus_or_open("filesystem", { position = "left", dir = util.root.get() }),
        desc = "Explorer (root dir)",
      })
      table.insert(keys, {
        "<leader>eE",
        focus_or_open("filesystem", { position = "left", dir = vim.fn.getcwd() }),
        desc = "Explorer (cwd)",
      })
      table.insert(keys, {
        "<leader>eg",
        focus_or_open("git_status", { position = "right" }),
        desc = "Git Status",
      })
      table.insert(keys, {
        "<leader>eb",
        focus_or_open("buffers", { position = "top" }),
        desc = "Buffers",
      })

      return keys
    end,
  },
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.exit_when_last = true
      return opts
    end,
  },
}
