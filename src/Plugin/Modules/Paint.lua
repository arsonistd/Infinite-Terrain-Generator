local root = script.Parent.Parent
local G = require(root.G)

local module = {}

local inputService = game:GetService("UserInputService")
local positionX = math.huge
local positionZ = math.huge
local material = 1376
local size = 4

module.Start = function()
	local mouse = G.plugin:GetMouse()

	local widgetButton = G.classes["WidgetButton"].New("Paint", "rbxassetid://3078999048", 3)
	local widgetPage = G.classes["WidgetPage"].New()
	local maid = G.classes["Maid"].New()
	
	local brushGroup = G.classes["Group"].New("Brush Settings", widgetPage.scrollingFrame)

	local materialsOption = G.classes["MaterialSelection"].New(material)
	brushGroup:AddChild(materialsOption.gui)
	materialsOption.event:Bind(function(value)
		material = value
		materialsOption:Select(value)
	end)

	local brushSizeSlider = G.classes["Slider"].New("Brush Size", brushGroup.gui, 0.5, 10, 1, 1, true)
	brushSizeSlider.event:Bind(function(value)
		size = value
	end)
	
	local functionsGroup = G.classes["Group"].New("Functions")
	widgetPage:AddChild(functionsGroup.gui)
	
	local saveOption = G.classes["Button"].New("Save Material Data")
	functionsGroup:AddChild(saveOption.gui)
	saveOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		for i, child in ipairs(selection:GetChildren()) do
			if child.Name ~= "MaterialData" then continue end
			if child.ClassName ~= "Folder" then continue end
			if child:GetAttribute("Data") ~= "Material" then continue end
			child:Destroy()
		end
		local chunkSize = 64
		local folder = Instance.new("Folder")
		folder.Name = "MaterialData"
		folder:SetAttribute("Data", "Material")
		folder.Parent = selection
		local datas = {}
		for x, v in pairs(G.modules["Terrain"].materialData) do
			for z, material in pairs(v) do
				local chunkX = math.floor(x / chunkSize)
				local chunkZ = math.floor(z / chunkSize)
				local lx = x - chunkX * chunkSize
				local lz = z - chunkZ * chunkSize
				if datas[chunkX] == nil then datas[chunkX] = {} end
				local data = datas[chunkX][chunkZ]
				if data == nil then
					data = {}
					datas[chunkX][chunkZ] = data
					data.script = Instance.new("ModuleScript")
					data.buffer = {}
					table.insert(data.buffer, 'return {\n')
				end
				if data.x ~= lx then
					if data.x ~= nil then table.insert(data.buffer, '},\n') end
					table.insert(data.buffer, lx)
					table.insert(data.buffer, ',{')
					data.x = lx
				else
					table.insert(data.buffer, ',')
				end
				table.insert(data.buffer, lz)
				table.insert(data.buffer, ',')
				table.insert(data.buffer, material)
			end
		end
		for chunkX, v in pairs(datas) do
			for chunkZ, data in pairs(v) do
				table.insert(data.buffer, '},\n}')
				data.script.Name = chunkX .. "," .. chunkZ
				data.script:SetAttribute("Position", Vector2.new(chunkX * chunkSize, chunkZ * chunkSize))
				data.script.Source = table.concat(data.buffer)
				data.script.Parent = folder
			end
		end	
	end)

	local loadOption = G.classes["Button"].New("Load Material Data")
	functionsGroup:AddChild(loadOption.gui)
	loadOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		if selection.ClassName ~= "Folder" then return end
		if selection:GetAttribute("Data") ~= "Material" then return end
		for i, child in ipairs(selection:GetDescendants()) do
			if child.ClassName ~= "ModuleScript" then continue end
			local func = loadstring(child.Source)
			if typeof(func) ~= "function" then return end
			local data = func()
			if typeof(data) ~= "table" then return end
			local position = child:GetAttribute("Position")
			for i = 1, #data, 2 do
				local x = position.X + data[i]
				local zData = data[i + 1]
				if G.modules["Terrain"].materialData[x] == nil then G.modules["Terrain"].materialData[x] = {} end
				for j = 1, #zData, 2 do
					local z = position.Y + zData[j]
					local material = zData[j + 1]
					G.modules["Terrain"].materialData[x][z] = material
				end
			end
		end
	end)
	
	local clearDataOption = G.classes["Button"].New("Clear Material Data")
	functionsGroup:AddChild(clearDataOption.gui)
	clearDataOption.event:Bind(function()
		G.modules["Terrain"].materialData = {}
	end)
	
	local generateDataOption = G.classes["Button"].New("Generate Material Data")
	functionsGroup:AddChild(generateDataOption.gui)
	generateDataOption.event:Bind(function()
		G.modules["Terrain"].GenerateMaterialData()
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

	widgetButton:Activated(function()
		widgetButton:Select()
		widgetPage:Show()
	end)

	widgetButton.selected:Bind(function()
		G.plugin:Activate(true)
		maid:Add(mouse.Button1Down:Connect(function()
			if mouse.Target == nil then return end
			local x = math.floor(mouse.Hit.Position.X / 4)
			local z = math.floor(mouse.Hit.Position.Z / 4)
			positionX, positionZ = x, z
			G.modules["Terrain"].Paint(x, z, size, material)
			local moveMaid = G.classes["Maid"].New()
			moveMaid:Add(mouse.Button1Up:Connect(function()
				moveMaid:Destroy()
			end))
			moveMaid:Add(mouse.Move:Connect(function()
				if mouse.Target == nil then return end
				local x = math.floor(mouse.Hit.Position.X / 4)
				local z = math.floor(mouse.Hit.Position.Z / 4)
				if positionX == x and positionZ == z then return end
				positionX, positionZ = x, z
				G.modules["Terrain"].Paint(x, z, size, material)
			end))
		end))

		maid:Add(mouse.WheelBackward:Connect(function()
			if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true then
				brushSizeSlider:Increment(-0.5)
			end
		end))
		maid:Add(mouse.WheelForward:Connect(function()
			if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true then
				brushSizeSlider:Increment(0.5)
			end
		end))
	end)

	widgetButton.deselected:Bind(function()
		maid:Destroy()
	end)
end

return module
