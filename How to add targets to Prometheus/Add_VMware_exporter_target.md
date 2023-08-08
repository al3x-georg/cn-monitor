_The following instructions are executed on Ubuntu environment._

**How to add a VMware exporter target to Prometheus monitoring targets.**

Firstly, VMware exporter needs to be installed on a server in order to collect the essential metrics of a VMware host as follows:

```bash
cd /opt
git clone https://github.com/pryorda/vmware_exporter/
cd vmware_exporter
python3 setup.py install
```

After that, the exporter's configuration file (config.yml) needs to be edited by adding the new host.

Let's say the server "example2.cn.ece.ntua.gr" named "atlas" needs to be added as a target. This can be achieved by adding the follows:

```yaml
default:

atlas:
  vsphere_host: example2.cn.ece.ntua.gr
  vsphere_user: ‘*****’
  vsphere_password: '********'
  ignore_ssl: True
  specs_size: 5000
  fetch_custom_attributes: False
  fetch_tags: False
  fetch_alarms: True
  collect_only:
  vms: True
  vmguests: True
  datastores: True
  hosts: True
  snapshots: True
```

In order to complete the proccess and add the new VMware host as a target to Prometheus monitoring targets, it is essential to edit the configuration file "prometheus.yml" in the Prometheus server. Thus, a new job name named "vmware_vcenter2", that contains the section "atlas" is added as follows:

```yaml
- job_name: 'vmware_vcenter2'
  metrics_path: '/metrics'
  static_configs:
    - targets:
      - 'example2.cn.ece.ntua.gr'
  params:
    section: [atlas]
  relabel_configs:
    - source_labels: [__address__]
      target_label: __param_target
    - source_labels: [__param_target]
      target_label: instance
    - target_label: __address__
      replacement: 147.102.40.79:9272  # IP address of VMware exporter
```
