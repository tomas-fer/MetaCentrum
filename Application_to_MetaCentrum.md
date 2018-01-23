**Application to MetaCentrum and how to set access to its resources**

1.  At the page <http://metavo.metacentrum.cz/en/index.html> click on Getting an
    account – Registration form and to Univerzita Karlova (or your institution)

2.  Login with your institutional credentials (CAS password at UK) and fill in
    the application. You get login information for MetaCentrum.

3.  All instructions how to use MetaCentrum are at
    <https://wiki.metacentrum.cz/w/index.php?title=Main_Page&setlang=en>

**Under Windows it is necessary to install Putty and WinSCP**

1.  Download putty.exe (*The latest developmental snapshot*, not *The latest
    release version!!!*) from
    <http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html>. This is a
    SSH client for login to MetaCentrum computers.

2.  Settings of the program is at
    <https://wiki.metacentrum.cz/wiki/Usage_of_Putty>

3.  Download software WinSCP from <http://winscp.net/eng/download.php>. This
    software is for file transfer between your computer and MetaCentrum.

4.  Settings of the program is at
    <https://wiki.metacentrum.cz/wiki/Usage_of_WinSCP>

5.  You can use Total Commander with SFTP plugin installed instead of WinSCP (my
    preferred choice). See <http://www.totalcmd.net/plugring/G_SFTP.html> how to
    do that.

6.  Instead of Putty you can use, e.g., CygWin (<http://cygwin.com/index.html>)

**How to work on MetaCentrum**

1.  Login to so-called frontend (e.g., skirit.ics.muni.cz) where you run
    computation (job), i.e. you reserve computational resources for your job.

2.  Job is possible to run interactivelly (using qsub –I) or run a script with
    all necessary commands.

3.  Job waits in a queue and then use resources (processors, memory) for the
    time reserved

4.  so-called PBSPro scheduling is used and resources specification for the job
    could are specified with specific command at the beginning of the script. An
    example:

```
#!/bin/sh
#PBS -N job_name
#PBS -l walltime=2:0:0
#PBS –l select=1:ncpus=2:mem=4gb:scratch_local=1gb
#PBS -j oe
#PBS -m abe
```
Explanation:

```-N job name```, max. 15 characters, no space, first character must be alphanumeric

```-l walltime``` define max. time for script running (HH:MM:SS)

```-l``` define requested resources:

* ```select``` – number of nodes (computers)  
* ```ncpus``` – number of processors per node  
* ```mem``` – allocated memory  
* ```scratch_local``` – disk size for data generated during computation  

```-j oe``` standard and error output joined

```-m``` send you e-mail when job is interrupted (a), started (b) a finished (e)

5.  Run your job using qsub name_of_your_script. Scheduler run the script on
    allocated computer. State of your jobs could be checked here
    <http://metavo.metacentrum.cz> (Current state – personal view).

6.  Before it is necessary to upload all input files to MetaCentrum. This can be
    done, e.g., using WinSCP. Data are transferred to your home directory, i.e.,
    in case you are logged to skirit to /storage/brno2/home/\$LOGNAME. Also your
    script should be uploaded there.

7.  Script is necessary to build with UNIX-style end of lines (EOLs). This can
    be done using, e.g., in Notepad++ (<http://notepad-plus-plus.org>) with Edit
    -\> EOL conversion to UNIX.

8.  Script could generally looks like, e.g.:

```
#!/bin/sh
#PBS -N job_name
#PBS -l walltime=2:0:0
#PBS –l select=1:ncpus=2:mem=4gb:scratch_local=1gb
#PBS -j oe
#PBS –m abe
# set the path to modules, i.e., all necessary pre-installed software packages
. /packages/run/modules-2.0/init/sh
# add a module
module add module_name
# go to scratch, i.e. to working directory at allocated computer resource
cd \$SCRATCHDIR
# copy everything from data folder to scratch
cp –r /storage/brno2/home/\$LOGNAME/data/\* .
# make directory for results
mkdir /storage/brno2/home/\$LOGNAME/data/results
# run some commands
...
# copy results from scratch back to storage
cp -r \* /storage/brno2/home/\$LOGNAME/data/results/
# delete everything in scratch
rm -rf \$SCRATCHDIR/\*
```

Look at MetaCentrum Wiki for detailed information

<https://wiki.metacentrum.cz/wiki/Jak_po%C4%8D%C3%ADtat>
