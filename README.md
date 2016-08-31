# packer-hadoop-asap
Build HDP images for use in [ansible-hadoop-asap](https://github.com/bushnoh/ansible-hadoop-asap).

Pre-build images can be found here: [https://atlas.hashicorp.com/bushnoh](https://atlas.hashicorp.com/bushnoh).

## Building the images
```
cd centos-6.6
export HDP_VERSION="HDP-2.3.4.0"
packer build -only=virtualbox-iso template.json
```
