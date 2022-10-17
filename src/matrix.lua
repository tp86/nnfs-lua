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
  -- TODO ensure shape
  local rows = #t
  local cols = #t[1]
  local data = {}
  for r = 1, rows do
    for c = 1, cols do
      data[#data+1] = t[r][c]
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
      mt[#mt+1] = m[i]
    end
  end
  return mt
end

function M.add(m1, m2)
  -- TODO assert shapes are same
  local m = { rows = m1.rows, cols = m2.cols }
  for i = 1, #m1 do
    m[i] = m1[i] + m2[i]
  end
  return m
end

function M.dot(m1, m2)
  -- TODO assert shapes
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

function M.print(m)
  for i, v in ipairs(m) do
    local c = (i - 1) % m.cols + 1
    io.write(string.format("%0.2f ", v))
    if c == m.cols then
      io.write('\n')
    end
  end
end

return M
