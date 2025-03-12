function OpenMarkdownPreview(url)
  vim.fn.system("google-chrome-bin --new-window " .. url)
end

vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'

