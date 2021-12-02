local root = script.Parent.Parent
local G = require(root.G)

local module = {}

module.toModule = function(selection)
	for i, child in ipairs(selection:GetChildren()) do
		if child.Name ~= "TerrainData" then continue end
		if child.ClassName ~= "ModuleScript" then continue end
		if child:GetAttribute("Data") ~= "Terrain" then continue end
		child:Destroy()
	end
	
	local buffer = {}
	local moduleScript = Instance.new("ModuleScript")
	moduleScript.Name = "TerrainData"
	moduleScript:SetAttribute("Data", "Terrain")
		
	table.insert(buffer, 'return {\n')
		
	table.insert(buffer, '	["thickness"] = ')
	table.insert(buffer, G.modules["Terrain"].thickness)
	table.insert(buffer, ',\n')
		
	table.insert(buffer, '	["shift"] = ')
	table.insert(buffer, G.modules["Terrain"].shift)
	table.insert(buffer, ',\n')
		
	table.insert(buffer, '	["waterHeight"] = ')
	table.insert(buffer, G.modules["Terrain"].waterHeight)
	table.insert(buffer, ',\n')
		
	table.insert(buffer, '	["minimumHeight"] = ')
	table.insert(buffer, G.modules["Terrain"].minimumHeight)
	table.insert(buffer, ',\n')
		
	table.insert(buffer, '	["maximumHeight"] = ')
	table.insert(buffer, G.modules["Terrain"].maximumHeight)
	table.insert(buffer, ',\n')
		
	table.insert(buffer, '	["noises"] = {\n')
	for i, data in ipairs(G.modules["Terrain"].noises) do
		table.insert(buffer, '		{')
		table.insert(buffer, data[1])
		table.insert(buffer, ', ')
		table.insert(buffer, data[2])
		table.insert(buffer, ', ')
		table.insert(buffer, data[3])
		table.insert(buffer, ', ')
		table.insert(buffer, data[4])
		table.insert(buffer, ', ')
		table.insert(buffer, data[5])
		table.insert(buffer, '},\n')
	end
	table.insert(buffer, '	},\n')
		
	table.insert(buffer, '	["materials"] = {\n')
	for i, data in ipairs(G.modules["Terrain"].materials) do
		table.insert(buffer, '		{')
		table.insert(buffer, data[1])
		table.insert(buffer, ', ')
		table.insert(buffer, data[2])
		table.insert(buffer, ', ')
		table.insert(buffer, data[3])
		table.insert(buffer, ', ')
		table.insert(buffer, data[4])
		table.insert(buffer, ', ')
		table.insert(buffer, data[5])
		table.insert(buffer, '},\n')
	end
	table.insert(buffer, '	},\n')
		
	table.insert(buffer, '	["models"] = {\n')
	for i, data in ipairs(G.modules["Terrain"].models) do
		table.insert(buffer, '		{"')
		table.insert(buffer, data[1])
		table.insert(buffer, '", ')
		table.insert(buffer, data[2])
		table.insert(buffer, ', ')
		table.insert(buffer, data[3])
		table.insert(buffer, ', ')
		table.insert(buffer, data[4])
		table.insert(buffer, ', ')
		table.insert(buffer, data[5])
		table.insert(buffer, ', ')
		table.insert(buffer, data[6])
		table.insert(buffer, ', {\n')
		for i, noise in ipairs(data[7]) do
			table.insert(buffer, '			{')
			table.insert(buffer, noise[1])
			table.insert(buffer, ', ')
			table.insert(buffer, noise[2])
			table.insert(buffer, ', ')
			table.insert(buffer, noise[3])
			table.insert(buffer, ', ')
			table.insert(buffer, noise[4])
			table.insert(buffer, ', ')
			table.insert(buffer, noise[5])
			table.insert(buffer, '},\n')
		end
		table.insert(buffer, '		}},\n')
	end
	table.insert(buffer, '	},\n')
		
	table.insert(buffer, '}')
	
	moduleScript.Source = table.concat(buffer)		
	
	return moduleScript
end

return module
