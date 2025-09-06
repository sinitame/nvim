return {
    {
        "yetone/avante.nvim",
        -- build step (uses prebuilt binary if available; falls back to cargo/make)
        build = vim.fn.has("win32") ~= 0
            and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        version = false,
        opts = {
            instructions_file = "avante.md",

            -- provider = "claude",
            --   claude = {
            --     endpoint = "https://api.anthropic.com",
            --     model = "claude-sonnet-4-20250514", -- example from README
            --     timeout = 30000,
            --     extra_request_body = {
            --       temperature = 0.5,
            --       max_tokens = 20480,
            --     },
            --   },

            provider = "openai",
            openai = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-3.5-turbo",
                timeout = 30000,
                extra_request_body = {
                    temperature = 1.0,
                    max_completion_tokens = 2048,
                },
            },

            -- 3) Ollama local (uncomment to use)
            -- ollama = {
            --   endpoint = "http://localhost:11434",
            --   model = "qwq:32b",
            -- },
            -- provider = "ollama",
        },

        -- Optional UI polish
        windows = {
            sidebar_header = { rounded = true, align = "left" },
            position = "left",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "stevearc/dressing.nvim",           -- nicer prompts
            "nvim-tree/nvim-web-devicons",      -- icons
            "hrsh7th/nvim-cmp",                 -- completion for mentions/commands
            "nvim-telescope/telescope.nvim",    -- file selector provider
            -- "echasnovski/mini.pick",          -- alt file selector
            -- "ibhagwan/fzf-lua",               -- alt file selector
            -- "zbirenbaum/copilot.lua",         -- if provider = 'copilot'
            {
                "HakonHarnes/img-clip.nvim",      -- paste images into Avante chats
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = { insert_mode = true },
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- renders Avante markdown nicely (optional)
                "MeanderingProgrammer/render-markdown.nvim",
                ft = { "markdown", "Avante" },
                opts = { file_types = { "markdown", "Avante" } },
            },
        },
        keys = {
            -- lightweight, discoverable keymaps
            { "aa", function() require("avante.api").ask() end,      desc = "Avante: Ask",    mode = { "n", "v" } },
            { "ae", function() require("avante.api").edit() end,     desc = "Avante: Edit",   mode = "v" },
            { "ar", function() require("avante.api").refresh() end,  desc = "Avante: Refresh" },
            { "az", function() require("avante.api").zen_mode() end, desc = "Avante: Zen Mode" },
        },
    },
}


