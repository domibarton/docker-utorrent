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