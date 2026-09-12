
# HP-Deskjet-2540-series	(OpenRC)


###  1.  CUPS + driver HP instalados:  
```
sudo apt install cups cups-client hplip 
```

### 2.  La cola de impresora creada (el script no la crea):

```
sudo /usr/sbin/lpadmin -p "HP-Deskjet-2540-series" -E \
  -v "usb://HP/Deskjet%202540%20series?serial=CN4313B2RP0604&interface=1" \
  -m "drv:///hp/hpcups.drv/hp-deskjet_2540_series.ppd"    
```
  
  (ajusta la URI y el PPD según lpinfo -m | grep 2540)
  
### 3. Luego sí ejecutas el script.

Si quieres que el script sea autocontenido, puedes añadir un check al inicio:

```
nano fix-hp-deskjet-2540.sh
```
```
#!/bin/bash
set -e
PRINTER="HP-Deskjet-2540-series"
```
Verificar que la cola existe

```
if ! /usr/sbin/lpstat -p "$PRINTER" 2>/dev/null | grep -q "$PRINTER"; then
  echo "ERROR: La cola '$PRINTER' no existe. Créala primero con lpadmin."
  exit 1
fi
echo "blacklist usblp" | sudo tee /etc/modprobe.d/blacklist-usblp.conf
/usr/sbin/lpadmin -p "$PRINTER" -o usb-no-reattach-default=true
/usr/sbin/lpadmin -p "$PRINTER" -o usb-unidir-default=true
echo "Hecho. Reinicia el sistema."  
```
```
chmod +x fix-hp-deskjet-2540.sh
```

