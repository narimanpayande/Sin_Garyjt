+## راهنمای نصب :
 +
 +git clone https://Github/kia-pashang/Tabchi.git
 +
 +cd Tabchi
 +
 +chmod +x intsall.sh
 +
 +./install.sh
 +
 +## نصب تمام شد
 +
 +## ران کردن ربات به صورت پیشفرض
 +
 +cd Tabchi
 +
 +lua creator.lua
 +
 +بعد ایدی سودو ست کنید مثلا : 353581089
 +
 +screen ./tabchi-0.sh
 +
 +شماره ست کنید و حالشو ببرین
 +
 +## ران کردن بات به صورت دستی
 +
 +cd Tabchi
 +
 +lua manual-creator.lua
 +
 +ایدی تبچی ست کنید مثلا : 5
 +
 +بعدش ایدی سودو بدین مثلا : 353581089
 +
 +screen ./tabchi-5.sh
 +
 +شماره ست کنید و حالشو ببرین
 +#!/bin/bash
 +while true ; do
 +  for entr in tabchi-*.sh ; do
 +    entry="${entr/.sh/}"
 +    tmux kill-session -t $entry
 +    rm -rf ~/.telegram-cli/$entry/data/animation/*
 +    rm -rf ~/.telegram-cli/$entry/data/audio/*
 +    rm -rf ~/.telegram-cli/$entry/data/document/*
 +    rm -rf ~/.telegram-cli/$entry/data/photo/*
 +    rm -rf ~/.telegram-cli/$entry/data/sticker/*
 +    rm -rf ~/.telegram-cli/$entry/data/temp/*
 +    rm -rf ~/.telegram-cli/$entry/data/video/*
 +    rm -rf ~/.telegram-cli/$entry/data/voice/*
 +    rm -rf ~/.telegram-cli/$entry/data/profile_photo/*
 +    tmux new-session -d -s $entry "./$entr"
 +    tmux detach -s $entry
 +  done
 +  echo Bots Running!
 +  sleep 1800
 +done
 +serpent = (loadfile "serpent.lua")()
 +tdcli = dofile('tdcli.lua')
 +redis = (loadfile "redis.lua")()
 +tabchi_id = "TABCHI-ID"
 +
 +function vardump(value)
 +  return serpent.block(value,{comment=false})
 +end
 +
 +function reload()
 +  tabchi = dofile("tabchi.lua")
 +end
 +
 +function dl_cb (arg, data)
 +end
 +
 +reload()
 +
 +function tdcli_update_callback(data)
 +  tabchi.update(data, tabchi_id)
 +  if data.message_ and data.message_.content_.text_ and data.message_.content_.text_ == "/reload" and data.message_.sender_user_id_ == tonumber(redis:get("tabchi:" .. tabchi_id ..":fullsudo")) then
 +    reload()
 +    tdcli.sendMessage(data.message_.chat_id_, 0, 1, "*Bot Reloaded*", 1, "md")
 +  elseif data.message_ and data.message_.content_.text_ and data.message_.content_.text_ == "/gitpull" and data.message_.sender_user_id_ == tonumber(redis:get("tabchi:" .. tabchi_id ..":fullsudo")) then
 +    io.popen("git fetch --all && git reset --hard origin/master && git pull origin master"):read("*all")
 +    reload()
 +    tdcli.sendMessage(data.message_.chat_id_, 0, 1, "*Updates Received And Bot Reloaded*", 1, "md")
 +  end
 +end
 +redis = (loadfile "redis.lua")()
 +io.write("Enter Tabchi ID : ")
 +local last = io.read()
 +io.popen('rm -rf ~/.telegram-cli/tabchi-'..last..' tabchi-'..last..'.lua tabchi-'..last..'.sh tabchi_'..last..'_logs.txt')
 +redis:del('tabchi:'..last..':*')
 +print("Done!\nAll Data/Files Of Tabchi Deleted\nTabchi ID : "..last)
 +redis = (loadfile "redis.lua")()
 +function gettabchiid()
 +    local i, t, popen = 0, {}, io.popen
 +    local pfile = popen('ls')
 +	local last = 0
 +    for filename in pfile:lines() do
 +        if filename:match('tabchi%-(%d+)%.lua') and tonumber(filename:match('tabchi%-(%d+)%.lua')) >= last then
 +			last = tonumber(filename:match('tabchi%-(%d+)%.lua')) + 1
 +			end		
 +    end
 +    return last
 +end
 +local last = gettabchiid()
 +io.write("Auto Detected Tabchi ID : "..last)
 +io.write("\nEnter Full Sudo ID : ")
 +local sudo=io.read()
 +local text,ok = io.open("base.lua",'r'):read('*a'):gsub("TABCHI%-ID",last)
 +io.open("tabchi-"..last..".lua",'w'):write(text):close()
 +io.open("tabchi-"..last..".sh",'w'):write("while true; do\n$(dirname $0)/telegram-cli-1222 -p tabchi-"..last.." -s tabchi-"..last..".lua\ndone"):close()
 +io.popen("chmod 777 tabchi-"..last..".sh")
 +redis:set('tabchi:'..last..':fullsudo',sudo)
 +print("Done!\nNew Tabchi Created...\nID : "..last.."\nFull Sudo : "..sudo.."\nRun : ./tabchi-"..last..".sh")
