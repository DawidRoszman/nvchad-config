function OpenMarkdownPreview(url)
  vim.fn.system("zen-browser --new-window " .. url)
end

vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'

