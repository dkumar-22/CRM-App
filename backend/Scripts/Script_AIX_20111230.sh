#!/bin/csh

############################################################
# Auditor Name :  XXXX
# Audit Date   :  12/8/2011
# Client Name  :  XXXX
# Description  :  Please type in a Description.
############################################################

#!/bin/csh
#
#

#set -x
onintr quit
set prompt="Press <Return> to continue"
set UNAMEa=`uname -a`
set basedir=/tmp/scan
set HOSTNAME=`hostname`
set INDEXF=index.html
#set SYSTEMF=system.out.txt
set SYSTEMF=system.html
#set SPECIFICF=specific.out.txt
set SPECIFICF=specific.html


main:
 while (1)
 clear
  echo "          ---------------------------------------------------"
  echo "          Please make your selection from the options below: "
  echo ""
  echo "           1) Run the script on this host     "
  echo "           2) Exit                            "
  echo ""
  echo -n "           Enter Selection: "
   set OUTPUTTYPE=$<

   switch ($OUTPUTTYPE)
   case 1:
        goto systemtype
   case 2:
        exit
   default:
        clear
        echo "Invalid selection"
        echo -n "$prompt"
         tmp=$<
        goto main
  endsw
 end

sleep 5
goto main

systemtype:
 clear

  echo "          ---------------------------------------------------"
  echo "                      Please select the system type:      "
  echo ""
  echo "           1) Linux                           "
  echo "           2) All other Unix flavors          "
  echo "           3) Sybase Database          "   
  echo ""
  echo -n "           Enter Selection: "
   set OUTPUTTYPE=$<

   switch ($OUTPUTTYPE)
   case 1:
        set case=1
        goto systeminfo1
   case 2:
        set case=2
        goto systeminfo2
   case 3:
        set case=3
        goto dbinfo
   default:
        clear
        echo "Invalid selection"
        echo -n "$prompt"
         tmp=$<
        goto systemtype
  endsw
 end


systeminfo1:
  clear
  echo "          ---------------------------------------------------"
  echo "               Please enter some of the system specifics "
  echo ""
  echo -n "           1) Please enter a unique output folder name : "
   set outfolder = `head -1`
   set outdir = ${basedir}/${outfolder}
  echo -n "           2) What is the Operating System Version?: "
   set version = `head -1`
  echo -n "           3) What is the System Hostname?: "
   set sysname = `head -1`
  echo -n "           4) What is the Administrator's Name?: "
   set adminname = `head -1`
  echo -n "           5) What is the Client's Name?: "
   set clientname = `head -1`
  echo -n "           6) Enter Auditor's Full Name: "
   set auditorname = `head -1`
  echo -n "           7) Enter Server Information / Note To Auditor: "
   set servinfo = `head -1`

  clear
  echo ""
  echo "          ---------------------------------------------------"
  echo "          System specifics "
  echo "          "
  echo "           1) Output directory: ${outdir}"
  echo "           2) OS Version Number: ${version}"
  echo "           3) System Name: ${sysname}"
  echo "           4) Administrator's Name: ${adminname}"
  echo "           5) Client's Name: ${clientname}"
  echo "           6) Auditor's Full Name: ${auditorname}"
  echo "           7) Server Information / Note To Auditor: ${servinfo}"
  echo ""
  echo -n "           Is the above information correct? [y/n]: "
   set ans=$<
#
if (!(($ans == "y") || ($ans == "Y"))) then
       clear
       goto systeminfo1
       else
       clear
       goto Query
endif

systeminfo2:
  clear
  echo ""
  echo "          ---------------------------------------------------"
  echo "               Please enter some of the system specifics "
  echo "          "
  echo -n "           1) Please enter a unique output folder name: "
   set outfolder = $<
   set outdir = ${basedir}/${outfolder}
  echo -n "           2) What is the Operating System Version?: "
   set version = $<
  echo -n "           3) What is the System Hostname?: "
   set sysname = $<
  echo -n "           4) What is the Administrator's Name?: "
   set adminname = $<
  echo -n "           5) What is the Client's Name?: "
   set clientname = $<
  echo -n "           6) Enter Auditor's Full Name: "
   set auditorname = $<
  echo -n "           7) Enter Server Information / Note To Auditor: "
   set servinfo = $<

  clear
  echo ""
  echo "          ---------------------------------------------------"
  echo "          System specifics "
  echo "          "
  echo "           1) Output directory: ${outdir}"
  echo "           2) OS Version Number: ${version}"
  echo "           3) System Name: ${sysname}"
  echo "           4) Administrator's Name: ${adminname}"
  echo "           5) Client's Name: ${clientname}"
  echo "           6) Auditor's Full Name: ${auditorname}"
  echo "           7) Server Information / Note To Auditor: ${servinfo}"
  echo ""
  echo -n "           Is the above information correct? [y/n]: "
   set ans=$<
#
if (!(($ans == "y") || ($ans == "Y"))) then
       clear
       goto systeminfo2
       else
       clear
       goto Query
endif

dbinfo:
  clear
  echo ""
  echo "          ---------------------------------------------------"
  echo "          Please enter the database connection information "

  echo "          ---------------------------------------------------"
  echo "          Please enter the database connection information "
  echo "                                                          "
  echo "                THIS INFORMATION WILL NOT BE SAVED!             "
  echo ""
  echo -n "           1) Please enter a unique output folder name: "
   set outfolder = `head -1`
   set outdir = ${basedir}/${outfolder}
  echo -n "           2) What is the Database Administrator username?: "
   set admin_name = `head -1`
  echo -n "           3) What is the Database Administrator password?: "
   set admin_pword = `head -1`
  echo -n "           4) What is the Database Name?: "
   set db_name = `head -1`

  clear
  echo ""
  echo "          ---------------------------------------------------"
  echo "          Database connection information "
  echo "          "
  echo "           1) Output directory: ${outdir}"
  echo "           2) Administrator Name: ${admin_name}"
  echo "           3) Administrator Password: ${admin_pword}"
  echo "           4) Database Name: ${db_name}"
  echo ""
  echo -n "           Is the above information correct? [y/n]: "
   set ans=$<
#
if (!(($ans == "y") || ($ans == "Y"))) then
       clear
       goto dbinfo
       else
       clear
       goto Query
endif

Query:
  echo ""
  echo "          ---------------------------------------------------"
  echo "            The query script is now running. Please wait..."
  echo ""
  echo ""

sleep 3

#*** Set up output formatting.

#
# This component of the script ensures that the output directory and files are resident on the system  being reviewed.
#

        if (!(-d ${basedir})) then
                mkdir -p ${basedir}
                chmod 700 ${basedir}
                mkdir -p ${outdir}
                chmod 700 ${outdir}
	else
                mkdir -p ${outdir}
                chmod 700 ${outdir}
		    

        endif

                if $case != 3 then
		set INDEXO=${outdir}/${INDEXF}
		set SYSTEMO=${outdir}/${SYSTEMF}
		set SPECIFICO=${outdir}/${SPECIFICF}
		set TEXTO=${outdir}/aumya-${HOSTNAME}.txt
                touch ${INDEXO}
                touch ${SPECIFICO}
                touch ${SYSTEMO}
                        # Add new html output files to the list here:
                        echo "<html><head><title>specific.out</title></head><body><h1>Specific to this  flavor of UNIX</h1><pre>" > ${SPECIFICO}
                        echo "<html><head><title>system.out</title></head><body><h1>System  files</h1><pre>" > ${SYSTEMO}
                        echo "<html><head><title>UNIX Script</title></head><body><h1>Aumya UNIX  Script</h1>" > ${INDEXO}
                        # End of new html output files

                        # System specifics to include on index page
                        #
                        echo "${UNAMEa}<br>" >>& ${INDEXO}
                        echo "<b>OS Version:</b> ${version}<br>">>& ${INDEXO}
                        echo "<b>Adminstrator:</b> ${adminname}<br>">>& ${INDEXO}
                        echo "<b>Client:</b> ${clientname}<br>">>& ${INDEXO}
                        echo "<b>Auditor's Full Name:</b> ${auditorname}<br>">>& ${INDEXO}
                
                        echo "<b>Server Information / Note To Auditor:</b> ${servinfo}<br><br><ul>">>&  ${INDEXO}
                        echo '<a name=TopOfIndex>' >>& ${INDEXO}
                endif

# Script finds and displays .hushlogin files
#
echo '<a name=Hush>' >>& ${SYSTEMO}
echo "Displaying .hushlogin files" >>&  ${SYSTEMO}
echo '**************************' >>&  ${SYSTEMO}
echo '' >>&  ${SYSTEMO}
     find / \( -fstype nfs -prune \) -o -name '.hushlogin' -exec ls -dal {} \; >>&  ${SYSTEMO}
echo '' >>&  ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script finds all .netrc files 
# 
echo '<a name=Netrc>' >>& ${SYSTEMO}
echo "Displaying .netrc files" >>& ${SYSTEMO}
echo '***********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
  find / \( -fstype nfs -prune \) -o -name '*.netrc' -exec /usr/bin/ls -al {} \; -exec cat {} \; >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}


# Script finds and displays .profile files 
#
echo '<a name=FindProfile>' >>& ${SYSTEMO} 
echo "Displaying .profile files" >>& ${SYSTEMO} 
echo '*************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
 find /home \( -fstype nfs -prune \) -o -name '*.profile' -print -exec ls -al {} \; -exec cat {} \; >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script finds and displays .rhost files
