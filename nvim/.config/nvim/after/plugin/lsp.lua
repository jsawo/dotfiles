local lsp = require('lsp-zero')

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = false,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '⚠️',
    hint = '⚑',
    info = ''
  }
})

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'sumneko_lua',
	'rust_analyzer',
	'gopls',
	'intelephense',
})

-- local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
-- 	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
-- 	['<C-Space>'] = cmp.mapping.complete(),
-- })

-- lsp.setup_nvim_cmp({
-- 	mapping = cmp_mappings
-- })

lsp.on_attach(function(client, bufnr)
  local bind = vim.keymap.set
	local opts = {buffer = bufnr, remap = false}

	bind("n", "gd", function() vim.lsp.buf.definition() end, opts)
	bind("n", "K", function() vim.lsp.buf.hover() end, opts)
	-- bind("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	-- bind("n", "<leader>vd", function() vim.lsp.diagnostic.open_float() end, opts)
	-- bind("n", "[d", function() vim.lsp.diagnostic.goto_next() end, opts)
	-- bind("n", "]d", function() vim.lsp.diagnostic.goto_prev() end, opts)
	-- bind("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	-- bind("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	-- bind("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	-- bind("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

