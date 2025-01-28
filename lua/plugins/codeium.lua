return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = "InsertEnter", -- Load on entering Insert mode
  config = function()
    require("codeium").setup()
  end,



}



