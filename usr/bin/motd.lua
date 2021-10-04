-- Serve a random MOTD --

local computer = require("computer")

local motds = {
  "KolibraCorp 2021. All rights reserved."
}

print(' ')
print(shell._VERSION .. " on " .. kernel._VERSION .. " - " .. tostring(math.floor(computer.totalMemory()/1024)) .. "k RAM")
print(motds[math.random(1, #motds)])
print(' ')

