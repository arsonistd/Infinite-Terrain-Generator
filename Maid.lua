local Maid = {}
Maid.__index = Maid

function Maid.New()
	return setmetatable({}, {self._objs})
end

function Maid:Add(obj)
  self._objs[#self.objs+1] = obj
end

function Maid:Clean()
	for i,v in pairs(self.objs) do
		if type(v) = "RBXScriptConnection" then
			v:Disconnect()
		elseif type(v) = "function" then
			v()
		elseif v.Destroy then
			v:Destroy()
		elseif type(v) == "Table" then
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
