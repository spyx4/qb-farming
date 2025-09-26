local QBCore = exports['qb-core']:GetCoreObject()
local selling = false
local npcEntity = nil


CreateThread(function()
    local coords = Config.JuiceStation
    exports['qb-target']:AddCircleZone("juice_station", coords, 2.0, {
        name = "juice_station",
        debugPoly = false,
        useZ = true
    }, {
        options = {
            {
                type = "client",
                event = "farm:craftJuice",
                icon  = "fas fa-blender",
                label = "Make Apple Juice",
                juice = "apple"
            },
            {
                type = "client",
                event = "farm:craftJuice",
                icon  = "fas fa-blender",
                label = "Make Lemon Juice",
                juice = "lemon"
            },
        },
        distance = 2.5
    })

    
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 728)  
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Juice Station")
    EndTextCommandSetBlipName(blip)
end)


RegisterNetEvent("farm:craftJuice", function(data)
    local ped = PlayerPedId()
    local juice = data.juice           

    QBCore.Functions.Progressbar("craft_"..juice, "Blending "..juice.." juice...", 6000, false, true, {
        disableMovement = true, disableCombat = true
    }, {
        animDict = "amb@prop_human_bbq@male@base",
        anim     = "base",
        flags    = 49,
    }, {}, {}, function()
        TriggerServerEvent("farm:makeJuice", juice, juice)
        ClearPedTasks(ped)
    end, function()
        QBCore.Functions.Notify("Canceled juice making", "error")
        ClearPedTasks(ped)
    end)
end)


CreateThread(function()
    for crop, locs in pairs(Config.FarmLocations) do
        for i, coords in ipairs(locs) do
            local zoneName = "farm_" .. crop .. "_" .. i
            exports['qb-target']:AddCircleZone(zoneName, coords, 2.0, {
                name = zoneName,
                debugPoly = false,
                useZ = true
            }, {
                options = {
                    {
                        type = "client",
                        event = "farm:collect",
                        icon = "fas fa-hand",
                        label = "Harvest " .. crop,
                        crop = crop
                    },
                },
                distance = 2.5
            })

            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, 515)           
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 2)             
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Harvest " .. crop)
            EndTextCommandSetBlipName(blip)
        end
    end
end)


RegisterNetEvent("farm:collect", function(data)
    local ped = PlayerPedId()
    local crop = data.crop

    local animDict, anim, flags, progressText

    if crop == "carrot" or crop == "potato" then
        animDict = "amb@world_human_gardener_plant@male@base"
        anim     = "base"
        progressText = "Harvesting "..crop.." ..."
        flags    = 49
    elseif crop == "apple" or crop == "lemon" then
        animDict = "missmechanic"
        anim     = "work2_base"
        progressText = "Picking "..crop.." ..."
        flags    = 49
    else
        animDict = "amb@prop_human_bum_bin@base"
        anim     = "base"
        progressText = "Harvesting "..crop.." ..."
        flags    = 49
    end

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    QBCore.Functions.Progressbar("harvest_"..crop, progressText, 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableCombat = true,
    }, {
        animDict = animDict,
        anim = anim,
        flags = flags,
    }, {}, {}, function()
        TriggerServerEvent("farm:giveItem", crop)
        QBCore.Functions.Notify("You harvested some "..crop, "success")
        ClearPedTasks(ped)
    end, function() 
        QBCore.Functions.Notify("Canceled harvesting "..crop, "error")
        ClearPedTasks(ped)
    end)
end)


CreateThread(function()
    local pedModel = Config.SellNpc.model
    local pedCoords = Config.SellNpc.coords
    local pedHeading = Config.SellNpc.heading

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(10)
    end

    npcEntity = CreatePed(4, pedModel, pedCoords.x, pedCoords.y, pedCoords.z, pedHeading, false, true)

    SetEntityAsMissionEntity(npcEntity, true, true)
    SetEntityInvincible(npcEntity, true)
    SetBlockingOfNonTemporaryEvents(npcEntity, true)
    SetPedCanRagdoll(npcEntity, false)
    TaskStartScenarioInPlace(npcEntity, "WORLD_HUMAN_CLIPBOARD", 0, true)

    exports['qb-target']:AddTargetEntity(npcEntity, {
        options = {
            {
                type = "client",
                event = "farm:sellMenu",
                icon = "fas fa-dollar-sign",
                label = "Sell items"
            },
        },
        distance = 2.5
    })

    local sellBlip = AddBlipForCoord(pedCoords.x, pedCoords.y, pedCoords.z)
    SetBlipSprite(sellBlip, 605)          
    SetBlipDisplay(sellBlip, 4)
    SetBlipScale(sellBlip, 0.9)
    SetBlipColour(sellBlip, 5)            
    SetBlipAsShortRange(sellBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Crop Buyer")
    EndTextCommandSetBlipName(sellBlip)
end)

RegisterNetEvent("farm:sellMenu", function()
    if selling then return end
    selling = true

    QBCore.Functions.TriggerCallback("farm:getItems", function(items)
        if not items or #items == 0 then
            QBCore.Functions.Notify("You don’t have anything to sell", "error")
            selling = false
            return
        end

        local menu = {
            {
                header = "Crop Buyer",
                isMenuHeader = true
            }
        }

        for _, item in pairs(items) do
            if Config.Prices[item.name] then
                menu[#menu + 1] = {
                    header = ("%s (x%d)"):format(QBCore.Shared.Items[item.name].label, item.amount),
                    txt = ("Price: $%d each"):format(Config.Prices[item.name]),
                    params = {
                        event = "farm:sellItemMenu",
                        args = {
                            name = item.name,
                            amount = item.amount,
                            price = Config.Prices[item.name]
                        }
                    }
                }
            end
        end

        menu[#menu + 1] = {
            header = "⬅ Close",
            params = { event = "" }
        }

        exports['qb-menu']:openMenu(menu)
        selling = false
    end)
end)

RegisterNetEvent("farm:sellItemMenu", function(data)
    local menu = {
        {
            header = ("Sell %s"):format(QBCore.Shared.Items[data.name].label),
            isMenuHeader = true
        },
        {
            header = "Sell All",
            txt = ("Sell %d for $%d"):format(data.amount, data.amount * data.price),
            params = {
                isServer = true,
                event = "farm:sellItem",
                args = { name = data.name, amount = data.amount }
            }
        },
        {
            header = "Sell 10",
            txt = ("Sell 10 for $%d"):format(10 * data.price),
            params = {
                isServer = true,
                event = "farm:sellItem",
                args = { name = data.name, amount = 10 }
            }
        },
        {
            header = "Sell 1",
            txt = ("Sell 1 for $%d"):format(data.price),
            params = {
                isServer = true,
                event = "farm:sellItem",
                args = { name = data.name, amount = 1 }
            }
        },
        {
            header = "⬅ Back",
            params = { event = "farm:sellMenu" }
        }
    }

    exports['qb-menu']:openMenu(menu)
end)



