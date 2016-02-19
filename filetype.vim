augroup filetypedetect
	au! BufRead,BufNewFile *.rl  set filetype=ragel
	au! BufRead,BufNewFile *.cg  set filetype=cg
	au! BufRead,BufNewFile *.frag,*.vert,*.fp,*.vp,*.glsl set filetype=glsl
augroup END 

