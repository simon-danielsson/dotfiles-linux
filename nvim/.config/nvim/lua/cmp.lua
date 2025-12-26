
local M = {}

function M.setup()
        ---------------------------------------------------------------------------
        -- Insert-mode completion behavior
        ---------------------------------------------------------------------------
        vim.opt.completeopt = { "menuone", "noselect" }
        vim.opt.shortmess:append("c")

        ---------------------------------------------------------------------------
        -- Command-line completion (:) (/ ?) enhancements
        ---------------------------------------------------------------------------
        vim.opt.wildmenu = true
        vim.opt.wildmode = "longest:full,full"
        vim.opt.wildignorecase = true

        ---------------------------------------------------------------------------
        -- Make <Tab> cycle the popup menu when visible
        ---------------------------------------------------------------------------
        vim.keymap.set("i", "<Tab>", function()
                if vim.fn.pumvisible() == 1 then
                        return "<C-n>"
                end
                return "<Tab>"
        end, { expr = true, silent = true })

        vim.keymap.set("i", "<S-Tab>", function()
                if vim.fn.pumvisible() == 1 then
                        return "<C-p>"
                end
                return "<S-Tab>"
        end, { expr = true, silent = true })

        ---------------------------------------------------------------------------
        -- LSP integration (completion, hover, signature help)
        ---------------------------------------------------------------------------
        vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Enable native LSP features",
                callback = function(args)
                        local buf = args.buf

                        -- Completion (omnifunc)
                        vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                        local opts = { buffer = buf, silent = true }

                        -- Hover documentation
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

                        -- Signature help (manual, non-intrusive)
                        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

                        -- Optional: jump to definition / references (still native)
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                end,
        })
end

return M
