local root = script.Parent.Parent
local G = require(root.G)

local module = {}

local inputService = game:GetService("UserInputService")
local positionX = math.huge
local positionZ = math.huge
local strength = 1
local size = 4

module.Start = function()
	local mouse = G.plugin:GetMouse()
	
	local widgetButton = G.classes["WidgetButton"].New("Edit", "rbxassetid://3079003835", 2)
	local widgetPage = G.classes["WidgetPage"].New()
	local maid = G.classes["Maid"].New()
	
	local brushSettingsGroup = G.classes["Group"].New("Brush Settings", widgetPage.scrollingFrame)

	local brushStrengthSlider = G.classes["Slider"].New("Brush Strength", brushSettingsGroup.gui, 0.1, 2, 1, 1, true)
	brushStrengthSlider.event:Bind(function(value)
		size = value
	end)

	local brushSizeSlider = G.classes["Slider"].New("Brush Size", brushSettingsGroup.gui, 0.5, 10, 1, 1, true)
	brushSizeSlider.event:Bind(function(value)
		size = value
	end)

	local functionsGroup = G.classes["Group"].New("Functions")
	widgetPage:AddChild(functionsGroup.gui)

	local saveOption = G.classes["Button"].New("Save Height Data")
	functionsGroup:AddChild(saveOption.gui)
	saveOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		for i, child in ipairs(selection:GetChildren()) do
			if child.Name ~= "HeightData" then continue end
			if child.ClassName ~= "Folder" then continue end
			if child:GetAttribute("Data") ~= "Height" then continue end
			child:Destroy()
		end
		local chunkSize = 64
		local folder = Instance.new("Folder")
		folder.Name = "HeightData"
		folder:SetAttribute("Data", "Height")
		folder.Parent = selection
		local datas = {}
		for x, v in pairs(G.modules["Terrain"].heightData) do
			for z, height in pairs(v) do
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
				table.insert(data.buffer, height)
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

	local loadOption = G.classes["Button"].New("Load Height Data")
	functionsGroup:AddChild(loadOption.gui)
	loadOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		if selection.ClassName ~= "Folder" then return end
		if selection:GetAttribute("Data") ~= "Height" then return end
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
				if G.modules["Terrain"].heightData[x] == nil then G.modules["Terrain"].heightData[x] = {} end
				for j = 1, #zData, 2 do
					local z = position.Y + zData[j]
					local height = zData[j + 1]
					G.modules["Terrain"].heightData[x][z] = height
				end
			end
		end
	end)

	local clearDataOption = G.classes["Button"].New("Clear Height Data")
	functionsGroup:AddChild(clearDataOption.gui)
	clearDataOption.event:Bind(function()
		G.modules["Terrain"].heightData = {}
	end)
	
	local generateDataOption = G.classes["Button"].New("Generate Height Data")
	functionsGroup:AddChild(generateDataOption.gui)
	generateDataOption.event:Bind(function()
		G.modules["Terrain"].GenerateHeightData()
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
			local height = mouse.Hit.Position.Y - 2
			if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true and inputService:IsKeyDown(Enum.KeyCode.LeftAlt) == true then 
				G.modules["Terrain"].Set(x, z, size, nil)
			elseif inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true then
				G.modules["Terrain"].Set(x, z, size, height)
			elseif inputService:IsKeyDown(Enum.KeyCode.LeftAlt) == true then
				G.modules["Terrain"].Smooth(x, z, size)
			elseif inputService:IsKeyDown(Enum.KeyCode.LeftShift) == true then
				G.modules["Terrain"].Increase(x, z, size, -strength)
			else
				G.modules["Terrain"].Increase(x, z, size, strength)
			end
			local connectionUp = nil
			local connectionMove = nil
			connectionUp = mouse.Button1Up:Connect(function()
				connectionUp:Disconnect()
				connectionMove:Disconnect()
			end)
			connectionMove = mouse.Move:Connect(function()
				if mouse.Target == nil then return end
				local x = math.floor(mouse.Hit.Position.X / 4)
				local z = math.floor(mouse.Hit.Position.Z / 4)
				if positionX == x and positionZ == z then return end
				positionX, positionZ = x, z
				if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true and inputService:IsKeyDown(Enum.KeyCode.LeftAlt) == true then 
					G.modules["Terrain"].Set(x, z, size, nil)
				elseif inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true then
					G.modules["Terrain"].Set(x, z, size, height)
				elseif inputService:IsKeyDown(Enum.KeyCode.LeftAlt) == true then
					G.modules["Terrain"].Smooth(x, z, size)
				elseif inputService:IsKeyDown(Enum.KeyCode.LeftShift) == true then
					G.modules["Terrain"].Increase(x, z, size, -strength)
				else
					G.modules["Terrain"].Increase(x, z, size, strength)
				end
			end)
		end))
		maid:Add(mouse.WheelBackward:Connect(function()
			if inputService:IsKeyDown(Enum.KeyCode.LeftShift) == true then
				brushStrengthSlider:Increment(-0.1)
			end
			if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true then
				brushSizeSlider:Increment(-0.5)
			end
		end))
		maid:Add(mouse.WheelForward:Connect(function()
			if inputService:IsKeyDown(Enum.KeyCode.LeftShift) == true then
				brushStrengthSlider:Increment(0.1)
			end
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
