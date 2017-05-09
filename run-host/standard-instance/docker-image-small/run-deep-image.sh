

sudo docker build -t "deep-image" .
sudo nvidia-docker run -it -d -v $(pwd)/projects:/projects -p 8888:8888 -p 6006:6006 --name deep-container deep-image

