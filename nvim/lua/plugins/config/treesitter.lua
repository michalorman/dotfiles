local present, tsconfig = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

tsconfig.setup({
  ensure_installed = {
    'lua', 'vim', 'javascript', 'rust', 'ruby', 'typescript', 'css', 'html', 'scss', 'vue'
  },

  highlight = {
    enable = true,
    use_languagetree = true
  }
})
