#!/bin/bash

Nombre_Pila="InstanciaUserData"
Nombre_Archivo="instanciaUserData.yml"

# Crear la pila de CloudFormation
aws cloudformation create-stack \
    --stack-name $Nombre_Pila \
    --template-body file://$Nombre_Archivo \
    --capabilities CAPABILITY_IAM

# Obtener la dirección IP de la instancia
IP_Instancia=$(aws ec2 describe-instances --filters "Name=tag:aws:cloudformation:stack-name,Values=$Nombre_Pila" --query "Reservations[0].Instances[0].PublicIpAddr>

# Imprimir mensajes finales
echo "La instancia EC2 con Tomcat se ha creado correctamente."
echo "Puedes acceder a Tomcat a través de la dirección IP: $IP_Instancia:8080"
