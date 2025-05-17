return {
	-- 'nvim-telescope/telescope.nvim', tag = '0.1.4',
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	-- or                              , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local telescope = require("telescope")

		telescope.setup()

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-p>", builtin.find_files)
		vim.keymap.set("n", "<leader>g", builtin.live_grep)
		vim.keymap.set("n", "ss", builtin.grep_string)
		vim.keymap.set("n", "fr", builtin.lsp_references)
		vim.keymap.set("n", "fi", builtin.lsp_implementations)
		vim.keymap.set("n", "fd", builtin.lsp_definitions)
		vim.keymap.set("n", "ft", builtin.lsp_type_definitions)
	end,
}
