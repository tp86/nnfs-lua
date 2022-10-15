local dot = require('helpers').dot

local inputs = { 1, 2, 3, 2.5 }

local weights = { 0.2, 0.8, -0.5, 1.0 }
local bias = 2

local output = dot(inputs, weights) + bias
print(output)
