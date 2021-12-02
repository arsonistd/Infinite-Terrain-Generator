local module = {}

local chunkSize = 16
local waterHeight = 0
local thickness = 6
local positionX = math.huge
local positionZ = math.huge
local connection = nil
local heightData = {}
local loaded = {}
local modelsFolder = nil

module.heightData = {}
module.materialData = {}
module.generateData = {}
module.distance = 6
module.thickness = thickness
module.biomes = {}
module.noises = {}
module.materials = {}
module.models = {}
module.shift = 0
module.waterHeight = waterHeight
module.minimumHeight = -10000
module.maximumHeight = 10000

LoadHeight = function(x, z)
	if heightData[x] == nil then heightData[x] = {} end
	if heightData[x][z] == nil then heightData[x][z] = {} end
	
	if heightData[x][z].height ~= nil then
		return heightData[x][z].height
	end
	
	if module.heightData[x] ~= nil and module.heightData[x][z] ~= nil then
		heightData[x][z].height = module.heightData[x][z]
		return module.heightData[x][z]
	end
	
	local height = 0
	for i, data in ipairs(module.noises) do
		local noise = math.noise(x * data[3], data[1], z * data[3])
		height += math.clamp(noise, data[4], data[5]) * data[2]
	end
	height += module.shift
	height = math.clamp(height, module.minimumHeight, module.maximumHeight)
	heightData[x][z].height = height
	return height
end

Load = function(x, z)
	if heightData[x] == nil then heightData[x] = {} end
	if heightData[x][z] == nil then heightData[x][z] = {} end
	
	local data = heightData[x][z]
	
	if data.minimum ~= nil then return end
	data.minimum = math.huge
	local maximum = -math.huge
	for xx = x-1, x+1 do
		for zz = z-1, z+1 do
			local height = LoadHeight(xx, zz)
			data.minimum = math.min(data.minimum, height)
			maximum = math.max(maximum, height)
		end
	end
	
	local height = data.height
	local slope = maximum - data.minimum
	local thick = height - data.minimum + thickness
	local position = Vector3.new(x * 4, height, z * 4)
	local cFrame = CFrame.new(x * 4 + 2, height - thick / 2, z * 4 + 2)
	local size = Vector3.new(4, thick, 4)
	if module.materialData[x] ~= nil and module.materialData[x][z] ~= nil then
		workspace.Terrain:FillBlock(cFrame, size, module.materialData[x][z])
	else
		for i, materialData in ipairs(module.materials) do
			if height < materialData[2] or height >= materialData[3] then continue end
			if slope < materialData[4] or slope >= materialData[5] then continue end
			workspace.Terrain:FillBlock(cFrame, size, materialData[1])
			break
		end
	end
	for i, modelData in ipairs(module.models) do
		if math.fmod(x, modelData[2]) ~= 0 or math.fmod(z, modelData[2]) ~= 0 then continue end
		if height < modelData[3] or height >= modelData[4] then continue end
		if slope < modelData[5] or slope >= modelData[6] then continue end
		local load = true
		local offset = Vector3.new(0, 0, 0)
		local scale = Vector3.new(1, 1, 1)
		local rotation = Vector3.new(0, 0, 0)
		for i, data in ipairs(modelData[7]) do
			if data[1] == 1 then
				local noise = math.noise(x * data[3], data[2], z * data[3])
				if noise < data[4] or noise >= data[5] then load = false break end
			elseif data[1] == 2 then
				offset += Vector3.new(data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5], 0, 0)
			elseif data[1] == 3 then
				offset += Vector3.new(0, data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5], 0)
			elseif data[1] == 4 then
				offset += Vector3.new(0, 0, data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5])
			elseif data[1] == 5 then
				scale *= data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5]
			elseif data[1] == 6 then
				scale *= Vector3.new(data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5], 1, 1)
			elseif data[1] == 7 then
				scale *= Vector3.new(1, data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5], 1)
			elseif data[1] == 8 then
				scale *= Vector3.new(1, 1, data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5])
			elseif data[1] == 9 then
				rotation += Vector3.new(data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5], 0, 0)
			elseif data[1] == 10 then
				rotation += Vector3.new(0, data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5], 0)
			elseif data[1] == 11 then
				rotation += Vector3.new(0, 0, data[4] + math.noise(x * data[3], data[2], z * data[3]) * data[5])
			end
		end
		if load == false then continue end
		if scale.X <= 0 or scale.Y <= 0 or scale.Z <= 0 then continue end
		local clone = game.ReplicatedStorage.TerrainModels[modelData[1]]:Clone()
		local pivotPosition = clone:GetPivot().Position
		for i, descendant in ipairs(clone:GetDescendants()) do
			if descendant:IsA("BasePart") == false then continue end
			descendant.PivotOffset += (descendant.PivotOffset.Position * scale) - descendant.PivotOffset.Position
			descendant.Position = pivotPosition + (descendant.Position - pivotPosition) * scale
			descendant.Size *= scale
		end
		clone:PivotTo(CFrame.new(position + offset) * CFrame.fromOrientation(math.rad(rotation.X), math.rad(rotation.Y), math.rad(rotation.Z)))
		clone.Parent = modelsFolder
		break
	end
	if height >= waterHeight then return end
	thick = waterHeight - height
	local cFrame = CFrame.new(x * 4 + 2, height + thick / 2, z * 4 + 2)
	local size = Vector3.new(4, thick, 4)
	workspace.Terrain:FillBlock(cFrame, size, Enum.Material.Water)
