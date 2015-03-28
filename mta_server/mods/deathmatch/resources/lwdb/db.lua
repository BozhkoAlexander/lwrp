--[[ MTA Lost World Role Play, Author: Alexander Bozhko
	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.]]
	
local handler = nil

function connect( res )
	if (res.name ~= "lwdb") then return end
	handler = mysql_connect("localhost", "root", "24Svjatogor93", "lwrp") -- Establish the connection
	if not handler then -- The connection failed
		outputDebugString("Unable to connect to the MySQL server")
	else
		outputDebugString("Connected to MySQL Server")
	end
end
addEventHandler("onResourceStart", getRootElement(), connect)

----------------------OLD PART------------------------------

local function generateSalt()
	local salt = ""
    local length = math.random(5,10) --длина соли (от 5 до 10 сомволов)
    for i = 1, length+1 do
        local ch = string.char(math.random(65,90)) --символ из ASCII-table
		salt = salt..ch
    end
    return salt
end

local function crypt(password, salt)
	if not salt then
		salt = generateSalt()
	end
	return md5(md5(salt)..md5(password)), salt
end

function getUserId(username, email)
	--select userId from lostworlddb.users where username = "Samuel" or `e-mail` = "brunobanany7@yandex.ru"
	local query = "select userId from lostworlddb.users where username = '"..username.."' or `e-mail` = '"..email.."';"
	local result = mysql_query(handler, query)
	if result then
		row = mysql_fetch_row(result)
		if row then
			local user = {}
			user.id = row[1]
			return user
		end
	end
end

function createUser(username, email, password)
	--INSERT INTO `lostworlddb`.`users` (`username`, `e-mail`, `password`) VALUES ('Sam', 'alexander.s.bozhko@gmail.com', '24Svjatogor93');
	local cryptPass, salt = crypt(password)
	local query = "INSERT INTO `lostworlddb`.`users` (`username`, `e-mail`, `password`, `salt`, `createdAt`) VALUES ('"..username.."', '"..email.."', '"..cryptPass.."', '"..salt.."', NOW())"
	local result = mysql_query(handler, query)
	if (not result) then
		outputDebugString("Error executing the query: ("..mysql_errno(handler)..") "..mysql_error(handler))
		return false
	else
		mysql_free_result(result) -- Freeing the result is IMPORTANT
		return true
	end
end 

function loginUser(username, password)
	--select salt from lostworlddb.users where username like 'Sam'
	local query = "select salt from lostworlddb.users where username like '"..username.."';"
	local result = mysql_query(handler, query)
	if result then
		local row = mysql_fetch_row(result)
		if row then
			mysql_free_result(result) -- Free the result
			local cryptPass = crypt(password, row[1])
			--select * from lostworlddb.users where username like 'Sam' and password like '691E184C74C2316ADA903EC37732A2A0'
			query = "select * from lostworlddb.users where username like '"..username.."' and password like '"..cryptPass.."';"
			result = mysql_query(handler, query)
			if result then
				row = mysql_fetch_row(result)
				if row then
					local user = {}
					user.id = row[1]
					user.name = row[2]
					user.email = row[3]
					setUserStatus(user.id, 1)
					outputDebugString("Login: "..user.name..", e-mail: "..user.email..", id: "..user.id)
					return user
				end
			end
		end
	end
end

function setUserStatus(userId, status)
	--UPDATE `lostworlddb`.`users` SET `status`='1' WHERE `userId`='3';
	local query = "UPDATE `lostworlddb`.`users` SET `status`='"..status.."' WHERE `userId`='"..userId.."';"
	local result = mysql_query(handler, query)
	if (not result) then
		outputDebugString("Error executing the query: ("..mysql_errno(handler)..") "..mysql_error(handler))
		return false
	else
		mysql_free_result(result) -- Freeing the result is IMPORTANT
		return true
	end
end

function getPlayerFromUserId(userId)
	--select * from lostworlddb.players where userId = 3;
	local query = "select * from lostworlddb.players where userId = "..userId..";"
	local result = mysql_query(handler, query)
	if result then
		local row = mysql_fetch_row(result)
		if row then
			local player = {}
			player.id = row[1]
			player.userId = row[2]
			player.firstName = row[3]
			player.lastName = row[4]
			player.sex = row[5]
			player.createdAt = row[6]
			player.xp = row[7]
			player.pos = {}
			player.pos.x = row[8]
			player.pos.y = row[9]
			player.pos.z = row[10]
			player.pos.r = row[11]
			player.hp = row[12]
			player.armor = row[13]
			player.skin = row[14]
			player.money = row[15]
			player.wStyle = row[16]
			outputDebugString("TO REMOVE: Player: "..player.firstName.." "..player.lastName..", userId: "..player.userId..", id: "..player.id)
			return player
		end
	end
end

function createPlayer(data)
	--[[characterData:
	userId
	firstName
	lastName
	sex: 1-male, 0-female
	pos.x, pos.y, pos.z, pos.r
	skin
	wStyle
	]]
	local query = "insert into `lostworlddb`.`players` (`userId`, `firstName`, `lastName`, `sex`, `posX`, `posY`, `posZ`, `posR`, `skin`, `walkingStyle`) values ('"
				..data.userId.."', '"..data.firstName.."', '"..data.lastName.."', '"..data.sex.."', '"..data.pos.x.."', '"..data.pos.y.."', '"..data.pos.z.."', '"..data.pos.r.."', '"..data.skin.."', '"..data.wStyle.."');"
	local result = mysql_query(handler, query)
	if (not result) then
		outputDebugString("Error executing the query: ("..mysql_errno(handler)..") "..mysql_error(handler))
		return false
	else
		mysql_free_result(result) -- Freeing the result is IMPORTANT
		return true
	end
end

----------------------------------------------------

function getPlayer( username )
	--select * from `player` where username like 'Samuel';
	local query = "select * from `player` where username like '"..username.."';"
	local result = mysql_query(handler, query)
	if result then
		local row = mysql_fetch_row(result)
		if row then
			local  character = {}
			character.id = row[1]
			character.username = row[2]
			character.firstname = row[3]
			character.lastname = row[4]
			character.gametime = row[5]
			character.sex = row[6]
			character.nation = row[7]
			character.pos = {}
			character.pos.x = row[8]
			character.pos.y = row[9]
			character.pos.z = row[10]
			character.pos.r = row[11]
			character.skin = row[12]
			outputDebugString("Found character "..character.firstname.." "..character.lastname)
			return character
		end
	end
end

function savePlayerData( playerId, gametime, posX, posY, posZ, posR, skin )
	--update lwrp.player set gametime = 1, posX = 1682.55, posY = -2327.25, posZ = -2.67, posR = 0, skinId = 183 where playerId = 1;
	local query = "update lwrp.player set gametime = "..gametime..", posX = "..posX..", posY = "..posY..", posZ = "..posZ..", posR = "..posR..", skinId = "..skin.." where playerId = "..playerId..";"
	local result = mysql_query(handler, query)
	if (not result) then
		outputDebugString("Error executing the query: ("..mysql_errno(handler)..") "..mysql_error(handler))
		return false
	else
		mysql_free_result(result) -- Freeing the result is IMPORTANT
		return true
	end
end