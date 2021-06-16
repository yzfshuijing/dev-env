" """""""""""""""""""""""""""""" common configuration """"""""""""""""""""""""""""""""""""""""""""""
" source /usr/share/vim/vim82/defaults.vim
set mouse=a
set cursorline
set cc=101
highlight Cursorline term=bold cterm=bold

""" fold """
set foldmethod=syntax
set foldlevel=99
nnoremap <space> za

let mapleader=","        "要定义一个使用 \"mapleader\" 变量的映射，可以使用特殊字串 \"< Leader >\"
let g:mapleader=","
let maplocalleader="\\"  "< LocalLeader > 和 < Leader > 类似，除了它使用 \"maplocalleader\" 而非 \"mapleader\"以外

"""""""""""""""""""""""""""""""""""" vim-plug """"""""""""""""""""""""""""""""""""""""""""""""""""""
" automatic install vim-plug https: // github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'liuchengxu/vista.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-scripts/BufOnly.vim'

Plug 'bronson/vim-trailing-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ludovicchabant/vim-gutentags'
Plug 'chazy/cscope_maps'

Plug 'durd07/vim-monokai'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"""""""""""""""""""""""""""""""""""" vim-plug configuration """"""""""""""""""""""""""""""""""""""""

"""
""" Plug 'durd07/vim-monokai'
"""
colorscheme monokai
let g:monokai_term_italic=1
let g:monokai_gui_italic=1

"""
""" Plug 'bronson/vim-trailing-whitespace'
"""
map <leader><space> :FixWhitespace<cr>

"""
""" Plug 'junegunn/fzf.vim'
"""
nmap <F9> :FZF <CR>
nmap <F8> :Rg <c-r>=expand("<cword>")<cr><CR>
let g:fzf_layout = { 'down': '~60%' }

"""
""" Plug 'vim-airline/vim-airline'
"""
map <F10> :AirlineToggle <CR>
"let g:airline_extensions = ['branch', 'tabline']
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1

let g:airline#existsions#whitespace#enabled=0
let g:airline#existsions#whitespace#symbol="!"
let g:airline#extensions#whitespace#show_message=0
let g:airline_detect_modified=1

if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif
"let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamemod=':t:.'
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.branch=''
let g:airline_symbols.readonly=''
let g:airline_symbols.linenr='☰'
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.maxlinenr=''

let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#show_line_numbers = 1

""" Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_project_root = ['.project']
let g:gutentags_ctags_tagfile = '.tags'  "所生成的数据文件的名称
let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif
"if executable('ctags')
"	let g:gutentags_modules += ['ctags']
"endif
"let s:vim_tags = expand('~/.cache/tags')  "将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
"let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q', '--c++-kinds=+px', '--c-kinds=+px']  "配置 ctags 的参数
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']  "如果使用 universal ctags 需要增加
let g:gutentags_auto_add_gtags_cscope = 1  "gutentags 自动加载 gtags 数据库的行为
"if !isdirectory(s:vim_tags)
"   silent! call mkdir(s:vim_tags, 'p')
"endif
"let $GTAGSLABEL = 'native-pygments'
"let $GTAGSCONF = '/home/felixdu/.gtags.conf'
let g:gutentags_define_advanced_commands = 1
let g:gutentags_trace = 0

"""
""" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"""
map tb :Vista!! <CR>
map <F3> :CocCommand explorer<CR>
map <F4> :CocDiagnostics <CR>
" TextEdit might fail if hidden is not set.
"set hidden

" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
  autocmd TermOpen * setl nonu
  set signcolumn=no
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <leader>ss  :exe 'CocList -I --input='.expand('<cword>').' symbols'<cr>
nnoremap <silent><nowait> <leader>w  :exe 'CocList -I --input='.expand('<cword>').' words'<cr>

nmap <F7> :PreviewTag <c-r>=expand("<cword>")<cr><CR>

" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""" other useful scripts """"""""""""""""""""""""""""""""""""""""""

