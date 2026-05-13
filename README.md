# ⚡ CudoShare — Lightning-Fast, Privacy-First File Sharing

[![macOS](https://img.shields.io/badge/macOS-14%2B-007AFF?logo=apple&logoColor=white)](https://github.com/CudoShare/cudoshare-releases)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D4?logo=windows&logoColor=white)](https://github.com/CudoShare/cudoshare-releases)
[![Latest Release](https://img.shields.io/github/v/release/CudoShare/cudoshare-releases?label=latest)](https://github.com/CudoShare/cudoshare-releases/releases)
[![License](https://img.shields.io/badge/license-Lifetime-green)](#-license-tiers)
[![AppSumo](https://img.shields.io/badge/AppSumo-Deal%20Live-orange)](https://appsumo.com)

> **Share any file, any size, with anyone — without uploading to the cloud.**
>
> CudoShare is the desktop app that turns file sharing into a **direct, encrypted, blazing-fast** experience. No subscriptions, no cloud storage limits, no privacy nightmares. Just drag, drop, and done.

---

## 🎯 What is CudoShare?

**CudoShare** is a next-generation file sharing application for macOS and Windows that lets you send files directly from your computer to anyone, anywhere — **without ever storing them on a third-party server**.

Unlike cloud-based services that force you to upload files, wait for sync, and pray for privacy, CudoShare establishes a **secure peer-to-peer connection** between sender and receiver. Your files travel directly from you to them, encrypted end-to-end.

### Why teams and power users love it:

- **🚀 Zero Upload Wait** — Send 50 GB files instantly. No upload queue, no sync time.
- **🔒 True Privacy** — Your files never touch our servers. End-to-end encryption by default.
- **💰 One-Time Payment** — Lifetime license. No monthly subscriptions, ever.
- **🌐 No File Size Limits** — Send a 4K video, a CAD project, or an entire drive backup.
- **📡 Works Anywhere** — Even behind firewalls and NATs. We handle the hard stuff.

---

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| ⚡ **Instant Sharing** | No upload step. Recipients start downloading immediately. |
| 🔐 **End-to-End Encryption** | AES-256 encryption. Only you and the recipient can read the files. |
| 📁 **No Size Limits** | Share anything from a 1 KB text file to a 500 GB video archive. |
| 🖥️ **Cross-Platform** | macOS and Windows. Linux coming soon. |
| 🌍 **No Cloud Required** | Direct device-to-device transfer. Your data stays yours. |
| 🔗 **Shareable Links** | Generate secure links that anyone can open in their browser. |
| 📂 **Folder Sharing** | Send entire directories with preserved structure in one click. |
| 📊 **Transfer Analytics** | See who downloaded what, when, and from where. |
| 🏷️ **Branded Transfers** | Add your logo and custom message (Tier 2+). |
| 👥 **Team Workspaces** | Shared folders and team management (Tier 3). |
| 🌙 **Dark Mode** | Beautiful native UI that matches your system theme. |
| 🔔 **Real-Time Notifications** | Desktop alerts when transfers complete or files arrive. |

---

## 🚀 Quick Install — One Command

Copy and paste one of the commands below into your terminal. That's it.

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-mac.sh | bash
```

### Windows (PowerShell — Admin)

```powershell
irm https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-windows.ps1 | iex
```

> **💡 Pro Tip:** Close and reopen your terminal after installation, or run `cudoshare --version` to verify.

---

## 📦 Installation Methods

### Option 1 — One-Liner Script (Recommended)

**macOS — Terminal:**
```bash
curl -fsSL https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-mac.sh | bash
```

**Windows — PowerShell (Run as Administrator):**
```powershell
irm https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-windows.ps1 | iex
```

These scripts will:
1. Detect your operating system and architecture
2. Download the latest stable release
3. Install CudoShare to your Applications folder (macOS) or Program Files (Windows)
4. Add the CLI to your system PATH
5. Clean up temporary files

### Option 2 — Manual Download

Prefer to install manually? Grab the latest installer directly:

| Platform | File | Size |
|----------|------|------|
| **macOS** (Apple Silicon & Intel) | [`CudoShare-macos.dmg`](https://github.com/CudoShare/cudoshare-releases/releases/latest/download/CudoShare-macos.dmg) | ~85 MB |
| **Windows** (64-bit) | [`CudoShare-windows.msi`](https://github.com/CudoShare/cudoshare-releases/releases/latest/download/CudoShare-windows.msi) | ~78 MB |

**Steps:**
1. Download the file for your platform above.
2. **macOS:** Open the `.dmg`, drag CudoShare to your Applications folder.
3. **Windows:** Run the `.msi` installer and follow the wizard.
4. Launch CudoShare from your Applications/Start Menu.

### Option 3 — Specific Version

Need a specific release? Browse all versions in the [`v1.0.0/`](./v1.0.0/) directory or visit the [Releases page](https://github.com/CudoShare/cudoshare-releases/releases).

---

## 🏷️ License Tiers

Choose the plan that fits your workflow. All tiers include **lifetime access** — pay once, use forever.

| | **Tier 1 — Starter** | **Tier 2 — Pro** | **Tier 3 — Team** |
|---|---|---|---|
| **Price** | ~~$49~~ **$39** | ~~$99~~ **$79** | ~~$199~~ **$149** |
| **Devices** | 2 devices | 5 devices | 10 devices |
| **Transfers / Month** | Unlimited | Unlimited | Unlimited |
| **Max File Size** | Unlimited | Unlimited | Unlimited |
| **End-to-End Encryption** | ✅ | ✅ | ✅ |
| **Shareable Links** | ✅ | ✅ | ✅ |
| **Transfer History** | 7 days | 90 days | Unlimited |
| **Branded Transfers** | ❌ | ✅ | ✅ |
| **Custom Domain Links** | ❌ | ✅ | ✅ |
| **Team Workspaces** | ❌ | ❌ | ✅ |
| **User Management** | ❌ | ❌ | ✅ |
| **Priority Support** | ❌ | Email | Email + Chat |
| **Best For** | Personal use | Freelancers & pros | Agencies & teams |

> 🛒 **[Get CudoShare on AppSumo](https://appsumo.com)** — Limited-time launch pricing. Stack codes to unlock higher tiers.

---

## 💻 System Requirements

### macOS
- **macOS:** 14.0 (Sonoma) or later
- **Chip:** Apple Silicon (M1/M2/M3/M4) or Intel (64-bit)
- **RAM:** 4 GB minimum, 8 GB recommended
- **Disk:** 250 MB free space
- **Network:** Internet connection for link-based sharing

### Windows
- **OS:** Windows 10 (1903+) or Windows 11 (64-bit)
- **RAM:** 4 GB minimum, 8 GB recommended
- **Disk:** 250 MB free space
- **Network:** Internet connection for link-based sharing

### For Direct P2P Transfers (No Cloud)
- Both sender and receiver need CudoShare installed, **or**
- Receiver can use the browser download link (no install required)

---

## ❓ Frequently Asked Questions

### General

**Q: Do files get stored on your servers?**
> **A:** No. CudoShare uses peer-to-peer and relay technologies to transfer files directly between devices. In rare cases where both devices are behind strict NATs, an encrypted relay may be used, but files are never persisted to disk.

**Q: Is there really no file size limit?**
> **A:** Correct. The only limit is your available disk space and bandwidth. Send a 10 GB video or a 1 TB backup — CudoShare handles it.

**Q: Do recipients need to install CudoShare?**
> **A:** Not necessarily. You can generate a secure web link that anyone can open in any modern browser to download your files.

### Licensing & Payment

**Q: Is this really a one-time payment?**
> **A:** Yes. Pay once, own it forever. No recurring fees, no surprise charges. Future updates within your major version are included.

**Q: Can I upgrade my tier later?**
> **A:** Absolutely. You can stack AppSumo codes to unlock higher tiers, or upgrade directly from within the app.

**Q: What happens if I change computers?**
> **A:** Deactivate the old device from your account dashboard and activate the new one. Your license travels with you.

### Technical

**Q: Does it work offline?**
> **A:** For direct device-to-device transfers on the same local network, yes — no internet required. For remote sharing, an internet connection is needed to establish the secure connection.

**Q: Is my data encrypted?**
> **A:** Every transfer uses AES-256-GCM encryption with ephemeral keys. Not even our team can decrypt your files.

**Q: Can I use this for my business?**
> **A:** Yes. Tier 2 and Tier 3 licenses include commercial use rights. Tier 3 adds team management and workspaces.

---

## 🔗 Important Links

| Resource | Link |
|----------|------|
| 🏠 **Official Website** | [https://cudoshare.com](https://cudoshare.com) |
| 🐙 **GitHub Repository** | [https://github.com/CudoShare/cudoshare-releases](https://github.com/CudoShare/cudoshare-releases) |
| 🛒 **AppSumo Deal** | [https://appsumo.com/products/cudoshare](https://appsumo.com) |
| 📖 **Documentation** | [https://docs.cudoshare.com](https://docs.cudoshare.com) |
| 🎫 **Support Portal** | [https://support.cudoshare.com](https://support.cudoshare.com) |
| ✉️ **Email Support** | [support@cudoshare.com](mailto:support@cudoshare.com) |
| 🐦 **Twitter / X** | [@CudoShare](https://twitter.com/CudoShare) |
| 💬 **Community Discord** | [Join our server](https://discord.gg/cudoshare) |

---

## ⭐ Loved by Early Adopters

> *"I used to pay $20/month for a file-sharing tool. CudoShare replaced it completely and paid for itself in 2 months."*
> — **Marcus T.** , Video Producer

> *"Sending 30 GB RAW photo folders to clients used to be a nightmare. Now it takes 30 seconds to start the transfer."*
> — **Elena R.** , Wedding Photographer

> *"The team workspace feature is exactly what our agency needed. No more WeTransfer links expiring on clients."*
> — **James K.** , Creative Director

---

<div align="center">

### Ready to share without limits?

**[🛒 Get CudoShare on AppSumo](https://appsumo.com)** &nbsp;·&nbsp; **[📥 Download Latest Release](https://github.com/CudoShare/cudoshare-releases/releases/latest)**

*Lifetime license. No subscriptions. Your files, your rules.*

</div>

---

---

# 🇪🇸 CudoShare — Compartición de Archivos Ultrarrápida y Privada

[![macOS](https://img.shields.io/badge/macOS-14%2B-007AFF?logo=apple&logoColor=white)](https://github.com/CudoShare/cudoshare-releases)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D4?logo=windows&logoColor=white)](https://github.com/CudoShare/cudoshare-releases)
[![Latest Release](https://img.shields.io/github/v/release/CudoShare/cudoshare-releases?label=latest)](https://github.com/CudoShare/cudoshare-releases/releases)
[![License](https://img.shields.io/badge/license-Lifetime-green)](#-tiers-de-licencia)
[![AppSumo](https://img.shields.io/badge/AppSumo-Deal%20Activo-orange)](https://appsumo.com)

> **Comparte cualquier archivo, de cualquier tamaño, con cualquiera — sin subirlo a la nube.**
>
> CudoShare es la aplicación de escritorio que convierte el intercambio de archivos en una experiencia **directa, cifrada y ultrarrápida**. Sin suscripciones, sin límites de almacenamiento en la nube, sin pesadillas de privacidad. Solo arrastra, suelta y listo.

---

## 🎯 ¿Qué es CudoShare?

**CudoShare** es una aplicación de intercambio de archivos de nueva generación para macOS y Windows que te permite enviar archivos directamente desde tu ordenador a cualquier persona, en cualquier lugar — **sin almacenarlos jamás en un servidor de terceros**.

A diferencia de los servicios basados en la nube que te obligan a subir archivos, esperar la sincronización y rezar por tu privacidad, CudoShare establece una **conexión segura peer-to-peer** entre el emisor y el receptor. Tus archivos viajan directamente de ti a ellos, cifrados de extremo a extremo.

### Por qué los equipos y usuarios avanzados lo adoran:

- **🚀 Espera Cero de Subida** — Envía archivos de 50 GB al instante. Sin cola de subida, sin tiempo de sincronización.
- **🔒 Privacidad Real** — Tus archivos nunca tocan nuestros servidores. Cifrado de extremo a extremo por defecto.
- **💰 Pago Único** — Licencia de por vida. Sin suscripciones mensuales, nunca.
- **🌐 Sin Límites de Tamaño** — Envía un vídeo 4K, un proyecto CAD o una copia de seguridad completa.
- **📡 Funciona en Cualquier Lugar** — Incluso detrás de firewalls y NATs. Nosotros nos encargamos de lo difícil.

---

## ✨ Características Principales

| Característica | Descripción |
|----------------|-------------|
| ⚡ **Compartición Instantánea** | Sin paso de subida. Los destinatarios empiezan a descargar inmediatamente. |
| 🔐 **Cifrado de Extremo a Extremo** | Cifrado AES-256. Solo tú y el destinatario podéis leer los archivos. |
| 📁 **Sin Límites de Tamaño** | Comparte desde un archivo de texto de 1 KB hasta un archivo de vídeo de 500 GB. |
| 🖥️ **Multiplataforma** | macOS y Windows. Linux próximamente. |
| 🌍 **Sin Nube Necesaria** | Transferencia directa de dispositivo a dispositivo. Tus datos son tuyos. |
| 🔗 **Enlaces Compartibles** | Genera enlaces seguros que cualquiera puede abrir en su navegador. |
| 📂 **Compartir Carpetas** | Envía directorios completos con estructura preservada en un clic. |
| 📊 **Analíticas de Transferencia** | Ve quién descargó qué, cuándo y desde dónde. |
| 🏷️ **Transferencias con Marca** | Añade tu logo y mensaje personalizado (Tier 2+). |
| 👥 **Espacios de Trabajo en Equipo** | Carpetas compartidas y gestión de equipo (Tier 3). |
| 🌙 **Modo Oscuro** | Interfaz nativa hermosa que se adapta al tema de tu sistema. |
| 🔔 **Notificaciones en Tiempo Real** | Alertas de escritorio cuando las transferencias se completan o llegan archivos. |

---

## 🚀 Instalación Rápida — Un Solo Comando

Copia y pega uno de los comandos de abajo en tu terminal. Eso es todo.

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-mac.sh | bash
```

### Windows (PowerShell — Admin)

```powershell
irm https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-windows.ps1 | iex
```

> **💡 Consejo Pro:** Cierra y vuelve a abrir tu terminal después de la instalación, o ejecuta `cudoshare --version` para verificar.

---

## 📦 Métodos de Instalación

### Opción 1 — Script de Una Línea (Recomendado)

**macOS — Terminal:**
```bash
curl -fsSL https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-mac.sh | bash
```

**Windows — PowerShell (Ejecutar como Administrador):**
```powershell
irm https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-windows.ps1 | iex
```

Estos scripts:
1. Detectarán tu sistema operativo y arquitectura
2. Descargarán la última versión estable
3. Instalarán CudoShare en tu carpeta de Aplicaciones (macOS) o Archivos de Programa (Windows)
4. Añadirán la CLI a tu PATH del sistema
5. Limpiarán archivos temporales

### Opción 2 — Descarga Manual

¿Prefieres instalar manualmente? Descarga el instalador directamente:

| Plataforma | Archivo | Tamaño |
|------------|---------|--------|
| **macOS** (Apple Silicon e Intel) | [`CudoShare-macos.dmg`](https://github.com/CudoShare/cudoshare-releases/releases/latest/download/CudoShare-macos.dmg) | ~85 MB |
| **Windows** (64-bit) | [`CudoShare-windows.msi`](https://github.com/CudoShare/cudoshare-releases/releases/latest/download/CudoShare-windows.msi) | ~78 MB |

**Pasos:**
1. Descarga el archivo para tu plataforma arriba.
2. **macOS:** Abre el `.dmg`, arrastra CudoShare a tu carpeta de Aplicaciones.
3. **Windows:** Ejecuta el instalador `.msi` y sigue el asistente.
4. Lanza CudoShare desde Aplicaciones o el Menú Inicio.

### Opción 3 — Versión Específica

¿Necesitas una versión concreta? Explora todas las versiones en el directorio [`v1.0.0/`](./v1.0.0/) o visita la [página de Releases](https://github.com/CudoShare/cudoshare-releases/releases).

---

## 🏷️ Tiers de Licencia

Elige el plan que se adapte a tu flujo de trabajo. Todos los tiers incluyen **acceso de por vida** — paga una vez, úsalo para siempre.

| | **Tier 1 — Starter** | **Tier 2 — Pro** | **Tier 3 — Team** |
|---|---|---|---|
| **Precio** | ~~$49~~ **$39** | ~~$99~~ **$79** | ~~$199~~ **$149** |
| **Dispositivos** | 2 dispositivos | 5 dispositivos | 10 dispositivos |
| **Transferencias / Mes** | Ilimitadas | Ilimitadas | Ilimitadas |
| **Tamaño Máximo** | Ilimitado | Ilimitado | Ilimitado |
| **Cifrado de Extremo a Extremo** | ✅ | ✅ | ✅ |
| **Enlaces Compartibles** | ✅ | ✅ | ✅ |
| **Historial de Transferencias** | 7 días | 90 días | Ilimitado |
| **Transferencias con Marca** | ❌ | ✅ | ✅ |
| **Enlaces con Dominio Personalizado** | ❌ | ✅ | ✅ |
| **Espacios de Trabajo en Equipo** | ❌ | ❌ | ✅ |
| **Gestión de Usuarios** | ❌ | ❌ | ✅ |
| **Soporte Prioritario** | ❌ | Email | Email + Chat |
| **Ideal Para** | Uso personal | Freelancers y profesionales | Agencias y equipos |

> 🛒 **[Consigue CudoShare en AppSumo](https://appsumo.com)** — Precio de lanzamiento por tiempo limitado. Acumula códigos para desbloquear tiers superiores.

---

## 💻 Requisitos del Sistema

### macOS
- **macOS:** 14.0 (Sonoma) o posterior
- **Chip:** Apple Silicon (M1/M2/M3/M4) o Intel (64-bit)
- **RAM:** 4 GB mínimo, 8 GB recomendados
- **Disco:** 250 MB de espacio libre
- **Red:** Conexión a Internet para compartir mediante enlaces

### Windows
- **SO:** Windows 10 (1903+) o Windows 11 (64-bit)
- **RAM:** 4 GB mínimo, 8 GB recomendados
- **Disco:** 250 MB de espacio libre
- **Red:** Conexión a Internet para compartir mediante enlaces

### Para Transferencias P2P Directas (Sin Nube)
- Tanto el emisor como el receptor necesitan tener CudoShare instalado, **o**
- El receptor puede usar el enlace de descarga en navegador (sin instalación necesaria)

---

## ❓ Preguntas Frecuentes

### General

**P: ¿Los archivos se almacenan en vuestros servidores?**
> **R:** No. CudoShare utiliza tecnologías peer-to-peer y relay para transferir archivos directamente entre dispositivos. En casos raros donde ambos dispositivos están detrás de NATs estrictos, puede usarse un relay cifrado, pero los archivos nunca se persisten en disco.

**P: ¿Realmente no hay límite de tamaño de archivo?**
> **R:** Correcto. El único límite es tu espacio en disco disponible y tu ancho de banda. Envía un vídeo de 10 GB o una copia de seguridad de 1 TB — CudoShare lo gestiona.

**P: ¿Los destinatarios necesitan instalar CudoShare?**
> **R:** No necesariamente. Puedes generar un enlace web seguro que cualquiera puede abrir en cualquier navegador moderno para descargar tus archivos.

### Licencias y Pago

**P: ¿Es realmente un pago único?**
> **R:** Sí. Paga una vez, es tuyo para siempre. Sin tarifas recurrentes, sin cargos sorpresa. Las futuras actualizaciones dentro de tu versión principal están incluidas.

**P: ¿Puedo actualizar mi tier más tarde?**
> **R:** Por supuesto. Puedes acumular códigos de AppSumo para desbloquear tiers superiores, o actualizar directamente desde la aplicación.

**P: ¿Qué pasa si cambio de ordenador?**
> **R:** Desactiva el dispositivo antiguo desde tu panel de cuenta y activa el nuevo. Tu licencia viaja contigo.

### Técnico

**P: ¿Funciona sin conexión?**
> **R:** Para transferencias directas de dispositivo a dispositivo en la misma red local, sí — no se necesita Internet. Para compartir remotamente, se necesita una conexión a Internet para establecer la conexión segura.

**P: ¿Mis datos están cifrados?**
> **R:** Cada transferencia utiliza cifrado AES-256-GCM con claves efímeras. Ni siquiera nuestro equipo puede descifrar tus archivos.

**P: ¿Puedo usarlo para mi negocio?**
> **R:** Sí. Las licencias Tier 2 y Tier 3 incluyen derechos de uso comercial. El Tier 3 añade gestión de equipo y espacios de trabajo.

---

## 🔗 Enlaces Importantes

| Recurso | Enlace |
|---------|--------|
| 🏠 **Sitio Web Oficial** | [https://cudoshare.com](https://cudoshare.com) |
| 🐙 **Repositorio GitHub** | [https://github.com/CudoShare/cudoshare-releases](https://github.com/CudoShare/cudoshare-releases) |
| 🛒 **Oferta en AppSumo** | [https://appsumo.com/products/cudoshare](https://appsumo.com) |
| 📖 **Documentación** | [https://docs.cudoshare.com](https://docs.cudoshare.com) |
| 🎫 **Portal de Soporte** | [https://support.cudoshare.com](https://support.cudoshare.com) |
| ✉️ **Email de Soporte** | [support@cudoshare.com](mailto:support@cudoshare.com) |
| 🐦 **Twitter / X** | [@CudoShare](https://twitter.com/CudoShare) |
| 💬 **Discord Comunitario** | [Únete a nuestro servidor](https://discord.gg/cudoshare) |

---

## ⭐ Amado por los Primeros Usuarios

> *"Solía pagar $20/mes por una herramienta de intercambio de archivos. CudoShare la reemplazó por completo y se pagó solo en 2 meses."*
> — **Marcus T.** , Productor de Vídeo

> *"Enviar carpetas de fotos RAW de 30 GB a clientes solía ser una pesadilla. Ahora tarda 30 segundos en iniciar la transferencia."*
> — **Elena R.** , Fotógrafa de Bodas

> *"La función de espacio de trabajo en equipo es exactamente lo que nuestra agencia necesitaba. No más enlaces de WeTransfer expirando en los clientes."*
> — **James K.** , Director Creativo

---

<div align="center">

### ¿Listo para compartir sin límites?

**[🛒 Consigue CudoShare en AppSumo](https://appsumo.com)** &nbsp;·&nbsp; **[📥 Descargar Última Versión](https://github.com/CudoShare/cudoshare-releases/releases/latest)**

*Licencia de por vida. Sin suscripciones. Tus archivos, tus reglas.*

</div>
