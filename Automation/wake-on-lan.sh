#!/usr/bin/env bash
set -euo pipefail

readonly CONFIG_FILE="/etc/wake-on-lan/devices.conf"

fail() { echo "Error: $*" >&2; exit 1; }

[[ $# -eq 1 ]] || fail "Usage: $0 <device-name>"
device_name="$1"

[[ "$device_name" =~ ^[a-zA-Z0-9_-]+$ ]] || \
    fail "Device names may contain only letters, numbers, underscores, and hyphens."
command -v wakeonlan >/dev/null 2>&1 || \
    fail "wakeonlan is not installed. Install it with: apt install wakeonlan"
[[ -f "$CONFIG_FILE" && ! -L "$CONFIG_FILE" ]] || \
    fail "Protected configuration file not found: $CONFIG_FILE"

owner="$(stat -c '%U' "$CONFIG_FILE")"
permissions="$(stat -c '%a' "$CONFIG_FILE")"
[[ "$owner" == "root" ]] || fail "$CONFIG_FILE must be owned by root."
(( (8#$permissions & 022) == 0 )) || \
    fail "$CONFIG_FILE must not be writable by group or other users. Use chmod 600."

mac_address=""
broadcast_address=""
while IFS='|' read -r configured_name configured_mac configured_broadcast remainder; do
    [[ -z "$configured_name" || "$configured_name" == \#* ]] && continue
    [[ -z "${remainder:-}" ]] || fail "Invalid configuration entry for $configured_name."
    if [[ "$configured_name" == "$device_name" ]]; then
        mac_address="$configured_mac"
        broadcast_address="$configured_broadcast"
        break
    fi
done < "$CONFIG_FILE"

[[ -n "$mac_address" ]] || fail "Device '$device_name' is not approved."
[[ "$mac_address" =~ ^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$ ]] || \
    fail "The configured MAC address is invalid."
[[ "$broadcast_address" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || \
    fail "The configured broadcast address is invalid."

IFS='.' read -r o1 o2 o3 o4 <<< "$broadcast_address"
for octet in "$o1" "$o2" "$o3" "$o4"; do
    (( 10#$octet >= 0 && 10#$octet <= 255 )) || fail "Invalid broadcast address."
done

logger -t wake-on-lan "Authorized wake request for '$device_name' by '${SUDO_USER:-$USER}'"
wakeonlan -i "$broadcast_address" "$mac_address"
echo "Wake request sent to '$device_name'."
