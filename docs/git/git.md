# Git Tips

## Syncing a fork

Create the upstream remote for the fork:
[Confiuring a remote for a fork](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/configuring-a-remote-for-a-fork)

* git remote -v

* git remote add upstream GITURL
* git remote -v

Sync the fork:
[Syncing a Fork](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork)

* git fetch upstream
* git checkout master
* git merge upstream/master

## Change Git Remote URL

In order to change the URL of a Git remote, you have to use the `git remote set-url`
command and specify the name of the remote as well as the new remote URL to be changed.

```shell
git remote set-url <remote_name> <remote_url>
```

## Revert one or more commits

Revert commit:
[Restore Repo to Previous Version](https://www.git-tower.com/learn/git/faq/restore-repo-to-previous-revision)

Throw away changes to files in the “undone” commits:

```shell
git reset --hard HEAD
```

Keep all the changes in the "undone" commits as local modifications use the --soft
option (it is the default):

```shell
git reset --soft HEAD~1
# or
git reset HEAD~1
```

## Git Log

```shell
git log --one-line -3
```

`-3`: show only the last n commits where n is an any positive integer

`--one-line` : summary only of each commit

`--stat`: show each file that has changed

`--patch`: show changes in each file

Filtering

Last n commits: `git log -n 3` or `git log -3`

Find by author: `--author jcouball`

Find by date: `--after="2020-07-01"` `--before="2020-08-01"`

Relative dates: `--before="yesterday"` `--after="one week ago"`

Grep commit message (case sensative):`--grep="GUI"`

Grep for added or removed lines: `-S"hello()"` (might want to use with `--patch`)

List between two commits `git log --one-line {start}..{end}` where start and end are
commit hashes.

Commits that touch a particular file: `git log --one-line -- {filename}`

Format or colorize git log output: `--pretty[=<format>]`or `--format=<format>` where
format is one of  `oneline`, `short`, `medium`, `full`, `fuller`, `reference`, `email`,
`raw`, `format:<string>` and `tformat:<string>`. The default is `medium`. See
[PRETTY FORMATS](https://git-scm.com/docs/git-log#_pretty_formats) for more info.

## Show History of a File

Show all the commits against a file:

```shell
git log --one-line --stat [filename]
```

## Find Author of a Line

List the auther of every line in a file:

```shell
git blame [rev] [path]
```

Show blame between two lines: `--L 1,3`

## Git Show

Show an object (like a commit, see [gitrevisions](https://git-scm.com/docs/gitrevisions)
for the full range of what can be shown):

```shell
# git show [object]
git show 555b62
git show HEAD~2
```

Show only changes to one file: `git show HEAD~2:{path}`

Only list files that were changed: `--name-only`

Only list files that were changed with status: `--name-status`

## Merging and rebasing

[Merging vs. Rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

## Reference previous Commits

* Most recent commit: HEAD
* Parent of the most recent commit: HEAD^
* HEAD~1 is the last commit. If you want to rollback 3 commits you could use HEAD~3. If
  you want to rollback to a specific revision number, you could also do that using its
  SHA hash.

## Squash commits

[How to Squash Commits](https://github.com/wprig/wprig/wiki/How-to-squash-commits)
Make sure your branch is up to date with the master branch

```shell
git rebase -i master
```

## Rewrite commit message

Amend last commit message:
* git commit --amend

Amend older commit messages:
* git rebase -i HEAD~3 # Displays a list of the last 3 commits on the current branch
* Replace pick with reword before each commit message you want to change.
* git push --force

## Stash

* `git stash`
    * [save “message”] - annotate a stash with a description
    * [--include-untracked | -u] - include untracked files
    * [--all | -a] - include ignored files
    * [—patch | -p] - interactively choose which change hunks to save in the stash.
      Press ‘?’ for a list of hunk commands.
* `git stash apply`
    * re-apply a stash but keep the stash
* `git stash pop`
    * re-apply the most recently created stash: stash@{0}
    * [identifier] - re-apply a stash by identifier (see git stash list)
* `git stash list`
    * List all available stashes with identifier and message
* `git stash show`
    * View a summary of the last stash
    * [identifier] - show the summary of a different stash
    * [--patch | -p] - include a full diff of the stash
* `git stash branch [branch-name]`
    * check out a new branch based on the commit the last stash was created from and
      then pops that stash’s changes onto it
    * [identifier] - branch and pop from a different stash
* `git stash drop`
    * Delete the last stash
    * [identifier] - delete a different stash
* `git stash clean`
    * Delete all stashes

## Checkout a pull request

Modifying an inactive pull request locally

```shell
# $PR is the pull request number
# $BRANCHNAME is the new branch to create

git fetch origin pull/$PR/head:$BRANCHNAME
git checkout $BRANCHNAME

# … make changes …

git push origin $BRANCHNAME

# Creeate a new PR with the new branch
```

## Signing Commits

* [signing Commits](https://help.github.com/en/github/authenticating-to-github/signing-commits)

## Diff

Compare worktree to index:

`git diff [<options>] [--] [<path> …]`

Compare paths:

`git diff [<options>] --no-index [--] <path> <path>`

Compare index to a commit:

`git diff [<options>] --cached [<commit>] [--] [<path> …]`

Compare worktree to commit:

`git diff [<options>] <commit> [--] [<path> …]`

Compare two commits:

`git diff [<options>] <commit> <commit> [--] [<path> …]`

View changes between two commits where each commit defaults to HEAD:

`git diff [<options>] <commit>..<commit> [--] [<path> …]`

View the results of a merge commit:

`git diff [<options>] <merge_commit> <parent_commit> … <parent_commit> [--] [<path> …]`

View the changes on the branch containing and up to the second <commit>, starting at a
common ancestor of both <commit>:

`git diff [<options>] <commit>...<commit> [--] [<path> …]`

View the differences between the raw contents of two blob objects:

`git diff [<options>] <blob> <blob>`

## Check index for staged changes

```shell
# exits with 0 then there were no differences (1 means there were differences)

git diff-index --quiet --cached HEAD --
git diff-files --quiet
```

## Clean

`git clean -xdf`

* -x removes all untracked files including ignored build directories
* -d allows Git to recurse into untracked directories when no path is specified
* -f overwrites the default Git clean configuration and starts cleaning untracked files
  and directories

## ls-files

List “untracked” files (will include ignored files, if present):

```shell
git ls-files --others
```

List untracked and unignored files:

```shell
git ls-files --exclude-standard --others`
```

better example of above two:

```shell
u="$(git ls-files --others)" && test -z "$u"
```

Get number of files added to the index (but uncommitted)

```shell
expr $(git status --porcelain 2>/dev/null| grep "^M" | wc -l)
```

Get number of files that are uncommitted and not added

```shell
expr $(git status --porcelain 2>/dev/null| grep "^ M" | wc -l)
```

Get number of total uncommited files

```shell
expr $(git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l)
```

## Determine if inside work tree

```shell
git rev-parse --is-inside-work-tree --quiet > /dev/null 2>&1
```

## Determine if at the top level of the repository

```shell
[ "$(git rev-parse --show-toplevel)" = "$(pwd)" ]
```

## Determine default branch of remote

## Undo create-release

```shell
version=`bump current`
git reset HEAD~1
git restore CHANGELOG.md lib/git/version.rb
git checkout master
git branch -D release-v${version}
git tag -d v${version}
git push origin --delete v${version}
git push origin --delete release-v${version}
git remote prune origin
```

## Are there staged changes?

```shell
git diff --staged --name-only | wc -l
```

version=0.5.0
git checkout master
git branch -D release-v${version}
git tag -d v${version}
git push origin --delete v${version}
git push origin --delete release-v${version}
git remote prune origin
gh release delete v${version}

```shell
git init --bare repo1.git
git init --bare repo2.git
git clone repo1.git work
cd work
echo '# README File' > README.md
git add README.md
git commit -m 'Add README.md file'
git push
git remote add repo2 ../repo2.git
git push repo2
# Create a new 'dev' branch in repo1.git and make it the active branch
git --git-dir ../repo1.git branch dev HEAD
git --git-dir ../repo1.git symbolic-ref HEAD refs/heads/dev
#
echo '----------'
git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
git symbolic-ref refs/remotes/repo2/HEAD | sed 's@^refs/remotes/repo2/@@'
```

[Change the Active Branch in a bare repository](https://stackoverflow.com/questions/3301956/git-correct-way-to-change-active-branch-in-a-bare-repository)

[How to Get the Default Branch](https://stackoverflow.com/questions/28666357/git-how-to-get-default-branch)

[git-symbolic-ref](https://git-scm.com/docs/git-symbolic-ref)

[git-ls-remote](https://git-scm.com/docs/git-ls-remote.html)

Git default branch name introduced in git 2.28.0.  Before that version, the default
branch name was assumed to be `master`

```shell
$ git config init.defaultBranch
master
```

Number of commits in the repository:

```shell
$ git rev-list --all --count
0
```

How to tell if you are in a detached state:

```shell
# Returns HEAD if in a detached state; otherwise, gives a branch
$ git rev-parse --abbrev-ref --symbolic-full-name HEAD
```

For a new repository with no commits:

```shell
$ git branch # no output

$ git branch --show-current # git 2.22.0 and later
master

$ git symbolic-ref --short refs/remotes/origin/HEAD
fatal: ref refs/remotes/origin/HEAD is not a symbolic ref

$ git remote show origin
fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

$ git ls-remote --symref origin
fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

For a new repository with one commit and no remotes:

```shell
# Last known state of HEAD on the origin remote
$ git symbolic-ref --short refs/remotes/origin/HEAD
<remote>/main

# Not sure what this points to
$ git symbolic-ref --short refs/origin/HEAD

# Only if there isn't a origin remote
$ git symbolic-ref --short HEAD
main

$ git remote show origin

$ git ls-remote --symref origin

$ git config init.defaultBranch
```

`refs/remotes/origin/HEAD` is the default branch on the remote

After cloning a Github repository whose default branch is `main` and then changing the
default branch of the Github repository to `new_main` using the Github UI:

```shell
$ git symbolic-ref --short refs/remotes/origin/HEAD
origin/main

$ git remote show origin
* remote origin
  Fetch URL: https://github.com/jcouball/test
  Push  URL: https://github.com/jcouball/test
  HEAD branch: new_main
  Remote branches:
    main     tracked
    new_main new (next fetch will store in remotes/origin)
  Local branch configured for 'git pull':
    main merges with remote main
  Local ref configured for 'git push':
    main pushes to main (up to date)

$ git ls-remote --symref origin
ref: refs/heads/new_main  HEAD
13f353ea1f675fc580c4b8bbc3011432abeb6c3d  HEAD
13f353ea1f675fc580c4b8bbc3011432abeb6c3d  refs/heads/main
13f353ea1f675fc580c4b8bbc3011432abeb6c3d  refs/heads/new_main
```

Repository has no commits if the following command returns 0:

```shell
git rev-list --all --count
```

Repository has no remotes if the following command returns nothing:

```shell
git remote
```

Repository has a detached HEAD if the following command returns HEAD

```shell
git rev-parse --abbrev-ref --symbolic-full-name HEAD
```

| State                                | What is the default branch?                                  |
| ------------------------------------ | ------------------------------------------------------------ |
| No Commits, Not Remote, Not Detached | Return the branch that HEAD references<br />`git symbolic-ref --short HEAD` |
| No Commits, Not Remote, Detached     | NOT A VALID STATE                                            |
| No Commits, Remote, Not Detached     | ???                                                          |
| No Commits, Remote, Detached         | NOT A VALID STATE                                            |
| Commits, Not Remote, Not Detached    | If a branch with the name given by the `init.defaultBranch` configuration exists, return it.<br />Otherwise, return the current branch<br />`git symbolic-ref --short HEAD` |
| Commits, Not Remote, Detached        | If there is only one branch, return it. If there is more than one branch and one of them is the configured `init.defaultBranch`, return it. Otherwise return the current branch. |
| Commits, Remote, Not Detached        | Return the last known state of HEAD on the remote<br />`git symbolic-ref --short refs/remotes/origin/HEAD` |
| Commits, Remote, Detached            | Return the last known state of HEAD on the remote<br />`git symbolic-ref --short refs/remotes/origin/HEAD` |
