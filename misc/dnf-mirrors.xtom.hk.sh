sed -i "s|^#baseurl=http://download.example/pub/fedora/linux/releases/|baseurl=https://mirrors.xtom.hk/fedora/releases/|g" /etc/yum.repos.d/fedora.repo
sed -i "s|^metalink=|#metalink=|g" /etc/yum.repos.d/fedora.repo
sed -i "s|^#baseurl=http://download.example/pub/fedora/linux/updates/|baseurl=https://mirrors.xtom.hk/fedora/updates/|g" /etc/yum.repos.d/fedora-updates.repo
sed -i "s|^metalink=|#metalink=|g" /etc/yum.repos.d/fedora-updates.repo
