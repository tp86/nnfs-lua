local dot = require('helpers').mdot
local add = require('helpers').add

local inputs = { 1, 2, 3, 2.5 }

local weights = {
  { 0.2, 0.8, -0.5, 1.0 },
  { 0.5, -0.91, 0.26, -0.5 },
  { -0.26, -0.27, 0.17, 0.87 },
}
local biases = { 2, 3, 0.5 }

local outputs = add(dot(weights, inputs), biases)
print(table.unpack(outputs))
