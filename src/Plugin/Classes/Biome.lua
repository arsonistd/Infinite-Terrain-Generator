local root = script.Parent.Parent
local G = require(root.G)

local module = {}
module.__index = module

module.New = function(data)
	local object = setmetatable({}, module)
	
	object.event = G.classes["Event"].New()
	object.data = data
	object.settingsOpen = false
	object.selected = data[2]
	
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

	local selectedFrame = Instance.new("Frame")
	selectedFrame.Position = UDim2.new(0.06, 0, 0, 0)
	selectedFrame.Size = UDim2.new(0.12, -1, 0, 24)
	selectedFrame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	selectedFrame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	selectedFrame.Parent = object.indent.gui

	object.selectedButton = Instance.new("TextButton")
	object.selectedButton.Position = UDim2.new(0, 3, 0, 3)
	object.selectedButton.Size = UDim2.new(1, -6, 0, 18)
	object.selectedButton.Text = "Unselected"
	object.selectedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	object.selectedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	object.selectedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.selectedButton.TextSize = 12
	object.selectedButton.Font = Enum.Font.Arial
	object.selectedButton.Parent = selectedFrame
	if data[2] == true then
		object.selectedButton.Text = "Selected"
		object.selectedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Selected)
		object.selectedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Selected)
		object.selectedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Selected)
	end
	object.selectedButton.Activated:Connect(function()
		object.event:Call(1)
		if object.selected == true then
			object:Unselect()
		else
			object:Select()
		end
	end)

	local deleteDupeFrame = Instance.new("Frame")
	deleteDupeFrame.Position = UDim2.new(0.9, 0, 0, 0)
	deleteDupeFrame.Size = UDim2.new(0.1, 0, 0, 24)
	deleteDupeFrame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	deleteDupeFrame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	deleteDupeFrame.Parent = object.indent.gui

	local deleteButton = Instance.new("ImageButton")
	deleteButton.Position = UDim2.new(0, 3, 0, 3)
	deleteButton.Size = UDim2.new(0.5, -6, 0, 18)
	deleteButton.ScaleType = Enum.ScaleType.Fit
	deleteButton.Image = "rbxassetid://7588843599"
	deleteButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	deleteButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	deleteButton.Parent = deleteDupeFrame
	deleteButton.Activated:Connect(function()
		object.event:Call(2)
	end)

	local dupeButton = Instance.new("ImageButton")
	dupeButton.Position = UDim2.new(0.5, 3, 0, 3)
	dupeButton.Size = UDim2.new(0.5, -6, 0, 18)
	dupeButton.ScaleType = Enum.ScaleType.Fit
	dupeButton.Image = "rbxassetid://7588749786"
	dupeButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	dupeButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	dupeButton.Parent = deleteDupeFrame
	dupeButton.Activated:Connect(function()
		object.event:Call(3)
	end)

	object.CompositionTextBox = Instance.new("TextBox")
	object.CompositionTextBox.Position = UDim2.new(0.18, 0, 0, 0)
	object.CompositionTextBox.Size = UDim2.new((1-0.28)/2, 0, 1, 0)
	object.CompositionTextBox.Text = data[1]
	object.CompositionTextBox.Parent = object.indent.gui
	object.CompositionTextBox.ClearTextOnFocus = false
	object.CompositionTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.CompositionTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.CompositionTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.CompositionTextBox.MouseEnter:Connect(function()
		object.CompositionTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.CompositionTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.CompositionTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.CompositionTextBox.MouseLeave:Connect(function()
		object.CompositionTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.CompositionTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.CompositionTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.CompositionTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[1] = tonumber(object.CompositionTextBox.Text) or data[1]
		object.CompositionTextBox.Text = data[1]
	end)
	
	object.ScaleTextBox = Instance.new("TextBox")
	object.ScaleTextBox.Position = UDim2.new(0.18+((1-0.28)/3), 0, 0, 0)
	object.ScaleTextBox.Size = UDim2.new((1-0.28)/3, 0, 1, 0)
	object.ScaleTextBox.Text = data[3]
	object.ScaleTextBox.Parent = object.indent.gui
	object.ScaleTextBox.ClearTextOnFocus = false
	object.ScaleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.ScaleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.ScaleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.ScaleTextBox.MouseEnter:Connect(function()
		object.ScaleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.ScaleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.ScaleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.ScaleTextBox.MouseLeave:Connect(function()
		object.ScaleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.ScaleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.ScaleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.ScaleTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[3] = tonumber(object.ScaleTextBox.Text) or data[3]
		object.ScaleTextBox.Text = data[3]
	end)
	
	object.SeedTextBox = Instance.new("TextBox")
	object.SeedTextBox.Position = UDim2.new(0.18+(((1-0.28)/3)*2), 0, 0, 0)
	object.SeedTextBox.Size = UDim2.new((1-0.28)/3, 0, 1, 0)
	object.SeedTextBox.Text = data[4]
	object.SeedTextBox.Parent = object.indent.gui
	object.SeedTextBox.ClearTextOnFocus = false
	object.SeedTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.SeedTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.SeedTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.SeedTextBox.MouseEnter:Connect(function()
		object.SeedTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.SeedTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.SeedTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.SeedTextBox.MouseLeave:Connect(function()
		object.SeedTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.SeedTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.SeedTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.SeedTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[4] = tonumber(object.SeedTextBox.Text) or data[4]
		object.SeedTextBox.Text = data[4]
	end)
	local generateSeedButton = Instance.new("TextButton")
	generateSeedButton.Text = "Generate"
	generateSeedButton.Font = Enum.Font.Arial
	generateSeedButton.TextSize = 12
	generateSeedButton.Position = UDim2.new(1, -4, 0.5, 0)
	generateSeedButton.AnchorPoint = Vector2.new(1, 0.5)
	generateSeedButton.Size = UDim2.new(0, 55, 1, -6)
	generateSeedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	generateSeedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	generateSeedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	generateSeedButton.Parent = self.SettingsSeedTextBox.gui
	generateSeedButton.MouseEnter:Connect(function()
		generateSeedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		generateSeedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		generateSeedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	generateSeedButton.MouseLeave:Connect(function()
		generateSeedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		generateSeedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		generateSeedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	generateSeedButton.MouseButton1Up:Connect(function()
		generateSeedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		generateSeedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Pressed)
		generateSeedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	generateSeedButton.MouseButton1Down:Connect(function()
		generateSeedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		generateSeedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		generateSeedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	generateSeedButton.Activated:Connect(function()
		self.data[4] = G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3)
		self.SettingsSeedTextBox:Set(self.data[4])
		self.SeedTextBox.Text = self.data[4]
	end)
	
	return object
end

module.Select = function(self)
	self.selected = true
	self.selectedButton.Text = "Selected"
	self.selectedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Selected)
	self.selectedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Selected)
	self.selectedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Selected)
end

module.Unselect = function(self)
	self.selected = false
	self.selectedButton.Text = "Unselected"
	self.selectedButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	self.selectedButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	self.selectedButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
end

module.ToggleBiomeParameters = function(self)
	if self.settingsOpen == true then
		self.settingsOpen = false
		self.collapseButton.Image = "rbxassetid://8057404440"
		self.gui.Size = UDim2.new(1, 0, 0, 24)
		self.settingsIndent:Destroy()
	else
		self.settingsOpen = true
		self.collapseButton.Image = "rbxassetid://8057404581"
		self.gui.Size = UDim2.new(1, 0, 0, 24*4)
		self.settingsIndent = G.classes["Indent"].New({
			["indent"] = 0.03,
			["position"] = UDim2.new(1, 0, 0, 24),
			["parent"] = object.indent
		})
		self.SettingsCompositionTextBox = G.Classes[Number].New("Composition", self.data[1])
		self.SettingsCompositionTextBox.gui.Parent = self.settingsIndent.gui
		self.SettingsCompositionTextBox.event:Bind(function(value)
			self.data[1] = tonumber(value) or self.data[1]
			self.SettingsCompositionTextBox:Set(self.data[1])
			self.CompositionTextBox.Text = self.data[1]
		end)
		self.SettingsScaleTextBox = G.Classes[Number].New("Composition", self.data[3])
		self.SettingsScaleTextBox.gui.Position = UDim2.new(0, 0, 0, 24)
		self.SettingsScaleTextBox.gui.Parent = self.settingsIndent.gui
		self.SettingsScaleTextBox.event:Bind(function(value)
			self.data[3] = tonumber(value) or self.data[3]
			self.SettingsScaleTextBox:Set(self.data[3])
			self.ScaleTextBox.Text = self.data[3]
		end)
		self.SettingsSeedTextBox = G.Classes[Number].New("Composition", self.data[3])
		self.SettingsSeedTextBox.gui.Position = UDim2.new(0, 0, 0, 24)
		self.SettingsSeedTextBox.gui.Parent = self.settingsIndent.gui
		self.SettingsSeedTextBox.event:Bind(function(value)
			self.data[4] = tonumber(value) or self.data[4]
			self.SettingsSeedTextBox:Set(self.data[4])
			self.SeedTextBox.Text = self.data[4]
		end)
	end
end

module.Destroy = function(self)
	self.gui:Destroy()
end

return module
