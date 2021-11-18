local root = script.Parent.Parent
local G = require(root.G)
local labels = {"Noise", "Position X", "Position Y", "Position Z", "Size", "Size X", "Size Y", "Size Z", "Rotation X", "Rotation Y", "Rotation Z"}

local module = {}
module.__index = module

module.New = function(data)
	local object = setmetatable({}, module)
	
	object.event = G.classes["Event"].New()
	object.data = data
	
	object.gui = Instance.new("Frame")
	object.gui.Size = UDim2.new(1, 0, 0, 0)
	object.gui.BackgroundTransparency = 1
	object.gui.BorderSizePixel = 0
	
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 1)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Parent = object.gui
	listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		object.gui.Size = UDim2.new(1, 0, 0, listLayout.AbsoluteContentSize.Y)
	end)
	
	local topframe = Instance.new("Frame")
	topframe.Size = UDim2.new(1, 0, 0, 24)
	topframe.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	topframe.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	topframe.Parent = object.gui
	
	object.frame = Instance.new("Frame")
	object.frame.Size = UDim2.new(1, 0, 0, 0)
	object.frame.BackgroundTransparency = 1
	object.frame.BorderSizePixel = 0
	object.frame.Visible = false
	object.frame.Parent = object.gui

	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 1)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Parent = object.frame
	listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		object.frame.Size = UDim2.new(1, 0, 0, listLayout.AbsoluteContentSize.Y)
	end)

	
	local frame = Instance.new("Frame")
	frame.Position = UDim2.new(0, 0, 0, 0)
	frame.Size = UDim2.new(0.06, -1, 0, 24)
	frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	frame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	frame.Parent = topframe

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
	frame.Position = UDim2.new(0.85, 0, 0, 0)
	frame.Size = UDim2.new(0.15, 0, 0, 24)
	frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	frame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	frame.Parent = topframe
	
	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0, 3, 0, 3)
	imageButton.Size = UDim2.new(0.333, -6, 0, 18)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxassetid://7589826586"
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	imageButton.Parent = frame
	imageButton.Activated:Connect(function()
		object.frame.Visible = not object.frame.Visible
	end)

	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0.333, 3, 0, 3)
	imageButton.Size = UDim2.new(0.333, -6, 0, 18)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxassetid://7588843599"
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	imageButton.Parent = frame
	imageButton.Activated:Connect(function()
		object.event:Call(3)
	end)

	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0.666, 3, 0, 3)
	imageButton.Size = UDim2.new(0.333, -6, 0, 18)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxassetid://7588749786"
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	imageButton.Parent = frame
	imageButton.Activated:Connect(function()
		object.event:Call(4)
	end)
	
	
	local textBox = Instance.new("TextBox")
	textBox.Text = data[1]
	textBox.Position = UDim2.new(0.06, 0, 0, 0)
	textBox.Size = UDim2.new(0.14, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = topframe
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
		data[1] = textBox.Text
	end)
	
	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[2])
	textBox.Position = UDim2.new(0.2, 0, 0, 0)
	textBox.Size = UDim2.new(0.13, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = topframe
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
	textBox.Text = tonumber(data[3])
	textBox.Position = UDim2.new(0.33, 0, 0, 0)
	textBox.Size = UDim2.new(0.13, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = topframe
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
	textBox.Text = tonumber(object.data[4])
	textBox.Position = UDim2.new(0.46, 0, 0, 0)
	textBox.Size = UDim2.new(0.13, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = topframe
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
	textBox.Text = tonumber(object.data[5])
	textBox.Position = UDim2.new(0.59, 0, 0, 0)
	textBox.Size = UDim2.new(0.13, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = topframe
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
	
	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[6])
	textBox.Position = UDim2.new(0.72, 0, 0, 0)
	textBox.Size = UDim2.new(0.13, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = topframe
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
		data[6] = tonumber(textBox.Text) or data[6]
		textBox.Text = data[6]
	end)
	
	local frame = Instance.new("Frame")
	frame.Position = UDim2.new(0, 0, 0, 0)
	frame.Size = UDim2.new(1, 0, 0, 24)
	frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground)
	frame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	frame.Parent = object.frame

	local textButton = Instance.new("TextButton")
	textButton.Text = "N"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0, 3, 0, 3)
	textButton.Size = UDim2.new(0.1, -6, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({1, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.04, 0, 10})
	end)
	
	local textButton = Instance.new("TextButton")
	textButton.Text = "PX"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.1, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({2, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 0, 10})
	end)

	local textButton = Instance.new("TextButton")
	textButton.Text = "PY"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.19, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({3, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 0, 10})
	end)

	local textButton = Instance.new("TextButton")
	textButton.Text = "PZ"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.28, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({4, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 0, 10})
	end)

	local textButton = Instance.new("TextButton")
	textButton.Text = "S"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.37, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({5, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 1, 1})
	end)

	local textButton = Instance.new("TextButton")
	textButton.Text = "SX"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.46, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({6, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 1, 1})
	end)
	
	local textButton = Instance.new("TextButton")
	textButton.Text = "SY"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.55, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({7, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 1, 1})
	end)
	

	local textButton = Instance.new("TextButton")
	textButton.Text = "SZ"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.64, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({8, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 1, 1})
	end)

	local textButton = Instance.new("TextButton")
	textButton.Text = "RX"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.73, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({9, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 0, 360})
	end)
	
	local textButton = Instance.new("TextButton")
	textButton.Text = "RY"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.82, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({10, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 0, 360})
	end)

	local textButton = Instance.new("TextButton")
	textButton.Text = "RZ"
	textButton.Font = Enum.Font.Arial
	textButton.TextSize = 12
	textButton.Position = UDim2.new(0.91, 0, 0, 3)
	textButton.Size = UDim2.new(0.09, -3, 0, 18)
	textButton.AutoButtonColor = false
	textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button)
	textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder)
	textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText)
	textButton.Parent = frame
	textButton.MouseEnter:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.MouseLeave:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Default)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
	end)
	textButton.MouseButton1Down:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Pressed)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Pressed)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Pressed)
	end)
	textButton.MouseButton1Up:Connect(function()
		textButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Hover)
		textButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonBorder, Enum.StudioStyleGuideModifier.Hover)
		textButton.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textButton.Activated:Connect(function()
		object:AddNoiseData({11, G.modules["Functions"].Round(math.random(10000, 99999) + math.random(), 3), 0.08, 0, 360})
	end)
	
	for i, noise in ipairs(data[7]) do
		object:AddNoise(noise)
	end
	
	return object
