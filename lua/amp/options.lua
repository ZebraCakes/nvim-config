-- miscellaneous
vim.opt.scrolloff = 5
vim.opt.path = vim.opt.path + "**"
vim.opt.ve = vim.opt.ve + "onemore"

vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

vim.opt.updatetime = 1000
vim.opt.sessionoptions = "buffers"
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"

-- long running undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- tabs vs space crap
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- visual stuff
vim.opt.wrap = false
vim.opt.number = true
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-- search
-- ignore case in searches...
vim.opt.ignorecase = true
-- ...unless
vim.opt.smartcase = true
vim.opt.incsearch = true -- e.g. term* = 

-- font stuff
vim.opt.guifont = "Source Code Pro Semibold:h14"
-- allow switching from unsaved buffer
vim.opt.hidden = true
-- ask before nuking an unsaved buffer
vim.opt.confirm = true


vim.opt.mouse = ""

vim.diagnostic.config({
    virtual_lines = { current_line = true }
})
