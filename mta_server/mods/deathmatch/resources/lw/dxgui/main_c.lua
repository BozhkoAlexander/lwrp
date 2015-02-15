--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        main_c.lua
*  PURPOSE:     (GUI) Main script file
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

local adminPanel = nil

addEventHandler("onClientResourceStart", getRootElement(), function ( startedRes )
	bindKeys()

	--------------------
	adminPanel = DXWindow(250, 50, 350, 400, LWColor.blackTranslucent, LWColor.blue, LWColor.black, "Admin panel")
	local spawnButton = DXButton(10, 300, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Появление")
	spawnButton:setOnClicked(function ( self )
		Admin.spawnIncognito()
	end)
	adminPanel:addSubview(spawnButton)

	local carButton = DXButton(10, 345, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Автомобиль")
	carButton:setOnClicked(function ( self )
		Admin.getCar()
	end)
	adminPanel:addSubview(carButton)

	--getHydra
	local airButton = DXButton(100, 345, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "Самолет")
	airButton:setOnClicked(function ( self )
		Admin.getHydra()
	end)
	adminPanel:addSubview(airButton)

	local akButton = DXButton(100, 300, 80, 35, LWColor.black, LWColor.blue, LWColor.blue, "АК-74")
	akButton:setOnClicked(function ( self )
		Admin.getWeapon(30)
	end)
	adminPanel:addSubview(akButton)

	local loginLabel = DXEditLabel(50, 50, 250, 30, nil, LWColor.blue, LWColor.orange, "login")
	adminPanel:addSubview(loginLabel)
	---------------------

	table.insert(DXViews, adminPanel)
	updateCursor()
end)

function toggleAdminPanel( )
	adminPanel:setVisible(not adminPanel:getVisible())
	updateCursor()
end