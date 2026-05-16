<div align="center">

# ⚡ CudoShare

### **Share any file, any size, with anyone — no cloud required.**

[![macOS](https://img.shields.io/badge/macOS-14%2B-007AFF?logo=apple&logoColor=white)](https://github.com/CudoShare/cudoshare-releases)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D4?logo=windows&logoColor=white)](https://github.com/CudoShare/cudoshare-releases)
[![Latest Release](https://img.shields.io/github/v/release/CudoShare/cudoshare-releases?label=latest)](https://github.com/CudoShare/cudoshare-releases/releases)
[![License](https://img.shields.io/badge/license-Lifetime-green)](#-license-tiers)
[![AppSumo](https://img.shields.io/badge/AppSumo-Deal%20Live-orange)](https://appsumo.com)

</div>

> CudoShare turns file sharing into a **direct, encrypted, blazing-fast** experience. Drag, drop, and your files travel straight from your device to the recipient — without ever touching a third-party server. No subscriptions. No storage limits. No privacy compromises.

---

## 🚀 How It Works

CudoShare uses **peer-to-peer (P2P)** technology to transfer files directly between sender and receiver. That means:

- **No upload queues** — recipients start downloading immediately.
- **No cloud storage** — your data never sits on someone else's server.
- **End-to-end encryption** — only you and the recipient can access the files.

### The 500 MB Rule — How Sharing Works

Every CudoShare tier supports **two ways to share files**. The method you use depends on the **total size of the file(s)** you are sending. This rule applies to **all tiers, without exception**:

| File Size | How the Recipient Downloads | Requirements |
|-----------|----------------------------|--------------|
| **Up to 500 MB** | A **secure web link** — anyone can download from any browser | Sender needs CudoShare installed |
| **Over 500 MB** | **Direct P2P transfer** via the CudoShare app | **Both sender and receiver** need CudoShare installed |

> 🔑 **Key Takeaway:** The 500 MB rule is a universal limit on **web-link sharing**. If you want to send anything larger than 500 MB, both sides need the app installed so the direct P2P connection can be established. This ensures speed, privacy, and zero reliance on cloud servers regardless of your tier.

---

## ✨ Key Features

| Feature | What It Means for You |
|---------|----------------------|
| ⚡ **Instant Sharing** | No uploads. No waiting. Recipients start downloading the moment you hit share. |
| 🔐 **End-to-End Encryption** | AES-256-GCM encryption with ephemeral keys. Not even our team can access your files. |
| 📁 **No Size Limits** | Your only limits are your tier's maximum file size and your available bandwidth. |
| 🖥️ **Cross-Platform** | macOS and Windows. Linux coming soon. |
| 🌍 **Zero Cloud Storage** | Files move directly between devices. Your data stays yours, always. |
| 🔗 **Browser Links** | Share up to 500 MB via a secure link that works in any modern browser — no install needed for the recipient. |
| 🌙 **Dark Mode** | Beautiful native UI that adapts to your system theme. |
| 🔔 **Real-Time Notifications** | Desktop alerts when transfers complete or new files arrive. |

---

## 🛠️ Quick Install — One Command

Open your terminal and paste one line. The installer handles everything.

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/AdolfoLoraDev/cudoshare-releases/main/install-mac.sh | bash
```

### Windows (PowerShell — Admin)

```powershell
irm https://raw.githubusercontent.com/AdolfoLoraDev/cudoshare-releases/main/install-windows.ps1 | iex
```

> 💡 **Pro Tip:** After installation, close and reopen your terminal, then run `cudoshare --version` to verify.

### Manual Download

Prefer a manual install? Grab the latest build directly:

| Platform | File | Size |
|----------|------|------|
| **macOS** (Apple Silicon & Intel) | [`CudoShare-macos.dmg`](https://github.com/CudoShare/cudoshare-releases/releases/latest/download/CudoShare-macos.dmg) | ~85 MB |
| **Windows** (64-bit) | [`CudoShare-windows.msi`](https://github.com/CudoShare/cudoshare-releases/releases/latest/download/CudoShare-windows.msi) | ~78 MB |

---

## 🏷️ License Tiers

Choose the plan that fits your workflow. All tiers include **lifetime access** — pay once, own it forever.

| | **Tier 1 — Starter** | **Tier 2 — Pro** | **Tier 3 — Team** |
|---|---|---|---|
| **Price** | **$49** | **$79** | **$139** |
| **Devices** | 2 devices | 5 devices | 10 devices |
| **Max File Size** | 500 MB | 20 GB | Unlimited |
| **End-to-End Encryption** | ✅ | ✅ | ✅ |
| **Shareable Links (up to 500 MB)** | ✅ | ✅ | ✅ |
| **Priority Support** | Email | Email | Email |
| **Best For** | Personal use | Freelancers & pros | Agencies & teams |

> 🛒 **[Get CudoShare on AppSumo](https://appsumo.com)** — Limited-time launch pricing. Stack codes to unlock higher tiers.

**How the tiers differ:**

- **Tier 1 — Starter ($49):** Perfect for everyday personal sharing. You can send files up to 500 MB and generate web links for browser downloads. For anything larger, both parties need the app installed.
- **Tier 2 — Pro ($79):** Built for freelancers and professionals handling large assets — 4K videos, RAW photos, design files. The 20 GB limit covers most heavy workflows while keeping the same 500 MB web-link rule for browser recipients.
- **Tier 3 — Team ($139):** The unlimited tier. Send terabyte-sized backups, entire project archives, or massive media libraries with zero ceiling. The 500 MB web-link limit still applies, but app-to-app transfers have no cap at all.

> 📌 Remember: the **500 MB web-link limit** is universal across all tiers. The tier difference is in the **maximum file size you can send via direct P2P transfer**.

---

## 💻 System Requirements

### macOS
- **OS:** macOS 14.0 (Sonoma) or later
- **Chip:** Apple Silicon (M1/M2/M3/M4) or Intel (64-bit)
- **RAM:** 4 GB minimum, 8 GB recommended
- **Disk:** 250 MB free space
- **Network:** Internet connection required

### Windows
- **OS:** Windows 10 (1903+) or Windows 11 (64-bit)
- **RAM:** 4 GB minimum, 8 GB recommended
- **Disk:** 250 MB free space
- **Network:** Internet connection required

### For Direct P2P Transfers Over 500 MB
- **Both sender and receiver** must have CudoShare installed on their device.
- For transfers **up to 500 MB**, the recipient can use any modern web browser — no installation needed.

---

## ❓ Frequently Asked Questions

### General

**Q: Do my files get stored on your servers?**
> **A:** No. CudoShare transfers files directly between devices using P2P and relay technologies. In rare cases where both devices are behind strict NATs, an encrypted relay may temporarily facilitate the connection, but your files are never persisted to disk.

**Q: Is there really no file size limit?**
> **A:** In Tier 3, yes — the only limits are your available disk space and bandwidth. Tiers 1 and 2 have generous caps (500 MB and 20 GB respectively) that cover the vast majority of use cases.

**Q: Do recipients need to install CudoShare?**
> **A:** Only if the file is larger than 500 MB. For anything up to 500 MB, you can generate a secure browser link that works on any device with no installation required. For files over 500 MB, both sender and receiver need the app installed to establish the direct P2P connection.

### Licensing & Payment

**Q: Is this really a one-time payment?**
> **A:** Yes. Pay once, own it forever. No recurring fees, no surprise charges. Future updates within your major version are included.

**Q: Can I upgrade my tier later?**
> **A:** Absolutely. You can purchase additional AppSumo codes to unlock higher tiers at any time.

**Q: What if I change computers?**
> **A:** Each license is tied to one computer. If you replace your device, you will need a new license for the new machine.

### Technical

**Q: Does it work offline?**
> **A:** An internet connection is required to establish the secure connection between devices.

**Q: Is my data encrypted?**
> **A:** Every transfer uses AES-256-GCM encryption with ephemeral keys. Not even our team can decrypt your files.

**Q: Can I use CudoShare for my business?**
> **A:** Yes. CudoShare is built for both personal and commercial use.

---

## 🔗 Important Links

| Resource | Link |
|----------|------|
| 🏠 **Official Website** | [https://cudoshare.com](https://cudoshare.com) |
| 🐙 **GitHub Repository** | [https://github.com/CudoShare/cudoshare-releases](https://github.com/CudoShare/cudoshare-releases) |
| 🛒 **AppSumo Deal** | [https://appsumo.com/products/cudoshare](https://appsumo.com) |

---

<div align="center">

### Ready to share without limits?

**[🛒 Get CudoShare on AppSumo](https://appsumo.com)** &nbsp;·&nbsp; **[📥 Download Latest Release](https://github.com/CudoShare/cudoshare-releases/releases/latest)**

*Lifetime license. No subscriptions. Your files, your rules.*

</div>
