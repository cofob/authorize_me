# authorize_me

Authorize me - dead simple ssh authorization synchronization written in Bash ([Amber-lang](https://amber-lang.com/), actually, but it's compilled to Bash).

## What is this?

This is simple program that integrates into sshd `AuthorizedKeysCommand` functionality. It does one simple thing - returns public ssh keys for given username. sshd automatically execute this program and consume ssh keys, if keys matching - login approved.

To increase stability it also caches remote keys to local file and reads it, if server is unavailable.

## Configuration

Program has following environment variables:

- `SERVER_URL` **(required)** - URL from where to fetch data. Example: `https://kmi.aeza.net/hFRDkMAoOl`.
- `USERS_PATH` - Default filesystem path where data from remote will be stored. Defaults to `/var/authorize_me/users.json`.
- `LOG_LEVEL` - Logging level. Allowed values: `DEBUG`, `INFO`, `WARN`, `ERROR`. Defaults to `INFO`.
- `LOG_PATH` - Path to where logs will be written. Defaults to `/dev/stderr`.

Also `.env` files are readed automatically.

## Requirements

- `jq`
- `busybox`
