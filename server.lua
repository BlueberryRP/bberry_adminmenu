RegisterServerEvent('bberry:addDollars')
AddEventHandler('bberry:addDollars', function()			
 local _source = source
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		if user ~= nil then
			user.addMoney(100)
		end
	end)			
end)				

RegisterServerEvent('bberry:addGold')
AddEventHandler('bberry:addGold', function()			
 local _source = source
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		if user ~= nil then
			user.addGold(100)
		end
	end)			
end)						


RegisterServerEvent('bberry:checkgroup')
AddEventHandler('bberry:checkgroup', function()
 local _source = source
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		if user ~= nil then
			user.getGroup()
			if user.getGroup() == "superadmin" then
			TriggerClientEvent('bberry:menu', source)
			end
		end
	end) 
end)
