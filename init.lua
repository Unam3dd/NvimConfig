local home = os.getenv('HOME')
-- Map Leader

vim.g.mapleader = " "

-- KeyMap
-- Insert Mode keymap

vim.api.nvim_set_keymap('i', '<C-q>', '<ESC>:q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:w!<CR>', {	noremap = true })
vim.api.nvim_set_keymap('i', '<TAB>', '<TAB>', { noremap = true })

-- Normal Mode keymap
vim.api.nvim_set_keymap('', '<C-q>', ':q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('', '<C-s>', ':w!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Right>', '<C-w><Right>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Left>', '<C-w><Left>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Up>', '<C-w><Up>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Down>', '<C-w><Down>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-n>', ':!(norminette)<CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<C-x>', ':!(python3 -m compiledb make)<CR>', { noremap = true})

-- Options
--vim.o.relativenumber = true
vim.wo.number = true
vim.o.tabstop = 4

-- Packer
require('packer-plugins')

-- Mason LSP

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clangd"},
	automatic_installation = true,
})

-- Load LSP

require("lspconfig").clangd.setup {}

-- Neotree configuration

require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	
	modified = {
            symbol = ">>>",
            highlight = "NeoTreeModified",
          },
	
	window = {
		position = "left",
		width = 40,
		mapping_options = {
			noremap  = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false,
			},
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			["c"] = "copy",
			["p"] = "paste_from_clipboard",
			["m"] = "move",
			["<"] = "prev_source",
			[">"] = "next_source",
			["r"] = "rename",
			["R"] = "refresh",
			["q"] = "close_window",
			["d"] = "delete",
			["A"] = "add_directory",
			["t"] = "open_tabnew",
			["s"] = "open_split",
			["S"] = "open_vsplit",
			["<cr>"] = "open",
			["<esc>"] = "revert_preview",
			["w"] = "open_with_window_picker",
			["P"] = { "toggle_preview", config = { use_float = true } },
		},
		git_status = {
          		window = {
            			position = "float",
            		mappings = {
              			["A"]  = "git_add_all",
              			["gu"] = "git_unstage_file",
              			["ga"] = "git_add_file",
              			["gr"] = "git_revert_file",
              			["gc"] = "git_commit",
              			["gp"] = "git_push",
             			["gg"] = "git_commit_and_push",
            			}
        		}
        	}
	}
})

vim.cmd([[set mouse=a]])
vim.cmd([[set guioptions-=r]])
vim.cmd([[set guioptions-=R]])
vim.cmd([[set guioptions-=l]])
vim.cmd([[set guioptions-=L]])
vim.cmd([[au 		BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
vim.cmd([[filetype plugin indent on]])
vim.cmd([[set smartindent]])
vim.cmd([[set autoindent]])
vim.cmd([[set backspace=indent,eol,start]])
vim.cmd([[set encoding=utf-8]])
vim.cmd([[set tabstop=4]])
vim.cmd([[set shiftwidth=4]])
vim.cmd([[set noswapfile]])
vim.cmd([[set showmode]])
vim.cmd([[set pumheight=50]])
vim.cmd([[set whichwrap+=<,>,[,]])
vim.cmd([[let g:load_doxygen_syntax=1]])
vim.api.nvim_set_keymap('i', '<C-g>', '<esc>:Neotree<CR', {})
vim.api.nvim_set_keymap('', '<C-g>', '<esc>:Neotree<CR>', {})

-- Dashboard
local db = require('dashboard')

-- linux

db.preview_command = 'python3 -c "import os;import random;dirs=os.listdir(os.path.expanduser(\'~\') + \'/.config/nvim/db\');rd=random.randint(0,len(dirs)-1);f=open(os.path.expanduser(\'~\') + \'/.config/nvim/db/\' + dirs[rd], \'rb\');data=f.read().decode(\'utf-8\');f.close();print(data)"'

--
db.preview_file_path = home .. '/.config/nvim/db/kelly_price.jpg'
db.preview_file_height = 20
db.preview_file_width = 40
db.custom_center = {
	{icon = '???  ',
      	desc = 'Recently latest session                  ',
      	shortcut = 'SPC s l',
      	action ='SessionLoad'},
      	{icon = '???  ',
     	 desc = 'Recently opened files                   ',
     	 action =  'DashboardFindHistory',
      	shortcut = 'SPC f h'},
      	{icon = '???  ',
      	desc = 'Find  File                              ',
     	 action = 'Telescope find_files find_command=rg,--hidden,--files',
      	shortcut = 'SPC f f'},
      	{icon = '???  ',
      	desc ='File Browser                            ',
      	action =  'Telescope file_browser',
      	shortcut = 'SPC f b'},
      	{icon = '???  ',
      	desc = 'Find  word                              ',
      	action = 'Telescope live_grep',
      	shortcut = 'SPC f w'},
      	{icon = '???  ',
      	desc = 'Open Personal dotfiles                  ',
      	action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
      	shortcut = 'SPC f d'},
}

require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- Set barbar's options
require'bufferline'.setup {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},

  -- Show every buffer
  hide = {current = false, inactive = false, visible = false},


  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = true,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '???',
  icon_separator_inactive = '???',
  icon_close_tab = '???',
  icon_close_tab_modified = '???',
  icon_pinned = '???',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the minimum padding width with which to surround each tab
  minimum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '???', right = '???'},
    section_separators = { left = '???', right = '???'},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Coc Autocomplete
vim.cmd([[inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"]])

require("toggleterm").setup()

vim.cmd([[nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>]])
vim.cmd([[inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>]])
