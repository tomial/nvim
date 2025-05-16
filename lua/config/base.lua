vim.cmd('syntax enable')
-- 设置 Neovim 消息语言为中文 (可选, 更推荐通过环境变量 LANG)
-- vim.cmd('language zh_CN.UTF-8')
vim.opt.number = true
vim.opt.mouse = 'a'
vim.cmd('filetype plugin indent on')
vim.opt.expandtab = true     -- 将 Tab 转换为空格
vim.opt.tabstop = 2          -- Tab 显示为2个空格的宽度
vim.opt.softtabstop = 2      -- 在编辑时，按 Tab 或 Backspace 时，把多个空格当作一个 Tab 对待 (宽度为2)
vim.opt.shiftwidth = 2       -- 自动缩进和手动缩进 (如使用 > 或 <) 时使用的空格数

vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.opt.fileformats = { "unix", "dos" }

vim.g.mapleader = " "

-- wsl clipboard, use win32yank
vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "win32yank -i --crlf",
    ["*"] = "win32yank -i --crlf",
  },
  paste = {
    ["+"] = 'win32yank -o --lf',
    ["*"] = 'win32yank -o --lf',
  },
  cache_enabled = 0,
}

