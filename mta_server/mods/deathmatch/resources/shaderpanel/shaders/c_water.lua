--
-- c_water.lua
--
local myShader22, tec = dxCreateShader ( "shaders/water.fx" )
localPlayer = getLocalPlayer()

addEventHandler( "onClientResourceStart", resourceRoot,
        function()

		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		if not myShader22 then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
		--	outputChatBox( "Using technique " .. tec )

			-- Set textures
			local textureVol = dxCreateTexture ( "shaders/images/smallnoise3d.dds" );
			local textureCube = dxCreateTexture ( "shaders/images/cube_env256.dds" );
			dxSetShaderValue ( myShader22, "sRandomTexture", textureVol );
			dxSetShaderValue ( myShader22, "sReflectionTexture", textureCube );

		end
	end
)
	
function shader_water_enabled(shawat)

if shawat==1 then
			-- Apply to global txd 13
						timer = setTimer(	function()
							if myShader22 then
								local r,g,b,a = getWaterColor()
								dxSetShaderValue ( myShader22, "gWaterColor", r/255, g/255, b/255, a/255 );
							end
						end
						,100,0 )
						
			engineApplyShaderToWorldTexture ( myShader22, "waterclear256" )

end
		   

if shawat==0 then
                      if isTimer(timer) then killTimer(timer) end
                      engineRemoveShaderFromWorldTexture ( myShader22, "waterclear256" )
end
	
end
	
	
	
	
	
