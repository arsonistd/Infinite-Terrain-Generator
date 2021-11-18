local root = script.Parent.Parent
local G = require(root.G)

local module = {}
module.__index = module

module.New = function(data)
	local object = setmetatable({}, module)
	
	object.event = G.classes["Event"].New()
	object.data = data
	
	object.gui = Instance.new("Frame")
	object.gui.Size = UDim2.new(1, 0, 0, 24)
	object.gui.BackgroundTransparency = 1
	object.gui.BorderSizePixel = 0
	
	local frame = Instance.new("Frame")
	frame.Position = UDim2.new(0, 0, 0, 0)
	frame.Size = UDim2.new(0.06, -1, 0, 24)
	frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	frame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	frame.Parent = object.gui

	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0, 3, 0, 3)
	imageButton.Size = UDim2.new(1, -6, 0.5, -4)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxassetid://7588748905"
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	imageButton.Parent = frame
	imageButton.Activated:Connect(function()
		object.event:Call(1)
	end)

	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0, 3, 0.5, 1)
	imageButton.Size = UDim2.new(1, -6, 0.5, -4)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxassetid://7588749154"
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	imageButton.Parent = frame
	imageButton.Activated:Connect(function()
		object.event:Call(2)
	end)

	local frame = Instance.new("Frame")
	frame.Position = UDim2.new(0.9, 0, 0, 0)
	frame.Size = UDim2.new(0.1, 0, 0, 24)
	frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	frame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	frame.Parent = object.gui

	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0, 3, 0, 3)
	imageButton.Size = UDim2.new(0.5, -6, 0, 18)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxassetid://7588843599"
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	imageButton.Parent = frame
	imageButton.Activated:Connect(function()
		object.event:Call(3)
	end)

	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0.5, 3, 0, 3)
	imageButton.Size = UDim2.new(0.5, -6, 0, 18)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxassetid://7588749786"
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	imageButton.Parent = frame
	imageButton.Activated:Connect(function()
		object.event:Call(4)
	end)
	
	object.imageButton = Instance.new("ImageButton")
	object.imageButton.Position = UDim2.new(0.06, 0, 0, 0)
	object.imageButton.Size = UDim2.new(0.168, -1, 0, 24)
	object.imageButton.ScaleType = Enum.ScaleType.Crop
	object.imageButton.AutoButtonColor = false
	object.imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	object.imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	object.imageButton.Parent = object.gui
	object.imageButton.MouseEnter:Connect(function()
		object.imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	object.imageButton.MouseLeave:Connect(function()
		object.imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		object.imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		object.imageButton.ImageColor3 = Color3.new(1, 1, 1)
	end)
	object.imageButton.MouseButton1Down:Connect(function()
		object.imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Pressed)
		object.imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Pressed)
		object.imageButton.ImageColor3 = Color3.new(0.5, 0.5, 0.5)
	end)
	object.imageButton.MouseButton1Up:Connect(function()
		object.imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		object.imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		object.imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	object.imageButton.Activated:Connect(function()
		object:ToggleMaterials()
	end)
	
	for i, material in ipairs(G.modules["Data"].materials) do
		if material[1] == data[1] then
			object.imageButton.Image = material[2]
			break
		end
	end
	
	local textBox = Instance.new("TextBox")
	textBox.Text = data[2]
	textBox.Position = UDim2.new(0.228, 0, 0, 0)
	textBox.Size = UDim2.new(0.168, -1, 1, 0)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = object.gui
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[2] = tonumber(textBox.Text) or data[2]
		textBox.Text = data[2]
	end)

	local textBox = Instance.new("TextBox")
	textBox.Text = data[3]
	textBox.Position = UDim2.new(0.396, 0, 0, 0)
	textBox.Size = UDim2.new(0.168, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = object.gui
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[3] = tonumber(textBox.Text) or data[3]
		textBox.Text = data[3]
	end)
	
	local textBox = Instance.new("TextBox")
	textBox.Text = data[4]
	textBox.Position = UDim2.new(0.564, 0, 0, 0)
	textBox.Size = UDim2.new(0.168, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = object.gui
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[4] = tonumber(textBox.Text) or data[4]
		textBox.Text = data[4]
	end)
	
	local textBox = Instance.new("TextBox")
	textBox.Text = data[5]
	textBox.Position = UDim2.new(0.732, 0, 0, 0)
	textBox.Size = UDim2.new(0.168, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = object.gui
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[5] = tonumber(textBox.Text) or data[5]
		textBox.Text = data[5]
	end)
	
	return object
end

module.ToggleMaterials = function(self)
	if self.frame ~= nil then
		self.frame:Destroy()
		self.frame = nil
		self.gui.Size = UDim2.new(1, 0, 0, 24)
	else
		self.gui.Size = UDim2.new(1, 0, 0, 198)

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
		self.frame.Parent = self.gui
	end
end

module.Destroy = function(self)
	self.event:UnBindAll()
	self.gui:Destroy()
end

return module
