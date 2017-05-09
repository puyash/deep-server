
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