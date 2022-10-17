local mat = require('matrix')

local inputs = mat.fromtable{
  { 1, 2, 3, 2.5 },
  { 2, 5, -1, 2 },
  { -1.5, 2.7, 3.3, -0.8 },
}

local weights = mat.fromtable{
  { 0.2, 0.8, -0.5, 1.0 },
  { 0.5, -0.91, 0.26, -0.5 },
  { -0.26, -0.27, 0.17, 0.87 },
}
local biases = { 2, 3, 0.5 }

local outputs = mat.addv(mat.dotT(inputs, weights), biases)

mat.print(outputs)
