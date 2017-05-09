
# run with argument: name-of-instance

LOCAL_PORT=8889

echo "attempting to run jupyter notebook on localhost:$LOCAL_PORT"
# starts the instance if is TERMINATED 
gcloud compute instances start $@
# sets up ssh-tunnel and logs in to server
gcloud compute ssh --ssh-flag "-L $LOCAL_PORT:localhost:8888" $@ 


