# sushi
Helpful tool to automate new device onboarding for arch systems on both `x86_64` and `aarch64`. 

| Tool/Setting | Tested On|
| ---- | ------|
| git config | x86 |
| SSH Key setup | x86 |
| Minecraft Launcher | x86 | 
| Flatpak | x86 | 
| Obsidian | x86 |
| VS Code | x86 |
| Zulu JDK  21 | x86 | 
| JetBrains IntelliJ | x86 | 
| Sublime Text | x86 |


### Applications/Tools Still Pending
- RVM / Ruby
- Reverse touchpad Autoscroll
- Autosign in system settings
- Thunderbird Email
- Gpodder / Quod Libet
- Element


## Shell
Initial efforts will produce a shell script which will check the user's underlying system architecture and install packages based on that.

The primary target OS will be EndeavourOS, but any ARCH based Linux distribution should work fine. 

## Ansible
The primary goal will be to setup an Ansible server and get this working in a playbook to keep all packages running at the latest versions. 
I'd like to automate as much of the configuration of each tool as well. Like adding the Java OpenJDK to the system PATH. 
