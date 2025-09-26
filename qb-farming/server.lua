local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent("farm:giveItem", function(crop)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.AddItem(crop, 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[crop], "add")
    end
end)


QBCore.Functions.CreateCallback("farm:getItems", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb({}) return end

    local items = {}
    for crop, _ in pairs(Config.Prices) do
        local count = Player.Functions.GetItemByName(crop)
        if count then
            table.insert(items, { name = crop, label = QBCore.Shared.Items[crop].label, amount = count.amount })
        end
    end
    cb(items)
end)


RegisterNetEvent("farm:sellAllItems", function(items)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    for _, data in pairs(items) do
        if Player.Functions.RemoveItem(data.name, data.amount) then
            local earned = data.amount * data.price
            Player.Functions.AddMoney("cash", earned, "sold crops")
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[data.name], "remove")
        end
    end
end)


RegisterNetEvent("farm:sellItem", function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not data or not data.name or not data.amount then return end

    local item = Player.Functions.GetItemByName(data.name)
    if item and item.amount >= data.amount then
        local price = Config.Prices[data.name] * data.amount
        Player.Functions.RemoveItem(data.name, data.amount)
        Player.Functions.AddMoney("cash", price, "farm-sell")
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[data.name], "remove")
        TriggerClientEvent("QBCore:Notify", src, ("You sold %d %s for $%d"):format(data.amount, QBCore.Shared.Items[data.name].label, price), "success")
    else
        TriggerClientEvent("QBCore:Notify", src, "You don’t have enough of that item!", "error")
    end
end)


RegisterNetEvent("farm:makeJuice", function(juice, fruit)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local fruitItem = Player.Functions.GetItemByName(fruit)
    if fruitItem and fruitItem.amount >= 10 then      -- need 10 fruits
        Player.Functions.RemoveItem(fruit, 10)
        Player.Functions.AddItem(juice.."_juice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[juice.."_juice"], "add")
        TriggerClientEvent('QBCore:Notify', src, "You made "..juice.." juice!", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough "..fruit.."!", "error")
    end
end)
