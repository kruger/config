version 6.0
"------------------------------------------
"  Scott Kruger's .vimrc file 
"  (based on Sven Gucke's file)
"  This is a good intro to stuff:
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven
" https://www.youtube.com/channel/UCpdsZ1n09mwrbUGmU7lqnqA
" See neovim:
"   https://www.youtube.com/watch?v=LRQGAnPtNdM
"------------------------------------------
:filetype off
set nocompatible 			 " Let Vim behave like Vi?  Hell, no!
set encoding=utf-8

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/plugin

" If you comment out a Vundle below, definitely do a 
" VundleClean; VundleInstall
" otherwise it sticks around

""" I got these from Damian Conway's github repo 
"See: https://www.youtube.com/watch?v=aHm36-na4-4&feature=youtu.be
"plugin/autoswap_mac_linux.vim
"plugin/hlnext.vim
"plugin/listtrans.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" GIT integration
Plugin 'tpope/vim-fugitive'

" https://github.com/tpope/vim-repeat
Plugin 'tpope/vim-repeat'

" tpope da man
Plugin 'tpope/vim-obsession'

" https://github.com/rudrab/vimf90
"Plugin 'rudrab/vimf90'

" See documentation
Plugin 'christoomey/vim-tmux-navigator'

" https://github.com/mhinz/vim-grepper
Plugin 'mhinz/vim-grepper'
let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'ag', 'grep']

" Mini-buff explorer -- So important
" https://github.com/weynhamz/vim-plugin-minibufexpl
"Plugin 'weynhamz/vim-plugin-minibufexpl'
" This is confusing
"Plugin 'fholgado/minibufexpl'

" https://github.com/geoffharcourt/vim-matchit
Plugin 'geoffharcourt/vim-matchit'

" Also see this thread:
" https://www.reddit.com/r/vim/comments/26mszm/what_is_everyones_favorite_commenting_plugin_and/
" https://github.com/scrooloose/nerdcommenter
Plugin 'scrooloose/nerdcommenter' 
Plugin 'scrooloose/nerdtree'

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" This does fuzzy search after hitting <CTRL-P>
" Lots of people like this, but I prefer fzf 
"Plugin 'kien/ctrlp.vim'

" For git diff -- this is really awesome
" https://vimawesome.com/plugin/vim-gitgutter
Plugin 'airblade/vim-gitgutter'

" This is used by vim-airline if you want to have buffers shown in statusline
" I've switched to buffers in tabline
"Plugin 'bling/vim-bufferline'

" This is for airline-tabline extension
" https://github.com/vim-ctrlspace/vim-ctrlspace
Plugin 'vim-ctrlspace/vim-ctrlspace'
" Neovim only?
let g:CtrlSpaceDefaultMappingKey = "<C-space>"
" Important ?
set showtabline=0
set hidden                         " Use if you don't autowrite
if executable('rg')
    let g:CtrlSpaceGlobCommand = 'rg --color=never --files'
elseif executable('fd')
    let g:CtrlSpaceGlobCommand = 'fd --type=file --color=never'
elseif executable('ag')
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
" This is OS specific
let g:CtrlSpaceFileEngine = '~/.vim/bundle/vim-ctrlspace/bin/file_engine_darwin_amd64'



" Awesome statusbar
" https://vimawesome.com/plugin/vim-airline 
"
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Buffers in tab are superior I think
"let g:airline_section_c='bufferline'
"let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Is this needed for ctrl-space functionality?
let g:airline_exclude_preview = 1

" This is faster and more customizable -- but I don't have time to figure out
"Plugin 'rbong/vim-crystalline'

" Linter
" https://github.com/w0rp/ale
Plugin 'w0rp/ale'

" See this
" https://majutsushi.github.io/tagbar/
" https://www.reddit.com/r/vim/comments/2k9lnm/is_there_a_highquality_restructuredtext_plugin/
" https://vimawesome.com/plugin/tagbar
"
Plugin 'preservim/tagbar'
let g:tagbar_position="topleft vertical"

Plugin 'vim-scripts/taglist.vim'
let g:Tlist_Ctags_Cmd='/opt/homebrew/bin/ctags'

"gtags
"Plugin 'vim-scripts/gtags.vim'

" https://vimawesome.com/plugin/tabular 
Plugin 'godlygeek/tabular'

" Impressive python scratchpad.
" https://github.com/metakirby5/codi.vim
Plugin 'metakirby5/codi.vim'


" Python plugins
Plugin 'tmhedberg/SimpylFold'    " For python folding
Plugin 'vim-scripts/indentpython.vim'


" See: 
" https://www.reddit.com/r/vim/comments/5w6wac/vim_users_of_reddit_whats_your_favorite/
"https://github.com/ajh17/VimCompletesMe
" This isn't as featurefull as YouCompleteMe or Jedi
"Plugin 'ajh17/VimCompletesMe'

""" Some like this the best nvim-completion-manager for python
" I need to figure out how to configure
"Plugin 'davidhalter/jedi-vim'