#
echo '<a name=Rhost>' >>& ${SYSTEMO}
echo "Displaying .rhosts files" >>& ${SYSTEMO}
echo '************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
  find / \( -fstype nfs -prune \) -o -name '*.rhosts' -print -exec ls -al {} \; -exec cat {} \; >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script finds and displays unauthorized device files
# 
echo '<a name=DeviceFiles>' >>& ${SYSTEMO}
echo "Displaying all device files" >>& ${SYSTEMO} 
echo '************************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
find / \( -fstype nfs -prune \) -o \( -type c -o -type b \) -exec ls -al {} \; >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script shows all executable files
# 
echo '<a name=ExecutableFiles>' >>& ${SYSTEMO}
echo "Displaying executable files" >>& ${SYSTEMO}
echo '***************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	find / \( -fstype nfs -prune \) -o -type f \( -perm -100 -o -perm -010 -o -perm -001 \) -exec ls -al {} \; >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays existence of SUID and SGID files
#
echo '<a name=SUID>' >>& ${SYSTEMO}
echo "Displaying SUID files" >>& ${SYSTEMO}
echo '*********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	find / \( -fstype nfs -prune \) -o -type f -perm -4000 -exec ls -dal {} \; >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

echo "Displaying SGID files" >>& ${SYSTEMO}
echo '*********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	find / \( -fstype nfs -prune \) -o -type f -perm -2000 -exec ls -dal {} \; >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays files that are both world-writable and executable
#
echo '<a name=WorldWriteableFiles>' >>& ${SYSTEMO}
echo "Displaying files that are both world-writeable and executable" >>&  ${SYSTEMO}
echo '*************************************************************' >>&  ${SYSTEMO}
echo '' >>&  ${SYSTEMO}
  find / \( -fstype nfs -prune \) -o -type f -perm -00003 -exec ls -al {} \; >>&  ${SYSTEMO}
echo '' >>&  ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays all world writable directories
#
echo '<a name=WorldWriteableDirs>' >>& ${SYSTEMO}
echo "Displaying world writable directories" >>& ${SYSTEMO} 
echo '*************************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
find / \( -fstype nfs -prune \) -o -type d -perm -2 -exec ls -dlL {} \; >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}


# Script displays all world writable files
#
echo '<a name=WorldWriteableFiles2>' >>& ${SYSTEMO}
echo "Displaying world writable files" >>& ${SYSTEMO} 
echo '*******************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
find / \( -fstype nfs -prune \) -o -type f -perm -2 -exec ls -dlL {} \; >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays open ports and open port numbers
#
echo '<a name=OpenPorts>' >>& ${SYSTEMO}
echo "Open ports" >>& ${SYSTEMO} 
echo "Displaying netstat -a" >>& ${SYSTEMO} 
echo '*********************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	netstat -a  >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
#
echo "Open port numbers" >>& ${SYSTEMO} 
echo "Displaying netstat -an" >>& ${SYSTEMO} 
echo '**********************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	netstat -an  >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays file permissions of /dev 
# 
echo '<a name=PermissionsDev>' >>& ${SYSTEMO}
echo "Displaying file permissions of /dev" >>& ${SYSTEMO} 
echo '***********************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	if ( -d /dev) then 
		ls -al /dev >>& ${SYSTEMO} 
	else 
		echo "No /dev directory found" >>& ${SYSTEMO} 
endif 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/group file
# 
echo '<a name=Group>' >>& ${SYSTEMO}
echo "Displaying /etc/group" >>& ${SYSTEMO}
echo '*********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	if ( -f /etc/group) then
		cat /etc/group >>& ${SYSTEMO}
	else
		echo "No /etc/group file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays /etc/inetd.conf file
# 
echo '<a name=Inetd>' >>& ${SYSTEMO}
echo "Displaying /etc/inetd.conf" >>& ${SYSTEMO}
echo '**************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	if ( -f /etc/inetd.conf) then
		cat /etc/inetd.conf >>& ${SYSTEMO}
	else
		echo "No /etc/inetd.conf file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Displays sendmail configuration info
#
echo '<a name=SendmailConf>' >>& ${SYSTEMO}
echo "Displaying /etc/mail/sendmail.cf" >>& ${SYSTEMO}
echo '********************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
if ( -f /etc/mail/sendmail.cf ) then
	cat /etc/mail/sendmail.cf >>& ${SYSTEMO}
else
	echo "No /etc/mail/sendmail.cf file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/named.conf file
# 
echo '<a name=NamedConf>' >>& ${SYSTEMO}
echo "Displaying /etc/named.conf" >>& ${SYSTEMO}
echo '**************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	if ( -f /etc/named.conf) then
		cat /etc/named.conf >>& ${SYSTEMO}
	else
		echo "No /etc/named.conf file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays /etc/passwd file
# 
echo '<a name=DisplayPasswdFile>' >>& ${SYSTEMO}
echo "Displaying /etc/passwd" >>& ${SYSTEMO}
echo '**********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	if ( -f /etc/passwd) then
		cat /etc/passwd >>& ${SYSTEMO}
	else
		echo "No /etc/passwd file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/profile file 
# 
echo '<a name=Profile>' >>& ${SYSTEMO}
echo "Displaying /etc/profile" >>& ${SYSTEMO} 
echo '***********************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	if ( -f /etc/profile) then 
		cat /etc/profile >>& ${SYSTEMO} 
	else 
		echo "No /etc/profile file found" >>& ${SYSTEMO} 
endif 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/security/audit/events
#
echo '<a name=AuditEvents>' >>& ${SYSTEMO}
echo "Displaying /etc/security/audit/events" >>& ${SYSTEMO}
echo '*************************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
if ( -f /etc/security/audit/events ) then
	cat /etc/security/audit/events >>& ${SYSTEMO}
else
	echo "No /etc/security/audit/events file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script shows /etc/security/lastlog
# 
echo '<a name=Lastlog>' >>& ${SYSTEMO}
echo "Displaying /etc/security/lastlog" >>&  ${SYSTEMO}
echo '********************************' >>&  ${SYSTEMO}
echo '' >>&  ${SYSTEMO}
  cat /etc/security/lastlog >>&  ${SYSTEMO}
echo '' >>&  ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays /etc/security/passwd file 
# 
echo '<a name=SecurityPasswd>' >>& ${SYSTEMO}
echo "Displaying /etc/security/passwd" >>& ${SYSTEMO} 
echo '*****************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	if ( -f /etc/security/passwd) then 
		cat /etc/security/passwd >>& ${SYSTEMO} 
	else 
		echo "No /etc/security/passwd file found" >>& ${SYSTEMO} 
endif 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/security/user file 
# 
echo '<a name=SecurityUser>' >>& ${SYSTEMO}
echo "Displaying /etc/security/user" >>& ${SYSTEMO} 
echo '*****************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	if ( -f /etc/security/user) then 
		cat /etc/security/user >>& ${SYSTEMO} 
	else 
		echo "No /etc/security/user file found" >>& ${SYSTEMO} 
endif 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/syslog.conf file
# 
echo '<a name=Syslog>' >>& ${SYSTEMO}
echo "Displaying /etc/syslog.conf" >>& ${SYSTEMO}
echo '***************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	if ( -f /etc/syslog.conf) then
		cat /etc/syslog.conf >>& ${SYSTEMO}
	else
		echo "No /etc/syslog.conf file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays /ftpusers file
#
echo '<a name=Ftpusers>' >>& ${SYSTEMO}
echo "Displaying contents of /ftpusers" >>& ${SYSTEMO}
echo '********************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	find /etc \( -fstype nfs -prune \) -o -name ftpusers -exec cat {} \; >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Displays 'ifconfig -a' to check for a promiscuous mode NIC 
#
echo '<a name=Ifconfig>' >>& ${SYSTEMO}
echo "Displaying 'ifconfig -a'" >>& ${SYSTEMO}
echo '************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	ifconfig -a >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays /usr/bin/last file
# 
echo '<a name=Last>' >>& ${SYSTEMO}
echo "Displaying /usr/bin/last" >>& ${SYSTEMO}
echo '************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	last >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

echo "Displaying previous /usr/bin/last files" >>& ${SYSTEMO}
echo '***************************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
if ( -f /var/log/wtmp.1 ) then
	last -f /var/log/wtmp.* >>& ${SYSTEMO}
else
	echo "No previous '/usr/bin/last' file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}

# Script displays ypcat passwd file
# 
echo '<a name=Ypcat>' >>& ${SYSTEMO}
echo "Displaying ypcat passwd" >>& ${SYSTEMO}
echo '***********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	ypcat passwd >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /usr/sbin/audit query
# 
echo '<a name=AuditQuery>' >>& ${SYSTEMO}
echo "Displaying /usr/sbin/audit query" >>& ${SYSTEMO} 
echo '********************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
 /usr/sbin/audit query >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /var/adm/sulog file 
# 
echo '<a name=Sulog>' >>& ${SYSTEMO}
echo "Displaying /var/adm/sulog" >>& ${SYSTEMO} 
echo '*************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	if ( -f /var/adm/sulog) then 
		cat /var/adm/sulog >>& ${SYSTEMO} 
	else 
		echo "No /var/adm/sulog file found" >>& ${SYSTEMO} 
