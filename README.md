# [1.1.1] 🏗️ MOGH - The Magic Of Git Hooks
_Easily configurable git hooks templates without bullshit_

[![Keep it simple, stupid](https://img.shields.io/badge/KISS-Powered-brightgreen?style=flat-square)](#)
[![Pull request are open](https://img.shields.io/badge/Pull_request-Open-green?style=flat-square)](https://github.com/IGLOU-EU/mogh/fork)
[![License: GPL 3.0](https://img.shields.io/badge/License-GPL_3.0_or_later-blue?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0.html)
[![Made with fun](https://img.shields.io/badge/Made_with-Fun_%F0%9F%98%B8-ff69b4?style=flat-square)](#)

The reason of this project, is that some Git Hooks usually have no interest in being checked out AFTER a push (like with github actions). Checking the format, preventing the commit of certain information or files, etc. All this stuff should be checked locally to prevent mistake and leave no trace of it in the history. 

This type of tool already exists, but it's extremely heavy and has many dependencies (like with npm, python, etc.). This is not the case here, it's just bash script that uses the default tools of a Unix like system and to be easily configurable with the git config command.

## ✨ I wish
- To finish Features implementations
- A gitlab job to run unit test
- To testing supported systems
- A Documentation review

## 🧠 Systems supported
- [x] Gnu/Linux
- [ ] Windows
- [ ] macOS (not tested)
- [ ] BSD (need to validate posix compatibility)

## 🧪 Features
- [x] Can be configured with `git config` globally or locally [see configuration](#-configuration)
- [x] Colored Error and Success message output
- [x] Unit testing for each hook
- [x] emoji type support for commit message
- [x] Check and Auto-fix commit message format
- [x] Check and Auto signoff when missing if required
- [x] Check and Auto pgp singing when missing if required
- [ ] Avoid duplicate commits message
- [x] Avoid to commit binary files with auto or interactive fix
- [x] Avoid to commit large files with auto or interactive fix
- [x] Support of DNCT (Do Not Commit This) tags in files
- [x] Prevent the commit of the mac ds_store ...
- [ ] Prevent pushing to remote branches that is not up-to-date with local branches
- [x] Prevent pushing commit with WIP tag
- [x] Prevent commit when previous commit is a WIP
- [x] Require a .gitignore file to be present in the root of the repository
- [ ] Emit a warning if potential sensitive information is found in a file
- [ ] Branch naming convention
- [x] Branch protection rules
- [ ] Enforce --force-with-lease instead of --force

## 💻 Usage
These scripts are automatically used by Git according to the actions taken,
like every `githooks` and comforming to the [githooks manual page](https://mirrors.edge.kernel.org/pub/software/scm/git/docs/githooks.html).

You can disable MOGH hooks for a specific project with the dedicated option.
Like this:
```bash
git config mogh.enabled 0
```

Or you can skip it one time with the git `--no-verify` flag for push actions.

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
- `pgp` if you require a PGP signature
- `jq` (only for unit testing) JSON processor

## 📥 Installation
To install it, just run the following command:
```bash
curl -sL https://gitlab.com/adrienK/mogh/-/raw/main/tools/install.sh | bash
```

That will clone the repository to your git templates directory and
enable it to the global git hooks.   
This is not a destructive operation, if you already have a git hook installed
it will not be overwritten but moved to `hooks.old`.

Or you can install it manually by running something like this:
```bash
mkdir -p ~/.git/templates
git clone https://gitlab.com/adrienK/mogh.git ~/.git/templates/hooks
git config --global init.templatedir ~/.git/templates
```

### Update ♻️
To update it, just run the following command:
```bash
curl -sL https://gitlab.com/adrienK/mogh/-/raw/main/tools/update.sh | bash
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

### Uninstall 🗑️
To update it, run the following command:
WARNING: There use an `rm -rf`, check the path if you're not sure !
```bash
templatedir="$(git config init.templatedir)" // find the install folder
rm -rf "$templatedir" // remove it
```
Every local git repos keep their git hooks. Git init make a copy of hooks, not a link. 
So you have two choices :
- Removing manually `.git/hooks` for every local repos
- Disable MOGH to prevent any execution `git config --global mogh.enabled 0`

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
This is the `git config` representation of how the default MOGH configuration applied for hooks.
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
	max-length = 80
[mogh "types"]
	emoji = 2
[mogh "signoff"]
	required = 1
	autofix = 1
[mogh "wip"]
	prevent-push = 1
	secure-commit = 1
[mogh "branch"]
	protected = 0
	protected-push = 0
	protected-name = "main|master"
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

#### mogh.header.max-length
To set the maximum length of the commit header.
This flag is used to prevent the commit of too long header.
> Can be set to a number. Default is 80.

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

#### mogh.wip.prevent-push
To enable or disable the WIP tag push prevention.   
This flag will prevent the push of a commit with the WIP tag.
> Can be set to 0 or 1. Default is 1.

#### mogh.wip.secure-commit
To enable or disable the prevention of commit when previous commit is a WIP.   
This flag is to keep the history clean of WIP commits.
> Can be set to 0 or 1. Default is 1.

#### mogh.branch.protected
To enable or disable the branch protection.   
This flag will prevent the commit on a protected branch.   
Particularly useful when your distante repository not support branch protection.
> Can be set to 0 or 1. Default is 0.

#### mogh.branch.protected-push
To enable or disable the branch protection push.   
This usefull to prevent allowing or not independently of commiting on a protected branch.
> Can be set to 0 or 1. Default is 0.   
> _**Note:** By default, this flag is set to the value of `mogh.branch.protected`._

#### mogh.branch.protected-name
To define a regex to match with the branches you wish to protect.   
Example: `release\/[0-9]+\.[0-9]+` will protect all branches like `release/1.0`, `release/2.0`, etc.
> Default is `main|master`.

## 🤝 Contributing
For contribute to this project, follow these steps:
1. Fork this repository.
2. Clone it to your local machine.
3. Remove the `.git/hooks` directory of the cloned repository `rm -rf .git/hooks`.
4. Create a symbolic link to THIS clone `ln -s "$(pwd)" "$(pwd)/.git/hooks"`.
5. Create a new branch with the feature, fix... name like `git checkout -b feature/feature-name`.
6. Commit, push and create a pull request ! 🎉
> If you have any questions, feel free to ask.
> And do not forget to sign your commits.

## 🧪 Testing
Every hook has its own unit test (if not, I have missed it). 

If you need to write a test. These are located in the `tests` directory and have the same name as the hook with the `.test` extension, you need to make it executable with `chmod +x tests/commit-msg.test` and cases are defined in json format.

To run them, you need to have `jq` installed. Then you can run it like every other bash script. Like:
```bash
./tests/commit-msg.test
```

## 📜 License
This project is licensed under the GPL 3.0 License - see the [LICENSE](LICENSE) file for details.