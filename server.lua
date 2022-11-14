local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local stre = {}
Tunnel.bindInterface("streamer",stre)
vCLIENT = Tunnel.getInterface("streamer")

local cooldowm = {}

function stre.cooldown()
    local user_id = vRP.getUserId(source)
    cooldowm[user_id] = {}
end

function stre.permission()
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,"streamer.permissao") or vRP.hasPermission(user_id,"admin.permissao")
end

function stre.giveitem(item)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local recompensa = {
        ["lancer"] = {
            type = "vehicle",
            spawn = "adder"
        },
        ["moto"] = {
            type = "vehicle",
            spawn = "r61"
        },
        ["streamer"] = {
            type = "item",
            items = {
                {
                    name = "wbody|WEAPON_PISTOL_MK2",
                    amount = 1
                },
                {
                    name = "wammo|WEAPON_PISTOL_MK2",
                    amount = 250
                },
                {
                    name = "melzinho",
                    amount = 10
                },
                {
                    name = "radio",
                    amount = 1
                },
                {
                    name = "mochila",
                    amount = 3
                },
                {
                    name = "compattach",
                    amount = 1
                }
            }
        },
        ["kit"] = {
            type = "amigo",
            items = {
                {
                    name = "wbody|WEAPON_PISTOL_MK2",
                    amount = 1
                },
                {
                    name = "wammo|WEAPON_PISTOL_MK2",
                    amount = 250
                },
                {
                    name = "melzinho",
                    amount = 10
                },
                {
                    name = "radio",
                    amount = 1
                },
                {
                    name = "compattach",
                    amount = 1
                }
            }
        }
    }
    if recompensa[item] then
        if cooldowm[user_id][item] == nil or cooldowm[user_id][item] <= os.time() then
            if recompensa[item].type == "vehicle" then
                cooldowm[user_id][item] = os.time() + 60 -- 1 minuto
                vCLIENT.spawnVeh(source,recompensa[item].spawn)
                TriggerEvent("setPlateEveryone",identity.registration)
            elseif recompensa[item].type == "item" then
                cooldowm[user_id][item] = os.time() + 2700 -- 45 minutos
                for _,v in pairs(recompensa[item].items) do
                    if vRP.itemBodyList(v.name) then
                        vRP.giveInventoryItem(user_id, v.name, v.amount)
                    end
                end
            elseif recompensa[item].type == "amigo" then
                local prompt = vRP.prompt(source, "Digite o <b>ID</b> que receberá o kit:", "")
                if tonumber(prompt) ~= nil then
                    local nuser_id = tonumber(prompt)
                    if nuser_id then
                        if nuser_id ~= user_id then
                            if cooldowm[nuser_id][item] == nil or cooldowm[nuser_id][item] <= os.time() then
                                cooldowm[user_id][item] = os.time + 2700 -- 45 minutos
                                for k,v in pairs(recompensa[item].items) do
                                    vRP.giveInventoryItem(nuser_id, v.name, v.amount)
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","O id <b>" .. nuser_id .."</b> está no cooldown!")
                            end
                        end
                    end
                end
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você está no cooldown!")
        end
    end
end