-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
return {
  {
    "nvim-treesitter",
    for_cat = 'general.treesitter',
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    load = function (name)
        vim.cmd.packadd(name)
        vim.cmd.packadd("nvim-treesitter-textobjects")
    end,
  },
}
