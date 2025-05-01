--leader funcs
vim.g.mapleader = "\\"
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>xe", ":Rex<CR>")
--vim.keymap.set("n", "<leader>rz", ":source ~\\AppData\\Local\\nvim\\init.lua<CR>")
--navigation
vim.keymap.set("n", "<C-S-Left>", "<C-o>")
vim.keymap.set("n", "<C-S-Right>", "<C-i>")
vim.keymap.set("n", "s", "n")
vim.keymap.set("n", "<S-s>", "<S-n>")
vim.keymap.set({"n", "v"}, "n", "h")
vim.keymap.set({"n", "v"}, "<S-n>", "<S-Left>")
vim.keymap.set({"n", "v"}, "<C-n>", "^")
vim.keymap.set({"n", "v"}, "e", "<Down>")
vim.keymap.set({"n", "v"}, "<S-e>", "<S-}>")
vim.keymap.set({"n", "v"}, "o", "<Right>")
vim.keymap.set({"n", "v"}, "<S-o>", "<S-Right>")
vim.keymap.set({"n", "v"}, "<C-o>", "$<Right>")
vim.keymap.set({"n", "v"}, "u", "<Up>")
vim.keymap.set({"n", "v"}, "<S-u>", "<S-{>")

-- move between windows
vim.keymap.set({"n"}, "<C-Up>", "<C-W>k")
vim.keymap.set({"n"}, "<C-Down>", "<C-W>j")
vim.keymap.set({"n"}, "<C-Left>", "<C-W>h")
vim.keymap.set({"n"}, "<C-Right>", "<C-W>l")
vim.keymap.set({"n", "v"}, ",", "<C-W><C-W>")

--editing
vim.keymap.set("n", "j", "<undo>")
vim.keymap.set("n", "<S-Del>", "dw")

vim.keymap.set("n", "<S-BS>", "db")
vim.keymap.set("n", "<C-BS>", "d^")
vim.keymap.set("n", "<A-BS>", "dw")

vim.keymap.set("n", "<A-e>", ":m .+1<CR>==")
vim.keymap.set("i", "<A-e>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("v", "<A-e>", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<A-u>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-u>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-u>", ":m '<-2<CR>gv=gv")

-- Buffer Management
vim.keymap.set("n", "<C-K>", ":BD<CR>")
vim.keymap.set("n", "<A-Left>", ":BB<CR>")
vim.keymap.set("n", "<A-Right>", ":BF<CR>")

-- Function Keys
vim.keymap.set("n", "<F2>", ":ToggleBufExplorer<CR>")
vim.keymap.set("n", "<F4>", vim.cmd.close)
vim.keymap.set("n", "<F5>", ":e ~/.config/nvim/init.lua<CR>")
-- vim.keymap.set("n", "<F7>", ":wa<CR>:copen<CR>:AsyncRun build -alin64 main sds2-ui api2 convert pydiodb<CR>")
vim.keymap.set("n", "<F7>", ":wa<CR>:copen<CR>:AsyncRun build all<CR>")
vim.keymap.set("n", "<F8>", ":wa<CR>:copen<CR>:AsyncRun build -arel -awin64 api2 binzip-64<CR>")
vim.keymap.set("n", "<F12>", ":copen<CR>:AsyncRun build -A clean api2clean<CR>")

-- Notes
vim.keymap.set("n", "<A-t>", "i// TODO(apeterson): ")
vim.keymap.set("n", "<A-n>", "i// NOTE(apeterson): ")
vim.keymap.set("n", "<A-i>", "i// IMPORTANT(apeterson): ")
vim.keymap.set("i", "<A-t>", "// TODO(apeterson): ")
vim.keymap.set("i", "<A-n>", "// NOTE(apeterson): ")
vim.keymap.set("i", "<A-i>", "// IMPORTANT(apeterson): ")

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
