--
-- c_car_paint.lua
local myShader99, tec = dxCreateShader ( "shaders/car_paint.fx" )
addEventHandler( "onClientResourceStart", resourceRoot,
    function()
		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader


		if not myShader99 then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			-- outputChatBox( "Using technique " .. tec )
			-- Set textures
    		dxSetShaderValue ( myShader99, "sRandomTexture", dxCreateTexture ( "shaders/images/smallnoise3d.dds" ) );
			dxSetShaderValue ( myShader99, "sReflectionTexture", dxCreateTexture ( "shaders/images/cube_env256.dds" ) );
			

			-- Apply to world texture			
		end
		end
)		
		
function start_carpaint_shadder(carpaint_onoff)		
		
			if  carpaint_onoff==1 then
			engineApplyShaderToWorldTexture ( myShader99, "vehiclegrunge256" )
			engineApplyShaderToWorldTexture ( myShader99, "?emap*" )
			
			end
			
			if carpaint_onoff==0 then
					engineRemoveShaderFromWorldTexture  ( myShader99, "vehiclegrunge256" )
					engineRemoveShaderFromWorldTexture ( myShader99, "?emap*" )

		                         end
end


	    

			
			
			

			

		


