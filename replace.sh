## start with zsh
rm ~/.zshrc
ln -s /Users/nathanmalishev/Coding/dotfiles/.zshrc /Users/nathanmalishev/.zshrc

rm ~/.oh-my-zsh/themes/geoffgarside.zsh-theme
ln -s /Users/nathanmalishev/Coding/dotfiles/geoffgarside.zsh-theme /Users/nathanmalishev/.oh-my-zsh/themes/geoffgarside.zsh-theme


## tmux conf
rm ~/.tmux.conf
ln -s /Users/nathanmalishev/Coding/dotfiles/.tmux.conf /Users/nathanmalishev/.tmux.conf

## alacritty
rm ~/.config/alacritty/alacritty.yml
ln -s /Users/nathanmalishev/Coding/dotfiles/alacritty.yml /Users/nathanmalishev/.config/alacritty/alacritty.yml

## nvim
rm ~/.config/nvim/init.vim
ln -s /Users/nathanmalisev/Coding/dotfiles/init.vim /Users/nathanmalishev/.config/nvim/init.vim

## tmux script
cp ./tm /usr/local/bin/tm
