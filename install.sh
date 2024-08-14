#!/bin/bash

WHITE='\033[0;37m'
NC='\033[0m' 

show_menu() {
    clear
    echo -e "${WHITE}"
    echo "SCRIPT: Transfer Me v0.1.0"
    echo "USAGE:  This script transfers your desired directories to your destination server."
    echo "------------------------------"
    echo "Select an option:"
    echo "1) Transfer Marzban Directories"
    echo "2) Transfer X-UI Directories"
    echo "3) Transfer Hiddify Directories"
    echo "4) Transfer Custom Directories"
    echo "5) Exit"
    echo -e "${NC}"  

    read -p "Enter your choice [1-5]: " choice
    case $choice in
        1)
            transfer_marzban_directories
            ;;
        2)
            transfer_xui_directories
            ;;
        3)
            transfer_hiddify_directories
            ;;
        4)
            transfer_custom_directories
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice, please enter a number between 1 and 5."
            show_menu
            ;;
    esac
}

transfer_marzban_directories() {
#!/bin/bash 

WHITE='\033[0;37m'
NC='\033[0m' 

display_warning() {
    clear
    echo -e "${WHITE}"
    echo "----------------------------------------"
    echo " WARNING: $1"
    echo "----------------------------------------"
    echo -e "${NC}"  
}

MESSAGE="First, make sure Marzban is installed on your destination server." 

display_warning "$MESSAGE"

read -p "Enter the destination server IP address: " SERVER_IP
read -p "Enter the SSH port (default 22): " SERVER_PORT
SERVER_PORT=${SERVER_PORT:-22} 
read -sp "Enter the SSH password: " SERVER_PASSWORD
echo

if ! command -v zip &> /dev/null; then
    echo "Installing zip package..."
    sudo apt-get update && sudo apt-get install -y zip
else
    echo "Zip is already installed."
fi

if ! command -v sshpass &> /dev/null; then
    echo "Installing sshpass..."
    sudo apt-get update && sudo apt-get install -y sshpass
else
    echo "sshpass is already installed."
fi

BASE_DIR="/opt"
BASE_DIR2="/var/lib"

echo "Zipping contents of $BASE_DIR/marzban..."
(cd "$BASE_DIR" && zip -r marzban.zip marzban/)

echo "Zipping contents of $BASE_DIR2/marzban..."
(cd "$BASE_DIR2" && zip -r marzban.zip marzban/)

echo "Transferring /opt/marzban.zip to the server..."
sshpass -p "$SERVER_PASSWORD" scp -P $SERVER_PORT /opt/marzban.zip root@$SERVER_IP:/opt/marzban.zip

echo "Transferring /var/lib/marzban.zip to the server..."
sshpass -p "$SERVER_PASSWORD" scp -P $SERVER_PORT /var/lib/marzban.zip root@$SERVER_IP:/var/lib/marzban.zip

sshpass -p "$SERVER_PASSWORD" ssh -T -p "$SERVER_PORT" root@"$SERVER_IP" << 'EOF' 

BASE_DIR="/opt"
BASE_DIR2="/var/lib"

    # Install unzip if not installed
    if ! command -v unzip &> /dev/null; then
        echo "Installing unzip package..."
        apt-get update && apt-get install -y unzip
    else
        echo "Unzip is already installed."
    fi

    echo "Removing /opt/marzban directory..."
    rm -rf /opt/marzban

    echo "Removing /var/lib/marzban directory..."
    rm -rf /var/lib/marzban

    echo "Unzipping /opt/marzban.zip..."
    (cd "$BASE_DIR" && unzip -o marzban.zip)

    echo "Unzipping /var/lib/marzban.zip..."
    (cd "$BASE_DIR2" && unzip -o marzban.zip)

    echo "Removing /opt/marzban.zip file..."
    rm -rf /opt/marzban.zip

    echo "Removing /var/lib/marzban.zip file..."
    rm -rf /var/lib/marzban.zip    
EOF

echo -e "\033[97mMarzban directories are transferred successfully.\033[0m"
}

transfer_xui_directories() {
#!/bin/bash 

WHITE='\033[0;37m'
NC='\033[0m' 

display_warning() {
    clear
    echo -e "${WHITE}"
    echo "----------------------------------------"
    echo " WARNING: $1"
    echo "----------------------------------------"
    echo -e "${NC}"  
}

MESSAGE="First, make sure X-UI is installed on your destination server." 

display_warning "$MESSAGE"

read -p "Enter the destination server IP address: " SERVER_IP
read -p "Enter the SSH port (default 22): " SERVER_PORT
SERVER_PORT=${SERVER_PORT:-22} 
read -sp "Enter the SSH password: " SERVER_PASSWORD
echo

if ! command -v zip &> /dev/null; then
    echo "Installing zip package..."
    sudo apt-get update && sudo apt-get install -y zip
else
    echo "Zip is already installed."
fi

if ! command -v sshpass &> /dev/null; then
    echo "Installing sshpass..."
    sudo apt-get update && sudo apt-get install -y sshpass
else
    echo "sshpass is already installed."
fi

BASE_DIR="/etc"

echo "Zipping contents of $BASE_DIR/x-ui..."
(cd "$BASE_DIR" && zip -r x-ui.zip x-ui/)

echo "Transferring /etc/x-ui.zip to the server..."
sshpass -p "$SERVER_PASSWORD" scp -P $SERVER_PORT /etc/x-ui.zip root@$SERVER_IP:/etc/x-ui.zip

sshpass -p "$SERVER_PASSWORD" ssh -T -p "$SERVER_PORT" root@"$SERVER_IP" << 'EOF'

BASE_DIR="/etc"

    # Install unzip if not installed
    if ! command -v unzip &> /dev/null; then
        echo "Installing unzip package..."
        apt-get update && apt-get install -y unzip
    else
        echo "Unzip is already installed."
    fi

    echo "Removing /etc/x-ui directory..."
    rm -rf /etc/x-ui

    echo "Unzipping /etc/x-ui.zip..."
    (cd "$BASE_DIR" && unzip -o x-ui.zip)

    echo "Removing /etc/x-ui.zip..."
    rm -rf /etc/x-ui.zip
EOF

echo -e "\033[97mX-UI directories are transferred successfully.\033[0m"
}

