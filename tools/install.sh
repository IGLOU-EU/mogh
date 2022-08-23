#!/bin/bash

# check if git is available
if ! command -v git >/dev/null 2>&1; then
    error "git is not available"
    exit 1
fi

# init var path
GIT_REPO="https://github.com/IGLOU-EU/mogh.git"
INSTALL_PATH="$(git config init.templatedir)"
TEMPLATE_PATH=""

# check if the INSTALL_PATH is empty
if [[ -z $INSTALL_PATH ]]; then
    INSTALL_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/.git/templates"
fi

# set the template path
TEMPLATE_PATH="${INSTALL_PATH}"
INSTALL_PATH+="/hooks"

# check if the install path already exists
if [[ -d $INSTALL_PATH ]]; then
    echo "[INFO] The install path already exists and it will be moved to ${INSTALL_PATH}.old"
    mv "$INSTALL_PATH" "$INSTALL_PATH.old" || {
        echo "[ERROR] Failed to move the install path" >&2
        exit 1
    }
fi

# create the install path
mkdir -p "$INSTALL_PATH" || {
    echo "[ERROR] Failed to create the install path" >&2
    exit 1
}

# clone to the install path
echo "[INFO] Cloning to the install path"
git clone "$GIT_REPO" "$INSTALL_PATH" > /dev/null || {
    echo "[ERROR] Failed to clone to the install path" >&2
    exit 1
}

# enable the templates in git config
echo "[INFO] Enable the templates in git config"
git config --global init.templatedir "$TEMPLATE_PATH" || {
    echo "[ERROR] Failed to enable the templates in git config" >&2
    exit 1
}

# enjoy your new git hooks 🎉
echo "[INFO] Installation complete 🎉"