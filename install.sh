#!/bin/bash

go(){
  # install curl, git, ...
    apt-get update
    apt-get install -y curl git jq

    useradd -m user
    su user

    # install go
    VERSION='1.14'
    OS='linux'
    ARCH='amd64'

    curl -OL https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz
    tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
    rm go$VERSION.$OS-$ARCH.tar.gz

    INSTALLED_GO_VERSION=$(go version)
    echo "Go version ${INSTALLED_GO_VERSION} is installed"

    # install gopls, dlv, hey
    echo "Getting development tools"
    go get -u golang.org/x/tools/gopls
    go get -u github.com/go-delve/delve/cmd/dlv
    go get -u github.com/rakyll/hey

    # vscode-go dependencies
    echo "Getting dependencies for the vscode-go plugin "
    # via: https://github.com/microsoft/vscode-go/blob/master/.travis.yml
    go get -u -v github.com/acroca/go-symbols
    go get -u -v github.com/cweill/gotests/...
    go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
    go get -u -v github.com/haya14busa/goplay/cmd/goplay
    go get -u -v github.com/mdempsky/gocode
    go get -u -v github.com/ramya-rao-a/go-outline
    go get -u -v github.com/rogpeppe/godef
    go get -u -v github.com/sqs/goreturns
    go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
    go get -u -v github.com/zmb3/gogetdoc
    go get -u -v golang.org/x/lint/golint
    go get -u -v golang.org/x/tools/cmd/gorename
}

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "                 cloning zsh-zsh-nvm                       "
    echo "-----------------------------------------------------------"
    git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
    echo "==========================================================="
    echo "                  Import zshrc                             "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc
}

lazygit() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    mkdir -p ~/bin
    cd ~/bin
    git clone https://github.com/jesseduffield/lazygit.git
    cd lazygit
    go install

    echo "==========================================================="
    echo "                  Import zshrc                             "
    echo "-----------------------------------------------------------"
    echo "alias lg='lazygit'" >> ~/.zshrc
}

go
zshrc
lazygit