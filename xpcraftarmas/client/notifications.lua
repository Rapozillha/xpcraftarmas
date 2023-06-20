-- Neste momento só tem opção para utilizar o mythic_notify ou o okokNotify (podes escolher entre estes dois no config.lua) mas podes sempre adicionar mais

RegisterNetEvent("xpcraftarmas:notification")
AddEventHandler("xpcraftarmas:notification", function(msg)

    if Config.UsingMythicNotify == true then
        exports['mythic_notify']:SendAlert('inform', msg)
    else if Config.UsingokokNotify == true then
        exports['okokNotify']:Alert('CRAFT', msg, 3000, 'info', true)
    end

end
end)