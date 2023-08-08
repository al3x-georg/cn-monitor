_The following instructions are executed on Ubuntu environment._

**How to add a BigBlueButton server to Prometheus monitoring targets.**

Firstly, it is essential to install the BigBlueButton exporter on the target server.

For that purpose, "Python 3 pip" has to be installed:

```bash
sudo apt install python3-pip
```
Furthermore, the source code and dependencies are installed as follows:

```bash
cd /opt
sudo git clone https://github.com/greenstatic/bigbluebutton-exporter.git
cd bigbluebutton-exporter/
# It is recommended to checkout a release tag instead of using the master branch, as well as
# selecting the latest release tag from:
# https://github.com/greenstatic/bigbluebutton-exporter/releases
sudo git checkout <RELEASE TAG>
sudo pip3 install -r requirements.txt
```

In the next step, a non-privileged user for the exporter is created and the Systemd unit service and settings are copied:

```bash
sudo cp /opt/bigbluebutton-exporter/extras/systemd/bigbluebutton-exporter.service /lib/systemd/system/
sudo mkdir /etc/bigbluebutton-exporter
sudo cp /opt/bigbluebutton-exporter/extras/systemd/bigbluebutton-exporter/* /etc/bigbluebutton-exporter
```

After that, the settings in the file "/etc/bigbluebutton-exporter/settings.env" have to be edited by replacing the API_BASE_URL and API_SECRET.

The next step, is to create an HTTP basic authentication scheme via Nginx:

```bash
sudo apt-get install apache2-utils
sudo htpasswd -c /etc/nginx/.htpasswd <desired user>
```

To complete the process, the configuration file of Nginx has to be configured as follows:

```bash
location /metrics/ {
  auth_basic "BigBlueButton exporter";
  auth_basic_user_file /etc/nginx/.htpasswd;
  proxy_pass http://127.0.0.1:9688/;
  include proxy_params;
}
```

After the installation of BigBlueButton exporter, the new host has to be added to Prometheus, as a target on the BigBlueButton exporter section.
For that purpose, the configuration file "prometheus.yml" in the Prometheus server has to be configured.

Let's say the server "example2.cn.ece.ntua.gr" needs to be added as a target. This can be achieved by adding the desired target's name within the section "targets" as follows:

```yaml
- job_name: 'bbb'
scrape_interval: 5s
static_configs:
- targets: ['example1.cn.ntua.gr:9688', 'example2.cn.ntua.gr:9688']
```
