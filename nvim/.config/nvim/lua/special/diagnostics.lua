-- Function to navigate diagnostics in current buffer
local function jump_diagnostic()
        local bufnr = vim.api.nvim_get_current_buf()
        local diagnostics = vim.diagnostic.get(bufnr)

        if #diagnostics == 0 then
                print("No diagnostics in current buffer")
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

        -- Build menu items
        local items = {}
        for i, diag in ipairs(diagnostics) do
                local line = diag.lnum + 1               -- convert 0-indexed to 1-indexed
                local col = diag.col + 1
                local msg = diag.message:gsub("\n", " ") -- one-line
                local display = string.format("%d: L%d:%d - %s", i, line, col, msg)
                table.insert(items, display)
        end

        -- Show selection menu
        vim.ui.select(items, {
                prompt = "Select diagnostic:",
        }, function(choice)
                if choice then
                        local index = tonumber(choice:match("^(%d+):"))
                        if index and diagnostics[index] then
                                local d = diagnostics[index]
                                vim.api.nvim_win_set_cursor(0, { d.lnum + 1, d.col })
                                vim.cmd("normal! zz") -- center cursor
                        end
                end
        end)
end

-- User command
vim.api.nvim_create_user_command("DiagnosticsJump", jump_diagnostic, {})

-- Keymap for <leader>d
-- vim.keymap.set("n", "<leader>d", jump_diagnostic, {
--         desc = "Jump to diagnostic",
--         noremap = true,
--         silent = true
-- })
