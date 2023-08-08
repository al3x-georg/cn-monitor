_The following instructions are executed on Ubuntu environment._

**How to add a Gitlab exporter server to Prometheus monitoring targets.**

In order to enable Gitlab exporter on a server, it is essential to install Gitlab on that server.

Firstly, the prerequisites have to be installed as follows:

```bash
sudo apt install tzdata curl ca-certificates openssh-server
```

The next step is to import the GPG key:

```bash
gpg_key_url="https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey"
curl -fsSL $gpg_key_url| sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/gitlab.gpg
```

In addition, the Gitlab repository needs to be added to the "sources.list.d" file of Ubuntu:

```bash
sudo tee /etc/apt/sources.list.d/gitlab_gitlab-ce.list<<EOF
deb https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ focal main
deb-src https://packages.gitlab.com/gitlab/gitlab-ce/ubuntu/ focal main
EOF
```

Finally, Gitlab can be installed as follows:

```bash
sudo apt update && sudo apt install gitlab-ce
```
After the installation of Gitlab, Gitlab exporter is configured by editing the configuration file of Gitlab named "gitlab.rb", as follows:

```rb
gitlab_exporter['enable'] = true
gitlab_exporter['log_directory'] = "/var/log/gitlab/gitlab-exporter"
gitlab_exporter['home'] = "/var/opt/gitlab/gitlab-exporter"
gitlab_exporter['listen_address'] = '0.0.0.0'
gitlab_exporter['listen_port'] = '9168'
node_exporter['enable'] = true
node_exporter['listen_address'] = '0.0.0.0:9100'
```

Finally, the new host has to be added to Prometheus, as a target on the Gitlab exporter section.
For that purpose, the configuration file "prometheus.yml" in the Prometheus server has to be configured.

Let's say the server "example2.cn.ece.ntua.gr" needs to be added as a target. This can be achieved by adding a new job name named "gitlab_exporter2" as follows:

```yaml
- job_name: gitlab_exporter2
metrics_path: "/metrics"
static_configs:
- targets:
- example2.cn.ece.ntua.gr:9168
```
