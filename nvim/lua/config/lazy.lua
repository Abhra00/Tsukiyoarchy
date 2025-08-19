-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Load keymaps
require 'config.keymaps'

-- Load options
require 'config.options'

-- Load the auto commands from the config/autocmds.lua file
require 'config.autocmds'

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    -- import your plugins
    { import = 'plugins' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'habmax' } },
  change_detection = {
    -- Don't notify us every time a change is made to the configuration
    notify = false,
  },
  -- automatically check for plugin updates
  checker = {
    enabled = true,

    -- Don't spam us with notification every time there is an update available
    notify = false,
  },

  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = vim.g.border_style,
    backdrop = 100,
    title = ' 󰒲  Lazy ', ---@type string only works when border is not "none"
    title_pos = 'center', ---@type "center" | "left" | "right"
    -- Show pills on top of the Lazy window
    pills = true, ---@type boolean
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    icons = {
      cmd = ' ',
      config = ' ',
      event = ' ',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = '󰌌 ',
      lazy = '󰒲 ',
      loaded = ' ',
      not_loaded = ' ',
      plugin = ' ',
      runtime = ' ',
      require = '󰢱 ',
      source = '󰳐 ',
      start = ' ',
      task = '✔ ',
      list = {
        '●',
        '➜',
        '★',
        '‒',
      },
    },
  },
}
