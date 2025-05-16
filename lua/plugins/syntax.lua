return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'go', 'rust', 'javascript', 'html' },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },  
    }
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup()
      require('mini.pairs').setup()
      require('mini.move').setup()
      require('mini.surround').setup()
      require('mini.diff').setup()
      require('mini.icons').setup()
      require('mini.trailspace').setup()
    end
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
  }
}
