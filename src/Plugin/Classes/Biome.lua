local module = {}
module.__index = module

module.New = function()
	local object = setmetatable({}, module)
	
	object.event = G.classes["Event"].New()
	object.data = data
	object.settingsOpen = false
	
	object.gui = Instance.new("Frame")
	object.gui.Size = UDim2.new(1, 0, 0, 24)
	object.gui.BackgroundTransparency = 1
	object.gui.BorderSizePixel = 0
	
	object.indent = G.classes["Indent"].New({
		["indent"] = 0.03,
		["position"] = UDim2.new(1, 0, 0, 0),
		["parent"] = object.gui
	})
	
	object.collapseButton = Instance.new("ImageButton")
	object.collapseButton.Position = UDim2.new(0, 0, 0, 0)
	object.collapseButton.Size = UDim2.new(0.06, 0, 0, 24)
	object.collapseButton.ScaleType = Enum.ScaleType.Fit
	object.collapseButton.Image = "rbxassetid://8057404440"
	object.collapseButton.ImageTransparency = 0.25
	object.collapseButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.collapseButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.collapseButton.Parent = object.indent.gui
	object.collapseButton.Activated:Connect(function()
		object:ToggleBiomeParameters()
	end)
	
	object.selectedIcon = Instance.new("ImageButton")
	object.selectedIcon.Position = UDim2.new(0.06, 0, 0, 0)
	object.selectedIcon.Size = UDim2.new(0.06, -1, 0, 24)
	object.selectedIcon.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	object.selectedIcon.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	object.selectedIcon.Parent = object.indent
	
	return object
end


module.ToggleBiomeParameters = function(self)
	if self.settingsOpen == true then
		
	else
		
	end
end

module.Destroy = function(self)
	
end

return module
