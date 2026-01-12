return {
  {
    "toggleterm.nvim",
    for_cat = 'general.extra',
    after = function()
      require("toggleterm").setup({
        start_in_insert = false,
      })

      local function open_and_focus_term(term_num, opts)
        local Terminal = require("toggleterm.terminal").Terminal
        local term = Terminal:new(vim.tbl_extend("force", {count = term_num}, opts or {}))
        if not term:is_open() then
          term:open()
        else
          term:focus()
        end
        vim.schedule(function() end)
      end

      local function close_term(term_num)
        local Terminal = require("toggleterm.terminal").Terminal
        local term = Terminal:new({count = term_num})
        if term:is_open() then
          term:close()
        end
      end

      vim.keymap.set('n', '<leader>ta', ':ToggleTermToggleAll<CR>', { desc = '[T]erm Toggle [A]ll' })
      vim.keymap.set('n', '<leader>ts', ':TermSelect<CR>', { desc = '[T]erm [S]elect' })
      vim.keymap.set('n', '<leader>tm', ':Telescope toggleterm_manager<CR>', { desc = '[T]erm [S]elect' })
      vim.keymap.set('n', '<leader>tn', ':ToggleTermSetName<CR>', { desc = '[T]erm [R]ename' })

      vim.keymap.set('n', '<leader>t1', function()
        open_and_focus_term(1, {direction="horizontal", size=10, name="termbottom1"})
      end, { desc = '[T]erm [1] (bottom)' })

      vim.keymap.set('n', '<leader>t2', function()
        open_and_focus_term(1, {direction="horizontal", size=10, name="termbottom1"})
        open_and_focus_term(2, {direction="horizontal", size=10, name="termbottom2"})
      end, { desc = '[T]erm 1 and [2] (bottom)' })

      vim.keymap.set('n', '<leader>tf', function()
        open_and_focus_term(9, {direction="float", name="floatterm9"})
      end, { desc = '[T]erm [F]loat (9)' })

      vim.keymap.set('n', '<leader>tc1', function() close_term(1) end, { desc = '[T]erm [C]lose [1]' })
      vim.keymap.set('n', '<leader>tc2', function() close_term(2) end, { desc = '[T]erm [C]lose [2]' })
      vim.keymap.set('n', '<leader>tcf', function() close_term(9) end, { desc = '[T]erm [C]lose [F]loat (9)' })
      vim.keymap.set('n', '<leader>tcc', function()
        local term_id = vim.b.toggle_number or 1
        close_term(term_id)
      end, { desc = "[T]erm [C]lose [C]urrent" })

      _G.set_terminal_keymaps = function()
        vim.keymap.set('t', '<C-j><C-n>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })
        vim.keymap.set('t', '<C-j><C-h>', [[<C-\><C-n><C-w>h]], { desc = "Exit terminal mode and Move to left window" })
        vim.keymap.set('t', '<C-j><C-j>', [[<C-\><C-n><C-w>j]], { desc = "Exit terminal mode and Move to below window" })
        vim.keymap.set('t', '<C-j><C-k>', [[<C-\><C-n><C-w>k]], { desc = "Exit terminal mode and Move to above window" })
        vim.keymap.set('t', '<C-j><C-l>', [[<C-\><C-n><C-w>l]], { desc = "Exit terminal mode and Move to right window" })
        vim.keymap.set('t', '<C-j><C-c>', function()
          local term_id = vim.b.toggle_number or 1
          close_term(term_id)
        end, { desc = "Close current terminal" })
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()
        end,
      })
    end,
  },
}
