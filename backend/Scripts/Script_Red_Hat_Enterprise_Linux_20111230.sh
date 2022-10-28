#!/bin/csh

############################################################

#!/bin/csh
#
#
# -------------------------------------
# Aumyaa UNIX Audit Script
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
  echo ""
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
		set TEXTO=${outdir}/Aumyaa-${HOSTNAME}.txt
                touch ${INDEXO}
                touch ${SPECIFICO}
                touch ${SYSTEMO}
                        # Add new html output files to the list here:
                        echo "<html><head><title>specific.out</title></head><body><h1>Specific to this  flavor of UNIX</h1><pre>" > ${SPECIFICO}
                        echo "<html><head><title>system.out</title></head><body><h1>System  files</h1><pre>" > ${SYSTEMO}
                        echo "<html><head><title>UNIX Script</title></head><body><h1>Aumyaa UNIX  Script</h1>" > ${INDEXO}
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

# Script shows user account information
# 
echo '<a name=LoginDefs>' >>& ${SYSTEMO}
echo "Displaying /etc/login.defs" >>& ${SYSTEMO}
echo '**************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
  cat /etc/login.defs >>& ${SYSTEMO}
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

# Displays OpenLDAP network communication information
#
echo '<a name=OpenLDAP>' >>& ${SYSTEMO}
echo "Displaying /etc/openldap/slapd.conf" >>& ${SYSTEMO}
echo '************************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
  cat /etc/openldap/slapd.conf >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/pam.d/system-auth file
#
echo '<a name=PamdSys>' >>& ${SYSTEMO}
echo "Displaying etc/pam.d/system-auth" >>& ${SYSTEMO}
echo '********************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
if ( -f /etc/pam.d/system-auth ) then
	cat /etc/pam.d/system-auth >>& ${SYSTEMO}
else
	echo "No /etc/pam.d/system-auth file found" >>& ${SYSTEMO}
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

# Script displays /etc/shadow file
# 
echo '<a name=Shadow>' >>& ${SYSTEMO}
echo "Displaying /etc/shadow" >>& ${SYSTEMO}
echo '**********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	if ( -f /etc/shadow) then
		cat /etc/shadow >>& ${SYSTEMO}
	else
		echo "No /etc/shadow file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script displays /etc/shells file
# 
echo '<a name=Shells>' >>& ${SYSTEMO}
echo "Displaying /etc/shells" >>& ${SYSTEMO}
echo '**********************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
	if ( -f /etc/shells) then
		cat /etc/shells >>& ${SYSTEMO}
	else
		echo "No /etc/shells file found" >>& ${SYSTEMO}
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

# Script displays vsftpd.conf file
# 
echo '<a name=VsftpdConf>' >>& ${SYSTEMO}
echo "Displaying /etc/vsftpd/vsftpd.conf" >>& ${SYSTEMO} 
echo '************************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO}
	if ( -f /etc/vsftpd/vsftpd.conf) then
		cat /etc/vsftpd/vsftpd.conf >>& ${SYSTEMO}
	else
		echo "No /etc/vsftpd/vsftpd.conf file found" >>& ${SYSTEMO}
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

# Script checks for services
# 
echo '<a name=ChkConfig>' >>& ${SYSTEMO}
echo "Displaying /sbin/chkconfig --list" >>& ${SYSTEMO} 
echo '*********************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
	/sbin/chkconfig --list >>& ${SYSTEMO} 
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

# Script displays /var/log/messages
#
echo '<a name=Messages>' >>& ${SYSTEMO}
echo "Displaying /var/log/messages" >>&  ${SYSTEMO}
echo '****************************' >>&  ${SYSTEMO}
echo '' >>&  ${SYSTEMO}
if ( -f /var/log/messages ) then
	cat /var/log/messages >>&  ${SYSTEMO}
else
	echo "No /var/log/messages file found" >>&  ${SYSTEMO}
endif
echo '' >>&  ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays /var/log/secure file 
# 
echo '<a name=Secure>' >>& ${SYSTEMO}
echo "Displaying /var/log/secure" >>& ${SYSTEMO} 
echo '**************************' >>& ${SYSTEMO} 
echo '' >>& ${SYSTEMO} 
if ( -f /var/log/secure) then 
cat /var/log/secure >>& ${SYSTEMO} 
else 
echo "No /var/log/secure file found" >>& ${SYSTEMO} 
endif 
echo '' >>& ${SYSTEMO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script displays ftp configuration files
#
echo '<a name=Vsftpd>' >>& ${SYSTEMO}
echo "Displaying /etc/vsftpd.ftpusers" >>& ${SYSTEMO}
echo '*******************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
if ( -f /etc/vsftpd.ftpusers ) then
	cat /etc/vsftpd.ftpusers >>& ${SYSTEMO}
else
	echo "No /etc/vsftpd.ftpusers file found" >>& ${SYSTEMO}
endif
echo '' >>& ${SYSTEMO}

echo "Displaying /etc/ftpaccess" >>& ${SYSTEMO}
echo '*************************' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}
if ( -f /etc/ftpaccess ) then
	cat /etc/ftpaccess >>& ${SYSTEMO}
else
	echo "No /etc/ftpaccess file found" >>& ${SYSTEMO}
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
echo '<li><a href=specific.html#DnsQueries4>Access to DNS Queries</a>' >>& ${INDEXO}
echo '<a name=DnsQueries4>' >>& ${SPECIFICO}
echo "Access to DNS Queries Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#OpenPorts>netstat -an</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Access to DNS Queries Step 2
#
echo "Access to DNS Queries Step 2"  >>& ${SPECIFICO}
echo "See '<a href=system.html#NamedConf>/etc/named.conf</a>' file in Section 2"  >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks for access to Samba
# 
# Access to Samba shares Step 1
#
echo '<li><a href=specific.html#SambaShares>Access to Samba shares</a>' >>& ${INDEXO}
echo '<a name=SambaShares>' >>& ${SPECIFICO}
echo "Access to Samba shares Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/samba/smb.conf" >>& ${SPECIFICO}
echo '******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/samba/smb.conf ) then
	cat /etc/samba/smb.conf >>& ${SPECIFICO}
else
	echo "No /etc/samba/smb.conf" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Access to Samba shares Step 2
#
echo "Access to Samba shares Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/samba/smb.conf | grep 'guest account'" >>& ${SPECIFICO}
echo '*****************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/samba/smb.conf ) then
	cat /etc/samba/smb.conf | grep 'guest account' >>& ${SPECIFICO}
else
	echo "No /etc/samba/smb.conf file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks for FTP service
# 
# Access to the FTP Service Step 1
#
echo '<li><a href=specific.html#FtpService>Access to the FTP Service</a>' >>& ${INDEXO}
echo '<a name=FtpService>' >>& ${SPECIFICO}
echo "Access to the FTP Service Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Access to the FTP Service Step 2
#
echo "Access to the FTP Service Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>vsftpd.ftpusers</a>' in Section 2" >>& ${SPECIFICO}
echo '********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Access to the FTP Service Step 2
#
echo "Access to the FTP Service Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>/ftpaccess</a>' in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Access to the FTP Service Step 2
#
echo "Access to the FTP Service Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ftpusers>/ftpusers</a>' file in Section 2" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks if accounts can be locked
# 
# Account Lockout Step 1
#
echo '<li><a href=specific.html#AccountLockout5>Account Lockout</a>' >>& ${INDEXO}
echo '<a name=AccountLockout5>' >>& ${SPECIFICO}
echo "Account Lockout Step 1" >>& ${SPECIFICO}
echo "Displaying /var/log/faillog" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /var/log/faillog ) then
	ls -al /var/log/faillog >>& ${SPECIFICO}
