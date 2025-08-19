return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  -- branch = '0.1.x',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'echasnovski/mini.icons', version = false, enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    --- Load icons file for convenience
    local icons = require 'config.icons'

    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`

      defaults = {
        prompt_prefix = ' ' .. icons.ui.Telescope .. ' ',
        selection_caret = ' ' .. icons.ui.TelescopePromptPrefix .. '  ',
        entry_prefix = '    ',
        borderchars = {
          prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'bottom',
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = {
          n = { ['q'] = require('telescope.actions').close },
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous, -- move to prev result
            ['<C-j>'] = require('telescope.actions').move_selection_next, -- move to next result
            ['<C-l>'] = require('telescope.actions').select_default, -- open file
          },
        },
      },
      pickers = {
        buffers = {
          sort_lastused = true,
          prompt_prefix = ' ' .. icons.ui.Buffer .. ' ',
          previewer = false,
          layout_config = {
            width = 0.3,
            height = 0.4,
          },
          mappings = {
            ['i'] = {
              ['<C-K>'] = require('telescope.actions').preview_scrolling_up,
              ['<C-J>'] = require('telescope.actions').preview_scrolling_down,
            },
          },
        },
        find_files = {
          file_ignore_patterns = { 'node_modules', '%.git', '%.venv' },
          hidden = true,
        },
        live_grep = {
          prompt_prefix = ' ' .. icons.ui.Grep .. ' ',
          file_ignore_patterns = { 'node_modules', '%.git', '%.venv' },
          additional_args = function(_)
            return { '--hidden' }
          end,
        },
        colorscheme = {
          prompt_prefix = ' ' .. icons.kind.Color .. ' ',
          enable_preview = true,
          previewer = false,
        },
        oldfiles = {
          prompt_prefix = ' ' .. icons.ui.Oldfiles .. ' ',
        },
      },
      extensions = {
        ['ui-select'] = {
          layout_config = {
            height = 0.5,
            width = 0.5, -- reduce width (default is 0.8-1.0)
            prompt_position = 'top',
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    -- set a vim motion to <Space> + f + f to search for files by their names
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    -- set a vim motion to <Space> + f + g to search for files based on the text inside of them
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    -- set a vim motion to <Space> + f + d to search for Code Diagnostics in the current project
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    -- set a vim motion to <Space> + f + r to resume the previous search
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]inder [R]esume' })
    -- set a vim motion to <Space> + f + . to search for Recent Files
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    -- set a vim motion to <Space> + f + b to search Open Buffers
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind Existing [B]uffers' })
  end,
}
