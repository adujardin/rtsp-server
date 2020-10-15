
FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --fix-missing \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev wget git vim python3-pip libgstrtspserver-1.0-0 dos2unix \
    libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-pulseaudio libgstrtspserver-1.0-0 \
    xz-utils

COPY src /src
WORKDIR /src

RUN dos2unix /src/* && chmod +x install_rtsp.sh && bash +x install_rtsp.sh

#download sample video .mp4
#RUN wget https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4

RUN gcc -o stream  stream.c  `pkg-config --cflags --libs gstreamer-rtsp-server-1.0`

RUN echo "./stream \"( filesrc location=$1 ! qtdemux ! h264parse ! rtph264pay name=pay0 pt=96 )\"" > start.sh
ENTRYPOINT ["bash", "+x", "start.sh"]
