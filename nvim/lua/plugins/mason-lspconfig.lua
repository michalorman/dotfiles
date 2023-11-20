return {
	"williamboman/mason-lspconfig.nvim",

	dependencies = {
		"williamboman/mason.nvim",
	},

	opts = {
		ensure_installed = {
			"astro",
			"cssls",
			"dockerls",
			"docker_compose_language_service",
			"html",
			"jsonls",
			"tsserver",
			"lua_ls",
			"marksman",
			"volar",
			"yamlls",
		},
	},
}
