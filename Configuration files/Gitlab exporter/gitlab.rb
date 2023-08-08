# This file is located at the path /etc/gitlab
gitlab_exporter['enable'] = true
gitlab_exporter['log_directory'] = "/var/log/gitlab/gitlab-exporter"
gitlab_exporter['home'] = "/var/opt/gitlab/gitlab-exporter"
gitlab_exporter['listen_address'] = '0.0.0.0'
gitlab_exporter['listen_port'] = '9168'
node_exporter['enable'] = true
node_exporter['listen_address'] = '0.0.0.0:9100'