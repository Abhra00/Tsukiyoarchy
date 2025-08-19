return {
  'rcarriga/nvim-notify',
  opts = {
    render = 'default',
    stages = 'slide',
    fps = 120,
    timeout = 6000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      local config = vim.api.nvim_win_get_config(win)
      config.border = vim.g.border_style
      config.zindex = 100
      vim.api.nvim_win_set_config(win, config)
    end,
  },
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = '[D]ismiss All Notifications',
    },
  },
  config = function(_, opts)
    require('notify').setup(opts)
    vim.notify = require 'notify'
  end,
}
