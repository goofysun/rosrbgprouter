#!/bin/bash
apt update
apt install bird2 -y

echo "开始下载 clash meta"
wget https://github.com/MetaCubeX/mihomo/releases/download/Prerelease-Alpha/mihomo-linux-amd64-compatible-alpha-7eb16a0.gz
echo "clash premium 下载完成"

echo "开始解压"
gunzip mihomo-linux-amd64-compatible-alpha-7eb16a0.gz
echo "解压完成"

echo "开始重命名"
mv mihomo-linux-amd64-compatible-alpha-7eb16a0 mihomo
echo "重命名完成"

echo "开始添加执行权限"
chmod u+x mihomo
echo "执行权限添加完成"

echo "开始创建 /etc/mihomo 目录"
sudo mkdir /etc/mihomo
echo "/etc/mihomo 目录创建完成"

echo "开始复制 clash 到 /usr/local/bin"
sudo cp clash /usr/local/bin
echo "复制完成"

echo "开始设置 转发"
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
echo "转发设置完成"

echo "开始创建 systemd 服务"

sudo tee /etc/systemd/system/clash.service > /dev/null <<EOF
[Unit]
Description=Clash daemon, A rule-based proxy in Go.
After=network.target

[Service]
Type=simple
Restart=always
ExecStart=/usr/local/bin/mihomo -d /etc/mihomo

[Install]
WantedBy=multi-user.target
EOF

echo "systemd 服务创建完成"
