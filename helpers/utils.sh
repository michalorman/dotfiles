symlink() {
    ln -sfn $1 $2

    print -P "  ✔️  created symlink %F{15}$2%f -> %F{15}$1%f"
}