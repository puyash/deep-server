

sudo docker build -t "jupyter-image" .
echo "image built.. proceeding to run container.."
# --restart=always makes sure that the container is up en running after restart of the server
sudo docker run -it -d --restart=always -v $HOME/projects:/projects -p 8888:8888 -p 6006:6006 --name jupyter-container jupyter-image

