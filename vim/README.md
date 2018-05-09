To enable `vim` syntax highlighting for `.Rev` files

```
ln -s $(pwd)/Rev.vim ~/.vim/syntax/Rev.vim
```

then register the filetype to be detected by adding the line

```
autocmd BufNewFile,BufRead *.Rev setf Rev
```

to the file `~/.vim/ftdetect/Rev.vim` (create if needed).

