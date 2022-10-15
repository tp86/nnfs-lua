local M = {}

function M.izip(t1, t2)
  local i = 1
  local function iter()
    local e1, e2 = t1[i], t2[i]
    i = i + 1
    return e1, e2
  end

  return iter
end

function M.vdot(v1, v2)
  local dot = 0
  for e1, e2 in M.izip(v1, v2) do
    dot = dot + e1 * e2
  end
  return dot
end

function M.mdot(m, v)
  local dot = {}
  for _, v1 in ipairs(m) do
    dot[#dot+1] = M.vdot(v1, v)
  end
  return dot
end

function M.add(v1, v2)
  local sumv = {}
  for e1, e2 in M.izip(v1, v2) do
    sumv[#sumv+1] = e1 + e2
  end
  return sumv
end

return M
