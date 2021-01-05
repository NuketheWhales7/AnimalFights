---------------------------AnimalFights----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------

ESX        = nil
local boss, InProgress = false, false
local Animals = {}
RingSideLoc = vec3(907.58,-1814.21,24.97)
RingInLoc = vec3(915.05,-1815.45,24.97)
corner1 = vec3(913.25, -1808.04, 24.97)
corner2 = vec3(916.77, -1821.33, 24.97)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('AnimalFights:Start')
AddEventHandler('AnimalFights:Start', function(bigboobers)
if bigboobers == nil then
elseif bigboobers.Arx then
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local dist = GetDistanceBetweenCoords( 915.83, -1804.72, 25.61, coords.x, coords.y, coords.z, false)
    if dist <= 3.0 then
        OpenMenu()
    else
        exports['mythic_notify']:DoHudText('error', 'You are not near the animal fight ring')
    end
else
end
end)

function OpenMenu(station)
    local elements = {
      {label = 'Dogs', value = 'dogs'},
      {label = 'Chickens', value = 'chickens'},
      {label = 'Monkeys', value = 'monkeys'},
      {label = 'Remove Animals', value = 'remove'}, }

    if boss then
        table.insert(elements, {label = 'Moutain Lions',  value = 'lions'})
    end

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Animals', {
 --       css      = 'Factures',
        title    = 'Choose the Animal',
        align    = 'bottom-right',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'dogs' then
            FightNight('a_c_rottweiler')
        elseif data.current.value == 'chickens' then
            FightNight('a_c_hen')
        elseif data.current.value == 'monkeys' then
            FightNight('a_c_rhesus')
        elseif data.current.value == 'lions' then
            FightNight('lions')
        elseif data.current.value == 'remove' then
            RemoveAnimals()
        end

    end, function(data, menu)
        menu.close()
    end)
end

function FightNight(Animal)
if InProgress then exports['mythic_notify']:DoHudText('error', 'Match Already Started!') return end
 InProgress = true
  print("spawning Animals")

local coord = vec3(901.40, -1810.41, 24.97)
local rotation = 190.0
local rotation2 = 180.0
    if Animal == 'a_c_rottweiler' then
        animation = {  dict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                      anim = 'sleep_in_kennel',
                    }
    elseif Animal == 'a_c_hen' then
        animation = {  dict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                      anim = 'sleep_in_kennel',
                    }
    elseif Animal == 'a_c_rhesus' then
        animation = {  dict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                      anim = 'sleep_in_kennel',
                    }
    elseif Animal == 'lions' then
        animation = {  dict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                      anim = 'sleep_in_kennel',
            }
    end

    model = Animal
    RequestModel(Animal)
    while not HasModelLoaded(Animal) do 
      Wait(0)
      print("loading animal")
    end
    --Animal ONE
    ped = CreatePed(4, GetHashKey(model), coord.x, coord.y, coord.z, rotation, true, false)
    table.insert(Animals, ped)
    AddRelationshipGroup(Animal)
    -- animation
    SetPedComponentVariation(ped2, 0, 0, 0, 1)
    -- DoRequestAnimSet(animation.dict)

    -- TaskPlayAnimAdvanced(ped, animation.dict, animation.anim, coord, 0.0, 0.0, rotation, 8.0, 1.0, -1, 1, 1.0, true, true)
