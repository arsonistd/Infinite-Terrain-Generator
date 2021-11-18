local root = script.Parent.Parent
local G = require(root.G)

local module = {}

module.Initiate = function()
    local widgetButton = G.classes["WidgetButton"].New("Biomes", "rbxassetid://3078999048", 3)
    local widgetPage = G.classes["WidgetPage"].New()

    widgetButton:Activated(function()
        widgetButton:Select()
		widgetPage:Show()
    end)

    widgetButton.selected:Bind(function()
        print("Biomes page opened!")
    end)

    widgetButton.deselected:Bind(function()
        print("Biomes page closed")
    end)

end

return module