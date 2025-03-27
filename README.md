# k8-Terraform
Under this project I am learning the basics of DevOps and Cloud Architecture pattern

Scope of this Branch:

we will create a Kubernetes cluster and deploy containers to it: a MongoDB database, a RabbitMQ server, and of
course, our video streaming microservice. 

We’ll build our production infrastructure. We’ll use Terraform to create the infrastructure for our microservices application, including our Kubernetes cluster.

Kubernetes is the computing platform that we use to host our microservices in production.

Terraform allows us to script the creation of cloud resources and application infrastructure.
https://docs.google.com/document/d/1DqJl-yPT9DeWYcRHD81TXcbRBvPhLO2GRYnH_HpTkDY/edit?tab=t.0#heading=h.u82umkmrzbk1


There are many reasons to use Kubernetes. The simplest reason is to avoid vendor lock-in. All the main cloud vendors offer their own container orchestration services that are good in their own right. But each of these also offers a managed Kubernetes service, so why use a proprietary service when you can instead use Kubernetes? Using Kubernetes means our application can be portable to any cloud vendor.

Most importantly, Kubernetes has an automatable API. This is what will allow us to build our automated deployment pipeline.


Kubectl is the official and primary method of interaction with Kubernetes. Anything that can be done with Kubernetes can be done
from Kubectl-configuration, deployment of containers, and even monitoring live applications.


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
    




