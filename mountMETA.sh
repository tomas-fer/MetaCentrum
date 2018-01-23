#!/bin/bash
#Mount MetaCentrum dir to folder /storage
#This works probably only on CentOS 7 (tested on VM in MetaCentrum cloud)
#Based on https://wiki.metacentrum.cz/wiki/Mounting_data_storages_on_local_station
#RUN WITH YOUR METACENTRUM LOGIN AS PARAMETER (e.g., ./mountMETA.sh yourlogin)
username=$1
#add support for Kerberos and NFS
yum install -y heimdal-appl-clients krb5-workstation nfs-utils
#Copy Kerberos configuration from MetaCentrum (skirit)
scp ${username}@skirit.ics.muni.cz:/etc/krb5.conf /etc
#allow NFS and RPCGSS support
modprobe nfs #allow nfs support
modprobe auth_rpcgss #support for RPCSEC
#Generate Kerberos ticket by connecting to MetaCentrum machine (e.g., skirit)
ssh ${username}@skirit.ics.muni.cz "/software/remctl-2.12/bin/remctl -d kdccesnet.ics.muni.cz accounts nfskeytab > krb5.keytab"
#Copy ticket to local machine
scp ${username}@skirit.ics.muni.cz:krb5.keytab /etc/
#Start NFS service
service nfs start
#make dir for mounting
mkdir -p /storage/brno7-cerit
#ADD record to /etc/fstab
echo "storage-brno7-cerit.metacentrum.cz/ /storage/brno7-cerit  nfs4       sec=krb5              0 0" | sudo tee -a /etc/fstab > /dev/null
#mount MetaCentrum disk
mount -t nfs4 storage-brno7-cerit.metacentrum.cz:/ /storage/brno7-cerit -o sec=krb5
