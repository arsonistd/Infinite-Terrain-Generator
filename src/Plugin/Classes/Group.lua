local module = {}
module.__index = module

local showing = nil

local openImage = "rbxassetid://8057404440"
local closeImage = "rbxassetid://8057404581"

module.New = function(label, parent)
	local object = setmetatable({}, module)
	
	object.gui = Instance.new("Frame")
	object.gui.Size = UDim2.new(1, 0, 0, 0)
	object.gui.BackgroundTransparency = 1
	object.gui.BorderSizePixel = 0

	-- Parent arg
	if parent then
		object.gui.Parent = parent
	end
	
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 1)
	padding.PaddingRight = UDim.new(0, 1)
	padding.Parent = object.gui
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 1)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	listLayout.Parent = object.gui
	listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		object.gui.Size = UDim2.new(1, 0, 0, listLayout.AbsoluteContentSize.Y)
	end)
		
	local textButton = Instance.new("TextButton")
	textButton.Text = label
	textButton.Font = Enum.Font.ArialBold
	textButton.TextSize = 12
	textButton.Size = UDim2.new(1, 0, 0, 24)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.CategoryItem)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textButton.Parent = object.gui

	object.collapseIcon = Instance.new("ImageLabel")
	object.collapseIcon.Size = UDim2.new(1, 0, 1, 0)
	object.collapseIcon.BackgroundTransparency = 1
	object.collapseIcon.Image = closeImage
	object.collapseIcon.ImageColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.collapseIcon.Parent = textButton

	local aspectRatio = Instance.new("UIAspectRatioConstraint")
	aspectRatio.Parent = object.collapseIcon
	
	object.frame = Instance.new("Frame")
	object.frame.Size = UDim2.new(1, 0, 0, 0)
	object.frame.BackgroundTransparency = 1
	object.frame.BorderSizePixel = 0
	object.frame.Parent = object.gui
	
	object.listLayout = Instance.new("UIListLayout")
	object.listLayout.Padding = UDim.new(0, 1)
	object.listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	object.listLayout.Parent = object.frame
	object.listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		object.frame.Size = UDim2.new(1, 0, 0, object.listLayout.AbsoluteContentSize.Y)
	end)
	
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.CategoryItem, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)

		object.collapseIcon.ImageColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.CategoryItem, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)

		object.collapseIcon.ImageColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.CategoryItem, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Pressed)

		object.collapseIcon.ImageColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.CategoryItem, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)

		object.collapseIcon.ImageColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)

	
	textButton.Activated:Connect(function()
		object.frame.Visible = not object.frame.Visible
		if object.collapseIcon.Image == closeImage then
			object.collapseIcon.Image = openImage
		else
			object.collapseIcon.Image = closeImage
		end
	end)
	
	return object
end

local listConnection = nil
module.Lock = function(self, reason)
	self.LockedGuiObjects = {}
	for i, v in pairs(self.frame:GetDecendants()) do
		if v:IsA("TextBox") or v:IsA("ImageButton") or v:IsA("TextButton") then
			if v.Active == true then
				v.Active = false
				self.LockedGuiObjects[#self.LockedGuiObjects+1] = v
			end
		end
	end
	
	self.reasonText = Instance.new("TextLabel")
	self.reasonText.Text = reason
	self.reasonText.Parent = self.gui
	self.reasonText.BackgroundTransparency = 0.5
	self.reasonText.Font = Enum.Font.ArialBold
	self.reasonText.TextSize = 20
	self.reasonText.BackgroundColor3 = Color3.new(0, 0, 0)
	listConnection = self.listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		self.reasonText.Size = UDim2.new(1, 0, 0, self.listLayout.AbsoluteContentSize.Y)
	end)
end

module.Unlock = function(self, reason)
	for i,v in pairs(self.LockedGuiObjects) do
		v.Active = true
	end
	if listConnection ~= nil then
		listConnection:Disconnect()
	end
	self.reasonText:Destroy()
end

module.AddChild = function(self, child)
	child.Parent = self.frame
end

return module
