_The following instructions are executed on Ubuntu environment._

**How to add a Node exporter server to Prometheus monitoring targets.**

Firstly, it is essential to install Node exporter on the target server:

```bash
sudo apt install prometheus-node-exporter
```

After that, the new host has to be added to Prometheus, as a target on the Node exporter section.
For that purpose, the configuration file "prometheus.yml" in the Prometheus server has to be configured.

Let's say the server "example2.cn.ece.ntua.gr" needs to be added as a target. This can be achieved by adding the desired target's name within the section "targets" as follows:

```yaml
- job_name: ‘node-exporter’
static_configs:
- targets: ['example1.cn.ece.ntua.gr:9100', 'example2.cn.ece.ntua.gr:9100']
```
