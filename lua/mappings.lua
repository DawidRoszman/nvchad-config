require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
local nomap = vim.keymap.del
-- nomap("n", "<leader> x")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- Harpoon
--
-- Add file to Harpoon
map("n", "<leader>a", function() require("harpoon.mark").add_file() end, { desc = "Add file to Harpoon" })

local harpoon_ui = require("harpoon.ui")
-- Toggle Harpoon UI
map("n", "<leader>jj", function() harpoon_ui.toggle_quick_menu() end, { desc = "Toggle Harpoon UI" })

-- Navigate to files
map("n", "j1", function() harpoon_ui.nav_file(1) end, { desc = "Go to Harpoon file 1" })
map("n", "j2", function() harpoon_ui.nav_file(2) end, { desc = "Go to Harpoon file 2" })
map("n", "j3", function() harpoon_ui.nav_file(3) end, { desc = "Go to Harpoon file 3" })
map("n", "j4", function() harpoon_ui.nav_file(4) end, { desc = "Go to Harpoon file 4" })
