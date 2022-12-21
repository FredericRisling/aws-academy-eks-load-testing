# aws-academy-eks-load-testing

The goal of this project is to evaluate the ability of the AWS academy platform to sustain a workload deployed on the maximum number of VMs that can be provisioned by account limits. 

In order to do so a simple webserver is deployed with AWS EKS. 

Step by Step: 

The webserver is based on https://github.com/eaccmk/node-app-http-docker
The webserver is then dockerized and published on docker-hub: https://hub.docker.com/r/f2499r/node-app

The AWS EKS cluster has to be configured in the AWS management console. 
NOTE: AWS academy has the limitation that you cannot add users and roles. Also you can not assign existing roles to users. Therefore you have to use the LabRole for the cluster as well as the worker nodes. 