else
	echo "No /var/log/faillog file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Account Lockout Step 2
#
echo "Account Lockout Step 2" >>& ${SPECIFICO}
echo "Displaying login configuration files in /etc/pam.d" >>& ${SPECIFICO}
echo '**************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	ls /etc/pam.d/gdm >>& ${SPECIFICO}
	cat /etc/pam.d/gdm >>& ${SPECIFICO}
	ls /etc/pam.d/ftp >>& ${SPECIFICO}
	cat /etc/pam.d/ftp >>& ${SPECIFICO}
	ls /etc/pam.d/login >>& ${SPECIFICO}
	cat /etc/pam.d/login >>& ${SPECIFICO}
	ls /etc/pam.d/rlogin >>& ${SPECIFICO}
	cat /etc/pam.d/rlogin >>& ${SPECIFICO}
	ls /etc/pam.d/sshd >>& ${SPECIFICO}
	cat /etc/pam.d/sshd >>& ${SPECIFICO}
	ls /etc/pam.d/system-auth >>& ${SPECIFICO}
	cat /etc/pam.d/system-auth >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks for administrator remote login
# 
# Administrator Login Over the Network Step 1
#
echo "Administrator Login Over the Network Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/access.conf" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/access.conf ) then
	cat /etc/security/access.conf >>& ${SPECIFICO}
else
	echo "No /etc/security/access.conf file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Administrator Login Over the Network Step 2
#
echo "Administrator Login Over the Network Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Administrator Login Over the Network Step 3
#
echo "Administrator Login Over the Network Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Secure>/var/log/secure</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO} 

# Script checks for FTP service
# 
# Anonymous Login to FTP Step 1
#
echo '<li><a href=specific.html#AnonymousLoginFTP2>Anonymous Login to FTP</a>' >>& ${INDEXO}
echo '<a name=AnonymousLoginFTP2>' >>& ${SPECIFICO}
echo "Anonymous Login to FTP Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Anonymous Login to FTP Step 2
#
echo "Anonymous Login to FTP Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>vsftpd.ftpusers</a>' in Section 2" >>& ${SPECIFICO} 
echo '********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Anonymous Login to FTP Step 2
#
echo "Anonymous Login to FTP Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>/ftpaccess</a>' in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Anonymous Login to FTP Step 2
#
echo "Anonymous Login to FTP Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ftpusers>/ftpusers</a>' file in Section 2" >>& ${SPECIFICO} 
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Script checks for scheduled cron jobs and backups
# 
# Auditing: Backup and Restore Step 2
#
echo '<li><a href=specific.html#AuditBackup2>Auditing: Backup and Restore</a>' >>& ${INDEXO}
echo '<a name=AuditBackup2>' >>& ${SPECIFICO}
echo "Auditing: Backup and Restore Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/crontab" >>& ${SPECIFICO}
echo '***********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/crontab >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Auditing: Backup and Restore Step 3
#
echo "Auditing: Backup and Restore Step 3" >>& ${SPECIFICO}
echo "Displaying permissions of /var/spool/cron jobs" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -d /var/spool/cron ) then
	ls -al /var/spool/cron >>& ${SPECIFICO}
else
	echo "No /var/spool/cron directory found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks permissions to the C compilers
# 
# C Compiler Step 1
#
echo '<li><a href=specific.html#CCompiler>C Compiler</a>' >>& ${INDEXO}
echo '<a name=CCompiler>' >>& ${SPECIFICO}
echo "C Compiler Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /usr/bin/gcc" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /usr/bin/gcc ) then
	ls -al /usr/bin/gcc >>& ${SPECIFICO}
else
	echo "No /usr/bin/gcc file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# C Compiler Step 1
#
echo "C Compiler Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /usr/bin/cc" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /usr/bin/cc ) then
	ls -al /usr/bin/cc >>& ${SPECIFICO}
else
	echo "No /usr/bin/cc" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script checks log file for clock synchronization
