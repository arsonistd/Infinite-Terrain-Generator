local root = script.Parent.Parent
local G = require(root.G)

local module = {}
module.__index = module

module.New = function(data)
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
	
	local positionFrame = Instance.new("Frame")
	positionFrame.Position = UDim2.new(0.06, 0, 0, 0)
	positionFrame.Size = UDim2.new(0.06, -1, 0, 24)
	positionFrame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	positionFrame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	positionFrame.Parent = object.indent.gui

	local upButton = Instance.new("ImageButton")
	upButton.Position = UDim2.new(0, 3, 0, 3)
	upButton.Size = UDim2.new(1, -6, 0.5, -4)
	upButton.ScaleType = Enum.ScaleType.Fit
	upButton.Image = "rbxassetid://7588748905"
	upButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	upButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	upButton.Parent = positionFrame
	upButton.Activated:Connect(function()
		object.event:Call(1)
	end)

	local downButton = Instance.new("ImageButton")
	downButton.Position = UDim2.new(0, 3, 0.5, 1)
	downButton.Size = UDim2.new(1, -6, 0.5, -4)
	downButton.ScaleType = Enum.ScaleType.Fit
	downButton.Image = "rbxassetid://7588749154"
	downButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	downButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	downButton.Parent = positionFrame
	downButton.Activated:Connect(function()
		object.event:Call(2)
	end)

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
		object:ToggleNoiseSettings()
	end)
	
	local dupeDeleteFrame = Instance.new("Frame")
	dupeDeleteFrame.Position = UDim2.new(0.9, 0, 0, 0)
	dupeDeleteFrame.Size = UDim2.new(0.1, 0, 0, 24)
	dupeDeleteFrame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	dupeDeleteFrame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	dupeDeleteFrame.Parent = object.indent.gui
	
	local dupeButton = Instance.new("ImageButton")
	dupeButton.Position = UDim2.new(0, 3, 0, 3)
	dupeButton.Size = UDim2.new(0.5, -6, 0, 18)
	dupeButton.ScaleType = Enum.ScaleType.Fit
	dupeButton.Image = "rbxassetid://7588843599"
	dupeButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	dupeButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	dupeButton.Parent = dupeDeleteFrame
	dupeButton.Activated:Connect(function()
		object.event:Call(3)
	end)

	local deleteButton = Instance.new("ImageButton")
	deleteButton.Position = UDim2.new(0.5, 3, 0, 3)
	deleteButton.Size = UDim2.new(0.5, -6, 0, 18)
	deleteButton.ScaleType = Enum.ScaleType.Fit
	deleteButton.Image = "rbxassetid://7588749786"
	deleteButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	deleteButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	deleteButton.Parent = dupeDeleteFrame
	deleteButton.Activated:Connect(function()
		object.event:Call(4)
	end)

	object.noiseTypeButton = Instance.new("ImageButton")
	object.noiseTypeButton.Position = UDim2.new(0.12, 0, 0, 0)
	object.noiseTypeButton.Size = UDim2.new(0.13, -1, 0, 24)
	object.noiseTypeButton.ScaleType = Enum.ScaleType.Crop
	object.noiseTypeButton.Image = G.modules["Data"].noises[data[6]][2]
	object.noiseTypeButton.AutoButtonColor = false
	object.noiseTypeButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.noiseTypeButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.noiseTypeButton.Parent = object.indent.gui
	
	object.seedTextBox = Instance.new("TextBox")
	object.seedTextBox.Text = tonumber(data[1])
	object.seedTextBox.Position = UDim2.new(0.25, 0, 0, 0)
	object.seedTextBox.Size = UDim2.new(0.13, -1, 0, 24)
	object.seedTextBox.ClearTextOnFocus = false
	object.seedTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.seedTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.seedTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.seedTextBox.Parent = object.indent.gui
	object.seedTextBox.MouseEnter:Connect(function()
		object.seedTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.seedTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.seedTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.seedTextBox.MouseLeave:Connect(function()
		object.seedTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.seedTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.seedTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.seedTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[1] = tonumber(object.seedTextBox.Text) or data[1]
		object.seedTextBox.Text = data[1]
		if object.settingsOpen == true then
			object.settingSeedTextBox.Text = data[1]
		end
	end)
	
	object.magnitudeTextBox = Instance.new("TextBox")
	object.magnitudeTextBox.Text = tonumber(object.data[2])
	object.magnitudeTextBox.Position = UDim2.new(0.38, 0, 0, 0)
	object.magnitudeTextBox.Size = UDim2.new(0.13, -1, 0, 24)
	object.magnitudeTextBox.ClearTextOnFocus = false
	object.magnitudeTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.magnitudeTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.magnitudeTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.magnitudeTextBox.Parent = object.indent.gui
	object.magnitudeTextBox.MouseEnter:Connect(function()
		object.magnitudeTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.magnitudeTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.magnitudeTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.magnitudeTextBox.MouseLeave:Connect(function()
		object.magnitudeTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.magnitudeTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.magnitudeTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.magnitudeTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[2] = tonumber(object.magnitudeTextBox.Text) or data[2]
		object.magnitudeTextBox.Text = data[2]
		if object.settingsOpen == true then
			object.settingMagnitudeTextBox.Text = data[2]
		end
	end)
	
	object.scaleTextBox = Instance.new("TextBox")
	object.scaleTextBox.Text = tonumber(data[3])
	object.scaleTextBox.Position = UDim2.new(0.51, 0, 0, 0)
	object.scaleTextBox.Size = UDim2.new(0.13, -1, 0, 24)
	object.scaleTextBox.ClearTextOnFocus = false
	object.scaleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.scaleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.scaleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.scaleTextBox.Parent = object.indent.gui
	object.scaleTextBox.MouseEnter:Connect(function()
		object.scaleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.scaleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.scaleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.scaleTextBox.MouseLeave:Connect(function()
		object.scaleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.scaleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.scaleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.scaleTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[3] = tonumber(object.scaleTextBox.Text) or data[3]
		object.scaleTextBox.Text = data[3]
		if object.settingsOpen == true then
			object.settingScaleTextBox.Text = data[3]
		end
	end)
	
	object.minClampTextBox = Instance.new("TextBox")
	object.minClampTextBox.Text = tonumber(data[4])
	object.minClampTextBox.Position = UDim2.new(0.64, 0, 0, 0)
	object.minClampTextBox.Size = UDim2.new(0.13, -1, 0, 24)
	object.minClampTextBox.ClearTextOnFocus = false
	object.minClampTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.minClampTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.minClampTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.minClampTextBox.Parent = object.indent.gui
	object.minClampTextBox.MouseEnter:Connect(function()
		object.minClampTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.minClampTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.minClampTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.minClampTextBox.MouseLeave:Connect(function()
		object.minClampTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.minClampTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.minClampTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.minClampTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[4] = tonumber(object.minClampTextBox.Text) or data[4]
		object.minClampTextBox.Text = data[4]
		if object.settingsOpen == true then
			object.settingMinClampTextBox.Text = data[4]
		end
	end)
	
	object.maxClampTextBox = Instance.new("TextBox")
	object.maxClampTextBox.Text = tonumber(data[5])
	object.maxClampTextBox.Position = UDim2.new(0.77, 0, 0, 0)
	object.maxClampTextBox.Size = UDim2.new(0.13, -1, 0, 24)
	object.maxClampTextBox.ClearTextOnFocus = false
	object.maxClampTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.maxClampTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.maxClampTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.maxClampTextBox.Parent = object.indent.gui
	object.maxClampTextBox.MouseEnter:Connect(function()
		object.maxClampTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.maxClampTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.maxClampTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.maxClampTextBox.MouseLeave:Connect(function()
		object.maxClampTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.maxClampTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.maxClampTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.maxClampTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[5] = tonumber(object.maxClampTextBox.Text) or data[5]
		object.maxClampTextBox.Text = data[5]
		if object.settingsOpen == true then
			object.settingMaxClampTextBox.Text = data[5]
		end
	end)

	object:Init()
	
	return object
end


module.Init = function(self)

	self.noiseTypeButton.MouseEnter:Connect(function()
		self.noiseTypeButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		self.noiseTypeButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		self.noiseTypeButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	self.noiseTypeButton.MouseLeave:Connect(function()
		self.noiseTypeButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		self.noiseTypeButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		self.noiseTypeButton.ImageColor3 = Color3.new(1, 1, 1)
	end)
	self.noiseTypeButton.MouseButton1Down:Connect(function()
		self.noiseTypeButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Pressed)
		self.noiseTypeButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Pressed)
		self.noiseTypeButton.ImageColor3 = Color3.new(0.5, 0.5, 0.5)
	end)
	self.noiseTypeButton.MouseButton1Up:Connect(function()
		self.noiseTypeButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		self.noiseTypeButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		self.noiseTypeButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	self.noiseTypeButton.Activated:Connect(function()
		self:ToggleNoiseSettings()
	end)

end


module.ToggleNoiseSettings = function(self)
	if self.settingsOpen == true then
		self.settingsOpen = false

		if self.noiseSelectionFrameOpen == true then
			self.noisesSelectionFrame:Destroy()
		end
		self.noiseSelectionFrameOpen = false

		self.settingFrame:Destroy()

		self.gui.Size = UDim2.new(1, 0, 0, 24)
		self.collapseButton.Image = "rbxassetid://8057404440"
		
	else
		self.settingsOpen = true
		self.noiseSelectionFrameOpen = false

		self.gui.Size = UDim2.new(1, 0, 0, 168)

		self.collapseButton.Image = "rbxassetid://8057404581"

		self.settingFrame = G.classes["Indent"].New({
			["indent"] = 0.03,
			["position"] = UDim2.new(1, 0, 0, 24),
			["parent"] = self.indent.gui
		})

		self.settingNoiseSelection = G.classes["NoiseSelection"].New(self.data[6])
		self.settingNoiseSelection.gui.Parent = self.settingFrame.gui
		self.settingNoiseSelection.event:Bind(function(value, valueImage)
			self.data[6] = tonumber(value) or self.data[6]
			self.noiseTypeButton.Image = valueImage
		end)
		self.settingNoiseSelection.openEvent:Bind(function(value)
			if value == true then
				self.gui.Size = UDim2.new(1, 0, 0, 233)

				self.settingSeedTextBox.gui.Position = UDim2.new(0, 0, 0, 113-24)
				self.settingMagnitudeTextBox.gui.Position = UDim2.new(0, 0, 0, 137-24)
				self.settingScaleTextBox.gui.Position = UDim2.new(0, 0, 0, 161-24)
				self.settingMaxClampTextBox.gui.Position = UDim2.new(0, 0, 0, 185-24)
				self.settingMinClampTextBox.gui.Position = UDim2.new(0, 0, 0, 209-24)
			else
				self.gui.Size = UDim2.new(1, 0, 0, 168)

				self.settingSeedTextBox.gui.Position = UDim2.new(0, 0, 0, 24)
				self.settingMagnitudeTextBox.gui.Position = UDim2.new(0, 0, 0, 48)
				self.settingScaleTextBox.gui.Position = UDim2.new(0, 0, 0, 72)
				self.settingMaxClampTextBox.gui.Position = UDim2.new(0, 0, 0, 96)
				self.settingMinClampTextBox.gui.Position = UDim2.new(0, 0, 0, 120)
			end
		end)

		self.settingSeedTextBox = G.classes["Number"].New("Seed", self.data[1])
		self.settingSeedTextBox.gui.Position = UDim2.new(0, 0, 0, 24)
		self.settingSeedTextBox.gui.Parent = self.settingFrame.gui
		self.settingSeedTextBox.event:Bind(function(value)
			self.data[1] = tonumber(value) or self.data[1]
			self.settingSeedTextBox:Set(self.data[1])
			self.seedTextBox.Text = self.data[1]
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
		generateSeedButton.Parent = self.settingSeedTextBox.gui
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
			self.data[1] = G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3)
			self.settingSeedTextBox:Set(self.data[1])
			self.seedTextBox.Text = self.data[1]
		end)
		
		self.settingMagnitudeTextBox = G.classes["Number"].New("Magnitude", self.data[2])
		self.settingMagnitudeTextBox.gui.Position = UDim2.new(0, 0, 0, 24*2)
		self.settingMagnitudeTextBox.gui.Parent = self.settingFrame.gui
		self.settingMagnitudeTextBox.event:Bind(function(value)
			self.data[2] = tonumber(value) or self.data[2]
			self.settingMagnitudeTextBox:Set(self.data[2])
			self.magnitudeTextBox.Text = self.data[2]
		end)

		self.settingScaleTextBox = G.classes["Number"].New("Scale", self.data[3])
		self.settingScaleTextBox.gui.Position = UDim2.new(0, 0, 0, 24*3)
		self.settingScaleTextBox.gui.Parent = self.settingFrame.gui
		self.settingScaleTextBox.event:Bind(function(value)
			self.data[3] = tonumber(value) or self.data[3]
			self.settingScaleTextBox:Set(self.data[3])
			self.scaleTextBox.Text = self.data[3]
		end)

		self.settingMinClampTextBox = G.classes["Number"].New("Min Clamp", self.data[4])
		self.settingMinClampTextBox.gui.Position = UDim2.new(0, 0, 0, 24*4)
		self.settingMinClampTextBox.gui.Parent = self.settingFrame.gui
		self.settingMinClampTextBox.event:Bind(function(value)
			self.data[4] = tonumber(value) or self.data[4]
			self.settingMinClampTextBox:Set(self.data[4])
			self.minClampTextBox.Text = self.data[4]
		end)

		self.settingMaxClampTextBox = G.classes["Number"].New("Max Clamp", self.data[5])
		self.settingMaxClampTextBox.gui.Position = UDim2.new(0, 0, 0, 24*5)
		self.settingMaxClampTextBox.gui.Parent = self.settingFrame.gui
		self.settingMaxClampTextBox.event:Bind(function(value)
			self.data[5] = tonumber(value) or self.data[5]
			self.settingMaxClampTextBox:Set(self.data[5])
			self.maxClampTextBox.Text = self.data[5]
		end)
	end
end

module.Destroy = function(self)
	self.event:UnBindAll()
	self.gui:Destroy()
end

return module
