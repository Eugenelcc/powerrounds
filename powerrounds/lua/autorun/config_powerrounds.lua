if !PowerRounds then PowerRounds = {} end
include("sh_powerrounds.lua")
--[[ Main Settings ]]--

	PowerRounds.ShowForPlayer = true -- Should it show the text in te middle of screen when round starts on everyones screen
	PowerRounds.PREvery = 5 -- Will run a PR every {set} rounds
	PowerRounds.SameInRow = false -- Should same PR be able to start 2 times in a row

	PowerRounds.ChatCommand = "!prmenu" -- Command that you type in chat to open power round menu
	PowerRounds.ChatInfoCommand = "!prinfo" -- Command that you type in chat to show name and description of the current PR

	PowerRounds.ChatInfoText = "Current PR is '{Name}' and what it does is '{Description}'" -- Text that will appear when a person writes in chat for PR info. {Name} = Name of the PR, {Description} = Nescription of the PR
	PowerRounds.ChatInfoNotPRText = "Current round is not a PR" -- Text that will appear when a person writes in chat for PR info , but it isn't a PR round.

	PowerRounds.UseULX = true -- If true addon will use ULX permissions for stuff like forcing PR in menu, if false it will use default built in admin, If ULX will not be available it will just use default built in admin

	PowerRounds.ForceNotify = true -- If true the ForceChatText will appear in chat when a PR is forced, if false only the person forcing it will see the text
		PowerRounds.ForceChatText = "{ForcerName} has forced next round to be '{PRName}' Power Round" -- Text that will appear in chat when a round is forced. {ForcerName} = Name of person that forced it, {PRName} = Name of the round forced
		PowerRounds.ForceChatColor = Color(0, 255, 0) -- Color that the text in chat will be

--[[New]]	PowerRounds.VoteTime = 60 -- Hold long vote time will last after first person votes
--[[New]]	PowerRounds.VotesPerMap = 2 -- How many voted PR rounds are allowed per map
--[[New]]	PowerRounds.VoteNotify = true -- If true the VoteChatText will appear in chat when someone votes for a PR, if false only the person voting will see the text
--[[New]]		PowerRounds.VoteChatText = "{VoterName} has voted next round to be '{PRName}' Power Round. {TimeLeft} seconds left until voting ends, use !prmenu to cast your vote!" -- Text that will appear in chat when someone votes for a round. {VoterName} = Name of person that voted, {PRName} = Name of the round voted for, {TimeLeft} = Seconds until voting ends
--[[New]]		PowerRounds.VoteChatColor = Color(160, 160, 160) -- Color that the text in chat will be
--[[New]]		PowerRounds.VoteEndChatText = "'{PRName}' Has been voted to be the next round Power Round!" -- Text that will appear in chat when voting ends. {PRName} = Name of the round that won the vote
--[[New]]		PowerRounds.VoteEndChatColor = Color(0, 255, 0) -- Color that the vote end text in chat will be
--[[New]]		PowerRounds.VotedAlreadyChatText = "You have already voted this time!" -- Text that will appear in chat when they try to vote second time in the same vote.
--[[New]]		PowerRounds.VotedAlreadyChatColor = Color(255, 0, 0) -- Color that the voted already text in chat will be
--[[New]]		PowerRounds.VotedPerMapChatText = "Max voted Power Rounds per map reached!" -- Text that will appear in chat when they try to vote while the PowerRounds.VotesPerMap has been reached
--[[New]]		PowerRounds.VotedPerMapChatColor = Color(255, 0, 0) -- Color that the voted already text in chat will be

--[[New]]	PowerRounds.NoAccessChatText = "Sorry, but you do not have access to vote for Power Rounds or force them" -- Text that appears in chat if they try to open Power Round menu without having access
--[[New]]	PowerRounds.NoAccessChatColor = Color(255, 0, 0) -- Color that the No Access text in chat will be


	PowerRounds.SaveOverMap = true -- Should the round counter carry over maps?

