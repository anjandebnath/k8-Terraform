# k8-Terraform
Under this project I am learning the basics of DevOps and Cloud Architecture pattern

Document Link: https://docs.google.com/document/d/1QLBJ6NbI1ysuVY7toN3WqBO_MbLvVDgZD4ctbC7fEF8/edit?tab=t.0#heading=h.b0zthp3z1ihh

Scope of this Branch:
We’ll add file storage so the WebApp has a location to store its videos. We want to have distinct areas of responsibility in
our application for video streaming and video storage.

We are adding file storage so that we have a location to store the videos used by
our application. A common approach is to use a storage solution provided
by one of the big cloud vendors. 

Live Reload
Live reload is really important to fast development because we can make
changes to our code and have our microservice automatically restart.
We can run it in development mode with nodemon for live
reload like this

        npm run start:dev

In the next feature branch, we’ll add a database. At this point, we add a database so that we
have a place to record the path to each video, but this is really just an excuse to get a database in place.

## vagrant commands 

   `vagrant ssh`
   `sudo -i`
   `cd /vagrant`

## vagrant check home 
    `cd /home/vagrant/node_project`
    `ls -l`

## If your project is stored in a different path inside the VM, adjust the command

    ` config.vm.synced_folder "/Users/anjandebnath/Documents/NodeProject/my-new-project", "/home/vagrant/node_project" `

## docker build -t my-node-app /home/vagrant/node_project
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
    




