



EXEMPLO DE COMO USAR:

RegisterServerEvent("itemCrafted")
AddEventHandler("itemCrafted", function(item, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if Config.Recipes[item].SuccessRate > math.random(0, Config.Recipes[item].SuccessRate) then
        if Config.UseLimitSystem then
            local xItem = xPlayer.getInventoryItem(item)

            if xItem.count + count <= xItem.weight then
                if Config.Recipes[item].isGun then
                    xPlayer.addWeapon(item, 0)
                else
                    xPlayer.addInventoryItem(item, count)
                end
                TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["item_crafted"])
                giveCraftingLevel(xPlayer.identifier, Config.ExperiancePerCraft)
            else
                TriggerEvent("craft", item)
                TriggerClientEvent("sendMessage", src, )
            end
        else
            if xPlayer.canCarryItem(item, count) then
                if Config.Recipes[item].isGun then
                    xPlayer.addWeapon(item, 0)
                else
                    xPlayer.addInventoryItem(item, count)
                end
                TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["item_crafted"])
                giveCraftingLevel(xPlayer.identifier, Config.ExperiancePerCraft)
            else
                TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["inv_limit_exceed"])
            end
    else
            TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["crafting_failed"])
    end
    
)