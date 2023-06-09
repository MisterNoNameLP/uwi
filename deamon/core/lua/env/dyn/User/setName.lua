return function(self, username)
    local userID = self:getID()
    local db = _M._I.userDB
    local suc, reason

    if _M._I.User.getIDByName(username) then
        debug.ulog("Tryed to set username. But username is already taken: userID: " .. tostring(userID) .. ", new name: " .. username)
        suc = -101
        reason = "Username already taken"
    else
        debug.ulog("Set new username: userID: " .. tostring(userID) .. ", new name: " .. username)
        suc = db:exec([[UPDATE users SET username = "]] .. username .. [[" WHERE id = ]] .. tostring(userID))
    end

    return suc, reason
end