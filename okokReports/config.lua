Config = {}

-------------------------- COMMANDS & FUNCTIONALITY

Config.FeedbackClientCommand = 'report' -- The command that the players use to report something

Config.FeedbackAdminCommand = 'reportr' -- The command that the admins use to check the pendent feedbacks list

Config.FeedbackCooldown = 5 -- Time in minutes

-------------------------- ADMIN PERMISSIONS

Config.ESX = false -- Set this to true if you use ESX 

-- If you use ESX you don't need to add any identifier to Config.AdminList because it checks if you have permission by your player group (superadmin, admin, mod)

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.AdminList = {
    'discord:1266181057221365875',  -- AKZA
    'discord:1191877675535585312', -- 3issam
    'discord:1243392503156183040', -- buba
    'discord:1134612368052211803', -- davini
    'discord:1180421084978360350', -- tamer
    'discord:1012806634340364359', -- rombo
    'discord:1136773380507439164', -- sido
    'discord:1134062045541703750', -- vip
    'discord:756939452428845098', -- dzairey
    'discord:1134612368052211803', -- zedk
    'discord:1095431854762512404', -- Ilyes
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 13

Config.BotName = 'Nexus' -- Write the desired bot name

Config.ServerName = 'Nexus RolePlay' -- Write your server's name

Config.IconURL = 'https://media.discordapp.net/attachments/1217229649629806732/1259555694462369906/algerianspace.png?ex=668c1c26&is=668acaa6&hm=598986e525a15d53e03c4818b741183de42f8baa7cab8fa68e85138b58162c30&=&format=webp&quality=lossless&width=468&height=468' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.NewFeedbackWebhookColor = '16769792'

Config.AssistFeedbackWebhookColor = '16776960'

Config.ConcludeFeedbackWebhookColor = '16752896'

-- ok? okok