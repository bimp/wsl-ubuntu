" ~/.vimrc - Vim configuration file
" ---------------------------------
" This configuration ensures the filename is always visible in the status line
" and also sets the terminal window title to the filename.

" Always show the status line, even if only one window is open
set laststatus=2    " 2 = always show status line

" Set the status line to display the full path of the current file
" %F = full path to file; use %f for just the filename
set statusline=%F

" Set the terminal window title to the filename (and path)
set title           " Enable setting the terminal's window title
set titlestring=%F  " Set the title string to the full file path
