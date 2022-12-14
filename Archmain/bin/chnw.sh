#!/bin/sh
# Archmain. maintenance app for Arch Linux.
# Author Jonathan Sanfilippo, Ivan Karavitis 
# Date Fri Jul 29 2022
# Copyright (C) 2022 Jonathan Sanfilippo <jonathansanfilippo.uk@gmail.com>



#Setting ------------------------------------------------------------------------


#Variable URL
list="$HOME/.local/share/Archmain/data/listupdates"
pending="$HOME/.local/share/Archmain/data/pending"
statusDelay="$HOME/.local/share/Archmain/data/statusDelay"
lastcheck="$HOME/.local/share/Archmain/data/lastcheck"
ini="$HOME/.local/share/Archmain/data/config/set.ini"
ini2="$HOME/.local/share/Archmain/data/config/set2.ini"
no="$HOME/.local/share/Archmain/data/no.ini"
noini="$HOME/.local/share/Archmain/data/config/no.ini"
gr="$HOME/.local/share/Archmain/data/gr.ini"
grini="$HOME/.local/share/Archmain/data/config/gr.ini"
or="$HOME/.local/share/Archmain/data/or.ini"
orini="$HOME/.local/share/Archmain/data/config/or.ini"
config="$HOME/.local/share/Archmain/data/config"
urltemp="$HOME/.local/share/Archmain/data/temp"

echo '' > $list

#Variable Cmd
get_Variables(){
AUR=$(pikaur -Qqua ;)
ListUpdates=$( checkupdates 2>/dev/null )
Pending=$(expr $(pikaur -Qqua | wc -l) + $(checkupdates 2>/dev/null | wc -l) )
DataTime=$(date '+%a %d %b %H:%M '  )

}

get_Variables


if [ "$Pending" -eq 1 ]; then
  echo "$Pending Update Pending" > "$pending"
  echo "$ListUpdates" "$AUR"  >> "$list"
  cp -r "$or" "$config"
  mv "$orini" "$ini"
  cp -r "$or" "$config"
  mv "$orini" "$ini2"
  elif
   [ "$Pending" -gt 0 ]; then
  echo "$Pending Updates Pending" > "$pending"
  echo "$ListUpdates"  "$AUR" >> "$list"
  cp -r "$or" "$config"
  mv "$orini" "$ini"
  cp -r "$or" "$config"
  mv "$orini" "$ini2"
  else
   echo "System Updated " > "$pending"
   echo 'System Updated' > "$list"
   cp -r "$gr" "$config"
   mv "$grini" "$ini"
   cp -r "$no" "$config"
   mv "$noini" "$ini2"
fi

 echo "OFF" > "$statusDelay"
echo "$DataTime" > "$lastcheck"

mv "$urltemp"  "$HOME/.local/share/Archmain/data/@lastup" 
