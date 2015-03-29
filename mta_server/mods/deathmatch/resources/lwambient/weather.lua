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

local _sa = math.random(0, 20)

local function setServerWeather( id )
	local weatherid, changing = getWeather()
	outputDebugString("Change  weather from "..weatherid.." to ".._sa)
	_sa = id or math.random(0, 20)
    setWeatherBlended ( _sa )
end

addEventHandler("onResourceStart", getRootElement(), function ( startedRes )
	if (getResourceName(startedRes) ~= "lwambient") then return end
		Timer(setServerWeather, 60000 * 120, 0)
end)


addCommandHandler ( "setWeather", function ( playerSource, command , parameter )
	setWeather ( parameter )
end )

addCommandHandler ( "getWeather", function ( playerSource, command , parameter )
	local weatherid, changing = getWeather()
	outputDebugString("Weather is "..weatherid)
end)