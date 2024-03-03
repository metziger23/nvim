return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Decorate floating windows
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		vim.diagnostic.config({
			float = { border = "rounded" },
		})
		require("lspconfig.ui.windows").default_options.border = "rounded"

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr
			local builtin = require("telescope.builtin")

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			opts.desc = "Goto definition"
			keymap.set("n", "gd", builtin.lsp_definitions, opts)
			opts.desc = "Goto implementation"
			keymap.set("n", "gI", builtin.lsp_implementations, opts)
			opts.desc = "Goto type"
			keymap.set("n", "gy", builtin.lsp_type_definitions, opts)
			opts.desc = "Goto References"
			keymap.set("n", "gr", builtin.lsp_references, opts)
			opts.desc = "Goto Line diagnostics"
			keymap.set("n", "gl", vim.diagnostic.open_float, opts)

			opts.desc = "Lsp Document Symbols"
			keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, opts)
			opts.desc = "Lsp Workspace Symbols"
			keymap.set("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, opts)
			opts.desc = "Lsp diagnostics"
			keymap.set("n", "<leader>ld", function()
				builtin.diagnostics({ bufnr = 0 })
			end, opts)
			opts.desc = "Lsp diagnostics in all buffers"
			keymap.set("n", "<leader>lD", function()
				builtin.diagnostics({ bufnr = nil })
			end, opts)

			if client.supports_method("callHierarchy/incomingCalls") then
				opts.desc = "Lsp incoming calls"
				keymap.set("n", "<leader>lc", function()
					builtin.lsp_incoming_calls()
				end, opts)
			end

			if client.supports_method("callHierarchy/outgoingCalls") then
				opts.desc = "Lsp outgoing calls"
				keymap.set("n", "<leader>lC", function()
					builtin.lsp_outgoing_calls()
				end, opts)
			end

			opts.desc = "Lsp rename"
			keymap.set("n", "<leader>lr", function()
				vim.lsp.buf.rename()
			end, opts)
			opts.desc = "Lsp Code action"
			keymap.set("n", "<leader>la", function()
				vim.lsp.buf.code_action()
			end, opts)
			opts.desc = "Lsp Source action"
			keymap.set("n", "<leader>lA", function()
				vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
			end, opts)
			opts.desc = "Format"
			keymap.set("n", "<leader>lf", function()
				require("conform").format()
			end, opts)
			opts.desc = "Format selection"
			keymap.set("v", "<leader>lf", function()
				require("conform").format()
			end, opts)

			opts.desc = "Hover information"
			keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			opts.desc = "Signature help"
			keymap.set("n", "gK", function()
				vim.lsp.buf.signature_help()
			end, opts)
			keymap.set("i", "<c-k>", function()
				vim.lsp.buf.signature_help()
			end, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function()
				vim.diagnostic.goto_next({ severity = nil })
			end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function()
				vim.diagnostic.goto_prev({ severity = nil })
			end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next error"
			keymap.set("n", "]e", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] })
			end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Go to previous error"
			keymap.set("n", "[e", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] })
			end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next warning"
			keymap.set("n", "]w", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] })
			end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Go to previous warning"
			keymap.set("n", "[w", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] })
			end, opts) -- jump to previous diagnostic in buffer
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure bashls server
		lspconfig["bashls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure clangd server
		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				local clang_opts = { noremap = true, silent = true }
				clang_opts.buffer = bufnr
				clang_opts.desc = "Switch Source/Header (C/C++)"
				vim.keymap.set("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", clang_opts)
			end,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
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
