# Homelab Docker Services

Docker Compose configurations used on my Ubuntu Server in my Proxmox homelab.

## Current Services

- Portainer
- Nginx Proxy Manager
- Gitea

## Architecture

- Proxmox provides virtualization
- pfSense provides routing, firewalling, DHCP, and DNS
- Ubuntu Server hosts Docker
- Nginx Proxy Manager provides reverse-proxy access
- Gitea provides internal Git repository hosting

## Security Notes

- Secrets and passwords are not stored in this repository
- Persistent application data is stored in Docker volumes
- Sensitive pfSense configuration backups are stored separately
