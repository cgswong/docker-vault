# What is docker-vault?
This is a Dockerized image of [Hashicorp's Vault](https://vaultproject.io/intro/index.html). Vault is tool to securely access _secrets_ such as API keys, passwords, certificates, token, and so on.


# Run from Docker Hub
A pre-built image is available on [Docker Hub](https://registry.hub.docker.com/u/cgswong/vault) and can be run as follows:

    docker run -it cgswong/vault:latest

By default the container will run the *vault* command showing the version. Simply run your regular `vault` commands as normal to use the image.


# Build from Source
1. Make sure [Docker](https://www.docker.com) is installed.

2. Clone _docker-vault_ from [GitHub](https://github.com/cgswong/docker-vault)

   ```sh
   git clone https://github.com/cgswong/docker-vault.git
   ```
3. Build the docker image (change `[version]` below with the appropriate version, and `[your_name]` as appropriate)

   ```sh
   cd docker-vault/[version]
   docker build -t [your_name]/vault:latest .
   ```

4. Run a docker container with that image (change [your_name] as done above)

   ```sh
   docker run -it [your_name]/vault:latest vault -help
   ```

# User Feedback

## Issues
If you have any problems with or questions about this image, please contact me through a [GitHub issue](https://github.com/cgswong/docker-vault/issues).

## Contributing
You are invited to contribute new features, fixes, or updates, large or small; I'm always thrilled to receive pull requests, and I'll do my best to process them as fast as I can.

Before you start to code, I recommend discussing your plans through a [GitHub issue](https://github.com/cgswong/docker-vault/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
