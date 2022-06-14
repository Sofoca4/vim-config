local lsp = require("lspconfig")
vim.keymap.set('n','<Tab>','<Cmd>bn<CR>', { silent = true, noremap = true })
vim.keymap.set('n','<S-Tab>','<Cmd>bp<CR>', { silent = true, noremap = true })

local custom_lsp_attach = function(client)
	vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
	vim.api.nvim_buf_set_keymap(0, 'i', '<C-Space>', '<C-X><C-O>', { silent = true, noremap = true })
	vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { silent = true, noremap = true })
	vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { silent = true, noremap = true })
	vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true, noremap = true })
	vim.api.nvim_buf_set_keymap(0, 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap=true, silent=true })
end

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/sofoca/.local/src/Omnisharp-1.37.14/run"
lsp.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
	on_attach = custom_lsp_attach;
    ...
}

lsp.pyright.setup{
	on_attach = custom_lsp_attach
}
--lsp.denols.setup{}
lsp.tsserver.setup{
	on_attach = custom_lsp_attach
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
