## start with zsh
rm ~/.zshrc
ln -s ./zshrc ~/.zshrc

rm ~/User/nathan/.oh-my-zsh/themes/geoffgarside.zsh-theme
ln -s ./geoffgarside.zsh-theme ~/User/nathan/.oh-my-zsh/themes/geoffgarside.zsh-theme


## tmux conf
rm ~/.tmux.conf
ln -s ./.tmux.conf ~/.tmux.conf

## alacritty
rm ~/.config/alacritty/alacritty.yml
ln -s ./alacritty.yml ~/.config/alacritty/alacritty.yml

## nvim
rm ~/configs/init.vim
ln -s ./init.vim ~/configs/init.vim

## tmux script
cp ./tm /usr/local/bin/tm
