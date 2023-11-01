# Adding symlinks to dotfiles repository configuration files

```
    ln -sf ~/github/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/github/dotfiles/.tmux.conf ~/.zshrc
    ln -sf ~/github/dotfiles/.tmux.conf ~/.zsh_aliases
```

# tmux plugins: 

Install by cloning the following repository https://github.com/tmux-plugins/tpm

# Other dependencies: 

Most dependencies are installed using brew. Check the github README.md installation instructions for each of the links below.

[github cli](https://github.com/cli/cli)

[jq command-line JSON processor](https://github.com/jqlang/jq)

```bash
brew tap ankitpokhrel/jira-cli
brew install jira-cli
```

Make sure to create a personal access token in jira through the /ViewProfile.jspa (Profile picture in the top right, click on Profile) page and set it in your preferred zsh/bash file:

```bash
export JIRA_API_TOKEN=yourpersonalaccesstoken

```

[fzf fuzzy finder](https://github.com/junegunn/fzf)

[jira cli](https://github.com/ankitpokhrel/jira-cli)

[fd alternative to find](https://github.com/sharkdp/fd)

[neovim](https://github.com/neovim/neovim)

[ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
