local izip = require('helpers').izip

local inputs = { 1, 2, 3, 2.5 }

local weights = {
  { 0.2, 0.8, -0.5, 1.0 },
  { 0.5, -0.91, 0.26, -0.5 },
  { -0.26, -0.27, 0.17, 0.87 },
}
local biases = {
  2,
  3,
  0.5,
}

local outputs = {}

for nweights, nbias in izip(weights, biases) do
  local output = 0
  for input, weight in izip(inputs, nweights) do
    output = output + input * weight
  end
  output = output + nbias
  outputs[#outputs+1] = output
end

print(table.unpack(outputs))
