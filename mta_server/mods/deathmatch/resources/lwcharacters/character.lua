--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        character.lua
*  PURPOSE:     Managing of characters
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

addEventHandler("onResourceStart", getRootElement(), function ( startedRes )
	if (getResourceName(startedRes) ~= "lwcharacters") then return end
	local allive = Player.getAllAlive()
	for i,player in ipairs(allive) do
		fetchPlayer(player)
	end
	local dead = Player.getAllDead()
	for i,player in ipairs(dead) do
		fetchPlayer(player)
	end
end)

addEventHandler("onResourceStop", getRootElement(), function ( startedRes )
	if (getResourceName(startedRes) ~= "lwcharacters") then return end
	local allive = Player.getAllAlive()
	for i,player in ipairs(allive) do
		savePlayer(player)
	end
	local dead = Player.getAllDead()
	for i,player in ipairs(dead) do
		savePlayer(player)
	end
end)

--triggerEvent("character:onLogin", source, character)
addEvent("character:onLogin", false)
addEventHandler("character:onLogin", getRootElement(), function ( character )
	characters[character.username] = character
	outputDebugString("Startup setting for character "..character.firstname.." "..character.lastname.." ")
	source:spawn(character.pos.x, character.pos.y, character.pos.z, character.pos.r, character.skin, 0, 0) -- spawns player with random skin
	fadeCamera (source, true)
	setCameraTarget (source, source)
end)

addEventHandler ( "onPlayerQuit", getRootElement(), function ( quitType )
	savePlayer(source)
	local character = characters[source.name]
	characters[source.name] = nil
	outputDebugString("Now online "..#characters.." characters.")
end )

function savePlayer( source )
	local character = characters[source.name]
	if not character then return end
	character.pos.x = source.position.x
	character.pos.y = source.position.y
	character.pos.z = source.position.z
	character.pos.r = source.rotation.z
	exports.lwdb:savePlayerData( character.id, character.gametime, character.pos.x, character.pos.y, character.pos.z, character.pos.r, character.skin )
	outputDebugString("Character "..character.firstname.." "..character.lastname.." saved.")
end

function fetchPlayer( source )
	local character = exports.lwdb:getPlayer(source.name)
	characters[source.name] = character
	outputDebugString("Character "..character.firstname.." "..character.lastname.." fetched.")
	return character
end