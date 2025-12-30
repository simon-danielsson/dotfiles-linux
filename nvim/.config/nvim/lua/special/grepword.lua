local M = {}

local function get_visual_selection()
        local mode = vim.fn.mode()
        if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
                return nil
        end

        local start_pos             = vim.fn.getpos("'<")
        local end_pos               = vim.fn.getpos("'>")

        local start_line, start_col = start_pos[2], start_pos[3]
        local end_line, end_col     = end_pos[2], end_pos[3]

        local lines                 = vim.fn.getline(start_line, end_line)
        if #lines == 0 then
                return nil
        end

        lines[1] = string.sub(lines[1], start_col)
        lines[#lines] = string.sub(lines[#lines], 1, end_col)

        local text = table.concat(lines, " ")
        text = text:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")

        return text ~= "" and text or nil
end

function M.grep_current_and_parent()
        local visual_text = get_visual_selection()

        local function run_grep(input, whole_word)
                if not input or input == "" then
                        return
                end

                local pattern = vim.fn.shellescape(input)

                local cmd = {
                        "rg",
                        "--vimgrep",
                        "--ignore-case",
                }

                if whole_word then
                        table.insert(cmd, "--word-regexp")
                end

                table.insert(cmd, pattern)
                table.insert(cmd, ".")
                table.insert(cmd, "..")

                local results = vim.fn.systemlist(table.concat(cmd, " "))

                vim.fn.setqflist({}, " ", {
                        title = "Grep: " .. input,
                        lines = results,
                })

                if #results > 0 then
                        vim.cmd("copen")
                        vim.cmd("cc")
                else
                        vim.notify("No matches found", vim.log.levels.INFO)
                end
        end

        -- If visual selection exists, grep immediately (whole word)
        if visual_text then
                run_grep(visual_text, true)
                return
        end

        -- Otherwise prompt
        vim.ui.input({ prompt = "Grep > " }, function(input)
                run_grep(input, false)
        end)
end

return M
