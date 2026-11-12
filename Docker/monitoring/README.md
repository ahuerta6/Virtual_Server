# Homelab Monitoring

Prometheus collects metrics from node exporter and cAdvisor. Grafana shows host and container dashboards and sends email alerts. A dedicated collector reads Proxmox LVM-thin storage usage over verified HTTPS with a read-only API token scoped to the monitored pool.

| Alert | Condition | Pending period |
| --- | --- | --- |
| Monitoring VM telemetry unavailable | Node exporter is unreachable or missing | 3 minutes |
| Monitoring VM high CPU | Five-minute average CPU usage is above 90% | 5 minutes |
| Monitoring VM high memory | Memory usage based on available memory is above 85% | 5 minutes |
| Monitoring VM root disk low space | Available space on the root filesystem is below 15% | 10 minutes |
| Proxmox storage pool high usage | Used capacity is above 85% | 10 minutes |

The storage rule keeps its last state when data is missing or evaluation fails, so a planned shutdown does not open a new capacity alert.

Verified that Prometheus scrapes the storage collector and that Grafana evaluates the storage rule as Normal at the observed usage. Email delivery was verified with a firing test rule. The storage rule itself was verified in its normal state.

Credentials, internal addresses, and deployment configuration are managed locally.
