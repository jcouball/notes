# Creating Snapshots

## Initialize a Repository

Use `git init` to initialize an empty repository.

```shell
$ mkdir my_project
$ cd my_project
$ git init
Initialized empty Git repository in /Users/couballj/my_project/.git/
$
```

The `.git` directory is the repository. This is where Git stores the repository
data.

You can remove the repository by deleting the `.git` directory.

## Git Workflow

In Git, the staging area (or index) is where we build a snapshot to be committed. Changes to
files can be moved into the staging area or removed from the staging area.

File changes are added to the staging area with the `git add` command and removed with the
`git rm --cached <file>` command.

Once changes are staged in the staging area, they are committed to the repository with the
`git commit -m <message>` command.

Each commit represents a complete snapshot of the project. This allows us to quickly
back to any previous state in our project.

## Staging Files

Use `git add` to stage the changes you want to commit. `git add .` will add all changed
files into the staging area.

Use `git status` to see the status of the working directory and the staging area.

```shell
$ pwd
/Users/couballj/my_project
$ echo hello > file1.txt
$ echo hello > file2.txt
$ git status
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        file1.txt
        file2.txt

nothing added to commit but untracked files present (use "git add" to track)
$
```

New changes (made after the previous `git add` command) will have to be added to the
staging area with another `git add` command.

```shell
$ echo world >> file1.txt
$ git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   file1.txt
        new file:   file2.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   file1.txt

$
```

```shell
$ git add file1.txt
$ git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   file1.txt
        new file:   file2.txt

$
```

## Committing Changes

Use `git commit -m <message>` to commit the changes in the staging area to the repository.

```shell
$ git commit -m 'Initial commit'
[main (root-commit) 34cbe44] Initial commit
 2 files changed, 3 insertions(+)
 create mode 100644 file1.txt
 create mode 100644 file2.txt
$ git status
On branch main
nothing to commit, working tree clean
$
```

## Committing Best Practices

* Keep the number of changes in each commit as small as possible
* Commit often
* Each commit should represent be a logically separate changeset
* Give meaningful commit messages
* Use past tense e.g. "Fixed the bug" instead of "Fix the bug"

## Skipping the Staging Area

Use the `-a` or `--all` option to `git commit` to add files to the staging area AND
commit at the same time. For example: `git commit -am 'Initial commit'`

## Removing Files with `rm`

To remove a file from the repository, it has to be removed from both the working
directory and the staging area.

```shell
$ pwd
/Users/couballj/my_project
$ rm file2.txt
$ git status
On branch main
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    file2.txt

no changes added to commit (use "git add" and/or "git commit -a")
$ git ls-files
file1.txt
file2.txt
$
```

`git ls-files` lists the files in the staging area. Note that `file2.txt` is still in the
staging area even though we have removed it from the working directory.

To remove `file2.txt` from the staging area, use the `git add` command:

```shell
$ git add file2.txt
$ git ls-files
file1.txt
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    file2.txt

$
```

Now that the change (the removal of `file2.txt`) has been staged, use `git commit` to
commit the staged change to the repository:

```shell
$ git commit -m 'Removed unused text'
[main a06cbfb] Removed unused text
 1 file changed, 1 deletion(-)
 delete mode 100644 file2.txt
$ git status
On branch main
nothing to commit, working tree clean
$
```

The `git log` command can be used to list the commits made to the repository:

```shell
$ git log
commit a06cbfba8bf5bf6b281f6b323ccf7aff00acf145 (HEAD -> main)
Author: James Couball <jcouball@yahoo.com>
Date:   Thu Dec 22 09:02:43 2022 -0800

    Removed unused text

commit 34cbe44f8f9d8446ebe149e327c0a95749c5d606
Author: James Couball <jcouball@yahoo.com>
Date:   Thu Dec 22 08:50:01 2022 -0800

    Initial commit

    This is the initial version of my project.
$
```

## Removing Files with `git rm`

You can remove AND stage a file removal in one command with `git rm`

```shell
$ pwd
/Users/couballj/my_project
$ git rm file1.txt
rm 'file1.txt'
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    file1.txt

$
```

A `git commit` is still needed to store the change in the repository.

## Renaming or Moving Files with `mv`

