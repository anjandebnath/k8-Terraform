# k8-Terraform
Under this project I am learning the basics of DevOps and Cloud Architecture pattern

## vagrant commands 

   `vagrant ssh`
   `sudo -i`
   `cd /vagrant`

## vagrant check home 
    `cd /home/vagrant/node_project`
    `ls -l`


## docker build -t my-node-app /home/vagrant/node_project
    ` config.vm.synced_folder "/Users/anjandebnath/Documents/NodeProject/my-new-project", "/home/vagrant/node_project" `



## If your project is stored in a different path inside the VM, adjust the command
   `docker build -t my-node-app /home/vagrant/node_project`

## Run the Docker Container, and the ID that generated You’ll need this ID to invoke future Docker commands that relate
to the container.

    `docker run -d -p 3000:3000 --name my-running-app my-node-app`

    ce263ec9596c2197b8d862d8730f3e4a64d76ba73d656eb382547bd48df285c1

    container id : 3dcd7aec2686


## Run the Container with Port Mapping
docker run -p 3000:3000 -e PORT=3000 my-node-app



## Verify the running continer 

#### To check if your container is running:
    docker ps

#### To see the container logs:
    docker logs my-running-app

#### To stop the container
    docker stop my-running-app

#### To remove the container
    docker rm my-running-app    
    




