if [ ! "$(rustup)" ]; then
  header1 "Installing rust toolchains"

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  # Patch cargo for fish shell, maybe one day the'd fix the issue
  # https://forum.garudalinux.org/t/getting-rust-related-error-in-fish-konsole/10373
  echo 'set --export PATH $HOME/.cargo/bin $PATH' > $HOME/.cargo/env
else
  header1 "Updating rust toolchains"

  rustup update
fi

[ ! -d $HOME/.config/fish/completions ] && mkdir $HOME/.config/fish/completions

if [ ! -f $HOME/.config/fish/completions/rustup.fish ]; then
  rustup completions fish > $HOME/.config/fish/completions/rustup.fish
fi
