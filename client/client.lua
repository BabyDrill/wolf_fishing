---------------| Developed by BabyDrill#7768 |---------------
ESX = exports.es_extended:getSharedObject()

local pescando = false

-- INIZIO --
Citizen.CreateThread(function()
    local pos = Config.Pesca.Posizione
    TriggerEvent('gridsystem:registerMarker', {
        name = 'pesca:',
        pos = vector3(pos.x,pos.y,pos.z),
        size = vector3(2.1,2.1,2.1),
        scale = Config.MarkerPesca.grandezza,
        color = Config.MarkerPesca.colore,
        drawDistance = Config.MarkerPesca.distanza,
        msg = Lang.pesca,
        control = Config.MarkerPesca.key,
        type = Config.MarkerPesca.id,
        action = function()
            MenuPesca()
        end
    })
end)

Citizen.CreateThread(function()
    local pesca = Config.Pesca.Posizione
    local blip = Config.BlipPesca
    wolfdev = AddBlipForCoord(pesca.x,pesca.y,pesca.z)
    SetBlipSprite(wolfdev, blip.id)
    SetBlipColour(wolfdev, blip.colore)
    SetBlipDisplay(wolfdev, 2)
    SetBlipScale(wolfdev, blip.grandezza)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang.pescatore_blip)
    EndTextCommandSetBlipName(wolfdev)
end)

function MenuPesca()
    ESX.UI.Menu.CloseAll()
    ESX.TriggerServerCallback('wolf_development:vendita', function(item1, item2, item3)
        local elements = {}
        if item1 == 0 and item2 == 0 and item3 == 0 then
            table.insert(elements, {label = Lang.opzione1..Config.Pesca.Item.CannaDaPesca.prezzo, value = 'pesca'})
        end
        if item1 > 0 then
            table.insert(elements, {label = Lang.vendita1, value = 'vendita1'})
        end
        if item2 > 0 then
            table.insert(elements, {label = Lang.vendita2, value = 'vendita2'})
        end
        if item3 > 0 then
            table.insert(elements, {label = Lang.vendita3, value = 'vendita3'})
        end

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'pesca',
            {
                title = Lang.opzione,
                elements = elements

            },
            function(data, menu)
                if data.current.value == 'pesca' then
                    TriggerServerEvent("wolf_development:iniziapesca", Config.Pesca.Item.CannaDaPesca.name, Config.Pesca.Item.CannaDaPesca.prezzo)
                    TriggerEvent("wolf_development:daibarca")
                elseif data.current.value == 'vendita1' then
                    TriggerServerEvent("wolf_development:iniziavendita", Config.Pesca.Item.PesceNormale.name, Config.Pesca.Item.PesceNormale.prezzo)
                elseif data.current.value == 'vendita2' then
                    TriggerServerEvent("wolf_development:iniziavendita", Config.Pesca.Item.PesceRaro.name, Config.Pesca.Item.PesceRaro.prezzo)
                elseif data.current.value == 'vendita3' then
                    TriggerServerEvent("wolf_development:iniziavendita", Config.Pesca.Item.PesceLeggendario.name, Config.Pesca.Item.PesceLeggendario.prezzo)
                end
            end,
            function(data, menu)
                menu.close()
            end
        )
    end, Config.Pesca.Item.PesceNormale.name, Config.Pesca.Item.PesceRaro.name, Config.Pesca.Item.PesceLeggendario.name)
end

RegisterNetEvent("wolf_development:daibarca")
AddEventHandler("wolf_development:daibarca", function()
    ESX.UI.Menu.CloseAll()
    pescando = true
    local ped = PlayerPedId()
    local pos = Config.Pesca.SpawnBarca
    SetEntityCoords(ped, pos.x, pos.y, pos.z, true, true, true, false)
    Citizen.Wait(5)
    ESX.ShowNotification(Lang.prontopesca)
    TriggerEvent('esx:spawnVehicle', Config.Pesca.Barca)
    SetEntityHeading(ped, 0)
    PescaAttivata()
    ESX.ShowNotification(Lang.recatiallapesca)
end)

function PescaAttivata()
    local pesca = Config.Pesca.SpawnPesci
    local ped = PlayerPedId()
    Deposito()

    Citizen.CreateThread(function()
        while true do
        local shop = 500
        local coords = GetEntityCoords(PlayerPedId())
            if pescando == true then		
                if GetDistanceBetweenCoords(coords, pesca.x, pesca.y, pesca.z, true) < 200 then
                    shop = 5
                    ESX.ShowHelpNotification(Lang.pescainfo)
                    if IsControlJustReleased(1, 51) then
                        if IsPedInAnyVehicle(PlayerPedId()) then
                            ESX.ShowNotification(Lang.veicolo)
                        else
                            ESX.TriggerServerCallback("wolf_development:controllaitem", function(qtty)
                                if qtty > 0 then
                                    TriggerEvent("wolf_development:zonapesca")
                                else
                                    ESX.ShowNotification(Lang.cannapesca)
                                  end
                          end, Config.Pesca.Item.CannaDaPesca.name) 
                        end
                    end	
                end
            end
            Citizen.Wait(shop)
        end
    end)

    babydrill = AddBlipForCoord(pesca.x,pesca.y,pesca.z)
    SetNewWaypoint(pesca.x,pesca.y,pesca.z)
    SetBlipSprite(babydrill, 404)
    SetBlipColour(babydrill, 5)
    SetBlipDisplay(babydrill, 2)
    SetBlipScale(babydrill, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Lang.pesca_blip)
    EndTextCommandSetBlipName(babydrill)
