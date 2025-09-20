# node-express-app
CICD project for node express app

## We use Terraform user_data to pulls an already-built image from Docker Hub, copies files from it into /home/ubuntu/app, and then runs the container.  

1.	EC2 spins up.  

2.	user_data.sh installs Docker.  

3.	Logs into Docker Hub using credentials you pass via Terraform.  

4.	Builds the Docker image from /home/ubuntu/app.  

5.	Pushes that image back to your Docker Hub repo.  

6.	Runs the container from that freshly built image. 

7.	We automatically generate unique version tags in our image, we can roll back to an older version if needed.  

8. On EC2, the script stops the old container, pulls the new version, and runs it.  
