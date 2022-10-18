local mat = require('matrix')

local inputs = mat.fromtable {
  { 1, 2, 3, 2.5 },
  { 2, 5, -1, 2 },
  { -1.5, 2.7, 3.3, -0.8 },
}

local weights = mat.fromtable {
  { 0.2, 0.8, -0.5, 1.0 },
  { 0.5, -0.91, 0.26, -0.5 },
  { -0.26, -0.27, 0.17, 0.87 },
}
local biases = { 2, 3, 0.5 }
local weights2 = mat.fromtable {
  { 0.1, -0.14, 0.5 },
  { -0.5, 0.12, -0.33 },
  { -0.44, 0.73, -0.13 },
}
local biases2 = { -1, 2, -0.5 }

---@diagnostic disable-next-line: redefined-local
local function layeroutputs(weights, biases, inputs)
  return mat.addv(mat.dotT(inputs, weights), biases)
end

local s = os.clock()
local l1outputs = layeroutputs(weights, biases, inputs)
local l2outputs = layeroutputs(weights2, biases2, l1outputs)
local e = os.clock()
print(e - s)

mat.print(l2outputs)

local neuron = require('neuron')

local layer1 = neuron.LayerDense(4, 3)
local layer2 = neuron.LayerDense(3, 3)
layer1:forward(inputs)
layer2:forward(layer1.outputs)
mat.print(layer2.outputs)
--[[
local readfile = require('helpers').readfile

local X100data = readfile('data/X100.data', 2)

for _, point in ipairs(X100data) do
  print(table.unpack(point))
end

local y100data = readfile('data/y100.data')

for _, v in ipairs(y100data) do
  print(v)
end
--]]
