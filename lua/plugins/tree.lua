return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      -- must happen before loading nvim-tree
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 32 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
    end,
  },
}
