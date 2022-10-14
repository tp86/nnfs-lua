local opt = vim.opt

opt.makeprg = './tasks'
opt.errorformat = [[lua: %f:%l: %m]]
vim.keymap.set('n', 'M', ':make run %<cr>', { noremap = true })