" See: https://github.com/Valloric/YouCompleteMe for feature list
" Plugin 'Valloric/YouCompleteMe' 

"let g:ycm_autoclose_preview_window_after_completion=1
" From https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/:
"   My leader key is mapped to space, so space-g 
"   will goto definition of whatever I’m currently on. "
"    Helpful when exploring new code.
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


""" Does targets within brackets
Plugin 'wellle/targets.vim'


" Pretty impressive
"https://github.com/itchyny/calendar.vim
Plugin 'itchyny/calendar.vim'

" This one has hooks 
"https://github.com/mattn/calendar-vim
"Plugin 'mattn/calendar-vim'


"""
" By hand:
" cd ~/.vim/bundle; git clone https://github.com/scrooloose/nerdtree.git
 
" Latex
Plugin 'lervag/vimtex'

"RST
" https://github.com/Rykka/riv.vim
"let g:riv_fold_auto_update=0
"let g:riv_fold_level=9
Plugin 'Rykka/riv.vim'
"let g:riv_fold_auto_update=0
"let g:riv_fold_level=0

let proj1 = { 'path': '~/ptsolveall/ptsolvedocs',}
let g:riv_projects = [proj1]

Plugin 'Rykka/InstantRst'


" Color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

"  https://github.com/tomasiser/vim-code-dark
"  To use: colorscheme codedark
Plugin 'tomasiser/vim-code-dark'

" ===================================================================
" Mappings:  I change these most often so put it at the front of file
" SEE :h modes for differences between map,nmap,vmap,imap,...

" Caveat:  Mapping must be "prefix free", ie no mapping must be the
" prefix of any other mapping.  Example:  "map ,abc foo" and
" "map ,abcd bar" will give you the error message "Ambigous mapping".
"
 " The backslash ('\') is the only(?) unmapped key, so this is the best
  " key to start mappings with as this does not take away a command key.
 " However, the backslash is never in the same position with keyboards.
 " Anyway, I have decided to start mappings with the comma as this
 " character is always on the same position on almost all keyboards
 " and I hardly have a need for that command.
 "
" # For use in Maps
" <A-...>		same as <M-...>			*<A-*
" <CR>             : carriage Return for maps
" <ESC>            : Escape
" <LEADER>         : normally \
" <BAR>            : | pipe
" ===================================================================

set guioptions+=f


"
" -------------------------------------------------------------------
" General Editing
" -------------------------------------------------------------------
"  As an alternative to autochdir, give mapping to change to same directory as
"  file and then print current directory
nnoremap ,,cd :cd %:p:h<CR>:pwd<CR>

"
" I find that these strange combinations do A LOT
nmap <M-j> j0.
nmap <M-n> n.
nmap <M-l> j$.

