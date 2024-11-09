#!/usr/bin/env bash

remote_config=https://raw.githubusercontent.com/kclymans/gg-server-configs/refs/heads/main/valheim/valheim.env
local_config="$HOME/valheim-plus-server/valheim.env"
source "$HOME/.secrets"

# Define variables to check
vars=("SERVER_PASS" "DISCORD_WEBHOOK" "ADMINLIST_IDS")

# Loop through each variable to check if it is set and non-empty
for var in "${vars[@]}"; do
    if [[ ! -v $var ]]; then
        echo "$var is not set"
        exit 0
    elif [[ -z "${!var}" ]]; then
        echo "$var is set to the empty string"
        exit 0
    else
        echo "$var FOUND: ${!var}"
    fi
done

# Download the remote config and update placeholders in one sed command
curl -s -o "$local_config" "$remote_config" && \
sed -i -e "s/adminlist_ids/$ADMINLIST_IDS/g; s/server_pass/$SERVER_PASS/g; s|discordwebhook_url|${DISCORD_WEBHOOK}|g" "$local_config"
