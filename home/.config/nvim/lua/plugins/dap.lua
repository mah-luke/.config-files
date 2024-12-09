-- Debug Adapter Protocol DAP
-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/theHamsta/nvim-dap-virtual-text
-- https://github.com/mfussenegger/nvim-dap-python

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "theHamsta/nvim-dap-virtual-text",
                config = true,
            },
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "DAP Set Conditional Breakpoint"
      },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP Step Over" },
      { "<leader>du", function() require("dap").step_out() end, desc = "DAP Step Out" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "DAP Quit" },
    },
        config = function()
            local dap = require("dap")
            -- Set up  nvim-dap-ui
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap_python = require("dap-python")
            dap_python.setup("/home/lukas/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

            -- not working:
            -- table.insert(require("dap").configurations.python, {
            --     justMyCode = false,
            -- })

            -- require("dap-python").test_runner = "pytest"
            -- require("dap-python").setup("/usr/bin/python3")
        end,
        keys = {
            {
                "<leader>dom",
                function()
                    require("dap-python").test_method({config={justMyCode=false}})
                end,
                desc = "DAP Python Run",
            },
            {
                "<leader>dm",
                function()
                    require("dap-python").test_method()
                end,
                desc = "DAP Python Run",
            },
        },
    },
}
