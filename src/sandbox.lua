local readfile = require('helpers').readfile

local X100data = readfile('data/X100.data', 2)

for _, point in ipairs(X100data) do
  print(table.unpack(point))
end

local y100data = readfile('data/y100.data')

for _, v in ipairs(y100data) do
  print(v)
end
