# [WIP] 🏗️ MOGH - The Magic Of Git Hooks
_Configurable UTF-8 git hooks templates without bullshit_

[![License: GPL 3.0](https://img.shields.io/badge/Pull_request-Open-green.svg?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0.html)
[![License: GPL 3.0](https://img.shields.io/badge/License-GPL_3.0_or_later-blue.svg?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0.html)

## 🧪 Features
- Check and Auto-fix commit message format
- Partial emoji support (can be disabled)
- Colored Error and Success message output

## 📦 Dependencies
To work properly, these scripts don't require any exta dumb tools like npm,
python or other crap. Requirements are probably by default on your system.

- `git` of course ...
- `bash` this is an sh-compatible shell
- `grep` searching plain-text data sets for lines
- `sed` parses and transforms text
- `tr` operation of replacing or removing specific characters
- `jq` (only for unit testing) JSON processor

## 📥 Installation
To install it, just run the following command:
```bash
curl -sL https://raw.githubusercontent.com/IGLOU-EU/mogh/master/tools/install.sh | bash
```

That will clone the repository to your git templates directory and
enable it to the global git hooks.   
This is not a destructive operation, if you already have a git hook installed
it will not be overwritten but moved to `hooks.old`.

Or you can install it manually by running something like this:
```bash
mkdir -p ~/.git/templates
git clone https://github.com/IGLOU-EU/mogh.git ~/.git/templates/hooks
git config --global init.templatedir ~/.git/templates
```

## 📝 Configuration
The configuration use the default git config file, so you can change it with 
the git command `git config`. By default, the configuration is applied only to
the current git repository, but you can apply it globally with the `--global`
flag option.

Local configuration overrides global configuration, except for lists, like
`mogh.types.extra` and `mogh.types.extra-emoji`. There use "all values for a
multi-valued key" from both configurations like an union of the two lists.

This is a config example, to full config see the next section
```bash
# add extra type support to global config
git config --global mogh.types.extra "poop"
git config --global mogh.types.extra "mock"
git config --global mogh.types.extra "break"

# add extra emoji support to global config
git config --global mogh.types.extra-emoji "💩"
git config --global mogh.types.extra-emoji "🤡"
git config --global mogh.types.extra-emoji "💥"

# enable the type replacement to emoji
# but only to the current repository
git config mogh.types.emoji 1
```

Take your `git config` and fill it to your needs 🎉

### [mogh] Section
```toml
[mogh]
```

## 💻 Usage
These scripts are automatically used by Git according to the actions taken,
like every `githooks` and comforming to the [githooks manual page](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/githooks.html).

You can disable MOGH hooks for a specific project with the dedicated option.
Like this:
```bash
git config mogh.enabled 0
```

Or you can skip it one with the git `--no-verify` flag for push actions.