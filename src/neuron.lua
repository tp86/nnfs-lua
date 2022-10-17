local mat = require('matrix')

local inputs = mat.fromtable{
  { 1, 2, 3, 2.5 },
  { 2, 5, -1, 2 },
  { -1.5, 2.7, 3.3, -0.8 },
}

local weights = mat.fromtable{
  { 0.2, 0.8, -0.5, 1.0 },
  { 0.5, -0.91, 0.26, -0.5 },
  { -0.26, -0.27, 0.17, 0.87 },
}
local biases = { 2, 3, 0.5 }
local weights2 = mat.fromtable{
  { 0.1, -0.14, 0.5 },
  { -0.5, 0.12, -0.33 },
  { -0.44, 0.73, -0.13 },
}
local biases2 = { -1, 2, -0.5 }

local function layeroutputs(weights, biases, inputs)
  return mat.addv(mat.dotT(inputs, weights), biases)
end

local s = os.clock()
local l1outputs = layeroutputs(weights, biases, inputs)
local l2outputs = layeroutputs(weights2, biases2, l1outputs)
local e = os.clock()
print(e - s)

mat.print(l2outputs)
