debug.setFuncPrefix("[DB]")
dlog("Prepare login DB")

local db, err = _M._I.lib.sqlite.open(_M._I.devConf.userDatabasePath)
local createSysinfoEntry = true

ldlog(db, err)

dlog("Create sysinfo table: " .. tostring(db:exec([[
	CREATE TABLE sysinfo (
		userCount INTEGER NOT NULL
	);
]])))

dlog("Create users table: " .. tostring(db:exec([[
	CREATE TABLE users (
		username TEXT NOT NULL,
		password TEXT NOT NULL,
		id INTEGER NOT NULL
	);
]])))

dlog("Create permissions table: " .. tostring(db:exec([[
	CREATE TABLE permissions (
		userID INTEGER NOT NULL,
		permission TEXT NOT NULL,
		level INTEGER NOT NULL
	);
]])))

dlog("Create sessions table: " .. tostring(db:exec([[
	CREATE TABLE sessions (
		sessionID TEXT NOT NULL,
		token TEXT NOT NULL,
		creationTime INTEGER NOT NULL,
		expireTime INTEGER NOT NULL,
		userID INTEGER NOT NULL,
		name TEXT NOT NULL,
		note TEXT NOT NULL,
		userAgent TEXT NOT NULL,
		createdAutomatically INTEGER NOT NULL,
		status INTEGER NOT NULL,
		deletionTime INTEGER NOT NULL
	);
]])))


dlog("Prepare sysinfo table: " .. tostring(_M._I.userDB:exec([[
	SELECT userCount FROM sysinfo
]], function(udata,cols,values,names)
	for i=1,cols do 
		if names[i] == "userCount" then
			createSysinfoEntry = false
		end
	end
	return 0
end)))

if createSysinfoEntry then
	dlog("Create sysinfo entry: " .. tostring(db:exec([[INSERT INTO sysinfo VALUES (0);]])))
end

db:close()