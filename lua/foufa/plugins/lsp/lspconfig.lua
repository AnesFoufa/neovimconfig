return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", vim.lsp.buf.references, opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Go to definition"
			keymap.set("n", "gd", vim.lsp.buf.definition, opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			-- code lens
			if client.server_capabilities.codeLensProvider then
				local codelens = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
				vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
					group = codelens,
					callback = function()
						vim.lsp.codelens.refresh()
					end,
					buffer = bufnr,
				})
			end
			-- Use LSP formatter for rust
			if client.name == "rust_analyzer" then
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
						})
					end,
				})
			end

			if client.name == "gopls" and client:supports_method("textDocument/formatting") then
				local augroup = vim.api.nvim_create_augroup("GoLspFormatting", {})
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							filter = function(format_client)
								return format_client.name == "gopls"
							end,
						})
					end,
				})
			end

			if client.name == "gleam" and client:supports_method("textDocument/formatting") then
				local augroup = vim.api.nvim_create_augroup("GleamLspFormatting", {})
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							filter = function(format_client)
								return format_client.name == "gleam"
							end,
						})
					end,
				})
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()
		local default_config = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		local function configure(server, config)
			vim.lsp.config(server, vim.tbl_deep_extend("force", default_config, config or {}))
			vim.lsp.enable(server)
		end

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)

		-- configure html server
		configure("html")

		-- configure typescript server with plugin
		configure("ts_ls")

		-- configure css server
		configure("cssls")

		-- configure tailwindcss server
		configure("tailwindcss")
		-- configure graphql language server
		configure("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- configure emmet language server
		configure("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- configure python server
		configure("pyright")

		configure("clangd")

		-- configure lua server (with special settings)
		configure("lua_ls", {
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
		configure("ocamllsp", {
			command = { "ocamllsp" },
			filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
			root_dir = function(fname)
				return vim.fs.root(fname, {
					"*.opam",
					"esy.json",
					"package.json",
					".git",
					"dune-project",
					"dune-workspace",
				})
			end,
		})
		configure("hls")

		configure("rust_analyzer")

		configure("gleam")
		configure("gopls")
		-- configure Erlang server
		configure("erlangls")
		configure("elixirls", {
			cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
			root_dir = function(fname)
				return vim.fs.root(fname, { "mix.exs", ".git" }) or (vim.uv or vim.loop).cwd()
			end,
			filetypes = { "elixir", "eelixir", "heex" },
			-- optional settings
			settings = {},
		})
		configure("bashls")
	end,
}
