# k8-Terraform
Under this project I am learning the basics of DevOps and Cloud Architecture pattern

Document Link: https://docs.google.com/document/d/1QLBJ6NbI1ysuVY7toN3WqBO_MbLvVDgZD4ctbC7fEF8/edit?tab=t.0#heading=h.b0zthp3z1ihh

Scope of this Branch:

RabbitMQ server is either a named queue or a message exchange. The combination of queues and exchanges gives us a lot of flexibility in how we structure our messaging architecture.

At no point do the sender and receiver communicate directly.

To publish a message to a queue or an exchange, we must first add a RabbitMQ server to our application.

Rather than directing our message to a particular microservice, as we did when sending messages via HTTP POST requests, we are instead directing these to a particular queue or exchange on our RabbitMQ server with the server located by DNS.

The message sender uses DNS to resolve the IP address of the RabbitMQ server. 
The receiver also uses DNS to locate the RabbitMQ server and communicate with it to retrieve the message from the queue.

 
The RabbitMQ server is fairly heavyweight, and it takes time to start up and get ready to
accept connections. Our tiny microservices, on the other hand, are lightweight and ready in just moments.

To be a fault-tolerant and well-behaved microservice, it should really wait until the RabbitMQ server is ready before it tries to connect. Better yet, if RabbitMQ ever goes down (say because we are upgrading it), we’d like
our microservices to handle the disconnection and automatically reconnect as soon as possible. We’d like it to work that way, but that’s more complicated. For the moment, we’ll solve this with a simple workaround.

What’s the simplest way to solve this problem? We’ll add an extra command to our Dockerfile that delays our microservice until the RabbitMQ server is ready. 

        npm install --save wait-port

In the Dockerfile-dev Uses npx to invoke the locally installed wait-port command to wait until the server at hostname rabbit is accepting connections on port 5672

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
    




