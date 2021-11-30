
local module = {}
module.__index = module

module.New = function(data)
	local object = setmetatable({}, module)

	local indent = data["indent"] or 0.03
	local ySizeScale = data["ySizeScale"] or 1
	local ySizeOffset = data["ySizeOffset"] or 0
	local backgroundTransparency = data["backgroundTransparency"] or 1
	local backgroundColor3 = data["backgroundColor3"] or Color3.new(1,1,1)
	local borderColor3 = data["borderColor3"] or Color3.new(1,1,1)
	local borderSizePixel = data["borderSizePixel"] or 0
	local xSizeScale = data["xSizeScale"] or 1

    object.gui = Instance.new("Frame")
	object.gui.Size = UDim2.new((xSizeScale-indent), 0, ySizeScale, ySizeOffset)
	object.gui.Position = data["position"]
	object.gui.BackgroundTransparency = backgroundTransparency
	object.gui.BorderSizePixel = borderSizePixel
	object.gui.Parent = data["parent"]
	object.gui.BorderColor3 = borderColor3
	object.gui.BackgroundColor3 = backgroundColor3
	object.gui.AnchorPoint = Vector2.new(1, 0)

    return object
end

module.Destroy = function(self)
    self.gui:Destroy()
end

return module