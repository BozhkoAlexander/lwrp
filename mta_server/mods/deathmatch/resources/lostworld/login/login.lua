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
	
local registerData = {}

addEvent("findUser", true)
addEventHandler("findUser", getRootElement(),
function (thePlayer, username, email)
	local result = getUserId(username, email)
	triggerClientEvent("onRegisterDataChecked", thePlayer, result)
end
)

addEvent("regsiterNewUser", true)
addEventHandler("regsiterNewUser", getRootElement(),
function (thePlayer, username, email, password)
	local result = createUser(username, email, password)
	triggerClientEvent("onUserCreated", thePlayer, result)
end
)

addEvent("loginUser", true)
addEventHandler("loginUser", getRootElement(),
function (thePlayer, username, password)
	if not username or not password then return end
	local user = loginUser(username, password)
	triggerClientEvent("onUserLogined", thePlayer, user)
end
)

addEvent("logoffUser", true)
addEventHandler("logoffUser", getRootElement(),
function (thePlayer, userData)
	if not userData then return end
	setUserStatus(userData.id, 0)
	removePlayer(thePlayer)
end)

addEvent("getPlayer", true)
addEventHandler("getPlayer", getRootElement(),
function (thePlayer, user)
	local player = getPlayerFromUserId(user.id)
	triggerClientEvent("onGetPlayerFinished", thePlayer, player)
end)