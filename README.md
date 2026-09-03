# Trinity Desktop Environment en Devuan Excalibur

Instalación limpia de **Trinity Desktop (TDE)** sobre **Devuan 6 (Excalibur)** con **LightDM** como display manager.

## Requisitos

- Devuan Excalibur (6)
- Conexión a internet
- Usuario con permisos de `sudo`

## Instalación

### 1. Keyring de Trinity

bash
sudo wget https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.deb
sudo dpkg -i trinity-keyring.deb

### 2. Repositorio

echo "deb http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x excalibur main deps" | sudo tee /etc/apt/sources.list.d/tde.list   

### 3. Actualizar e instalar

sudo apt-get update
sudo apt-get install tde-trinity   

!! Para una instalación mínima (sin apps extra como Amarok, K3b, etc.):

sudo apt-get install tdebase-trinity

### 4. LightDM

sudo apt-get install lightdm
sudo dpkg-reconfigure lightdm   

Elige lightdm como display manager predeterminado.

### 5. Reiniciar

sudo reboot

Al iniciar sesión, selecciona Trinity Desktop en el selector de sesión.

---

### Verificación

ls /usr/share/xsessions/tde.desktop

Si no existe, créalo:

sudo tee /usr/share/xsessions/tde.desktop << 'EOF'
[Desktop Entry]
Name=Trinity Desktop
Comment=This session logs you into Trinity Desktop
Exec=/usr/bin/starttde
Type=Application
EOF

### Reset a valores de fábrica
Reset total
mv ~/.trinity ~/.trinity.bak

Al volver a iniciar sesión, TDE recreará todo con defaults.

### Reset selectivo
# Panel / taskbar
mv ~/.trinity/share/config/kickerrc ~/.trinity/share/config/kickerrc.bak

# Apariencia (tema, colores, fuentes)
mv ~/.trinity/share/config/kdeglobals ~/.trinity/share/config/kdeglobals.bak

# Escritorio
mv ~/.trinity/share/config/kdesktoprc ~/.trinity/share/config/kdesktoprc.bak

### Reiniciar el panel:

dcop kicker kicker restart

### Notas
Componente	Paquete
TDE completo	tde-trinity
TDE base (mínimo)	tdebase-trinity
Display manager	lightdm
Keyring	trinity-keyring

⚠️ TDM es el DM nativo de TDE, pero LightDM funciona perfectamente y es más estable a largo plazo.

## Disclaimer

> ⚠️ **Uso bajo tu propia responsabilidad**
>
> Este proyecto se proporciona **tal cual**, sin garantía de ningún tipo, expresa o implícita, incluyendo pero no limitado a garantías de comerciabilidad, idoneidad para un propósito particular o no infracción.
>
> El autor **no se hace responsable** de:
> - Pérdida de datos, archivos o configuraciones.
> - Daños al sistema, al hardware o a la instalación del SO.
> - Problemas de compatibilidad, seguridad o rendimiento.
> - Cualquier uso que se le dé a este material.
>
> Usar este README implica que asumes **todos los riesgos** asociados. Haz siempre una copia de seguridad antes de modificar tu sistema.
>
> Si algo sale mal, no me lo reproches. 🤷   
