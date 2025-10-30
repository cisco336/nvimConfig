-- custom/configs/dap.lua
local dap = require "dap"
local dapui = require "dapui"

-- JS/TS configs for Next.js
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

-- Keymaps (add to custom/mappings.lua or here)
-- vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
-- vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
-- vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
-- vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
-- vim.keymap.set("n", "<Leader>a", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
-- vim.keymap.set("n", "<Leader>A", function()
--   dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
-- end, { desc = "DAP: Conditional Breakpoint" })
-- vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
-- vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
