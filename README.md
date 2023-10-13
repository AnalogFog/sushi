# sushi
Tooling to automate new device onboarding. 

## Shell
Initial efforts will produce a shell script which will check the user's underlying system architecture and install packages based on that.

The primary target OS will be EndeavourOS, but any ARCH based Linux distribution should work fine. 

### Target Applications/Tools
- Minecraft
- Obsidian
- VSCode
- Jetbrains IntelliJ
- Sublime Text
- Zulu 21 OpenJDK
- RVM / Ruby
- Reverse touchpad Autoscroll
- Autosign in system settings
- Thunderbird Email
- Gpodder / Quod Libet
- Element

## Ansible
The primary goal will be to setup an Ansible server and get this working in a playbook to keep all packages running at the lates versions. 
I'd like to automate as much as the configuration of each tool as well. Like adding the Java OpenJDK to the system PATH. 