end

Unload = function(x, z)
	if heightData[x] == nil or heightData[x][z] == nil or heightData[x][z].minimum == nil then return end
	
	local data = heightData[x][z]
	local minimum = data.minimum
	local maximum = math.max(data.height, waterHeight)

	minimum = math.floor((minimum - thickness) / 4) * 4
	maximum = math.ceil(maximum / 4) * 4
	local thick = maximum - minimum
	local cFrame = CFrame.new(x * 4 + 2, minimum + thick / 2, z * 4 + 2)
	local size = Vector3.new(4, thick, 4)
	workspace.Terrain:FillBlock(cFrame, size, Enum.Material.Air)
	heightData[x][z] = nil
end

LoadChunk = function(chunkX, chunkZ)
	if loaded[chunkX] == nil then loaded[chunkX] = {} end
	if loaded[chunkX][chunkZ] ~= nil then return end
	loaded[chunkX][chunkZ] = true
	local startX = chunkX * chunkSize
	local startZ = chunkZ * chunkSize
	local endX = startX + chunkSize - 1
	local endZ = startZ + chunkSize - 1
	for x = startX, endX do
		for z = startZ, endZ do
			Load(x, z)
		end
	end
	wait()
end

LoadChunks = function(chunkX, chunkZ, hole)
	if hole == nil then hole = 0 LoadChunk(chunkX, chunkZ) end
	hole = hole * 2 + 1
	local x = chunkX + math.floor(hole/2)
	local z = chunkZ - math.floor(hole/2)
	local dx, dz = 1, 0
	local passed = hole - 1
	local length = hole
	local amount = (module.distance * 2 + 1) * (module.distance * 2 + 1) - hole * hole
	for i = 1, amount do
		x += dx z += dz
		if Vector2.new(chunkX - x, chunkZ - z).Magnitude < module.distance + 0.5 then LoadChunk(x, z) end
		passed += 1
		if passed == length then passed = 0 dx, dz = -dz, dx if dz == 0 then length += 1 end end
		if connection == nil then return end
	end
end

module.GenerateHeightData = function()
	for x, v in pairs(module.heightData) do
		for z, height in pairs(v) do
			Load(x, z)
		end
	end
end

module.GenerateMaterialData = function()
	for x, v in pairs(module.materialData) do
		for z, material in pairs(v) do
			Load(x, z)
		end
	end
end

module.GenerateGenerateData = function()
	for x, v in pairs(module.generateData) do
		for z, material in pairs(v) do
			Load(x, z)
		end
	end
end

module.Set = function(x, z, size, height)
	if height ~= nil then height = math.round(height * 10) / 10 end
	for xx = x - size, x + size do
		for zz = z - size, z + size do
			local magnitude = Vector2.new(xx - x , zz - z).Magnitude
			local strength = math.max(size + 0.5 - magnitude, 0) / (size + 0.5)
			if strength == 0 then continue end
			if module.heightData[xx] == nil then module.heightData[xx] = {} end
			module.heightData[xx][zz] = height
			if height == nil and next(module.heightData[xx]) == nil then
				module.heightData[xx] = nil
			end
		end
	end
	for xx = x - size - 1, x + size + 1 do
		for zz = z - size - 1, z + size + 1 do
			Unload(xx, zz)
		end
	end
	for xx = x - size - 1, x + size + 1 do
		for zz = z - size - 1, z + size + 1 do
			Load(xx, zz)
		end
	end
end

module.Increase = function(x, z, size, amount)
	for xx = x - size, x + size do
		for zz = z - size, z + size do
			local magnitude = Vector2.new(xx - x , zz - z).Magnitude
			local strength = math.max(size + 0.5 - magnitude, 0) / (size + 0.5)
			if strength == 0 then continue end
			local height = LoadHeight(xx, zz)
			height = math.round((height + amount * strength) * 10) / 10
			if module.heightData[xx] == nil then module.heightData[xx] = {} end
			module.heightData[xx][zz] = height
		end
	end
	for xx = x - size - 1, x + size + 1 do
		for zz = z - size - 1, z + size + 1 do
			Unload(xx, zz)
		end
	end
	for xx = x - size - 1, x + size + 1 do
		for zz = z - size - 1, z + size + 1 do
			Load(xx, zz)
		end
	end
end

