vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Leader keys early
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Improve startup
pcall(vim.loader.enable)

-- Lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = { notify = false },
    install = { colorscheme = { "tokyonight", "habamax" } },
})

-- UI & editor options that are not plugin-specific
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"

-- Colorscheme
require("colorscheme")

-- Global diagnostics config
require("nvim-lsp")

-- Autocomplete (cmp) core + vsnip integration
require("autocomplete")
require("autocomplete-rs")

-- Treesitter
require("treesitter")

-- nvim-tree
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = { width = 32 },
    renderer = { group_empty = true },
    filters = { dotfiles = false },
})

-- Mason + LSP servers
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    },
})
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "rust_analyzer", "lua_ls" },
    automatic_installation = true,
})

-- LSP
local keymaps = require("keymaps")

-- Rust via rust-tools
local rt = require("rust-tools")
rt.setup({
    tools = {
        hover_actions = { border = "rounded" },
    },
    server = {
        on_attach = function(client, bufnr)
            keymaps.on_attach(client, bufnr)
            -- Rust-specific
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "Rust Hover" })
            vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "Rust Code Action Group" })
        end,
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = "clippy" },
                inlayHints = { enable = true },
            },
        },
    },
})


-- Pyright
local lspconfig = require("lspconfig")
local pyright_cfg = require("pyright")
lspconfig.pyright.setup(vim.tbl_deep_extend("force", pyright_cfg.default_config, {
    on_attach = keymaps.on_attach,
}))

lspconfig.lua_ls.setup({
    on_attach = keymaps.on_attach,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})
