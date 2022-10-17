local mat = require('matrix')

local m1 = mat.fromtable{
  { 0.49, 0.97, 0.53, 0.05 },
  { 0.33, 0.65, 0.62, 0.51 },
  { 1.00, 0.38, 0.61, 0.45 },
  { 0.74, 0.27, 0.64, 0.17 },
  { 0.36, 0.17, 0.96, 0.12 },
}
local m2 = mat.fromtable{
  { 0.79, 0.32, 0.68, 0.90, 0.77 },
  { 0.18, 0.39, 0.12, 0.93, 0.09 },
  { 0.87, 0.42, 0.60, 0.71, 0.12 },
  { 0.45, 0.55, 0.40, 0.78, 0.81 },
}
local s = os.clock()
local mdot = mat.dot(m1, m2)
local e = os.clock()
print(e - s)
mat.print(mdot)
print()

--mat.print(mat.add(m1, mat.transpose(m2)))

local m2t = mat.transpose(m2)
s = os.clock()
local mdotT = mat.dotT(m1, m2t)
e = os.clock()
print(e - s)
mat.print(mdotT)
