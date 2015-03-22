
--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        admin.lua
*  PURPOSE:     Server side admin logic
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

--Respawn positions
SpawnPos = {
	lsAirport1 = { x = 1682.55, y = -2327.25, z = -2.67, r = 0}
}

addEvent("admin:spawn:incognito", true)
addEventHandler("admin:spawn:incognito", root, function ()
	outputDebugString("Player "..source.name.." will spawn incognito.")
	local pos = SpawnPos.lsAirport1
	source:fadeCamera(true)
	source:setCameraTarget(source)
	source:spawn(pos.x, pos.y, pos.z, pos.r, 183, 0, 0)
end)

--admin:vehicle
addEvent("admin:vehicle", true)
addEventHandler("admin:vehicle", root, function ( id )
	outputDebugString("Player "..source.name.." will get a vehicle "..id)
	local x, y, z = getElementPosition(source)
	vehicle = Vehicle(id, Vector3(x+4, y, z+0.2)); -- Create a vehicle and spawn it at the middle of SA.
    vehicle:setColor(34, 34, 34); -- Set its color.
    vehicle:setInterior(source.interior, x+4, y, z+0.2)
end)

--giveWeapon
addEvent("admin:weapon", true)
addEventHandler("admin:weapon", root, function ( id )
	outputDebugString("Player "..source.name.." will get a weapon.")
	giveWeapon(source, id, 120)
end)

--login
addEvent("admin:login", true)
addEventHandler("admin:login", root, function ( username, password )
	local account = getAccount(username, password) -- Return the account
	if (account ~= false) then -- If the account exists.
		setPlayerName(source, username)
		logIn(source, account, password) -- Log them in.
		if isObjectInACLGroup ("user."..account.name, aclGetGroup("Admin")) then
			executeCommandHandler("debugscript", source, "3")
			outputDebugString("Logined admin "..account.name)
			triggerClientEvent(source, "admin:onLogin", source, account)
		end
	else
		outputChatBox ( "Wrong username or password!", source, 255, 255, 0 ) -- Output they got the details wrong.
	end
end)

addCommandHandler ( "veh", function ( playerSource, command , parameter )
	triggerEvent("admin:vehicle", playerSource, parameter)
end )

addCommandHandler ( "tpto", function ( playerSource, command, parameter )

	local destPlayer = nil
	for i, player in ipairs(Player.getAllAlive()) do
		if player.name == parameter then
			destPlayer = player
			break
		end
	end
	if destPlayer then
		local x, y, z = destPlayer.position
		playerSource:setPosition(x, y, z)
	end
end )
