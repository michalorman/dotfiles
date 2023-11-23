return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"sindrets/diffview.nvim",
		"ibhagwan/fzf-lua",
	},

	config = function()
		local neogit = require("neogit")

		neogit.setup()

		vim.keymap.set("n", "<leader>c", neogit.open)
		vim.keymap.set("n", "<leader>cc", function()
			neogit.open({ "commit" })
		end)
	end,
}
