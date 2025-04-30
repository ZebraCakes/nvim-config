local commandt = require('wincent.commandt').setup({
    height = 50,
})

vim.keymap.set('n', '<leader>ct', ':CommandT<CR>', {})
vim.keymap.set('n', '<leader>cb', ':CommandTBuffer<CR>', {})
vim.keymap.set('n', '<leader>cf', ':CommandTFind<CR>', {})
vim.keymap.set('n', '<leader>cg', ':CommandTGit<CR>', {})
vim.keymap.set('n', '<leader>ch', ':CommandTHelp<CR>', {})
vim.keymap.set('n', '<leader>cr', ':CommandTRipgrep<CR>', {})
vim.keymap.set('n', '<leader>cw', ':CommandTWatchman<CR>', {})
