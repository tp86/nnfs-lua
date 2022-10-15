local v1 = { 1, 2, 3 }
local v2 = { 2, 3, 4 }

local dot = require('helpers').dot
local add = require('helpers').add

print(dot(v1, v2))
print(table.unpack(add(v1, v2)))
