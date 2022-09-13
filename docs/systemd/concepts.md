# systemd

Handles all system state and init stuff during bootup and after.

More of a system manager than a service manager. It reacts to system level events.

{:toc}

## What is systemd made of?

* systemctl
* journalctl
* init
* Process management
* Network management (networkd)
* Login management (logind)
* Logs (journald)
* Etc.

## Directory and files

### Configuration files

| Path         | Description                                          |
| ------------ | ---------------------------------------------------- |
| /etc/systemd | Contains configuration files for systemd components. |

Not all systemd componets are used on every distribution. For instance, in RHEL
**timesyncd** is not used.

Configuration files typically list ALL possible configuration items. Most will be
commented out. These commented out entries show the (compiled in) default values for
each setting.

Get help on a particlar setting using the `man` command. Use the string
`systemd-{file}` to get help for the settings in a particular config file. For example
`man systemd-system.conf`

### Unit files

| Path                      | Description                                                  |
| ------------------------- | ------------------------------------------------------------ |
| `/lib/systemd/system`     | The default location for unit files that either come with the operating system or come with any packages that you might install |
| `/usr/lib/systemd/system` | Unit files from locally installed packages (e.g. via apt-get) |
| `/run/systemd/system`     | Transient unit files that are generated                      |
| `/etc/systemd/system`     | The location for user created unit files. Any unit files in this directory have have the same name as unit files in `/lib/systemd/system` take precedence. |

A unit file is a plain text ini-style file that encodes information about a service, a
socket, a device, a mount point, an automount point, a swap file or partition, a start-
up target, a watched file system path, a timer controlled and supervised by systemd(1),
a resource management slice or a group of externally created processes.

Each file is a plain text file divided into sections, with configuration entries in the
style key=value. Empty lines and lines starting with "#" or ";" are ignored, which may
be used for commenting.

See `man systemd.unit` for full documentation.

### Executables

| Path           | Description                                                  |
| -------------- | ------------------------------------------------------------ |
| `/lib/systemd` | Contains most of the systemd executables. There are symbolic links in either /bin or /usr/bin directories that point to some of the executable files here. |

## Systemd units

A thing that systemd manages. systemd can manage these type of things:

| Unit Type          | Description                                                  |
| ------------------ | ------------------------------------------------------------ |
| service            | These are the configuration files for services. They replace the old-fashioned init scripts that we had on the old System V (SysV) systems. |
| socket             | Sockets can either enable communication between different system services or they can automatically wake up a sleeping service when it receives a connection request. |
| slice              | Slice units are used when configuring **cgroups**.           |
| mount or automount | These contain mount point information for filesystems that are controlled by systemd. Normally, they get created automatically, so you shouldn't have to do too much with them. |
| target             | Target units are used during system startup, for grouping units and for providing well-known synchronization points. Akin to named runlevels |
| timer              | Timer units are for scheduling jobs that run on a schedule. They replace the old cron system. |
| path               | Path units are for services that can be started via path-based activation. |
| swap               | Swap units contain information about your swap partitions.   |
| device             | Many system devices are automatically represented inside systemd by device units, which can be used to activate services when a given device exists in the file system. Device units are named after the `/sys/` and `/dev/` paths they control. |
| scope              | Scopes units manage a set of system processes. Unlike service units, scope units manage externally created processes and do not fork off processes on its own. |

A unit is described by options in a unit file. Unit file options are described by
`man systend.unit`. This man page is an index that directs to the right man page for
each parameter.

### A minimal unit file

```ini
[Unit]
Description=A very simple service created by James
# bring up only after networking has come up
After=network-up.target

[Service]
# the command for starting this service
ExecStart=/usr/local/bin/myservice

[Install]
# this unit should be running in order to consider the multi-user unit to be considered up.
WantedBy=multi-user.target
```

### Service unit file

Service units are the equivalent of init scripts on the old SysV systems. Use them to
configure services (aka *daemons*). A service can be pretty much anything that starts
automatically and runs in the background.

Service unit files are divided into three sections: `[Unit]`, `[Service]`, and `[Install]`.

| Section     | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| `[Unit]`    | The `[Unit]` section contains generic options about the unit that is not dependent on the type of unit. These options are documented by `man systemd.unit`.<br /><br />The most used options are `Description`, `Documentation`, and `After`. |
| `[Service]` | The `[Service]` section contains options which can only be used in a service unit file. <br /><br />These options describe the service and the process it supervises. These options are documented by `man systemd.service`. |
| `[Install]` | The `[Install]` section describes what happens when the unit is enabled or disabled. This section is not interpreted by `systemd` during runtime; it is used by the `enable` and `disable` commands of the `systemctl` during installation of a unit.<br /><br />These options are documented by `man systemd.unit`. |

### Socket unit file

### Path unit file

## Enabled vs. Disabled

An enabled unit is launched at bootup time. A disabled unit is not. Has nothing to do
with the current running state of the unit.

## Active vs. Inactive

An active unit is currently running. An inactive unit is not.

## Controlling a service

### Verify the status of a service

### Starting, stopping, and reloading a.service

### Enabling and disabling a service

### Kiling a service

### Masking a service

## journalctl

| Command | Description |
| ------- | ----------- |
|         |             |

## User Level Units