endif 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script finds all executable files and shows group permissions 
# 
# Access to Administration Tools and System Utilities Step 1
#
echo '<li><a href=specific.html#AdminTools2>Access to Administration Tools and System Utilities</a>' >>& ${INDEXO}
echo '<a name=AdminTools2>' >>& ${SPECIFICO}
echo "Access to Administration Tools and System Utilities Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ExecutableFiles>executable</a>' files in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Access to Administration Tools and System Utilities Step 3
#
echo "Access to Administration Tools and System Utilities Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks the BIND service and configuration file
# 
# Access to DNS Queries Step 1
#
echo '<li><a href=specific.html#DnsQueries2>Access to DNS Queries</a>' >>& ${INDEXO}
echo '<a name=DnsQueries2>' >>& ${SPECIFICO}
echo "Access to DNS Queries Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/lssrc -s named" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/lssrc -s named >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Access to DNS Queries Step 2
#
echo "Access to DNS Queries Step 2"  >>& ${SPECIFICO}
echo "See '<a href=system.html#NamedConf>/etc/named.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script displays administrator login info
# 
# Administrator Login Over the Network Step 1
#
echo '<li><a href=specific.html#AdministratorLoginNetwork3>Administrator Login Over the Network</a>' >>& ${INDEXO}
echo '<a name=AdministratorLoginNetwork3>' >>& ${SPECIFICO}
echo "Administrator Login Over the Network Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Administrator Login Over the Network Step 2
#
echo "Administrator Login Over the Network Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Sulog>/var/adm/sulog</a>' file in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks if auditing is enabled and displays auditing configuration
# 
# Auditing: Backup and Restore Step 2
#
echo '<li><a href=specific.html#AuditBackup>Auditing: Backup and Restore</a>' >>& ${INDEXO}
echo '<a name=AuditBackup>' >>& ${SPECIFICO}
echo "Auditing: Backup and Restore Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#AuditQuery>/usr/sbin/audit query</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Auditing: Backup and Restore Step 3
#
echo "Auditing: Backup and Restore Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#AuditEvents>/etc/security/audit/events</a>' file in Section 2" >>& ${SPECIFICO}
echo '**************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script shows drive storage space
# 
# Authentication System Resources Step 1
#
echo '<li><a href=specific.html#AuthSysResource>Authentication System Resources</a>' >>& ${INDEXO}
echo '<a name=AuthSysResource>' >>& ${SPECIFICO}
echo "Authentication System Resources Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/df -k" >>& ${SPECIFICO}
echo '*************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/df -k >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks user account information
# 
# Command Line Access Step 1
#
echo '<li><a href=specific.html#CommandLineAccess>Command Line Access</a>' >>& ${INDEXO}
echo '<a name=CommandLineAccess>' >>& ${SPECIFICO}
echo "Command Line Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Command Line Access Step 4
#
echo "Command Line Access Step 4" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ftpusers>/ftpusers</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks for SUID, SGID, and world-writable file/directory information 
# 
# Configuration Checklist Step 1
#
echo '<li><a href=specific.html#ConfigCheck>Configuration Checklist</a>' >>& ${INDEXO}
echo '<a name=ConfigCheck>' >>& ${SPECIFICO}
echo "Configuration Checklist Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SUID>SUID and SGID</a>' files in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Configuration Checklist Step 2
#
echo "Configuration Checklist Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableDirs>world writable directories</a>' in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Configuration Checklist Step 2
#
echo "Configuration Checklist Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableFiles>world writable</a>' files in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Configuration Checklist Step 3
#
echo "Configuration Checklist Step 3" >>& ${SPECIFICO}
echo "<a href=system.html#Netstat>See 'netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script shows BIND status
# 
# Current Version of BIND Step 1
#
echo '<li><a href=specific.html#CurrentBind2>Current Version of BIND</a>' >>& ${INDEXO}
echo '<a name=CurrentBind2>' >>& ${SPECIFICO}
echo "Current Version of BIND Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/lssrc -s named" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
   /usr/bin/lssrc -s named >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script finds all files with world writeable permissions
# 
# Data File Permissions Step 1
#
echo '<li><a href=specific.html#DataFile>Data File Permissions</a>' >>& ${INDEXO}
echo '<a name=DataFile>' >>& ${SPECIFICO}
echo "Data File Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableFiles>world writable</a>' files in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows account and network information
# 
# Default Accounts Step 1
#
echo '<li><a href=specific.html#DefaultAccounts2>Default Accounts</a>' >>& ${INDEXO}
echo '<a name=DefaultAccounts2>' >>& ${SPECIFICO}
echo "Default Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Default Accounts Step 1
#
echo "Default Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityPasswd>/etc/security/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Default Accounts Step 2
#
echo "Default Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ypcat>/usr/bin/ypcat passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays contents of /etc/security/user 
# 
# Default Passwords Step 1
#
echo '<li><a href=specific.html#DefaultPasswd2>Default Passwords</a>' >>& ${INDEXO}
echo '<a name=DefaultPasswd2>' >>& ${SPECIFICO}
echo "Default Passwords Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows system umask value
# 
# Default Umask Value Step 1
#
echo '<li><a href=specific.html#DefaultUmaskValue3>Default Umask Value</a>' >>& ${INDEXO}
echo '<a name=DefaultUmaskValue3>' >>& ${SPECIFICO}
echo "Default Umask Value Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/grep umask /etc/security/user" >>& ${SPECIFICO}
echo '*************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/grep umask /etc/security/user >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows OS system and program info 
# 
# Denial of Service Attacks Step 2
#
echo '<li><a href=specific.html#DenialOfServiceAttacks3>Denial of Service Attacks</a>' >>& ${INDEXO}
echo '<a name=DenialOfServiceAttacks3>' >>& ${SPECIFICO}
echo "Denial of Service Attacks Step 2" >>& ${SPECIFICO}
echo "Displaying /usr/bin/oslevel" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/oslevel >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Denial of Service Attacks Step 3
#
echo "Denial of Service Attacks Step 3" >>& ${SPECIFICO}
echo "Displaying /usr/bin/lslpp -c -l" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/lslpp -c -l >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays file permissions of device files
#
# Device Permissions Step 1
#
echo '<li><a href=specific.html#DevicePermissions>Device Permissions</a>' >>& ${INDEXO}
echo '<a name=DevicePermissions>' >>& ${SPECIFICO}
echo "Device Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#PermissionsDev>file permissions of /dev</a>' in Section 2" >>& ${SPECIFICO}
echo '*******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# # Device Permissions Step 2
#
echo "Device Permissions Step 2" >>& ${SPECIFICO} 
echo "See '<a href=system.html#DeviceFiles>all device files</a>' in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /usr/sbin/mount
#
# Directories Mounted with the 'nosuid' Option Step 1
#
echo '<li><a href=specific.html#NoSuid>Directories Mounted with the 'nosuid' Option</a>' >>& ${INDEXO}
echo '<a name=NoSuid>' >>& ${SPECIFICO}
echo "Directories Mounted with the 'nosuid' Option Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/sbin/mount" >>& ${SPECIFICO}
echo '**************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/sbin/mount >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows access control for TCP ports
# 
# Discretionary Access Control for Internet Ports Step 1
#
echo '<li><a href=specific.html#DisAccess>Discretionary Access Control for Internet Ports</a>' >>& ${INDEXO}
echo '<a name=DisAccess>' >>& ${SPECIFICO}
echo "Discretionary Access Control for Internet Ports Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/acl" >>& ${SPECIFICO}
echo '****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/security/acl >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks if auditing is enabled and displays auditing configuration
# 
# DNS Logging Step 1
#
echo '<li><a href=specific.html#DNSLogging3>DNS Logging</a>' >>& ${INDEXO}
echo '<a name=DNSLogging3>' >>& ${SPECIFICO}
echo "DNS Logging Step " >>& ${SPECIFICO}
echo "See '<a href=system.html#AuditQuery>/usr/sbin/audit query</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# DNS Logging Step 2 
#
echo "DNS Logging Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/security/audit/objects" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/security/audit/objects >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# DNS Logging Step 3 
#
echo "DNS Logging Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#AuditEvents>/etc/security/audit/events</a>' file in Section 2" >>& ${SPECIFICO}
echo '**************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for and displays /etc/named.conf
# 
# DNS Secure Updates Step 1
#
echo '<li><a href=specific.html#DnsSecure>DNS Secure Updates</a>' >>& ${INDEXO}
echo '<a name=DnsSecure>' >>& ${SPECIFICO}
echo "DNS Secure Updates Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#NamedConf>/etc/named.conf</a>' file in Section 2"  >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows BIND status and zone transfer settings
# 
# DNS Zone Transfers Step 1
#
echo '<li><a href=specific.html#DnsZoneTransfers2>DNS Zone Transfers</a>' >>& ${INDEXO}
echo '<a name=DnsZoneTransfers2>' >>& ${SPECIFICO}
echo "DNS Zone Transfers Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/lssrc -s named" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
   /usr/bin/lssrc -s named >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# DNS Zone Transfers Step 2
#
echo "DNS Zone Transfers Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/named.conf |grep allow-transfer" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
if ( -f /etc/named.conf ) then
	cat /etc/named.conf |grep allow-transfer >>& ${SPECIFICO}
else
	echo "No /etc/named.conf file found" >>& ${SPECIFICO}
