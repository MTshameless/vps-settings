# vps-settings

1.x-ui:
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)

2.alist: 
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)

3.vps测试
bash <(wget -qO- bash.spiritlhl.net/ecs)

4.rclone
curl https://rclone.org/install.sh | sudo bash
wget -N git.io/rcloned && nano rcloned
mv rcloned /etc/init.d/rcloned
chmod +x /etc/init.d/rcloned
bash /etc/init.d/rcloned start

5.aria2+rclone 自动上传
wget -N git.io/aria2.sh && chmod +x aria2.sh && ./aria2.sh
nano /root/.aria2c/aria2.conf
on-download-complete=/root/.aria2c/upload.sh 
nano /root/.aria2c/script.conf
drive-name=
