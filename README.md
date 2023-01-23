# Adding symlinks to dotfiles repository configuration files

In order: tmux, LunarVim

```
    ln -sf ~/github/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/github/dotfiles/config.lua /Users/pete.mckinney/.config/lvim/config.lua
```


# Angular Language server configuration

angularls seems to work intermittently unless the server version matches the application version of angular. 

https://angular.io/guide/language-service

Install the angular language service globally for a target version by:

```bash
npm install --global @angular/language-service@13
```

# tmux plugins: 

Install by cloning the following repository https://github.com/tmux-plugins/tpm
