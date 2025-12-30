vim.pack.add({
        {
                src = "https://github.com/Saghen/blink.cmp",
                version = "v1.*",
        },
        { src = "https://github.com/rafamadriz/friendly-snippets" },
})

-- ~/.config/nvim/lua/blink-setup.lua
local blink = require("blink.cmp")

blink.setup({
        -- keymaps: preset + a few common bindings
        keymap = {
                preset = "default", -- default mappings
                ["<C-enter>"] = { "accept", "fallback" },
                ["<C-l>"] = { "select_next", "fallback" },
                ["<C-ö>"] = { "select_prev", "fallback" },
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
        },

        -- enable signature help (shown with C-k / auto if enabled)
        signature = { enabled = true },

        -- control how the completion menu looks
        completion = {
                documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 150,
                },
        },

        -- cmdline mode (if you want completion in : commands)
        cmdline = {
                enabled = true,
                keymap = {
                        preset = "inherit",
                        ["<CR>"] = { "accept_and_enter", "fallback" },
                },
        },

        -- define which sources you want
        -- "default" is the top‑level set used in insert mode
        sources = {
                default = { "lsp", "path", "snippets", "buffer" },
        },

        -- fuzzy configuration (rust preferred if available)
        fuzzy = {
                implementation = "prefer_rust_with_warning",
        },
})
