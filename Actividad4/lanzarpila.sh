NOMBRE_PILA="ScriptActividad4"
ARCHIVO="instancia.yml"
REGION="us-east-1"

aws cloudformation create-stack \
    --stack-name $NOMBRE_PILA \
    --template-body file://$ARCHIVO \
    --capabilities CAPABILITY_IAM \
    --region $REGION

aws cloudformation wait stack-create-complete \
    --stack-name $NOMBRE_PILA \
    --region $REGION

echo "Stack desplegado exitosamente: $NOMBRE_PILA"
