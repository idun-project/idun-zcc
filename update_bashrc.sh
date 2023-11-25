post_install() {
  if ! [ -d "/home/idun/.bashrc" ]; then
    echo ". \"/etc/profile.d/z88dk.sh\"" >> /home/idun/.bashrc
  fi
}

pre_remove() {
  if ! [ -d "/home/idun/.bashrc" ]; then
    sed -i '/z88dk/d' /home/idun/.bashrc
  fi
}
