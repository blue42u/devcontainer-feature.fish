#!/bin/sh -e

# SPDX-FileCopyrightText: Jonathon Anderson
#
# SPDX-License-Identifier: MIT

# Identify the current architecture
case "$(uname -m)" in
x86_64)
  archspec=linux-x86_64
  ;;
aarch64)
  archspec=linux-aarch64
  ;;
*)
  echo "Unsupported architecture: $(uname -m)"
  exit 1
  ;;
esac

# Confirm the binary is available
cd "$(dirname "$(realpath "$0")")"
if ! [ -e "dist/fish-$archspec" ]; then
  echo "fish-$archspec not found in dist/"
  exit 1
fi

# Install the binary in a global location (/usr/bin)
if [ -e /usr/bin/fish ] && [ "$OVERWRITE" != "true" ]; then
  echo "/usr/bin/fish already present, not overwriting"
else
  cp dist/fish-$archspec /usr/bin/fish
  chmod +x /usr/bin/fish
fi

if [ "$UPDATESHELL" = "true" ]; then
  # Confirm Fish is allowed as a shell in /etc/shells
  if ! grep -qxF /usr/bin/fish /etc/shells; then
    echo '/usr/bin/fish' >> /etc/shells
  fi

  # Update the /etc/passwd entry for the remote user to /usr/bin/fish
  sed -i "/^$_REMOTE_USER:/s|:[^:]*$|:/usr/bin/fish|" /etc/passwd
fi
