--[[
/***************************************************************************************************************
*
*  PROJECT:     Lost World
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        time.lua
*  PURPOSE:     Managing game time
*  DEVELOPERS:  Samuel <alexander.s.bozhko@gmail.com>
*
****************************************************************************************************************/
]]

local function setRealTime()
    local realtime = getRealTime()
 
    setTime(realtime.hour, realtime.minute)
    setMinuteDuration(60000)
end

addEventHandler("onResourceStart", getRootElement(), function ( startedRes )
	if (getResourceName(startedRes) ~= "lwambient") then return end
	setRealTime()
end)