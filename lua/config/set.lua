local cmd = vim.cmd
local opt = vim.opt
local indent = 4

opt.backspace = { "eol", "start", "indent" } -- allow backspacing over everything in insert mode
opt.clipboard = "unnamedplus"                -- allow neovim to access the system clipboard

-- indention
opt.autoindent = true    -- auto indentation
opt.expandtab = true     -- convert tabs to spaces
opt.shiftwidth = indent  -- the number of spaces inserted for each indentation
opt.smartindent = true   -- make indenting smarter
opt.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
opt.tabstop = indent     -- insert 2 spaces for a tab
opt.shiftround = true    -- use multiple of shiftwidth when indenting with "<" and ">"

-- search
opt.hlsearch = true   -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true  -- smart case
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true   -- make tab completion for files/buffers act like bash

-- ui
opt.cursorline = true -- highlight the current line
opt.laststatus = 2    -- only the last window will always have a status line
opt.lazyredraw = true -- don"t update the display while executing macros
opt.list = true
-- You can also add "space" or "eol", but I feel it"s quite annoying
opt.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×"
}

-- Hide cmd line
opt.cmdheight = 0      -- more space in the neovim command line for displaying messages

opt.number = true      -- set numbered lines
opt.scrolloff = 18     -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 3  -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.splitbelow = true  -- open new split below
opt.splitright = true  -- open new split to the right
opt.wrap = true        -- display a wrapped line
opt.guicursor = ""
opt.relativenumber = true --relative line numbers
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.updatetime = 50
opt.showmode = false

-- backups
opt.backup = false      -- create a backup file
opt.swapfile = false    -- creates a swapfile
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- theme
opt.termguicolors = true --enable 24-bit RGB
