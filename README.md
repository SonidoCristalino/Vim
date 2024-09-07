
# Information about this repository

This repository is about config files for [vim](https://www.vim.org/) text editor.

## How can you use this config files?

1. Please, first install [Vim](https://www.vim.org/)
2. **IMPORTANT:** clone this repository into your `$HOME` and after that change the dir name from
   `Vim` to `.vim`. 
3. The final path to assume the new configuration must be `$HOME/.vim`, because from this directory vim will
   take all the config. 
4. If you already have your file configuration like `$HOME/.vimrc` please, change it name, just
   like `vimrc_bkp`.
5. Enjoy it!

## Clipboard problems

There is an issue with the Vim binaries found in some distributions, such as Ubuntu, which are very basic and,
therefore, lack certain features, such as clipboard support. If we have installed the Vim program using `sudo
apt-get install vim`, we will see that when checking whether the shared buffer with the system clipboard is
enabled by running `vim --version | grep -i clipboard`, it will show that it is not installed.

To solve this problem on Ubuntu, we can install the package that includes this feature (and many others as
well) as follows: `sudo apt-get install vim-gtk3`

Again, we can check the clipboard feature using `vim --version | grep -i clipboard`.
