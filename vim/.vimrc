"          _
" __    __(_)_ __  __  _ __  ___
" \ \  / /  | '_  '_ \| '__ /  _|
"  \ \/ / | | | | | | | |  |  (_
"   \__/  |_|_| |_| |_|_|   \___|




" Setup for Vundle plugin manager
" ==================================================================

	set nocompatible              " be iMproved, required
	filetype off                  " required

	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	  Plugin 'VundleVim/Vundle.vim'

	" Surround command variants
		Plugin 'tpope/vim-surround'

	"	Plugins (e.g. surround) to use dot
		Plugin 'tpope/vim-repeat'

	"	Plugin to comment out lines or paragraph
		Plugin 'tpope/vim-commentary'

	" Nerdtree, file manager for Vim
	  Plugin 'scrooloose/nerdtree'

	" ALE, linting multiple coding languages
		Plugin 'dense-analysis/ale'

	" Vim Airline
	  Plugin 'vim-airline/vim-airline'
		Plugin 'vim-airline/vim-airline-themes'

	" Solarized plugin to change the default colors
		Plugin 'altercation/vim-colors-solarized'

	" Emmet for easier HTML and CSS
	  Plugin 'mattn/emmet-vim'

	" Plugin for Vue.JS
		Plugin 'posva/vim-vue'

	"	Plugin for React
		Plugin 'maxmellon/vim-jsx-pretty'

	" Plugin for Ruby and Rails
	"	Plugin 'vim-ruby/vim-ruby'
		Plugin 'tpope/vim-rails'

	" PHP plugins
		Plugin 'StanAngeloff/php.vim'
		Plugin 'jwalton512/vim-blade'
		Plugin '2072/PHP-Indenting-for-VIm'

	"	Go plugin
		Plugin 'fatih/vim-go'

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	"
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	"
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line


" Basics and keybinds
" ==================================================================

"	Setting the numbers on the side relative
	set number relativenumber
" Splits open on the bottom and the right
	set splitbelow splitright

	syntax enable
	syntax on
	set nocompatible
	filetype plugin on

"	Split navigation shortcuts
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

"	CTRL-n opens NerdTree
	nmap <C-n> :NERDTreeToggle<CR>
" NerdTree shows hidden
	let NERDTreeShowHidden=1

" 	Enable poweline fonts
	let g:airline_powerline_fonts = 1

	if !exists('g:airline_symbols')
 	  let g:airline_symbols = {}
	endif

" Unicode symbols
	let g:airline_left_sep = '»'
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '«'
	let g:airline_right_sep = '◀'
	let g:airline_symbols.linenr = '␊'
	let g:airline_symbols.linenr = '␤'
	let g:airline_symbols.linenr = '¶'
	let g:airline_symbols.branch = '⎇'
	let g:airline_symbols.paste = 'ρ'
	let g:airline_symbols.paste = 'Þ'
	let g:airline_symbols.paste = '∥'
	let g:airline_symbols.whitespace = 'Ξ'

" Airline symbols
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''

"	Copy and paste to and from Vim
	vnoremap <C-c> "+y
	map <C-v> "+P

"	Setting tab to 2 spaces worth, indent to 2 spaces, tab to the next indent
	set tabstop=2 shiftwidth=2 smarttab

" Deleting traling whitespace from documents
	autocmd BufWritePre * %s/\s\+$//e

"	Disabling the arrows. Learn the hard way.
	noremap <Up> <Nop>
	noremap <Down> <Nop>
	noremap <Left> <Nop>
	noremap <Right> <Nop>
	inoremap <Up> <Nop>
	inoremap <Down> <Nop>
	inoremap <Left> <Nop>
	inoremap <Right> <Nop>

"	Because I mess it up all the time
	command! Wq wq
	command! WQ wq
	command! W w
	command! Q q

" Emmet
	let g:user_emmet_leader_key:','

" Programming language specific settings
" =================================================================

"	Go
	au BufRead,BufNewFile *.go set filetype=go

"	Typescript
	au BufRead,BufNewFile *.ts setfiletype typescript

" Javascript
  set autoindent
  filetype plugin indent on
  autocmd FileType javascript setlocal smartindent
	au BufNewFile,BufRead *.ejs set filetype=html
  inoremap {<CR> {<CR>}<ESC>O
  inoremap (<CR> (<CR>)<ESC>O
  inoremap [<CR> [<CR>]<ESC>O

"	Vue JS
	au BufNewFile,BufRead *.vue setlocal filetype=vue
	let g:vue_disable_pre_processors=1
	autocmd FileType vue syntax sync fromstart

"	Ruby
	autocmd FileType eruby syntax sync fromstart
  autocmd FileType eruby setlocal smartindent
	autocmd FileType eruby inoremap ,def def<Enter><Enter>end<Esc>2k$a<Space>
	autocmd FileType eruby inoremap ,if if<Enter><Enter>end<Esc>2k$a<Space>
	autocmd FileType eruby inoremap ,% <%<Space>%><Enter><Enter><%<Space>end<Space>%><Esc>2k$F%hi<Space>
	autocmd FileType eruby inoremap ,%= <%=<Space>%><Enter><Enter><%<Space>end<Space>%><Esc>2k$F%hi<Space>

" Color scheme
" ============
	colorscheme solarized
	let g:solarized_termtrans=1
"	This setting removes the dark background from most of the letters.
	set bg=dark
"	This setting makes the background transparent
	hi Normal guibg=NONE ctermbg=NONE
