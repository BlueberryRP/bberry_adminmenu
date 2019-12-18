keys = {
    ['G'] = 0x760A9C6F,
    ['S'] = 0xD27782E3,
    ['W'] = 0x8FD015D8,
	['H'] = 0x24978A28,
	['G'] = 0x5415BE48,
	['E'] = 0xDFF812F9
}


Citizen.CreateThread(function()

 WarMenu.CreateMenu('MenuList', 'AdminMenu')
 WarMenu.CreateSubMenu('TP', 'MenuList', 'Teleport')
 WarMenu.CreateSubMenu('noclip', 'MenuList', 'Adminnoclip')
 WarMenu.CreateSubMenu('AddMoney', 'MenuList', 'AddMoney')
 WarMenu.SetSubTitle('MenuList', 'functions')
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if WarMenu.IsMenuOpened('MenuList') then
			if WarMenu.MenuButton('Adminnoclip', 'noclip') then end
			if WarMenu.MenuButton('Teleport', 'TP') then end
			if WarMenu.MenuButton('AddMoney', 'AddMoney') then end
			WarMenu.Display()
			elseif WarMenu.IsMenuOpened('noclip') then
			if WarMenu.Button('Adminnoclip activate/deactivate') then
				TriggerEvent('noclip:activate')
			end
			WarMenu.Display()
			elseif WarMenu.IsMenuOpened('TP') then
			if WarMenu.Button('Armadillo') then
					SetEntityCoords(playerPed, -3622.04,-2612.9,-13.61) 
				elseif WarMenu.Button('Valentine') then
					SetEntityCoords(playerPed, -238.11,744.48,116.68) 
				elseif WarMenu.Button('Blackwater') then
					SetEntityCoords(playerPed, -908.72,-1366.0,45.41) 
				elseif WarMenu.Button('Strawberry') then
					SetEntityCoords(playerPed, -1781.67,-378.35,158.14) 
				elseif WarMenu.Button('Strawberry') then
					SetEntityCoords(playerPed, 2415.1,-1164.2,46.29)
				elseif WarMenu.Button('Annesburg') then
					SetEntityCoords(playerPed, 2904.81,1356.38,51.72)
				elseif WarMenu.Button('VanHorn') then
					SetEntityCoords(playerPed, 2955.93,501.25,45.87)
				elseif WarMenu.Button('Tumbleweed') then
					SetEntityCoords(playerPed, -5519.9,-2901.19,-2.5)
				elseif WarMenu.Button('BacchusStation') then
					SetEntityCoords(playerPed, 572.85,1688.11,187.63)
				elseif WarMenu.Button('MountHagen') then
					SetEntityCoords(playerPed, -1917.85,1333.33,200.86)
				elseif WarMenu.Button('Rhodes') then
					SetEntityCoords(playerPed, -1218.43,-1286.51,76.9)
			end
			WarMenu.Display()
			elseif WarMenu.IsMenuOpened('AddMoney') then
				if WarMenu.Button('AddDollars') then
				TriggerServerEvent('bberry:addDollars')
					
			elseif WarMenu.Button('AddGold') then
				TriggerServerEvent('bberry:addGold')
				end
			WarMenu.Display()
		end
	end
end)

RegisterNetEvent('bberry:menu')
AddEventHandler('bberry:menu', function()
  WarMenu.OpenMenu('MenuList')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, keys['H']) then
			TriggerServerEvent('bberry:checkgroup')
		end
	end
end)

local noclip = false
local noclip_speed = 5.0

function admin_no_clip()
noclip = not noclip
  local playerPed = PlayerPedId()
  if noclip then -- active
    SetEntityInvincible(playerPed, true)
    SetEntityVisible(playerPed, false, false)
	
  else -- desactive
    SetEntityInvincible(playerPed, false)
    SetEntityVisible(playerPed, true, false)
	
  end
end


function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if noclip then
      local playerPed = PlayerPedId()
      local x,y,z = getPosition()
      local dx,dy,dz = getCamDirection()
      local speed = noclip_speed

      -- reset du velocity
      SetEntityVelocity(playerPed, 0.0001, 0.0001, 0.0001)

      -- aller vers le haut
      if IsControlPressed(0, keys['W']) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end

      -- aller vers le bas
      if IsControlPressed(0, keys['S']) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end
      SetEntityCoordsNoOffset(playerPed,x,y,z,true,true,true)
    end
  end
end)

RegisterNetEvent('noclip:activate')
AddEventHandler('noclip:activate', function()
	admin_no_clip()
end)