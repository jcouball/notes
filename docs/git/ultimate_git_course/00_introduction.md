# Introduction

There are my personal notes taken from the excellent Code With Mosh course
[The Ultimate Git Course](https://codewithmosh.com/courses/enrolled/1120640).

The course is great. I encourage anyone wanting to learn Git to take the
course. You will learn a lot more from taking the course than you will from reading
my notes.

It is well worth the price.

## My Git Configuration

My global configuration in `~/.gitconfig`:

```gitconfig
[core]
  pager =
  editor = code -r -w
  autocrlf = input
[user]
  email = jcouball@yahoo.com
  name = James Couball
[init]
  defaultBranch = main
[diff]
  tool = vscode
[difftool "vscode"]
  cmd = code --wait --diff $LOCAL $REMOTE
```
