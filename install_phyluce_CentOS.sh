# This script installs dependencies for phyluce on CentOS 7 (e.g., new VM in MetaCentrum)
# https://github.com/faircloth-lab/phyluce
# http://phyluce.readthedocs.io/en/latest/installation.html

# Install java
yum install -y java-1.7.0-openjdk
# Install Miniconda
wget https://repo.continuum.io/miniconda/Miniconda-3.10.1-Linux-x86_64.sh
chmod +x Miniconda-3.10.1-Linux-x86_64.sh
./Miniconda-3.10.1-Linux-x86_64.sh
# Open new terminal
bash
# Add faircloth-lab conda repository
conda config --add channels https://conda.anaconda.org/faircloth-lab
# Install phyluce using conda
conda install phyluce
