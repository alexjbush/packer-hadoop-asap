# packer-hadoop-asap
forked from https://github.com/bushnoh/packer-hadoop-asap and updated for HDP 2.5.3

Build HDP images for use in [ansible-hadoop-asap](https://github.com/bushnoh/ansible-hadoop-asap).

Pre-build images can be found here: [https://atlas.hashicorp.com/bushnoh](https://atlas.hashicorp.com/bushnoh).

## Building the images
```
git clone https://github.com/bushnoh/packer-hadoop-asap.git
cd packer-hadoop-asap
cd centos-7.3
export HDP_VERSION="HDP-2.5.3.0"
packer build -only=virtualbox-iso template.json
```

## Using the images

**locally for development**

```
vagrant init xxxx-virtualbox.box
vagrant up
```

to destroy
```
vagrant halt
vagrant destroy -y
vagrant box rm XXX
```