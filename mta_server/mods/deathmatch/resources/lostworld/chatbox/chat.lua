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
	
function sendChatMessage(thePlayer, message)
	triggerClientEvent(thePlayer, "chat:message", thePlayer, message)
end

function messageGeneration(message, player)
	local name = "Система"
	if player and getElementType(player) == "player" then
		name = getPlayerName(player)
	end
	return name..": "..message
end

function sendMessage(message)
	alivePlayers = getAlivePlayers()
	if alivePlayers then
		for playerKey, playerValue in ipairs(alivePlayers) do
			sendChatMessage(playerValue, messageGeneration(message, source))
		end
	end
end
addEvent("chat:send", true)
addEventHandler("chat:send", getRootElement(), sendMessage)