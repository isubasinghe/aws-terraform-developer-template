mkdir ~/coder
mkdir ~/coder/workspace
mkdir ~/coder/keys
cp ~/cert.cert ~/coder/keys/cert.cert
cp ~/key.key ~/coder/keys/key.key
wget https://github.com/cdr/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz
tar -xf code-server1.1156-vsc1.33.1-linux-x64.tar.gz -C ~/coder
sudo setcap 'cap_net_bind_service=+ep' ~/coder/code-server1.1156-vsc1.33.1-linux-x64/code-server
screen -S work bash -c '~/coder/code-server1.1156-vsc1.33.1-linux-x64/code-server --cert=cert.cert --cert-key=key.key --port=443'