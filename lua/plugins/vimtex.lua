return {
  "lervag/vimtex",
  lazy = false,
  config = function()
    -- Grundkonfiguration
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_compiler_method = "latexmk"

    -- Windows-spezifische Pfadkonfiguration
    vim.g.vimtex_compiler_latexmk = {
      executable = "latexmk.exe",
      build_dir = ".latexmk/output",
      aux_dir = ".latexmk/temp",
      options = {
        "-pdf",
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-outdir=.latexmk/output",
        "-auxdir=.latexmk/temp",
      },
    }

    -- Sioyek mit Windows-spezifischen Einstellungen
    vim.g.vimtex_view_sioyek = {
      viewer = [[C:\Users\llindermayr.ABBW\scoop\shims\sioyek.exe]],
      options = "--reuse-window",
      pdf_file = [[%:p:h/.latexmk/output/%:t:r.pdf]], -- Dynamischer Pfad
      forward_search_style = "cursor",
      sync_timeout = 300,
      -- Windows-spezifische Pfadkonvertierung
      pdf_compiler = function(file)
        return file:gsub("/", "\\") -- Unix zu Windows-Pfad
      end,
    }

    -- Automatische Verzeichniserstellung
    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventInitPost",
      callback = function()
        vim.fn.mkdir(".latexmk/temp", "p")
        vim.fn.mkdir(".latexmk/output", "p")
      end,
    })

    -- Keymap mit erweitertem Error-Handling
    vim.keymap.set("n", "<leader>lv", function()
      local pdf_path = vim.fn.expand("%:p:h") .. "/.latexmk/output/" .. vim.fn.expand("%:t:r") .. ".pdf"
      pdf_path = pdf_path:gsub("/", "\\") -- Pfad für Windows konvertieren

      if vim.fn.filereadable(pdf_path) == 1 then
        -- Dateiberechtigungen prüfen
        vim.cmd([[!powershell -Command "Unblock-File -Path ]] .. pdf_path .. [["]])
        vim.cmd("VimtexView")
      else
        vim.notify("PDF existiert nicht:\n" .. pdf_path, vim.log.levels.ERROR)
      end
    end, { desc = "PDF öffnen" })
  end,
  keys = {
    { "<leader>ll", "<cmd>VimtexCompile<cr>", desc = "Kompilieren" },
  },
}
