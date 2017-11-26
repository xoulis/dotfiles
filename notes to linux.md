﻿
----------------------------------------------
## SAMBA                               
----------------------------------------------
Adding a user   
    
    smbpasswd -a samba_user
List Samba users    
    
    sudo pdbedit -L -v

----------------------------------------------
##     ADD A NEW USER TO SECONDARY GROUP   
----------------------------------------------
To add a new group, all you need to do is 
use the groupadd command like so:
    
    groupadd <groupname>
Change a User’s Primary Group
    
    usermod -g <groupname> username

    useradd -G {group-name} username
The useradd command will not surprisingly try to add a new user.
To modify an existing user,like 
adding that user to a new group,
use the usermod command.

    usermod -a -G groupName userName
----------------------------------------------

----------------------------------------------
##     ENSURE THAT USER IS ADDED            
----------------------------------------------
    id username
    groups <username>

----------------------------------------------

----------------------------------------------
1. To make Plymouth work:
     1.1. Add "plymouth" to HOOKS after "base" and "udev" in /etc/mkinitcpio.conf
     1.2. Add 'quiet splash' to the grub command line in /etc/default/grub
     1.3. Rebuild your initrd image (# mkinitcpio -p [kernel preset name]).
          E.g.: sudo mkinitcpio -p linux38

2. To enable encryption, replace "encrypt" with "plymouth-encrypt" in
   mkinitcpio.conf and rebuild your initrd image.

3. You will also need to rebuild your initrd image every time you change your theme
   (the default is set as 'spinfinity').

   To list all plymouth themes:
       plymouth-set-default-theme -l

   To change theme:
       # plymouth-set-default-theme <theme>

   To rebuild initrd image:
       # mkinitcpio -p <kernel present name>

4. For Smooth Transition to Display Manager you have to:
     4.1. See the Wiki Page (link in 5) to prepare your Display Manager
     4.2. Disable your Display Manager Unit 
          E.g. : systemctl disable kdm.service
     4.3. Enable the respective DM-plymouth Unit (GDM,KDM,Lightdm,LXDM units provided)
          E.g. : systemctl enable kdm-plymouth.service

5. For more information please visit the Wiki page:
   https://wiki.archlinux.org/index.php/Plymouth

OBS. If you have any leftover "kill Plymouth" lines in /etc/rc.local or ~/.xinitrc
     they are no longer required.
     
----------------------------------------------

----------------------------------------------
##      CANNOT RUN STEAM                    
----------------------------------------------
	find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete
	
    find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete



----------------------------------------------
##     CORRECT TIME IN WINDOWS              
----------------------------------------------
I recently faced the same problem and this is how I fixed it. You need to make some minor changes in both operating systems.

I started with Linux first. Run the following commands as root:

ntpdate pool.ntp.org
This will update your time if it is not set correctly.

Now set the hardware clock to UTC with this command.

	hwclock –systohc –utc
	Source

Now boot to Windows and add the following to the registry. Simply create a .reg file using the code below in Notepad. Save it and run it.

	Windows Registry Editor Version 5.00
	[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
	“RealTimeIsUniversal”=dword:00000001
	Source

From the next boot onward, both operating systems will show you the correct time.

##	Change input language
-------------------------------------------------
	localectl --no-convert set-x11-keymap gr,us pc104  grp:alt_shift_toggle

----------------------------------------------
##     Fix Bluetooth                        
----------------------------------------------
Get the id of the bluetooth device from lsusb command
	
    $ lsusb
Let's say, 0bda:57d6 is the offending device. Now open the tlp configuration file at /etc/default/tlp. I prefer nano editor, so use command sudo nano /etc/default/tlp

Find the line that reads

	 #USB_BLACKLIST="1111:2222 3333:4444"
change it to

	USB_BLACKLIST="0bda:57d6"

----------------------------------------------
##             MIRORS                       
----------------------------------------------
 	
    sudo pacman-mirrors -f 0


----------------------------------------------
##            git vim update               
----------------------------------------------
	cd ~/.vim/bundle
	for i in `ls`; do
  	cd "$i"
  	git pull
  	cd ..
  
  --or--
  
	for i in ~/.vim/bundle/*; do git -C $i pull; done

----------------------------------------------
##	Git store credentials                 
----------------------------------------------
	git config credential.helper store
then

 	git pull
provide user-name and password and those details will be remembered later. The credentials are stored in the disk, with the disk permissions.

if you want to change password later

	git config credential.helper store 
then

 	git pull
provide new password and it will work like before.
