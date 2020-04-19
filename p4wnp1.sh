#!/bin/bash
# P4wnP1 Connect for Linux
# edited by vay3t

bbver=1
sp4wnp1nmask=255.255.255.252
sp4wnp1net=172.16.0.0/30
sp4wnp1lan=usb1
sp4wnp1wan=wlan0
sp4wnp1gw=192.168.100.1
sp4wnp1hostip=172.16.0.2
sp4wnp1ip=172.16.0.1
sfirsttime=0
sp4wnp1mac="42:63:66"

if [ "$EUID" -ne 0 ]
    then echo "This P4wnP1 Connection script requires root."
    sudo su -s "$0"
    exit
fi

function banner {
    # Show random banner because 1337
    b=$(( ( RANDOM % 5 ) + 1 ))
    case "$b" in
        1)
        echo $(tput setaf 3)
    echo '     __________  _____              __________  ____ ';
    echo '     \______   \/  |  |__  _  ______\______   \/_   |';
    echo '      |     ___/   |  |\ \/ \/ /    \|     ___/ |   |';
    echo '      |    |  /    ^   /\     /   |  \    |     |   |';
    echo '      |____|  \____   |  \/\_/|___|  /____|     |___|';
    echo '                   |__|            \/                ';
	echo " P4wnP1 Connect edited by vay3t // USB Attack Platform  ";
        echo "$(tput sgr0) v$bbver";
        ;;
        2)
        echo $(tput setaf 3)
    echo '     __________  _____              __________  ____ ';
    echo '     \______   \/  |  |__  _  ______\______   \/_   |';
    echo '      |     ___/   |  |\ \/ \/ /    \|     ___/ |   |';
    echo '      |    |  /    ^   /\     /   |  \    |     |   |';
    echo '      |____|  \____   |  \/\_/|___|  /____|     |___|';
    echo '                   |__|            \/                ';
    echo " P4wnP1 Connect edited by vay3t // USB Attack Platform  ";
        echo "$(tput sgr0) v$bbver";
        ;;
        3)
        echo $(tput setaf 3)
    echo '     __________  _____              __________  ____ ';
    echo '     \______   \/  |  |__  _  ______\______   \/_   |';
    echo '      |     ___/   |  |\ \/ \/ /    \|     ___/ |   |';
    echo '      |    |  /    ^   /\     /   |  \    |     |   |';
    echo '      |____|  \____   |  \/\_/|___|  /____|     |___|';
    echo '                   |__|            \/                ';
    echo " P4wnP1 Connect edited by vay3t // USB Attack Platform  ";
        echo "$(tput sgr0) v$bbver";
        ;;
        4)
        echo $(tput setaf 3)
    echo '     __________  _____              __________  ____ ';
    echo '     \______   \/  |  |__  _  ______\______   \/_   |';
    echo '      |     ___/   |  |\ \/ \/ /    \|     ___/ |   |';
    echo '      |    |  /    ^   /\     /   |  \    |     |   |';
    echo '      |____|  \____   |  \/\_/|___|  /____|     |___|';
    echo '                   |__|            \/                ';
    echo " P4wnP1 Connect edited by vay3t // USB Attack Platform  ";
        echo "$(tput sgr0) v$bbver";
        ;;
        5)
        echo $(tput setaf 3)
    echo '     __________  _____              __________  ____ ';
    echo '     \______   \/  |  |__  _  ______\______   \/_   |';
    echo '      |     ___/   |  |\ \/ \/ /    \|     ___/ |   |';
    echo '      |    |  /    ^   /\     /   |  \    |     |   |';
    echo '      |____|  \____   |  \/\_/|___|  /____|     |___|';
    echo '                   |__|            \/                ';
    echo " P4wnP1 Connect edited by vay3t // USB Attack Platform  ";
        echo "$(tput sgr0) v$bbver";
        ;;
    esac
}

function showsettings {
    printf "\n\
    $(tput bold)Saved Settings$(tput sgr0): Share Internet connection from $sp4wnp1wan\n\
    to P4wnP1 at $sp4wnp1lan through default gateway $sp4wnp1gw\n"
}

