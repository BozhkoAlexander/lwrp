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
	
local oldX, oldY = 0, 0
local scrW, scrH = guiGetScreenSize()
local backspaceToggle = 0
local keyCursor = {}

local function toColor(color)
	if not color then return toColor(Colors.gray) end
	return tocolor(color.r, color.g, color.b, color.a)
end

function isHighlighted(view, x, y)
	if not x or not y then
		local x, y = getCursorPosition()
		local scrW, scrH = guiGetScreenSize()
		x, y = x*scrW, y*scrH
	end
	local absX = view.target.x + view.x
	local absY = view.target.y + view.y
	return view.visible and x >= absX and x <= absX+view.w and y >= absY and y <= absY+view.h
end

local function mouseMoved(x, y)
	for key, target in pairs(dxGUItargets) do
		if target.visible then
			if target.class == "scrollView" and target.scrolled then
				triggerEvent("onScrolled", getRootElement(), target, x, y)
			end
			for k, view in pairs(target.views) do
				if isHighlighted(view, x, y) then
					setState(view, State.highlighted)
				else 
					setState(view, State.normal)
				end
			end
		end
	end
end

local function removeLastCharacter(inputText)
	if string.len(inputText) > 0 then
		if string.len(inputText) > 1 then
			local code = string.byte(string.sub(inputText, -2))
			if code == 208 or code == 209 then
				inputText = string.sub(inputText, 1, string.len(inputText)-2)
				return inputText
			end
		end
		inputText = string.sub(inputText, 1, string.len(inputText)-1)
	end
	if not inputText then
		outputDebugString("not inputText")
	end
	return inputText
end

function backspace()
	if getKeyState("backspace") == true and isInputEnabled() then
		backspaceToggle = backspaceToggle+1
		if backspaceToggle > 5 then
			local editbox = getInputedEditBox()
			editbox.label.text = removeLastCharacter(editbox.label.text)
		end
	else
		backspaceToggle = 0
	end 
end

local function toggleCursor()
	if not isInputEnabled() then return end
	keyCursor.visible = not keyCursor.visible
end

local function drawView(view)
	if view.class == "view" then
		if view.color then
			dxDrawRectangle(view.x, view.y, view.w, view.h, toColor(view.color))
		end
		if view.image then
			dxDrawImage(view.x, view.y, view.w, view.h, view.image)
		end
	elseif view.class == "label" then
		dxDrawText(view:outText(), view.x, view.y, view.x+view.w, view.y+view.h, toColor(view.color), view.scale, view.font, view.alignX, view.alignY, view.clip, view.wordBreak)
	elseif view.class == "button" or view.class == "editbox" then
		if view.color then
			dxDrawRectangle(view.x, view.y, view.w, view.h, toColor(view.color))
		elseif view.image then
			dxDrawImage(view.x, view.y, view.w, view.h, view.image)
		end
		drawView(view.label)
	end
end

local function drawCursor()
	if not isInputEnabled() then return end
	local editbox = getInputedEditBox()
	local posX = editbox.label:textWidth()
	keyCursor.x = editbox.target.x+editbox.label.x+posX
	keyCursor.y = editbox.target.y+editbox.y
	if keyCursor.visible then
		dxDrawLine(keyCursor.x+2, keyCursor.y+2, keyCursor.x+2, keyCursor.y+editbox.h-2, toColor(lwColors.lwBlack), 2)
	end
end
	
addEventHandler("onClientRender", getRootElement(),
function ()	
	local x, y = getCursorPosition()
	if x and y then
		x = x * scrW
		y = y * scrH
		if x ~= oldX or y ~= oldY then
			oldX, oldY = x, y
			mouseMoved(x, y)
		end
	end
	for key, target in pairs(dxGUItargets) do
		if target.visible then
			dxSetRenderTarget(target.render)
			for k, view in pairs(target.views) do
				if view.visible then
					drawView(view)
				end
			end
			dxSetRenderTarget()
			dxDrawImage(target.x, target.y, target.w, target.h, target.render)
		end
	end
	drawCursor()
end
)

addEventHandler("onClientResourceStart", getRootElement(),
function ()
	setTimer(backspace, 50, 0)
	setTimer(toggleCursor, 400, 0)
end
)

addEventHandler("onClientClick", getRootElement(),
function (button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	for key, target in pairs(dxGUItargets) do
		if target.visible then
			for k, view in pairs(target.views) do
				--scroll
				local scrollView = getScrolledView()
				if state == "up" and scrollView then
					scrollView.scrolled = false
				end
				--
				local highlighted = isHighlighted(view, absoluteX, absoluteY)
				if highlighted and isInputEnabled() and (view.class ~= "editbox" or view.id ~= getInputedEditBox().id) then
					setInputedEditBox()
				end
				if view.visible and (view.class == "button" or view.class == "editbox") and highlighted then
					if state == "down" then
						setState(view, State.pressed)
					elseif state == "up" then
						setState(view, State.released)
					end
					return
				end
			end
		end
	end
end
)

addEventHandler("onClientKey", root, 
function(button,press)
	if button == "backspace" and press and isInputEnabled() then
		local editbox = getInputedEditBox()
		editbox.label.text = removeLastCharacter(editbox.label.text)
	elseif (button == "tab") and not press then
		nextInputedEditBox()
	end
end 
)

addEventHandler("onClientCharacter", getRootElement(), 
function (character)
	if isInputEnabled() then
		local editbox = getInputedEditBox()
		if editbox.label:textWidth() < editbox.label.w-15 then
			editbox.label.text = editbox.label.text..character
		end
	end
end
)