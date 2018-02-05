
INSPIRE dashboards on docker
===========================


This is the configuration used to build and run the INSPIRE dashboards available at EEA. The process allows to run 2 images for the 2 types of dashboard app (sandbox and official) available on docker hub https://hub.docker.com/u/inspiremif/. To build and make more customization to the images, see https://github.com/INSPIRE-MIF/daobs/tree/2.0.x/docker#install--run


To run the composition:


```bash
docker-compose -p dashboard-sandbox -f docker-compose-canonical.yml -f docker-compose-eea-dashboard-sandbox.yml up
docker-compose -p dashboard-official -f docker-compose-canonical.yml -f docker-compose-eea-dashboard-official.yml up

```


Then open the applications with:

* https://localhost:81
* https://localhost

Then for the official node, change the default account in user.properties in the dashboard-official volume and change it also for the kibana_rw user in readonlyrest.yml.

The two orchestrations can be run, side-by-side in the same machine, as they have different namespaces for container, volumes and networks names.


Load the default data
---------------------

The official node contains all past monitoring made by Member States. 2011 to 2016 files can be found at https://taskman.eionet.europa.eu/attachments/40869/2016%20(ref%20year%202015).zip. Sign in the dashboard and then load the monitoring files from the **submit monitoring** section (http://localhost/official/#/monitoring/submit):

![Submit monitoring](/img/submit-monitoring.png)


The sandbox node is used by Member States to easily create the monitoring from the content harvested from their discovery service.



Advanced Configuration
----------------------
Nginx is running on port 443|444 (it uses different ports in the official and sandbox applications, in order to enable both of them to bind to the localhost).



Security
--------
Only the web container (nginx) publishes its ports. All other containers communicate *only* using docker's internal network.

On this orchestration, **SSL is enabled** by default.
In order to setup SSL with your own certificates you need to export some environment variables, with the **location** and **name** of your private and public keys:

* `SSL_CERTS_DIR`: path on disk of the public key (without a trailing `/` on the end).
* `SSL_PUB`: name of the file which stores the public key.
* `SSL_KEY_DIR`: path on disk of the private key (without a trailing `/` on the end).
* `SSL_PRIV`: name of the file which stores the private key.

If you don't have any keys, you may leave these variables empty: a runtime script will generate **self-signed certificates**, which will enable you to use SSL on a development environment. Self-signed certificates will issue an warning in the browser and need to be trusted by the user. It is not recommended to use self-signed certificates in production environments.

![Generated self-signed certificate](https://raw.githubusercontent.com/INSPIRE-MIF/daobs/2.0.x/docker/ssl.png)



Persisted Volumes
-----------------
The folder `/usr/share/elasticsearch/data` is persisted to a named volume, whose name depends on the node and orchestration. Unless explicitly removed, this volume will be persisted on the host folder: `var/lib/docker/volumes/[NAMED_VOLUME]/_data`, where [NAMED_VOLUME] should be replaced by the actual volume name.
The folder `/daobs-data-dir/`, which is mapped in the dockerfile to environmental variable `INSTALL_DASHBOARD_PATH`, is persisted in a volume whose name depends on the orchestration (e.g.: "dashboardsandbox_dashboard-sandbox-dir", "dashboardofficial_dashboard-official-dir")`. If you change `INSTALL_DASHBOARD_PATH` on the dockerfile, remember to also change the mapping on docker-compose, or your data directory won't be persisted.

License
========
View [license information](https://github.com/INSPIRE-MIF/daobs/blob/2.0.x/LICENCE.md) for the software contained in this image.
