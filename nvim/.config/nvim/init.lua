-- ==== imports: ui ====

require('ui.colorscheme')
require('ui.theme')
local colors = require("ui.colorscheme")
colors.colorscheme(2) -- 1: lo cont 2: hi cont
colors.background_transparency(true)
require('ui.statusline')

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
require('special.notify')
require("special.pairs").setup()
-- require('special.hoverwindoc').setup()

-- ==== imports: plugins ====

require('plugins.lsp')
require('plugins.flash')
require('plugins.render-markdown')
require('plugins.treesitter')
