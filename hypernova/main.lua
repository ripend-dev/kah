--[[GLOBAL VARIABLES]]--
-- Basic global variables that will be used in the whole script
local lp = game.Players.LocalPlayer
local players = game:GetService'Players':GetPlayers -- Called using players()

--[[GUI SETUP]]--
-- Creates an empty list for commands to be shown in the QOL tab in the GUI and so on
local qol = {} 

--[[COMMAND INITIALIZE]]--
-- Shows the players username and displayname above their head [DisplayName (@Username1234)]
qol.showdn = {
    name = 'Show Display Names',
    description = 'Shows all player\'s display names above their head',
	properties = {
	    above = false,
        forceun = false,
        spacing = 0
	},
	aliases = {'showdisplaynames', 'usedn'}
}

-- Changes the player's text color in chat
qol.textchc = {
    name = 'Chat Color',
    description = 'Changes the player\'s chat color',
    properties = {
        color = Color3.new(255, 255, 255)
    },
    aliases = {'textcolor', 'chatcol'}
}

--[[COMMAND SETUP]]--
-- Sets up the commands that we initialized earlier
-- Command is the function that is called when user executes the command
qol.showdn.command = function()
    for _, v in next, players() do
        if v.Character:FindFirstChild'Humanoid' then
            if not qol.showdn.properties.above then
                v.Character.Humanoid.DisplayName = v.Character.Humanoid.Name..""..string.rep("\n", qol.showdn.properties.spacing).."(@"..v.Character.Humanoid.DisplayName..")"
            elseif qol.showdn.properties.above then
                v.Character.Humanoid.DisplayName = v.Character.Humanoid.DisplayName..""..string.rep("\n", qol.showdn.properties.spacing).."(@"..v.Character.Humanoid.Name..")"
            elseif qol.showdn.properties.showun then
                v.Character.Humanoid.DisplayName = v.Character.Humanoid.Name
            end
        end
    end
end

qol.textchc.command = function(newcol)
    -- TODO: Complete after sw is up again
end