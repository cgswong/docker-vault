What is docker-vault?
==============

This is a Dockerized image of [Hashicorp's Vault](https://vaultproject.io/intro/index.html). Vault is tool to securely access _secrets_ such as API keys, passwords, certificates, token, and so on.


Run from Docker Hub
-------------------
A pre-built image is available on [Docker Hub](https://registry.hub.docker.com/u/cgswong/vault) and can be run as follows:

    docker run -it cgswong/vault:latest

By default the container will run the *vault* command showing the version. Simply run your regular `vault` commands as normal to use the image.


Build from Source
-----------------
1. Make sure [Docker](https://www.docker.com) is installed.

2. Clone _docker-vault_ from [GitHub](https://github.com/cgswong/docker-vault)

   ```sh
   git clone https://github.com/cgswong/docker-aws.git
   ```
3. Build the docker image

   ```sh
   cd docker-vault
   docker build -t cgswong/vault:latest .
   ```

4. Run a docker container with that image

   ```sh
   docker run -it cgswong/vault:latest vault -help
   ```
