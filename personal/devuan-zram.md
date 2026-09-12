# Resumen: zram en Devuan + OpenRC (12 GB RAM)

Archivo: /etc/init.d/zramswap
```
#!/sbin/openrc-run

depend() {
    after *
}

start() {
    ebegin "Activando zram swap"
    modprobe zram
    zramctl /dev/zram0 --size 6G --algorithm zstd
    mkswap /dev/zram0
    swapon /dev/zram0 -p 100
    eend $?
}

stop() {
    ebegin "Desactivando zram swap"
    swapoff /dev/zram0
    zramctl --reset /dev/zram0
    eend $?
}
```
## Comandos de instalación:
```
sudo apt install zram-tools
sudo chmod +x /etc/init.d/zramswap
echo "zram" | sudo tee -a /etc/modules
sudo rc-update add zramswap default
```

Verificación:

zramctl
swapon --show

Puntos clave que costaron:

Problema	Solución
localmount / local no existen	after * en depend()
/dev/zram0 no existe	modprobe zram + añadir a /etc/modules
systemd-zram-generator	No aplica, es solo para systemd

# Solución a posibles problemas


¿Hay un resume escondido en initramfs-tools?
```
cat /etc/initramfs-tools/conf.d/resume 2>/dev/null
grep -r "resume" /etc/initramfs-tools/
```
```
sudo rm /etc/initramfs-tools/conf.d/resume
sudo update-initramfs -u
sudo reboot
```

Con eso el kernel deja de buscar un dispositivo de resume que no existe. 

