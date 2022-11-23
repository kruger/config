local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- ------------------------------------------------------------------------------------------------------------------------
-- Notes on keymaps
-- Other plugins and settings may also set keymaps.  Some key locations are:
-- lua/usr/lsp/handlers.lua
-- lua/user/toggleterm.lua
-- ------------------------------------------------------------------------------------------------------------------------

-- Shorten the key function name
local keymap = vim.api.nvim_set_keymap
-- 1st argument is the mode, 2nd argument is the key to be mapped, 3rd is the action, 4th is always optional arguments above
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


--Remap space as leader key.  This works surprisingly well as shown later
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- As an alternative to autochdir, give mapping to change to same directory as file and then print current directory
keymap("n", ",,cd", ":cd %:p:h<CR>:pwd<CR>", opts)


-- Normal --
-- Better window navigation
-- TODO - SEK:  These don't work because of my tmux settings
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- ------------------------------------------------------------------------------------------------------------------------
-- Leader capabilities
-- ------------------------------------------------------------------------------------------------------------------------
-- leader e => explorer (currently with NvimTree)
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- Lex is short for Lexplore = Left-hand explorer
-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- leader l => format (lint) (with null ls)
keymap("n", "<leader>l", ":Format<cr>", opts)

-- leader f => find files with Telescope
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)

-- leader g => grep with Telescope
keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)

-- leader p => projects with Telescope
keymap("n", "<leader>p", "<cmd>Telescope projects<cr>", opts)

-- Need way of turning off hlsearch
keymap("n", "<leader><leader>", ":nohls<cr>", opts)

-- ------------------------------------------------------------------------------------------------------------------------

-- Resize with arrows  -- this interferes with my MacOS options
-- TODO Figure out what to do here because this is brilliant
-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers -- the S here is shift.  This is brilliant
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts) -- this is subtle but a more intuitive paste mechanism

-- Move text up and down
-- SEK: I cannot get alt key to work on MacOS/wezterm
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- SEK: I don't understand terminal mode, but these are mapped in tmux
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)



--SEK -- these are my own
-- -------------------------------------------------------------------
-- General Editing
-- -------------------------------------------------------------------
--  As an alternative to autochdir, give mapping to change to same directory as
--  file and then print current directory
keymap("n", ",,cd", ":cd %:p:h<CR>:pwd<CR>", opts)

-- I find that these strange combinations do A LOT
keymap("n", "<M-j>", "j0.", opts)
keymap("n", "<M-n>", "n.", opts)
keymap("n", "<M-l>", "j$.", opts)

-- vimdiff mappings
keymap("n", ",g", ":diffget<CR>", opts)
keymap("n", ",p", ":diffput<CR>", opts)
keymap("n", ",n", "]c", opts)
keymap("n", ",c", "[c", opts)
-- Folding
keymap("n", ",,9", ":set foldlevel=9<CR>", opts)
keymap("n", ",,0", ":set foldlevel=0<CR>", opts)
keymap("n", ",,1", ":set foldlevel=1<CR>", opts)

-- -------------------------------------------------------------------
--  Files to edit and source quickly
-- -------------------------------------------------------------------
--  Get to the configuration files quickly
-- TODO: Figure out how to source this and map it
keymap("n", ",,rc", ":e ~/.config/nvim/init.lua<cr>", opts)
--
--  These files contain useful info. Need to reference quickly like help
keymap("n", ",,p", ":e ~/config/tips/<cr>", opts)
