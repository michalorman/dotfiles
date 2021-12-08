# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

header() {
    printf "
  ${Cyan}$1${Color_Off}
----------------------------------------
\n"
}

footer() {
    printf "
----------------------------------------
  🍺 ${Cyan}$1${Color_Off}
\n"
}

header1() {
    printf "

  ✨ ${White}$1${Color_Off}
----------------------------------------
\n"
}

header2() {
    printf "${White}$1${Color_Off}\n"
}

success() {
	printf "${Green}$1${Color_Off}\n"
}

symlink() {
    ln -sfn $1 $2

    success "created symlink $2 -> $1"
}
