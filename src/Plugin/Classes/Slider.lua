local root = script.Parent.Parent
local G = require(root.G)

local Slider = {}
Slider.__index = Slider


function Slider.new(label, parent, min, max, default, doRound)
    local self = setmetatable({}, Slider)

    self.label = label or ""
    self.parent = parent
    self.min = min or 1
	self.max = max or 60
	self.doRound = doRound or false
	self.default = default or 1

    self.gui = Instance.new("Frame")
    self.nameLabel = Instance.new("TextLabel")
    self.sliderFrame = Instance.new("Frame")
    self.textBox = Instance.new("TextBox")

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

    self:Init()

    return self
end

function Slider:Init()
    self.gui.Size = UDim2.new(1, 0, 0, 24)
	self.gui.BackgroundTransparency = 1
	self.gui.BorderSizePixel = 0
	if self.parent then
		self.gui.Parent = self.parent
	end

    self.nameLabel.Text = self.label
	self.nameLabel.Font = Enum.Font.Arial
	self.nameLabel.TextSize = 12
	self.nameLabel.Position = UDim2.new(0, 0, 0, 0)
	self.nameLabel.Size = UDim2.new(0, 120, 1, 0)
	self.nameLabel.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	self.nameLabel.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	self.nameLabel.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	self.nameLabel.LayoutOrder = 1
	self.nameLabel.Parent = self.gui

	self.sliderFrame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	self.sliderFrame.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	self.sliderFrame.Position = UDim2.new(0, 120, 0, 0)
	self.sliderFrame.Size = UDim2.new(1, -121, 1, 0)
	self.sliderFrame.LayoutOrder = 2
	self.sliderFrame.Parent = self.gui

    self.textBox.Text = self.default
	self.textBox.Font = Enum.Font.Arial
	self.textBox.TextSize = 12
	self.textBox.Position = UDim2.new(1, 0, 0, 0)
	self.textBox.Size = UDim2.new(0, 40, 1, 0)
	self.textBox.AnchorPoint = Vector2.new(1, 0)
	self.textBox.ClearTextOnFocus = false
	self.textBox.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Item)
	self.textBox.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	self.textBox.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
	self.textBox.LayoutOrder = 3
	self.textBox.Parent = self.sliderFrame
end


function Slider:Destroy()
    
end


return Slider