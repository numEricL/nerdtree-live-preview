" TODO Create buffer for preview window, this will fix problems when preview is
" opened on empty buffer

if !exists('g:NERDTreePreview_Enable')
    let g:NERDTreePreview_Enable = 1
endif
let g:NERDTreePreview_line_count_limit = 10000

augroup NERDTreePreview
    autocmd VimEnter * if (g:NERDTreePreview_Enable) | call NERDTreePreview_Enable()
augroup END

function NERDTreePreview_Enable()
    call NERDTreeAddKeyMap({
                \ 'key':           'j',
                \ 'callback':      'NERDTreePreview_j',
                \ 'quickhelpText': 'preview',
                \ 'override': '1',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key':           'k',
                \ 'callback':      'NERDTreePreview_k',
                \ 'quickhelpText': 'preview',
                \ 'override': '1',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 'o',
                \ 'callback': 'NERDTreePreview_o',
                \ 'quickhelpText': 'o custom',
                \ 'override': '1',
                \ 'scope': 'FileNode',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 't',
                \ 'callback': 'NERDTreePreview_t',
                \ 'quickhelpText': 't custom',
                \ 'override': '1',
                \ 'scope': 'FileNode',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 'T',
                \ 'callback': 'NERDTreePreview_T',
                \ 'quickhelpText': 'T custom',
                \ 'override': '1',
                \ 'scope': 'FileNode',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 'i',
                \ 'callback': 'NERDTreePreview_i',
                \ 'quickhelpText': 'i custom',
                \ 'override': '1',
                \ 'scope': 'FileNode',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 'gi',
                \ 'callback': 'NERDTreePreview_gi',
                \ 'quickhelpText': 'gi custom',
                \ 'override': '1',
                \ 'scope': 'FileNode',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 's',
                \ 'callback': 'NERDTreePreview_s',
                \ 'quickhelpText': 's custom',
                \ 'override': '1',
                \ 'scope': 'FileNode',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 'gs',
                \ 'callback': 'NERDTreePreview_gs',
                \ 'quickhelpText': 'gs custom',
                \ 'override': '1',
                \ 'scope': 'FileNode',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key': 'q',
                \ 'callback': 'NERDTreePreview_Quit',
                \ 'quickhelpText': '...',
                \ 'override': '1',
                \ })
endfunction

function NERDTreePreview_j()
    normal! j
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_Show()
endfunction

function NERDTreePreview_k()
    normal! k
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_Show()
endfunction

function NERDTreePreview_o(...)
    let l:filepath = NERDTreePreview_GetCurrentNode()
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_Quit()
    execute 'edit +setlocal\ modifiable ' . l:filepath
endfunction

function NERDTreePreview_t(...)
    let l:filepath = NERDTreePreview_GetCurrentNode()
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_Quit()
    execute '$tabnew +setlocal\ modifiable ' . l:filepath
endfunction

function NERDTreePreview_T(...)
    let l:nerdtree_win = win_getid(winnr())
    let l:filepath = NERDTreePreview_GetCurrentNode()
    call NERDTreePreview_SetPreviewWindow()
    execute '$tabnew +setlocal\ modifiable|setlocal\ noreadonly ' . l:filepath
    call win_gotoid(l:nerdtree_win)
endfunction

function NERDTreePreview_i(...)
    let l:filepath = NERDTreePreview_GetCurrentNode()
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_Quit()
    execute 'split +setlocal\ modifiable ' . l:filepath
endfunction

function NERDTreePreview_gi(...)
    let l:filepath = NERDTreePreview_GetCurrentNode()
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_RestorePreviewWindow()
    execute 'split +setlocal\ modifiable|setlocal\ noreadonly ' . l:filepath
    call NERDTreePreview_SetPreviewWindow()
endfunction

function NERDTreePreview_s(...)
    let l:filepath = NERDTreePreview_GetCurrentNode()
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_Quit()
    execute 'vsplit +setlocal\ modifiable ' . l:filepath
endfunction