module.Smooth = function(x, z, size)
	for xx = x - size, x + size do
		for zz = z - size, z + size do
			local magnitude = Vector2.new(xx - x , zz - z).Magnitude
			local strength = math.max(size + 0.5 - magnitude, 0) / (size + 0.5)
			if strength == 0 then continue end
			local height = 0
			local count = 0
			local minimum = math.huge
			local maximum = -math.huge
			for xxx = xx-1, xx+1 do
				for zzz = zz-1, zz+1 do
					height += LoadHeight(xxx, zzz)
					count += 1
				end
			end
			height = math.round((height / count) * 10) / 10
			if module.heightData[xx] == nil then module.heightData[xx] = {} end
			module.heightData[xx][zz] = height
		end
	end
	for xx = x - size - 1, x + size + 1 do
		for zz = z - size - 1, z + size + 1 do
			Unload(xx, zz)
		end
	end
	for xx = x - size - 1, x + size + 1 do
		for zz = z - size - 1, z + size + 1 do
			Load(xx, zz)
		end
	end
end

module.Paint = function(x, z, size, material)
	for xx = x - size, x + size do
		for zz = z - size, z + size do
			local magnitude = Vector2.new(xx - x , zz - z).Magnitude
			local strength = math.max(size + 0.5 - magnitude, 0) / (size + 0.5)
			if strength == 0 then continue end
			if module.materialData[xx] == nil then module.materialData[xx] = {} end
			module.materialData[xx][zz] = material
			if material == nil and next(module.materialData[xx]) == nil then
				module.materialData[xx] = nil
			end
			Unload(xx, zz)
			Load(xx, zz)
		end
	end
end

module.Generate = function(x, z, size, value)
	for xx = x - size, x + size do
		for zz = z - size, z + size do
			local magnitude = Vector2.new(xx - x , zz - z).Magnitude
			local strength = math.max(size + 0.5 - magnitude, 0) / (size + 0.5)
			if strength == 0 then continue end
			if module.generateData[xx] == nil then module.generateData[xx] = {} end
			module.generateData[xx][zz] = value
			if value == nil then
				if next(module.generateData[xx]) == nil then
					module.generateData[xx] = nil
				end
				Unload(xx, zz)
			else
				Load(xx, zz)
			end
			
		end
	end
end

module.Clear = function()
	for x, object in pairs(heightData) do
		for z, v in pairs(object) do
			Unload(x, z)
		end
	end
	thickness = module.thickness
	waterHeight = module.waterHeight
	loaded = {}
	heightData = {}
	if modelsFolder ~= nil then
		if connection == nil then
			modelsFolder:Destroy()
			modelsFolder = nil
		else
			modelsFolder:ClearAllChildren()
		end
	end
	if connection == nil then return end
	positionX, positionZ = workspace.CurrentCamera.Focus.Position.X, workspace.CurrentCamera.Focus.Position.Z
	local x = math.floor(positionX / 4 / chunkSize)
	local z = math.floor(positionZ / 4 / chunkSize)
	LoadChunks(x, z)
end

module.ClearAll = function()
	game.Workspace.Terrain:Clear()
	thickness = module.thickness
	waterHeight = module.waterHeight
	loaded = {}
	heightData = {}
	if modelsFolder ~= nil then
		if connection == nil then
			modelsFolder:Destroy()
			modelsFolder = nil
		else
			modelsFolder:ClearAllChildren()
		end
	end
	if connection == nil then return end
	positionX, positionZ = workspace.CurrentCamera.Focus.Position.X, workspace.CurrentCamera.Focus.Position.Z
	local x = math.floor(positionX / 4 / chunkSize)
	local z = math.floor(positionZ / 4 / chunkSize)
	LoadChunks(x, z)
end

module.Enable = function(value)
	if value == false then
		if connection == nil then return end
		connection:Disconnect()
		connection = nil
	else
		if connection ~= nil then return end
		if modelsFolder == nil then
			modelsFolder = Instance.new("Folder")
			modelsFolder.Name = "TerrainModels"
			modelsFolder.Parent = workspace
		end
		connection = workspace.CurrentCamera:GetPropertyChangedSignal("Focus"):Connect(function()
			local x = workspace.CurrentCamera.Focus.Position.X
			local z = workspace.CurrentCamera.Focus.Position.Z
			local magnitude = Vector2.new(positionX - x, positionZ - z).Magnitude
			if magnitude < chunkSize * 8 then return end
			positionX, positionZ = x, z
			x = math.floor(positionX / 4 / chunkSize)
			z = math.floor(positionZ / 4 / chunkSize)
			if magnitude < module.distance * chunkSize * 2 then
				LoadChunks(x, z, math.floor(module.distance / 2 - 0.5))
			else
				LoadChunks(x, z)
			end
		end)
		positionX, positionZ = workspace.CurrentCamera.Focus.Position.X, workspace.CurrentCamera.Focus.Position.Z
		local x = math.floor(positionX / 4 / chunkSize)
		local z = math.floor(positionZ / 4 / chunkSize)
		LoadChunks(x, z)
	end
end

return module
