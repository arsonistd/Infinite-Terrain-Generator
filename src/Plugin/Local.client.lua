if game:IsLoaded() == false then game.Loaded:Wait() end
local dataChild = nil
local heightChild = nil
local materialChild = nil
for i, child in ipairs(script:GetChildren()) do
	if child.ClassName == "ModuleScript" then
		local data = child:GetAttribute("Data")
		if data == "Terrain" then
			dataChild = child
		end
	elseif child.ClassName == "Folder" then
		local data = child:GetAttribute("Data")
		if data == "Height" then
			heightChild = child
		elseif data == "Material" then
			materialChild = child
		end
	end
end
if dataChild == nil then return end

local data = require(dataChild)

local distance = 16
local chunkSize = 16
local positionX = math.huge
local positionZ = math.huge
local heightData = {}
local materialData = {}
local loaded = {}
local modelsFolder = nil
if #data.models > 0 then
	modelsFolder = Instance.new("Folder")
	modelsFolder.Name = "TerrainModels"
	modelsFolder.Parent = workspace
end

if heightChild then
	for i, child in ipairs(heightChild:GetDescendants()) do
		if child.ClassName ~= "ModuleScript" then continue end
		local data = require(child)
		local position = child:GetAttribute("Position")
		for i = 1, #data, 2 do
			local x = position.X + data[i]
			local zData = data[i + 1]
			if heightData[x] == nil then heightData[x] = {} end
			for j = 1, #zData, 2 do
				local z = position.Y + zData[j]
				local height = zData[j + 1]
				heightData[x][z] = height
			end
		end
	end
end

if materialChild then
	for i, child in ipairs(materialChild:GetDescendants()) do
		if child.ClassName ~= "ModuleScript" then continue end
		local data = require(child)
		local position = child:GetAttribute("Position")
		for i = 1, #data, 2 do
			local x = position.X + data[i]
			local zData = data[i + 1]
			if materialData[x] == nil then materialData[x] = {} end
			for j = 1, #zData, 2 do
				local z = position.Y + zData[j]
				local material = zData[j + 1]
				materialData[x][z] = material
			end
		end
	end
end


GetHeight = function(x, z)
	if heightData[x] == nil then heightData[x] = {} end
	if heightData[x][z] ~= nil then return heightData[x][z] end	
	local height = 0
	for i, data in ipairs(data.noises) do
		local noise = math.noise(x * data[3], data[1], z * data[3])
		height += math.clamp(noise, data[4], data[5]) * data[2]
	end
	height += data.shift
	height = math.clamp(height, data.minimumHeight, data.maximumHeight)
	heightData[x][z] = height
	return height
end

Load = function(x, z)
	local minimum = math.huge
	local maximum = -math.huge
	for xx = x-1, x+1 do
		for zz = z-1, z+1 do
			local height = GetHeight(xx, zz)
			minimum = math.min(minimum, height)
			maximum = math.max(maximum, height)
		end
	end
	local slope = maximum - minimum
	local height = heightData[x][z]
	local thickness = height - minimum + data.thickness
	local position = Vector3.new(x * 4, height, z * 4)
	local cFrame = CFrame.new(x * 4 + 2, height - thickness / 2, z * 4 + 2)
	local size = Vector3.new(4, thickness, 4)
	if materialData[x] ~= nil and materialData[x][z] ~= nil then
		workspace.Terrain:FillBlock(cFrame, size, materialData[x][z])
	else
		for i, materialData in ipairs(data.materials) do
			if height < materialData[2] or height >= materialData[3] then continue end
			if slope < materialData[4] or slope >= materialData[5] then continue end
			workspace.Terrain:FillBlock(cFrame, size, materialData[1])
			break
		end
	end
	for i, modelData in ipairs(data.models) do
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
	if height >= data.waterHeight then return end
	thickness = data.waterHeight - height
	local cFrame = CFrame.new(x * 4 + 2, height + thickness / 2, z * 4 + 2)
	local size = Vector3.new(4, thickness, 4)
	workspace.Terrain:FillBlock(cFrame, size, Enum.Material.Water)
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
	local amount = (distance * 2 + 1) * (distance * 2 + 1) - hole * hole
	for i = 1, amount do
		x += dx z += dz
		if Vector2.new(chunkX - x, chunkZ - z).Magnitude < distance + 0.5 then LoadChunk(x, z) end
		passed += 1
		if passed == length then passed = 0 dx, dz = -dz, dx if dz == 0 then length += 1 end end
	end
end

workspace.CurrentCamera:GetPropertyChangedSignal("Focus"):Connect(function()
	local x = workspace.CurrentCamera.Focus.Position.X
	local z = workspace.CurrentCamera.Focus.Position.Z
	local magnitude = Vector2.new(positionX - x, positionZ - z).Magnitude
	if magnitude < chunkSize * 8 then return end
	positionX, positionZ = x, z
	x = math.floor(positionX / 4 / chunkSize)
	z = math.floor(positionZ / 4 / chunkSize)
	if magnitude < distance * chunkSize * 2 then
		LoadChunks(x, z, math.floor(distance / 2 - 0.5))
	else
		LoadChunks(x, z)
	end
end)