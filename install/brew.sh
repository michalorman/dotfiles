header2 "Configuring homebrew:"

if ! which brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

success "homebrew installed"

brew update
brew upgrade
brew upgrade --casks

success "homebrew updated"

brew bundle --file=./brew/Brewfile

success "homebrew packages installed"

header2 "🍺 homebrew configuration done."
