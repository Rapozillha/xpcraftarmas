------------------------------------------------------------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

------------------------------------------------------------------------------------------------------------

RegisterServerEvent('xpcraftarmas:CraftingSuccess')
AddEventHandler('xpcraftarmas:CraftingSuccess', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Items[CraftItem]
    for itemname, v in pairs(item.needs) do
        xPlayer.removeInventoryItem(itemname, v.count)
    end
    if CraftItem == "weapon_pistol" or CraftItem == "weapon_combatpistol" then
        xPlayer.addWeapon(CraftItem, 0)
    else
        xPlayer.addInventoryItem(CraftItem, 1)
    end
    AddCraftingPoints(src)
    TriggerClientEvent("xpcraftarmas:notification", src, Config.Text["have_made"] ..item.label.."~w~!")
end)


RegisterServerEvent('xpcraftarmas:CraftingFailed')
AddEventHandler('xpcraftarmas:CraftingFailed', function(CraftItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = Crafting.Items[CraftItem]
    -- Random chance to lose your items you can't change it
    local rand = math.random(1,50)
    if rand >= 50 then
        TriggerClientEvent("xpcraftarmas:notification", src, Config.Text["luck"])
    else
        for itemname, v in pairs(item.needs) do
            xPlayer.removeInventoryItem(itemname, v.count)
        end
    end
    TriggerClientEvent("xpcraftarmas:notification", src, Config.Text["failed"] ..item.label)
end)


ESX.RegisterServerCallback('xpcraftarmas:HasTheItems', function(source, cb, CraftItem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Crafting.Items[CraftItem]
    for itemname, v in pairs(item.needs) do
        if xPlayer.getInventoryItem(itemname).count < v.count then
            cb(false)
        end
    end
    cb(true)
end)


------------------------------------------------------------------------------------------------------------

function AddCraftingPoints(source)
    local identifier =  GetPlayerIdentifiers(source)[1]
    MySQL.Sync.execute('UPDATE user_levels SET crafting = crafting + @crafting WHERE identifier = @identifier', {
        ['@crafting'] = math.random(1, 3),
        ['@identifier'] = identifier
    })
end


ESX.RegisterServerCallback('xpcraftarmas:GetSkillLevel', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll('SELECT * FROM user_levels WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] ~= nil then
            cb(tonumber(result[1].crafting))
        else
            MySQL.Async.execute('INSERT INTO user_levels (identifier, crafting) VALUES (@identifier, @crafting)', {
                ['@identifier'] = identifier,
                ['@crafting'] = 1
            }, function(rowsChanged)
                return cb(1)
            end)
        end
    end)
end)

------------------------------------------------------------------------------------------------------------