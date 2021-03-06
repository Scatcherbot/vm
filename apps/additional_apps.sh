#!/bin/bash

# T&M Hansson IT AB © - 2020, https://www.hanssonit.se/

# shellcheck disable=2034,2059
true
# shellcheck source=lib.sh
. <(curl -sL https://raw.githubusercontent.com/nextcloud/vm/master/lib.sh)

# Check for errors + debug code and abort if something isn't right
# 1 = ON
# 0 = OFF
DEBUG=0
debug_mode

# Must be root
root_check

# Install Apps
whiptail --title "Which apps do you want to install?" --checklist --separate-output "Automatically configure and install selected apps\nSelect by pressing the spacebar" "$WT_HEIGHT" "$WT_WIDTH" 4 \
"Fail2ban" "(Extra Bruteforce protection)   " OFF \
"Adminer" "(PostgreSQL GUI)       " OFF \
"Netdata" "(Real-time server monitoring)       " OFF \
"Collabora" "(Online editing [2GB RAM])   " OFF \
"OnlyOffice" "(Online editing [2GB RAM])   " OFF \
"Bitwarden" "(External password manager)   " OFF \
"FullTextSearch" "(Elasticsearch for Nextcloud [2GB RAM])   " OFF \
"PreviewGenerator" "(Pre-generate previews)   " OFF \
"LDAP" "(Windows Active directory)   " OFF \
"Talk" "(Nextcloud Video calls and chat)   " OFF \
"SMB-mount" "(Connect to SMB-shares from your local network)   " OFF 2>results

while read -r choice
do
    case "$choice" in
        "Fail2ban")
            clear
            run_app_script fail2ban
        ;;

        "Adminer")
            clear
            run_app_script adminer
        ;;

        "Netdata")
            clear
            run_app_script netdata
        ;;

        "OnlyOffice")
            clear
            run_app_script onlyoffice
        ;;

        "Collabora")
            clear
            run_app_script collabora
        ;;

        "Bitwarden")
            clear
            run_app_script tmbitwarden
        ;;

        "FullTextSearch")
            clear
           run_app_script fulltextsearch
        ;;

        "PreviewGenerator")
            clear
           run_app_script previewgenerator
        ;;

        "LDAP")
            clear
	    print_text_in_color "$ICyan" "Installing LDAP..."
            if install_and_enable_app user_ldap
	    then
	        msg_box "LDAP installed! Please visit https://subdomain.yourdomain.com/settings/admin/ldap to finish the setup once this script is done."
	    else msg_box "LDAP installation failed."
	    fi
        ;;

        "Talk")
            clear
            run_app_script talk
        ;;

        "SMB-mount")
            clear
            run_app_script smbmount
        ;;

        *)
        ;;
    esac
done < results
rm -f results
clear

exit
