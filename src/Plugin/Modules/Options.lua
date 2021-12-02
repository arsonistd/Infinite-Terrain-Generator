local root = script.Parent.Parent
local G = require(root.G)

local module = {}

local biomesGroup = nil
local noisesGroup = nil
local materialsGroup = nil
local modelsGroup = nil


-- Biomes 
local biomes = {}
local selectedBiome = nil
CreateBiome = function(data)
	local biome = G.classes["Biome"].New(data)
	biomes[#biomes+1] = biome
	G.modules["Terrain"].biomes[#G.modules["Terrain"].biomes+1] = biome
	biomesGroup:AddChild(biome.gui)
	biome.event:Bind(function(event)
		local key = nil
		if event == 1 then
			if selectedBiome == biome then
				UnselectBiome()
			else
				SelectBiome(biome)
			end
		elseif event == 2 then
			CreateBiome(G.modules["Functions"].Clone(data))
		elseif event == 3 then
			biome:Destroy()
			table.remove(biomes, key)
			table.remove(G.modules["Terrain"].biomes, key)
			for i, object in ipairs(biomes) do object.gui.LayoutOrder = i end
		end
	end)
	if data[2] == true then
		SelectBiome(biome)
	end
	
	return biome
end
ClearBiomes = function()
	for i, object in ipairs(biomes) do
		object:Destroy()
	end
	biomes = {}
	G.modules["Terrain"].biomes = {}
end
SelectBiome = function(biome)
	--print(selectedBiome)
	if selectedBiome == biome then print("yo") return end
	UnselectBiome()

	selectedBiome = biome
	
	noisesGroup:Unlock()
	materialsGroup:Unlock()
	modelsGroup:Unlock()
end
UnselectBiome = function()
	if selectedBiome ~= nil then
		selectedBiome:Unselect()
	end
	selectedBiome = nil
	
	noisesGroup:Lock("Select a biome to edit noises...")
	materialsGroup:Lock("Select a biome to edit materials...")
	modelsGroup:Lock("Select a biome to edit models...")
end




-- Noises
local noises = {}
CreateNoise = function(data)
	local noise = G.classes["Noise"].New(data)
	table.insert(noises, noise)
	table.insert(G.modules["Terrain"].noises, data)
	noise.gui.LayoutOrder = #noises
	noisesGroup:AddChild(noise.gui)
	noise.event:Bind(function(event)
		local key = nil
		for i, object in ipairs(noises) do if noise == object then key = i break end end
		if event == 1 then
			local key2 = key - 1
			if key2 < 1 then key2 = #noises end
			noises[key].gui.LayoutOrder, noises[key2].gui.LayoutOrder = noises[key2].gui.LayoutOrder, noises[key].gui.LayoutOrder
			noises[key], noises[key2] = noises[key2], noises[key]
			G.modules["Terrain"].noises[key], G.modules["Terrain"].noises[key2] = G.modules["Terrain"].noises[key2], G.modules["Terrain"].noises[key]
		elseif event == 2 then
			local key2 = key + 1
			if key2 > #noises then key2 = 1 end
			noises[key].gui.LayoutOrder, noises[key2].gui.LayoutOrder = noises[key2].gui.LayoutOrder, noises[key].gui.LayoutOrder
			noises[key], noises[key2] = noises[key2], noises[key]
			G.modules["Terrain"].noises[key], G.modules["Terrain"].noises[key2] = G.modules["Terrain"].noises[key2], G.modules["Terrain"].noises[key]
		elseif event == 3 then
			CreateNoise(G.modules["Functions"].Clone(data))
		elseif event == 4 then
			noise:Destroy()
			table.remove(noises, key)
			table.remove(G.modules["Terrain"].noises, key)
			for i, object in ipairs(noises) do object.gui.LayoutOrder = i end
		end
	end)
	return noise
end
ClearNoises = function()
	for i, object in ipairs(noises) do
		object:Destroy()
	end
	noises = {}
	G.modules["Terrain"].noises = {}
end




-- Materials
local materials = {}
CreateMaterial = function(data)
	local material = G.classes["Material"].New(data)
	table.insert(materials, material)
	table.insert(G.modules["Terrain"].materials, data)
	material.gui.LayoutOrder = #materials
	materialsGroup:AddChild(material.gui)
	material.event:Bind(function(event)
		local key = nil
		for i, object in ipairs(materials) do if material == object then key = i break end end
		if event == 1 then
			local key2 = key - 1
			if key2 < 1 then key2 = #materials end
			materials[key].gui.LayoutOrder, materials[key2].gui.LayoutOrder = materials[key2].gui.LayoutOrder, materials[key].gui.LayoutOrder
			materials[key], materials[key2] = materials[key2], materials[key]
			G.modules["Terrain"].materials[key], G.modules["Terrain"].materials[key2] = G.modules["Terrain"].materials[key2], G.modules["Terrain"].materials[key]
		elseif event == 2 then
			local key2 = key + 1
			if key2 > #materials then key2 = 1 end
			materials[key].gui.LayoutOrder, materials[key2].gui.LayoutOrder = materials[key2].gui.LayoutOrder, materials[key].gui.LayoutOrder
			materials[key], materials[key2] = materials[key2], materials[key]
			G.modules["Terrain"].materials[key], G.modules["Terrain"].materials[key2] = G.modules["Terrain"].materials[key2], G.modules["Terrain"].materials[key]
		elseif event == 3 then
			CreateMaterial(G.modules["Functions"].Clone(data))
		elseif event == 4 then
			material:Destroy()
			table.remove(materials, key)
			table.remove(G.modules["Terrain"].materials, key)
			for i, object in ipairs(materials) do object.gui.LayoutOrder = i end
		end
	end)
	return material
end
ClearMaterials = function()
	for i, object in ipairs(materials) do
		object:Destroy()
	end
	materials = {}
	G.modules["Terrain"].materials = {}
end




-- Models
local models = {}
CreateModel = function(data)
	local model = G.classes["Model"].New(data)
	table.insert(models, model)
	table.insert(G.modules["Terrain"].models, data)
	model.gui.LayoutOrder = #models
	modelsGroup:AddChild(model.gui)
	model.event:Bind(function(event)
		local key = nil
		for i, object in ipairs(models) do if model == object then key = i break end end
		if event == 1 then
			local key2 = key - 1
			if key2 < 1 then key2 = #models end
			models[key].gui.LayoutOrder, models[key2].gui.LayoutOrder = models[key2].gui.LayoutOrder, models[key].gui.LayoutOrder
			models[key], models[key2] = models[key2], models[key]
			G.modules["Terrain"].models[key], G.modules["Terrain"].models[key2] = G.modules["Terrain"].models[key2], G.modules["Terrain"].models[key]
		elseif event == 2 then
			local key2 = key + 1
			if key2 > #models then key2 = 1 end
			models[key].gui.LayoutOrder, models[key2].gui.LayoutOrder = models[key2].gui.LayoutOrder, models[key].gui.LayoutOrder
			models[key], models[key2] = models[key2], models[key]
			G.modules["Terrain"].models[key], G.modules["Terrain"].models[key2] = G.modules["Terrain"].models[key2], G.modules["Terrain"].models[key]
		elseif event == 3 then
			local object = CreateModel(G.modules["Functions"].Clone(data))
			object.frame.Visible = true
		elseif event == 4 then
			model:Destroy()
			table.remove(models, key)
			table.remove(G.modules["Terrain"].models, key)
			for i, object in ipairs(models) do object.gui.LayoutOrder = i end
		end
	end)
	return model
end
ClearModels = function()
	for i, object in ipairs(models) do
		object:Destroy()
	end
	models = {}
	G.modules["Terrain"].models = {}
end



module.Start = function()
	local widgetButton = G.classes["WidgetButton"].New("Terrain", "rbxassetid://7588761139", 1)
	local widgetPage = G.classes["WidgetPage"].New()
	widgetButton:Select()
	widgetPage:Show()
	widgetButton:Activated(function()
		G.plugin:Deactivate()
	end)
		
	G.plugin.Deactivation:Connect(function()
		widgetButton:Select()
		widgetPage:Show()
	end)
	
	local dataGroup = G.classes["Group"].New("Data")
	widgetPage:AddChild(dataGroup.gui)

	local generateOption = G.classes["Toggle"].New("Generate Terrain", false)
	dataGroup:AddChild(generateOption.gui)
	generateOption.event:Bind(function(value)
		G.modules["Terrain"].Enable(value)
	end)
	
	local distanceOption = G.classes["Number"].New("Distance", G.modules["Terrain"].distance, {["minimum"] = 1, ["round"] = 0})
	dataGroup:AddChild(distanceOption.gui)
	distanceOption.event:Bind(function(value)
		G.modules["Terrain"].distance = value
	end)
	
	local thicknessOption = G.classes["Number"].New("Thickness", G.modules["Terrain"].thickness)
	dataGroup:AddChild(thicknessOption.gui)
	thicknessOption.event:Bind(function(value)
		G.modules["Terrain"].thickness = value
	end)
	
	local shiftOption = G.classes["Number"].New("Shift", G.modules["Terrain"].shift)
	dataGroup:AddChild(shiftOption.gui)
	shiftOption.event:Bind(function(value)
		G.modules["Terrain"].shift = value
	end)
	
	local waterHeightOption = G.classes["Number"].New("Water Height", G.modules["Terrain"].waterHeight)
	dataGroup:AddChild(waterHeightOption.gui)
	waterHeightOption.event:Bind(function(value)
		G.modules["Terrain"].waterHeight = value
	end)
	
	local minimumHeightOption = G.classes["Number"].New("Minimum Height", G.modules["Terrain"].minimumHeight)
	dataGroup:AddChild(minimumHeightOption.gui)
	minimumHeightOption.event:Bind(function(value)
		G.modules["Terrain"].minimumHeight = value
	end)
	
	local maximumHeightOption = G.classes["Number"].New("Maximum Height", G.modules["Terrain"].maximumHeight)
	dataGroup:AddChild(maximumHeightOption.gui)
	maximumHeightOption.event:Bind(function(value)
		G.modules["Terrain"].maximumHeight = value
	end)
	
	
	
	-- Biomes
	biomesGroup = G.classes["Group"].New("Biomes")
	widgetPage:AddChild(biomesGroup.gui)
	local biomeOption = G.classes["Button"].New("Add Biome")
	biomeOption.gui.LayoutOrder = 2147483647
	biomesGroup:AddChild(biomeOption.gui)
	biomeOption.event:Bind(function()
		local percent = 100
		local active = false
		if #biomes == 0 then
			active = true --if this is the first biome then auto select it
		else
			percent = percent/(#biomes+1)
		end
		CreateBiome({percent, active})
	end)
	
	
	
	-- Noises
	noisesGroup = G.classes["Group"].New("Noises")
	widgetPage:AddChild(noisesGroup.gui)
	local noiseOption = G.classes["Button"].New("Add Noise")
	noiseOption.gui.LayoutOrder = 2147483647
	noisesGroup:AddChild(noiseOption.gui)
	noiseOption.event:Bind(function()
		CreateNoise({G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 50, 0.04, -10, 10, 1})
	end)
	
	
	
	-- Materials
	materialsGroup = G.classes["Group"].New("Materials")
	widgetPage:AddChild(materialsGroup.gui)
	local materialOption = G.classes["Button"].New("Add Material")
	materialOption.gui.LayoutOrder = 2147483647
	materialsGroup:AddChild(materialOption.gui)
	materialOption.event:Bind(function()
		CreateMaterial({1376, -10000, 10000, 0, 10000})
	end)
	
	
	
	-- Models
	modelsGroup = G.classes["Group"].New("Models")
	widgetPage:AddChild(modelsGroup.gui)
	local modelOption = G.classes["Button"].New("Add Model")
	modelOption.gui.LayoutOrder = 2147483647
	modelsGroup:AddChild(modelOption.gui)
	modelOption.event:Bind(function()
		local object = CreateModel({"", 10, -10000, 10000, 0, 10000, {}})
		object.frame.Visible = true
	end)
	
	local functionsGroup = G.classes["Group"].New("Functions")
	widgetPage:AddChild(functionsGroup.gui)
	local saveOption = G.classes["Button"].New("Save")
	functionsGroup:AddChild(saveOption.gui)
	saveOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		local formatedData = G.classes["format"].toModule(selection)
		formatedData.Parent = selection
	end)
		
	local loadOption = G.classes["Button"].New("Load")
	functionsGroup:AddChild(loadOption.gui)
	loadOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		if selection.ClassName ~= "ModuleScript" then return end
		if selection:GetAttribute("Data") ~= "Terrain" then return end
		
		local func = loadstring(selection.Source)
		if typeof(func) ~= "function" then return end
		local data = func()
		if typeof(data) ~= "table" then return end
		
		thicknessOption:Set(data.thickness)
		shiftOption:Set(data.shift)
		waterHeightOption:Set(data.waterHeight)
		minimumHeightOption:Set(data.minimumHeight)
		maximumHeightOption:Set(data.maximumHeight)
		
		ClearNoises()
		for i, data in ipairs(data.noises) do
			CreateNoise(data)
		end
		
		ClearMaterials()
		for i, data in ipairs(data.materials) do
			CreateMaterial(data)
		end
		
		ClearModels()
		for i, data in ipairs(data.models) do
			CreateModel(data)
		end
	end)
	
	local LocalOption = G.classes["Button"].New("Create Local Script")
	functionsGroup:AddChild(LocalOption.gui)
	LocalOption.event:Bind(function()
		local clone = root.LocalScript:Clone()
		clone.Name = "Terrain"
		clone.Disabled = false
		clone.Parent = game.ReplicatedFirst
		game.Selection:Set({clone})
	end)
	
	local clearTerrainOption = G.classes["Button"].New("Clear Terrain")
	functionsGroup:AddChild(clearTerrainOption.gui)
	clearTerrainOption.event:Bind(function()
		G.modules["Terrain"].Clear()
	end)

	local clearAllTerrainOption = G.classes["Button"].New("Clear All Terrain")
	functionsGroup:AddChild(clearAllTerrainOption.gui)
	clearAllTerrainOption.event:Bind(function()
		G.modules["Terrain"].ClearAll()
	end)
end

return module
