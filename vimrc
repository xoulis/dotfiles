set mouse=a
execute pathogen#infect()

filetype plugin indent on
syntax on              "turn on syntax highlighting
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
if !has('gui_running')
	set t_Co=256
endif

" map <F5> <C-R>=strftime("%a %d %b %Y")<CR>
" map <F5> "=strftime("%a %d %b %Y")<CR>P
map <F5> "=strftime("%d/%m/%y ")<CR>P
map <C-n> :NERDTreeToggle<CR>
" autoclose nerdtree
let NERDTreeQuitOnOpen = 1
" quit nerdtree if last window   
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
" NERDTree minimal
let NERDTreeMinimalUI = 1

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
