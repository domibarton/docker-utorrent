<p align="center">
    <h2 align="center">GitHub Readme Stats</h2>
</p>
  <p align="center">
      ## Contributing [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)
    <a href="https://github.com/yurilchuk/utorrent-kubernetes/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/yurilchuk/utorrent-kubernetes/?color=0088ff" />
    </a>
    <a href="https://github.com/yurilchuk/utorrent-kubernetes/pulls">
      <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/yurilchuk/utorrent-kubernetes/?color=0088ff" />
    </a>
    <br />
    <br />
  </p>

  ![example workflow](https://github.com/github/docs/actions/workflows/main.yml/badge.svg)

## About

Docker image to run the [utorrent server](http://www.utorrent.com/) in a Kubernetes environment.

### Run

To run the utorrent k8s container you can execute:

```
sudo kubectl apply -n utorrent -f https://raw.githubusercontent.com/yurilchuk/utorrent-kubernetes/master/utorrent-kube.yaml
```

If do you want to create your own k8s yaml file, just use the docker image:

```
image: yurilchuk/utorrent-kubernetes:latest
```

### Volumes

You need to create a local Path: `/storage/hd0/utorrent` 

Pod Volume:

* `/utorrent/shared/`: Directory for your files