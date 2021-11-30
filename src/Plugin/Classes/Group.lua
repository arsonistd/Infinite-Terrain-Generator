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
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 1)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Parent = object.frame
	listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		object.frame.Size = UDim2.new(1, 0, 0, listLayout.AbsoluteContentSize.Y)
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

module.AddChild = function(self, child)
	child.Parent = self.frame
end

return module
