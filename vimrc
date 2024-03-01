""""""""""""""""""""""""""""""""""""""""""""""""""
""	  __   __ (_)  _ __ ___    _ __    ___ """
""	  \ \ / / | | | '_ ` _ \  | '__|  / __|"""
"" 	   \ V /  | | | | | | | | | |    | (__ """
""  	    \_/   |_| |_| |_| |_| |_|     \___|"""
""""""""""""""""""""""""""""""""""""""""""""""""""  
			
set mouse=r
set wildmenu
set wildmode=list:longest,full
set number 			"Line numbers are good
set number relativenumber 	"Hiblid line numers
syntax on              "turn on syntax highlighting
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set incsearch			"Incremental search
set hlsearch			"highlight search results
set autowrite			"save changes when vim automatically switch buffers
set ignorecase			"case insesitive search
set smartcase			"smart case insensitive search
setglobal spell spelllang=en_us,el 	"set spell language
colorscheme delek

" Vim-plug autoinstall
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Vim-plug 
call plug#begin('~/.vim/bundle')
" Declare the list of plugins
Plug 'scrooloose/nerdtree'
Plug 'itchyny/calendar.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'iamcco/markdown-preview.vim'
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'
Plug 'inside/vim-search-pulse'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug '907th/vim-auto-save'
Plug 'lifepillar/vim-cheat40'
Plug 'romainl/vim-cool'
"Plug 'RRethy/vim-illuminate'
"Plug 'xolox/vim-notes'
"Plug 'xolox/vim-misc'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"	         _             _           
"	   _ __ | |_   _  __ _(_)_ __  ___ 
"	  | '_ \| | | | |/ _` | | '_ \/ __|
"	  | |_) | | |_| | (_| | | | | \__ \
"	  | .__/|_|\__,_|\__, |_|_| |_|___/
"	  |_|            |___/             
"

" Vim cheat sheat
" <leader> + ? 
" <\> + ?

" Time Date maping 
iab xdate <c-r>=strftime("%d/%m/%y %H:%M")<cr>

" Spell togle
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <Leader>s :call ToggleSpellCheck()<CR>
"nmap <silent> <leader>s :set spell!<CR>

"VIM autosave
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" Rainbow parenthesis
let g:rainbow_active = 1 "rainbow can the toggled using :RainbowToggle

" vim cool
let g:CoolTotalMatches = 1

" Search pulse
let g:vim_search_pulse_duration = 200 "The pulse duration can be customized to user’s taste.

" Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
if !has('gui_running')
	set t_Co=256
endif

"Airline vim
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1
"let g:airline_theme='powerlineish'
"let g:airline_solarized_bg='dark'

"Swap and close buffers quickly
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
":nnoremap <C-X> :bdelete<CR>

" NerdTree
" start NerdTree
map <C-n> :NERDTreeToggle<CR>
" autoclose nerdtree
let NERDTreeQuitOnOpen = 1
" quit nerdtree if last window   
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
" NERDTree minimal
let NERDTreeMinimalUI = 1

" Markdown Preview
"let g:mkdp_path_to_chrome = ""
    " path to the chrome or the command to open chrome(or other modern browsers)
    " if set, g:mkdp_browserfunc would be ignored

"let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
    " callback vim function to open browser, the only param is the url to open

"let g:mkdp_auto_start = 0
    " set to 1, the vim will open the preview window once enter the markdown buffer

"let g:mkdp_auto_open = 0
    " set to 1, the vim will auto open preview window when you edit the markdown file

let g:mkdp_auto_close = 1
    " set to 1, the vim will auto close current preview window when change from markdown buffer to another buffer

let g:mkdp_refresh_slow = 0
    " set to 1, the vim will just refresh markdown when save the buffer or leave from insert mode, default 0 is auto refresh markdown as you edit or move the cursor

"let g:mkdp_command_for_global = 0
    " set to 1, the MarkdownPreview command can be use for all files, by default it just can be use in markdown file

"let g:mkdp_open_to_the_world = 0
    " set to 1, preview server available to others in your network by default, the server only listens on localhost (127.0.0.1)
nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode
 
" Vim Notes
"filetype plugin on
":let g:notes_directories = ['/home/xoulis/Notes']

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
