# zfunctions

Autoloaded zsh functions. Symlinked to `~/.zfunctions` and registered with
zsh via `fpath` + `autoload -Uz` from `config/shell/.zshrc`.

## Adding a function

Drop a file in this directory whose name is the function name. The file's
contents become the function body.

```zsh
# config/shell/zfunctions/greet
#autoload
echo "Hi $1"
```

After the next shell start (or `exec zsh`), `greet alice` will work.

The leading `#autoload` line is a convention, not required — it's a hint to
readers that the file is meant to be autoloaded rather than sourced.

## How it works

`.zshrc` adds `~/.zfunctions` to `fpath` and runs `autoload -Uz` for every
regular file in the directory. Functions are loaded lazily on first call.
