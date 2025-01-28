-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lazyvim").setup({
  spec = {
    -- Import all plugin files from the lua/plugins/ directory
    { import = "plugins" },
  },
})


-- Set a transparent background color
vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
vim.cmd([[ hi NonText guibg=NONE ctermbg=NONE ]])

-- Set colors for Neotree
vim.cmd([[ hi NeoTreeNormal guibg=NONE ctermbg=NONE ]])    -- Set the background for the main Neotree window
vim.cmd([[ hi NeoTreeNormalNC guibg=NONE ctermbg=NONE ]]) -- Set the background for non-focused Neotree windows

--set colors for WichKey
vim.cmd([[ hi WhichKeyFloat guibg=NONE ctermbg=NONE ]]) -- Set the background for WhichKey popup

--set colors for non focused panes
vim.cmd([[ hi NormalNC guibg=NONE ctermbg=NONE ]]) -- Background for non-focused windows
vim.cmd([[ hi TabLine guibg=NONE ctermbg=NONE ]])   -- Background for tab line
vim.cmd([[ hi TabLineSel guibg=NONE ctermbg=NONE ]]) -- Background for selected tab line


vim.env.HTTP_PROXY = "192.168.123.95:3128"
vim.env.HTTPS_PROXY = "192.168.123.95:3128"
vim.g.vimtex_compiler_progname = "nvim"  -- Wichtig: Erzwinge Neovim-Erkennung
vim.g.vimtex_view_method = "general"
