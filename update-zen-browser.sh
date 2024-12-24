
#!/usr/bin/env bash

upstream=$(./new-version.sh | cat -)

echo "Updating to $upstream"

baseUrl="https://github.com/zen-browser/desktop/releases/download/$upstream"

# Modify with sed the nix file
sed -i "s/version = \".*\"/version = \"$upstream\"/" ./flake.nix

# Update the hash sha256
generic=$(nix-prefetch-url --type sha256 --unpack $baseUrl/zen.linux-x86_64.tar.bz2)
sed -i "s/generic.sha256 = \".*\"/generic.sha256 = \"$generic\"/" ./flake.nix

nix flake update
nix build
