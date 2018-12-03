# AppSys

## What You Need

DOCKER_LOGIN_CREDENTIALS - The username and password provided to you for downloading the AppSys docker image.

## Download AppSys Repository

`git clone https://github.com/academicsystems/AppSysDeploy`

## Configure AppSys

Add the needed configuration files in the `/setup` directory. There are example configurations in `/setup_examples`. There are directories for:

  - Shibboleth authentication
  - SimpleSAML authentication
  - Mongo database initialization
  - Nginx server configuration
  
Only `/nginx` is absolutely necessary.

Now run `sh setup/setup.sh`. That will copy your configuration files into the correct volumes.

## Start AppSys

`docker login registry.academic.systems`

`docker-compose up -d`

## Proxy To AppSys

Finally, proxy your server traffic to AppSys at `https://127.0.0.1:8443/$1`. Make sure you strip any irrelevant path parts when you proxy, for example: `/PATH/(.*)` -> `/$1`.