```shell
$ pwd
/Users/couballj/my_project
$ ls
file1.txt
$ mv file1.txt main.js
$ git status
On branch main
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    file1.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        main.js

no changes added to commit (use "git add" and/or "git commit -a")
$
```

This shows TWO changes: one to delete `file.txt` and another to create `main.js`. Both of
these changes would have to be staged (via `git add`) separately. Once both changes are
added, Git will (usually) show that the file was renamed.

```shell
$ git add file1.txt main.js
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    file1.txt -> main.js

$
```

## Renaming or Moving Files with `git mv`

You can rename AND stage that rename in one command with `git mv`

```shell
$ git mv main.js file1.js
$ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        renamed:    file1.txt -> file1.js

$ git commit -m "Refactor code"
[main fb1b1e7] Refactor code
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename file1.txt => file1.js (100%)
$
```

## Ignoring Files

There are many files that need to be excluded from the Git repository. This includes files
such as log files or binary files generated by the build.

List the files and directories that should be excluded from the staging area and the
repository in the `.gitignore` file.

Here is an example of having log files in a project that should be excluded from the
repository:

```shell
$ mkdir logs
$ echo 'ERROR: something happened' > logs/errors.txt
$ git status
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        logs/

nothing added to commit but untracked files present (use "git add" to track)
$
```

To exclude the logs, add `logs/` to the `.gitignore` file:

```shell
$ echo 'logs/' > .gitignore
$ git status
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .gitignore

nothing added to commit but untracked files present (use "git add" to track)
$
```

This change to the `.gitignore` file should be added to the repository:

```shell
$ git add .gitignore
$ git commit -m 'Ignore log files'
[main 2b695e7] Ignore log files
 1 file changed, 1 insertion(+)
 create mode 100644 .gitignore
$
```

To remove a file from the staging area without removing it from the working copy
using the `--cached` option to `git rm`.

Various .gitignore templates for various languages can be found on GitHub in the
[github/gitignore](https://github.com/github/gitignore) repository.

## Short Status

Get a short status by adding the `-s` option to `git status` command.

To illustrate the `-s` option, start with a repository with one file in it:

```shell
$ pwd
/Users/couballj
$ mkdir my_project
$ cd my_project
$ git init
Initialized empty Git repository in /Users/couballj/my_project/.git/
$ echo hello > file1.txt
$ git add file1.txt
$ git commit -m 'Initial version of my_project'
[main (root-commit) 24670a1] Initial version of my_project
 1 file changed, 1 insertion(+)
 create mode 100644 file1.txt
$
```

Introduce a couple of changes and get the status:

```shell
$ echo world >> file1.txt
$ echo hello > file2.txt
$ git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   file1.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        file2.txt

no changes added to commit (use "git add" and/or "git commit -a")
$
```

The same short status looks like this:

```shell
$ git status -s
 M file1.txt
?? file2.txt
$
```

In the this format, the status of each path is shown as one of these forms:

```text
XY PATH
XY ORIG_PATH -> PATH
```

where `ORIG_PATH` is where the renamed/copied contents came from. `ORIG_PATH` is
only shown when the entry is renamed or copied.

The `XY` is a two-letter status code. `X` shows the status of the index and `Y`
shows the status of the working tree. The most often seen statuses are:

* ' ' (a space): unmodified
* `M`: modified
* `A`: added
* `D`: deleted
* `R`: renamed
* `?`: untracked

A comprehensive definition of the short-format status can be found in
[`git-status` documentation](https://git-scm.com/docs/git-status) or in the output of
`git status --help`.

## Viewing Unstaged and Staged Changes

View differences between the working directory and the stagging area with `git diff`

View differences between the stagging area and the repository with `git diff --staged`

## Visual Diff Tools

Set up Git to view diffs in VS Code:

```shell
$ git config --global diff.tool vscode
$ git config --global difftool.vscode.cmd "code --wait --diff $LOCAL $REMOTE"
$
```

Then use `git difftool` exactly as `git diff` would be used (same exact options)
to view diffs in VS Code.

## Viewing a Commit

Use `git log` to view the history of commits.

## Unstaged Files

## Discarding Local Changes

## Restoring a File to an Earlier Version

## Creating Snapshots with VSCode

## Creating Snapshots with GitKraken
