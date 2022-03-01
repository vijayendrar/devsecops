#!/bin/bash
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
echo "192.168.50.20 content.example.com" > /etc/hosts
