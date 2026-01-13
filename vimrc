" vim-bootstrap 2023-10-29 18:28:50

"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "c"
let g:vim_bootstrap_editor = "vim"				" nvim or vim
let g:vim_bootstrap_theme = "gruvbox"
" let g:vim_bootstrap_frams = "vuejs"

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/CSApprox'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'editor-bootstrap/vim-bootstrap-updater'
Plug 'tpope/vim-rhubarb' " required by fugitive to :GBrowse
Plug 'morhetz/gruvbox'
Plug 'vimwiki/vimwiki'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/vim-easy-align' " ga=
Plug 'BurntSushi/ripgrep'

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Vim-Session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'

"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber

let no_buffers_menu=1

colorscheme industry

" Better command line completion 
set wildmenu

" mouse support
set mouse=a

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = ''
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1
  
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
  
endif

if &term =~ '256color'
  set t_ut=
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0

set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 35
let NERDTreeShowHidden=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <leader>o :NERDTreeToggle<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>


"*****************************************************************************
"" Commands
"*****************************************************************************

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
"" Functions
"*****************************************************************************

" Function to compile PDF from .tex files
function! SaveAndCompile()
    " Save file
    :w

    " Obtain file name without extension
    let filename = expand('%:r')

    " Compile document using pdflatex
    silent execute '!pdflatex ' . filename . '.tex'
    silent execute '!pdflatex ' . filename . '.tex'

    " Remove useless files after compile
    :!rm *.aux *.log
endfunction

nnoremap <leader>pdf :call SaveAndCompile()<CR>

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
 
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup vimrc-wrapping
  autocmd!
  " Notas: Soft-wrap y Hard-wrap a 150 caracteres
  autocmd BufRead,BufNewFile *.wiki,*.md,*.tex setlocal wrap wm=2 textwidth=150
  
  " Archivos técnicos: Soft-wrap y Hard-wrap a 110 caracteres
  autocmd BufRead,BufNewFile *.txt, setlocal wrap wm=2 textwidth=110
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" Define a shortkey to search into wiki files
augroup vimwiki_search_mapping
  autocmd!
  autocmd FileType vimwiki nnoremap <buffer> <F5> :VWS 
  
  " Center screen when follow a link
  autocmd FileType vimwiki nnoremap <buffer> <CR> <Plug>VimwikiFollowLink<CR>zz
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit --verbose<CR>
" noremap <Leader>gsh :Git push<CR>
"noremap <Leader>gll :Git pull<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiffsplit<CR>
noremap <Leader>gr :GRemove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

"Recovery commands from history through FZF
nmap <leader>y :History:<CR>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ale
let g:ale_linters = {}

" To use VWS without delete BufRead when open with :lopen
let g:ale_pattern_options = {
    \ '.*\.wiki$': {'ale_enabled': 0}}

" Tagbar
nmap <silent> <leader>tag :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap XX "+x<CR>
" We comment on the following line because it conflicts with the opening of our annotation file.
" noremap <leader>p "+gP<CR> 

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
nnoremap <C-b> :bp<CR>
nnoremap <C-w> :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :nohlsearch<CR>

"" Allows to adjust the window size in the split mode
:let &winheight = &lines * 8 / 10

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Create a vimwiki table into file
nnoremap <C-t> :VimwikiTable 3 4<CR>

"" Open current line on GitHub
" nnoremap <Leader>o :.GBrowse<CR>

"" To search and replace in selected block
" Select your text in visual mode, and then press ":" and enter "s/hello/world/g"

"*****************************************************************************
"" Spell checking 
"*****************************************************************************

"" Establish spanish/english language 
set spelllang=es,en

"" On/Off spell checking
function! ToggleSpellCheck()
    if &spell
        set nospell
    else
        set spell
    endif
endfunction

nnoremap <leader>spell :call ToggleSpellCheck()<CR>

"" Activate spell highlight
" hi SpellBad ctermfg=1 guibg=#FF0000 gui=underline 
hi SpellBad ctermfg=1 guibg=#FFA500 gui=underline 