" vimdiff mappings
 nmap ,g :diffget<CR>
 nmap ,h :diffput<CR>
 nmap ,n ]c
 nmap ,c [c

" Map Alt-< and Alt-> in Normal mode to upward and downward searching for 
" lines with the same indent as the current line.
nn <M-,> k:call search ("^". matchstr (getline (line (".")+ 1), '\(\s*\)') ."\\S", 'b')<CR>^ 
nn <M-.> :call search ("^". matchstr (getline (line (".")), '\(\s*\)') ."\\S")<CR>^ 

" The command {number}CTRL-G show the current buffer number, too.
" As I always want to see the buffer number I map it to CTRL-G.
" Please note that here we need to prevent a loop in the mapping by
" using the comamnd "noremap"!
  noremap <C-G> 2<C-G>

 nmap ,,9 :set foldlevel=9<CR>
 nmap ,,0 :set foldlevel=0<CR>
 nmap ,,1 :set foldlevel=1<CR>

" -------------------------------------------------------------------
"  Files to edit and source quickly
" -------------------------------------------------------------------
"  Get to the configuration files quickly
 nmap ,,rc :e ~/.vimrc<CR>
 nmap ,,src :so ~/.vimrc<CR>

"  These files contain useful info. Need to reference quickly like help
 nmap ,,t :e ~/config/tips/<CR>

map ,,ad :e ~/.addresses<CR>
map ,,cal :Calendar -view=year -split=horizontal -position=below -height=12<CR>

" -------------------------------------------------------------------
" Moving around
" -------------------------------------------------------------------
" Note that :close closes the windows
" I'm overwritting some mappings here, but I don't use them much
" This is now handled by tmux plugin above
"nmap <C-h> <C-W>h				" Move left one window
"nmap <C-j> <C-W>j				" Move up one window 
"nmap <C-k> <C-W>k				" Move down one window
"nmap <C-l> <C-W>l				" Move right one window
"nmap <C-h> <C-W>h<C-W>_		" Move left one window and maximize
"nmap <C-j> <C-W>j<C-W>_		" Move up one window and maximize
"nmap <C-k> <C-W>k<C-W>_		" Move down one window and maximize
"nmap <C-l> <C-W>l<C-W>_		" Move down one window and maximize

" Moving between buffers
" Note that :bd deletes the buffer
" Note that :only  will give you only the current window
" Overwriting original defs, but I use j,k instead
nmap <C-n> :bn<CR> 	" Next buffer in list
nmap <C-p> :bp<CR> 	" Previous buffer in list
nmap <C-#> :b#<CR> 	" Previous buffer you were in
nmap <C-3> :b#<CR> 	" Previous buffer you were in

 " Jump to a specific buffer number
 map <M-9> :b9<CR>
 map <M-8> :b8<CR>
 map <M-7> :b7<CR>
 map <M-6> :b6<CR>
 map <M-5> :b5<CR>
 map <M-4> :b4<CR>
 map <M-3> :b3<CR>
 map <M-2> :b2<CR>
 map <M-1> :b1<CR>
 map <M-0> :b0<CR>
 imap <M-9> <Esc>b9<CR>
 imap <M-8> <Esc>b8<CR>
 imap <M-7> <Esc>b7<CR>
 imap <M-6> <Esc>b6<CR>
 imap <M-5> <Esc>b5<CR>
 imap <M-4> <Esc>b4<CR>
 imap <M-3> <Esc>b3<CR>
 imap <M-2> <Esc>b2<CR>
 imap <M-1> <Esc>b1<CR>
 imap <M-0> <Esc>b0<CR>
 
" -------------------------------------------------------------------
"  Keyboard mapping stuff
" -------------------------------------------------------------------

" make space move the cursor to the right - much better than a *beep*
 nmap \  l
" Quick insertion of an empty line:
 nmap <CR> o<ESC>

" when the backspace key sends a "delete" character
" then you simply map the "delete" to a "backspace" (CTRL-H):
" map <Del> <C-H>

" Disable the suspend for ^Z.
  map <C-Z> :shell

" Obvious mappings
 map <PageUp>   <C-B>
 map <PageDown> <C-F>

"These are command-line mappings.  
" I like keyboard mappings in command-line to act like tcsh w/ emacs
" bindings (although it is possible to make tcsh act like vi)
 cnoremap <C-A> <Home>
 cnoremap <C-F> <Right>
" cnoremap <C-B> <Left>
 cnoremap <C-D> <C-H>
 cnoremap <M-b> <S-Left>
 cnoremap <M-f> <S-Right>

 "I like to leave all my buffers at once
 cnoremap <C-w> bufdo w!<CR><CR>
 "cnoremap <C-q> bufdo q

" This is for taglist
  nnoremap <silent> <F9> :TlistSync<CR>

" -------------------------------------------------------------------
" These comment highlighted sections
"  Deprecated in favor of nerdcommenter plugin above
" -------------------------------------------------------------------
"map ,# :s/^/#/<CR>
"map ,/ :s/^/\/\//<CR>
"map ,> :s/^/> /<CR>
"map ," :s/^/\"/<CR>
"map ,% :s/^/%/<CR>
"map ,! :s/^/!/<CR>
"map ,7 :s/^/c/<CR>
"map ,; :s/^/;/<CR>
"map ,- :s/^/--/<CR>
"map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;c]//<CR>

" wrapping comments
"map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>
"map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>
"map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>
"map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>


" -------------------------------------------------------------------
" nice examples. 
" -------------------------------------------------------------------
"      ,rcm = remove "control-m"s - for those mails sent from DOS:
"      SEK: (doesn't seem to work?)
  cmap ,m %s/<C-V><C-M>//g
"
"     Make whitespace visible:
"     Sws = show whitespace
  nmap ,Sws :%s/ /_/g<C-M>
  vmap ,Sws :%s/ /_/g<C-M>  "My vmap's have problems with colons
"
"     Sometimes you just want to *see* that trailing whitespace:
"     Stws = show trailing whitespace
  nmap ,Stws :%s/  *$/_/g<C-M>
  vmap ,Stws :%s/  *$/_/g<C-M>

:vmap sb "zdi<b><C-R>z</b><ESC> : wrap <b></b> around VISUALLY selected Text
:vmap st "zdi<?= <C-R>z ?><ESC>  : wrap <?=   ?> around VISUALLY selected Text

"
"     ,tr = transpose two characters: from aXb -> bXa
 map ,tr XplxhhPl

" _Y: Yank the highlighted block of text (or a single line) to a tmp file.
" _P: Put the text yanked with \_Y (possibly in another invocation of Vim).
" Might be useful to use function keys here
" :map   <f12>  
nmap    _Y      :.w! /tmp/vi_tmp<CR>
vmap    _Y      :w! /tmp/vi_tmp<CR>
nmap    _P      :r /tmp/vi_tmp<CR>

 
" ===================================================================
" Abbreviations:
" ===================================================================
"
":una[bbreviate] <lhs>   remove abbreviation for <lhs> from the list
":norea[bbrev] [lhs] [rhs]
"                        same as ":ab", but no remapping for this <rhs> {not
"                        in Vi}
":ca[bbrev] [lhs] [rhs]  same as ":ab", but for Command-line mode only.  {not
"                        in Vi}
":cuna[bbrev] <lhs>      same as ":una", but for Command-line mode only.  {not
"                        in Vi}
":cnorea[bbrev] [lhs] [rhs]
"                        same as ":ab", but for Command-line mode only and no
"                        
":ia[bbrev] [lhs] [rhs]  same as ":ab", but for Insert mode only.  {not in Vi}
":iuna[bbrev] <lhs>      same as ":una", but for insert mode only.  {not in
"                        Vi}
":inorea[bbrev] [lhs] [rhs]
"                        same as ":ab", but for Insert mode only and no
"                        remapping for this <rhs> {not in Vi}
":abc[lear]              Remove all abbreviations.  {not in Vi} 
":iabc[lear]             Remove all abbreviations for Insert mode.  {not in Vi}
":cabc[lear]             Remove all abbreviations for Command-line mode.  {not
"                        in Vi} 
" ===================================================================

" Abbreviations for some important numbers:
  iab Npi 3.1415926535897932384626433832795028841972
  iab Ne  2.7182818284590452353602874713526624977573
"
"     Yruler : A ruler.
  iab Yruler 1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
"
"     Ysesqui : "Sesquipedalophobia" means "fear of big words."  ;-)
  iab Ysesqui    sesquipedalophobia
"
" Correcting those typos. [I almost never get these right.  :-(]
  iab teh       the
  iab alos      also
  iab aslo      also
  iab bianry    binary
  iab bianries  binaries
  iab charcter  character
  iab charcters characters
  iab exmaple   example
  iab exmaples  examples
  iab shoudl    should
  iab seperate  separate
  iab tpyo      typo

" -------------------------------------------------------------------
" Inserting Dates and Times
" -------------------------------------------------------------------
"  iab Ydate <C-R>=strftime("%y%m%d")<CR>
" Example: 971027
"


  iab Ytime <C-R>=strftime("%H:%M")<CR>
" Example: 14:28
"
  iab YDT   <C-R>=strftime("%Y-%m-%d")<CR>
"
  iab YDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
" Example: Tue Dec 16 12:07:00 CET 1997

"==========================================================
" Very advanced
"==========================================================
" I like the tags file to be hidden.  For ctags use:
"  ctags -o .tags .
  set tags=.tags;
"  set tags+=tags;/
  let Tlist_Ctags_Cmd="ctags"

"------------------------------------------
"  FILETYPES
" Filetypes control various things for different types of files
" See ~/.vim/filetype.vim
" This stuff doesn't always work:
"------------------------------------------

 " vim has an directory explorer as a plugin (I like :Sexplore)
  let g:explVertical=1		" Split vertically
  let g:explStartRight=0    " Put new explorer window to the left of the
			    		" current window
" vundle:
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" :filetype on
" :filetype plugin indent on

" Use bundles above
" Python.  Not sure if this will conflict with ftdetect
" Note that PEP89 recommends 4 spaces, but Tx standard is 2
"au BufNewFile,BufRead *.py
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/




" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch
highlight Normal guibg=Black guifg=White
set background=dark
set title
set titleold=""

" Disable the spelling plugin by default
let spell_auto_type = "tex,mail,text,html,sgml,otl,cvs,none"
" ===================================================================
"  Various settings
" ===================================================================
  set clipboard=unnamed             " This uses the system clipboard on Mac
  set smarttab
  set tabstop=4
  set expandtab 		             "This changes tabs to spaces
  "set listchars=tab:>~,nbsp:+,trail:.
  "set list
  set nosmartindent
  set autoindent
  "set autochdir				 " Change local directory automatically to current
  set shiftwidth=4                   " # of spaces to use for (auto)indent.
  set hidden                         " Use if you don't autowrite
  set autowrite                      " Save changes before going to next file
  set mousehide                      " Hide the mouse pointer while typing
  set incsearch                      " Search as you type
  set magic                          " Use (extended regular expressions)
                                     "  in search patterns
  set ignorecase                     " ignore the case in search patterns? 
  set smartcase                      " Use case if user uses
  set scrolloff=5                    " Let me always have context     
  set whichwrap=<,>                  " Determine which direction keys will wrap
  set wrapmargin=10			         " Distance from edge to begin wrap

  set ruler                          " Show the position of the cursor.
  set laststatus=2                   " Display a status-bar.
  set showmode                       " Show the current mode
" This is replaced by vim-airline above -- it's awesome
"       statusline:  customize contents of the windows' status line.
"       Show the current buffer number and filename with info on
"       modification, read-only, and whether it is a help buffer
"       (show only when applied).
"       On right side, show current position with line+column+virtual_column:
" set   statusline=[%n]\ %f\ %(\ %M%R%H)%)%=%l\,%c%V\ %P
 set wmh=0 					"sets minumum window height

  set showmatch                      " Show matching parenthese.
  set viminfo=%,'50,\"100,:100,n~/.viminfo  " read/write a .viminfo file, 
                                     " don't store >50 lines of registers
  set history=50                     " keep 50 lines of command line history
  set nobackup 			       " backups are for wimps  ;-)
  set backspace=2 			 " '2' is much smarter.->"help backspace"
  set comments=b:#,:%,fb:-,n:>,n:)   " comments default
  set dictionary=/usr/dict/words 	 " dictionary
  set noerrorbells 			 " errorbells: damn this beep!  ;-)
  set esckeys 				 " allow cursor keys within insert mode
  set   helpheight=0                 " zero disables this.
  "set nohlsearch " highlight search - show the current search pattern
  "change highlighting (space to get rid of after search)
  noremap <silent> <Space> :silent noh<Bar>echo<CR>
  set noinsertmode
  set lazyredraw                     " don't update screen whil executing macros
  set textwidth=80
  set colorcolumn=81
  set nonumber                       " Number the lines
  set path=.,$HOME,$HOME/.vim        " list of directories to search when 
                                     "  you specify file with edit command.
  set report=10                      " show a report when N lines were changed.
  set shell=/bin/tcsh
  set noshowcmd                      " Show current uncompleted command?  
  set splitbelow                    " Where to put the window
"  set splitright                     "  when splitting
"                             Ignore filename with any of these suffixes
"                             when using the ":edit" command.
  set   suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar

"       startofline:  no:  do not jump to first character with page
"       commands, ie keep the cursor in the current column.
  set nostartofline
  set notextmode                    " no - I am using Vim on UNIX!
  set   novisualbell
  set   t_vb=                       " terminal's visual bell 
                                    "   - turned off to make Vim quiet!
  set   wildchar=<TAB>              " char used for "expansion" on the 
                                    "  command line
  set wildignore=*.o,*.bak,*.mod
  " This has to do with writing to swap.  Useful for taglist
  set updatetime=1000			" In msec
"==========================================================
" Things I don't understand very well
"==========================================================
  set formatoptions=cqrt            " Options for "text format" command ("gq")

"  set   modeline                   " Allow last line to be a modeline 
"  set   modelines=1                " 
"  set   highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws
"  set   iskeyword=@,48-57,_,192-255,-,.,@-@
"  set   joinspaces                   " insert two spaces after a 
                                      " period with every joining of lines.
" set   keywordprg=man\ -s            Program to use for the "K" command.
"  set   pastetoggle=<f11>
  set   shortmess=at                " Kind of messages to show.

   
" ===================================================================
" ASCII tables - you may need them some day.  Save them to a file!
" ===================================================================
"
" ASCII Table - | octal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |010 bs |011 ht |012 nl |013 vt |014 np |015 cr |016 so |017 si |
" |020 dle|021 dc1|022 dc2|023 dc3|024 dc4|025 nak|026 syn|027 etb|
" |030 can|031 em |032 sub|033 esc|034 fs |035 gs |036 rs |037 us |
" |040 sp |041  ! |042  " |043  # |044  $ |045  % |046  & |047  ' |
" |050  ( |051  ) |052  * |053  + |054  , |055  - |056  . |057  / |
" |060  0 |061  1 |062  2 |063  3 |064  4 |065  5 |066  6 |067  7 |
" |070  8 |071  9 |072  : |073  ; |074  < |075  = |076  > |077  ? |
" |100  @ |101  A |102  B |103  C |104  D |105  E |106  F |107  G |
" |110  H |111  I |112  J |113  K |114  L |115  M |116  N |117  O |
" |120  P |121  Q |122  R |123  S |124  T |125  U |126  V |127  W |
" |130  X |131  Y |132  Z |133  [ |134  \ |135  ] |136  ^ |137  _ |
" |140  ` |141  a |142  b |143  c |144  d |145  e |146  f |147  g |
" |150  h |151  i |152  j |153  k |154  l |155  m |156  n |157  o |
" |160  p |161  q |162  r |163  s |164  t |165  u |166  v |167  w |
" |170  x |171  y |172  z |173  { |174  | |175  } |176  ~ |177 del|
"
" ===================================================================
" ASCII Table - | decimal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |008 bs |009 ht |010 nl |011 vt |012 np |013 cr |014 so |015 si |
" |016 dle|017 dc1|018 dc2|019 dc3|020 dc4|021 nak|022 syn|023 etb|
" |024 can|025 em |026 sub|027 esc|028 fs |029 gs |030 rs |031 us |
" |032 sp |033  ! |034  " |035  # |036  $ |037  % |038  & |039  ' |
" |040  ( |041  ) |042  * |043  + |044  , |045  - |046  . |047  / |
" |048  0 |049  1 |050  2 |051  3 |052  4 |053  5 |054  6 |055  7 |
" |056  8 |057  9 |058  : |059  ; |060  < |061  = |062  > |063  ? |
" |064  @ |065  A |066  B |067  C |068  D |069  E |070  F |071  G |
" |072  H |073  I |074  J |075  K |076  L |077  M |078  N |079  O |
" |080  P |081  Q |082  R |083  S |084  T |085  U |086  V |087  W |
" |088  X |089  Y |090  Z |091  [ |092  \ |093  ] |094  ^ |095  _ |
" |096  ` |097  a |098  b |099  c |100  d |101  e |102  f |103  g |
" |104  h |105  i |106  j |107  k |108  l |109  m |110  n |111  o |
" |112  p |113  q |114  r |115  s |116  t |117  u |118  v |119  w |
" |120  x |121  y |122  z |123  { |124  | |125  } |126  ~ |127 del|
"
" ===================================================================
" ASCII Table - | hex value - name/char |
"
" | 00 nul| 01 soh| 02 stx| 03 etx| 04 eot| 05 enq| 06 ack| 07 bel|
" | 08 bs | 09 ht | 0a nl | 0b vt | 0c np | 0d cr | 0e so | 0f si |
" | 10 dle| 11 dc1| 12 dc2| 13 dc3| 14 dc4| 15 nak| 16 syn| 17 etb|
" | 18 can| 19 em | 1a sub| 1b esc| 1c fs | 1d gs | 1e rs | 1f us |
" | 20 sp | 21  ! | 22  " | 23  # | 24  $ | 25  % | 26  & | 27  ' |
" | 28  ( | 29  ) | 2a  * | 2b  + | 2c  , | 2d  - | 2e  . | 2f  / |
" | 30  0 | 31  1 | 32  2 | 33  3 | 34  4 | 35  5 | 36  6 | 37  7 |
" | 38  8 | 39  9 | 3a  : | 3b  ; | 3c  < | 3d  = | 3e  > | 3f  ? |
" | 40  @ | 41  A | 42  B | 43  C | 44  D | 45  E | 46  F | 47  G |
" | 48  H | 49  I | 4a  J | 4b  K | 4c  L | 4d  M | 4e  N | 4f  O |
" | 50  P | 51  Q | 52  R | 53  S | 54  T | 55  U | 56  V | 57  W |
" | 58  X | 59  Y | 5a  Z | 5b  [ | 5c  \ | 5d  ] | 5e  ^ | 5f  _ |
" | 60  ` | 61  a | 62  b | 63  c | 64  d | 65  e | 66  f | 67  g |
" | 68  h | 69  i | 6a  j | 6b  k | 6c  l | 6d  m | 6e  n | 6f  o |
" | 70  p | 71  q | 72  r | 73  s | 74  t | 75  u | 76  v | 77  w |
" | 78  x | 79  y | 7a  z | 7b  { | 7c  | | 7d  } | 7e  ~ | 7f del|
" ===================================================================
