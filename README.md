# 🚀 DeployHub

**Self-hosted deployment platform like Vercel, but on your own server!**

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)

## ✨ Features

- 🚀 **Git-based Deployment** - Push to deploy automatically
- 📊 **Real-time Monitoring** - CPU, Memory, Disk, Network tracking
- 📦 **Quick Deploy** - Upload ZIP files via web interface
- 🔒 **Free SSL** - Auto SSL with Let's Encrypt
- 💾 **Database Manager** - PostgreSQL & MongoDB support
- 🌍 **Public Tunnel** - Expose apps via Cloudflare Tunnel
- 📁 **File Manager** - Edit code in browser with syntax highlighting
- 🔔 **Telegram Alerts** - Get notified on deployments
- 🌿 **Multi-Branch** - Deploy from different branches
- ⏮️ **Easy Rollback** - Revert to previous versions
- 🔑 **Environment Variables** - Secure env management
- 🎨 **Professional Dashboard** - Modern, responsive UI

## 📋 System Requirements

- **OS:** Ubuntu 20.04+ / Debian 11+ / Kali Linux
- **RAM:** 2GB minimum (4GB recommended)
- **Disk:** 20GB minimum
- **Access:** Root/sudo privileges

## 🚀 Quick Install
```bash
# Download installer
wget https://github.com/YOUR_USERNAME/deployhub/releases/latest/download/deployhub-installer.tar.gz

# Extract
tar -xzf deployhub-installer.tar.gz
cd deployhub-installer

# Run installer (as root)
sudo bash install.sh

# Extract dashboard
sudo tar -xzf dashboard.tar.gz -C /home/deployments/

# Start dashboard
cd /home/deployments/dashboard
pm2 start server.js --name dashboard
pm2 save

# Access dashboard
# http://YOUR_SERVER_IP:4000
```

## 📖 Documentation

### Creating Your First App

1. Open dashboard at `http://YOUR_SERVER_IP:4000`
2. Enter app name and click **"Create App"**
3. Deploy via:
   - **Quick Deploy:** Upload ZIP file
   - **Git Push:** `git push /home/deployments/repos/APP_NAME.git main`

### Accessing Your Apps

- **Via IP + Port:** `http://YOUR_SERVER_IP:3000`
- **Via Domain:** Configure in Dashboard → Domain
- **Via Public Tunnel:** Dashboard → Public Tunnel → Start

## 🛠️ Tech Stack

- **Backend:** Node.js, Express
- **Process Manager:** PM2
- **Web Server:** Nginx
- **Database:** PostgreSQL, MongoDB
- **Monitoring:** systeminformation, Socket.io
- **Notifications:** Telegram Bot API
- **Tunnel:** Cloudflare Tunnel

## 📸 Screenshots

Coming soon...

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

MIT License - feel free to use this project however you want!

## 🙏 Acknowledgments

Built with ❤️ for developers who want full control over their deployments.

## 📞 Support

- GitHub Issues: Report bugs or request features
- Documentation: Check the wiki for detailed guides

---

**Star ⭐ this repo if you find it useful!**