transfer_hiddify_directories() {
#!/bin/bash 

WHITE='\033[0;37m'
NC='\033[0m' 

display_warning() {
    clear
    echo -e "${WHITE}"
    echo "----------------------------------------"
    echo " WARNING: $1"
    echo "----------------------------------------"
    echo -e "${NC}" 
}

MESSAGE="First, make sure Hiddify is installed on your destination server." 

display_warning "$MESSAGE"

read -p "Enter the destination server IP address: " SERVER_IP
read -p "Enter the SSH port (default 22): " SERVER_PORT
SERVER_PORT=${SERVER_PORT:-22} 
read -sp "Enter the SSH password: " SERVER_PASSWORD
echo

if ! command -v zip &> /dev/null; then
    echo "Installing zip package..."
    sudo apt-get update && sudo apt-get install -y zip
else
    echo "Zip is already installed."
fi

if ! command -v sshpass &> /dev/null; then
    echo "Installing sshpass..."
    sudo apt-get update && sudo apt-get install -y sshpass
else
    echo "sshpass is already installed."
fi

BASE_DIR="/opt"

echo "Zipping contents of $BASE_DIR/hiddify-config..."
(cd "$BASE_DIR" && zip -r hiddify-config.zip hiddify-config/)

echo "Transferring /opt/hiddify-config.zip to the server..."
sshpass -p "$SERVER_PASSWORD" scp -P $SERVER_PORT /opt/hiddify-config.zip root@$SERVER_IP:/opt/hiddify-config.zip

sshpass -p "$SERVER_PASSWORD" ssh -T -p "$SERVER_PORT" root@"$SERVER_IP" << 'EOF'

BASE_DIR="/opt"

    # Install unzip if not installed
    if ! command -v unzip &> /dev/null; then
        echo "Installing unzip package..."
        apt-get update && apt-get install -y unzip
    else
        echo "Unzip is already installed."
    fi

    echo "Removing /opt/hiddify-config directory..."
    rm /opt/hiddify-config

    echo "Unzipping /opt/hiddify-config.zip..."
    (cd "$BASE_DIR" && unzip -o hiddify-config.zip)

    echo "Removing /opt/hiddify-config.zip file..."
    rm -rf /opt/hiddify-config.zip 
EOF

echo -e "\033[97mHiddify directories are transferred successfully.\033[0m"
}

transfer_custom_directories() {
#!/bin/bash 

WHITE='\033[0;37m'
NC='\033[0m' 

display_warning() {
    clear
    echo -e "${WHITE}"
    echo "----------------------------------------"
    echo " INFO: $1"
    echo "----------------------------------------"
    echo -e "${NC}" 
}

MESSAGE="This section is for transferring custom directories." 

display_warning "$MESSAGE"

read -p "Enter the destination server IP address: " SERVER_IP
read -p "Enter the SSH port (default 22): " SERVER_PORT
SERVER_PORT=${SERVER_PORT:-22} 
read -sp "Enter the SSH password: " SERVER_PASSWORD
echo

read -p "Enter the first directory you want to transfer (example: /opt/marzban): " CUSTOM_DIR1
read -p "Enter the second directory you want to transfer (optional, press Enter to skip): " CUSTOM_DIR2

if ! command -v zip &> /dev/null; then
    echo "Installing zip package..."
    sudo apt-get update && sudo apt-get install -y zip
else
    echo "Zip is already installed."
fi

if ! command -v sshpass &> /dev/null; then
    echo "Installing sshpass..."
    sudo apt-get update && sudo apt-get install -y sshpass
else
    echo "sshpass is already installed."
fi

zip_and_transfer() {
    local dir="$1"
    local base_dir=$(dirname "$dir")
    local dir_name=$(basename "$dir")
    local zip_file="${dir_name}.zip"

    echo "Zipping contents of $dir..."
    (cd "$base_dir" && zip -r "$zip_file" "$dir_name/")

    echo "Transferring $zip_file to the server..."
    sshpass -p "$SERVER_PASSWORD" scp -P "$SERVER_PORT" "$base_dir/$zip_file" root@"$SERVER_IP":"$base_dir/$zip_file"

    echo "Unzipping $zip_file on the server..."
    sshpass -p "$SERVER_PASSWORD" ssh -T -p "$SERVER_PORT" root@"$SERVER_IP" << EOF
        if ! command -v unzip &> /dev/null; then
            echo "Installing unzip package..."
            apt-get update && apt-get install -y unzip
        else
            echo "Unzip is already installed."
        fi
        echo "Removing $dir on the server..."
        rm -rf "$dir"

        echo "Unzipping $base_dir/$zip_file..."
        (cd "$base_dir" && unzip -o "$zip_file")

        echo "Deleting $zip_file on the server..."
        rm -f "$base_dir/$zip_file"
EOF
}

if [ -n "$CUSTOM_DIR1" ]; then
    zip_and_transfer "$CUSTOM_DIR1"
else
    echo "No first custom directory specified."
fi

if [ -n "$CUSTOM_DIR2" ]; then
    zip_and_transfer "$CUSTOM_DIR2"
else
    echo "No second custom directory specified."
fi

echo -e "\033[97mCustom directories are transferred successfully.\033[0m"
}

show_menu
