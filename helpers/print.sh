header1() {
    print -P "%F{111}$1%f"
}

header2() {
    print -P "\n%F{105}$1%f"
}

success() {
    print -P "  ✔️  %f$1"
}