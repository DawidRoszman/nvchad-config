vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md", -- Match Markdown files
    callback = function()
        -- Run your command with the current file's name
        local filepath = vim.fn.expand("%:t")
        vim.fn.system("markdownlint -f '" .. filepath .. "'")
        vim.cmd("edit!")
    end,
})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.java", -- Match Markdown files
    callback = function()
        -- Run your command with the current file's name
        local filepath = vim.fn.expand("%:t")
        vim.fn.system("./gradlew spotlessApply")
        vim.cmd("edit!")
    end,
})

-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--     desc = "Resize nvim-tree if nvim window got resized",
--
--     group = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true }),
--     callback = function()
--         local percentage = 30
--
--         local ratio = percentage / 100
--         local width = math.floor(vim.go.columns * ratio)
--         vim.cmd("tabdo NvimTreeResize " .. width)
--     end,
-- })
