sudo apt-get update && sudo apt-get install --yes \
  dirmngr \
  emacs \
  git \
  gnupg2 \
  pandoc \
  python3

for locale in en_US sv_SE; do
  sudo sed -i "s/^# *\\(${locale}.UTF-8\\)/\\1/" /etc/locale.gen
done
sudo locale-gen
