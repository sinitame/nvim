return {
    {
        "yetone/avante.nvim",
        build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
        event = "VeryLazy",
        version = false,
        opts = {
            instructions_file = "avante.md",
            provider = "openai",
            debug = true,
            providers = {
                openai = {
                    endpoint = "https://api.openai.com/v1",
                    model = "gpt-4.1-mini",
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 1.0,
                        max_completion_tokens = 4000,
                    },
                },
            },
        },

        windows = {
            sidebar_header = { rounded = true, align = "left" },
            position = "left",
        },

        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "stevearc/dressing.nvim", -- nicer prompts
            "nvim-tree/nvim-web-devicons", -- icons
            "hrsh7th/nvim-cmp", -- completion for mentions/commands
            "nvim-telescope/telescope.nvim", -- file selector provider

            {
                "HakonHarnes/img-clip.nvim", -- paste images into Avante chats
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
            { "aa", function() require("avante.api").ask() end, desc = "Avante: Ask", mode = { "n", "v" } },
            { "ae", function() require("avante.api").edit() end, desc = "Avante: Edit", mode = "v" },
            { "ar", function() require("avante.api").refresh() end, desc = "Avante: Refresh" },
            { "az", function() require("avante.api").zen_mode() end, desc = "Avante: Zen Mode" },
        },
    },
}

