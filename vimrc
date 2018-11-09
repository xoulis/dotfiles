set mouse=r
set wildmenu
set wildmode=list:longest,full
" set number 			"Line numbers are good
syntax on              "turn on syntax highlighting
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom

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

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
if !has('gui_running')
	set t_Co=256
endif

" Time maping 
" map <F5> <C-R>=strftime("%a %d %b %Y")<CR>
" map <F5> "=strftime("%a %d %b %Y")<CR>P
map <F5> <C-R>=strftime("%d/%m/%y ")<CR>P
map! <F5> <C-R>=strftime("%d/%m/%y ")<CR>

"NerdTree
"start NerdTree
map <C-n> :NERDTreeToggle<CR>
" autoclose nerdtree
let NERDTreeQuitOnOpen = 1
" quit nerdtree if last window   
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
" NERDTree minimal
let NERDTreeMinimalUI = 1

"Airline vim
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='powerlineish'
"let g:airline_solarized_bg='dark'

" Powerline
"let g:powerline_pycmd="py3"
"let $PYTHONPATH='/usr/lib/python3.5/site-packages'
"set laststatus=2

"Markdown Preview
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

"let g:mkdp_refresh_slow = 0
    " set to 1, the vim will just refresh markdown when save the buffer or leave from insert mode, default 0 is auto refresh markdown as you edit or move the cursor

"let g:mkdp_command_for_global = 0
    " set to 1, the MarkdownPreview command can be use for all files, by default it just can be use in markdown file

"let g:mkdp_open_to_the_world = 0
    " set to 1, preview server available to others in your network by default, the server only listens on localhost (127.0.0.1)

nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode
