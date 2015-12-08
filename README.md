# ssh-docker
* SSH, SCP, Rsync services in a Docker container.


## Authorized Keys:
* This container only accepts ssh-key auth.

You **must** put at least 1 valid public key in './files/' before building. 

Anything matching `./files/*.pub` will be added to /etc/authorized_keys
 before sshd starts.

Edit `/etc/authorized_keys` to modify keys after container is running.


## Basic Installation:
1. [Install Docker](http://docs.docker.com/engine/installation/)
2. Clone this repo: `git clone https://github.com/jhazelwo/ssh-docker.git`
3. Copy your public key `cp ~/.ssh/id_rsa.pub ./ssh-docker/files/`
4. Build the image `cd ssh-docker; ./Build.sh`
5. Start a container from that image. `./Go.sh`


## Config:
* To use a different port change Port in `./files/sshd_config`
* To [map a path from host to container](http://docs.docker.com/engine/userguide/dockervolumes/),
 update $Map variable in `./Go.sh`


## Usage Examples:

### Put (rsync)

`rsync -av --progress -e 'ssh -p 22022 -l data -i ~/.ssh/id_rsa' remote.host.tld:*.zip .`

### Get (rsync)

`rsync -av --progress -e 'ssh -p 22022 -l data -i ~/.ssh/id_rsa' *.zip remote.host.tld:.`

### Shell

`ssh -l data -p 22022 -i ~/.ssh/id_rsa remote.host.tld`

### Put (scp)

`scp -P 22022 -i ~/.ssh/id_rsa *.zip data@remote.host.tld:.` 
 note: _Use upper-case P for 'Port' when using scp._

### Get (scp)

`scp -P 22022 -i ~/.ssh/id_rsa data@remote.host.tld:*.zip .`
 note: _Use upper-case P for 'Port' when using scp._

### ~/.ssh/config
    # If you put key, user and port in ~/.ssh/config you don't  have to 
    # include them in your commands.
    Host remote.host.tld
        HostName remote.host.tld
        User data
        IdentityFile ~/.ssh/remote_host_PRIVATE_key
        Port 22022

