# WireGuard VPN & Secure Remote Administration on Proxmox
## Project Overview
The goal of this project was to implement a secure remote administrative tool for my Proxmox homelab. I did this by using WireGuard VPN and SSH based authentication. This tool allows for a secure connection to Proxmox without exposing management systems to the internet.

<h3>Objective</h3>
  
- Implement WireGuard VPN within Proxmox 
- Enable secure remote access to the Proxmox web interface
- Configure SSH key authentication for root account on Proxmox
- Disable password-based SSH authentication

<h3>Network Architecture</h3>

| Devices | Address |
| --- | --- |
| Router | 10.0.0.1 |
| Proxmox | 10.0.0.44 |
| WireGuard Container| 10.0.0.121 |

<h3>VPN Network</h3>

| Devices | Address |
| --- | --- |
| WireGuard Server | 10.6.0.1 |
| Windows Client | 10.6.0.2 |

## Project Workflow
<h3>1. Configuring SSH Connection</h3>

- Generated SSH key pair on Windows

Example: 
```bash
ssh-keygen -t ed25519
```

- Copy newly generated public key to ssh authorized keys

Example: 
```bash
/root/.ssh/authorized_keys
```

<h4>Configure SSH:</h4>

```bash
PermitRootLogin prohibit-password
PubkeyAuthentication yes
```
<h3>Summary</h3>
When starting this project I wanted to ensure that ssh connection was working properly, to do this I needed to generate key pairs using the ssh keygen tool. Using this tool generates a public key, and private key file. These key pairs are important because they allow for devices to authenticate eachother if they have the same key pair. Thats why it is important to paste the public key to the authorized key file in the desired device you are trying to connect to. For best security practices I configured ssh to not allow password authentication. This ensures that anyone that is trying to ssh into the device must have the same key pair to enter.

>[!WARNING]
The private key must never be exposed because if an unauthorized user ever gains access to the private key they can gain access through ssh. 

# 