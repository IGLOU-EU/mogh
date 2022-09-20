# [1.0.0] 🏗️ MOGH - The Magic Of Git Hooks
_Configurable UTF-8 git hooks templates without bullshit_

[![Pull request are open](https://img.shields.io/badge/Pull_request-Open-green.svg?style=flat-square)](https://github.com/IGLOU-EU/mogh/fork)
[![License: GPL 3.0](https://img.shields.io/badge/License-GPL_3.0_or_later-blue.svg?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0.html)

## 🧠 Systems supported
- [x] Gnu/Linux
- [ ] Windows
- [ ] macOS
- [ ] BSD

## 🧪 Features
- [x] Can be configured with `git config` globally or locally
- [x] Colored Error and Success message output
- [x] Unit testing for each hook
- [x] emoji type support (can be disabled)
- [x] Check and Auto-fix commit message format
- [x] Check and Auto signoff when missing if required
- [ ] Check and Auto pgp singing when missing if required
- [ ] Avoid duplicate commits
- [x] Avoid to commit binary files with auto or interactive fix
- [x] Avoid to commit large files with auto or interactive fix
- [x] Support of DNCT (Do Not Commit This) tags in files
- [x] Prevent the commit of the mac ds_store ...
- [ ] Prevent pushing to remote branches that is not up-to-date with local branches
- [ ] Prevent pushing commit with WIP (Work in Progress) tag
- [x] Require a .gitignore file to be present in the root of the repository
- [ ] Emit a warning if potential sensitive information is found in a file

## 💻 Usage
These scripts are automatically used by Git according to the actions taken,
like every `githooks` and comforming to the [githooks manual page](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/githooks.html).

You can disable MOGH hooks for a specific project with the dedicated option.
Like this:
```bash
git config mogh.enabled 0
```

Or you can skip it one with the git `--no-verify` flag for push actions.

## 📦 Dependencies
To work properly, these scripts don't require any exta dumb tools like npm,
python or other crap. Requirements are probably by default on your system.

- `git` of course ...
- `printf` to format a string
- `bash` this is an sh-compatible shell
- `grep` searching plain-text data sets for lines
- `file` checking file type
- `stat` checking file size
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

### Update ♻️
To update it, just run the following command:
```bash
curl -sL https://raw.githubusercontent.com/IGLOU-EU/mogh/master/tools/update.sh | bash
```
That will globally made an `git pull` to the repository to update the templates.
If the repository is not cloned yet, it returns an error.

### Update repository 🪝
To update hooks in a repository, run the following command on it:
```bash
git init
```
According to the [documentation](https://git-scm.com/docs/git-init/en),
this can update repository.
> Create an empty Git repository **OR** reinitialize an existing one

## 📝 Configuration
The configuration use the default git config file, so you can change it with 
the git command `git config`. By default, the configuration is applied only to
the current git repository, but you can apply it globally with the `--global`
flag option. For more information, see the
[documentation](https://git-scm.com/docs/git-config).

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

### TOML config 📋
This is the `git config` representation of how the default MOGH configuration
is applied for hooks.
```toml
[mogh]
	enabled = 1
    gitignore = 1
[mogh "dnct"]
	enabled = 1
	regex = \\[DNCT\\]|DONOTCOMMITTHIS|DO-NOT-COMMIT-THIS|DO_NOT_COMMIT_THIS|DO NOT COMMIT THIS
[mogh "files"]
	size-max = 1024
	uncache-oversize = 2
	uncache-dsstore = 1
	uncache-binary = 2
[mogh "gpg"]
	required = 1
	autofix = 1
[mogh "header"]
	autofix = 1
[mogh "types"]
	emoji = 2
[mogh "signoff"]
	required = 1
	autofix = 1
```

### Detailed config 📑
#### mogh.enabled
To enable or disable MOGH hooks.    
> Can be set to 0 or 1. Default is 1.

#### mogh.gitignore
To enable or disable the gitignore requirement.
> Can be set to 0 or 1. Default is 1.

#### mogh.dnct.enabled
To enable or disable the dnct tag checker.
This tag DO NOT COMMIT THIS is used to prevent the commit of sensitive data.
> Can be set to 0 or 1. Default is 1.

#### mogh.dnct.regex
To set the dnct tag regex.
This is the regex to match the dnct tag.
> Default is `\[DNCT\]|DONOTCOMMITTHIS|DO-NOT-COMMIT-THIS|DO_NOT_COMMIT_THIS|DO NOT COMMIT THIS`

#### mogh.files.uncache-dsstore
To enable or disable the ds_store remover.
When you work with mac guys ...
> Can be set to 0 or 1. Default is 1.

#### mogh.files.uncache-binary
To enable or disable the binary file remover.
This flag is used to prevent the commit of executable binaries.
> Can be set to 0, 1, 2. Default is 2.    
> 0: keep it; 1: remove from commit; 2: interactive fix.

#### mogh.files.size-max
To set the maximum file size to be committed.
This flag is used to prevent the commit of large files.
> Can be set to a KB value. Default is 1024.

#### mogh.files.uncache-oversize
To enable or disable the file size autofix.
> Can be set to 0, 1, 2. Default is 2.    
> 0: keep it; 1: remove from commit; 2: interactive fix.

#### mogh.gpg.required
To enable or disable GPG signing requirement.    
This flag will force user to use git `-S, --gpg-sign`
> Can be set to 0 or 1. Default is 1.

#### mogh.gpg.autofix
To enable or disable automatic GPG signature fixing.    
This flag will try to automatically apply the gpg signature to the commit.
> Can be set to 0 or 1. Default is 1.

#### mogh.header.autofix
To enable or disable automatic header fixing.    
This flag will try to automatically fix the header of the commit.
According to the [conventionalcommits.org v1](https://www.conventionalcommits.org/en/v1.0.0/).
> Can be set to 0 or 1. Default is 1.

#### mogh.types.extra
To add extra commit type to the list of supported types.    
By default, all commit type from conventionalcommits.org v1 are available.
> Default is an empty list.    
> Can be added with `git config --global mogh.types.extra "poop"`

#### mogh.types.emoji
To enable or disable the emoji type support.    
The idea is to use the emoji type instead of the type name.
This is largely inspired by [gitmoji.dev](https://gitmoji.dev/).
> Can be set to 0, 1, 2. Default is 2.    
> 0: disable; 1: enable; 2: enable but keep the type name.

#### mogh.types.extra-emoji
To add extra emoji commit type to the list of supported types.    
In case you have added extra commit type to the list and whant corresponding
emoji, you need to add them here. Warning, the position id in the array is
used to map the commit type to emoji, so you need to keep the same order.
> Default is an empty list.    
> Can be added with `git config --global mogh.types.extra-emoji "💩"`

#### mogh.signoff.required
To enable or disable the signoff requirement.    
This flag will force user to use git `-s, --signoff`
> Can be set to 0 or 1. Default is 1.

#### mogh.signoff.autofix
To enable or disable automatic signoff fixing.    
This flag will try to automatically add the signoff to the commit.
It use git variable `GIT_AUTHOR_NAME` and `GIT_AUTHOR_EMAIL` to generate it.
> Can be set to 0 or 1. Default is 1.
