<h1 align="center"/>Transfer Me</h1>

<p align="center">
    A Practical Script to Transfer Your Desired Directories to Another Server
</p>

# Usage
`Transfer Me` is a practical script that transfers your desired directories to your destination server, so instead of manually moving the files, all you have to do is use this script and you're good to go!

### 📜 Options

  - **Marzban**
  - **X-UI**
  - **Hiddify**
  - **Custom**

> [!IMPORTANT]
> First, make sure your panel (`Marzban` or `X-UI` or `Hiddify`) is installed on your destination server. Also, keep in mind that the assumption is that your destination server is fresh, therefore `Transfer Me` will `replace` panel's directories with your current Master panel.

## Setup Instructions 

Replace your destination server IP address in the following command and run it:
```bash
ssh -p "22" root@"IP.IP.IP.IP"
```

> [!TIP]
> This will help with `Host Key Verification` to make SSH connection successfully, after that close the terminal and log into your Master server again.

Then, enter the following command: 

```bash
sudo bash -c "$(curl -sL https://github.com/iamtheted/transfer-me/raw/main/install.sh)"
```

## Next Steps

> [!IMPORTANT]
> After the directories are transferred, you need to deactivate your panel on your current Master server then activate it on your destination server, also you need to change your panel and subscription link's IP to your destination server IP address. 

> [!TIP]
> If you're using `Marzban`, enter `marzban down` in your current Master server then enter `marzban restart` in your destination server.

> [!TIP]
> If you're using `X-UI`, enter `x-ui stop` in your current Master server then enter `x-ui restart` in your destination server.

> [!TIP]
> If you're using `Hiddify`, enter the following commands in your current Master server:
```bash
systemctl stop hiddify-redis
systemctl stop hiddify-ssh-liberty-bridge
systemctl stop hiddify-haproxy
systemctl stop hiddify-panel
systemctl stop hiddify-nginx
systemctl stop hiddify-singbox
systemctl stop hiddify-xray
```
Then enter the the following command in your destination server:
```bash
bash /opt/hiddify-manager/restart.sh
```

## Contribution

`Transfer Me` has got plenty of room for improvement, I was trying to add `SSH KEY` support as well but there were many problems that didn't let me make that happen including `scp` command which would face `premission denied` error, also I found another way which was not recommended due to security risks so I got rid of `SSH KEY` support for now, if you believe you can help on this matter, please don't hesitate! 

## Support

A Star (⭐) is enough, I appreciate it.
