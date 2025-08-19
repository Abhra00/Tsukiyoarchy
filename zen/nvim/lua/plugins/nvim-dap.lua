return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()

    dap.configurations.java = {
      {
        type = 'java',
        request = 'attach',
        name = 'Debug (Attach) - Remote',
        hostName = '127.0.0.1',
        port = 5005,
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
    -- set keymaps
    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = '[D]ebug [T]oggle Breakpoint' })
    vim.keymap.set('n', '<leader>ds', dap.continue, { desc = '[D]ebug [S]tart' })
    vim.keymap.set('n', '<leader>dc', dapui.close, { desc = '[D]ebug [C]lose' })
    vim.keymap.set('n', '<leader>dn', function()
      require('dap').step_over()
    end, { desc = '[D]ebug Step [N]ext' })
    vim.keymap.set('n', '<leader>di', function()
      require('dap').step_into()
    end, { desc = '[D]ebug Step [I]nto' })
    vim.keymap.set('n', '<leader>do', function()
      require('dap').step_out()
    end, { desc = '[D]ebug Step [O]ut' })
  end,
}