# 
# Clock Synchronization Step 1
#
echo '<li><a href=specific.html#ClockSynchornization3>Clock Synchronization</a>' >>& ${INDEXO}
echo '<a name=ClockSynchornization3>' >>& ${SPECIFICO}
echo "Clock Synchronization Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Messages>/var/log/messages</a>' file in Section 2" >>& ${SPECIFICO}
echo '*****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Displays account access
#
# Command Line Access Step 1
#
echo '<li><a href=specific.html#CommandLineAccess12>Command Line Access</a>' >>& ${INDEXO}
echo '<a name=CommandLineAccess2>' >>& ${SPECIFICO}
echo "Command Line Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Command Line Access Step 2
#
echo "Command Line Access Step 2" >>& ${SPECIFICO}
echo "Displaying shell files for bash users" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  find /home \( -fstype nfs -prune \) -o \( -name .bash_profile -o -name .bashrc \) -print -exec ls -al {} \; -exec cat {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Command Line Access Step 3
#
echo "Command Line Access Step 3" >>& ${SPECIFICO}
echo "Displaying shell files for korn, shell, bourne, and trusted users" >>& ${SPECIFICO}
echo '*****************************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  find /home \( -fstype nfs -prune \) -o -name .profile -print -exec ls -al {} \; -exec cat {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Command Line Access Step 4
#
echo "Command Line Access Step 4" >>& ${SPECIFICO}
echo "Displaying shell files for c-shell users" >>& ${SPECIFICO}
echo '****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  find /home \( -fstype nfs -prune \) -o \( -name .cshrc -o -name .login -o -name .logout \) -print -exec ls -al {} \; -exec cat {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Command Line Access Step 5
#
echo "Command Line Access Step 5" >>& ${SPECIFICO} 
echo "See '<a href=system.html#Vsftpd>vsftpd.ftpusers</a>' in Section 2" >>& ${SPECIFICO} 
echo '********************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Command Line Access Step 5 
# 
echo "Command Line Access Step 5" >>& ${SPECIFICO} 
echo "See '<a href=system.html#Vsftpd>/ftpaccess</a>' in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO} 

# Command Line Access Step 5 
# 
echo "Command Line Access Step 5" >>& ${SPECIFICO} 
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

# Script displays file permissions and contents of /etc/hosts.equiv
#
# Control Trust Relationships Step 1
#
echo '<li><a href=specific.html#ControlTrustRelationships>Control Trust Relationships</a>' >>& ${INDEXO}
echo '<a name=ControlTrustRelationships>' >>& ${SPECIFICO}
echo "Control Trust Relationships Step 1" >>& ${SPECIFICO}
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


# Script checks for bind version
# 
# Current Version of Bind Step 1
#
echo '<li><a href=specific.html#CurrentBind3>Current Version of Bind</a>' >>& ${INDEXO}
echo '<a name=CurrentBind3>' >>& ${SPECIFICO}
echo "Current Version of Bind Step 1" >>& ${SPECIFICO}
echo "Displaying Bind Version" >>& ${SPECIFICO}
echo '***********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  rpm -q bind >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for NIS version
# 
# Current Version of NIS Step 1
#
echo '<li><a href=specific.html#CurrentNis>Current Version of NIS</a>' >>& ${INDEXO}
echo '<a name=CurrentNis>' >>& ${SPECIFICO}
echo "Current Version of NIS Step 1" >>& ${SPECIFICO}
echo "Displaying NIS Version" >>& ${SPECIFICO}
echo '**********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  rpm -q ypserv >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays password status for accounts and NIS/NIS+, if applicable
#
# Default Accounts Step 1
#
echo '<li><a href=specific.html#DefaultAccounts4>Default Accounts</a>' >>& ${INDEXO}
echo '<a name=DefaultAccounts4>' >>& ${SPECIFICO}
echo "Default Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shadow>/etc/shadow</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Default Accounts Step 2
#
echo "Default Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ypcat>/usr/bin/ypcat passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script displays system umask value and users utilizing other umask values
#
# Default Umask Value Step 1
#
echo '<li><a href=specific.html#DefaultUmaskValue5>Default Umask Value</a>' >>& ${INDEXO}
echo '<a name=DefaultUmaskValue5>' >>& ${SPECIFICO}
echo "Default Umask Value Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/bashrc" >>& ${SPECIFICO}
echo '**********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	if ( -f /etc/bashrc ) then
		cat /etc/bashrc >>& ${SPECIFICO}
	else
		echo "No /etc/bashrc file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Default Umask Value Step 1
#
echo "Default Umask Value Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Default Umask Value Step 2
#
echo "Default Umask Value Step 2" >>& ${SPECIFICO}
echo "Displaying user login scripts that define umask" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/bin/grep -r umask /home/*/.bashrc >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays file permissions of device files
#
# Device Permissions Step 1
#
echo '<li><a href=specific.html#DevicePermissions4>Device Permissions</a>' >>& ${INDEXO}
echo '<a name=DevicePermissions4>' >>& ${SPECIFICO}
echo "Device Permissions Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#PermissionsDev>file permissions of /dev</a>' in Section 2" >>& ${SPECIFICO}
echo '*******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# # Device Permissions Step 2
#
echo "Device Permissions Step 2" >>& ${SPECIFICO} 
echo "See 'all device files' in Section 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#DeviceFiles>all device files</a>' in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays mounted directories
#
# Directories Mounted with the 'nosuid' Option Step 1
#
echo '<li><a href=specific.html#NoSuid3>Directories Mounted with the 'nosuid' Option</a>' >>& ${INDEXO}
echo '<a name=NoSuid3>' >>& ${SPECIFICO}
echo "Directories Mounted with the 'nosuid' Option Step 1" >>& ${SPECIFICO}
echo "Displaying /bin/mount" >>& ${SPECIFICO}
echo '*********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/mount >>& ${SPECIFICO}
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

# Script displays configuration file to review for access to DNS zone transfers
#
#  DNS Zone Transfers Step 1
#
echo '<li><a href=specific.html#DnsZoneTransfers>DNS Zone Transfers</a>' >>& ${INDEXO}
echo '<a name=DnsZoneTransfers>' >>& ${SPECIFICO}
echo "DNS Zone Transfers Step 1"  >>& ${SPECIFICO}
echo "See '<a href=system.html#NamedConf>/etc/named.conf</a>' file in Section 2"  >>& ${SPECIFICO}
echo '****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays /etc/shells file and /etc/passwd file to check for valid shells
#
# Domain-Wide NIS Access Step 1
#
echo '<li><a href=specific.html#DomainWideNISAccess>Domain-Wide NIS Access</a>' >>& ${INDEXO}
echo '<a name=DomainWideNISAccess>' >>& ${SPECIFICO}
echo "Domain-Wide NIS Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shells>/etc/shells</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Domain-Wide NIS Access Step 2
#
echo "Domain-Wide NIS Access Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
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

# Script checks last user logins for dormant accounts
# 
# Dormant Accounts Step 1
#
echo '<li><a href=specific.html#DormantAccounts2>Dormant Accounts</a>' >>& ${INDEXO}
echo '<a name=DormantAccounts2>' >>& ${SPECIFICO}
echo "Dormant Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Last>/usr/bin/last</a>' file in Section 2" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Dormant Accounts Step 1
#
echo "Dormant Accounts Step 1" >>& ${SPECIFICO}
echo "See previous '<a href=system.html#Last>/usr/bin/last</a>' files in Section 2" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks filesystem information

# Encrypt File System Step 1
#
echo '<li><a href=specific.html#EncryptFile>Encrypt File System</a>' >>& ${INDEXO}
echo '<a name=EncryptFile>' >>& ${SPECIFICO}
echo "Encrypt File System Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/fstab" >>& ${SPECIFICO}
echo '*********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/fstab >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows event log statistics
# 
# Event Log Disk Space Step 1
#
echo '<li><a href=specific.html#EventLog2>Event Log Disk Space</a>' >>& ${INDEXO}
echo '<a name=EventLog2>' >>& ${SPECIFICO}
echo "Event Log Disk Space Step 1" >>& ${SPECIFICO}
echo "Displaying df -k" >>& ${SPECIFICO}
echo '****************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  df -k >>& ${SPECIFICO}
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

# Script shows file permissions
#
# File Permissions Step 1
#
echo '<li><a href=specific.html#FilePermissions3>File Permissions</a>' >>& ${INDEXO}
echo '<a name=FilePermissions3>' >>& ${SPECIFICO}
echo "File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying root path variable" >>& ${SPECIFICO}
echo '*****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/echo $PATH >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# File Permissions Step 2
#
echo "File Permissions Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableDirs>world writable directories</a>' in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# File Permissions Step 4
#
echo "File Permissions Step 4" >>& ${SPECIFICO}
echo "See '<a href=system.html#WorldWriteableFiles>world writable and executable</a>' files in Section 2" >>& ${SPECIFICO}
echo '******************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for FTP Logging

# FTP Logging Step 1
#
echo '<li><a href=specific.html#FtpLogging2>FTP Logging</a>' >>& ${INDEXO}
echo '<a name=FtpLogging2>' >>& ${SPECIFICO}
echo "FTP Logging Step 1" >>& ${SPECIFICO}
echo "See '/etc/vsftpd/vsftpd.conf' file in Section 2" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# FTP Logging Step 1
#
echo "FTP Logging Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>/ftpaccess</a>' in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# FTP Logging Step 1
#
echo "FTP Logging Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/xinetd.d/wu-ftpd" >>& ${SPECIFICO}
echo '********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	cat /etc/xinetd.d/wu-ftpd >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Displays /etc/group file to be reviewed for group membership
#
# Group Management Step 1
#
echo '<li><a href=specific.html#GroupManagement>Group Management</a>' >>& ${INDEXO}
echo '<a name=GroupManagement>' >>& ${SPECIFICO}
echo "Group Management Step 1"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Displays session and timeout information
#
# Idle Session Timeout Step 1
#
echo '<li><a href=specific.html#IdleSession2>Idle Session Timeout</a>' >>& ${INDEXO}
echo '<a name=IdleSession2>' >>& ${SPECIFICO}
echo "Idle Session Timeout Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Idle Session Timeout Step 2
#
echo "Idle Session Timeout Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Idle Session Timeout Step 3
#
echo "Idle Session Timeout Step 3" >>& ${SPECIFICO}
echo "Displaying user login scripts that utilize an alternative timeout" >>& ${SPECIFICO}
echo '*****************************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/bin/grep -r TMOUT /home/ >>& ${SPECIFICO}
	/bin/grep -r TIMEOUT /home/ >>& ${SPECIFICO}
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
# Issuance of User IDs Step 1
#
echo '<li><a href=specific.html#IssuanceUserIds4>Issuance of User IDs</a>' >>& ${INDEXO}
echo '<a name=IssuanceUserIds4>' >>& ${SPECIFICO}
echo "Issuance of User IDs Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#LoginDefs>/etc/login.defs</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Issuance of User IDs Step 2
#
echo "Issuance of User IDs Steps 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shadow>/etc/shadow</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Issuance of User IDs Step 3
#
echo "Issuance of User IDs Step 3" >>& ${SPECIFICO}
echo "Displaying '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows welcome banner configurations
# 
# Legal Caption Step 1
#
echo '<li><a href=specific.html#LegalCaption3>Legal Caption</a>' >>& ${INDEXO}
echo '<a name=LegalCaption3>' >>& ${SPECIFICO}
echo "Legal Caption Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Legal Caption Step 2
#
echo "Legal Caption Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/issue.net" >>& ${SPECIFICO}
echo '*************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/issue.net >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Legal Caption Step 4
#
echo "Legal Caption Step 4" >>& ${SPECIFICO}
echo "Displaying /etc/issue" >>& ${SPECIFICO}
echo '*********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/issue >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Legal Caption Step 5
#
echo "Legal Caption Step 5" >>& ${SPECIFICO}
echo "Displaying /etc/motd" >>& ${SPECIFICO}
echo '********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/motd >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks FTP configuration

# Limited FTP Commands Step 1
#
echo '<li><a href=specific.html#LimitedFtp>Limited FTP Commands</a>' >>& ${INDEXO}
echo '<a name=LimitedFtp>' >>& ${SPECIFICO}
echo "Limited FTP Commands Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#VsftpdConf>/etc/vsftpd/vsftpd.conf' in Section 2" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Limited FTP Commands Step 1
#
echo "Limited FTP Commands Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>/ftpaccess</a>' in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows file permissions for log files
# 
# Log File Access Step 1
#
echo '<li><a href=specific.html#LogFileAccess4>Log File Access</a>' >>& ${INDEXO}
echo '<a name=LogFileAccess4>' >>& ${SPECIFICO}
echo "Log File Access Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /var/log" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -d /var/log ) then
	/bin/ls -l /var/log >>& ${SPECIFICO}
else
	echo "No /var/log directory found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Log File Access Step 1
#
echo "Log File Access Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /var/log/secure" >>& ${SPECIFICO}
echo '*****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /var/log/secure ) then
	/bin/ls -l /var/log/secure >>& ${SPECIFICO}
else
	echo "No /var/log/secure file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Log File Access Step 2
#
echo "Log File Access Step 2" >>& ${SPECIFICO}
echo "Displaying log file attributes" >>& ${SPECIFICO}
echo '******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/lsattr /var/log/* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays log file information and configuration to verify logging events
#
# Log Security Events Step 1
#
echo '<li><a href=specific.html#LogSecurityEvents4>Log Security Events</a>' >>& ${INDEXO}
echo '<a name=LogSecurityEvents4>' >>& ${SPECIFICO}
echo "Log Security Events Step 1"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Syslog>/etc/syslog.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 3
#
echo "Log Security Events Step 3"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Secure>/var/log/secure</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 3
#
echo "Log Security Events Step 3"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Messages>/var/log/messages</a>' file in Section 2" >>& ${SPECIFICO}
echo '*****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 3
#
echo "Log Security Events Step 3"  >>& ${SPECIFICO}
echo "Displaying /usr/bin/lastlog" >>& ${SPECIFICO}
echo '***************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/lastlog >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 4
#
echo "Log Security Events Step 4"  >>& ${SPECIFICO}
echo "Displaying /usr/bin/w" >>& ${SPECIFICO}
echo '*********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/w >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo "Displaying /usr/bin/who" >>& ${SPECIFICO}
echo '***********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/who >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo "Displaying /usr/bin/finger" >>& ${SPECIFICO}
echo '**************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/finger >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo "Displaying /usr/bin/rwho" >>& ${SPECIFICO}
echo '************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/rwho >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo "Displaying /usr/bin/users" >>& ${SPECIFICO}
echo '*************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/usr/bin/users >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Log Security Events Step 5
#
echo "Log Security Events Step 5"  >>& ${SPECIFICO}
echo "See '<a href=system.html#Last>/usr/bin/last</a>' file in Section 2" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays login time restrictions
#
# Login Time Restrictions Step 1
#
echo '<li><a href=specific.html#LoginTime2>Login Time Restrictions</a>' >>& ${INDEXO}
echo '<a name=LoginTime2>' >>& ${SPECIFICO}
echo "Login Time Restrictions Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/time.conf" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	cat /etc/security/time.conf >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays system account information
#
# Mail Users: System Shell Access Step 1
#
echo '<li><a href=specific.html#MailUsers>Mail Users: System Shell Access</a>' >>& ${INDEXO}
echo '<a name=MailUsers>' >>& ${SPECIFICO}
echo "Mail Users: System Shell Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays memory dump setting
#
# Memory Dump Files Step 1
#
echo '<li><a href=specific.html#MemoryDumps3>Memory Dump Files</a>' >>& ${INDEXO}
echo '<a name=MemoryDumps3>' >>& ${SPECIFICO}
echo "Memory Dump Files Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Profile>/etc/profile</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows OS system and program info 
# 
# Network Device Configuration Step 1
#
echo '<li><a href=specific.html#NetworkDevice>Network Device Configuration</a>' >>& ${INDEXO}
echo '<a name=NetworkDevice>' >>& ${SPECIFICO}
echo "Network Device Configuration Step 1" >>& ${SPECIFICO}
echo "Displaying /bin/rpm -qva" >>& ${SPECIFICO}
echo '************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/rpm -qva >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Network Device Configuration Step 2
#
echo "Network Device Configuration Step 2" >>& ${SPECIFICO}
echo "Displaying /sbin/sysctl -a" >>& ${SPECIFICO}
echo '**************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /sbin/sysctl -a >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
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

# Script shows mounted directories
#
# NFS and Sendmail Step 1
#
echo '<li><a href=specific.html#NfsSendmail>NFS and Sendmail</a>' >>& ${INDEXO}
echo '<a name=NfsSendmail>' >>& ${SPECIFICO}
echo "NFS and Sendmail Step 1" >>& ${SPECIFICO}
echo "Displaying /bin/mount" >>& ${SPECIFICO}
echo '*********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/mount >>& ${SPECIFICO}
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

# Displays OpenLDAP admin access
#
# OpenLDAP Administrative Access Step 1
#
echo '<li><a href=specific.html#LdapAdmin>OpenLDAP Administrative Access</a>' >>& ${INDEXO}
echo '<a name=LdapAdmin>' >>& ${SPECIFICO}
echo "OpenLDAP Administrative Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#OpenLDAP>/etc/openldap/slapd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays OpenLDAP domain configuration
#
# OpenLDAP Domain Configuration Step 1
#
echo '<li><a href=specific.html#LdapDomain>OpenLDAP Domain Configuration</a>' >>& ${INDEXO}
echo '<a name=LdapDomain>' >>& ${SPECIFICO}
echo "OpenLDAP Domain Configuration Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#OpenLDAP>/etc/openldap/slapd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays OpenLDAP password information
#
# OpenLDAP Encrypted Password Step 1
#
echo '<li><a href=specific.html#LdapEncrypt>OpenLDAP Encrypted Password</a>' >>& ${INDEXO}
echo '<a name=LdapEncrypt>' >>& ${SPECIFICO}
echo "OpenLDAP Encrypted Password Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#OpenLDAP>/etc/openldap/slapd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Displays OpenLDAP network communication information
#
# OpenLDAP Secure Network Communication Step 1
#
echo '<li><a href=specific.html#LdapSecure>OpenLDAP Secure Network Communication</a>' >>& ${INDEXO}
echo '<a name=LastLogin>' >>& ${SPECIFICO}
echo "OpenLDAP Secure Network Communication Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#OpenLDAP>/etc/openldap/slapd.conf</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# Password Composition Step 1
#
echo '<li><a href=specific.html#PasswordComposition4>Password Composition</a>' >>& ${INDEXO}
echo '<a name=PasswordComposition4>' >>& ${SPECIFICO}
echo "Password Composition Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#LoginDefs>/etc/login.defs</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Password Composition Step 2
#
echo "Password Composition Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#PamdSys>/etc/pam.d/system-auth' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# Password Expiration Step 1
#
echo '<li><a href=specific.html#PasswordExpiration5>Password Expiration</a>' >>& ${INDEXO}
echo '<a name=PasswordExpiration5>' >>& ${SPECIFICO}
echo "Password Expiration Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#LoginDefs>/etc/login.defs</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# Password History Step 2
#
echo '<li><a href=specific.html#PasswordHistory4>Password History</a>' >>& ${INDEXO} 
echo '<a name=PasswordHistory4>' >>& ${SPECIFICO} 
echo "Password History Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#PamdSys>/etc/pam.d/system-auth</a>' file in Section 2" >>& ${SPECIFICO}
echo '*********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Password History Step 3
#
echo "Password History Step 3" >>& ${SPECIFICO}
echo "Displaying permissions of /etc/security/opasswd" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/security/opasswd ) then
	ls -al /etc/security/opasswd >>& ${SPECIFICO}
else
	echo "No /etc/security/opasswd file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks if /etc/passwd and /etc/shadow exist and their contents
# 
# Password Storage Step 1
#
echo '<li><a href=specific.html#PasswordStorage3>Password Storage</a>' >>& ${INDEXO}
echo '<a name=PasswordStorage3>' >>& ${SPECIFICO}
echo "Password Storage Step 1" >>& ${SPECIFICO}
echo "Displaying permissions /etc/passwd" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/passwd ) then
	ls -al /etc/passwd >>& ${SPECIFICO}
else
	echo "No /etc/passwd file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Password Storage Step 1
#
echo "Password Storage Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Password Storage Step 2
#
echo "Password Storage Step 2" >>& ${SPECIFICO}
echo "Displaying permissions /etc/shadow" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/shadow ) then
	ls -al /etc/shadow >>& ${SPECIFICO}
else
	echo "No /etc/shadow file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Password Storage Step 2
#
echo "Password Storage Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shadow>/etc/shadow</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks services that use plain text authentication
#
# Plain Text Authentication Step 1
#
echo '<li><a href=specific.html#PlainText>Plain Text Authentication</a>' >>& ${INDEXO}
echo '<a name=UnecessaryServices>' >>& ${SPECIFICO}
echo "Plain Text Authentication Step 1" >>& ${SPECIFICO}
echo "<a href=system.html#Netstat>See 'netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows permissions for printer spool directories
#
# Print Spool Directories Step 1
#
echo '<li><a href=specific.html#PrintSpool5>Print Spool Directories</a>' >>& ${INDEXO}
echo '<a name=PrintSpool5>' >>& ${SPECIFICO}
echo "Print Spool Directories Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /var/spool" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/ls -l /var/spool >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows permissions for printer driver configuration
#
# Printer Drivers Step 1
#
echo '<li><a href=specific.html#PrintDrive>Printer Drivers</a>' >>& ${INDEXO}
echo '<a name=PrintDrive>' >>& ${SPECIFICO}
echo "Printer Drivers Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /dev/lp*" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  ls -la /dev/lp*  >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Printer Drivers Step 1
#
echo "Printer Drivers Step 1"  >>& ${SPECIFICO}
echo "Displaying /etc/cups/cupsd.conf" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -d /etc/cups ) then
	cat /etc/cups/cupsd.conf >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	echo "Printer Drivers Step 1"  >>& ${SPECIFICO}
	echo "Displaying /etc/cups/client.conf" >>& ${SPECIFICO}
	echo '********************************' >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	cat /etc/cups/client.conf >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	echo "Printer Drivers Step 1"  >>& ${SPECIFICO}
	echo "Displaying /etc/cups/printers.conf" >>& ${SPECIFICO}
	echo '**********************************' >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	cat /etc/cups/printers.conf >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	echo "Printer Drivers Step 1"  >>& ${SPECIFICO}
	echo "Displaying /etc/cups/classes.conf" >>& ${SPECIFICO}
	echo '*********************************' >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	cat /etc/cups/client.conf >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
else
	echo "No /etc/cups directory found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays root account information
#
# Privileged Accounts / Root Login at Console Step 1
#
echo '<li><a href=specific.html#RootLogin4>Privileged Accounts / Root Login at Console</a>' >>& ${INDEXO}
echo '<a name=RootLogin4>' >>& ${SPECIFICO}
echo "Privileged Accounts / Root Login at Console Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/security/access.conf" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/security/access.conf >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Privileged Accounts / Root Login at Console Step 2
#
echo "Privileged Accounts / Root Login at Console Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Privileged Accounts / Root Login at Console Step 3
#
echo "Privileged Accounts / Root Login at Console Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Secure>/var/log/secure</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script displays account information
#
# Privileged Accounts Step 1
#
echo '<li><a href=specific.html#PrivilegedAccounts3>Privileged Accounts</a>' >>& ${INDEXO}
echo '<a name=PrivilegedAccounts3>' >>& ${SPECIFICO}
echo "Privleged Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#FindPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Privileged Accounts Step 2
#
echo "Privileged Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Group>/etc/group</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
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

# Script checks for unencrypted services 
# 
# Protection of Authentication Data Step 1
#
echo '<li><a href=specific.html#ProtectData2>Protection of Authentication Data</a>' >>& ${INDEXO}
echo '<a name=ProtectData2>' >>& ${SPECIFICO}
echo "Protection of Authentication Data Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Protection of Authentication Data Step 2
#
echo "Protection of Authentication Data Step 2" >>& ${SPECIFICO}
echo "<a href=system.html#Netstat>See 'netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for remote trusted r-services
# 
# Remote Trusted r- Services Step 1
#
echo '<li><a href=specific.html#RServices3>Remote Trusted r- Services</a>' >>& ${INDEXO}
echo '<a name=RServices3>' >>& ${SPECIFICO}
echo "Remote Trusted r- Services Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
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

# Script checks for restricted FTP Access

# Restricted FTP Access Step 1
#
echo '<li><a href=specific.html#RestrictFtp>Restricted FTP Access</a>' >>& ${INDEXO}
echo '<a name=RestrictFtp>' >>& ${SPECIFICO}
echo "Restricted FTP Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#VsftpdConf>/etc/vsftpd/vsftpd.conf' in Section 2" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Restricted FTP Access Step 2
#
echo "Restricted FTP Access Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/vsftpd.chroot_list" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/vsftpd.chroot_list ) then
	cat /etc/vsftpd.chroot_list >>& ${SPECIFICO}
else
	echo "No /etc/vsftpd.chroot_list file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Restricted FTP Access Step 1
#
echo "Restricted FTP Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>/ftpaccess</a>' in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO} 
echo '' >>& ${SPECIFICO}

# Script checks for scheduled cron jobs and backups
# 
# Review Audit Log Step 1
#
echo '<li><a href=specific.html#ReviewLog>Review Audit Log</a>' >>& ${INDEXO}
echo '<a name=ReviewLog>' >>& ${SPECIFICO}
echo "Review Audit Log Step 1" >>& ${SPECIFICO}
echo "Displaying ps -axu | grep syslogd" >>& ${SPECIFICO}
echo '*********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  ps -axu | grep syslogd >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Review Audit Log Step 2
#
echo "Review Audit Log Step 2" >>& ${SPECIFICO}
echo "Displaying permissions of /var/log" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /var/log ) then
	ls -al /var/log >>& ${SPECIFICO}
else
	echo "No /var/log vile found found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# Root Access Step 1
#
echo '<li><a href=specific.html#RootAcess2>Root Access</a>' >>& ${INDEXO}
echo '<a name=RootAccess2>' >>& ${SPECIFICO}
echo "Root Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Access Step 1
#
echo "Root Access Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Secure>/var/log/secure</a>' in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for root FTP access

# Root Login to FTP Step 1
#
echo '<li><a href=specific.html#RootFtp2>Root Login to FTP</a>' >>& ${INDEXO}
echo '<a name=RootFtp2>' >>& ${SPECIFICO}
echo "Root Login to FTP Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#VsftpdConf>/etc/vsftpd/vsftpd.conf' in Section 2" >>& ${SPECIFICO}
echo '***********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Login to FTP Step 2
#
echo "Root Login to FTP Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/vsftpd.user_list" >>& ${SPECIFICO}
echo '********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/vsftpd.user_list ) then
	cat /etc/vsftpd.user_list >>& ${SPECIFICO}
else
	echo "No /etc/vsftpd.user_list file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Root Login to FTP Step 1
#
echo "Root Login to FTP Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Vsftpd>/ftpaccess</a>' in Section 2" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows SSH login information
# 
# Root Login to SSH Step 1
#
echo '<li><a href=specific.html#RootSsh>Root Login to SSH Step 1</a>' >>& ${INDEXO}
echo '<a name=RootSsh>' >>& ${SPECIFICO}
echo "Root Login to SSH Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/ssh/sshd_config | grep PermitRootLogin" >>& ${SPECIFICO}
echo '**************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/ssh/sshd_config | grep PermitRootLogin >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows telnet root login information
# 
# Root Login to Telnet Step 1
#
echo '<li><a href=specific.html#RootTelnet>Root Login to Telnet</a>' >>& ${INDEXO}
echo '<a name=RootTelnet>' >>& ${SPECIFICO}
echo "Root Login to Telnet Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/securetty" >>& ${SPECIFICO}
echo '*************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/securetty >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows root startup permissions
# 
# Root Startup File Permissions Step 1
#
echo '<li><a href=specific.html#RootStartup3>Root Startup File Permissions</a>' >>& ${INDEXO}
echo '<a name=RootStartup3>' >>& ${SPECIFICO}
echo "Root Startup File Permissions Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /root/.*" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  ls -al /root/.* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Root Startup File Permissions Step 2
#
echo "Root Startup File Permissions Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows root user path variable information
# 
# Root User Path Variable Step 1
#
echo '<li><a href=specific.html#RootPath3>Root User Path Variable</a>' >>& ${INDEXO}
echo '<a name=RootPath3>' >>& ${SPECIFICO}
echo "Root User Path Variable Step 1" >>& ${SPECIFICO}
echo "Displaying root path variable" >>& ${SPECIFICO}
echo '*****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/echo $PATH >>& ${SPECIFICO}
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

# Displays BIND status
#
# Run BIND With Non-Root Privlege Step 1
#
echo '<li><a href=specific.html#RunBind>Run BIND With Non-Root Privlege</a>' >>& ${INDEXO}
echo '<a name=RunBind>' >>& ${SPECIFICO}
echo "Run BIND With Non-root Privlege Step 1" >>& ${SPECIFICO}
echo "Displaying ps -ef | grep named" >>& ${SPECIFICO}
echo '******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	ps -ef | grep named >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows Samba password file
# 
# Samba Password File Step 1
#
echo '<li><a href=specific.html#SambaPass>Samba Password File</a>' >>& ${INDEXO}
echo '<a name=SambaPass>' >>& ${SPECIFICO}
echo "Samba Password File Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/samba/smb.conf | grep 'smb passwd file'" >>& ${SPECIFICO}
echo '*******************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/samba/smb.conf | grep 'smb passwd file' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows NIS access information
# 
# Securing NIS Step 1
#
echo '<li><a href=specific.html#SecureNis>Securing NIS </a>' >>& ${INDEXO}
echo '<a name=SecureNis>' >>& ${SPECIFICO}
echo "Securing NIS Step 1" >>& ${SPECIFICO}
echo "Displaying /var/yp/securenets" >>& ${SPECIFICO}
echo '*****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /var/yp/securenets >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows permissions for printer configuration
#
# Securing Printing Step 1
#
echo '<li><a href=specific.html#SecurePrint3>Securing Printing</a>' >>& ${INDEXO}
echo '<a name=SecurePrint3>' >>& ${SPECIFICO}
echo "Securing Printing Step 1"  >>& ${SPECIFICO}
echo "Displaying /etc/cups/cupsd.conf" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/cups/cupsd.conf ) then
	cat /etc/cups/cupsd.conf >>& ${SPECIFICO}
else
	echo "No /etc/cups/cupsd.conf file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows Samba host configuration
# 
# Securing Samba Step 1
#
echo '<li><a href=specific.html#SecureSamba>Securing Samba</a>' >>& ${INDEXO}
echo '<a name=SecureSamba>' >>& ${SPECIFICO}
echo "Securing Samba Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/samba/smb.conf | grep 'hosts allow'" >>& ${SPECIFICO}
echo '***************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/samba/smb.conf | grep 'hosts allow' >>& ${SPECIFICO}
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

# Displays /etc/mail/sendmail.mc to check for DoS vulnerbility
#
# Sendmail: Limiting DoS Attack Step 1
#
echo '<li><a href=specific.html#SendmailLimit>Sendmail: Limiting DoS Attack</a>' >>& ${INDEXO}
echo '<a name=SendmailLimit>' >>& ${SPECIFICO}
echo "Sendmail: Limiting DoS Attack Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/mail/sendmail.mc" >>& ${SPECIFICO}
echo '********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	cat /etc/mail/sendmail.mc >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows finger information
# 
# Service Information Step 1
#
echo '<li><a href=specific.html#ServiceInformation3>Service Information</a>' >>& ${INDEXO}
echo '<a name=ServiceInformation3>' >>& ${SPECIFICO}
echo "Service Information Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Service Information Step 2
#
echo "Service Information Step 2" >>& ${SPECIFICO}
echo "Displaying /etc/xinetd.d/finger" >>& ${SPECIFICO}
echo '*******************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/xinetd.d/finger >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays grpck -r and /etc/group files to be reviewed for group membership
#
# Share and Mount Point Security Step 2
#
echo '<li><a href=specific.html#ShareSecure>Share and Mount Point Security</a>' >>& ${INDEXO}
echo '<a name=ShareSecure>' >>& ${SPECIFICO}
echo "Share and Mount Point Security Step 2"  >>& ${SPECIFICO}
echo "Displaying /etc/exports" >>& ${SPECIFICO}
echo '***********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	cat /etc/exports >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Share and Mount Point Security Step 2
#
echo "Share and Mount Point Security Step 2"  >>& ${SPECIFICO}
echo "Displaying permissions of files and directories located in /etc/exports" >>& ${SPECIFICO}
echo '***********************************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	ls -al /etc/exports* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user accounts on the system
# 
# Shared Generic Accounts Step 1
#
echo '<li><a href=specific.html#SharedGeneric>Shared Generic Accounts</a>' >>& ${INDEXO}
echo '<a name=SharedGeneric>' >>& ${SPECIFICO}
echo "Shared Generic Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Shared Generic Accounts Step 1
#
echo "Shared Generic Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ypcat>ypcat passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Shared Generic Accounts Step 2
#
echo "Shared Generic Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Rhosts>.rhosts</a>' files in Section 2" >>& ${SPECIFICO}
echo '********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Shared Generic Accounts Step 3
#
echo "Shared Generic Accounts Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#Secure>/var/log/secure</a>' file in Section 2" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SYSTEMO}
echo '' >>& ${SYSTEMO}

# Script shows single command account information
# 
# Single Command Accounts Step 1
#
echo '<li><a href=specific.html#SingleCommandAccounts3>Single Command Accounts</a>' >>& ${INDEXO}
echo '<a name=SingleCommandAccounts3>' >>& ${SPECIFICO}
echo "Single Command Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Single Command Accounts Step 2
#
echo "Single Command Accounts Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shadow>/etc/shadow</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows system boot loader password
# 
# System Boot Loader Password Step 1
#
echo '<li><a href=specific.html#SysBoot>System Boot Loader Password</a>' >>& ${INDEXO}
echo '<a name=SysBoot>' >>& ${SPECIFICO}
echo "System Boot Loader Password Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/lilo.conf | grep password" >>& ${SPECIFICO}
echo '*****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/lilo.conf ) then
	cat /etc/lilo.conf | grep password >>& ${SPECIFICO}
else
	echo "No /etc/lilo.conf file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# System Boot Loader Password Step 1
#
echo "System Boot Loader Password Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/grub.conf | grep password" >>& ${SPECIFICO}
echo '*****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/grub.conf ) then
	cat /etc/grub.conf | grep password >>& ${SPECIFICO}
else
	echo "No /etc/grub.conf file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# Temporary and Contractor Type Accounts Step 1
#
echo '<li><a href=specific.html#TempContract4>Temporary and Contractor Type Accounts</a>' >>& ${INDEXO} 
echo '<a name=TempContract4>' >>& ${SPECIFICO}
echo "Temporary and Contractor Type Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shadow>/etc/shadow</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
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

# Script displays configurations of local and network services
#
# Unnecessary Services Step 1
#
echo '<li><a href=specific.html#UnecessaryServices4>Unecessary Services</a>' >>& ${INDEXO}
echo '<a name=UnecessaryServices4>' >>& ${SPECIFICO}
echo "Unnecessary Services Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Unnecessary Services Step 1
#
echo "Unnecessary Services Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Netstat>netstat -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Unnecessary Services Step 1
#
echo "Unnecessary Services Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Ifconfig>ifconfig -a</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script shows permissions and contents of at.deny and at.allow, if they exist
#
# Use of AT and BATCH Commands Step 1
#
echo '<li><a href=specific.html#AtBatch4>Use of AT and BATCH Commands</a>' >>& ${INDEXO}
echo '<a name=AtBatch4>' >>& ${SPECIFICO}
echo "Use of AT and BATCH Commands Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of AT and BATCH Commands Step 2
#
echo "Use of AT and BATCH Commands Step 2"  >>& ${SPECIFICO}
echo "Displaying permissions of /etc/at.deny" >>& ${SPECIFICO}
echo '**************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/at.deny ) then
	/bin/ls -al /etc/at.deny >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	echo "Use of AT and BATCH Commands Step 2"  >>& ${SPECIFICO}
	echo "Displaying /etc/at.deny" >>& ${SPECIFICO}
	echo '***********************' >>& ${SPECIFICO}
	/bin/cat /etc/at.deny >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
else
	echo "No /etc/at.deny file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}

# Use of AT and BATCH Commands Step 2
#
echo "Use of AT and BATCH Commands Step 2"  >>& ${SPECIFICO}
echo "Displaying permissions of /etc/at.allow" >>& ${SPECIFICO}
echo '***************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
if ( -f /etc/at.allow ) then
	/bin/ls -al /etc/at.allow >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
	echo "Use of AT and BATCH Commands Step 1"  >>& ${SPECIFICO}
	echo "Displaying /etc/at.allow" >>& ${SPECIFICO}
	echo '*********************************' >>& ${SPECIFICO}
	/bin/cat /etc/at.allow >>& ${SPECIFICO}
	echo '' >>& ${SPECIFICO}
else
	echo "No /etc/at.allow file found" >>& ${SPECIFICO}
endif
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows Crontab command usage
#
# Use of CRONTAB Command Step 1
#
echo '<li><a href=specific.html#Crontab3>Use of CRONTAB Command</a>' >>& ${INDEXO}
echo '<a name=Crontab3>' >>& ${SPECIFICO}
echo "Use of CRONTAB Command Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of CRONTAB Command Step 2
#
echo "Use of CRONTAB Command Step 2"  >>& ${SPECIFICO}
echo "Displaying permissions of /etc/cron*" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/bin/ls -al /etc/cron* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of CRONTAB Command Step 2
#
echo "Use of CRONTAB Command Step 2"  >>& ${SPECIFICO}
echo "Displaying permissions of /var/spool/cron*" >>& ${SPECIFICO}
echo '*******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	/bin/ls -al /var/spool/cron* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays configuration of sendmail
#
# Use of Sendmail Step 1
#
echo '<li><a href=specific.html#UseOfSendmail4>Use of Sendmail</a>' >>& ${INDEXO}
echo '<a name=UseOfSendmail4>' >>& ${SPECIFICO}
echo "Use of Sendmail Step 1" >>& ${SPECIFICO}
echo "Displaying /sbin/service sendmail status" >>& ${SPECIFICO}
echo '****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  	/sbin/service sendmail status >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of Sendmail Step 1
#
echo "Use of Sendmail Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script displays configuration of SNMP
#
# Use of SNMP Step 1
#
echo '<li><a href=specific.html#UseOfSnmp2>Use of SNMP</a>' >>& ${INDEXO}
echo '<a name=UseOfSnmp2>' >>& ${SPECIFICO}
echo "Use of SNMP Step 1" >>& ${SPECIFICO}
echo "Displaying /sbin/service snmpd status" >>& ${SPECIFICO}
echo '*************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  	/sbin/service snmpd status >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of SNMP Step 1
#
echo "Use of SNMP Step 1" >>& ${SPECIFICO}
echo "Displaying /sbin/service snmptrapd status" >>& ${SPECIFICO}
echo '*****************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  	/sbin/service snmptrapd status >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of SNMP Step 1
#
echo "Use of SNMP Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
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

# Script shows user 'sudo' information
# 
# Use of Sudo Step 1
#
echo '<li><a href=specific.html#UseOfSudo>Use of Sudo</a>' >>& ${INDEXO}
echo '<a name=UseOfSudo>' >>& ${SPECIFICO}
echo "Use of Sudo Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/sudoers" >>& ${SPECIFICO}
echo '***********************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/sudoers >>& ${SPECIFICO}
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
echo '<li><a href=specific.html#UseOfTcpWrap3>Use of TCP Wrappers</a>' >>& ${INDEXO}
echo '<a name=UseOfTcpWrap3>' >>& ${SPECIFICO}
echo "Use of TCP Wrappers Step 1" >>& ${SPECIFICO}
echo "Displaying permissions of /etc/xinetd.d directory" >>& ${SPECIFICO}
echo '*************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/ls -al /etc/xinetd.d >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Use of TCP Wrappers Step 2
#
echo "Use of TCP Wrappers Step 2" >>& ${SPECIFICO}
echo "Displaying contents of every file in /etc/xinetd.d directory" >>& ${SPECIFICO}
echo '************************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
	cat /etc/xinetd.d/* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks TFTP configuration
# 
# Use of TFTP Step 1
#
echo '<li><a href=specific.html#UseOfTftp3>Use of TFTP</a>' >>& ${INDEXO}
echo '<a name=UseOfTftp3>' >>& ${SPECIFICO}
echo "Use of TFTP Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/xinetd.d/tftp" >>& ${SPECIFICO}
echo '*****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/xinetd.d/tftp >>& ${SPECIFICO}
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

# Displays user account information
#
# User Home Directory Step 1
#
echo '<li><a href=specific.html#UserHome2>User Home Directory</a>' >>& ${INDEXO}
echo '<a name=UserHome2>' >>& ${SPECIFICO}
echo "User Home Directory Step 1" >>& ${SPECIFICO}
echo "Displaying /usr/sbin/pwck -r" >>& ${SPECIFICO}
echo '****************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 
   /usr/sbin/pwck -r >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# User Home Directory Step 1
#
echo "User Home Directory Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks for user shells
#
# User Shells Step 1
#
echo '<li><a href=specific.html#UserShells3>User Shells</a>' >>& ${INDEXO}
echo '<a name=UserShells3>' >>& ${SPECIFICO}
echo "User Shells Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shells>/etc/shells</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# User Shells Step 2
#
echo "User Shells Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks if UUCP is used
# 
# UUCP Usage Step 1
#
echo '<li><a href=specific.html#UucpUse4>UUCP Usage</a>' >>& ${INDEXO} 
echo '<a name=UucpUse4>' >>& ${SPECIFICO}
echo "UUCP Usage Step 1" >>& ${SPECIFICO}
echo "Displaying /bin/rpm -qa | grep uucp" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/rpm -qa | grep uucp >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 2
#
echo "UUCP Usage Step 2" >>& ${SPECIFICO}
echo "See '<a href=system.html#Shadow>/etc/shadow</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 3
#
echo "UUCP Usage Step 3" >>& ${SPECIFICO}
echo "See '<a href=system.html#ChkConfig>/sbin/chkconfig --list</a>' in Section 2" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# UUCP Usage Step 4
#
echo "UUCP Usage Step 4" >>& ${SPECIFICO}
echo "Displaying contents of /etc/uucp/*" >>& ${SPECIFICO}
echo '**********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  /bin/cat /etc/uucp/* >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user accounts
# 
# Vendor Support Accounts Step 1
#
echo '<li><a href=specific.html#VendorSupportAccounts3>Vendor Support Accounts</a>' >>& ${INDEXO}
echo '<a name=VendorSupportAccounts3>' >>& ${SPECIFICO}
echo "Vendor Support Accounts Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#DisplayPasswdFile>/etc/passwd</a>' file in Section 2" >>& ${SPECIFICO}
echo '***********************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO} 

# Script shows user account information
# 
# X-Windows Started At Boot Step 1
#
echo '<li><a href=specific.html#XWinBoot>X-Windows Started At Boot Time</a>' >>& ${INDEXO}
echo '<a name=XWinBoot>' >>& ${SPECIFICO}
echo "X-Windows Started At Boot Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/inittab | grep initdefault" >>& ${SPECIFICO}
echo '******************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/inittab | grep initdefault >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script shows user account information
# 
# X-Windows Tunneling Over SSH Step 1
#
echo '<li><a href=specific.html#XWinTunnel>X-Windows Tunneling Over SSH</a>' >>& ${INDEXO}
echo '<a name=XWinTunnel>' >>& ${SPECIFICO}
echo "X-Windows Started At Boot Step 1" >>& ${SPECIFICO}
echo "Displaying /etc/ssh/sshd_config | grep X11Forwarding" >>& ${SPECIFICO}
echo '****************************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  cat /etc/ssh/sshd_config | grep X11Forwarding >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
echo '<a href=index.html#TopOfIndex>Return to Report</a>' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# Script checks if X-windows is used
#
# X-Windows Usage Step 1
#
echo '<li><a href=specific.html#XWinUse>X-Windows Usage</a>' >>& ${INDEXO}
echo '<a name=XWinUse>' >>& ${SPECIFICO}
echo "X-Windows Usage Step 1" >>& ${SPECIFICO}
echo "See '<a href=system.html#Netstat>netstat -an</a>' file in Section 2" >>& ${SPECIFICO}
echo '************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# X-Windows Usage Step 2
#
echo "X-Windows Usage Step 2" >>& ${SPECIFICO}
echo "Displaying files that allow X-windows sessions" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  	find / \( -fstype nfs -prune \) -o -name 'X*.hosts' -exec ls -la  {} \; -exec cat {} \; >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}

# X-Windows Usage Step 3
#
echo "X-Windows Usage Step 3" >>& ${SPECIFICO}
echo "Displaying permissions of /usr/X11R6/bin/xhost" >>& ${SPECIFICO}
echo '**********************************************' >>& ${SPECIFICO}
echo '' >>& ${SPECIFICO}
  	/bin/ls -l /usr/X11R6/bin/xhost >>& ${SPECIFICO}
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
 echo ""
  echo "          ---------------------------------------------------"
 echo "          The Aumyaa Report File is located in:"
 echo "          '${outdir}'"
 echo ""
 echo "          Thanks for your cooperation"
 echo ""
 echo ""
exit 1