#!/bin/bash
cont=0
while true
do
	echo "Descargando base de datos..."
	
	scp promo@server:/home/ruta/Desktop/db703160626_ole.sql /Users/ruta/Desktop
	
	sleep 2
	
	echo "Comprimim datos..."
	tar -czvf copiesBD/db703160626_$cont.tgz db703160626_ole.sql 
	
	sleep 2
	echo "Senva a dormir..."
	((cont++))
	sleep 2
	if test $(($RANDOM%100)) = 50; then
                find /Users/ruta/Desktop/copiesBD/* -mmin -2 -exec cp {} /Users/ruta/Desktop/historico_copiesBD \;
                echo "Copiando a historico..."
                sleep 2
        else
                if test $(($RANDOM%25)) = 10; then
                        find /Users/developmentpamex/Desktop/copiesBD/* -mmin +1440 -exec rm {} \;
                        echo "Borrando copias de mas de 1 dia..."
                        sleep 2
                else
                        echo ""
                fi
        fi
	sleep 1800
done
	echo "ERROR en la copia de la bd torna a executar"
