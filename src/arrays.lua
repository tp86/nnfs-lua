local M = {}

local function checkshape(m, r, c, l)
  l = l or 4
  if r and r > m.shape[1] then error('row index too high', l) end
  if c and c > m.shape[2] then error('column index too high', l) end
end

local function getindex(m, r, c)
  checkshape(m, r, c)
  return (r - 1) * m.shape[2] + c
end

local function get(m, r, c)
  local i = getindex(m, r, c)
  return m[i]
end

local function rowi(m, r)
  local imin = (r - 1) * m.shape[2] + 1
  local imax = imin + m.shape[2] - 1
  local i = imin
  local function iter()
    if i > imax then return end
    local v = i
    i = i + 1
    return v
  end

  return iter
end

local function coli(m, c)
  local imin = c
  local imax = (m.shape[1] - 1) * m.shape[2] + c
  local i = imin
  local function iter()
    if i > imax then return end
    local v = i
    i = i + m.shape[2]
    return v
  end

  return iter
end

local function dot(m1, m2)
  -- TODO: finish general version
  local m = {}
  local mr = m1.shape[1]
  local mc = m2.shape[2]
  assert(m1.shape[2] == m2.shape[1])
  for r = 1, mr do
    for c = 1, mc do
      local m1iter = rowi(m1, r)
      local m2iter = coli(m2, c)
      local m1i, m2i = m1iter(), m2iter()
      while m1i do
        print(m1[m1i], m2[m2i])
        m1i, m2i = m1iter(), m2iter()
      end
    end
  end
end

M.dot = dot

function M.Mat(t)
  if type(t) ~= 'table' then
    error('Matrix can only be constructed from table, given ' .. type(t), 2)
  end

  local m = {
    get = get,
  }

  local row1 = t[1]
  if type(row1) == 'table' then
    local rows = #t
    local cols = #row1
    m.shape = { rows, cols }
    for r = 1, rows do
      for c = 1, cols do
        m[#m + 1] = t[r][c]
      end
    end
  else
    local cols = #t
    m.shape = { 1, cols }
    for c = 1, cols do
      m[#m + 1] = t[c]
    end
  end

  return m
end

return M
