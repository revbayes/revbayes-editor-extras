To enable `vim` syntax highlighting for `.Rev` files

```
mv Rev.vim ~/.vim/syntax
```

then register the filetype to be detected by adding the line

```
autocmd BufNewFile,BufRead *.Rev setf Rev
```

to the directory `~/.vim/ftdetect` (create if needed).