function menu {
    printf "\n\
    [$(tput bold)C$(tput sgr0)]onnect using saved settings\n\
    [$(tput bold)G$(tput sgr0)]uided setup (recommended)\n\
    [$(tput bold)M$(tput sgr0)]anual setup\n\
    [$(tput bold)A$(tput sgr0)]dvanced IP settings\n\
    [$(tput bold)Q$(tput sgr0)]uit\n\n    "
    read -r -sn1 key
    case "$key" in
            [gG]) guidedsetup;;
            [mM]) manualsetup;;
            [cC]) connectsaved;;
            [aA]) advancedsetup;;
            [bB]) p4wnp1;;
            [qQ]) printf "\n"; exit;;
    esac
}

function manualsetup {
    ipinstalled=$(which ip)
    if [[ "$?" == 0 ]]; then
        ifaces=($(ip link show | grep -v link | awk {'print $2'} | sed 's/://g' | grep -v lo))
        printf "\n    Select P4wnP1 Interface:\n"
        for i in "${!ifaces[@]}"; do
            printf "    [$(tput bold)%s$(tput sgr0)]\t%s\t" "$i" "${ifaces[$i]}"
            printf "$(ip -4 addr show ${ifaces[$i]} | grep inet | awk {'print $2'} | head -1)\n"
        done
        read -r -p "    > " planq
        if [ "$planq" -eq "$planq" ] 2>/dev/null; then
            sp4wnp1lan=(${ifaces[planq]})
        else
            printf "\n    Response must be a listed numeric option\n"; manualsetup
        fi
        printf "\n    Select Internet Interface:\n"
        for i in "${!ifaces[@]}"; do
            printf "    [$(tput bold)%s$(tput sgr0)]\t%s\t" "$i" "${ifaces[$i]}"
            printf "$(ip -4 addr show ${ifaces[$i]} | grep inet | awk {'print $2'} | head -1)\n"
        done
        read -r -p "    > " inetq
        if [ "$inetq" -eq "$inetq" ] 2>/dev/null; then
            sp4wnp1wan=(${ifaces[inetq]})
        else
            printf "\n    Response must be a listed numeric option\n"; manualsetup
        fi
        printf "\n$(netstat -nr)\n\n"
        read -r -p "    Specify Default Gateway IP Address: " sp4wnp1gw
        savechanges
    else
        printf "\n\n    Configuration requires the 'iproute2' package (aka the 'ip' command).\n    Please install 'iproute2' to continue.\n"
        menu
    fi
}

