# k8-Terraform
Under this project I am learning the basics of DevOps and Cloud Architecture pattern

Document Link: https://docs.google.com/document/d/1QLBJ6NbI1ysuVY7toN3WqBO_MbLvVDgZD4ctbC7fEF8/edit?tab=t.0#heading=h.b0zthp3z1ihh

Scope of this Branch:
feature_2/boot_separate_microservice:
We created an AWS Storage account, and we uploaded our test video. Then we created our
second microservice, the AWS Storage microservice, which is a REST API
that abstracts our storage provider. After that, we updated our videostreaming microservice so that instead of loading the video from the filesystem, it now retrieves the video via the video-storage microservice.

feature_3/mongodb_configure

Here we update our video-streaming microservice to delegate storage to another microservice. We are separating our concerns so that the videostreaming microservice is solely responsible for streaming video to our
user and so that it doesn’t need to know the details of how storage is handled.

   npm run start:dev 
   http://localhost:3001/video



The first thing we need is metadata storage for each video. We’ll start using our database by storing the path to each video. This will fix the problem we encountered earlier of having a hard-coded path to the video file
in our video-streaming microservice.

MongoDB is one of the most popular of the so-called NoSQL variety of databases. Using Docker allows us to have an almost instant database. MongoDB is also known to have high performance and is extremely scalable.

We will add one new container to our application to host a single database server. We only need a single server,
but we can host many databases on that server. 

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
    




