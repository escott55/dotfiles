" Modeline and Notes {{{1
" vim: foldlevel=0 foldmethod=marker:
"
"   This is the personal .vimrc file of Eric Scott.
"
"   Online example vimrc files were helpful in constructing this file
"   mcandre has some pragmatic mappings and an organized set of options
"   https://github.com/mcandre/dotfiles/blob/master/.vimrc
" }}}

"############################# VUNDLE SETTINGS #################################

" Plugin Install Help {{{1
"steps to install a plugin
"  1. add it to you .vimrc between call vundle#begin() and call vundle#end()
"  2. save the .vimrc
"  3. type <ESC>:PluginInstall<CR>
"to update the plugins
"  1. type <ESC>:PluginInstall!<CR> or <ESC>:PluginUpdate<CR>
" to remove a plugin
"  1. remove it from the .vimrc
"  2. save the .vimrc
"  3.type <ESC>:PluginClean<CR>
"  }}}

" Initialize Vundle {{{1
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
" https://www.digitalocean.com/community/tutorials/how-to-use-vundle-to-manage-vim-plugins-on-a-linux-vps
set nocompatible              " required

" vundle needs filtype plugins off
" i turn it on later
filetype plugin indent off
syntax off

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Initialize Vundle Plugins {{{2
" can pass a path where Vundle should install plugins here
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" filesystem navigation The-NERD-tree
Plugin 'scrooloose/nerdtree.git'
map <F2> :NERDTreeToggle<cr>

" Auto-complete
Plugin 'Valloric/YouCompleteMe'
" ensures that the autocomplete window goes away when you’re done with it
"let g:ycm_autoclose_preview_window_after_completion=1
" defines a shortcut for goto definition
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Source code browser for c/c++,java,perl,python,tcl,sql,php
Plugin 'taglist.vim'
map <F4> :TlistToggle<cr>

" Upgraded status tabline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" provide tab completion to satisfy all your insert completion needs
" Usage :help ins-completion
Plugin 'ervandew/supertab'

" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'

" Folding Python code
" Its fine, but I dont want it to fold my function definitions
"Plugin 'tmhedberg/SimpylFold'

" Script for easy commenting
Plugin 'scrooloose/nerdcommenter'

" Git wrapper for vim
" Need to incorporate this in the workflow later
"Plugin 'tpope/vim-fugitive'

" Makes a colorscheme menu
"Plugin 'ColorSchemeMenuMaker'

" Molokai colorscheme
Plugin 'tomasr/molokai'

" Distinguished colorscheme
Plugin 'Lokaltog/vim-distinguished'

" Solarized colorscheme
Plugin 'altercation/vim-colors-solarized'

" Hybrid colorscheme
Plugin 'w0ng/vim-hybrid'

" BadWolf colorscheme
Plugin 'sjl/badwolf'

call vundle#end()            
" }}} End Plugin initialization

filetype plugin indent on    
syntax on
" }}} Vundle End

"########################### CONFIGURATION SETTINGS ############################

" Set Basic Global attributes {{{1
"set ttyfast " fast terminal connection
"set number " show number of lines
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set encoding=utf-8
"set textwidth=79 " Limit the width of the code to 80 characters...
" }}}

" Color Scheme Settings {{{1
set t_Co=256 " use 256 colors
set background=dark " We're basically always in terminal so...
colorscheme hybrid
"colorscheme default
"colorscheme molokai
"colorscheme distinguished
"colorscheme badwolf
" Solarized configuration
"let g:solarized_termcolors=256	"16 | 256
"let g:solarized_contrast="high"		"\"normal\"| \"high\" or \"low\"
"let g:solarized_visibility="high"	"\"normal\"| \"high\" or \"low\"
"colorscheme solarized
"}}}

" Toggle ability to Paste Code without automatic indentation {{{1
set pastetoggle=<F3>
"}}}

" Toggle Tabs - allowing space and default tabs {{{1
" allow toggling between local and default mode
function! TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    execute "set shiftwidth=".g:my_tab
    execute "set softtabstop=".g:my_tab
    set expandtab
  endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z
"}}}

" Set Highlighting Options {{{1
set hlsearch
" Highligh characters after column 80 marker {{{2
highlight OverLength ctermbg=darkred ctermfg=white guibg=#660000
match OverLength /\%81v.\+/
" }}}
" Flag unnecessary whitespace {{{2
highlight ExtraWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match ExtraWhitespace /\s\+$/
" }}}
" }}}

" Remap keyboard common commands to simpler keys {{{1
nnoremap <space> zz	" Map recenter to space
nnoremap n nzz 		" Find next search term using n
nnoremap N Nzz 		" Find previous search term using N
"}}}

" Set Syntastic recommended settings {{{1
" Help with Syntastic
" http://vimawesome.com/plugin/syntastic
" :help syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

" Set Spellchecking options {{{1
autocmd BufRead,BufNewFile *.tex call texSpellingOptions()
autocmd BufRead,BufNewFile *.md setlocal spell | 
"autocmd FileType gitcommit call texSpellingOptions()
function TexSpellingOptions()
	"setlocal spell
	setlocal spelllang=en_gb spell
	let g:tex_comment_nospell=1
endfunction
" }}}

" Folding code configuration {{{1
" SimpylFold was a bit too simple...
" https://github.com/tmhedberg/SimpylFold " :help fold-commands 
"let g:SimpylFold_docstring_preview = 1
"autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
"autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
set foldmethod=syntax
set foldnestmax=1
set foldignore=		" Set ignore to be nothing so that comments are folded

let g:vim_markdown_folding_disabled=1 " Markdown
let javaScript_fold=1                 " JavaScript
let perl_fold=1                       " Perl
let php_folding=1                     " PHP
let r_syntax_folding=1                " R
let ruby_fold=1                       " Ruby

"autocmd FileType python setlocal foldmethod=indent
"autocmd FileType java setlocal foldmethod=indent
"autocmd FileType bash setlocal foldmethod=syntax
nnoremap f za 		" Map fold toggle to f
"vnoremap f zf		" Map visual folding to f
"}}}

" Airline configuration {{{1
"let g:airline_section_b = '%{strftime("%c")}'
"let g:airline_section_y = 'BN: %{bufnr("%")}'
set laststatus=2 	" Has to be on for some reason
set ttimeoutlen=50	" Refersh time
let g:airline_powerline_fonts = 1
let g:airline_theme='distinguished'
"}}}

" NERD commenter configuration. Mostly key remappings {{{1
" http://vimawesome.com/plugin/the-ner d-commenter
nmap <silent> <C-C> \cs " Map commenting to control c
nmap <silent> <C-X> \cu " Map uncommenting to control x
nmap <silent> <C-A> \ca " Map comment appending to control a
vmap <silent> <C-C> \cs " Map visual commenting to control c
vmap <silent> <C-X> \cu " Map uncommenting to control x
" }}}

" ~/.vimrc ends here
