brew install nvim
# git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
time="`date +%Y%m%d%H%M%S`"
mv ~/.config/nvim ~/.config/nvim_$time
mv ~/.local/share/nvim ~/.local/share/nvim_$time
cp -r ./nvim/config ~/.config/nvim
cp -r ./nvim/local/nvim ~/.local/share/nvim
