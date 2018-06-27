# This script installs dependencies for FastPlast on CentOS 7 (e.g., new VM in MetaCentrum)
# Clones FastPlast from GitHub (https://github.com/mrmckain/Fast-Plast)

# Install java (necessary for Trimmomatic)
yum install -y java-1.7.0-openjdk.x86_64
# Install perl modules
yum install -y perl-Env
yum install -y perl-IO-Compress
# Install zlib library
yum install -y zlib-devel
# Install R
yum install R
# Clone & install FastPlast
git clone https://github.com/mrmckain/Fast-Plast.git
cd Fast-Plast
perl INSTALL.pl
