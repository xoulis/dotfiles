#	Notes to Linux
Mainly some usefull notes for my arch adventures

## SAMBA                               
----------------------------------------------
Adding a user   
    
    smbpasswd -a samba_user
List Samba users    
    
    sudo pdbedit -L -v

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
     

##      CANNOT RUN STEAM                    
----------------------------------------------
	find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete
	
    find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" -o -name "libgpg-error.so*" \) -print -delete



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

##     Fix Bluetooth                        
----------------------------------------------
Get the id of the bluetooth device from lsusb command
	
    $ lsusb
Let's say, 0bda:57d6 is the offending device. Now open the tlp configuration file at /etc/default/tlp. I prefer nano editor, so use command sudo nano /etc/default/tlp

Find the line that reads

	 #USB_BLACKLIST="1111:2222 3333:4444"
change it to

	USB_BLACKLIST="0bda:57d6"

##             MIRORS                       
----------------------------------------------
 	
    sudo pacman-mirrors -f 0


##            Git vim update               
----------------------------------------------
	cd ~/.vim/bundle
	for i in `ls`; do
  	cd "$i"
  	git pull
  	cd ..
  
  --or--
  
	for i in ~/.vim/bundle/*; do git -C $i pull; done

##	Git basic workflow
----------------------------------------------
git - the simple guide
	http://rogerdudler.github.io/git-guide/


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

## View images in the Mutt e-mail client
----------------------------------------------
1. install the w3m-img package 
2. create the bash script muttimage.sh
***
	#! /bin/sh
	#Determine size of Terminal
	height=`stty  size | awk 'BEGIN {FS = " "} {print $1;}'`
	width=`stty  size | awk 'BEGIN {FS = " "} {print $2;}'`
	# Display Image / offset with mutt bar
	echo -e "2;3;n0;1;210;20;$((width*7-250));$((height*14-100));0;0;0;0;$1n4;n3;" |  /usr/lib/w3m/w3mimgdisplay &
3.  add the following command in your mailcap.mutt located in your .mutt directory
    	image/*; ~/PATH/YOUR/SCRIPT/muttimage.sh %s ; copiousoutput

## How to change keyboard layout in i3
----------------------------------------------
setxkbmap -layout eu,gr
setxkbmap -option 'grp:alt_shift_toggle'

exec_always "setxkbmap -model pc104 -layout eu,gr ,, -option grp:alt_shift_toggle"

## Kde plasma Fixes
----------------------------------------------
To regenerate plasma config.

	cd ~/.config
	for j in plasma*; do mv -- "$j" "${j%}.bak"; done

To rebuild cache

	mv ~/.config/Trolltech.conf ~/.config/Trolltech.conf.bak
	mv ~/.cache/ ~/cache.bak
	mkdir ~/.cache
	kbuildsycoca5 --noincremental && kbuildsycoca4 --noincremental

Later if required u can delete .bak files and directories.


## Primus with GF117M
----------------------------------------------------
# Bumblebee/Optimus:
	sudo mhwd -r pci video-hybrid-intel-nvidia-bumblebee
	sudo mhwd -i pci video-hybrid-intel-nvidia-390xx-bumblebee

# Single card/PRIME:
	sudo mhwd -r pci video-nvidia
	sudo mhwd -i pci video-nvidia-390xx

To check which gpu is enabled

	cat /proc/acpi/bbswitch
OFF in intel, ON is nvidia.

Turn the card off, respectively on:
	
	tee /proc/acpi/bbswitch <<<OFF
 	tee /proc/acpi/bbswitch <<<ON

## Set up PRIME with NVIDIA proprietary driver
----------------------------------------------------
# Step 1: remove bumblebee
If you installed with the non-free driver option mhwd will have set up bumblebee for you. This will get in the way so the first step is to remove it. Use the mhwd command-line or simply remove it via Manjaro Settings Manager.

# Step 2: install the NVIDIA driver
Use mhwd or MSM to install the nvidia driver in the normal way.

# Step 3: break fix mhwd's configuration
mhwd does the sensible thing and puts configuration in place as though the NVIDIA GPU was the only device available. We need to change this setup so PRIME will work.

# Step 3.1: set up a new Xorg configuration
Firstly, remove /etc/X11/xorg.conf.d/90-mhwd.conf and replace it with:

    /etc/X11/xorg.conf.d/optimus.conf

While the BusID value above should be correct for most Optimus laptops you should check your values with 
    lspci | grep -E "VGA|3D" .

# Step 3.2: Refine blacklisting
PRIME relies on nvidia-drm and mhwd puts it in a blacklist by default, but to to ensure the nvidia kernel module will load we still need to blacklist certain other modules. Therefore, you’ll have to do some editing of the files in /etc/modprobe.d.

To remove the existing blacklist, edit, move or remove any related mhwd-* files in /etc/modprobe.d/, e.g.

    ls /etc/modprobe.d/mhwd*
    sudo rm /etc/modprobe.d/mhwd-gpu.conf
    sudo rm /etc/modprobe.d/mhwd-nvidia.conf

The end result must include a blacklist of the following modules, e.g. in /etc/modprobe.d/nvidia.conf:

    blacklist nouveau
    blacklist nvidiafb
    blacklist rivafb

# Step 4: enable nvidia-drm.modeset
Create a new file,

    /etc/modprobe.d/nvidia-drm.conf

# Step 5: Set the output source for your DM.
This is the most complicated part and the one which will take longest to get right. If you reboot now, your DM will load but display on the wrong output; the laptop display will be entirely blank (powered off).

We need to set a startup script to load the correct settings while the DM is loading.

Create a new file with the following content:

    /usr/local/bin/optimus.sh

Make sure to set it world read-execute, 
    chmod a+rx /usr/local/bin/optimus.sh

Now you have to get this to load in your DM’s startup sequence.

LightDM
Edit /etc/lightdm/lightdm.conf and set

display-setup-script=/usr/local/bin/optimus.sh

GDM
Create a new file,

 /usr/local/share/optimus.desktop
and link it into place so it starts with GDM and on login

sudo ln -s /usr/local/share/optimus.desktop /usr/share/gdm/greeter/autostart/optimus.desktop
sudo ln -s /usr/local/share/optimus.desktop /etc/xdg/autostart/optimus.desktop
You’ll also have to use X, not Wayland.

SDDM
Create a new file,

 /usr/share/sddm/scripts/Xsetup

# Step 6: reboot
If everything is set correctly, when you reboot your DM will load, you can log in, and:

$ glxinfo | grep -i vendor
server glx vendor string: NVIDIA Corporation
client glx vendor string: NVIDIA Corporation
OpenGL vendor string: NVIDIA Corporation

Hooray! You’re running X via the dGPU not the iGPU!

If you have multiple displays you may have to configure their layout again in the normal way.

-------------------------------------------------------------------------------------------------------------

## Optimus-manager
This Linux program provides a solution for GPU switching on Optimus laptops (a.k.a laptops with dual Nvidia/Intel GPUs).

Manjaro is supported: Only Xorg sessions are supported (no Wayland).

Supported display managers are : SDDM, LightDM, GDM. The program may still work with others but you have to configure them manually (see this section).

Regression: GDM support is currently broken (see this issue : https://github.com/Askannz/optimus-manager/issues/4 7). You can still use optimus-manager but you will have to manually logout and stop the X server before switching GPUs.

# The “why”
On Windows, the Optimus technology works by dynamically offloading rendering to the Nvidia GPU when running 3D-intensive applications, while the desktop session itself runs on the Intel GPU.

However, on Linux, the Nvidia driver does not provide such offloading capabilities (yet 16), which makes it difficult to use the full potential of your machine while keeping a reasonable battery life.

Currently, if you have Linux installed on an Optimus laptop, there are three methods to use your Nvidia GPU :

Run your whole X session on the Intel GPU and use Bumblebee to offload rendering to the Nvidia GPU. While this mimic the behavior of Optimus on Windows, this is an unofficial, hacky solution with three major drawbacks : 1. a noticeable performance hit (because Bumblebee has to use your CPU to copy frames over to the display) 2. no support for Vulkan (therefore, it is incompatible with DXVK and any native game using Vulkan, like Shadow of the Tomb Raider for instance) 3. you will be unable to use any video output (like HDMI ports) connected to the Nvidia GPU, unless you have the open-source nouveau driver loaded to this GPU at the same time.

Use nvidia-xrun to have the Nvidia GPU run on its own X server in another virtual terminal. You have to keep two X servers running at the same time, which can be detrimental to performance. Also, you do not have acess to your normal desktop environment while in the virtual terminal of the Nvidia GPU, and in my own experience, the nvidia driver is prone to crashing when switching between virtual terminals.

Run your whole X session on the Nvidia GPU and disable rendering on the Intel GPU. This allows you to run your applications at full performance, with Vulkan support, and with access to all video outputs. However, since your power-hungry Nvidia GPU is turned on at all times, so it has a massive impact on your battery life.
This method is often called Nvidia PRIME, although technically PRIME is just the technology that allows your Nvidia GPU to send its frame to the built-in display of your laptop via the Intel GPU.

An acceptable middle ground could be to use the third method on demand : switching the X session to the Nvidia GPU when you need extra rendering power, and then switching it back to Intel when you are done, to save battery life.

Unfortunately the X server configuration is set-up in a permanent manner with configuration files, which makes switching a hassle because you have to rewrite those files every time you want to switch GPUs. You also have to restart the X server for those changes to be taken into account.

This is what this tool does for you : it dynamically writes the X configuration at boot time, rewrites it every time you need to switch GPUs, and also loads the appropriate kernel modules to make sure your GPUs are properly turned on/off.

Note that this is nothing new : Ubuntu has been using that method for years with their prime-select script.

In practice, here is what happens when switching to the Intel GPU (for example) :

Your login manager is automatically stopped, which also stops the X server (warning : this closes all opened applications)
The Nvidia modules are unloaded and nouveau is loaded instead to switch off the card (this can also be done with bbswitch if nouveau does not work)
The configuration for X and your login manager is updated (note that the configuration is saved to dedicated files, this will not overwrite any of your own configuration files)
The login manager is restarted.
We are well-aware this is still a hacky solution and we will happily deprecate this tool the day Nvidia implements proper GPU offloading in their Linux driver.

# Installation
pamac install optimus-manager

Once the package is installed, do not forget to enable the daemon so that it is started at boot time :

# systemctl enable optimus-manager.service
IMPORTANT : make sure you do not have any configuration file conflicting with the ones autogenerated by optimus-manager. In particular, remove everything related to displays or GPUs in /etc/X11/xorg.conf, /etc/X11/xorg.conf.d/ and also in /etc/X11/mhwd.d/. Avoid running nvidia-xconfig or using the Save to X Configuration file in the Nvidia control panel. If you need to apply specific options to your Xorg config, see the Configuration section.

If you have bumblebee installed on your system, uninstall it or at least make sure the bumblebeed service is disabled. Finally, make sure the bbswitch module is not loaded at boot time (check /etc/modules-load.d/).

If you want to disable optimus-manager completely, then first disable the SystemD service :

# systemctl stop optimus-manager.service
# systemctl disable optimus-manager.service
Then run optimus-manager --cleanup as root to remove any leftover autogenerated configuration file. Make sure to do this step before uninstalling the program.

# Usage
Make sure the SystemD service optimus-manager.service is running, then run

optimus-manager --switch nvidia
to switch to the Nvidia GPU, and

optimus-manager --switch intel
to switch to the Intel GPU.

WARNING : Switching GPUs automatically restarts your display manager, so make sure you save your work and close all your applications before doing so.

You can setup autologin in your display manager so that you do not have to re-enter your password every time.

You can also specify which GPU you want to be used by default when the system boots :

optimus-manager --set-startup MODE
Where MODE can be intel, nvidia, or nvidia_once. The last one is a special mode which makes your system use the Nvidia GPU at boot, but for one boot only. After that it reverts to intel mode. This can be useful to test your Nvidia configuration and make sure you do not end up with an unusable X server.

# Configuration
The default configuration file can be found at /usr/share/optimus-manager.conf. Please do not edit this file ; instead, create your own config file at /etc/optimus-manager.conf.

Any parameter not specified in your config file will take value from the default file.

Please refer to the comments in the default config file for descriptions of the available parameters. In particular, it is possible to set common Xorg options like DRI version or triple buffering, as well as some kernel module loading options.

Those parameters probably do not cover all use cases (yet), but feel free to open an issue if you think something else should beem  added there.

------------------------------------------------------------------------------------------------------------
## Find corect DPI
	xrandr | grep -w connected
 Convert output to centimetres or with a long ruler by hand.  Then divide by 2.54 to convert them in inches, and then divide the resolution with the output.
 	
 	1920/13.54in=141 x 1080/7.63in=141.54
 -------------------------------------------------------------------------------------------------------------
	
## Multiseat configuration on Linux

The easieast way I found was to use multiseat on Manjaro 
	https://github.com/ezst036/EasySeats-releases
	https://easy-seats.weebly.com/
	
Example of working seat1
	sudo loginctl seat-status seat1
seat1
        Sessions: *4
         Devices:
                  ├─/sys/devices/pci0000:00/0000:00:02.0/drm/card0
                  │ [MASTER] drm:card0
                  │ └─/sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-HDMI-A-1
                  │   [MASTER] drm:card0-HDMI-A-1
                  ├─/sys/devices/pci0000:00/0000:00:02.0/graphics/fb1
                  │ graphics:fb1 "i915drmfb"
                  └─/sys/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1:1.2/0003:046D:C52B.0005/0003:046D:404D.000A/input/input42
                    input:input42 "Logitech K400 Plus"
                    ├─/sys/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1:1.2/0003:046D:C52B.0005/0003:046D:404D.000A/input/input42/input42::capslock
                    │ leds:input42::capslock
                    ├─/sys/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1:1.2/0003:046D:C52B.0005/0003:046D:404D.000A/input/input42/input42::compose
                    │ leds:input42::compose
                    ├─/sys/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1:1.2/0003:046D:C52B.0005/0003:046D:404D.000A/input/input42/input42::kana
                    │ leds:input42::kana
                    ├─/sys/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1:1.2/0003:046D:C52B.0005/0003:046D:404D.000A/input/input42/input42::numlock
                    │ leds:input42::numlock
                    └─/sys/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11.1/1-11.1:1.2/0003:046D:C52B.0005/0003:046D:404D.000A/input/input42/input42::scrolllock
                      leds:input42::scrolllock
	
 