--[[ End of Main Settings ]]--
--[[ Client Settings ]]--
if CLIENT then -- Don't touch

	PowerRounds.InfoShowTime = 10 -- How long the text and description should be shown [default: 10 (Same as default Murder black screen)]
	PowerRounds.MaxInfoWidth = ScrW() / 2 -- At what text and description width it should continue text in new line on screen [default: ScrW() / 2 (Half of screen size)]
	PowerRounds.InfoPos = { H = ScrH() / 2.5, W = ScrW() / 2 } -- Divides screen height/width in half, so text is in the middle [default: { H = ScrH() / 3, W = ScrW() / 2 } (Middle of screen)]

	PowerRounds.MenuFont = "coolvetica" -- http://wiki.garrysmod.com/page/Default_Fonts All gmod default font names available there

	PowerRounds.NameSize = 60 -- Font size for the PRs name text
	PowerRounds.NameFont = "coolvetica" -- http://wiki.garrysmod.com/page/Default_Fonts All gmod default font names available there

	PowerRounds.DescriptionSize = 35 -- Font size for the PRs description
	PowerRounds.DescriptionFont = "coolvetica" -- http://wiki.garrysmod.com/page/Default_Fonts All gmod default font names available there

	PowerRounds.ShowUntilNext = true -- Should it show how many rounds are left until next PR
		PowerRounds.NextPos = {H = 15, W = 15, TextAllignH = TEXT_ALIGN_TOP, TextAllignW = TEXT_ALIGN_LEFT} -- Divides screen height/width in half, so text is in the middle [default: { H = 1, W = 1 } (Top left corner)], TextAllign values: TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, TEXT_ALIGN_BOTTOM
		PowerRounds.NextClr = Color(255, 255, 255, 255) -- Color that the number should be
		PowerRounds.NextSize = 30 -- Size of the font for the text
		PowerRounds.NextTextOne = "{Num} round left until PR" -- Text when only one round is left until next PR {Num} = Rounds left, number
		PowerRounds.NextTextMultiple = "{Num} rounds left until PR" -- Text when more than 1 round is left until next PR {Num} = Rounds left, number
		PowerRounds.NextTextCurrent = "This is PR round" -- Text when this round is the PR
		PowerRounds.NextTextForced = " This is forced PR round" -- Text when this round is a forced PR
		PowerRounds.NextFont = "coolvetica" -- http://wiki.garrysmod.com/page/Default_Fonts All gmod default font names available there

	PowerRounds.Menu = {}

		PowerRounds.Menu.BGColor = Color(35, 35, 35, 255)
		PowerRounds.Menu.FGColor = Color(42, 42, 42, 255)

		PowerRounds.Menu.TitleColor = Color(19, 121, 245, 255)

		PowerRounds.Menu.CloseBtnColor = Color(151, 151, 151, 255)
		PowerRounds.Menu.CloseBtnBorderColor = Color(0, 0, 0, 255)
		PowerRounds.Menu.CloseBtnTextColor = Color(255, 255, 255, 255)

		PowerRounds.Menu.ForceBtnColor = Color(151, 151, 151, 255)
		PowerRounds.Menu.ForceBtnBorderColor = Color(0, 0, 0, 255)
		PowerRounds.Menu.ForceBtnTextColor = Color(255, 255, 255, 255)

