local root = script.Parent.Parent
local G = require(root.G)

local module = {}

module.Start = function()
    local widgetButton = G.classes["WidgetButton"].New("Biomes", "rbxassetid://8037148392", 3)
    local widgetPage = G.classes["WidgetPage"].New()
    local maid = G.classes["Maid"].New()

    local biomesGroup = G.classes["Group"].New("Biomes", widgetPage.scrollingFrame)

    local addBiomeBtn = G.classes["Button"].New("Add biome", biomesGroup.gui)
    addBiomeBtn.event:Bind(function()
        
    end)

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