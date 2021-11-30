local root = script.Parent.Parent
local G = require(root.G)

local Slider = {}
Slider.__index = Slider

Slider.New = function(label, parent, min, max, default, round, snapping)
    local self = setmetatable({}, Slider)

	self._maid = G.classes["Maid"].New()

	self.event = G.classes["Event"].New()

	self.label = label or ""
	self.parent = parent
	self.min = min or 1
	self.max = max or 5
	self.round = round or 0
	self.default = default or 1
	self.snapping = snapping or false

	self.mouseBtnPressed = false

	self.gui = Instance.new("Frame")
	self.nameLabel = Instance.new("TextLabel")
	self.sliderFrame = Instance.new("Frame")
	self.sliderLine = Instance.new("Frame")
	self.sliderDragger = Instance.new("TextButton")
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

Slider.Init = function(self)
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
	self.sliderFrame.Position = UDim2.new(0, 121, 0, 0)
	self.sliderFrame.Size = UDim2.new(1, -121, 1, 0)
	self.sliderFrame.LayoutOrder = 2
	self.sliderFrame.Parent = self.gui

	self.sliderLine.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ScrollBarBackground)
	self.sliderLine.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	self.sliderLine.Size = UDim2.new(1, -60, 0, 4)
	self.sliderLine.Position = UDim2.new(0, 10, 0.5, 0)
	self.sliderLine.AnchorPoint = Vector2.new(0, 0.5)
	self.sliderLine.Parent = self.sliderFrame

	self.sliderDragger.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ScrollBar)
	self.sliderDragger.BorderColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	self.sliderDragger.Size = UDim2.new(0, 6, 0, 18)
	self.sliderDragger.Position = UDim2.new(0, 0, 0.5, 0)
	self.sliderDragger.AnchorPoint = Vector2.new(0.5, 0.5)
	self.sliderDragger.Text = ""
	self.sliderDragger.AutoButtonColor = false
	self.sliderDragger.Parent = self.sliderLine

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
		local newValue = tonumber(self.textBox.Text) or self.default
		if self.round ~= 0 then newValue = G.modules["Functions"].Round(newValue, self.round) end
		if self.min > newValue then newValue = math.clamp(newValue, self.min, math.huge) end
		self.textBox.Text = newValue

		local xScalePos = self.textBox.Text/self.max
		self:Set(xScalePos)
		self.event:Call(self.textBox.Text)
	end)

	local detectMouseMoving
	local function startDetectingMouseMovement(input)
		detectMouseMoving = game:GetService("RunService").Heartbeat:Connect(function()
			if self.mouseBtnPressed then
				local mousePos = input.Position.X
				local sliderLine = self.sliderLine
				local frameSize = sliderLine.AbsoluteSize.X-- + (sliderLine.AbsoluteSize.X/2)
				local framePosition = sliderLine.AbsolutePosition.X-- + (sliderLine.AbsoluteSize.X)
				local xOffset = mousePos - framePosition
				local clampedXOffset = math.clamp(xOffset, 0, frameSize) -- Makes sure the dragger doesnt fall off the sliderFrame
				local xScalePos = (clampedXOffset) / frameSize
				self:Set(xScalePos)
			end
		end)
	end

	self.sliderDragger.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self.sliderDragger.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ScrollBar, Enum.StudioStyleGuideModifier.Pressed)
			self.mouseBtnPressed = true
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			if detectMouseMoving == nil then
				startDetectingMouseMovement(input)
			end
		end
	end)
	self.sliderDragger.InputEnded:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self.sliderDragger.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.ScrollBar, Enum.StudioStyleGuideModifier.Default)
			self.mouseBtnPressed = false
			if detectMouseMoving then
				detectMouseMoving:Disconnect()
				detectMouseMoving = nil
			end
			self.event:Call(self.textBox.Text)
		end
	end)
	self._maid:Add(function()
		if detectMouseMoving then
			detectMouseMoving:Disconnect()
			detectMouseMoving = nil
		end
	end)
	
	self.sliderLine.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self.mouseBtnPressed = true
			local mousePos = input.Position.X
			local sliderLine = self.sliderLine
			local offset = sliderLine.AbsolutePosition.X-mousePos
			local scale = offset/self.sliderLine.AbsoluteSize.X
			local xScalePos = math.abs(scale)
			self:Set(xScalePos)
			startDetectingMouseMovement(input)
		end
	end)
	self.sliderLine.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			self.mouseBtnPressed = false
			if detectMouseMoving then
				detectMouseMoving:Disconnect()
				detectMouseMoving = nil
			end
			self.event:Call(self.textBox.Text)
		end
	end)

	self:Set(math.clamp(self.default/self.max, self.min, self.max))
end



Slider.Set = function(self, value)
	local minValue = self.min
	local maxValue = self.max

	local decimalValue = G.modules["Functions"].Round(value, 2)
	local clampedDecimalValue = math.clamp(decimalValue, 0, 1) 
	local newValue = minValue+(maxValue-minValue)*decimalValue
	
	self.value = maxValue*decimalValue

	if self.round ~= nil then newValue = G.modules["Functions"].Round(newValue, self.round) end
	
	local sliderScale = clampedDecimalValue
	if self.snapping then
		local decimalValue = value
		local newValue = maxValue*decimalValue
		local roundedValue = G.modules["Functions"].Round(newValue, self.round)
		sliderScale = roundedValue/maxValue
	end

	self.sliderDragger.Position = UDim2.new(sliderScale, 0, 0.5, 0)
	self.textBox.Text = newValue
end

Slider.Increment = function(self, increment) 
	local maxValue = self.max

	local newValue = self.value+increment
	print(newValue)
	if self.round ~= nil then newValue = G.modules["Functions"].Round(newValue, self.round) end
	local xScalePos = newValue/maxValue
	local clampedxScalePosScalePos = math.clamp(xScalePos, 0, 1) 

	self:Set(clampedxScalePosScalePos)
end


Slider.Destroy = function(self)
    self._maid:Destroy()
end


return Slider
