return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Verwenden Sie die neueste Hauptversion
    build = "make install_jsregexp", -- Optional: Installiert jsregexp für erweiterte Regex-Unterstützung
    dependencies = {
      "rafamadriz/friendly-snippets", -- Optionale Sammlung von Snippets
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load() -- Lädt VSCode-kompatible Snippets
    end,
  },
}
