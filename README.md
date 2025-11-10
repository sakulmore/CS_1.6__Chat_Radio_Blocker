# CS_1.6__Chat_Radio_Blocker
A plugin that blocks radio (RADIO) messages in chat (globally; it does not affect voice commands).

# Installation
- Just download the plugin and upload the .amxx file to your plugins folder on your server (or you can of course compile the .sma file and then upload the compilated .amxx file to your server).
- Then write the plugin name (with .amxx) to `/cstrike/addons/amxmodx/configs/plugins.ini`.

# Requirements
- AMX Mod X 1.10

# Features
- Enables/Disables radio messages (RADIO) in chat.
- Easy to use

# Console Commands
`amx_radioturn on/off` = ON = Enable | OFF = Disable | Default = OFF
- If you want to set a specific value permanently, you can write the cvar into `server.cfg`.

The command is protected by an Admin Flag. To change the Admin Flag, simply edit the line `#define RADIO_TOGGLE_FLAG ADMIN_BAN` in the .sma file.

# Support
If you having any issues please feel free to write your issue to the issue section :) .

# Showcases
https://youtu.be/otEziremJWc
