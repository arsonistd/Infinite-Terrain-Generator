local root = script.Parent.Parent
local G = require(root.G)

local slider = {}
slider.__index = slider

slider.New = function(label, parent, data)
	local self = setmetatable({}, slider)
	
	self.data = data
	
	self.gui = Instance.new("Frame")
	self.gui.Size = UDim2.new(1, 0, 0, 24)
	self.gui.BackgroundTransparency = 1
	self.gui.BorderSizePixel = 0
	
	-- Arg 2
	if parent then
		self.gui.Parent = parent
	end
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.Parent = self.gui
	
	local nameLabel = Instance.new("TextLabel")
	nameLabel.Text = label or ""
	nameLabel.Font = Enum.Font.Arial
	nameLabel.TextSize = 12
	nameLabel.Position = UDim2.new(0, 0, 0, 0)
	nameLabel.Size = UDim2.new(0, 120, 1, 0)
	nameLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	nameLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	nameLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	nameLabel.LayoutOrder = 1
	nameLabel.Parent = self.gui
	
	self.textBox = Instance.new("TextBox")
	self.textBox.Text = object.value
	self.textBox.Font = Enum.Font.Arial
	self.textBox.TextSize = 12
	self.textBox.Position = UDim2.new(1, 0, 0, 0)
	self.textBox.Size = UDim2.new(0, 120, 1, 0)
	self.textBox.AnchorPoint = Vector2.new(1, 0)
	self.textBox.ClearTextOnFocus = false
	self.textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	self.textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	self.textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	self.nameLabel.LayoutOrder = 2
	self.textBox.Parent = self.gui
	self.textBox.MouseEnter:Connect(function()
		self.textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		self.textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		self.textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	self.textBox.MouseLeave:Connect(function()
		self.textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		self.textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		self.textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	self.textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		local newValue = tonumber(object.textBox.Text) or object.value
		if self.data.minimum then newValue = math.max(newValue, self.data.minimum) end
		if self.data.maximum then newValue = math.min(newValue, self.data.maximum) end
		if self.data.round then newValue = G.modules["Functions"].Round(newValue, self.data.round) end
		object.textBox.Text = newValue
		if object.value == newValue then return end
		object.value = newValue
		object.event:Call(self.value)
	end)
	
	local sliderFrame = Instance.new("Frame")
	sliderFrame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	sliderFrame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	sliderFrame.Position = UDim2.new(0, 120, 0, 0)
	sliderFrame.Size = UDim2.new(1, -121, 1, 0)
	sliderFrame.LayoutOrder = 2
	sliderFrame.Parent = self.gui
	
	return self
end

slider:Set = function(self, value)
	if self.value == value then return end
	if self.data.minimum then value = math.max(value, self.data.minimum) end
	if self.data.maximum then value = math.min(value, self.data.maximum) end
	if self.data.round then value = G.modules["Functions"].Round(value, self.data.round) end
end

slider:Destroy = function()
	
end


return slider