end

function Deposito()
    Citizen.CreateThread(function()
        while true do
        local shop = 500
        local coords    = GetEntityCoords(PlayerPedId())	
        local pos = Config.Pesca.Deposito.posizione
            if pescando == true then		
                if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < Config.Pesca.Deposito.marker.distanza then
                    shop = 5
                    DrawMarker(Config.Pesca.Deposito.marker.id, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Pesca.Deposito.marker.grandezza, Config.Pesca.Deposito.marker.colore, 100, false, true, 2, nil, nil, false)
                    ESX.ShowHelpNotification(Lang.deposito)
                    if IsControlJustReleased(1, Config.Pesca.Deposito.marker.key) then
                        Citizen.Wait(500)
                        pescando = false
                        vehicle = ESX.Game.GetClosestVehicle()
                        ESX.Game.DeleteVehicle(vehicle)
                        RemoveBlip(babydrill)
                        SetNewWaypoint(coords)
                    end	
                end
            end
            Citizen.Wait(shop)
        end
    end)
end

RegisterNetEvent("wolf_development:zonapesca")
AddEventHandler("wolf_development:zonapesca", function()
    pescando = false
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
    local time_until_catch = math.random(Config.Pesca.Tempo.Min, Config.Pesca.Tempo.Max)
    local fish_type = math.random(0,3)
    local fishing_rod = math.random(0,2)
    Citizen.Wait(time_until_catch)
    ESX.ShowHelpNotification(Lang.pescepreso)
    Citizen.Wait(3500)
        ClearPedTasks(GetPlayerPed(-1))
        if fish_type == 0 then 
            ClearHelp(true)
            ESX.ShowNotification(Lang.pescenonpreso)
            Citizen.Wait(3500)
            pescando = true
        elseif fish_type == 1 then
            ESX.ShowNotification(Lang.pesceitem..Config.Pesca.Item.PesceNormale.label)
            TriggerServerEvent("wolf_development:daipesce", Config.Pesca.Item.PesceNormale.name)
            Citizen.Wait(3500)
            pescando = true
        elseif fish_type == 2 then
            ESX.ShowNotification(Lang.pesceitem..Config.Pesca.Item.PesceRaro.label)
            TriggerServerEvent("wolf_development:daipesce", Config.Pesca.Item.PesceRaro.name)
            Citizen.Wait(3500)
            pescando = true
        elseif fish_type == 3 then
            ESX.ShowNotification(Lang.pesceitem..Config.Pesca.Item.PesceLeggendario.label)
            TriggerServerEvent("wolf_development:daipesce", Config.Pesca.Item.PesceLeggendario.name)
            Citizen.Wait(3500)
            fishing_rod = math.random(0,2)
            Citizen.Wait(1)
        if fishing_rod == 0 then
            Citizen.Wait(3500)
            ESX.ShowNotification(Lang.cannapescarotta)
            Citizen.Wait(3500)
            TriggerEvent("wolf_development:cannadapescarotta")
        elseif fishing_rod == 1 or fishing_rod == 2 then
            pescando = true
        end
    end
end)

RegisterNetEvent("horizon_fishing:repairFishingrod")
AddEventHandler("horizon_fishing:repairFishingrod", function()
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    exports['progressBars']:startUI(15000, "Riparando canna da pesca...")
    Citizen.Wait(15000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    pescando = true
end)

--/////////////////////////////////////////////////////PED//////////////////////////////////////////////////////////////////////
local function findAnimsDictPed(anim_dict)
    RequestAnimDict(anim_dict)
    while not HasAnimDictLoaded(anim_dict) do
        Wait(1000)
    end
end

local function ClearPedsModel()
    for i=1, #Config.Pesca do
        local myPeds = Config.Pesca[i]["Pescatore"]
        if DoesEntityExist(myPeds["entity"]) then
            DeletePed(myPeds["entity"])
            SetPedAsNoLongerNeeded(myPeds["entity"])
        end
    end
end

local isAnimEnabled = false

local function findPedModel(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

local function ClearPedsModel()
    for i=1, #Config.Pesca do
        local myPeds = Config.Pesca[i]["Pescatore"]
        if DoesEntityExist(myPeds["entity"]) then
            DeletePed(myPeds["entity"])
            SetPedAsNoLongerNeeded(myPeds["entity"])
        end
    end
end

Citizen.CreateThread(function()
    for i=1, #Config.Pesca do
        local myPeds = Config.Pesca[i]["Pescatore"]
        if myPeds then
            myPeds["hash"] = myPeds["hash"]
            myPeds["anim_dict"] = myPeds["anim_dict"]
            myPeds["anim_action"] = myPeds["anim_action"]
            findPedModel(myPeds["hash"])
            findAnimsDictPed(myPeds["anim_dict"])
            if not DoesEntityExist(myPeds["entity"]) then

                myPeds["entity"] = CreatePed(4, myPeds["hash"], myPeds["x"], myPeds["y"], myPeds["z"] -1, myPeds["h"], 0, 0)
                if isAnimEnabled then
                    TaskPlayAnim(myPeds["entity"],myPeds["anim_dict"], myPeds["anim_action"],1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
                end
                SetEntityAsMissionEntity(myPeds["entity"])
                SetBlockingOfNonTemporaryEvents(myPeds["entity"], true)
                FreezeEntityPosition(myPeds["entity"], true)
                SetEntityInvincible(myPeds["entity"], true) 
            end
            SetModelAsNoLongerNeeded(myPeds["hash"])
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        ClearPedsModel()
    end
end)
---------------| Developed by BabyDrill#7768 |---------------