local M = {}

function M.readfile(filename, pointdims)
  local file = assert(io.open(filename, 'r'))
  local data = {}
  local pointsize = 4 * (pointdims or 1)
  local point = file:read(pointsize)
  local unpackfmt = string.rep('f', (pointdims or 1))
  repeat
    local pointdata = table.pack(string.unpack(unpackfmt, point))
    table.remove(pointdata)
    if not pointdims then
      pointdata = table.unpack(pointdata)
    end
    data[#data+1] = pointdata
    point = file:read(pointsize)
  until not point
  file:close()
  return data
end

return M