endif  
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /etc/security/login file and /etc/passwd file to check for valid shells
#
# Domain-Wide NIS Access Step 1
#
echo '<li><a href=specific.html#DomainWideNISAccess2>Domain-Wide NIS Access</a>' >>& ${INDEXO}
echo '<a name=DomainWideNISAccess2>' >>& ${SPECIFICO}
echo "Domain-Wide NIS Access Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/login.cfg" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/security/login.cfg >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Domain-Wide NIS Access Step 2
#
echo "Domain-Wide NIS Access Step 2" >>& ${SPECIFICO}
echo "Displaying '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays '/usr/bin/ypcat passwd' file to review for domain wide root accounts
#
# Domain-Wide Root Account Step 1
#
echo '<li><a href=specific.html#RootAccount>Domain-Wide Root Account</a>' >>& ${INDEXO}
echo '<a name=RootAccount>' >>& ${SPECIFICO}
echo "Domain-wide Root Account Step 1">>& ${SPECIFICO}
echo "See '<a href=system.html#Ypcat>ypcat passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows /etc/security/lastlog
# 
# Dormant Accounts Step 1
#
echo '<li><a href=specific.html#DormantAccounts3>Dormant Accounts</a>' >>& ${INDEXO}
echo '<a name=DormantAccounts3>' >>& ${SPECIFICO}
echo "Dormant Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Lastlog>/etc/security/lastlog</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows event log statistics
# 
# Event Log Disk Space Step 1
#
echo '<li><a href=specific.html#EventLog>Event Log Disk Space</a>' >>& ${INDEXO}
echo '<a name=EventLog>' >>& ${SPECIFICO}
echo "Event Log Disk Space Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/df /var/adm" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/df /var/adm >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Event Log Disk Space Step 1
#
echo "Event Log Disk Space Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/df /etc/security" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/df /etc/security >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Event Log Disk Space Step 1
#
echo "Event Log Disk Space Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/df /etc" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/df /etc >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for and displays /etc/exports
# 
# Exported File Permissions Step 1
#
echo '<li><a href=specific.html#ExportedFilePermissions2>Exported File Permissions</a>' >>& ${INDEXO}
echo '<a name=ExportedFilePermissions2>' >>& ${SPECIFICO}
echo "Exported File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/exports" >>& ${SPECIFICO}
echo '***********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/exports ) then
	cat /etc/exports >>& ${SPECIFICO}
else
	echo "No /etc/exports file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks file permissions
# 
# File Permissions Step 1
#
echo '<li><a href=specific.html#FilePermissions2>File Permissions</a>' >>& ${INDEXO}
echo '<a name=FilePermissions2>' >>& ${SPECIFICO}
echo "File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/environment" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/environment >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# File Permissions Step 1
#
echo "File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/.profile" >>& ${SPECIFICO}
echo '*********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/security/.profile >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
# 
# File Permissions Step 1
#
echo "File Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# File Permissions Step 1
#
echo "File Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#FindProfile>*.Profile</a>' files in Section 2" >>& ${SPECIFICO}
echo '*********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# File Permissions Step 2
#
echo "File Permissions Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableDirs>world writable directories</a>' in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# File Permissions Step 3
#
echo "File Permissions Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableFiles>world writable and executable</a>' files in Section 2" >>& ${SPECIFICO}
echo '******************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays /etc/inetd and /etc/syslog configuration files to review for FTP logging information
#
# FTP Logging Step 1
#
echo '<li><a href=specific.html#FtpLogging>FTP Logging</a>' >>& ${INDEXO}
echo '<a name=FtpLogging>' >>& ${SPECIFICO}
echo "FTP Logging Step 1"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# FTP Logging Step 2
#
echo "FTP Logging Step 2"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Syslog>/etc/syslog.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays different account information to check for generic accounts
#
# Generic Accounts Step 1
#
echo '<li><a href=specific.html#GenericAccounts2>Generic Accounts</a>' >>& ${INDEXO}
echo '<a name=GenericAccounts2>' >>& ${SPECIFICO}
echo "Generic Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Generic Accounts Step 1
#
echo "Generic Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ypcat>ypcat passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Generic Accounts Step 2
#
echo "Generic Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Generic Accounts Step 3
#
echo "Generic Accounts Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Sulog>/var/adm/sulog</a>' file in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Displays etc/group file to be reviewed for group membership
#
# Group Membership Step 1
#
echo '<li><a href=specific.html#GroupMembership>Group Membership</a>' >>& ${INDEXO}
echo '<a name=GroupMembership>' >>& ${SPECIFICO}
echo "Group Membership Step 1"  >>& ${SPECIFICO}
echo "See '<a href=system.html#passwd>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo "Group Membership Step 2"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays session and timeout information
#
# Idle Session Timeout Step 1
#
echo '<li><a href=specific.html#IdleSession>Idle Session Timeout</a>' >>& ${INDEXO}
echo '<a name=IdleSession>' >>& ${SPECIFICO}
echo "Idle Session Timeout Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Idle Session Timeout Step 2
#
echo "Idle Session Timeout Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Idle Session Timeout Step 3
#
echo "Idle Session Timeout Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays sendmail configuration info
#
# Insecure Sendmail Options Step 1
#
echo '<li><a href=specific.html#InsecureMail>Insecure Sendmail Options</a>' >>& ${INDEXO}
echo '<a name=InsecureMail>' >>& ${SPECIFICO}
echo "Insecure Sendmail Options Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SendmailConf>/etc/mail/sendmail.cf</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script shows user account information
# 
# Issuance of User IDs Steps 1 and 2
#
echo '<li><a href=specific.html#IssuanceUserIds2>Issuance of User IDs</a>' >>& ${INDEXO}
echo '<a name=IssuanceUserIds2>' >>& ${SPECIFICO}
echo "Issuance of User IDs Steps 1 and 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Issuance of User IDs Step 3
#
echo "Issuance of User IDs Steps 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityPasswd>/etc/security/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Issuance of User IDs Step 4
#
echo "Issuance of User IDs Step 4" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows welcome banner configurations
# 
# Legal Caption Step 1
#
echo '<li><a href=specific.html#LegalCaption>Legal Caption</a>' >>& ${INDEXO}
echo '<a name=LegalCaption>' >>& ${SPECIFICO}
echo "Legal Caption Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/login.cfg" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/security/login.cfg >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Legal Caption Step 2
#
echo "Legal Caption Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/motd" >>& ${SPECIFICO}
echo '********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/motd >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Legal Caption Step 3
#
echo "Legal Caption Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#SendmailConf>/etc/mail/sendmail.cf</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows security file logs
# 
# Log Security Events Step 1
#
echo '<li><a href=specific.html#LogSecurityEvents2>Log Security Events</a>' >>& ${INDEXO}
echo '<a name=LogSecurityEvents2>' >>& ${SPECIFICO}
echo "Log Security Events Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Sulog>/var/adm/sulog</a>' file in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 1
#
echo "Log Security Events Step 1" >>& ${SPECIFICO}
echo "Displaying who -s /etc/security/failedlogin" >>& ${SPECIFICO}
echo '********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/failedlogin ) then
	/usr/bin/who -s /etc/security/failedlogin >>& ${SPECIFICO}
else
	echo "No /etc/security/failedlogin file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Log Security Events Step 1
#
echo "Log Security Events Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Last>/usr/bin/last</a>' file in Section 2" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 1
#
echo "Log Security Events Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Lastlog>/etc/security/lastlog</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 3
#
echo "Log Security Events Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#AuditQuery>/usr/sbin/audit query</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 3
#
echo "Log Security Events Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#AuditEvents>/etc/security/audit/events</a>' file in Section 2" >>& ${SPECIFICO}
echo '**************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows login times
# 
# Login Time Restrictions Step 1
#
echo '<li><a href=specific.html#LoginTime>Login Time Restrictions</a>' >>& ${INDEXO}
echo '<a name=LoginTime>' >>& ${SPECIFICO}
echo "Login Time Restrictions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script finds all .netrc files 
# 
# .netrc Files Step 1
#
echo '<a name=Netrc>' >>& ${SPECIFICO}
echo ".netrc Files Step 1" >>& ${SPECIFICO}
echo "See '.netrc' files in Section 2" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays 'ifconfig -a' to check for a promiscuous mode NIC 
#
# Network Interface Card and Promiscuous Mode Step 1
#
echo '<li><a href=specific.html#Promiscuous>Network Interface Card and Promiscuous Mode</a>' >>& ${INDEXO}
echo '<a name=Promiscuous>' >>& ${SPECIFICO}
echo "Network Interface Card and Promiscuous Mode Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ifconfig>ifconfig -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows executable file permissions and group membership
# 
# Network Interface Packet Sniffing Step 1
#
echo '<li><a href=specific.html#NetworkInterface>Network Interface Packet Sniffing</a>' >>& ${INDEXO}
echo '<a name=NetworkInterface>' >>& ${SPECIFICO}
echo "Network Interface Packet Sniffing Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ExecutableFiles>executable</a>' files in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Network Interface Packet Sniffing Step 3
#
echo "Network Interface Packet Sniffing Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays NIS configuration
#
# NIS Alternatives
#
echo '<li><a href=specific.html#NisAlternatives2>NIS Alternatives</a>' >>& ${INDEXO}
echo '<a name=NisAlternatives2>' >>& ${SPECIFICO}
echo "NIS Alternatives Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/nisls" >>& ${SPECIFICO}
echo '*************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /usr/bin/nisls) then
	/usr/bin/nisls >>& ${SPECIFICO}
else
	echo "No 'nisls' file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays existence of '.hushlogin' files
