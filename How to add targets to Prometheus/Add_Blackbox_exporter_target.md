_The following instructions are executed on Ubuntu environment._

**How to add a Blackbox exporter target to Prometheus monitoring targets.**

Firstly, Blackbox exporter needs to be installed on a server in order to collect the essential metrics of a web server as follows:
```bash
sudo apt-get install prometheus-blackbox-exporter
```
Blackbox exporter collects metrics via Probing over HTTP(S). In order to add a web server as a target to Prometheus monitoring targets, it is only required to edit the configuration file "prometheus.yml" in the Prometheus server.

Let's say the web server "example2.cn.ece.ntua.gr" needs to be added as a target. This can be achieved by adding
the desired target's name within the section "targets" as follows:

```yaml
- job_name: 'blackbox'
metrics_path: /probe
params:
module: [http_2xx] # Look for a HTTP 200 response.
static_configs:
- targets:
- https://example1.cn.ntua.gr # Target no.1
- https://example2.cn.ntua.gr # Target no.2
relabel_configs:
- source_labels: [__address__]
target_label: __param_target
- source_labels: [__param_target]
target_label: instance
- target_label: __address__
replacement: cn-monitor-2.cn.ntua.gr:9115 # The blackbox exporter's real
hostname:port
```
