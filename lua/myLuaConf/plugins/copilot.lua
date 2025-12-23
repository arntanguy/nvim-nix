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
    {
      "codecompanion.nvim",
      on_plugin = "copilot.lua",
      for_cat = "ai",
      event = "InsertEnter",
     
      dep = {
        "copilot.lua", "plenary.nvim", "dressing.nvim", 
        "mini.diff",
      },

      keys = {
        { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "[A]I [A]ctions" },
        { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "[A]I [C]hat Toggle" },
        { "<leader>ae", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "[A]I Chat [E]xplain Selection" },
        { "<leader>an", "<cmd>CodeCompanionChat<cr>", mode = "n", desc = "[A]I [N]ew Chat" },
        { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "[A]I [I]nline Assistant" },
        { "<leader>aq", "<cmd>CodeCompanionCmd<cr>", mode = "n", desc = "[A]I [Q]uick Command" },
      },

      after = function(name)
        -- CodeCompanion usually requires a scheduled setup to register its 
        -- internal sub-modules correctly without "textlock" errors.
        vim.schedule(function()
          require("codecompanion").setup({
            interactions = {
              chat = { adapter = "copilot" },
              inline = { adapter = "copilot" },
              agent = { adapter = "copilot" },
            },
            adapters = {
              http = {
                opts = { show_defaults = false },
                copilot = function()
                  return require("codecompanion.adapters").extend("copilot", {})
                end,
              },
            },
            chat = {
              window = {
                layout = "vertical",
                position = "right", -- add this line
              }
            },
            display = {
              action_palette = { width = 95, height = 10 },
              chat = { window = { layout = "vertical" } },
              diff = {
                enabled = true,
                layout = "vertical",
                opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                provider = "default",
              },
            },
          })

          -- Setup WhichKey group
          local status_wk, wk = pcall(require, "which-key")
          if status_wk then
            wk.add({ { "<leader>a", group = "[A]I Assistant", icon = "🤖" } })
          end
        end)
      end,
    }
}
