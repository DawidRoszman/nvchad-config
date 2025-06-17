return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  keys = {
    accept_suggestion = "<Tab>",
    clear_suggestion = "<C-]>",
    accept_word = "<C-j>",
  },
  config = function()
    require("supermaven-nvim").setup({
      condition = function()
        return string.match(vim.fn.expand("%:p"), "work")
      end,
    })
  end,
}
