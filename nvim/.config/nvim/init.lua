-- ==== interface ====

require('ui.colorscheme')
require('ui.theme')
local colors = require("ui.colorscheme")
-- 1: retrobox (opaque) 2: wildcharm (trans.)
colors.colorscheme(2)
require('ui.statusline')

-- ==== general ====

require('general.options')
require('general.keymaps')
require('general.autocmds')
require('general.indenting')
-- require('general.cmp')

-- ==== special ====

require('special.oldfiles')
require('special.buffers')
-- require('special.diagnostics')
require('special.diagn_quickfix')
require('special.notify')
require("special.pairs").setup()
require('special.hoverwindoc').setup()

-- ==== plugins ====

require('plugins.lsp')
require('plugins.flash')
require('plugins.render-markdown')
require('plugins.treesitter')
require('plugins.cmp')
