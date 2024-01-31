#!/bin/usr/bash

<<com
- I just made this script to debloat fedora gnome because i don't some stock gnome apps
   that fedora comes with.
- The script can be easily modified to suit your needs and distro of choice.
- Comments will show where to edit incase you need to change anything
com

# Root?
if [[ $EUID -ne 0]]; then
    echo "Please run this as root i.e 'sudo ./debloatFedora.sh'"
    exit 1
fi

# Edit line below to modify the apps to be removed by this script
packages("gnome-maps" "abrt-applet" "gnome-connections" "gnome-contacts" "gnome-clocks" "totem" "gnome-boxes" "gnome-software")

remove_package() {
    package_name = $1
    echo "Removing: $package_name...."
    dnf remove $package_name -y

    if [ $? -eq 0 ]; then
        echo "$package_name has been removed succesfully."
    else
        echo "Failed to remove $package_name."
    fi
}

for package in "${packages[@]}"; do
    # Check if package is installed
    if rpm -q $package &>/dev/null; then
        remove_package $package
    else
        echo "$package is not installed."
    fi
done

exit 0