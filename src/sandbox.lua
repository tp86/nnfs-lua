local v1 = { 1, 2, 3 }
local v2 = { 2, 3, 4 }

local dot = require('helpers').vdot
local add = require('helpers').add

--print(dot(v1, v2))
--print(table.unpack(add(v1, v2)))

local arr = require('arrays')

arr.dot(arr.Mat{1, 2, 3}, arr.Mat{{4}, {5}, {6}})
