curl -L -o ~/.local/bin/kast $(curl -s https://api.github.com/repos/simon-danielsson/kast-launcher/releases/latest \
        | grep "browser_download_url.*kast\"" \
        | cut -d '"' -f 4)
chmod +x ~/.local/bin/kast
