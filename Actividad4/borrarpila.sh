NOMBRE_PILA="ScriptActividad4"
REGION="us-east-1"

# Comando para borrar el stack
aws cloudformation delete-stack \
    --stack-name $NOMBRE_PILA \
    --region $REGION

echo "Stack eliminado exitosamente: $NOMBRE_PILA"
