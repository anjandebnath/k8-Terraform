# k8-Terraform
Under this project I am learning the basics of DevOps and Cloud Architecture pattern

Scope of this Branch:

- We used Terraform to build and publish the Docker image for our first
microservice, the video-streaming microservice, which we then deployed to our Kubernetes cluster.
- Create token based authentication for kubernetes dashboard access locally
- We used Docker to build and publish the image for our microservice.
- Authentication from the cluster to the container registry (to pull the image) was a bit tricky, but we created a Kubernetes secret 
to handle that.

What features are covered and inprogress sofar
- [x] Running microservices with Node.js 
- [x] Packaging and publishing our microservices with Docker 
- [x] Building and running our application in development with Docker Compose 
- [x] Storing and retrieving data using a mongodb database
- [x] Storing and retrieving files using external file storage AWS S3 
- [x] Communication between microservices with HTTP requests and RabbitMQ messages 
- [x] Deploying the application to a Kubernetes cluster using Terraform
- [] Creating a CD pipeline with Github Actions Pipelines 
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml`

![PODs](https://github.com/anjandebnath/k8-Terraform/blob/main/video-streaming/videos/pods.png?raw=true)









