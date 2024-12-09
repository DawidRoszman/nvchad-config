vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md", -- Match Markdown files
    callback = function()
        -- Run your command with the current file's name
        local filepath = vim.fn.expand("%:t")
        vim.fn.system("markdownlint -f '" .. filepath .. "'")
        vim.cmd("edit!")
    end,
})

