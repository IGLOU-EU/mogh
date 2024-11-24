#!/bin/bash

# check if git is available
if ! command -v git >/dev/null 2>&1; then
    error "git is not available"
    exit 1
fi

# init var path
INSTALL_PATH="$(realpath "$(git config init.templatedir | sed "s|^~|$HOME|")")/hooks"

# check if the install path exists
if [[ ! -d $INSTALL_PATH ]]; then
    echo "[ERROR] The install path does not exist: $INSTALL_PATH" >&2
    exit 1
fi

# update the hooks
git -C "$INSTALL_PATH" pull || {
    echo "[ERROR] Failed to update the hooks into: $INSTALL_PATH" >&2
    exit 1
}

# enjoy your updated git hooks 🎉
echo "[INFO] Update complete 🎉"