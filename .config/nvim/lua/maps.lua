local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- increment/decrement
keymap.set('n', '+', '<c-a>')
keymap.set('n', '-', '<c-x>')

-- select all
keymap.set('n', '<c-a>', 'gg<s-v>g')

-- save with root permission (not working for now)
--vim.api.nvim_create_user_command('w', 'w !sudo tee > /dev/null %', {})

-- new tab
keymap.set('n', 'te', ':tabedit<return>')
keymap.set('n', 'sf', ':Telescope file_browser<return>')
-- split window
keymap.set('n', 'ss', ':split<return><c-w>w')
keymap.set('n', 'sv', ':vsplit<return><c-w>w')
keymap.set('n', 'ff', ':Emmet ')
-- move window
keymap.set('n', '<space>', '<c-w>w')
keymap.set('', 'sh', '<c-w>h')
keymap.set('', 'sk', '<c-w>k')
keymap.set('', 'sj', '<c-w>j')
keymap.set('', 'sl', '<C-w>l')

-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
