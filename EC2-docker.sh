#!/bin/bash

# Crea una instancia de Amazon EC2 y agrega una etiqueta con el nombre Prueba-aws
aws ec2 run-instances --tag-specifications ResourceType=instance,Tags=[{Key=Name,Value=Prueba-aws-cli}] --image-id ami-0c7217cdde317cfec --count 1 --instance-type t2.micro --key-name vodkey --security-group-ids sg-099f7faab0918f0c7 --subnet-id subnet-0e57b108435210052
# Espera a que la instancia se inicie
aws ec2 wait instance-running --instance-ids $instance_id

# Instala Docker en la instancia
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start

