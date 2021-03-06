if LayerLoaded('python')

    function! s:hi_over_length()
        highlight OverLength ctermbg=133 ctermfg=254 cterm=bold guibg=#592929
        match OverLength /\%81v.\+/
    endfunction

    augroup SPACEVIM_PYTHON
        autocmd!
        " Force indentation styles for python
        autocmd FileType python setlocal
                    \   foldmethod=indent
                    \   tabstop=4
                    \   shiftwidth=4
                    \   softtabstop=4
                    \   textwidth=79
                    \   expandtab
                    \   autoindent
                    \   fileformat=unix

        autocmd FileType python nnoremap <LocalLeader>ho :call <SID>hi_over_length()<CR>

        if LayerLoaded('programming')
            autocmd FileType python nnoremap <buffer> <F5> :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
            autocmd FileType python nnoremap <buffer> <LocalLeader>cc :update<Bar>execute 'AsyncRun! python '.shellescape(@%, 1)<CR>
            autocmd FileType python nnoremap <buffer> <LocalLeader>cs :update<Bar>execute 'AsyncStop!'<CR>
        else
            autocmd FileType python nnoremap <buffer> <F5> :update<Bar>execute '! python '.shellescape(@%, 1)<CR>
            autocmd FileType python nnoremap <buffer> <LocalLeader>cc :update<Bar>execute '! python '.shellescape(@%, 1)<CR>
        endif

        if executable('yapf')
            autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
        else
            autocmd FileType python nnoremap <LocalLeader>= echom '[space-vim] yapf is unavailable, please install it first.'
        endif

    augroup END

    if IsDir('python-mode')
        let g:pymode_lint_checkers = ['pyflakes']
        let g:pymode_trim_whitespaces = 0
        let g:pymode_options = 0
        let g:pymode_rope = 0

        let g:pymode_indent = 1
        let g:pymode_options_colorcolumn = 1

        if LayerLoaded('syntax-checking')
            let g:pymode_lint = 0
        endif

        " Enhanced python highlighting
        hi pythonLambdaExpr      ctermfg=105 guifg=#8787ff
        hi pythonInclude         ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
        hi pythonClass           ctermfg=167 guifg=#d75f5f
        hi pythonParameters      ctermfg=147 guifg=#afafff
        hi pythonParam           ctermfg=175 guifg=#d787af
        hi pythonBrackets        ctermfg=183 guifg=#d7afff
        hi pythonClassParameters ctermfg=111 guifg=#87afff
        hi pythonSelf            ctermfg=174 guifg=#d7afaf

        hi pythonDottedName      ctermfg=74  guifg=#5fafd7

        hi pythonError           ctermfg=196 guifg=#ff0000
        hi pythonIndentError     ctermfg=197 guifg=#ff005f
        hi pythonSpaceError      ctermfg=198 guifg=#ff0087

        hi pythonBuiltinType     ctermfg=74  guifg=#5fafd7
        hi pythonBuiltinObj      ctermfg=71  guifg=#5faf5f
        hi pythonBuiltinFunc     ctermfg=140 guifg=#af87d7
    endif

endif
