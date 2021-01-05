---------------------------AnimalFights----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------
while Config == nil do Citizen.Wait(10); end; 
local debugprint, arrester1, arrester2, arrester3 = false, true, false, false
if Config.usingESX then
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if Config.Whitelist then
--Put steam or license here if using a Whitelist
Whitelist = {
    'steam:11000010b73ef22',
    'steam:1100001050cb08a',
    'steam:11000010afcac2a',
    --'steam:11000510b72352',
    --'license:1234975143578921327',
}

function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(Whitelist) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('[^1NewsPaper-Debug^7] Whitelist id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end
end

RegisterCommand(Config.FightCommand, function(source, args)
	local usource = source
   	local article = table.concat(args, " ")
    local bigboobers = {Arx = "CyprusHill"}
	if Config.Whitelist then
	    if isAllowedToChange(usource) then
			TriggerClientEvent('AnimalFights:Start', usource,bigboobers)
		else
			TriggerClientEvent('chatMessage', usource, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
		end
	else
		TriggerClientEvent('AnimalFights:Start', usource,bigboobers)
	end
end)

---------------------------AnimalFights----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------