# Home Files

Managing Mac/Linux home files

## `homefiles` command

See [homefiles_setup](https://github.com/jcouball/homefiles_setup)

Ignore all files by default:

`homefiles config --local status.showUntrackedFiles no`

### Links

* [Dotfiles: Best Way to Store in a Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles)
* [The best way to store your dotfiles: A bare Git repository](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/)
* [A Simple Approach to storing Home Directory Config Files (Dotfiles) in Git using Bash, Zsh, or Powershell, without a Bare Repo](https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-a-simple-approach-without-a-bare-repo-2if7)
* [The Bare Repo Approach to Storing Home Directory Config Files (Dotfiles) in Git using Bash, Zsh, or Powershell](https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3)

## Shell Startup Files

### Bash

[Bash startup files](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html)
showing the order (A, B, etc.) which files are sourced depending on how the shell was run.

| File | Interactive<br/>Login | Interactive<br/>non-login | Script |
| :------------- | :---: | :---: | :---: |
| **STARTUP FILES** {: colspan=4 } | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} |
| /etc/profile    | A     | --    | --    |
| /etc/bashrc     | --    | A     | --    |
| ~/.bashrc       | --    | B     | --    |
| ~/.bash_profile | B1    | --    | --    |
| ~/.bash_login   | B2    | --    | --    |
| ~/.profile      | B3    | --    | --    |
| BASH_ENV        | --    | --    | A     |
| **SHUTDOWN FILES** {: colspan=4 } | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} |
| ~/.bash_logout  | C     | --    | --    |

List all possible Bash dotfiles:

```shell
ll /etc/profile /etc/bashrc ~/.bashrc ~/.bash_profile ~/.bash_login ~/.profile ~/.bash_logout
```

On my system:

* `/etc/profile` sources `/etc/bashrc` if not running bash
* `/etc/bashrc` sources `/etc/bashrc_$TERM_PROGRAM` — there isn’t one for iTerm.app
* `~/.bashrc` sources `/etc/bashrc`
* `~/.bash_profile` sources `~/.bashrc`

### Z Shell

[Z Shell startup files](http://zsh.sourceforge.net/Intro/intro_3.html)
showing the order (A, B, etc.) which files are sourced depending on how the shell was run.

| File | Interactive<br/>Login | Interactive<br/>non-login | Script |
| :----------- | :---: | :---: | :---: |
| **STARTUP FILES** {: colspan=4 } | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} |
| /etc/zshenv   | A     | A     | A     |
| ~/.zshenv     | B     | B     | B     |
| /etc/zprofile | C     | --    | --    |
| ~/.zprofile   | D     | --    | --    |
| /etc/zshrc    | E     | C     | --    |
| ~/.zshrc      | F     | D     | --    |
| /etc/zlogin   | G     | --    |       |
| ~/.zlogin     | H     | --    |       |
| **SHUTDOWN FILES** {: colspan=4 } | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} | &#8288 {: style="padding:0"} |
| ~/.zlogout    | I     | --    | --    |
| /etc/zlogout  | J     | --    | --    |

List all possible Z Shell dotfiles:

```shell
ll /etc/zshenv ~/.zshenv /etc/zprofile ~/.zprofile /etc/zshrc ~/.zshrc /etc/zlogin ~/.zlogin ~/.zlogout /etc/zlogout
```

On my system:

* `/etc/zshrc` sources `/etc/zshrc_$TERM_PROGRAM` — there isn’t one for iTerm.app
* `~/.zshrc` sources `$ZSH/oh-my-zsh.sh`
