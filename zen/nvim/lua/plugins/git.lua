return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local icons = require 'config.icons'

      -- setup gitsigns
      require('gitsigns').setup {
        signs = {
          add = {
            hl = 'GitSignsAdd',
            text = icons.ui.BoldLineMiddle,
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn',
          },
          change = {
            hl = 'GitSignsChange',
            text = icons.ui.BoldLineDashedMiddle,
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
          delete = {
            hl = 'GitSignsDelete',
            text = icons.ui.TriangleShortArrowRight,
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
          },
          topdelete = {
            hl = 'GitSignsDelete',
            text = icons.ui.TriangleShortArrowRight,
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
          },
          changedelete = {
            hl = 'GitSignsChange',
            text = icons.ui.BoldLineMiddle,
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
        },
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = 'rounded',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
      }

      vim.keymap.set('n', '<leader>ggh', ':Gitsigns preview_hunk<CR>', { desc = '[G]it Preview [H]unk' })
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>ggb', ':Git blame<cr>', { desc = '[G]it [B]lame' })
      vim.keymap.set('n', '<leader>gga', ':Git add .<cr>', { desc = '[G]it Add [A]ll' })
      vim.keymap.set('n', '<leader>gg.', 'Git add', { desc = '[G]it [A]dd' })
      vim.keymap.set('n', '<leader>ggc', ':Git commit', { desc = '[G]it [C]ommit' })
      vim.keymap.set('n', '<leader>ggp', 'Git push', { desc = '[G]it [P]ush' })
    end,
  },
  {
    'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = {
      'tpope/vim-fugitive',
    },
  },
}
