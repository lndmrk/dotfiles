sudo apt-get update && sudo apt-get install --yes \
  git \
  emacs \
  pandoc \
  python3 \
  shellcheck \
  stow

for locale in en_US sv_SE; do
  sudo sed -i "s/^# *\\(${locale}.UTF-8\\)/\\1/" /etc/locale.gen
done
sudo locale-gen
