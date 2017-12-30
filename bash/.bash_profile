__source_iff() {
    while (($#)); do
        if [ -r "$1" ]; then
            source "$1"
        fi
        shift
    done
}

__source_iff ~/.profile
__source_iff ~/.bashrc
