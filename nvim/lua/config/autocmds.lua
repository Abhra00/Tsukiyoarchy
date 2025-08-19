-- For conciseness
local function augroup(name)
  return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
end

-- For jdtls
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    require('config.jdtls').setup_jdtls()
  end,
})

-- For autoformatting java code
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.java',
  callback = function()
    vim.lsp.buf.format {
      async = false,
      filter = function(client)
        return client.name == 'jdtls'
      end,
    }
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'json_conceal',
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Disable mini.indentscope for certain filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lazy' },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
