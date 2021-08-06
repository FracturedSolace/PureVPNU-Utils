# PureVPNU-Utils
Bash scripts used to set up purevpn with transmission-daemon

-Scripts assume that others are in the path directory (ex. start-vpn.sh will call hasipchanged.sh without a full path specified)
-These rely on the .ovpn files provided by purevpn (https://s3-us-west-1.amazonaws.com/heartbleed/windows/New+OVPN+Files.zip) and their directory should be hard-coded
-Scripts also expect a login.txt file with your purevpn login information stored in plaintext. Do NOT use this method if your password is shared across other, important accounts
-More information on how to connect to these files from purevpn https://support.purevpn.com/article-categories/getting-started/linux/manual-connection-setup/command-line/command-line-openvpn
-Currently these are not very portable, so don't be surprised if they need tweaking for your system, especially if you don't have all of the referenced commands installed. Essentially I just slapped my ~/bin/ directory onto github in case I need these scripts again.

Main goals of these scripts
-Replace the god awful purevpn app provided for linux, which stopped working for my recently with native OVPN support
-Check that IP has actually been changed before starting sensitive applications (torrent client)
-Check that sensitive applications (torrent client) have actually been closed before allowing the VPN to disconnect

Contact https://github.com/FracturedSolace if you really want to use these and are lost on setting them up, and I'll provide the rest of the set up files if you can't figure out the inner workings just from the scripts
