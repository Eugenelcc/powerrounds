if !PowerRounds then PowerRounds = {} end

if PowerRounds.SharedLoaded then
	return
else
	PowerRounds.SharedLoaded = true
end

local GamemodePlayers, GamemodeAllPlayers

PR_ROLE_ANY = 0
PR_ROLE_BAD = 1
PR_ROLE_GOOD = 2
PR_ROLE_SPEC = 3
PR_ROLE_SPECIAL = 4

PowerRounds.Rounds = {
	["Murder"] = {},
	["TTT"] = {},
	["PropHunt"] = {},
	["Melonbomber"] = {},
	["Jailbreak"] = {},
	["Deathrun"] = {},
	["GuessWho"] = {}
}

local PRIDs = 1

function PowerRounds.AddRound(RT)
	if PowerRounds.DoneRounds then return end

	if !RT.Name then
		RT.Name = "No name set"
	end

	if !RT.Gamemode then
		RT.Gamemode = "Any"
	end

	if !RT.Description then
		RT.Description = "No description set"
	end

	if SERVER then
		RT.ClientStart = nil
		RT.ClientEnd = nil

		for n, j in pairs(RT) do
			if string.StartWith(n, "CHOOK_") || string.StartWith(n, "CTIMER_") then
				RT[n] = nil
			end
		end
	elseif CLIENT then
		RT.ServerStartWait = nil
		RT.WinTeamCondition = nil
		RT.ServerStart = nil
		RT.ServerEnd = nil
		RT.PlayersStart = nil
		RT.PlayersEnd = nil
		RT.PlayerDeath = nil
		RT.DoPlayerDeath = nil
		RT.PlayerUpdate = nil
		RT.Think = nil
		RT.PlayerCanPickupWeapon = nil
		RT.PlayerShouldTakeDamage = nil
		RT.ScalePlayerDamage = nil
		RT.TTTPlayerSpeed = nil
		RT.BlockKarma = nil
		RT.BlockScore = nil
		RT.RunCondition = nil

		for n, j in pairs(RT) do
			if string.StartWith(n, "SHOOK_") || string.StartWith(n, "STIMER_") then
				RT[n] = nil
			end
		end
	end

	RT.ID = PRIDs
	PRIDs = PRIDs + 1

	for n, j in pairs(PowerRounds.Rounds) do
		if RT.Gamemode == "Any" || RT.Gamemode == n then
			j[RT.ID] = RT
		end
	end
end