#
# Notification of Last Login Step 1
#
echo '<li><a href=specific.html#LastLogin>Notification of Last Login</a>' >>& ${INDEXO}
echo '<a name=LastLogin>' >>& ${SPECIFICO}
echo "Notification of Last Login Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Hush>hushlogin</a>' files in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows account password information
# 
# Password Composition Step 1
#
echo '<li><a href=specific.html#PasswordComposition2>Password Composition</a>' >>& ${INDEXO}
echo '<a name=PasswordComposition2>' >>& ${SPECIFICO}
echo "Password Composition Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows account password information
# 
# Password Expiration Step 1
#
echo '<li><a href=specific.html#PasswordExpiration3>Password Expiration</a>' >>& ${INDEXO}
echo '<a name=PasswordExpiration3>' >>& ${SPECIFICO}
echo "Password Expiration Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows OS system and program info 
# 
# Patch Maintenance Step 2
#
echo '<li><a href=specific.html#PatchMaintenance3>Patch Maintenence</a>' >>& ${INDEXO}
echo '<a name=PatchMaintenance3>' >>& ${SPECIFICO}
echo "Patch Maintenance Step 2" >>& ${SPECIFICO}
echo "Displaying /usr/bin/oslevel" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/oslevel -rq >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Patch Maintenance Step 3
#
echo "Patch Maintenance Step 3" >>& ${SPECIFICO}
echo "Displaying /usr/bin/lslpp -c -l" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/lslpp -c -l >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays user and group account information
#
# Powerful Group Membership Step 1
#
echo '<li><a href=specific.html#PowerfulGroupMembership>Powerful Group Membership</a>' >>& ${INDEXO}
echo '<a name=PowerfulGroupMembership>' >>& ${SPECIFICO}
echo "Powerful Group Membership Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Powerful Group Membership Step 1
#
echo "Powerful Group Membership Step 1"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows permissions for printer spool directories
#
# Print Spool Directories Step 1
#
echo '<li><a href=specific.html#PrintSpool3>Print Spool Directories</a>' >>& ${INDEXO}
echo '<a name=PrintSpool3>' >>& ${SPECIFICO}
echo "Print Spool Directories Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /var/spool directory" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/ls -ld /var/spool >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Print Spool Directories Step 1
#
echo "Print Spool Directories Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /var/spool" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/ls -l /var/spool >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Print Spool Directories Step 1
#
echo "Print Spool Directories Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /var/spool/lpd" >>& ${SPECIFICO}
echo '****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/ls -l /var/spool/lpd >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows executable file permissions and group membership
# 
# Program File Permissions Step 1
#
echo '<li><a href=specific.html#ProgFilePermissions2>Program File Permissions</a>' >>& ${INDEXO}
echo '<a name=ProgFilePermissions2>' >>& ${SPECIFICO}
echo "Program File Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ExecutableFiles>executable</a>' files in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Program File Permissions Step 3
#
echo "Program File Permissions Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays configurations of encrypted and unencrypted network services
#
# Protection of Authentication Step 1
#
echo '<li><a href=specific.html#ProtectAuth3>Protection of Authentication</a>' >>& ${INDEXO}
echo '<a name=ProtectAuth3>' >>& ${SPECIFICO}
echo "Protection of Authentication Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}	

# Protection of Authentication Step 2
#
echo "Protection of Authentication Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Netstat>netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Protection of Authentication Step 3
#
echo "Protection of Authentication Step 3" >>& ${SPECIFICO}
echo "Displaying ssh configuration" >>& ${SPECIFICO}
echo '****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  	find / \( -fstype nfs -prune \) -o -name sshd_config -exec ls -l {} \; -exec cat {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays existence of remote printer daemon
#
# Remote Printer Daemon Step 1
#
echo '<li><a href=specific.html#RemotePrint2>Remote Printer Daemon</a>' >>& ${INDEXO}
echo '<a name=RemotePrint2>' >>& ${SPECIFICO}
echo "Remote Printer Daemon Step 1" >>& ${SPECIFICO}
echo "Displaying lssrc -s lpd" >>& ${SPECIFICO}
echo '***********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/lssrc -s lpd >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Remote Printer Daemon Steps 2 and 3

echo "Remote Printer Daemon Steps 2 and 3" >>& ${SPECIFICO}
echo "Displaying contents and permissions of /etc/hosts.lpd" >>& ${SPECIFICO}
echo '*****************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/hosts.lpd ) then
	/usr/bin/ls -al /etc/hosts.lpd >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	cat /etc/hosts.lpd >>& ${SPECIFICO}
else
	echo "No /etc/hosts.lpd file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Remote Printer Daemon Step 4

echo "Remote Printer Daemon Step 4" >>& ${SPECIFICO}
echo "Displaying permissions of /usr/spool/lpd" >>& ${SPECIFICO}
echo '****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /usr/spool/lpd ) then
	/usr/bin/ls -al /usr/spool/lpd >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
else
	echo "No /usr/spool/lpd file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script finds removable media files 
# 
# Removable Media Step 1
#
echo '<li><a href=specific.html#RemoveMedia>Removable Media</a>' >>& ${INDEXO}
echo '<a name=RemoveMedia>' >>& ${SPECIFICO}
echo "Removable Media Step 1" >>& ${SPECIFICO}
echo "Displaying remotely mounted filesystems" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  showmount -e localhost
echo '' >>& ${SPECIFICO}

# Removable Media Step 2
#
echo "Removable Media Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#DeviceFiles>device files</a>' in Section 2" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# Root Access Step 1
#
echo '<li><a href=specific.html#RootAcess>Root Access</a>' >>& ${INDEXO}
echo '<a name=RootAcess>' >>& ${SPECIFICO}
echo "Root Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Access Step 1
#
echo "Root Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Sulog>/var/adm/sulog</a>' file in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Access Step 2
#
echo "Root Access Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/security/user.roles" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/user.roles ) then
	cat /etc/security/user.roles >>& ${SPECIFICO}
else
	echo "No /etc/security/user.roles file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Root Access Step 3
#
echo "Root Access Step 3" >>& ${SPECIFICO}
echo "Displaying /etc/security/roles" >>& ${SPECIFICO}
echo '******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/roles ) then
	cat /etc/security/roles >>& ${SPECIFICO}
else
	echo "No /etc/security/roles file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Root Access Step 3
#
echo "Root Access Step 3" >>& ${SPECIFICO}
echo "Displaying /etc/security/smitacl.group" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/smitacl.group ) then
	cat /etc/security/smitacl.group >>& ${SPECIFICO}
else
	echo "No /etc/security/smitacl.group file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Root Access Step 3
#
echo "Root Access Step 3" >>& ${SPECIFICO}
echo "Displaying /etc/security/smitacl.user" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/smitacl.user ) then
	cat /etc/security/smitacl.user >>& ${SPECIFICO}
else
	echo "No /etc/security/smitacl.user file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays permissions of files in root directory
#
# Root Startup File Permissions Step 1
#
echo '<li><a href=specific.html#RootStartup2>Root Startup File Permissions</a>' >>& ${INDEXO}
echo '<a name=RootStartup2>' >>& ${SPECIFICO}
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.login'" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.login' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.profile'" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.profile' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}  

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.cshrc'" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 
	find / \( -fstype nfs -prune \) -o -name '*.cshrc' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.kshrc'" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}  
	find / \( -fstype nfs -prune \) -o -name '*.kshrc' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.emacs'" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.emacs' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.exrc'" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.exrc' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.forward'" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.forward' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Rhosts>.rhosts</a>' files in Section 2" >>& ${SPECIFICO}
echo '********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}  

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.dtprofile'" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 
	find / \( -fstype nfs -prune \) -o -name '*.dtprofile' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.Xdefaults'" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.Xdefaults' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.screenrc'" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.screenrc' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.xinitrc'" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.xinitrc' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 1
#
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of '*.zshrc'" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	find / \( -fstype nfs -prune \) -o -name '*.zshrc' -exec ls -ldb {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script shows 'profile' file contents 
# 
# Root User Path Variable Step 1 
# 
echo '<li><a href=specific.html#RootPath>RPC Services</a>' >>& ${INDEXO} 
echo '<a name=RootPath>' >>& ${SPECIFICO} 
echo "Root User Path Variable Step 1" >>& ${SPECIFICO} 
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO} 
echo '************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Root User Path Variable Step 2
#
echo "Root User Path Variable Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root User Path Variable Step 3
# 
echo "Root User Path Variable Step 3" >>& ${SPECIFICO} 
echo "See '<a href=system.html#FindProfile>.profile</a>' files in Section 2" >>& ${SPECIFICO} 
echo '***********************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Displays /usr/bin/rpcinfo file to check for RPC network services
#
# RPC Services Step 1
#
echo '<li><a href=specific.html#Rpc>RPC Services</a>' >>& ${INDEXO}
echo '<a name=Rpc>' >>& ${SPECIFICO}
echo "RPC Services Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/rpcinfo" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
            rpcinfo -p localhost >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows printer access and permissions
#
# Securing Printing Step 1
#
echo '<li><a href=specific.html#SecurePrint2>Securing Printing</a>' >>& ${INDEXO}
echo '<a name=SecurePrint2>' >>& ${SPECIFICO}
echo "Securing Printing Step 1" >>& ${SPECIFICO}
echo "Displaying permissions and contents of /etc/hosts.equiv" >>& ${SPECIFICO}
echo '*******************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/hosts.equiv ) then
	ls -l /etc/hosts.equiv >>& ${SPECIFICO}
	cat /etc/hosts.equiv >>& ${SPECIFICO}
else
	echo "No /etc/hosts.equiv file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Securing Printing Step 1
#
echo "Securing Printing Step 1" >>& ${SPECIFICO}
echo "Displaying permissions and contents of /etc/hosts.lpd" >>& ${SPECIFICO}
echo '*****************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/hosts.lpd ) then
	ls -l /etc/hosts.lpd >>& ${SPECIFICO}
	cat /etc/hosts.lpd >>& ${SPECIFICO}
else
	echo "No /etc/hosts.lpd file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays permissions of sendmail.cf file
