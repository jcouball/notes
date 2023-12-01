# Visual Studio Code

## Debugging

## Tasks

Note that `shell` tasks are alway run in a non-interactive shell even if you try
to force giving the `--interactive` arg to the shell. In this example, system ruby is run
instead of the ruby installed in my user account using `asdf`. This is because I
have configured `asdf` in my `.zshrc` was not sourced.

```json
{
  "type": "shell",
  "label": "",
  "options": {
    "shell": {
      "executable": "/bin/zsh",
      "args": ["--login", "--interactive", "-c"]
    }
  },
  "command": "ruby --version"
}
```

To see the ruby in my account, I found that either sourcing `.zshrc` works:

```json
  "command": "source ~/.zshrc && ruby --version"
```

or running a subshell passing the interactive and login args:

```json
  "command": "zsh --login --interactive -c -- ruby --version"
```
