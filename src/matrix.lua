local M = {}

--function M.itorc(i, cols)
--  local i1 = i - 1
--  return i1 // cols + 1, i1 % cols + 1
--end
--
--function M.rctoi(r, c, cols)
--  return (r - 1) * cols + c
--end

function M.fromtable(t)
  assert(type(t) == "table")
  local rows = #t or 0
  local cols = #t[1] or 0
  local data = {}
  for r = 1, rows do
    assert(#t[r] == cols)
    for c = 1, cols do
      local e = t[r][c]
      assert(type(e) ~= 'table')
      data[#data + 1] = t[r][c]
    end
  end
  data.rows = rows
  data.cols = cols
  return data
end

function M.transpose(m)
  local i = 1
  local mt = { rows = m.cols, cols = m.rows }
  for c = 1, m.cols do
    for r = 1, m.rows do
      i = (r - 1) * m.cols + c
      mt[#mt + 1] = m[i]
    end
  end
  return mt
end

function M.add(m1, m2)
  assert(m1.rows == m2.rows and m1.cols == m2.cols)
  local m = { rows = m1.rows, cols = m2.cols }
  for i = 1, #m1 do
    m[i] = m1[i] + m2[i]
  end
  return m
end

function M.addv(m, v)
  assert(m.cols == #v)
  local ma = { rows = m.rows, cols = m.cols }
  local vi = 1
  for i = 1, m.rows * m.cols do
    ma[#ma + 1] = m[i] + v[vi]
    vi = vi % #v + 1
  end
  return ma
end

function M.dot(m1, m2)
  assert(m1.cols == m2.rows)
  local m = { rows = m1.rows, cols = m2.cols }
  for r = 1, m1.rows do
    local r1 = r - 1
    for c = 1, m2.cols do
      local i = r1 * m.cols + c
      local dot = 0
      local r1offset = r1 * m1.cols
      for cr = 1, m1.cols do
        dot = dot + m1[r1offset + cr] * m2[(cr - 1) * m2.cols + c]
      end
      m[i] = dot
    end
  end
  return m
end

function M.dotT(m1, m2)
  assert(m1.cols == m2.cols)
  local m = { rows = m1.rows, cols = m2.rows }
  for r1 = 1, m1.rows do
    local r1offset = (r1 - 1) * m1.cols
    for r2 = 1, m2.rows do
      local r2offset = (r2 - 1) * m2.cols
      local dot = 0
      for c = 1, m1.cols do
        dot = dot + m1[r1offset + c] * m2[r2offset + c]
      end
      m[#m + 1] = dot
    end
  end
  return m
end

function M.max(value, m)
  local res = { rows = m.rows, cols = m.cols }
  for i = 1, m.rows * m.cols do
    res[i] = math.max(value, m[i])
  end
  return res
end

function M.print(m, from, to)
  from = from or 1
  to = to or m.rows
  local row = from
  for i, v in ipairs(m) do
    local c = (i - 1) % m.cols + 1
    io.write(string.format("% 0.3e ", v))
    if c == m.cols then
      io.write('\n')
      if row >= to then break end
      row = row + 1
    end
  end
end

return M
