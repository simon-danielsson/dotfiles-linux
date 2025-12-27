-- get rid of lazy source not supported error

vim.notify = function(msg, log_level, opts)
        if msg:match("supported") then
                return
        end
        vim.api.nvim_echo({ { msg } }, false, {})
end

-- load modules
require('options')
require('keymaps')
require('config.lazy')
require('lazy').setup('plugins')
require('autocmds')
require('indenting')
require('oldfiles')
require('buffers')
require('diagnostics')
-- require('hoverwindoc').setup()
require("pairs").setup()

-- colors, theme and statusline

require('colorscheme')
require('theme')

local colors = require("colorscheme")
colors.colorscheme(2) -- 1: lo cont 2: hi cont
colors.background_transparency(true)

require('statusline')

-- tmux

if os.getenv("TMUX") then
        vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
                callback = function()
                        local name = vim.fn.expand("%:t")
                        if name == "" then name = "[No Name]" end
                        vim.fn.system({ "tmux", "rename-window", name })
                end,
                desc = "Rename TMUX windows dynamically",
        })
end
