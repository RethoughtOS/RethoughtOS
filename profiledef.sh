#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="RethoughtOS"
iso_label="RethoughtOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="RethoughtOS <https://rethoughtos.com>"
iso_application="RethoughtOS Live/Rescue DVD"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')

bootmodes=(
  'bios.syslinux.mbr' 'bios.syslinux.eltorito'
  'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
  'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito'
)

arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"

# **Korrigierte SquashFS-Einstellungen für Performance & Stabilität**
airootfs_image_tool_options=(
  '-comp' 'zstd'                 # Schnellere Kompression als xz
  '-Xcompression-level' '15'      # Hohe Kompressionsrate ohne zu viel Performanceverlust
  '-b' '1M'                       # 1 MB Blockgröße für schnelleres Laden
  '-processors' "$(nproc)"        # Nutzt alle CPU-Kerne für maximale Geschwindigkeit
)

# **Schnellere Bootstrap-Kompression mit Zstd**
bootstrap_tarball_compression=(
  'zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19'
)

# **Sichere Datei-Berechtigungen für Enterprise-Umgebungen**
file_permissions=(
  ["/etc/gshadow"]="0:0:0400"
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
)
