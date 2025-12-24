local g            = vim.g
local cmd          = vim.api.nvim_create_autocmd
local wo           = vim.wo
local opt          = vim.opt
local o            = vim.o

-- line numbers

opt.number         = true
opt.relativenumber = true

-- wrapping & linebreaks

opt.wrap           = true
opt.linebreak      = true
o.breakindent      = true
opt.showbreak      = '~~'
opt.scrolloff      = 999
opt.virtualedit    = "onemore"
opt.sidescrolloff  = 6
o.smoothscroll     = true

-- clipboard

opt.clipboard      = 'unnamedplus'

-- editing

opt.iskeyword:append({ "-", "_" })
opt.backspace     = "indent,eol,start"
opt.modifiable    = true
opt.completeopt   = { "noselect", "menu", "menuone", "preview" }
o.inccommand      = 'nosplit'

-- appearance

o.signcolumn      = 'yes:1'
opt.winborder     = "rounded"
opt.termguicolors = true
vim.o.encoding    = "utf-8"
opt.numberwidth   = 4
opt.showmatch     = true

-- cursor & statusline

o.mouse           = 'a'
opt.mouse         = "a"
opt.cursorline    = true
o.showmode        = false
opt.laststatus    = 3
vim.opt.cmdheight = 0

-- netrw

g.netrw_liststyle = 1
g.netrw_banner    = 1
g.netrw_preview   = 1
cmd({ "FileType", "BufWinEnter" }, {
        pattern = "netrw",
        callback = function()
                local opts = { buffer = true, noremap = true, silent = true }
                local keymap = vim.keymap.set
                keymap("n", "n", "h", opts)
                keymap("n", "e", "j", opts)
                keymap("n", "o", "k", opts)
                keymap("n", "i", "l", opts)
                vim.wo.relativenumber = true
                vim.wo.number = true
        end,
})
-- search

opt.path:append("**")
opt.hlsearch    = true
opt.ignorecase  = true
opt.smartcase   = true
opt.incsearch   = true
opt.wildmenu    = true
opt.wildmode    = "longest:full,full"
opt.wildoptions = "pum,fuzzy"
opt.wildignore:append({ "*.o", "*.obj",
        "*.pyc", "*.class", "*.jar" })

-- file handling

opt.undodir              = vim.fn.expand("~/.vim/undodir")
opt.undofile             = true
opt.backup               = false
opt.writebackup          = false
opt.swapfile             = false
opt.updatetime           = 100
opt.timeoutlen           = 200
opt.ttimeoutlen          = 0
opt.autoread             = true
opt.autowrite            = false
opt.confirm              = false

-- performance

opt.redrawtime           = 10000
opt.maxmempattern        = 20000

g.loaded_gzip            = 1
g.loaded_tarPlugin       = 1
g.loaded_tutor           = 1
g.loaded_zipPlugin       = 1
g.loaded_2html_plugin    = 1
g.loaded_osc52           = 1
g.loaded_tohtml          = 1
g.loaded_getscript       = 1
g.loaded_getscriptPlugin = 1
g.loaded_logipat         = 1
g.loaded_tar             = 1
g.loaded_rrhelper        = 1
g.loaded_zip             = 1
g.loaded_synmenu         = 1
g.loaded_bugreport       = 1
g.loaded_vimball         = 1
g.loaded_vimballPlugin   = 1
