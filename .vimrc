set modeline
set undofile
set undodir=~/.vim/undodir

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'pearofducks/ansible-vim'
Plug 'vim-syntastic/syntastic'
Plug 'gabrielelana/vim-markdown'
Plug 'towolf/vim-helm'
call plug#end()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_aggregate_errors = 1
let g:syntastic_yaml_checkers = ['yamllint']

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E902,E910,S104,S404,S601,S603,W503'

let g:syntastic_html_checkers = ['eslint']
let g:syntastic_html_eslint_exec = 'eslint_d'

function! GetSigil() 
    let end = line('$') 
    return end >= 1 && match(getline( max([end - 5, 1]), end ), '\m^# vi:.*ansible') >= 0
endfunction

augroup syntastic_haters
    autocmd!
    autocmd BufReadPost * let b:syntastic_skip_checks = GetSigil()
augroup END
