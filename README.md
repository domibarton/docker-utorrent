## About

Docker image to run the [utorrent server](http://www.utorrent.com/) in a containerized environment.

The docker image currently supports:

* running utorrent under its __own user__ (not `root`)
* changing of the __UID and GID__ for the utorrent user

## Run

### Run via Docker CLI client

To run the utorrent container you can execute:

```bash
docker run --name sickbeard -v <datadir path>:/datadir -v <media path>:/media -p 8081:8081 yurilchuk/utorrent-kubernetes
```

Open a browser and point your to [http://my-docker-host:8080/gui](http://my-docker-host:8080/gui)

## Run via Docker Compose

You can also run the utorrent container by using [Docker Compose](https://www.docker.com/docker-compose).

If you've cloned the [git repository](https://github.com/domibarton/docker-utorrent) you can build and run the Docker container locally (without the Docker Hub):

```bash
docker-compose up -d
```

If you want to use the Docker Hub image within your existing Docker Compose file you can use the following YAML snippet:

```yaml
utorrent:
    image: "yurilchuk/utorrent-kubernetes"
    container_name: "utorrent"
    volumes:
        - "<settings path>:/settings"
        - "<done path>:/media/done"
        - "<downloading path>:/media/downloading"
        - "<torrents path>:/media/torrents"
    ports:
        - "8080:8080"
        - "6881:6881"
    restart: always
```

## Configuration

### Volumes

Please mount the following volumes inside your utorrent container:

* `/settings`: Holds all the utorrent settings file
* `/media/done`: Directory for your downloaded media
* `/media/downloading`: Directory for your downloading media
* `/media/torrents`: Directory for your torrent files

### UID and GID

By default utorrent runs with user ID and group ID `666`.
If you want to run utorrent with different ID's you've to set the `UTORRENT_UID` and/or `UTORRENT_GID` environment variables, for example:

```
UTORRENT_UID=1234
UTORRENT_GID=1234
```