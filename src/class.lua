local initname = '_init'
local function instanceconstruction(cls, ...)
  local instance = setmetatable({}, cls)
  local init = cls[initname]
  if init then init(instance, ...) end
  return instance
end
local classmt = {
  __call = instanceconstruction,
}

local function newclass(cls, base)
  cls = cls or {}
  base = base or {}
  for k, v in pairs(base) do
    if not cls[k] then cls[k] = v end
  end
  cls.__index = cls
  return setmetatable(cls, classmt)
end

return {
  new = newclass,
  initializer = initname,
}
