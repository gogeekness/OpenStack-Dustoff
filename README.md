# OpenStack-Dustoff
This is a repo to version settings for Dustoff server.

I have a working OpenStack server, and I have had to put a lot of effort to get thif this far.
I do not want to loose my place.  So, I am versioning key config files from my server.
This way I can track my changes.

As from my experence Kolla is unstable and likes to break. 

## Storage

The server has 2 zpools:
```
NAME             SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
openstack-pool   222G  29.4G   193G        -         -     7%    13%  1.00x    ONLINE  -
orionsbelt      13.6T  1.21M  13.6T        -         -     0%     0%  1.00x    ONLINE  -
```

### Kolla new directories

My botting disk is only 16GB in size, not large enough to use as the primary drive so I need to move OpenStack to my SSD mirror `/openstack-pool`. It has 186GB, no vast but large enought for a few to a dozen VMs.

```
Filesystem                     Size  Used Avail Use% Mounted on
tmpfs                          4.8G  504M  4.3G  11% /run
/dev/sda2                       15G  4.8G  9.1G  35% /
tmpfs                           24G   36K   24G   1% /dev/shm
tmpfs                          5.0M     0  5.0M   0% /run/lock
openstack-pool                 191G  4.5G  186G   3% /openstack-pool
openstack-pool/logs            186G   94M  186G   1% /openstack-pool/logs
openstack-pool/home            186G  128K  186G   1% /openstack-pool/home
openstack-pool/vms             186G  128K  186G   1% /openstack-pool/vms
openstack-pool/docker          194G  7.3G  186G   4% /openstack-pool/docker
openstack-pool/glance          186G  128K  186G   1% /openstack-pool/glance
openstack-pool/home/reseke     188G  2.0G  186G   2% /openstack-pool/home/reseke
orionsbelt                      11T  128K   11T   1% /orionsbelt
orionsbelt/backups              11T  128K   11T   1% /orionsbelt/backups
orionsbelt/media                11T  128K   11T   1% /orionsbelt/media
orionsbelt/cinder               11T  128K   11T   1% /orionsbelt/cinder
openstack-pool/var-lib-docker  188G  2.2G  186G   2% /var/lib/docker
tmpfs                          4.8G   16K  4.8G   1% /run/user/1000
```
Orionsbelt is for Cinder and more permanent store.  It will have NAS and more media (if I can get Kolla working).

## Kolla globals

I have a one server (host) set up.  so the networking was to be simple...
So, Nic #1 is doing most of the work and is routed to my Friztbox and network `192.168.178.x`.
Nic #2 is interal and there are bridges (`ex` an `int`).  I wanted something simple to start before (or I thought).
There is a connection IP, and an Internal one defined in the globals.





