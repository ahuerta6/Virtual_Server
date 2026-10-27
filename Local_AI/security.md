[← Local AI](README.md)

# Security and permissions

## Separate suggestions from execution

An AI response does not grant authority to change a server. The recorded access workflow separates persistent grants defining permitted scope from one-use human approval of an execution request.

The approval portal is separate from the chat interface. Human approval remains a human action; the assistant must not approve its own requests. Guest administrator access is handled separately from ordinary development access. Access to one target does not imply access to other guests or the Proxmox host.

These statements describe the recorded workflow. They do not establish that every future tool integration uses the same enforcement.

## Keep the container unprivileged

The AI runs inside an unprivileged LXC container. During the GPU transfer, only the required GPU render device was exposed to LXC and mapped into the inference Docker service. The transfer did not convert LXC to privileged mode or disable isolation protections.

A mapped device is still an additional interface to the host kernel and GPU driver. This is a limited device-access design, not VM-equivalent isolation.

## Keep inference internal

The GPU Ollama service shares Open WebUI's network namespace and listens on loopback. No additional host-published inference port or firewall rule was introduced for the GPU service.

The recorded configuration includes `OLLAMA_NO_CLOUD=1`. This is a service setting, not evidence of complete network isolation or proof that optional integrations cannot send data elsewhere.

Remote management follows the homelab's [documented security model](../SECURITY.md). The AI service's internal endpoint does not establish authentication or encryption for every other interface.

## Make changes recoverable

The GPU change included backups of the affected guest and host configuration, plus a consistent application database backup. Those backups remain private because they can contain application data.

A CPU inference endpoint remains available as a fallback. Switching back to it avoids restoring an old application database and losing newer conversations. A full hardware rollback was documented but not executed.

## Known gaps and review items

The October 17 defensive inventory found asymmetric network segmentation, broad outbound permissions on one lab segment, an unaudited IPv6 configuration, and the Proxmox firewall disabled at inspection. These dated observations need rechecking before describing the homelab as fully isolated.

The AI container was on the management/home network rather than a dedicated disposable testing network. Isolated cyber-range networks were discussed but had not been created in that inventory.

A full host reboot after the GPU change was not tested. Container restart was tested during the transfer; the final writable-storage service configuration was then validated through the application.

## Publication boundary

Public documentation contains architectural descriptions and summarized results. Private keys, passwords, approval credentials, tokens, application databases, conversation exports, and live request receipts stay out of the repository. Screenshots and configuration examples require review before publication.
