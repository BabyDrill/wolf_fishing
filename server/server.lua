---------------| Developed by BabyDrill#7768 |---------------
ESX = exports.es_extended:getSharedObject()

ESX.RegisterServerCallback("wolf_development:controllaitem", function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count  
    cb(qtty)
end)

ESX.RegisterServerCallback('wolf_development:vendita', function(source, cb, item1, item2, item3)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item1 = xPlayer.getInventoryItem(item1).count
    local item2 = xPlayer.getInventoryItem(item2).count
    local item3 = xPlayer.getInventoryItem(item3).count
	cb(item1, item2, item3)
end)

RegisterServerEvent("wolf_development:iniziapesca")
AddEventHandler("wolf_development:iniziapesca", function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = xPlayer.getMoney(_source)

    if money >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1) 
        TriggerClientEvent('wolf_development:daibarca')
    else
        TriggerClientEvent('esx:showNotification', _source, Lang.soldi)
    end 
end)

RegisterServerEvent("wolf_development:daipesce")
AddEventHandler("wolf_development:daipesce", function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem(item, 1)
end) 


RegisterServerEvent("wolf_development:iniziavendita")
AddEventHandler("wolf_development:iniziavendita", function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local itemQuantity = xPlayer.getInventoryItem(item).count

    if itemQuantity > 0 then
        xPlayer.removeInventoryItem(item, itemQuantity)
        xPlayer.addMoney(price*itemQuantity)
        TriggerClientEvent("esx:showNotification", _source, Lang.venduto..itemQuantity.." "..item.." "..Lang.soldi2..price*itemQuantity)
    else
        TriggerClientEvent("esx:showNotification", _source, Lang.materiale)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    wolflogo()
end)

function wolflogo()
    print([[
^4| Developed by BabyDrill |
| Powered By Wolf Development |
| https://discord.gg/EP9apZgAVR |^0]])
end
---------------| Developed by BabyDrill#7768 |---------------