local root = script.Parent.Parent
local G = require(root.G)

local module = {}
module.__index = module

local function getSelectedName(value)
	for i, material in ipairs(G.modules["Data"].materials) do
		if material[1] == value then
			return material[3]
		end
	end
end

module.New = function(value)
	local object = setmetatable({}, module)
	
	object.event = G.classes["Event"].New()
	object.value = value
	object.selected = value or ""
	object.selectedName = getSelectedName(value)
	
	object.gui = Instance.new("Frame")
	object.gui.Size = UDim2.new(1, 0, 0, 208)-- 184
	object.gui.Position = UDim2.new(0, 0, 0, 0)
	object.gui.BackgroundTransparency = 1

	local listLayout = Instance.new("UIListLayout")
	listLayout.Parent = object.gui
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.VerticalAlignment = Enum.VerticalAlignment.Center

	local materialTitleFrame = Instance.new("Frame")
	materialTitleFrame.BackgroundTransparency = 1
	materialTitleFrame.Size = UDim2.new(1, 0, 0, 24)
	materialTitleFrame.Parent = object.gui

	local materialTitle = Instance.new("TextLabel")
	materialTitle.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	materialTitle.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	materialTitle.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	materialTitle.Size = UDim2.new(0, 120, 1, 0)
	materialTitle.Text = "Brush Material"
	materialTitle.Font = Enum.Font.Arial
	materialTitle.TextSize = 12
	materialTitle.LayoutOrder = 1
	materialTitle.Parent = materialTitleFrame

	object.selectedLabel = Instance.new("TextLabel")
	object.selectedLabel.Text = object.selectedName
	object.selectedLabel.Font = Enum.Font.Arial
	object.selectedLabel.TextSize = 12
	object.selectedLabel.Position = UDim2.new(0, 121, 0, 0)
	object.selectedLabel.Size = UDim2.new(1, -121, 1, 0)
	object.selectedLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.selectedLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.selectedLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.selectedLabel.Parent = materialTitleFrame
	
	local materialFrame = Instance.new("Frame")
	materialFrame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	materialFrame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	materialFrame.Size = UDim2.new(1, 0, 0, 184)
	materialFrame.Parent = object.gui
	materialFrame.LayoutOrder = 2
	
	local materialPadding = Instance.new("UIPadding")
	materialPadding.PaddingBottom = UDim.new(0, 8)
	materialPadding.PaddingLeft = UDim.new(0, 8)
	materialPadding.PaddingRight = UDim.new(0, 0)
	materialPadding.PaddingTop = UDim.new(0, 8)
	materialPadding.Parent = materialFrame
	
	local gridLayout = Instance.new("UIGridLayout")
	gridLayout.CellSize = UDim2.new(0.125, -8, 0, 50)
	gridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
	gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	gridLayout.Parent = materialFrame
	gridLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom


	object.selectedLabel.MouseEnter:Connect(function()
		object.selectedLabel.Text = "Select material below..."
	end)
	object.selectedLabel.MouseLeave:Connect(function()
		object.selectedLabel.Text = object.selectedName
	end)
	
	object.imageButtons = {}
	
	for i, material in ipairs(G.modules["Data"].materials) do
		local imageButton = Instance.new("ImageButton")
		imageButton.Image = material[2]
		imageButton.ScaleType = Enum.ScaleType.Crop
		imageButton.BorderSizePixel = 2
		imageButton.AutoButtonColor = false
		imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
		if object.selected == (material[1] or "") then
			imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Selected)
		else
			imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
		end
		
		imageButton.Parent = materialFrame
				
		imageButton.MouseEnter:Connect(function()
			if object.selected == (material[1] or "") then return end
			imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
			imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
			imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
		end)
		imageButton.MouseLeave:Connect(function()
			if object.selected == (material[1] or "") then return end
			imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
			imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
			imageButton.ImageColor3 = Color3.new(1, 1, 1)
		end)
		imageButton.MouseButton1Down:Connect(function()
			if object.selected == (material[1] or "") then return end
			imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
			imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
			imageButton.ImageColor3 = Color3.new(0.5, 0.5, 0.5)
		end)
		imageButton.MouseButton1Up:Connect(function()
			if object.selected == (material[1] or "") then return end
			imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
			imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
			imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
		end)
		imageButton.Activated:Connect(function()
			if object.value == material[1] then return end
			object.value = material[1]
			object.event:Call(object.value)
		end)
		object.imageButtons[material[1] or ""] = imageButton
	end
	
	return object
end

module.Select = function(self, value)
	self.imageButtons[self.selected].BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
	self.imageButtons[self.selected].BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
	self.imageButtons[self.selected].ImageColor3 = Color3.new(1, 1, 1)
	self.selected = value or ""
	self.imageButtons[self.selected].BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
	self.imageButtons[self.selected].BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Selected)

	self.imageButtons[self.selected].ImageColor3 = Color3.new(1, 1, 1)
	self.selectedName =  getSelectedName(value)
	self.selectedLabel.Text = self.selectedName 
end

module.Destroy = function(self)
	self.event:UnBindAll()
	self.gui:Destroy()
end

return module
