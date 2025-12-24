
return {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local icon = {
            prompt_prefix = "   ",
            selection_caret = " ",
        }

        require("telescope").setup({
            defaults = {
                path_display = {
                    filename_first = {
                        reverse_directories = false,
                    },
                },
                prompt_prefix = icon.prompt_prefix,
                selection_caret = icon.selection_caret,
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        preview_width = 0.4,
                        results_width = 0.8,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                winblend = 0,
                border = true,
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                file_ignore_patterns = { "node_modules", ".git/" },
                set_env = { ["COLORTERM"] = "truecolor" },
            },

            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
                find_files = {
                    hidden = true,
                },
            },
        })
    end,
}
