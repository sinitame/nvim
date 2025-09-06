local M = {}

M.on_attach = function(_, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
	end

	-- LSP navigation
	map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
	map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
	map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
	map("n", "gr", require("telescope.builtin").lsp_references, "References")

	-- Info & actions
	map("n", "K", vim.lsp.buf.hover, "Hover")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
	map({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
	map("n", "<leader>f", function() vim.lsp.buf.format({ async = false }) end, "Format")

	-- Diagnostics
	map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
	map("n", "<leader>e", vim.diagnostic.open_float, "Line Diagnostics")
end

return M
