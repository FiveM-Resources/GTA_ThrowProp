local square = math.sqrt
function getDistance(a, b) 
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return square(x*x+y*y+z*z)
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end

function EnumerateEntities(firstFunc, nextFunc, endFunc)
	return coroutine.wrap(function()
		local iter, id = firstFunc()

		if not id or id == 0 then
			endFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = endFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = nextFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		endFunc(iter)
	end)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end



function PlayAnimation(ped, animDict, animName, animFlag)
	if not DoesAnimDictExist(animDict) then
		print("Invalid animation dictionry: " .. animDict)
		return
	end

	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Wait(0)
	end

	TaskPlayAnim(ped, animDict, animName, 4.0, 4.0, -1, animFlag, 0, false, false, false, "", false)

	RemoveAnimDict(animDict)
end

function CanThrowProp(ped)
	return not (IsPedRagdoll(ped) or IsPedClimbing(ped) or IsPlayerDead(ped))
end

function SetPedRagdoll(ped, velocity)
	SetPedToRagdoll(ped, 3000, 3000, 0, 0, 0, 0)
	SetEntityVelocity(ped, velocity / 6.0)
end

function GetPlayerFromPed(ped)
	for _, player in ipairs(GetActivePlayers()) do
		if GetPlayerPed(player) == ped then
			return player
		end
	end
end


function Attach(obj, ped)
    AttachEntityToEntity(obj, ped, GetPedBoneIndex(ped, 0x6F06), 0.0, 0.0, 0.0, 0.0, 0.0,0.0, true, true, false, true, 1, true)
end

local function AddLongString(txt)
    for i = 100, string.len(txt), 99 do
        local sub = string.sub(txt, i, i + 99)
        AddTextComponentSubstringPlayerName(sub)
    end
end
RegisterNetEvent("GTA-NotifHelp:InfoInteraction")
AddEventHandler("GTA-NotifHelp:InfoInteraction", function(text, sound, loop)
	BeginTextCommandDisplayHelp("jamyfafi")
    AddTextComponentSubstringPlayerName(text)
    if string.len(text) > 99 then
        AddLongString(text)
    end
    EndTextCommandDisplayHelp(0, loop or 0, sound or false, -1)
end)