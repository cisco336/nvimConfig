return {
  -- Optional: Enhance JS debugging with VS Code's adapter (for better Next.js source maps)
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
    version = "1.*",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "microsoft/vscode-js-debug" },
    config = function()
      require("dap-vscode-js").setup({
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" }, -- For server/client
      })
    end,
  },

  -- Override DAP configs for Next.js
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function(_, opts)
      local dap = require("dap")
      -- Server-side (Node.js) config: Launch dev server with inspect
      table.insert(opts.configurations.javascript or {}, {
        name = "Next.js: Launch Server-Side",
        type = "node-terminal",
        request = "launch",
        program = "${workspaceFolder}/node_modules/.bin/next",
        args = { "dev", "--inspect", "-p", "3000" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
        protocol = "inspector",
      })

      -- Client-side (Browser) config: Attach to Chrome
      table.insert(opts.configurations.javascript or {}, {
        name = "Next.js: Attach to Chrome",
        type = "pwa-chrome",
        request = "launch",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        userDataDir = "${workspaceFolder}/.vscode/chrome", -- Temp dir for Chrome profile
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "**/*.test.ts" },
      })

      -- Duplicate for TypeScript
      opts.configurations.typescript = opts.configurations.javascript
      opts.configurations.typescriptreact = opts.configurations.javascript
      opts.configurations.javascriptreact = opts.configurations.javascript
    end,
  },
}
