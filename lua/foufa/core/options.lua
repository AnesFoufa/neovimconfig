local opt = vim.opt -- for conciseness

opt.number = true

--tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- add one level after language block starters like `{`

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if I include mixed case in search, assumes case senstive

-- cursor line
opt.cursorline = true -- hightlight the current cursor line

-- backspace
opt.backspace = "indent,eol,start"

-- spellchecking
opt.spelllang = "en_us"
opt.spell = true
