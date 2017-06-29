# SpeedTAGS

---

A better way to use CTAGS in vim.


###Works with `.js` `.cs` `.cpp` `.rb` `.coffee` `.clj` and `.c` files 


Speeds up CTAGS

It works by doing the following:

Initialize tags file with symlink to /tmp (tmpfs) with uuid in name if no symlink was found
Touch tags file
If file is empty (wc -l return 0 lines) then populate it with `ctags -R` command
Remove all lines from tags file related to current file
Update tags file with new content of current file with `ctags -a`
Why I use symlinks for tags file?

- Writes are slow
- Writes are bad for SSDs
- Memory is blazingly fast


