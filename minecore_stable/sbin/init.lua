-- Basically the CC-UNIX init script :P --

local panic = ...

if sh then
  error("mineSHELL is already running!")
  return false
end

-- Messy
write("\n")
term.setTextColor(0x6699FF)
write("  mineSHELL ")
term.setTextColor(0xFFFFFF)
write("starting up ")
term.setTextColor(0xFFFF00)
write(kernel.version().."\n\n")
term.setTextColor(0xFFFFFF)
-- /Messy

kernel.log("Starting mineSHELL services")
local initd = fs.list("/etc/init.d")
table.sort(initd)
for i=1, #initd, 1 do
  kernel.log("Loading /etc/init.d/" .. initd[i])
  local ok, err = loadfile("/etc/init.d/" .. initd[i])
  if not ok then
    panic(err)
  end
  local s, r = pcall(ok)
  if not s then
    panic(r)
  end
end

kernel.log("Starting mineRC")
local ok, err = loadfile("/sbin/minerc.lua")
if not ok then
  panic("mineRC crashed! " .. err)
end
local status, ret = pcall(ok)
if not status then
  panic("OpenRC crashed! " .. ret)
end

kernel.log("Starting shell")
kernel.hideLogs()

while true do
  local ok, err = loadfile("/bin/sh.lua")
  if not ok then
    printError(err)
    break
  else
    os.spawn("shell", ok)
    os.start()
  end
end
