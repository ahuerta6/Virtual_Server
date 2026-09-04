# Automation

This folder contains automation tools for the Proxmox homelab. Public files contain no real MAC addresses, public IP addresses, credentials, or device inventory.

## Wake-on-LAN Tool

`wake-on-lan.sh` sends a Wake-on-LAN packet to an approved physical computer. It accepts a device name instead of a MAC address, keeping real device information out of shell history and GitHub.

### Security Design

- Real device details stay in `/etc/wake-on-lan/devices.conf` on Proxmox
- Only devices listed in that protected file can receive a wake request
- MAC and broadcast addresses are validated
- The configuration must be owned by `root` and protected from other writers
- Wake requests are recorded in the system log
- User input is quoted and restricted to safe characters
- Secrets, keys, public IPs, and real device identifiers are excluded from Git

Wake-on-LAN does not authenticate or encrypt magic packets. Limit it to the trusted local network and reach Proxmox remotely through WireGuard. Never expose it directly to the internet.

### Installation

```bash
apt update
apt install wakeonlan
install -o root -g root -m 0755 wake-on-lan.sh /usr/local/sbin/wake-device
install -d -o root -g root -m 0700 /etc/wake-on-lan
```

Create `/etc/wake-on-lan/devices.conf` directly on Proxmox. Never place the real file in the repository:

```text
# device-name|MAC-address|broadcast-address
desktop|AA:BB:CC:DD:EE:FF|192.0.2.255
```

Replace the example values locally and protect the file:

```bash
chown root:root /etc/wake-on-lan/devices.conf
chmod 600 /etc/wake-on-lan/devices.conf
```

### Usage

```bash
sudo wake-device desktop
```

Do not put the real MAC address on the command line.

### Verification

```bash
journalctl -t wake-on-lan --since today
```

## Testing Checklist

- Confirm Wake-on-LAN is enabled in the target BIOS/UEFI and wired adapter
- Shut down the target while leaving power and Ethernet connected
- Run the tool through a trusted Proxmox or WireGuard session
- Confirm the correct approved computer turns on
- Review the system log entry
- Confirm an unknown device name is rejected
- Record results without publishing real identifiers

## Future Process Report

1. What problem was I trying to solve?
2. Why did I choose Proxmox to send the wake request?
3. What is a Wake-on-LAN magic packet?
4. Why did I separate public code from private configuration?
5. How did I build and test the tool?
6. What problems occurred, and how did I troubleshoot them?
7. What security limits did I put in place?
8. What would I improve or automate next?
