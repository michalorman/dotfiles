local present, tsconfig = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

tsconfig.setup({
  ensure_installed = "all",

  highlight = {
    enable = true,
    -- use_languagetree = true,
    -- additional_vim_regex_highlighting = true,
  }
})
