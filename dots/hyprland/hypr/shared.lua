local function find_element(tbl, condition_func)
	for key, value in pairs(tbl) do
		if condition_func(value, key) then
			return value, key
		end
	end
	return nil, nil
end

return {
	find_element = find_element,
}
