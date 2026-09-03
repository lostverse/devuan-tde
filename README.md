# devuan-tde
devuan (excalibur) + trinity desktop

# Trinity Desktop Environment en Devuan Excalibur

Instalación limpia de **Trinity Desktop (TDE)** sobre **Devuan 6 (Excalibur)** con **LightDM** como display manager.

## Requisitos

- Devuan Excalibur (6)
- Conexión a internet
- Usuario con permisos de `sudo`

## Instalación

### 1. Keyring de Trinity

```bash
sudo wget https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.deb
sudo dpkg -i trinity-keyring.deb   
