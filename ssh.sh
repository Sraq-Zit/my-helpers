# ~/.oualil/ssh.sh

ssh-user-add() {
    local name=""
    local server=""
    local username=""
    local port="22"

    # Prompt for missing arguments
    if [[ -z "$1" ]]; then
        echo -e "\n\033[1mEnter a name for the SSH user configuration:\033[0m"
        read -r name
    else
        name="$1"
    fi

    # Check if the name already exists in the SSH config
    if grep -q "^Host $name$" ~/.ssh/config; then
        echo -e "\n\033[1;31mSSH user configuration with the name '$name' already exists:\033[0m"
        grep -A4 "^Host $name$" ~/.ssh/config
        return
    fi

    if [[ -z "$2" ]]; then
        echo -e "\n\033[1mEnter the server address:\033[0m"
        read -r server
    else
        server="$2"
    fi

    if [[ -z "$3" ]]; then
        echo -e "\n\033[1mEnter the username:\033[0m"
        read -r username
    else
        username="$3"
    fi

    if [[ -z "$2" ]]; then
        echo -e "\n\033[1mEnter the port (default 22):\033[0m"
        read -r port
        port=${port:-22}
    else
        port="$4"
    fi

    # Check if there is already a session with the same configuration
    if grep -q "HostName $server" ~/.ssh/config && grep -q "User $username" ~/.ssh/config && grep -q "Port $port" ~/.ssh/config; then
        echo -e "\n\033[1;31mA session with the same configuration already exists:\033[0m"
        grep -A4 "HostName $server" ~/.ssh/config | grep -A3 "User $username" | grep -A2 "Port $port"
        return
    fi

    # Add the SSH user configuration to the SSH config file
    config_lines="\nHost $name\n\
    \tHostName $server\n\
    \tUser $username\n\
    \tPort $port\n\
    \tIdentityFile ~/.ssh/id_rsa\n"

    echo -e "\n\033[1;32mSSH user configuration for '$name' has been added to ~/.ssh/config:\033[0m"
    echo -e "\033[1mAdded configuration lines:\033[0m"
    echo -e "$config_lines"

    echo -e "$config_lines" >> ~/.ssh/config

}

# Other custom configurations...