" Move between words misspelling
nnoremap <C-n> ]s
nnoremap <C-p> [s

" Toggle suggestion words
nnoremap <C-s> z= 

" To add a new word into dictionary, you can use 'zg' 

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_symbols.maxlinenr = ' '
  let g:airline_symbols.colnr = ' :'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

set background=dark

"*****************************************************************************
"" Vim-alignment: 
"*****************************************************************************
" To see how work with: https://github.com/junegunn/vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" To indent a whole file content you can do this: 
" So, gg to get the start of the file, = to indent, G to the end of the file => gg=G

"*****************************************************************************
"" Vimwiki: Handling external browser 
"*****************************************************************************

" Función para abrir links en navegadores y perfiles específicos
function! VimwikiLinkHandler(link)
    let link = a:link

    " 1. Lógica para abrir archivos locales exactamente como se escriben (vfile:)
    if link =~# '^vfile:'
        " Quitamos el prefijo 'vfile:'
        let l:raw_path = substitute(link, '^vfile:', '', '')
        
        " Expandimos ~ y variables de entorno para obtener la ruta absoluta real
        let l:full_path = expand(l:raw_path)
        
        " Si la ruta es relativa, la unimos al directorio del archivo actual
        if l:full_path !~ '^/.*'
            let l:full_path = expand('%:p:h') . '/' . l:full_path
        endif

        if filereadable(l:full_path) || isdirectory(l:full_path)
            execute 'tabnew ' . fnameescape(l:full_path)
            return 1
        else
            echomsg 'Vimwiki Error: El archivo no existe en ' . l:full_path
            return 0
        endif
    endif

    " 2. Lógica para navegadores (Chrome Profiles y Vieb)
    let browser = ''
    if link =~ '^work:'
        let browser = 'google-chrome --profile-directory="Profile 5"'
        let link = substitute(link, '^work:', '', '')
    elseif link =~ '^google:'
        let browser = 'google-chrome --profile-directory="Profile 1"'
        let link = substitute(link, '^google:', '', '')
    elseif link =~ '^vieb:'
        let browser = 'vieb'
        let link = substitute(link, '^vieb:', '', '')
    else
        return 0
    endif

    execute "!".browser." ".shellescape(link)." >/dev/null 2>&1 &"
    return 1
endfunction

"*****************************************************************************

" Vimwiki: TOC functions 
let g:vimwiki_emoji_enable = 1
nmap <silent> <leader>to :VimwikiTOC<CR>
let g:vimwiki_toc_header = 'Contenido'

" Desactiva el menú gráfico (solución al error E330 y mejora de performance)
let g:vimwiki_menu = ''

" Evita que Vimwiki secuestre archivos markdown fuera de las rutas definidas
let g:vimwiki_global_ext = 0

" Mapear explícitamente extensiones a formatos
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.wiki': 'default'}

" Agregamos 3 nuevas wikis para tener separado lo Personal con lo Laboral
let g:vimwiki_list = [
    \ {
    \   'path': '~/.vimwiki/',
    \   'name': 'Personal',
    \   'syntax': 'markdown',
    \   'ext': '.wiki'
    \ },
    \ { 'path': '~/.vimwiki_laboral/',
    \   'name': 'Laboral',
    \   'syntax': 'markdown',
    \   'ext': '.wiki',
    \   'auto_tags': 0,
    \   'auto_diary_link': 0
    \ },
    \ {
    \   'path': '/tmp/mis_notas/',
    \   'name': 'WikiTemporal',
    \   'syntax': 'markdown',
    \   'ext': '.wiki',
    \   'auto_tags': 0,
    \   'auto_diary_link': 0
    \ }
\]

" Función que permite que se pueda trabajar mediante vimwiki con el formato de markdown
augroup vimwiki_temp_fix
    autocmd!
    autocmd BufRead,BufNewFile /tmp/mis_notas/*.wiki let b:vimwiki_wiki_nr = 1 | let b:vimwiki_syntax = 'markdown' | set filetype=vimwiki
augroup END

" Función para pasar de "=" a "#" para los headers
function! ConvertirVimwikiAMarkdown()
    " El flag 'e' evita que Vim se queje si no encuentra algún nivel de encabezado
    silent! %s/^\s*======\s\(.*\)\s======\s*$/###### \1/ge
    silent! %s/^\s*====\s\(.*\)\s====\s*$/#### \1/ge
    silent! %s/^\s*===\s\(.*\)\s===\s*$/### \1/ge
    silent! %s/^\s*==\s\(.*\)\s==\s*$/## \1/ge
    silent! %s/^\s*=\s\(.*\)\s=\s*$/# \1/ge
    echo "Encabezados convertidos a Markdown"
endfunction

" Creamos un comando personalizado para llamar a la función
command! FixHeaders call ConvertirVimwikiAMarkdown()

"*****************************************************************************
"" Annotations: Function to call the annotation file
"*****************************************************************************

function! ToggleAnotaciones()
    " Obtener el número del buffer que contiene el archivo Anotaciones_diarias.wiki
    let l:buf = bufnr('~/vimwiki/Anotaciones_diarias.wiki')

    if l:buf > 0
        " Obtener la lista de ventanas que muestran el buffer
        let l:winid = bufwinnr(l:buf)
        
        if l:winid != -1
            " Cambiar a la ventana que muestra el buffer específico
            execute l:winid . 'wincmd w'
            
            " Verificar si hay cambios no guardados y guardar si es necesario
            if &modifiable && getbufvar(l:buf, '&modified')
                execute 'write'
            endif
            
            " Cerrar la ventana actual
            execute 'close'
        else
            " Si no hay ventana visible, simplemente abrirlo
            botright split ~/vimwiki/Anotaciones_diarias.wiki
        endif
    else
        " Si el buffer no existe, abrir el archivo
        botright split ~/vimwiki/Anotaciones_diarias.wiki
    endif
endfunction

" Mapear la función a la combinación de teclas
" nnoremap <silent> <leader>p :call ToggleAnotaciones()<CR>

"*****************************************************************************
"" InsertLines : Function to insert empty lines
"*****************************************************************************
" Permite agregar 5 líneas vacías desde donde se encuentra el cursor
function! InsertFiveEmptyLines()
  let current_line = line('.')
  for i in range(5)
    call append(current_line, '')
  endfor
  call cursor(current_line, col('.'))
endfunction

" gnome-terminal: try not use alt+space because this keybinding is catching by
" terminal
nnoremap <leader>l :call InsertFiveEmptyLines()<CR>

"*****************************************************************************
"" SaveDraft : Function to save the annotation file
"*****************************************************************************

" Script to save temporary draft files to a permanent location
" Mapped to <leader>sd (save draft) in normal mode

function! SaveDraft()
    " Get the full path of the current file
    let l:current_file = expand('%:p')

    " Regex pattern to identify temporary draft files
    let l:pattern = "^/tmp/mis_notas/\\d\\+-\\d\\+-\\d\\+-\\d\\+_\\d\\+\\.md$"

    " Check if the current file matches the temporary draft pattern
    if l:current_file =~# l:pattern
        " Extract only the filename (e.g., 05-21-1446_20965.wiki)
        let l:filename = fnamemodify(l:current_file, ':t')

        " Prompt the user to choose the destination directory (1 or 2)
        " Updated prompt to "Personal" and "Laboral"
        let l:choice_num = input('Save to (1. Personal / 2. Laboral)? ', '1')

        let l:save_dir = ''
        if l:choice_num == '1'
            " Path for Personal notes
            let l:save_dir = '/home/emiliano/.vimwiki/AnotacionesPersonales'
        elseif l:choice_num == '2'
            " Updated path for Laboral notes
            let l:save_dir = '/home/emiliano/.vimwiki_laboral/TrabajoRemoto/AnotacionesLaborales'
        else
            echomsg "Invalid option (must be 1 or 2). Draft will not be saved."
            return
        endif

        " Construct the full destination path
        let l:destination_path = l:save_dir . '/' . l:filename
        " echomsg "  Destination Path: " . l:destination_path

        " Check if the destination file already exists
        if filereadable(l:destination_path)
            let l:confirm = input("Destination file already exists. Overwrite? (y/n): ", "n")
            if l:confirm =~? '^y'
                " Get the content of the current buffer
                let l:buffer_content = getbufline('%', 1, '$')
                " Overwrite the file using writefile()
                call writefile(l:buffer_content, l:destination_path)
                echomsg " Draft saved to: " . l:destination_path
            else
                echomsg "Save canceled by user. File was not overwritten."
            endif
        else
            " Get the content of the current buffer
            let l:buffer_content = getbufline('%', 1, '$')
            " If the file does not exist, save it normally using writefile()
            call writefile(l:buffer_content, l:destination_path)
            echomsg " Draft saved to: " . l:destination_path
        endif
    else
        echomsg "Current file (" . l:current_file . ") does NOT appear to be a temporary draft."
    endif
endfunction

" Map the function to <leader>sd (save draft) in normal mode
nnoremap <leader>sd :call SaveDraft()<CR>

" Use diary template 
au BufNewFile ~/.vimwiki/diary/*.wiki :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'

" Mapea la selección visual de una tabla markdown a una multilinea
vnoremap <Leader>pm :!pandoc -f markdown+multiline_tables -t markdown<CR>

" Mapea la selección visual para formatear títulos de listas en cursiva (un sólo asterisco)  
" vnoremap <Leader>vi :s/^\(\s*[-*]\s*\)\(\S.\{-}\)\ze:/\1*\2*/g<CR>

" Mapea la selección visual para formatear títulos de listas en negrita (con dos asteriscos)
vnoremap <Leader>vi :s/^\(\s*[-*]\s*\)\(\S.\{-}\)\ze:/\1**\2**/g<CR>
