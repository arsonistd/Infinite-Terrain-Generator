local module = {}

module.Round = function(value, decimals)
	local mult = 10 ^ (decimals or 0)
	return math.round(value * mult) / mult
end

module.Clone = function(original)
	if typeof(original) ~= "table" then return original end
	local clone = {}
	for key, value in pairs(original) do clone[key] = module.Clone(value) end
	return clone
end

return module
