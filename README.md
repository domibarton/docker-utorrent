<p align="center">
    <h2 align="center">GitHub Readme Stats</h2>
</p>
  <p align="center">
    <a href="https://github.com/yurilchuk/utorrent-kubernetes/actions">
      <img alt="Tests Passing" src="https://github.com/anuraghazra/github-readme-stats/workflows/Test/badge.svg" />
    </a>
    <a href="https://github.com/yurilchuk/utorrent-kubernetes/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/anuraghazra/github-readme-stats?color=0088ff" />
    </a>
    <a href="https://github.com/yurilchuk/utorrent-kubernetes/pulls">
      <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/anuraghazra/github-readme-stats?color=0088ff" />
    </a>
    <br />
    <br />
  </p>

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