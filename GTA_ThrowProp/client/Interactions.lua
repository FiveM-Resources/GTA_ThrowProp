local optiTimer = 1000
local lastObjGrab = nil
local CurrentAnimation = nil
local isObjGrab = false
local proGrabed = nil
local isDrop = false
local tableData = {}


Citizen.CreateThread(function() 
    while true do 
        local playerPed = GetPlayerPed(-1)	
        local PedPos = GetEntityCoords(playerPed)

        for i in pairs(tableData) do
            tableData[i] = nil
        end

        for k in pairs(listObject) do
            local prop = GetClosestObjectOfType(PedPos.x, PedPos.y, PedPos.z, 3.0, GetHashKey(listObject[k]), false)
            local dist = getDistance(PedPos, GetEntityCoords(prop))
            table.insert(tableData, {object = prop, distance = dist, propHash = GetHashKey(listObject[k])})
        end

        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do 
        optiTimer = 1000
        local playerPed = GetPlayerPed(-1)	
        local timeStartedPressing = nil

        local closest = tableData[1]
		for _,v in pairs(tableData) do
			if v.distance < closest.distance then
				closest = v
			end
		end

        local distance = closest.distance
		local object = closest.object
        local lastObj = closest.propHash

        if (distance <= 3.0 and isObjGrab == false) then
            optiTimer = 0
            TriggerEvent("GTA-NotifHelp:InfoInteraction", "~INPUT_CELLPHONE_CAMERA_GRID~ to take the prop.")

            if IsControlJustReleased(0, 183) then
                NetworkRequestControlOfEntity(object)

                local timeWaited = 0

                while not NetworkHasControlOfEntity(object) and timeWaited <= 500 do
                    Wait(1)
                    timeWaited = timeWaited + 1
                end

                SetEntityAsMissionEntity(object)

                DeleteObject(object)

                PlayAnimation(playerPed,"weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_floor", 1)

                Wait(800)

                ClearPedTasksImmediately(playerPed)

                local obj = CreateObject(lastObj, 0.0, 0.0, 0.0, true, false, true, false, false)
                SetEntityCollision(obj, true)
            
                Attach(obj, playerPed)
                POS = GetEntityCoords(obj)


                isObjGrab = true
                lastObjGrab = obj
                proGrabed = lastObjGrab
            end
        end

        if isObjGrab == true then 
            optiTimer = 0

            SetPlayerLockon(PlayerId(), false)

            if CanThrowProp(playerPed) then 
                TriggerEvent("GTA-NotifHelp:InfoInteraction", "~INPUT_AIM~ + ~INPUT_ATTACK~ to throw the prop.")

                if IsControlPressed(0, 25) then
                    local timePressed = nil


                    loadAnimDict("weapons@projectile@")
                    TaskPlayAnim(playerPed, "weapons@projectile@", "throw_m_fb_stand", 3.0, 3.0, 100, 0, 120)

                    if timeStartedPressing then
                        timePressed = GetGameTimer() - timeStartedPressing
                    else
                        timePressed = 0
                    end

                    local rot = GetGameplayCamRot(2)
                    local zangle

                    if rot.x < -20.0 then
                        if timePressed > 1000 then
                            CurrentAnimation = Config.Animations.aimingFullLow
                        else
                            CurrentAnimation = Config.Animations.aimingLow
                        end

                        zangle = 5.0
                    elseif rot.x < 20.0 then
                        if timePressed > 1000 then
                            CurrentAnimation = Config.Animations.aimingFullMed
                        else
                            CurrentAnimation = Config.Animations.aimingMed
                        end
                        
                        zangle = 10.0
                    else
                        if timePressed > 1000 then
                            CurrentAnimation = Config.Animations.aimingFullHigh
                        else
                            CurrentAnimation = Config.Animations.aimingHigh
                        end

                        zangle = 15.0
                    end

                    DrawMarker(3, POS.x, POS.y, POS.z, 0, 0, 0, rot.x, rot.y, rot.z, 1.0, rot.y, rot.y, 255, 255, 255, 255)

                    if IsControlPressed(0, 24) then
                        if not timeStartedPressing then
                            timeStartedPressing = GetGameTimer()
                        end
                    elseif IsControlJustReleased(0, 24) then
                        local velocity
                        local throwingAnim

                        if timePressed > 1000 then
                            velocity = Config.BaseVelocity * 5
                            throwingAnim = Config.Animations.throwingHigh
                        elseif timePressed > 200 then
                            velocity = Config.BaseVelocity * 3
                            throwingAnim = Config.Animations.throwingMed
                        else
                            velocity = Config.BaseVelocity
                            throwingAnim = Config.Animations.throwingLow
                        end

                        timeStartedPressing = nil


                        ClearPedTasksImmediately(playerPed)
                        SetEntityHeading(playerPed, rot.z)
                        PlayAnimation(playerPed, throwingAnim.dict, throwingAnim.name, 120)

                        Wait(500)

                        local r = math.rad(-rot.z)
                        local vx = velocity * math.sin(r)
                        local vy = velocity * math.cos(r)
                        local vz = rot.x + zangle

                        ClearPedTasks(playerPed)
                        DetachEntity(lastObjGrab, true, true)
                        SetEntityCoords(lastObjGrab, GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.2))
                        SetEntityVelocity(lastObjGrab, vx, vy, vz)


                        isDrop = true

                        proGrabed = lastObjGrab

                        local model = GetEntityModel(lastObjGrab)
                        SetObjectAsNoLongerNeeded(lastObjGrab)
                        SetPlayerLockon(PlayerId(), true)

                        lastObjGrab = 0
                        isObjGrab = false
                    end
                end
            end
        end

        if HasEntityCollidedWithAnything(proGrabed) then
            local velocity = GetEntityVelocity(proGrabed)
            if isDrop == true then
                for ped in EnumeratePeds() do
                    if IsEntityTouchingEntity(proGrabed, ped) then
                        if IsPedAPlayer(ped) and not IsPedRagdoll(ped) then
                            TriggerServerEvent("GTA_Prop:Server_Touch", GetPlayerServerId(GetPlayerFromPed(ped)), -1, velocity)
                            isDrop = false
                            break
                        elseif NetworkGetEntityIsNetworked(ped) and not IsPedRagdoll(ped) then
                            if NetworkHasControlOfEntity(ped) then
                                SetPedRagdoll(ped, velocity)
                                isDrop = false
                                break
                            else
                                TriggerServerEvent("GTA_Prop:Server_Touch", -1, PedToNet(ped), velocity)
                                isDrop = false
                                break
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(optiTimer)
    end
end)


RegisterNetEvent("GTA_Prop:Client_Touch")
AddEventHandler("GTA_Prop:Client_Touch", function(ped, velocity)
	if (ped == -1) then
		SetPedRagdoll(PlayerPedId(), velocity)
	else
		SetPedRagdoll(NetToPed(ped), velocity)
	end
end)