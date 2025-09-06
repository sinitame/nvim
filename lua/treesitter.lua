require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "rust", "toml", "python", "bash", "json", "yaml", "markdown" },
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
})

-- Rainbow delimiters
local rd = require('rainbow-delimiters')
vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rd.strategy['global'],
        vim = rd.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed', 'RainbowDelimiterYellow', 'RainbowDelimiterBlue',
        'RainbowDelimiterOrange', 'RainbowDelimiterGreen', 'RainbowDelimiterViolet', 'RainbowDelimiterCyan',
    },
}

-- Optional: Treesitter folding (off by default)
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