#
# Security of Sendmail.cf File Step 1
#
echo '<li><a href=specific.html#SendmailCf>Security of Sendmail.cf File</a>' >>& ${INDEXO}
echo '<a name=SendmailCf>' >>& ${SPECIFICO}
echo "Security of Sendmail.cf File Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /etc/mail/sendmail.cf" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  ls -la /etc/mail/sendmail.cf >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /etc/mail/sendmail.cf to check for trusted clients
#
# Sendmail Trusted Clients Step 1
#
echo '<li><a href=specific.html#SendmailTrusted>Sendmail Trusted Clients</a>' >>& ${INDEXO}
echo '<a name=SendmailTrusted>' >>& ${SPECIFICO}
echo "Sendmail Trusted Clients Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SendmailCf>/etc/mail/sendmail.cf</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script shows service information
# 
# Service Information Step 1
#
echo '<li><a href=specific.html#ServiceInformation2>Service Information</a>' >>& ${INDEXO}
echo '<a name=ServiceInformation2>' >>& ${SPECIFICO}
echo "Service Information Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>&  ${SPECIFICO}

# Service Information Step 3
#
echo "Service Information Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Netstat>netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script shows single command account information
# 
# Single Command Accounts Step 1
#
echo '<li><a href=specific.html#SingleCommandAccounts2>Single Command Accounts</a>' >>& ${INDEXO}
echo '<a name=SingleCommandAccounts>' >>& ${SPECIFICO}
echo "Single Command Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Single Command Accounts Step 3
#
echo "Single Command Accounts Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityPasswd>/etc/security/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks if Trusted Computing Base is installed
#
# TCB Auditing Step 1
#
echo '<li><a href=specific.html#TcbAudit>Pluggable Authentication Module</a>' >>& ${INDEXO}
echo '<a name=TcbAudit>' >>& ${SPECIFICO}
echo "TCB Auditing Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/bin/tcbck" >>& ${SPECIFICO}
echo '*************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /usr/bin/tcbck >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows account information 
# 
# Temporary and Contractor Type Accounts Step 1 
# 
echo '<li><a href=specific.html#TempContract2>Temporary and Contractor Type Accounts</a>' >>& ${INDEXO} 
echo '<a name=TempContract2>' >>& ${SPECIFICO} 
echo "Temporary and Contractor Type Accounts Step 1" >>& ${SPECIFICO} 
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Temporary and Contractor Type Accounts Step 2
#
echo "Temporary and Contractor Type Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script shows login terminal lockout restrictions
# 
# Terminal Lockout Step 1
#
echo '<li><a href=specific.html#TermLock>Terminal Lockout </a>' >>& ${INDEXO}
echo '<a name=TermLock>' >>& ${SPECIFICO}
echo "Terminal Lockout Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/login.cfg" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/login.cfg) then
	cat /etc/security/login.cfg >>& ${SPECIFICO}
else
	echo "No /etc/security/login.cfg file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks user and group account information 
# 
# Step 1 
echo '<li><a href="specific.html#DataMod">Test Access to Data and Data Modification Utilities</a>' >>& ${INDEXO} 
echo '<a name=DataMod>' >>& ${SPECIFICO} 
echo "<b>Test Access to Data and Data Modification Utilities Step 2</b>" >>& ${SPECIFICO} 
echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script checks access to privelged IT functions
# 
# Step 1
echo '<li><a href="specific.html#PrivilegedIT">Test Access to Privileged IT Functions</a>' >>& ${INDEXO} 
echo '<a name=PrivilegedIT>' >>& ${SPECIFICO} 
echo "<b>Test Access to Privileged IT Functions Step 2</b>" >>& ${SPECIFICO} 
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' in Section 2" >>& ${SPECIFICO} 
echo '*******************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 


echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo "See '<a href=system.html#Sulog>/var/adm/sulog</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script displays the contents of the /etc/inetd file 
# 
# Step 1 
echo '<li><a href="specific.html#RemoteServices">Test Access to Remote Trusted Services</a>' >>& ${INDEXO} 
echo '<a name=RemoteServices>' >>& ${SPECIFICO} 
echo "<b>Test Access to Remote Trusted Services Step 1</b>" >>& ${SPECIFICO} 
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script displays permissions of the /etc/passwd and /etc/security/passwd files 
#
# Step 1 
echo '<li><a href="specific.html#AccesstoSecurity">Test Access to Security files</a>' >>& ${INDEXO} 
echo '<a name=DisplayPasswdFileParams>' >>& ${SPECIFICO} 
echo "<b>Test Access to Security files Step 1</b>" >>& ${SPECIFICO} 
echo '<a name=DisplayPasswdFileParams>' >>& ${SPECIFICO} 
echo "Displaying /etc/passwd Permissions" >>& ${SPECIFICO} 
echo '**********************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /etc/passwd) then 
ls -l /etc/passwd >>& ${SPECIFICO} 
else 
echo "No /etc/passwd file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 

# Script displays permissions of the /etc/security/passwd file 
# 
echo '<a name=DisplayPasswdFileParams>' >>& ${SPECIFICO} 
echo "Displaying /etc/security/passwd Permissions" >>& ${SPECIFICO} 
echo '**********************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /etc/security/passwd) then 
ls -l /etc/security/passwd >>& ${SPECIFICO} 
else 
echo "No /etc/security/passwd file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script displays the contents of the /etc/security/user file 
# 
# Step 1 
echo '<li><a href="specific.html#DefaultAccounts">Test Default Accounts & Passwords</a>' >>& ${INDEXO} 
echo '<a name=DefaultAccounts>' >>& ${SPECIFICO} 
echo "<b>Test Default Accounts & Passwords Step 1</b>" >>& ${SPECIFICO} 
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' in Section 2" >>& ${SPECIFICO} 
echo '*******************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script displays file permissions and contents of /etc/hosts.equiv 
# 
# Test For Trust Relationships Step 1 
# 
echo '<li><a href="specific.html#TrustRelationships">Test For Trust Relationships</a>' >>& ${INDEXO} 
echo '<a name=TrustRelationships>' >>& ${SPECIFICO} 
echo "<b>Test For Trust Relationships Step 1</b>" >>& ${SPECIFICO} 
echo "Displaying permissions and contents of /etc/hosts.equiv" >>& ${SPECIFICO} 
echo '**********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}
if ( -f /etc/hosts.equiv ) then 
ls -l /etc/hosts.equiv >>& ${SPECIFICO} 
cat /etc/hosts.equiv >>& ${SPECIFICO} 
else 
echo "No /etc/hosts.equiv file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO}

echo "<b>Test For Trust Relationships Step 4</b>" >>& ${SPECIFICO} 
echo "Listing .rhost files" >>& ${SPECIFICO} 
echo '**********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
 /usr/bin/find / -name '.rhosts' -exec /bin/ls -al {} \; -exec /bin/cat {} \; >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script displays the contents of the /etc/passwd and /etc/security/passwd files 
# 
# Step 1 
echo '<li><a href="specific.html#ShadowPassword">Test for Use of Shadow Password file</a>' >>& ${INDEXO} 
echo '<a name=ShadowPassword>' >>& ${SPECIFICO} 
echo "<b>Test for Use of Shadow Password File Step 1</b>" >>& ${SPECIFICO} 
echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO}

# 
echo "Default Accounts Step 1" >>& ${SPECIFICO} 
echo "See '<a href=system.html#SecurityPasswd>/etc/security/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '********************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}  
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script displays the contents of the /etc/ftpusers file 
# 
echo '<a name=DisplayFtpusersFile>' >>& ${SPECIFICO} 
echo "Displaying /etc/ftpusers file contents" >>& ${SPECIFICO} 
echo '**********************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /etc/ftpusers) then 
/usr/bin/cat /etc/ftpusers >>& ${SPECIFICO} 
else 
echo "No /etc/ftpusers file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 

echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script checks Logical Access and Segregation of Duties 
# 
# Step 1 
echo '<li><a href="specific.html#LogicalSegregation">Test Logical Access Segregation of Duties</a>' >>& ${INDEXO} 
echo '<a name=LogicalSegregation>' >>& ${SPECIFICO} 
echo "<b>Test Logical Access Segregation of Duties Step 1</b>" >>& ${SPECIFICO} 
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' in Section 2" >>& ${SPECIFICO} 
echo '*******************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo "See '<a href=system.html#Sulog>/var/adm/sulog</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script displays user and group account information 
# 
# Test Manage Change Segregation of Duties / Access to Programs     Step 2 

echo '<li><a href="specific.html#ManageSegregation">Test Manage Change Segregation of Duties</a>' >>& ${INDEXO} 
echo '<a name=ManageSegregation>' >>& ${SPECIFICO} 
echo "<b>Test Manage Change Segregation of Duties Step 2</b>" >>& ${SPECIFICO} 
echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 


echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script checks new user setup 
# 
# Step 1 
echo '<li><a href="specific.html#MonitoringUser">Test Monitoring of User Access</a>' >>& ${INDEXO} 
echo '<a name=MonitoringUser>' >>& ${SPECIFICO} 
echo "<b>Test Monitoring of User Access Step 1</b>" >>& ${SPECIFICO} 
echo "See '<a href=system.html#AuditEvents>/etc/security/audit/events</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**************************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

echo "<b>Test Monitoring of User Access Step 2</b>" >>& ${SPECIFICO} 
echo "See '<a href=system.html#Sulog>/var/adm/sulog</a>' file in Section 2" >>& ${SPECIFICO} 
echo '**************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script displays permissions of the failedlogin file 
# 
echo '<a name=DisplayPasswdFileParams>' >>& ${SPECIFICO} 
echo "Displaying /etc/security/failedlogin Permissions" >>& ${SPECIFICO} 
echo '**********************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /etc/security/failedlogin) then 
ls -l /etc/security/failedlogin >>& ${SPECIFICO} 
else 
echo "No /etc/security/failedlogin" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 

