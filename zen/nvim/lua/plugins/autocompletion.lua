-- Get icons
local icons = require 'config.icons'

return {
  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      'moyiz/blink-emoji.nvim',
      'ray-x/cmp-sql',
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<C-Z>'] = { 'accept', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',

        kind_icons = {
          Class = icons.kind.Class,
          Color = icons.kind.Colors,
          Constant = icons.kind.Constant,
          Constructor = icons.kind.Constructor,
          Enum = icons.kind.Enum,
          EnumMember = icons.kind.EnumMember,
          Event = icons.kind.Event,
          Field = icons.kind.Field,
          File = icons.kind.File,
          Folder = icons.kind.Folder,
          Function = icons.kind.Function,
          Interface = icons.kind.Interface,
          Keyword = icons.kind.Keyword,
          Method = icons.kind.Method,
          Module = icons.kind.Module,
          Operator = icons.kind.Operator,
          Property = icons.kind.Property,
          Reference = icons.kind.Reference,
          Snippet = icons.kind.Snippet,
          Struct = icons.kind.Struct,
          Text = icons.kind.Text,
          TypeParameter = icons.kind.TypeParameter,
          Unit = icons.kind.Unit,
          Value = icons.kind.Value,
          Variable = icons.kind.Variable,
        },
      },

      -- Some opts for my own taste
      completion = {
        menu = {
          border = vim.g.border_style,
          scrolloff = 1,
          scrollbar = true,
          -- draw = {
          --   padding = { 0, 0 }, -- side padding
          --   components = {
          --     kind_icon = {
          --       text = function(ctx)
          --         return ' ' .. ctx.kind_icon .. ctx.icon_gap .. ' '
          --       end,
          --     },
          --   },
          -- },
        },
        documentation = {
          auto_show_delay_ms = 0,
          auto_show = true,
          window = {
            border = vim.g.border_style,
          },
        },
      },
      signature = { enabled = false },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'emoji', 'sql' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          emoji = {
            module = 'blink-emoji',
            name = 'Emoji',
            score_offset = 15, -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
            should_show_items = function()
              return vim.tbl_contains(
                -- Enable emoji completion only for git commits and markdown.
                -- By default, enabled for all file-types.
                { 'gitcommit', 'markdown' },
                vim.o.filetype
              )
            end,
          },
          sql = {
            -- IMPORTANT: use the same name as you would for nvim-cmp
            name = 'sql',
            module = 'blink.compat.source',

            -- all blink.cmp source config options work as normal:
            score_offset = -3,

            -- this table is passed directly to the proxied completion source
            -- as the `option` field in nvim-cmp's source config
            --
            -- this is NOT the same as the opts in a plugin's lazy.nvim spec
            opts = {},
            should_show_items = function()
              return vim.tbl_contains(
                -- Enable emoji completion only for git commits and markdown.
                -- By default, enabled for all file-types.
                { 'sql' },
                vim.o.filetype
              )
            end,
          },
          path = {
            name = 'Path',
            module = 'blink.cmp.sources.path',
            score_offset = 25,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { 'snippets', 'buffer' },
            -- min_keyword_length = 2,
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
        },
      },

      cmdline = {
        enabled = true,
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
