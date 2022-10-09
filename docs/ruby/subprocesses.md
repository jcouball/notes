# Running Subprocesses in Ruby

Ruby has many ways of running subprocesses. This guide will help you to choose the
right method for your needs. Ruby comes with a rich-set of tools for spawning and
communicating with external subprocesses.

**How To Start Subprocesses**

| **Method** | **Use Case** |
| ---------- | ------------ |
| [Backticks](#backticks) | Run a command and wait for the results. STDOUT from the subprocess is returned as a String.
| [Kernel#system](#kernelsystem) | Run a command and wait for the results. By default STDOUT/STDERR are inherited from the parent.
| [Kernel#spawn](#kernelspawn) | Run a command asynchronously. By default STDOUT/STDERR are inherited from the parent.
| [Kernel#exec](#kernelexec) | Replace the current process by some other command. By default all file descriptors are inherited from the parent.
| [Kernel#fork](#kernelfork) | Run Ruby code asynchronously in a subprocess. By default all file descriptors are inherited from the parent.
| [IO.popen](#iopopen) | **TODO** Run a command asynchronously and interact with its STDOUT and STDIN via a pipe
| [Open3.popen3](#open3popen3) | **TODO** Run a command asynchronously and interact with its STDOUT, STDERR, and STDIN via a pipe
| [PTY.spawn](#ptyspawn) | **TODO** Run a command asynchronously and have it behave like it was run from a terminal

**How To Control Subprocesses**

| **Topic** | **Description** |
| --------- | --------------- |
| [How Are Commands Run](#how-commands-are-run) | how to specify what command is run and how Ruby decides if the command will be run directly or via a subshell
| [What Shell Is Used](#what-shell-is-used) | how Ruby selects which shell to use if the command is to be run in a subshell
| [$CHILD_STATUS](#child_status) | the status of a running or terminated subprocess
| [Detach](#detach) | tell Ruby you are not interested in the result of a subprocess
| [Wait](#wait) | wait for a subprocess to finish and get its status
| [Kill](#kill) | send an signal to a subprocess possibly causing it to terminate before it otherwise would
| [Environment](#environment) | choose what variables are passed into the subprocess's environment
| [Redirection](#redirection) | choose what is sent to a subprocess's stdin or where a subprocess's stdout and stderr are sent
| [Limits](#limits) | **TODO** set the resource limits (like CPU time, memory used, and number of open files) of a subprocess

**External References**

| **Topic** | **Description** |
| --------- | --------------- |
| [Gems](#gems) | Useful gems to help create and control subprocesses
| [References](#references) | Links to useful articles

## Backticks

**[\`command\` ⭢ string](https://ruby-doc.org/core/Kernel.html#method-i-60)**

**Use Case**: Run a command and wait for the results. STDOUT from the subprocess is
returned as a String.

**Params**

* `command` the command and its arguments

    Behaves like a [double-quote string literal](https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Strings),
    in that it allows escape characters and interpolation.

    ```ruby linenums="1"
    command = 'grep'
    arguments = '--verbose'
    pattern = '*'
    files = 'file1 file2 file3'
    command_stdout = `#{command} #{arguments} #{pattern} #{files}`
    ```

**Returns**: the stdout of the subprocess is returned as a string

**Raises**:

* `Errno::ENOENT` if the command could not be found in the PATH
* `Errno::EACCES` if the command exists but is not executable or is not a regular file

**Side Effects**

* The command exit status is saved in `$CHILD_STATUS`.
  See [Subprocess Status](#subprocess-status) for more details.

**Notes**

With backticks, the subprocess blocks the parent process until it completes so it should
be used for short-running programs.

The subprocess's `stderr` is sent to the parent process's `stderr`. `stderr` can be redirected
to `stdout` to capture both in a single string by using shell redirection as follows:

```ruby
stdout_and_stderr = `ls /usr/local/bin 2>&1`
```

The built in syntax `%x` is equivalent to the backtick operator.

```ruby
stdout_and_stderr = %x{ls /usr/local/bin 2>&1}
```

When using backticks, there is no way to supress Ruby's shell detection to avoid shell expansion.
See [How Commands Are Run](#how-commands-are-run) for more details. Use
[Kernel#system](#kernel-system) to avoid shell expansion.

When using backticks, there is no way to control the subprocess's environment (it gets the
global ENV from the parent) or give other subprocess special options like process
group, umask, current directory, limits or redirection.

## Kernel#system

**[system([env], command..., [options], exception: false) ⭢ true, false, nil](https://ruby-doc.org/core/Kernel.html#method-i-system)**

**Use Case**: Ideal for (1) a short running command, (2) where it is ok for stdout and stderr
  to be output as it runs, and (3) it only matters if the command succeeds or fails.

**Params**

* **env** [Hash] *(defaults to: { })* — updates the environment of the subprocess.
  See [Environment Isolation](#environment-isolation) for more details.

* **command** [String, Array<String\>] — the command to run.
  See [How Commands Are Run](#how-commands-are-run) for more details.

* **options** [Hash] *(defaults to: { })* — used to set various subprocess attributes.
  See [Kernel#spawn](https://ruby-doc.org/core/Kernel.html#method-i-spawn) for more details.

* **exception** [Boolean] *(defaults to: false)* — if `exception: true` is passed, the
  method raises an exception instead of returning false or nil.

**Returns**

* `true` if the command exits with 0 exit status
* `false` if the command exits with a non-zero exit status
* `nil` if the command could not be run.

**Raises**: only raises an error if the **exception** param is `true`.

* `Errno::ENOENT` if the command could not be found in the PATH
* `Errno::EACCES` if the command exists but is not executable or is not a regular file

**Side Effects**

* The command exit status is saved in `$CHILD_STATUS`.
  See [Subprocess Status](#subprocess-status) for more details.

**Notes**

* Blocks until the subprocess exits.

* The subprocess output is sent to the parent process's stdout and stderr. The subprocess
  output can be redirected using either [shell redirection](https://www.gnu.org/software/bash/manual/html_node/Redirections.html)
  by embedding the redirection directives in the command:

    ```ruby
    system('ls > file.txt')
    ```

    or by using the **options** param to specify redirection (see [Redirection](#redirection)
    for more details):

    ```ruby
    system('ls', { out: ['file.txt'] })
    ```

## Kernel#spawn

**[spawn([env,] command... [,options]) ⭢ pid](https://ruby-doc.org/core/Kernel.html#method-i-spawn)**

**Use Case**: Ideal for running multiple commands in parallel

**Params**

* **env** [Hash] *(defaults to: { })* — updates the environment of the subprocess.
  See [Environment Isolation](#environment-isolation) for more details.

* **command** [String, Array<String\>] — the command to run.
  See [How Commands Are Run](#how-commands-are-run) for more details.

* **options** [Hash] *(defaults to: { })* — used to set various subprocess attributes.
  See [Kernel#spawn](https://ruby-doc.org/core/Kernel.html#method-i-spawn) for more details.

**Returns**: the pid of the running subprocess

**Raises**:

* `Errno::ENOENT` if the command could not be found in the PATH
* `Errno::EACCES` if the command exists but is not executable or is not a regular file

**Side Effects**

* The command exit status is saved in `$CHILD_STATUS` after ithas been reaped via [wait](#wait).
  See [Subprocess Status](#subprocess-status) for more details.

**Notes**

This method is similar to [Kernel#system](#kernel-system) but it doesn't wait for the
subprocess to end.

Manage the subprocess using the following:

* Use [Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait)
  to wait for the subprocesses to end and collect its termination status

* Use [Process.detach](https://ruby-doc.org/core/Process.html#method-c-detach) to register
  disinterest in a subprocess's status to avoid creating zombies

* Use [Process.kill](https://ruby-doc.org/core/Process.html#method-c-kill) to prematurely
  end the process

See [Detach](#detach), [Wait](#wait), and [Kill](#kill) for more details.

## Kernel#exec

**[exec([env,] command... [,options])](https://ruby-doc.org/core/Kernel.html#method-i-exec)**

**Use Case**: Replace the current process by some other command

**Params**

* **env** [Hash] *(defaults to: { })* — updates the environment of the subprocess.
  See [Environment Isolation](#environment-isolation) for more details.

* **command** [String, Array<String\>] — the command to run.
  See [How Commands Are Run](#how-commands-are-run) for more details.

* **options** [Hash] *(defaults to: { })* — used to set various subprocess attributes.
  See [Kernel#spawn](https://ruby-doc.org/core/Kernel.html#method-i-spawn) for more details.

**Returns**: N/A - does not return unless an error is raised

**Raises**

* `Errno::ENOENT` if the command could not be found in the PATH
* `Errno::EACCES` if the command exists but is not executable or is not a regular file
* `SystemCallError` if the command could not be run for some other reason (eg. if exec is
  not supported on the platform)

**Side Effects**: N/A

**Notes**

Replaces the current process by running the given external command. The new process retains
the original process's ID. The new process may inherit the original process's environment
including open file descriptors.

Exec (and fork) is only available on UNIX-like systems. A SystemCallError is raised if the
command can't be run.

Limits modified via the `options` parameter are retained if the command can not be run
because hard limits are not restorable. These limits can be set to a different value but
not unset.

## Kernel#fork

**[fork ⭢ integer or nil](https://ruby-doc.org/core/Kernel.html#method-i-fork)**

**[fork { block } ⭢ integer or nil](https://ruby-doc.org/core/Kernel.html#method-i-fork)**

**Use Case**: Run a block of the program's Ruby code asynchronously in a subprocess

**Examples**

▸ called with a block

``` ruby
--8<-- "examples/fork_with_block.rb"
```

▸ called without a block

``` ruby
--8<-- "examples/fork_without_block.rb"
```

**Params**

* **block** — the optional block of Ruby code to run in a subprocess

**Returns**:

* `(Integer, nil)` - Returns the subprocess's pid in the parent process or nil in the subprocess

**Raises**:

* `Errno::ENOENT` if the command could not be found in the PATH
* `Errno::EACCES` if the command exists but is not executable or is not a regular file
* `SystemCallError` if the command could not be run for some other reason (eg. if exec is
  not supported on the platform)

**Side Effects**:

* The command exit status is saved in `$CHILD_STATUS` after ithas been reaped via [wait](#wait).
  See [Subprocess Status](#subprocess-status) for more details.

**Notes**

Fork creates a new process that is a duplicate of the current process. Both processes are
running the same Ruby program, at the same point, with the same state.

If fork is called *with a block*:

* execution in the child process continues in the block and exits with a status of zero
  when the block ends
* execution of the parent process continues with fork returning the pid of the child process
  (the block is not executed).

If fork is called *without a block*:

* execution of the child process continues with fork returning `nil`
* execution of the parent process continues with fork returning the pid of the child process

Manage the subprocess using the following:

* Use [Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait)
  to wait for the subprocesses to end and collect its termination status

* Use [Process.detach](https://ruby-doc.org/core/Process.html#method-c-detach) to register
  disinterest in a subprocess's status to avoid creating zombies

* Use [Process.kill](https://ruby-doc.org/core/Process.html#method-c-kill) to prematurely
  end the process

See [Detach](#detach), [Wait](#wait), and [Kill](#kill) for more details.

The subprocess can exit with `exit!` to avoid any exit handlers setup by the parent process.

Fork is only available on UNIX-like systems (check Process.respond_to?(:fork)). Use Kernel#spawn
on systems that don't support fork. Raises `SystemCallError` if called on a platform that does
not support fork.

## IO.popen

**[popen([env,] cmd, mode="r" [, options]) ⭢ io](https://ruby-doc.org/core/IO.html#method-c-popen)**

**[popen([env,] cmd, mode="r" [, options]) { |io or nil| block } ⭢ obj](https://ruby-doc.org/core/IO.html#method-c-popen)**

**Use Case**: Ideal for use cases where you want to stream a lot of data to the subprocess's
  stdin or from the subprocess's stdout and don't need to hold the whole result at one time

**Params**

* **env** [Hash] *(defaults to: { })* — updates the environment of the subprocess.
  See [Environment Isolation](#environment-isolation) for more details.

* **command** [String, Array<String\>] — the command to run.
  See [How Commands Are Run](#how-commands-are-run) for more details.

* **options** [Hash] *(defaults to: { })* — used to set various subprocess attributes.
  See [Kernel#spawn](https://ruby-doc.org/core/Kernel.html#method-i-spawn) for more details.

**Returns**: an IO stream connected to the subprocess.  Writing to it sends data to the
  subprocesses's stdin.  Reading from it retrieves data from the subprocess's stdout.

**Side Effects**:

**Notes**

* When to use: you need to interact with the standard out and standard in of a program
  and are not interested in stderr

[spawn](#spawn) can be used instead of IO.popen as follows:

``` ruby
# similar to r = IO.popen(command)
r, w = IO.pipe
pid = spawn(command, :out=>w)   # r, w is closed in the child process.
w.close
```

## Open3.popen3

**[popen3([env,] cmd... [, opts]) { |stdin, stdout, stderr, wait_thr| }](https://ruby-doc.org/stdlib/libdoc/open3/rdoc/Open3.html#method-c-popen3)**

**[popen3([env,] cmd... [, opts]) ⭢ [stdin, stdout, stderr, wait_thr]](https://ruby-doc.org/stdlib/libdoc/open3/rdoc/Open3.html#method-c-popen3)**

**Use Case**:

**Params**

**Returns**:

**Side Effects**:

**Notes**

Unfortunately, the docs don’t mention one crucial point — whatever redirections you pass will
be ignored, because `popen3` always overrides the redirection options with its own pipes.

So if you do need to inherit `stdin` and `Kernel#system` won’t do, `IO.popen` may be your only
choice. e.g. to inherit `stdin` and read `stdout` as a string:

## PTY.spawn

**[spawn(cmd...) { |r, w, pid| }](https://ruby-doc.org/stdlib/libdoc/pty/rdoc/PTY.html#method-c-spawn)**

**[spawn(cmd...) ⭢ [r, w, pid]](https://ruby-doc.org/stdlib/libdoc/pty/rdoc/PTY.html#method-c-spawn)**

**Use Case**:

**Params**

**Returns**:

**Side Effects**:

**Notes**

## How Commands Are Run

Most Ruby methods that run a subprocess
(such as [Kernel#system](https://ruby-doc.org/core/Kernel.html#method-i-system))
allow the command to be run to be specified in one of the following ways:

* `commandline` a single string specifying the command and its arguments
* `cmdName, arg1, ...` command name and one or more arguments passed as separate parameters
* `[cmdName, arg0], arg1, ...` command name and argv[0] passed as an array and zero or more
  arguments passed  as separate parameters

When running a command in a subprocess (eg. via exec, fork et al.), Ruby may run the command
via a subshell or execute the command directly. Ruby uses the following rules to determine
which to do:

When the command is a single string:

* When the command does not contain special shell syntax, the command is executed
  directly
* When the string contains special shell syntax, the command is passed to a subshell so the
  shell syntax can be interpreted. The subshell, in turn, runs the command.

    Special shell syntax includes redirection, shell variables starting with '$' or a semicolon.

When passing the command broken up into an Array:

* Ruby will always execute the command directly without a subshell

## What Shell Is Used

To determine which shell to run, Ruby first checks the environment variables
(in this order): `RUBYSHELL`, `SHELL`, or `COMSPEC`. If none of those environment variables
are set, `/bin/sh` is used.

## $CHILD_STATUS

[Backticks](#backticks) and [system](#system) set the global variable `$CHILD_STATUS`
(aka `$?`) based on the exit status of the subprocess that was run. [wait](#wait) (and similar
methods) set `$CHILD_STATUS` when it reports that an asynchronuous subprocess has terminated.

`$CHILD_STATUS` is either `nil` or an instance of
[Process::Status](https://ruby-doc.org/core/Process/Status.html).
This class encapsulates the information on the status of a running or terminated subprocess.
It stores the pid of the process, the exitstatus of the subprocess, the signal that terminated
the subprocess, and if the subprocess core dumped.

`$CHILD_STATUS` is thread-global variable which can have different values in different threads.

## Detach

Some operating systems retain the status of terminated child processes until the parent
collects that status. In Ruby, this is normally done by using some variant of
[Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait)).

If the parent never collects this status, the process is considered a
[a zombie process](https://en.wikipedia.org/wiki/Zombie_process).
A zombie process is a process has completed execution but still has an entry
in the OS process table.

If you don't care about the result of a subprocess, call
[Process.detach](https://ruby-doc.org/core/Process.html#method-c-detach)
register your disinterest in the result of the process.

In the background, this starts a Ruby thread to automatically reap the subprocess
status information when the subprocess exits. Once the OS knows we have this information,
it can clear it out of the process table.

## Wait

Use [Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait) to wait for
one or more subprocesses to finish.

**Waiting For A Single Subprocess**

Pass a single pid to [Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait) to
block until the subprocess has completed.
[Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait) returns the pid of the
process that finished and sets `$CHILD_STATUS` to the exit status of the subprocess.

```ruby linenums="1"
--8<-- "examples/wait1.rb"
```

**Waiting For Multiple Subprocesses I**

The most naive way to wait several subprocess to complete is to wait
for them serially, one at a time.  This can be accomplished using
[Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait) as follows.

```ruby linenums="1"
--8<-- "examples/wait2.rb"
```

Because of the way this has been implemented, subprocess completion is reported in the order
that the subprocesses were created, not necessarily in the order that they terminate.

**Waiting For Multiple Subprocesses II**

In order to report on each subprocess as it finishes, supply the special flag value
`-1` to [Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait) instead
of waiting on a specific pid. This blocks until any subprocess to terminates.

Just like the previous example, the pid of the terminated subprocess is returned and
`$CHILD_STATUS` is set to the subprocess's exit status.

```ruby linenums="1"
--8<-- "examples/wait3.rb"
```

With this implementation the subprocesses are report in the order they terminate.

**Get Signaled When Subprocesses Finish**

To be notified of subprocess completion in a totally asynchronous fashion, register to receive
a signal from the operating system as subprocesses are completed using a signal trap.

A [signal](https://en.wikipedia.org/wiki/Signal_(IPC)) is an asynchronous notification sent
by the operating system to a process in order to notify it of an event that occurred.

When a signal is sent, the operating system interrupts the target process' normal flow of
execution to deliver the signal. If the process has registered a trap handler for
that signal, that handler is executed.

[Kernel#trap](https://ruby-doc.org/core/Kernel.html#method-i-trap) allows a Ruby program to
specify how signals are handled. It takes two arguments: the name of the signal to trap and
the block of code to run when the named signal is received.

The block passed to [Kernel#trap](https://ruby-doc.org/core/Kernel.html#method-i-trap)
must be [reentrant](https://en.wikipedia.org/wiki/Reentrancy_(computing)) and
thread-safe. For detailed guidance on what is safe to call in a trap block, see the
article [Caveats for implementing Signal.trap callbacks](https://ruby-doc.org/core/doc/signals_rdoc.html).
To avoid problems in the trap block, the main thread of the program is blocked while
the trap block is executed.

The operating system will tell Ruby about subprocesses terminating with the `SIGCHLD` signal.

Ruby may call the trap after ***multiple*** subprocesses have ended. To handle this
situation, call [Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait) in
a loop with the `Process::WNOHANG` flag. This flag tells
[Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait) to return `nil`
rather than blocking if there are no more subprocesses that have terminated.

A complete implementation of the previous examples using a signal handler follows.  The
example shows a dashboard of the processes along with the elapsed time.

```ruby linenums="1"
--8<-- "examples/signal.rb"
```

The trap might be called for one or more processes exiting, hence the while loop in
the example above.

## Kill

In the previous examples, [Process.wait](https://ruby-doc.org/core/Process.html#method-c-wait)
waits for the subprocess to terminate on its own.
[Process.kill](https://ruby-doc.org/core/Process.html#method-c-kill)
can be used to terminate a process before it would otherwise do so on its own.

[Process.kill](https://ruby-doc.org/core/Process.html#method-c-kill) is based on the Unix
process API of the same name for sending a signal to a process. Originally, the kill command
could only kill a process. Later it was enhanced to allow you to send any signal.

[Signal.list](https://ruby-doc.org/core/Signal.html#method-c-list) names all the signals
that Ruby understands. The Wikipedia [Signals](https://en.wikipedia.org/wiki/Signal_(IPC))
page defines typial POSIX signals.

Which signal to send to a subprocess to make it terminate early depends on the subprocess.
There are three signals typically used to terminate a subprocess:

* **SIGINT** The SIGINT signal is sent to a process by its controlling terminal when a user
  wishes to interrupt the process. This is typically initiated by pressing Ctrl+C.

* **SIGTERM** The SIGTERM signal is sent to a process to request its termination. It can be
  caught and interpreted or ignored by the process. This allows the process to perform nice
  termination releasing resources and saving state if appropriate. SIGTERM is nearly identical
  to SIGINT.

* **SIGKILL** The SIGKILL signal is sent to a process to cause it to terminate immediately.
  In contrast to SIGTERM and SIGINT, this signal cannot be caught or ignored, and the receiving
  process cannot perform any clean-up upon receiving this signal.

    SIGKILL should be used as a last resort when terminating processes if it does not voluntarily
    exit in response to SIGTERM.

The following example uses
[Process.kill](https://ruby-doc.org/core/Process.html#method-c-kill) to stop any
subprocess that is still running after 3 seconds. In this case, the SIGINT signal is
used.

```ruby linenums="1" hl_lines="50-54 76"
--8<-- "examples/kill.rb"
```

## Environment

Without any action, the subprocess gets a copy of the parent process's environment.

Some methods take an `env` hash which can be used to add, change, or remove environment
variables destined for the subprocesses environment.

For these methods, the environment passed to the subprocess is the parent's environment merged
with `env`.

Additionally, any key in `env` whose value is `nil` is removed from the subprocess's environment.

The subprocess's environment is effectively set to: `ENV.merge(env).compact`

For methods that also take an `options` hash, if `options[:unsetenv_others]` is truthy,
then `ENV` is not passed to the subprocess's environment. The subprocess's environment is
instead effectively set to `env.compact`.

When using `options[:unsetenv_others]` be especially mindful about `PATH` and `HOME` environment
variables since system and user scripts often depend on them being set.

## Redirection

Spawn, system and other subprocess starting commands takes several options for
redirecting output. For instance, to map stderr in the subprocess to the parent processes
stdout:

```ruby
spawn('ls', :err => :out)
```

Using these options, the key is the stream (`:err` above) in the subprocess and
the value (`:out` above) is the stream in the parent process.

To redirect to a file map a stream to a filename:

```ruby
system('echo "1\n2\n3"', :out => "stdout.txt")
 => true
File.read('stdout.txt')
 => "1\n2\n3\n"
```

Or:

```ruby
system('echo "Error:\nNOT FOUND" >&2', :err => "stderr.txt")
 => true
File.read('stderr.txt')
 => "Error:\nNOT FOUND\n"
```

The same works for input:

```ruby
File.write("name.txt", "John Smith")
system('read -p "Name: " username; echo "You entered \'$username\'"', in: 'name.txt')
You entered 'John Smith'
 => true
```

Specify open mode and permissions by specifying the file as an array:

```ruby
system('echo "Line 1\nLine2"', :out => ['stdout.txt', 'w', 0644]) # overwrite
 => true
system('echo "Line 3\nLine4"', :out => ['stdout.txt', 'a']) # append
 => true
File.read('stdout.txt')
 => "Line 1\nLine2\nLine 3\nLine4\n"
```

To redirect into an already open file:

```ruby
file = open("output.txt", "w")
system('echo "Line 1\nLine 2"', :out => file)
 => true
file.close
 => nil
File.read("output.txt")
 => "Line 1\nLine 2\n"
```

To redirect into a Tempfile:

```ruby
file = Tempfile.new('output.txt')
begin
  system('echo "Line 1\nLine 2"', :out => file)
  file.close
  File.read(file.path)
ensure
  file.delete
end
 => "Line 1\nLine 2\n"
```

To redirect to a pipe objects to capture output:

```ruby
output, input = IO.pipe
system('echo "Line 1\nLine 2"', :out => input)
 => true
input.close
 => nil
output.read
 => "Line 1\nLine 2\n"
```

Pipes and asynchronous subprocesses allow us to do sophisticated things like
processing output as it is produced in a streaming fashion.

Multiple streams can be mapped a single destination by using an Array of stream names as
the key of the redirect:

```ruby
system('echo "1\n2"; echo "3\n4" >&2', [:out, :err] => "out.txt")
 => true
File.read('out.txt')
 => "1\n2\n3\n4\n"
```

To supress all output, redirect to /dev/null (using the device name given by
`IO::NULL` for portability):

```ruby
system('echo "1\n2"; echo "3\n4" >&2', [:out, :err] => IO::NULL)
 => true
```

## Limits

Sets boundaries for subprocesses: limit damage from buggy jobs that might eat up all
available system resources.

See [Process.setrlimit](https://ruby-doc.org/core/Process.html#method-c-setrlimit)

* Process.spawn rlimit options sets these limits
    * limit_cpu # seconds of CPU time the scipt can use

    * rlimit_as # sets bound (in bytes) for address space made available to program

    * Files open at a time, number of processes, etc.

    * Pay attention to the platform compatibility information listed for each

* There is an option to set soft limits and hard limits
    * Hard limits effects are both sudden and final usually resulting in the subprocess
      being terminated
    * If just one limit number is given, it is considered a hard limit:
        * :limit_cpu => 2
    * Soft limits raise a signal in the subprocess when the soft limit is hit (they can
      be thought of as a warning to the subprocess):
        * A hard limit needs to be specified along with the hard limit, the first number
          is the soft limit and the second number is the hard limit:
            * :limit_cpu = [1, 2]
    * Example:

      ```ruby
      trap("XCPU") do
        puts "Received SIGXCPU, shutting down"
        exit
      end
      ```

## Open Pipe

* Sense if being run in a console with $stdout.tty?
* Open an output stream and pipe to an external program
* To do this, add a pipe to the beginning of the filename in an open call.  For example,
  to pipe all output to a pager if you are running on an interactive console:

    ```ruby
    if $stdout.tty?
      pager = open("| less”, "w”)
      at_exit { pager.close }
      $stdout = pager
    end
    ```

* Make sure to close the pipe so the output is flushed in a timely fashion.

## Gems

* mixlib-shellout
* shell
* subprocess
* tty-command

## References

* [A Dozen (or so) Ways to Start Subprocesses in Ruby: Part 1](https://devver.wordpress.com/2009/06/30/a-dozen-or-so-ways-to-start-sub-processes-in-ruby-part-1/)
* [A Dozen (or so) Ways to Start Subprocesses in Ruby: Part 2](https://devver.wordpress.com/2009/07/13/a-dozen-or-so-ways-to-start-sub-processes-in-ruby-part-2/)
* [A Dozen (or so) Ways to Start Subprocesses in Ruby: Part 3](https://devver.wordpress.com/2009/10/12/ruby-subprocesses-part_3/)
* [When to use each method of launching a subprocess in Ruby](https://stackoverflow.com/questions/7212573/when-to-use-each-method-of-launching-a-subprocess-in-ruby/7263556#7263556)
* [Using the PTY Class to Test Interactive Apps in Ruby](https://toasterlovin.com/using-the-pty-class-to-test-interactive-cli-apps-in-ruby/)
* [Stream processing of shell command results](https://mensfeld.pl/2016/12/ruby-stream-processing-of-shell-command-results/)

* [IO in Ruby](https://thoughtbot.com/blog/io-in-ruby)
* [The TTY demystified](http://www.linusakesson.net/programming/tty/)
* [Signal](https://en.wikipedia.org/wiki/Signal_(IPC))
* [Reentrancy](https://en.wikipedia.org/wiki/Reentrancy_(computing))

* [Signals, Traps, and Rescues](https://timuruski.net/blog/2014/signals-traps-and-rescues/)
* [Caveats for implementing Signal.trap callbacks](https://ruby-doc.org/core/doc/signals_rdoc.html)
* [Signal handling in Ruby and its internals](https://kirshatrov.com/2017/04/17/ruby-signal-trap/)
* [Signal handling and Ruby](https://gist.github.com/mvidner/bf12a0b3c662ca6a5784)
* [SignalException](https://www.exceptionalcreatures.com/bestiary/SignalException.html)
* [Signals Referenced in RubyTapas Episodes](https://www.rubytapas.com/references/signals/)

## Subprocess Status

## Kernel System

## Environment Isolation

## Spawn

## System
