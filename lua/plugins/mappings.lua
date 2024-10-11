local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" });

map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })



vim.keymap.set('n', 'ö', function()
  -- Append comma at the end of the current line
  vim.api.nvim_command('normal! A,')
  -- Move to a new line below and enter insert mode
  vim.api.nvim_feedkeys('o', 'n', true)
end, { desc = "Append comma and move to new line in insert mode" })




vim.keymap.set('n', 'Ö', function()
  -- Append semicolon at the end of the current line
  vim.api.nvim_command('normal! A;')
  -- Move to a new line below and enter insert mode
  vim.api.nvim_feedkeys('o', 'n', true)
end, { desc = "Append semicolon and move to new line in insert mode" })


-- TODO implement the use off map in all bindings
-- Var fo crating mapping for simpler use
local map = vim.keymap.set

local lazyterm = function(command)
    -- Open a floating terminal and run the command in the specified directory
    LazyVim.terminal() -- Open the terminal first
    vim.cmd("startinsert") -- Enter insert mode in the terminal
    vim.fn.chansend(vim.b.terminal_job_id, command .. "\r") -- Send the command to the terminal
end

map("n", "äc", function()
    vim.cmd('write') -- Save the current file

    local current_file = vim.fn.expand('%:p') -- Get the current file path
    local file_extension = vim.fn.fnamemodify(current_file, ':e') -- Get the file extension

    if file_extension == 'rs' then
        lazyterm('cargo run')

    elseif file_extension == 'c' then
        local file_name = vim.fn.fnamemodify(current_file, ':t:r') -- Get the file name without extension
        lazyterm('gcc ' .. current_file .. ' -o ' .. file_name .. ' && .\\' .. file_name) -- Compile and run

    elseif file_extension == 'py' then
        lazyterm('python ' .. current_file) -- Execute Python program

    elseif file_extension == 'js' then
        lazyterm('node ' .. current_file) -- Execute JavaScript program

    else
        print("Unrecognized file type: " .. file_extension)
    end
end, { desc = 'Save and run in LazyVim floating terminal based on file type' })
--
--     local current_file = vim.fn.expand('%:p') -- Aktuellen Dateipfad abrufen
--     local file_extension = vim.fn.fnamemodify(current_file, ':e') -- Dateiendung abrufen
--
--     if file_extension == 'rs' then
--         vim.cmd('split term://cargo run')
--
--     elseif file_extension == 'c' then
--         local file_name = vim.fn.fnamemodify(current_file, ':t:r') -- Dateinamen ohne Endung abrufen
--         vim.cmd('split term://gcc ' .. current_file .. ' -o ' .. file_name .. ' && ./' .. file_name) -- Kompilieren und ausführen
--
--     elseif file_extension == 'py' then
--         vim.cmd('split term://python ' .. current_file) -- Python-Programm ausführen
--
--     elseif file_extension == "js" then
--         vim.cmd('split term://node ' .. current_file)
--
--     else
--         print("Unrecognized file type: " .. file_extension)
--     end
-- end, { desc = 'Save and run in current directory based on file type' })
-- Save file
vim.api.nvim_set_keymap('n', '<leader>ä', ':w<CR>', { noremap = true, silent = true })
--Append . to end of line and start insert
vim.api.nvim_set_keymap('n', '<leader>.', '<Esc>A.', { noremap = true, silent = true })
--Append , to en of line and start insert
vim.api.nvim_set_keymap('n', '<leader>,', '<Esc>A,', { noremap = true, silent = true })

return {}
