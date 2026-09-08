#!/bin/bash
# fix-hp-deskjet-2540.sh
# Ejecutar UNA vez (o tras reinstalar CUPS). No es idempotente en caliente.
set -e

PRINTER="HP-Deskjet-2540-series"

# 1. Blacklist usblp (solo se aplica al reiniciar)
echo "blacklist usblp" | sudo tee /etc/modprobe.d/blacklist-usblp.conf

# 2. Flags del backend USB
/usr/sbin/lpadmin -p "$PRINTER" -o usb-no-reattach-default=true
/usr/sbin/lpadmin -p "$PRINTER" -o usb-unidir-default=true

echo "Hecho. Reinicia el sistema para que usblp no se cargue."
echo "Después imprime dos veces seguidas para verificar."     
