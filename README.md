# Docker image with Fedora 34, nginx and php 5.6

- Download repo
- Build image 

`docker build -t image-name .`

- Run image (example)

`docker run -d -v /workspace/html:/var/www/html -p 8080:80 image-name`
