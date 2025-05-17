return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local tree = require("nvim-tree")

		tree.setup()

		local api = require("nvim-tree.api")

		vim.keymap.set("n", "<C-n>", function()
			api.tree.toggle({
				find_file = true,
			})
		end)
	end,
}
