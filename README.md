# authorize_me

Authorize me - dead simple ssh authorization synchronization written in Bash ([Amber-lang](https://amber-lang.com/), actually, but it's compilled to Bash).

## What is this?

This is simple program that integrates into sshd `AuthorizedKeysCommand` functionality. It does one simple thing - returns public ssh keys for given username. sshd automatically execute this program and consume ssh keys, if keys matching - login approved.

To increase stability it also caches remote keys to local file and reads it, if server is unavailable.

Also repository contains very simple http server that server JSON files from `HOSTS_DIR` folder based on request IP. If request coming from 1.2.3.4 src IP it will respond with content of `1.2.3.4.json` file.

## Configuration

Program has following environment variables:

- `SERVER_URL` **(required, client-only)** - URL from where to fetch data. Example: `https://kmi.aeza.net/hFRDkMAoOl`.
- `USERS_PATH` **(client-only)** - Default filesystem path where data from remote will be stored. Defaults to `/var/authorize_me/users.json`.
- `HOST` **(server-only)** - Listen address. Defaults to `127.0.0.1`.
- `PORT` **(server-only)** - Listen port. Defaults to `8080`.
- `HOSTS_DIR` **(server-only)** - Directory where user keys are stored. Defaults to `/var/authorize_me`.
- `LOG_LEVEL` - Logging level. Allowed values: `DEBUG`, `INFO`, `WARN`, `ERROR`. Defaults to `INFO`.
- `LOG_PATH` - Path to where logs will be written. Defaults to `/dev/stderr`.

Also `.env` files are readed automatically.

## Requirements

- `socat` **(for server)**
- `jq` **(for client)**
- `busybox` **(for server and client)**
