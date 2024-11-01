#!/bin/bash

lint() {
    flatpak run --command=flatpak-builder-lint org.flatpak.Builder --exceptions manifest com.neoutils.NeoRegex.yml
}

build() {
    flatpak run --filesystem=host org.flatpak.Builder --force-clean --sandbox --user --repo=repo build-dir com.neoutils.NeoRegex.yml
}

install() {
    flatpak run --filesystem=host org.flatpak.Builder --force-clean --sandbox --user build-dir --user --install com.neoutils.NeoRegex.yml
}

uninstall() {
    flatpak --user uninstall com.neoutils.NeoRegex
}

create_flatpak() {
    build
    mkdir -p distribution
    flatpak build-bundle repo distribution/com.neoutils.NeoRegex.flatpak com.neoutils.NeoRegex
}

run() {
    flatpak run com.neoutils.NeoRegex
}

if [ $# -gt 0 ]; then
    case $1 in
        lint) lint ;;
        build) build ;;
        install) install ;;
        uninstall) uninstall ;;
        create-flatpak) create_flatpak ;;
        run) run ;;
        *) echo "Invalid option" ;;
    esac
    exit 0
fi

echo "Choose an option:"
echo "1) Lint"
echo "2) Build"
echo "3) Install"
echo "4) Uninstall"
echo "5) Create Flatpak"
echo "6) Run"
read -p "Option: " option

case $option in
    1) lint ;;
    2) build ;;
    3) install ;;
    4) uninstall ;;
    5) create_flatpak ;;
    6) run ;;
    *) echo "Invalid option" ;;
esac