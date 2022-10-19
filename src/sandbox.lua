local readfile = require('helpers').readfile

local X100data = readfile('data/X100.data', 2)
local y100data = readfile('data/y100.data')
local mat = require('matrix')
local X = mat.fromtable(X100data)

local LayerDense = require('neuron').LayerDense
local ActivationReLU = require('neuron').ActivationReLU

local layer1 = LayerDense(2, 3)
local activation1 = ActivationReLU()
local s = os.clock()
layer1:forward(X)
activation1:forward(layer1.outputs)
local e = os.clock()
print(e - s)

mat.print(activation1.outputs, 1, 5)
