local present, tokyonight = pcall(require, 'tokyonight')

if not present then
  return
end

tokyonight.setup({
  style = "night"
})
