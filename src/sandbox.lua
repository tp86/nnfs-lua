local readfile = require('helpers').readfile

local X100data = readfile('data/X100.data', 2)
local y100data = readfile('data/y100.data')
local mat = require('matrix')
local X = mat.fromtable(X100data)

local LayerDense = require('neuron').Layer.Dense
local Softmax = require('neuron').Activation.Softmax

local layer1 = LayerDense(2, 3)
local layer2 = LayerDense(3, 3, Softmax)
local s = os.clock()
--for _ = 1, 10000 do
layer1:forward(X)
layer2:forward(layer1.outputs)
--end
local e = os.clock()
print(e - s)

local function printoutputs(outputs, rows, cols)
  for index = 1, rows * cols do
    io.write(string.format("% 0.7e ", outputs[index]))
    if index % cols == 0 then
      io.write('\n')
    end
  end
end

printoutputs(layer2.outputs, 5, layer2.neurons)

local function argmax(t)
  local maxindex
  local maxvalue
  for i, v in ipairs(t) do
    if v > (maxvalue or -math.huge) then
      maxvalue = v
      maxindex = i
    end
  end
  return maxindex, maxvalue
end
