local root = script.Parent.Parent
local G = require(root.G)

local module = {}

local inputService = game:GetService("UserInputService")
local positionX = math.huge
local positionZ = math.huge
local size = 4

module.Initiate = function()
	local mouse = G.plugin:GetMouse()
	local connection1 = nil
	local connection2 = nil
	local connection3 = nil
	
	local widgetButton = G.classes["WidgetButton"].New("Generate", "rbxassetid://7249080767", 4)
	local widgetPage = G.classes["WidgetPage"].New()
	
	local dataGroup = G.classes["Group"].New("Data")
	widgetPage:AddChild(dataGroup.gui)

	local sizeOption = G.classes["Number"].New("Size", size, {["minimum"] = 0, ["round"] = 0})
	dataGroup:AddChild(sizeOption.gui)
	sizeOption.event:Bind(function(value)
		size = value
	end)

	local functionsGroup = G.classes["Group"].New("Functions")
	widgetPage:AddChild(functionsGroup.gui)

	local saveOption = G.classes["Button"].New("Save Generate Data")
	functionsGroup:AddChild(saveOption.gui)
	saveOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		for i, child in ipairs(selection:GetChildren()) do
			if child.Name ~= "GenerateData" then continue end
			if child.ClassName ~= "Folder" then continue end
			if child:GetAttribute("Data") ~= "Generate" then continue end
			child:Destroy()
		end
		local chunkSize = 64
		local folder = Instance.new("Folder")
		folder.Name = "GenerateData"
		folder:SetAttribute("Data", "Generate")
		folder.Parent = selection
		local datas = {}
		for x, v in pairs(G.modules["Terrain"].generateData) do
			for z, value in pairs(v) do
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

	local loadOption = G.classes["Button"].New("Load Generate Data")
	functionsGroup:AddChild(loadOption.gui)
	loadOption.event:Bind(function()
		local selection = game.Selection:Get()[1]
		if selection == nil then return end
		if selection.ClassName ~= "Folder" then return end
		if selection:GetAttribute("Data") ~= "Generate" then return end
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
				if G.modules["Terrain"].generateData[x] == nil then G.modules["Terrain"].generateData[x] = {} end
				for i, z in ipairs(zData) do					
					G.modules["Terrain"].generateData[x][position.Y + z] = true
				end
			end
		end
	end)

	local clearDataOption = G.classes["Button"].New("Clear Generate Data")
	functionsGroup:AddChild(clearDataOption.gui)
	clearDataOption.event:Bind(function()
		G.modules["Terrain"].generateData = {}
	end)
	
	local generateDataOption = G.classes["Button"].New("Generate Generate Data")
	functionsGroup:AddChild(generateDataOption.gui)
	generateDataOption.event:Bind(function()
		G.modules["Terrain"].GenerateGenerateData()
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
		connection1 = mouse.Button1Down:Connect(function()
			if mouse.Target == nil then return end
			local x = math.floor(mouse.Hit.Position.X / 4)
			local z = math.floor(mouse.Hit.Position.Z / 4)
			positionX, positionZ = x, z
			if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true and inputService:IsKeyDown(Enum.KeyCode.LeftAlt) == true then 
				G.modules["Terrain"].Generate(x, z, size)
			else
				G.modules["Terrain"].Generate(x, z, size, true)
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
					G.modules["Terrain"].Generate(x, z, size)
				else
					G.modules["Terrain"].Generate(x, z, size, true)
				end
			end)
		end)
		connection2 = mouse.WheelBackward:Connect(function()
			if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true then
				sizeOption:Set(size - 1)
			end
		end)
		connection3 = mouse.WheelForward:Connect(function()
			if inputService:IsKeyDown(Enum.KeyCode.LeftControl) == true then
				sizeOption:Set(size + 1)
			end
		end)
	end)
	
	widgetButton.deselected:Bind(function()
		if connection1 ~= nil then connection1:Disconnect() connection1 = nil end
		if connection2 ~= nil then connection2:Disconnect() connection2 = nil end
		if connection3 ~= nil then connection3:Disconnect() connection3 = nil end
	end)
end

return module
