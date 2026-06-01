local M = {}

local function configure(name, callback)
  local ok, err = pcall(callback)
  if not ok then
    vim.notify("Failed to configure " .. name .. ": " .. err, vim.log.levels.ERROR)
  end
end

function M.setup()
  vim.o.timeout = true
  vim.o.timeoutlen = 2000

  configure("tokyonight", function()
    require("tokyonight").setup({
      style = "night",
    })
  end)

  configure("which-key", function()
    require("which-key").setup({})
  end)

  configure("nvim-treesitter", function()
    require("nvim-treesitter").setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "astro",
        "bash",
        "c",
        "cpp",
        "css",
        "graphql",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "ruby",
        "rust",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml",
      },
      callback = function(event)
        pcall(vim.treesitter.start, event.buf)
        vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end)

  configure("nvim-ts-context-commentstring", function()
    require("ts_context_commentstring").setup({})
  end)

  configure("trouble", function()
    require("trouble").setup({})

    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
    vim.keymap.set(
      "n",
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      { desc = "Buffer Diagnostics (Trouble)" }
    )
    vim.keymap.set("n", "<leader>cS", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
    vim.keymap.set(
      "n",
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      { desc = "LSP Definitions / references / ... (Trouble)" }
    )
    vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
    vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
  end)

  configure("todo-comments", function()
    require("todo-comments").setup({})
  end)

  configure("telescope", function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        preview = {
          treesitter = false,
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    telescope.load_extension("ui-select")

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<C-p>", builtin.find_files)
    vim.keymap.set("n", "<leader>g", builtin.live_grep)
    vim.keymap.set("n", "ss", builtin.grep_string)
    vim.keymap.set("n", "fr", builtin.lsp_references)
    vim.keymap.set("n", "fi", builtin.lsp_implementations)
    vim.keymap.set("n", "fd", builtin.lsp_definitions)
    vim.keymap.set("n", "ft", builtin.lsp_type_definitions)
  end)

  configure("nvim-tree", function()
    local tree = require("nvim-tree")

    tree.setup()

    local api = require("nvim-tree.api")

    vim.keymap.set("n", "<C-n>", function()
      api.tree.toggle({
        find_file = true,
      })
    end)
  end)

  configure("nvim-lspconfig", function()
    require("mason").setup()

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "astro",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "html",
        "jsonls",
        "ts_ls",
        "lua_ls",
        "marksman",
        "volar",
        "yamlls",
      },
      automatic_enable = true,
    })

    local diagnostic_signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(diagnostic_signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end)

  configure("nvim-colorizer", function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "javascript",
        "typescript",
        "html",
      },
    })
  end)

  configure("noice", function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      messages = {
        enabled = false,
      },
    })
  end)

  configure("neogit", function()
    local neogit = require("neogit")

    neogit.setup()

    vim.keymap.set("n", "<leader>cs", neogit.open)
    vim.keymap.set("n", "<leader>cc", function()
      neogit.open({ "commit" })
    end)
  end)

  configure("mini.surround", function()
    require("mini.surround").setup()
  end)

  configure("mini.statusline", function()
    require("mini.statusline").setup()
  end)

  configure("mini.pairs", function()
    require("mini.pairs").setup({})
  end)

  configure("mini.comment", function()
    require("mini.comment").setup({})
  end)

  configure("conform", function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        vue = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end)

  configure("blink.cmp", function()
    require("blink.cmp").setup({
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    })
  end)

  configure("better-escape", function()
    require("better_escape").setup({})
  end)

  configure("snacks", function()
    require("snacks").setup({
      input = {},
      picker = {},
      terminal = {},
    })
  end)

  configure("opencode", function()
    vim.g.opencode_opts = {
      auto_fallback_to_embedded = false,
    }
    vim.o.autoread = true

    vim.keymap.set("n", "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    vim.keymap.set("v", "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode about the selection" })
  end)
end

return M
