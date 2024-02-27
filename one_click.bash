#!/bin/bash

# 这是一个示例脚本，包含一些常用的Debian 11服务器命令和梯子安装选项

# 更新软件包列表
sudo apt update

# 安装常用工具
sudo apt install wget curl vim git sudo -y

echo "选择要执行的操作:"
echo "1. 梯子安装"
echo "2. Alist安装"
echo "3. VPS测试"
echo "4. Rclone操作"
echo "5. Aria2安装"
echo "6. Jupyter安装"
echo "7. 设置Nginx反代"
echo "8. 为IPv6服务器添加IPv4出口"
echo "9. Docker和Docker-Compose安装"

read -p "请输入数字进行选择: " choice

case $choice in
    1)
        echo "选择梯子安装方式:"
        echo "1. x-ui"
        echo "2. vasma"
        echo "3. singbox"

        read -p "请输入数字选择梯子安装方式: " vpn_choice

        case $vpn_choice in
            1)
                bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
                ;;
            2)
                wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh && /root/install.sh
                ;;
            3)
                bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh)
                ;;
            *)
                echo "无效的选择"
                ;;
        esac
        ;;
    2)
        # alist安装
        curl -fsSL "https://alist.nn.ci/v3.sh" | bash -s install
        cd /opt/alist
        read -p "请输入新密码: " new_password
        ./alist admin set "$new_password"
        ;;
    3)
        # VPS测试
        echo "选择VPS测试方式:"
        echo "1 融合怪"
        echo "2 性能"
        echo "3 网络"
        echo "4 是否超售"

        read -p "请输入数字选择VPS测试方式: " vps_test_choice

        case $vps_test_choice in
            1)
                bash <(wget -qO- bash.spiritlhl.net/ecs)
                ;;
            2)
                wget -qO- yabs.sh | bash
                ;;
            3)
                bash <(curl -Lso- https://bench.im/hyperspeed)
                wget -N --no-check-certificate https://raw.githubusercontent.com/Chennhaoo/Shell_Bash/master/AutoTrace.sh && chmod +x AutoTrace.sh && bash AutoTrace.sh
                ;;
            4)
                wget --no-check-certificate -O memoryCheck.sh https://raw.githubusercontent.com/uselibrary/memoryCheck/main/memoryCheck.sh && chmod +x memoryCheck.sh && bash memoryCheck.sh
                ;;
            *)
                echo "无效的选择"
                ;;
        esac
        ;;
    4)
        # Rclone操作
        echo "选择Rclone操作方式:"
        echo "1 安装rclone"
        echo "2 移动文件"
        echo "3 挂载目录"

        read -p "请输入数字选择Rclone操作方式: " rclone_choice

        case $rclone_choice in
            1)
                curl https://rclone.org/install.sh | sudo bash
                ;;
            2)
                read -p "请输入源文件的Drive编号（例如DRIVE_1）: " source_drive
                read -p "请输入目标文件的Drive编号（例如DRIVE_2）: " target_drive
                read -p "请输入文件名: " filename
                nohup rclone copy "$source_drive:/$filename" "$target_drive:/$filename" --ignore-existing &
                ;;
            3)
                apt install fuse
                apt install fuse3
                mkdir /FILE
                read -p "请输入挂载的文件名（例如FILE）: " mount_file
                read -p "请输入rclone配置的目录（例如FILE）: " rclone_dir
                nohup rclone mount "$rclone_dir:/" "/$mount_file" --cache-dir /tmp --allow-other --vfs-cache-mode writes --allow-non-empty &
                ;;
            *)
                echo "无效的选择"
                ;;
        esac
        ;;
    5)
        # Aria2安装
        wget -N git.io/aria2.sh && chmod +x aria2.sh && ./aria2.sh
        ;;
    6)
        # Jupyter安装
        sudo apt install python3 python3-pip python3-venv -y
        mkdir code
        python3 -m venv env
        source env/bin/activate
        pip3 install jupyter

        # 判断服务器是否有IPv4地址
        if [[ $(ip -4 a show scope global | grep inet) ]]; then
            jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
        else
            # 如果没有IPv6地址则执行
            jupyter notebook --ip=:: --port=8888 --no-browser --allow-root
        fi
        ;;
    7)
        # 设置Nginx反代
        sudo apt install nginx

        read -p "请输入配置文件的名称（例如NAME）: " nginx_name
        read -p "请输入域名（例如DOMAIN_NAME）: " domain_name
        read -p "请输入端口号（例如PORT）: " port

        cat <<EOF > "/etc/nginx/sites-available/$nginx_name.conf"
        your_content
        server {
            listen 80;
            server_name $domain_name;

            location / {
                proxy_pass http://localhost:$port;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
            }
        }
EOF 
        ln -s "/etc/nginx/sites-available/$nginx_name.conf" "/etc/nginx/sites-enabled/"
        sudo apt install certbot python3-certbot-nginx
        certbot --nginx
        ;;
    8)
        # 为IPv6服务器添加IPv4出口
        mv /etc/resolv.conf /etc/resolv.conf.bak && echo -e "nameserver 2001:67c:2b0::4\nnameserver 2001:67c:2b0::6" > /etc/resolv.conf

        echo "选择IPv4出口方式:"
        echo "1 FSCARMEN"
        echo "2 P3TERX"
        echo "3 WARP-GO"
        echo "4 MISAKA"

        read -p "请输入数字选择IPv4出口方式: " ipv4_exit_choice

        case $ipv4_exit_choice in
            1)
                wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh && bash menu.sh
                ;;
            2)
                bash <(curl -fsSL git.io/warp.sh) menu
                ;;
            3)
                wget -N https://raw.githubusercontent.com/fscarmen/warp/main/warp-go.sh && bash warp-go.sh
                ;;
            4)
                wget -N https://gitlab.com/Misaka-blog/warp-script/-/raw/main/warp.sh && bash warp.sh
                ;;
            *)
                echo "无效的选择"
                ;;
        esac
        ;;
    9)
        # Docker和Docker-Compose安装
        curl -sSL https://get.docker.com/ | sh
        curl -L "https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
        ;;
    *)
        echo "无效的选择"
        ;;
esac