""" use <leader><num> to jump to buffer
function! BufPos_Initialize()
    exe "map <leader>0 :buffer 0<CR>"
    let l:count=1
    for i in range(1, 9)
        exe "map <leader>" . i . " :buffer " . i . "<CR>"
    endfor
endfunction
au VimEnter * call BufPos_Initialize()

""" RUN
let g:asyncrun_open=10
map <F5> :call Run()<CR>
func! Run()
    exec "w"
    if &filetype == 'c'
        exec "AsyncRun gcc % -o %< -std=c11 && ./%<"
    elseif &filetype == 'python'
	exec "AsyncRun -raw=1 python3 %"
    elseif &filetype == 'cpp'
        exec "AsyncRun g++ % -o %< -std=c++20 && ./%<"
    elseif &filetype == 'go'
        exec "AsyncRun -raw=1 go run %"
    elseif &filetype == 'java'
        exec "AsyncRun javac %"
    elseif &filetype == 'sh'
        exec "AsyncRun -raw=1 chmod +x ./% && ./%"
    endif
endfunc

""" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>t :ZoomToggle<CR>

""" Run Block
map <F6> :call RunBlock()<CR>
function! RunBlock()
    let startline = search('```', 'b')
    let endline = search('```')
    let content = getline(startline+1, endline-1)

    let ft = matchstr(getline(startline), '```\s*\zs[0-9A-Za-z_+-]*')
    if !empty(ft) && ft !~ '^\d*$'
        if ft == 'c'
            call writefile(content, '/tmp/vim-cb'.'.c')
            exec "AsyncRun -raw gcc /tmp/vim-cb.c -o /tmp/vim-cb.bin && /tmp/vim-cb.bin"
        elseif ft == 'python'
            call writefile(content, '/tmp/vim-cb'.'.py')
            exec "AsyncRun -mode=term -pos=bottom -raw python3 /tmp/vim-cb.py"
        elseif ft == 'c++'
            call writefile(content, '/tmp/vim-cb'.'.cpp')
            exec "AsyncRun -raw g++ /tmp/vim-cb.cpp -o /tmp/vim-cb.bin && /tmp/vim-cb.bin"
        elseif ft == 'go'
            call writefile(content, '/tmp/vim-cb'.'.go')
            exec "AsyncRun -raw go run /tmp/vim-cb.go"
        elseif ft == 'java'
            call writefile(content, '/tmp/vim-cb'.'.java')
            exec "AsyncRun -raw javac /tmp/vim-cb.java"
        elseif ft == 'sh'
            call writefile(content, '/tmp/vim-cb'.'.sh')
            "exec "AsyncRun -raw=1 chmod +x /tmp/vim-cb.sh && /tmp/vim-cb.sh"
            exec "AsyncRun -mode=term -pos=bottom -raw=1 chmod +x /tmp/vim-cb.sh && /tmp/vim-cb.sh"
	else
            echo ft
        endif
    endif
endfunction

"""""""""""""""""""""""""""""""""""" work arounds """"""""""""""""""""""""""""""""""""""""""""""""""
" enable mouse for vim in tmux
if !has('nvim')
  set ttymouse=xterm2
endif

" for solve the problem nvim in tmux act slow
set timeoutlen=1000 ttimeoutlen=0

"""""""""""""""""""""""""""""""""""" temp configuration """"""""""""""""""""""""""""""""""""""""""""
let g:vista_default_executive = 'coc'

" disabe airline by default
au VimEnter * AirlineToggle

autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
"autocmd FileType markdown setlocal tabstop=8 softtabstop=8 shiftwidth=8 expandtab

autocmd BufRead,BufNewFile /home/felixdu/src/service-mesh/* setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd BufRead,BufNewFile /home/felixdu/src/service-mesh/istio/* setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
autocmd BufRead,BufNewFile /home/felixdu/src/service-mesh/istio-github/* setlocal tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab
autocmd BufRead,BufNewFile /home/felixdu/src/service-mesh/envoy_discovery/* setlocal tabstop=8 shiftwidth=8 softtabstop=8 expandtab
