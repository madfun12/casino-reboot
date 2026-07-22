local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("ry::server:purchaseMembership", function()
    local src = source
    TriggerClientEvent('QBCore:Notify', src, 'Purchase memberships from the casino front desk.', 'error')
end)

RegisterNetEvent("ry::server:purchaseVIPMembership", function()
    local src = source
    TriggerClientEvent('QBCore:Notify', src, 'Purchase memberships from the casino front desk.', 'error')
end)


QBCore.Functions.CreateCallback('ry::server:HasCasinoMembership', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local metadata = Player and Player.PlayerData.metadata or {}
    cb(metadata.casinoMembership == true or metadata.casinoVip == true)
end)

QBCore.Functions.CreateCallback('ry::server:HasVIPMembership', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local metadata = Player and Player.PlayerData.metadata or {}
    cb(metadata.casinoVip == true)
end)

















