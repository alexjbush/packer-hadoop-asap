#!/bin/bash

#HDP packages to install

# Preinstall HDP packages
HDP_VERSION="$1"
HDP_OS="$2"

# Test env variables are set
if [ -z "$HDP_VERSION" ]; then 
  echo "HDP_VERSION not set"; 
  exit 1
elif [ -z "$HDP_OS" ]; then
  echo "HDP_OS not set";
  exit 1
fi

# Get a repo url for the given version and os combination
case "$HDP_OS" in
  "centos6")
    case "$HDP_VERSION" in
      "HDP-2.3.4.0")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.3.4.0/hdp.repo"
        ;;
      "HDP-2.3.4.7")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.3.4.7/hdp.repo"
        ;;
      "HDP-2.3.4.14-9")
        HDP_REPO="http://private-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.3.4.14-9/hdp.repo"
        ;;
      "HDP-2.4.2.0")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.4.2.0/hdp.repo"
        ;;
      "HDP-2.5.0.0")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.5.0.0/hdp.repo"
        ;;
      "HDP-2.5.3.0")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.3.0/hdp.repo"
        ;;
      *)
        echo "HDP_VERSION: $HDP_VERSION not handled"
        exit 1
        ;;
    esac
    ;;
  "centos7")
    case "$HDP_VERSION" in
      "HDP-2.3.4.7")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.4.7/hdp.repo"
        ;;
      "HDP-2.4.2.0")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.4.2.0/hdp.repo"
        ;;
      "HDP-2.5.0.0")
        HDP_REPO="http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.0.0/hdp.repo"
        ;;
      *)
        echo "HDP_VERSION: $HDP_VERSION not handled"
        exit 1
        ;;
    esac
    ;;
  *)
    echo "HDP_OS: $HDP_OS not handled"
    exit 1
    ;;
esac

# Test we have a repo set
if [ -z "$HDP_REPO " ]; then
  echo "HDP_REPO not set. Cannot continue."
  exit 1
fi

# Pull repo file down
curl "$HDP_REPO" > /etc/yum.repos.d/hdp.repo
if [ "$?" != "0" ]; then
  echo "Failed when pulling repo contents from $HDP_REPO"
  exit 1
fi

# Install yum utils for repoquery
yum -y install yum-utils
if [ "$?" != "0" ]; then
  echo "Failed when installing yum-utils"
  exit 1
fi

# Install all HDP files
repoquery --disablerepo=* --enablerepo="$HDP_VERSION" -a | xargs sudo yum -y install
if [ "$?" != "0" ]; then
  echo "Failed installing packages from $HDP_VERSION"
  exit 1
fi

# Remove repo file
rm /etc/yum.repos.d/hdp.repo
if [ "$?" != "0" ]; then
  echo "Failed removing repo file: /etc/yum.repos.d/hdp.repo"
  exit 1
fi
