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
	
dxGUItargets = {}
local inputViewId = nil
	
State = { normal = 0,
		highlighted = 1,
		pressed = 2,
		released = 3
}

Fonts = { default = "default",
		bold = "default-bold",
		clear = "clear",
		arial = "arial",
		sans = "sans",
		pricedown = "pricedown",
		bankgothic = "bankgothic",
		diploma = "diploma",
		beckett = "beckett"
}

Colors = { white = {r = 255, g = 255, b = 255, a = 255},
		lightGray = {r = 184, g = 184, b = 184, a = 255},
		gray = {r = 123, g = 123, b = 123, a = 255},
		darkGray = {r = 61, g = 61, b = 61, a = 255},
		black = {r = 0, g = 0, b = 0, a = 255},
		red = {r = 255, g = 0, b = 0, a = 255},
		green = {r = 0, g = 255, b = 0, a = 255},
		blue = {r = 0, g = 0, b = 255, a = 255}
}

addEvent("onButtonHighlighted", false)
addEvent("onButtonPressed", false)
addEvent("onButtonReleased", false)
addEvent("onEditBoxStartEditing", false)
addEvent("onEditBoxEndEditing", false)
addEvent("onScrolled", false)

function createColor(r, g, b, a)
	local color = {}
	color.r = r
	color.g = g
	color.b = b
	color.a = a
	return color
end

function setInputedEditBox(view)
	for key, target in pairs(dxGUItargets) do
		if target.visible then
			for k, view in pairs(target.views) do
				if view.class == "editbox" then
					view.inputed = false
				end
			end
		end
	end
	if view then
		view.inputed = true
		inputViewId = view.id
	else
		inputViewId = nil
	end
end

function getInputedEditBox()
	for key, target in pairs(dxGUItargets) do
		if target.visible then
			for k, view in pairs(target.views) do
				if view.class == "editbox" and view.id == inputViewId then
					return view
				end
			end
		end
	end
end

function nextInputedEditBox()
	if not isInputEnabled() then return end
	local flag = false
	for key, target in pairs(dxGUItargets) do
		if target.visible then
			for k, view in pairs(target.views) do
				if view.class == "editbox" then
					if view.id == inputViewId then
						flag = true
					elseif flag == true then
						setInputedEditBox(view)
						return view
					end
				end
			end
		end
	end
end

function isInputEnabled()
	return inputViewId ~= nil
end

function getScrolledView()
	for key, target in pairs(dxGUItargets) do
		if target.class == "scrollView" and target.scrolled then
			return target
		end
	end
end

function setState(view, state)	
	if view.state == state then return
	elseif view.state == State.pressed and state == State.highlighted then return
	elseif not view.state == State.pressed and state == State.released then return
	elseif view.state == State.normal and state == State.highlighted then
		if view.class == "button" then
			triggerEvent("onButtonHighlighted", getRootElement(), view)
		end
	elseif view.state == State.highlighted and state == State.pressed then
		if view.class == "button" then
			triggerEvent("onButtonPressed", getRootElement(), view)
		end
	elseif view.state == State.pressed and state == State.released then
		if view.class == "button" then
			triggerEvent("onButtonReleased", getRootElement(), view)
		elseif view.class == "editbox" then
			setInputedEditBox(view)
			triggerEvent("onEditBoxStartEditing", getRootElement(), view)
		end
	end
	
	if view.class =="button" or view.class == "editbox" then
		setState(view.label, state)
	end
	if state == State.released then
		state = State.highlighted
	end
	
	if view.state == State.normal then
		view.states.normal.color = view.color
	elseif view.state == State.highlighted then
		view.states.highlighted.color = view.color
	elseif view.state == State.pressed then
		view.states.pressed.color = view.color
	end
	view.state = state
	if state == State.normal and view.states.normal.color then
		view.color = view.states.normal.color
	elseif state == State.highlighted and view.states.highlighted.color then
		view.color = view.states.highlighted.color
	elseif state == State.pressed and view.states.pressed.color then
		view.color = view.states.pressed.color
	end
end

