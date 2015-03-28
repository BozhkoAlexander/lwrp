--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        weather.lua
*  PURPOSE:     Managing game weather
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

local _sa = math.random(0, 21)

local function setRandomWeather( )
	local weatherid, changing = getWeather()
	outputDebugString("Change  weather from "..weatherid.." to ".._sa)
	_sa = math.random(0, 21)
    setWeather( weatherid )
    setWeatherBlended ( _sa )
    --newId, changing = getWeather()
end

addEventHandler("onResourceStart", getRootElement(), function ( startedRes )
	if (getResourceName(startedRes) ~= "lwambient") then return end
	setWeather ( _sa )
	Timer(setRandomWeather, 60000 * 5, 0)
end)