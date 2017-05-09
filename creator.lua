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
 +#!/usr/bin/env bash
 +wget "https://valtman.name/files/telegram-cli-1222"
 +sudo apt-get install libreadline6 libreadline-dev libreadline-dev libreadline6-dev libconfig-dev libssl-dev tmux lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip redis-server autoconf git g++ libjansson-dev libpython-dev expat libexpat1-dev ppa-purge python3-pip python3-dev software-properties-common python-software-properties 
 +sudo add-apt-repository ppa:ubuntu-toolchain-r/test
 +sudo apt-get update
 +sudo apt-get upgrade
 +sudo apt-get dist-upgrade
 +sudo ppa-purge
 +sudo service redis-server restart
 +chmod 777 telegram-cli-1222
 +chmod 777 anticrash.sh
 +RED='\033[0;31m'
 +NC='\033[0m'
 +CYAN='\033[0;36m'
 +echo -e "${CYAN}Installation Completed. Create a bot with creator.lua (lua creator.lua)${NC}"
 +exit
 +redis = (loadfile "redis.lua")()
 +io.write("Enter Tabchi ID : ")
 +local last = io.read()
 +io.write("\nEnter Full Sudo ID : ")
 +local sudo=io.read()
 +local text,ok = io.open("base.lua",'r'):read('*a'):gsub("TABCHI%-ID",last)
 +io.open("tabchi-"..last..".lua",'w'):write(text):close()
 +io.open("tabchi-"..last..".sh",'w'):write("while true; do\n./telegram-cli-1222 -p tabchi-"..last.." -s tabchi-"..last..".lua\ndone"):close()
 +io.popen("chmod 777 tabchi-"..last..".sh")
 +redis:set('tabchi:'..last..':fullsudo',sudo)
 +print("Done!\nNew Tabchi Created...\nID : "..last.."\nFull Sudo : "..sudo.."\nRun : ./tabchi-"..last..".sh")
 +local Redis = (loadfile "lua-redis.lua")()
 +local FakeRedis = (loadfile "fakeredis.lua")()
 +
 +local params = {
 +  host = '127.0.0.1',
 +  port = 6379,
 +}
 +
 +-- Overwrite HGETALL
 +Redis.commands.hgetall = Redis.command('hgetall', {
 +  response = function(reply, command, ...)
 +    local new_reply = { }
 +    for i = 1, #reply, 2 do new_reply[reply[i]] = reply[i + 1] end
 +    return new_reply
 +  end
 +})
 +
 +local redis = nil
 +
 +-- Won't launch an error if fails
 +local ok = pcall(function()
 +  redis = Redis.connect(params)
 +end)
 +
 +if not ok then
 +
 +  local fake_func = function()
 +    print('\27[31mCan\'t connect with Redis, install/configure it!\27[39m')
 +  end
 +  fake_func()
 +  fake = FakeRedis.new()
 +
 +  print('\27[31mRedis addr: '..params.host..'\27[39m')
 +  print('\27[31mRedis port: '..params.port..'\27[39m')
 +
 +  redis = setmetatable({fakeredis=true}, {
 +  __index = function(a, b)
 +    if b ~= 'data' and fake[b] then
 +      fake_func(b)
 +    end
 +    return fake[b] or fake_func
 +  end })
 +
 +end
 +
 +
 +return redis
 +local n, v = "serpent", 0.28 -- (C) 2012-15 Paul Kulchenko; MIT License
 +local c, d = "Paul Kulchenko", "Lua serializer and pretty printer"
 +local snum = {[tostring(1/0)]='1/0 --[[math.huge]]',[tostring(-1/0)]='-1/0 --[[-math.huge]]',[tostring(0/0)]='0/0'}
 +local badtype = {thread = true, userdata = true, cdata = true}
 +local keyword, globals, G = {}, {}, (_G or _ENV)
 +for _,k in ipairs({'and', 'break', 'do', 'else', 'elseif', 'end', 'false',
 +  'for', 'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat',
 +  'return', 'then', 'true', 'until', 'while'}) do keyword[k] = true end
 +for k,v in pairs(G) do globals[v] = k end -- build func to name mapping
 +for _,g in ipairs({'coroutine', 'debug', 'io', 'math', 'string', 'table', 'os'}) do
 +  for k,v in pairs(G[g] or {}) do globals[v] = g..'.'..k end end
 +
 +local function s(t, opts)
 +  local name, indent, fatal, maxnum = opts.name, opts.indent, opts.fatal, opts.maxnum
 +  local sparse, custom, huge = opts.sparse, opts.custom, not opts.nohuge
 +  local space, maxl = (opts.compact and '' or ' '), (opts.maxlevel or math.huge)
 +  local iname, comm = '_'..(name or ''), opts.comment and (tonumber(opts.comment) or math.huge)
 +  local seen, sref, syms, symn = {}, {'local '..iname..'={}'}, {}, 0
 +  local function gensym(val) return '_'..(tostring(tostring(val)):gsub("[^%w]",""):gsub("(%d%w+)",
 +    -- tostring(val) is needed because __tostring may return a non-string value
 +    function(s) if not syms[s] then symn = symn+1; syms[s] = symn end return tostring(syms[s]) end)) end
 +  local function safestr(s) return type(s) == "number" and tostring(huge and snum[tostring(s)] or s)
 +    or type(s) ~= "string" and tostring(s) -- escape NEWLINE/010 and EOF/026
 +    or ("%q"):format(s):gsub("\010","n"):gsub("\026","\\026") end
 +  local function comment(s,l) return comm and (l or 0) < comm and ' --[['..tostring(s)..']]' or '' end
 +  local function globerr(s,l) return globals[s] and globals[s]..comment(s,l) or not fatal
 +    and safestr(select(2, pcall(tostring, s))) or error("Can't serialize "..tostring(s)) end
 +  local function safename(path, name) -- generates foo.bar, foo[3], or foo['b a r']
 +    local n = name == nil and '' or name
 +    local plain = type(n) == "string" and n:match("^[%l%u_][%w_]*$") and not keyword[n]
 +    local safe = plain and n or '['..safestr(n)..']'
 +    return (path or '')..(plain and path and '.' or '')..safe, safe end
 +  local alphanumsort = type(opts.sortkeys) == 'function' and opts.sortkeys or function(k, o, n) -- k=keys, o=originaltable, n=padding
 +    local maxn, to = tonumber(n) or 12, {number = 'a', string = 'b'}
 +    local function padnum(d) return ("%0"..tostring(maxn).."d"):format(tonumber(d)) end
 +    table.sort(k, function(a,b)
 +      -- sort numeric keys first: k[key] is not nil for numerical keys
 +      return (k[a] ~= nil and 0 or to[type(a)] or 'z')..(tostring(a):gsub("%d+",padnum))
 +           < (k[b] ~= nil and 0 or to[type(b)] or 'z')..(tostring(b):gsub("%d+",padnum)) end) end
 +  local function val2str(t, name, indent, insref, path, plainindex, level)
 +    local ttype, level, mt = type(t), (level or 0), getmetatable(t)
 +    local spath, sname = safename(path, name)
 +    local tag = plainindex and
 +      ((type(name) == "number") and '' or name..space..'='..space) or
 +      (name ~= nil and sname..space..'='..space or '')
 +    if seen[t] then -- already seen this element
 +      sref[#sref+1] = spath..space..'='..space..seen[t]
 +      return tag..'nil'..comment('ref', level) end
 +    if type(mt) == 'table' and (mt.__serialize or mt.__tostring) then -- knows how to serialize itself
 +      seen[t] = insref or spath
 +      if mt.__serialize then t = mt.__serialize(t) else t = tostring(t) end
 +      ttype = type(t) end -- new value falls through to be serialized
 +    if ttype == "table" then
 +      if level >= maxl then return tag..'{}'..comment('max', level) end
 +      seen[t] = insref or spath
 +      if next(t) == nil then return tag..'{}'..comment(t, level) end -- table empty
 +      local maxn, o, out = math.min(#t, maxnum or #t), {}, {}
 +      for key = 1, maxn do o[key] = key end
 +      if not maxnum or #o < maxnum then
 +        local n = #o -- n = n + 1; o[n] is much faster than o[#o+1] on large tables
 +        for key in pairs(t) do if o[key] ~= key then n = n + 1; o[n] = key end end end
 +      if maxnum and #o > maxnum then o[maxnum+1] = nil end
 +      if opts.sortkeys and #o > maxn then alphanumsort(o, t, opts.sortkeys) end
 +      local sparse = sparse and #o > maxn -- disable sparsness if only numeric keys (shorter output)
 +      for n, key in ipairs(o) do
 +        local value, ktype, plainindex = t[key], type(key), n <= maxn and not sparse
 +        if opts.valignore and opts.valignore[value] -- skip ignored values; do nothing
 +        or opts.keyallow and not opts.keyallow[key]
 +        or opts.valtypeignore and opts.valtypeignore[type(value)] -- skipping ignored value types
 +        or sparse and value == nil then -- skipping nils; do nothing
 +        elseif ktype == 'table' or ktype == 'function' or badtype[ktype] then
 +          if not seen[key] and not globals[key] then
 +            sref[#sref+1] = 'placeholder'
 +            local sname = safename(iname, gensym(key)) -- iname is table for local variables
 +            sref[#sref] = val2str(key,sname,indent,sname,iname,true) end
 +          sref[#sref+1] = 'placeholder'
 +          local path = seen[t]..'['..tostring(seen[key] or globals[key] or gensym(key))..']'
 +          sref[#sref] = path..space..'='..space..tostring(seen[value] or val2str(value,nil,indent,path))
 +        else
 +          out[#out+1] = val2str(value,key,indent,insref,seen[t],plainindex,level+1)
 +        end
 +      end
 +      local prefix = string.rep(indent or '', level)
 +      local head = indent and '{\n'..prefix..indent or '{'
 +      local body = table.concat(out, ','..(indent and '\n'..prefix..indent or space))
 +      local tail = indent and "\n"..prefix..'}' or '}'
 +      return (custom and custom(tag,head,body,tail) or tag..head..body..tail)..comment(t, level)
 +    elseif badtype[ttype] then
 +      seen[t] = insref or spath
 +      return tag..globerr(t, level)
 +    elseif ttype == 'function' then
 +      seen[t] = insref or spath
 +      local ok, res = pcall(string.dump, t)
 +      local func = ok and ((opts.nocode and "function() --[[..skipped..]] end" or
 +        "((loadstring or load)("..safestr(res)..",'@serialized'))")..comment(t, level))
 +      return tag..(func or globerr(t, level))
 +    else return tag..safestr(t) end -- handle all other types
 +  end
 +  local sepr = indent and "\n" or ";"..space
 +  local body = val2str(t, name, indent) -- this call also populates sref
 +  local tail = #sref>1 and table.concat(sref, sepr)..sepr or ''
 +  local warn = opts.comment and #sref>1 and space.."--[[incomplete output with shared/self-references skipped]]" or ''
 +  return not name and body..warn or "do local "..body..sepr..tail.."return "..name..sepr.."end"
 +end
 +
 +local function deserialize(data, opts)
 +  local env = (opts and opts.safe == false) and G
 +    or setmetatable({}, {
 +        __index = function(t,k) return t end,
 +        __call = function(t,...) error("cannot call functions") end
 +      })
 +  local f, res = (loadstring or load)('return '..data, nil, nil, env)
 +  if not f then f, res = (loadstring or load)(data, nil, nil, env) end
 +  if not f then return f, res end
 +  if setfenv then setfenv(f, env) end
 +  return pcall(f)
 +end
 +
 +local function merge(a, b) if b then for k,v in pairs(b) do a[k] = v end end; return a; end
 +return { _NAME = n, _COPYRIGHT = c, _DESCRIPTION = d, _VERSION = v, serialize = s,
 +  load = deserialize,
 +  dump = function(a, opts) return s(a, merge({name = '_', compact = true, sparse = true}, opts)) end,
 +  line = function(a, opts) return s(a, merge({sortkeys = true, comment = true}, opts)) end,
 +  +#!/bin/bash
 +sudo apt-get install -y tor
 +sudo service tor start
 +sudo export http_proxy=socks5://127.0.0.1:9050 https_proxy=socks5://127.0.0.1:9050
 +NC='\033[0m'
 +CYAN='\033[0;36m'
 +echo -e "${CYAN}All Done! Tor Installed And Applied..., Enjoy Your Bots${NC}"
 +exit
 +block = function(a, opts) return s(a, merge({indent = '  ', sortkeys = true, comment = true}, opts)) end }
 +local pfile = io.popen('ls')
 +for filename in pfile:lines() do
 +  if filename:match('tabchi%-(%d+)%.lua') then
 +    local text, ok = io.open(filename,'r'):read('*a'):gsub([[localfile("tabchi.lua")()]],[[tabchi = dofile("tabchi.lua")]]):gsub([[update(data, tabchi_id)]],[[tabchi.update(data, tabchi_id)]])
 +    io.open(filename,'w'):write(text):close()
 +  end
 +end
 +print("Bots Source Updated!")
