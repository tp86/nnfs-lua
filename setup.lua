local match = string.match
local version = match(_VERSION, '^Lua (.+)$')
local luapatterns = { '/?.lua', '/?/init.lua' }

local projectdirs = { 'src' }
local luarocksdirs = { '.luarocks' }
local luarockspaths = {}
local luarockscpaths = {}
for i, dir in ipairs(luarocksdirs) do
  luarockspaths[i] = dir .. '/share/lua/' .. version
  luarockscpaths[i] = dir .. '/lib/lua/' .. version
end

local paths = {}
for _, dir in ipairs(projectdirs) do
  paths[#paths+1] = dir
end
for _, path in ipairs(luarockspaths) do
  paths[#paths+1] = path
end
local pathpatterns = {}
for _, path in ipairs(paths) do
  for _, pattern in ipairs(luapatterns) do
    pathpatterns[#pathpatterns+1] = path .. pattern
  end
end
package.path = table.concat(pathpatterns, ';') .. ';' .. package.path
local cpathpatterns = {}
for _, path in ipairs(paths) do
  for _, pattern in ipairs(luarockscpaths) do
    cpathpatterns[#cpathpatterns+1] = path .. pattern
  end
end
package.cpath = table.concat(cpathpatterns, ';') .. ';' .. package.cpath