# 
echo "Displaying permissions of /var/adm/wtmp" >>& ${SPECIFICO} 
echo '***************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /var/adm/wtmp ) then 
/usr/bin/ls -l /var/adm/wtmp >>& ${SPECIFICO} 
else 
echo "No /var/adm/wtmp file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 

echo "Displaying permissions of /etc/security/lastlogin" >>& ${SPECIFICO} 
echo '*************************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /etc/security/lastlogin ) then 
/usr/bin/ls -l /etc/security/lastlogin >>& ${SPECIFICO} 
else 
echo "No /etc/security/lastlogin file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 

echo "Displaying permissions of /audit/trail" >>& ${SPECIFICO} 
echo '**************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /audit/trail ) then 
/usr/bin/ls -l /audit/trail >>& ${SPECIFICO} 
else 
echo "No /audit/trail file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 

echo "Displaying permissions of /var/adm/daemon" >>& ${SPECIFICO} 
echo '*****************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /var/adm/daemon ) then 
/usr/bin/ls -l /var/adm/daemon >>& ${SPECIFICO} 
else 
echo "No /var/adm/daemon file found" >>& ${SPECIFICO} 
endif
echo '' >>& ${SPECIFICO} 

echo "Displaying permissions of /etc/security//audit/events" >>& ${SPECIFICO} 
echo '**************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
if ( -f /etc/security//audit/events ) then 
/usr/bin/ls -l /etc/security//audit/events >>& ${SPECIFICO} 
else 
echo "No /etc/security//audit/events file found" >>& ${SPECIFICO} 
endif 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 





# Script checks new user setup 
# 
# Step 1 
echo '<li><a href="specific.html#NewUser">Test New User Setup</a>' >>& ${INDEXO} 
echo '<a name=NewUser>' >>& ${SPECIFICO} 
echo "<b>Test New User Setup Step 1</b>" >>& ${SPECIFICO}  
echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script checks Password Settings 
# 
# Step 1 
echo '<li><a href="specific.html#PasswordSettings">Test Password Settings</a>' >>& ${INDEXO} 
echo '<a name=PasswordSettings>' >>& ${SPECIFICO} 
echo "<b>Test Password Settings Step 1</b>" >>& ${SPECIFICO} 
echo "See '<a href=system.html#SecurityUser>/etc/security/user</a>' in Section 2" >>& ${SPECIFICO} 
echo '*******************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 


echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '***********************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# 
echo "See '<a href=system.html#SecurityPasswd>/etc/security/passwd</a>' file in Section 2" >>& ${SPECIFICO} 
echo '********************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# 
echo "See '<a href=system.html#Lastlog>/etc/security/lastlog</a>' file in Section 2" >>& ${SPECIFICO} 
echo '*********************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# 
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO} 
echo '************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script shows x-windows binary files
# 
# Unauthorized Monitoring of Remote X-Server Step 1
#
echo '<li><a href=specific.html#UnauthMonitor>Unauthorized Monitoring of Remote X-Server</a>' >>& ${INDEXO}
echo '<a name=UnauthMonitor>' >>& ${SPECIFICO}
echo "Unauthorized Monitoring of Remote X-Server Step 1" >>& ${SPECIFICO}
echo "Displaying xwd files and permissions" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  find / \( -fstype nfs -prune \) -o -name xwd -exec ls -al {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Unauthorized Monitoring of Remote X-Server Step 1
#
echo "Unauthorized Monitoring of Remote X-Server Step 1" >>& ${SPECIFICO}
echo "Displaying xwud files and permissions" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  find / \( -fstype nfs -prune \) -o -name xwud -exec ls -al {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /etc/passwd file
#
# Unique User IDs Step 1
#
echo '<li><a href=specific.html#UniqueUserIds>Unique User IDs</a>' >>& ${INDEXO}
echo '<a name=UniqueUserIds>' >>& ${SPECIFICO}
echo "Unique User IDs Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Displays configurations of local and network services
#
# Unnecessary Services Step 1
#
echo '<li><a href=specific.html#UnecessaryServices>Unecessary Services</a>' >>& ${INDEXO}
echo '<a name=UnecessaryServices>' >>& ${SPECIFICO}
echo "Unnecessary Services Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Netstat>netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Unnecessary Services Step 2
#
echo "Unnecessary Services Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ifconfig>ifconfig -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Unnecessary Services Step 3
#
echo "Unnecessary Services Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays permissions of /var/adm/cron and displays at.deny and at.allow, if they exist
#
# Use of AT and BATCH Commands Step 1
#
echo '<li><a href=specific.html#AtBatch3>Use of AT and BATCH Commands</a>' >>& ${INDEXO}
echo '<a name=AtBatch3>' >>& ${SPECIFICO}
echo "Use of AT and BATCH Commands Step 1"  >>& ${SPECIFICO}
echo "Displaying /var/adm/cron" >>& ${SPECIFICO}
echo '************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -d /var/adm/cron ) then
	/usr/bin/ls -l /var/adm/cron >>& ${SPECIFICO}
else
	echo "No /var/adm/cron directory found" >>& ${SPECIFICO}
endif	
echo '' >>& ${SPECIFICO}

# Use of AT and BATCH Commands Step 1
#
echo "Use of AT and BATCH Commands Step 1"  >>& ${SPECIFICO}
echo "Displaying permissions of /var/adm/cron/at.deny" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /var/adm/cron/at.deny ) then
	/usr/bin/ls -al /var/adm/cron/at.deny >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	echo "Use of AT and BATCH Commands Step 1"  >>& ${SPECIFICO}
	echo "Displaying /var/adm/cron/at.deny" >>& ${SPECIFICO}
	echo '********************************' >>& ${SPECIFICO}
	/usr/bin/cat /var/adm/cron/at.deny >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
else
	echo "No /var/adm/cron/at.deny file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Use of AT and BATCH Commands Step 1
#
echo "Use of AT and BATCH Commands Step 1"  >>& ${SPECIFICO}
echo "Displaying permissions of /var/adm/cron/at.allow" >>& ${SPECIFICO}
echo '************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /var/adm/cron/at.allow ) then
	/usr/bin/ls -al /var/adm/cron/at.allow >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	echo "Use of AT and BATCH Commands Step 1"  >>& ${SPECIFICO}
	echo "Displaying /var/adm/cron/at.allow" >>& ${SPECIFICO}
	echo '*********************************' >>& ${SPECIFICO}
	/usr/bin/cat /var/adm/cron/at.allow >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
else
	echo "No /var/adm/cron/at.allow file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Use of AT and BATCH Commands Step 2
#
echo "Use of AT and BATCH Commands Step 2"  >>& ${SPECIFICO}
echo "Displaying /usr/spool/cron/atjobs" >>& ${SPECIFICO}
echo '*********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -d /usr/spool/cron/atjobs ) then
	/usr/bin/ls -l /usr/spool/cron/atjobs >>& ${SPECIFICO}
else
	echo "No /usr/spool/cron/atjobs directory found" >>& ${SPECIFICO}
endif	
echo '' >>& ${SPECIFICO}

# Use of AT and BATCH Commands Step 3
#
echo "Use of AT and BATCH Commands Step 3"  >>& ${SPECIFICO}
echo "Displaying /usr/spool/cron/atjobs/root" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -d /usr/spool/cron/atjobs/root) then
	/usr/bin/cat /usr/spool/cron/atjobs/root >>& ${SPECIFICO}
else
	echo "No /usr/spool/cron/atjobs/root directory found" >>& ${SPECIFICO}
endif	
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Displays contents of /etc/default/cron, permissions of /usr/lib/cron, and displays at.deny and at.allow, if they exist
#
# Use of CRONTAB Command Step 1
#
echo '<li><a href=specific.html#Crontab2>Use of CRONTAB Command</a>' >>& ${INDEXO}
echo '<a name=Crontab2>' >>& ${SPECIFICO}
echo "Use of CRONTAB Command Step 1"  >>& ${SPECIFICO}
echo "Displaying /var/adm/cron" >>& ${SPECIFICO}
echo '************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -d /var/adm/cron) then
	/usr/bin/ls -l /var/adm/cron >>& ${SPECIFICO}
else
	echo "No /var/adm/cron file found " >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Use of CRONTAB Command Step 1
#
echo "Use of CRONTAB Command Step 1"  >>& ${SPECIFICO}
echo "Displaying /etc/cron.d/cron.deny" >>& ${SPECIFICO}
echo '********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /var/adm/cron/cron.deny ) then
	/usr/bin/cat /var/adm/cron/cron.deny >>& ${SPECIFICO}
else
	echo "No /var/adm/cron/cron.deny file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Use of CRONTAB Command Step 1
#
echo "Use of CRONTAB Command Step 1"  >>& ${SPECIFICO}
echo "Displaying /var/adm/cron/cron.allow" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /var/adm/cron/cron.allow ) then
	/usr/bin/cat /var/adm/cron/cron.allow >>& ${SPECIFICO}
else
	echo "No /var/adm/cron/cron.allow file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Use of CRONTAB Command Step 3