function setColor(view, color, state)
	if not view or not color then
		return
	end
	if view.state == state or not state then
		view.color = color
	end
	if state == State.normal then
		view.states.normal.color = color
	elseif state == State.highlighted then
		view.states.highlighted.color = color
	elseif state == State.pressed then
		view.states.pressed.color = color
	end
end
	
function createView(x, y, w, h, target, id)
	local view = {}
	view.x = x
	view.y = y
	view.w = w
	view.h = h
	view.target = target
	if target.class =="scrollView" then
		view.sx = x
		view.sy = y
	end
	view.states = {normal = {}, highlighted = {}, pressed = {}}
	setState(view, State.normal)
	view.visible = true
	view.color = nil
	view.image = nil
	view.id = id
	view.class = "view"
	table.insert(target.views, view)
	return view
end

function createEditBox(x, y, w, h, target, id)
	local view = createView(x, y, w, h, target, id)
	view.label = createLabel(x+5, y+(0.1*h), w-5, h-(0.1*h), target, "", id)
	view.label.parent = view
	view.label.alignX = "left"
	view.color = Colors.gray
	view.class = "editbox"
	view.inputed = false
	return view
end

function createButton(x, y, w, h, target, title, id)
	local view = createView(x, y, w, h, target, id)
	view.label = createLabel(x, y+(0.1*h), w, h-(0.1*h), target, title, id)
	view.label.parent = view
	view.color = Colors.gray
	view.class = "button"
	return view
end

function createLabel(x, y, w, h, target, text, id)
	local view = createView(x, y, w, h ,target, id)
	view.text = text
	view.color = Colors.black
	view.font = Fonts.default
	view.scale = 1
	view.alignX = "center"
	view.alignY = "center"
	view.clip = false
	view.wordBreak = false
	view.mask = false
	view.class = "label"
	view.outText = function(self)
		local text = self.text
		if self.mask then
			text = ""
			for i=1, #self.text do
				local code = string.byte(string.sub(self.text, i,i+1))
				if code ~= 208 and code ~= 209 then
					text = text..string.char(7)
				end
			end
		end
		return text
	end
	view.textWidth = function(self)
		local width = 0
		if self.mask then
			width = 9*#self:outText()
		else
			width = dxGetTextWidth(self:outText(), self.scale, self.font)
		end
		return width
	end
	return view
end

function createScrollView(x, y, w, h, cw, ch, id)
	cw = cw or w
	ch = ch or h
	local target = createTarget(x, y, w, h, id)
	target.contentView = createView(0, 0, cw, ch, target, id)
	target.scroll = createButton(w-13, 0, 13, 65, target, "", "scroll")
	target.scrolled = false
	target.class = "scrollView"
	addEventHandler("onButtonPressed", getRootElement(),
	function (button)
		if button.id == "scroll" then
			target.scrolled = true
		end
	end)
	addEventHandler("onScrolled", getRootElement(), 
	function(scrollView, x, y)
		y = y - target.scroll.h/2 - target.y
		if y < 0 then y = 0 end
		if (y + target.scroll.h > target.h) then y = target.h - target.scroll.h end
		target.scroll.y = y
		local k = y / (target.h - target.scroll.h)
		target.contentView.y = -(target.contentView.h - target.h) * k
		for key, view in pairs(target.views) do
			if view.id ~= target.contentView.id and view.id ~= "scroll" then
				view.y = target.contentView.y + view.sy
			end
		end
	end)
	return target
end

function createLWScrollView(x, y, w, h, cw, ch, id)
	local target = createScrollView(x, y, w, h, cw, ch, id)
	target.scroll.color = nil
	target.scroll.image = "/images/scroller.png"
	return target
end

function createTarget(x, y, w, h, id)
	local target = {}
	target.x = x
	target.y = y
	target.w = w
	target.h = h
	target.visible = true
	target.render = dxCreateRenderTarget(w, h, true)
	target.id = id
	target.class = "target"
	target.views = {}
	table.insert(dxGUItargets, target)
	return target
end

function removeTarget(target)
	target.visible = false
	for key, aTarget in pairs(dxGUItargets) do
		if target.id == aTarget.id then
			table.remove(dxGUItargets, key)
			return
		end
	end
end