end -- Don't touch
--[[ End of Client Settings ]]--

	--[[
	Gamemode names(Use the ones for Gamemode config for a round):
		Any = Will run on any supported gamemode
		TTT = Trouble in Terrorist Town
		Murder = Murder
		PropHunt = Prop Hunt
		Melonbomber = Melonbomber
		Jailbreak = Jailbreak
		GuessWho = Guess Who

	]]--

	--[[ All possible values for a power round
	PowerRounds.AddRound({
		Name = "Any Text",                                          --Any text, will be the power rounds name {Default: ""}
		Gamemode = "Any",                                           --Which gamemode should this Power ROund be for {Default: "Any"} Can be one of these: "TTT", "Murder", "Any"
		NameClr = Color(255,255,255,255),                           --Color that the Name will appear on round start {Default: Color(255,255,255,255) | white color}
		Description = "Any Text",                                   --Any text, will be the power rounds description {Default: ""}
		DescriptionClr = Color(1,255,255,255),                      --Color that the Description will appear on round start {Default: Color(255,255,255,255) | white color}
		ServerStartWait = 10,                                       --Time that the server should wait before running ServerStart function {Default: 0 | No waiting}
		WinTeamCondition = function(Ply) return Ply:Alive() end,    --Function that will run for every player playing when the round ends {Default: if player is alive} [Values: Ply = player] (Return: true = winner, false = not winner)
		ServerStart = function() end,                               --Function that will run when round starts {Default: empty function} (Runs once)
		ServerEnd = function(Winners, Losers) end,                  --Function that will run when round ends {Default: empty function} [Values: Winners = table of this rounds winners, Losers = table of this rounds losers]
		PlayersStart = function(Ply) end,                           --Function that will run for every player playing when round starts {Default: empty function} [Values: Ply = player]
		PlayersEnd = function(Ply, IsWinner) end,                   --Function that will run for every player playing when round ends {Default: empty function} [Values: Ply = player, IsWinner = Value returned by WinTeamCondition for that player]
		PlayerDeath = function(Ply, Attacker) end,                  --Function that will run when a person dies {Default: empty function} [Values: Ply = killed player, Attacker = killer] (Return: true = will stop things like: Punishment for teamkill)
		DoPlayerDeath = function(Ply, Attacker, DMGInfo) end,       --Function that will run when a person dies {Default: empty function} [Values: Ply = killed player, Attacker = killer, DMGInfo = damage info] (Return: true = will not create a ragdoll or add deaths)
		PlayerUpdate = function(Ply, Type, *Attacker*) end,         --**Attacker is only returned on player update that involves death** Function that will run when a person dies, goes spectator or disconnects {Default: empty function} [Values: Ply = player, Type = PR_PUPDATE_DISCONNECT or PR_PUPDATE_DIE or PR_PUPDATE_SPECTATOR,Attacker = killer]
		Think = function() end,                                     --Runs on every think hook {Default: empty function}
		PlayerCanPickupWeapon = function(Ply, Ent) end,             --Function that will run when a person gets a gun {Default: empty function} [Values: Ply = player, Ent = weapon] (Return: true = will let picking up, false = will not)
		PlayerShouldTakeDamage = function(Ply, Ent) end,            --Function that will run when a person gets hurt {Default: empty function} [Values: Ply = player, Ent = player that hurt] (Return: true = will take damage, false = will not)
		ScalePlayerDamage = function(Ply, HitGroup, DMGInfo) end,   --Function that will run when a person gets hurt {Default: empty function} [Values: Ply = player, HitGroup = where the person was hit, DMGInfo = damage info] (Return: Edited DMGInfo)
		TTTPlayerSpeed = function(Ply) end,                         --Function that will run whenever TTT needs to knowp players speed {Default: empty function} [Values: Ply = player] (Return: multiplier number)
		BlockKarma = false,                                         --{TTT only}If true no karma will be lost or gained if you kill that round, if false you will loose or gain karma from kills. {Default: false}
		BlockScore = false,                                         --{TTT only}If true no score will be lost or gained if you kill that round, if false you will loose or gain score from kills. {Default: false}
		BlockTTTDamagelogs = false,                                 --{TTT only}If true TTT Damagelogs add-on(https://facepunch.com/showthread.php?t=1416843) will be unusable for that round. {Default: false}
		CustomRoundEnd = false,                                     --Will the round end in a custom way {Default: false} !!!If you set this to true, remember to have code that will end the round!!!
		RunCondition = function() return true end,                  --Function that will run when this PR is randomly chosen for the next round {Default: Always allow} (Return: true = Allows the round to be chosen, false = Disallows)

		HUDPaint = function() end,                                  --{Client only, of course :D }Function that can be used for drawing stuff on screen {Default: empty function} (Runs in the HUDPaint hook while the round is going)
		ClientStart = function() end,                               --{Client only}Function that will run when round starts {Default: empty function} (Runs once)
		ClientEnd = function() end,                                 --{Client only}Function that will run when round ends {Default: empty function} (Runs once)

		<<<<New ones!>>>>

		BlockTShop = false,											--{TTT only}If true traitors will not be able to purchase stuff from the traitor shop {Default: false}
		BlockDShop = false,											--{TTT only}If true detectives will not be able to purchase stuff from the detective shop {Default: false}

		SHOOK_HookName = function(hook provided parameters) end,	--{Server only} Easier and more clean way of adding other hooks to your round, automatically added when round starts and removed when it ends for example for OnPlayerChat hook you'd make the function SHOOK_OnPlayerChat  (Return: Anything you want to be returned in the hook)
		CHOOK_HookName = function(hook provided parameters) end,	--{Client only} Used same as SHOOK_, usable client side, while SHOOK_ is server side  (Return: Anything you want to be returned in the hook)

		STIMER_Num_Repeat_Name = function() end,					--{Server only} Easier and more clean way of adding repeating timers to your round, automatically added when round starts and removed when it ends
																		for example you want a timer that repeats every 3 seconds, you'd make the function name STIMER_3_AnyNameHere
																		or if you only want to to run twice, once after 3 seconds, then again after 3 more, then for example, do   STIMER_3_2_AnyNameHere
																		Can also be used as STIMER_Num_Name then Repeat defaults to 0 and the timer keeps repeating until round end
																		If you need to access the timer to reset it or whatever, the name gets set to    PowerRoundsTimer_Name       Name being the one you set in the function name
		CTIMER_Num_Repeat_Name = function() end,					--{Client only} Same as STIMER_ just runs on client side
	})



	While the round is going you can access the round table with PowerRounds.CurrentPR
	So you can add your own functions and name them whatever you want and then access them using PowerRounds.CurrentPR.YourFunctionNameHere

	Example:
		PowerRounds.AddRound({
			Name = "MyOwnRound",
			Gamemode = "TTT",
			NameClr = Color(191, 12, 12),
			Description = "Description here",
			DescriptionClr = Color(191, 12, 12),
			MyOwnCustomFunction = function(Ply)
				print("Ran my custom function")
			end,
			ServerStart = function()
				PowerRounds.CurrentPR.MyOwnCustomFunction()
			end
		})


		Other standalone useful functions can be found in sh_powerrounds.lua line 358
	]]--


	PowerRounds.AddRound({
		Name = "No communication",
		Gamemode = "Any",
		NameClr = Color(191, 12, 12),
		Description = "Voice and chat communication is disabled!",
		DescriptionClr = Color(191, 12, 12),
		SHOOK_PlayerCanHearPlayersVoice = function() return false end,
		SHOOK_PlayerCanSeePlayersChat = function() return false end,
		SHOOK_TTTPlayerRadioCommand = function() return true end,
		CHOOK_OnPlayerChat = function(Ply, Msg, Team, Dead)
			if Dead then return true end
		end,
		ServerStart = function()
			local PlyMeta = FindMetaTable("Player")
			TempOldSendLastWordsForPR = PlyMeta.SendLastWords
			PlyMeta.SendLastWords = function() end
		end,
		ServerEnd = function()
			local PlyMeta = FindMetaTable("Player")
			PlyMeta.SendLastWords = TempOldSendLastWordsForPR
			TempOldSendLastWordsForPR = nil
		end
	})

	PowerRounds.AddRound({
		Name = "Slow motion",
		Gamemode = "Any",
		NameClr = Color(12, 121, 255),
		Description = "The whole game is 2 times slower for this round!",
		DescriptionClr = Color(12, 121, 255),
		ServerStart = function() game.SetTimeScale(0.5) end,
		ServerEnd = function() game.SetTimeScale(1) end
	})

	PowerRounds.AddRound({
		Name = "Low gravity",
		Gamemode = "Any",
		NameClr = Color(12, 121, 255),
		Description = "The gravity is 3 times lower for this round!",
		DescriptionClr = Color(12, 121, 255),
		ServerStart = function() game.ConsoleCommand("sv_gravity 200\n") end,
		ServerEnd = function() game.ConsoleCommand("sv_gravity 600\n") end
	})

	PowerRounds.AddRound({ -- Included this more of an example for creating role changing round
		Name = "TDM Any Gamemode",
		Gamemode = "Any",
		NameClr = Color(12, 121, 255),
		Description = "Half of you are one team, other half the other team, it's a fight for your team!",
		DescriptionClr = Color(12, 121, 255),
		PlayersStart = function(Ply)
			--Ply:StripWeapons() -- Can strip weapons and give ones after
			if PowerRounds.GetRole(Ply) == PR_ROLE_BAD then
				--Ply:Give("weapon_for_bad_guy")
			else
				--Ply:Give("weapon_for_good_guy")
			end
		end,
		PlayerShouldTakeDamage = function(Ply, Ent) -- No team damage
			if Ent != Ply && Ent:IsPlayer() && PowerRounds.GetRole(Ply) == PowerRounds.GetRole(Ent) then
				return false
			end
		end,
		ServerStart = function()
			local Players = PowerRounds.Players(2) -- Get all playing players
			local PlayerNum = table.Count(Players)
			local BadNum = PlayerNum / 2

			for i = 1, PlayerNum do
				local Num = math.random(1, #Players)
				local Ply = Players[Num]

				if BadNum > 0 then
					PowerRounds.SetRole(Ply, PR_ROLE_BAD)
					BadNum = BadNum - 1
				else
					PowerRounds.SetRole(Ply, PR_ROLE_GOOD)
				end
				--Ply:CalculateSpeed() -- Something neccessary for Murder, because Murderer can run faster
				Ply:Spawn() --Keep in mind some gamemodes might need you to spawn the player again, because they might be on the wrong sides of maps
				table.remove(Players, Num)
			end
		end
	})

	PowerRounds.AddRound({
		Name = "TDM",
		Gamemode = "Murder",
		NameClr = Color(12, 121, 255),
		Description = "Half of you are murderers, other half bystanders, you only get your teams weapon and no hands, it's a fight for your team!",
		DescriptionClr = Color(12, 121, 255),
		CustomRoundEnd = true,
		PlayersStart = function(Ply)
			Ply:StripWeapons()
			if Ply:GetMurderer() then
				Ply:Give("weapon_mu_knife")
				Ply:SelectWeapon("weapon_mu_knife")
			else
				Ply:Give("weapon_mu_magnum")
				Ply:SelectWeapon("weapon_mu_magnum")
			end
		end,
		PlayerShouldTakeDamage = function(Ply, Ent)
			if Ply.Murderer == Ent.Murderer then
				return false
			end
		end,
		ServerStart = function()
			local Players = PowerRounds.Players(2)
			local PlayerNum = #Players
			local BystanderNum = PlayerNum / 2

			for i = 1, PlayerNum do
				local Num = math.random(1, #Players)
				local Ply = Players[Num]

				if BystanderNum > 0 then
					Ply:SetMurderer(false)
					BystanderNum = BystanderNum - 1
				else
					Ply:SetMurderer(true)
				end
				Ply:CalculateSpeed()
				table.remove(Players, Num)
			end
		end,
		PlayerDeath = function() return true end,
		PlayerUpdate = function(Ply)
			local Murderers = {}
			local Bystanders = {}
			for _, j in ipairs(PowerRounds.Players(2, Ply) ) do
				if j:GetMurderer() then
					table.insert(Murderers, j)
				else
					table.insert(Bystanders, j)
				end
			end

			if #Bystanders == 0 then
				PowerRounds.EndRound(PR_WIN_BAD, Murderers[1])
			elseif #Murderers == 0 then
				PowerRounds.EndRound(PR_WIN_GOOD)
			end
		end,
	})

	PowerRounds.AddRound({
		Name = "OP Murderer",
		Gamemode = "Murder",
		NameClr = Color(191, 12, 12),
		Description =  "All bystanders get a gun, but the murderer gets an RPG and grenades plus extra health depending on how many bystanders there are.",
		DescriptionClr = Color(191, 12, 12),
		PlayersStart = function(Ply)
			if Ply:GetMurderer() then
				Ply:Give("weapon_rpg")
				Ply:Give("weapon_frag")
				Ply:SetAmmo(20, 10) -- set frag ammo to 20
				Ply:SetAmmo(3, 8) -- set RPG ammo to 3
				local PlayerNum = #PowerRounds.Players(2) - 1
				if PlayerNum > 0 && PlayerNum < 3 then
					Ply:SetHealth(100)
				elseif PlayerNum > 2 && PlayerNum < 6 then
					Ply:SetHealth(200)
				elseif PlayerNum > 5 then
					Ply:SetHealth(300)
				end
			else
				Ply:Give("weapon_mu_magnum")
			end
		end
	})

	PowerRounds.AddRound({
		Name = "RPG Madness",
		Gamemode = "Murder",
		NameClr = Color(12, 121, 255),
		Description = "No guns or knives but everyone gets an rpg with loads of ammo. Normal murder rules apply!",
		DescriptionClr = Color(12, 121, 255),
		PlayerDeath = function(Ply, Attacker)
			if IsValid(Attacker) && !Attacker:GetMurderer() && !Ply:GetMurderer() && Attacker:HasWeapon("weapon_rpg") then
				Attacker:DropWeapon(Attacker:GetWeapon("weapon_rpg") )
			end
		end,
		PlayerCanPickupWeapon = function(Ply, Ent)
			return Ent:GetClass() == "weapon_rpg" && !Ply:GetTKer()
		end,
		PlayersStart = function(Ply)
			Ply:StripWeapon("weapon_rp_hands")
			if Ply:HasWeapon("weapon_mu_knife") then
				Ply:StripWeapon("weapon_mu_knife")
			end
			if Ply:HasWeapon("weapon_mu_magnum") then
				Ply:StripWeapon("weapon_mu_magnum")
			end
			Ply:Give("weapon_rpg")
			Ply:SelectWeapon("weapon_rpg")
			Ply:SetAmmo(9999, 8) -- set RPG ammo to 9999
		end
	})

	PowerRounds.AddRound({
		Name = "Free for all",
		Gamemode = "Murder",
		NameClr = Color(191, 12, 12),
		Description = "You get both a gun and a knife, kill everyone you see! Last one standing wins!",
		DescriptionClr = Color(191, 12, 12),
		CustomRoundEnd = true,
		PlayerDeath = function() return true end,
		PlayerCanPickupWeapon = function() return true end,
		PlayerUpdate = function(Ply)
			local Alive = PowerRounds.Players(2, Ply)
			if #Alive < 2 then
				PowerRounds.EndRound(PR_WIN_GOOD, Alive[1])
			end
		end,
		PlayersStart = function(Ply)
			Ply:SetMurderer(false)
			Ply:Give("weapon_mu_magnum")
			Ply:Give("weapon_mu_knife")
			Ply:CalculateSpeed()
		end
	})

	PowerRounds.AddRound({
		Name = "Cat and mice",
		Gamemode = "Murder",
		NameClr = Color(191, 12, 12),
		Description = "No bystanders get guns but the murderer gets a knife and a gun, but he only gets 2 minutes to kill everyone before the bystanders win!",
		DescriptionClr = Color(191, 12, 12),
		ServerStartWait = 10,
		PlayerCanPickupWeapon = function(Ply)
			return Ply:GetMurderer()
		end,
		PlayersStart = function(Ply)
			if Ply:HasWeapon("weapon_mu_magnum") then
				Ply:StripWeapon("weapon_mu_magnum")
			end
			if Ply:GetMurderer() then
				Ply:Give("weapon_mu_magnum")
				Ply:Give("weapon_mu_knife")
			end
		end,
		STIMER_120_1_RoundEnd = function()
			local Players = PowerRounds.Players(1)
			for _, j in ipairs(Players) do
				if j:GetMurderer() then
					PowerRounds.EndRound(PR_WIN_GOOD, j)
					return
				end
			end
			PowerRounds.EndRound(PR_WIN_GOOD) -- Just in case murderer is not here?
		end
	})

	PowerRounds.AddRound({
		Name = "Mice and cat",
		Gamemode = "Murder",
		NameClr = Color(12, 121, 255),
		Description = "Murderer doesn't have a knife and all bystanders have guns, but the bystanders only have 1 minute to find and kill the murderer, before he wins!",
		DescriptionClr = Color(12, 121, 255),
		ServerStartWait = 10,
		PlayerCanPickupWeapon = function(Ply)
			return !Ply:GetMurderer()
		end,
		PlayersStart = function(Ply)
			Ply:Give("weapon_mu_magnum")
			if Ply:HasWeapon("weapon_mu_knife") then
				Ply:StripWeapon("weapon_mu_knife")
			end
		end,
		STIMER_60_1_RoundEnd = function()
			local Players = PowerRounds.Players(1)
			for _, j in ipairs(Players) do
				if j:GetMurderer() then
					PowerRounds.EndRound(PR_WIN_BAD, j)
					return
				end
			end
			PowerRounds.EndRound(PR_WIN_BAD)
		end
	})

	PowerRounds.AddRound({
		Name = "Tag",
		Gamemode = "Murder",
		NameClr = Color(191, 12, 12),
		Description = "When the murderer stabs someone they become the new murderer. Every 30 second the current murderer dies and a new person becomes murderer",
		DescriptionClr = Color(191, 12, 12),
		ServerStartWait = 10,
		CustomRoundEnd = true,
		PlayerCanPickupWeapon = function(Ply)
			return Ply:GetMurderer()
		end,
		PlayersStart = function(Ply)
			if Ply:HasWeapon("weapon_mu_magnum") then
				Ply:StripWeapon("weapon_mu_magnum")
			end
		end,
		DoPlayerDeath = function(Ply, Attacker)
			if IsValid(Attacker) && Attacker.Murderer then
				return false
			end
		end,
		PlayerDeath = function(Ply, Attacker)
			if Ply.Murderer && Ply == Attacker then
				PowerRounds.CurrentPR.SetRandomMurderer(Ply)
			end
			if IsValid(Attacker) && Attacker:IsPlayer() then
				if Attacker:GetMurderer() && Attacker != Ply then
					PowerRounds.Chat(Ply, Color(255, 0, 0), "You are the new 'it'!")
					timer.Simple(0.5, function()
						Ply:Spawn()
						Ply:SetMurderer(true)
						Ply:CalculateSpeed()
						Ply:Give("weapon_mu_knife")
						Attacker:SetMurderer(false)
						Attacker:CalculateSpeed()
						if Attacker:HasWeapon("weapon_mu_knife") then
							Attacker:StripWeapon("weapon_mu_knife")
						end
					end)
					timer.Start("PowerRoundsTimer_TagChangeMurderer") -- Restart timer
				end
			end
			return false
		end,
		SetRandomMurderer = function(Exclude)
			local NextMurderer = {}
			for _, j in ipairs(PowerRounds.Players(2, Exclude) ) do
				if j:GetMurderer() then
					j:SetMurderer(false)
					j:Kill()
				else
					table.insert(NextMurderer, j)
				end
			end
			local Ply = NextMurderer[math.random(1, #NextMurderer)]
			Ply:SetMurderer(true)
			Ply:Give("weapon_mu_knife")
			Ply:CalculateSpeed()
			PowerRounds.Chat(Ply, Color(255, 0, 0), "You are the new 'it'!")
			timer.Start("PowerRoundsTimer_TagChangeMurderer") -- Restart timer
		end,
		PlayerUpdate = function(Ply, Attacker)
			local Alive = PowerRounds.Players(2, Ply)

			if #Alive < 2 then
				PowerRounds.EndRound(PR_WIN_GOOD, Alive[1] or PowerRounds.Players(1)[1])
			end
		end,
		STIMER_30_TagChangeMurderer = function() PowerRounds.CurrentPR.SetRandomMurderer() end
	})

	PowerRounds.AddRound({
		Name = "Knife battle",
		Gamemode = "TTT",
		NameClr = Color(191, 12, 12),
		Description = "Everyone is an innocent with a knife. Last one alive is the winner!",
		DescriptionClr = Color(191, 12, 12),
		BlockKarma = true,
		BlockScore = true,
		BlockTTTDamagelogs = true,
		CustomRoundEnd = true,
		PlayersStart = function(Ply)
			Ply:StripWeapons()
			Ply:SetRole(ROLE_INNOCENT)
			Ply:Give("weapon_ttt_knife")
		end,
		STIMER_1_GiveKnife = function()
			for _, j in ipairs(PowerRounds.Players(2) ) do
				if !j:HasWeapon("weapon_ttt_knife") then
					j:Give("weapon_ttt_knife")
				end
			end
		end,
		PlayerCanPickupWeapon = function(Ply, Ent)
			return Ent:GetClass() == "weapon_ttt_knife"
		end,
		PlayerUpdate = function(Ply)
			local Plys = PowerRounds.Players(2, Ply)
			if #Plys < 2 then
				PowerRounds.EndRound(PR_WIN_GOOD)
				if #Plys == 1 then
					PowerRounds.Chat("All", Color(0, 255, 0), "Winner of this round was: " .. Plys[1]:Nick() )
				end
			end
		end
	})

	PowerRounds.AddRound({
		Name = "Headshots only",
		Gamemode = "TTT",
		NameClr = Color(191, 12, 12),
		Description = "Bullets will hurt people only in their head. Nothing else will hurt them. Normal TTT rules apply!",
		DescriptionClr = Color(191, 12, 12),
		ScalePlayerDamage = function(Ply, HitGroup, DMGInfo)
			if HitGroup != HITGROUP_HEAD || !DMGInfo:IsBulletDamage() && Ply != DMGInfo:GetAttacker() then
				DMGInfo:SetDamage(0)
				return DMGInfo
			end
		end
	})

	PowerRounds.AddRound({
		Name = "TDM",
		Gamemode = "TTT",
		NameClr = Color(191, 12, 12),
		Description = "Half of you are traitors, other half detectives. It's a fight for your team!",
		DescriptionClr = Color(191, 12, 12),
		PlayerShouldTakeDamage = function(Ply, Ent)
			if Ply.role == Ent.role then
				return false
			end
		end,
		ServerStart = function()
			local Players = PowerRounds.Players(2)
			local PlayerNum = #Players
			local DetectiveNum = PlayerNum / 2

			for i = 1, PlayerNum do
				local Num = math.random(1, #Players)
				local Ply = Players[Num]

				if DetectiveNum > 0 then
					Ply:SetRole(ROLE_DETECTIVE)
					DetectiveNum = DetectiveNum - 1
				else
					Ply:SetRole(ROLE_TRAITOR)
				end
				Ply:SetDefaultCredits()
				table.remove(Players, Num)
			end
		end
	})

	PowerRounds.AddRound({
		Name = "Shuffle deathmatch",
		Gamemode = "TTT",
		NameClr = Color(191, 12, 12),
		Description = "You are split in 2 teams, each time someone dies they get moved to opposite team. Team that has no more players loses.",
		DescriptionClr = Color(191, 12, 12),
		ServerStart = function()
			local Players = PowerRounds.Players(2)
			local PlayerNum = #Players
			local DetectiveNum = PlayerNum / 2

			for i = 1, PlayerNum do
				local Num = math.random(1, #Players)
				local Ply = Players[Num]

				if DetectiveNum > 0 then
					Ply:SetRole(ROLE_DETECTIVE)
					DetectiveNum = DetectiveNum - 1
				else
					Ply:SetRole(ROLE_TRAITOR)
				end
				Ply:SetDefaultCredits()
				table.remove(Players, Num)
			end
			timer.Create("ShuffleDMPRTimer", 180, 1, function() -- Start draining health after this many seconds
				PowerRounds.CurrentPR.NoSpawn = true
				timer.Create("ShuffleDMHPDrainPRTimer", 1, 0, function() -- Change the 1 to how many seconds wait until next health drain
					for _, j in ipairs(PowerRounds.Players(2) ) do
						j:SetHealth(j:Health() - 2) -- Take away 2 health every time
						if j:Health() <= 0 then
							local effectdata = EffectData()
								effectdata:SetOrigin(j:GetPos() )
								effectdata:SetNormal(j:GetPos() )
								effectdata:SetMagnitude(8)
								effectdata:SetScale(1)
								effectdata:SetRadius(78)
								util.Effect("Sparks", effectdata)

							local ent = ents.Create("env_explosion")
								ent:SetPos(j:GetPos() )
								ent:SetOwner(j)
								ent:SetKeyValue("iMagnitude", "100")
								ent:Spawn()
								ent:Fire("Explode", 0, 0)
								ent:EmitSound("siege/big_explosion.wav", 250)
							j:Kill()
						end
					end
				end)
				PowerRounds.Chat("All", Color(255, 0, 0), "You are taking more than 3 minutes to do this! No more respawn! Draining your health as well!")
			end)
		end,
		ServerEnd = function()
			if timer.Exists("ShuffleDMPRTimer") then
				timer.Destroy("ShuffleDMPRTimer")
			end
			if timer.Exists("ShuffleDMHPDrainPRTimer") then
				timer.Destroy("ShuffleDMHPDrainPRTimer")
			end
		end,
		ScalePlayerDamage = function(Ply, HitGroup, DMGInfo)
			local Attacker = DMGInfo:GetAttacker()
			if IsValid(Attacker) && Attacker:IsPlayer() && Attacker:GetRole() == Ply:GetRole() then
				return true
			end
		end,
		PlayerDeath = function(Ply, Attacker)
			if !PowerRounds.CurrentPR.NoSpawn then
				timer.Simple(3, function()
					local Rag = Ply.server_ragdoll or Ply:GetRagdollEntity()
					if IsValid(Rag) then
						Rag:Remove()
					end
					local PRNewRole = ROLE_DETECTIVE
					if Ply:GetRole() == ROLE_DETECTIVE then
						PRNewRole = ROLE_TRAITOR
					end
					Ply:Spawn()
					Ply:SetRole(PRNewRole)
					SendTraitorList()
					SendDetectiveList()
				end)
			return false
			end
		end
	})

	PowerRounds.AddRound({
		Name = "Disguised mode",
		Gamemode = "TTT",
		NameClr = Color(191, 12, 12),
		Description = "Everyone is disguised. Normal TTT rules apply.",
		DescriptionClr = Color(191, 12, 12),
		PlayersStart = function(Ply)
			Ply:SetNWBool("disguised", true)
		end,
		ServerStart = function()
			for _, j in ipairs(EquipmentItems[ROLE_TRAITOR]) do
				if j.id == EQUIP_DISGUISE then
					EquipmentItems[ROLE_TRAITOR].n = nil
					PowerRoundsTempHoldEquipment = table.remove(EquipmentItems[ROLE_TRAITOR], n)
					break
				end
			end
		end,
		ServerEnd = function()
			table.insert(EquipmentItems[ROLE_TRAITOR], PowerRoundsTempHoldEquipment)
		end
	})

	PowerRounds.AddRound({
		Name = "Sudden death",
		Gamemode = "TTT",
		NameClr = Color(191, 12, 12),
		Description = "Everyone has 1 HP! Normal TTT rules apply.",
		DescriptionClr = Color(191, 12, 12),
		PlayersStart = function(Ply)
			Ply:SetHealth(1)
			Ply:SetMaxHealth(1)
		end
	})



PowerRounds.DoneRounds = true -- Don't touch this!
--[[ /Settings ]]-- DO NOT edit anything further than this, if you don't know what you are doing!!

if CLIENT then
	surface.CreateFont("PowerRoundsDescriptionFont", {
		font = PowerRounds.DescriptionFont,
		size = PowerRounds.DescriptionSize,
		weight = 500
	})

	surface.CreateFont("PowerRoundsNameFont", {
		font = PowerRounds.NameFont,
		size = PowerRounds.NameSize,
		weight = 500
	})

	surface.CreateFont("PowerRoundsNextFont", {
		font = PowerRounds.NextFont,
		size = PowerRounds.NextSize,
		weight = 500
	})

	surface.CreateFont("PowerRoundsMenu20", {
		font = PowerRounds.MenuFont,
		size = 20,
		weight = 500
	})

	surface.CreateFont("PowerRoundsMenu30", {
		font = PowerRounds.MenuFont,
		size = 30,
		weight = 600
	})

	surface.CreateFont("PowerRoundsMenu22", {
		font = PowerRounds.MenuFont,
		size = 22,
		weight = 500
	})
end