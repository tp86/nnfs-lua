local mat = require('matrix')
local class = require('class').new
local init = require('class').initializer

local function gaussian(mean, variance)
  mean = mean or 0
  variance = variance or 1
  return math.sqrt(-2 * variance * math.log(math.random())) *
      math.cos(2 * math.pi * math.random()) + mean
end

local M = {}

local function initweights(ninputs, nneurons)
  local weights = {}
  for n = 1, nneurons do
    weights[n] = {}
    for i = 1, ninputs do
      weights[n][i] = 0.01 * gaussian()
    end
  end
  return mat.fromtable(weights)
end
local function initbiases(nneurons)
  local biases = {}
  for n = 1, nneurons do
    biases[n] = 0
  end
  return biases
end
M.LayerDense = class{
  [init] = function(self, ninputs, nneurons)
    self.outputs = {}
    self.weights = initweights(ninputs, nneurons)
    self.biases = initbiases(nneurons)
  end,
  forward = function(self, inputs)
    self.outputs = mat.addv(mat.dotT(inputs, self.weights), self.biases)
  end,
}

M.ActivationReLU = class{
  forward = function(self, inputs)
    self.outputs = mat.max(0, inputs)
  end,
}

return M
