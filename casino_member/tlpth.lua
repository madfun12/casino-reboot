-- Initialize QBCore
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('casino:checkVIPStatus', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        cb(Player.PlayerData.metadata and Player.PlayerData.metadata.casinoVip == true)
    else
        cb(false)
    end
end)
