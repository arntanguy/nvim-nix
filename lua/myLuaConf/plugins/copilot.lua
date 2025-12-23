return {
  {
    "copilot.lua", -- The plugin directory name in the nix store
    for_cat = "ai",
     -- This tells lze to run 'packadd copilot-lua' when require('copilot') is called
    on_require = { "copilot" },
    -- Load on InsertEnter or when the :Copilot command is run
    event = "InsertEnter",
    cmd = "Copilot",
    
    -- This replaces the "config" block in Lazy.nvim
    after = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          ["*"] = true,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          help = false,
          yaml = true,
          yml = true,
          markdown = true,
          json = true,
          jsonc = true,
          lua = true,
          python = true,
          javascript = true,
          typescript = true,
          go = true,
          rust = true,
          c = true,
          cpp = true,
          ["."] = false,
          ["dap-repl"] = false,
          ["dapui_watches"] = false,
          ["dapui_stacks"] = false,
          ["dapui_breakpoints"] = false,
          ["dapui_scopes"] = false,
          ["dapui_console"] = false,
          ["TelescopePrompt"] = false,
          ["codecompanion"] = false,
          ["oil"] = false,
          ["neo-tree"] = false,
        },
      })
    end,
  },
}
