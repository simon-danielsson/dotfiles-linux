local M = {}

function M.grep_current_and_parent()
        vim.ui.input({ prompt = "Grep > " }, function(input)
                if not input or input == "" then
                        return
                end

                -- escape input for shell safety
                local pattern = vim.fn.shellescape(input)

                -- run ripgrep on current dir and parent dir
                local cmd = table.concat({
                        "rg",
                        "--vimgrep",
                        "--ignore-case",
                        pattern,
                        ".", ".."
                }, " ")

                -- populate quickfix list
                vim.fn.setqflist({}, " ", {
                        title = "Grep: " .. input,
                        lines = vim.fn.systemlist(cmd),
                })

                -- Open quickfix window if results exist
                if #vim.fn.getqflist() > 0 then
                        vim.cmd("copen")
                        vim.cmd("cc") -- jump to first result
                else
                        vim.notify("No matches found", vim.log.levels.INFO)
                end
        end)
end

return M
