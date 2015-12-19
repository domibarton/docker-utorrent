## About

Docker image to run the [utorrent server](http://www.utorrent.com/) in a containerized environment.

The utserver will run under it's owner user (`utorrent:utorrent`) with user ID `666`.

## Update utorrent

The utorrent server will automatically be updated when you (re)start the conatiner.

## Build

```bash
git clone https://github.com/dbarton/docker-utorrent.git
cd docker-utorrent
docker build -t <tag> .
```

## Run

```bash
docker run --name utorrent -v <settings path>:/settings -v <media path>:/media dbarton/utorrent
```
