# Config especifica para AMD. 

Forzar amdgpu en vez de radeon:
```
echo "options amdgpu si_support=1" | sudo tee /etc/modprobe.d/amdgpu.conf
echo "blacklist radeon" | sudo tee /etc/modprobe.d/blacklist-radeon.conf
```
```
sudo update-initramfs -u
```
```
sudo reboot   
```
Después del reboot, inxi -G debería mostrar driver: amdgpu en vez de radeon, y la GPU integrada va a ir un pelín más optimizada (mejor manejo de modos de potencia, menos micro-stutter).
