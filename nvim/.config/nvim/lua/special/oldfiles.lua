-- Function to open old files with menu + substring search
local function open_old_file()
        local oldfiles = vim.v.oldfiles
        if #oldfiles == 0 then
                print("No recent files found")
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

        -- Ask user: press Enter for menu, or type a substring
        local input = vim.fn.input("Recent files search (Enter/Esc: menu): ")
        input = vim.trim(input)

        if input == "" then
                -- Show menu
                vim.ui.select(oldfiles, {
                        prompt = "Select old file:",
                        format_item = function(item)
                                return shorten_path(item, 3)
                        end
                }, function(choice)
                        if choice then
                                vim.cmd("edit " .. vim.fn.fnameescape(choice))
                        end
                end)
        else
                -- Search by substring (case-insensitive)
                local match
                for _, file in ipairs(oldfiles) do
                        if string.match(string.lower(file), string.lower(input)) then
                                match = file
                                break
                        end
                end
                if match then
                        vim.cmd("edit " .. vim.fn.fnameescape(match))
                else
                        print("No matching oldfile found")
                end
        end
end

-- User command
vim.api.nvim_create_user_command("Old", open_old_file, {})

-- Keymap for <leader>r
vim.keymap.set("n", "<leader>r", open_old_file, {
        desc = "Launch oldfiles (menu or search)",
        noremap = true,
        silent = true
})
