local map = vim.keymap.set

-- ==== leader ====

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ==== hjkl remappings ====

map("n", "i", "<Nop>")
map("n", "I", "<Nop>")
map("n", "o", "<Nop>")
map("n", "O", "<Nop>")

map({ "n", "v" }, "n", "h",
        { desc = "Move left" })

map({ "n", "v" }, "i", "l",
        { desc = "Move right" })

map({ 'n', 'v' }, 'o', "v:count == 0 ? 'gk' : 'k'",
        {
                expr = true,
                silent = true,
                desc = "Move up (through wrapped lines)"
        })

map({ 'n', 'v' }, 'e', "v:count == 0 ? 'gj' : 'j'",
        {
                expr = true,
                silent = true,
                desc = "Move down (through wrapped lines)"
        })

map("n", ">", "nzzzv",
        { desc = "Next search result (centered)" })

map("n", "<", "Nzzzv",
        { desc = "Previous search result (centered)" })

map("n", "}", "}zz",
        { desc = "Next empty line (centered)" })

map("n", "{", "{zz",
        { desc = "Previous empty line (centered)" })

map("n", "<C-e>", function()
        vim.diagnostic.goto_prev()
        vim.cmd("normal! zz")
end, { desc = "Go to previous diagnostic" })

map("n", "<C-o>", function()
        vim.diagnostic.goto_next()
        vim.cmd("normal! zz")
end, { desc = "Go to next diagnostic" })

-- general nav

map("n", "<leader>f", "<cmd>Ex<CR>",
        {
                desc = "Launch netrw",
                noremap = true,
                silent = true
        })

map("n", "-", function()
        vim.cmd("wincmd w")
end, { desc = "Cycle through splits" })

map("n", "_", function()
        local bufs = vim.api.nvim_list_bufs()
        local open_bufs = {}
        for _, bufnr in ipairs(bufs) do
                if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buflisted") then
                        table.insert(open_bufs, bufnr)
                end
        end
        if #open_bufs == 0 then return end
        local current = vim.api.nvim_get_current_buf()
        local idx = nil
        for i, bufnr in ipairs(open_bufs) do
                if bufnr == current then
                        idx = i
                        break
                end
        end
        local next_idx = (idx % #open_bufs) + 1
        vim.api.nvim_set_current_buf(open_bufs[next_idx])
end, { desc = "Cycle through open buffers" })

map('t', '<Esc><Esc>', '<C-\\><C-n>',
        { desc = 'Exit terminal mode' })

map("n", "<Esc>", "<cmd>nohlsearch<CR>",
        { desc = "Clear search highlights" })

-- folds
map('n', 'za', 'za',
        { desc = "Toggle fold under cursor" })

map('n', 'zo', 'zR',
        { desc = "Open all folds" })

map('n', 'zc', 'zM',
        { desc = "Close all folds" })

-- New insert mode bindings
map("n", "<leader>i", "i", { desc = "Insert before cursor" })
map("n", "<leader>I", "I", { desc = "Insert at line start" })
map("n", "<leader>o", "o", { desc = "Open new line below" })
map("n", "<leader>O", "O", { desc = "Open new line above" })

map("i", "<Tab>", "<Nop>")
map("i", "<S-Tab>", "<Nop>")
map({ "v", "i" }, "<Tab>", ">gv", { desc = "Indent selection" })
map({ "v", "i" }, "<S-Tab>", "<gv", { desc = "Outdent selection" })
map("n", "<Tab>", ">>", { desc = "Indent line" })
map("n", "<S-Tab>", "<<", { desc = "Outdent line" })
map("i", "<Tab>", "<C-t>", { desc = "Indent line in insert mode" })
map("i", "<S-Tab>", "<C-d>", { desc = "Outdent line in insert mode" })

map("n", "-", function()
        vim.cmd("wincmd w")
end, { desc = "Cycle through splits" })

map('n', '<Left>', '<cmd>vertical resize +4<cr>',
        { desc = 'Increase Window Width' })

map('n', '<Right>', '<cmd>vertical resize -4<cr>',
        { desc = 'Decrease Window Width' })
map('n', 'x', '"_x',
        { desc = "Delete single character without yanking to register" })

map("n", "<leader><CR>", "i<CR><Esc>",
        { desc = "Insert newline at cursor in normal mode" })

map("n", "<leader><BS>", "i<BS><Esc>",
        { desc = "Insert backspace at cursor in normal mode" })

map("n", "<leader><leader>", "i<Space><Esc>",
        { desc = "Insert space at cursor in normal mode" })

-- editing

map("n", "<leader>,", [[:%s/<C-r><C-w>//gI<Left><Left><Left>]],
        { desc = "open %s//gI with cword" })
-- Move selected lines up/down in visual mode using Shift and navigation keys
map("v", "<S-e>", ":m '>+2<CR>gv=gv", { desc = "Move selection down" })
map("v", "<S-o>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- LSP
map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
map("n", "<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, opts)

map("n", "å", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, { desc = "Toggle Inlay Hints" })
