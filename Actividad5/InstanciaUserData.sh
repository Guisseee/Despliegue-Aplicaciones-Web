Nombre_Pila="InstanciaUserData"

Nombre_Archivo="instanciaUserData.yaml"

EC2AMI="/aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
KEY="vockey"
SSH_LOCATION="0.0.0.0/0"

aws cloudformation create-stack \
    --stack-name $Nombre_Pila \
    --template-body file://$Nombre_Archivo \
    --parameters ParameterKey=EC2AMI,ParameterValue="$EC2AMI" \
                 ParameterKey=KeyName,ParameterValue="$KEY" \
                 ParameterKey=SSHLocation,ParameterValue="$SSH_LOCATION" \
    --capabilities CAPABILITY_IAM

aws cloudformation wait stack-create-complete --stack-name $Nombre_Pila

IP_Instancia=$(aws cloudformation describe-stacks --stack-name $Nombre_Pila --query "Stacks[0].Outputs[0].OutputValue" --output text)

echo "La instancia EC2 con Tomcat se ha creado correctamente."
echo "Puedes acceder a Tomcat a través de la dirección IP: $IP_Instancia:8080"
