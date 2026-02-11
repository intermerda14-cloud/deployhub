#!/bin/bash

set -e

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║            🚀 DeployHub Installer v1.0.0 🚀              ║"
echo "║                                                           ║"
echo "║    Self-hosted deployment platform like Vercel           ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "📋 Checking system requirements..."

# Check OS
if ! command -v apt-get &> /dev/null; then
    echo "❌ This installer only supports Debian/Ubuntu-based systems"
    exit 1
fi

echo "✅ OS: Debian/Ubuntu detected"

# Check sudo
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Please run as root or with sudo"
    exit 1
fi

echo "✅ Running with root privileges"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
apt-get update -qq
apt-get install -y nginx git curl unzip postgresql-client mongodb-clients certbot python3-certbot-nginx > /dev/null 2>&1

echo "✅ System dependencies installed"

# Install Node.js
echo ""
echo "📦 Installing Node.js v20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - > /dev/null 2>&1
apt-get install -y nodejs > /dev/null 2>&1

echo "✅ Node.js $(node -v) installed"

# Install PM2
echo ""
echo "📦 Installing PM2..."
npm install -g pm2 --silent

echo "✅ PM2 installed"

# Install Docker
echo ""
echo "📦 Installing Docker..."
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh > /dev/null 2>&1
sh /tmp/get-docker.sh > /dev/null 2>&1
systemctl start docker
systemctl enable docker > /dev/null 2>&1

echo "✅ Docker installed"

# Install Cloudflare Tunnel
echo ""
echo "📦 Installing Cloudflare Tunnel..."
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -O /tmp/cloudflared.deb
dpkg -i /tmp/cloudflared.deb > /dev/null 2>&1

echo "✅ Cloudflare Tunnel installed"

# Create directories
echo ""
echo "📁 Setting up directories..."
mkdir -p /home/deployments/{repos,apps,envs,configs,dashboard}

# Download & setup dashboard
echo ""
echo "📥 Downloading DeployHub dashboard..."
cd /home/deployments/dashboard

# We'll package this later - for now create placeholder
cat > package.json << 'EOF'
{
  "name": "deployhub-dashboard",
  "version": "1.0.0",
  "description": "DeployHub Dashboard",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "ejs": "^3.1.9",
    "ejs-mate": "^4.0.0",
    "body-parser": "^1.20.2",
    "socket.io": "^4.6.1",
    "systeminformation": "^5.21.20",
    "node-telegram-bot-api": "^0.63.0",
    "multer": "^1.4.5-lts.1",
    "bcrypt": "^5.1.1",
    "express-session": "^1.17.3"
  }
}
EOF

echo "✅ Dashboard structure created"

# Install npm dependencies
echo ""
echo "📦 Installing dashboard dependencies..."
npm install --silent

echo "✅ Dashboard dependencies installed"

# Configure Nginx
echo ""
echo "🔧 Configuring Nginx..."
systemctl stop apache2 2>/dev/null || true
systemctl disable apache2 2>/dev/null || true
systemctl start nginx
systemctl enable nginx > /dev/null 2>&1

echo "✅ Nginx configured"

# Setup PM2 startup
echo ""
echo "🔧 Configuring PM2 auto-start..."
pm2 startup systemd -u root --hp /root > /dev/null 2>&1

echo "✅ PM2 auto-start configured"

# Get server IP
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║          ✅ DeployHub Installation Complete! ✅          ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "📝 Next steps:"
echo ""
echo "1. Extract dashboard files to /home/deployments/dashboard/"
echo "2. Start dashboard:"
echo "   cd /home/deployments/dashboard"
echo "   pm2 start server.js --name dashboard"
echo "   pm2 save"
echo ""
echo "3. Access dashboard at:"
echo "   http://$SERVER_IP:4000"
echo ""
echo "📚 Documentation: https://github.com/yourusername/deployhub"
echo ""
echo "🎉 Happy deploying!"
echo ""

