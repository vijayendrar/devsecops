#!/bin/bash
sudo apt update 
sudo apt install -y --no-install-recommends software-properties-common
sudo add-apt-repository ppa:vbernat/haproxy-2.5 -y
sudo apt install -y haproxy=2.5.\* 