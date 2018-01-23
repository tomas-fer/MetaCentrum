#This script installs dependencies for HybPiper on CentOS 7 (e.g., new VM in MetaCentrum)
#Clones HybPiper from GitHub, downloads test data and runs first script on one sample
mkdir install
cd install
#Install pip (assumes python is installed)
yum install -y python-pip
#Upgrade pip
pip install --upgrade pip
#Install biopython
pip install biopython
#Download BLAST
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz
tar xfz ncbi-blast-2.7.1+-x64-linux.tar.gz
rm -f ncbi-blast-2.7.1+-x64-linux.tar.gz
cp ncbi-blast-2.7.1+/bin/* /usr/local/bin
#Download SPAdes
wget http://spades.bioinf.spbau.ru/release3.11.1/SPAdes-3.11.1-Linux.tar.gz
tar xfz SPAdes-3.11.1-Linux.tar.gz
rm -f SPAdes-3.11.1-Linux.tar.gz
cp SPAdes-3.11.1-Linux/bin/* /usr/local/bin
cp -r SPAdes-3.11.1-Linux/share/ /usr/local/
#Install parallel
yum install -y parallel
#Download exonerate
wget http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-2.2.0-x86_64.tar.gz
tar xfz exonerate-2.2.0-x86_64.tar.gz
rm -f exonerate-2.2.0-x86_64.tar.gz
cp exonerate-2.2.0-x86_64/bin/* /usr/local/bin
#Install zlib (required by BWA)
yum install -y zlib-devel
#Download/compile BWA
wget https://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.17.tar.bz2
tar jxf bwa-0.7.17.tar.bz2
rm -f bwa-0.7.17.tar.bz2
cd bwa-0.7.17
make
cp bwa /usr/local/bin
cd ..
#Install bzip2-devel and xz-devel (required by samtools)
yum install -y bzip2-devel
yum install -y xz-devel
#Download/compile samtools
wget https://github.com/samtools/samtools/releases/download/1.6/samtools-1.6.tar.bz2
tar jxf samtools-1.6.tar.bz2
rm -f samtools-1.6.tar.bz2
cd samtools-1.6
./configure --without-curses
make
make install
cd ..
cd ..
#Clone HybPiper
git clone https://github.com/mossmatters/HybPiper.git
cd HybPiper
#Run a test of dependencies
./reads_first.py --check-depend
#Download and run a test dataset
cd test_dataset
rm test_reads.fastq.tar.gz
wget https://github.com/mossmatters/HybPiper/raw/develop/test_dataset/test_reads.fastq.tar.gz
tar -zxvf test_reads.fastq.tar.gz
../reads_first.py -b test_targets.fasta -r NZ281_R*_test.fastq --prefix NZ281 --bwa
