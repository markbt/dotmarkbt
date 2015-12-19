#!/bin/bash 

# Save this script into set_colors.sh, make this file executable and run it: 
# 
# $ chmod +x set_colors.sh 
# $ ./set_colors.sh 
# 
# Alternatively copy lines below directly into your shell. 

gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_background --type bool false 
gconftool-2 --set /apps/gnome-terminal/profiles/Default/use_theme_colors --type bool false 
gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/background_color '#0d0d19192626'
gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/foreground_color '#d9d9e6e6f2f2'
gconftool-2 -s -t string /apps/gnome-terminal/profiles/Default/palette '#000000000000:#dbdb54545454:#5454dbdb5454:#dbdbdbdb5454:#54545454dbdb:#dbdb5454dbdb:#5454dbdbdbdb:#c8c8c8c8c8c8:#4a4a4a4a4a4a:#e9e996969696:#9696e9e99696:#e9e9e9e99696:#96969696e9e9:#e9e99696e9e9:#9696e9e9e9e9:#ffffffffffff'

