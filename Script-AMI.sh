#!/bin/bash

# ID de la instancia que deseas respaldar
INSTANCE_ID="ID_DE_TU_INSTANCIA"

# Nombre base para la AMI
AMI_NAME_BASE="nombre_base_ami"

# Región de AWS
AWS_REGION="TU_REGION"

# Configura las credenciales de AWS (asegúrate de tener configuradas tus credenciales)
export AWS_ACCESS_KEY_ID="TU_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="TU_SECRET_KEY"
export AWS_DEFAULT_REGION=$AWS_REGION

# Nombre único para la AMI basado en la fecha y hora actual
AMI_NAME="${AMI_NAME_BASE}_$(date +"%Y%m%d%H%M%S")"

# Crear la AMI
aws ec2 create-image --instance-id $INSTANCE_ID --name $AMI_NAME --description "AMI creada automáticamente para $INSTANCE_ID" --no-reboot

# Imprimir mensaje de finalización
echo "AMI creada exitosamente."
