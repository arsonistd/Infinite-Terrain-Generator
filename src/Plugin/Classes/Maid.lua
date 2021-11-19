local Maid = {}
Maid.__index = Maid

function Maid.New()
	return setmetatable({}, Maid)
end

function Maid:Add(obj)
  self[#self+1] = obj
end

function Maid:Clean()
	for i,v in pairs(self) do
		if typeof(v) == "RBXScriptConnection" then
			v:Disconnect()
		elseif type(v) == "function" then
			v()
		elseif v.Destroy then
			v:Destroy()
		elseif typeof(v) == "table" then
			for _, cleanupMethod in ipairs({"destroy", "Destroy", "Disconnect"}) do
				if table[cleanupMethod] then
					table[cleanupMethod]()
				end
			end
		end
	end
end

Maid.Destroy = Maid.Clean

return Maid
