require('gitsigns').setup{
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>ls', gitsigns.stage_hunk, {desc =  "Stage hunk" })
    map('n', '<leader>lr', gitsigns.reset_hunk, {desc =  "Reset hunk" })
    map('v', '<leader>ls', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc =  "Stage hunk V" })
    map('v', '<leader>lr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc =  "Reset hunk V" })
    map('n', '<leader>lS', gitsigns.stage_buffer, {desc =  "Stage buffer" })
    map('n', '<leader>lu', gitsigns.undo_stage_hunk, {desc =  "Undo stage buffer" })
    map('n', '<leader>lR', gitsigns.reset_buffer, {desc =  "Reset buffer" })
    map('n', '<leader>lp', gitsigns.preview_hunk, {desc =  "Preview hunk" })
    map('n', '<leader>lb', function() gitsigns.blame_line{full=true} end, {desc =  "Blame line" })
    map('n', '<leader>lb', gitsigns.toggle_current_line_blame, {desc =  "Toggle blame current line" })
    map('n', '<leader>ld', gitsigns.diffthis, {desc =  "Diff" })
    map('n', '<leader>lD', function() gitsigns.diffthis('~') end, {desc =  "Diff this" })
    map('n', '<leader>td', gitsigns.toggle_deleted, {desc =  "Toggle deleted" })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
