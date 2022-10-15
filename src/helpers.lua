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

function m.dot(v1, v2)
  local dot = 0
  for e1, e2 in m.izip(v1, v2) do
    dot = dot + e1 * e2
  end
  return dot
end

function m.add(v1, v2)
  local sumv = {}
  for e1, e2 in m.izip(v1, v2) do
    sumv[#sumv+1] = e1 + e2
  end
  return sumv
end

return m
