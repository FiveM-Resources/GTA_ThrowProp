RegisterNetEvent("GTA_Prop:Server_Touch")
AddEventHandler("GTA_Prop:Server_Touch", function(player, ped, velocity)
	TriggerClientEvent("GTA_Prop:Client_Touch", player, ped, velocity)
end)