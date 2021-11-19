local root = script.Parent
local G = require(root.G)
G.plugin = plugin
G.modules = {}
G.classes = {}

for i, descendant in ipairs(script.Parent:GetDescendants()) do
	if descendant.ClassName ~= "ModuleScript" then continue end
	if descendant.Name == "G" then continue end
	local module = require(descendant)
	if module.__index == nil then
		G.modules[descendant.Name] = module
	else
		G.classes[descendant.Name] = module
	end
end
for i, module in pairs(G.modules) do
	if module.Init then module.Init() end
end
for i, module in pairs(G.modules) do
	if module.Start then module.Start() end
end