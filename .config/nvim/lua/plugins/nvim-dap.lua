-- custom/plugins.lua
return {
  -- Core DAP
  { "mfussenegger/nvim-dap" },

  -- DAP UI for a better interface (breakpoints, variables, etc.)
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "mxsdev/nvim-dap-vscode-js",
      {
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      -- local dap_js = require "dap-vscode-js"
      require("dap-vscode-js").setup {
        debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug/", -- Path to built adapter
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      }

      -- Auto-open/close UI on debug events
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      for _, lang in ipairs(js_based_languages) do
        dap.configurations[lang] = {
          -- Server-side: Launch Next.js dev server with inspect flag
          {
            name = "Next.js: Launch server-side",
            type = "node-terminal",
            request = "launch",
            program = "${workspaceFolder}/node_modules/.bin/next", -- Or use 'npm run dev' if preferred
            args = { "dev" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            port = 9229, -- Default inspect port; adjust if needed
            sourceMapPathOverrides = {
              ["webpack:///./*"] = "${workspaceFolder}/*",
            },
          },
          -- Server-side: Attach to running dev server (after starting with NODE_OPTIONS='--inspect')
          {
            name = "Next.js: Attach server-side",
            type = "pwa-node",
            request = "attach",
            cwd = "${workspaceFolder}",
            port = 9229,
            sourceMaps = true,
            restart = true,
            skipFiles = { "<node_internals>/**" },
            localSourceMaps = true,
            sourceMapPathOverrides = {
              ["webpack:///./*"] = "${workspaceFolder}/*",
            },
          },
          {
            name = "Next.js: Attach server-side",
            type = "pwa-node",
            request = "attach",
            cwd = "${workspaceFolder}",
            port = 9229,
            sourceMaps = true,
            restart = true,
            skipFiles = { "<node_internals>/**" },
            localSourceMaps = true,
            sourceMapPathOverrides = {
              ["webpack:///./*"] = "${workspaceFolder}/*",
            },
          },
          -- Client-side: Debug in Chrome (launch browser)
          {
            name = "Next.js: Launch Chrome client-side",
            type = "pwa-chrome",
            request = "launch",
            program = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}",
            userDataDir = vim.fn.stdpath "cache" .. "/chrome-debug", -- Persistent Chrome profile
            sourceMapPathOverrides = {
              ["webpack:///./*"] = "${workspaceFolder}/*",
            },
          },
          -- Client-side: Attach to open Chrome (visit localhost:3000 first)
          {
            name = "Next.js: Attach Chrome client-side",
            type = "pwa-chrome",
            request = "attach",
            program = "${workspaceFolder}",
            port = 9222,
            cwd = "${workspaceFolder}",
            webRoot = "${workspaceFolder}",
            sourceMapPathOverrides = {
              ["webpack:///./*"] = "${workspaceFolder}/*",
            },
          },
        }
      end

      -- Setup the JS debugger (adjust adapters as needed)
      -- dap_js.setup {
      --   debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug", -- Path for Lazy installs
      --   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      -- }
      -- require "configs.dap"
    end,
  },

  -- JS/TS adapter using vscode-js-debug
  -- {
  --   "microsoft/vscode-js-debug",
  --   build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
  --   version = "1.*",
  -- },
  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   config = function()
  --     require("dap-vscode-js").setup {
  --       debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug/", -- Path to built adapter
  --       adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
  --     }
  --
  --     -- Alias for Next.js terminal launches
  --     local dap = require "dap"
  --     dap.adapters["node-terminal"] = function(callback, config)
  --       callback(require("dap-vscode-js").adapter(config))
  --     end
  --   end,
  -- },

  -- Optional: Mason for easy adapter management (installs js-debug-adapter)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup {
        ensure_installed = { "js-debug-adapter" }, -- Auto-installs the JS adapter
      }
    end,
  },
}