end

module.AddNoiseData = function(self, data)
	table.insert(self.data[7], data)
	self:AddNoise(data)
end

module.AddNoise = function(self, data)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 24)
	frame.Parent = self.frame
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Text = labels[data[1]]
	textLabel.Position = UDim2.new(0, 0, 0, 0)
	textLabel.Size = UDim2.new(0.19, -1, 1, 0)
	textLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground)
	textLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textLabel.Parent = frame
	
	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[2])
	textBox.Position = UDim2.new(0.19, 0, 0, 0)
	textBox.Size = UDim2.new(0.19, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = frame
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[2] = tonumber(textBox.Text) or data[2]
		textBox.Text = data[2]
	end)

	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[3])
	textBox.Position = UDim2.new(0.38, 0, 0, 0)
	textBox.Size = UDim2.new(0.19, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = frame
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[3] = tonumber(textBox.Text) or data[3]
		textBox.Text = data[3]
	end)

	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[4])
	textBox.Position = UDim2.new(0.57, 0, 0, 0)
	textBox.Size = UDim2.new(0.19, -1, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = frame
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[4] = tonumber(textBox.Text) or data[4]
		textBox.Text = data[4]
	end)

	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[5])
	textBox.Position = UDim2.new(0.76, 0, 0, 0)
	textBox.Size = UDim2.new(0.19, 0, 0, 24)
	textBox.ClearTextOnFocus = false
	textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground)
	textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	textBox.Parent = frame
	textBox.MouseEnter:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Hover)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Hover)
	end)
	textBox.MouseLeave:Connect(function()
		textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Default)
		textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
	end)
	textBox.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
		data[5] = tonumber(textBox.Text) or data[5]
		textBox.Text = data[5]
	end)
	
	local imageButton = Instance.new("ImageButton")
	imageButton.Position = UDim2.new(0.95, 0, 0, 0)
	imageButton.Size = UDim2.new(0.05, 0, 0, 24)
	imageButton.ScaleType = Enum.ScaleType.Fit
	imageButton.Image = "rbxasset://textures/CollisionGroupsEditor/delete.png"
	imageButton.AutoButtonColor = false
	imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground)
	imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	imageButton.Parent = frame
	imageButton.MouseEnter:Connect(function()
		imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Hover)
		imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	imageButton.MouseLeave:Connect(function()
		imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Default)
		imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Default)
		imageButton.ImageColor3 = Color3.new(1, 1, 1)
	end)
	imageButton.MouseButton1Down:Connect(function()
		imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Pressed)
		imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Pressed)
		imageButton.ImageColor3 = Color3.new(0.5, 0.5, 0.5)
	end)
	imageButton.MouseButton1Up:Connect(function()
		imageButton.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Hover)
		imageButton.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border, Enum.StudioStyleGuideModifier.Hover)
		imageButton.ImageColor3 = Color3.new(0.75, 0.75, 0.75)
	end)
	imageButton.Activated:Connect(function()
		local key = nil
		for i, object in ipairs(self.data[7]) do if data == object then key = i break end end
		table.remove(self.data[7], key)
		frame:Destroy()
	end)
end

module.Destroy = function(self)
	self.event:UnBindAll()
	self.gui:Destroy()
end

return module
