# pfSense Firewall Setup on Proxmox
<h2>Project Overview</h2>
The point of this project was to set up a virtual firewall with pfSense so that I can isolate my home lab and run test on it. There are other benefits to such as security. The way I did create this firewall was by deploying pfSense as a virtual machine with two network interfaces one that acts as my WAN facing my home network and one that acts like a LAN facing an isolated bridge that only the lab machines live on. This allows me to run scenarios such as malware analysis, penetration testing, and vulnerable target machines without any of the traffic touching the rest of my home network.

> [!IMPORTANT]
> **Build status.** The isolated bridge `vmbr1` and the pfSense VM (VM 101 — two NICs, UEFI) are **built**, and the VM boots to the installer — that is exactly what the screenshots below show. Everything from *[Boot the Installer](#3-boot-the-installer)* onward is the **standard install/configuration path**, documented here as the plan. Those later steps and their values (LAN subnet, DHCP range, firewall rules) are **not configured yet** and are flagged inline as placeholders to confirm.

<h3>Objective</h3>

- Create a second, isolated virtual bridge (`vmbr1`) on Proxmox
- Deploy pfSense as a VM with a WAN interface (`vmbr0`) and a LAN interface (`vmbr1`)
- Route and firewall the lab network so it can reach the internet but **cannot** reach the home network
- Lay the groundwork for attacker/target lab VMs to sit safely behind the firewall