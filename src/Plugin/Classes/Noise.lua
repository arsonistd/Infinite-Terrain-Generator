local root = script.Parent.Parent
local G = require(root.G)

local module = {}
module.__index = module

function module.New(data)
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
	
	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[1])
	textBox.Position = UDim2.new(0.06, 0, 0, 0)
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
		data[1] = tonumber(textBox.Text) or data[1]
		textBox.Text = data[1]
	end)
	
	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(object.data[2])
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
	textBox.Text = tonumber(data[3])
	textBox.Position = UDim2.new(0.396, 0, 0, 0)
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
		data[3] = tonumber(textBox.Text) or data[3]
		textBox.Text = data[3]
	end)
	
	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[4])
	textBox.Position = UDim2.new(0.564, 0, 0, 0)
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
		data[4] = tonumber(textBox.Text) or data[4]
		textBox.Text = data[4]
	end)
	
	local textBox = Instance.new("TextBox")
	textBox.Text = tonumber(data[5])
	textBox.Position = UDim2.new(0.732, 0, 0, 0)
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
		data[5] = tonumber(textBox.Text) or data[5]
		textBox.Text = data[5]
	end)
	
	return object
end

function module:Init()
	
end

function module:Destroy()
	self.event:UnBindAll()
	self.gui:Destroy()
end

return module
