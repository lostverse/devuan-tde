## 💬 Whatsie

Cliente de escritorio para WhatsApp Web en Linux. Escrito en C++ con Qt 6
(no Electron), así que es ligero y no consume RAM como una app de navegador.

**Licencia:** MIT (código abierto, auditable).
**Repo:** [github.com/keshavbhatt/whatsie](https://github.com/keshavbhatt/whatsie)

### Instalación


## Flatpak (recomendado, devuan no trae snap de base)

flatpak install flathub com.ktechpit.whatsie

---

**Opciones de privacidad**

En Settings → Privacy se puede activar el blur por elemento:

Elemento	Descripción
Fotos de perfil	Oculta avatares
Previews	Oculta último mensaje en la lista de chats
Media	Oculta imágenes y vídeos
Texto	Oculta contenido de mensajes

Al pasar el cursor se revela. Útil si dejas la laptop abierta en un sitio público.

**Notas**

Es un wrapper de web.whatsapp.com (Qt WebEngine). No añade riesgo extra.
No hay telemetría propia ni backdoors.
App lock con passcode incluido.

¿Por qué no solo Signal? Porque estoy solo en Signal. O_O
