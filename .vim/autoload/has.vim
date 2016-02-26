function! has#colorscheme(name)
    let pat = 'colors/' . a:name . '.vim'
    return !empty(globpath(&rtp, pat))
endfunction
