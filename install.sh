#!/usr/bin/env zsh

source helpers/print.sh
source helpers/utils.sh

header1 "Configuring Mac..."

source install/brew.sh
source install/zsh.sh
source install/git.sh

header1 "\n👍🏻 Mac is ready!"