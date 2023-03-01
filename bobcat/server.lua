local QBCore = exports['qb-core']:GetCoreObject() 

QBCore.Functions.CreateUseableItem('thermite', function(source) 
	TriggerClientEvent('bobcat:startHeist', source) 
end) 

RegisterServerEvent('bobcat:particles')
AddEventHandler('bobcat:particles', function(method)
	TriggerClientEvent('bobcat:ptfxparticle', -1, method)
end)

RegisterServerEvent('bobcat:particles2')
AddEventHandler('bobcat:particles2', function(method)
	TriggerClientEvent('bobcat:ptfxparticle2', -1, method)
end)

QBCore.Functions.CreateUseableItem('bobcatsecuritycard', function(source)
	TriggerClientEvent('bobcat:openThirdDoor', source)
end) 

local weapons = {
	"weapon_dp9",
	"weapon_pistol_mk2",
	"weapon_compactrifle",
	"weapon_assaultrifle",
	"weapon_assaultrifle_mk2",
}

RegisterServerEvent('bobcat:giveRandomWeapon')
AddEventHandler('bobcat:giveRandomWeapon', function()
	local src = source 
	local Player = QBCore.Functions.GetPlayer(src)
	for i = 1, math.random(1, 5), 1 do 
		local randomWeapon = weapons[math.random(1, #weapons)] --weapon circles
		local amount = math.random(0, 2) --weapon counts
		Player.Functions.AddItem(randomWeapon, amount)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomWeapon], 'add')
		Citizen.Wait(300)
	end

	local chance = math.random(1, 100)
	if chance < 10 then 
		Player.Functions.AddItem('weapon_microsmg2', 1, false)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_microsmg2'], 'add')
	end
end) 

QBCore.Functions.CreateCallback('bobcat:enoughCops', function(source, cb)
	local Cops = 0 
    for k, v in pairs(QBCore.Functions.GetPlayers()) do 
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if Player.PlayerData.job.name == "police" then 
                Cops = Cops + 1 
            end
        end
    end 
    cb(Cops)
end) 

RegisterServerEvent("bobcat:removeItem")
AddEventHandler("bobcat:removeItem", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    Player.Functions.RemoveItem(item, 1) 
end)

RegisterServerEvent("bobcat:syncPedsSV")
AddEventHandler("bobcat:syncPedsSV", function(peds, players)
    for _, p in pairs(players) do
		print(p)
		Player = QBCore.Functions.GetPlayer(tonumber(p))
		TriggerClientEvent('bobcat:syncPeds',tonumber(p), peds)
	end
end)