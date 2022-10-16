local M = {}

function M.fromtable(t)
  local m = {}
  if type(t) ~= 'table' then error('cannot determine shape of type ' .. type(t)) end
  local tlength = #t
  local elem1 = t[1]
  if type(elem1) == 'table' then
    local elems = #elem1
    for r = 2, tlength do
      if type(t[r]) ~= 'table' or #t[r] ~= elems then error('all rows must have the same number of columns') end
    end
    m.shape = { tlength, elems }
    for r = 1, m.shape[1] do
      for c = 1, m.shape[2] do
        m[#m+1] = t[r][c]
      end
    end
  else
    m.shape = { 1, tlength }
    for c = 2, tlength do
      if type(t[c]) == 'table' then error('malformed matrix') end
    end
    for i = 1, tlength do
      m[#m+1] = t[i]
    end
  end
  return m
end

function M.zeros(r, c)
  local m = { shape = { r, c } }
  for _ = 1, r*c do
    m[#m+1] = 0
  end
  return m
end

local coli

local function rowi(m, r)
  if m.transposed then return coli(m, r) end
  local rmin = (r - 1) * m.shape[2] + 1
  local rmax = r * m.shape[2]
  local i = rmin
  local function iter()
    if i > rmax then return end
    local v = i
    i = i + 1
    return v
  end

  return iter
end

function coli(m, c)
  local cmin = c
  local cmax = (m.shape[1] - 1) * m.shape[2] + c
  local cstep = m.shape[2]
  local i = cmin
  local function iter()
    if i > cmax then return end
    local v = i
    i = i + cstep
    return v
  end

  return iter
end

local function rowindices(m, r)
  if m.transposed then return coli(m, r) end
  return rowi(m, r)
end

local function colindices(m, c)
  if m.transposed then return rowi(m, c) end
  return coli(m, c)
end

local function dotrc(m1, m2, r, c)
  local dot = 0
  local riter = rowindices(m1, r)
  local citer = colindices(m2, c)
  local ri, ci = riter(), citer()
  while ri and ci do
    dot = dot + m1[ri] * m2[ci]
    ri, ci = riter(), citer()
  end
  return dot
end

function M.dot(m1, m2)
  assert(m1.shape[2] == m2.shape[1])
  local m = M.zeros(m1.shape[1], m2.shape[2])
  for r = 1, m1.shape[1] do
    for c = 1, m2.shape[2] do
      local i = (r - 1) * m.shape[2] + c
      m[i] = dotrc(m1, m2, r, c)
    end
  end
  return m
end

function M.T(m)
  m.shape[1], m.shape[2] = m.shape[2], m.shape[1]
  if not m.transposed then
    m.transposed = true
  else
    m.transposed = nil
  end
  return m
end

--------------------------------------------------------------------------------

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
local function gettransposed(m, r, c)
  return get(m, c, r)
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
