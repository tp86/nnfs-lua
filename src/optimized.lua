local sqrt = math.sqrt
local log = math.log
local random = math.random
local cos = math.cos
local pi = math.pi
local classmod = require('class')
local class = classmod.new
local init = classmod.initializer

local forward = function(self, inputs)
    local outputs = {}
    local output = 0
    local outputi = 1
    local neuronoffset = 0
    local neuronmax = -math.huge
    for sampleoffset = 0, #inputs - 1, self.inputs do
      neuronoffset = 0
      neuronmax = -math.huge
      for neuron = 1, self.neurons do
        output = self.biases[neuron]
        for inputi = 1, self.inputs do
          output = output + inputs[sampleoffset + inputi] * self.weights[neuronoffset + inputi]
        end
        if output > neuronmax then
          neuronmax = output
        end
        outputs[outputi] = output
        outputi = outputi + 1
        neuronoffset = neuronoffset + self.inputs
      end
    end
    self.outputs = outputs
end

local function gaussian()
  return sqrt(-2 * log(random())) * cos(2 * pi * random())
end

local M = {}

local forwardfnparts = {
  [[
  function(self, inputs)
    local outputs = {}
    local output = 0
    local outputi = 1
    local neuronoffset = 0
    for sampleoffset = 0, #inputs - 1, self.inputs do
      neuronoffset = 0
      for neuron = 1, self.neurons do
        output = self.biases[neuron]
        for inputi = 1, self.inputs do
          output = output + inputs[sampleoffset + inputi] * self.weights[neuronoffset + inputi]
        end
  ]],
  [[
        outputs[outputi] = output
        outputi = outputi + 1
        neuronoffset = neuronoffset + self.inputs
      end
    end
    self.outputs = outputs
  end
  ]]
}

M.Activations = {
  ReLU = { 'if output < 0 then output = 0 end' },
}

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

M.LayerDense = class {
  [init] = function(self, ninputs, nneurons, activationfn)
    self.neurons = nneurons
    self.inputs = ninputs
    self.weights = initweights(ninputs, nneurons)
    self.biases = initbiases(nneurons)
    local activationparts = activationfn or M.Activations.ReLU
    local forwardcode = {}
    for p = 1, #forwardfnparts do
      forwardcode[#forwardcode + 1] = forwardfnparts[p]
      forwardcode[#forwardcode + 1] = (activationparts[p] or '')
    end
    self.forward = load('return ' .. table.concat(forwardcode))()
  end,
}

return M
