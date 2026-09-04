# Trinity Desktop Environment en Devuan Excalibur

Instalación limpia de **Trinity Desktop (TDE)** sobre **Devuan 6 (Excalibur)** con **LightDM** como display manager.

## Requisitos

- Devuan Excalibur (6)
- Conexión a internet
- Usuario con permisos de `sudo`

## Instalación

### 1. Keyring de Trinity

> ```bash
> sudo wget https://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-keyring.deb
> sudo dpkg -i trinity-keyring.deb
> ```

### 2. Repositorio

> ```bash
> echo "deb http://mirror.ppa.trinitydesktop.org/trinity/deb/trinity-r14.1.x excalibur main deps" | sudo tee /etc/apt/sources.list.d/tde.list
> ```

### 3. Actualizar e instalar

> ```bash
> sudo apt-get update
> sudo apt-get install tde-trinity
> ```

> Para una instalación mínima (sin apps extra como Amarok, K3b, etc.):
>
> ```bash
> sudo apt-get install tdebase-trinity
> ```

### 4. LightDM

> ```bash
> sudo apt-get install lightdm
> sudo dpkg-reconfigure lightdm
> ```

Elige **lightdm** como display manager predeterminado.

### 5. Cambiar idioma 

> ```bash
> sudo apt install tde-i18n-es-trinity
> ```

Después, para activarlo:

Panel de control → Regional & Accessibility → Country/Region & Language → selecciona Spanish
O por línea de comandos:

> ```bash
> export LANG=es_ES.UTF-8   
> ```
## Notas
Como en muchos proyectos de FOSS, probablemente hay componentes incompletos o caducados, respecto a la traducción .

### 6. Reiniciar

> ```bash
> sudo reboot
> ```

Al iniciar sesión, selecciona **Trinity Desktop** en el selector de sesión.

## Verificación

> ```bash
> ls /usr/share/xsessions/tde.desktop
> ```

Si no existe, créalo:

> ```bash
> sudo tee /usr/share/xsessions/tde.desktop << 'EOF'
> [Desktop Entry]
> Name=Trinity Desktop
> Comment=This session logs you into Trinity Desktop
> Exec=/usr/bin/starttde
> Type=Application
> EOF
> ```

## ⚠️ Reset a valores de fábrica ⚠️

### Reset total

> ```bash
> mv ~/.trinity ~/.trinity.bak
> ```

Al volver a iniciar sesión, TDE recreará todo con defaults.

### Reset selectivo

> ```bash
> # Panel / taskbar
> mv ~/.trinity/share/config/kickerrc ~/.trinity/share/config/kickerrc.bak
>
> # Apariencia (tema, colores, fuentes)
> mv ~/.trinity/share/config/kdeglobals ~/.trinity/share/config/kdeglobals.bak
>
> # Escritorio
> mv ~/.trinity/share/config/kdesktoprc ~/.trinity/share/config/kdesktoprc.bak
> ```

Reiniciar el panel:

> ```bash
> dcop kicker kicker restart
> ```

## Notas

| Componente | Paquete |
|---|---|
| TDE completo | `tde-trinity` |
| TDE base (mínimo) | `tdebase-trinity` |
| Display manager | `lightdm` |
| Keyring | `trinity-keyring` |

> ⚠️ **TDM** es el DM nativo de TDE, pero LightDM funciona perfectamente y es más estable a largo plazo.

### Encontrar temas para TDE.
-Pling → store.kde.org — busca en la sección "KDE 3.5 Themes" o "KDM3 Themes" (para TDM).

-trinity-look.org → opendesktop.org/s/Trinity — la "KDE-Look" dedicada a TDE, con temas de deKorator, Karamba, splash screens, esquemas de color, etc.

-KDE-Look → kde-look.org — la original de KDE 3, muchos temas siguen siendo compatibles.

# ⚠️Cambiar el gestor de archivos [opcional]⚠️

# Gestión del gestor de archivos por defecto en Trinity Desktop (Devuan)

## Verificar el gestor activo

    xdg-mime query default inode/directory

Debería devolver algo como `konqueror.desktop` o `thunar.desktop`.

## Cambiar a Konqueror

### 1. Desde línea de comandos

    xdg-mime default konqueror.desktop inode/directory

### 2. Desde el Panel de Control de TDE

1. **Panel de control → Componentes de TDE → Asociaciones de archivos**
2. Busca `inode` → `directory`
3. Asegúrate de que **Konqueror** esté en primer lugar
4. En la pestaña **Incrustado (Embedding)**, verifica que Konqueror también esté arriba

> **Truco:** Si el cambio no se aplica, borra la entrada `inode/directory` de la lista y re-creala desde cero con Konqueror arriba. A veces la lista se corrompe internamente y no se actualiza solo moviendo el orden.

## Cambiar a Thunar

    xdg-mime default thunar.desktop inode/directory

Y repite los pasos del Panel de Control con Thunar en primer lugar.

## Alternativas

| Gestor | Paquetes | Notas |
|--------|----------|-------|
| **Konqueror** | `konqueror` | Gestor nativo de TDE, viene de base |
| **Dolphin (TDE)** | `dolphin-trinity` | Variante de Dolphin adaptada a TDE |
| **Thunar** | `thunar` | Gestor de XFCE, ligero |

## Notas

- TDE no tiene una opción única "gestor por defecto"; hay que mantener la consistencia entre `xdg-mime` y las asociaciones de TDE.
- Si solo cambias uno de los dos, el otro puede seguir imponiéndose.
### Abrir carpetas en la misma ventana (no en ventana nueva)

1. Abre Konqueror
2. **Settings → Configure Konqueror → Embedding**
3. Marca **"Open file in embedded viewer"**

> ⚠️ No confundir con "Open folders in separate windows" en Behaviour → Misc Options. Es la opción de Embedding la que controla si se abre en la misma ventana o en una nueva.   


# ⚠️ Eliminar TDE ⚠️

# 1. Quitar los paquetes de TDE
sudo apt-get remove tde-trinity tdebase-trinity

# 2. Limpiar dependencias que se instalaron "por arrastre"
sudo apt-get autoremove --purge

# 3. Quitar keyring y repo
sudo dpkg -r trinity-keyring
sudo rm /etc/apt/sources.list.d/tde.list

# 4. Actualizar
sudo apt-get update   

autoremove --purge es la clave: quita todos los paquetes que apt instaló automáticamente como dependencias de TDE y que ya no usa nada más.

# Ver si queda algún paquete tde-*
dpkg -l | grep tde

# Borrar configuración residual (opcional, irreversible)
sudo find /etc -name "*tde*" -delete
sudo find /usr -name "*tde*" -delete   

⚠️ Con el find ten cuidado: solo bórralo si estás 100% seguro de que no tienes nada más que se llame tde.

Y por último, tu config de usuario:

rm -rf ~/.trinity

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
