vim.pack.add({
        {
                src = "https://github.com/folke/flash.nvim",
                name = "flash",
                version = "v2.1.0",
                sync = true,
                silent = true
        },
})

require("flash").setup({
        highlight = {
                backdrop = true,
                matches = true,
                priority = 5000,
                groups = {
                        match = "FlashMatch",
                        current = "FlashCurrent",
                        backdrop = "FlashBackdrop",
                        label = "FlashLabel",
                },
        },
        modes = {
                search = {
                        enabled = true,
                        highlight = { backdrop = false },
                        jump = { history = true, register = true, nohlsearch = true },
                },
        },
        labels = "ashtfmneoi",
        -- keys = {
        --         { "s", mode = { "n", "x", "o" }, desc = "Flash" },
        -- },
})

vim.keymap.set({ "n", "x", "o" }, "s", function()
        require("flash").jump()
end, { desc = "Flash" })
