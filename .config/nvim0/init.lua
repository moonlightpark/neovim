-- ~/.config/nvim/init.lua

-- 리더 키를 스페이스로 설정 (lazy.nvim 설정 전에 필요)
vim.g.mapleader = " "

-- 기본 옵션 설정
vim.opt.number = true         -- 줄 번호 표시
vim.opt.autoindent = true     -- 자동 들여쓰기
vim.opt.tabstop = 2           -- 탭 크기
vim.opt.expandtab = true      -- 탭을 스페이스로 대체
vim.opt.shiftwidth = 2        -- 자동 들여쓰기 크기
vim.opt.smarttab = true       -- 스마트 탭
vim.opt.softtabstop = 2       -- 편집할 때 탭 크기
vim.opt.termguicolors = true  -- 터미널 256 색상 지원
vim.opt.mouse = ""

-- lazy.nvim 설치
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 핵심 플러그인 설치
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Copilot 설정 (필요 시 추가)
    end,
  },
  { "jiangmiao/auto-pairs", lazy = false },
  {
    "preservim/nerdtree",
    lazy = false,
    config = function()
      vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTree<CR>',       { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFind<CR>',   { noremap = true, silent = true })
    end,
  },
  { "Xuyuanp/nerdtree-git-plugin", lazy = false, dependencies = { "preservim/nerdtree" } },
  { "tiagofumo/vim-nerdtree-syntax-highlight", lazy = false, dependencies = { "preservim/nerdtree" } },
  {
    "hashivim/vim-terraform",
    lazy = false,
    config = function()
      vim.g.terraform_fmt_on_save = 1
      vim.g.terraform_align = 1
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },
})

vim.g.NERDTreeShowIcons = 1
vim.g.WebDevIconsUnicodeDecorateFileNodes = 1
vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1

-- 기본 키매핑
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Ctrl + / 주석 처리 매핑
map('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts)
map('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts)

-- 창 이동
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