--    SetFacialIdleAnimOverride(ped, "mood_sleeping_1", 0)
    SetPedHearingRange(ped, 4.0)
    SetPedSeeingRange(ped, 3.0)
    SetPedAlertness(ped, 1)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_BITE"), 999, true, false)

    --Make Animal Walk to Ring
    EnterRing(ped)
    GoToCorner(ped,corner1,corner2)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedAsEnemy(ped,true)
    SetPedMoney(ped, 50)
    SetPedMaxHealth(ped, 900)
    SetPedAlertness(ped, 3)
    SetPedCombatRange(ped, 2)
    SetPedConfigFlag(ped, 224, true)
    SetPedCombatMovement(ped, 2)
    SetPedRelationshipGroupHash(ped, GetHashKey(Animal))

    --Animal TWO
    ped2 = CreatePed(4, GetHashKey(model), coord.x, coord.y, coord.z, rotation, true, false)
    table.insert(Animals, ped2)
    -- animation
    SetPedComponentVariation(ped2, 0, 0, 0, 1)
    -- DoRequestAnimSet('creatures@rottweiler@amb@sleep_in_kennel@')
    -- TaskPlayAnim(ped2, 'creatures@rottweiler@amb@sleep_in_kennel@', 'sleep_in_kennel' ,8.0, -8, -1, 1, 0, false, false, false)          
    SetPedHearingRange(ped2, 6.0)
    SetPedSeeingRange(ped2, 4.0)
    SetPedAlertness(ped2, 1)
    GiveWeaponToPed(ped2, GetHashKey("WEAPON_BITE"), 999, true, false)

    --Make Animal Walk to Ring
    EnterRing(ped2)
    GoToCorner(ped2,corner2,corner1)
    SetPedRelationshipGroupHash(ped2, GetHashKey(Animal))
    SetPedCombatAttributes(ped2, 46, true)
    SetPedFleeAttributes(ped2, 0, 0)
    SetPedAsEnemy(ped2,true)
    SetPedMoney(ped2, 50)
    SetPedMaxHealth(ped2, 900)
    SetPedAlertness(ped2, 3)
    SetPedCombatRange(ped2, 2)
    SetPedConfigFlag(ped2, 224, true)
    SetPedCombatMovement(ped2, 2)
    print("finished spawned Animals") 
    Citizen.Wait(4000)

    --Fight Start
    SetRelationshipBetweenGroups(5, GetHashKey(Animal), GetHashKey(Animal))
    ClearPedTasksImmediately(ped)
    ClearPedTasksImmediately(ped2)
    MiddleRing(ped)
    MiddleRing(ped2)
    TaskCombatPed(ped2,ped,0,16)
    TaskCombatPed(ped,ped2,0,16)
    IsFighting = true
    print("FIGHT!")

  while IsFighting do
    Citizen.Wait(10)
    if GetEntityHealth(ped) <= 1.0 and GetEntityHealth(ped2) <= 1.0  then
        IsFighting = false
        ESX.ShowNotification("Tie.")
        Citizen.Wait(1000)
        SetEntityAsMissionEntity(ped,true,true)
        DeleteEntity(ped)
        SetEntityAsMissionEntity(ped2,true,true)
        DeleteEntity(ped2)
        InProgress = false
    elseif GetEntityHealth(ped) <= 1.0 then
        IsFighting = false
        ESX.ShowNotification("Fighter A wins.")
        Citizen.Wait(1000)
        SetEntityAsMissionEntity(ped,true,true)
        DeleteEntity(ped)
        SetEntityAsMissionEntity(ped2,true,true)
        DeleteEntity(ped2)
        InProgress = false
    elseif GetEntityHealth(ped2) <= 1.0 then
        IsFighting = false
        ESX.ShowNotification("Fighter B wins.")
        Citizen.Wait(1000)
        SetEntityAsMissionEntity(ped,true,true)
        DeleteEntity(ped)
        SetEntityAsMissionEntity(ped2,true,true)
        DeleteEntity(ped2)
        InProgress = false
    else
        ClearPedTasksImmediately(ped)
        ClearPedTasksImmediately(ped2)
        TaskCombatPed(ped2,ped,0,16)
        Citizen.Wait(5000)
        TaskCombatPed(ped,ped2,0,16)
        Citizen.Wait(5000)
    end
  end
  InProgress = false
end

function DoRequestAnimSet(anim)
  RequestAnimDict(anim)
  while not HasAnimDictLoaded(anim) do
    Citizen.Wait(1)
  end
end

function EnterRing(peds)
  if not peds then return; end
   print("going to ring side")
  local pos = RingSideLoc
  TaskGoStraightToCoord(peds, pos.x,pos.y,pos.z, 1.0, 1.0, 1.0, 1.0)

  while GetVecDist(GetEntityCoords(peds),pos) > 2.55 do Citizen.Wait(0); end
  Citizen.Wait(2000)
 print("going to ring middle")
  local pos = RingInLoc
  local adder = 2
  TaskGoStraightToCoord(peds, pos.x,pos.y,pos.z, 1.0, 1.0, 1.0, 1.0)
  while GetVecDist(GetEntityCoords(peds),pos) > 1.5 do Citizen.Wait(1000 * adder) adder = math.min(adder * 2,5) end
end

function GoToCorner(peds,pos,corner)
  if not peds or not pos or not corner then return; end
  print("going to corner")
  TaskGoStraightToCoord(peds, pos.x,pos.y,pos.z, 1.0, 1.0, 1.0, 1.0)  

  while GetVecDist(GetEntityCoords(peds),pos) > 1 do Citizen.Wait(0); end

  local pos = corner
  TaskTurnPedToFaceCoord(peds, pos.x,pos.y,pos.z, -1)
  Citizen.Wait(1000)
  print("done with corner")
end

function MiddleRing(peds)
  if not peds then return; end
 print("going to ring middle")
  local pos = RingInLoc
  local adder = 2
  TaskGoStraightToCoord(peds, pos.x,pos.y,pos.z, 1.0, 1.0, 1.0, 1.0)
  while GetVecDist(GetEntityCoords(peds),pos) > 1.5 do Citizen.Wait(1000 * adder) adder = math.min(adder * 2,5) end
end

function RemoveAnimals()
    for _,ped in pairs(Animals) do
        SetPedAsNoLongerNeeded(ped)
    DeletePed(ped)
   
    end
    print("Animals Removed!!")
  Animals = {}
  InProgress = false
end


function GetVecDist(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

---------------------------AnimalFights----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------