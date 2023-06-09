return function(self, perm)
	if type(perm) ~= "string" then
		error("No valid permimssion name given", 2)
	end

	local userID = self:getID()
	local db = _M._I.userDB
	local reason, suc = nil, nil
	local permLevel
	
	debug.ulog("Get perm: userID: " .. tostring(userID) .. ", perm: " .. perm)
	suc = db:exec([[SELECT level FROM permissions WHERE userID = "]] .. tostring(userID) .. [[" AND permission = "]] .. perm .. [["]], function(udata, cols, values, names)
		permLevel = values[1]
		return 0
	end)
	
	if suc == 0 and permLevel ~= nil then
		return true, permLevel
	elseif suc == 0 and permLevel == nil then
		return false, permLevel
	else
		return suc, reason
	end
end