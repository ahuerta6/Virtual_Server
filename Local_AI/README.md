[← Homelab documentation](../README.md)

# Local AI on Proxmox

I built a local AI environment in my Proxmox homelab to learn about self-hosted inference, container administration, GPU acceleration, and controlled access to infrastructure. The goal is a useful assistant whose access stays limited and reviewable.

This section summarizes recorded work through October 19, 2026, plus later file-access requirements. It is documentation of a learning project, not a fresh audit of the running server.

## Explore the project

- [Security and permissions](security.md)
- [Architecture and operation](architecture.md)
- [Performance measurements](performance.md)
- [Roadmap and planned features](roadmap.md)

## What I built

- Open WebUI as the browser interface, with Ollama for local inference.
- Docker services inside an unprivileged Proxmox LXC container.
- A coding model alias based on Qwen3 4B Instruct, using Q4_K_M quantization and an 8,192-token context.
- AMD Radeon RX 580 acceleration through Vulkan, with partial GPU offload.
- A separate human approval workflow for scoped infrastructure execution.

## Security priorities

The model's ability to suggest an action is separate from permission to execute it. The design uses scoped grants and a separate human approval step for execution requests. GPU acceleration was added while retaining the unprivileged container and limiting device access to a render node.

The inference service uses loopback inside the application's shared network namespace. That protects this service from direct network exposure; browser access, host management, and network segmentation remain separate security concerns.

## What this demonstrates

This project combines Linux administration, virtualization, container networking, least privilege, reversible infrastructure changes, and measurement before tuning. Short-prompt generation improved from about 10.4 to 27 tokens per second on the same model.

Future work includes durable project notes, reusable context profiles, carefully scoped document access, and a portable application. These are tracked as plans rather than deployed capabilities.
