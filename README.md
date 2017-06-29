# SpeedTAGS

---

A better way to use CTAGS in vim.


### Works with `.js` `.cs` `.cpp` `.rb` `.coffee` `.clj` and `.c` files 


Speeds up CTAGS

It works by doing the following:

1. Initialize tags file with symlink to /tmp (tmpfs) with uuid in name if no symlink was found
1. Touch tags file
1. If file is empty (wc -l return 0 lines) then populate it with `ctags -R` command
1. Remove all lines from tags file related to current file
1. Update tags file with new content of current file with `ctags -a`
### Why I use symlinks for tags file?

- Writes are slow
- Writes are bad for SSDs
- Memory is blazingly fast
### Usage
Open a `.js` `.cs` `.cpp` `.rb` `.coffee` `.clj` or `.c` file. 
SpeedTAGS with run automagicly

Use 
`:UpdateTags` 
to update your tags

### Installation

Use your perfered installation method:

or use Pathogen:

`> cd .vim/bundle`

`> git clone https://github.com/ajmwagar/SpeedTAGS.git`

Restart VIM
