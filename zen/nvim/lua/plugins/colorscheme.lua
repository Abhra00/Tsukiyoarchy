return {
  'RRethy/base16-nvim',
  lazy = false,
  priority = 1000,
  init = function()
    local colors = dofile(os.getenv 'HOME' .. '/.cache/wal/colors-base16-nvim.lua')
    require('base16-colorscheme').with_config { telescope = false }
    require('base16-colorscheme').setup(colors)
  end,
}
