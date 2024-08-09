local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins in plugins directory
require("lazy").setup("plugins")

-- Colorscheme setup
require("colorscheme")

-- Setup Mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()

-- Setup NVIM LSP for Rust
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Rust tool config using Nvim diagnose API
require("nvim-lsp")

-- Setup NVIM auto complete
require("autocomplete")

-- Setup auto-complete for Rust
require("autocomplete-rs")

-- Setup tree sitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml", "python" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
require("treesitter")

-- NVIM Tree 
require("nvim-tree").setup()

require("lspconfig")["pyright"].setup({})
-- Setup NVIM LSP for python
require("pyright")