#
echo "Use of CRONTAB Command Step 3"  >>& ${SPECIFICO}
echo "Displaying permissions of /usr/spool/cron/crontabs" >>& ${SPECIFICO}
echo '**************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/ls -al /usr/spool/cron/crontabs >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of CRONTAB Command Step 3
#
echo "Use of CRONTAB Command Step 3"  >>& ${SPECIFICO}
echo "Displaying current jobs for each cron user" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/cat /usr/spool/cron/crontabs/* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for Sendmail through netstat
#
# Use of Sendmail Step 1
#
echo '<li><a href=specific.html#UseOfSendmail3>Use of Sendmail</a>' >>& ${INDEXO}
echo '<a name=UseOfSendmail3>' >>& ${SPECIFICO}
echo "Use of Sendmail Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Netstat>netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows world writeable directories
#
# Use of  Sticky Bit Step 1
#
echo '<li><a href=specific.html#UseOfSticky>Use of  Sticky Bit</a>' >>& ${INDEXO}
echo '<a name=UseOfSticky>' >>& ${SPECIFICO}
echo "Use of the Sticky Bit Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableDirs>world writable directories</a>' in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays existence of SUID and SGID files
#
# Use of SUID and SGID Programs Step 1
#
echo '<li><a href=specific.html#UseOfSuid>Use of SUID and SGID Programs</a>' >>& ${INDEXO}
echo '<a name=UseOfSuid>' >>& ${SPECIFICO}
echo "Use of SUID and SGID Programs Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SUID>SUID</a>' files in Section 2" >>& ${SPECIFICO}
echo '*****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of SUID and SGID Programs Step 1
#
echo "Use of SUID and SGID Programs Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#SUID>SGID</a>' files in Section 2" >>& ${SPECIFICO}
echo '*****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script looks for TCP wrappers
# 
# Use of TCP Wrappers Step 1
#
echo '<li><a href=specific.html#UseOfTcpWrap2>Use of TCP Wrappers</a>' >>& ${INDEXO}
echo '<a name=UseOfTcpWrap2>' >>& ${SPECIFICO}
echo "Use of TCP Wrappers Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of TCP Wrappers Step 1
#
echo "Use of TCP Wrappers Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/hosts.allow" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/hosts.allow) then
	cat /etc/hosts.allow >>& ${SPECIFICO}
else
	echo "No /etc/hosts.allow file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Use of TCP Wrappers Step 1
#
echo "Use of TCP Wrappers Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/hosts.deny" >>& ${SPECIFICO}
echo '**************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/hosts.deny) then
	cat /etc/hosts.deny >>& ${SPECIFICO}
else
	echo "No /etc/hosts.deny file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows system processes
# 
# Use of TFTP Step 1
#
echo '<li><a href=specific.html#UseOfTftp2>Use of TFTP</a>' >>& ${INDEXO}
echo '<a name=UseOfTftp2>' >>& ${SPECIFICO}
echo "Use of TFTP Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of TFTP Step 2
#
echo "Use of TFTP Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /etc/passwd file
#
# User Description Step 1
#
echo '<li><a href=specific.html#UserDescription>User Description</a>' >>& ${INDEXO}
echo '<a name=UserDescription>' >>& ${SPECIFICO}
echo "User Description Step 1" >>& ${SPECIFICO}
echo "<a href=system.html#DisplayPasswdFile>See '/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /etc/passwd file
#
# User Home Directory Step 1
#
echo '<li><a href=specific.html#UserHome>User Home Directory</a>' >>& ${INDEXO}
echo '<a name=UserHome>' >>& ${SPECIFICO}
echo "User Home Directory Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /etc/passwd file
#
# User ID Naming Convention Step 1
#
echo '<li><a href=specific.html#UserIdNamingConvention>User ID Naming Convention</a>' >>& ${INDEXO}
echo '<a name=UserIdNamingConvention>' >>& ${SPECIFICO}
echo "User ID Naming Convention Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# User ID Numbers Step 1
#
echo '<li><a href=specific.html#UserIdNumber>User ID Numbers</a>' >>& ${INDEXO}
echo '<a name=UserIdNumber>' >>& ${SPECIFICO}
echo "User ID Numbers Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}



# Script shows user account information
# 
# User Rights: Backup and Restore Step 1
#
echo '<li><a href=specific.html#UserBackup2>User Rights: Backup and Restore</a>' >>& ${INDEXO}
echo '<a name=UserBackup2>' >>& ${SPECIFICO}
echo "User Rights: Backup and Restore Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/user.roles" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}  
if ( -f /etc/security/user.roles ) then
	cat /etc/security/user.roles >>& ${SPECIFICO}
else
	echo "No /etc/security/user.roles file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# User Rights: Backup and Restore Step 2
#
echo "User Rights: Backup and Restore Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/security/roles" >>& ${SPECIFICO}
echo '******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/roles ) then
	cat /etc/security/roles >>& ${SPECIFICO}
else
	echo "No /etc/security/roles file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# User Rights: Backup and Restore Step 2
#
echo "User Rights: Backup and Restore Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/security/smitacl.group" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/smitacl.group ) then
	cat /etc/security/smitacl.group >>& ${SPECIFICO}
else
	echo "No /etc/security/smitacl.group file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# User Rights: Backup and Restore Step 2
#
echo "User Rights: Backup and Restore Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/security/smitacl.user" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 
if ( -f /etc/security/smitacl.user ) then
	cat /etc/security/smitacl.user >>& ${SPECIFICO}
else
	echo "No /etc/security/smitacl.user file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user shells
# 
# User Shells Step 1
#
echo '<li><a href=specific.html#UserShells2>User Shells</a>' >>& ${INDEXO}
echo '<a name=UserShells2>' >>& ${SPECIFICO}
echo "User Shells Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/login.cfg" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/login.cfg) then
	cat /etc/security/login.cfg >>& ${SPECIFICO}
else
	echo "No /etc/security/login.cfg file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks for the UUCP service
#
# UUCP Usage Step 1
#
echo '<li><a href=specific.html#UucpUse2>UUCP Usage</a>' >>& ${INDEXO} 
echo '<a name=UucpUse2>' >>& ${SPECIFICO} 
echo "UUCP Usage Step 1" >>& ${SPECIFICO}
echo "Displaying 'lslpp' file " >>& ${SPECIFICO}
echo '************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/lslpp -c -l | grep uucp >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 2
#
echo "UUCP Usage Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityPasswd>/etc/security/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 3 
#
echo "UUCP Usage Step 3"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Inetd>/etc/inetd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 4
#
echo "UUCP Usage Step 4" >>& ${SPECIFICO}
echo "Displaying /etc/uucp/Devices" >>& ${SPECIFICO}
echo '****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/uucp/Devices ) then
	cat /etc/uucp/Devices >>& ${SPECIFICO}
else
	echo "No /etc/uucp/Devices file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 4
#
echo "UUCP Usage Step 4" >>& ${SPECIFICO}
echo "Displaying /etc/uucp/Dialers" >>& ${SPECIFICO}
echo '****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/uucp/Dialers ) then
	cat /etc/uucp/Dialers >>& ${SPECIFICO}
else
	echo "No /etc/uucp/Dialers file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 4
#
echo "UUCP Usage Step 4" >>& ${SPECIFICO}
echo "Displaying /etc/uucp/Systems" >>& ${SPECIFICO}
echo '****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/uucp/Systems ) then
	cat /etc/uucp/Systems >>& ${SPECIFICO}
else
	echo "No /etc/uucp/Systems file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 4
#
echo "UUCP Usage Step 4" >>& ${SPECIFICO}
echo "Displaying /etc/uucp/Permissions" >>& ${SPECIFICO}
echo '********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/uucp/Permissions ) then
	cat /etc/uucp/Permissions >>& ${SPECIFICO}
else
	echo "No /etc/uucp/Permissions file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user accounts
# 
# Vendor Support Accounts Step 1
#
echo '<li><a href=specific.html#VendorSupportAccounts2>Vendor Support Accounts</a>' >>& ${INDEXO}
echo '<a name=VendorSupportAccounts2>' >>& ${SPECIFICO}
echo "Vendor Support Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Vendor Support Accounts Step 2
#
echo "Vendor Support Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#SecurityPasswd>/etc/security/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

#################################################################
#
# This portion should remain at the bottom of this script
#
################################################################

# Output file

if $case == 3 then
        mv Aumyaa_SybaseDBDump.html /${outdir}
        goto cleanup
else

cat ${INDEXO}  >>& ${TEXTO}
echo "*****************************" >>& ${TEXTO}
echo "-----------------------------" >>& ${TEXTO}
echo "SECTION 1: SPECIFIC WORKSTEPS" >>& ${TEXTO}
echo "-----------------------------" >>& ${TEXTO}
echo "*****************************" >>& ${TEXTO}
echo '' >>& ${TEXTO}
cat ${SPECIFICO} >>& ${TEXTO}
echo "******************************" >>& ${TEXTO}
echo "------------------------------" >>& ${TEXTO}
echo "SECTION 2: COMMON SYSTEM FILES" >>& ${TEXTO}
echo "------------------------------" >>& ${TEXTO}
echo "******************************" >>& ${TEXTO}
echo '' >>& ${TEXTO}
cat ${SYSTEMO} >>& ${TEXTO}

cleanup:

sleep 3
 clear
  echo ""
  echo "          ---------------------------------------------------"
  echo "          All finished.  What's next?"
  echo ""
  echo "           1) Exit"
  echo -n "           Enter Selection: "
   set CLEANUPTYPE=$<

   switch ($CLEANUPTYPE)
   case 1:
        goto quit
   default:
        clear
        echo "Invalid selection"
        echo -n "$prompt"
        set tmp=$<
        goto cleanup
  endsw

sleep 5
goto cleanup

quit:
 clear
  echo "          ---------------------------------------------------"
 echo "          The Aumya Report File is located in:"
 echo "          '${outdir}'"
 echo ""
 echo "          Thanks for your cooperation"
 echo ""
 echo ""
exit 1