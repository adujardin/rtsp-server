# RTSP Server from video file using Docker

Original blogpost at https://medium.com/@pratik.mungekar/stream-video-using-gstreamer-rtsp-server-ca498f4a54bd

## Building docker image

```
docker build -t rtsp-server:file_input .
```
Or 

```
docker pull adujardin/rtsp-server:file_input
```

## Running it

The filepath need `/host` in front since we added the whole `/` as a volume. On the host the sample video will be located at `/home/user/Downloads/sample-mp4-file.mp4`. This video sample can be downloaded at https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4

```sh
docker run --rm -v /:/host -it -p 8554:8554 rtsp-server:file_input /host/home/user/Downloads/sample-mp4-file.mp4
```

Console output :
```
...
stream ready at rtsp://127.0.0.1:8554/test
```



To view the stream, vlc can be used with the provided URL (`rtsp://127.0.0.1:8554/test`)

![](vlc_preview.jpg)