function guidedsetup {
    p4wnp1detected=$(ip addr | grep $sp4wnp1mac -B1 | awk {'print $2'} | head -1 | grep 'usb\|en')
    if [[ "$?" == 0 ]]; then
        printf "\n    P4wnP1 detected. Please disconnect the P4wnP1 from\n    this computer and $(tput bold)press any key$(tput sgr0) to continue with guided setup.\n    "
        read -r -sn1 anykey
        guidedsetup
    fi
    hasiproute2=$(which ip)
    if [[ "$?" == 1 ]]; then
        printf "\n\n    Configuration requires the 'iproute2' package (aka the 'ip' command).\n    Please install 'iproute2' to continue.\n"; menu
    fi
    hasdefaultroute=$(ip route)
    if [[ "$?" == 1 ]]; then
        printf "\n    No route detected. Check connection and try again.\n"; menu
    fi

    printf "\n    $(tput setaf 3)Step 1 of 3: Select Default Gateway$(tput sgr0)\n\
    Default gateway reported as $(tput bold)$(ip route | grep default | awk {'print $3'} | head -1)$(tput sgr0)\n"
    read -r -p "    Use the above reported default gateway?             [Y/n]? " usedgw
    case $usedgw in
        [yY][eE][sS]|[yY]|'')
        sp4wnp1gw=($(ip route | grep default | awk {'print $3'}))
        ;;
        [nN][oO]|[nN])
        printf "\n$(ip route)\n\n"
        read -r -p "    Specify the default gateway by IP address: " sp4wnp1gw
        ;;
    esac

    printf "\n    $(tput setaf 3)Step 2 of 3: Select Internet Interface$(tput sgr0)\n\
    Internet interface reported as $(tput bold)$(ip route | grep default | awk {'print $5'} | head -1)$(tput sgr0)\n"
    read -r -p "    Use the above reported Internet interface?          [Y/n]? " useii
    case $useii in
        [yY][eE][sS]|[yY]|'')
            sp4wnp1wan=($(ip route | grep default | awk {'print $5'}))
        ;;
        [nN][oO]|[nN])
            printf "\n    Available Network Interfaces:\n"
            ifaces=($(ip link show | grep -v link | awk {'print $2'} | sed 's/://g' | grep -v lo))
            for i in "${!ifaces[@]}"; do
                printf "    \t%s\t" "${ifaces[$i]}"
                printf "$(ip -4 addr show ${ifaces[$i]} | grep inet | awk {'print $2'} | head -1)\n"
            done
            read -r -p "    Specify the internet interface by name: " sp4wnp1wan
        ;;
    esac

    printf "\n    $(tput setaf 3)Step 3 of 3: Select P4wnP1 Interface$(tput sgr0)\n    Please connect the P4wnP1 to this computer.\n    "

    a="0"
    until p4wnp1iface=$(ip addr | grep $sp4wnp1mac -B1 | awk {'print $2'} | head -1 | grep 'usb\|en')
    do
        printf "."
        sleep 1
        a=$[$a+1]
        if [[ $a == "51" ]]; then
            printf "\n    "
            a=0
        fi
    done
    printf "[Checking]"
    sleep 5 # Wait as the system is likely to rename interface. Sleeping rather than more advanced error handling becasue reasons.
    p4wnp1iface=$(ip addr | grep $sp4wnp1mac -B1 | awk {'print $2'} | head -1 | grep 'usb\|en' | sed 's/://g')
    printf "\n    Detected P4wnP1 on interface $(tput bold)$p4wnp1iface$(tput sgr0)\n";
    read -r -p "    Use the above detected P4wnP1 interface?    [Y/n]? " pi
    case $pi in
        [yY][eE][sS]|[yY]|'')
            sp4wnp1lan=$p4wnp1iface
        ;;
        [nN][oO]|[nN])
            printf "\n    Available Network Interfaces:\n"
            ifaces=($(ip link show | grep -v link | awk {'print $2'} | sed 's/://g' | grep -v lo))
            for i in "${!ifaces[@]}"; do
                printf "    \t%s\t" "${ifaces[$i]}"
                printf "$(ip -4 addr show ${ifaces[$i]} | grep inet | awk {'print $2'} | head -1)\n"
            done
            read -r -p "    Specify the P4wnP1 interface by name: " sp4wnp1lan
        ;;
    esac
    savechanges
}

function advancedsetup {
    printf "\n\
    By default the P4wnP1 resides on the $(tput bold)172.16.0.0/30$(tput sgr0) network\n\
    with the IP Address $(tput bold)172.16.0.1$(tput sgr0) and Ethernet default route $(tput bold)172.16.0.2$(tput sgr0).\n\n\
    The P4wnP1 expects an Internet connection from 172.16.0.2 by\n\
    default, which this script aids in configuring. These IP addresses may\n\
    be changed if desired by modifying network configs on the P4wnP1.\n\n"
    read -r -p "    Continue with advanced IP config [y/N]? " qcontinue
    case $qcontinue in
        [nN][oO]|[nN]|'') menu ;;
        [yY][eE][sS]|[yY])
            read -r -p "    P4wnP1 Network               [172.16.42.0/24]: " sp4wnp1net
            if [[ $sp4wnp1net == '' ]]; then 
            sp4wnp1net=172.16.0.0/30 # P4wnP1 network. Default is 172.16.0.0/30
            fi
            read -r -p "    P4wnP1 Netmask               [255.255.255.252]: " sp4wnp1nmask
            if [[ $sp4wnp1nmask == '' ]]; then 
            sp4wnp1nmask=255.255.255.252 #Default netmask for /24 network
            fi
            read -r -p "    Host IP Address                  [172.16.42.42]: " sp4wnp1hostip
            if [[ $sp4wnp1hostip == '' ]]; then 
            sp4wnp1hostip=172.16.0.2 #IP Address of host computer
            fi
            read -r -p "    P4wnP1 IP Address            [172.16.42.1]: " sp4wnp1ip
            if [[ $sp4wnp1ip == '' ]]; then 
            sp4wnp1ip=172.16.0.1 #If this seems familiar it's becuase I'm just recycling wp6.sh from the WiFi Pineapple 
            fi
            printf "\n    Advanced IP settings will be saved for future sessions.\n    Default settings may be restored by selecting Advanced IP settings and\n    pressing [ENTER] when prompted for IP settings.\n\n    Press any key to continue"
            savechanges
        ;;
    esac
}

