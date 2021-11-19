local root = script.Parent.Parent
local G = require(root.G)

local module = {}

module.Init = function()
	local toolbar = G.plugin:CreateToolbar("Terrain")
	local button = toolbar:CreateButton("Infinite Terrain", "Create and edit terrain", "rbxassetid://7588761139")
	local widgetInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 200, 300, 150, 150)
	button.ClickableWhenViewportHidden = true
	button.Click:Connect(function() G.modules["Widget"].window.Enabled = not G.modules["Widget"].window.Enabled end)
	G.modules["Widget"].window = G.plugin:CreateDockWidgetPluginGui("InfiniteTerrain", widgetInfo)
	G.modules["Widget"].window.Title = "Infinite Terrain"
	G.modules["Widget"].window:GetPropertyChangedSignal("Enabled"):Connect(function() if G.modules["Widget"].window.Enabled then button:SetActive(true) else button:SetActive(false) end end)
	
	G.modules["Widget"].frame = Instance.new("Frame")
	G.modules["Widget"].frame.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.Border)
	G.modules["Widget"].frame.BorderSizePixel = 0
	G.modules["Widget"].frame.Size = UDim2.new(1, 0, 0, 60)
	G.modules["Widget"].frame.Parent = G.modules["Widget"].window

	local padding = Instance.new("UIPadding")
	padding.PaddingBottom = UDim.new(0, 4)
	padding.PaddingLeft = UDim.new(0, 4)
	padding.PaddingTop = UDim.new(0, 4)
	padding.Parent = G.modules["Widget"].frame

	local listLayout = Instance.new("UIListLayout")
	listLayout.FillDirection = Enum.FillDirection.Horizontal
	listLayout.Padding = UDim.new(0, 4)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Parent = G.modules["Widget"].frame
end

return module
