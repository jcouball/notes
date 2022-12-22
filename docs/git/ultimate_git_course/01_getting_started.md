# Getting Started

To get the most our of this class watch every lesson order!

## What is Git?

The most popular version control system in the world.

Allows you to track history of a project and effectively collaborate.

Git is a distributed version control system. This means that there is no central
server that must be up to save snapshote or collaborate with other users. Every
team member has a copy of the project on their machine.

Subversion and Team Foundation Server are centralized version control systems.
Git and Mercural are distributed version control systems.

## Using Git

You can use Git with the `git` command line. A lot of people use the command line.

You can use Git from your IDE like VS Code. VS Code has Git support built in as well
as the excellent GitLens extension.

There are standalone GUI interfaces like GitKraken and SoureTree.

IDE and GUI's are nice but often have limitations that can only be solved using
`git` CLI.

This course focuses on learning the `git` CLI.

## Installing Git

On Mac, use `brew` to install the `git` CLI:

```shell
$ brew install git
...
$
```

## Configuring Git

There are a few configuration settings you should set when you first start using git:
set your name, your email, your default text editor, and how line endings should be
treated.

Git has settings at three levels:

* System: applies to all users / all repositories
* Global: applies to all repositories for the current user
* Local: only the current repository
* On the command line with -c: only for the current command

Set your name:

```shell
$ git config --global user.name "James Couball"
$ git config --global user.email "jcouball@yahoo.com"
$ git config --global core.editor "code --wait"
$ git config --global core.autocrlf "input"
$
```

A note about core.autocrlf: should be set to `true` in Windows and `input` in MacOS.

## Getting Help

Commands can be found online in the [Git Reference](https://git-scm.com/docs).
Googling the git command in question usually brings up the page from the reference
guide as the first result. e.g. [`git-config`](https://google.com/search?q=git%20config).

The exact same help can be accessed from the terminal window using the `--help`
option. For instance, `git config --help` will give the same text as what is on
[the git-config page in the Git Reference](https://git-scm.com/docs/git-config).

To view a short summary of a command , use the `-h` option (instead of `--help`).
e.g. `git config -h`.

Helpful documents:
* [Mosh's Git Cheat Sheet](https://cdn.fs.teachablecdn.com/O3sHNsAnSARDUwO28Jp3)
* [Git Cheat Sheet](https://training.github.com/downloads/github-git-cheat-sheet/)
* [Git Visual Cheat Sheet](https://ndpsoftware.com/git-cheatsheet.html)
* [Git Reference](https://git-scm.com/docs)
* [Git Book](https://git-scm.com/book/en/v2)