function PowerRounds.Chat(Ply, ...)
	if CLIENT then
		chat.AddText(...)
	elseif SERVER then
		if Ply != "All" && !IsValid(Ply) then return end

		local T = {...}

		net.Start("PowerRoundsChat")
			net.WriteUInt(#T, 8)

			for _, j in ipairs(T) do
				if isentity(j) then
					j = j:Nick()
				end

				if j == nil then
					j = ""
				end

				if isstring(j) then
					net.WriteUInt(0, 1)
					net.WriteString(j)
				elseif istable(j) then
					net.WriteUInt(1, 1)
					net.WriteUInt(j.r or 255, 8)
					net.WriteUInt(j.g or 255, 8)
					net.WriteUInt(j.b or 255, 8)
				end
			end
		if Ply == "All" then
			net.Broadcast()
		else
			net.Send(Ply)
		end
	end
end


hook.Add("PostGamemodeLoaded", "PowerRoundsPostGamemodeLoadedSH", function()
	local GMName = GAMEMODE.Name
	if GMName == "Murder" then -- Murder
		PowerRounds.CurrentGM = "Murder"
		PowerRounds.CurrentGMSpecific = "Murder"
		function GamemodePlayers(Ply)
			if Ply:GetMurderer() then
				return PR_ROLE_BAD
			else
				return PR_ROLE_GOOD
			end
		end
		function GamemodeAllPlayers()
			return team.GetPlayers(2)
		end
	elseif GMName == "Trouble in Terrorist Town" then -- Trouble in terrorist town
		PowerRounds.CurrentGM = "TTT"
		PowerRounds.CurrentGMSpecific = "TTT"
		function GamemodePlayers(Ply)
			if Ply:GetRole() == ROLE_TRAITOR then
				return PR_ROLE_BAD
			else
				if Ply:Team() == TEAM_SPEC then
					return PR_ROLE_SPEC
				else
					return PR_ROLE_GOOD, Ply:GetRole() == ROLE_DETECTIVE
				end
			end
		end
		function GamemodeAllPlayers()
			return team.GetPlayers(TEAM_TERROR)
		end

		local PlyMeta = FindMetaTable("Player")

		local OldGetCredits = PlyMeta.GetCredits
		function PlyMeta:GetCredits() -- T and D shop blocking for Server side
			if PowerRounds.CurrentPR && ((PowerRounds.CurrentPR.BlockTShop && self:GetRole() == ROLE_TRAITOR) || (PowerRounds.CurrentPR.BlockDShop && self:GetRole() == ROLE_DETECTIVE) ) then
				return 0
			else
				return OldGetCredits(self)
			end
		end

		function PowerRounds.SendRole(Ply)
			net.Start("TTT_Role")
				net.WriteUInt(Ply:GetRole(), 2)
			net.Send(Ply)
		end

		if Damagelog then
			PowerRounds.TTTDamagelogsBefore = Damagelog.RDM_Manager_Enabled
		end
	elseif GMName == "Enhanced Prop Hunt" then -- Enhanced Prop Hunt
		PowerRounds.CurrentGM = "PropHunt"
		PowerRounds.CurrentGMSpecific = "EnhancedPropHunt"
		function GamemodePlayers(Ply)
			if Ply:Team() == TEAM_HUNTERS then
				return PR_ROLE_BAD
			elseif Ply:Team() == TEAM_PROPS then
				return PR_ROLE_GOOD
			else
				return PR_ROLE_SPEC
			end
		end
		function GamemodeAllPlayers()
			local Players = team.GetPlayers(TEAM_HUNTERS)
			table.Add(Players, team.GetPlayers(TEAM_PROPS) )
			return Players
		end

		local OldGetGameTimeLeft = GAMEMODE.GetGameTimeLeft
		GAMEMODE.GetGameTimeLeft = function()
			if PowerRounds.CurrentPR && PowerRounds.CurrentPR.CustomRoundEnd then
				return 99999
			else
				return OldGetGameTimeLeft()
			end
		end
	elseif GMName == "Prop Hunt" && GAMEMODE.Author == "Kow@lski (Original by AMT)" then -- Original Prop Hunt
		PowerRounds.CurrentGM = "PropHunt"
		PowerRounds.CurrentGMSpecific = "OriginalPropHunt"
		function GamemodePlayers(Ply)
			if Ply:Team() == TEAM_HUNTERS then
				return PR_ROLE_BAD
			elseif Ply:Team() == TEAM_PROPS then
				return PR_ROLE_GOOD
			else
				return PR_ROLE_SPEC
			end
		end
		function GamemodeAllPlayers()
			local Players = team.GetPlayers(TEAM_HUNTERS)
			table.Add(Players, team.GetPlayers(TEAM_PROPS) )
			return Players
		end
	elseif GMName == "Melonbomber" then -- Melonbomber
		PowerRounds.CurrentGM = "Melonbomber"
		PowerRounds.CurrentGMSpecific = "Melonbomber"
		function GamemodePlayers(Ply)
			return PR_ROLE_ANY
		end
		function GamemodeAllPlayers()
			return team.GetPlayers(2)
		end
	elseif GMName == "Jailbreak" && GAMEMODE.Author == "Chessnut" then -- Chessnut's Jailbreak
		PowerRounds.CurrentGM = "Jailbreak"
		PowerRounds.CurrentGMSpecific = "ChessnutJailbreak"
		function GamemodePlayers(Ply, Type)
			if (Type == 4 && j:Team() == TEAM_GUARD) || (Type == 6 && j:Team() == TEAM_GUARD_DEAD) then
				return PR_ROLE_BAD
			elseif (Type == 5 && j:Team() == TEAM_PRISONER) || (Type == 7 && j:Team() == TEAM_PRISONER_DEAD) then
				return PR_ROLE_GOOD
			else
				return PR_ROLE_SPEC
			end
		end
		function GamemodeAllPlayers()
			return player.GetAll()
		end
	elseif GMName == "Jail Break" && istable(JB) && isfunction(JB.DebugPrint) then -- Excl's Jailbreak
		PowerRounds.CurrentGM = "Jailbreak"
		PowerRounds.CurrentGMSpecific = "ExclJailbreak"
		function GamemodePlayers(Ply)
			if Ply:Team() == TEAM_GUARD then
				return PR_ROLE_BAD
			elseif Ply:Team() == TEAM_PRISONER then
				return PR_ROLE_GOOD
			else
				return PR_ROLE_SPEC
			end
		end
		function GamemodeAllPlayers()
			local Players = team.GetPlayers(TEAM_GUARD)
			table.Add(Players, team.GetPlayers(TEAM_PRISONER) )
			return Players
		end
	elseif GMName == "Jailbreak" && GAMEMODE.Author == "my_hat_stinks" then -- my_hat_stinks Jailbreak
		PowerRounds.CurrentGM = "Jailbreak"
		PowerRounds.CurrentGMSpecific = "MyHatStinksJailbreak"
		function GamemodePlayers(Ply)
			if Ply:Team() == TEAM_JAILOR then
				return PR_ROLE_BAD
			elseif Ply:Team() == TEAM_PRISONER then
				return PR_ROLE_GOOD
			else
				return PR_ROLE_SPEC
			end
		end
		function GamemodeAllPlayers()
			local Players = team.GetPlayers(TEAM_JAILOR)
			table.Add(Players, team.GetPlayers(TEAM_PRISONER) )
			return Players
		end
	elseif GMName == "Deathrun" then -- Arizard's Deathrun and Mr Gash's Deathrun
		PowerRounds.CurrentGM = "Deathrun"
		if GAMEMODE.Author == "Arizard" then
			PowerRounds.CurrentGMSpecific = "ArizardDeathrun"
		elseif GAMEMODE.Author == "Mr. Gash" then
			PowerRounds.CurrentGMSpecific = "MrGashDeathrun"
		end
		function GamemodePlayers(Ply)
			if Ply:Team() == TEAM_DEATH then
				return PR_ROLE_BAD
			elseif Ply:Team() == TEAM_RUNNER then
				return PR_ROLE_GOOD
			else
				return PR_ROLE_SPEC
			end
		end
		function GamemodeAllPlayers()
			local Players = team.GetPlayers(TEAM_DEATH)
			table.Add(Players, team.GetPlayers(TEAM_RUNNER) )
			return Players
		end
	elseif GMName == "Guess Who" then -- Guess Who
		PowerRounds.CurrentGM = "GuessWho"
		PowerRounds.CurrentGMSpecific = "GuessWho"
		function GamemodePlayers(Ply)
			if Ply:Team() == TEAM_SEEKING then
				return PR_ROLE_BAD
			elseif Ply:Team() == TEAM_HIDING then
				return PR_ROLE_GOOD
			else
				return PR_ROLE_SPEC
			end
		end
		function GamemodeAllPlayers()
			local Players = team.GetPlayers(TEAM_SEEKING)
			table.Add(Players, team.GetPlayers(TEAM_HIDING) )
			return Players
		end
	elseif GMName == "Homicide" then -- Homicide
		PowerRounds.CurrentGM = "Murder"
		PowerRounds.CurrentGMSpecific = "Homicide"
		function GamemodePlayers(Ply)
			if Ply:GetMurderer() then
				return PR_ROLE_BAD
			else
				return PR_ROLE_GOOD
			end
		end
		function GamemodeAllPlayers()
			return team.GetPlayers(2)
		end
	end

	if CLIENT then
		if PowerRounds.NextPos.TextAllignH == TEXT_ALIGN_BOTTOM && PowerRounds.NextPos.TextAllignW == TEXT_ALIGN_LEFT && PowerRounds.NextPos.H == 15 && PowerRounds.NextPos.W == 15 then
			PowerRounds.NextPos.TextAllignH = TEXT_ALIGN_TOP
		end
	else
		hook.Run("PowerRoundsPST")
	end
end)


if CLIENT then
	net.Receive("PowerRoundsChat", function()
		local Chat = {}
		local Amount = net.ReadUInt(8)

		for i = 1, Amount do
			local PType = net.ReadUInt(1)
			if PType == 0 then
				local Text = net.ReadString()
				table.insert(Chat, Text)
			elseif PType == 1 then
				local R = net.ReadUInt(8)
				local G = net.ReadUInt(8)
				local B = net.ReadUInt(8)
				table.insert(Chat, Color(R, G, B) )
			end
		end

		if #Chat != 0 then
			chat.AddText(unpack(Chat) )
		end
	end)
end


function PowerRounds.Access(Ply, Access)
	local HasAccess = false
	if ULib && PowerRounds.UseULX then
		HasAccess = ULib.ucl.query(Ply, Access)
	else
		if Access == "PowerRounds_Vote" then
			HasAccess = true
		elseif Access == "PowerRounds_Force" then
			HasAccess = Ply:IsAdmin()
		end
	end
	if !HasAccess then
		if SERVER then
			MsgC(Color(255, 0, 0), "[PowerRounds] " .. Ply:Name() .. "|" .. Ply:SteamID() .. " has attempted to cheat the system! By accessing '" .. Access .. "' while not having access!")
		end
	end

	return HasAccess
end

--[[PowerRounds.GetRole Usage:
	Arguments:
		Player object	The player to get role of

	Returns:
		PR_ROLE_*	value. All values: PR_ROLE_ANY(When can't determine), PR_ROLE_BAD(muderers/traitors/hunters/guards), PR_ROLE_GOOD(bystanders/innocents/detectives/props/prisoners), PR_ROLE_SPEC(Spectator)
		Boolean		(Only TTT)Is the player Detective
]]
function PowerRounds.GetRole(Ply)
	local Role, IsDetective = GamemodePlayers(Ply)
	return Role or PR_ROLE_ANY, IsDetective or false
end

if SERVER then


	--[[PowerRounds.SetRole Usage:
		Arguments:
			Player object	The player to set role for
			PR_ROLE_* value.   All values: PR_ROLE_BAD(muderers/traitors/hunters/guards), PR_ROLE_GOOD(bystanders/innocents/props/prisoners), PR_ROLE_SPECIAL(Currently only for TTT, sets to Detective)
	]]


	--[[PowerRounds.SendRole Usage:
		Arguments:
			Player object	The player to send the role to, use after changing role mid game(Currently only for TTT)
	]]

	function PowerRounds.SendRole(Ply)
		print("Using PowerRounds.SendRole in a gamemode that doesn't support it (Only TTT does)")
	end


	--[[PowerRounds.EndRound Usage:
		Arguments:
			PR_WIN_* value.   PR_WIN_BAD (muderers/traitors/hunters/guards),  PR_WIN_GOOD (bystanders/innocents/props/prisoners),  PR_WIN_NONE
			Player object(Only Murder gamemode)   Murdered from that round

	]]
	function PowerRounds.EndRound(Type)
		-- Function created elsewhere, dont mind it being empty here
	end


end

--[[PowerRounds.Players Usage:
	Arguments:
		Type number		Type ID of who to get: 1 = All, 2 = Alive(Without SpecDM), 3 = Alive(All alive), 4 = Only alive muderers/traitors/hunters/guards(Without SpecDM), 5 = Only alive bystanders/innocents/detectives/props/prisoners(Without SpecDM), 6 = All muderers/traitors/hunters/guards, 7 = All bystanders/innocents/detectives/props/prisoners
		(OPTIONAL)Player object OR table of Player objects		Player(s) to exclude from returned list.

	Returns:
		Table of player objects
]]
function PowerRounds.Players(Type, Exclude)
	local PlayerList = GamemodeAllPlayers()

	if Type == 1 then
		return PlayerList
	end

	local Players = {}

	for _, j in ipairs(PlayerList) do
		if (!istable(Exclude) && j != Exclude) || (istable(Exclude) && !table.HasValue(Exclude, j) ) then
			if Type == 2 then
				if j:Alive() && !j:GetNWBool("SpecDM_Enabled", false) then
					table.insert(Players, j)
				end
			elseif Type == 3 then
				if j:Alive() then
					table.insert(Players, j)
				end
			elseif (Type == 4 && j:Alive() && !j:GetNWBool("SpecDM_Enabled", false) ) || Type == 6 then
				local Role = GamemodePlayers(j, Type)
				if Role == PR_ROLE_ANY || Role == PR_ROLE_BAD then
					table.insert(Players, j)
				end
			elseif (Type == 5 && j:Alive() && !j:GetNWBool("SpecDM_Enabled", false) ) || Type == 7 then
				local Role = GamemodePlayers(j, Type)
				if Role == PR_ROLE_ANY || Role == PR_ROLE_GOOD then
					table.insert(Players, j)
				end
			end
		end
	end

	return Players
end