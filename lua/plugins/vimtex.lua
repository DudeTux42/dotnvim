return {
  "lervag/vimtex",
  lazy = false,
  config = function()
    -- Grundkonfiguration
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_compiler_method = "latexmk"
    
    -- Linux-Konfiguration
    vim.g.vimtex_compiler_latexmk = {
      build_dir = ".latexmk/output",
      aux_dir = ".latexmk/temp",
      options = {
        "-pdf",
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
      },
    }
    
    -- Sioyek für Linux
    vim.g.vimtex_view_sioyek_exe = "sioyek"
    vim.g.vimtex_view_sioyek_options = "--reuse-window"
    
    -- Automatische Verzeichniserstellung
    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventInitPost",
      callback = function()
        vim.fn.mkdir(".latexmk/temp", "p")
        vim.fn.mkdir(".latexmk/output", "p")
      end,
    })
    
    -- Keymap vereinfacht
    vim.keymap.set("n", "<leader>lv", function()
      local pdf_path = vim.fn.expand("%:p:h") .. "/.latexmk/output/" .. vim.fn.expand("%:t:r") .. ".pdf"
      if vim.fn.filereadable(pdf_path) == 1 then
        vim.cmd("VimtexView")
      else
        vim.notify("PDF existiert nicht: " .. pdf_path, vim.log.levels.ERROR)
      end
    end, { desc = "PDF öffnen" })
  end,
  
  keys = {
    { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "Kompilieren" },
  },
}
