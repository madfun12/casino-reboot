local QBCore = exports['qb-core']:GetCoreObject()

local MEMBERSHIP_PRICE = 5000
local VIP_PRICE = 50000

local function getMetadata(Player)
    return Player.PlayerData.metadata or {}
end

local function hasMembership(Player)
    local metadata = getMetadata(Player)
    return metadata.casinoMembership == true or metadata.casinoVip == true
end

local function hasVipMembership(Player)
    return getMetadata(Player).casinoVip == true
end

local function migrateLegacyCards(Player)
    local memberCard = Player.Functions.GetItemByName('casino_member')
    local vipCard = Player.Functions.GetItemByName('casino_vip')

    if not memberCard and not vipCard then
        return
    end

    if memberCard then
        Player.Functions.SetMetaData('casinoMembership', true)
        Player.Functions.RemoveItem('casino_member', memberCard.amount)
    end

    if vipCard then
        Player.Functions.SetMetaData('casinoMembership', true)
        Player.Functions.SetMetaData('casinoVip', true)
        Player.Functions.RemoveItem('casino_vip', vipCard.amount)
    end

    TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'Your casino membership is now permanently linked to your player.', 'success')
end

AddEventHandler('QBCore:Server:OnPlayerLoaded', function(Player)
    migrateLegacyCards(Player)
end)

RegisterNetEvent('casino:server:buyCasinoMember', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then
        return
    end

    migrateLegacyCards(Player)

    if hasVipMembership(Player) then
        TriggerClientEvent('QBCore:Notify', src, 'You already have a VIP casino membership.', 'error')
        return
    end

    if hasMembership(Player) then
        TriggerClientEvent('QBCore:Notify', src, 'You already have a casino membership. Upgrade to VIP at the front desk.', 'error')
        return
    end

    if Player.Functions.GetMoney('bank') < MEMBERSHIP_PRICE then
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money in your bank.', 'error')
        return
    end

    Player.Functions.RemoveMoney('bank', MEMBERSHIP_PRICE, 'casino-membership')
    Player.Functions.SetMetaData('casinoMembership', true)
    TriggerClientEvent('QBCore:Notify', src, 'Casino membership purchased.', 'success')
end)

RegisterNetEvent('casino:server:buyCasinoVIP', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then
        return
    end

    migrateLegacyCards(Player)

    if hasVipMembership(Player) then
        TriggerClientEvent('QBCore:Notify', src, 'You already have a VIP casino membership.', 'error')
        return
    end

    if Player.Functions.GetMoney('bank') < VIP_PRICE then
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money in your bank.', 'error')
        return
    end

    Player.Functions.RemoveMoney('bank', VIP_PRICE, 'casino-vip-membership')
    Player.Functions.SetMetaData('casinoMembership', true)
    Player.Functions.SetMetaData('casinoVip', true)
    TriggerClientEvent('QBCore:Notify', src, 'VIP casino membership purchased.', 'success')
end)
