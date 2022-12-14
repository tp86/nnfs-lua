local class = require('class').new
local init = require('class').initializer
local sqrt = math.sqrt
local log = math.log
local random = math.random
local cos = math.cos
local pi = math.pi

local function gaussian()
  return sqrt(-2 * log(random())) * cos(2 * pi * random())
end

local M = {}
M.Layer = {}
M.Activation = {}

local function makeLayerDenseClass()
  local function initweights(ninputs, nneurons)
    local weights = {}
    for i = 1, nneurons * ninputs do
      weights[i] = 0.01 * gaussian()
    end
    return weights
  end

  local function initbiases(nneurons)
    local biases = {}
    for n = 1, nneurons do
      biases[n] = 0
    end
    return biases
  end

  return class {
    [init] = function(self, ninputs, nneurons, activationfn, weights, biases)
      self.inputs = ninputs
      self.neurons = nneurons
      self.weights = weights or initweights(ninputs, nneurons)
      self.biases = biases or initbiases(nneurons)
      self.activationfn = activationfn or M.Activation.ReLU
    end,
    forward = function(self, inputs)
      local outputs = self.outputs or {}
      local output = 0
      local neuronoffset = 0
      local outputindex = 1
      for sampleoffset = 0, #inputs - 1, self.inputs do
        neuronoffset = 0
        for neuronindex = 1, self.neurons do
          output = self.biases[neuronindex]
          for inputindex = 1, self.inputs do
            output = output + self.weights[neuronoffset + inputindex] * inputs[sampleoffset + inputindex]
          end
          outputs[outputindex] = output
          outputindex = outputindex + 1
          neuronoffset = neuronoffset + self.inputs
        end
      end
      self:activationfn(outputs)
      self.outputs = outputs
    end,
  }
end

M.Layer.Dense = makeLayerDenseClass()

M.Activation.ReLU = function(_, data)
  for i, v in ipairs(data) do
    if v > 0 then
      data[i] = v
    else
      data[i] = 0
    end
  end
end

local exp = math.exp
M.Activation.Softmax = function(self, data)
  local inputspersample = self.neurons
  local neuronoutputsmax = -math.huge
  local neuronoutputssum = 0
  local expvalue = 0
  local index = 0
  for sampleoffset = 0, #data - 1, inputspersample do
    neuronoutputsmax = -math.huge
    neuronoutputssum = 0
    -- first pass - find max
    for inputindex = 1, inputspersample do
      local value = data[sampleoffset + inputindex]
      if value > neuronoutputsmax then
        neuronoutputsmax = value
      end
    end
    -- second pass - exponentiate and sum
    for inputindex = 1, inputspersample do
      index = sampleoffset + inputindex
      expvalue = exp(data[index] - neuronoutputsmax)
      neuronoutputssum = neuronoutputssum + expvalue
      data[index] = expvalue
    end
    -- third pass - divide by sum
    for inputindex = 1, inputspersample do
      index = sampleoffset + inputindex
      data[index] = data[index] / neuronoutputssum
    end
  end
end

return M
