" If tags file does not exist initializes it with symlink to tmp with UUID in
" filename
function! InitTagsFileWithSymlink(f)
  let filepath = a:f
  let issymlink = system("find '" . filepath . "' -type l | wc -l")
  if issymlink == 0
    let uuid = system('uuidgen')
    let cmd  = 'ln -s "/tmp/ctags-for-vim-' . uuid . '" "' . filepath . '"'
    let cmd  = substitute(cmd, '\n', '', 'g')
    let resp = system(cmd)
  endif
endfunction

" Populates tags file if lines count is equal to 0
" with `ctags -R .`
function! PopulateTagsFile(f)
  let filepath = a:f
  let resp     = system('touch "' . filepath . '"')
  let lines    = system('wc -l "' . filepath . '"')
  let linescnt = substitute(lines, '\D', '', 'g')
  if linescnt == 0
    let cwd  = getcwd()
    let cmd  = 'ctags -Rf "'. filepath . '" "' . cwd . '"'
    let resp = system(cmd)
  endif
endfunction

" Remove tags for saved file from tags file
function! DelTagOfFile(file)
  let fullpath    = a:file
  let cwd         = getcwd()
  let tagfilename = cwd . "/tags"
  let f           = substitute(fullpath, cwd . "/", "", "")
  let f           = escape(f, './')
  let cmd         = 'sed --follow-symlinks -i "/' . f . '/d" "' . tagfilename . '"'
  let resp        = system(cmd)
endfunction

" Init tags file
" Populate it
" Remove data related to saved file
" Append it with data for saved file
function! UpdateTags()
  let f           = expand("%:p")
  let cwd         = getcwd()
  let tagfilename = cwd . "/tags"
  call InitTagsFileWithSymlink(tagfilename)
  call PopulateTagsFile(tagfilename)
  call DelTagOfFile(f)
  let cmd  = 'ctags -a -f ' . tagfilename . ' "' . f . '"'
  let resp = system(cmd)
endfunction

command UpdateTags call UpdateTags()
autocmd BufWritePost *.cpp,*.c,*.cs,*.rb,*.js,*.coffee,*.clj call UpdateTags()
