# k8-Terraform
Under this project I am learning the basics of DevOps and Cloud Architecture pattern

Document Link: https://docs.google.com/document/d/1QLBJ6NbI1ysuVY7toN3WqBO_MbLvVDgZD4ctbC7fEF8/edit?tab=t.0#heading=h.b0zthp3z1ihh

Scope of this Branch:
So far the video-streaming microservice has a mongodb database, and the video-storage microservice uses external cloud storage AWS S3 to store the video files. 

Actually, we wouldn’t have gotten this far without having already used HTTP requests for communication between the video-streaming and video-storage microservice.

We are using the history microservices in this chapter as an example of how microservices can send and receive messages to each other. Actually, this new microservice really does have a proper place in FlixTube, and as the name suggests, it records our user’s viewing history.

The message we’ll transmit between microservices is the viewed message.To keep the examples in this repo simple, we’ll drop out the video-storage microservice.

As a way to explore communication methods, we’ll have the video-streaming microservice send a viewed message to the history microservice to record our user’s viewing history.

Having an efficient live reload mechanism is even more important at the application level than it is at the microservice level. 
Unfortunately, in transitioning from direct use of Node.js to running our microservices in Docker containers, we lost
our ability to automatically reload our code.

Because we are baking our code into our Docker images, we aren’t able to change it afterward!
And for repeated rebuilds and restarts, the time really adds up, especially as our application grows in size.

We’ll upgrade our Docker Compose file to support sharing code between our development workstation and our containers. 

we’ll create separate Dockerfiles for our development and production modes. In each case, our needs differ. For development, we prioritize fast iteration. For production, we prioritize performance and security.

To share the code, we use one Docker volume. 



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
    




