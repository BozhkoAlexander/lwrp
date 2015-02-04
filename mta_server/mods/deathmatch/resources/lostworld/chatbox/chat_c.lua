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
	
local numberOfLines = 15
local lineH = 12
local width, height = 500, numberOfLines*lineH
local font = "default"
local labels = {}

local chatboxView = nil
local eTarget = nil

function initChatBox()
	showChat(false)
	
	chatboxView = createLWScrollView(5, 5, width, height, nil, nil, "chatbox")
	chatboxView.contentView.color = createColor(0, 0, 0, 100)
	chatboxView.visible = false
	chatboxView.scroll.visible = false
	
	eTarget = createTarget(5, height+10,width, 25, "etarget")
	eTarget.visible = false
	eTarget.editbox = createEditBox(0, 0, eTarget.w, eTarget.h, eTarget, "editbox")
	eTarget.editbox.color = createColor(0, 0, 0, 200)
	eTarget.editbox.label.color = lwColors.lwBlue
	
	chatMessage("Добро пожаловать на Lost World Role Play!")
	chatMessage("Сервер находится в разработке.")
end
addEventHandler("onClientResourceStart", getRootElement(), initChatBox)

function setChatBoxVisible(visible)
	chatboxView.visible = visible
	showCursor(isInputEnabled())
end

-- show message into chat
function chatMessage(message)
	local hour, minutes = getTime()
	text = "["..hour..":"..minutes.."]: "..message
	local label = createLabel(3, (3*(#labels+1)+lineH*#labels), chatboxView.w - 10, lineH, chatboxView, text)
	label.color = lwColors.lwBlue
	label.alignX = "left"
	label.alignY = "top"
	labels[#labels+1] = label
	if label.y+label.h+3 > chatboxView.h then
		chatboxView.contentView.h = label.y+label.h+3
	else
		chatboxView.contentView.h = chatboxView.h
	end
	triggerEvent("onScrolled", getRootElement(), chatboxView, 0, chatboxView.y+chatboxView.h)
end
addEvent("chat:message", true)
addEventHandler("chat:message", localPlayer, chatMessage)

function sendMessage(message)
	if #message > 0 then
		triggerServerEvent("chat:send", localPlayer, message)
	end
end

function toggleInput(state)
	if playerState ~= 1 then return end
	
	eTarget.visible = state
	if state then
		setInputedEditBox(eTarget.editbox)
	else
		setInputedEditBox()
	end
	showCursor(state)
	guiSetInputEnabled(state)
end

function playerPressedKey(button, press)
    if button == "t" and not press and chatboxView.visible then
		toggleInput(true)
	elseif eTarget.editbox.inputed and button == "enter" and press then
		sendMessage(eTarget.editbox.label.text)
		eTarget.editbox.label.text = ""
		toggleInput(false)
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

