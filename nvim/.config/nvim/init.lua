-- ==== ignore errors ====

vim.notify = function(msg, log_level, opts)
        if msg:match("supported") then
                return
        end
        vim.api.nvim_echo({ { msg } }, false, {})
end

-- ==== imports: general ====

require('general.options')
require('general.keymaps')
require('general.autocmds')
require('general.indenting')
require('general.cmp')

-- ==== imports: special ====

require('special.oldfiles')
require('special.buffers')
require('special.diagnostics')
require("special.pairs").setup()

-- ==== imports: third-party ====

require('config.lazy')
require('lazy').setup('plugins')

-- ==== imports: ui ====

require('ui.hoverwindoc').setup()
require('ui.colorscheme')
require('ui.theme')
local colors = require("ui.colorscheme")
colors.colorscheme(2) -- 1: lo cont 2: hi cont
colors.background_transparency(true)
require('ui.statusline')
