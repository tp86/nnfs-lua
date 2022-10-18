local mat = require('matrix')

local RootObj = {
  new = function(self, obj)
    obj = obj or {}
    self.__index = self
    setmetatable(obj, self)
    return obj
  end,
}

local function gaussian(mean, variance)
  return math.sqrt(-2 * variance * math.log(math.random())) *
      math.cos(2 * math.pi * math.random()) + mean
end

local M = {}

local function forward(self, inputs)
  self.outputs = mat.addv(mat.dotT(inputs, self.weights), self.biases)
end

M.LayerDense = function(ninputs, nneurons)
  local weights = {}
  for n = 1, nneurons do
    weights[n] = {}
    for i = 1, ninputs do
      weights[n][i] = 0.01 * gaussian(0, 1)
    end
  end
  local biases = {}
  for n = 1, nneurons do
    biases[n] = 0
  end
  return RootObj:new {
    weights = mat.fromtable(weights),
    biases = biases,
    forward = forward,
  }
end

return M
