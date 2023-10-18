#!/bin/sh

# Configuración de la base de datos
DB_USER="pep"
DB_PASSWORD="pep"
DB_NAME="pep"

# Ruta donde se guardarán los archivos SQL de respaldo
BACKUP_DIR="/home/copiaBD/"

while true
do
    # Generar un nombre de archivo único con la fecha y hora actual
    #TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    FILENAME="$BACKUP_DIR/db703160626_ole.sql"

    # Realizar la copia de seguridad de la base de datos
    mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$FILENAME"

    # Verificar si la copia de seguridad se creó con éxito
    if [ $? -eq 0 ]; then
        echo "Copia de seguridad de la base de datos creada: $FILENAME"

        # Copiar el archivo al servidor remoto usando scp
        scp "$FILENAME" pep@server:/home/promo/Desktop/

        # Verificar si la copia al servidor remoto se realizó con éxito
        if [ $? -eq 0 ]; then
            echo "Copia de seguridad enviada al servidor remoto."
        else
            echo "Error al copiar la copia de seguridad al servidor remoto."
        fi
    else
        echo "Error al crear la copia de seguridad de la base de datos."
    fi

    # Esperar 30 minutos antes de ejecutar el próximo ciclo
    sleep 1800  # 1800 segundos = 30 minutos
done
