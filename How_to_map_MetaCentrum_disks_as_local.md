 # How to map MetaCentrum disks as local (e.g., in VM)

(instructions for CentOS 7, for other distributions see
<https://wiki.metacentrum.cz/wiki/Mounting_data_storages_on_local_station>)

1.  install packages supporting Kerberos authentization and NFS

```
yum install -y heimdal-appl-clients krb5-workstation nfs-utils
```

2.  copy Kerberos configuration from skirit

```
scp username\@skirit.ics.muni.cz:/etc/krb5.conf /etc
```

3.  allow NFS and RPCSEC support

```
modprobe nfs
modprobe auth_rpcgss
```  

4.  generate Kerberos ticket (by connecting to MetaCentrum, e.g., skirit)

```
ssh username\@skirit.ics.muni.cz "/software/remctl-2.12/bin/remctl \
-d kdccesnet.ics.muni.cz accounts nfskeytab \> krb5.keytab"
```

5.  copy ticket to the local machine

```
scp username\@skirit.ics.muni.cz:krb5.keytab /etc/
```

6.  start NFS

```
service nfs start
```

7.  make a folder for mapping MetaCentrum disk (brno7-cerit in this case)

```
mkdir -p /storage/brno7-cerit
```

8.  add entry to the file /etc/fstab

```
echo "storage-brno7-cerit.metacentrum.cz/ /storage/brno7-cerit nfs4       sec=krb5              0 0" \
| sudo tee -a /etc/fstab \> /dev/null
```
9.  mount MetaCentrum disk

```
mount -t nfs4 storage-brno7-cerit.metacentrum.cz:/ /storage/brno7-cerit -o sec=krb5
```

your MetaCentrum data are in the folder /storage/brno7-cerit/home/username

10.  It is also possible to download all above mentioned instruction as a single file

```
wget https://raw.githubusercontent.com/tomas-fer/MetaCentrum/master/mountMETA.sh
```

make the script executable

```
chmod +x mountMETA.sh
```

and run the script with your MetaCentrum login as a parameter

```
./mountMETA.sh username
```

it is necessary to provide your MetaCentrum password three times during the run of the script

11.  This is an instruction how to map disk brno7-cerit; if you wish to map other
    storage you find their names on MetaCentrum Wiki (see link at the top). It
    is necessary to repeat steps 7-9 for each storage.
