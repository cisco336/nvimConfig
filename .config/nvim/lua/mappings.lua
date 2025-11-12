require "nvchad.mappings"
local dap = require "dap"
local dapui = require "dapui"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
map("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
map("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
map("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
map("n", "<Leader>a", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
map("n", "<Leader>A", function()
  dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "DAP: Conditional Breakpoint" })
map("n", "<Leader>dr", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
map("n", "<Leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
map("t", "<esc><esc>", "<c-\\><c-n>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
