local root = script.Parent.Parent
local G = require(root.G)

local module = {}
module.__index = module

local function getSelectedName(value)
	for i, noise in ipairs(G.modules["Data"].noises) do
		if noise[1] == value then
			return noise[3]
		end
	end
end

module.New = function(value)
	local object = setmetatable({}, module)

    object.event = G.classes["Event"].New()
	object.openEvent = G.classes["Event"].New()
	object.value = value
	object.selected = value or ""
	object.selectedName = getSelectedName(value)
	object.selectionOpen = false

	object.gui = Instance.new("Frame")
	object.gui.Size = UDim2.new(1, 0, 0, 24)-- 184
	object.gui.Position = UDim2.new(0, 0, 0, 0)
	object.gui.BackgroundTransparency = 0

	local noiseFrame = Instance.new("Frame")
	noiseFrame.BackgroundTransparency = 1
	noiseFrame.Size = UDim2.new(1, 0, 0, 24)
	noiseFrame.Parent = object.gui

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	TitleLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	TitleLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	TitleLabel.Size = UDim2.new(0, 120, 1, 0)
	TitleLabel.Text = "Noise Pattern"
	TitleLabel.Font = Enum.Font.Arial
	TitleLabel.TextSize = 12
	TitleLabel.LayoutOrder = 1
	TitleLabel.Parent = noiseFrame

	object.selectedLabel = Instance.new("TextLabel")
	object.selectedLabel.Text = object.selectedName
	object.selectedLabel.Font = Enum.Font.Arial
	object.selectedLabel.TextSize = 12
	object.selectedLabel.Position = UDim2.new(0, 121, 0, 0)
	object.selectedLabel.Size = UDim2.new(1, -121, 1, 0)
	object.selectedLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.selectedLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.selectedLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.selectedLabel.Parent = noiseFrame
	object.selectedLabel.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			object:ToggleSelection()
		end
	end)
	object.selectedLabel.MouseEnter:Connect(function()
		object.selectedLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.selectedLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.selectedLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
		object.selectedLabel.Text = "Click to change noise pattern..."
	end)
	object.selectedLabel.MouseLeave:Connect(function()
		object.selectedLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.selectedLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.selectedLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
		object.selectedLabel.Text = object.selectedName
	end)

    return object 
end

module.ToggleSelection = function(self)
	if self.selectionOpen then
		self.selectionOpen = false
		self.openEvent:Call(false)
		self.noisesSelectionFrame:Destroy()
		self.gui.Size = UDim2.new(1, 0, 0, 24)
	else
		self.selectionOpen = true
		self.openEvent:Call(true)
		self.gui.Size = UDim2.new(1, 0, 0, 233)

		self.noisesSelectionFrame = G.classes["Indent"].New({
			["indent"] = 0.03,
			["position"] = UDim2.new(1, 0, 0, 24),
			["parent"] = self.gui,
			["ySizeOffset"] = 65,
			["ySizeScale"] = 0,
			["backgroundColor3"] = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Dropdown),
			["borderColor3"] = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border),
			["borderSizePixel"] = 1,
			["backgroundTransparency"] = 0
		})

		local padding = Instance.new("UIPadding")
		padding.PaddingBottom = UDim.new(0, 8)
		padding.PaddingLeft = UDim.new(0, 8)
		padding.PaddingRight = UDim.new(0, 8)
		padding.PaddingTop = UDim.new(0, 8)
		padding.Parent = self.noisesSelectionFrame.gui

		local gridLayout = Instance.new("UIGridLayout")
		gridLayout.CellSize = UDim2.new(0.125, -4, 0, 50)
		gridLayout.CellPadding = UDim2.new(0, 4, 0, 4)
		gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		gridLayout.Parent = self.noisesSelectionFrame.gui

		for i, noise in ipairs(G.modules["Data"].noises) do
			local imageButton = Instance.new("ImageButton")
			imageButton.Image = noise[2]
			imageButton.ScaleType = Enum.ScaleType.Crop
			imageButton.BorderSizePixel = 2
			imageButton.AutoButtonColor = false
			imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
			imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
			imageButton.MouseEnter:Connect(function()
				imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
				imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
				imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
			end)
			imageButton.MouseLeave:Connect(function()
				imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
				imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
				imageButton.ImageColor3 = Color3.new(1, 1, 1)
			end)
			imageButton.MouseButton1Down:Connect(function()
				imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
				imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
				imageButton.ImageColor3 = Color3.new(0.5, 0.5, 0.5)
			end)
			imageButton.MouseButton1Up:Connect(function()
				imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
				imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
				imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
			end)
			imageButton.Activated:Connect(function()
				if self.value == noise[1] then self:ToggleSelection() return end
				self.value = noise[1]
				self.selectedName = noise[3]
				self.selectedLabel.Text = self.selectedName
				self.event:Call(noise[1], noise[2])
				self:ToggleSelection()
			end)
			imageButton.Parent = self.noisesSelectionFrame.gui
		end
	end
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