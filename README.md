# deep-server: Steps



This is for demo purposes only.

* Setup a GPU-enabled Google cloud instance.
* Install docker and NVIDIA dependencies.
* Build a docker image with cuda-dependencies ML-libraries, TensorFlow and Jupyter.
* Confugure Jupyter.
* Run container. 
* Access your gpu instance and ML-environment from local browser.

## Prepare

In order to be able to run the scripts and setup the environment, make sure to have a Google cloud account setup and access to GPU-instances. Note that GPU-instances are billed per hour and that they will incur costs even by being idle. Make sure to terminate the instance when done with your computations (and restart when needed again).

1. Make sure account and access is in place.
2. Do reserach on pricing, regions/zones etc.
3. Install `gcloud` (Google Cloud SDK).
4. Make sure you have ssh keys in order (try setting up an instance and login from terminal using ssh or `gcloud compute ssh machine-name`)

## 1 Create instance

The following found in `run-local` directory sets up a GPU instance named deep-server-1 with a Nvidia Tesla K80 GPU. You might want to bump up the processor, ram and disk if working with large datasets. Choose a zone in your part of the world.

```
# creates a standard instance with 1 CPU, 3.75 GB ram
# and 1 Tesla K80 GPU running Ubuntu

gcloud beta compute instances create deep-server-1 \
  --machine-type n1-standard-1 \
  --zone us-east1-d \
  --accelerator type=nvidia-tesla-k80,count=1 \
  --image-family ubuntu-1604-lts \
  --image-project ubuntu-os-cloud \
  --boot-disk-size 50GB \
  --boot-disk-device-name deep-disk-1 \
  --no-boot-disk-auto-delete \
  --maintenance-policy=TERMINATE  
 
# set default zone for  
gcloud config set compute/zone us-east1-d

```

## 2 Setup server

On the 'host' (`deep-server-1`) run the shell script `setup-deep-server.sh` to install:

1. Nvidia drivers.
2. Docker.
3. Nvidia Docker (Nvidias docker wrapper).
4. Creates a directory `/home/user/projects` which will be mounten on container.


## 3 Build image and run container

The script ´run-deep-image.sh´ contains commands for building docker images and for running the container. Port for Jupyter notebook are forwarded, so are port for Tensorboard. 

```
sudo docker build -t "deep-image" .
# TODO: add error checks
echo "image built.. proceeding to run container.."
# --restart=always makes sure that the container is up en running after restart of the server
sudo nvidia-docker run -it -d --restart=always -v $HOME/projects:/projects -p 8888:8888 -p 6006:6006 --name deep-container deep-image
```

## 4 Try it out

With everything set up, run `sh start-notebook.sh deep-server-1` to:

1. Start server if shut down.
2. Setup an ssh tunnel to your server.

```
LOCAL_PORT=8889

echo "attempting to run jupyter notebook on localhost:$LOCAL_PORT"
# starts the instance if is TERMINATED 

gcloud compute instances start $@
# sets up ssh-tunnel and logs in to server
gcloud compute ssh --ssh-flag "-L $LOCAL_PORT:localhost:8888" $@ 
```
Then open up your browser and browse localhost:8889 to access your environment.


##### References

I have followed the steps outlined in https://medium.com/google-cloud/containerized-jupyter-notebooks-on-gpu-on-google-cloud-8e86ef7f31e9, but with the scripts more or less re-written. 





