-- Function to select and switch to an open buffer
local function switch_buffer()
        local bufs = vim.api.nvim_list_bufs()
        local open_bufs = {}

        -- Filter only loaded buffers with a name
        for _, b in ipairs(bufs) do
                if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_buf_get_name(b) ~= "" then
                        table.insert(open_bufs, b)
                end
        end

        if #open_bufs == 0 then
                print("No open buffers found")
                return
        end

        -- Helper to shorten paths for display
        local function shorten_path(path, n)
                n = n or 3
                local rel = vim.fn.fnamemodify(path, ":.") -- relative to cwd
                local parts = vim.split(rel, "/", { plain = true })
                if #parts > n then
                        return "…/" .. table.concat(vim.list_slice(parts, #parts - n + 1, #parts), "/")
                else
                        return rel
                end
        end

        -- Create a numbered list of buffers
        local items = {}
        for i, b in ipairs(open_bufs) do
                local name = vim.api.nvim_buf_get_name(b)
                table.insert(items, string.format("%d: %s", i, shorten_path(name, 3)))
        end

        -- Show selection menu
        vim.ui.select(items, {
                prompt = "Switch buffer:",
        }, function(choice)
                if choice then
                        -- Extract buffer number from choice string
                        local index = tonumber(choice:match("^(%d+):"))
                        if index and open_bufs[index] then
                                vim.api.nvim_set_current_buf(open_bufs[index])
                        end
                end
        end)
end

-- User command
vim.api.nvim_create_user_command("Buffers", switch_buffer, {})

-- Keymap for <leader>b
vim.keymap.set("n", "<leader>b", switch_buffer, {
        desc = "Switch open buffer",
        noremap = true,
        silent = true
})
