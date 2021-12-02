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
		object:toggleMaterialSettings()
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
		object.event:Call(3)
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
		object.event:Call(4)
	end)
	
	object.materialButton = Instance.new("ImageButton")
	object.materialButton.Position = UDim2.new(0.12, 0, 0, 0)
	object.materialButton.Size = UDim2.new(0.156, -1, 0, 24)
	object.materialButton.ScaleType = Enum.ScaleType.Crop
	object.materialButton.AutoButtonColor = false
	object.materialButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.materialButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.materialButton.Parent = object.indent.gui
	object.materialButton.MouseEnter:Connect(function()
		object.materialButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.materialButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.materialButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	object.materialButton.MouseLeave:Connect(function()
		object.materialButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.materialButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.materialButton.ImageColor3 = Color3.new(1, 1, 1)
	end)
	object.materialButton.MouseButton1Down:Connect(function()
		object.materialButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Pressed)
		object.materialButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Pressed)
		object.materialButton.ImageColor3 = Color3.new(0.5, 0.5, 0.5)
	end)
	object.materialButton.MouseButton1Up:Connect(function()
		object.materialButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.materialButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.materialButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	object.materialButton.Activated:Connect(function()
		object:toggleMaterialSettings()
	end)
	
	for i, material in ipairs(G.modules["Data"].materials) do
		if material[1] == data[1] then
			object.materialButton.Image = material[2]
			break
		end
	end
	
	object.minimumHeightTextBox = Instance.new("TextBox")
	object.minimumHeightTextBox.Text = data[2]
	object.minimumHeightTextBox.Position = UDim2.new(0.12+0.156, 0, 0, 0)
	object.minimumHeightTextBox.Size = UDim2.new(0.156, -1, 0, 24)
	object.minimumHeightTextBox.ClearTextOnFocus = false
	object.minimumHeightTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.minimumHeightTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.minimumHeightTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.minimumHeightTextBox.Parent = object.indent.gui
	object.minimumHeightTextBox.MouseEnter:Connect(function()
		object.minimumHeightTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.minimumHeightTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.minimumHeightTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.minimumHeightTextBox.MouseLeave:Connect(function()
		object.minimumHeightTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.minimumHeightTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.minimumHeightTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.minimumHeightTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[2] = tonumber(object.minimumHeightTextBox.Text) or data[2]
		object.minimumHeightTextBox.Text = data[2]
	end)

	object.maximumHeightTextBox = Instance.new("TextBox")
	object.maximumHeightTextBox.Text = data[3]
	object.maximumHeightTextBox.Position = UDim2.new(0.12+0.156*2, 0, 0, 0)
	object.maximumHeightTextBox.Size = UDim2.new(0.156, -1, 0, 24)
	object.maximumHeightTextBox.ClearTextOnFocus = false
	object.maximumHeightTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.maximumHeightTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.maximumHeightTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.maximumHeightTextBox.Parent = object.indent.gui
	object.maximumHeightTextBox.MouseEnter:Connect(function()
		object.maximumHeightTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.maximumHeightTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.maximumHeightTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.maximumHeightTextBox.MouseLeave:Connect(function()
		object.maximumHeightTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.maximumHeightTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.maximumHeightTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.maximumHeightTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[3] = tonumber(object.maximumHeightTextBox.Text) or data[3]
		object.maximumHeightTextBox.Text = data[3]
	end)
	
	object.minimumAngleTextBox = Instance.new("TextBox")
	object.minimumAngleTextBox.Text = data[4]
	object.minimumAngleTextBox.Position = UDim2.new(0.12+0.156*3, 0, 0, 0)
	object.minimumAngleTextBox.Size = UDim2.new(0.156, -1, 0, 24)
	object.minimumAngleTextBox.ClearTextOnFocus = false
	object.minimumAngleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.minimumAngleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.minimumAngleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.minimumAngleTextBox.Parent = object.indent.gui
	object.minimumAngleTextBox.MouseEnter:Connect(function()
		object.minimumAngleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.minimumAngleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.minimumAngleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.minimumAngleTextBox.MouseLeave:Connect(function()
		object.minimumAngleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.minimumAngleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.minimumAngleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.minimumAngleTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[4] = tonumber(object.minimumAngleTextBox.Text) or data[4]
		object.minimumAngleTextBox.Text = data[4]
	end)
	
	object.maximumAngleTextBox = Instance.new("TextBox")
	object.maximumAngleTextBox.Text = data[5]
	object.maximumAngleTextBox.Position = UDim2.new(0.12+0.156*4, 0, 0, 0)
	object.maximumAngleTextBox.Size = UDim2.new(0.156, -1, 0, 24)
	object.maximumAngleTextBox.ClearTextOnFocus = false
	object.maximumAngleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.maximumAngleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.maximumAngleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	object.maximumAngleTextBox.Parent = object.indent.gui
	object.maximumAngleTextBox.MouseEnter:Connect(function()
		object.maximumAngleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.maximumAngleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.maximumAngleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	object.maximumAngleTextBox.MouseLeave:Connect(function()
		object.maximumAngleTextBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.maximumAngleTextBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.maximumAngleTextBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	object.maximumAngleTextBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[5] = tonumber(object.maximumAngleTextBox.Text) or data[5]
		object.maximumAngleTextBox.Text = data[5]
	end)
	
	return object
end


module.toggleMaterialSettings = function(self)
	if self.settingsOpen == true then
		self.gui.Size = UDim2.new(1, 0, 0, 24)

		self.collapseButton.Image = "rbxassetid://8057404440"

		self.settingsOpen = false
		
		self.settingFrame:Destroy()
	else
		self.gui.Size = UDim2.new(1, 0, 0, 6*24)

		self.collapseButton.Image = "rbxassetid://8057404581"

		self.settingFrame = G.classes["Indent"].New({
			["indent"] = 0.03,
			["position"] = UDim2.new(1, 0, 0, 24),
			["parent"] = self.indent.gui
		})
		self.settingsOpen = true
		self.settingsMaterial = G.classes["MaterialSelection"].New(self.data[1])
		self.settingsMaterial.gui.Parent = self.settingFrame.gui
		self.settingsMaterial.event:Bind(function(value, valueImage)
			self.data[1] = tonumber(value) or self.data[1]
			self.materialButton.Image = valueImage
		end)
		self.settingsMaterial.openEvent:Bind(function(value)
			if value == true then
				self.gui.Size = UDim2.new(1, -10, 0, 6*24+184)

				self.settingsMinHeight.gui.Position = UDim2.new(0, 0, 0, 2*24+174)
				self.settingsMaxHeight.gui.Position = UDim2.new(0, 0, 0, 3*24+174)
				self.settingsMinAngle.gui.Position = UDim2.new(0, 0, 0, 4*24+174)
				self.settingsMaxAngle.gui.Position = UDim2.new(0, 0, 0, 5*24+174)
			else
				self.gui.Size = UDim2.new(1, -10, 0, 6*24)

				self.settingsMinHeight.gui.Position = UDim2.new(0, 0, 0, 24)
				self.settingsMaxHeight.gui.Position = UDim2.new(0, 0, 0, 48)
				self.settingsMinAngle.gui.Position = UDim2.new(0, 0, 0, 72)
				self.settingsMaxAngle.gui.Position = UDim2.new(0, 0, 0, 96)
			end
		end)

		self.settingsMinHeight = G.classes["Number"].New("Minimum Height", self.data[2])
		self.settingsMinHeight.gui.Position = UDim2.new(0, 0, 0, 24)
		self.settingsMinHeight.gui.Parent = self.settingFrame.gui
		self.settingsMinHeight.event:Bind(function(value)
			self.data[2] = tonumber(value) or self.data[2]
			self.settingsMinHeight:Set(self.data[2])
			self.minimumHeightTextBox.Text = self.data[2]
		end)

		self.settingsMaxHeight = G.classes["Number"].New("Maximum Height", self.data[3])
		self.settingsMaxHeight.gui.Position = UDim2.new(0, 0, 0, 24*2)
		self.settingsMaxHeight.gui.Parent = self.settingFrame.gui
		self.settingsMaxHeight.event:Bind(function(value)
			self.data[3] = tonumber(value) or self.data[3]
			self.settingsMaxHeight:Set(self.data[3])
			self.maximumHeightTextBox.Text = self.data[3]
		end)


		self.settingsMinAngle = G.classes["Number"].New("Minimum Angle", self.data[4])
		self.settingsMinAngle.gui.Position = UDim2.new(0, 0, 0, 24*3)
		self.settingsMinAngle.gui.Parent = self.settingFrame.gui
		self.settingsMinAngle.event:Bind(function(value)
			self.data[4] = tonumber(value) or self.data[4]
			self.settingsMinAngle:Set(self.data[4])
			self.minimumAngleTextBox.Text = self.data[4]
		end)


		self.settingsMaxAngle = G.classes["Number"].New("Maximum Angle", self.data[5])
		self.settingsMaxAngle.gui.Position = UDim2.new(0, 0, 0, 24*4)
		self.settingsMaxAngle.gui.Parent = self.settingFrame.gui
		self.settingsMaxAngle.event:Bind(function(value)
			self.data[5] = tonumber(value) or self.data[5]
			self.settingsMaxAngle:Set(self.data[5])
			self.maximumAngleTextBox.Text = self.data[5]
		end)

	end
end

module.ToggleMaterials = function(self)
	if self.frame ~= nil then
		self.frame:Destroy()
		self.frame = nil
		self.gui.Size = UDim2.new(1, 0, 0, 144)
	else
		self.gui.Size = UDim2.new(1, 0, 0, 318)

		self.frame = Instance.new("Frame")
		self.frame.Position = UDim2.new(0, 0, 0, 24)
		self.frame.Size = UDim2.new(1, 0, 0, 174)
		self.frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Dropdown)
		self.frame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)	

		local padding = Instance.new("UIPadding")
		padding.PaddingBottom = UDim.new(0, 8)
		padding.PaddingLeft = UDim.new(0, 8)
		padding.PaddingRight = UDim.new(0, 8)
		padding.PaddingTop = UDim.new(0, 8)
		padding.Parent = self.frame

		local gridLayout = Instance.new("UIGridLayout")
		gridLayout.CellSize = UDim2.new(0.125, -4, 0, 50)
		gridLayout.CellPadding = UDim2.new(0, 4, 0, 4)
		gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		gridLayout.Parent = self.frame

		for i, material in ipairs(G.modules["Data"].materials) do
			local imageButton = Instance.new("ImageButton")
			imageButton.Image = material[2]
			imageButton.ScaleType = Enum.ScaleType.Crop
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
				if material[1] == nil then
					self.event:Call(4)
				else
					self:ToggleMaterials()
					self.data[1] = material[1]
					self.imageButton.Image = material[2]
				end
			end)
			imageButton.Parent = self.frame
		end
		self.frame.Parent = self.indent.gui
	end
end

module.Destroy = function(self)
	self.event:UnBindAll()
	self.gui:Destroy()
end

return module
