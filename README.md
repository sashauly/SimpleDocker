# Simple-Docker

> Introduction to docker. Developing a simple docker image for your own server.

## Table of Contents

- [Simple-Docker](#simple-docker)
  - [Table of Contents](#table-of-contents)
  - [Overhaul](#overhaul)
  - [Part 1. Ready-made docker](#part-1-ready-made-docker)
  - [Part 2. Operations with container](#part-2-operations-with-container)
  - [Part 3. Mini web server](#part-3-mini-web-server)
  - [Part 4. Your own docker](#part-4-your-own-docker)
  - [Part 5. **Dockle**](#part-5-dockle)
  - [Part 6. Basic **Docker Compose**](#part-6-basic-docker-compose)

## Overhaul

As a result of the work you should provide a report on the first two tasks. Each part of the task describe what should be added to the report once it has been completed. This can be answers to questions, screenshots, etc.
[Here it is](./src/report.md).

As a result of the third task you should provide source files for running the web server.

As a result of the fourth and fifth tasks you should provide dockerfiles.

As a result of the sixth task you should provide a *docker-compose.yml* file and the dockerfiles needed to run it (if not provided earlier).

- A report with a .md extension must be uploaded to the repository, in the src folder.
- All parts of the task should be highlighted in the report as level 2 headings.
- Within one part of the task, everything that is added to the report must be in the form of the list.
- Each screenshot in the report must be briefly captioned (what’s in the screenshot).
- All screenshots must be cropped so that only the relevant part of the screen is shown.
- It’s allowed to have several task points shown in one screenshot, but they must all be described in the caption.
- Source files for running the web server from the third task should be uploaded to the repository, in the src/server folder.
- Dockerfiles from the fourth and fifth tasks should be uploaded to the repository, in the src folder.
- *docker-compose.yml* from the sixth task should be uploaded to the repository, in the src folder.

## Part 1. Ready-made docker

As the final goal of your little practice you have immediately chosen to write a docker image for your own web server, so first you need to deal with a ready-made docker image for the server.
You chose a pretty simple **nginx**.

- Take the official docker image from **nginx** and download it using `docker pull`

- Check for the docker image with `docker images`

- Run docker image with `docker run -d [image_id|repository]`

- Check that the image is running with `docker ps`

- View container information with `docker inspect [container_id|container_name]`

- From the command output define and write in the report the container size, list of mapped ports and container ip

- Stop docker image with `docker stop [container_id|container_name]`

- Check that the image has stopped with `docker ps`

- Run docker with ports 80 and 443 in container, mapped to the same ports on the local machine, with *run* command

- Check that the **nginx** start page is available in the browser at *localhost:80*

- Restart docker container with `docker restart [container_id|container_name]`

- Check in any way that the container is running

- Add the following screenshots to the report:
  - the call and output of all commands used in this part of the task;
  - **nginx** start page at *localhost:80* (address must be shown).

## Part 2. Operations with container

Docker image and container are ready. Now we can look into **nginx** configuration and display page status.

- Read the *nginx.conf* configuration file inside the docker container with the *exec* command

- Create a *nginx.conf* file on a local machine

- Configure it on the */status* path to return the **nginx** server status page

- Copy the created *nginx.conf* file inside the docker image using the `docker cp` command

- Restart **nginx** inside the docker image with *exec*

- Check that *localhost:80/status* returns the **nginx** server status page

- Export the container to a *container.tar* file with the *export* command

- Stop the container

- Delete the image with `docker rmi [image_id|repository]`without removing the container first

- Delete stopped container

- Import the container back using the *import*command

- Run the imported container

- Check that *localhost:80/status* returns the **nginx** server status page

- Add the following screenshots to the report:
  - the call and output of all commands used in this part of the task;
  - the contents of the created *nginx.conf* file;
  - the **nginx** server status page at *localhost:80/status*.

## Part 3. Mini web server

It's time to take a little break from the docker to prepare for the last stage. It's time to write your own server.

- Write a mini server in **C** and **FastCgi** that will return a simple page saying `Hello World!`

- Run the written mini server via *spawn-fcgi* on port 8080

- Write your own *nginx.conf* that will proxy all requests from port 81 to *127.0.0.1:8080*

- Check that browser on *localhost:81* returns the page you wrote

- Put the *nginx.conf* file under *./nginx/nginx.conf* (you will need this later)

## Part 4. Your own docker

Now everything is ready. You can start writing the docker image for the created server.

When writing a docker image avoid multiple calls of RUN instructions.

- Write your own docker image that:

> 1) builds mini server sources on FastCgi from [Part 3](#part-3-mini- web-server)
> 2) runs it on port 8080
> 3) copies inside the image written *./nginx/nginx.conf*
> 4) runs **nginx**

**nginx** can be installed inside the docker itself, or you can use a ready-made image with **nginx** as base.*

- Build the written docker image with `docker build`, specifying the name and tag

- Check with `docker images` that everything is built correctly

- Run the built docker image by mapping port 81 to 80 on the local machine and mapping the *./nginx* folder inside the container to the address where the **nginx** configuration files are located (see [Part 2](#part-2-operations-with-container))

- Check that the page of the written mini server is available on localhost:80

- Add proxying of */status* page in *./nginx/nginx.conf* to return the **nginx** server status

- Restart docker image

(If everything is done correctly, after saving the file and restarting the container, the configuration file inside the docker image should update itself without any extra steps)

- Check that*localhost:80/status* now returns a page with **nginx** status

## Part 5. **Dockle**

Once you've written the image, it's never a bad idea to check it for security.

- Check the image from the previous task with `dockle [image_id|repository]`

- Fix the image so that there are no errors or warnings when checking with **dockle**

## Part 6. Basic **Docker Compose**

There, you've finished your warm-up. Wait a minute though...
Why not try experimenting with deploying a project consisting of several docker images at once?

- Write a *docker-compose.yml* file, using which:

>1) Start the docker container from [Part 5](#part-5-dockle) *(it must work on local network, i.e., you don't need to use **EXPOSE** instruction and map ports to local machine)*
>2) Start the docker container with **nginx** which will proxy all requests from port 8080 to port 81 of the first container

- Map port 8080 of the second container to port 80 of the local machine

- Stop all running containers

- Build and run the project with the `docker-compose build` and `docker-compose up` commands

- Check that the browser returns the page you wrote on *localhost:80* as before