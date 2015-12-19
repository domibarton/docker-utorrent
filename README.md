## About

Docker image to run the [utorrent server](http://www.utorrent.com/) in a containerized environment.

The utserver will run under it's owner user (`utorrent:utorrent`) with user ID `666`.

## Update utorrent

The utorrent server will automatically be loaded when you create the container.
Therefor you can remove and simply re-create the container at any time to get the new utorrent version.

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
