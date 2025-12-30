vim.keymap.set("n", "<leader>d", function()
        local diagnostics = vim.diagnostic.get(0) -- 0 = current buffer

        local qflist = {}
        for _, d in ipairs(diagnostics) do
                table.insert(qflist, {
                        bufnr = vim.api.nvim_get_current_buf(),
                        lnum = d.lnum + 1,                  -- quickfix is 1-based
                        col = d.col + 1,                    -- quickfix is 1-based
                        text = d.message,
                        type = vim.diagnostic.severity[d.severity]:sub(1, 1), -- E/W/I/H
                })
        end

        vim.fn.setqflist(qflist, "r")
        vim.cmd("copen")
end, { desc = "Send buffer diagnostics to quickfix" })
