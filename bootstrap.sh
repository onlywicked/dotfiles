#!/bin/bash

set -eu

###############################################################################
#                                                                             #
# Note: Currently, only works on Ubuntu                                       #
#                                                                             #
###############################################################################

export DEBIAN_FRONTEND=noninteractive

UPGRADE_PACKAGES=${1:-none}
if [ "${UPGRADE_PACKAGES}" != "none" ]; then
	echo "==> Upgrading packages"

	# add third party repositories
	sudo add-apt-repository ppa:apt-fast/stable -y

	sudo apt-get update
	sudo apt-get upgrade -y
fi

# use apt-get while installing packages in apt-fast
_APTMGR=apt-get
export _APTMGR

# install apt-fast for faster downloads
if ! [ "$(command -v apt-fast)" ]; then
	echo "==> Installing apt-fast"
	sudo apt-get install -qq apt-fast -y
fi

# install packages
sudo apt-fast install -qq -y \
	bison \
	build-essential \
	ca-certificates \
	clang \
	cmake \
	curl \
	git \
	htop \
	make \
	mosh \
	neovim \
	p7zip-full \
	p7zip-rar \
	pkg-config \
	ripgrep \
	software-properties-common \
	sqlite3 \
	tig \
	tmux \
	tree \
	unzip \
	wget \
	zip


if ! [ "$(command -v n)" ]; then
	echo "==> Installing n"
	curl -sSL -o n-install https://git.io/n-install
	chmod +x n-install
	./n-install -y
	rm -rf n-install
fi

if ! [ "$(command -v gvm)" ]; then
	echo "==> Installing gvm"

	# installing gvm dependency
	sudo apt-fast install -qq -y bison

	# download the latest version of gvm
	curl -s -S -L -o gvm-installer https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer
	chmod +x gvm-installer
	./gvm-installer
	rm -f ./gvm-installer
fi

if ! [ "$(command -v go)" ]; then
	source  ~/.gvm/scripts/gvm

	GOVERSION="1.14.2"
	echo "===> Installing go${GOVERSION}"
	gvm install go${GOVERSION} -B
fi

DOT_FILES="${HOME}/dotfiles"
if [ -d "${DOT_FILES}" ]; then
	pushd "${DOT_FILES}"

	echo "===> Symlinking dot files"
	# symlink dotfiles
	ln -sfn $(pwd)/.vimrc ~/.vimrc
	ln -sfn $(pwd)/.profile ~/.profile
	ln -sfn $(pwd)/.tmux.conf ~/.tmux.conf
	ln -sfn $(pwd)/.bash_aliases ~/.bash_aliases

	# symlink vimrc for neovim
	mkdir -p ~/.config/nvim
	ln -sfn $(pwd)/.vimrc ~/.config/nvim/init.vim

	popd
fi

if ! [ "$(command -v nix-env)" ]; then
	echo "=> Installing nix package manager"
	curl -sSL -o nix-install https://nixos.org/nix/install
	sh ./nix-install
	rm -rf ./nix-install
fi

NVIM=$(which nvim)
if [ "$(command -v nvim)" ]; then
	echo "==> seting neovim as default editor"
	sudo update-alternatives --install /usr/bin/vi vi ${NVIM} 60
	# sudo update-alternatives --config vi
	sudo update-alternatives --install /usr/bin/vim vim ${NVIM} 60
	# sudo update-alternatives --config vim
	sudo update-alternatives --install /usr/bin/editor editor ${NVIM} 60
	# sudo update-alternatives --config editor
fi

VIM_PLUG="${HOME}/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f "${VIM_PLUG}" ] ; then
	echo "===> Installing vim-plug"
	curl -fLo ${VIM_PLUG} --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if ! [ "$(command -v lf)" ]; then
	echo "==> Intalling lf"
	go get -u github.com/gokcehan/lf
fi

if ! [ "$(command -v exa)" ]; then
	echo "===> Installing exa"
	nix-env -i exa
fi

echo ""
echo "================ Done =================="
