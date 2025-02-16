local oneSync = false
ESX = nil

Citizen.CreateThread(function()
	if GetConvar("onesync") ~= 'off' then
		oneSync = true
	end
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
end)

-------------------------- VARS

local Webhook = 'https://discord.com/api/webhooks/1101966480796549262/fcPgch1GcyKY_9xRj7Hy7gxI5IzACPOCezuGBE0EN319Avdpan2i2QWlz1CpunutqqoK'
local staffs = {}
local FeedbackTable = {}

-------------------------- NEW FEEDBACK

RegisterNetEvent("okokReports:NewFeedback")
AddEventHandler("okokReports:NewFeedback", function(data)
	local identifierlist = ExtractIdentifiers(source)
	local newFeedback = {
		feedbackid = #FeedbackTable+1,
		playerid = source,
		identifier = identifierlist.license:gsub("license2:", ""),
		subject = data.subject,
		information = data.information,
		category = data.category,
		concluded = false,
		discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
	}

	FeedbackTable[#FeedbackTable+1] = newFeedback

	TriggerClientEvent("okokReports:NewFeedback", -1, newFeedback)

	if Webhook ~= 'https://discord.com/api/webhooks/1101966480796549262/fcPgch1GcyKY_9xRj7Hy7gxI5IzACPOCezuGBE0EN319Avdpan2i2QWlz1CpunutqqoK' then
		newFeedbackWebhook(newFeedback)
	end
end)

-------------------------- FETCH FEEDBACK

RegisterNetEvent("okokReports:FetchFeedbackTable")
AddEventHandler("okokReports:FetchFeedbackTable", function()
	local staff = hasPermission(source)
	if staff then
		staffs[source] = true
		TriggerClientEvent("okokReports:FetchFeedbackTable", source, FeedbackTable, staff, oneSync)
	end
end)

-------------------------- ASSIST FEEDBACK

RegisterNetEvent("okokReports:AssistFeedback")
AddEventHandler("okokReports:AssistFeedback", function(feedbackId, canAssist)
	if staffs[source] then
		if canAssist then
			local id = FeedbackTable[feedbackId].playerid
			if GetPlayerPing(id) > 0 then
				local ped = GetPlayerPed(id)
				local playerCoords = GetEntityCoords(ped)
				local pedSource = GetPlayerPed(source)
				local identifierlist = ExtractIdentifiers(source)
				local assistFeedback = {
					feedbackid = feedbackId,
					discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
				}

				SetEntityCoords(pedSource, playerCoords.x, playerCoords.y, playerCoords.z)
				TriggerClientEvent('qb-Notify:Alert', source, "REPORT", "You are assisting FEEDBACK #"..feedbackId.."!", 20000, 'info')
				TriggerClientEvent('qb-Notify:Alert', id, "REPORT", "An admin arrived!", 20000, 'info')

				if Webhook ~= 'https://discord.com/api/webhooks/1101966480796549262/fcPgch1GcyKY_9xRj7Hy7gxI5IzACPOCezuGBE0EN319Avdpan2i2QWlz1CpunutqqoK' then
					assistFeedbackWebhook(assistFeedback)
				end
			else	
				TriggerClientEvent('qb-Notify:Alert', id, "REPORT", "That player is no longer in the server!", 20000, 'error')
			end
			if not FeedbackTable[feedbackId].concluded then
				FeedbackTable[feedbackId].concluded = "assisting"
			end
			TriggerClientEvent("okokReports:FeedbackConclude", -1, feedbackId, FeedbackTable[feedbackId].concluded)
		end
	end
end)

-------------------------- CONCLUDE FEEDBACK

RegisterNetEvent("okokReports:FeedbackConclude")
AddEventHandler("okokReports:FeedbackConclude", function(feedbackId, canConclude)
	if staffs[source] then
		local feedback = FeedbackTable[feedbackId]
		local identifierlist = ExtractIdentifiers(source)
		local concludeFeedback = {
			feedbackid = feedbackId,
			discord = "<@"..identifierlist.discord:gsub("discord:", "")..">"
		}

		if feedback then
			if feedback.concluded ~= true or canConclude then
				if canConclude then
					if FeedbackTable[feedbackId].concluded == true then
						FeedbackTable[feedbackId].concluded = false
					else
						FeedbackTable[feedbackId].concluded = true
					end
				else
					FeedbackTable[feedbackId].concluded = true
				end
				TriggerClientEvent("okokReports:FeedbackConclude", -1, feedbackId, FeedbackTable[feedbackId].concluded)

				if Webhook ~= 'https://discord.com/api/webhooks/1101966480796549262/fcPgch1GcyKY_9xRj7Hy7gxI5IzACPOCezuGBE0EN319Avdpan2i2QWlz1CpunutqqoK' then
					concludeFeedbackWebhook(concludeFeedback)
				end
			end
		end
	end
end)
-------------------------- HAS PERMISSION

function hasPermission(id)
	local staff = false

	if Config.ESX then
		local player = ESX.GetPlayerFromId(id)
		local playerGroup = player.getGroup()

		if playerGroup ~= nil and playerGroup == "superadmin" or playerGroup == "admin" or playerGroup == "mod" then 
			staff = true
		end
	else
		for i, a in ipairs(Config.AdminList) do
	        for x, b in ipairs(GetPlayerIdentifiers(id)) do
	            if string.lower(b) == string.lower(a) then
	                staff = true
	            end
	        end
	    end
	end

	return staff
end

-------------------------- IDENTIFIERS

function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end