function savechanges {
    sed -i "s/^sp4wnp1nmask.*/sp4wnp1nmask=$sp4wnp1nmask/" $0
    sed -i "s&^sp4wnp1net.*&sp4wnp1net=$sp4wnp1net&" $0
    sed -i "s/^sp4wnp1lan.*/sp4wnp1lan=$sp4wnp1lan/" $0
    sed -i "s/^sp4wnp1wan.*/sp4wnp1wan=$sp4wnp1wan/" $0
    sed -i "s/^sp4wnp1gw.*/sp4wnp1gw=$sp4wnp1gw/" $0
    sed -i "s/^sp4wnp1hostip.*/sp4wnp1hostip=$sp4wnp1hostip/" $0
    sed -i "s/^sp4wnp1ip.*/sp4wnp1ip=$sp4wnp1ip/" $0
    sed -i "s/^sfirsttime.*/sfirsttime=0/" $0
    sfirsttime=0
    printf "\n    Settings saved.\n"
    showsettings
    menu
}

function connectsaved {
    if [[ "$sfirsttime" == "1" ]]; then
        printf "\n    Error: Settings unsaved. Run either Guided or Manual setup first.\n"; menu
    fi
    ifconfig $sp4wnp1lan $sp4wnp1hostip netmask $sp4wnp1nmask up #Bring up Ethernet Interface directly connected to P4wnP1
    printf "Detecting P4wnP1..."
    until ping $sp4wnp1ip -c1 -w1 >/dev/null
    do
        printf "."
        ifconfig $sp4wnp1lan $sp4wnp1hostip netmask $sp4wnp1nmask up &>/dev/null
        sleep 1
    done
    printf "...found.\n\n"
    printf "    $(tput setaf 6)     _ .   $(tput sgr0)        $(tput setaf 7)___$(tput sgr0)         $(tput setaf 3)(\___/)$(tput sgr0)\n"
    printf "    $(tput setaf 6)   (  _ )_ $(tput sgr0) $(tput setaf 2)<-->$(tput sgr0)  $(tput setaf 7)[___]$(tput sgr0)  $(tput setaf 2)<-->$(tput sgr0)  $(tput setaf 3)(='.'=)$(tput sgr0)\n"
    printf "    $(tput setaf 6) (_  _(_ ,)$(tput sgr0)       $(tput setaf 7)\___\\$(tput sgr0)        $(tput setaf 3)(\")_(\")$(tput sgr0)\n"
    echo ""
    echo "      ssh pi@"$sp4wnp1ip
    ifconfig $sp4wnp1lan $sp4wnp1hostip netmask $sp4wnp1nmask up #Bring up Ethernet Interface directly connected to Pineapple
    echo '1' > /proc/sys/net/ipv4/ip_forward # Enable IP Forwarding
    iptables -X #clear chains and rules
    iptables -F
    iptables -A FORWARD -i $sp4wnp1wan -o $sp4wnp1lan -s $sp4wnp1net -m state --state NEW -j ACCEPT #setup IP forwarding
    iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
    iptables -A POSTROUTING -t nat -j MASQUERADE
    route del default #remove default route
    route add default gw $sp4wnp1gw $sp4wnp1wan #add default gateway
    printf "\n\n"
    exit
}

function p4wnp1 {
    printf "\nNetmask $sp4wnp1nmask\nP4wnP1 Net $sp4wnp1net\nP4wnP1 LAN $sp4wnp1lan\nP4wnP1 WAN $sp4wnp1wan\nP4wnP1 GW $sp4wnp1gw\nP4wnP1 IP $sp4wnp1ip\nHost IP $sp4wnp1hostip\n"
    printf "\n/)___(\ \n(='.'=)\n(\")_(\")\n"
    exit
}

banner #remove for less 1337
showsettings
if [[ "$sfirsttime" == "1" ]]; then
    printf "
    Since this is the first time running the P4wnP1 Internet Connection Sharing\n\
    script, Guided setup is recommended to save initial configuration.\n\
    Subsequent sessions may be quickly connected using saved settings.\n"
fi
menu