function NERDTreePreview_gs(...)
    let l:filepath = NERDTreePreview_GetCurrentNode()
    call NERDTreePreview_SetPreviewWindow()
    call NERDTreePreview_RestorePreviewWindow()
    execute 'vsplit +setlocal\ modifiable|setlocal\ noreadonly ' . l:filepath
    call NERDTreePreview_SetPreviewWindow()
endfunction

function NERDTreePreview_GetCurrentNode()
    let l:file_obj = g:NERDTreeFileNode.GetSelected()
    if l:file_obj != {}
        return l:file_obj.path.str()
    endif
endfunction

function NERDTreePreview_SetPreviewWindow()
    let l:preview_changed = !NERDTreePreview_IsSamePreviewWindow()
    if exists('b:NERDTreePreview_preview_win') && l:preview_changed
        call NERDTreeFocus()
        wincmd p
        let l:new_preview_win = win_getid(winnr())
        call NERDTreePreview_RestorePreviewWindow()
        call win_gotoid(l:new_preview_win)
    endif
    if !exists('b:NERDTreePreview_preview_win') || l:preview_changed
        call NERDTreeFocus()
        wincmd p
        let l:preview_win = win_getid(winnr())
        let l:original_buf = bufnr('%')
        call NERDTreeFocus()
        let b:NERDTreePreview_preview_win = l:preview_win
        let b:NERDTreePreview_original_buf = l:original_buf
    endif
endfunction

function NERDTreePreview_RestorePreviewWindow()
    call NERDTreeFocus()
    if exists('b:NERDTreePreview_preview_win')
        let l:original_buf = b:NERDTreePreview_original_buf
        call win_gotoid(b:NERDTreePreview_preview_win)
        execute 'buffer ' . l:original_buf
    endif
endfunction

function NERDTreePreview_Show()
    let l:file_obj = g:NERDTreeFileNode.GetSelected()
    if l:file_obj == {}
        return
    endif
    let l:filename = l:file_obj.path.str()
    if winbufnr(b:NERDTreePreview_preview_win) == bufnr(l:filename)
        return
    endif

    if filereadable(l:filename) && !NERDTreePreview_Skip(l:filename)
        call NERDTreeFocus()
        call win_gotoid(b:NERDTreePreview_preview_win)
        if buflisted(l:filename)
            execute 'edit '. l:filename
        else
            set shortmess+=A
            execute 'edit +setlocal\ nobuflisted|setlocal\ nomodifiable|setlocal\ readonly ' . l:filename 
            set shortmess-=A
        endif
        call NERDTreeFocus()
    endif
endfunction

function NERDTreePreview_IsSamePreviewWindow()
    call NERDTreeFocus()
    let l:result = 1
    if exists('b:NERDTreePreview_preview_win')
        let l:preview_win = b:NERDTreePreview_preview_win
        wincmd p
        let l:result = win_getid(winnr()) == l:preview_win
    endif
    call NERDTreeFocus()
    return l:result
endfunction

function NERDTreePreview_Quit()
    call NERDTreePreview_RestorePreviewWindow()
    call NERDTreeFocus()
    if exists('b:NERDTreePreview_preview_win')
        unlet b:NERDTreePreview_preview_win
        unlet b:NERDTreePreview_original_buf
    endif
    silent! NERDTreeClose
    call NERDTreePreview_DeleteUnlistedBuffers()
endfunction

function NERDTreePreview_DeleteUnlistedBuffers()
    redir => l:scratch
        silent ls u
    redir END
    let buflist = split(l:scratch,"\n")
    for item in buflist
        if item !~# 'NERD_tree_' && item !~# 'NERDTreePreview'
            silent! execute 'bdelete '. item[:2]
        endif
    endfor
endfunction

function NERDTreePreview_Skip(file)
    let line_count = system( 'wc -l '.shellescape(a:file).' | awk '. shellescape('{print $1}') )
    if line_count > g:NERDTreePreview_line_count_limit
        return 1
    endif

    if system('file -ib ' . shellescape(a:file)) =~# 'binary'
        return 1
    endif

    return 0
endfunction
