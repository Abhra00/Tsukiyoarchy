-- get the icons file for conciseness
local icons = require 'config.icons'

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI
      view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = {}, -- global options for the cmdline. See section on views
      format = {

        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { pattern = '^:', icon = icons.ui.Cmdline, lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = icons.ui.Search_down, lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = icons.ui.Search_up, lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = icons.ui.Filter, lang = 'bash' },
        lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = icons.ui.Lua, lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = icons.ui.Help },
        input = { view = 'cmdline_input', icon = icons.ui.Input }, -- Used by input()
      },
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
      inc_rename = true,
    },
    views = {
      popup = {
        relative = 'editor',
        position = '50%',
        size = {
          width = 80,
          height = 20,
        },
        enter = true,
        border = {
          style = vim.g.border_style,
          padding = { 0, 1 },
        },
      },
      popupmenu = {
        relative = 'editor',
        position = 'auto',
        zindex = 65,
        size = {
          width = 'auto',
          height = 'auto',
          max_height = 20,
        },
        border = {
          style = vim.g.border_style,
          padding = { 0, 1 },
        },
      },
      cmdline_popup = {
        relative = 'editor',
        position = {
          row = '50%',
          col = '50%',
        },
        size = {
          min_width = 35,
          width = 'auto',
          height = 'auto',
        },
        border = {
          style = vim.g.border_style,
          padding = { 1, 2 },
        },
      },
      cmdline_input = {
        size = {
          min_width = 40,
          width = 'auto',
          height = 'auto',
        },
        border = {
          style = vim.g.border_style,
          padding = { 1, 2 },
        },
      },
      confirm = {
        relative = 'editor',
        align = 'center',
        position = {
          row = 3,
          col = '50%',
        },
        size = 'auto',
        border = {
          style = vim.g.border_style,
          padding = { 0, 1 },
          text = {
            top = ' Confirm ',
          },
        },
      },
      hover = {
        relative = 'cursor',
        position = { row = 1, col = 0 },
        size = {
          width = 'auto',
          height = 'auto',
          max_width = 80,
          max_height = 20,
        },
        border = {
          style = vim.g.border_style,
          padding = { 0, 1 },
        },
      },
      mini = {
        align = 'message-right',
        reverse = true,
        position = {
          row = -1,
          col = '100%',
        },
        size = {
          width = 'auto',
          height = 'auto',
          max_height = 10,
        },
        border = {
          style = 'none',
        },
      },
      notify = {
        replace = false,
        merge = false,
        format = 'notify',
      },
      split = {
        backend = 'split',
        position = 'bottom',
        size = '20%',
        close = {
          keys = { 'q' },
        },
      },
      cmdline = {
        relative = 'editor',
        position = {
          row = '100%',
          col = 0,
        },
        size = {
          height = 'auto',
          width = '100%',
        },
        border = {
          style = 'none',
        },
      },
    },
  },
    -- stylua: ignore
  keys = {
    { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == 'lazy' then
      vim.cmd [[messages clear]]
    end
    require('noice').setup(opts)
  end,
}
