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

		-- configure emmet language server
		configure("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
		})

		-- configure python server
		configure("pyright")

		configure("bashls", {
			filetypes = { "sh", "bash", "zsh" },
		})

		configure("sqlls")

		configure("dockerls")

		configure("yamlls", {
			settings = {
				yaml = {
					schemas = {
						kubernetes = {
							"*.k8s.yaml",
							"*.k8s.yml",
							"k8s/*.yaml",
							"k8s/*.yml",
							"manifests/*.yaml",
							"manifests/*.yml",
						},
					},
				},
			},
		})

		configure("helm_ls", {
			filetypes = { "helm" },
			settings = {
				["helm-ls"] = {
					yamlls = {
						path = "yaml-language-server",
					},
				},
			},
		})

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
	end,
}
