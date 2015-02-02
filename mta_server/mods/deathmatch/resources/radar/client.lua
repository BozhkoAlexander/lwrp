--[[
    # Resource Name
	  Grand Theft Auto V | Radar
	# Author
	  Rage
	# Date created
	  25.04.2014
	# Last update
      17.07.2014	
	# Copyright (c)
	  If you edit it, then please respect me and keep
	  the credits.
--]]

local screenW,screenH = guiGetScreenSize()
local resW,resH = 1280,720
local sW,sH =  (screenW/resW), (screenH/resH)

    local turn = true
    local alpha = 255

local visible = true

function setVisible(_visible)
	visible = _visible
end
	
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
	    setPlayerHudComponentVisible ( "radar", false )
		--# Create Textures
        hudMaskFX = dxCreateShader("mask.fx")
		radarTexture = dxCreateTexture("img/radar_map.jpg")
		maskTexture = dxCreateTexture("img/radar_mask.png")
		checkTextures = ( hudMaskFX and radarTexture and maskTexture )

		if not ( checkTextures ) then
			outputChatBox( "[GTA V Radar]: Could not create textures. Please use debugscript 3" )
		else
			dxSetShaderValue( hudMaskFX, "sPicTexture", radarTexture )
			dxSetShaderValue( hudMaskFX, "sMaskTexture", maskTexture )
		end
	end
)

    function drawRadar()
		if not visible then return end
		if not ( checkTextures ) then return end
	        dxSetShaderValue( hudMaskFX, "sMaskTexture", maskTexture )
		
		local x,y = getElementPosition( localPlayer )
		local zoom = 13		
		    x = ( x ) / 6000
		    y = ( y ) / -6000
		dxSetShaderValue( hudMaskFX, "gUVPosition", x,y )
		dxSetShaderValue( hudMaskFX, "gUVScale", 1/zoom, 1/zoom )

        --# Get rotations
		local _, _, c_Rot = getElementRotation( getCamera());
		local _, _, p_Rot = getElementRotation( localPlayer )		
		    dxSetShaderValue( hudMaskFX, "gUVRotAngle", math.rad( -c_Rot ))
	    
		local playerHealth = math.floor( getElementHealth( localPlayer ))
	    local playerArmor = math.floor( getPedArmor( localPlayer ))
		local playerOxygen = math.floor( getPedOxygenLevel( localPlayer ))
		    if ( playerHealth  <= 50) then
			    HP_Colour = tocolor(200, 0, 0, 190)
				HP_Alpha = tocolor(200, 0, 0, 100)
			else
			    HP_Colour = tocolor(102, 204, 102, 190)
				HP_Alpha = tocolor(102, 204, 102, 100)				
            end
            if ( playerHealth >= 101 ) then
                maxHealth = 200
            else
                maxHealth = 100
            end				
		
		--# Alpha
		dxDrawRectangle(23.5*sW, 676.5*sH, 130.5*sW, 9.2*sH, HP_Alpha)		
		dxDrawRectangle(156.6*sW, 676.5*sH, 65*sW, 9.2*sH, tocolor(0, 102, 255, 100))
        dxDrawRectangle(225*sW, 676.5*sH, 62.6*sW, 9.2*sH, tocolor(255, 255, 0, 100))
		
		--# Bars
		dxDrawRectangle(23.5*sW, 676.5*sH, 130.5*sW/maxHealth*playerHealth, 9.2*sH, HP_Colour)		
        dxDrawRectangle(156.6*sW, 676.5*sH, 65*sW/100*playerArmor, 9.2*sH, tocolor(0, 102, 255, 190))
        dxDrawRectangle(225*sW, 676.5*sH, 62.6*sW/1000*playerOxygen, 9.2*sH, tocolor(255, 255, 0, 190))			 
		
		--# Minimap		
        dxDrawImage(18*sW, 530*sH, 275*sW, 160*sH, "img/radar_cover.png", 0, 0, 0, tocolor(255, 255, 255, 255))
        dxDrawImage(23*sW, 536*sH, 265*sW, 135*sH, hudMaskFX, 0,0,0, tocolor(255,255,255,210))
        dxDrawImage(144*sW, 595*sH, 20*sW, 20*sH, "img/radar_player.png", -p_Rot+c_Rot, 0, 0, tocolor(255, 255, 255, 255))

		--# Wanted
		local g_wl = getPlayerWantedLevel( localPlayer )
        if ( g_wl > 0 ) then
            if ( turn == true ) then
                alpha = alpha + 5
                    if ( alpha > 180 ) then
                        alpha = 180
                        turn = false
        end
        elseif ( turn == false ) then
            alpha = alpha - 5
                if ( alpha < 0 ) then
                    alpha = 0
                    turn = true
                end
        end
        dxDrawRectangle(23*sW, 536*sH, 265*sW, 135*sH, tocolor(0, 102, 255, alpha))
        else return end		
		end
addEventHandler( "onClientRender", root, drawRadar)

addEventHandler( "onClientResourceStop", resourceRoot,
	function()
	    setPlayerHudComponentVisible ( "radar", true )
	end)