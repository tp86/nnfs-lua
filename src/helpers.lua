local m = {}

function m.izip(...)
  local tables = {...}

  local minlength = #tables[1] or 0
  for _, t in ipairs(tables) do
    minlength = math.min(minlength, #t)
  end

  local i = 1
  local function iter()
    if i > minlength then return end
    local values = {}
    for _, t in ipairs(tables) do
      values[#values+1] = t[i]
    end
    i = i + 1
    return table.unpack(values)
  end

  return iter
end

return m
