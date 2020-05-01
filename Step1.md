##Step 1

### Acceptance criteria

* You have a GitHub repo with everything needed to build the Docker image.
* You can do a demo, where you build the image, run a container and access content from a browser.


1. Building the image in the directory containing the Dockerfile :
docker build -t <nom_image> .

2. Running the contrainer with the port mapping.  
docker run -p <localport:portContainer> <nom_image> 

3. Writing in the URL localhost:<localport> to be able to acces the content.

* You have used a nice looking web template, different from the one shown in the webcast.
* You are able to explain what you do in the Dockerfile.

We use a already created image callse php:7.2-apache

[](./img/Dockerfile1.png)

Everytime we build this Dockerfile, all the content and all the files in the content/ directory will be copied in the var/www/html/ directory in the virtual host. This vm directory is the default root directory configured in etc/apache2/sites-enabled directory.

[](./img/Dockerfile2.png)

* You are able to show where the apache config files are located (in a running container).

We exec an interactiv image with a bash client to traval in the filesystem. In the etc/apache2/ we can find these files.

[](./img/configuration.png)

There are all the different virtual host. We are interested in the default one in **sites_available**. We can then open the .conf file inside to know more about the virtual host.

[](./img/configuration2.png)

* You have **documented** your configuration in your report.