
Game = {
	DeckChoice = { Rebel = "", Imperial = "" },
	Systems = { Imperial = {}, Rebel = {}, DSUC = "", RebelBase = {ID = "", Name = ""} },
	Players = { Total = 2, Rebels = 1, Imperials = 1},
	Round = 0,
	Phase = "Setup",
	Turn = {Num = 0, Faction = "", Role = ""},
	Type = "Advanced",	--First|Advanced|Custom
	SubTitle = "",	--"Rise of the Empire";"Wider Front Lines"
	Flags = {
		RotE = true,
        WFL = true,
		GSDeck = false,	--use big galactic struggle deck?
		AdvancedTactics = false,
		UnitPlacement = "",	--Base or RotE
		Dealing = false,	--flag to limit dealing cards 1 at a time.
		Immediate = { Action = {Rebel = false, Imperial = false} },
		RebelBaseRevealed = false,
		RapidMobilization = false,	--does it need to be resolved?
		Painted = true,
		ContingencyPlan = false, --was it played?
		SweepTheArea = false,	--can imperials play sweep the area?
		Passed = {},	--[1]=false,[2]=false,[3]=false,[4]=false
		MissionHandOK = { Rebel = false, Imperial = false},	--flag that checks mission hand size during refresh.
		Busy =  {Rebel = false, Imperial = false},
		Build = {Rebel = false, Imperial = false},
		Slid = {Rebel = false, Imperial = false},
        ExitingCombat = false,
	},
	AI = {
		Active = false,
		Leaders={},
		Missions={},
		Systemns=nil,
		FleetCount=0,
		Fleets=nil,
	},--AI
	Leaders = {
		Pools = {
			Rebel = {"Princess Leia","Jan Dodonna","Mon Mothma","General Rieekan"},
			Imperial = {"Emperor Palpatine","Darth Vader","Grand Moff Tarkin", "General Tagge"},
		},
		Draws = { Rebel = {}, Imperial = {} },
		Recruits = { Rebel = {}, Imperial = {} },
		Objects = { Rebel = {}, Imperial = {} },
		Recruiting = { Rebel = "", Imperial = "" },
		NoRecruit = { Rebel = false, Imperial = false },
	},
	FactionSheets = { Rebel = {ID = "8d61bd"}, Imperial = {ID = "a3467f"} },
	Boards = {
		Game = {ID = "9f58ca"},
		Combat = {ID = "78fe4b"},
		Assignment = { Rebel = {ID = "d99608"}, Imperial = {ID = "9675be"} }
	},
}

Loaded = false	--flag for when game is done loading.
ResettingTactics = false
UnitHighlights = false
RepCount = 0	--used to break loops that go on too long.
GridSquareWidthRatio = 0.326
GridSquareHeightRatio = 0.328
SoundEnabled = true
CombatBoardUpdateID = ""	--used to suppress multiple updates within 1 second.
Step = ""  --the current step (settings to "" automatically triggers next step)
NextStep = ""	--the next pending step
ResumeStep = ""	--used when resuming from an interrupt.
SuppressVictoryCheck = false	--flag to temporarily suppress victory checking (when updating the board)...

Grid = {}	--board object will initialize it.
SystemDistance = {}	--board object will initiatlize this.
ImperialPanelCards = {}	--temporary array of objects for handling cards on the imperial player panels.
RebelPanelCards = {}	--temporary array of objects for handling cards on the rebel player panels.

--may not need!?!
LeaderInfo={}
LeaderInfo["Emperor Palpatine"] = {Faction="Imperial",Type="Admiral",Starting=true,SpaceTactic=3,GroundTactic=2,Diplomacy=3,Intel=2,SpecOps=0,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Grand Moff Tarkin"] = {Faction="Imperial",Type="Admiral",Starting=true,SpaceTactic=2,GroundTactic=1,Diplomacy=1,Intel=1,SpecOps=0,Logistics=1,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Darth Vader"] = {Faction="Imperial",Type="General",Starting=true,SpaceTactic=2,GroundTactic=3,Diplomacy=2,Intel=0,SpecOps=3,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["General Tagge"] = {Faction="Imperial",Type="General",Starting=true,SpaceTactic=1,GroundTactic=2,Diplomacy=0,Intel=0,SpecOps=1,Logistics=1,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Soontir Fel"] = {Faction="Imperial",Type="Admiral",Starting=false,SpaceTactic=2,GroundTactic=1,Diplomacy=0,Intel=1,SpecOps=2,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Admiral Piett"] = {Faction="Imperial",Type="Admiral",Starting=false,SpaceTactic=3,GroundTactic=1,Diplomacy=0,Intel=2,SpecOps=1,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Admiral Ozzel"] = {Faction="Imperial",Type="Admiral",Starting=false,SpaceTactic=2,GroundTactic=1,Diplomacy=0,Intel=1,SpecOps=0,Logistics=1,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Janus Greejatus"] = {Faction="Imperial",Type="Admiral",Starting=false,SpaceTactic=0,GroundTactic=0,Diplomacy=2,Intel=1,SpecOps=0,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Moff JerJerrod"] = {Faction="Imperial",Type="General",Starting=false,SpaceTactic=1,GroundTactic=1,Diplomacy=1,Intel=0,SpecOps=0,Logistics=1,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Colonel Yularen"] = {Faction="Imperial",Type="General",Starting=false,SpaceTactic=2,GroundTactic=2,Diplomacy=0,Intel=3,SpecOps=0,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["General Veers"] = {Faction="Imperial",Type="General",Starting=false,SpaceTactic=1,GroundTactic=3,Diplomacy=0,Intel=0,SpecOps=2,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Boba Fett"] = {Faction="Imperial",Type="General",Starting=false,SpaceTactic=0,GroundTactic=0,Diplomacy=0,Intel=2,SpecOps=3,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="Base"}
LeaderInfo["Admiral Motti"] = {Faction="Imperial",Type="Admiral",Starting=false,SpaceTactic=2,GroundTactic=1,Diplomacy=0,Intel=0,SpecOps=0,Logistics=1,MinorDiplomacy=1,MinorIntel=1,MinorSpecOps=0,Game="RotE"}
LeaderInfo["Director Krennic"] = {Faction="Imperial",Type="Admiral",Starting=false,SpaceTactic=2,GroundTactic=2,Diplomacy=0,Intel=1,SpecOps=0,Logistics=1,MinorDiplomacy=0,MinorIntel=2,MinorSpecOps=1,Game="RotE"}
LeaderInfo["Krennic's Finest"] = {Faction="Imperial",Type="General",Starting=false,SpaceTactic=1,GroundTactic=3,Diplomacy=0,Intel=0,SpecOps=2,Logistics=0,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=2,Game="RotE"}
LeaderInfo["Jabba the Hutt"] = {Faction="Imperial",Type="General",Starting=false,SpaceTactic=0,GroundTactic=0,Diplomacy=2,Intel=2,SpecOps=0,Logistics=0,MinorDiplomacy=1,MinorIntel=1,MinorSpecOps=0,Game="RotE"}
LeaderInfo["Grand Admiral Thrawn"] = {Faction="Imperial",Type="Admiral",Starting=false,SpaceTactic=4,GroundTactic=0,Diplomacy=1,Intel=2,SpecOps=0,Logistics=1,MinorDiplomacy=0,MinorIntel=0,MinorSpecOps=0,Game="WFL"}

Queues = {
	Rebel = {
		Panel = {
			Spots = {
				{ {2.5,0.55,26},{1.5,0.55,26},{0.5,0.55,26},{-0.5,0.55,26},{-1.5,0.55,26},{-2.5,0.55,26},{-3.5,0.55,26},{2.5,0.55,27},{1.5,0.55,27},{0.5,0.55,27},{-0.5,0.55,27},{-1.5,0.55,27},{-2.5,0.55,27},{-3.5,0.55,27},{2.5,0.55,28},{1.5,0.55,28},{0.5,0.55,28},{-0.5,0.55,28},{-1.5,0.55,28},{-2.5,0.55,28},{-2.5,0.55,28}, },--1
				{ {2.5,0.55,29.3},{1.5,0.55,29.3},{0.5,0.55,29.3},{-0.5,0.55,29.3},{-1.5,0.55,29.3},{-2.5,0.55,29.3},{-3.5,0.55,29.3},{2.5,0.55,30.3},{1.5,0.55,30.3},{0.5,0.55,30.3},{-0.5,0.55,30.3},{-1.5,0.55,30.3},{-2.5,0.55,30.3},{-3.5,0.55,30.3} },--2
				{ {2.5,0.55,31.5},{1.5,0.55,31.5},{0.5,0.55,31.5},{-0.5,0.55,31.5},{-1.5,0.55,31.5},{-2.5,0.55,31.5},{-3.5,0.55,31.5} }--3
			},	--table of spots to place tokens on the player panels.
			DecalSpots = {
				{ {0.65,0,-0.475},{0.35,0,-0.475},{0.05,0,-0.475},{-0.25,0,-0.475},{-0.55,0,-0.475},{-0.85,0,-0.475},{-1.15,0,-0.475},
          		{0.65,0,-0.475},{0.35,0.55,27},{1.5,0.55,27},{0.5,0.55,27},{-0.5,0.55,27},{-1.5,0.55,27},
          		{0.65,0,0},{0.35,0.55,27},{2.5,0.55,28},{1.5,0.55,28},{0.5,0.55,28},{-0.5,0.55,28},{-1.5,0.55,28},{-2.5,0.55,28},{-3.5,0.55,28}, },--1
				{ {2.5,0.55,29.3},{1.5,0.55,29.3},{0.5,0.55,29.3},{-0.5,0.55,29.3},{-1.5,0.55,29.3},{-2.5,0.55,29.3},{-3.5,0.55,29.3},{2.5,0.55,30.3},{1.5,0.55,30.3},{0.5,0.55,30.3},{-0.5,0.55,30.3},{-1.5,0.55,30.3},{-2.5,0.55,30.3},{-3.5,0.55,30.3} },--2
				{ {2.5,0.55,31.5},{1.5,0.55,31.5},{0.5,0.55,31.5},{-0.5,0.55,31.5},{-1.5,0.55,31.5},{-2.5,0.55,31.5},{-3.5,0.55,31.5} }--3
			},	--table of spots to place tokens on the player panels.
			Tiles = { {},{},{} }	--table of 3 build tokens.
		},
		Board = {
			Spots = {
				{--1
					S={{20,3,8.5},{20,3,9},{20,3,9.5},{20,3,10},{20,3,10.5},{19.5,3,8.5},{19.5,3,9},{19.5,3,9.5},{19.5,3,10},{19.5,3,10.5},{19,3,8.5},{19,3,9},{19,3,9.5},{19,3,10},{19,3,10.5},{18.5,3,8.5},{18.5,3,9},{18.5,3,9.5},{18.5,3,10},{18.5,3,10.5}},
					M={},--there are no medium sized units build on Q1.
					L={},--there are no large sized units build on Q1.
				},--1
				{--2
					S={{20.5,3,4.6},{21,3,5},{20.5,3,5.1},{21,3,5.5},{20.5,3,5.6},{21,3,6},{20.5,3,6.1},{21,3,6.5},{20.5,3,6.6},{21,3,7},{20.5,3,7.1}},
					M={{21,3,4.5},{21,3,3.9},{20.5,3,4.05}},
					L={},--there are no large sized units build on Q1.
				},--2
				{--3
					S={{21,3,2.5},{21,3,3},{20.5,3,2.5},{20.5,3,3}},
					M={{21,3,0.6},{21,3,1.3},{20.5,3,0.6},{20.5,3,1.3}},
					L={{21.5,3,0.7},{21.5,3,1.7},{21.5,3,2.7}},
				}--3
			}
		}
	},
	Imperial = {
		Panel = {
			Spots = {
				{ {-2.5,0.55,-26},{-1.5,0.55,-26},{-0.5,0.55,-26},{0.5,0.55,-26},{1.5,0.55,-26},{2.5,0.55,-26},{3.5,0.55,-26},{-2.5,0.55,-27},{-1.5,0.55,-27},{-0.5,0.55,-27},{0.5,0.55,-27},{1.5,0.55,-27},{2.5,0.55,-27},{3.5,0.55,-27},{-2.5,0.55,-28},{-1.5,0.55,-28},{-0.5,0.55,-28},{0.5,0.55,-28},{1.5,0.55,-28},{2.5,0.55,-28},{3.5,0.55,-28}, },--1
				{ {-2.5,0.55,-29.3},{-1.5,0.55,-29.3},{-0.5,0.55,-29.3},{0.5,0.55,-29.3},{1.5,0.55,-29.3},{2.5,0.55,-29.3},{3.5,0.55,-29.3},{-2.5,0.55,-30.3},{-1.5,0.55,-30.3},{-0.5,0.55,-30.3},{0.5,0.55,-30.3},{1.5,0.55,-30.3},{2.5,0.55,-30.3},{3.5,0.55,-30.3} },--2
				{ {-2.5,0.55,-31.5},{-1.5,0.55,-31.5},{-0.5,0.55,-31.5},{0.5,0.55,-31.5},{1.5,0.55,-31.5},{2.5,0.55,-31.5},{3.5,0.55,-31.5} }--3
			},	--table of spots to place tokens on the player panels.
			Tiles = { {},{},{} }	--table of 3 build tokens.
		},
		Board = {
			Spots = {
				{--1
					S={{20,3,-8.5},{20,3,-9},{20,3,-9.5},{20,3,-10},{20,3,-10.5},{19.5,3,-8.5},{19.5,3,-9},{19.5,3,-9.5},{19.5,3,-10},{19.5,3,-10.5},{19,3,-8.5},{19,3,-9},{19,3,-9.5},{19,3,-10},{19,3,-10.5},{18.5,3,-8.5},{18.5,3,-9},{18.5,3,-9.5},{18.5,3,-10},{18.5,3,-10.5}},
					M={},--there are no medium sized units build on Q1.
					L={},--there are no large sized units build on Q1.
				},--1
				{--2
					S={{21,3,-6},{21,3,-6.4},{21,3,-6.8},{21,3,-7.2},{20.5,3,-6},{20.5,3,-6.4},{20.5,3,-6.8},{20.5,3,-7.2}},
					M={{21,3,-5.50},{21,3,-4.8},{21,3,-4.1},{20.5,3,-5.5},{20.5,3,-4.9},{20.5,3,-4.3}},
					L={},--there are no large sized units build on Q2.
				},--2
				{--3
					S={{21,3,-2.5},{21,3,-3},{20.5,3,-2.5},{20.5,3,-3}},
					M={{21,3,-0.6},{21,3,-1.3},{20.5,3,-0.6},{20.5,3,-1.3}},
					L={{21.5,3,-1.2},{21.5,3,-2.1},{21.5,3,-3}},
				}--3
			}
		}
	},
}

Counts = {
	Players = 2,
	RebelPlayers = 1,
	ImperialPlayers = 1,
	Units = {
		Stormtroopers = 0,
		AssaultTanks = 0,
		ATSTs = 0,
		ATATs = 0,
		ShieldBunkers = 0,
		TIEFighters = 0,
		TIEStrikers = 0,
		AssaultCarriers = 0,
		StarDestroyers = 0,
		Interdictors = 0,
		SuperStarDestroyers = 0,
		DeathStars = 0,
		DeathStarUnderConstructions = 0,
		RebelTroopers = 0,
		RebelVanguards = 0,
		Airspeeders = 0,
		GolanArmsTurrets = 0,
		ShieldGenerators = 0,
		IonCannons = 0,
		XWings = 0,
		YWings = 0,
		UWings = 0,
		RebelTransports = 0,
		CorellianCorvettes = 0,
		NebulonBFrigates = 0,
		MonCalaCruisers = 0
	},
	Combat = {
		Rebel = {
			Space = 0,
			Ground = 0,
		},
		Imperial = {
			Space = 0,
			Ground = 0,
		},
	}
}

Tactics = {
	Rebel = {
		--Leaders = {},	--list of leaders in combat
		Admiral = "",
		General = "",
		Space = 0,
		Ground = 0,
	},
	Imperial = {
		--Leaders = {},	--list of leaders in combat
		Admiral = "",
		General = "",
		Space = 0,
		Ground = 0,
	},
}

Blocked = {--blocked damage tracker.
	Imperial = {
		Black = 0,
		Red = 0,
		Direct = 0,
		IonBlast = 0,
		GroundDamage = 0,
		SpaceDamage = 0,
	},
	Rebel = {
		Black = 0,
		Red = 0,
		Direct = 0,
		GroundDamage = 0,
		SpaceDamage = 0,
	},
}--Blocked

IDs = {
	Table = "3df05d",
	GameBoard = "9f58ca",
	SoundCube = "5c7223",
	CombatBoard = "78fe4b",
	GameBox = "416d9d",
	RotEBox = "c24e80",
    WFLBox = "6c5531",
	SetupPanel = "f46766",
	ImperialPanel = "55c264",
	RebelPanel = "56669d",
	ImperialDicePanel = "73a97e",
	RebelDicePanel = "5b043a",
	TimeMarker = "457be7",
	ReputationMarker = "355eb7",
	GroundTacticDeckPad = "34716c",
	SpaceTacticDeckPad = "ef89da",
	GroundTacticDiscardDeckPad = "0d7025",
	SpaceTacticDiscardDeckPad = "9d4884",
	CombatMarkerBag = "454e55",
    CombatZone = "03bcbb",
	Rebel = {
		FactionSheet = "8d61bd",
		LeaderBag = "ddd8a9",
		RingBag = "c1d20c",
		AssignmentBoard = "d99608",
		GroundAdvancedTacticDiscarDeckPad = "7d48a5",
		SpaceAdvancedTacticDiscarDeckPad = "778748",
		MissionHand = "3bd3de",
		ActionHand = "b3d1b6",
		ObjectiveHand = "eba631",
		HiddenMissionZone = "06ea71",
		ProbeLogBag = "f2fba2",
		AdvancedTacticDiscardZone = "a339c5",
		HiddenPanelZone = "1b93e2",
    MissionSecretZone = "cb24b1",
    MissionRevealedZone = "fa3d97",
    MissionDiscardZone = "2e5145",
		BaseProbeCardZone = "fdc158",
		OTBag = "2c9ccb",
		OCBag = "b363bc",
		OSBag = "96121c",
		BTBag = "c7c67b",
		BCBag = "ff3816",
		BSBag = "cb9f86",
		DamageBag = "45a55b"
	},
	Imperial = {
		FactionSheet = "a3467f",
		LeaderBag = "006c3e",
		RingBag = "d533cf",
		AssignmentBoard = "9675be",
		GroundAdvancedTacticDiscarDeckPad = "c3bf87",
		SpaceAdvancedTacticDiscarDeckPad = "2f45f2",
		MissionHand = "14d917",
		ActionHand = "9db9f0",
		ProbeHand = "9155c0",
		ProbeLogBag = "09a645",
		HiddenMissionZone = "aed0b5",
		AdvancedTacticDiscardZone = "dcd3c0",
		HiddenPanelZone = "c10194",
    	MissionSecretZone = "274a45",
    	MissionRevealedZone = "d0828d",
    	MissionDiscardZone = "748125",
    	ProjectDiscardZone = "1fdeeb",
		OTBag = "3fef68",
		OCBag = "4c3648",
		OSBag = "1a6df5",
		BTBag = "59ddb2",
		BCBag = "380d07",
		BSBag = "25b979",
		DamageBag = "a5c3aa"
	}
}

Hands = {
	RebelMission = {Index=2,Color="White",DrawSpot={-16,1,18},Rotation={0,0,0}},
	ImperialMission = {Index=2,Color="Blue",DrawSpot={-16,1,-18},Rotation={0,180,0}},
	RebelAction = {Index=3,Color="White",DrawSpot={-16,1,22},Rotation={0,0,0}},
	ImperialAction = {Index=3,Color="Blue",DrawSpot={-16,1,-22},Rotation={0,180,0}},
	RebelObjective = {Index=4,Color="White",DrawSpot={-28.5,1,22},Rotation={0,0,0}},
	ImperialProbe = {Index=4,Color="Blue",DrawSpot={-28,1,-22},Rotation={0,180,0}},
	RebelSpaceTactic = {Index=5,Color="White",DrawSpot={49,1,15},Rotation={0,0,0}},
	ImperialSpaceTactic = {Index=5,Color="Blue",DrawSpot={49,1,-15},Rotation={0,180,0}},
	RebelGroundTactic = {Index=6,Color="White",DrawSpot={36,1,15},Rotation={0,0,0}},
	ImperialGroundTactic = {Index=6,Color="Blue",DrawSpot={36,1,-15},Rotation={0,180,0}}
}

Decks = {
	ObjectiveISetup = {ID="0bd492",DropSpot={-20.11,3,9.76}},
	ObjectiveIISetup = {ID="213977",DropSpot={-20.11,2,9.76}},
	ObjectiveIIISetup = {ID="b152a6",DropSpot={-20.11,1,9.76}},
	Objective = {ID="b152a6",Spot={-20.11,0.77,9.76},DropSpot={-20.11,1,9.76},Rotation={0,90,180},DeckName="Rebel Objectives Deck",DeckTag="Deck;Objective;Rebel;",CardTag="ObjectiveCard;"},
	Probe = {ID="eab231",Spot={-21.1,0.88,-7.24},DropSpot={-21.1,1.2,-7.24},Rotation={0,180,180},DeckName="Probe Deck",DeckTag="Deck;Probe;",CardTag="ProbeCard;"},
	RebelBase = {ID="",PadID="fcff84",Spot={-23.39, 0.67, 7.45},Rotation={0,270,180}},
	SpaceTactic = {ID="b4467d",PadID="ef89da",Spot={46.4,0.75,-1.05},DropSpot={46.4,1.75,-1.05},Rotation={0,90,180}},
	GroundTactic = {ID="638e6e",PadID="34716c",Spot={46.4,0.75,0.95},DropSpot={46.4,1.75,0.95},Rotation={0,90,180}},
	SpaceTacticDiscard = {ID="",PadID="26bcc7",Spot={46.4,0.75,-3.05},DropSpot={46.4,1.75,-3.05},Rotation={0,90,0}},
	GroundTacticDiscard = {ID="",PadID="d08a14",Spot={46.4,0.75,2.95},DropSpot={46.4,0.75,2.95},Rotation={0,90,0}},
	RebelAdvancedSpaceTacticDiscard = {ID="c0b6c6",PadID="778748",Spot={48.57,0.75,12.9},DropSpot={48.57,1.75,12.9},Rotation={0,0,0}},
	RebelAdvancedGroundTacticDiscard = {ID="3e2f96",PadID="7d48a5",Spot={46.08,0.75,12.9},DropSpot={46.08,1.75,12.9},Rotation={0,0,0}},
	ImperialAdvancedSpaceTacticDiscard = {ID="7f5c27",PadID="2f45f2",Spot={48.43,0.75,-12.9},DropSpot={48.43,1.75,-12.9},Rotation={0,180,0}},
	ImperialAdvancedGroundTacticDiscard = {ID="c46ccd",PadID="c3bf87",Spot={45.93,0.75,-12.9},DropSpot={45.93,1.75,-12.9},Rotation={0,180,0}},
	RebelStartingAction={ID="2c9815"},
	RebelAction = {ID="3382dc",PadID="f82f02",Spot={6.33,0.81,20.08},DropSpot={6.33,1.5,20.08},Rotation={0,0,180}},
	ImperialStartingAction={ID = "9c20c3"},
	ImperialAction={ID="f17ff7",PadID="cd3983",Spot={6.34,0.81,-20.08},DropSpot={6.34,1.5,-20.08},Rotation={0,180,180}},
	RebelMission = {ID="ce5f22",PadID="3a438a",Spot={-6.63,0.98,19.66},DropSpot={-6.63,1.98,19.66},Rotation={0,0,180}},
	ImperialMission = {ID="fc6082",PadID="c168a8",Spot={-6.63,0.97,-19.66},DropSpot={-6.63,1.97,-19.66},Rotation={0,180,180}},
	ImperialProject = {ID="5dbdab",PadID="",Spot={-20.07,0.80,-9.68},DropSpot={-20.07,1.80,-9.68},Rotation={0,90,180}},
	RebelMissionDiscard = {ID="",PadID="7277f2",Spot={-20.78,0.74,13},DropSpot={-20.78,1.5,13},Rotation={0,0,0}},
	ImperialMissionDiscard = {ID="",PadID="06ceb7",Spot={-18.35,0.74,-13},DropSpot={-18.35,1.5,-13},Rotation={0,180,0}},
	ImperialProjectDiscard = {ID="",PadID="21d14c",Spot={-20.75,0.74,-13},DropSpot={-20.75,1.5,-13},Rotation={0,180,0}}
}

PanelSpots = {
	Default = {Position={-25,14,0},Rotation={90,90,0},Scale={5,1,5}},
	Settings = {Position={-30.2,0.8,0},Rotation={0,90,0},Scale={2,1,2}},
	Imperial = {Position={0,0.6,-28},Rotation={0,180,0},Scale={4.2,1,4.2}},
	Rebel = {Position={0,0.6,28},Rotation={0,0,0},Scale={4.2,1,4.2}},
	ImperialSecret = {Position={0,7.6,-15},Rotation={90,180,0},Scale={4.2,1,4.2}},
	RebelSecret = {Position={0,7.6,15},Rotation={90,0,0},Scale={4.2,1,4.2}},
	ImperialHidden = {Position={0,-1,-28},Rotation={0,180,0},Scale={4.2,1,4.2}},
	RebelHidden = {Position={0,-1,28},Rotation={0,0,0},Scale={4.2,1,4.2}},
	ImperialCombat = {Position={37,0.64,-22},Rotation={0,180,0},Scale={3,1,3}},
	RebelCombat = {Position={37,0.64,22},Rotation={0,0,0},Scale={3,1,3}},
}

Spots = {
	Action = {
		Rebel = {{12.2,0.67,18.2},{13.9,0.67,18.2},{15.6,0.67,18.2},{17.3,0.67,18.2},{19,0.67,18.2},{20.7,0.67,18.2}},
		Imperial = {{12.2,0.67,-18.2},{13.9,0.67,-18.2},{15.6,0.67,-18.2},{17.3,0.67,-18.2},{19,0.67,-18.2},{20.7,0.67,-18.2}}
	},
	Assignment = {
		Rebel = {
	    Hidden = {{9,0.7,14.95},{6.75,0.7,14.95},{4.5,0.7,14.95},{2.25,0.7,14.95},{0,0.7,14.95},{-2.25,0.7,14.95},{-4.5,0.7,14.95},{-6.75,0.7,14.95},{-9,0.7,14.95}},
			Revealed = {{9,0.7,13.75},{6.75,0.7,13.75},{4.5,0.7,13.75},{2.25,0.7,13.75},{0,0.7,13.75},{-2.25,0.7,13.75},{-4.5,0.7,13.75},{-6.75,0.7,13.75},{-9,0.7,13.75}},
		},
		Imperial = {
		  Hidden = {{-9,0.7,-14.95},{-6.75,0.7,-14.95},{-4.5,0.7,-14.95},{-2.25,0.7,-14.95},{0,0.7,-14.95},{2.25,0.7,-14.95},{4.5,0.7,-14.95},{6.75,0.7,-14.95},{9,0.7,-14.95}},
			Revealed = {{-9,0.7,-13.75},{-6.75,0.7,-13.75},{-4.5,0.7,-13.75},{-2.25,0.7,-13.75},{0,0.7,-13.75},{2.25,0.7,-13.75},{4.5,0.7,-13.75},{6.75,0.7,-13.75},{9,0.7,-13.75}},
		}
	},
	Recruitment = {
		Rebel = {
			Cards = {{4,0.7,29.7},{2.4,0.7,29.7},{0.8,0.7,29.7},{-0.8,0.7,29.7},{-2.4,0.7,29.7},{-4,0.7,29.7},{-5.6,0.7,29.7}},
			Leaders = {{1.5,0.7,26.5},{0.5,0.7,26.5},{-0.5,0.7,26.5},{-1.5,0.7,26.5}},
		},
		Imperial = {
			Cards = {{-4,0.7,-29.7},{-2.4,0.7,-29.7},{-0.8,0.7,-29.7},{0.8,0.7,-29.7},{2.4,0.7,-29.7},{4,0.7,-29.7},{5.6,0.7,-29.7}},
			Leaders = {{-1.5,0.7,-26.5},{-0.5,0.7,-26.5},{0.5,0.7,-26.5},{1.5,0.7,-26.5}},
		}
	},
	HiddenZones = {
		PlayerPanel = { Rebel = { On = {0,2,28}, Off = {0,-2,28} }, Imperial = { On = {0,2,-28}, Off = {0,-2,-28} } },
		AssignmentPanel = { Rebel = { On = {0,1.46,15.6}, Off = {0,-20,15.6} }, Imperial = { On = {0,1.46,-15.6}, Off = {0,-20,-15.6} } }
	},
	Combat = {
		IL = {{33.5,2,-8.25},{34.75,2,-8.25},{32.25,2,-8.25},{36,2,-8.25},{31,2,-8.25},{37.25,2,-8.25},{29.75,2,-8.25},{38.5,2,-8.25},{28.5,2,-8.25},{39.75,2,-8.25},{27.25,2,-8.25},{41,2,-8.25}},
		RL =  {{33.5,2,8.25},{34.75,2,8.25},{32.25,2,8.25},{36,2,8.25},{31,2,8.25},{37.25,2,8.25},{29.75,2,8.25},{38.5,2,8.25},{28.5,2,8.25},{39.75,2,8.25},{27.25,2,8.25},{41,2,8.25}},
		DSUC = {{39.1,2,-7.6}},
		DS = {{40.2,2,-7.35},{41.4,2,-7.35}},
		SSD = {{34,2,-6.5},{35,2,-6.5}},
		SD = {{37,2,-5.9},{38,2,-5.9},{39,2,-5.9},{40,2,-5.9},{41,2,-5.9},{42,2,-5.9},{43,2,-5.9},{44,2,-5.9}},
		ID = {{36,2,-7.3},{37,2,-7.3},{38,2,-7.3}},
		AC = {{37.7,2,-4.2},{38.6,2,-4.25},{39.5,2,-4.25},{40.4,2,-4.25},{41.3,2,-4.25},{42.2,2,-4.25},{43.1,2,-4.25},{44,2,-4.25}},
		TS = {{38,2,-2.25},{37,2,-2.25},{36,2,-2.25},{35,2,-2.25},{34,2,-2.25},{33,2,-2.25}},
		TF = {{39,2,-1.25},{38,2,-1.25},{40,2,-1.25},{37,2,-1.25},{41,2,-1.25},{36,2,-1.25},{42,2,-1.25},{35,2,-1.25},{43,2,-1.25},{34,2,-1.25},{44,2,-1.25},{33,2,-1.25},
		      {39,2,-0.25},{38,2,-0.25},{40,2,-0.25},{37,2,-0.25},{41,2,-0.25},{36,2,-0.25},{42,2,-0.25},{35,2,-0.25},{43,2,-0.25},{34,2,-0.25},{44,2,-0.25},{33,2,-0.25}},
		LC = {{33,2,-5.25},{33,2,-6.35},{33,2,-7.45}},
		LSH = {{36,2,-5.2},{36,2,-6.2}},
		DSH = {{36.9,2,-4.25}},
		TD = {{35,2,-3.25},{34,2,-3.25},{33,2,-3.25},{34,2,-4.25},{33,2,-4.25}},
		TA = {{35,2,-4.25},{36,2,-4.25}},
		TI = {{39,2,-2.25},{40,2,-2.25},{41,2,-2.25},{42,2,-2.25},{43,2,-2.25},{44,2,-2.25}},
		TB = {{36,2,-3.25},{37,2,-3.25},{38,2,-3.25},{39,2,-3.25},{40,2,-3.25},{41,2,-3.25},{42,2,-3.25},{43,2,-3.25},{44,2,-3.25}},
		ATAT = {{26,2,-7.5},{27,2,-7.5},{28,2,-7.5},{29,2,-7.5}},
		SB = {{30,2,-7.5},{31,2,-7.5},{32,2,-7.5}},
		ATST = {{28,2,-6.25},{27,2,-6.25},{29,2,-6.25},{26,2,-6.25},{30,2,-6.25},{25,2,-6.25},{31,2,-6.25},{24,2,-6.25},{32,2,-6.25},{23,2,-6.25}},
		AT = {{26,2,-4.5},{25,2,-4.5},{24,2,-4.5},{26,2,-5.5},{25,2,-5.5},{24,2,-5.5}},
		ST = {{28,2,-1.5},{27,2,-1.5},{29,2,-1.5},{26,2,-1.5},{30,2,-1.5},{25,2,-1.5},{31,2,-1.5},{24,2,-1.5},{32,2,-1.5},{23,2,-1.5},
		      {28,2,-2.5},{27,2,-2.5},{29,2,-2.5},{26,2,-2.5},{30,2,-2.5},{25,2,-2.5},{31,2,-2.5},{24,2,-2.5},{32,2,-2.5},{23,2,-2.5},
			  {28,2,-0.5},{27,2,-0.5},{29,2,-0.5},{26,2,-0.5},{30,2,-0.5},{25,2,-0.5},{31,2,-0.5},{24,2,-0.5},{32,2,-0.5},{23,2,-0.5}},
		SCTT = {{27,2,-5},{28,2,-5},{29,2,-5},{30,2,-5},{31,2,-5},{32,2,-5}},
		DTHT = {{28,2,-3.5},{29,2,-3.5},{30,2,-3.5},{31,2,-3.5},{32,2,-3.5}},
		DRKT = {{26,2,-3.5},{25,2,-3.5},{24,2,-3.5},{23,2,-3.5}},
		RT = {{26,2,2.5},{27,2,2.5},{28,2,2.5},{29,2,2.5},{30,2,2.5},{31,2,2.5},{32,2,2.5},
			  {26,2,3.5},{27,2,3.5},{28,2,3.5},{29,2,3.5},{30,2,3.5},{31,2,3.5},{32,2,3.5},
			  {26,2,1.5},{27,2,1.5},{28,2,1.5},{29,2,1.5},{30,2,1.5},{31,2,1.5},{32,2,1.5}},
		RV = {{25,2,2.5},{24,2,2.5},{23,2,2.5},{25,2,3.5},{24,2,3.5},{23,2,3.5}},
		AS = {{27,2,5},{28,2,5},{26,2,5},{29,2,5},{25,2,5},{30,2,5}},
		GAT = {{26,2,6.25},{25,2,6.25},{24,2,6.25}},
		SG = {{28,2,7.5},{30,2,7.5},{26,2,7.5}},
		IC = {{29,2,6.5},{30,2,6.5},{31,2,6.5}},
		WV = {{25,2,1.5},{24,2,1.5},{23,2,1.5}},
		JK = {{30,2,0.5},{25,2,0.5}},
		XW = {{38,2,1},{37,2,1},{36,2,1},{35,2,1},{34,2,1},{33,2,1},{36,2,2},{35,2,2}},
		YW = {{38,2,3},{37,2,3},{36,2,3},{35,2,3},{34,2,3},{33,2,3},{38,2,2},{37,2,2},{34,2,2},{33,2,2},{37,2,4},{36,2,4}},
		UW = {{39,2,3},{40,2,3},{41,2,3},{42,2,3},{43,2,3},{44,2,3}},
		GR75 = {{34,2,5.7},{34,2,7},{33,2,5.7},{33,2,7}},
		CC = {{41,2,4.25},{42,2,4.25},{43,2,4.25},{44,2,4.25}},
		NBF = {{42,2,6},{43,2,6},{44,2,6}},
		MCC = {{40,2,6.5},{39,2,6.5},{41,2,6.5}},
		AW = {{39,2,1},{40,2,1},{41,2,1},{42,2,1},{43,2,1},{44,2,1}},
		BW = {{39,2,2},{40,2,2},{41,2,2},{42,2,2},{43,2,2},{44,2,2}},
		LF = {{35,2,4.5},{34,2,4.5},{33,2,4.5}},
		HC = {{39,2,4.25},{40,2,4.25}},
		EC = {{38,2,4.50}},
		MC75 = {{35,2,6.5}},
		MC80 = {{37,3,6.5},{38,3,6.5},{36,3,6.5}},

		Imperial = {
			Ground = { --max 53
				{28.25,0.74,-2.3},{29.15,0.74,-2.3},{30.05,0.74,-2.3},{30.95,0.74,-2.3},{31.85,0.74,-2.3},{32.75,0.74,-2.3},{33.65,0.74,-2.3},{34.55,0.74,-2.3},{35.45,0.74,-2.3},
				{28.25,0.74,-1.4},{29.15,0.74,-1.4},{30.05,0.74,-1.4},{30.95,0.74,-1.4},{31.85,0.74,-1.4},{32.75,0.74,-1.4},{33.65,0.74,-1.4},{34.55,0.74,-1.4},{35.45,0.74,-1.4},
				{28.25,0.74,-0.5},{29.15,0.74,-0.5},{30.05,0.74,-0.5},{30.95,0.74,-0.5},{31.85,0.74,-0.5},{32.75,0.74,-0.5},{33.65,0.74,-0.5},{34.55,0.74,-0.5},{35.45,0.74,-0.5},
				{28.25,0.74,-3.2},{29.15,0.74,-3.2},{30.05,0.74,-3.2},{30.95,0.74,-3.2},{31.85,0.74,-3.2},{32.75,0.74,-3.2},{33.65,0.74,-3.2},{34.55,0.74,-3.2},{35.45,0.74,-3.2},
				{28.25,0.74,-4.1},{29.15,0.74,-4.1},{30.05,0.74,-4.1},{30.95,0.74,-4.1},{31.85,0.74,-4.1},{32.75,0.74,-4.1},{33.65,0.74,-4.1},{34.55,0.74,-4.1},{35.45,0.74,-4.1},
				{28.25,0.74,-5.0},{29.15,0.74,-5.0},{30.05,0.74,-5.0},{30.95,0.74,-5.0},{31.85,0.74,-5.0},{32.75,0.74,-5.0},{33.65,0.74,-5.0},{34.55,0.74,-5.0},{35.45,0.74,-5.0},
				{30.95,0.74,-5.9},{31.85,0.74,-5.9},{32.75,0.74,-5.9},{33.65,0.74,-5.9},{34.55,0.74,-5.9},{35.45,0.74,-5.9},
				{30.95,0.74,-6.8},{31.85,0.74,-6.8},{32.75,0.74,-6.8},{33.65,0.74,-6.8},{34.55,0.74,-6.8},{35.45,0.74,-6.8},
			},
			Space = {	--Max 54
				{45.75,0.74,-3.2},{44.85,0.74,-3.2},{43.95,0.74,-3.2},{43.05,0.74,-3.2},{42.15,0.74,-3.2},{41.25,0.74,-3.2},{40.35,0.74,-3.2},{39.45,0.74,-3.2},{38.55,0.74,-3.2},{37.65,0.74,-3.2},
				{45.75,0.74,-2.3},{44.85,0.74,-2.3},{43.95,0.74,-2.3},{43.05,0.74,-2.3},{42.15,0.74,-2.3},{41.25,0.74,-2.3},{40.35,0.74,-2.3},{39.45,0.74,-2.3},{38.55,0.74,-2.3},{37.65,0.74,-2.3},
				{45.75,0.74,-1.4},{44.85,0.74,-1.4},{43.95,0.74,-1.4},{43.05,0.74,-1.4},{42.15,0.74,-1.4},{41.25,0.74,-1.4},{40.35,0.74,-1.4},{39.45,0.74,-1.4},{38.55,0.74,-1.4},{37.65,0.74,-1.4},
				{45.75,0.74,-0.5},{44.85,0.74,-0.5},{43.95,0.74,-0.5},{43.05,0.74,-0.5},{42.15,0.74,-0.5},{41.25,0.74,-0.5},{40.35,0.74,-0.5},{39.45,0.74,-0.5},{38.55,0.74,-0.5},{37.65,0.74,-0.5},
				{45.75,0.74,-5},{44.85,0.74,-5},{43.95,0.74,-5},{43.05,0.74,-5},{42.15,0.74,-5},{41.25,0.74,-5},{40.35,0.74,-5},{39.45,0.74,-5},{38.55,0.74,-5},{37.65,0.74,-5},{36.75,0.74,-5},
				{36.6,0.7,-2},{38.5,0.7,-6.8},--SSDs
				{43,1.5,-6.8},{36.6,1.5,-6.8}--DSs
			}
		},
		Rebel = {
			Ground = { --max 42
				{28.25,0.74,2.3},{29.15,0.74,2.3},{30.05,0.74,2.3},{30.95,0.74,2.3},{31.85,0.74,2.3},{32.75,0.74,2.3},{33.65,0.74,2.3},{34.55,0.74,2.3},{35.45,0.74,2.3},
				{28.25,0.74,1.4},{29.15,0.74,1.4},{30.05,0.74,1.4},{30.95,0.74,1.4},{31.85,0.74,1.4},{32.75,0.74,1.4},{33.65,0.74,1.4},{34.55,0.74,1.4},{35.45,0.74,1.4},
				{28.25,0.74,0.5},{29.15,0.74,0.5},{30.05,0.74,0.5},{30.95,0.74,0.5},{31.85,0.74,0.5},{32.75,0.74,0.5},{33.65,0.74,0.5},{34.55,0.74,0.5},{35.45,0.74,0.5},
				{28.25,0.74,3.2},{29.15,0.74,3.2},{30.05,0.74,3.2},{30.95,0.74,3.2},{31.85,0.74,3.2},{32.75,0.74,3.2},{33.65,0.74,3.2},{34.55,0.74,3.2},{35.45,0.74,3.2},
				{28.25,0.74,4.1},{29.15,0.74,4.1},{30.05,0.74,4.1},{30.95,0.74,4.1},{31.85,0.74,4.1},{32.75,0.74,4.1},{33.65,0.74,4.1},{34.55,0.74,4.1},{35.45,0.74,4.1},
				{28.25,0.74,5.5},{29.15,0.74,5.5},{30.05,0.74,5.5},{30.95,0.74,5.5},{31.85,0.74,5.5},{32.75,0.74,5.5},{33.65,0.74,5.5},{34.55,0.74,5.5},{35.45,0.74,5.5}
			},
			Space = {	--Max 40
				{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},{45.75,0.74,3.2},
				{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},{45.75,0.74,2.3},
				{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},{45.75,0.74,1.4},
				{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},{45.75,0.74,0.5},
				{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5},{45.75,0.74,5}
			}
		}
	},
	TimeTrack = {
		{-20.59, 0.69, -5.32},
		{-21.46, 0.69, -4.73},
		{-20.61, 0.69, -4.15},
		{-21.47, 0.69, -3.57},
		{-20.61, 0.69, -3.00},
		{-21.45, 0.69, -2.43},
		{-20.60, 0.69, -1.86},
		{-21.47, 0.69, -1.26},
		{-20.60, 0.69, -0.70},
		{-21.46, 0.69, -0.14},
		{-20.61, 0.69, 0.43},
		{-21.46, 0.69, 0.99},
		{-20.59, 0.69, 1.57},
		{-21.48, 0.69, 2.15},
		{-20.61, 0.69, 2.72},
		{-21.46, 0.69, 3.31}
  	},
}

StepList = {
	{"Assignment","AssignmentPhase.Start"},
	{"Assignment","AssignmentPhase.RebelAssignments"},
	{"Assignment","AssignmentPhase.ImperialAssignments"},
	{"Assignment","AssignmentPhase.End"},
	{"Command","CommandPhase.Start"},
	--{"Command","CommandPhase.Turns"},
	{"Command","CommandPhase.1.Rebel.Turn"},--2P
	{"Command","CommandPhase.2.Imperial.Turn"}, --2P
	{"Command","CommandPhase.1.Rebel.Admiral.Turn"},--3+P
	{"Command","CommandPhase.2.Imperial.Admiral.Turn"}, --3+P
	{"Command","CommandPhase.3.Imperial.General.Turn"}, --3+P
	{"Command","CommandPhase.4.Rebel.General.Turn"},--3+P
	{"Command","CommandPhase.RapidMobilization"},
	{"Command","CommandPhase.SweepTheArea"},
	{"Command","CommandPhase.End"},
	{"Refresh","RefreshPhase.Start"},
	{"Refresh","RefreshPhase.I.RetrieveLeaders"},
	{"Refresh","RefreshPhase.II.DrawMissions.1"},
	{"Refresh","RefreshPhase.II.DrawMissions.2"},
	{"Refresh","RefreshPhase.II.DiscardMissions"},
	{"Refresh","RefreshPhase.III.LaunchProbeDroids"},
	{"Refresh","RefreshPhase.IV.DrawObjective"},
	--{"Refresh","RefreshPhase.IV.DrawObjective.Immediate"},
	{"Refresh","RefreshPhase.V.i.RecruitIcon"},
	--{"Refresh","RefreshPhase.V.i.ChooseActionCard"},
	{"Refresh","RefreshPhase.V.ii.BuildIcon"},
	--{"Refresh","RefreshPhase.V.ii.BuildRebelUnits"},
	--{"Refresh","RefreshPhase.V.ii.BuildImperialUnits"},
	--{"Refresh","RefreshPhase.V.ii.BuildUnits"},
	{"Refresh","RefreshPhase.VI.DeployUnits"},
	--{"Refresh","RefreshPhase.VI.DeployRebelUnits"},
	--{"Refresh","RefreshPhase.VI.DeployImperialUnits"},
	{"Refresh","RefreshPhase.End"}
}

CameraViews = {
	ImperialPanel = {position={0,0,-20},pitch=60,yaw=0,distance=25},
	RebelPanel = {position={0,0,20},pitch=60,yaw=180,distance=25},
}

SystemMatrix = {}

Locations = {}
Locations["REBEL QUEUE 3"] = {Loyalty="",Type="Queue",Subtype="3",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["REBEL QUEUE 2"] = {Loyalty="",Type="Queue",Subtype="2",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["REBEL QUEUE 1"] = {Loyalty="",Type="Queue",Subtype="1",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["REBEL DEPLOYMENT"] = {Loyalty="",Type="Queue",Subtype="0",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["IMPERIAL QUEUE 3"] = {Loyalty="",Type="Queue",Subtype="3",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["IMPERIAL QUEUE 2"] = {Loyalty="",Type="Queue",Subtype="2",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["IMPERIAL QUEUE 1"] = {Loyalty="",Type="Queue",Subtype="1",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["IMPERIAL DEPLOYMENT"] = {Loyalty="",Type="Queue",Subtype="0",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot=nil,GridSpots={},LogSpot=nil,SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["REBEL BASE"] = {Loyalty="Rebel",Type="Base",Subtype="Space",Region=0,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",MarkerSpot={-19.37,0.8,5.31},GridSpots={},LogSpot=nil,SabotageSpot={-20.58,0.69,5.16},Build={Queue=1,Icons={"BT","OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["CORUSCANT"] = {Loyalty="Imperial",Type="System",Subtype="Populous",Region=1,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={0.25,5,1.05},MarkerSpot={2.58,0.8,-9.65},GridSpots={},LogSpot={-27.49,0.79,-17.1},SabotageSpot={1.34,0.69,-9.8},Build={Queue=1,Icons={"OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["ALDERAAN"] = {Loyalty="",Type="System",Subtype="Populous",Region=1,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-0.4,5,0.7},MarkerSpot={-3.02,0.8,-6.89},GridSpots={},LogSpot={-28.87,0.79,-15.82},SabotageSpot={-4.23, 0.69, -7.04},Build={Queue=1,Icons={"OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["CATO NEIMOIDIA"] = {Loyalty="",Type="System",Subtype="Populous",Region=1,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={0.35,5,0.55},MarkerSpot={4.12,0.8,-4.55},GridSpots={},LogSpot={-27.03,0.79,-15.35},SabotageSpot={2.94, 0.69, -4.67},Build={Queue=2,Icons={"BT","OC"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["CORELLIA"] = {Loyalty="",Type="System",Subtype="Populous",Region=1,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={0.9,5,0.9},MarkerSpot={8.01,0.8,-9.00},GridSpots={},LogSpot={-26.03,0.79,-16.54},SabotageSpot={6.74, 0.69, -9.08},Build={Queue=3,Icons={"BT","BS"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["DANTOOINE"] = {Loyalty="",Type="System",Subtype="Remote",Region=2,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-2.1,5,0.4},MarkerSpot={-17.56,0.8,-3.98},GridSpots={},LogSpot={-32.77,0.79,-15.04},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["MYGEETO"] = {Loyalty="",Type="System",Subtype="Populous",Region=2,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-1.75,5,0.75},MarkerSpot={-14.03,0.8,-6.73},GridSpots={},LogSpot={-31.75,0.79,-15.82},SabotageSpot={-15.26, 0.69, -6.87},Build={Queue=2,Icons={"BT","OS"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["ORD MANTELL"] = {Loyalty="",Type="System",Subtype="Populous",Region=2,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-1,5,0.85},MarkerSpot={-7.55,0.8,-7.71},GridSpots={},LogSpot={-30.15,0.79,-16.51},SabotageSpot={-8.78, 0.69, -7.88},Build={Queue=2,Icons={"BC","OC"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["ILUM"] = {Loyalty="",Type="System",Subtype="Remote",Region=2,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-1.4,5,1.05},MarkerSpot={-11.25,0.8,-9.43},GridSpots={},LogSpot={-31.19,0.79,-17.07},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["DATHOMIR"] = {Loyalty="",Type="System",Subtype="Remote",Region=3,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-1.45,5,0.25},MarkerSpot={-11.47,0.69,-2.77},GridSpots={},LogSpot={-30.88,0.79,-14.73},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["MANDALORE"] = {Loyalty="",Type="System",Subtype="Populous",Region=3,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-0.8,5,0.4},MarkerSpot={-6.2,0.8,-4.05},GridSpots={},LogSpot={-29.76,0.79,-14.89},SabotageSpot={-7.40, 0.69, -4.22},Build={Queue=1,Icons={"OT","BT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["KASHYYYK"] = {Loyalty="",Type="System",Subtype="Populous",Region=3,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={0.3,5,0.1},MarkerSpot={-2.4,0.8,-2.02},GridSpots={},LogSpot={-28.82,0.79,-14.10},SabotageSpot={-3.65, 0.69, -2.12},Build={Queue=1,Icons={"OT","OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["MALASTARE"] = {Loyalty="",Type="System",Subtype="Populous",Region=3,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={0.1,5,0},MarkerSpot={2.94,0.8,-1.04},GridSpots={},LogSpot={-27.13,0.79,-13.99},SabotageSpot={1.75, 0.69, -1.21},Build={Queue=1,Icons={"OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["YAVIN"] = {Loyalty="",Type="System",Subtype="Remote",Region=4,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-2,5,-0.2},MarkerSpot={-16.03,0.8,1.47},GridSpots={},LogSpot={-32.05,0.79,-13.14},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["FELUCIA"] = {Loyalty="",Type="System",Subtype="Populous",Region=4,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-1.6,5,-0.5},MarkerSpot={-12.43,0.8,3.54},GridSpots={},LogSpot={-31.21,0.79,-12.42},SabotageSpot={-13.65, 0.69, 3.39},Build={Queue=1,Icons={"OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["SALEUCAMI"] = {Loyalty="",Type="System",Subtype="Populous",Region=4,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-1.1,5,-0.5},MarkerSpot={-8.11,0.8,3.82},GridSpots={},LogSpot={-30.23,0.79,-12.36},SabotageSpot={-9.37, 0.69, 3.67},Build={Queue=1,Icons={"OC"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["MON CALAMARI"] = {Loyalty="",Type="System",Subtype="Populous",Region=4,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-1.8,5,-1.1},MarkerSpot={-14.56,0.8,8},GridSpots={},LogSpot={-31.6,0.79,-11.17},SabotageSpot={-15.76, 0.69, 7.83},Build={Queue=3,Icons={"BT","BS"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["KESSEL"] = {Loyalty="",Type="System",Subtype="Populous",Region=5,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-0.9,5,-1.1},MarkerSpot={-7.08,0.8,8.08},GridSpots={},LogSpot={-29.75,0.79,-11.37},SabotageSpot={-8.36, 0.69, 7.93},Build={Queue=1,Icons={"OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["NAL HUTTA"] = {Loyalty="",Type="System",Subtype="Populous",Region=5,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-0.4,5,-1.1},MarkerSpot={-2.38,0.8,7.59},GridSpots={},LogSpot={-28.72,0.79,-10.89},SabotageSpot={-3.59, 0.69, 7.44},Build={Queue=1,Icons={"OT","BT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["TOYDARIA"] = {Loyalty="",Type="System",Subtype="Populous",Region=5,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={-0.5,5,-0.4},MarkerSpot={-3.71,0.8,3.05},GridSpots={},LogSpot={-28.98,0.79,-12.58},SabotageSpot={-5.11, 0.69, 2.81},Build={Queue=2,Icons={"BC"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["BOTHAWUI"] = {Loyalty="",Type="System",Subtype="Populous",Region=5,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={0.2,5,-0.7},MarkerSpot={2.5,0.8,5.99},GridSpots={},LogSpot={-27.56,0.79,-11.86},SabotageSpot={1.23, 0.69, 5.86},Build={Queue=1,Icons={"OC"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["TATOOINE"] = {Loyalty="",Type="System",Subtype="Remote",Region=6,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={0.9,5,-1.1},MarkerSpot={8.72,0.8,9.33},GridSpots={},LogSpot={-26.03,0.79,-10.73},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["RODIA"] = {Loyalty="",Type="System",Subtype="Populous",Region=6,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=fAIalse,Blockaded=false,CombatMarkerID="",ButtonSpot={0.0,5,0.0},MarkerSpot={6.24,0.8,4.19},GridSpots={},LogSpot={-26.60,0.79,-12.16},SabotageSpot={4.92, 0.69, 4.09},Build={Queue=1,Icons={"OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["RYLOTH"] = {Loyalty="",Type="System",Subtype="Populous",Region=6,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={1.9,5,-1.1},MarkerSpot={16.62,0.8,8.92},GridSpots={},LogSpot={-24.1,0.79,-10.67},SabotageSpot={15.37, 0.69, 8.82},Build={Queue=1,Icons={"OT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["GEONOSIS"] = {Loyalty="",Type="System",Subtype="Populous",Region=6,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={1.5,5,-0.7},MarkerSpot={13.4,0.8,5.56},GridSpots={},LogSpot={-24.74,0.79,-11.81},SabotageSpot={12.18, 0.69, 5.46},Build={Queue=2,Icons={"BT","OS"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["UTAPAU"] = {Loyalty="",Type="System",Subtype="Populous",Region=7,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={2.1,5,-0.5},MarkerSpot={18.33,0.8,3.03},GridSpots={},LogSpot={-23.24,0.79,-12.24},SabotageSpot={17.16, 0.69, 2.89},Build={Queue=3,Icons={"BC","BS"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["DAGOBAH"] = {Loyalty="",Type="System",Subtype="Remote",Region=7,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={1.5,5,0.1},MarkerSpot={13.27,0.8,-1.30},GridSpots={},LogSpot={-24.77,0.79,-14.19},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["SULLUST"] = {Loyalty="",Type="System",Subtype="Populous",Region=7,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={1.1,5,0.5},MarkerSpot={9.76,0.8,-4.35},GridSpots={},LogSpot={-25.48,0.79,-15.16},SabotageSpot={8.54, 0.69, -4.47},Build={Queue=2,Icons={"OT","OS"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["NABOO"] = {Loyalty="",Type="System",Subtype="Populous",Region=7,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={1.1,5,-0.2},MarkerSpot={9.56,0.8,1.16},GridSpots={},LogSpot={-25.68,0.79,-13.28},SabotageSpot={8.34, 0.69, 1.00},Build={Queue=1,Icons={"OT","BT"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["MUSTAFAR"] = {Loyalty="",Type="System",Subtype="Populous",Region=8,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={2.1,5,0.2},MarkerSpot={17.84,0.8,-1.92},GridSpots={},LogSpot={-23.56,0.79,-14.31},SabotageSpot={16.61, 0.69, -2.03},Build={Queue=2,Icons={"BT","BC"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["BESPIN"] = {Loyalty="",Type="System",Subtype="Populous",Region=8,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={1.7,5,0.7},MarkerSpot={15.18,0.8,-6.09},GridSpots={},LogSpot={-24.13,0.79,-15.93},SabotageSpot={13.97, 0.69, -6.23},Build={Queue=1,Icons={"OC"}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["HOTH"] = {Loyalty="",Type="System",Subtype="Remote",Region=8,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={2.2,5,0.6},MarkerSpot={19.4,0.8,-5.56},GridSpots={},LogSpot={-23.01,0.79,-15.67},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}
Locations["ENDOR"] = {Loyalty="",Type="System",Subtype="Remote",Region=8,Sabotaged=false,Scanned=false,Probed=false,Destroyed=false,Subjugated=false,Blockaded=false,CombatMarkerID="",ButtonSpot={1.7,5,1.1},MarkerSpot={15.11,0.8,-9.54},GridSpots={},LogSpot={-24.06,0.79,-17.26},SabotageSpot=nil,Build={Queue=0,Icons={}},Units={List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}}

Units = {}
Units["Stormtrooper"] = {BagID="6b573b",Count=0,Max=30,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.45,0.45,0.45},DamageY=0.81,DamageOffset={0,2,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="OT",Box="Base"}
Units["Assault Tank"] = {BagID="4505ba",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.19,OffsetZ=-0.04,AngleY=180,Scale={0.13,0.13,0.09},DamageY=0.56,DamageOffset={0,4.7,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Red",Build="OT",Box="RotE"}
Units["AT-ST"] = {BagID="e271c6",Count=0,Max=10,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.11,AngleY=180,Scale={0.08,0.08,0.08},DamageY=0.81,DamageOffset={0,10.8,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="OC",Box="Base"}
Units["Shield Bunker"] = {BagID="f9fa3a",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.25,OffsetZ=-0.21,AngleY=180,Scale={0.03,0.03,0.03},DamageY=0.96,DamageOffset={0,33.7,0},Faction="Imperial",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=3,HealthColor="Red",Build="OC",Box="RotE"}
Units["AT-AT"] = {BagID="7c3b27",Count=0,Max=4,GridX=2,GridZ=4,OffsetX=0.00,OffsetZ=-0.26,AngleY=0,Scale={0.11,0.11,0.11},DamageY=1.01,DamageOffset={0,9.6,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=2,GreenDice=0,Health=3,HealthColor="Red",Build="OS",Box="Base"}
Units["TIE Fighter"] = {BagID="29f627",Count=0,Max=24,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.2,0.2,0.2},DamageY=1.05,DamageOffset={0,5.5,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="BT",Box="Base"}
Units["TIE Striker"] = {BagID="1d349b",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.23,AngleY=180,Scale={0.2,0.2,0.2},DamageY=0.91,DamageOffset={0,4.8,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Black",Build="BT",Box="RotE"}
Units["Assault Carrier"] = {BagID="14d976",Count=0,Max=8,GridX=2,GridZ=4,OffsetX=0.00,OffsetZ=-0.16,AngleY=0,Scale={0.06,0.06,0.06},DamageY=0.57,DamageOffset={0,10.4,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="BC",Box="Base"}
Units["Star Destroyer"] = {BagID="64ecf6",Count=0,Max=8,GridX=3,GridZ=5,OffsetX=0.33,OffsetZ=-0.65,AngleY=0,Scale={0.09,0.08,0.08},DamageY=0.54,DamageOffset={0,7.5,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=6,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=2,GreenDice=0,Health=4,HealthColor="Red",Build="BS",Box="Base"}
Units["Super Star Destroyer"] = {BagID="90a2d8",Count=0,Max=2,GridX=3,GridZ=10,OffsetX=1.32,OffsetZ=-0.24,AngleY=0,Scale={0.2,0.2,0.2},DamageY=0.31,DamageOffset={0,1.8,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=8,NeedsTransport=false,Immobile=false,BlackDice=2,RedDice=3,GreenDice=0,Health=6,HealthColor="Red",Build="",Box="Base"}
Units["Interdictor"] = {BagID="757ff6",Count=0,Max=3,GridX=3,GridZ=5,OffsetX=0.17,OffsetZ=-0.43,AngleY=0,Scale={0.2,0.2,0.2},DamageY=0.82,DamageOffset={0,4.4,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=2,Health=4,HealthColor="Red",Build="",Box="RotE"}
Units["Death Star Under Construction"] = {BagID="090afc",Count=0,Max=1,GridX=3,GridZ=3,OffsetX=0,OffsetZ=0,AngleY=90,Scale={0.01,0.01,0.01},DamageY=0.6,DamageOffset={0,60,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Station",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=4,HealthColor="Black",Build="",Box="Base"}
Units["Death Star"] = {BagID="1e6540",Count=0,Max=2,GridX=3,GridZ=3,OffsetX=0.33,OffsetZ=-0.33,AngleY=0,Scale={0.09,0.09,0.09},DamageY=1,DamageOffset={0,0,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Station",Transport=8,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=4,GreenDice=0,Health=9999,HealthColor="",Build="",Box="Base"}
Units["Rebel Trooper"] = {BagID="3f9ee5",Count=0,Max=21,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.45,0.45,0.45},DamageY=0.91,DamageOffset={0,2.2,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="OT",Box="Base"}
Units["Rebel Vanguard"] = {BagID="ca216d",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.03,OffsetZ=-0.01,AngleY=0,Scale={0.45,0.45,0.45},DamageY=0.81,DamageOffset={0,2,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Black",Build="OT",Box="RotE"}
Units["Airspeeder"] = {BagID="31952e",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.05,AngleY=0,Scale={0.14,0.14,0.14},DamageY=0.31,DamageOffset={0,2.6,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="OC",Box="Base"}
Units["Golan Arms Turret"] = {BagID="988851",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.16,AngleY=180,Scale={1,1,1},DamageY=0.46,DamageOffset={0,0.55,0},Faction="Rebel",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=2,Health=3,HealthColor="Red",Build="OC",Box="RotE"}
Units["Shield Generator"] = {BagID="111449",Count=0,Max=3,GridX=3,GridZ=1,OffsetX=0.00,OffsetZ=-0.33,AngleY=0,Scale={0.35,0.35,0.35},DamageY=0.21,DamageOffset={0,0.8,0},Faction="Rebel",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=3,HealthColor="Red",Build="OS",Box="Base"}
Units["Ion Cannon"] = {BagID="af1c24",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.5,0.5,0.5},DamageY=0.35,DamageOffset={0,0.8,0},Faction="Rebel",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=3,HealthColor="Red",Build="OS",Box="Base"}
Units["X-Wing"] = {BagID="420fef",Count=0,Max=8,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.16,AngleY=0,Scale={0.22,0.22,0.22},DamageY=0.99,DamageOffset={0,4.8,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="BT",Box="Base"}
Units["Y-Wing"] = {BagID="ab8843",Count=0,Max=12,GridX=2,GridZ=3,OffsetX=0.00,OffsetZ=-0.16,AngleY=0,Scale={0.22,0.22,0.22},DamageY=1.05,DamageOffset={0,5,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=1,GreenDice=0,Health=1,HealthColor="Black",Build="BT",Box="Base"}
Units["U-Wing"] = {BagID="564515",Count=0,Max=6,GridX=1,GridZ=3,OffsetX=0.00,OffsetZ=-0.16,AngleY=0,Scale={0.15,0.15,0.15},DamageY=0.43,DamageOffset={0,3.2,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=1,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Black",Build="BT",Box="RotE"}
Units["Rebel Transport"] = {BagID="d931ee",Count=0,Max=4,GridX=1,GridZ=3,OffsetX=0.00,OffsetZ=-0.16,AngleY=180,Scale={0.25,0.25,0.25},DamageY=0.28,DamageOffset={0,1.4,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=0,Health=2,HealthColor="Red",Build="BT",Box="Base"}
Units["Corellian Corvette"] = {BagID="5943da",Count=0,Max=4,GridX=2,GridZ=4,OffsetX=0.00,OffsetZ=-0.31,AngleY=0,Scale={0.06,0.06,0.06},DamageY=0.62,DamageOffset={0,11.2,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=2,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="BC",Box="Base"}
Units["Nebulon-B Frigate"] = {BagID="c1cdc7",Count=0,Max=3,GridX=1,GridZ=4,OffsetX=0.05,OffsetZ=-0.48,AngleY=180,Scale={0.3,0.3,0.3},DamageY=1.12,DamageOffset={0,3.9,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=3,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=2,Health=3,HealthColor="Red",Build="BC",Box="RotE"}
Units["Mon Cala Cruiser"] = {BagID="d45244",Count=0,Max=3,GridX=2,GridZ=5,OffsetX=0.03,OffsetZ=-0.48,AngleY=0,Scale={0.33,0.33,0.33},DamageY=0.36,DamageOffset={0,1.3,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=2,GreenDice=0,Health=4,HealthColor="Red",Build="BS",Box="Base"}
--WFL Expansion Units...
Units["Darktrooper"] = {BagID="5663a1",Count=0,Max=5,GridX=2,GridZ=2,OffsetX=0,OffsetZ=0,AngleY=180,Scale={0.3,0.35,0.3},DamageY=0.81,DamageOffset={0,2.5,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=2,HealthColor="Black",Build="",Box="WFL"}
Units["Death Trooper"] = {BagID="43ac9b",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0,OffsetZ=0,AngleY=180,Scale={0.45,0.45,0.45},DamageY=0.81,DamageOffset={0,2,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=2,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="OC",Box="WFL"}
Units["Scout Trooper"] = {BagID="38421e",Count=0,Max=6,GridX=2,GridZ=3,OffsetX=0,OffsetZ=0,AngleY=180,Scale={0.35,0.35,0.35},DamageY=0.81,DamageOffset={0,2.5,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=1,Health=1,HealthColor="Green",Build="OT",Box="WFL"}
Units["TIE Advanced"] = {BagID="faf5a7",Count=0,Max=2,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.25,0.25,0.25},DamageY=0.48,DamageOffset={0,2.2,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=2,HealthColor="Black",Build="",Box="WFL"}
Units["TIE Bomber"] = {BagID="ea22ee",Count=0,Max=9,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.14,0.14,0.14},DamageY=0.56,DamageOffset={0,4.4,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=1,GreenDice=0,Health=1,HealthColor="Black",Build="BT",Box="WFL"}
Units["TIE Defender"] = {BagID="1dd318",Count=0,Max=5,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.65,0.65,0.65},DamageY=0.33,DamageOffset={0,0.6,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="",Box="WFL"}
Units["TIE Interceptor"] = {BagID="0e0f01",Count=0,Max=5,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.25,0.25,0.25},DamageY=1.27,DamageOffset={0,5.3,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Green",Build="BT",Box="WFL"}
Units["Delta Shuttle"] = {BagID="ebd1df",Count=0,Max=1,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.2,0.2,0.2},DamageY=0.96,DamageOffset={0,6.8,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=1,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=0,Health=1,HealthColor="Red",Build="",Box="WFL"}
Units["Lambda Shuttle"] = {BagID="842eb8",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.15,0.15,0.15},DamageY=0.86,DamageOffset={0,6.1,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=2,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=0,Health=1,HealthColor="Red",Build="BT",Box="WFL"}
Units["Light Cruiser"] = {BagID="3efec8",Count=0,Max=4,GridX=3,GridZ=4,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.045,0.045,0.045},DamageY=0.24,DamageOffset={0,6.5,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=5,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=2,Health=3,HealthColor="Red",Build="BC",Box="WFL"}
Units["Recruit"] = {BagID="442e68",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0,OffsetZ=0,AngleY=0,Scale={0.45,0.45,0.45},DamageY=1,DamageOffset={0,2,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=0,Health=0,HealthColor="",Build="OT",Box="WFL"}
Units["Wookiee Veteran"] = {BagID="bd062e",Count=0,Max=4,GridX=2,GridZ=2,OffsetX=0,OffsetZ=0,AngleY=0,Scale={0.45,0.45,0.45},DamageY=0.91,DamageOffset={0,2.2,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=1,Health=2,HealthColor="Black",Build="OC",Box="WFL"}
Units["Jedi Knight"] = {BagID="421238",Count=0,Max=2,GridX=2,GridZ=2,OffsetX=0,OffsetZ=0,AngleY=0,Scale={0.45,0.45,0.45},DamageY=0.81,DamageOffset={0,2,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=0,Health=1,HealthColor="Green",Build="OS",Box="WFL"}
Units["A-Wing"] = {BagID="86b88e",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.16,AngleY=180,Scale={0.35,0.35,0.35},DamageY=0.31,DamageOffset={0,1.1,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Green",Build="BT",Box="WFL"}
Units["B-Wing"] = {BagID="f4d5d0",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.16,AngleY=0,Scale={0.2,0.2,0.2},DamageY=1.02,DamageOffset={0,5.5,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=1,GreenDice=0,Health=2,HealthColor="Black",Build="BT",Box="WFL"}
Units["Light Freighter"] = {BagID="c36b95",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.06,0.06,0.06},DamageY=0.65,DamageOffset={0,11.8,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=1,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=0,Health=3,HealthColor="Black",Build="BC",Box="WFL"}
Units["Hammerhead Corvette"] = {BagID="8da31e",Count=0,Max=4,GridX=2,GridZ=4,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.16,0.16,0.16},DamageY=0.46,DamageOffset={0,3.2,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=2,NeedsTransport=false,Immobile=false,BlackDice=2,RedDice=0,GreenDice=0,Health=2,HealthColor="Red",Build="BC",Box="WFL"}
Units["Escort Carrier"] = {BagID="9b2233",Count=0,Max=2,GridX=3,GridZ=4,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.22,0.22,0.22},DamageY=0.9,DamageOffset={0,4.4,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=8,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=2,HealthColor="Red",Build="BC",Box="WFL"}
Units["MC75 Cruiser"] = {BagID="831132",Count=0,Max=1,GridX=3,GridZ=5,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.2,0.2,0.2},DamageY=1.1,DamageOffset={0,5.8,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=3,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=2,GreenDice=0,Health=3,HealthColor="Red",Build="BS",Box="WFL"}
Units["MC80 Cruiser"] = {BagID="0ed055",Count=0,Max=3,GridX=3,GridZ=5,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.3,0.3,0.3},DamageY=1.29,DamageOffset={0,4.9,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=2,GreenDice=1,Health=4,HealthColor="Red",Build="BS",Box="WFL"}

UnitQueue = {}	--{BagID="",UnitID="",Qty=1,Location=""}

function LoadOriginalUnits()
	--load table of original unit data...
	Units["Stormtrooper"] = {BagID="6b573b",Count=0,Max=30,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.25,0.25,0.25},DamageY=0.56,DamageOffset={0,2.5,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="OT",Box="Base"}
	Units["Assault Tank"] = {BagID="4505ba",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.19,OffsetZ=-0.04,AngleY=0,Scale={0.14,0.18,0.18},DamageY=0.34,DamageOffset={0,2.2,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Red",Build="OT",Box="RotE"}
	Units["AT-ST"] = {BagID="e271c6",Count=0,Max=10,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.11,AngleY=0,Scale={0.3,0.3,0.3},DamageY=0.46,DamageOffset={0,1.8,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="OC",Box="Base"}
	Units["Shield Bunker"] = {BagID="f9fa3a",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.25,OffsetZ=-0.21,AngleY=0,Scale={0.15,0.15,0.15},DamageY=0.81,DamageOffset={0,5.8,0},Faction="Imperial",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=3,HealthColor="Red",Build="OC",Box="RotE"}
	Units["AT-AT"] = {BagID="7c3b27",Count=0,Max=4,GridX=2,GridZ=4,OffsetX=0.00,OffsetZ=-0.26,AngleY=0,Scale={0.15,0.15,0.15},DamageY=0.35,DamageOffset={0,2.7,0},Faction="Imperial",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=2,GreenDice=0,Health=3,HealthColor="Red",Build="OS",Box="Base"}
	Units["TIE Fighter"] = {BagID="29f627",Count=0,Max=24,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=0,Scale={0.25,0.25,0.25},DamageY=0.37,DamageOffset={0,1.7,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="BT",Box="Base"}
	Units["TIE Striker"] = {BagID="1d349b",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.23,AngleY=180,Scale={0.9,0.9,0.9},DamageY=0.24,DamageOffset={0,0.35,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Black",Build="BT",Box="RotE"}
	Units["Assault Carrier"] = {BagID="14d976",Count=0,Max=8,GridX=2,GridZ=4,OffsetX=0.00,OffsetZ=-0.16,AngleY=0,Scale={0.38,0.38,0.38},DamageY=0.29,DamageOffset={0,0.9,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="BC",Box="Base"}
	Units["Star Destroyer"] = {BagID="64ecf6",Count=0,Max=8,GridX=3,GridZ=5,OffsetX=0.33,OffsetZ=-0.65,AngleY=180,Scale={0.25,0.25,0.25},DamageY=0.36,DamageOffset={0,1.7,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=6,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=2,GreenDice=0,Health=4,HealthColor="Red",Build="BS",Box="Base"}
	Units["Super Star Destroyer"] = {BagID="90a2d8",Count=0,Max=2,GridX=3,GridZ=10,OffsetX=1.32,OffsetZ=-0.24,AngleY=0,Scale={0.2,0.2,0.2},DamageY=0.31,DamageOffset={0,1.8,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=8,NeedsTransport=false,Immobile=false,BlackDice=2,RedDice=3,GreenDice=0,Health=6,HealthColor="Red",Build="",Box="Base"}
	Units["Interdictor"] = {BagID="757ff6",Count=0,Max=3,GridX=3,GridZ=5,OffsetX=0.17,OffsetZ=-0.43,AngleY=0,Scale={0.7,0.7,0.7},DamageY=0.26,DamageOffset={0,0.45,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=2,Health=4,HealthColor="Red",Build="",Box="RotE"}
	Units["Death Star Under Construction"] = {BagID="090afc",Count=0,Max=1,GridX=3,GridZ=3,OffsetX=0.33,OffsetZ=-0.66,AngleY=0,Scale={0.7,0.7,0.7},DamageY=0.92,DamageOffset={0,1.4,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Station",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=4,HealthColor="Black",Build="",Box="Base"}
	Units["Death Star"] = {BagID="1e6540",Count=0,Max=2,GridX=3,GridZ=3,OffsetX=0.33,OffsetZ=-0.33,AngleY=0,Scale={0.22,0.22,0.22},DamageY=1,DamageOffset={0,1,0},Faction="Imperial",Theater="Space",Type="Ship",SubType="Station",Transport=8,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=4,GreenDice=0,Health=9999,HealthColor="",Build="",Box="Base"}
	Units["Rebel Trooper"] = {BagID="3f9ee5",Count=0,Max=21,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.25,0.25,0.25},DamageY=0.56,DamageOffset={0,2.5,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="OT",Box="Base"}
	Units["Rebel Vanguard"] = {BagID="ca216d",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.03,OffsetZ=-0.01,AngleY=180,Scale={0.28,0.28,0.28},DamageY=0.52,DamageOffset={0,2.1,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Black",Build="OT",Box="RotE"}
	Units["Airspeeder"] = {BagID="31952e",Count=0,Max=6,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.05,AngleY=180,Scale={0.35,0.35,0.35},DamageY=0.25,DamageOffset={0,0.9,0},Faction="Rebel",Theater="Ground",Type="",SubType="",Transport=0,NeedsTransport=true,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="OC",Box="Base"}
	Units["Golan Arms Turret"] = {BagID="988851",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.16,AngleY=180,Scale={1,1,1},DamageY=0.46,DamageOffset={0,0.55,0},Faction="Rebel",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=2,Health=3,HealthColor="Red",Build="OC",Box="RotE"}
	Units["Shield Generator"] = {BagID="111449",Count=0,Max=3,GridX=3,GridZ=1,OffsetX=0.00,OffsetZ=-0.33,AngleY=180,Scale={0.35,0.35,0.35},DamageY=0.21,DamageOffset={0,0.8,0},Faction="Rebel",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=3,HealthColor="Red",Build="OS",Box="Base"}
	Units["Ion Cannon"] = {BagID="af1c24",Count=0,Max=3,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=0.00,AngleY=180,Scale={0.5,0.5,0.5},DamageY=0.35,DamageOffset={0,0.8,0},Faction="Rebel",Theater="Ground",Type="Structure",SubType="",Transport=0,NeedsTransport=false,Immobile=true,BlackDice=0,RedDice=0,GreenDice=0,Health=3,HealthColor="Red",Build="OS",Box="Base"}
	Units["X-Wing"] = {BagID="420fef",Count=0,Max=8,GridX=2,GridZ=2,OffsetX=0.00,OffsetZ=-0.16,AngleY=180,Scale={0.3,0.3,0.3},DamageY=0.32,DamageOffset={0,1.3,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=0,GreenDice=0,Health=1,HealthColor="Black",Build="BT",Box="Base"}
	Units["Y-Wing"] = {BagID="ab8843",Count=0,Max=12,GridX=2,GridZ=3,OffsetX=0.00,OffsetZ=-0.16,AngleY=180,Scale={0.25,0.25,0.25},DamageY=0.36,DamageOffset={0,1.7,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=0,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=1,GreenDice=0,Health=1,HealthColor="Black",Build="BT",Box="Base"}
	Units["U-Wing"] = {BagID="564515",Count=0,Max=6,GridX=1,GridZ=3,OffsetX=0.00,OffsetZ=-0.16,AngleY=0,Scale={0.8,0.8,0.8},DamageY=0.36,DamageOffset={0,0.53,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Fighter",Transport=1,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=1,Health=1,HealthColor="Black",Build="BT",Box="RotE"}
	Units["Rebel Transport"] = {BagID="d931ee",Count=0,Max=4,GridX=1,GridZ=3,OffsetX=0.00,OffsetZ=-0.16,AngleY=180,Scale={0.3,0.3,0.3},DamageY=0.22,DamageOffset={0,0.9,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=0,Health=2,HealthColor="Red",Build="BT",Box="Base"}
	Units["Corellian Corvette"] = {BagID="5943da",Count=0,Max=4,GridX=2,GridZ=4,OffsetX=0.00,OffsetZ=-0.31,AngleY=180,Scale={0.2,0.2,0.2},DamageY=0.29,DamageOffset={0,1.7,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=2,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=1,GreenDice=0,Health=2,HealthColor="Red",Build="BC",Box="Base"}
	Units["Nebulon-B Frigate"] = {BagID="c1cdc7",Count=0,Max=3,GridX=1,GridZ=4,OffsetX=0.05,OffsetZ=-0.48,AngleY=180,Scale={0.8,0.8,0.8},DamageY=0.62,DamageOffset={0,0.85,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=3,NeedsTransport=false,Immobile=false,BlackDice=0,RedDice=0,GreenDice=2,Health=3,HealthColor="Red",Build="BC",Box="RotE"}
	Units["Mon Cala Cruiser"] = {BagID="d45244",Count=0,Max=3,GridX=2,GridZ=5,OffsetX=0.03,OffsetZ=-0.48,AngleY=0,Scale={0.3,0.3,0.3},DamageY=0.27,DamageOffset={0,1.1,0},Faction="Rebel",Theater="Space",Type="Ship",SubType="Capital",Transport=4,NeedsTransport=false,Immobile=false,BlackDice=1,RedDice=2,GreenDice=0,Health=4,HealthColor="Red",Build="BS",Box="Base"}
	--switch over to original?
	if Game.Flags.Painted then
		Game.Flags.Painted = false
		--reset the infinite unit bags over to the orignal units (go through each item in the original unit bag)...
		for I,Item in pairs(getObjectFromGUID("46904c").getObjects()) do 
			if Units[Item.name] != nil then
				if getObjectFromGUID(Units[Item.name].BagID) != nil then
					getObjectFromGUID(Units[Item.name].BagID).reset()
					local UnitObj = getObjectFromGUID("46904c").takeObject({guid=Item.guid,smooth=true,position={getObjectFromGUID(Units[Item.name].BagID).getPosition().x,3,getObjectFromGUID(Units[Item.name].BagID).getPosition().z},rotation={0,Units[Item.name].AngleY,0}})
					getObjectFromGUID(Units[Item.name].BagID).putObject(UnitObj)
				end--if
			end--if
		end--for I,Item
	end--if
end--function 


function onLoad(SaveState)
	--flip all cards in hidden zones face down... 
	for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.MissionSecretZone).getObjects()) do 
		if Obj.type == "Card" or Obj.type == "Deck" then
			Obj.setRotation({0,0,180})
			Obj.setHiddenFrom({"Blue","Orange","Grey"})
			Obj.clearButtons()
			Obj.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.6}})
		end--if
	end--for O,Obj 
	for O,Obj in pairs(getObjectFromGUID(IDs.Imperial.MissionSecretZone).getObjects()) do 
		if Obj.type == "Card" or Obj.type == "Deck" then
			Obj.setRotation({0,180,180})
			Obj.setHiddenFrom({"White","Red","Grey"})
			Obj.clearButtons()
			Obj.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
		end--if
	end--for O,Obj 	--init game panels...
	UpdateBoard(false)--update the board, such as loyalty, sabotage, unit counts, etc.
	SetupPanel = getObjectFromGUID(IDs.SetupPanel)
	ImperialPanel = getObjectFromGUID(IDs.ImperialPanel)
	RebelPanel = getObjectFromGUID(IDs.RebelPanel)
	ImperialDicePanel = getObjectFromGUID(IDs.ImperialDicePanel)
	RebelDicePanel = getObjectFromGUID(IDs.RebelDicePanel)
	CombatBoard = getObjectFromGUID(IDs.CombatBoard)
	--freeze objects...
	getObjectFromGUID(IDs.Table).interactable = false
	getObjectFromGUID(IDs.GameBoard).interactable = false
	getObjectFromGUID(IDs.Rebel.AssignmentBoard).interactable = false
	getObjectFromGUID(IDs.Imperial.AssignmentBoard).interactable = false
	getObjectFromGUID(Decks.RebelBase.PadID).interactable = false
	CombatBoard.interactable = false
	--ImperialPanel.interactable = false--keep this off or it displays buttons when hidden.
	--RebelPanel.interactable = false--keep this off or it displays buttons when hidden.
	ImperialDicePanel.interactable = false
	RebelDicePanel.interactable = false
	--init teams...
	printToAll("Imperials are team Spades.")
	Player["Blue"].team = "Spades"
	Player["Orange"].team = "Spades"
	printToAll("Rebels are team Hearts.")
	Player["White"].team = "Hearts"
	Player["Red"].team = "Hearts"
	--resume a game?
	if SaveState != "null" and SaveState != nil and SaveState != "" then
		printToAll("Resuming previous game...")
		if Player["White"].seated then
			Player["White"].changeColor("Grey")
		end--if
		Game = JSON.decode(SaveState).Game
		NextStep = JSON.decode(SaveState).NextStep
		ResumeStep = JSON.decode(SaveState).Step
		printToAll(" Round: "..Game.Round)
		printToAll(" Phase: "..Game.Phase)
		printToAll(" Turn: ("..Game.Turn.Num..")"..Game.Turn.Faction.." "..Game.Turn.Role)
		printToAll(" Step: "..NextStep)
		if Game.Flags.Painted then
			printToAll("Playing with painted units.")
		else
			printToAll("Playing with original units.")
			LoadOriginalUnits()
		end--if
		--resuming to leader recruit step of refresh stage?
		if ResumeStep != "RefreshPhase.V.i.ChooseActionCard" then
			for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.HiddenPanelZone).getObjects()) do 
				if Obj.type == "Card" or Obj.type == "Deck" then
					Obj.setRotation({0,0,180})
					Obj.setHiddenFrom({"Blue","Orange","Grey"})
					Obj.clearButtons()
					Obj.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.6}})
				end--if
			end--for O,Obj 
			for O,Obj in pairs(getObjectFromGUID(IDs.Imperial.HiddenPanelZone).getObjects()) do 
				if Obj.type == "Card" or Obj.type == "Deck" then
					Obj.setRotation({0,180,180})
					Obj.setHiddenFrom({"White","Red","Grey"})
					Obj.clearButtons()
					Obj.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
				end--if
			end--for O,Obj 	--init game panels...
			--lower recruit hidden zones (in case they are up)...
			getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
			getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.Off,false,false)
		end--if
		--cartwheel leaders with rings to raise them above the table... 
    	for O,Obj in pairs(getAllObjects()) do
      		--object is a leader?
      		if Obj.getVar("Component") == "Leader" then
        		--leader as a ring?
        		if #Obj.getAttachments() > 0 then
          			--flip leader like a salt shaker to work around bug where they sink into the floor...
					Obj.flip()
					Wait.time(function() Obj.flip() end,1)
        		end--if
      		end--if 
    	end--for O,Obj 
	else--start new game...
		log("Starting a new game...")
		NextStep = "Setup.0.StartSetup"
	end--if
	--update all unit box display counts... 
	for U,Unit in pairs(Units) do 
		UpdateUnitBox(U)
		--update all unit infinite bags with " of "
	end--for U,Unit 
	Step = ""
	--start main coroutine...
	startLuaCoroutine(Global,"MainCoroutine")
	--wait 2 seconds, then flag Loaded as done. 
	Wait.time(function() Loaded = true end,2)
end--function

function onSave()
	local SaveState = nil
	--only save the game if it started...
	if Game.Round > 0 then
		SaveState = {
			Game = Game,
			--Locations = Locations,
			Step = Step,
			NextStep = NextStep,
			ResumeStep = ResumeStep
		}
		--log("Gamedata saved.")
		return JSON.encode(SaveState)
	end--if
end--function

--GLOBAL OBJECT EVENTS==================================================================================================================================================

function onObjectPeek(Obj,Player)
	if Obj.getGUID() == RebelBaseCardID then
		if Player != "White" and Player != "Red" and (getObjectFromGUID(RebelBaseCardID).getRotation().z < 90 or  getObjectFromGUID(RebelBaseCardID).getRotation().z > 270) then
			PlaySound({ID=53})
			broadcastToAll("Alert: Hidden Rebel Base Probe Card was peeked at by "..Player.." Player.")
		end--if
	end--if
end--if

function onObjectSearchStart(Obj,Player)
	local ContainerName = "the "..Obj.getName()
	if ContainerName == "the " then
    ContainerName = "a "..Obj.tag
	end--if
	broadcastToAll(Player.." Player is searching "..ContainerName.." [ID:"..Obj.getGUID().."]")
end--function

--function onPlayerAction(Player,Action,Targets)
  --log(tostring(Player.color).." player performed action:"..tostring(Action))
  --return true
--end--function

function onObjectLeaveContainer(Container,Object)
	if Object.getDescription() == nil then Object.setDescription("") end--if
  --which container?
  if Container.getGUID() == Decks.RebelMission.ID then
      if string.find(Object.getDescription(),"MissionCard;") != nil then
        Object.setHiddenFrom({"Blue","Orange","Grey"})
        Object.clearButtons()
        Object.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
      end--if
  elseif Container.getGUID() == Decks.ImperialMission.ID or Container.getGUID() == Decks.ImperialProject.ID then
    if string.find(Object.getDescription(),"MissionCard;") != nil then
      Object.setHiddenFrom({"White","Red","Grey"})
      Object.clearButtons()
      Object.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
    end--if
  elseif Container.getGUID() == Decks.Probe.ID then
    printToAll("A Probe card was drawn.")
  --elseif Container.type == "Infinite" and string.find(Object.getDescription(),"Unit;") != nil then
    --add lua code... 
    --local Script = " function onLoad(save_state)\n  Scale = 1 / self.getScale().x \n Global.call('UnitOnLoad',{Unit=self}) \n end--function \n\n"
    --Script = Script.." function onDrop(PlayerColor)\n  Global.call('UnitOnDrop',{Unit=self,Player=PlayerColor}) \n end--function \n\n"
    --Script = Script.." function onPickUp(PlayerColor)\n  Global.call('UnitOnPickUp',{Unit=self,Player=PlayerColor}) \n end--function \n\n"
	--Script = Script.." function onDestroy()\n  if Global != nil then \n   Global.call('UnitOnDestroy',{Unit=self}) \n  end--if \n end--function\n\n"
	--Script = Script.." function onCollisionEnter(collision_info)\n  Global.call('UnitOnCollision',{Unit=self,Info=collision_info})\n end--function" 
	--Object.setLuaScript(Script)
	--Object.setVar("Component","Unit")
  end--if
end--function 

function onObjectEnterZone(Zone,Object)
	if Object.getDescription() == nil then Object.setDescription("") end--if
    --which zone? 
    if Zone.getGUID() == IDs.Rebel.MissionSecretZone then
        if Object.type == "Card" or Object.type == "Deck" then
			Object.setHiddenFrom({"Blue","Orange","Grey"})
			Object.clearButtons()
			Object.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
			UpdateRevealButtons(Zone)
        end--if
    elseif Zone.getGUID() == IDs.Imperial.MissionSecretZone then
        if Object.type == "Card" or Object.type == "Deck" then
          Object.setHiddenFrom({"White","Red","Grey"})
          Object.clearButtons()
          Object.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
		  UpdateRevealButtons(Zone)
        end--if
    elseif Zone.getGUID() == IDs.Rebel.MissionDiscardZone or Zone.getGUID() == IDs.Imperial.MissionDiscardZone or Zone.getGUID() == IDs.Imperial.ProjectDiscardZone then
        if Object.type == "Card" or Object.type == "Deck" then
          Object.setHiddenFrom({})
          Object.clearButtons()
        end--if
    elseif Zone.getGUID() == IDs.Rebel.MissionRevealedZone then
      if Object.type == "Card" then
        Object.setHiddenFrom({})
        Object.clearButtons()
        --mission helper buttons?
        AddSoundButton(Object)--add sound effect button if one exists.
        if Object.getName() == "INFILTRATION" then
			Object.createButton({click_function="InfiltrationSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Infiltration Mission was successful."})
			Object.createButton({click_function="InfiltrationFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Infiltration Mission failed."})
    	elseif Object.getName() == "SABOTAGE" then
			Object.createButton({click_function="SabotageSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Sabotage Mission was successful."})
			Object.createButton({click_function="SabotageFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Sabotage Mission failed."})
        elseif Object.getName() == "COVERT OPERATION" then
			Object.createButton({click_function="CovertOperationSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Covert Operation Mission was successful."})
			Object.createButton({click_function="CovertOperationFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Covert Operation Mission failed."})
        elseif Object.getName() == "STOLEN PLANS" then
			Object.createButton({click_function="StolenPlansSuccess",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Stolen Plans Mission was successful."})
			Object.createButton({click_function="StolenPlansFail",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Stolen Plans Mission failed."})
        elseif Object.getName() == "PLANT FALSE LEAD" then
			Object.createButton({click_function="PlantFalseLeadResolve",function_owner=Global,label="Resolve",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Plant False Lead Mission was successful."})
			Object.createButton({click_function="PlantFalseLeadResolved",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Plant False Lead Mission failed."})
        elseif Object.getName() == "SEEK YODA" then
			Object.createButton({click_function="SeekYodaResolved",function_owner=Global,label="Resolve",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="get the Master Yoda attachment ring."})
			Object.createButton({click_function="SeekYodaDone",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Done."})
        elseif Object.getName() == "CONTACT SMUGGLERS" then
			Object.createButton({click_function="ContactSmugglersSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Contact Smugglers Mission was successful."})
			Object.createButton({click_function="ContactSmugglersFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Contact Smugglers Mission failed."})
		  end--end
      end--if
    elseif Zone.getGUID() == IDs.Imperial.MissionRevealedZone then
        if Object.type == "Card" then
                Object.setHiddenFrom({})
                Object.clearButtons()
                --mission helper buttons?
				AddSoundButton(Object)--add sound effect button if one exists.
                if Object.getName() == "RESEARCH AND DEVELOPMENT" then
                  Object.createButton({click_function="ResearchAndDevelopmentDraw2",function_owner=Global,label="Draw 2 Projects",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Draw 2 Projects. Keep 1 and place the other on the bottom of the Project Deck."})
                  Object.createButton({click_function="ResearchAndDevelopmentDraw1",function_owner=Global,label="Draw 1 Project",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Draw 1 Project to keep, and remove a Sabotage Marker."})
				elseif Object.getName() == "GATHER INTEL" then
					Object.createButton({click_function="GatherIntelSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Gather Intel Mission was successful."})
					Object.createButton({click_function="GatherIntelFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Gather Intel Mission failed."})
				elseif Object.getName() == "CAPTURE REBEL OPERATIVE" or Object.getName() == "COLLECT BOUNTY" then
                  	Object.createButton({click_function="CaptureSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Capture was successful."})
                  	Object.createButton({click_function="CaptureFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Capture failed."})
                elseif Object.getName() == "LURE OF THE DARK SIDE" then
                  Object.createButton({click_function="LureOfTheDarkSideSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Lure of the Dark Side Mission was successful."})
                  Object.createButton({click_function="LureOfTheDarkSideFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Lure of the Dark Side Mission failed."})
                elseif Object.getName() == "CARBON FREEZING" then
                  Object.createButton({click_function="CarbonFreezingSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Carbon Freezing Mission was successful."})
                  Object.createButton({click_function="CarbonFreezingFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Carbon Freezing Mission failed."})
                elseif Object.getName() == "INTERCEPT TRANSMISSION" then
                  --Object.createButton({click_function="InterceptTransmissionSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Intercept Transmission was successful."})
                  --Object.createButton({click_function="InterceptTransmissionFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Intercept Transmission failed."})
                elseif Object.getName() == "PURSUIT" then
					Object.createButton({click_function="PursuitSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Pursuit was successful."})
					Object.createButton({click_function="PursuitFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Pursuit failed."})
                elseif Object.getName() == "MERCENARY TRAP" then
					Object.createButton({click_function="MercenaryAssistanceSuccessful",function_owner=Global,label="Succeeded",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Mercenary Trap was successful."})
					Object.createButton({click_function="MercenaryAssistanceFailed",function_owner=Global,label="Failed",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Mercenary Trap failed."})
                elseif Object.getName() == "TACTICAL TRAINING" then
					Object.createButton({click_function="TacticalTrainingResolved",function_owner=Global,label="Fetch Ring",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Fetch the Tactical Training Ring."})
  				end--end
        end--if
	elseif Zone.getGUID() == IDs.Rebel.BaseProbeCardZone then
		if string.find(Object.getDescription(),"ProbeCard;") != nil then
			--hide from imperial players when card enters zone... 
			Object.setHiddenFrom({"Blue","Orange","Grey"})
			Object.clearButtons()
			Object.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0,0.2,-0.8},scale={0.5,0.5,0.5},width=0,height=0,font_size=300,font_color={1,1,1}})
			Object.setGMNotes("Hidden")
		end--if probecard?
    elseif Zone.getGUID() == IDs.CombatZone then
		if Object.getDescription() != nil then
			--advanced tactic card?
			if string.find(Object.getDescription(),"AdvancedTacticCard;") != nil then 
				AdvancedTacticMenu(Object)
			elseif Object.getVar("Component") == "Unit"  then 
				--update combat theater unit count... 
				Counts.Combat[Object.getVar("Faction")][Object.getVar("Theater")] = Counts.Combat[Object.getVar("Faction")][Object.getVar("Theater")] + 1
				--unit entered into combat (try to update the location from combat)...
				--if CombatLocation != nil and CombatLocation != "" then
					--Object.setGMNotes(UpdateTag({Text=Object.getGMNotes(),Tag="Location",Value=CombatLocation}))
				--else
					--Object.setGMNotes(RemoveTag({Text=Object.getGMNotes(),Tag="Location"}))
				--end--if
				UpdateCombatBoard(Object.getGUID())
			elseif Object.getVar("Component") == "Leader" then
				--update space tactics value? (if higher than current)... 
				if Tactics[Object.getVar("Faction")].Space < GetLeaderTactic({Leader=Object,Theater="Space"}) then
					Tactics[Object.getVar("Faction")].Admiral = Object.getName()
					Tactics[Object.getVar("Faction")].Space = GetLeaderTactic({Leader=Object,Theater="Space"})
					log(Tactics[Object.getVar("Faction")].Admiral.." is the acting Admiral in Combat (Space Tactics:"..tostring(Tactics[Object.getVar("Faction")].Space)..").")
				end--if
				--update ground tactics value? (if higher than current)... 
				if Tactics[Object.getVar("Faction")].Ground < GetLeaderTactic({Leader=Object,Theater="Ground"}) then
					Tactics[Object.getVar("Faction")].General = Object.getName()
					Tactics[Object.getVar("Faction")].Ground = GetLeaderTactic({Leader=Object,Theater="Ground"})
					log(Tactics[Object.getVar("Faction")].General.." is the acting General in Combat (Ground Tactics:"..tostring(Tactics[Object.getVar("Faction")].Ground)..").")
				end--if
				--leader entered into combat (try to get the location from combat)...
				if CombatLocation != nil and CombatLocation != "" then
					Object.setGMNotes(UpdateTag({Text=Object.getGMNotes(),Tag="Location",Value=CombatLocation}))
				else
					Object.setGMNotes(RemoveTag({Text=Object.getGMNotes(),Tag="Location"}))
				end--if
				UpdateCombatBoard(Object.getGUID())
			end--if
		end--if
	elseif Zone.getGUID() == IDs.Rebel.AdvancedTacticDiscardZone or Zone.getGUID() == IDs.Imperial.AdvancedTacticDiscardZone then
		--advanced tactic card?
		if string.find(Object.getDescription(),"AdvancedTacticCard;") != nil then 
			--clear any buttons on the card... 
			Object.clearButtons()
		end--if
    elseif Zone.getGUID() == IDs.Rebel.MissionHand then
        if Object.type == "Card" then
            if string.find(Object.getDescription(),"MissionCard;") != nil then
                Object.setHiddenFrom({"Blue","Orange","Grey"})
                Object.clearButtons()
				Object.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
            end--if
        end--if
    elseif Zone.getGUID() == IDs.Imperial.MissionHand then
        if Object.type == "Card" then
            if string.find(Object.getDescription(),"MissionCard;") != nil then
                Object.setHiddenFrom({"White","Red","Grey"})
                Object.clearButtons()
				Object.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
            end--if
        end--if
    elseif Zone.getGUID() == IDs.Imperial.ProbeHand then
        if Object.type == "Card" then
            if string.find(Object.getDescription(),"ProbeCard;") != nil then
                Object.setHiddenFrom()
                Object.clearButtons()
				UpdateImperialProbeMap(Object.getName(),5)
            end--if
        end--if
	end--if
end--function

function onObjectLeaveZone(Zone,Object)
	if Object.getDescription() == nil then Object.setDescription("") end--if
	if (Zone.getGUID() == IDs.Rebel.MissionSecretZone or Zone.getGUID() == IDs.Imperial.MissionSecretZone) and (Object.type == "Card" or Object.type == "Deck") then
		UpdateRevealButtons(Zone)
	elseif Zone.getGUID() == IDs.Rebel.BaseProbeCardZone then
		if string.find(Object.getDescription(),"ProbeCard;") != nil then
			log("Rebel Base Probe Card removed.")
			--remove hidden... 
			Object.setHiddenFrom()
			Object.clearButtons()
			Object.setGMNotes("")
			--clear scan history (base changed)... 
			for L,Location in pairs(Locations) do 
				Location.Scanned = false
				Location.Probed = false
				--imperial unit?
				if Location.Units.Imperial.Space + Location.Units.Imperial.Ground > 0 then
					Location.Scanned = true
				end--if
				--imperial loyalty?
				if Location.Loyalty == "Imperial" then 
					Location.Scanned = true
				end--if
				--do we have the probe card?
				if CardInHand({Player="Blue",Index=Hands.ImperialProbe.Index,Name=L}) then
					Location.Probed = true
				end--if
				if not Location.Scanned and not Location.Probed then
					UpdateImperialProbeMap(L,2)
				end--if
			end--for L,Location 
			--starting imperial system?
			for S=1,#Game.Systems.Imperial do 
				if L == Game.Systems.Imperial[S] then
					Locations[Game.Systems.Imperial[S]].Probed = true
					Locations[Game.Systems.Imperial[S]].Scanned = true
				end--if L
			end--for S
			if Locations[Game.Systems.DSUC] != nil then
				Locations[Game.Systems.DSUC].Scanned = true
				Locations[Game.Systems.DSUC].Probed = true
			end--if
			log("Rebel Base scan log has been reset.")
		end--probe card?
    elseif Zone.getGUID() == IDs.CombatZone and CombatLocation != "" then 
		--unit or leader object that left?
		if Object.getVar("Component") == "Unit" then
			--update combat theater unit count... 
			Counts.Combat[Object.getVar("Faction")][Object.getVar("Theater")] = Counts.Combat[Object.getVar("Faction")][Object.getVar("Theater")] - 1
			UpdateCombatBoard(Object.getGUID())
		elseif Object.getVar("Component") == "Leader" then
			--acting admiral or general departed?
			if Tactics[Object.getVar("Faction")].Admiral == Object.getName() or Tactics[Object.getVar("Faction")].General == Object.getName() then
				UpdateCombatLeaders()
			end--if
			UpdateCombatBoard(Object.getGUID())
		end--if
	elseif Zone.getGUID() == IDs.Rebel.ActionHand or Zone.getGUID() == IDs.Imperial.ActionHand then
		if string.find(Object.getDescription(),"ActionCard;") != nil then
			Object.clearButtons()
			Object.setHiddenFrom()
			AddSoundButton(Object)
		end--if
    elseif Zone.getGUID() == IDs.Imperial.ProbeHand then
        if Object.type == "Card" then
            if string.find(Object.getDescription(),"ProbeCard;") != nil then
                Object.clearButtons()
				if Locations[Object.getName()].Scanned then
					UpdateImperialProbeMap(Object.getName(),3)
				elseif Locations[Object.getName()].Units.Imperial.Ground > 0 then
					UpdateImperialProbeMap(Object.getName(),3)
				elseif Locations[Object.getName()].Units.Imperial.Space > 0 then
					UpdateImperialProbeMap(Object.getName(),4)
				else
					UpdateImperialProbeMap(Object.getName(),2)
				end--if
            end--if
        end--if
	end--if
end--function

function UpdateRevealButtons(Zone)
	if Zone.getGUID() == IDs.Rebel.MissionSecretZone then
		getObjectFromGUID(IDs.Rebel.AssignmentBoard).clearButtons()
		for O,Obj in pairs(Zone.getObjects()) do 
			if Obj.getPosition().x < -7.875 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel1",function_owner=Global,label="Reveal",position={2.14,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < -5.625 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel2",function_owner=Global,label="Reveal",position={1.605,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < -3.375 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel3",function_owner=Global,label="Reveal",position={1.07,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < -1.125 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel4",function_owner=Global,label="Reveal",position={0.535,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 1.125 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel5",function_owner=Global,label="Reveal",position={0,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 3.375 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel6",function_owner=Global,label="Reveal",position={-0.535,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 5.625 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel7",function_owner=Global,label="Reveal",position={-1.07,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 7.875 then
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel8",function_owner=Global,label="Reveal",position={-1.605,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			else
				getObjectFromGUID(IDs.Rebel.AssignmentBoard).createButton({click_function="RevealCardRebel9",function_owner=Global,label="Reveal",position={-2.14,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			end--if
		end--for O,Obj 
	elseif Zone.getGUID() == IDs.Imperial.MissionSecretZone then
		getObjectFromGUID(IDs.Imperial.AssignmentBoard).clearButtons()
		for O,Obj in pairs(Zone.getObjects()) do 
			if Obj.getPosition().x < -7.875 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial1",function_owner=Global,label="Reveal",position={-2.14,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < -5.625 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial2",function_owner=Global,label="Reveal",position={-1.605,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < -3.375 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial3",function_owner=Global,label="Reveal",position={-1.07,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < -1.125 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial4",function_owner=Global,label="Reveal",position={-0.535,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 1.125 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial5",function_owner=Global,label="Reveal",position={0,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 3.375 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial6",function_owner=Global,label="Reveal",position={0.535,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 5.625 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial7",function_owner=Global,label="Reveal",position={1.07,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			elseif Obj.getPosition().x < 7.875 then
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial8",function_owner=Global,label="Reveal",position={1.605,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			else
				getObjectFromGUID(IDs.Imperial.AssignmentBoard).createButton({click_function="RevealCardImperial9",function_owner=Global,label="Reveal",position={2.14,0.1,-0.25},scale={0.5,0.5,0.5},color={1,1,1,0.7},width=500,height=250,font_size=100,tooltip="Reveal this Mission."})
			end--if
		end--for O,Obj 
	end--if
end--function 

function RevealCardRebel1() RevealCard("Rebel",1) end--function 
function RevealCardRebel2() RevealCard("Rebel",2) end--function 
function RevealCardRebel3() RevealCard("Rebel",3) end--function 
function RevealCardRebel4() RevealCard("Rebel",4) end--function 
function RevealCardRebel5() RevealCard("Rebel",5) end--function 
function RevealCardRebel6() RevealCard("Rebel",6) end--function 
function RevealCardRebel7() RevealCard("Rebel",7) end--function 
function RevealCardRebel8() RevealCard("Rebel",8) end--function 
function RevealCardRebel9() RevealCard("Rebel",9) end--function 
function RevealCardImperial1() RevealCard("Imperial",1) end--function 
function RevealCardImperial2() RevealCard("Imperial",2) end--function 
function RevealCardImperial3() RevealCard("Imperial",3) end--function 
function RevealCardImperial4() RevealCard("Imperial",4) end--function 
function RevealCardImperial5() RevealCard("Imperial",5) end--function 
function RevealCardImperial6() RevealCard("Imperial",6) end--function 
function RevealCardImperial7() RevealCard("Imperial",7) end--function 
function RevealCardImperial8() RevealCard("Imperial",8) end--function 
function RevealCardImperial9() RevealCard("Imperial",9) end--function 
function RevealCard(Faction,Slot)
	local X = -11.25+2.25*Slot
	local Z = 1
	local R = {0,0,0}
	if Faction == "Imperial" then 
		Z = -1 
		R = {0,180,0}
	end--if
	for O,Obj in pairs(Physics.cast({origin={X,1,Z*15},orientation={0,0,0},direction={0,1,0},type=3,size={1,1,1},max_distance=0,debug=false})) do
		if Obj.hit_object.type == "Card" or Obj.hit_object.type == "Deck" then
			Obj.hit_object.setPositionSmooth({X,0.8,Z*13.75},false,false)
			Obj.hit_object.setRotationSmooth(R,false,false)
			printToAll(Faction.." Player revealed: "..Obj.hit_object.getName()..".")
			break
		end--if
	end--for
end--function 

function AddSoundButton(Object)
    if GetSoundID(Object.getName()) > 0 then
        Object.createButton({click_function="PlaySoundEffect",function_owner=Global,label=">",position={0.9,0.2,-1.1},scale={0.5,0.5,0.5},color={1,1,1,0.8},width=300,height=300,font_size=300,tooltip="Play Sound Effect."})
    end--if
end--function 

function PlaySoundEffect(Object)
    PlaySound({ID=GetSoundID(Object.getName())})
end--function 

function GetSoundID(Title)
    if Title == "RESOURCEFUL ASTROMECH" then return 3
    elseif Title == "HUMAN-CYBORG RELATIONS" then return 2
    elseif Title == "ACCORDING TO MY DESIGN" then return 14
    elseif Title == "BLINDSIDE" then return 15
    elseif Title == "BOBA FETT? WHERE?" then return 16
    elseif Title == "BRILLIANT ADMINISTRATOR" then return 17
    elseif Title == "TARGET THE STAR DESTROYERS" then return 18
    elseif Title == "IT IS YOUR DESTINY" then return 19
    elseif Title == "IT'S A TRAP" then return 20
    elseif Title == "KEEP THEM FROM ESCAPING" then return 21
    elseif Title == "MORE DANGEROUS THAN YOU REALIZE" then return 22
    elseif Title == "POINT-BLANK ASSAULT" then return 23
    elseif Title == "PUBLIC SUPPORT" then return 24
    elseif Title == "START THE EVACUATION" then return 25
    elseif Title == "TARGET THE GENERATOR" then return 26
    elseif Title == "ONE IN A MILLION" then return 27
    elseif Title == "OUR MOST DESPERATE HOUR" then return 28
    elseif Title == "SON OF SKYWALKER" then return 29
    elseif Title == "NOBLE SACRIFICE" then return 30
    elseif Title == "WOOKIEE GUARDIAN" then return 31
    elseif Title == "FEAR WILL KEEP THEM IN LINE" then return 32
    elseif Title == "PLANETARY CONQUEST" then return 33
    elseif Title == "RETRIEVE THE PLANS" then return 34
    elseif Title == "LONG-RANGE PROBE" then return 35
    elseif Title == "PROBE DROID INITIATIVE" then return 35
    elseif Title == "DISPLAY OF POWER" then return 52	--change to "Fire at will commander!"
    end--if
    return 0
end--function 

function UpdateBoard(Verbose)
	SuppressVictoryCheck = true
	if Verbose == nil then Verbose = false end--if
    --loop through all locations and reset flags and counts...
    for L,Location in pairs(Locations) do
        --reset location flags...
        Location.Destroyed = false	--false until proven true.
        Location.Sabotaged = false	--false until proven true.
        Location.Blockaded = false	--false until proven true.
        Location.Subjugated = false	--false until proven true.
        Location.Neutral = true
        --start recount of all units on the board... 
        Location.Units = {List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}
    end--for
    --update all unit locations...
    for O,Obj in pairs(getAllObjects()) do
        if Obj.getVar("Component") == "Unit" then
            Obj.setGMNotes("")	--remove prev location, it will be redetected to update count if game is reloaded.
            Obj.setVar("Location","")
            UnitUpdateLocation(Obj)	
			if Step != "RefreshPhase.VI.DeployUnits" and Step != "RefreshPhase.VI.DeployRebelUnits" and Step != "RefreshPhase.VI.DeployImperialUnits" then
				Obj.clearButtons()
			end--if
        end--if
    end--for
    --loop through all locations and update its info...
    for L,Location in pairs(Locations) do
        --log("Analyzing "..L.."...")
        --scan for Markers...
        local Markers = ScanForObjects({Description="Marker;",Origin=Location.MarkerSpot,Size={2,2,2},Debug=false})
        --loop through markers... (Loyalty, Destroyed, Sabotage)?
        for M,Marker in pairs(Markers) do
			if Marker.getDescription() == nil then Marker.setDescription("") end--if
            if string.find(Marker.getDescription(),"DestroyedMarker;") != nil then
                Location.Destroyed = true
				Location.scanned = true	--mark as already scanned.
            elseif string.find(Marker.getDescription(),"SabotageMarker;") != nil then
                Location.Sabotaged = true
            elseif string.find(Marker.getDescription(),"LoyaltyMarker;Imperial;") != nil then
				Marker.setGMNotes(L)--store location name in the loyalty marker's gm notes.
                Location.Loyalty = "Imperial"
				Location.scanned = true	--mark as already scanned.
            elseif string.find(Marker.getDescription(),"LoyaltyMarker;Rebel;") != nil then
				Marker.setGMNotes(L)--store location name in the loyalty marker's gm notes.
                Location.Loyalty = "Rebel"
                --subjugated Rebel System?
                if Location.Units.Imperial.Ground > 0 then
                    Location.Subjugated = true
                    Marker.setRotation({0,180,180})
					Location.scanned = true	--mark as already scanned.
                else
                    Location.Subjugated = false
                    Marker.setRotation({0,180,0})
                end--if
            elseif string.find(Marker.getDescription(),"LoyaltyMarker;Neutral;") != nil then
				Marker.setGMNotes(L)--store location name in the loyalty marker's gm notes.
                Location.Loyalty = "Neutral"
                --subjugated Neutral System?
                if Location.Units.Imperial.Ground > 0 then
                    Location.Subjugated = true
                    Marker.setRotation({0,180,180})
					Location.scanned = true	--mark as already scanned.
                else
                    Location.Subjugated = false
                    Marker.setRotation({0,180,0})
                end--if
            end--if
        end--for
        --corrections...
        if L == "CORUSCANT" then
            Location.Loyalty = "Imperial"
			Location.scanned = true	--mark as already scanned.
        end--if
        if L == "REBEL BASE" then
            Location.Loyalty = "Rebel"
			Location.scanned = true	--mark as already scanned.
        end--if
        if Location.Subtype == "Remote" then
            Location.Loyalty = "Neutral"
        end--if
        --blockaded? ((rebel units and imperial/subjugated) or (Imperial Space Units and rebel loyalty and not subjugated))...
        if ((Location.Units.Rebel.Space > 0 or (Location.Units.Rebel.Ground - Location.Units.Rebel.Recruits) > 0) and (Location.Loyalty == "Imperial" or Location.Subjugated))
        or (Location.Units.Imperial.Space > 0 and Location.Loyalty == "Rebel" and not Location.Subjugated) then
            Location.Blockaded = true
        end--if
        if Location.Destroyed then
            Location.Loyalty = "Neutral"
            Location.Sabotaged = false
            Location.Blockaded = false
        end--if
		if Verbose then
			if Location.Blockaded then
				log(" "..L.." is Blockaded.")
			end--if
			if Location.Destroyed then
				log(" "..L.." is Destroyed.")
			end--if
			if Location.Sabotaged then
				log(" "..L.." is Sabotaged.")
			end--if
			if Location.Scanned then
				log(" "..L.." is Scanned.")
			end--if
			if Location.Subjugated then
				log(" "..L.." is Subjugated.")
			end--if
			if Location.Loyalty != "Neutral" and Location.Loyalty != "" then
				log(" "..L.." has "..Location.Loyalty.." Loyalty.")
			end--if
			if Location.Units.Rebel.Space > 0 then
				log(" "..L.." has "..Location.Units.Rebel.Space.." Rebel Space Units.")
			end--if
			if Location.Units.Rebel.Ground > 0 then
				log(" "..L.." has "..Location.Units.Rebel.Ground.." Rebel Ground Units.")
			end--if
			if Location.Units.Rebel.Recruits > 0 then
				log(" "..L.." has "..Location.Units.Rebel.Recruits.." Recruit Units.")
			end--if
			if Location.Units.Imperial.Space > 0 then
				log(" "..L.." has "..Location.Units.Imperial.Space.." Imperial Space Units.")
			end--if
			if Location.Units.Imperial.Ground > 0 then
				log(" "..L.." has "..Location.Units.Imperial.Ground.." Imperial Ground Units.")
			end--if
		end--if
	end--for
	SuppressVictoryCheck = false
	CombatCheckAllSystems()
	if Verbose then
		broadcastToAll("Board re-calculation complete.")
		printToAll("Check log (~) for details.")
	end--if
end--function 

function UpdateCombatLeaders()
	--does a complete scan for leaders in combat and updates all tactics info... 
	--Tactics.Rebel.Leaders={}
	Tactics.Rebel.Admiral = ""
	Tactics.Rebel.General = ""
	Tactics.Rebel.Space = 0
	Tactics.Rebel.Ground = 0
	--Tactics.Imperial.Leaders={}
	Tactics.Imperial.Admiral = ""
	Tactics.Imperial.General = ""
	Tactics.Imperial.Space = 0
	Tactics.Imperial.Ground = 0
	--go through objects in the combat zone... 
	for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do
		--leader object?
		if Obj.getVar("Component") == "Leader" then
			--table.insert(Tactics[Obj.getVar("Faction")].Leaders,Obj.getName()) 
			--better admiral? 
			if GetLeaderTactic({Leader=Obj,Theater="Space"}) > Tactics[Obj.getVar("Faction")].Space then
				Tactics[Obj.getVar("Faction")].Admiral = Obj.getName()
				Tactics[Obj.getVar("Faction")].Space = GetLeaderTactic({Leader=Obj,Theater="Space"})
			end--if
			--better general? 
			if GetLeaderTactic({Leader=Obj,Theater="Ground"}) > Tactics[Obj.getVar("Faction")].Space then
				Tactics[Obj.getVar("Faction")].General = Obj.getName()
				Tactics[Obj.getVar("Faction")].Ground = GetLeaderTactic({Leader=Obj,Theater="Ground"})
			end--if
		end--if
	end--for O,Obj
end--function 

function UpdateCombatBoard(ObjectID)
	--LastID to trigger this update (to suppress multiple updates within the same second).
	CombatBoardUpdateID = ObjectID
	Wait.time(function() UpdateCombatBoardSubRoutine(ObjectID) end,1)
	function UpdateCombatBoardSubRoutine(LastID)
		--is the LastID not expired? (not replaced by a more current one?)
		if LastID == CombatBoardUpdateID then
			--counts units in combat theaters...
			Counts.Combat.Rebel.Space = 0
			Counts.Combat.Rebel.Ground = 0
			Counts.Combat.Imperial.Space = 0
			Counts.Combat.Imperial.Ground = 0
			for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do
				if Obj.getVar("Component") == "Unit" then
					Counts.Combat[Obj.getVar("Faction")][Obj.getVar("Theater")] = Counts.Combat[Obj.getVar("Faction")][Obj.getVar("Theater")] + 1
				end--if
			end--for O,Obj
			log("Combat Tally (Imperial vs Rebel):\n Space:"..tostring(Counts.Combat.Imperial.Space).." vs "..tostring(Counts.Combat.Rebel.Space).."\n Ground:"..tostring(Counts.Combat.Imperial.Ground).." vs "..tostring(Counts.Combat.Rebel.Ground))
			CombatBoard.clearButtons()
			--is combat being resolved in a system?
			if CombatLocation != nil and CombatLocation != "" then
				--is combat ongoing? (opposing units in the same theater)... 
				if (Counts.Combat.Rebel.Space > 0 and Counts.Combat.Imperial.Space > 0) or (Counts.Combat.Rebel.Ground > 0 and Counts.Combat.Imperial.Ground > 0) then
					--display combat system to the side of the combat board...
					CombatBoard.createButton({click_function="NA",function_owner=Global,label=CombatLocation,position={1.875,0.2,0},rotation={0,270,0},scale={0.5,0.5,0.5},width=0,height=0,font_size=100,font_color={0.6,0.6,1,1}})
				else--combat is over (no opposing units), prompt to exit...
					printToAll("The Battle at "..CombatLocation.." has ended (no opposing units in the same theater).",{1,1,0})
					--create return prompt button... 
					CombatBoard.createButton({click_function="ExitCombat",function_owner=Global,label="Return to "..CombatLocation,position={1.78,0.2,0},rotation={0,90,0},scale={0.5,0.5,0.5},color={0.4,1,0.4},width=2000,height=200,font_size=150,font_color={0,0,0},tooltip="End Combat in "..CombatLocation.." and return surviving Units back to the board."})
					CombatBoard.createButton({click_function="ExitCombat",function_owner=Global,label="⇨",position={1.78,0.2,-1.1},rotation={0,0,0},scale={0.5,0.5,0.5},width=0,height=0,font_size=200,font_color={0.4,1,0.4}})
					CombatBoard.createButton({click_function="ExitCombat",function_owner=Global,label="⇨",position={1.78,0.2,1.1},rotation={0,0,0},scale={0.5,0.5,0.5},width=0,height=0,font_size=200,font_color={0.4,1,0.4}})
				end--if
			end--if
			--display leader info... 
			local LeaderString = ""
			--rebel leader(s)...
			if Tactics.Rebel.Space + Tactics.Rebel.Ground < 1 then
				LeaderString = "(No Rebel Leader with Tactics)"
			elseif Tactics.Rebel.Admiral == Tactics.Rebel.General then
				LeaderString = Tactics.Rebel.Admiral
			else--joint leaders... 
				LeaderString = Tactics.Rebel.Admiral.."/"..Tactics.Rebel.General
			end--if
			CombatBoard.createButton({click_function="NA",function_owner=Global,label=LeaderString,position={-0.002,0.1,1.848},rotation={0,0,0},scale={0.6,0.6,0.6},width=0,height=0,color={0,0,0},font_size=50,font_color={0,0,0}})
			CombatBoard.createButton({click_function="NA",function_owner=Global,label=LeaderString,position={0.003,0.1,1.853},rotation={0,0,0},scale={0.6,0.6,0.6},width=0,height=0,color={0,0,0},font_size=50,font_color={0,0,0}})
			CombatBoard.createButton({click_function="NA",function_owner=Global,label=LeaderString,position={0,0.101,1.85},rotation={0,0,0},scale={0.6,0.6,0.6},width=0,height=0,color={0,0,0},font_size=50,font_color={0.8,1,0.8}})
			if Tactics.Rebel.Space + Tactics.Rebel.Ground > 0 then
			  CombatBoard.createButton({click_function="NA",function_owner=Global,label=Tactics.Rebel.Space,position={-1.35,0.1,1.74},rotation={0,0,0},scale={0.6,0.6,0.6},width=125,height=125,color={0,0,1},font_size=75,font_color={1,1,1},tooltip=Tactics.Rebel.Admiral.." has a Space Tactics Value of "..Tactics.Rebel.Space.."."})
			  CombatBoard.createButton({click_function="NA",function_owner=Global,label=Tactics.Rebel.Ground,position={1.35,0.1,1.74},rotation={0,0,0},scale={0.6,0.6,0.6},width=125,height=125,color={1,0.65,0},font_size=75,font_color={1,1,1},tooltip=Tactics.Rebel.General.." has a Ground Tactics Value of "..Tactics.Rebel.Ground.."."})
			end--if
			--Imperial leader(s)...
			if Tactics.Imperial.Space + Tactics.Imperial.Ground < 1 then
				LeaderString = "(No Imperial Leader with Tactics)"
			elseif Tactics.Imperial.Admiral == Tactics.Imperial.General then
				LeaderString = Tactics.Imperial.Admiral
			else--joint leaders... 
				LeaderString = Tactics.Imperial.Admiral.."/"..Tactics.Imperial.General
			end--if
			CombatBoard.createButton({click_function="NA",function_owner=Global,label=LeaderString,position={-0.002,0.1,-1.848},rotation={0,180,0},scale={0.6,0.6,0.6},width=0,height=0,color={0,0,0},font_size=50,font_color={0,0,0}})
			CombatBoard.createButton({click_function="NA",function_owner=Global,label=LeaderString,position={0.003,0.1,-1.853},rotation={0,180,0},scale={0.6,0.6,0.6},width=0,height=0,color={0,0,0},font_size=50,font_color={0,0,0}})
			CombatBoard.createButton({click_function="NA",function_owner=Global,label=LeaderString,position={0,0.101,-1.85},rotation={0,180,0},scale={0.6,0.6,0.6},width=0,height=0,color={0,0,0},font_size=50,font_color={0.8,1,0.8}})
			if Tactics.Imperial.Space + Tactics.Imperial.Ground > 0 then
			  CombatBoard.createButton({click_function="NA",function_owner=Global,label=Tactics.Imperial.Space,position={-1.35,0.1,-1.74},rotation={0,180,0},scale={0.6,0.6,0.6},width=125,height=125,color={0,0,1},font_size=75,font_color={1,1,1},tooltip=Tactics.Imperial.Admiral.." has a Space Tactics Value of "..Tactics.Imperial.Space.."."})
			  CombatBoard.createButton({click_function="NA",function_owner=Global,label=Tactics.Imperial.Ground,position={1.35,0.1,-1.74},rotation={0,180,0},scale={0.6,0.6,0.6},width=125,height=125,color={1,0.65,0},font_size=75,font_color={1,1,1},tooltip=Tactics.Imperial.General.." has a Ground Tactics Value of "..Tactics.Imperial.Ground.."."})
			end--if
			CombatBoardUpdateID = ""
		end--if
	end--function 
end--function 

function UnitCombatCount(UnitName)
	local UnitCount = 0
	for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do 
		if Obj.getVar("Component") == "Unit" then
			if Obj.getName() == UnitName then
				UnitCount = UnitCount + 1
			end--if
		end--if
	end--for O,Obj 
	return UnitCount
end--function 

--ADVANCED TACTICS-----------------------------------------------------------------------

function AdvancedTacticMenu(CardObj)
	--place top/bottom buttons
	CardObj.clearButtons()
	CardObj.createButton({click_function="AdvancedTacticConfirmTop",function_owner=Global,label="Play Top",position={0,0.3,-0.1},scale={0.5,0.5,0.5},color={1,1,1,0.8},font_color={0,0,0},width=1200,height=250,font_size=200,tooltip="Play the top effect of this Advanced Tactic Card."})
	CardObj.createButton({click_function="AdvancedTacticPlayBottom",function_owner=Global,label="Play Bottom",position={0,0.3,1.4},scale={0.5,0.5,0.5},color={1,1,1,0.8},font_color={0,0,0},width=1200,height=250,font_size=200,tooltip="Play the bottom effect of this Advanced Tactic Card."})
end--function 

function AdvancedTacticConfirmTop(CardObj)
	CardObj.clearButtons()
	local OK = false
	--verify unit is in the theater... 
	if CardObj.getName() == "Bombing Run" then--Y-Wing
		OK = UnitCombatCount("Y-Wing") > 0
	elseif CardObj.getName() == "Deployment" then--U-Wing
		OK = UnitCombatCount("U-Wing") > 0
	elseif CardObj.getName() == "Draw Their Fire" then--Nebulon B Frigate
		OK = UnitCombatCount("Nebulon-B Frigate") > 0
	elseif CardObj.getName() == "Escort" then--Rebel Transport
		OK = UnitCombatCount("Rebel Transport") > 0
	elseif CardObj.getName() == "Fleet Logistics" then--Mon Cala Cruiser
		OK = UnitCombatCount("Mon Cala Cruiser") > 0
	elseif CardObj.getName() == "Ion Blast" then--Ion Cannon
		OK = UnitCombatCount("Ion Cannon") > 0
	elseif CardObj.getName() == "Outrun Them" then--Corellian Corvette
		OK = UnitCombatCount("Corellian Corvette") > 0
	elseif CardObj.getName() == "Rogue Squadron Support" then--X-Wing
		OK = UnitCombatCount("X-Wing") > 0
	elseif CardObj.getName() == "Confrontation" then--Imperial Leader
		OK = true
	elseif CardObj.getName() == "Escape Plan" then--Rebel Transport
		OK = UnitCombatCount("Rebel Transport") > 0
	elseif CardObj.getName() == "Hold Them Back" then--Rebel Trooper
		OK = UnitCombatCount("Rebel Trooper") > 0
	elseif CardObj.getName() == "Planetary Shield" then--Shield Generator
		OK = UnitCombatCount("Shield Generator") > 0
	elseif CardObj.getName() == "Rogue One" then--U-Wing
		OK = UnitCombatCount("U-Wing") > 0
	elseif CardObj.getName() == "Take Cover" then--Golan Arms Turret
		OK = UnitCombatCount("Golan Arms Turret") > 0
	elseif CardObj.getName() == "Take It Down" then--Rebel Vanguard
		OK = UnitCombatCount("Rebel Vanguard") > 0
	elseif CardObj.getName() == "Tow Cables" then--Airspeeder
		OK = UnitCombatCount("Airspeeder") > 0 and UnitCombatCount("AT-ST") + UnitCombatCount("AT-AT") > 0
	elseif CardObj.getName() == "Energy Shield" then
		OK = UnitCombatCount("Shield Bunker") > 0
	elseif CardObj.getName() == "Entrapment" then
		OK = UnitCombatCount("Interdictor") > 0
	elseif CardObj.getName() == "Intercept" then
		OK = UnitCombatCount("TIE Striker") > 0
	elseif CardObj.getName() == "Overwhelming Presence" then
		OK = UnitCombatCount("Super Star Destroyer") > 0
	elseif CardObj.getName() == "Reinforcements" then
		OK = UnitCombatCount("Assault Carrier") > 0
	elseif CardObj.getName() == "Superlaser Blast" then
		OK = UnitCombatCount("Death Star") > 0 and UnitCombatCount("Mon Cala Cruiser") + UnitCombatCount("Nebulon-B Frigate") + UnitCombatCount("Corellian Corvette") + UnitCombatCount("Rebel Transport") > 0
	elseif CardObj.getName() == "Swarm Tactics" then
		OK = UnitCombatCount("TIE Fighter") > 0 and UnitCombatCount("TIE Fighter") + UnitCombatCount("TIE Striker") > UnitCombatCount("U-Wing") + UnitCombatCount("X-Wing") + UnitCombatCount("Y-Wing")
	elseif CardObj.getName() == "Tractor Beam" then
		OK = UnitCombatCount("Star Destroyer") > 0
	elseif CardObj.getName() == "Air Superiority" then
		OK = UnitCombatCount("TIE Striker") > 0
	elseif CardObj.getName() == "Armored Patrol" then
		OK = UnitCombatCount("Assault Tank") > 0
	elseif CardObj.getName() == "Armored Position" then
		OK = UnitCombatCount("Shield Bunker") > 0
	elseif CardObj.getName() == "Bombardment" then
		OK =  UnitCombatCount("Star Destroyer") + UnitCombatCount("Super Star Destroyer") > 0 and UnitCombatCount("Shield Generator") < 1
	elseif CardObj.getName() == "Imposing Presence" then
		OK = true
	elseif CardObj.getName() == "Overrun" then
		OK = UnitCombatCount("AT-ST") > 0
	elseif CardObj.getName() == "Support of the 501st" then
		OK = UnitCombatCount("Stormtrooper") > 0
	elseif CardObj.getName() == "Target the Generator" then
		OK = UnitCombatCount("AT-AT") > 0 and UnitCombatCount("Shield Generator") + UnitCombatCount("Ion Cannon") + UnitCombatCount("Golan Arms Turret") > 0
	elseif CardObj.getName() == "Hit And Run" then
		OK = UnitCombatCount("A-Wing") > 0
	elseif CardObj.getName() == "Proton Torpedoes" then
		OK = UnitCombatCount("B-Wing") > 0
	elseif CardObj.getName() == "Lightspeed" then
		OK = UnitCombatCount("Light Freighter") > 0
	elseif CardObj.getName() == "Ramming Tug" then
		OK = UnitCombatCount("Hammerhead Corvette") > 0
	elseif CardObj.getName() == "Fighter Screen" then
		OK = UnitCombatCount("Escort Carrier") > 0
	elseif CardObj.getName() == "Point Blank Range" then
		OK = UnitCombatCount("MC80 Cruiser") > 0
	elseif CardObj.getName() == "Data Transmission" then
		OK = UnitCombatCount("MC75 Cruiser") > 0
	elseif CardObj.getName() == "Jedi Master" then
		OK = UnitCombatCount("Jedi Knight") > 0
	elseif CardObj.getName() == "Ferocious Warriors" then
		OK = UnitCombatCount("Wookiee Veteran") > 0
	elseif CardObj.getName() == "Broader Formation" then
		OK = UnitCombatCount("TIE Interceptor") > 0
	elseif CardObj.getName() == "Asteroid Field" then
		OK = UnitCombatCount("TIE Bomber") > 0
	elseif CardObj.getName() == "Stay On The Leader" then
		OK = UnitCombatCount("TIE Advanced") > 0
	elseif CardObj.getName() == "Guided Missiles" then
		OK = UnitCombatCount("TIE Defender") > 0
	elseif CardObj.getName() == "Perimeter Patrols" then
		OK = UnitCombatCount("TIE Defender") > 0
	elseif CardObj.getName() == "Recon Deployment" then
		OK = UnitCombatCount("Lambda Shuttle") > 0
	elseif CardObj.getName() == "Suppression Fire" then
		OK = UnitCombatCount("Light Cruiser") > 0
	elseif CardObj.getName() == "Close Air Support" then
		OK = UnitCombatCount("TIE Bomber") > 0
	elseif CardObj.getName() == "Airborne Assault" then
		OK = UnitCombatCount("Darktrooper") > 0
	elseif CardObj.getName() == "Boarding Assault" then
		OK = UnitCombatCount("Darktrooper") > 0
	elseif CardObj.getName() == "Elite Deployment" then
		OK = UnitCombatCount("Death Trooper") > 0
	elseif CardObj.getName() == "Outflank" then
		OK = UnitCombatCount("Scout Trooper") > 0
	end--if
	if OK then
		AdvancedTacticPlayTop(CardObj)
	else--confirm first
		CardObj.createButton({click_function="NA",function_owner=Global,label="Requirements for\ntop were not met.\nPlay top anyway?",position={0,0.3,-0.75},scale={0.5,0.5,0.5},color={1,1,1,0.9},font_color={1,1,0},width=0,height=0,font_size=225})
		CardObj.createButton({click_function="AdvancedTacticPlayTop",function_owner=Global,label="Yes",position={-0.6,0.3,-0.1},scale={0.5,0.5,0.5},color={1,1,1,0.9},font_color={0,0,0},width=800,height=400,font_size=300,tooltip="YES: Play the top effect (even though the unit was not found in combat)."})
		CardObj.createButton({click_function="AdvancedTacticMenu",function_owner=Global,label="No",position={0.6,0.3,-0.1},scale={0.5,0.5,0.5},color={1,1,1,0.9},font_color={0,0,0},width=800,height=400,font_size=300,tooltip="NO: Do not play top effect."})
	end--if
end--function 

function AdvancedTacticPlayTop(CardObj)
	function AdvancedTacticPlayTopCoroutine()
		CardObj.clearButtons()
		CardObj.createButton({click_function="AdvancedTacticDiscard",function_owner=Global,label="x",position={-0.9,0.3,-1.4},scale={0.5,0.5,0.5},color={1,1,1,0.8},font_color={0,0,0},width=300,height=300,font_size=250,tooltip="Discard this Advanced Tactic."})
		CardObj.createButton({click_function="NA",function_owner=Global,label="Played Top",position={0,0.3,-0.1},scale={0.5,0.5,0.5},color={1,1,1,0.8},font_color={1,1,0},width=0,height=0,font_size=200})
		if CardObj.getName() == "Bombing Run" then--Y-Wing
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x-0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
			DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x+0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Deployment" then--U-Wing
		elseif CardObj.getName() == "Draw Their Fire" then--Nebulon B Frigate
		elseif CardObj.getName() == "Escort" then--Rebel Transport
			Blocked.Rebel.Black = Blocked.Rebel.Black + 1
			Blocked.Rebel.Red = Blocked.Rebel.Red + 1
			Blocked.Rebel.Direct = Blocked.Rebel.Direct + 1
		elseif CardObj.getName() == "Fleet Logistics" then--Mon Cala Cruiser
			Blocked.Rebel.Red = Blocked.Rebel.Red + 2
		elseif CardObj.getName() == "Ion Blast" then--Ion Cannon
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			Blocked.Imperial.IonBlast = 1
		elseif CardObj.getName() == "Outrun Them" then--Corellian Corvette
		elseif CardObj.getName() == "Rogue Squadron Support" then--X-Wing
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x-0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
			DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x+0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Confrontation" then--Imperial Leader
		elseif CardObj.getName() == "Escape Plan" then--Rebel Transport
		elseif CardObj.getName() == "Hold Them Back" then--Rebel Trooper
		elseif CardObj.getName() == "Planetary Shield" then--Shield Generator
		elseif CardObj.getName() == "Rogue One" then--U-Wing
		elseif CardObj.getName() == "Take Cover" then--Golan Arms Turret
			Blocked.Rebel.Black = Blocked.Rebel.Black + 2
			Blocked.Rebel.Red = Blocked.Rebel.Red + 2
		elseif CardObj.getName() == "Take It Down" then--Rebel Vanguard
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x-0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
			DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x+0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Tow Cables" then--Airspeeder
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.2,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.3,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.4,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Energy Shield" then
		elseif CardObj.getName() == "Entrapment" then
		elseif CardObj.getName() == "Intercept" then
		elseif CardObj.getName() == "Overwhelming Presence" then
			Blocked.Imperial.Red = Blocked.Imperial.Red + 2
			Blocked.Imperial.Direct = Blocked.Imperial.Direct + 1
		elseif CardObj.getName() == "Reinforcements" then
			Blocked.Imperial.Black = Blocked.Imperial.Black + 2
			getObjectFromGUID(Units["TIE Fighter"].BagID).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+1,CardObj.getPosition().z},rotation=CardObj.getRotation()})			
		elseif CardObj.getName() == "Superlaser Blast" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.2,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.3,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.4,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.5,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Swarm Tactics" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x-0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x+0.4,CardObj.getPosition().y+0.2,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Tractor Beam" then
		elseif CardObj.getName() == "Air Superiority" then
		elseif CardObj.getName() == "Armored Patrol" then
			Blocked.Imperial.Black = Blocked.Imperial.Black + 2
			Blocked.Imperial.Red = Blocked.Imperial.Red + 2
		elseif CardObj.getName() == "Armored Position" then
		elseif CardObj.getName() == "Bombardment" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x-0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
			DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x+0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Imposing Presence" then
			Blocked.Rebel.GroundDamage = 1
		elseif CardObj.getName() == "Overrun" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x-0.4,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
			DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x+0.4,CardObj.getPosition().y+0.2,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Support of the 501st" then
		elseif CardObj.getName() == "Target the Generator" then
		elseif CardObj.getName() == "Hit And Run" then
		elseif CardObj.getName() == "Proton Torpedoes" then
		elseif CardObj.getName() == "Lightspeed" then
		elseif CardObj.getName() == "Ramming Tug" then
		elseif CardObj.getName() == "Fighter Screen" then
		elseif CardObj.getName() == "Point Blank Range" then
		elseif CardObj.getName() == "Data Transmission" then
		elseif CardObj.getName() == "Jedi Master" then
		elseif CardObj.getName() == "Ferocious Warriors" then
		elseif CardObj.getName() == "Broader Formation" then
		elseif CardObj.getName() == "Asteroid Field" then
		elseif CardObj.getName() == "Stay On The Leader" then
		elseif CardObj.getName() == "Guided Missiles" then
		elseif CardObj.getName() == "Perimeter Patrols" then
		elseif CardObj.getName() == "Recon Deployment" then
		elseif CardObj.getName() == "Suppression Fire" then
		elseif CardObj.getName() == "Close Air Support" then
		elseif CardObj.getName() == "Airborne Assault" then
		elseif CardObj.getName() == "Boarding Assault" then
		elseif CardObj.getName() == "Elite Deployment" then
		elseif CardObj.getName() == "Outflank" then
		end--if
		ImperialDicePanel.call("DefaultMenu")
		RebelDicePanel.call("DefaultMenu")
		return 1
	end--function 
	startLuaCoroutine(Global,"AdvancedTacticPlayTopCoroutine")
end--function 

function AdvancedTacticPlayBottom(CardObj)
	function AdvancedTacticPlayBottomCoroutine()
		CardObj.clearButtons()
		CardObj.createButton({click_function="AdvancedTacticDiscard",function_owner=Global,label="x",position={-0.9,0.3,-1.4},scale={0.5,0.5,0.5},color={1,1,1,0.8},font_color={0,0,0},width=300,height=300,font_size=250,tooltip="Discard this Advanced Tactic."})
		CardObj.createButton({click_function="NA",function_owner=Global,label="Played Bottom",position={0,0.3,-0.1},scale={0.5,0.5,0.5},color={1,1,1,0.8},font_color={1,1,0},width=0,height=0,font_size=200})
		if CardObj.getName() == "Bombing Run" then--Y-Wing
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Deployment" then--U-Wing
			Blocked.Imperial.SpaceDamage = 1
		elseif CardObj.getName() == "Draw Their Fire" then--Nebulon B Frigate
		elseif CardObj.getName() == "Escort" then--Rebel Transport
			Blocked.Rebel.Black = Blocked.Rebel.Black + 2
		elseif CardObj.getName() == "Fleet Logistics" then--Mon Cala Cruiser
			Blocked.Rebel.Red = Blocked.Rebel.Red + 2
		elseif CardObj.getName() == "Ion Blast" then--Ion Cannon
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Outrun Them" then--Corellian Corvette
		elseif CardObj.getName() == "Rogue Squadron Support" then--X-Wing
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Confrontation" then--Imperial Leader
		elseif CardObj.getName() == "Escape Plan" then--Rebel Transport
		elseif CardObj.getName() == "Hold Them Back" then--Rebel Trooper
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Planetary Shield" then--Shield Generator
		elseif CardObj.getName() == "Rogue One" then--U-Wing
			Blocked.Imperial.GroundDamage = 1
		elseif CardObj.getName() == "Take Cover" then--Golan Arms Turret
			Blocked.Rebel.Black = Blocked.Rebel.Black + 1
			Blocked.Rebel.Red = Blocked.Rebel.Red + 1
		elseif CardObj.getName() == "Take It Down" then--Rebel Vanguard
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Tow Cables" then--Airspeeder
			local DamageToken = getObjectFromGUID(IDs.Rebel.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Energy Shield" then
		elseif CardObj.getName() == "Entrapment" then
		elseif CardObj.getName() == "Intercept" then
			Blocked.Rebel.SpaceDamage = 1
		elseif CardObj.getName() == "Overwhelming Presence" then
			Blocked.Imperial.Red = Blocked.Imperial.Red + 2
		elseif CardObj.getName() == "Reinforcements" then
			Blocked.Imperial.Black = Blocked.Imperial.Black + 2
		elseif CardObj.getName() == "Superlaser Blast" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Swarm Tactics" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Tractor Beam" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Air Superiority" then
		elseif CardObj.getName() == "Armored Patrol" then
			Blocked.Imperial.Black = Blocked.Imperial.Black + 1
			Blocked.Imperial.Red = Blocked.Imperial.Red + 1
		elseif CardObj.getName() == "Armored Position" then
		elseif CardObj.getName() == "Bombardment" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Imposing Presence" then
		elseif CardObj.getName() == "Overrun" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject({smooth=true,position={CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},rotation=CardObj.getRotation()})
		elseif CardObj.getName() == "Support of the 501st" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject()
			DamageToken = DamageToken.setState(5)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Target the Generator" then
			local DamageToken = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject()
			DamageToken = DamageToken.setState(3)
			DamageToken.setRotationSmooth(CardObj.getRotation(),false,false)
			DamageToken.setPositionSmooth({CardObj.getPosition().x,CardObj.getPosition().y+0.1,CardObj.getPosition().z},false,false)
		elseif CardObj.getName() == "Hit And Run" then
		elseif CardObj.getName() == "Proton Torpedoes" then
		elseif CardObj.getName() == "Lightspeed" then
			Blocked.Rebel.Direct = Blocked.Rebel.Direct + 1
		elseif CardObj.getName() == "Ramming Tug" then
		elseif CardObj.getName() == "Fighter Screen" then
		elseif CardObj.getName() == "Point Blank Range" then
		elseif CardObj.getName() == "Data Transmission" then
		elseif CardObj.getName() == "Jedi Master" then
		elseif CardObj.getName() == "Ferocious Warriors" then
		elseif CardObj.getName() == "Broader Formation" then
			Blocked.Imperial.Red = Blocked.Imperial.Red + 1
			Blocked.Imperial.Black = Blocked.Imperial.Black + 1
		elseif CardObj.getName() == "Asteroid Field" then
		elseif CardObj.getName() == "Stay On The Leader" then
		elseif CardObj.getName() == "Guided Missiles" then
		elseif CardObj.getName() == "Perimeter Patrols" then
		elseif CardObj.getName() == "Recon Deployment" then
		elseif CardObj.getName() == "Suppression Fire" then
		elseif CardObj.getName() == "Close Air Support" then
		elseif CardObj.getName() == "Airborne Assault" then
		elseif CardObj.getName() == "Boarding Assault" then
		elseif CardObj.getName() == "Elite Deployment" then
		elseif CardObj.getName() == "Outflank" then
			Blocked.Imperial.Direct = Blocked.Imperial.Direct + 1
		end--if
		ImperialDicePanel.call("DefaultMenu")
		RebelDicePanel.call("DefaultMenu")
		return 1
	end--function 
	startLuaCoroutine(Global,"AdvancedTacticPlayBottomCoroutine")
end--function 

function AdvancedTacticDiscard(CardObj)
	local CardFaction = ""
	if CardObj.getDescription() == nil then CardObj.setDescription("") end--if
	if string.find(CardObj.getDescription(),"Imperial;") != nil then
		CardFaction = "Imperial"
	elseif string.find(CardObj.getDescription(),"Rebel;") != nil then
		CardFaction = "Rebel"
	end--if
	--space or ground?
	local Theater = ""
	if string.find(CardObj.getDescription(),"Space;") != nil then
		Theater = "Space"
	else--must be rebel...
		Theater = "Ground"
	end--if
	--if Blocked[CardFaction].Black + Blocked[CardFaction].Red + Blocked[CardFaction].Direct > 0 then
		--printToAll(CardFaction.." damage prevention reset.",{1,1,0})
	--end--if
	--Blocked.Imperial.Black = 0
	--Blocked.Imperial.Red = 0
	--Blocked.Imperial.Direct = 0
	--Blocked.Rebel.Black = 0
	--Blocked.Rebel.Red = 0
	--Blocked.Rebel.Direct = 0
	ImperialDicePanel.call("DefaultMenu")
	RebelDicePanel.call("DefaultMenu")
	--get deck info for discarding...
	local DeckInfo = nil
	DeckInfo = Decks[CardFaction.."Advanced"..Theater.."TacticDiscard"]
	CardObj.setRotationSmooth(DeckInfo.Rotation,false,true)
	CardObj.setPositionSmooth({DeckInfo.DropSpot[1],DeckInfo.DropSpot[2],DeckInfo.DropSpot[3]},false,true)
end--function 

--COMMON CARD HANDLING SCRIPTS--------------------------------------------------------------

function ShuffleHand(HandID)
	--Code by SuperSpitzi
	function SubShuffle(j)
		for i = #j, 2, -1 do
			local n = math.random(i)
			j[i], j[n] = j[n], j[i]
		end--for
		return j
	end--function
	local HandList = getObjectFromGUID(HandID).getObjects()
	if #HandList > 0 then
		local Card = {}
		for i, j in pairs(HandList) do
		Card[i] = j.getPosition()
		end--for
		local shuffledObj = SubShuffle(HandList)
		local shuffledCard = SubShuffle(Card)
		for i, j in pairs(shuffledObj) do
		j.setPosition(shuffledCard[i])
		end--for
	end--if
end--function
  
function PlaceBottomProject(Object,PlayerColor)
  function PlaceBottomProjectCoroutine()
    coroutine.yield(0)
    if Object != nil then
      Object.clearButtons()
      --try to raise up the current Project deck...
      local Deck = GetDeck("ImperialProject")
      if Deck != nil then
		Deck.setPositionSmooth({Deck.getPosition().x,Deck.getPosition().y+2,Deck.getPosition().z},false,true)
      end--if
      coroutine.yield(0)
      Object.setPosition(Decks.ImperialProject.Spot)
      Object.setRotation(Decks.ImperialProject.Rotation)
      coroutine.yield(0)
      if PlayerColor != nil then
        broadcastToAll(PlayerColor.." Player placed a card on the bottom of the Project Deck.",PlayerColor)
      end--if
    end--if
    return 1
  end--function 
  startLuaCoroutine(Global,"PlaceBottomProjectCoroutine")
end--function 

function KeepProject(Object,PlayerColor)
  function KeepProjectCoroutine()
    if Object != nil then
      coroutine.yield(0)
      Object.clearButtons()
      Object.setPosition({getObjectFromGUID(IDs.Imperial.MissionHand).getPosition().x,9,getObjectFromGUID(IDs.Imperial.MissionHand).getPosition().z})
      coroutine.yield(0)
      Object.setPositionSmooth(getObjectFromGUID(IDs.Imperial.MissionHand).getPosition(),false,false)
      Wait.time(function() Object.setHiddenFrom() end,2)
      if PlayerColor != nil then
        printToAll(PlayerColor.." Player added an Project Card to the Imperial Mission Hand.",PlayerColor)
      end--if
    end--if 
    return 1
  end--function 
  startLuaCoroutine(Global,"KeepProjectCoroutine")
end--function 

function PlaceTopObjective(Object,PlayerColor)
	function PlaceTopObjectiveCoroutine()
		coroutine.yield(0)
		if Object != nil then
			Object.clearButtons()
			Object.setPosition({Decks.Objective.Spot[1],Decks.Objective.Spot[2]+3,Decks.Objective.Spot[3]})
			Object.setRotation(Decks.Objective.Rotation)
			if PlayerColor != nil then
				broadcastToAll(PlayerColor.." Player placed a card on top of the Objective Deck.",PlayerColor)
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"PlaceTopObjectiveCoroutine")
end--function 

function PlaceBottomObjective(Object,PlayerColor)
	function PlaceBottomObjectiveCoroutine()
		coroutine.yield(0)
		if Object != nil then
			Object.clearButtons()
			--try to raise up the current objective deck...
			local Deck = GetDeck("Objective")
			if Deck != nil then
				Deck.setPositionSmooth({Deck.getPosition().x,Deck.getPosition().y+2,Deck.getPosition().z},false,true)
			end--if
			coroutine.yield(0)
			Object.setPosition(Decks.Objective.Spot)
			Object.setRotation(Decks.Objective.Rotation)
			coroutine.yield(0)
			if PlayerColor != nil then
				broadcastToAll(PlayerColor.." Player placed a card on the bottom of the Objective Deck.",PlayerColor)
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"PlaceBottomObjectiveCoroutine")
end--function 

function KeepObjective(Object,PlayerColor)
	function KeepObjectiveCoroutine()
		if Object != nil then
			coroutine.yield(0)
			Object.clearButtons()
			Object.setPosition({getObjectFromGUID(IDs.Rebel.ObjectiveHand).getPosition().x,9,getObjectFromGUID(IDs.Rebel.ObjectiveHand).getPosition().z})
			coroutine.yield(0)
			Object.setPositionSmooth(getObjectFromGUID(IDs.Rebel.ObjectiveHand).getPosition(),false,false)
			Wait.time(function() Object.setHiddenFrom() end,2)
			if PlayerColor != nil then
				printToAll(PlayerColor.." Player added an Objective Card to the Rebel Hand.",PlayerColor)
			end--if
		end--if 
		return 1
	end--function 
	startLuaCoroutine(Global,"KeepObjectiveCoroutine")
end--function 
	
function PlaceTopProbe(Object,PlayerColor)
	function PlaceTopProbeCoroutine()
		coroutine.yield(0)
		if Object != nil then
			Object.clearButtons()
			Object.setPosition({Decks.Probe.Spot[1],Decks.Probe.Spot[2]+3,Decks.Probe.Spot[3]})
			Object.setRotation(Decks.Probe.Rotation)
			if PlayerColor != nil then
				broadcastToAll(PlayerColor.." Player placed a card on top of the Probe Deck.",PlayerColor)
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"PlaceTopProbeCoroutine")
end--function 
	
function PlaceBottomProbe(Object,PlayerColor)
	function PlaceBottomProbeCoroutine()
		coroutine.yield(0)
		if Object != nil then
			Object.clearButtons()
			--try to raise up the current Probe deck...
			local Deck = GetDeck("Probe")
			if Deck != nil then
			Deck.setPositionSmooth({Deck.getPosition().x,Deck.getPosition().y+2,Deck.getPosition().z},false,true)
			end--if
			coroutine.yield(0)
			Object.setPosition(Decks.Probe.Spot)
			Object.setRotation(Decks.Probe.Rotation)
			coroutine.yield(0)
			if PlayerColor != nil then
				broadcastToAll(PlayerColor.." Player placed a card on the bottom of the Probe Deck.",PlayerColor)
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"PlaceBottomProbeCoroutine")
end--function 

function ClearButtons(Object)
	--this function exists so a button can be cliced to clear buttons off of an object.
	Object.clearButtons()
end--function 
	  
--RESEARCH AND DEVELOPMENT (IMPERIAL)--------------------------------------------------------------

function ResearchAndDevelopmentDraw2(Object,PlayerColor)
	function ResearchAndDevelopmentDraw2Coroutine()
		coroutine.yield(0)
		Object.clearButtons()
		ImperialPanelCards = {}
		for C=1,2 do
			local Card = DrawFromDeck({Deck="ImperialProject",Smooth=false,Position={3.75-C*2.5,1,-30},Rotation={0,180,0},Hidden={"White","Red"}})
			coroutine.yield(0)
			Card.clearButtons()
			Card.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
			Card.createButton({click_function="ResearchAndDevelopmentKeep",function_owner=Global,label="Keep",position={-0.5,0.2,0.6},scale={0.5,0.5,0.5},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Keep this Project Card (Add to Imperial Mission Hand)."})
			Card.createButton({click_function="ResearchAndDevelopmentBottom",function_owner=Global,label="Bottom",position={0.5,0.2,0.6},scale={0.5,0.5,0.5},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Place this Card on the bottom of the Project Deck."})
			table.insert(ImperialPanelCards,Card)
		end--for C
		--did we get any cards?
		if #ImperialPanelCards > 0 then
			--set resume step... 
			ResumeStep = Step
			--raise imperial hidden zone...
			getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.On,false,false)
			--imperial panel prompt...
			ImperialPanel.clearButtons()
			ImperialPanel.createButton(({click_function="NA",function_owner=Global,label="IMPERIAL RESEARCH AND DEVELOPMENT\nDraw 2 Projects, keep 1 and\nPlace the other back on the Bottom",position={0,0.2,-0.5},scale={0.5,0.5,0.5},width=0,height=0,font_size=100,font_color={1,1,1}}))
			--set Imperial camera view to Imperial panel...
			if Player.Blue.seated then Player.Blue.lookAt(CameraViews.ImperialPanel) Ping({Player="Blue",Position={0,1,-29}}) end--if
			if Player.Orange.seated then Player.Orange.lookAt(CameraViews.ImperialPanel) Ping({Player="Orange",Position={0,1,-29}}) end--if
			if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.ImperialPanel)  end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"ResearchAndDevelopmentDraw2Coroutine")
end--function 

function ResearchAndDevelopmentDraw1(Object,PlayerColor)
  function ResearchAndDevelopmentDraw1Coroutine()
    coroutine.yield(0)
    Object.clearButtons()
    local Card = DrawFromDeck({Deck="ImperialProject",Smooth=true,Position=getObjectFromGUID(IDs.Imperial.MissionHand).getPosition(),Rotation={0,180,0},Hidden={"White","Red"}})
    coroutine.yield(0)
	if Card != nil then
		Wait.time(function() Card.setHiddenFrom() end,2)
		Card.clearButtons()
		if PlayerColor != nil then
			printToAll(PlayerColor.." Player added an Project Card to the Imperial Mission Hand.",PlayerColor)
		end--if
	else 
		printToAll("Unable to Draw from Imperial Project Deck.")
	end--if
  return 1
  end--function 
  startLuaCoroutine(Global,"ResearchAndDevelopmentDraw1Coroutine")
end--function 

function ResearchAndDevelopmentBottom(Object,PlayerColor)
	PlaceBottomProject(Object,PlayerColor)
	for P=#ImperialPanelCards,1,-1 do
		if ImperialPanelCards[P] == Object then
			table.remove(ImperialPanelCards,P)
			--should be 1 card remaining now... 
			if #ImperialPanelCards == 1 then
				KeepProject(ImperialPanelCards[1],PlayerColor)
				ImperialPanelCards = {}
			end--if
			break
		end--if
	end--for P
	--no more cards?
	if #ImperialPanelCards == 0 then
		--clear Imperial panel prompt... 
		ImperialPanel.clearButtons()
		--remove Imperial panel hidden zone...
		getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.Off,false,false)
		--resume from interrupt...
		Step = "" 
	end--if
end--function 

function ResearchAndDevelopmentKeep(Object,PlayerColor)
	KeepProject(Object,PlayerColor)
	for P=#ImperialPanelCards,1,-1 do
		if ImperialPanelCards[P] == Object then
			table.remove(ImperialPanelCards,P)
			--should be 1 card remaining now... 
			if #ImperialPanelCards == 1 then
				PlaceBottomProject(ImperialPanelCards[1],PlayerColor)
				ImperialPanelCards = {}
			end--if
			break
		end--if
	end--for P
	--no more cards?
	if #ImperialPanelCards == 0 then
		--clear Imperial panel prompt... 
		ImperialPanel.clearButtons()
		--remove Imperial panel hidden zone...
		getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.Off,false,false)
		--resume from interrupt...
		Step = "" 
	end--if
end--function 

--CAPTURE REBEL OPERATIVE (IMPERIAL)---------------------------------------------------------------

function CaptureSuccessful(Object,PlayerColor)
	function CaptureSuccessfulCoroutine()
		Object.clearButtons()
		printToAll("\nImperial Capture Mission Succeeded.")
		local CapturedLeader = nil
		local CaptureRingIndex = 0
		local CaptureRing = nil
		--try to take the capture ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Imperial.RingBag).getObjects()) do 
			if Item.name == "Captured" then
				CaptureRing = getObjectFromGUID(IDs.Imperial.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,180,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if CaptureRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--rebel leader?
				if Obj.getVar("Component") == "Leader" and string.find(Obj.getDescription(),"Rebel;") != nil then
					--capture ring attached?
					for I,Item in pairs(Obj.getAttachments()) do
						--capture ring?
						if string.find(Item.description,"Ring;") != nil and Item.name == "Captured" then
							CapturedLeader = Obj
							CaptureRingIndex = Item.index
							break
						end--if
					end--for
				elseif Obj.getName() == "Captured" and string.find(Obj.getDescription(),"Ring;") != nil then
					CaptureRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if CaptureRing != nil then
				CaptureRing.setPositionSmooth(Object.getPosition(),false,false)
				CaptureRing.setRotation({0,180,0},false,false)
			elseif CapturedLeader != nil then	--found it attached to another leader... 
				function ReuseCaptureRing(Object)
					Object.clearButtons()
					--take ring from Captured Leader...
					CaptureRing = CapturedLeader.removeAttachment(CaptureRingIndex)
					CaptureRing.setPositionSmooth(Object.getPosition(),false,false)
					CaptureRing.setRotation({0,180,0},false,false)
					--send previously Captured Leader to the Rebel Base Space...
					CapturedLeader.setPositionSmooth({-20.35,3,6.35},false,false)
					CapturedLeader.setRotationSmooth({0,0,0},false,false)
					CapturedLeader.clearButtons()
				end--function 
				Object.createButton({click_function="ReuseCaptureRing",function_owner=Global,label="Take Ring From\n"..CapturedLeader.getName(),position={0,0.2,-0.7},scale={0.5,0.5,0.5},color={1,0,0},width=1800,height=400,font_size=150,font_color={0,0,0},tooltip="Take the Captured Ring from "..CapturedLeader.getName().." (Rescues them) to use for the newly Captured Leader."})
				Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="Leave the Capture Ring where it is, or I'll attach it myself."})
			else
				printToAll("Cannot find the Captured Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"CaptureSuccessfulCoroutine")
end--function 

function CaptureFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Capture Mission failed.")
end--function 

--LURE OF THE DARK SIDE (IMPERIAL)-----------------------------------------------------------------

function LureOfTheDarkSideSuccessful(Object,PlayerColor)
	function LureOfTheDarkSideSuccessfulCoroutine()
		Object.clearButtons()
		printToAll("\nImperial Lure of the Dark Side Mission Succeeded.")
		local LureRing = nil
		--try to take the Lure ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Imperial.RingBag).getObjects()) do 
			if Item.name == "Lure of the Dark Side" then
				LureRing = getObjectFromGUID(IDs.Imperial.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,180,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if LureRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--carbon ring?
				if Obj.getName() == "Lure of the Dark Side" and string.find(Obj.getDescription(),"Ring;") != nil then
					LureRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if LureRing != nil then
				LureRing.setPositionSmooth(Object.getPosition(),false,false)
				LureRing.setRotation({0,180,0},false,false)
			else
				printToAll("Unable to fetch the Lure of the Dark Side Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"LureOfTheDarkSideSuccessfulCoroutine")
end--function 

function LureOfTheDarkSideFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Lure of the Dark Side Mission failed.")
end--function 

--CARBON FREEZING (IMPERIAL)-----------------------------------------------------------------------

function CarbonFreezingSuccessful(Object,PlayerColor)
	function CarbonFreezingSuccessfulCoroutine()
		Object.clearButtons()
		printToAll("\nImperial Carbon Freezing Mission Succeeded.")
		local CarboniteRingIndex = 0
		local CarboniteRing = nil
		--try to take the carbonite ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Imperial.RingBag).getObjects()) do 
			if Item.name == "Carbonite" then
				CarboniteRing = getObjectFromGUID(IDs.Imperial.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,180,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if CarboniteRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--carbon ring?
				if Obj.getName() == "Carbonite" and string.find(Obj.getDescription(),"Ring;") != nil then
					CarboniteRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if CarboniteRing != nil then
				CarboniteRing.setPositionSmooth(Object.getPosition(),false,false)
				CarboniteRing.setRotation({0,180,0},false,false)
			else
				printToAll("Unable to fetch the Carbonite Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"CarbonFreezingSuccessfulCoroutine")
end--function 

function CarbonFreezingFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Carbon Freezing Mission failed.")
end--function 

--PURSUIT (IMPERIAL)---------------------------------------------------------------

function PursuitSuccessful(Object,PlayerColor)
	function PursuitSuccessfulCoroutine()
		Object.clearButtons()
		printToAll("\nImperial Pursuit Mission Succeeded.")
		local PursuitLeader = nil
		local PursuitRingIndex = 0
		local PursuitRing = nil
		--try to take the Pursuit ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Imperial.RingBag).getObjects()) do 
			if Item.name == "Pursuit" then
				PursuitRing = getObjectFromGUID(IDs.Imperial.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,180,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if PursuitRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--rebel leader?
				if Obj.getVar("Component") == "Leader" and string.find(Obj.getDescription(),"Rebel;") != nil then
					--Pursuit ring attached?
					for I,Item in pairs(Obj.getAttachments()) do
						--Pursuit ring?
						if string.find(Item.description,"Ring;") != nil and Item.name == "Pursuit" then
							PursuitLeader = Obj
							PursuitRingIndex = Item.index
							break
						end--if
					end--for
				elseif Obj.getName() == "Pursuit" and string.find(Obj.getDescription(),"Ring;") != nil then
					PursuitRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if PursuitRing != nil then
				PursuitRing.setPositionSmooth(Object.getPosition(),false,false)
				PursuitRing.setRotation({0,180,0},false,false)
			elseif PursuitLeader != nil then	--found it attached to another leader... 
				function ReusePursuitRing(Object)
					Object.clearButtons()
					--take ring from Pursuit Leader...
					PursuitRing = PursuitLeader.removeAttachment(PursuitRingIndex)
					PursuitRing.setPositionSmooth(Object.getPosition(),false,false)
					PursuitRing.setRotation({0,180,0},false,false)
					PursuitLeader.clearButtons()
				end--function 
				Object.createButton({click_function="ReusePursuitRing",function_owner=Global,label="Take Ring From\n"..PursuitLeader.getName(),position={0,0.2,-0.7},scale={0.5,0.5,0.5},color={1,0,0},width=1800,height=400,font_size=150,font_color={0,0,0},tooltip="Take the Pursuit Ring from "..PursuitLeader.getName().." to use for the new Leader."})
				Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="Leave the Pursuit Ring where it is, or I'll attach it myself."})
			else
				printToAll("Cannot find the Pursuit Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"PursuitSuccessfulCoroutine")
end--function 

function PursuitFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Pursuit Mission failed.")
end--function 

--MERCENARY TRAP (IMPERIAL)---------------------------------------------------------------

function MercenaryAssistanceSuccessful(Object,PlayerColor)
	function MercenaryAssistanceSuccessfulCoroutine()
		Object.clearButtons()
		printToAll("\nImperial Mercenary Trap Mission Succeeded.")
		local MercenaryAssistanceLeader = nil
		local MercenaryAssistanceRingIndex = 0
		local MercenaryAssistanceRing = nil
		--try to take the MercenaryAssistance ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Imperial.RingBag).getObjects()) do 
			if Item.name == "Mercenary Trap" then
				MercenaryAssistanceRing = getObjectFromGUID(IDs.Imperial.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,180,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if MercenaryAssistanceRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--Imperial leader?
				if Obj.getVar("Component") == "Leader" and string.find(Obj.getDescription(),"Imperial;") != nil then
					--MercenaryAssistance ring attached?
					for I,Item in pairs(Obj.getAttachments()) do
						--MercenaryAssistance ring?
						if string.find(Item.description,"Ring;") != nil and Item.name == "Mercenary Trap" then
							MercenaryAssistanceLeader = Obj
							MercenaryAssistanceRingIndex = Item.index
							break
						end--if
					end--for
				elseif Obj.getName() == "Mercenary Trap" and string.find(Obj.getDescription(),"Ring;") != nil then
					MercenaryAssistanceRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if MercenaryAssistanceRing != nil then
				MercenaryAssistanceRing.setPositionSmooth(Object.getPosition(),false,false)
				MercenaryAssistanceRing.setRotation({0,180,0},false,false)
			elseif MercenaryAssistanceLeader != nil then	--found it attached to another leader... 
				function ReuseMercenaryAssistanceRing(Object)
					Object.clearButtons()
					--take ring from MercenaryAssistance Leader...
					MercenaryAssistanceRing = MercenaryAssistanceLeader.removeAttachment(MercenaryAssistanceRingIndex)
					MercenaryAssistanceRing.setPositionSmooth(Object.getPosition(),false,false)
					MercenaryAssistanceRing.setRotation({0,180,0},false,false)
					MercenaryAssistanceLeader.clearButtons()
				end--function 
				Object.createButton({click_function="ReuseMercenaryAssistanceRing",function_owner=Global,label="Take Ring From\n"..MercenaryAssistanceLeader.getName(),position={0,0.2,-0.7},scale={0.5,0.5,0.5},color={1,0,0},width=1800,height=400,font_size=150,font_color={0,0,0},tooltip="Take the Mercenary Trap Ring from "..MercenaryAssistanceLeader.getName().." to use for the new Leader."})
				Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="Leave the Mercenary Trap Ring where it is, or I'll attach it myself."})
			else
				printToAll("Cannot find the Mercenary Trap Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"MercenaryAssistanceSuccessfulCoroutine")
end--function 

function MercenaryAssistanceFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Mercenary Trap Mission failed.")
end--function 

--TACTICAL TRAINING (IMPERIAL)---------------------------------------------------------------

function TacticalTrainingResolved(Object,PlayerColor)
	function TacticalTrainingSuccessfulCoroutine()
		Object.clearButtons()
		local TacticalTrainingLeader = nil
		local TacticalTrainingRingIndex = 0
		local TacticalTrainingRing = nil
		--try to take the TacticalTraining ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Imperial.RingBag).getObjects()) do 
			if Item.name == "Tactical Training" then
				TacticalTrainingRing = getObjectFromGUID(IDs.Imperial.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,180,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if TacticalTrainingRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--imperial leader?
				if Obj.getVar("Component") == "Leader" and string.find(Obj.getDescription(),"Imperial;") != nil then
					--TacticalTraining ring attached?
					for I,Item in pairs(Obj.getAttachments()) do
						--TacticalTraining ring?
						if string.find(Item.description,"Ring;") != nil and Item.name == "Tactical Training" then
							TacticalTrainingLeader = Obj
							TacticalTrainingRingIndex = Item.index
							break
						end--if
					end--for
				elseif Obj.getName() == "Tactical Training" and string.find(Obj.getDescription(),"Ring;") != nil then
					TacticalTrainingRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if TacticalTrainingRing != nil then
				TacticalTrainingRing.setPositionSmooth(Object.getPosition(),false,false)
				TacticalTrainingRing.setRotation({0,180,0},false,false)
			elseif TacticalTrainingLeader != nil then	--found it attached to another leader... 
				function ReuseTacticalTrainingRing(Object)
					Object.clearButtons()
					--take ring from TacticalTraining Leader...
					TacticalTrainingRing = TacticalTrainingLeader.removeAttachment(TacticalTrainingRingIndex)
					TacticalTrainingRing.setPositionSmooth(Object.getPosition(),false,false)
					TacticalTrainingRing.setRotation({0,180,0},false,false)
					TacticalTrainingLeader.clearButtons()
				end--function 
				Object.createButton({click_function="ReuseTacticalTrainingRing",function_owner=Global,label="Take Ring From\n"..TacticalTrainingLeader.getName(),position={0,0.2,-0.7},scale={0.5,0.5,0.5},color={1,0,0},width=1800,height=400,font_size=150,font_color={0,0,0},tooltip="Take the Tactical Training Ring from "..TacticalTrainingLeader.getName().." to use for the new Leader."})
				Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="Leave the Tactical Training Ring where it is, or I'll attach it myself."})
			else
				printToAll("Cannot find the Tactical Training Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"TacticalTrainingSuccessfulCoroutine")
end--function 

--INTERCEPT TRANSMISSION (IMPERIAL)----------------------------------------------------------------

function InterceptTransmissionSuccessful(Object,PlayerColor)
	--set resume step... 
	ResumeStep = Step
	--raise imperial hidden zone...
	getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.On,false,false)
	--imperial panel prompt...
	RebelPanel.clearButtons()
	RebelPanel.createButton(({click_function="NA",function_owner=Global,label="INTERCEPT TRANSMISSION",position={0,0.2,-0.5},scale={0.5,0.5,0.5},width=0,height=0,font_size=100,font_color={1,1,1}}))
	--set rebel camera view to rebel panel...
	if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) Ping({Player="White",Position={0,1,29}}) end--if
	if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) Ping({Player="Red",Position={0,1,29}}) end--if
	if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel)  end--if
end--function 

function InterceptTransmissionFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Intercept Transmission failed.")
end--function 

--GATHER INTEL (IMPERIAL)-----------------------------------------------------------------------------

function GatherIntelSuccessful(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Gather Intel Mission Succeeded.")
	if Object.getDescription() == nil then Object.setDescription("") end--if
	Object.createButton({click_function="GatherIntelDrawProbes",function_owner=Global,label="Draw Probe Cards",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={0.5,0.5,1},width=1500,height=250,font_size=150,font_color={0,0,0},tooltip="Click here to draw a Probe card for every 4 units in the Rebel Base Space (minimum 1 draw)."})
	Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="If you performed this card manually, click Done to signify yo are finished."})
end--function 

function GatherIntelDrawProbes(Object,PlayerColor)
	Object.clearButtons()
	local RebelCount = 0
	local Drawcount = 0
	local BaseRevealed = IsBaseRevealed()
	local BaseSystem = GetRebelBaseSystem()
	for O,Obj in pairs(getAllObjects()) do 
		if Obj.getVar("Component") == "Unit" then
			if Obj.getVar("Faction") == "Rebel" then 
				if Obj.getVar("Location") == "REBEL BASE" then
					RebelCount = RebelCount + 1
				elseif BaseRevealed and Obj.getVar("Location") == BaseSystem then 
					RebelCount = RebelCount + 1
				end--if
			end--if
		end--if unit 
	end--for O,Obj 
	DrawCount = math.floor(RebelCount/4)
	if DrawCount < 1 then DrawCount = 1 end--if
	printToAll("There are "..RebelCount.." Rebel Units in the Rebel Base.\nGather Intel will draw "..DrawCount.." Probe Cards.",{1,1,0})
	DealToHand({Deck="Probe",Player="Blue",Index=4,Qty=DrawCount,Flip=true})
end--function 

function GatherIntelFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nImperial Gather Intel failed.")
end--function 
	
--SEEK YODA (REBEL)---------------------------------------------------------------

function SeekYodaResolved(Object,PlayerColor)
	function SeekYodaResolvedCoroutine()
		Object.clearButtons()
		printToAll("\nRebel Seek Yoda Mission Succeeded.")
		local MasterYodaLeader = nil
		local MasterYodaRingIndex = 0
		local MasterYodaRing = nil
		--try to take the MasterYoda ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Rebel.RingBag).getObjects()) do 
			if Item.name == "Master Yoda" then
				MasterYodaRing = getObjectFromGUID(IDs.Rebel.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,0,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if MasterYodaRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--rebel leader?
				if Obj.getVar("Component") == "Leader" and string.find(Obj.getDescription(),"Rebel;") != nil then
					--MasterYoda ring attached?
					for I,Item in pairs(Obj.getAttachments()) do
						--MasterYoda ring?
						if string.find(Item.description,"Ring;") != nil and Item.name == "Master Yoda" then
							MasterYodaLeader = Obj
							MasterYodaRingIndex = Item.index
							break
						end--if
					end--for
				elseif Obj.getName() == "Master Yoda" and string.find(Obj.getDescription(),"Ring;") != nil then
					MasterYodaRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if MasterYodaRing != nil then
				MasterYodaRing.setPositionSmooth(Object.getPosition(),false,false)
				MasterYodaRing.setRotation({0,0,0},false,false)
			elseif MasterYodaLeader != nil then	--found it attached to another leader... 
				function ReuseMasterYodaRing(Object)
					Object.clearButtons()
					--take ring from MasterYoda Leader...
					MasterYodaRing = MasterYodaLeader.removeAttachment(MasterYodaRingIndex)
					MasterYodaRing.setPositionSmooth(Object.getPosition(),false,false)
					MasterYodaRing.setRotation({0,180,0},false,false)
					MasterYodaLeader.clearButtons()
				end--function 
				Object.createButton({click_function="ReuseMasterYodaRing",function_owner=Global,label="Take Ring From\n"..MasterYodaLeader.getName(),position={0,0.2,-0.7},scale={0.5,0.5,0.5},color={1,0,0},width=1800,height=400,font_size=150,font_color={0,0,0},tooltip="Take the Master Yoda Ring from "..MasterYodaLeader.getName().." to use for the new Leader."})
				Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="Leave the Master Yoda Ring where it is, or I'll attach it myself."})
			else
				printToAll("Cannot find the Master Yoda Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"SeekYodaResolvedCoroutine")
end--function 

function SeekYodaDone(Object,PlayerColor)
	Object.clearButtons()
end--function 

--CONTACT SMUGGLERS (REBEL)---------------------------------------------------------------

function ContactSmugglersSuccessful(Object,PlayerColor)
	function ContactSmugglersSuccessfulCoroutine()
		Object.clearButtons()
		printToAll("\nRebel Contact Smugglers Mission Succeeded.")
		local SmugglerLeader = nil
		local SmugglerRingIndex = 0
		local SmugglerRing = nil
		--try to take the Smuggler ring from the box... 
		for I,Item in pairs(getObjectFromGUID(IDs.Rebel.RingBag).getObjects()) do 
			if Item.name == "Smuggler" then
				SmugglerRing = getObjectFromGUID(IDs.Rebel.RingBag).takeObject({guid=Item.guid,position=Object.getPosition(),rotation={0,0,0},smooth=true})
				coroutine.yield(0)
				break
			end--if
		end--for O,Obj
		--ring not found?
		if SmugglerRing == nil then
			--look for it on the board... 
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--rebel leader?
				if Obj.getVar("Component") == "Leader" and string.find(Obj.getDescription(),"Rebel;") != nil then
					--Smuggler ring attached?
					for I,Item in pairs(Obj.getAttachments()) do
						--Smuggler ring?
						if string.find(Item.description,"Ring;") != nil and Item.name == "Smuggler" then
							SmugglerLeader = Obj
							SmugglerRingIndex = Item.index
							break
						end--if
					end--for
				elseif Obj.getName() == "Smuggler" and string.find(Obj.getDescription(),"Ring;") != nil then
					SmugglerRing = Obj
					break
				end--if
			end--for O,Obj 
			--found the ring loose on the board?
			if SmugglerRing != nil then
				SmugglerRing.setPositionSmooth(Object.getPosition(),false,false)
				SmugglerRing.setRotation({0,0,0},false,false)
			elseif SmugglerLeader != nil then	--found it attached to another leader... 
				function ReuseSmugglerRing(Object)
					Object.clearButtons()
					--take ring from Smuggler Leader...
					SmugglerRing = SmugglerLeader.removeAttachment(SmugglerRingIndex)
					SmugglerRing.setPositionSmooth(Object.getPosition(),false,false)
					SmugglerRing.setRotation({0,180,0},false,false)
					SmugglerLeader.clearButtons()
				end--function 
				Object.createButton({click_function="ReuseSmugglerRing",function_owner=Global,label="Take Ring From\n"..SmugglerLeader.getName(),position={0,0.2,-0.7},scale={0.5,0.5,0.5},color={1,0,0},width=1800,height=400,font_size=150,font_color={0,0,0},tooltip="Take the Smuggler Ring from "..SmugglerLeader.getName().." to use for the new Leader."})
				Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="Leave the Smuggler Ring where it is, or I'll attach it myself."})
			else
				printToAll("Cannot find the Smuggler Ring.",{1,1,0})
			end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"ContactSmugglersSuccessfulCoroutine")
end--function 

function ContactSmugglersFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nRebel Contact Smugglers Mission failed.")
end--function 

--INFILTRATION (REBEL)-----------------------------------------------------------------------------

function InfiltrationSuccessful(Object,PlayerColor)
	function InfiltrationSuccessfulCoroutine()
		Object.clearButtons()
		Object.createButton({click_function="NA",function_owner=Global,label="Resolving",position={0,0.2,-0.6},scale={0.5,0.5,0.5},width=0,height=0,font_size=200,font_color={1,1,1}})
		Object.createButton({click_function="InfiltrationDone",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Click here if you are done with resolving this mission."})
		coroutine.yield(0)
		printToAll("\nRebel Infiltration Mission succeeded.")
		RebelPanelCards = {}
		for C=1,2 do
			local Card = DrawFromDeck({Deck="Objective",Smooth=false,Position={3.75-C*2.5,1,30},Rotation={0,0,0},Hidden={"Blue","Orange"}})
			coroutine.yield(0)
			Card.clearButtons()
			Card.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
			Card.createButton({click_function="InfiltrationTop",function_owner=Global,label="Top",position={-0.5,0.2,0.6},scale={0.5,0.5,0.5},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Place this Card on the top of the Objective Deck."})
			Card.createButton({click_function="InfiltrationBottom",function_owner=Global,label="Bottom",position={0.5,0.2,0.6},scale={0.5,0.5,0.5},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Place this Card on the bottom of the Objective Deck."})
			table.insert(RebelPanelCards,Card)
		end--for C
		--did we get any cards?
		if #RebelPanelCards > 0 then
			--set resume step... 
			ResumeStep = Step
			--raise imperial hidden zone...
			getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.On,false,false)
			--imperial panel prompt...
			RebelPanel.clearButtons()
			RebelPanel.createButton(({click_function="NA",function_owner=Global,label="INFILTRATION\nDraw 2 Objectives\nPlace 1 on Top\nand 1 on the Bottom",position={0,0.2,-0.5},scale={0.5,0.5,0.5},width=0,height=0,font_size=100,font_color={1,1,1}}))
			--set rebel camera view to rebel panel...
			if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) Ping({Player="White",Position={0,1,29}}) end--if
			if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) Ping({Player="Red",Position={0,1,29}}) end--if
			if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel)  end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"InfiltrationSuccessfulCoroutine")
end--function 

function InfiltrationFailed(Object,PlayerColor)
	Object.clearButtons()
	printToAll("\nRebel Infiltration Mission failed.")
end--function 

function InfiltrationDone(Object)
	--clear rebel panel prompt... 
	RebelPanel.clearButtons()
	Object.clearButtons()
	for P=#RebelPanelCards,1,-1 do
		RebelPanelCards[P].setRotation({0,0,180})
	end--for P
	--remove rebel panel hidden zone...
	getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
	--resume from interrupt...
	Step = "" 
end--function 
	

function InfiltrationTop(Object,PlayerColor)
	PlaceTopObjective(Object,PlayerColor)
	for P=#RebelPanelCards,1,-1 do
		if RebelPanelCards[P] == Object then
			table.remove(RebelPanelCards,P)
			--should be 1 card remaining now... 
			if #RebelPanelCards == 1 then
				PlaceBottomObjective(RebelPanelCards[1],PlayerColor)
				RebelPanelCards = {}
			end--if
			break
		end--if
	end--for P
	--no more cards?
	if #RebelPanelCards == 0 then
		--clear rebel panel prompt... 
		RebelPanel.clearButtons()
		--remove rebel panel hidden zone...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		--remove buttons on mission card... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "INFILTRATION" then
				Obj.clearButtons()
			end--if
		end--for O,Obj
		--resume from interrupt...
		Step = "" 
	end--if
end--function 

function InfiltrationBottom(Object,PlayerColor)
	PlaceBottomObjective(Object,PlayerColor)
	for P=#RebelPanelCards,1,-1 do
		if RebelPanelCards[P] == Object then
			table.remove(RebelPanelCards,P)
			--should be 1 card remaining now... 
			if #RebelPanelCards == 1 then
				PlaceTopObjective(RebelPanelCards[1],PlayerColor)
				RebelPanelCards = {}
			end--if
			break
		end--if
	end--for P
	--no more cards?
	if #RebelPanelCards == 0 then
		--clear rebel panel prompt... 
		RebelPanel.clearButtons()
		--remove rebel panel hidden zone...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		--remove buttons on mission card... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "INFILTRATION" then
				Obj.clearButtons()
			end--if
		end--for O,Obj
		--resume from interrupt...
		Step = "" 
	end--if
end--function 
	
--SABOTAGE (REBEL)---------------------------------------------------------------------------------

function SabotageSuccessful(Object)
  Object.clearButtons()
  printToAll("\nRebel Sabotage Mission Succeeded.")
  function GrabSabotageMarker()
    Object.clearButtons()
    printToAll("Drop this Marker above the System that was Sabotaged.")
    Ping({Position=Object.getPosition()})
    getObjectFromGUID("8c6111").takeObject({smooth=true,position=Object.getPosition(),rotation={0,180,0}})
  end--function 
  if Object.getDescription() == nil then Object.setDescription("") end--if
  --RotE?
  if string.find(Object.getDescription(),"RotE;") != nil then
    Object.createButton({click_function="GrabSabotageMarker",function_owner=Global,label="Get Sabotage Marker",position={0,0.2,-0.6},scale={0.5,0.5,0.5},color={1,0,0},width=1800,height=250,font_size=150,font_color={0,0,0},tooltip="Spawn a Sabotage Marker to be placed onto the board."})
    Object.createButton({click_function="ClearButtons",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=900,height=250,font_size=150,font_color={0,0,0},tooltip="I don't need a Sabotage Marker."})
  else--base game sabotage... 
    GrabSabotageMarker()
  end--if
end--function 

function SabotageFailed(Object)
  Object.clearButtons()
  printToAll("\nRebel Sabotage Mission failed.")
end--function 

--COVERT OPERATION (REBEL)-------------------------------------------------------------------------

function CovertOperationSuccessful(Object)
	function CovertOperationSuccessfulCoroutine()
		Object.clearButtons()
		Object.createButton({click_function="NA",function_owner=Global,label="Resolving",position={0,0.2,-0.6},scale={0.5,0.5,0.5},width=0,height=0,font_size=200,font_color={1,1,1}})
		Object.createButton({click_function="CovertOperationDone",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Click here if you are done with resolving this mission."})
		coroutine.yield(0)
		printToAll("\nRebel Covert Operation Mission succeeded.")
		RebelPanelCards = {}
		for C=1,2 do
			local Card = DrawFromDeck({Deck="Objective",Smooth=false,Position={3.75-C*2.5,1,30},Rotation={0,0,0},Hidden={"Blue","Orange"}})
			coroutine.yield(0)
			Card.clearButtons()
			Card.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
			Card.createButton({click_function="CovertOperationBottom",function_owner=Global,label="Bottom",position={-0.5,0.2,0.6},scale={0.5,0.5,0.5},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Place this Card on the bottom of the Objective Deck."})
			Card.createButton({click_function="CovertOperationKeep",function_owner=Global,label="Keep",position={0.5,0.2,0.6},scale={0.5,0.5,0.5},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Keep this Objective Card, and add it to your hand."})
			table.insert(RebelPanelCards,Card)
		end--for C
		--did we get any cards?
		if #RebelPanelCards > 0 then
			--set resume step... 
			ResumeStep = Step
			--raise imperial hidden zone...
			getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.On,false,false)
			--imperial panel prompt...
			RebelPanel.clearButtons()
			RebelPanel.createButton(({click_function="NA",function_owner=Global,label="COVERT OPERATION\nDraw 2 Objectives and keep 1\nthen place the other on the bottom",position={0,0.2,-0.5},scale={0.5,0.5,0.5},width=0,height=0,font_size=100,font_color={1,1,1}}))
			--set rebel camera view to rebel panel...
			if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) Ping({Player="White",Position={0,1,29}}) end--if
			if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) Ping({Player="Red",Position={0,1,29}}) end--if
			if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel)  end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"CovertOperationSuccessfulCoroutine")
end--function 

function CovertOperationFailed(Object)
  Object.clearButtons()
  printToAll("\nRebel Covert Operation Mission failed.")
end--function 

function CovertOperationDone(Object)
	--clear rebel panel prompt... 
	RebelPanel.clearButtons()
	Object.clearButtons()
	for P=#RebelPanelCards,1,-1 do
		RebelPanelCards[P].setRotation({0,0,180})
	end--for P
	--remove rebel panel hidden zone...
	getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
	--resume from interrupt...
	Step = "" 
end--function 
	

function CovertOperationBottom(Object,PlayerColor)
	PlaceBottomObjective(Object,PlayerColor)
	for P=#RebelPanelCards,1,-1 do
		if RebelPanelCards[P] == Object then
			table.remove(RebelPanelCards,P)
			--should be 1 card remaining now... 
			if #RebelPanelCards == 1 then
				KeepObjective(RebelPanelCards[1],PlayerColor)
				RebelPanelCards = {}
			end--if
			break
		end--if
	end--for P
	--no more cards?
	if #RebelPanelCards == 0 then
		--clear rebel panel prompt... 
		RebelPanel.clearButtons()
		--remove rebel panel hidden zone...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		--remove buttons on mission card... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "COVERT OPERATION" then
				Obj.clearButtons()
			end--if
		end--for O,Obj
		--resume from interrupt...
		Step = "" 
	end--if
end--function 

function CovertOperationKeep(Object,PlayerColor)
	KeepObjective(Object,PlayerColor)
	for P=#RebelPanelCards,1,-1 do
		if RebelPanelCards[P] == Object then
			table.remove(RebelPanelCards,P)
			--should be 1 card remaining now... 
			if #RebelPanelCards == 1 then
				PlaceBottomObjective(RebelPanelCards[1],PlayerColor)
				RebelPanelCards = {}
			end--if
			break
		end--if
	end--for P
	--no more cards?
	if #RebelPanelCards == 0 then
		--clear rebel panel prompt... 
		RebelPanel.clearButtons()
		--remove rebel panel hidden zone...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		--remove buttons on mission card... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "COVERT OPERATION" then
				Obj.clearButtons()
			end--if
		end--for O,Obj
		--resume from interrupt...
		Step = "" 
	end--if
end--function 
	
--STOLEN PLANS (REBEL)-----------------------------------------------------------------------------

function StolenPlansSuccess(Object)
	function StolenPlansSuccessCoroutine()
		Object.clearButtons()
		Object.createButton({click_function="NA",function_owner=Global,label="Resolving",position={0,0.2,-0.6},scale={0.5,0.5,0.5},width=0,height=0,font_size=200,font_color={1,1,1}})
		Object.createButton({click_function="StolenPlansDone",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Click here if you are done with resolving Stolen Plans."})
		coroutine.yield(0)
		printToAll("\nRebel Stolen Plans Mission succeeded.")
		RebelPanelCards = {}
		for C=1,4 do
			local Card = DrawFromDeck({Deck="Objective",Smooth=false,Position={5-C*2,1,30},Rotation={0,0,0},Hidden={"Blue","Orange"}})
			coroutine.yield(0)
			if Card != nil then 
				Card.clearButtons()
				Card.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
				Card.createButton({click_function="StolenPlansPlaceTop",function_owner=Global,label="Top",position={0,0.2,0.6},scale={0.5,0.5,0.5},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Place this Card on the top of the Objective Deck."})
				table.insert(RebelPanelCards,Card)
			end--if card drawn ok
		end--for C
		--did we get any cards?
		if #RebelPanelCards > 0 then
			--set resume step... 
			ResumeStep = Step
			--raise imperial hidden zone...
			getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.On,false,false)
			--imperial panel prompt...
			RebelPanel.clearButtons()
			RebelPanel.createButton(({click_function="NA",function_owner=Global,label="STOLEN PLANS\nDraw 4 Objectives and\nplace them back top in any order\n(The first card you click will be the bottom-most\nthe last card you click will be the top-most card).",position={0,0.2,-0.4},scale={0.5,0.5,0.5},width=0,height=0,font_size=100,font_color={1,1,1}}))
			--RebelPanel.createButton({click_function="StolenPlansDone",function_owner=Global,label="Done",position={0,0.1,0.88},scale={0.6,0.6,0.6},width=500,height=150,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Click Done if you want to manually place the cards yourself."})
			--set rebel camera view to rebel panel...
			if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) Ping({Player="White",Position={0,1,29}}) end--if
			if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) Ping({Player="Red",Position={0,1,29}}) end--if
			if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel)  end--if
		end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"StolenPlansSuccessCoroutine")
end--function 

function StolenPlansDone(Object)
	--clear rebel panel prompt... 
	RebelPanel.clearButtons()
	Object.clearButtons()
	for P=#RebelPanelCards,1,-1 do
		RebelPanelCards[P].setRotation({0,0,180})
	end--for P
	--remove rebel panel hidden zone...
	getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
	--resume from interrupt...
	Step = "" 
end--function 

function StolenPlansFail(Object)
  Object.clearButtons()
  printToAll("\nRebel Stolen Plans Mission failed.")
end--function 

function StolenPlansPlaceTop(Object,PlayerColor)
	PlaceTopObjective(Object,PlayerColor)
	for P=#RebelPanelCards,1,-1 do
		if RebelPanelCards[P] == Object then
			table.remove(RebelPanelCards,P)
			break
		end--if
	end--for P
	--no more cards?
	if #RebelPanelCards == 0 then
		--clear rebel panel prompt... 
		RebelPanel.clearButtons()
		--remove rebel panel hidden zone...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		--remove buttons on mission card... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "STOLEN PLANS" then
				Obj.clearButtons()
			end--if
		end--for O,Obj
		--resume from interrupt...
		Step = "" 
	end--if
end--function 
	
--PLANT FALSE LEAD (REBEL)-------------------------------------------------------------------------

function PlantFalseLeadResolve(Object)
	function PlantFalseLeadTakeProbesCoroutine()
		Object.clearButtons()
		coroutine.yield(0)
		printToAll("\nResolving Plant False Lead...")
		printToAll("Shuffling Imperial Probe Hand...")
		local ProbeHand = getObjectFromGUID(IDs.Imperial.ProbeHand)
		ShuffleHand(IDs.Imperial.ProbeHand)
		coroutine.yield(0)
		printToAll("Taking 4 Probe Cards from the Imperial Player...")
		RebelPanelCards = {}
		for C=1,4 do
			coroutine.yield(0)
			if #ProbeHand.getObjects() > 0 then
				local CardObj = getObjectFromGUID(ProbeHand.getObjects()[1].guid)
				if CardObj != nil then
					CardObj.setHiddenFrom({"Blue","Orange","Grey"})
					CardObj.setPosition({5-C*2,1,30})
					CardObj.setRotation({0,0,0})
					coroutine.yield(0)
					CardObj.clearButtons()
					CardObj.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
					CardObj.createButton({click_function="PlantFalseLeadPlaceTop",function_owner=Global,label="Top",position={-0.5,0.2,0.4},scale={0.5,0.5,0.5},color={1,1,1,0.8},width=900,height=400,font_size=250,font_color={0,0,0},tooltip="Place this Card on the top of the Probe Deck."})
					CardObj.createButton({click_function="PlantFalseLeadPlaceBottom",function_owner=Global,label="Bottom",position={0.5,0.2,0.4},scale={0.5,0.5,0.5},color={1,1,1,0.8},width=900,height=400,font_size=250,font_color={0,0,0},tooltip="Place this Card on the bottom of the Probe Deck."})
					table.insert(RebelPanelCards,CardObj)
				end--if
			else
				printToAll("Imperial Probe Hand had less than 4 Probe Cards.",{1,1,0})
				break
			end--if
		end--for C 
		--did we get any cards?
		if #RebelPanelCards > 0 then
			--set resume step... 
			ResumeStep = Step
			--raise imperial hidden zone...
			getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.On,false,false)
			--imperial panel prompt...
			RebelPanel.clearButtons()
			RebelPanel.createButton(({click_function="NA",function_owner=Global,label="PLANT FALSE LEAD\nTake 4 Probe Cards and\nPlace them on top or bottom\nof the Probe Deck in any order",position={0,0.2,-0.5},scale={0.5,0.5,0.5},width=0,height=0,font_size=100,font_color={1,1,1}}))
			Object.createButton({click_function="NA",function_owner=Global,label="Resolving",position={0,0.2,-0.6},scale={0.5,0.5,0.5},width=0,height=0,font_size=200,font_color={1,1,1}})
			Object.createButton({click_function="PlantFalseLeadDone",function_owner=Global,label="Done",position={0,0.2,-0.2},scale={0.5,0.5,0.5},color={1,1,1},width=1200,height=250,font_size=150,font_color={0,0,0},tooltip="Click here if you are done with resolving this mission."})
				--set rebel camera view to rebel panel...
			if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) Ping({Player="White",Position={0,1,29}}) end--if
			if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) Ping({Player="Red",Position={0,1,29}}) end--if
			if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel)  end--if
		end--if
		return 1
	end--function
	startLuaCoroutine(Global,"PlantFalseLeadTakeProbesCoroutine") 
end--function

function PlantFalseLeadResolved(Object)
  Object.clearButtons()
end--function 

function PlantFalseLeadDone(Object)
	--clear rebel panel prompt... 
	RebelPanel.clearButtons()
	Object.clearButtons()
	for P=#RebelPanelCards,1,-1 do
		RebelPanelCards[P].setRotation({0,0,180})
	end--for P
	--remove rebel panel hidden zone...
	getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
	--resume from interrupt...
	Step = "" 
end--function 

function PlantFalseLeadPlaceTop(Object,PlayerColor)
	PlaceTopProbe(Object,PlayerColor)
	for P=#RebelPanelCards,1,-1 do
		if RebelPanelCards[P] == Object then
			table.remove(RebelPanelCards,P)
			break
		end--if
	end--for P
	--no more cards?
	if #RebelPanelCards == 0 then
		--clear rebel panel prompt... 
		RebelPanel.clearButtons()
		--remove rebel panel hidden zone...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		--remove buttons on mission card... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "PLANT FALSE LEAD" then
				Obj.clearButtons()
			end--if
		end--for O,Obj
		--resume from interrupt...
		Step = "" 
	end--if
end--function 
	
function PlantFalseLeadPlaceBottom(Object,PlayerColor)
	PlaceBottomProbe(Object,PlayerColor)
	for P=#RebelPanelCards,1,-1 do
		if RebelPanelCards[P] == Object then
			table.remove(RebelPanelCards,P)
			break
		end--if
	end--for P
	--no more cards?
	if #RebelPanelCards == 0 then
		--clear rebel panel prompt... 
		RebelPanel.clearButtons()
		--remove rebel panel hidden zone...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		--remove buttons on mission card... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "PLANT FALSE LEAD" then
				Obj.clearButtons()
			end--if
		end--for O,Obj
		--resume from interrupt...
		Step = "" 
	end--if
end--function 
	
--GALACTIC STRUGGLE--------------------------------------------------------------------------------

function GalacticStruggleRebelMissionDrawCoroutine()
	if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) Ping({Player="White",Position={0,1,29}}) end--if
	if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) Ping({Player="Red",Position={0,1,29}}) end--if
	if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel) end--if
    coroutine.yield(0)
    RebelPanel.clearButtons()
	RebelPanel.createButton(({click_function="NA",function_owner=Global,label="GALACTIC STRUGGLE:\nDraw 3 Missions\nand Discard 1",position={0,0.2,-0.6},width=0,height=0,font_size=100,font_color={1,1,1}}))
	RebelPanelCards = {}
    for C=1,3 do
		RebelPanelCards[C] = DrawFromDeck({Deck="RebelMission",Smooth=true,Position={-5+C*2.5,1,29},Rotation={0,0,0},Hidden={"Blue","Orange"}})
		coroutine.yield(0)
		RebelPanelCards[C].clearButtons()
		RebelPanelCards[C].createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
		RebelPanelCards[C].createButton({click_function="GalacticStruggleDiscardMission",function_owner=Global,label="Discard",position={0,0.2,2},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Discard this Mission and keep the others."})
    end--for C
	return 1
end--function 

function GalacticStruggleImperialMissionDrawCoroutine()
	if Player.Blue.seated then Player.Blue.lookAt(CameraViews.ImperialPanel) Ping({Player="Blue",Position={0,1,-29}}) end--if
	if Player.Orange.seated then Player.Orange.lookAt(CameraViews.ImperialPanel) Ping({Player="Orange",Position={0,1,-29}}) end--if
	if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.ImperialPanel) end--if
    coroutine.yield(0)
    ImperialPanel.clearButtons()
	ImperialPanel.createButton(({click_function="NA",function_owner=Global,label="GALACTIC STRUGGLE:\nDraw 3 Missions\nand Discard 1",position={0,0.2,-0.6},width=0,height=0,font_size=100,font_color={1,1,1}}))
	ImperialPanelCards = {}
    for C=1,3 do
		ImperialPanelCards[C] = DrawFromDeck({Deck="ImperialMission",Smooth=true,Position={-5+C*2.5,1,-29},Rotation={0,180,0},Hidden={"White","Red"}})
		coroutine.yield(0)
		ImperialPanelCards[C].clearButtons()
		ImperialPanelCards[C].createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
		ImperialPanelCards[C].createButton({click_function="GalacticStruggleDiscardMission",function_owner=Global,label="Discard",position={0,0.2,2},width=800,height=400,font_size=200,font_color={0,0,0},tooltip="Discard this Mission and keep the others."})
    end--for C
	return 1
end--function 

function GalacticStruggleDiscardMission(Object)
	--detect the faction, then discard the mission card and keep the rest... 
	if string.find(Object.getDescription(),"Rebel;") != nil then
		for C=1,#RebelPanelCards do 
			RebelPanelCards[C].clearButtons()
			if RebelPanelCards[C].getGUID() == Object.getGUID() then
				RebelPanelCards[C].setPosition({0,1,14})
				RebelPanelCards[C].setPositionSmooth(Decks.RebelMissionDiscard.DropSpot,false,false)
				RebelPanelCards[C].setRotationSmooth(Decks.RebelMissionDiscard.Rotation,false,false)
				RebelPanelCards[C].setHiddenFrom()
			else--send to hand... 
				RebelPanelCards[C].setPosition({0,1,19})
				RebelPanelCards[C].setRotation({0,0,0})
				CardToHand({CardID=RebelPanelCards[C].getGUID(),Player="White",Index=Hands.RebelMission.Index,Flip=true})
			end--if
		end--for
		RebelPanelCards = {}
		Game.Flags.MissionHandOK.Rebel = true
		Step = ""
	elseif string.find(Object.getDescription(),"Imperial;") != nil then
		for C=1,#ImperialPanelCards do 
			ImperialPanelCards[C].clearButtons()
			if ImperialPanelCards[C].getGUID() == Object.getGUID() then
				ImperialPanelCards[C].setPosition({0,1,-14})
				ImperialPanelCards[C].setPositionSmooth(Decks.ImperialMissionDiscard.DropSpot,false,false)
				ImperialPanelCards[C].setRotationSmooth(Decks.ImperialMissionDiscard.Rotation,false,false)
				ImperialPanelCards[C].setHiddenFrom()
			else--send to hand... 
				ImperialPanelCards[C].setPosition({0,1,-19})
				ImperialPanelCards[C].setRotation({0,180,0})
				CardToHand({CardID=ImperialPanelCards[C].getGUID(),Player="Blue",Index=Hands.ImperialMission.Index,Flip=true})
			end--if
		end--for
		ImperialPanelCards = nil
		Game.Flags.MissionHandOK.Imperial = true
		Step = ""
	else --uhoh!
		print("ERROR: could not determind Card's faction!")
	end--if
end--function 

--MAIN COROUTINE---------------------------------------------------------------------------------

function MainCoroutine()
	repeat
		coroutine.yield(0)
		if Step == "" then
			--resume step or go to next step?
			if ResumeStep != "" then
				Step = ResumeStep
				ResumeStep = ""
			else--go to next step...
				Step = NextStep
				NextStep = ""
			end--if
			startLuaCoroutine(Global,"ProcessStepCoroutine")
		end--if
		coroutine.yield(0)
	--until false
	until Step == "" and NextStep == "" and ResumeStep == ""
	print("=========================\nScript Error: Main Coroutine had no next step!\n=========================")
	return 1
end--function
	
function ProcessStepCoroutine()
	log("Step:"..Step)
	--which step are we on?
	if Step == "Setup.0.StartSetup" then
		Game.Phase = "Setup"
		printToAll("Starting Setup...")
		--lower recruit hidden zones...
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.Off,false,false)
		coroutine.yield(0)
		--prompt for type of setup (expansion?)...
		StartSetupMenu()
	elseif Step == "Setup.1.DeterminePlayers" then
		--start by shuffling everything...
		printToAll("Starting Setup...")
		printToAll("Shuffling everything...")
		for D,Deck in pairs(Decks) do
			if getObjectFromGUID(Deck.ID) != nil then
				getObjectFromGUID(Deck.ID).shuffle()
			end
		end--for
		coroutine.yield(0)
		--remove pepperfish... 
		if getObjectFromGUID("9464e9") != nil then getObjectFromGUID("9464e9").destruct() end--if
		--init faction combat sheets... 
		local FS = FindObject({Name="Rebel Combat Sheet"})
		if FS != nil then
			if Game.Flags.WFL then
				if FS.getStateId() != 3 then FS.setState(3) end--if
			elseif Game.Flags.RotE then
				if FS.getStateId() != 2 then FS.setState(2) end--if
			else--base game... 
				if FS.getStateId() != 1 then FS.setState(1) end--if
			end--if
		end--if
		coroutine.yield(0)
		FS = FindObject({Name="Imperial Combat Sheet"})
		if FS != nil then
			if Game.Flags.WFL then
				if FS.getStateId() != 3 then FS.setState(3) end--if
			elseif Game.Flags.RotE then
				if FS.getStateId() != 2 then FS.setState(2) end--if
			else--base game... 
				if FS.getStateId() != 1 then FS.setState(1) end--if
			end--if
		end--if
		coroutine.yield(0)
		--remove rote components?
		if not Game.Flags.RotE then
			RemoveComponent({ID="1f6fbd",BoxID=IDs.RoteBox})--RotE rules
			RemoveComponent({ID="c1cdc7",BoxID=IDs.RoteBox})--nebulon-b frigate box
			RemoveComponent({ID="564515",BoxID=IDs.RoteBox})--u-wing box
			RemoveComponent({ID="988851",BoxID=IDs.RoteBox})--golan arms turret box
			RemoveComponent({ID="ca216d",BoxID=IDs.RoteBox})--vanguard box
			RemoveComponent({ID="4505ba",BoxID=IDs.RoteBox})--assault tank box
			RemoveComponent({ID="f9fa3a",BoxID=IDs.RoteBox})--shield bunker box
			RemoveComponent({ID="1d349b",BoxID=IDs.RoteBox})--tie striker box
			RemoveComponent({ID="757ff6",BoxID=IDs.RoteBox})--interdictor box
			RemoveComponent({ID="d1c77d",BoxID=IDs.RoteBox})--assault tank token
			RemoveComponent({ID="e76bf3",BoxID=IDs.RoteBox})--shield bunker token
			RemoveComponent({ID="c71c86",BoxID=IDs.RoteBox})--tie striker token
			RemoveComponent({ID="f44911",BoxID=IDs.RoteBox})--vanguard token
			RemoveComponent({ID="81067f",BoxID=IDs.RoteBox})--golan arms turret token
			RemoveComponent({ID="d9c9d8",BoxID=IDs.RoteBox})--u-wing build token
			RemoveComponent({ID="80a1b0",BoxID=IDs.RoteBox})--nebulon build token
			coroutine.yield(0)
      --remove RotE cached objects...
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == "CachedObject;" then
					if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
					if string.find(Obj.getGMNotes(),"RotE;") != nil then
						Obj.destruct()
						--coroutine.yield(0)
					end--if
				end--if
			end--for O,Obj 
		end--if
		--remove wfl components?
		if not Game.Flags.WFL then
			RemoveComponent({ID="3bbe8f",BoxID=IDs.WFLBox})--RotE rules
			RemoveComponent({ID="373e5b",BoxID=IDs.WFLBox})--academy marker
			RemoveComponent({ID="b7151e",BoxID=IDs.WFLBox})--reconnaissance marker
			RemoveComponent({ID="38421e",BoxID=IDs.WFLBox})--scout trooper box
			RemoveComponent({ID="43ac9b",BoxID=IDs.WFLBox})--death trooper box
			RemoveComponent({ID="5663a1",BoxID=IDs.WFLBox})--dark trooper box
			RemoveComponent({ID="ea22ee",BoxID=IDs.WFLBox})--tie bomber box
			RemoveComponent({ID="0e0f01",BoxID=IDs.WFLBox})--tie interceptor box
			RemoveComponent({ID="842eb8",BoxID=IDs.WFLBox})--lambda shuttle box
			RemoveComponent({ID="3efec8",BoxID=IDs.WFLBox})--light cruiser box
			RemoveComponent({ID="faf5a7",BoxID=IDs.WFLBox})--tie advanced box
			RemoveComponent({ID="1dd318",BoxID=IDs.WFLBox})--tie defender box
			RemoveComponent({ID="ebd1df",BoxID=IDs.WFLBox})--delta shuttle box
			RemoveComponent({ID="1b7096",BoxID=IDs.WFLBox})--scout build token
			RemoveComponent({ID="132ba8",BoxID=IDs.WFLBox})--death trooper build token
			RemoveComponent({ID="8601b6",BoxID=IDs.WFLBox})--tie interceptor build token
			RemoveComponent({ID="a21398",BoxID=IDs.WFLBox})--tie bomber build token
			RemoveComponent({ID="d14930",BoxID=IDs.WFLBox})--lambda shuttle build token
			RemoveComponent({ID="c92dd5",BoxID=IDs.WFLBox})--light cruiser build token
			RemoveComponent({ID="0ed055",BoxID=IDs.WFLBox})--mc80 build box
			RemoveComponent({ID="831132",BoxID=IDs.WFLBox})--mc75 build box
			RemoveComponent({ID="9b2233",BoxID=IDs.WFLBox})--escort carrier build box
			RemoveComponent({ID="8da31e",BoxID=IDs.WFLBox})--hammerhead corevette build box
			RemoveComponent({ID="c36b95",BoxID=IDs.WFLBox})--light freighter build box
			RemoveComponent({ID="f4d5d0",BoxID=IDs.WFLBox})--b-wing build box
			RemoveComponent({ID="86b88e",BoxID=IDs.WFLBox})--a-wing build box
			RemoveComponent({ID="421238",BoxID=IDs.WFLBox})--jedi knight build box
			RemoveComponent({ID="bd062e",BoxID=IDs.WFLBox})--wookiee veteran build box
			RemoveComponent({ID="442e68",BoxID=IDs.WFLBox})--rebel recruit build box
			coroutine.yield(0)
      --remove WFL cached objects...
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getDescription() == "CachedObject;" then
					if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
					if string.find(Obj.getGMNotes(),"WFL;") != nil then
						Obj.destruct()
						--coroutine.yield(0)
					end--if
				end--if
			end--for O,Obj 
		end--if
		--clean up table...
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if Obj.getVar("Component") == "Unit" then
				Obj.destruct()
			elseif string.find(Obj.getDescription(),"Leader;Rebel") != nil then
				getObjectFromGUID(IDs.Rebel.LeaderBag).putObject(Obj)
				coroutine.yield(0)
			elseif string.find(Obj.getDescription(),"Leader;Imperial") != nil then
				getObjectFromGUID(IDs.Imperial.LeaderBag).putObject(Obj)
				coroutine.yield(0)
			elseif string.find(Obj.getDescription(),"Ring;Rebel;") != nil then
				getObjectFromGUID(IDs.Rebel.RingBag).putObject(Obj)
				coroutine.yield(0)
			elseif string.find(Obj.getDescription(),"Ring;Imperial;") != nil then
				getObjectFromGUID(IDs.Imperial.RingBag).putObject(Obj)
				coroutine.yield(0)
			elseif string.find(Obj.getDescription(),"BuildTile;") != nil then
				Obj.destruct()
			elseif string.find(Obj.getDescription(),"CachedObject;") != nil then
        --remove cached leaders, rings, and markers...
				if string.find(Obj.getGMNotes(),"Leader;") != nil or string.find(Obj.getGMNotes(),"AttachmentRing;") != nil or string.find(Obj.getGMNotes(),"DestroyedMarker;") != nil or string.find(Obj.getGMNotes(),"SabotageMarker;") != nil then
					Obj.destruct()
				end--if
			elseif string.find(Obj.getDescription(),"DamageMarker;") != nil then
				Obj.destruct()
			elseif string.find(Obj.getDescription(),"DestroyedMarker;") != nil then
				Obj.destruct()
			end--if
		end--for O,Obj 
		--init counts...
		Counts.Combat.Rebel.Space = 0
		Counts.Combat.Rebel.Ground = 0
		Counts.Combat.Imperial.Space = 0
		Counts.Combat.Imperial.Ground = 0
		--prompt for number of players...
		DeterminePlayersMenu()
	elseif Step == "Setup.2.PrepareLeaders" then
		--fetch all leaders to their bags...
		PleaseWait({Panel=SetupPanel,Text="Preparing Leaders..."})
		GatherToBag({BagID=IDs.Rebel.LeaderBag,Description="Leader;Rebel;"})
		coroutine.yield(0)
		GatherToBag({BagID=IDs.Imperial.LeaderBag,Description="Leader;Imperial;"})
		coroutine.yield(0)
		Game.FactionSheets.Rebel.ID = FindObject({Name="Rebel Faction Sheet"}).getGUID()
		Game.FactionSheets.Imperial.ID = FindObject({Name="Imperial Faction Sheet"}).getGUID()
		local TempItem = nil
		local AdmiralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getTable("AdmiralOffset"),Angle=0})
		local GeneralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getTable("GeneralOffset"),Angle=0})
		--fetch starting Rebel leaders to pool and put away expansion leaders if necessary...
		for _,TempItem in pairs(getObjectFromGUID(IDs.Rebel.LeaderBag).getObjects()) do
			--if the leader is a starting one...
			if string.find(TempItem.description,"Starting;") != nil then
				--admiral or general?
				if string.find(TempItem.description,"Admiral;") != nil then
					getObjectFromGUID(IDs.Rebel.LeaderBag).takeObject({guid=TempItem.guid,smooth=true,position=AdmiralSpot})
					AdmiralSpot.z = AdmiralSpot.z + 1
				else	--must be a general...
					getObjectFromGUID(IDs.Rebel.LeaderBag).takeObject({guid=TempItem.guid,smooth=true,position=GeneralSpot})
					GeneralSpot.z = GeneralSpot.z + 1
				end--if
			elseif not Game.Flags.RotE and string.find(TempItem.description,"RotE;") != nil then
				--put rise of the empire leaders away in their box (not used)...
				getObjectFromGUID(IDs.RotEBox).putObject(getObjectFromGUID(IDs.Rebel.LeaderBag).takeObject({guid=TempItem.guid}))
			elseif not Game.Flags.WFL and string.find(TempItem.description,"WFL;") != nil then
				--put wider front lines leaders away in their box (not used)...
				getObjectFromGUID(IDs.WFLBox).putObject(getObjectFromGUID(IDs.Rebel.LeaderBag).takeObject({guid=TempItem.guid}))
			end--if
			coroutine.yield(0)
		end--for
		AdmiralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getTable("AdmiralOffset"),Angle=0})
		GeneralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getTable("GeneralOffset"),Angle=0})
		--fetch starting Imperial leaders to pool and put away expansion leaders if necessary...
		for _,TempItem in pairs(getObjectFromGUID(IDs.Imperial.LeaderBag).getObjects()) do
			--if the leader is a starting one...
			if string.find(TempItem.description,"Starting;") != nil then
				--admiral or general?
				if string.find(TempItem.description,"Admiral;") != nil then
					getObjectFromGUID(IDs.Imperial.LeaderBag).takeObject({guid=TempItem.guid,smooth=true,position=AdmiralSpot})
					AdmiralSpot.z = AdmiralSpot.z - 1
				else	--must be a general...
					getObjectFromGUID(IDs.Imperial.LeaderBag).takeObject({guid=TempItem.guid,smooth=true,position=GeneralSpot})
					GeneralSpot.z = GeneralSpot.z - 1
				end--if
			elseif not Game.Flags.RotE and string.find(TempItem.description,"RotE;") != nil then
				--put rise of the empire leaders away in their box (not used)...
				getObjectFromGUID(IDs.RotEBox).putObject(getObjectFromGUID(IDs.Imperial.LeaderBag).takeObject({guid=TempItem.guid}))
			elseif not Game.Flags.WFL and string.find(TempItem.description,"WFL;") != nil then
				--put wider front lines leaders away in their box (not used)...
				getObjectFromGUID(IDs.WFLBox).putObject(getObjectFromGUID(IDs.Imperial.LeaderBag).takeObject({guid=TempItem.guid}))
			end--if
			coroutine.yield(0)
		end--for
		--advance to next step...
		NextStep = "Setup.3.PrepareGameBoadAndTimeTrack"
		Step = ""
	elseif Step == "Setup.3.PrepareGameBoadAndTimeTrack" then
		PleaseWait({Panel=SetupPanel,Text="Preparing Time Track..."})
		--init time marker (1)...
		getObjectFromGUID(IDs.TimeMarker).setPositionSmooth(Spots.TimeTrack[1],false,false)
		getObjectFromGUID(IDs.TimeMarker).setRotationSmooth({0,90,0},false,false)
		--init reputation marker (14)...
		getObjectFromGUID(IDs.ReputationMarker).setPositionSmooth(Spots.TimeTrack[14],false,false)
		getObjectFromGUID(IDs.ReputationMarker).setRotationSmooth({0,90,0},false,false)
		--advance to next step...
		NextStep = "Setup.4.PrepareObjectiveDeck"
		Step = ""
	elseif Step == "Setup.4.PrepareObjectiveDeck" then
		PleaseWait({Panel=SetupPanel,Text="Preparing Rebel Objectives Deck..."})
		--not using Wider Front Lines Expansion?
		if not Game.Flags.WFL then
			--remove all WFL Objectives...
			MoveObjectsFromBagToBag({FromBagID=GetDeck("ObjectiveISetup").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			MoveObjectsFromBagToBag({FromBagID=GetDeck("ObjectiveIISetup").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			MoveObjectsFromBagToBag({FromBagID=GetDeck("ObjectiveIIISetup").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0)
		else--remove duplicate support of the Hutts from RotE...
			MoveObjectsFromBagToBag({FromBagID=GetDeck("ObjectiveISetup").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="Support of the Hutts",Description="RotE;"})
			coroutine.yield(0)
		end--if
		--not using Rise of the Empire Expansion?
		if not Game.Flags.RotE then
			--remove all RotE Objectives...
			MoveObjectsFromBagToBag({FromBagID=GetDeck("ObjectiveISetup").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="RotE;"})
			MoveObjectsFromBagToBag({FromBagID=GetDeck("ObjectiveIISetup").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="RotE;"})
			MoveObjectsFromBagToBag({FromBagID=GetDeck("ObjectiveIIISetup").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="RotE;"})
			coroutine.yield(0)
		end--if
		--shuffle all Objective Setup Decks...
		GetDeck("ObjectiveIIISetup").shuffle()
		GetDeck("ObjectiveIISetup").shuffle()
		GetDeck("ObjectiveISetup").shuffle()
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		--remove Objective III cards until 5 are left...
		local CardCount = #GetDeck("ObjectiveIIISetup").getObjects()
		for _,CardItem in pairs(GetDeck("ObjectiveIIISetup").getObjects()) do
			coroutine.yield(0)
			--card count above 5?
			if CardCount <= 5 then
				break
			else  --remove a card...
				--Don't remove Death Star Plans...
				if CardItem.name != "Death Star Plans" then
					CardCount = CardCount - 1
					--RotE card?
					if string.find(CardItem.description,"RotE;") == nil then
						getObjectFromGUID(IDs.GameBox).putObject(GetDeck("ObjectiveIIISetup").takeObject({guid=CardItem.guid}))
					else
						getObjectFromGUID(IDs.GameBox).putObject(GetDeck("ObjectiveIIISetup").takeObject({guid=CardItem.guid}))
					end--if
				end--if
			end--if
		end--for
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		--build Objectives II (with Death Star Plans)...
		CardCount = #GetDeck("ObjectiveIISetup").getObjects()
		for _,CardItem in pairs(GetDeck("ObjectiveIISetup").getObjects()) do
			coroutine.yield(0)
			--card count above 5?
			if CardCount <= 5 then
				break
			else  --remove a card...
				--Don't remove Death Star Plans...
				if CardItem.name != "Death Star Plans" then
					CardCount = CardCount - 1
					--RotE card?
					if string.find(CardItem.description,"RotE;") == nil then
						getObjectFromGUID(IDs.GameBox).putObject(GetDeck("ObjectiveIISetup").takeObject({guid=CardItem.guid}))
					else
						getObjectFromGUID(IDs.GameBox).putObject(GetDeck("ObjectiveIISetup").takeObject({guid=CardItem.guid}))
					end--if
				end--if
			end--if
		end--for
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		--build Objectives I...
		CardCount = #GetDeck("ObjectiveISetup").getObjects()
		for _,CardItem in pairs(GetDeck("ObjectiveISetup").getObjects()) do
			coroutine.yield(0)
			--card count above 5?
			if CardCount <= 5 then
				break
			else  --remove a card...
				CardCount = CardCount - 1
				--RotE card?
				if string.find(CardItem.description,"RotE;") == nil then
					getObjectFromGUID(IDs.GameBox).putObject(GetDeck("ObjectiveISetup").takeObject({guid=CardItem.guid}))
				else
					getObjectFromGUID(IDs.GameBox).putObject(GetDeck("ObjectiveISetup").takeObject({guid=CardItem.guid}))
				end--if
			end--if
		end--for
		--assemble deck...
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		GetDeck("ObjectiveIIISetup").setPosition(Decks.ObjectiveIIISetup.DropSpot)
		GetDeck("ObjectiveIIISetup").setRotation(Decks.Objective.Rotation)
		coroutine.yield(0)
		GetDeck("ObjectiveIIISetup").setPositionSmooth({Decks.ObjectiveIIISetup.DropSpot[1],Decks.ObjectiveIIISetup.DropSpot[2]-0.1,Decks.ObjectiveIIISetup.DropSpot[3]},true,true)
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		GetDeck("ObjectiveIISetup").setPosition(Decks.ObjectiveIISetup.DropSpot)
		GetDeck("ObjectiveIISetup").setRotation(Decks.Objective.Rotation)
		coroutine.yield(0)
		GetDeck("ObjectiveIISetup").setPositionSmooth({Decks.ObjectiveIISetup.DropSpot[1],Decks.ObjectiveIISetup.DropSpot[2]-0.1,Decks.ObjectiveIISetup.DropSpot[3]},true,true)
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		GetDeck("ObjectiveISetup").setPosition(Decks.ObjectiveISetup.DropSpot)
		GetDeck("ObjectiveISetup").setRotation(Decks.Objective.Rotation)
		coroutine.yield(0)
		GetDeck("ObjectiveISetup").setPositionSmooth({Decks.ObjectiveISetup.DropSpot[1],Decks.ObjectiveISetup.DropSpot[2]-0.1,Decks.ObjectiveISetup.DropSpot[3]},true,true)
		--wait for decks to merge...
		RepCount = RepCount + 1
		repeat
			coroutine.yield(0)
		until getObjectFromGUID(Decks.ObjectiveISetup.ID) == nil and getObjectFromGUID(Decks.ObjectiveIISetup.ID) == nil
		RepCount = RepCount - 1
		--draw first Objective I Card...
		PleaseWait({Panel=SetupPanel,Text="Drawing top Rebel Objective Card..."})
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		GetDeck("Objective").deal(1,Hands.RebelObjective.Color,Hands.RebelObjective.Index)
		coroutine.yield(0)
		--advance to next step...
		NextStep = "Setup.5.PrepareActionDecks"
		Step = ""
	elseif Step == "Setup.5.PrepareActionDecks" then
		PleaseWait({Panel=SetupPanel,Text="Preparing Action Decks..."})
		--using Rise of the Empire Expansion?
		if Game.Flags.WFL then
			print("Preparing Actions cards for Wider Front Lines game...")
			--swap out RotE replacement action cards...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SON OF SKYWALKER",ExcludeDescription="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelStartingAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="HUMAN-CYBORG RELATIONS",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelStartingAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="RESOURCEFUL ASTROMECH",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelStartingAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="START THE EVACUATION",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelStartingAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="REBEL PLANNING",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="HE MEANS WELL",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="THE MILLENNIUM FALCON",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="NOBLE SACRIFICE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="IT'S A TRAP",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialStartingAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="ACCORDING TO MY DESIGN",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialStartingAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="MORE DANGEROUS THAN YOU REALIZE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="LOCAL RUMORS",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="PUBLIC SUPPORT",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="KEEP THEM FROM ESCAPING",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SCOUTING MISSION",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="TARGET THE GENERATOR",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="LORD VADER'S ORDERS",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="GOOD INTEL",ExcludeDescription="WFL;"})
		elseif Game.Flags.RotE then
			print("Preparing Actions cards for Rise of the Empire game...")
			--swap out RotE replacement action cards (Son of Skywalker and Good Intel)...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SON OF SKYWALKER",ExcludeDescription="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="GOOD INTEL",ExcludeDescription="RotE;"})
			--remove all WFL Action Cards...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelStartingAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialStartingAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
      		--remove WFL rings...
	  		coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=IDs.Rebel.RingBag,ToBagID=IDs.WFLBox,Description="WFL;"})
	  		coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=IDs.Imperial.RingBag,ToBagID=IDs.WFLBox,Description="WFL;"})
		else--not using RotE...
			print("Preparing Actions cards for base game...")
			--remove all RotE Action Cards...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelStartingAction").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Description="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialStartingAction").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Description="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Description="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Description="RotE;"})
      		--remove RotE rings...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=IDs.Rebel.RingBag,ToBagID=IDs.WFLBox,Description="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=IDs.Imperial.RingBag,ToBagID=IDs.WFLBox,Description="RotE;"})
			--remove all WFL Action Cards...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelStartingAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialStartingAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialAction").getGUID(),ToBagID=IDs.WFLBox,Tag="Card",Description="WFL;"})
			--remove WFL rings...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=IDs.Rebel.RingBag,ToBagID=IDs.WFLBox,Description="WFL;"})
		    coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=IDs.Imperial.RingBag,ToBagID=IDs.WFLBox,Description="WFL;"})
		end--if
		coroutine.yield(0)
		--shuffle action decks...
		GetDeck("RebelAction").shuffle()
		GetDeck("RebelStartingAction").shuffle()
		GetDeck("ImperialAction").shuffle()
		GetDeck("ImperialStartingAction").shuffle()
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		--advance to next step...
		NextStep = "Setup.6.PrepareTacticDecksMarkersAndDice.1"
		Step = ""
	elseif Step == "Setup.6.PrepareTacticDecksMarkersAndDice.1" then
		--RotE?
		if Game.Flags.RotE then
			--prompt for house rule to use base game tactic cards....
			ChooseTacticDeckMenu()
		else
			--advance to next step...
			NextStep = "Setup.6.PrepareTacticDecksMarkersAndDice.2"
			Step = ""
		end--if
	elseif Step == "Setup.6.PrepareTacticDecksMarkersAndDice.2" then
		PleaseWait({Panel=SetupPanel,Text="Preparing Tactic Deck..."})
		--play with Advanced Tactics?...
		if Game.Flags.AdvancedTactics then
			--remove base game Tactics Decks...
			coroutine.yield(0)
			getObjectFromGUID(IDs.GameBox).putObject(GetDeck("SpaceTactic")) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.GameBox).putObject(GetDeck("GroundTactic")) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.GameBox).putObject(getObjectFromGUID(Decks.SpaceTactic.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.GameBox).putObject(getObjectFromGUID(Decks.GroundTactic.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.GameBox).putObject(getObjectFromGUID(Decks.SpaceTacticDiscard.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.GameBox).putObject(getObjectFromGUID(Decks.GroundTacticDiscard.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			coroutine.yield(0)
			--remove Wider Front Lines Advanced tactics if not playing that expansion... 
			if not Game.Flags.WFL then
				for O,Obj in pairs(getAllObjects()) do 
					if Obj.type == "Card" then
						if Obj.getDescription() == nil then Obj.setDescription("")  end--if
						if string.find(Obj.getDescription(),"AdvancedTacticCard;") != nil then
							if string.find(Obj.getDescription(),"WFL;") != nil then
								getObjectFromGUID(IDs.WFLBox).putObject(Obj)
								--coroutine.yield(0)
							end--if
						end--if
					end--if
				end--for O,Obj 
			end--if
		else
			--remove Advanced Tactics Decks...
			coroutine.yield(0)
			getObjectFromGUID(IDs.RotEBox).putObject(getObjectFromGUID(Decks.RebelAdvancedSpaceTacticDiscard.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.RotEBox).putObject(getObjectFromGUID(Decks.RebelAdvancedGroundTacticDiscard.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.RotEBox).putObject(getObjectFromGUID(Decks.ImperialAdvancedSpaceTacticDiscard.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			getObjectFromGUID(IDs.RotEBox).putObject(getObjectFromGUID(Decks.ImperialAdvancedGroundTacticDiscard.PadID)) for D=1,5 do coroutine.yield(0) end--for D
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.type == "Card" then
					if Obj.getDescription() == nil then Obj.setDescription("")  end--if
					if string.find(Obj.getDescription(),"AdvancedTacticCard;") != nil then
						if string.find(Obj.getDescription(),"WFL;") != nil then
							getObjectFromGUID(IDs.WFLBox).putObject(Obj)
							--coroutine.yield(0) 
						else
							getObjectFromGUID(IDs.RotEBox).putObject(Obj)
							--coroutine.yield(0) 
						end--if
					end--if
				end--if
			end--for O,Obj 
			for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
			--prepare base Tactic Decks...
			GetDeck("SpaceTactic").shuffle()
			GetDeck("GroundTactic").shuffle()
		end--if
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		--advance to next step...
		NextStep = "Setup.7.PrepareMissionCards.1"
		Step = ""
	elseif Step == "Setup.7.PrepareMissionCards.1" then
		--WFL?
		if Game.Flags.WFL then
			--prompt for house rule to use big galactic mission deck or standard mission deck....
			ChooseMissionDeckTypeMenu()
		else
			--advance to next step...
			Game.Flags.GSDeck = false	--make sure this flag is false.
			NextStep = "Setup.7.PrepareMissionCards.2"
			Step = ""
		end--if
	elseif Step == "Setup.7.PrepareMissionCards.2" then
		PleaseWait({Panel=SetupPanel,Text="Preparing Mission Decks..."})
		if Game.Flags.GSDeck then
			--remove mission cards replaced by WFL versions.
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="INFILTRATION",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="HIDDEN FLEET",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="PREPARE FOR BATTLE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="ROGUE SQUADRON RAID",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SEEK YODA",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SUPPORT OF THE MON CALAMARI",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="DARING RESCUE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="HIT AND RUN",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="INCITE REBELLION",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="RECONNAISSANCE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="ASSAULT",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Name="DISCREDIT REBELLION",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Name="MAKE AN EXAMPLE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="INTERROGATION",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SECRET WEAPONS RESEARCH",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="CONSTRUCT DEATH STAR",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SUPERLASER ONLINE",ExcludeDescription="WFL;"})
			coroutine.yield(0)
			--remove mission cards replaced by RotE versions...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SABOTAGE",ExcludeDescription="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="CONSTRUCT SUPER STAR DESTROYER",ExcludeDescription="RotE;"})
			coroutine.yield(0)
			--advance to next step...
			NextStep = "Setup.7.III.BuildMissionDecks"
			Step = ""
		elseif Game.Flags.WFL then
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="GSIcon;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="GSIcon;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="GSIcon;"})
			--playing WFL without the GS deck: only 4 starting missions, so remove GS starting missions...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="HIDDEN FLEET",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="INTERROGATION",Description="WFL;"})
			--some mission cards replaced by WFL versions...
			--MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="INFILTRATION",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="PREPARE FOR BATTLE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="ROGUE SQUADRON RAID",ExcludeDescription="WFL;"})
			--MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SEEK YODA",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SUPPORT OF THE MON CALAMARI",ExcludeDescription="WFL;"})
			--MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Name="DISCREDIT REBELLION",ExcludeDescription="WFL;"})
			--MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.RotEBox,Tag="Card",Name="MAKE AN EXAMPLE",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SECRET WEAPONS RESEARCH",ExcludeDescription="WFL;"})
			--MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="CONSTRUCT DEATH STAR",ExcludeDescription="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SUPERLASER ONLINE",ExcludeDescription="WFL;"})
			--only remove 1 of these duplicate copies (there's only 1 replacement, but need to keep duplicates)...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="DARING RESCUE",ExcludeDescription="WFL;",Limit=1})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="HIT AND RUN",ExcludeDescription="WFL;",Limit=1})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="INCITE REBELLION",ExcludeDescription="WFL;",Limit=1})
			--MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="RECONNAISSANCE",ExcludeDescription="WFL;",Limit=1})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="ASSAULT",ExcludeDescription="WFL;",Limit=1})
			coroutine.yield(0)
			--remove mission cards replaced by RotE versions...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SABOTAGE",ExcludeDescription="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="CONSTRUCT SUPER STAR DESTROYER",ExcludeDescription="RotE;"})
			coroutine.yield(0)
			--Rebels secretly choose Deck...
			NextStep = "Setup.7.I.RebelMissionDeckChoice"
			Step = ""
		elseif Game.Flags.RotE then
			--remove all WFL mission cards...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0)
			--remove mission cards replaced by RotE versions...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="SABOTAGE",ExcludeDescription="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name="CONSTRUCT SUPER STAR DESTROYER",ExcludeDescription="RotE;"})
			coroutine.yield(0)
			--Rebels secretly choose Deck...
			NextStep = "Setup.7.I.RebelMissionDeckChoice"
			Step = ""
		else --no expansion...
			Game.DeckChoice.Rebel = "Base"
			Game.DeckChoice.Imperial = "Base"
			--remove all RotE mission cards...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="RotE;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="RotE;"})
			coroutine.yield(0)
			--remove all WFL mission cards...
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0) MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialProject").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Description="WFL;"})
			coroutine.yield(0)
			--advance to next step (skipping deck choice step)...
			NextStep = "Setup.7.III.BuildMissionDecks"
			Step = ""
		end--if
		for D=1,10 do coroutine.yield(0) end--for D (delay 10 frames)
	elseif Step == "Setup.7.I.RebelMissionDeckChoice" then
		printToAll("Rebel Player is choosing a Mission Deck...")
		--prompt for type of setup (expansion?)...
		RebelMissionDeckChoiceMenu()
	elseif Step == "Setup.7.II.ImperialMissionDeckChoice" then
		printToAll("Imperial Player is choosing a Mission Deck...")
		--prompt for type of setup (expansion?)...
		ImperialMissionDeckChoiceMenu()
	elseif Step == "Setup.7.III.BuildMissionDecks" then
		if Player.White.seated then Player.White.blindfolded = false end--if
		if Player.Red.seated then Player.Red.blindfolded = false end--if
		PleaseWait({Panel=SetupPanel,Text="Building Mission Decks..."})
		--announce choices... 
		printToAll("\nRebels are using the "..Game.DeckChoice.Rebel.." mission deck.",{1,1,0})
		printToAll("Imperials are using the "..Game.DeckChoice.Imperial.." mission deck.\n",{1,1,0})
		--restore game panel to default location...
		SetupPanel.setPositionSmooth(PanelSpots.Default.Position,false,false)
		SetupPanel.setRotationSmooth(PanelSpots.Default.Rotation,false,false)
		SetupPanel.setScale(PanelSpots.Default.Scale)
		SetupPanel.setColorTint({1,1,1,1})
		--build mission decks and draw starting missions...
		local CardItem = mil
		--loop through Rebel Mission Deck...
		for _,CardItem in pairs(GetDeck("RebelMission").getObjects()) do
			--starting mission?
			if string.find(CardItem.description,"Starting;") != nil then
				--draw starting missions to hand...
				local Card = GetDeck("RebelMission").takeObject({guid=CardItem.guid,smooth=true,position=Hands.RebelMission.DrawSpot,rotation={0,0,180}})
				coroutine.yield(0)
				Card.setPosition(Hands.RebelMission.DrawSpot)
				Card.setRotation(Hands.RebelMission.Rotation)
			elseif string.find(CardItem.description,"Leader:") == nil then
				--it's not a leader mission, so see if we need to remove the card...
				if (Game.DeckChoice.Rebel == "RotE" and string.find(CardItem.description,"VaderIcon;") == nil) or (Game.DeckChoice.Rebel == "Base" and string.find(CardItem.description,"VaderIcon;") != nil) then
					--remove all copies of this card...
					MoveObjectsFromBagToBag({FromBagID=GetDeck("RebelMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",ID=CardItem.guid})
				end--if
			end--if
		end--for
		--loop through Imperial Mission Deck...
		for _,CardItem in pairs(GetDeck("ImperialMission").getObjects()) do
			--starting mission?
			if string.find(CardItem.description,"Starting;") != nil then
				--draw starting missions to hand...
				local Card = GetDeck("ImperialMission").takeObject({guid=CardItem.guid,smooth=true,position=Hands.ImperialMission.DrawSpot,rotation={0,0,180}})
				coroutine.yield(0)
				Card.setPosition(Hands.ImperialMission.DrawSpot)
				Card.setRotation(Hands.ImperialMission.Rotation)
			elseif string.find(CardItem.description,"Leader:") == nil then
				--it's not a leader mission, so see if we need to remove the card...
				if (Game.DeckChoice.Imperial == "RotE" and string.find(CardItem.description,"VaderIcon;") == nil) or (Game.DeckChoice.Imperial == "Base" and string.find(CardItem.description,"VaderIcon;") != nil) then
					--remove all copies of this card...
					MoveObjectsFromBagToBag({FromBagID=GetDeck("ImperialMission").getGUID(),ToBagID=IDs.GameBox,Tag="Card",ID=CardItem.guid})
				end--if
			end--if
		end--for
		--shuffle mission decks...
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		GetDeck("RebelMission").shuffle()
		GetDeck("ImperialMission").shuffle()
		GetDeck("ImperialProject").shuffle()
		for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
		--advance to next step...
		NextStep = "Setup.8.ChooseUnitPaint"
		Step = ""
	elseif Step == "Setup.8.ChooseUnitPaint" then
		ChooseUnitModelsMenu()
	elseif Step == "Setup.8.PlaceStartingUnitsAndLoyalty" then
		--clean up build tiles on table...
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if string.find(Obj.getDescription(),"BuildTile;") != nil or string.find(Obj.getDescription(),"DamageMarker;") != nil then
				Obj.destruct()
			end--if
		end--for O,Obj 
		ChooseSetupTypeMenu()
	elseif Step == "Setup.8.I.DetermineStartingLoyalty" then
    	--game type?
		if Game.Type == "First" then
			PleaseWait({Panel=SetupPanel,Text="  Preparing Starting Loyalty..."})
			--draw first 3 Rebels and 5 Imperial Systems...
			local CardItem = nil
			Game.Systems.Rebel = {"KASHYYYK","BOTHAWUI","NABOO"}
			Game.Systems.Imperial = {"CORELLIA","MANDALORE","SALEUCAMI","SULLUST","MUSTAFAR"}
			printToAll("   Rebels start with Loyalty on: Kashyyyk, Bothawui, and Naboo.")
			SetLoyalty({System="KASHYYYK",Loyalty="Rebel",Subjugated=false,Ping=true})
			SetLoyalty({System="BOTHAWUI",Loyalty="Rebel",Subjugated=false,Ping=true})
			SetLoyalty({System="NABOO",Loyalty="Rebel",Subjugated=false,Ping=true})
			printToAll("   Imperials Start with Subjugation on: Mandalore and Sullust.")
			SetLoyalty({System="MANDALORE",Loyalty="Neutral",Subjugated=true,Ping=true})
			SetLoyalty({System="SULLUST",Loyalty="Neutral",Subjugated=true,Ping=true})
			printToAll("   Imperials Start with Loyalty on: Saleucami, Corellia, Mustafar, and Coruscant.")
			SetLoyalty({System="SALEUCAMI",Loyalty="Imperial",Subjugated=false,Ping=true})
			SetLoyalty({System="CORELLIA",Loyalty="Imperial",Subjugated=false,Ping=true})
			SetLoyalty({System="MUSTAFAR",Loyalty="Imperial",Subjugated=false,Ping=true})
			--remove imperial probe cards and update probe logs...
			for _,CardItem in pairs(GetDeck("Probe").getObjects()) do
				if CardItem.name == "CORELLIA" or CardItem.name == "MANDALORE" or CardItem.name == "SALEUCAMI" or CardItem.name == "SULLUST" or CardItem.name == "MUSTAFAR" then
					printToAll("   Removing "..CardItem.name.." Probe Card from the Game.")
					local CardObj = GetDeck("Probe").takeObject({guid=CardItem.guid,smooth=true,position=Spots.Assignment.Rebel.Revealed[RebelCount],rotation={0,0,0}})
					coroutine.yield(0)
					getObjectFromGUID(IDs.GameBox).putObject(CardObj)
					coroutine.yield(0)
					--local PC = getObjectFromGUID(IDs.Imperial.ProbeLogBag).takeObject({smooth=true,position=Locations[CardItem.name].LogSpot,rotation={0,90,0}})
					--PC.setName("Started Imperial")
					UpdateImperialProbeMap(CardItem.name,1)
					local PC = getObjectFromGUID(IDs.Rebel.ProbeLogBag).takeObject({smooth=true,position={Locations[CardItem.name].LogSpot[1],Locations[CardItem.name].LogSpot[2],Locations[CardItem.name].LogSpot[3]+28},rotation={0,90,0}})
					PC.setName("Started Imperial")
					coroutine.yield(0)
				end--if
			end--for
			--reshuffle,pause...
			GetDeck("Probe").shuffle()
			for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
			--first game setup always uses the base setup (cannot be RotE setup).
			Game.Flags.UnitPlacement = "Base"
			--advance to next step...
			NextStep = "Setup.8.II.GatherStartingUnits"
			Step = ""
		elseif Game.Type == "Advanced" then
			PleaseWait({Panel=SetupPanel,Text="  Determining Starting Loyalty..."})
			--shuffle probe deck...
			GetDeck("Probe").shuffle()
			for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
			--draw first 3 Rebels and 5 Imperial Systems...
			local CardItem = nil
			local RebelCount = 0
			local ImperialCount = 0
			local RebelCards = {}
			local ImperialCards = {}
			for _,CardItem in pairs(GetDeck("Probe").getObjects()) do
				if string.find(CardItem.description,"Rebel") != nil and RebelCount < 3 then
					RebelCount = RebelCount + 1
					GetDeck("Probe").takeObject({guid=CardItem.guid,smooth=true,position=Spots.Assignment.Rebel.Revealed[RebelCount],rotation={0,0,0}})
					coroutine.yield(0)
					printToAll("   Rebel Loyal ("..RebelCount.."): "..CardItem.name)
					SetLoyalty({System=CardItem.name,Loyalty="Rebel",Subjugated=false,Ping=true})
					table.insert(RebelCards,CardItem.guid)
					table.insert(Game.Systems.Rebel,CardItem.name)
					for Delay=1,5 do coroutine.yield(0) end--for (delay 30 frames)
				elseif string.find(CardItem.description,"Imperial") != nil and ImperialCount < 5 then
					ImperialCount = ImperialCount + 1
					GetDeck("Probe").takeObject({guid=CardItem.guid,smooth=true,position=Spots.Assignment.Imperial.Revealed[ImperialCount],rotation={0,180,0}})
					coroutine.yield(0)
					table.insert(ImperialCards,CardItem.guid)
					table.insert(Game.Systems.Imperial,CardItem.name)
					Locations[CardItem.name].Scanned = true
					if ImperialCount <= 2 then
						printToAll("   Imperial Subjugated ("..ImperialCount.."): "..CardItem.name)
						SetLoyalty({System=CardItem.name,Loyalty="Neutral",Subjugated=true,Ping=true})
					else
						printToAll("   Imperial Loyal ("..ImperialCount.."): "..CardItem.name)
						SetLoyalty({System=CardItem.name,Loyalty="Imperial",Subjugated=false,Ping=true})
					end--if
					for Delay=1,5 do coroutine.yield(0) end--for (delay a few frames)
					--update imperial probe log...
					--local PC = getObjectFromGUID(IDs.Imperial.ProbeLogBag).takeObject({smooth=true,position=Locations[CardItem.name].LogSpot,rotation={0,90,0}})
					--PC.setName("Started Imperial")
					UpdateImperialProbeMap(CardItem.name,1)
					--update rebel probe log...
					local PC = getObjectFromGUID(IDs.Rebel.ProbeLogBag).takeObject({smooth=true,position={Locations[CardItem.name].LogSpot[1],Locations[CardItem.name].LogSpot[2],Locations[CardItem.name].LogSpot[3]+28},rotation={0,270,0}})
					PC.setName("Started Imperial")
				end--if
				coroutine.yield(0)
			end--for
			--clean up Probe Cards...
			for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
			for C=1,#RebelCards do
				--put card back into the deck...
				printToAll("   Placing "..getObjectFromGUID(RebelCards[C]).getName().." back into the Probe Deck...")
				GetDeck("Probe").putObject(getObjectFromGUID(RebelCards[C]))
			end--for
			--wait for card to disappear back into the deck....
			RepCount = RepCount + 1--track the number of running repeat statements.
			repeat
				coroutine.yield(0)
			until getObjectFromGUID(RebelCards[#RebelCards]) == nil
			RepCount = RepCount - 1--remove this count from the number of running repeat statements.
			for C=1,#ImperialCards do
				--put card in box...
				printToAll("   Placing "..getObjectFromGUID(ImperialCards[C]).getName().." into the Game Box...")
				getObjectFromGUID(IDs.GameBox).putObject(getObjectFromGUID(ImperialCards[C]))
			end--for
			--reshuffle,pause...
			GetDeck("Probe").shuffle()
			for Delay=1,30 do coroutine.yield(0) end--for (delay 30 frames)
			--prompt for unit Placement list if RotE...
			if Game.Flags.RotE then
				ChooseStartingUnitPlacement()
			else	--use base game list...
				Game.Flags.UnitPlacement = "Base"
				--advance to next step...
				NextStep = "Setup.8.II.GatherStartingUnits"
				Step = ""
			end--if
		else--assume custom... 
      Game.Systems.Rebel = {"1st Rebel System","2nd Rebel System","3rd Rebel System"}
      Game.Systems.Imperial = {"1st Imperial System","2nd Imperial System","3rd Imperial System","4th Imperial System","5th Imperial System"}
			--prompt for unit Placement list if RotE...
			if Game.Flags.RotE then
				ChooseStartingUnitPlacement()
			else	--use base game list...
				Game.Flags.UnitPlacement = "Base"
				--advance to next step...
				NextStep = "Setup.8.II.GatherStartingUnits"
				Step = ""
			end--if
		end--if
	elseif Step == "Setup.8.II.GatherStartingUnits" then
		if Game.Type == "First" then
			PleaseWait({Panel=SetupPanel,Text="Placing Imperial Starting Units...",Print=false})
		elseif Game.Type == "Advanced" then
			PleaseWait({Panel=SetupPanel,Text="Place Imperial Starting Units...\n\n(Refer to Imperial Game Panel)",Print=false})
		else 
			PleaseWait({Panel=SetupPanel,Text="Custom Setup:\n\nDetermine Starting System Loyalties\n(Don't forget to remove Imperial Probe Cards)\n\nPlace Imperial Starting Units...\n\n(Refer to Imperial Game Panel)",Print=false})
		end--if
		PleaseWait({Panel=RebelPanel,Text="Waiting for Imperial Player\nto Place Starting Units...",Print=false})
		PleaseWait({Panel=ImperialPanel,Text="Fetching Imperial Starting Units..."})
		coroutine.yield(0)
		--set assumed next step...
		NextStep = "Setup.8.II.PlaceImperialStartingUnits"
		--using RotE Unit Placement List?...
		if Game.Type == "First" then
			PlaceUnit({Unit="Death Star",Position={-8,2,0}})
			coroutine.yield(0)
			PlaceUnit({Unit="TIE Fighter",Position={-9.8,2,0.45}})
			PlaceUnit({Unit="TIE Fighter",Position={-9.3,2,0.45}})
			PlaceUnit({Unit="TIE Fighter",Position={-9.8,2,-0.05}})
			PlaceUnit({Unit="TIE Fighter",Position={-9.3,2,-0.05}})
			coroutine.yield(0)
			PlaceUnit({Unit="Stormtrooper",Position={-7.5,2,-2.5}})
			PlaceUnit({Unit="Stormtrooper",Position={-6.5,2,-2.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="AT-ST",Position={-7,2,-3.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="Star Destroyer",Position={-11.5,2,6.3}})
			coroutine.yield(0)
			PlaceUnit({Unit="TIE Fighter",Position={-10.7,2,7}})
			PlaceUnit({Unit="TIE Fighter",Position={-10,2,7}})
			coroutine.yield(0)
			PlaceUnit({Unit="AT-ST",Position={-9,2,4}})
			coroutine.yield(0)
			PlaceUnit({Unit="Stormtrooper",Position={-9.3,2,5}})
			PlaceUnit({Unit="Stormtrooper",Position={-8.7,2,5}})
			coroutine.yield(0)
			PlaceUnit({Unit="Star Destroyer",Position={0,2,-8.25}})
			coroutine.yield(0)
			PlaceUnit({Unit="Assault Carrier",Position={-1,2,-8.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="TIE Fighter",Position={-1,2,-9.5}})
			PlaceUnit({Unit="TIE Fighter",Position={0,2,-9.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="AT-AT",Position={1,2,-9}})
			PlaceUnit({Unit="AT-ST",Position={2,2,-9}})
			coroutine.yield(0)
			PlaceUnit({Unit="Stormtrooper",Position={1,2,-7.7}})
			PlaceUnit({Unit="Stormtrooper",Position={1.75,2,-7.7}})
			PlaceUnit({Unit="Stormtrooper",Position={2,2,-7.7}})
			coroutine.yield(0)
			PlaceUnit({Unit="Assault Carrier",Position={5,2,-7}})
			coroutine.yield(0)
			PlaceUnit({Unit="Stormtrooper",Position={7,2,-7}})
			coroutine.yield(0)
			PlaceUnit({Unit="Star Destroyer",Position={6,1,-2.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="TIE Fighter",Position={7,2,-3}})
			PlaceUnit({Unit="TIE Fighter",Position={7.5,2,-3}})
			coroutine.yield(0)
			PlaceUnit({Unit="AT-ST",Position={9,2,-4}})
			coroutine.yield(0)
			PlaceUnit({Unit="Stormtrooper",Position={8.5,2,-3}})
			PlaceUnit({Unit="Stormtrooper",Position={9.5,2,-3}})
			coroutine.yield(0)
			PlaceUnit({Unit="Assault Carrier",Position={15,2,-2}})
			coroutine.yield(0)
			PlaceUnit({Unit="TIE Fighter",Position={14.5,2,-3}})
			PlaceUnit({Unit="TIE Fighter",Position={15.5,2,-3}})
			coroutine.yield(0)
			PlaceUnit({Unit="AT-ST",Position={17,2,-1.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="Stormtrooper",Position={16.5,2,-0.5}})
			PlaceUnit({Unit="Stormtrooper",Position={17.5,2,-0.5}})
			coroutine.yield(0)
			--Rebel First Game Units...
			PlaceUnit({Unit="Corellian Corvette",Position={0,1,5.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="Rebel Transport",Position={-0.8,1,5.5}})
			coroutine.yield(0)
			PlaceUnit({Unit="Y-Wing",Position={-0.6,1,4}})
			PlaceUnit({Unit="Y-Wing",Position={-20.30, 0.74, 8.06}})
			coroutine.yield(0)
			PlaceUnit({Unit="X-Wing",Position={0.1,1,4}})
			PlaceUnit({Unit="X-Wing",Position={-21.34, 0.78, 7.93}})
			coroutine.yield(0)
			PlaceUnit({Unit="Airspeeder",Position={1.6,1,6.25}})
			PlaceUnit({Unit="Airspeeder",Position={-20.65, 0.75, 5.86}})
			coroutine.yield(0)
			PlaceUnit({Unit="Rebel Trooper",Position={1,1,7}})
			PlaceUnit({Unit="Rebel Trooper",Position={2,1,7}})
			PlaceUnit({Unit="Rebel Trooper",Position={3,1,7}})
			coroutine.yield(0)
			PlaceUnit({Unit="Rebel Trooper",Position={-20.90, 0.94, 6.34}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.34, 0.94, 6.39}})
			PlaceUnit({Unit="Rebel Trooper",Position={-19.68, 0.94, 6.38}})
			coroutine.yield(0)
			NextStep = "Setup.9.ChooseBaseLocation"
		elseif Game.Flags.UnitPlacement == "RotE" then
			--imperial RotE Units...
			PlaceUnit({Unit="Death Star",Position={20.55,1.48,-3.00}})
			PlaceUnit({Unit="Death Star Under Construction",Position={11.00, 1.48, -12.00}})
			PlaceUnit({Unit="Star Destroyer",Position={13,1,-12}})
			PlaceUnit({Unit="Star Destroyer",Position={15,1,-12}})
			PlaceUnit({Unit="Star Destroyer",Position={17,1,-12}})
			PlaceUnit({Unit="Assault Carrier",Position={12,1,-12.5}})
			PlaceUnit({Unit="Assault Carrier",Position={14,1,-12.5}})
			PlaceUnit({Unit="Assault Carrier",Position={16,1,-12.5}})
			PlaceUnit({Unit="TIE Striker",Position={13,1,-13.25}})
			PlaceUnit({Unit="TIE Striker",Position={17,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={10.8,1,-13}})
			PlaceUnit({Unit="TIE Fighter",Position={11.3,1,-13}})
			PlaceUnit({Unit="TIE Fighter",Position={10.8,1,-13.5}})
			PlaceUnit({Unit="TIE Fighter",Position={11.3,1,-13.5}})
			PlaceUnit({Unit="TIE Fighter",Position={12.5,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={13.5,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={16.5,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={17.5,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={14.25,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={14.75,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={15.25,1,-13.25}})
			PlaceUnit({Unit="TIE Fighter",Position={15.75,1,-13.25}})
			PlaceUnit({Unit="AT-AT",Position={15,1.5,-14.25}})
			PlaceUnit({Unit="AT-ST",Position={13.5,1.5,-14}})
			PlaceUnit({Unit="AT-ST",Position={14.25,1.5,-14}})
			PlaceUnit({Unit="AT-ST",Position={15.75,1.5,-14}})
			PlaceUnit({Unit="AT-ST",Position={16.5,1.5,-14}})
			PlaceUnit({Unit="Assault Tank",Position={12.75,1,-14}})
			PlaceUnit({Unit="Assault Tank",Position={17.25,1,-14}})
			PlaceUnit({Unit="Stormtrooper",Position={11.00,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={12.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={12.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={13.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={13.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={14.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={14.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={15.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={16.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={16.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={17.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={17.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={18.0,1,-15}})
			--Rebel RotE Units...
			PlaceUnit({Unit="Corellian Corvette",Position={-18.77, 0.81, 7.76}})
			PlaceUnit({Unit="Rebel Transport",Position={-19.24, 0.78, 7.97}})
			PlaceUnit({Unit="U-Wing",Position={-19.81, 0.74, 8.04}})
			PlaceUnit({Unit="Y-Wing",Position={-20.30, 0.74, 8.06}})
			PlaceUnit({Unit="X-Wing",Position={-20.85, 0.78, 8.04}})
			PlaceUnit({Unit="Airspeeder",Position={-20.14, 0.75, 5.88}})
			PlaceUnit({Unit="Airspeeder",Position={-20.65, 0.75, 5.86}})
			PlaceUnit({Unit="Rebel Vanguard",Position={-19.68, 0.94, 6.38}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.35, 0.94, 7.00}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.90, 0.94, 6.34}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.34, 0.94, 6.39}})
			PlaceUnit({Unit="Rebel Trooper",Position={-19.73, 0.94, 7.04}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.88, 0.94, 7.01}})
		else --Base Game Imperial Unit Placement...
			PlaceUnit({Unit="Death Star",Position={11.00, 1.48, -12.00}})
			PlaceUnit({Unit="Star Destroyer",Position={13,1,-12}})
			PlaceUnit({Unit="Star Destroyer",Position={15,1,-12}})
			PlaceUnit({Unit="Star Destroyer",Position={17,1,-12}})
			PlaceUnit({Unit="Assault Carrier",Position={12,1,-12.5}})
			PlaceUnit({Unit="Assault Carrier",Position={14,1,-12.5}})
			PlaceUnit({Unit="Assault Carrier",Position={16,1,-12.5}})
			PlaceUnit({Unit="TIE Fighter",Position={12.75, 0.85, -13}})
			PlaceUnit({Unit="TIE Fighter",Position={12.75, 0.85, -13.5}})
			PlaceUnit({Unit="TIE Fighter",Position={13.25, 0.85, -13}})
			PlaceUnit({Unit="TIE Fighter",Position={13.25, 0.85, -13.5}})
			PlaceUnit({Unit="TIE Fighter",Position={14.75, 0.85, -13}})
			PlaceUnit({Unit="TIE Fighter",Position={14.75, 0.85, -13.5}})
			PlaceUnit({Unit="TIE Fighter",Position={15.25, 0.85, -13}})
			PlaceUnit({Unit="TIE Fighter",Position={15.25, 0.85, -13.5}})
			PlaceUnit({Unit="TIE Fighter",Position={16.75, 0.85, -13}})
			PlaceUnit({Unit="TIE Fighter",Position={16.75, 0.85, -13.5}})
			PlaceUnit({Unit="TIE Fighter",Position={17.25, 0.85, -13}})
			PlaceUnit({Unit="TIE Fighter",Position={17.25, 0.85, -13.5}})
			PlaceUnit({Unit="AT-AT",Position={14,1.5,-14}})
			PlaceUnit({Unit="AT-ST",Position={13.00,1.5,-14.25}})
			PlaceUnit({Unit="AT-ST",Position={14.75,1.5,-14.25}})
			PlaceUnit({Unit="AT-ST",Position={15.25,1.5,-14.25}})
			PlaceUnit({Unit="AT-ST",Position={16.75,1.5,-14.25}})
			PlaceUnit({Unit="AT-ST",Position={17.25,1.5,-14.25}})
			PlaceUnit({Unit="Stormtrooper",Position={10.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={11.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={11.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={12.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={13.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={13.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={14.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={15.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={15.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={16.5,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={17.0,1,-15}})
			PlaceUnit({Unit="Stormtrooper",Position={17.5,1,-15}})
			--Rebel Base Units...
			PlaceUnit({Unit="Corellian Corvette",Position={-18.77, 0.81, 7.76}})
			PlaceUnit({Unit="Rebel Transport",Position={-19.24, 0.78, 7.97}})
			PlaceUnit({Unit="Y-Wing",Position={-19.81, 0.74, 8.04}})
			PlaceUnit({Unit="Y-Wing",Position={-20.30, 0.74, 8.06}})
			PlaceUnit({Unit="X-Wing",Position={-20.85, 0.78, 8.04}})
			PlaceUnit({Unit="X-Wing",Position={-21.34, 0.78, 7.93}})
			PlaceUnit({Unit="Airspeeder",Position={-20.14, 0.75, 5.88}})
			PlaceUnit({Unit="Airspeeder",Position={-20.65, 0.75, 5.86}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.88, 0.94, 7.01}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.35, 0.94, 7.00}})
			PlaceUnit({Unit="Rebel Trooper",Position={-19.73, 0.94, 7.04}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.90, 0.94, 6.34}})
			PlaceUnit({Unit="Rebel Trooper",Position={-20.34, 0.94, 6.39}})
			PlaceUnit({Unit="Rebel Trooper",Position={-19.68, 0.94, 6.38}})
		end--if
		for D=1,20 do coroutine.yield(0) end--for D
    --remove all cached unit objects...
		--for O,Obj in pairs(getAllObjects()) do 
			--if Obj.getDescription() == "CachedObject;" then
				--if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
				--if string.find(Obj.getGMNotes(),"OriginalUnit;") != nil or string.find(Obj.getGMNotes(),"PaintedUnit;") != nil or string.find(Obj.getGMNotes(),"BothUnit;") != nil then
					--Obj.destruct()
				--end--if
			--end--if
		--end--for O,Obj 
		Step = ""
	elseif Step == "Setup.8.II.PlaceImperialStartingUnits" then
		if Player.Blue.seated then Player.Blue.lookAt(CameraViews.ImperialPanel) end--if
		if Player.Orange.seated then Player.Orange.lookAt(CameraViews.ImperialPanel) end--if
		if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.ImperialPanel) end--if
			Ping({Position={14,1,-14}})
		ImperialStartingUnitPlacement()
	elseif Step == "Setup.8.II.ValidateImperialStartingUnits" then
		--validate imperial starting units...
		local ErrorText = ""  --a more detailed error message.
		local UnitCount = 0	--reusable unit counter.
		--VALIDATE: Imperial Ground Unit in each imperial System (including CORUSCANT)...
		if GetUnitCount({Location="CORUSCANT",Theater="Ground",Faction="Imperial"}) == 0 then
			ErrorText = ErrorText.."\n* CORUSCANT does not have an Imperial Ground Unit."
		end--if
		for S = 1,#Game.Systems.Imperial do
			if GetUnitCount({Location=Game.Systems.Imperial[S],Theater="Ground",Faction="Imperial"}) == 0 then
				ErrorText = ErrorText.."\n* "..Game.Systems.Imperial[S].." does not have an Imperial Ground Unit."
			end--if
		end--for (S)
		--VALIDATE: RotE Setup...
		if Game.Flags.UnitPlacement == "RotE" then
			--VALIDATE: RotE: Check DSUC Remote system with 1 Stormtooper + 4 TIEs, and Deathstar in queue 3...
			Game.Systems.DSUC = ""	--location of death star under construction.
			for O,Obj in pairs(getAllObjects()) do
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--DSUC Unit?
				if Obj.getVar("Component") == "Unit" and Obj.getName() == "Death Star Under Construction" then
					--get its location...
					Game.Systems.DSUC = ReadTag({Text=Obj.getGMNotes(),Tag="Location",Default=""})
					--is DSUC in a remote system?
					if Game.Systems.DSUC == "" then
						ErrorText = ErrorText.."\n* DSUC is not in a Remote System."
					elseif Locations[Game.Systems.DSUC].Subtype != "Remote" then
						ErrorText = ErrorText.."\n* DSUC is not in a Remote System."
					else--DSUC is ok, how about the stormtrooper and 4 TIEs?
						if GetUnitCount({Location=Game.Systems.DSUC,Unit="Stormtrooper"}) == 0 then
							ErrorText = ErrorText.."\n* DSUC Remote System must have a Stormtrooper."
						end--if
						if GetUnitCount({Location=Game.Systems.DSUC,Unit="TIE Fighter"}) < 4 then
							ErrorText = ErrorText.."\n* DSUC Remote System must have 4 TIE Fighters."
						end--if
					end--if
				elseif Obj.getVar("Component") == "Unit" and Obj.getName() == "Death Star" then
					if GetUnitCount({Location="IMPERIAL QUEUE 3",Unit="Death Star"}) == 0 then
						ErrorText = ErrorText.."\n* Death Star must be in Imperial Queue 3."
					end--if
				end--if
			end--for
			--VALIDATE: RotE Unit Totals: 2 TS, 13 ST, 4 ATST, 2 AT)
			UnitCount = GetUnitCount({Unit="TIE Striker",SystemType="Imperial"})
			if UnitCount != 2 then ErrorText = ErrorText.."\n* "..UnitCount.." TIE Strikers deployed (should be 2)." end--if
			UnitCount = GetUnitCount({Unit="Stormtrooper",SystemType="Imperial"})
			if UnitCount != 13 then ErrorText = ErrorText.."\n* "..UnitCount.." Stormtroopers deployed (should be 13)." end--if
			UnitCount = GetUnitCount({Unit="Assault Tank",SystemType="Imperial"})
			if UnitCount != 2 then ErrorText = ErrorText.."\n* "..UnitCount.." Assault Tanks deployed (should be 2)." end--if
			UnitCount = GetUnitCount({Unit="AT-ST",SystemType="Imperial"})
			if UnitCount != 4 then ErrorText = ErrorText.."\n* "..UnitCount.." AT-STs deployed (should be 4)." end--if
		else--Base Game...
			--VALIDATE: Base Unit Totals: 1 DS, 5 AT-STs, 12 ST
			UnitCount = GetUnitCount({Unit="Death Star",SystemType="Imperial"})
			if UnitCount != 1 then ErrorText = ErrorText.."\n* "..UnitCount.." Death Stars deployed (should be 1)." end--if
			UnitCount = GetUnitCount({Unit="Stormtrooper",SystemType="Imperial"})
			if UnitCount != 12 then ErrorText = ErrorText.."\n* "..UnitCount.." Stormtroopers deployed (should be 12)." end--if
			UnitCount = GetUnitCount({Unit="AT-ST",SystemType="Imperial"})
			if UnitCount != 5 then ErrorText = ErrorText.."\n* "..UnitCount.." AT-STs deployed (should be 5)." end--if
		end--if
		--VALIDATE: Unit Totals: 12 TF, 3 AC, 3 SD, 1 ATAT
		UnitCount = GetUnitCount({Unit="TIE Fighter",SystemType="Imperial"})
		if UnitCount != 12 then ErrorText = ErrorText.."\n* "..UnitCount.." TIE Fighters deployed (should be 12)." end--if
		UnitCount = GetUnitCount({Unit="Assault Carrier",SystemType="Imperial"})
		if UnitCount != 3 then ErrorText = ErrorText.."\n* "..UnitCount.." Assault Carriers deployed (should be 3)." end--if
		UnitCount = GetUnitCount({Unit="Star Destroyer",SystemType="Imperial"})
		if UnitCount != 3 then ErrorText = ErrorText.."\n* "..UnitCount.." Star Destroyers deployed (should be 3)." end--if
		UnitCount = GetUnitCount({Unit="AT-AT",SystemType="Imperial"})
		if UnitCount != 1 then ErrorText = ErrorText.."\n* "..UnitCount.." AT-ATs deployed (should be 1)." end--if
		--any errors?
		if ErrorText == "" then
			--no issues detected.
			NextStep = "Setup.8.III.PlaceRebelStartingUnits"
			Step = ""
		else --one or more issues were detected with the imperial starting unit placement...
			printToAll(ErrorText,{1,1,0})
			ImperialStartingUnitPlacementValidation({ErrorText=ErrorText})
		end--if
	elseif Step == "Setup.8.III.PlaceRebelStartingUnits" then
		if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) end--if
		if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) end--if
		if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel) end--if
			Ping({Position={-20.35,1,6.4}})
		--remove DSUC remote system probe cards if applicable...
		if Game.Systems.DSUC != "" then
			--make sure it's a remote system...
			if Locations[Game.Systems.DSUC].Subtype == "Remote" then
				printToAll("Removing the "..Game.Systems.DSUC.." Probe Card from the game...")
				MoveObjectsFromBagToBag({FromBagID=GetDeck("Probe").getGUID(),ToBagID=IDs.GameBox,Tag="Card",Name=Game.Systems.DSUC})
				Locations[Game.Systems.DSUC].Scanned = true
				--update imperial probe log...
				--local PC = getObjectFromGUID(IDs.Imperial.ProbeLogBag).takeObject({smooth=true,position=Locations[Game.Systems.DSUC].LogSpot,rotation={0,90,0}})
				--PC.setName("Started Imperial")
				UpdateImperialProbeMap(Game.Systems.DSUC,1)
				--update rebel probe log...
				local PC = getObjectFromGUID(IDs.Rebel.ProbeLogBag).takeObject({smooth=true,position={Locations[Game.Systems.DSUC].LogSpot[1],Locations[Game.Systems.DSUC].LogSpot[2],Locations[Game.Systems.DSUC].LogSpot[3]+28},rotation={0,270,0}})
				PC.setName("Started Imperial")
		else
				printToAll("Note: The Death Star Under Construction was not in a Remote System, so the Probe card was not removed.")
			end--if
		end--if
		PleaseWait({Panel=SetupPanel,Text="  Placing Rebel Starting Units..."})
		PleaseWait({Panel=ImperialPanel,Text="Waiting for Rebel Player\nto Place Starting Units..."})
		if Game.Flags.UnitPlacement == "RotE" then
		else --Base Game Rebel Unit Placement...
		end--if
		--Rebel Unit Placement Menu...
		RebelStartingUnitPlacement()
	elseif Step == "Setup.8.III.ValidateRebelStartingUnits" then
		--validate Rebel starting units...
		local ErrorText = ""
		local ErrorImperialSystem = false	--rebel unit found in an imperial system.
		local ErrorImperialUnits = false	--rebel unit found with imperial units.
		local ErrorOutsideSystem = false	--rebel unit found outside a system or the rebel base. 
		local SystemsCount = {}
		local UnitsCount = {}
		if Game.Flags.UnitPlacement == "Rote" then
			UnitsCount = {RT=5,RV=1,AS=2,GAT=0,IC=0,SG=0,XW=1,YW=1,GR75=1,UW=1,CC=1,NBF=0,MCC=0}
		else--assume base game... 
			UnitsCount = {RT=6,RV=0,AS=2,GAT=0,IC=0,SG=0,XW=2,YW=2,GR75=1,UW=0,CC=1,NBF=0,MCC=0}
		end--if
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getVar("Component") == "Unit" and Obj.getVar("Faction") == "Rebel" then
				if Locations[Obj.getVar("Location")] != nil then
					if Locations[Obj.getVar("Location")].Loyalty == "Imperial" or Locations[Obj.getVar("Location")].Subjugated then
						ErrorImperialSystem = true
						Ping({Position=Obj.getPosition()})
					elseif Locations[Obj.getVar("Location")].Units.Imperial.Space + Locations[Obj.getVar("Location")].Units.Imperial.Ground > 0 then
						ErrorImperialUnits = true
						Ping({Position=Obj.getPosition()})
					elseif Locations[Obj.getVar("Location")].Type != "System" and Locations[Obj.getVar("Location")].Type != "Base" then
						ErrorOutsideSystem = true
						Ping({Position=Obj.getPosition()})
					elseif Locations[Obj.getVar("Location")].Type == "System" then
						local Found = false 
						for S=1,#SystemsCount do
							if SystemsCount[S] == Obj.getVar("Location") then
								Found = true
								break
							end--if
						end--for S
						if not Found then
							table.insert(SystemsCount,Obj.getVar("Location"))
						end--if
					end--if
				end--if
			end--if
		end--for O,Obj 
		--check error flags... 
		if #SystemsCount > 1 then
			ErrorText = ErrorText.."\nRebels detected in more than 1 System."
			for S = 1,#SystemsCount do
				if Locations[SystemsCount[S]] != nil then
					if Locations[SystemsCount[S]].MarkerSpot != nil then
						Ping({Position=Locations[SystemsCount[S]].MarkerSpot})
					end--if
				end--if
			end--for S
		end--if
		if ErrorImperialSystem then
			ErrorText = ErrorText.."\nRebels detected in an Imperial System."
		elseif ErrorImperialUnits then
			ErrorText = ErrorText.."\nRebels detected in a System with Imperial Units."
		end--if
		if ErrorOutsideSystem then
			ErrorText = ErrorText.."\nRebels detected outside a system or the Rebel Base."
		end--if
		if ErrorText == "" then
			--no issues detected.
			printToAll("Rebel Starting Unit Placement appears Valid.")
			NextStep = "Setup.8.IV.DrawStartingActionCards"
			Step = ""
		else --one or more issues were detected with the Rebel starting unit placement...
			printToAll(ErrorText,{1,1,0})
			RebelStartingUnitPlacementValidation({ErrorText=ErrorText})
		end--if
	elseif Step == "Setup.8.IV.DrawStartingActionCards" then
		PleaseWait({Panel=SetupPanel,Text="  Drawing Starting Action Cards..."})
		PleaseWait({Panel=ImperialPanel,Text="Drawing Starting\nAction Cards..."})
		PleaseWait({Panel=RebelPanel,Text="Drawing Starting\nAction Cards..."})
		--draw starting action cards to action hand...
		DealToHand({Deck="RebelStartingAction",Player="White",Index=Hands.RebelAction.Index,Qty=2,Flip=true})
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat 
			coroutine.yield(0) 
			TimeOut = TimeOut - 1
		until not Game.Flags.Dealing or TimeOut <= 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
		DealToHand({Deck="ImperialStartingAction",Player="Blue",Index=Hands.ImperialAction.Index,Qty=2,Flip=true})
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat 
			coroutine.yield(0) 
			TimeOut = TimeOut - 1
		until not Game.Flags.Dealing or TimeOut <= 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
		--wait for cards to deal to hands...
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat
			coroutine.yield(0)
			TimeOut = TimeOut - 1
		until #Player["White"].getHandObjects(Hands.RebelAction.Index) == 2 and #Player["Blue"].getHandObjects(Hands.ImperialAction.Index) == 2 and TimeOut > 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
		Game.Flags.Immediate.Action.Rebel = false
		Game.Flags.Immediate.Action.Imperial = false
		--advance to next step...
		NextStep = "Setup.8.IV.ResolveStartingActionCards"
		Step = ""
	elseif Step == "Setup.8.IV.ResolveStartingActionCards" then
		--repeat this step until there are no immediate action cards to be resolved...
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat 
			coroutine.yield(0) 
			TimeOut = TimeOut - 1
		until not Game.Flags.Dealing or TimeOut <= 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
		--any immediate action cards?
		for O,Obj in pairs(Player["White"].getHandObjects(Hands.RebelAction.Index)) do
			if Obj.getName() == "REBEL EXTREMIST" and not Game.Flags.Immediate.Action.Rebel then
				Game.Flags.Immediate.Action.Rebel = true
				if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) end--if
				if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) end--if
				if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel) end--if
				local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Rebel,Description="ActionCard;"})
				Obj.setPosition(CardSpot)
				Obj.setRotation({0,0,0})
				ResolveRebelExtremist({CardObj=Obj})
				coroutine.yield(0)
				Ping({Position=CardSpot})
				break
			elseif Obj.getName() == "HELP ME OBI-WAN KENOBI" and not Game.Flags.Immediate.Action.Rebel then
				Game.Flags.Immediate.Action.Rebel = true
				if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) end--if
				if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) end--if
				if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel) end--if
				local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Rebel,Description="ActionCard;"})
				Obj.setPosition(CardSpot)
				Obj.setRotation({0,0,0})
				ResolveHelpMeObiWanKenobi({CardObj=Obj})
				coroutine.yield(0)
				Ping({Position=CardSpot})
				break
			elseif Obj.getName() == "HUMAN-CYBORG RELATIONS" then
				local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Rebel,Description="ActionCard;"})
				Obj.setPosition(CardSpot)
				Obj.setRotation({0,0,0})
				LeaderFetchRing({Name="C-3P0",BagID=IDs.Rebel.RingBag,Smooth=true,Position={CardSpot[1],0.7,14.3},Rotation={0,0,0}})
				coroutine.yield(0)
				Ping({Position=CardSpot})
				Ping({Position={CardSpot[1],0.7,14.3}})
			elseif Obj.getName() == "RESOURCEFUL ASTROMECH" then
				local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Rebel,Description="ActionCard;"})
				Obj.setPosition(CardSpot)
				Obj.setRotation({0,0,0})
				LeaderFetchRing({Name="R2-D2",BagID=IDs.Rebel.RingBag,Smooth=true,Position={CardSpot[1],0.7,14.3},Rotation={0,0,0}})
				coroutine.yield(0)
				Ping({Position=CardSpot})
				Ping({Position={CardSpot[1],0.7,14.3}})
			end--if
		end--for
		for O,Obj in pairs(Player["Blue"].getHandObjects(Hands.ImperialAction.Index)) do
			if Obj.getName() == "EARLY PROMOTION" and not Game.Flags.Immediate.Action.Imperial then
				Game.Flags.Immediate.Action.Imperial = true
				if Player.Blue.seated then Player.Blue.lookAt(CameraViews.ImperialPanel) end--if
				if Player.Orange.seated then Player.Orange.lookAt(CameraViews.ImperialPanel) end--if
				if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.ImperialPanel) end--if
				Obj.setPosition(GetFirstOpenSpot({Spots=Spots.Action.Imperial,Description="ActionCard;"}))
				Obj.setRotation({0,180,0})
				GetLeader({Name="Admiral Motti",Smooth=true,Position={0,0.7,-24.5},Rotation={0,180,0}})
				ResolveEarlyPromotion({CardObj=Obj})
				coroutine.yield(0)
				Ping({Position=Spots.Action.Imperial[O]})
			elseif Obj.getName() == "ELITE GUARD" then
				local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Imperial,Description="ActionCard;"})
				Obj.setPosition(CardSpot)
				Obj.setRotation({0,180,0})
				LeaderFetchRing({Name="Elite Guard",BagID=IDs.Imperial.RingBag,Smooth=true,Position={CardSpot[1],0.7,-14.3},Rotation={0,0,0}})
				coroutine.yield(0)
				Ping({Position=CardSpot})
				Ping({Position={CardSpot[1],0.7,-14.3}})
			end--if
		end--for
		if Game.Flags.Immediate.Action.Rebel == false and Game.Flags.Immediate.Action.Imperial == false then
			NextStep = "Setup.9.ChooseBaseLocation"
			Step = ""
		elseif Game.Flags.Immediate.Action.Rebel and not Game.Flags.Immediate.Action.Imperial then
			PleaseWait({Panel=ImperialPanel,Text="Rebel Player is resolving\na Starting Action Card..."})
		elseif Game.Flags.Immediate.Action.Imperial and not Game.Flags.Immediate.Action.Rebel then
			PleaseWait({Panel=RebelPanel,Text="Imperial Player is resolving\na Starting Action Card..."})
		end--if
	elseif Step == "Setup.9.ChooseBaseLocation" then
		--prompt rebels to choose rebel base location...
		PleaseWait({Panel=SetupPanel,Text="Choose Rebel Base Location..."})
		PleaseWait({Panel=ImperialPanel,Text="Rebel Player is choosing a\nsecret Rebel Base location..."})
		ChooseRebelBaseStartingLocation()
	elseif Step == "Setup.10.DrawStartingHand" then
		NextStep = "Setup.10.DrawStartingHand"
		if Game.Flags.GSDeck then--galactic struggle deck mode... 
			if not Game.Flags.MissionHandOK.Imperial and not Game.Flags.MissionHandOK.Rebel then
				printToAll("Shuffling Probe Deck again...")
				GetDeck("Probe").shuffle()
				PleaseWait({Panel=SetupPanel,Text="Galactic Struggle:\nDrawing 3 Mission Cards\nDiscarding 1..."})
				printToAll("\nGalactic Struggle: Draw 3 Missions, Discard 1...")
				startLuaCoroutine(Global,"GalacticStruggleImperialMissionDrawCoroutine")
				startLuaCoroutine(Global,"GalacticStruggleRebelMissionDrawCoroutine")
			end--if
			if Game.Flags.MissionHandOK.Imperial then
				PleaseWait({Panel=ImperialPanel,Text="Waiting for Rebel Player\nto finish drawing Missions..."})
			end
			if Game.Flags.MissionHandOK.Rebel then
				PleaseWait({Panel=RebelPanel,Text="Waiting for Imperial Player\nto finish drawing Missions..."})
			end
			if Game.Flags.MissionHandOK.Imperial and Game.Flags.MissionHandOK.Rebel then
				NextStep = "SetupComplete"
				Step = ""
			end--if
		else--standard mission deck mode... 
			printToAll("Shuffling Probe Deck again...")
			GetDeck("Probe").shuffle()
			PleaseWait({Panel=SetupPanel,Text="Drawing 2 Mission Cards..."})
			PleaseWait({Panel=ImperialPanel,Text="Drawing 2 Mission Cards..."})
			PleaseWait({Panel=RebelPanel,Text="Drawing 2 Mission Cards..."})
			--draw 2 mission cards to mission hands...
			DealToHand({Deck="RebelMission",Player="White",Index=Hands.RebelMission.Index,Qty=2,Flip=true})
			RepCount = RepCount + 1
			local TimeOut = 500
			repeat 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			until not Game.Flags.Dealing or TimeOut <= 0
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			DealToHand({Deck="ImperialMission",Player="Blue",Index=Hands.ImperialMission.Index,Qty=2,Flip=true})
			RepCount = RepCount + 1
			local TimeOut = 500
			repeat 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			until not Game.Flags.Dealing or TimeOut <= 0
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			NextStep = "SetupComplete"
			Step = ""
		end--if
	elseif Step == "SetupComplete" then
		PlaySound({ID=1})--Opening Theme
		--remove starting action decks to box...
		getObjectFromGUID(IDs.GameBox).putObject(GetDeck("RebelStartingAction"))
		getObjectFromGUID(IDs.GameBox).putObject(GetDeck("ImperialStartingAction"))
		--display big start button... 
		SetupCompleteMenu()
		PleaseWait({Panel=ImperialPanel,Text="Setup is Complete."})
		PleaseWait({Panel=RebelPanel,Text="Setup is Complete."})
		Game.Round = 1
	elseif Step == "AssignmentPhase.Start" then
		UpdateBoard(false)
		broadcastToAll("Start of Round: "..Game.Round)
		Game.Phase = "Assignment"
		printToAll("\n========================================\nStarting Round: "..Game.Round.."\n========================================")
		broadcastToAll("ASSIGNMENT PHASE")
		printToAll("========================================")
		--place setup/settings panel in settings/play spot...
		SetupPanel.setPositionSmooth(PanelSpots.Settings.Position,false,false)
		SetupPanel.setRotationSmooth(PanelSpots.Settings.Rotation,false,false)
	  	SetupPanel.setScale(PanelSpots.Settings.Scale)
		SetupPanel.setColorTint({1,1,1,1})
		CombatCheckAllSystems()
		if Game.AI.Active then
			--initialize AI systems data...
			startLuaCoroutine(Global,"AI_InitSystemsCoroutine")
		end--if AI active. 
		NextStep = "AssignmentPhase.RebelAssignments"
		Step = ""
	elseif Step == "AssignmentPhase.RebelAssignments" then
		Game.Turn.Num = 1	--rebel assignment turn.
		PleaseWait({Panel=ImperialPanel,Text="Rebel Player is\nAssigning Missions..."})
		AssignMissions()
		SettingsMenu()
	elseif Step == "AssignmentPhase.ImperialAssignments" then
		Game.Turn.Num = 2 --imperial assignment turn.
		PleaseWait({Panel=RebelPanel,Text="Imperial Player is\nAssigning Missions..."})
		AssignMissions()
		SettingsMenu()
	elseif Step == "AssignmentPhase.End" then
		NextStep = "CommandPhase.Start"
		Step = ""
	elseif Step == "CommandPhase.Start" then
		Game.Phase = "Command"
		printToAll("========================================")
		broadcastToAll("COMMAND PHASE")
		printToAll("========================================")
		--init turn and pass data...
		Game.Turn.Num = 0	--zero means no one has had a turn yet.
		Game.Flags.RapidMobilization = false
    	Game.Flags.ContingencyPlan = false
		Game.Flags.Passed[1] = false	--rebel player or rebel admiral
		Game.Flags.Passed[2] = false  --imperial player or imperial admiral
		if Game.Players.Total <= 2 then
			Game.Flags.Passed[3] = true  --imperial general passed
			Game.Flags.Passed[4] = true  --rebel general passed
			NextStep = "CommandPhase.1.Rebel.Turn"
		else
			Game.Flags.Passed[3] = false  --imperial general not passed
			Game.Flags.Passed[4] = false  --rebel general not passed
			NextStep = "CommandPhase.1.Rebel.Admiral.Turn"
		end--if
		Step = ""
	elseif Step == "CommandPhase.1.Rebel.Turn" then --2P
		--have all players have passed?...
		if Game.Flags.Passed[1] and Game.Flags.Passed[4] and Game.Flags.Passed[2] and Game.Flags.Passed[3] then
			--end the command phase...
			NextStep = "CommandPhase.RapidMobilization"
			Step = ""
		else
			NextStep = "CommandPhase.2.Imperial.Turn"
			--has this player passed?
			if Game.Flags.Passed[1] then
				Step = ""
			else--perform turn...
				Game.Turn.Num = 1
				Game.Turn.Faction = "Rebel"
				Game.Turn.Role = "Player"
	  		CommandTurnMenu()
			end
		end--if
	elseif Step == "CommandPhase.2.Imperial.Turn" then  --2P
		--have all players have passed?...
		if Game.Flags.Passed[1] and Game.Flags.Passed[4] and Game.Flags.Passed[2] and Game.Flags.Passed[3] then
			--end the command phase...
			NextStep = "CommandPhase.RapidMobilization"
			Step = ""
		else
			NextStep = "CommandPhase.1.Rebel.Turn"
			--has this player passed?
			if Game.Flags.Passed[2] then
				Step = ""
			else--perform turn...
				Game.Turn.Num = 2
				Game.Turn.Faction = "Imperial"
				Game.Turn.Role = "Player"
	  		CommandTurnMenu()
			end
		end--if
	elseif Step == "CommandPhase.1.Rebel.Admiral.Turn" then --3+P
		--have all players have passed?...
		if Game.Flags.Passed[1] and Game.Flags.Passed[4] and Game.Flags.Passed[2] and Game.Flags.Passed[3] then
			--end the command phase...
			NextStep = "CommandPhase.RapidMobilization"
			Step = ""
		else
			NextStep = "CommandPhase.2.Imperial.Admiral.Turn"
			--has this player passed?
			if Game.Flags.Passed[1] then
				Step = ""
			else--perform turn...
				Game.Turn.Num = 1
				Game.Turn.Faction = "Rebel"
				Game.Turn.Role = "Admiral"
	  		CommandTurnMenu()
			end
		end--if
	elseif Step == "CommandPhase.2.Imperial.Admiral.Turn" then  --3+P
		--have all players have passed?...
		if Game.Flags.Passed[1] and Game.Flags.Passed[4] and Game.Flags.Passed[2] and Game.Flags.Passed[3] then
			--end the command phase...
			NextStep = "CommandPhase.RapidMobilization"
			Step = ""
		else
			NextStep = "CommandPhase.3.Imperial.General.Turn"
			--has this player passed?
			if Game.Flags.Passed[2] then
				Step = ""
			else--perform turn...
				Game.Turn.Num = 2
				Game.Turn.Faction = "Imperial"
				Game.Turn.Role = "Admiral"
	  		CommandTurnMenu()
			end
		end--if
	elseif Step == "CommandPhase.3.Imperial.General.Turn" then  --3+P
		--have all players have passed?...
		if Game.Flags.Passed[1] and Game.Flags.Passed[4] and Game.Flags.Passed[2] and Game.Flags.Passed[3] then
			--end the command phase...
			NextStep = "CommandPhase.RapidMobilization"
			Step = ""
		else
			NextStep = "CommandPhase.4.Rebel.General.Turn"
			--has this player passed?
			if Game.Flags.Passed[3] then
				Step = ""
			else--perform turn...
				Game.Turn.Num = 3
				Game.Turn.Faction = "Imperial"
				Game.Turn.Role = "General"
	  		CommandTurnMenu()
			end
		end--if
	elseif Step == "CommandPhase.4.Rebel.General.Turn" then --3+P
		--have all players have passed?...
		if Game.Flags.Passed[1] and Game.Flags.Passed[4] and Game.Flags.Passed[2] and Game.Flags.Passed[3] then
			--end the command phase...
			NextStep = "CommandPhase.RapidMobilization"
			Step = ""
		else
			NextStep = "CommandPhase.1.Rebel.Admiral.Turn"
			--has this player passed?
			if Game.Flags.Passed[4] then
				Step = ""
			else--perform turn...
				Game.Turn.Num = 4
				Game.Turn.Faction = "Rebel"
				Game.Turn.Role = "General"
	  		CommandTurnMenu()
			end
		end--if
	elseif Step == "CommandPhase.RapidMobilization" then
		Game.Flags.ContingencyPlan = false
		Game.Flags.RapidMobilization = false
    	--scan rebel revealed mission area... 
    	for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.MissionRevealedZone).getObjects()) do 
			if Obj.type == "Card" and Obj.getName() == "RAPID MOBILIZATION" and (Obj.getRotation().z < 90 or Obj.getRotation().z > 270) then
				Game.Flags.RapidMobilization = true
			elseif Obj.type == "Card" and Obj.getName() == "CONTINGENCY PLAN" and (Obj.getRotation().z < 90 or Obj.getRotation().z > 270) then
				Game.Flags.ContingencyPlan = true
			end--if
    	end--for O,Obj
		if Game.Flags.RapidMobilization then
			--resolve rapid mobilization...
			ResolveRapidMobilization({Count=Game.Flags.RapidMobilization})
			PleaseWait({Panel=ImperialPanel,Text="Rebels are resolving\nRapid Mobilization..."})
		else
			NextStep = "CommandPhase.SweepTheArea"
			Step = ""
		end--if
	elseif Step == "CommandPhase.SweepTheArea" then
		--prompt imperials to resolve sweep the area?
		if Game.Flags.SweepTheArea then
			SweepTheArea()
			PleaseWait({Panel=RebelPanel,Text="Imperials are considering\nSweeping the Area..."})
		else
			NextStep = "CommandPhase.End"
			Step = ""
		end--if
	elseif Step == "CommandPhase.End" then
		--eliminate confronted leader?
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getVar("Component") == "Leader" then
				if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
				if string.find(Obj.getGMNotes(),"Confronted;") != nil then
					broadcastToAll(Obj.getName().." was confronted and eliminated!",{1,1,0})
					getObjectFromGUID(IDs.Imperial.LeaderBag).putObject(Obj)
				end--if has confronted tag
			end--if leader
		end--for O,Obj 
		NextStep = "RefreshPhase.Start"
		Step = ""
	elseif Step == "RefreshPhase.Start" then
		Game.Phase = "Refresh"
		printToAll("========================================")
		broadcastToAll("REFRESH PHASE")
		printToAll("========================================")
		--play objective?
		RefreshPlayObjective()
		--PleaseWait({Panel=ImperialPanel,Text="Rebel player is checking\ntheir Objectives..."})
	elseif Step == "RefreshPhase.I.RetrieveLeaders" then
		PleaseWait({Panel=RebelPanel,Text="Retrieving Leaders..."})
		PleaseWait({Panel=ImperialPanel,Text="Retrieving Leaders..."})
		--recall leaders to pooland wait for the coroutine to finish...
		RetrieveLeaders()
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat 
			coroutine.yield(0) 
			TimeOut = TimeOut - 1
		until not RetrievingLeaders or TimeOut <= 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to retrieve leaders.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
  		--go to next step...
		NextStep = "RefreshPhase.II.DrawMissions.1"
		Step = ""
	elseif Step == "RefreshPhase.II.DrawMissions.1" then
		PleaseWait({Panel=RebelPanel,Text="Drawing Missions..."})
		PleaseWait({Panel=ImperialPanel,Text="Drawing Missions..."})
		printToAll("Discarding/Returning Mission Cards...")
        local DiscardList = {}
        local ReturnList = {}
        if Player.White.seated then printToColor("\nMission Discard information below is hidden from your opponent(s):","White") end--if
        if Player.Red.seated then printToColor("\nMission Discard information below is hidden from your opponent(s):","Red") end--if
        --scan rebel mission revealed area mission cards to discard/return...
        for C,Card in pairs(getObjectFromGUID(IDs.Rebel.MissionRevealedZone).getObjects()) do 
			if Card.getDescription() == nil then Card.setDescription("") end--if (in case an object has a nil description)
			--mission card?
			if string.find(Card.getDescription(),"MissionCard;") != nil then
                --starting card?
				if string.find(Card.getDescription(),"Starting;") != nil then
					--return starting cards to hand... 
                    table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
					if Player.White.seated then printToColor(Card.getName().." is a Starting Mission, returning to hand.","White") end--if
					if Player.Red.seated then printToColor(Card.getName().." is a Starting Mission, returning to hand.","Red") end--if
					if Player.Black.seated then printToColor(Card.getName().." is a Starting Mission, returning to hand.","Black") end--if
                elseif Card.getRotation().z < 90 or Card.getRotation().z > 270 then
                    --face up in revealed zone...
                    table.insert(DiscardList,Card)--add to list of cards to be discarded.
					if Player.White.seated then printToColor(Card.getName().." is face up in the revealed zone, discarding.","White") end--if
					if Player.Red.seated then printToColor(Card.getName().." is face up in the revealed zone, discarding.","Red") end--if
					if Player.Black.seated then printToColor(Card.getName().." is face up in the revealed zone, discarding.","Black") end--if
                elseif Card.getRotation().z >= 90 and Card.getRotation().z <= 270 then
                    --face down in revealed zone...
                    table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
					if Player.White.seated then printToColor(Card.getName().." is face down in the revealed zone, returning to hand.","White") end--if
					if Player.Red.seated then printToColor(Card.getName().." is face down in the revealed zone, returning to hand.","Red") end--if
					if Player.Black.seated then printToColor(Card.getName().." is face down in the revealed zone, returning to hand.","Black") end--if
                else--should never happen!
                    table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
					if Player.White.seated then printToColor(Card.getName().." is unknown status in the revealed zone, returning to hand.","White") end--if
					if Player.Red.seated then printToColor(Card.getName().." is unknown status in the revealed zone, returning to hand.","Red") end--if
					if Player.Black.seated then printToColor(Card.getName().." is unknown status in the revealed zone, returning to hand.","Black") end--if
                end--if starting/flipped?
            end--if mission card
        end--for C,Card (rebel revealed zone)
		--scan rebel mission secret area mission cards to return...
        for C,Card in pairs(getObjectFromGUID(IDs.Rebel.MissionSecretZone).getObjects()) do 
			if Card.getDescription() == nil then Card.setDescription("") end--if (in case an object has a nil description)
			--mission card?
			if string.find(Card.getDescription(),"MissionCard;") != nil then
                --any mission cards in the secret zone get returned to hand...
                table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
                if Player.White.seated then printToColor(Card.getName().." was not revealed, returning to hand.","White") end--if
                if Player.Red.seated then printToColor(Card.getName().." was not revealed, returning to hand.","Red") end--if
                if Player.Black.seated then printToColor(Card.getName().." was not revealed, returning to hand.","Black") end--if
            end--if mission card
        end--for C,Card (rebel revealed zone)
        --return cards to hand...
        for C,Card in pairs (ReturnList) do 
            Card.setRotation({0,0,0})
            Card.setPosition({Card.GetPosition().x,2,Card.GetPosition().z})
            CardToHand({CardID=Card.getGUID(),Player="White",Index=Hands.RebelMission.Index,Flip=true})
            coroutine.yield(0)
        end--for C,Card (rebel returnlist)
        for C,Card in pairs (DiscardList) do 
            local P = Decks.RebelMissionDiscard.DropSpot
            P[2] = P[2] + C * 0.2
            Card.setPositionSmooth(P,false,false)
            Card.setRotationSmooth(Decks.RebelMissionDiscard.Rotation,false,false)
            coroutine.yield(0)
        end--for C,Card (rebel returnlist)
        DiscardList = {}
        ReturnList = {}
        if Player.Blue.seated then printToColor("\nMission Discard information below is hidden from your opponent(s):","Blue") end--if
        if Player.Orange.seated then printToColor("\nMission Discard information below is hidden from your opponent(s):","Orange") end--if
        --scan imperial mission revealed area mission/project cards to discard/return...
        for C,Card in pairs(getObjectFromGUID(IDs.Imperial.MissionRevealedZone).getObjects()) do 
			if Card.getDescription() == nil then Card.setDescription("") end--if (in case an object has a nil description)
			--mission card?
			if string.find(Card.getDescription(),"MissionCard;") != nil then
                --starting card?
				if string.find(Card.getDescription(),"Starting;") != nil then
					--return starting cards to hand... 
                    table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
					if Player.Blue.seated then printToColor(Card.getName().." is a Starting Mission, returning to hand.","Blue") end--if
					if Player.Orange.seated then printToColor(Card.getName().." is a Starting Mission, returning to hand.","Orange") end--if
					if Player.Black.seated then printToColor(Card.getName().." is a Starting Mission, returning to hand.","Black") end--if
                elseif Card.getRotation().z < 90 or Card.getRotation().z > 270 then
                    --face up in revealed zone...
                    table.insert(DiscardList,Card)--add to list of cards to be discarded.
					if Player.Blue.seated then printToColor(Card.getName().." is face up in the revealed zone, discarding.","Blue") end--if
					if Player.Orange.seated then printToColor(Card.getName().." is face up in the revealed zone, discarding.","Orange") end--if
					if Player.Black.seated then printToColor(Card.getName().." is face up in the revealed zone, discarding.","Black") end--if
                elseif Card.getRotation().z >= 90 and Card.getRotation().z <= 270 then
                    --face down in revealed zone...
                    table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
					if Player.Blue.seated then printToColor(Card.getName().." is face down in the revealed zone, returning to hand.","Blue") end--if
					if Player.Orange.seated then printToColor(Card.getName().." is face down in the revealed zone, returning to hand.","Orange") end--if
					if Player.Black.seated then printToColor(Card.getName().." is face down in the revealed zone, returning to hand.","Black") end--if
                else--should never happen!
                    table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
					if Player.Blue.seated then printToColor(Card.getName().." is unknown status in the revealed zone, returning to hand.","Blue") end--if
					if Player.Orange.seated then printToColor(Card.getName().." is unknown status in the revealed zone, returning to hand.","Orange") end--if
					if Player.Black.seated then printToColor(Card.getName().." is unknown status in the revealed zone, returning to hand.","Black") end--if
                end--if starting/flipped?
            end--if mission card
        end--for C,Card (Imperial revealed zone)
		--scan Imperial mission secret area mission cards to return...
        for C,Card in pairs(getObjectFromGUID(IDs.Imperial.MissionSecretZone).getObjects()) do 
			if Card.getDescription() == nil then Card.setDescription("") end--if (in case an object has a nil description)
			--mission card?
			if string.find(Card.getDescription(),"MissionCard;") != nil then
                --any mission cards in the secret zone get returned to hand...
                table.insert(ReturnList,Card)--add to list of cards to be returned to hand.
                if Player.Blue.seated then printToColor(Card.getName().." was not revealed, returning to hand.","Blue") end--if
                if Player.Orange.seated then printToColor(Card.getName().." was not revealed, returning to hand.","Orange") end--if
                if Player.Black.seated then printToColor(Card.getName().." was not revealed, returning to hand.","Black") end--if
            end--if mission card
        end--for C,Card (Imperial revealed zone)
        --return cards to hand...
        for C,Card in pairs (ReturnList) do 
            Card.setRotation({0,180,0})
            Card.setPosition({Card.GetPosition().x,2,Card.GetPosition().z})
            CardToHand({CardID=Card.getGUID(),Player="Blue",Index=Hands.ImperialMission.Index,Flip=true})
            coroutine.yield(0)
        end--for C,Card (Imperial returnlist)
        for C,Card in pairs (DiscardList) do 
            --project?
            if string.find(Card.getDescription(),"Project;") != nil then
                --discard to projects discard pad...
                local P = Decks.ImperialProjectDiscard.DropSpot
                P[2] = P[2] + C * 0.2
                Card.setPositionSmooth(P,false,false)
                Card.setRotationSmooth(Decks.ImperialProjectDiscard.Rotation,false,false)
            else  --discard to mission discard pad...
                local P = Decks.ImperialMissionDiscard.DropSpot
                P[2] = P[2] + C * 0.2
                Card.setPositionSmooth(P,false,false)
                Card.setRotationSmooth(Decks.ImperialMissionDiscard.Rotation,false,false)
            end--if
            coroutine.yield(0)
        end--for C,Card (imperial returnlist)
		for D=1,30 do coroutine.yield(0) end--for D
		local MissionCards = GetDeck("RebelMission")
		local DiscardPile = GetDeck("RebelMissionDiscard")
		--if the rebel deck needs to be rebuilt...
		if MissionCards == nil then
			if DiscardPile == nil then
				printToAll("Uhoh! The Rebel Mission deck appears to be depleted, but I cannot locate the discard pile to rebuild it!",{1,0.5,0.25})
			else 
				printToAll("Rebuilding the Rebel Mission deck from the discard pile...",{1,1,0})
				DiscardPile.shuffle()
				DiscardPile.setPosition(Decks.RebelMission.Spot)
				DiscardPile.setRotation(Decks.RebelMission.Rotation)
				for D=1,30 do coroutine.yield(0) end--for D
				Decks.RebelMission.ID = DiscardPile.getGUID()
			end--if
		elseif MissionCards.type == "Card" then
			if DiscardPile == nil then
				printToAll("Uhoh! The Rebel Mission deck appears to be depleted, but I cannot locate the discard pile to rebuild it!",{1,0.5,0.25})
			else 
				printToAll("Rebuilding the Rebel Mission deck from the discard pile...",{1,1,0})
				DiscardPile.shuffle()
				DiscardPile.setPosition(Decks.RebelMission.Spot)
				DiscardPile.setRotation(Decks.RebelMission.Rotation)
				MissionCards.setPosition({Decks.RebelMission.Spot[1],2,Decks.RebelMission.Spot[3]})
				coroutine.yield(0)
				DiscardPile.putObject(MissionCards)
				for D=1,30 do coroutine.yield(0) end--for D
				Decks.RebelMission.ID = DiscardPile.getGUID()
			end--if
		end--if
		MissionCards = GetDeck("ImperialMission")
		DiscardPile = GetDeck("ImperialMissionDiscard")
		--if the Imperial deck needs to be rebuilt...
		if MissionCards == nil then
			if DiscardPile == nil then
				printToAll("Uhoh! The Imperial Mission deck appears to be depleted, but I cannot locate the discard pile to rebuild it!",{1,0.5,0.25})
			else 
				printToAll("Rebuilding the Imperial Mission deck from the discard pile...",{1,1,0})
				DiscardPile.shuffle()
				DiscardPile.setPosition(Decks.ImperialMission.Spot)
				DiscardPile.setRotation(Decks.ImperialMission.Rotation)
				for D=1,30 do coroutine.yield(0) end--for D
				Decks.ImperialMission.ID = DiscardPile.getGUID()
			end--if
		elseif MissionCards.type == "Card" then
			if DiscardPile == nil then
				printToAll("Uhoh! The Imperial Mission deck appears to be depleted, but I cannot locate the discard pile to rebuild it!",{1,0.5,0.25})
			else 
				printToAll("Rebuilding the Imperial Mission deck from the discard pile...",{1,1,0})
				DiscardPile.shuffle()
				DiscardPile.setPosition(Decks.ImperialMission.Spot)
				DiscardPile.setRotation(Decks.ImperialMission.Rotation)
				MissionCards.setPosition({Decks.ImperialMission.Spot[1],2,Decks.ImperialMission.Spot[3]})
				coroutine.yield(0)
				DiscardPile.putObject(MissionCards)
				for D=1,30 do coroutine.yield(0) end--for D
				Decks.ImperialMission.ID = DiscardPile.getGUID()
			end--if
		end--if
		coroutine.yield(0)
		--reset mission hand flags...
		Game.Flags.MissionHandOK.Rebel = false	--assume false until proven true.
		Game.Flags.MissionHandOK.Imperial = false	--assume false until proven true.
		--go to next step...
		NextStep = "RefreshPhase.II.DrawMissions.2"
		Step = ""
	elseif Step == "RefreshPhase.II.DrawMissions.2" then
		NextStep = "RefreshPhase.II.DrawMissions.2"
		if Game.Flags.GSDeck then--galactic struggle deck mode... 
			if not Game.Flags.MissionHandOK.Imperial and not Game.Flags.MissionHandOK.Rebel then
				printToAll("\nGalactic Struggle: Draw 3 Missions, Discard 1...")
				startLuaCoroutine(Global,"GalacticStruggleImperialMissionDrawCoroutine")
				startLuaCoroutine(Global,"GalacticStruggleRebelMissionDrawCoroutine")
			end--if
			if Game.Flags.MissionHandOK.Imperial then
				PleaseWait({Panel=ImperialPanel,Text="Waiting for Rebel Player\nto finish drawing Missions..."})
			end
			if Game.Flags.MissionHandOK.Imperial then
				PleaseWait({Panel=RebelPanel,Text="Waiting for Imperial Player\nto finish drawing Missions..."})
			end
			if Game.Flags.MissionHandOK.Imperial and Game.Flags.MissionHandOK.Rebel then
				Game.Flags.MissionHandOK.Imperial = false
				Game.Flags.MissionHandOK.Rebel = false
				NextStep = "RefreshPhase.II.DiscardMissions"
				Step = ""
			end--if
		else--standard mission deck mode... 
			printToAll("Each Faction Draws 2 Mission Cards...")
			--get hand size before draw (rebels)...
			local HandSize = #Player["White"].getHandObjects(Hands.RebelMission.Index)
			--draw 2 mission cards to mission hand (rebels)...
			DealToHand({Deck="RebelMission",Player="White",Index=Hands.RebelMission.Index,Qty=2,Flip=true})
			RepCount = RepCount + 1
			local TimeOut = 500
			repeat 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			until not Game.Flags.Dealing or TimeOut <= 0
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			--wait for cards to reach the hand...
			RepCount = RepCount + 1
			local TimeOut = 500
			while #Player["White"].getHandObjects(Hands.RebelMission.Index) < HandSize + 2 and TimeOut > 0 do 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			end--while
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			--get hand size before draw (imperials)...
			HandSize = #Player["Blue"].getHandObjects(Hands.ImperialMission.Index)
			--draw 2 mission cards to mission hand (imperials)...
			DealToHand({Deck="ImperialMission",Player="Blue",Index=Hands.ImperialMission.Index,Qty=2,Flip=true})
			RepCount = RepCount + 1
			local TimeOut = 500
			repeat 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			until not Game.Flags.Dealing or TimeOut <= 0
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			--wait for cards to reach the hand...
			RepCount = RepCount + 1
			local TimeOut = 500
			while #Player["Blue"].getHandObjects(Hands.ImperialMission.Index) < HandSize + 2 and TimeOut > 0 do 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			end--while
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			--go to next step...
			NextStep = "RefreshPhase.II.DiscardMissions"
			Step = ""
		end--if
	elseif Step == "RefreshPhase.II.DiscardMissions" then
		--repeat this step until mission hand sizes are ok...
		if #Player["White"].getHandObjects(Hands.RebelMission.Index) > 10 and not Game.Flags.MissionHandOK.Rebel then
			DiscardMissions({Faction="Rebel",Size=#Player["White"].getHandObjects(Hands.RebelMission.Index)})
		else
			PleaseWait({Panel=RebelPanel,Text="Imperials are\nDiscarding Missions..."})
			Game.Flags.MissionHandOK.Rebel = true
		end--if
		if #Player["Blue"].getHandObjects(Hands.ImperialMission.Index) > 10 and not Game.Flags.MissionHandOK.Imperial then
			DiscardMissions({Faction="Imperial",Size=#Player["Blue"].getHandObjects(Hands.ImperialMission.Index)})
		else
			PleaseWait({Panel=ImperialPanel,Text="Rebels are\nDiscarding Missions..."})
			Game.Flags.MissionHandOK.Imperial = true
		end--if
		--repeat this step until both mission hands are flagged as ok...
		if Game.Flags.MissionHandOK.Rebel and Game.Flags.MissionHandOK.Imperial then
			NextStep = "RefreshPhase.III.LaunchProbeDroids"
			Step = ""
		end--if
	elseif Step == "RefreshPhase.III.LaunchProbeDroids" then
		PlaySound({ID=35})--probe droid
		printToAll("Imperials Launch Probe Droids (Draw 2 Probe Cards)...")
		DealToHand({Deck="Probe",Player="Blue",Index=Hands.ImperialProbe.Index,Qty=2,Flip=true})
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat 
			coroutine.yield(0) 
			TimeOut = TimeOut - 1
		until not Game.Flags.Dealing or TimeOut <= 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
	--go to next step...
		NextStep = "RefreshPhase.IV.DrawObjective"
		Step = ""
	elseif Step == "RefreshPhase.IV.DrawObjective" then
		printToAll("Rebels Draw 1 Objective Card...")
		DealToHand({Deck="Objective",Player="White",Index=Hands.RebelObjective.Index,Qty=1,Flip=true})
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat 
			coroutine.yield(0) 
			TimeOut = TimeOut - 1
		until not Game.Flags.Dealing or TimeOut <= 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
	  --assume next step...
		NextStep = "RefreshPhase.V.AdvanceTimeMarker"
		--immediate objective?
		--for each card in rebel action card hand...
		for O,Obj in pairs(Player["White"].getHandObjects(Hands.RebelObjective.Index)) do
			if Obj.getName() == "Rebel Cell" then
				Obj.setPosition({-18.50,1,12.89})
				Obj.setRotation({0,0,0})
				if getObjectFromGUID("7f5047") != nil then
					getObjectFromGUID("7f5047").setPositionSmooth({-18.50,1.1,12.89},false,false)
				end--if
				broadcastToAll("Immediate Objective drawn: REBEL CELL")
				coroutine.yield(0)
				Ping({Position={-18.50,1,12.89}})
				NextStep = "RefreshPhase.IV.DrawObjective.Immediate"
			elseif Obj.getName() == "Raid Outposts" then
				Obj.setPosition({-16.45,1,12.90})
				Obj.setRotation({0,0,0})
				if getObjectFromGUID("209ac9") != nil then
					getObjectFromGUID("209ac9").setPositionSmooth({-16.45,1.1,12.90},false,false)
				end--if
				if getObjectFromGUID("2f062d") != nil then
					getObjectFromGUID("2f062d").setPositionSmooth({-16.45,1.2,12.90},false,false)
				end--if
				broadcastToAll("Immediate Objective drawn: RAID OUTPOSTS")
				coroutine.yield(0)
				Ping({Position={-16.45,1,12.90}})
				NextStep = "RefreshPhase.IV.DrawObjective.Immediate"
			end--if
		end--for
		--go to next step...
		Step = ""
	elseif Step == "RefreshPhase.IV.DrawObjective.Immediate" then
		NextStep = "RefreshPhase.V.AdvanceTimeMarker"
		ResolveImmediateObjective()
		PleaseWait({Panel=ImperialPanel,Text="Rebels are resolving\nan Immediate Objective..."})
	elseif Step == "RefreshPhase.V.AdvanceTimeMarker" then
		Game.Round = Game.Round + 1
		printToAll("Advancing Time Marker to "..(Game.Round).."...")
		local P = Spots.TimeTrack[Game.Round]
		P[2] = P[2] + 0.5
		getObjectFromGUID(IDs.TimeMarker).setPositionSmooth(P,false,false)
		getObjectFromGUID(IDs.TimeMarker).setRotationSmooth({0,90,0},false,false)
		Ping({Position=P})
		--go to next step...
		NextStep = "RefreshPhase.V.i.RecruitIcon"
		Step = ""
	elseif Step == "RefreshPhase.V.i.RecruitIcon" then
		--recruit round?
		if Game.Round <= 5 then
			printToAll("  Recruit Icon: This is a Recruiting Round.")
			--init recruiting data...
			Game.Leaders.Recruiting.Rebel = ""
			Game.Leaders.Recruiting.Imperial = ""
			Game.Leaders.Draws.Rebel={nil,nil,nil,nil,nil}
			Game.Leaders.Draws.Imperial={nil,nil,nil,nil,nil}
			Game.Leaders.Recruits.Rebel={}
			Game.Leaders.Recruits.Imperial={}
			--move leader bags into hidden zone for better privacy...
			getObjectFromGUID(IDs.Rebel.LeaderBag).setPositionSmooth({0,1.57,24.7},false,true)
			getObjectFromGUID(IDs.Rebel.LeaderBag).setRotation({0,0,0})
			getObjectFromGUID(IDs.Imperial.LeaderBag).setPositionSmooth({0,1.57,-24.7},false,true)
			getObjectFromGUID(IDs.Imperial.LeaderBag).setRotation({0,180,0})
			--raise recruit hidden zones...
			getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.On,false,false)
			getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.On,false,false)
			--draw 2 recruits for each faction...
			Game.Leaders.Draws.Rebel[1] = GetDeck("RebelAction").takeObject({smooth=true,position=Spots.Recruitment.Rebel.Cards[1],rotation={0,0,180}}).getGUID()
			Game.Leaders.Draws.Rebel[2] = GetDeck("RebelAction").takeObject({smooth=true,position=Spots.Recruitment.Rebel.Cards[2],rotation={0,0,180}}).getGUID()
			Game.Leaders.Draws.Imperial[1] = GetDeck("ImperialAction").takeObject({smooth=true,position=Spots.Recruitment.Imperial.Cards[1],rotation={0,180,180}}).getGUID()
			Game.Leaders.Draws.Imperial[2] = GetDeck("ImperialAction").takeObject({smooth=true,position=Spots.Recruitment.Imperial.Cards[2],rotation={0,180,180}}).getGUID()
			--flip the cards...
			RepCount = RepCount + 1
			local TimeOut = 500
			repeat 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			until not getObjectFromGUID(Game.Leaders.Draws.Rebel[1]).isSmoothMoving() and not getObjectFromGUID(Game.Leaders.Draws.Rebel[2]).isSmoothMoving() and not getObjectFromGUID(Game.Leaders.Draws.Imperial[1]).isSmoothMoving() and not getObjectFromGUID(Game.Leaders.Draws.Imperial[2]).isSmoothMoving() and TimeOut > 0
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to flip a card.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			getObjectFromGUID(Game.Leaders.Draws.Rebel[1]).flip()
			getObjectFromGUID(Game.Leaders.Draws.Rebel[2]).flip()
			getObjectFromGUID(Game.Leaders.Draws.Imperial[1]).flip()
			getObjectFromGUID(Game.Leaders.Draws.Imperial[2]).flip()
			NextStep = "RefreshPhase.V.i.ChooseActionCard"
			PresentRecruits()	--get out all possible recruits...
			coroutine.yield(0)
		else
			Game.Flags.Build.Rebel = false
			Game.Flags.Build.Imperial = false
			Game.Flags.Slid.Rebel = false
			Game.Flags.Slid.Imperial = false
			--go to next step...
			NextStep = "RefreshPhase.V.ii.BuildIcon"
		end--if
		Step = ""
	elseif Step == "RefreshPhase.V.i.ChooseActionCard" then
		--update recruits and dismiss unrecruitable leaders...
		DismissRecruits()
		--if both factions have not chosen an action card yet...
		if #Game.Leaders.Draws.Rebel > 1 or #Game.Leaders.Draws.Imperial > 1 then
			PresentRecruits()
			--are rebels still choosing a card?
			if #Game.Leaders.Draws.Rebel > 1 then
				ChooseRebelLeaderActionCard()
			else--rebels have chosen...
				PleaseWait({Panel=RebelPanel,Text="Waiting for Imperials to\nchoose an Action card\nto recruit from..."})
			end--if
			--are imperials still choosing a card?
			if #Game.Leaders.Draws.Imperial > 1 then
				ChooseImperialLeaderActionCard()
			else--rebels have chosen...
				PleaseWait({Panel=ImperialPanel,Text="Waiting for Rebels to\nchoose an Action card\n to recruit from..."})
			end--if
		elseif Game.Leaders.Recruiting.Rebel == "" or Game.Leaders.Recruiting.Imperial == "" then--if both factions have not finished recruiting...
			--if rebels are still recruiting...
			if Game.Leaders.Recruiting.Rebel == "" then
				ChooseRebelLeaderActionCard()
				PleaseWait({Panel=ImperialPanel,Text="Wait for Rebels to\nannounce their Recruitment\nchoice before choosing."})
	  		elseif Game.Leaders.Recruiting.Imperial == "" then--if imperials are still recruiting...
				--move rebel leader bag back to original location...
				getObjectFromGUID(IDs.Rebel.LeaderBag).setPositionSmooth({19,1.47,33},false,false)
				getObjectFromGUID(IDs.Rebel.LeaderBag).setRotation({0,0,0})
				--announce rebel recruitment choice and lower rebel hidden zone...
				--if we find the leader in the hidden zone... 
				local Found = false
				for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.HiddenPanelZone).getObjects()) do
					if Obj.getVar("Component") == "Leader" then
						if Obj.getName() == Game.Leaders.Recruiting.Rebel then
							Found = true
							break
						end
					end--if
				end--for O,Obj
				if Found then
					broadcastToAll("    Rebels Recruited: "..Game.Leaders.Recruiting.Rebel)
				else
					broadcastToAll("    Rebels did not Recruit a Leader.")
				end--if
				--lower rebel recruit hidden zone...
				Wait.time(function() getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false) end,0.5)
				PleaseWait({Panel=RebelPanel,Text="Waiting for Imperials\nto choose which\nLeader to Recruit..."})
				ChooseImperialLeaderActionCard()
			end--if
		else--must be done!
			--move imperial leader bags back to original location...
			getObjectFromGUID(IDs.Imperial.LeaderBag).setPositionSmooth({19,1.47,-33},false,false)
			getObjectFromGUID(IDs.Imperial.LeaderBag).setRotation({0,180,0})
			--lower imperial recruit hidden zone...
			Wait.time(function() getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.Off,false,false) end,0.5)
			--announce imperial choice
			--if we find the leader in the hidden zone... 
			local Found = false
			for O,Obj in pairs(getObjectFromGUID(IDs.Imperial.HiddenPanelZone).getObjects()) do
				if Obj.getVar("Component") == "Leader" then
					if Obj.getName() == Game.Leaders.Recruiting.Imperial then
						Found = true
						break
					end
				end--if
			end--for O,Obj
			if Found then
				broadcastToAll("    Imperials Recruited: "..Game.Leaders.Recruiting.Imperial)
			else
				broadcastToAll("    Imperials did not Recruit a Leader.")
			end--if
			--recall leaders to pool and wait for the coroutine to finish...
			for Delay=1,30 do coroutine.yield(0) end--for
			RetrieveLeaders()
			RepCount = RepCount + 1
			local TimeOut = 500
			repeat 
				coroutine.yield(0) 
				TimeOut = TimeOut - 1
			until not RetrievingLeaders or TimeOut <= 0
			if TimeOut <= 0 then
				printToAll("Uhoh! Timed out waiting for script to retrieve leaders.  Attempting to resume script...",{1,0.5,0.25})
			end--if
			RepCount = RepCount - 1
			for Delay=1,30 do coroutine.yield(0) end--for
			--activate any immediate action cards in player's hands...
			--for each card in rebel action card hand...
			for O,Obj in pairs(Player["White"].getHandObjects(Hands.RebelAction.Index)) do
				if Obj.getName() == "UNDER THE RADAR" then
					local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Rebel,Description="ActionCard;"})
					Obj.setPosition(CardSpot)
					Obj.setRotation({0,0,0})
					coroutine.yield(0)
					Ping({Position=CardSpot})
				elseif Obj.getName() == "THE MILLENNIUM FALCON" then
					local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Rebel,Description="ActionCard;"})
					Obj.setPosition(CardSpot)
					Obj.setRotation({0,0,0})
					LeaderFetchRing({Name="Millennium Falcon",BagID=IDs.Rebel.RingBag,Smooth=true,Position={CardSpot[1],0.7,14.3},Rotation={0,0,0}})
					coroutine.yield(0)
					Ping({Position=CardSpot})
					Ping({Position={CardSpot[1],0.7,14.3}})
				elseif Obj.getName() == "HE MEANS WELL" then
					local CardSpot = GetFirstOpenSpot({Spots=Spots.Action.Rebel,Description="ActionCard;"})
					Obj.setPosition(CardSpot)
					Obj.setRotation({0,0,0})
					LeaderFetchRing({Name="K%-2S0",BagID=IDs.Rebel.RingBag,Smooth=true,Position={CardSpot[1],0.7,14.3},Rotation={0,0,0}})
					coroutine.yield(0)
					Ping({Position=CardSpot})
					Ping({Position={CardSpot[1],0.7,14.3}})
				end--if
			end--for
			--for each card in imperial action card hand...
			for O,Obj in pairs(Player["Blue"].getHandObjects(Hands.ImperialAction.Index)) do
				if Obj.getName() == "SECRET FACILITY" then
					Obj.setPosition(GetFirstOpenSpot({Spots=Spots.Action.Imperial,Description="ActionCard;"}))
					Obj.setRotation({0,180,0})
					coroutine.yield(0)
					Ping({Position=Spots.Action.Imperial[O]})
				elseif Obj.getName() == "LORD VADER'S ORDERS" then
					Obj.setPosition(GetFirstOpenSpot({Spots=Spots.Action.Imperial,Description="ActionCard;"}))
					Obj.setRotation({0,180,0})
					coroutine.yield(0)
					Ping({Position=Spots.Action.Imperial[O]})
				elseif Obj.getName() == "SWEEP THE AREA" then
					Obj.setPosition(GetFirstOpenSpot({Spots=Spots.Action.Imperial,Description="ActionCard;"}))
					Obj.setRotation({0,180,0})
					coroutine.yield(0)
					Ping({Position=Spots.Action.Imperial[O]})
				end--if
			end--for
			Game.Flags.Build.Rebel = false
			Game.Flags.Build.Imperial = false
			Game.Flags.Slid.Rebel = false
			Game.Flags.Slid.Imperial = false
			--advance to next step in refresh phase...
			NextStep = "RefreshPhase.V.ii.BuildIcon"
			Step = ""
		end--if
	elseif Step == "RefreshPhase.V.ii.BuildIcon" then
		--build round?
		if Game.Round % 2 == 0 then
			SuppressVictoryCheck = true
			Game.Flags.Busy.Rebel = false
			Game.Flags.Busy.Imperial = false
			printToAll("  Build Icon: This is a Building Round.")
			PleaseWait({Panel=ImperialPanel,Text="Analyzing Board..."})
			PleaseWait({Panel=RebelPanel,Text="Analyzing Board..."})
			RebelPanel.setRotation({0,0,180})
			ImperialPanel.setRotation({0,180,180})
			coroutine.yield(0) 
			--loop through all locations and reset flags and counts...
			for L,Location in pairs(Locations) do
				--reset location flags...
				Location.Destroyed = false	--false until proven true.
				Location.Sabotaged = false	--false until proven true.
				Location.Blockaded = false	--false until proven true.
				Location.Subjugated = false	--false until proven true.
				Location.Neutral = true
				--start recount of all units on the board... 
				Location.Units = {List={},Imperial={Space=0,Ground=0,Structures=0,Deployed=0,Bunkers=0,OldGround=0},Rebel={Space=0,Ground=0,Structures=0,Deployed=0,Recruits=0}}
			end--for
			coroutine.yield(0)
			--update all unit locations and delete any stray buildtiles...
			for O,Obj in pairs(getAllObjects()) do
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				if string.find(Obj.getDescription(),"BuildTile;") != nil then
					Obj.destruct()
				elseif Obj.getVar("Component") == "Unit" then
					Obj.setGMNotes("")	--remove prev location, it will be redetected to update count if game is reloaded.
					Obj.setVar("Location","")
					UnitUpdateLocation(Obj)	
				end--if
			end--for
			SuppressVictoryCheck = true
			coroutine.yield(0)
			--init queue data...
			Queues.Rebel.Panel.Tiles = { {},{},{} }
			Queues.Imperial.Panel.Tiles = { {},{},{} }
			UpdateBoard(false)
			--rebel base is blockaded if revealed with an imperial unit or loyalty in the system... 
			for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.BaseProbeCardZone).getObjects()) do 
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				if string.find(Obj.getDescription(),"ProbeCard;") != nil then
					if (Obj.getRotation().z < 90 or Obj.getRotation().z > 270) and Obj.getGMNotes() != "Hidden" then
						if Locations[Obj.getName()] != nil then
							if Locations[Obj.getName()].Loyalty == "Imperial" or Locations[Obj.getName()].Units.Imperial.Space + Locations[Obj.getName()].Units.Imperial.Ground > 0 then  
								Locations["REBEL BASE"].Blockaded = true
								log("Rebel Base is revealed and blockaded.")
							end--if
						else 
							log("Rebel Base appears Revealed, but there's a problem reading the probe card.")
						end--if location exists. 
					end--if
					break
				end--if
			end--for O,Obj 
			--loop thru the locations and tally builds...
			for L,Location in pairs(Locations) do
				--loop through the location's build icons...
				for I = 1,#Location.Build.Icons do
					--is this system icon able to build?
					if not Location.Destroyed and not Location.Sabotaged and not Location.Blockaded and Location.Build.Queue > 0 then
						local BuildTile = nil
						--if imperial has not built yet, and imperial loyal or subjugated and only looking at the first icon...
						if not Game.Flags.Build.Imperial and Location.Loyalty == "Imperial" or (Location.Subjugated and I < 2) then
							--this is an imperial/subjugated system...
							--BuildTile = getObjectFromGUID(IDs.Imperial[Location.Build.Icons[I].."Bag"]).takeObject({smooth=false,position=Queues.Imperial.Panel.Spots[Location.Build.Queue][#Queues.Imperial.Panel.Tiles[Location.Build.Queue]+1],rotation={0,180,0}})
							BuildTile = getObjectFromGUID(IDs.Imperial[Location.Build.Icons[I].."Bag"]).takeObject()
							BuildTile.setName(BuildTile.getName().." ("..L..")")
							BuildTile.setDescription(BuildTile.getDescription().."Location:"..L..";Q:"..Location.Build.Queue..";#:"..(#Queues.Imperial.Panel.Tiles[Location.Build.Queue]+1))
							BuildTile.setLock(true)
							BuildTile.setPosition(Queues.Imperial.Panel.Spots[Location.Build.Queue][#Queues.Imperial.Panel.Tiles[Location.Build.Queue]+1])
							BuildTile.setRotation({0,180,0})
							--other states?
							if BuildTile.getStates() != nil then
								local States = {}	--table to store other states.
								--loop through all states of the tile...
								for S,State in pairs(BuildTile.getStates()) do
									table.insert(States,S,State.id)
								end--for
								for S=1,#States do
									BuildTile = BuildTile.setState(States[S])
									coroutine.yield(0)
									BuildTile.setName(BuildTile.getName().." ("..L..")")
									BuildTile.setDescription(BuildTile.getDescription().."Location:"..L..";Q:"..Location.Build.Queue..";#:"..(#Queues.Imperial.Panel.Tiles[Location.Build.Queue]+1))
								end--for
								BuildTile = BuildTile.setState(1)
							end--if
							coroutine.yield(0)
							BuildTile.setVar("Location",L)
							table.insert(Queues.Imperial.Panel.Tiles[Location.Build.Queue],BuildTile)
						elseif not Game.Flags.Build.Rebel and Location.Loyalty == "Rebel" and not Location.Subjugated then
							--this is a rebel non-subjugated system (and the rebel player has not built yet this round)...
							BuildTile = getObjectFromGUID(IDs.Rebel[Location.Build.Icons[I].."Bag"]).takeObject({smooth=false,position=Queues.Rebel.Panel.Spots[Location.Build.Queue][#Queues.Rebel.Panel.Tiles[Location.Build.Queue]+1],rotation={0,0,0}})
							BuildTile.setName(BuildTile.getName().." ("..L..")")
							BuildTile.setDescription(BuildTile.getDescription().."Location:"..L..";Q:"..Location.Build.Queue..";#:"..(#Queues.Rebel.Panel.Tiles[Location.Build.Queue]+1))
							BuildTile.setLock(true)
							BuildTile.setPosition(Queues.Rebel.Panel.Spots[Location.Build.Queue][#Queues.Rebel.Panel.Tiles[Location.Build.Queue]+1])
							BuildTile.setRotation({0,0,0})
							--other states?
							if BuildTile.getStates() != nil then
								local States = {}	--table to store other states.
								--loop through all states of the tile...
								for S,State in pairs(BuildTile.getStates()) do
									table.insert(States,S,State.id)
								end--for
								for S=1,#States do
									BuildTile = BuildTile.setState(States[S])
									coroutine.yield(0)
									BuildTile.setName(BuildTile.getName().." ("..L..")")
									BuildTile.setDescription(BuildTile.getDescription().."Location:"..L..";Q:"..Location.Build.Queue..";#:"..(#Queues.Rebel.Panel.Tiles[Location.Build.Queue]+1))
								end--for
								BuildTile = BuildTile.setState(1)
							end--if
							coroutine.yield(0)
							BuildTile.setVar("Location",L)
							table.insert(Queues.Rebel.Panel.Tiles[Location.Build.Queue],BuildTile)
						end--if
					end--if
				end--for
			end--for L,Location
			--refresh all build tile positions, rotations, and scales in case of lag... 
			for O,Obj in pairs(getAllObjects()) do
				if Obj.getDescription() == nil then Obj.setDescription("")  end--if
				--is the object a build tile?
				if string.find(Obj.getDescription(),"BuildTile;") != nil then
					Obj.setPosition({Obj.getPosition().x,0.55,Obj.getPosition().z})
					Obj.setRotation({0,Obj.getRotation().y,0})
					Obj.setScale({0.25,1,0.25})
					coroutine.yield(0)
				end--if
			end--for O,Obj
			--prompt factions to build...
			if not Game.Flags.Build.Rebel then
				BuildUnits({Faction="Rebel"})
			else--rebels already built...
				PleaseWait({Panel=RebelPanel,Text="Rebels already Built.\n\nWaiting on Imperials to Build..."})
				RebelPanel.setRotation({0,0,0})
			end--if
			if not Game.Flags.Build.Imperial then
				BuildUnits({Faction="Imperial"})
			else--imperials already built...
				PleaseWait({Panel=ImperialPanel,Text="Imperials already Built.\n\nWaiting on Rebels to Build..."})
				ImperialPanel.setRotation({0,180,0})
			end--if
		else
			--go to next step...
			NextStep = "RefreshPhase.VI.DeployRebelRecruits"
			Step = ""
		end--if
	elseif Step == "RefreshPhase.V.ii.BuildRebelUnits" then
		--build rebel units...
		Game.Flags.Busy.Rebel = true
		local L = 0
		local M = 0
		local S = 0
		local NewUnit = nil
		local T = 0
		local Tile = nil
		printToAll("========================================\nREBEL QUEUE 3\n----------------------------------------")
		for T,Tile in pairs(ScanForObjects({Description="Q:3;#",Origin={0,0.6,28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
			if Tile.getDescription() == nil then Tile.setDescription("") end--if
			printToAll(Tile.getName())
			if string.find(Tile.getName(),"Mon Cala Cruiser") != nil then
				L=L+1
				NewUnit = getObjectFromGUID(Units["Mon Cala Cruiser"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].L[L],rotation={0,Units["Mon Cala Cruiser"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"MC80 Cruiser") != nil then
				L=L+1
				NewUnit = getObjectFromGUID(Units["MC80 Cruiser"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].L[L],rotation={0,Units["MC80 Cruiser"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"MC75 Cruiser") != nil then
				L=L+1
				NewUnit = getObjectFromGUID(Units["MC75 Cruiser"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].L[L],rotation={0,Units["MC75 Cruiser"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Nebulon%-B Frigate") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Nebulon-B Frigate"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].M[M],rotation={0,Units["Nebulon-B Frigate"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Corellian Corvette") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Corellian Corvette"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].M[M],rotation={0,Units["Corellian Corvette"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Hammerhead Corvette") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Hammerhead Corvette"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].M[M],rotation={0,Units["Hammerhead Corvette"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Escort Carrier") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Escort Carrier"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].M[M],rotation={0,Units["Escort Carrier"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Light Freighter") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Light Freighter"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].S[S],rotation={0,Units["Light Freighter"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Rebel Transport") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Rebel Transport"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].S[S],rotation={0,Units["Rebel Transport"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"X%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["X-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].S[S],rotation={0,Units["X-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Y%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Y-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].S[S],rotation={0,Units["Y-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"U%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["U-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].S[S],rotation={0,Units["U-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"A%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["A-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].S[S],rotation={0,Units["A-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"B%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["B-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[3].S[S],rotation={0,Units["B-Wing"].AngleY,0}})
				Tile.destruct()
			end--if
			for D=1,30 do coroutine.yield(0) end--for D
			--if new unit still exists (wasn't destroyed for going over supply limit)...
			if NewUnit != nil then
				NewUnit.setGMNotes(UpdateTag({Text=NewUnit.getGMNotes(),Tag="Location",Value="REBEL QUEUE 3"}))
				--shrink and highlight...
				NewUnit.setScale({NewUnit.getScale().x*0.5,NewUnit.getScale().y*0.5,NewUnit.getScale().z*0.5})
				if NewUnit.getVar("Theater") == "Space" then
					NewUnit.highlightOn({1,1,1})
				else
					NewUnit.highlightOn({1,0,0})
				end--if
			else--unit was destroyed, probably for going over the supply limit...
				--make a note for later...
			end--if
		end--for
		--wait for last unit to stop moving...
		RepCount = RepCount + 1
		if NewUnit != nil then repeat coroutine.yield(0) until not NewUnit.isSmoothMoving() end--if
		RepCount = RepCount - 1
		NewUnit = nil
		printToAll("----------------------------------------\nREBEL QUEUE 2\n----------------------------------------")
		L = 0
		M = 0
		S = 0
		for T,Tile in pairs(ScanForObjects({Description="Q:2;#",Origin={0,0.6,28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
			if Tile.getDescription() == nil then Tile.setDescription("") end--if
			printToAll(Tile.getName())
			if string.find(Tile.getName(),"Nebulon%-B Frigate") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Nebulon-B Frigate"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].M[M],rotation={0,Units["Nebulon-B Frigate"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Corellian Corvette") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Corellian Corvette"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].M[M],rotation={0,Units["Corellian Corvette"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Hammerhead Corvette") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Hammerhead Corvette"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].M[M],rotation={0,Units["Hammerhead Corvette"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Escort Carrier") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Escort Carrier"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].M[M],rotation={0,Units["Escort Carrier"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Light Freighter") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Light Freighter"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Light Freighter"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Rebel Transport") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Rebel Transport"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Rebel Transport"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"X%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["X-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["X-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Y%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Y-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Y-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"U%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["U-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["U-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"A%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["A-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["A-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"B%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["B-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["B-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Shield Generator") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Shield Generator"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Shield Generator"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Ion Cannon") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Ion Cannon"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Ion Cannon"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Golan Arms Turret") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Golan Arms Turret"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Golan Arms Turret"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Airspeeder") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Airspeeder"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Airspeeder"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Jedi Knight") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Jedi Knight"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Jedi Knight"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Wookiee Veteran") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Wookiee Veteran"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Wookiee Veteran"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Recruit") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Recruit"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Recruit"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Rebel Vanguard") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Rebel Vanguard"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Rebel Vanguard"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Rebel Trooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Rebel Trooper"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[2].S[S],rotation={0,Units["Rebel Trooper"].AngleY,0}})
				Tile.destruct()
			end--if
			for D=1,30 do coroutine.yield(0) end--for D
			--if new unit still exists (wasn't destroyed for going over supply limit)...
			if NewUnit != nil then
				--NewUnit.setGMNotes("Location:REBEL QUEUE 2;")
				NewUnit.setGMNotes(UpdateTag({Text=NewUnit.getGMNotes(),Tag="Location",Value="REBEL QUEUE 2"}))
				--shrink and highlight...
				NewUnit.setScale({NewUnit.getScale().x*0.5,NewUnit.getScale().y*0.5,NewUnit.getScale().z*0.5})
				if NewUnit.getVar("Theater") == "Space" then
					NewUnit.highlightOn({1,1,1})
				else
					NewUnit.highlightOn({1,0,0})
				end--if
			else--unit was destroyed, probably for going over the supply limit...
				--make a note for later...
			end--if
		end--for
		--wait for last unit to stop moving...
		RepCount = RepCount + 1
		if NewUnit != nil then repeat coroutine.yield(0) until not NewUnit.isSmoothMoving() end--if
		RepCount = RepCount - 1
		NewUnit = nil
		printToAll("----------------------------------------\nREBEL QUEUE 1\n----------------------------------------")
		L = 0
		M = 0
		S = 0
		for T,Tile in pairs(ScanForObjects({Description="Q:1;#",Origin={0,0.6,28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
			if Tile.getDescription() == nil then Tile.setDescription("") end--if
			printToAll(Tile.getName())
			if string.find(Tile.getName(),"Rebel Transport") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Rebel Transport"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Rebel Transport"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"X%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["X-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["X-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Y%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Y-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Y-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"U%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["U-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["U-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"A%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["A-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["A-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"B%-Wing") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["B-Wing"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["B-Wing"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Golan Arms Turret") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Golan Arms Turret"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Golan Arms Turret"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Airspeeder") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Airspeeder"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Airspeeder"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Wookiee Veteran") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Wookiee Veteran"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Wookiee Veteran"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Recruit") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Recruit"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Recruit"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Rebel Vanguard") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Rebel Vanguard"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Rebel Vanguard"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Rebel Trooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Rebel Trooper"].BagID).takeObject({smooth=true,position=Queues.Rebel.Board.Spots[1].S[S],rotation={0,Units["Rebel Trooper"].AngleY,0}})
				Tile.destruct()
			end--if
			for D=1,30 do coroutine.yield(0) end--for D
			--if new unit still exists (wasn't destroyed for going over supply limit)...
			if NewUnit != nil then
				--NewUnit.setGMNotes("Location:REBEL QUEUE 1;")
				NewUnit.setGMNotes(UpdateTag({Text=NewUnit.getGMNotes(),Tag="Location",Value="REBEL QUEUE 1"}))
				--shrink and highlight...
				NewUnit.setScale({NewUnit.getScale().x*0.5,NewUnit.getScale().y*0.5,NewUnit.getScale().z*0.5})
				if NewUnit.getVar("Theater") == "Space" then
					NewUnit.highlightOn({1,1,1})
				else
					NewUnit.highlightOn({1,0,0})
				end--if
			else--unit was destroyed, probably for going over the supply limit...
				--make a note for later...
			end--if
		end--for
		--wait for last unit to stop moving...
		RepCount = RepCount + 1
		if NewUnit != nil then repeat coroutine.yield(0) until not NewUnit.isSmoothMoving() end--if
		RepCount = RepCount - 1
		NewUnit = nil
		--flip rebel control panel over...
		RebelPanel.setRotation({0,0,0})
		PleaseWait({Panel=RebelPanel,Text="Waiting for Imperials\nto finish building...\n\n(Units will automatically\n slide down the queue)"})
		for D=1,66 do coroutine.yield(0) end--for (pause for a bit)
		Game.Flags.Build.Rebel = true	--we are done building flag true.
    	--advance to next step...
		NextStep = "RefreshPhase.V.ii.BuildUnits"
		Step = ""
	elseif Step == "RefreshPhase.V.ii.BuildImperialUnits" then
		--build imperial units...
		Game.Flags.Busy.Imperial = true
		local L = 0
		local M = 0
		local S = 0
		local NewUnit = nil
		local T = 0
		local Tile = nil
		printToAll("========================================\nIMPERIAL QUEUE 3\n----------------------------------------")
		for T,Tile in pairs(ScanForObjects({Description="Q:3;#",Origin={0,0.6,-28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
			if Tile.getDescription() == nil then Tile.setDescription("") end--if
			printToAll(Tile.getName())
			if string.find(Tile.getName(),"Star Destroyer") != nil then
				L=L+1
				NewUnit = getObjectFromGUID(Units["Star Destroyer"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].L[L],rotation={0,Units["Star Destroyer"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Assault Carrier") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Assault Carrier"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].M[M],rotation={0,Units["Assault Carrier"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Light Cruiser") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Light Cruiser"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].M[M],rotation={0,Units["Light Cruiser"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Fighter") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Fighter"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].S[S],rotation={0,Units["TIE Fighter"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Striker") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Striker"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].S[S],rotation={0,Units["TIE Striker"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Interceptor") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Interceptor"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].S[S],rotation={0,Units["TIE Interceptor"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Bomber") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Bomber"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].S[S],rotation={0,Units["TIE Bomber"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Lambda Shuttle") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Lambda Shuttle"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[3].S[S],rotation={0,Units["Lambda Shuttle"].AngleY,0}})
				Tile.destruct()
			end--if
			for D=1,30 do coroutine.yield(0) end--for D
			--if new unit still exists (wasn't destroyed for going over supply limit)...
			if NewUnit != nil then
				--shrink and highlight...
				NewUnit.setScale({NewUnit.getScale().x*0.5,NewUnit.getScale().y*0.5,NewUnit.getScale().z*0.5})
				if NewUnit.getVar("Theater") == "Space" then
					NewUnit.highlightOn({0.4,0.4,1})
				else
					NewUnit.highlightOn({1,0.5,0})
				end--if
				NewUnit.setGMNotes(UpdateTag({Text=NewUnit.getGMNotes(),Tag="Location",Value="IMPERIAL QUEUE 3"}))
			else--unit was destroyed, probably for going over the supply limit...
				--make a note for later...
			end--if
		end--for
		--wait for last unit to stop moving...
		RepCount = RepCount + 1
		if NewUnit != nil then repeat coroutine.yield(0) until not NewUnit.isSmoothMoving() end--if
		RepCount = RepCount - 1
		NewUnit = nil
		printToAll("----------------------------------------\nIMPERIAL QUEUE 2\n----------------------------------------")
		L = 0
		M = 0
		S = 0
		for T,Tile in pairs(ScanForObjects({Description="Q:2;#",Origin={0,0.6,-28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
			if Tile.getDescription() == nil then Tile.setDescription("") end--if
			printToAll(Tile.getName())
			if string.find(Tile.getName(),"Assault Carrier") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Assault Carrier"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].M[M],rotation={0,Units["Assault Carrier"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Light Cruiser") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["Light Cruiser"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].M[M],rotation={0,Units["Light Cruiser"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Fighter") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Fighter"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["TIE Fighter"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Striker") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Striker"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["TIE Striker"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Interceptor") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Interceptor"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["TIE Interceptor"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Bomber") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Bomber"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["TIE Bomber"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Lambda Shuttle") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Lambda Shuttle"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["Lambda Shuttle"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"AT%-AT") != nil then
				M=M+1
				NewUnit = getObjectFromGUID(Units["AT-AT"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].M[M],rotation={0,Units["AT-AT"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"AT%-ST") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["AT-ST"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["AT-ST"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Shield Bunker") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Shield Bunker"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["Shield Bunker"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Death Trooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Death Trooper"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["Death Trooper"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Assault Tank") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Assault Tank"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["Assault Tank"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Stormtrooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Stormtrooper"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["Stormtrooper"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Scout Trooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Scout Trooper"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[2].S[S],rotation={0,Units["Scout Trooper"].AngleY,0}})
				Tile.destruct()
			end--if
			for D=1,30 do coroutine.yield(0) end--for D
			--if new unit still exists (wasn't destroyed for going over supply limit)...
			if NewUnit != nil then
				--NewUnit.setGMNotes("Location:IMPERIAL QUEUE 2;")
				NewUnit.setGMNotes(UpdateTag({Text=NewUnit.getGMNotes(),Tag="Location",Value="IMPERIAL QUEUE 2"}))
				--shrink and highlight...
				NewUnit.setScale({NewUnit.getScale().x*0.5,NewUnit.getScale().y*0.5,NewUnit.getScale().z*0.5})
				if NewUnit.getVar("Theater") == "Space" then
					NewUnit.highlightOn({0.4,0.4,1})
				else
					NewUnit.highlightOn({1,0.5,0})
				end--if
            else--unit was destroyed, probably for going over the supply limit...
				--make a note for later...
			end--if
		end--for
		--wait for last unit to stop moving...
		RepCount = RepCount + 1
		if NewUnit != nil then repeat coroutine.yield(0) until not NewUnit.isSmoothMoving() end--if
		RepCount = RepCount - 1
		NewUnit = nil
		printToAll("----------------------------------------\nIMPERIAL QUEUE 1\n----------------------------------------")
		L = 0
		M = 0
		S = 0
		for T,Tile in pairs(ScanForObjects({Description="Q:1;#",Origin={0,0.6,-28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
			if Tile.getDescription() == nil then Tile.setDescription("") end--if
			printToAll(Tile.getName())
			if string.find(Tile.getName(),"TIE Fighter") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Fighter"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["TIE Fighter"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Striker") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Striker"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["TIE Striker"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Interceptor") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Interceptor"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["TIE Interceptor"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"TIE Bomber") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["TIE Bomber"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["TIE Bomber"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Lambda Shuttle") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Lambda Shuttle"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["Lambda Shuttle"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"AT%-ST") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["AT-ST"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["AT-ST"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Shield Bunker") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Shield Bunker"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["Shield Bunker"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Death Trooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Death Trooper"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["Death Trooper"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Assault Tank") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Assault Tank"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["Assault Tank"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Stormtrooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Stormtrooper"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["Stormtrooper"].AngleY,0}})
				Tile.destruct()
			elseif string.find(Tile.getName(),"Scout Trooper") != nil then
				S=S+1
				NewUnit = getObjectFromGUID(Units["Scout Trooper"].BagID).takeObject({smooth=true,position=Queues.Imperial.Board.Spots[1].S[S],rotation={0,Units["Scout Trooper"].AngleY,0}})
				Tile.destruct()
			end--if
			for D=1,30 do coroutine.yield(0) end--for D
			--if new unit still exists (wasn't destroyed for going over supply limit)...
			if NewUnit != nil then
				--NewUnit.setGMNotes("Location:IMPERIAL QUEUE 1;")
				NewUnit.setGMNotes(UpdateTag({Text=NewUnit.getGMNotes(),Tag="Location",Value="IMPERIAL QUEUE 1"}))
				--shrink and highlight...
				NewUnit.setScale({NewUnit.getScale().x*0.5,NewUnit.getScale().y*0.5,NewUnit.getScale().z*0.5})
				if NewUnit.getVar("Theater") == "Space" then
					NewUnit.highlightOn({0.4,0.4,1})
				else
					NewUnit.highlightOn({1,0.5,0})
				end--if
			else--unit was destroyed, probably for going over the supply limit...
				--make a note for later...
			end--if
		end--for
		--wait for last unit to stop moving...
		RepCount = RepCount + 1
		if NewUnit != nil then repeat coroutine.yield(0) until not NewUnit.isSmoothMoving() end--if
		RepCount = RepCount - 1
		NewUnit = nil
		--flip imperial control panel over...
		ImperialPanel.setRotation({0,180,0})
		PleaseWait({Panel=ImperialPanel,Text="Waiting for Rebels\nto finish building...\n\n(Units will automatically\n slide down the queue)"})
		for D=1,66 do coroutine.yield(0) end--for (pause for a bit)
		Game.Flags.Build.Imperial = true
		--advance to next step...
		NextStep = "RefreshPhase.V.ii.BuildUnits"
		Step = ""
	elseif Step == "RefreshPhase.V.ii.BuildUnits" then
		--have both factions finished building?
		if Game.Flags.Build.Rebel and Game.Flags.Build.Imperial then
			--destroy all build tiles and flip over panels...
			for T,Tile in pairs(getAllObjects()) do
				if Tile.getDescription() == nil then Tile.setDescription("") end--if
				if string.find(Tile.getDescription(),"BuildTile;") != nil then
					Tile.destruct()
				end--if
			end--for
			RebelPanel.setRotation({0,0,0})
			ImperialPanel.setRotation({0,180,0})
			for D=1,30 do coroutine.yield(0) end--for (pause for a bit to let units finish building)
			Game.Flags.Busy.Rebel = false
			Game.Flags.Busy.Imperial = false
			--advance to next step...
			NextStep = "RefreshPhase.VI.DeployRebelRecruits"
			Step = ""
		else
			if not Game.Flags.Busy.Imperial then BuildUnits({Faction="Imperial"}) end
			if not Game.Flags.Busy.Rebel then BuildUnits({Faction="Rebel"}) end
		end--if
	elseif Step == "RefreshPhase.VI.DeployRebelRecruits" then
		NextStep = "RefreshPhase.VI.DeployImperialRecruits"
		--go through all units on the board... 
		local RecruitList = {}
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getVar("Component") == "Unit" then
				if Obj.getName() == "Recruit" then
					if GetLoyalty({System=ReadTag({Text=Obj.getGMNotes(),Tag="Location",Default=""})}) == "Rebel" then
						Ping({Position=Obj.getPosition()})
						table.insert(RecruitList,Obj)
					end--if
				end--if
			end--if
		end--for O,Obj
		--recruits found in rebel loyal systems?
		if #RecruitList > 0 then
			printToAll("  Deploy "..#RecruitList.." Rebel Recruits...")
			--prompt players with menus...
			DeployRebelRecruits(RecruitList)
			PleaseWait({Panel=ImperialPanel,Text="Rebels are\nDeploying Recruits..."})
		else--continue on... 
			Step = ""
		end--if
	elseif Step == "RefreshPhase.VI.DeployImperialRecruits" then
		NextStep = "RefreshPhase.VI.DeployUnits"
		--go through all units on the board again... 
		local RecruitList = {}
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getVar("Component") == "Unit" then
				if Obj.getName() == "Recruit" then
					if GetLoyalty({System=ReadTag({Text=Obj.getGMNotes(),Tag="Location",Default=""})}) == "Imperial" then
						Ping({Position=Obj.getPosition()})
						table.insert(RecruitList,Obj)
					end--if
				end--if
			end--if
		end--for O,Obj
		--recruits found in imperial loyal systems?
		if #RecruitList > 0 then
			printToAll("  Deploy "..#RecruitList.." Imperial Recruits...")
			--prompt players with menus...
			DeployImperialRecruits(RecruitList)
			PleaseWait({Panel=RebelPanel,Text="Imperials are\nDeploying Recruits..."})
		else--continue on... 
			Step = ""
		end--if
	elseif Step == "RefreshPhase.VI.DeployUnits" then
		if not Game.Flags.Slid.Imperial then
			Game.Flags.Slid.Imperial = true
			printToAll("\nDeploy Units...")
			--loop thru all locations and init deployed counts...
			for L,Location in pairs(Locations) do
				Location.Units.Imperial.Deployed = 0
				Location.Units.Rebel.Deployed = 0
			end--for
			PleaseWait({Panel=RebelPanel,Text="Sliding Units down the Track..."})
			PleaseWait({Panel=ImperialPanel,Text="Sliding Units down the Track..."})
			--Slide Units down the track...
			printToAll("  Sliding Units down the track...")
			local LastUnit = nil
			--loop through every unit first to slide it...
			for U,Unit in pairs(getAllObjects()) do
				--is this object a unit?
				if Unit.getVar("Component") == "Unit" then
					if Unit.getGMNotes() == nil then Tile.getGMNotes("") end--if
					--is this unit on the track?
					if string.find(Unit.getGMNotes(),"Location:REBEL QUEUE 3;") != nil then
						Unit.setPositionSmooth({Unit.getPosition().x,Unit.getPosition().y+2,Unit.getPosition().z+3.5,},false,false)
						LastUnit = Unit
					elseif string.find(Unit.getGMNotes(),"Location:REBEL QUEUE 2;") != nil then
						Unit.setPositionSmooth({Unit.getPosition().x,Unit.getPosition().y+2,Unit.getPosition().z+3.7,},false,false)
						LastUnit = Unit
					elseif string.find(Unit.getGMNotes(),"Location:REBEL QUEUE 1;") != nil then
						Unit.setPositionSmooth({Unit.getPosition().x,Unit.getPosition().y+2,Unit.getPosition().z+3.8,},false,false)
						LastUnit = Unit
						if not UnitHighlights then Unit.highlightOff() end--if leave highlights on?						
					elseif string.find(Unit.getGMNotes(),"Location:IMPERIAL QUEUE 3;") != nil then
						Unit.setPositionSmooth({Unit.getPosition().x,Unit.getPosition().y+2,Unit.getPosition().z-3.5,},false,false)
						LastUnit = Unit
					elseif string.find(Unit.getGMNotes(),"Location:IMPERIAL QUEUE 2;") != nil then
						Unit.setPositionSmooth({Unit.getPosition().x,Unit.getPosition().y+2,Unit.getPosition().z-3.6,},false,false)
						LastUnit = Unit
					elseif string.find(Unit.getGMNotes(),"Location:IMPERIAL QUEUE 1;") != nil then
						Unit.setPositionSmooth({Unit.getPosition().x,Unit.getPosition().y+2,Unit.getPosition().z-3.8,},false,false)
						LastUnit = Unit
						if not UnitHighlights then Unit.highlightOff() end--if leave highlights on?						
					end--if
				end--if
			end--for
			--wait for last unit to finish sliding...
			if LastUnit != nil then
				RepCount = RepCount + 1
				repeat coroutine.yield(0) until not LastUnit.isSmoothMoving()
				RepCount = RepCount - 1
			end--if
			for D=1,60 do coroutine.yield(0) end--for Pause a bit
			--loop through every unit again to update it's location on the queue...
			for U,Unit in pairs(getAllObjects()) do
				if Unit.getDescription() == nil then Unit.setDescription("") end--if
				--is this object a unit?
				if string.find(Unit.getDescription(),"Unit;") != nil then
					--is this unit on the track or deployment?
					if string.find(Unit.getGMNotes(),"Location:REBEL QUEUE 3") != nil then
						Unit.setGMNotes(UpdateTag({Text=Unit.getGMNotes(),Tag="Location",Value="REBEL QUEUE 2"}))
					elseif string.find(Unit.getGMNotes(),"Location:REBEL QUEUE 2") != nil then
						Unit.setGMNotes(UpdateTag({Text=Unit.getGMNotes(),Tag="Location",Value="REBEL QUEUE 1"}))
					elseif string.find(Unit.getGMNotes(),"Location:REBEL QUEUE 1") != nil then
						Unit.setGMNotes(UpdateTag({Text=Unit.getGMNotes(),Tag="Location",Value="REBEL DEPLOYMENT"}))
						UnitFlagDeployment(Unit)
					elseif string.find(Unit.getGMNotes(),"Location:IMPERIAL QUEUE 3") != nil then
						Unit.setGMNotes(UpdateTag({Text=Unit.getGMNotes(),Tag="Location",Value="IMPERIAL QUEUE 2"}))
					elseif string.find(Unit.getGMNotes(),"Location:IMPERIAL QUEUE 2") != nil then
						Unit.setGMNotes(UpdateTag({Text=Unit.getGMNotes(),Tag="Location",Value="IMPERIAL QUEUE 1"}))
					elseif string.find(Unit.getGMNotes(),"Location:IMPERIAL QUEUE 1") != nil then
						Unit.setGMNotes(UpdateTag({Text=Unit.getGMNotes(),Tag="Location",Value="IMPERIAL DEPLOYMENT"}))
						UnitFlagDeployment(Unit)
					elseif string.find(Unit.getGMNotes(),"DEPLOYMENT") != nil or Unit.getGMNotes() == "" then
						UnitFlagDeployment(Unit)
					end--if
				end--if
			end--for
			NextStep = "RefreshPhase.VI.DeployRebelUnits"
			Step = ""
		end--if
	elseif Step == "RefreshPhase.VI.DeployRebelUnits" then
		printToAll("  Deploy Rebel Units...")
		--prompt players with menus...
		DeployRebelUnits({Error=""})
		PleaseWait({Panel=ImperialPanel,Text="Rebels are\nDeploying Units..."})
	elseif Step == "RefreshPhase.VI.DeployImperialUnits" then
		--return any undeployed rebel units back to queue 1...
		local X = 18.75
		local Y = 1
		local Z = 10
		for O,Obj in pairs(getAllObjects()) do
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
			if Obj.getPosition().z > 11 and Obj.getVar("Component") == "Unit" and string.find(Obj.getDescription(),"Rebel;") != nil and (string.find(Obj.getGMNotes(),"REBEL DEPLOYMENT;") != nil or Obj.getGMNotes() == "") then
			  --printToAll(Obj.getName().." was not Deployed. Returning to Rebel Queue 1.")
				Obj.setPositionSmooth({X,Y,Z},false,false)
				X = X + 0.5
				if X > 21.25 then
					X = 18.75
					Z = Z - 1
				end--if
				if Z < 9 then
					Z = 10
					Y = Y + 0.5
				end--if
				Obj.setRotation({0,0,0})
				Obj.setScale({Units[Obj.getName()].Scale[1]*0.5,Units[Obj.getName()].Scale[2]*0.5,Units[Obj.getName()].Scale[3]*0.5})
				--Obj.setGMNotes("Location:REBEL QUEUE 1;")
				Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="Location",Value="REBEL QUEUE 1"}))
			end--if
		end--for
		printToAll("  Deploy Imperial Units...")
		--prompt players with menus...
		DeployImperialUnits({Error=""})
		PleaseWait({Panel=RebelPanel,Text="Imperials are\nDeploying Units..."})
	elseif Step == "RefreshPhase.End" then
		--return any undeployed imperial units back to queue 1...
		local X = 18.75
		local Y = 1
		local Z = -10
		for O,Obj in pairs(getAllObjects()) do
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
			if Obj.getPosition().z < -11 and Obj.getVar("Component") == "Unit" and string.find(Obj.getDescription(),"Imperial;") != nil and (string.find(Obj.getGMNotes(),"IMPERIAL DEPLOYMENT;") != nil or Obj.getGMNotes() == "") then
				X = X + 0.5
				if X > 21.25 then
					X = 18.75
					Z = Z + 1
				end--if
				if Z > -9 then
					Z = -10
					Y = Y + 0.5
				end--if
				Obj.setPositionSmooth({X,Y,Z},false,false)
				Obj.setRotation({0,0,0})
				Obj.setScale({Units[Obj.getName()].Scale[1]*0.5,Units[Obj.getName()].Scale[2]*0.5,Units[Obj.getName()].Scale[3]*0.5})
				Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="Location",Value="IMPERIAL QUEUE 1"}))
			end--if
		end--for
		printToAll("End of Refresh Phase.")
		--remove deployment flags from all units and detained flag from any leaders...
		for O,Obj in pairs(getAllObjects()) do
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
			if Obj.getVar("Component") == "Unit" then
				Obj.clearButtons()
				Obj.setDescription(string.gsub(Obj.getDescription(),"Deploy;",""))
			elseif Obj.getVar("Component") == "Leader" then
				--detained?
				if string.find(Obj.getGMNotes(),"Detained;") != nil then
					--toggle off Detained tag...
					LeaderDetained(Obj)
				end--if
			end--if
		end--if
		--go to next step...
		NextStep = "AssignmentPhase.Start"
		Step = ""
	end--if
	--is setup done?
	if Game.Phase != "Setup" then
		SettingsMenu()
	end--if
	return 1
end--function

function RemoveComponent(Params)	--{ID="",BoxID=""}
	if Params.BoxID == nil then Params.BoxID = IDs.GameBox end--if
	if getObjectFromGUID(Params.ID) != nil then
		getObjectFromGUID(Params.ID).setLock(false)
		getObjectFromGUID(Params.BoxID).putObject(getObjectFromGUID(Params.ID))
	else 
		print("Could not Remove: ",Params.ID)
	end--if
end--function 

function Setup2PlayerGame()
  SetupPanel.clearButtons()
  Game.Players.Total = 2
	Game.Players.Rebels = 1
	Game.Players.Imperials = 1
	printToAll("\nThis will be a 2-Player game.")
	--is Imperial (blue) player seated?
	if Player["Blue"].seated then
		printToAll(Player["Blue"].steam_name.." is the Imperial Player (Blue).",Player["Blue"].color)
	else
		printToAll("No one is in the Imperial Player seat (Blue)!",Player["Blue"].color)
		if Player["Orange"].seated then
			Player["Orange"].changeColor("Blue")
			printToAll("Moved Orange Player to Blue Seat.")
		end--if red seat occupied. 
	end--if
	--is Rebel (White) player seated?
	if Player["White"].seated then
		printToAll(Player["White"].steam_name.." is the Rebel Player (White).",Player["White"].color)
	else
		printToAll("No one is in the Rebel Player seat (White)!",Player["White"].color)
		if Player["Red"].seated then
			Player["Red"].changeColor("White")
			printToAll("Moved Red Player to White Seat.")
		end--if red seat occupied. 
	end--if
	--remove extra seats... 
	if getObjectFromGUID("760c18") != nil then
		getObjectFromGUID("760c18").destruct()
		printToAll("Removed Red Player (Rebel General) seat.")
	end--if red seat exists 
	if getObjectFromGUID("a52532") != nil then
		getObjectFromGUID("a52532").destruct()
		printToAll("Removed Orange Player (Imperial General) seat.")
	end--if Orange seat exists 
	--init faction sheets...
	local FS = FindObject({Name="Rebel Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 5 then FS.setState(5) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 3 then FS.setState(3) end--if
		else
			if FS.getStateId() != 1 then FS.setState(1) end--if
		end--if
	end--if
	FS = FindObject({Name="Imperial Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 5 then FS.setState(5) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 3 then FS.setState(3) end--if
		else
			if FS.getStateId() != 1 then FS.setState(1) end--if
		end--if
	end--if
	--advance to next step...
  NextStep = "Setup.2.PrepareLeaders"
  Step = ""
end--function

function Setup3PlayerGame()
	SetupPanel.clearButtons()
  	Game.Players.Total = 3
	Game.Players.Rebels = 1
	Game.Players.Imperials = 2
	printToAll("\nThis will be a 3-Player game.\nAn Imperial Admiral and an Imperial General vs. a Rebel Player.")
	--is Imperial Admiral (blue) player seated?
	if Player["Blue"].seated then
		printToAll(Player["Blue"].steam_name.." is the Imperial Admiral Player (Blue).",Player["Blue"].color)
	else
		printToAll("No one is in the Imperial Admiral Player seat (Blue)!",Player["Blue"].color)
	end--if
	--is Imperial General (orange) player seated?
	if Player["Orange"].seated then
		printToAll(Player["Orange"].steam_name.." is the Imperial General Player (Orange).",Player["Orange"].color)
	else
		printToAll("No one is in the Imperial General Player seat (Orange)!",Player["Orange"].color)
	end--if
	--is Rebel (White) player seated?
	if Player["White"].seated then
		printToAll(Player["White"].steam_name.." is the Rebel Player (White).",Player["White"].color)
	else
		printToAll("No one is in the Rebel Player seat (White)!",Player["White"].color)
		if Player["Red"].seated then
			Player["Red"].changeColor("White")
			printToAll("Moved Red Player to White Seat.")
		end--if red seat occupied. 
	end--if
	--remove extra seats... 
	if getObjectFromGUID("760c18") != nil then
		getObjectFromGUID("760c18").destruct()
		printToAll("Removed Red Player (Rebel General) seat.")
	end--if red seat exists 
	Player["Blue"].team = "Spades"
	Player["Orange"].team = "Spades"
	Player["White"].team = "Hearts"
	--init faction sheets...
	local FS = FindObject({Name="Rebel Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 6 then FS.setState(6) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 4 then FS.setState(4) end--if
		else
			if FS.getStateId() != 2 then FS.setState(2) end--if
		end--if
	end--if
	FS = FindObject({Name="Imperial Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 6 then FS.setState(6) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 4 then FS.setState(4) end--if
		else
			if FS.getStateId() != 2 then FS.setState(2) end--if
		end--if
	end--if
	--advance to next step...
  	NextStep = "Setup.2.PrepareLeaders"
  	Step = ""
end--function

function Setup4PlayerGame()
	SetupPanel.clearButtons()
  	Game.Players.Total = 4
	Game.Players.Rebels = 2
	Game.Players.Imperials = 2
	printToAll("\nThis will be a 4-Player game.\nAn Imperial Admiral (Blue) and an Imperial General (Orange) vs. a Rebel Admiral (White) and a Rebel General (Red).")
	--is Imperial Admiral (Blue) player seated?
	if Player["Blue"].seated then
		printToAll(Player["Blue"].steam_name.." is the Imperial Admiral Player (Blue).",Player["Blue"].color)
	else
		printToAll("No one is in the Imperial Admiral Player seat (Blue)!",Player["Blue"].color)
	end--if
	--is Imperial General (Orange) player seated?
	if Player["Orange"].seated then
		printToAll(Player["Orange"].steam_name.." is the Imperial General Player (Orange).",Player["Orange"].color)
	else
		printToAll("No one is in the Imperial General Player seat (Orange)!",Player["Orange"].color)
	end--if
	--is Rebel Admiral (White) player seated?
	if Player["White"].seated then
		printToAll(Player["White"].steam_name.." is the Rebel Admiral Player (White).",Player["White"].color)
	else
		printToAll("No one is in the Rebel Admiral Player seat (White)!",Player["White"].color)
	end--if
	--is Rebel General (Red) player seated?
	if Player["Red"].seated then
		printToAll(Player["Red"].steam_name.." is the Rebel General Player (Red).",Player["Red"].color)
	else
		printToAll("No one is in the Rebel General Player seat (Red)!",Player["Red"].color)
	end--if
	Player["Blue"].team = "Spades"
	Player["Orange"].team = "Spades"
	Player["White"].team = "Hearts"
	Player["Red"].team = "Hearts"
	local FS = FindObject({Name="Rebel Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 6 then FS.setState(6) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 4 then FS.setState(4) end--if
		else
			if FS.getStateId() != 2 then FS.setState(2) end--if
		end--if
	end--if
	FS = FindObject({Name="Imperial Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 6 then FS.setState(6) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 4 then FS.setState(4) end--if
		else
			if FS.getStateId() != 2 then FS.setState(2) end--if
		end--if
	end--if
	--advance to next step...
  	NextStep = "Setup.2.PrepareLeaders"
  	Step = ""
end--function

function Setup1PlayerGame()
	SetupPanel.clearButtons()
	Game.Players.Total = 2
	Game.Players.Rebels = 1
	Game.Players.Imperials = 1
	Game.AI.Active = true
	printToAll("\nThis will be a solo game (Rebel (White) Player vs Imperial AI).")
	--is Rebel (White) player seated?
	if Player["White"].seated then
		printToAll(Player["White"].steam_name.." is the Rebel Player (White).",Player["White"].color)
	else
		printToAll("No one is in the Rebel Player seat (White)!",Player["White"].color)
	end--if
	--init faction sheets...
	local FS = FindObject({Name="Rebel Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 5 then FS.setState(5) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 3 then FS.setState(3) end--if
		else
			if FS.getStateId() != 1 then FS.setState(1) end--if
		end--if
	end--if
	FS = FindObject({Name="Imperial Faction Sheet"})
	if FS != nil then
		if Game.Flags.WFL then
			if FS.getStateId() != 5 then FS.setState(5) end--if
		elseif Game.Flags.RotE then
			if FS.getStateId() != 3 then FS.setState(3) end--if
		else
			if FS.getStateId() != 1 then FS.setState(1) end--if
		end--if
	end--if
	printToAll("Imperial AI: I am ready.",{0.5,0.5,1})
	--advance to next step...
	NextStep = "Setup.2.PrepareLeaders"
	Step = ""
end--function

function GetLeader(Params)	--{Name="Admiral Motti",Smooth=true,Position={0,0.7,=24.5},Rotation={0,180,0},BagOnly=false}
	--returns a leader's object if found...
	if Params.Name != nil then
		if Params.BagOnly == nil then Params.BagOnly = false end--if
		if Params.Rotation == nil then Params.Rotation = {0,0,0} end--if
		if Params.Position == nil then Params.Position = {0,0.7,0} end--if
		if Params.Smooth == nil then Params.Smooth = false end--if
		--look in play?...
		if not Params.BagOnly then
			--look for leader in play...
			for O,Obj in pairs(getAllObjects()) do
				if Obj.getName() == Params.Name and Obj.getVar("Component") == "Leader" then
					Obj.setRotation(Params.Rotation)
					if Params.Smooth then
						Obj.setPositionSmooth(Params.Position,false,false)
					else--not smooth...
						Obj.setPosition(Params.Position)
					end--if
					return Obj
				end--if
			end--for
		end--if
		--look in rebel leader bag...
		for I,Item in pairs(getObjectFromGUID(IDs.Rebel.LeaderBag).getObjects()) do
			if Item.name == Params.Name then
				return getObjectFromGUID(IDs.Rebel.LeaderBag).takeObject({guid=Item.guid,smooth=Params.Smooth,position=Params.Position,rotation=Params.Rotation})
			end--if
		end--for
		--look in imperial leader bag...
		for I,Item in pairs(getObjectFromGUID(IDs.Imperial.LeaderBag).getObjects()) do
			if Item.name == Params.Name then
				return getObjectFromGUID(IDs.Imperial.LeaderBag).takeObject({guid=Item.guid,smooth=Params.Smooth,position=Params.Position,rotation=Params.Rotation})
			end--if
		end--for
	else	--no name specified...
		return nil
	end--if
end--function

function RetrieveLeaders()
	--retrieve leaders back to leader pool, exclude captured/carbonite,detained...
	function RetrieveLeadersCoroutine()
		log("Started RetrieveLeaders() Coroutine.")
		RetrievingLeaders = true
		--update the faction sheet ids incase the user changed the sheet states accidentally.
		Game.FactionSheets.Rebel.ID = FindObject({Name="Rebel Faction Sheet"}).getGUID()
		Game.FactionSheets.Imperial.ID = FindObject({Name="Imperial Faction Sheet"}).getGUID()
		local RebelAdmiralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getTable("AdmiralOffset"),Angle=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getPosition().y})
		local RebelGeneralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getTable("GeneralOffset"),Angle=getObjectFromGUID(Game.FactionSheets.Rebel.ID).getPosition().y})
		local ImperialAdmiralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getTable("AdmiralOffset"),Angle=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getPosition().y})
		local ImperialGeneralSpot = CalcSpot({Spot=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getPosition(),Offset=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getTable("GeneralOffset"),Angle=getObjectFromGUID(Game.FactionSheets.Imperial.ID).getPosition().y})
		local RingGap = 0.25
		local Gap = 0.75
		--wait a few frames (in case leaders are going back into storage)...
		for D=1,60 do coroutine.yield(0) end--for D
		--search for Leaders and retrieve them if able..
		for O,Obj in pairs(getAllObjects()) do
			if Obj.getName() == nil then Obj.setName("") end--if
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
			if Obj.getVar("Component") == "Leader" then
				log(" Found Leader:"..Obj.getName()..":"..Obj.getGUID())
				local ReturnOK = true
				local HasRing = false
				local Lured = false
				log("  Checking "..Obj.getName().." for a Ring.")
				--does this leader have an attachment?
				for I,Item in pairs(Obj.getAttachments()) do
					--ring?
					if string.find(Item.description,"Ring;") != nil then
						log("   "..Obj.getName().." has Ring:"..Item.name..".")
						HasRing = true
						--captured/frozen/lured?
						if Item.name == "Captured" then
							printToAll(Obj.getName().." is Captured and cannot return.")
							Obj.setVar("Captured",true)
							ReturnOK = false
						elseif Item.name == "Carbonite" then
							printToAll(Obj.getName().." is Frozen in Carbonite and cannot return.")
							Obj.setVar("Captured",true)
							Obj.setVar("Carbonite",true)
							ReturnOK = false
						elseif Item.name == "Lure of the Dark Side" then
							printToAll(Obj.getName().." was Lured to the Dark Side, and is under Imperial control.")
							Obj.setVar("Faction","Imperial")
							Obj.setVar("Lured",true)
							Lured = true
						end--if
					end--if
				end--for
				--detained?
				log("  Checking if "..Obj.getName().." is Detained.")
				if string.find(Obj.getGMNotes(),"Detained;") != nil then
					printToAll(Obj.getName().." is Detained and cannot return.")
					ReturnOK = false
				end--if
				--Leader is OK to return and an Admiral...
				log("  "..Obj.getName().." is OK to return.")
				if ReturnOK then
					--clear old location... 
					log("  Clearing Location from: "..Obj.getName()..":"..Obj.getGUID()..".")
					Obj.setGMNotes("")
					if string.find(Obj.getDescription(),"Admiral;") != nil then
						--imperial or lured?
						if string.find(Obj.getDescription(),"Imperial;") != nil or Lured then
							log("  "..Obj.getName().." is an Imperial Admiral.")
							if HasRing then ImperialAdmiralSpot.z = ImperialAdmiralSpot.z - RingGap end--if
							Obj.setRotation({0,180,0})
							--Obj.setPosition({Obj.getPosition().x,3,Obj.getPosition().z})
							Obj.setPositionSmooth({ImperialAdmiralSpot.x,3,ImperialAdmiralSpot.z},false,false)
							--Obj.setRotationSmooth({0,180,0},false,false)
							if HasRing then ImperialAdmiralSpot.z = ImperialAdmiralSpot.z - RingGap end--if
							ImperialAdmiralSpot.z = ImperialAdmiralSpot.z - Gap
						else--must be rebel admiral...
							log("  "..Obj.getName().." is a Rebel Admiral.")
							if HasRing then RebelAdmiralSpot.z = RebelAdmiralSpot.z + RingGap end--if
							Obj.setRotation({0,0,0})
							--Obj.setPosition({Obj.getPosition().x,3,Obj.getPosition().z})
							Obj.setPositionSmooth({RebelAdmiralSpot.x,3,RebelAdmiralSpot.z},false,false)
							--Obj.setRotationSmooth({0,0,0},false,false)
							if HasRing then RebelAdmiralSpot.z = RebelAdmiralSpot.z + RingGap end--if
							RebelAdmiralSpot.z = RebelAdmiralSpot.z + Gap
						end--if
						coroutine.yield(0)
					elseif string.find(Obj.getDescription(),"General;") != nil then
						--imperial or lured?
						if string.find(Obj.getDescription(),"Imperial;") != nil or Lured then
							log("  "..Obj.getName().." is an Imperial General.")
							if HasRing then ImperialGeneralSpot.z = ImperialGeneralSpot.z - RingGap end--if
							Obj.setRotation({0,180,0})
							--Obj.setPosition({Obj.getPosition().x,3,Obj.getPosition().z})
							Obj.setPositionSmooth({ImperialGeneralSpot.x,3,ImperialGeneralSpot.z},false,false)
							--Obj.setRotationSmooth({0,180,0},false,false)
							if HasRing then ImperialGeneralSpot.z = ImperialGeneralSpot.z - RingGap end--if
							ImperialGeneralSpot.z = ImperialGeneralSpot.z - Gap
						else--must be rebel general...
							log("  "..Obj.getName().." is a Rebel General.")
							if HasRing then RebelGeneralSpot.z = RebelGeneralSpot.z + RingGap end--if
							Obj.setRotation({0,0,0})
							--Obj.setPosition({Obj.getPosition().x,3,Obj.getPosition().z})
							Obj.setPositionSmooth({RebelGeneralSpot.x,3,RebelGeneralSpot.z},false,false)
							--Obj.setRotationSmooth({0,0,0},false,false)
							if HasRing then RebelGeneralSpot.z = RebelGeneralSpot.z + RingGap end--if
							RebelGeneralSpot.z = RebelGeneralSpot.z + Gap
						end--if
					end--if
					coroutine.yield(0)
				else--not OK to return...
					log("  "..Obj.getName().." should not return to the Pool.")
					coroutine.yield(0)
				end--if
			end--if
		end--for
		coroutine.yield(0)
		RetrievingLeaders = false
		log("Ended RetrieveLeaders() Coroutine.")
		return 1
	end--function
	startLuaCoroutine(Global,"RetrieveLeadersCoroutine")
end--function

function ReadTag(Params) --{Text="",Tag="",Default=""}
  --returns a value read from a line of text:  ex: System:ABCDE; will return ABCDE,or the default value if not found...
  if Params.Default == nil then Params.Default = "" end--if
  local TagValue=string.match(Params.Text,Params.Tag..":.-;")
  if TagValue == nil then
    return Params.Default
  else
    TagValue=string.sub(TagValue,string.len(Params.Tag)+2,-2)
    return TagValue
  end--if
end--function

function RemoveTag(Params) --{Text="",Tag=""} return the new text string.
	if Params.Text == nil then
		return ""
	end--if
	local TagString = string.match(Params.Text,Params.Tag..":.-;")
	if TagString == nil then
		return Params.Text
	else
		return string.gsub(Params.Text,TagString,"")
	end--if
end--function

function UpdateTag(Params)  --{Text="",Tag="",Value=""}  return the new text string.
	local TagString = string.match(Params.Text,Params.Tag..":.-;")
	if TagString == nil then
		return Params.Text..Params.Tag..":"..Params.Value..";"
	else
		return string.gsub(Params.Text,TagString,Params.Tag..":"..Params.Value..";")
	end--if
end--function

function FindObject(Params)  --{Note="",Name="",Description="",Tag=""}
  --return the first object found matching the criteria...
  if Params.Tag == nil then Params.Tag = "" end--if
  if Params.Name == nil then Params.Name = "" end--if
  if Params.Description == nil then Params.Description = "" end--if
  for _,Obj in pairs(getAllObjects()) do
	if Obj.getName() == nil then Obj.setName("") end--if
	if Obj.getDescription() == nil then Obj.setDescription("")  end--if
    if (Params.Tag == "" or string.find(Obj.tag,Params.Tag) != nil) and (Params.Name == "" or string.find(Obj.getName(),Params.Name) != nil) and (Params.Description == "" or string.find(Obj.getDescription(),Params.Description) != nil) then
      return Obj
    end--if
  end--for
  return nil
end--function

function FindObjects(Params)  --{Tag="",Name="",Description=""}
  --return a table of objects matching the criteria...
  if Params.Tag == nil then Params.Tag = "" end--if
  if Params.Name == nil then Params.Name = "" end--if
  if Params.Description == nil then Params.Description = "" end--if
  local Result = {}
  for _,Obj in pairs(getAllObjects()) do
	if Obj.getName() == nil then Obj.setName("") end--if
	if Obj.getDescription() == nil then Obj.setDescription("")  end--if
    if (Params.Tag == "" or string.find(Obj.tag,Params.Tag) != nil) and (Params.Name == "" or string.find(Obj.getName(),Params.Name) != nil) and (Params.Description == "" or string.find(Obj.getDescription(),Params.Description) != nil) then
      table.insert(Result,Obj)
    end--if
  end--for
  return Result
end--function

function ScanForObjectID(Params) --{Tag="",Name="",Description="",Origin={0,0,0},Orientation={0,0,0},Size={1,1,1},Debug=false,Type=2}
  --returns the guid of the first object found containing description,or "" if no match...
  if Params.Debug == nil then Params.Debug=false end--if
  if Params.Orientation == nil then Params.Orientation={0,0,0} end--if
  if Params.Size == nil then Params.Size={1,1,1} end--if
  if Params.Type == nil then Params.Type=2 end--if
  if Params.Tag == nil then Params.Tag = "" end--if
  if Params.Description == nil then Params.Description = "" end--if
  if Params.Name == nil then Params.Name = "" end--if
  if Params.Origin == nil then Params.Origin = {0,0,0} end--if
  for O,Obj in pairs(Physics.cast({origin=Params.Origin,orientation=Params.Orientation,direction={0,1,0},type=Params.Type,size=Params.Size,max_distance=0,debug=Params.Debug})) do
	if Obj.hit_object.getName() == nil then Obj.hit_object.setName("") end--if
	if Obj.hit_object.getDescription() == nil then Obj.hit_object.setDescription("") end--if
	if Obj.hit_object.getGMNotes() == nil then Obj.hit_object.setGMNotes("") end--if
    if (Params.Description == "" or string.find(Obj.hit_object.getDescription(),Params.Description)) and
       (Params.Name == "" or string.find(Obj.hit_object.getName(),Params.Name)) and
       (Params.Tag == "" or Obj.hit_object.tag == Params.Tag) then
      return Obj.hit_object.getGUID()
    end--if
  end--for
  return ""
end--function

function ScanForObject(Params) --{Tag="",Name="",Description="",Origin={0,0,0},Orientation={0,0,0},Size={1,1,1},Debug=false,Type=2}
  --returns the first object found containing any specified tag, name, and description, otherwise returns nil if no match...
  if Params.Debug == nil then Params.Debug=false end--if
  if Params.Orientation == nil then Params.Orientation={0,0,0} end--if
  if Params.Size == nil then Params.Size={1,1,1} end--if
  if Params.Type == nil then Params.Type=2 end--if
  if Params.Tag == nil then Params.Tag = "" end--if
  if Params.Description == nil then Params.Description = "" end--if
  if Params.Name == nil then Params.Name = "" end--if
  for O,Obj in pairs(Physics.cast({origin=Params.Origin,orientation=Params.Orientation,direction={0,1,0},type=Params.Type,size=Params.Size,max_distance=0,debug=Params.Debug})) do
	if Obj.hit_object.getName() == nil then Obj.hit_object.setName("") end--if
	if Obj.hit_object.getDescription() == nil then Obj.hit_object.setDescription("") end--if
	if Obj.hit_object.getGMNotes() == nil then Obj.hit_object.setGMNotes("") end--if
    if (Params.Description == "" or string.find(Obj.hit_object.getDescription(),Params.Description)) and
       (Params.Name == "" or string.find(Obj.hit_object.getName(),Params.Name)) and
       (Params.Tag == "" or Obj.hit_object.tag == Params.Tag) then
      return Obj.hit_object
    end--if
  end--for
  return nil
end--function

function ScanForObjects(Params) --{Tag="",Name="",Description="",Origin={0,0,0},Orientation={0,0,0},Size={1,1,1},Debug=false,Type=2}
  --returns a list of objects found containing any specified tag, name, and description, otherwise returns empty table if no matches...
  if Params.Debug == nil then Params.Debug=false end--if
  if Params.Orientation == nil then Params.Orientation={0,0,0} end--if
  if Params.Size == nil then Params.Size={1,1,1} end--if
  if Params.Type == nil then Params.Type=2 end--if
  if Params.Tag == nil then Params.Tag = "" end--if
  if Params.Description == nil then Params.Description = "" end--if
  if Params.Name == nil then Params.Name = "" end--if
  ObjList = {}
  for O,Obj in pairs(Physics.cast({origin=Params.Origin,orientation=Params.Orientation,direction={0,1,0},type=Params.Type,size=Params.Size,max_distance=0,debug=Params.Debug})) do
	if Obj.hit_object.getName() == nil then Obj.hit_object.setName("") end--if
	if Obj.hit_object.getDescription() == nil then Obj.hit_object.setDescription("") end--if
	if Obj.hit_object.getGMNotes() == nil then Obj.hit_object.setGMNotes("") end--if
    if (Params.Description == "" or string.find(Obj.hit_object.getDescription(),Params.Description)) and
       (Params.Name == "" or string.find(Obj.hit_object.getName(),Params.Name)) and
       (Params.Tag == "" or Obj.hit_object.tag == Params.Tag) then
      table.insert(ObjList,Obj.hit_object)
    end--if
  end--for
  return ObjList
end--function

function SetGameState(Params)	--{Round=1,Phase="",TurnNum=1,Step=""}
	if Params.Round != nil then
		printToAll("Game Round changed from "..Game.Round.." to "..Params.Round..".",{1,1,0})
		Game.Round = Params.Round
	end--if
	if Params.Phase != nil then
		printToAll("Game Phase changed from '"..Game.Phase.."' to '"..Params.Phase.."'.",{1,1,0})
		Game.Phase = Params.Phase
	end--if
	if Params.TurnNum != nil then
		local TurnFaction = "Rebel"
		local TurnRole = "Admiral"
		if Params.TurnNum == 2 then
			TurnFaction = "Imperial"
		elseif Params.TurnNum == 3 then
			TurnFaction = "Imperial"
			TurnRole = "General"
		elseif Params.TurnNum == 4 then
			TurnRole = "General"
		end--if
		if Game.Players.Total <= 2 then
			TurnRole = "Player"
		end--if
		printToAll("Game Turn changed from ("..Game.Turn.Num..") "..Game.Turn.Faction.." "..Game.Turn.Role.." to ("..Params.TurnNum..")"..TurnFaction.." "..TurnRole..".",{1,1,0})
		Game.Turn.Num = Params.Turn.Num
		Game.Turn.Faction = TurnFaction
		Game.Turn.Role = TurnRole
	end--if
	if Params.Step != nil then
		printToAll("Game Step changed from '"..Step.."' to '"..Params.Step.."'.",{1,1,0})
		Step = Params.Step
	end--if
	--is setup done? then update settings panel display...
	if Game.Phase != "Setup" then
		SettingsMenu()
	end--if
end--function

function CalcSpot(Params)     --Spot,Offset,Angle
  --calculates where the spot should be from offset and angle...
  local Spot = Params.Spot
  local Offset = Params.Offset
  local Angle = Params.Angle
  Spot[1]=Spot[1]+(Offset[3]*math.sin(Angle*math.pi/180)+Offset[1]*math.cos(Angle*math.pi/180))
  Spot[2]=Spot[2]+Offset[2]
  Spot[3]=Spot[3]+(Offset[3]*math.cos(Angle*math.pi/180)-Offset[1]*math.sin(Angle*math.pi/180))
  return Spot
end--function

function GetGrid(Params)  --{Position={x,y,z}}
  --returns gridsquare when passed a board position...
  if Params.Position != nil then
		if Params.Position[1] != nil then
			local X = math.floor((Params.Position[1]+22)/GridSquareWidthRatio)
	    local Z = math.floor((-Params.Position[3]+11)/GridSquareHeightRatio)
	    if Grid[X] != nil then
	      if Grid[X][Z] != nil then
	        return Grid[X][Z]
	      end
	    end
		end--if
  end--if
  return {SquareSpot={0,0},PixelSpot={0,0},Location="",Occupant="",Theater=""}
end--function

function MoveObjectsFromBagToBag(Params)	--{FromBagID="",ToBagID="",ID="",Name="",Description="",ExcludeDescription="",Limit=999}
	--make sure both bags exist...
	if getObjectFromGUID(Params.FromBagID) != nil and getObjectFromGUID(Params.ToBagID) != nil then
		if Params.ID == nil then Params.ID = "" end--if
		if Params.Name == nil then Params.Name = "" end--if
	    if Params.Description == nil then Params.Description = "" end--if
	    if Params.ExcludeDescription == nil then Params.ExcludeDescription = "" end--if (do not remove if the description contains this text)
		if Params.Limit == nil then Params.Limit = 999 end--if (only remove up to the limit number of cards matching the criteria)
		local TempItem = nil
		for _,TempItem in pairs(getObjectFromGUID(Params.FromBagID).getObjects()) do
			if (Params.ID == "" or TempItem.guid == Params.ID) and (Params.Name == "" or TempItem.name == Params.Name) and (Params.Description == "" or string.find(TempItem.description,Params.Description) != nil) and (Params.ExcludeDescription == "" or string.find(TempItem.description,Params.ExcludeDescription) == nil) then
				getObjectFromGUID(Params.ToBagID).putObject(getObjectFromGUID(Params.FromBagID).takeObject({guid=TempItem.guid}))
				Params.Limit = Params.Limit - 1
				if Params.Limit == 0 then
					return true
				end--if
	   		end--if
		end--for
	else
		print("ERROR (MoveObjectsFromBagToBag): From/To Bag missing.")
	end--if
end--function

function GetObjectFromBag(Params)	--{BagID="",ID="",Name="",Description="",Position={x,y,z},Rotation={x,y,z},Smooth=true}
	--returns the first matching object from the container or nil if not found...
	--make sure both bags exist...
	if getObjectFromGUID(Params.BagID) != nil then
		if Params.ID == nil then Params.ID = "" end--if
		if Params.Name == nil then Params.Name = "" end--if
		if Params.Description == nil then Params.Description = "" end--if
		if Params.Smooth == nil then Params.Smooth=true end--if
		local TempItem = nil
		for _,TempItem in pairs(getObjectFromGUID(Params.BagID).getObjects()) do
			if (Params.ID == "" or TempItem.guid == Params.ID) and (Params.Name == "" or string.find(TempItem.name,Params.Name) != nil) and (Params.Description == "" or string.find(TempItem.description,Params.Description) != nil) then
				local TempObj = getObjectFromGUID(Params.BagID).takeObject({guid=TempItem.guid})
				if Params.Position != nil then
					TempObj.setPosition(Params.Position)				
				end--if
				if Params.Rotation != nil then
					TempObj.setRotation(Params.Rotation)				
				end--if
				return TempObj
			end--if
		end--for
	end--if
	return nil
end--function

function GatherToBag(Params)  --{BagID="",ID="",Name="",Description=""}
	--look through at all objects in play and in containers, and place them in a target bag...
	if getObjectFromGUID(Params.BagID) != nil then
		if Params.ID == nil then Params.ID = "" end--if
	  if Params.Name == nil then Params.Name = "" end--if
	  if Params.Description == nil then Params.Description = "" end--if
		local TempObj = nil
		local TempItem = nil
		for _,TempObj in pairs(getAllObjects()) do
			 --if the current object is a (non-infinite) bag or deck, and not the target bag...
			 --if (TempObj.tag == "Bag" or TempObj.tag == "Deck") and TempObj.getQuantity() > 0 and TempObj.getGUID() != Params.BagID then
  		 if (TempObj.tag == "Bag") and TempObj.getQuantity() > 0 and TempObj.getGUID() != Params.BagID then
				 --loop through items in the sub-container...
				 for _,TempItem in pairs(TempObj.getObjects()) do
					 --make sure the sub-container still exists...
					 if TempObj != nil then
						 --if the item matches the search...
						 if (Params.ID == "" or TempItem.guid == Params.ID) and (Params.Name == "" or string.find(TempItem.name,Params.Name) != nil) and (Params.Description == "" or string.find(TempItem.description,Params.Description) != nil) then
							 getObjectFromGUID(Params.BagID).putObject(TempObj.takeObject({guid=TempItem.guid,smooth=true,position=getObjectFromGUID(Params.BagID).getPosition()}))
				     end--if
					 end--if
				 end--for
			 elseif (Params.ID == "" or TempObj.getGUID() == Params.ID) and (Params.Name == "" or string.find(TempObj.getName(),Params.Name) != nil) and (Params.Description == "" or string.find(TempObj.getDescription(),Params.Description) != nil) then
				 getObjectFromGUID(Params.BagID).putObject(TempObj)
			 end--if
		 end--for
	end--if
end--function

function SetLoyalty(Params)	--{System="",Loyalty="",Subjugated=false,Ping=false}
	--sets the system's loyalty...
	if Params.Subjugated == nil then Params.Subjugated = false end--if
	if Params.Ping == nil then Params.Ping = false end--if
	if Params.System != nil then
		--exclude remote, coruscant, and rebel base...
		if Params.System == "CORUSCANT" or Params.System == "REBEL BASE" then
			print("Cannot change Loyalty of ",Params.System)
		elseif Locations[Params.System] != nil then
			if Locations[Params.System].Subtype != "Populous" then
				print("Cannot change Loyalty of ",Params.System, " because it is not Populous.")
			else
				Locations[Params.System].Loyalty = Params.Loyalty
				--get markerid
				local MarkerID = ScanForObjectID({Description="LoyaltyMarker;",Origin=Locations[Params.System].MarkerSpot,Debug=false})
				if Params.Ping then
					Ping({Position=Locations[Params.System].MarkerSpot})
				end--if
				--subjugated?
				if Params.Subjugated and Params.Loyalty != "Imperial" then
					getObjectFromGUID(MarkerID).setRotationSmooth({0,180,180},false,false)
					Locations[Params.System].Subjugated = true
				else
					getObjectFromGUID(MarkerID).setRotationSmooth({0,180,0},false,false)
				end--if
				getObjectFromGUID(MarkerID).setPositionSmooth(Locations[Params.System].MarkerSpot,false,true)
				--set marker to Loyalty
				if Params.Loyalty == "Rebel" and getObjectFromGUID(MarkerID).getStateId() != 3 then
					--rebel loyal...
					getObjectFromGUID(MarkerID).setState(3)
				elseif Params.Loyalty == "Imperial" and getObjectFromGUID(MarkerID).getStateId() != 1  then
					--imperial loyal...
					getObjectFromGUID(MarkerID).setState(1)
				elseif getObjectFromGUID(MarkerID).getStateId() != 2 then
					--neutral...
					getObjectFromGUID(MarkerID).setState(2)
				end--if
			end--if
		end--if
	end--if
end--function

function GetLoyalty(Params)	--{System=""}
	--returns the system's loyalty...
	local Loyalty = "Neutral"
	if Params.System != nil then
		--exclude remote, coruscant, and rebel base...
		if Params.System == "CORUSCANT" then
			Loyalty = "Imperial"
		elseif Params.System == "REBEL BASE" then
			Loyalty = "Rebel"
		elseif Locations[Params.System] != nil then
			if Locations[Params.System].Subtype != "Populous" then
				Loyalty = "Neutral"
			else
				--get markerid
				local MarkerID = ScanForObjectID({Description="LoyaltyMarker;",Origin=Locations[Params.System].MarkerSpot,Debug=false})
				if getObjectFromGUID(MarkerID) != nil then
					if getObjectFromGUID(MarkerID).getDescription() == nil then getObjectFromGUID(MarkerID).setDescription("") end--if
					if string.find(getObjectFromGUID(MarkerID).getDescription(),"Imperial;") != nil then
						Loyalty = "Imperial"
					elseif string.find(getObjectFromGUID(MarkerID).getDescription(),"Rebel;") != nil then
						Loyalty = "Rebel"
					else 
						Loyalty = "Neutral"
					end--if
					--update loyalty in the table... 
					Locations[Params.System].Loyalty = Loyalty
				end--if
			end--if
		end--if
	end--if
	return Loyalty
end--function

function GetDeck(DeckTitle)
	local Deck = getObjectFromGUID(Decks[DeckTitle].ID)
	--if the deck was not found, try to find it...
	if Deck == nil then
		--scan for a deck at the deck's location...
		Deck = ScanForObject({Tag="Deck",Origin=Decks[DeckTitle].Spot})
		if Deck != nil then
			Deck.setName(Decks[DeckTitle].DeckName)
			Deck.setDescription(Decks[DeckTitle].DeckTag)
			Decks[DeckTitle].ID = Deck.getGUID()	--update deck guid.
        else--look for card there... 
            Deck = ScanForObject({Tag="Card",Origin=Decks[DeckTitle].Spot})
		end--if
	end--if
	if Deck != nil then
		if Deck.getName() == nil then Deck.setName("") end--if
		if Deck.getDescription() == nil then Deck.setDescription("") end--if
		if Deck.getGMNotes() == nil then Deck.setGMNotes("") end--if
	end--if
	return Deck
end--function

function DrawFromDeck(Params)--{Deck="Objective",Smooth=true,Position={x,y,z},Rotation={x,y,z},Hidden={"Blue","Orange"}}
  local Deck = getObjectFromGUID(Decks[Params.Deck].ID)
  local Card = nil
  --does the specified deck exist?
  if Deck != nil then
    Card = Deck.takeObject()
  else--look in the spot...
    for O,Obj in pairs(Physics.cast({origin=Decks[Params.Deck].Spot,orientation={0,0,0},direction={0,1,0},type=3,size={1,1,1},max_distance=0,debug=false})) do
      if Obj.hit_object.type == "Deck" then
        Card = Obj.hit_object.takeObject()
        break
      elseif Obj.hit_object.type == "Card" then
        Card = Obj.hit_object
        break
      end--if
    end--for O,Obj
  end--if
  if Card != nil then
    if Params.Rotation == nil then
      Params.Rotation = Card.getRotation()
    end--if
    if Params.Smooth != false then
      Card.setPositionSmooth(Params.Position,false,false)
      Card.setRotationSmooth(Params.Rotation,false,false)
    else
      Card.setPosition(Params.Position)
      Card.setRotation(Params.Rotation)
    end--if
    if Params.Hidden != nil then
      Card.setHiddenFrom(Params.Hidden)
    end--if
  end--if
  return Card
end--function 

function DealToHand(Params)	--{Deck="",Player="",Index=0,Qty=1,Flip=true}
	function DealToHandCoroutine()
		RepCount = RepCount + 1
		local TimeOut = 500
		repeat 
			coroutine.yield(0) 
			TimeOut = TimeOut - 1
		until not Game.Flags.Dealing or TimeOut <= 0
		if TimeOut <= 0 then
			printToAll("Uhoh! Timed out waiting for script to deal a card.  Attempting to resume script...",{1,0.5,0.25})
		end--if
		RepCount = RepCount - 1
  		Game.Flags.Dealing = true
		if Params.Qty == nil then Params.Qty = 1 end--if
		if Params.Flip == nil then Params.Flip = true end--if
		--try to find the deck by it's id...
		local Deck = GetDeck(Params.Deck)
		--does the deck exist?
		if Deck != nil then
            --is the deck only a single card?
            if Deck.type == "Card" then
                local Card = Deck
                local R = Player[Params.Player].getHandTransform(Params.Index).rotation
                R.y = R.y + 180
                R.z = 180
                coroutine.yield(0)
                Card.setPositionSmooth(Player[Params.Player].getHandTransform(Params.Index).position,false,true)
                Card.setRotationSmooth(R,false,false)
                coroutine.yield(0)
                --flip the card?
                if Params.Flip then
                    --wait until the card is found in the hand...
                    local RepeatLimit = 999
                    RepCount = RepCount + 1
                    repeat
                        RepeatLimit = RepeatLimit - 1
                        coroutine.yield(0)
                    until CardInHand({Player=Params.Player,Index=Params.Index,ID=Card.getGUID()}) or RepeatLimit < 1
                    RepCount = RepCount - 1
                    R.z = 0
                    Card.setRotationSmooth(R,false,false)
                end--if
            else--it's a deck... 
                local Cards = Deck.getObjects()
                local Card = nil
                local R = Player[Params.Player].getHandTransform(Params.Index).rotation
                R.y = R.y + 180
                R.z = 180
                --deck too small?
                if Params.Qty > #Cards then
                    printToAll("Cannot deal all "..Params.Qty.." cards from the Deck:"..Deck.getName()..". Dealing the remaining "..#Cards.." card(s) instead.")
                    Params.Qty = #Cards
                end--if
                --deal the cards...
                for C=1,Params.Qty do
                    coroutine.yield(0)
                    --if the card is found outside the deck...
                    if getObjectFromGUID(Cards[C].guid) != nil then
                        Card = getObjectFromGUID(Cards[C].guid)
                    else	--pull card from the deck...
                        Card = Deck.takeObject({guid=Cards[C].guid})
                    end--if
                    coroutine.yield(0)
                    Card.setPositionSmooth(Player[Params.Player].getHandTransform(Params.Index).position,false,true)
                    Card.setRotationSmooth(R,false,false)
                    coroutine.yield(0)
                    --flip the card?
                    if Params.Flip then
                        --wait until the card is found in the hand...
                        local RepeatLimit = 999
                        RepCount = RepCount + 1
                        repeat
                            RepeatLimit = RepeatLimit - 1
                            coroutine.yield(0)
                        until CardInHand({Player=Params.Player,Index=Params.Index,ID=Cards[C].guid}) or RepeatLimit < 1
                        RepCount = RepCount - 1
                        R.z = 0
                        Card.setRotationSmooth(R,false,false)
                    end--if
                end--for
            end--if
		else
			printToAll("Cannot Deal from "..Params.Deck.." Deck, because it no longer exists.")
		end--if
		Game.Flags.Dealing = false
		return 1
	end--function
	startLuaCoroutine(Global,"DealToHandCoroutine")
end--function

function CardToHand(Params)	--{CardID="",Player="",Index=0,Flip=true}
	function CardToHandCoroutine()
		if Params.Flip == nil then Params.Flip = true end--if
		local Card = getObjectFromGUID(Params.CardID)
		--does the card exist?
		if Card != nil then
			local R = Player[Params.Player].getHandTransform(Params.Index).rotation
			R.y = R.y + 180
			R.z = 180
			Card.setPositionSmooth(Player[Params.Player].getHandTransform(Params.Index).position,false,true)
			Card.setRotationSmooth(R,false,false)
			--flip the card?
			if Params.Flip then
				--wait until the card is found in the hand...
				local RepeatLimit = 500
				RepCount = RepCount + 1
				repeat
					RepeatLimit = RepeatLimit - 1
					coroutine.yield(0)
				until CardInHand({Player=Params.Player,Index=Params.Index,ID=Card.getGUID()}) or RepeatLimit < 1
				RepCount = RepCount - 1
				R.z = 0
				Card.setRotationSmooth(R,false,false)
			end--if
		end--if
		return 1
	end--function
	startLuaCoroutine(Global,"CardToHandCoroutine")
end--function

function CardInHand(Params)	--{Player="",Index=1,ID="",Name="",Description=""}
	--returns true if the card is found in the specified hand...
	if Params.ID == nil then Params.ID = "" end--if
	if Params.Name == nil then Params.Name = "" end--if
	if Params.Description == nil then Params.Description = "" end--if
	local Card = nil
	local C = 0
	for C,Card in pairs(Player[Params.Player].getHandObjects(Params.Index)) do
		if (Params.ID == "" or Params.ID == Card.guid) and (Params.Name == "" or string.find(Card.getName(),Params.Name) != nil) and (Params.Description == "" or string.find(Card.getDescription(),Params.Description) != nil) then
			return true
		end--if
	end--for
	return false
end--function

function Ping(Params)	--{Position={},GUID="",Player="",Message=""}
	if Params.Position == nil then 
		Params.Position = {0,0,0} 
	end--if
	if Params.GUID == nil then 
		Params.GUID = "" 
	end--if
	if Params.Player == nil then 
		Params.Player = Player.getPlayers()[1].color 
	end--if
	if getObjectFromGUID(Params.GUID) != nil then 
		Params.Position = getObjectFromGUID(Params.GUID).getPosition() 
	end--if
	--hotseat mode?
	local HotSeat = false
	if #Player.getPlayers() > 1 then
		if Player.getPlayers()[1].steam_id == Player.getPlayers()[2].steam_id then
			HotSeat = true
		end--if
	end--if
	--anyone in an active player color seat?
	if not HotSeat and Params.Player != "Grey" and #getSeatedPlayers() > 0 then
		if Player[Params.Player].seated then
			Player[Params.Player].pingTable(Params.Position)
		end--if
	end--if
	if Params.Message != "" then
		printToAll(Params.Message)
	end--if
end--function

function GetFaction(Params)	--{Text=""}
	if string.find(Params.Text,"Rebel;") != nil then
		return "Rebel"
	elseif string.find(Params.Text,"Imperial;") != nil then
		return "Imperial"
	else
		return "Neutral"
	end--if
end--function

function GetFirstOpenSpot(Params)	--{Spots=Spots.Action.Imperial,Description="ActionCard;"}
	for S = 1,#Params.Spots do
		if #ScanForObjectID({Description=Params.Description,Origin=Params.Spots[S],Orientation={0,0,0},Size={0.25,0.25,0.25},Debug=false,Type=2}) == 0 then
			return Params.Spots[S]
		end--if
	end--for
	--if no open spots were found, re-use the first one...
	return Params.Spots[1]
end--function

--RECRUITMENT FUNCTIONS====================================================================================================================================

function SearchTable(Table,Item)
	--searches Table for Item and returns the index, or 0 if not found...
	for T=1,#Table do
		if Table[T] == Item then
			return T
		end--if
	end--for
	return 0
end--function

function PresentRecruits()
	log("Presenting Recruits...")
	--present possible Recruits for both factions in the hidden zones...
	Game.Leaders.Recruits.Rebel = {}
	--go through each Rebel draw...
	for D,Draw in pairs(Game.Leaders.Draws.Rebel) do
		--get leaders from the draw...
		local LeaderIcons = GetLeadersFromActionCard(getObjectFromGUID(Draw))
		--if first/left leader is not blank and not already in the pool and not already in the recruits list...
		if LeaderIcons[1] != "" and SearchTable(Game.Leaders.Pools.Rebel,LeaderIcons[1]) == 0  and SearchTable(Game.Leaders.Recruits.Rebel,LeaderIcons[1]) == 0 then
			table.insert(Game.Leaders.Recruits.Rebel,LeaderIcons[1])
		end--if
		--if second/right leader is not blank and not already in the pool and not already in the recruits list...
		if LeaderIcons[2] != "" and SearchTable(Game.Leaders.Pools.Rebel,LeaderIcons[2]) == 0  and SearchTable(Game.Leaders.Recruits.Rebel,LeaderIcons[2]) == 0 then
			table.insert(Game.Leaders.Recruits.Rebel,LeaderIcons[2])
		end--if
	end--for
	Game.Leaders.Objects.Rebel = {}
	--teleport rebel recruitable leaders to hidden zone...
	local X = 0
	for R,Recruit in pairs(Game.Leaders.Recruits.Rebel) do
		--get recruitable leaders out of the bag and line them up...
		local TempItem = nil
		for T,TempItem in pairs(getObjectFromGUID(IDs.Rebel.LeaderBag).getObjects()) do
			if TempItem.name == Recruit then
				X = X + 1
				local LO = getObjectFromGUID(IDs.Rebel.LeaderBag).takeObject({guid=TempItem.guid,smooth=false,position=Spots.Recruitment.Rebel.Leaders[X],rotation={0,0,0}})
				LO.setPosition(Spots.Recruitment.Rebel.Leaders[X])
				LO.setRotation({0,0,0})
				table.insert(Game.Leaders.Objects.Rebel,LO.getGUID())
        		coroutine.yield(0)
	    	end--if
		end--for
	end--for
	--use Pool and Draw to determine each faction's possible Recruits...
	Game.Leaders.Recruits.Imperial = {}
	--go through each Imperial draw...
	for _,Draw in pairs(Game.Leaders.Draws.Imperial) do
		--get leaders from the draw...
		local LeaderIcons = GetLeadersFromActionCard(getObjectFromGUID(Draw))
		--if first/left leader is not blank and not already in the pool and not already in the recruits list...
		if LeaderIcons[1] != "" and SearchTable(Game.Leaders.Pools.Imperial,LeaderIcons[1]) == 0  and SearchTable(Game.Leaders.Recruits.Imperial,LeaderIcons[1]) == 0 then
			table.insert(Game.Leaders.Recruits.Imperial,LeaderIcons[1])
		end--if
		--if second/right leader is not blank and not already in the pool and not already in the recruits list...
		if LeaderIcons[2] != "" and SearchTable(Game.Leaders.Pools.Imperial,LeaderIcons[2]) == 0  and SearchTable(Game.Leaders.Recruits.Imperial,LeaderIcons[2]) == 0 then
			table.insert(Game.Leaders.Recruits.Imperial,LeaderIcons[2])
		end--if
	end--for
	Game.Leaders.Objects.Imperial = {}
	--teleport imperial recruitable leaders to hidden zone...
	X = 0
	for R,Recruit in pairs(Game.Leaders.Recruits.Imperial) do
		--get recruitable leaders out of the bag and line them up...
		local TempItem = nil
		for _,TempItem in pairs(getObjectFromGUID(IDs.Imperial.LeaderBag).getObjects()) do
			if TempItem.name == Recruit then
				X=X+1
				local LO = getObjectFromGUID(IDs.Imperial.LeaderBag).takeObject({guid=TempItem.guid,smooth=false,position=Spots.Recruitment.Imperial.Leaders[X],rotation={0,180,0}})
				--LO.setLock(true)
				LO.setPosition(Spots.Recruitment.Imperial.Leaders[X])
				LO.setRotation({0,180,0})
				table.insert(Game.Leaders.Objects.Imperial,LO.getGUID())
				coroutine.yield(0)
	    	end--if
		end--for
	end--for
	log("Done Presenting Recruits...")
end--function

function DismissRecruits()
	--start with rebels...
	Game.Leaders.Recruits.Rebel = {}
	--if a recruit was already selected...
	if Game.Leaders.Recruiting.Rebel != "" then
		if Game.Leaders.Recruiting.Rebel != "NONE" then
			Game.Leaders.Recruits.Rebel = {Game.Leaders.Recruiting.Rebel}
		end--if
	else
		--go through each Rebel draw...
		for D,Draw in pairs(Game.Leaders.Draws.Rebel) do
			--get leaders from the draw...
			local LeaderIcons = GetLeadersFromActionCard(getObjectFromGUID(Draw))
			--if first/left leader is not blank and not already in the pool and not already in the recruits list...
			if LeaderIcons[1] != "" and SearchTable(Game.Leaders.Pools.Rebel,LeaderIcons[1]) == 0  and SearchTable(Game.Leaders.Recruits.Rebel,LeaderIcons[1]) == 0 then
				table.insert(Game.Leaders.Recruits.Rebel,LeaderIcons[1])
			end--if
			--if second/right leader is not blank and not already in the pool and not already in the recruits list...
			if LeaderIcons[2] != "" and SearchTable(Game.Leaders.Pools.Rebel,LeaderIcons[2]) == 0  and SearchTable(Game.Leaders.Recruits.Rebel,LeaderIcons[2]) == 0 then
				table.insert(Game.Leaders.Recruits.Rebel,LeaderIcons[2])
			end--if
		end--for
	end--if
	--put away rebel leaders in the hidden zone that are not recruitable and line up remaining recruitable ones...
	Game.Leaders.Objects.Rebel = {}
	for O,Obj in pairs(ScanForObjects({Description="Leader;Rebel;",Origin={0,0.6,28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
		if SearchTable(Game.Leaders.Recruits.Rebel,Obj.getName()) == 0 then
			getObjectFromGUID(IDs.Rebel.LeaderBag).putObject(Obj)
    end--if
	end--for
	local X = 0
	for R,Recruit in pairs(Game.Leaders.Recruits.Rebel) do
    if getObjectFromGUID(Recruit) != nil then
      X=X+1
      table.insert(Game.Leaders.Objects.Rebel,getObjectFromGUID(Recruit).getGUID())
      getObjectFromGUID(Recruit).setPosition(Spots.Recruitment.Rebel.Leaders[X])
      getObjectFromGUID(Recruit).setRotation({0,0,0})
      end--if
    coroutine.yield(0)
	end--for
	--now process imperials...
	Game.Leaders.Recruits.Imperial = {}
	--if a recruit was already selected...
	if Game.Leaders.Recruiting.Imperial != "" then
		if Game.Leaders.Recruiting.Imperial != "NONE" then
			Game.Leaders.Recruits.Imperial = {Game.Leaders.Recruiting.Imperial}
		end--if
	else
		--go through each Imperial draw...
		for _,Draw in pairs(Game.Leaders.Draws.Imperial) do
			--get leaders from the draw...
			local LeaderIcons = GetLeadersFromActionCard(getObjectFromGUID(Draw))
			--if first/left leader is not blank and not already in the pool and not already in the recruits list...
			if LeaderIcons[1] != "" and SearchTable(Game.Leaders.Pools.Imperial,LeaderIcons[1]) == 0  and SearchTable(Game.Leaders.Recruits.Imperial,LeaderIcons[1]) == 0 then
				table.insert(Game.Leaders.Recruits.Imperial,LeaderIcons[1])
			end--if
			--if second/right leader is not blank and not already in the pool and not already in the recruits list...
			if LeaderIcons[2] != "" and SearchTable(Game.Leaders.Pools.Imperial,LeaderIcons[2]) == 0  and SearchTable(Game.Leaders.Recruits.Imperial,LeaderIcons[2]) == 0 then
				table.insert(Game.Leaders.Recruits.Imperial,LeaderIcons[2])
			end--if
		end--for
	end--if
	--put away imperial leaders in the hidden zone that are not recruitable and line up remaining recruitable ones...
	Game.Leaders.Objects.Imperial = {}
	for _,Obj in pairs(ScanForObjects({Description="Leader;Imperial;",Origin={0,0.6,-28},Orientation={0,0,0},Size={11,2,9},Debug=false,Type=3})) do
		if SearchTable(Game.Leaders.Recruits.Imperial,Obj.getName()) == 0 then
			getObjectFromGUID(IDs.Imperial.LeaderBag).putObject(Obj)
		end--if
	end--for
	X = 0
	for R,Recruit in pairs(Game.Leaders.Recruits.Imperial) do
    if getObjectFromGUID(Recruit) != nil then
      X=X+1
      table.insert(Game.Leaders.Objects.Imperial,getObjectFromGUID(Recruit).getGUID())
      getObjectFromGUID(Recruit).setPosition(Spots.Recruitment.Imperial.Leaders[X])
      getObjectFromGUID(Recruit).setRotation({0,180,0})
      end--if
    coroutine.yield(0)
	end--for
    return 1
end--function

function GetLeadersInPool(Params)--{Faction="Imperial"}
	local ScanSpot={0,1.3,20}
	local List={}
	if Params.Faction == "Imperial" then
		ScanSpot = {0,1.3,-20}
	end--if imperials?
	for O,Obj in pairs(ScanForObjects({Description="Leader;",Origin=ScanSpot,Orientation={0,0,0},Size={10,1,7},Debug=true,Type=3})) do
		table.insert(List,Obj.getName())
	end--for O,Obj
	return List
end--function 

function GetLeadersFromActionCard(ActionCard)
	--returns a table of leader names (1-2) associated with the action card...
	if ActionCard.getName() == "ACCORDING TO MY DESIGN" then
		return {"Emperor Palpatine",""}
	elseif ActionCard.getName() == "IT IS YOUR DESTINY" then
		return {"Darth Vader",""}
	elseif ActionCard.getName() == "BRILLIANT ADMINISTRATOR" then
		return {"Grand Moff Tarkin",""}
	elseif ActionCard.getName() == "MORE DANGEROUS THAN YOU REALIZE" then
		return {"General Tagge",""}
	elseif ActionCard.getName() == "TRACK THEM" then
		return {"",""}
	elseif ActionCard.getName() == "EARLY PROMOTION" then
		return {"Admiral Motti",""}
	elseif ActionCard.getName() == "REBEL PLANNING" then
		return {"Jan Dodonna",""}
	elseif ActionCard.getName() == "START THE EVACUATION" then
		return {"General Rieekan",""}
	elseif ActionCard.getName() == "OUR MOST DESPERATE HOUR" then
		return {"Princess Leia",""}
	elseif ActionCard.getName() == "RESOURCEFUL ASTROMECH" then
		return {"",""}
	elseif ActionCard.getName() == "TEMPORARY ALLIANCE" then
		return {"Mon Mothma",""}
	elseif ActionCard.getName() == "HUMAN-CYBORG RELATIONS" then
		return {"",""}
	elseif ActionCard.getName() == "REBEL EXTREMIST" then
		return {"Saw Gerrera",""}
	elseif ActionCard.getName() == "FALSE ORDERS" then
		return {"",""}
	elseif ActionCard.getName() == "CATCH THEM BY SURPRISE" then
		return {"Admiral Ozzel",""}
	elseif ActionCard.getName() == "LOCAL RUMORS" then
		if Game.Flags.WFL then
			return {"Colonel Yularen","Grand Admiral Thrawn"}
		else
			return {"Colonel Yularen",""}
		end--if
	elseif ActionCard.getName() == "KEEP THEM FROM ESCAPING" then
		return {"Admiral Piett",""}
	elseif ActionCard.getName() == "GOOD INTEL" then
		return {"Soontir Fel","Colonel Yularen"}
	elseif ActionCard.getName() == "FULLY OPERATIONAL" then
		return {"Moff Jerjerrod",""}
	elseif ActionCard.getName() == "AMBITIONS OF POWER" then
		return {"Admiral Motti","Jabba the Hutt"}
	elseif ActionCard.getName() == "BOBA FETT? WHERE?" then
		return {"Boba Fett",""}
	elseif ActionCard.getName() == "TARGET THE GENERATOR" then
		return {"General Veers",""}
	elseif ActionCard.getName() == "PUBLIC SUPPORT" then
		return {"Janus Greejatus",""}
	elseif ActionCard.getName() == "BLINDSIDE" then
		return {"Janus Greejatus","Boba Fett"}
	elseif ActionCard.getName() == "SCOUTING MISSION" then
		return {"Soontir Fel",""}
	elseif ActionCard.getName() == "POST BOUNTY" then
		return {"Jabba the Hutt",""}
	elseif ActionCard.getName() == "PROCEEDING AS PLANNED" then
		return {"Admiral Ozzel","Moff Jerjerrod"}
	elseif ActionCard.getName() == "SECRET FACILITY" then
		return {"Director Krennic","Krennic's Finest"}
	elseif ActionCard.getName() == "READY FOR ACTION" then
		return {"Admiral Piett","General Veers"}
	elseif ActionCard.getName() == "LORD VADER'S ORDERS" then
		return {"Director Krennic",""}
	elseif ActionCard.getName() == "SWEEP THE AREA" then
		return {"Krennic's Finest",""}
	elseif ActionCard.getName() == "SON OF SKYWALKER" then
		return {"Luke Skywalker",""}
	elseif ActionCard.getName() == "AN OLD FRIEND" then
		return {"Han Solo",""}
	elseif ActionCard.getName() == "HE MEANS WELL" then
		return {"Cassian Andor",""}
	elseif ActionCard.getName() == "TARGET THE STAR DESTROYERS" then
		return {"Wedge Antilles",""}
	elseif ActionCard.getName() == "ONE IN A MILLION" then
		return {"Wedge Antilles","Luke Skywalker"}
	elseif ActionCard.getName() == "TRUST IN THE FORCE" then
		return {"Jyn Erso","Chirrut Imwe"}
	elseif ActionCard.getName() == "THE MILLENNIUM FALCON" then
		return {"Han Solo","Chewbacca"}
	elseif ActionCard.getName() == "INDEPENDENT OPERATION" then
		return {"Lando Calrissian",""}
	elseif ActionCard.getName() == "AMBUSH" then
		return {"General Madine",""}
	elseif ActionCard.getName() == "NOBLE SACRIFICE" then
		return {"Obi-Wan Kenobi",""}
	elseif ActionCard.getName() == "BAZE'S LOYALTY" then
		return {"Chirrut Imwe",""}
	elseif ActionCard.getName() == "IT'S A TRAP" then
		return {"Admiral Ackbar",""}
	elseif ActionCard.getName() == "UNDERCOVER" then
		return {"Lando Calrissian","Obi-Wan Kenobi"}
	elseif ActionCard.getName() == "WOOKIEE GUARDIAN" then
		return {"Chewbacca",""}
	elseif ActionCard.getName() == "POINT-BLANK ASSAULT" then
		return {"Admiral Ackbar","General Madine"}	elseif ActionCard.getName() == "UNDER THE RADAR" then
		return {"Cassian Andor","Saw Gerrera"}
	elseif ActionCard.getName() == "SOMETHING TO FIGHT FOR" then
		return {"Jyn Erso",""}
	elseif ActionCard.getName() == "YOU ARE IN COMMAND NOW" then
		return {"Grand Admiral Thrawn",""}
	end--if
end--function

function LeaderOnLoad(Params)  --{Leader=Obj}
	LeaderButtons(Params.Leader)
end--function 

function LeaderButtons(LeaderObj)  --{Leader=Obj}
	LeaderObj.clearButtons()
	--ring attached?
	if #LeaderObj.getAttachments() > 0 then
		LeaderObj.createButton({click_function="LeaderDetachMenu",function_owner=Global,label="x",position={-0.6,0.3,0.6},rotation={0,0,0},scale={1,1,1},width=300,height=300,font_size=300,tooltip="Detach this Ring."})
		LeaderObj.createButton({click_function="LeaderDetachMenu",function_owner=Global,label="x",position={-0.6,0.3,-0.6},rotation={0,180,0},scale={1,1,1},width=300,height=300,font_size=300,tooltip="Detach this Ring."})
		LeaderObj.createButton({click_function="LeaderRingInfo",function_owner=Global,label="?",position={0.6,0.3,0.6},rotation={0,0,0},scale={1,1,1},width=300,height=300,font_size=300,tooltip="What does this Ring do?\n(Prints Action Card text to chat)."})
		LeaderObj.createButton({click_function="LeaderRingInfo",function_owner=Global,label="?",position={0.6,0.3,-0.6},rotation={0,180,0},scale={1,1,1},width=300,height=300,font_size=300,tooltip="What does this Ring do?\n(Prints Action Card text to chat)."})
		--does this leader have lured attachment?
		for I,Item in pairs(LeaderObj.getAttachments()) do
			--ring?
			if Item.name == "Captured" then
				printToAll(LeaderObj.getName().." is Captured.")
				LeaderObj.setVar("Captured",true)
			elseif Item.name == "Carbonite" then
				printToAll(LeaderObj.getName().." is Captured in Carbonite.")
				LeaderObj.setVar("Captured",true)
				LeaderObj.setVar("Carbonite",true)
			elseif Item.name == "Lure of the Dark Side" then
				printToAll(LeaderObj.getName().." was Lured to the Dark Side, and is under Imperial control.")
				LeaderObj.setVar("Faction","Imperial")
				LeaderObj.setVar("Lured",true)
			end--if
		end--for
	end--if
	--if imperial and confronted, show the cancel confrontation button... 
	if LeaderObj.getVar("Faction") == "Imperial" then
		if string.find(LeaderObj.getGMNotes(),"Confronted;") != nil then
			LeaderObj.createButton({click_function="ConfrontationPrompt",function_owner=Global,label="CONFRONTED",position={0,3.5,0.4},rotation={270,0,0},scale={1,1,1},width=0,height=0,font_size=220,font_color={1,1,1}})
			LeaderObj.createButton({click_function="ConfrontationPrompt",function_owner=Global,label="CONFRONTED",position={0,3.5,-0.15},rotation={90,180,0},scale={1,1,1},width=0,height=0,font_size=220,font_color={1,1,1}})
			LeaderObj.createButton({click_function="ConfrontationPrompt",function_owner=Global,label=string.char(9760),position={0,0.3,0.55},rotation={0,0,0},scale={1,1,1},width=300,height=300,font_size=250,tooltip="Cancel the confrontation on this leader."})
			LeaderObj.createButton({click_function="ConfrontationPrompt",function_owner=Global,label=string.char(9760),position={0,0.3,-0.4},rotation={0,180,0},scale={1,1,1},width=300,height=300,font_size=250,tooltip="Cancel the confrontation on this leader."})
			end--if
	end--if 
	--if rebel leader, show the detained button...
	if LeaderObj.getVar("Faction") == "Rebel" then
		LeaderObj.createButton({click_function="LeaderDetained",function_owner=Global,label=string.char(9684),position={0,0.3,0.4},rotation={0,0,0},scale={1,1,1},width=300,height=300,font_size=400,tooltip="Detain this Leader."})
		LeaderObj.createButton({click_function="LeaderDetained",function_owner=Global,label=string.char(9684),position={0,0.3,-0.4},rotation={0,180,0},scale={1,1,1},width=300,height=300,font_size=400,tooltip="Detain this Leader."})
	end--if
	--if actually detained, display detained banner... 
  	if string.find(LeaderObj.getGMNotes(),"Detained;") != nil then
		LeaderObj.createButton({click_function="LeaderDetained",function_owner=Global,label="DETAINED",position={0,4,0.2},rotation={270,0,0},scale={1,1,1},width=0,height=0,font_size=300,font_color={1,0,0}})
		LeaderObj.createButton({click_function="LeaderDetained",function_owner=Global,label="DETAINED",position={0,4,-0.2},rotation={90,180,0},scale={1,1,1},width=0,height=0,font_size=300,font_color={1,0,0}})
	end--if
	LeaderObj.setVar("Colliding",false)
end--function

function LeaderOnPickUp(Params)  --{Leader=Obj,Player=""}
	Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="Location"}))
	Params.Leader.setVar("Location","")
end--function

function LeaderOnDrop(Params)  --{Leader=Obj,Player=""}
	if Params.Silent == nil then Params.Silent = false end--if
	local Location = GetGrid({Position=Params.Leader.getPosition()}).Location
  --do we need to check combat zone?
  if Location == "" and CombatLocation != "" and CombatLocation != nil then
    --in the combat zone?
    if Params.Leader.getPosition().x > 22.5 and Params.Leader.getPosition().x < 44.5 and Params.Leader.getPosition().z > -11 and Params.Leader.getPosition().z < 11 then
      Location = CombatLocation
    end--if
  end--if
	Params.Leader.setVar("Location",Location)
	--if dropped into a known location...
	if Location != "" then
		--clear Combat notes if present and update location...
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="X"}))
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="Y"}))
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="Z"}))
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="RX"}))
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="RY"}))
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="RZ"}))
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="Damage"}))
		Params.Leader.setGMNotes(UpdateTag({Text=Params.Leader.getGMNotes(),Tag="Location",Value=Location}))
		--player dropped it?
		if Params.Player != nil and not Params.Silent then
			log(Params.Player.." Player dropped "..Params.Leader.getName().." into "..Location)
			printToAll(Params.Player.." Player dropped "..Params.Leader.getName().." into "..Location,Params.Player)
		else
			log(Params.Leader.getName().." was dropped into "..Location)
		end--if
	elseif Params.Leader.getPosition().z > 11 and Params.Leader.getPosition().z < 16.6 and Params.Leader.getPosition().x > -10 and Params.Leader.getPosition().x < 10 then
		--leader dropped into rebel assignment zone...
		--whick card section was the leader dropped in? 1-9
		--leader in left spot?
		--leader in right spot?
	elseif Params.Leader.getPosition().z < -11 and Params.Leader.getPosition().z > -16.6 and Params.Leader.getPosition().x > -10 and Params.Leader.getPosition().x < 10 then
		--leader dropped into imperial assignmentment zone...
		--whick card section was the leader dropped in? 1-9
		--leader in left spot?
		--leader in right spot?
  else--remove the location tag...
		Params.Leader.setGMNotes(RemoveTag({Text=Params.Leader.getGMNotes(),Tag="Location"}))
  end--if
end--function

function LeaderOnCollision(Params)	--{Leader=Obj,Info=collision_info}
	--flag this leader as colliding...
	Params.Leader.setVar("Colliding",true)
	--ring collision with rebel leader?
	if Params.Leader.getVar("Faction") == "Rebel" and string.find(Params.Info.collision_object.getDescription(),"Ring;") != nil and Params.Info.collision_object.getVar("AttachTo") == "Rebel" then
		--flag this ring as taken...
		if Params.Info.collision_object.getVar("Colliding") == nil then
			Params.Info.collision_object.setVar("Colliding",Params.Leader.getGUID())
			--make sure this leader does not already have a ring and is the first/only colliding leader...
			if #Params.Leader.getAttachments() == 0 and Params.Info.collision_object.getVar("Colliding") == Params.Leader.getGUID() then
				--only han and chewy get the millennium falcon UNLESS WFL expansion...
				if not Game.Flags.WFL and Params.Info.collision_object.getName() == "Millennium Falcon" and not (Params.Leader.getName() == "Han Solo" or Params.Leader.getName() == "Chewbacca") then
					printToAll("Millenium Falcon Ring can only be attached to Han or Chewy.",{1,1,0})
				else--attach the ring... 
					--promote luke to jedi if not using WFL?
					if not Game.Flags.WFL and Params.Info.collision_object.getName() == "Master Yoda" and Params.Leader.getName() == "Luke Skywalker" then
						broadcastToAll("Luke is now a Jedi",{1,1,0})
						--replace luke with jedi luke... 
						local TempObj = GetLeader({Name="Luke Skywalker (Jedi)",Smooth=false,Position=Params.Leader.getPosition(),Params.Leader.getPosition()})
						getObjectFromGUID(IDs.Rebel.LeaderBag).putObject(Params.Leader)
						Params.Leader = TempObj
					end--if luke?
					Params.Info.collision_object.setRotation({0,0,0})
					Params.Leader.setRotation({0,0,0})
					Params.Leader.setPosition({Params.Info.collision_object.getPosition().x,Params.Info.collision_object.getPosition().y+0.1,Params.Info.collision_object.getPosition().z})
					Params.Leader.addAttachment(Params.Info.collision_object)
					LeaderOnLoad({Leader=Params.Leader})	--call load function to display buttons.
					broadcastToAll(Params.Leader.getName().." now has the Ring: "..Params.Info.collision_object.getName()..".")
          			--flip leader like a salt shaker to work around bug where they sink into the floor...
					Params.Leader.flip()
					Wait.time(function() Params.Leader.flip() end,1)
					--update leader variables... 
					if Params.Info.collision_object.getName() == "Captured" then
						Params.Leader.setVar("Captured",true)
					elseif Params.Info.collision_object.getName() == "Carbonite" then
						Params.Leader.setVar("Captured",true)
						Params.Leader.setVar("Carbonite",true)
					elseif Params.Info.collision_object.getName() == "Lure of the Dark Side" then
						Params.Leader.setVar("Lured",true)
						Params.Leader.setVar("Faction","Imperial")
					end--if
					--sound effect...
					if Params.Info.collision_object.getName() == "Millennium Falcon" then
						if Params.Leader.getName() == "Han Solo" then
							PlaySound({ID=4})
						elseif Params.Leader.getName() == "Chewbacca" then
							PlaySound({ID=5})
						else 
							--generic millenium falcon sound goes here.
						end--if
					elseif Params.Info.collision_object.getVar("Sound") > 0 then --play sound from ring...
						PlaySound({ID=Params.Info.collision_object.getVar("Sound")})
					end--if
				end--if
			end--if
		end--if
	elseif Params.Leader.getVar("Faction") == "Imperial" and string.find(Params.Info.collision_object.getDescription(),"Ring;") != nil and Params.Info.collision_object.getVar("AttachTo") == "Imperial" then
		--flag this ring as taken...
		if Params.Info.collision_object.getVar("Colliding") == nil then
			Params.Info.collision_object.setVar("Colliding",Params.Leader.getGUID())
			--make sure this leader does not already have a ring and is the first/only colliding leader...
			if #Params.Leader.getAttachments() == 0 and Params.Info.collision_object.getVar("Colliding") == Params.Leader.getGUID() then
				Params.Info.collision_object.setRotation({0,0,0})
				Params.Leader.setRotation({0,0,0})
				Params.Leader.setPosition({Params.Info.collision_object.getPosition().x,Params.Info.collision_object.getPosition().y+0.1,Params.Info.collision_object.getPosition().z})
				Params.Leader.addAttachment(Params.Info.collision_object)
				LeaderOnLoad({Leader=Params.Leader})	--call load function to display buttons.
				broadcastToAll(Params.Leader.getName().." now has the Ring: "..Params.Info.collision_object.getName()..".")
					--flip leader like a salt shaker to work around bug where they sink into the floor...
				Params.Leader.flip()
				Wait.time(function() Params.Leader.flip() end,1)
				--sound effect...
				if Params.Info.collision_object.getVar("Sound") > 0 then --play sound from ring...
					PlaySound({ID=Params.Info.collision_object.getVar("Sound")})
				end--if
			end--if
		end--if
	end--if
	Wait.frames(function() Params.Leader.setVar("Colliding",false) end,9)
	Wait.frames(function() Params.Info.collision_object.setVar("Colliding",nil) end,9)
end--function

function LeaderOnDestroy(Params)  --{Leader=Obj}
end--function

function LeaderFetchRing(Params)--{RingID="",Name="",BagID="",Position={},Rotation={},Smooth=true}
	if Params.RingID == nil then Params.RingID = "" end--if
	if Params.Name == nil then Params.Name = "" end--if
	if Params.Rotation == nil then Params.Rotation = {0,0,0} end--if
	if Params.Smooth == nil then Params.Smooth = true end--if
	local RingObj = nil
	--try to take the specified ring from the box... 
	for I,Item in pairs(getObjectFromGUID(Params.BagID).getObjects()) do 
		if (Item.name == Params.Name and Params.Name != "") or (Item.guid == Params.RingID and Params.RingID != "") then
			RingObj = getObjectFromGUID(Params.BagID).takeObject({guid=Item.guid,position=Params.Position,rotation=Params.Rotation,smooth=Params.Smooth})
			coroutine.yield(0)
			break
		end--if
	end--for O,Obj
	--ring not found?
	if RingObj == nil then
		if Params.Name != "" then
			printToAll("Unable to fetch the "..Params.Name.." Ring from the Ring Supply.",{1,1,0})
		else
			printToAll("Unable to fetch the Ring from the Ring Supply.",{1,1,0})
		end--if
	end--if
end--function 

function LeaderDetachMenu(LeaderObj)
	LeaderObj.clearButtons()
	LeaderObj.createButton({click_function="LeaderDiscardRing",function_owner=Global,label="Discard",position={0,4,0.1},rotation={270,0,0},color={1,1,1},width=1000,height=400,font_size=300,tooltip="Discard this Ring."})
	LeaderObj.createButton({click_function="LeaderDetachRing",function_owner=Global,label="Detach",position={0,3,0.1},rotation={270,0,0},color={1,1,1},width=1000,height=400,font_size=300,tooltip="Detach this Ring (Re-assign)."})
	LeaderObj.createButton({click_function="LeaderButtons",function_owner=Global,label="Cancel",position={0,2,0.1},rotation={270,0,0},color={1,1,1},width=1000,height=400,font_size=300,tooltip="Leave the Ring attached."})
	LeaderObj.createButton({click_function="LeaderDiscardRing",function_owner=Global,label="Discard",position={0,4,-0.15},rotation={90,180,0},color={1,1,1},width=1000,height=400,font_size=300,tooltip="Discard this Ring."})
	LeaderObj.createButton({click_function="LeaderDetachRing",function_owner=Global,label="Detach",position={0,3,-0.15},rotation={90,180,0},scolor={1,1,1},width=1000,height=400,font_size=300,tooltip="Detach this Ring (Re-assign)."})
	LeaderObj.createButton({click_function="LeaderButtons",function_owner=Global,label="Cancel",position={0,2,-0.15},rotation={90,180,0},color={1,1,1},width=1000,height=400,font_size=300,tooltip="Leave the Ring attached."})
end--function 

function LeaderDetachRing(LeaderObj)
	printToAll("Detaching Ring from "..LeaderObj.getName().."...")
	--loop thru all child attachments...
	for O,Obj in pairs(LeaderObj.removeAttachments()) do
		--does this child have the ring tag?
		if string.find(Obj.getDescription(),"Ring;") != nil then
			--which ring?
			if Obj.getName() == "Lure of the Dark Side" then
				--turn back to the light side!
				LeaderObj.setVar("Faction","Rebel")	
			end--if
			--clear all possible ring tags from this player...
			LeaderObj.setVar("Captured",false)
			LeaderObj.setVar("Carbonite",false)
			LeaderObj.setVar("Lured",false)
			--which faction is the ring from?
			if string.find(Obj.getDescription(),"Imperial;") != nil then
				Obj.setPositionSmooth({11,1,-16},false,false)
				Ping({Position={11,1,-16},Player="Blue"})
			elseif string.find(Obj.getDescription(),"Rebel;") != nil then
				Obj.setPositionSmooth({11,1,16},false,false)
				Ping({Position={11,1,16},Player="White"})
			end--if
			Obj.setVar("Leader",nil)
		end--if
	end--for
	LeaderButtons(LeaderObj)
end--function 

function LeaderDiscardRing(LeaderObj)
	printToAll("Discarding Ring from "..LeaderObj.getName().."...")
	--loop thru all child attachments...
	for O,Obj in pairs(LeaderObj.removeAttachments()) do
		--does this child have the ring tag?
		if string.find(Obj.getDescription(),"Ring;") != nil then
			--which ring?
			if Obj.getName() == "Lure of the Dark Side" then
				--turn back to the light side!
				LeaderObj.setVar("Faction","Rebel")	
			elseif Obj.getName() == "Elite Guard" then
				--deploy 1 death trooper!
				printToAll("Discarding Elite Guard ring and deploying a Death Trooper...")
				getObjectFromGUID(Units["Death Trooper"].BagID).takeObject({smooth=true,position={LeaderObj.getPosition().x,2,LeaderObj.getPosition().z-0.55},rotation={0,180,0}})
			end--if
			--clear all possible ring tags from this player...
			LeaderObj.setVar("Captured",false)
			LeaderObj.setVar("Carbonite",false)
			LeaderObj.setVar("Lured",false)
			--which faction is the ring from?
			if string.find(Obj.getDescription(),"Imperial;") != nil then
				getObjectFromGUID(IDs.Imperial.RingBag).putObject(Obj)
			elseif string.find(Obj.getDescription(),"Rebel;") != nil then
				getObjectFromGUID(IDs.Rebel.RingBag).putObject(Obj)
			end--if
			Obj.setVar("Leader",nil)
		end--if
	end--for
	LeaderButtons(LeaderObj)
end--function

function LeaderRingInfo(LeaderObj)
	--loop thru all child attachments...
	for I,Item in pairs(LeaderObj.getAttachments()) do
		--does this child have the ring tag?
		if string.find(Item.description,"Ring;") != nil then
			local Text = ""
			if Item.name == "R2-D2" then
				Text = "RESOURCEFUL ASTROMECH: After your opponent rolls dice during a mission in R2-D2's system, discard this ring to turn 1 of your opponent's dice to its blank side."
			elseif Item.name == "C-3P0" then
				Text = "HUMAN-CYBORG RELATIONS: When you fail a diplomacy mission in C-3P0's system, discard this ring to make the mission succeed instead."
			elseif Item.name == "Millennium Falcon" then
				Text = "MILLENNIUM FALCON: After you succeed at a mission in the Millennium Falcon's system, discard this ring to rescue 1 captured leader in this system."
			elseif Item.name == "Master Yoda" then
				Text = "MASTER YODA: Once per game round, when this leader is in the same system as a mission or combat, you may reroll 1 of your dice."
			elseif Item.name == "K-2S0" then
				Text = "HE MEANS WELL: The attached leader gains 1 minor spec ops icon and 1 minor intel icon."
			elseif Item.name == "Captured" then
				Text = "CAPTURED: Captured leaders do not oppose missions, cannot return to the leader pool, and cannot be moved by the Rebel player.\n"
				Text = Text.."If a mission is attempted 'against a captured leader,' the captured leader opposes the mission and rolls dice. The Rebel player can also send another leader from his leader pool to oppose the mission as normal.\n"
				Text = Text.."Captured leaders do not prevent Rebel units from moving out of their system.\nThe Imperial player can move a captured leader as if it were a ground unit, but it does not count toward transport capacity.\nCaptured leaders cannot be moved when retreating."
			elseif Item.name == "Carbonite" then
				Text = "CARBONITE: If successfully attached to a Rebel Leader, the Rebel Player loses 1 Reputation.  A leader with this ring attached is considered Captured."
			elseif Item.name == "Lure of the Dark Side" then
				Text = "LURE OF THE DARK SIDE: When attached to a Rebel Leader, it becomes an Imperial leader for the rest of the game. If that leader is Luke Skywalker, the Rebel player loses 1 Reputation."
			elseif Item.name == "Bounty" then
				Text = "POST BOUNTY: When this Leader is Captured, the Rebels lose 1 Reputation."
			elseif Item.name == "Elite Guard" then
				Text = "ELITE GUARD: The attached leader gains 1 minor spec ops icon. You may discard this ring to deploy 1 Death Trooper in the leader's system."
			elseif Item.name == "Pursuit" then
				Text = "PURSUIT: While this ring is attached, the Imperial player draws +1 probe card during the Launch Probes step of the Refresh Phase."
			elseif Item.name == "Mercenary Trap" then
				Text = "MERCENARY TRAP: After any mission fails in this ring's system, the Imperial player may discard the ring to capture a Rebel leader in the same system."
			elseif Item.name == "Tactical Training" then
				Text = "TACTICAL TRAINING: The tactic values of this leader for each theater of combat are increased by 1."
			elseif Item.name == "Pledging Support" then
				Text = "PLEDGING SUPPORT: Whenever this leader gains loyalty, you may also deploy 1 unit from space 1 of the build queue in that system."
			elseif Item.name == "Smuggler" then
				Text = "SMUGGLER: When a mission is attempted in the Smuggler ring's system, the Rebel player may roll 1 extra die."
			elseif Item.name == "Imperial Shuttle" then
				Text = "IMPERIAL SHUTTLE: Before rolling dice on any Rebel Mission, you may discard this ring to move this leader to the mission's system."
			end--if
			printToAll("\n"..Text.."\n",{1,1,0})
		end--if
	end--for
end--function

function LeaderDetained(LeaderObj)
	--toggle detained tag...
	if string.find(LeaderObj.getGMNotes(),"Detained;") != nil then
		LeaderObj.setGMNotes(string.gsub(LeaderObj.getGMNotes(),"Detained;",""))
	else
		LeaderObj.setGMNotes(LeaderObj.getGMNotes().."Detained;")
	end--if
	LeaderOnLoad({Leader=LeaderObj})
end--function

function ConfrontationPrompt(LeaderObj)
	LeaderObj.clearButtons()
	LeaderObj.setColorTint({1,0,0})
	LeaderObj.createButton({click_function="ConfrontationPrompt",function_owner=Global,label="Confronted?",position={0,3.5,0.4},rotation={270,0,0},font_color={1,1,1},width=0,height=0,font_size=220})
	LeaderObj.createButton({click_function="ConfrontedYes",function_owner=Global,label="Yes",position={0,2.5,0.4},rotation={270,0,0},color={1,1,1},width=600,height=400,font_size=300,tooltip="Yes: This leader will be eliminated at the end of the Command Phase."})
	LeaderObj.createButton({click_function="ConfrontedNo",function_owner=Global,label="No",position={0,1.5,0.4},rotation={270,0,0},color={1,1,1},width=600,height=400,font_size=300,tooltip="No: Remove the confrontation tag.  This leader will not be eliminated at the end of the Command Phase."})
	LeaderObj.createButton({click_function="ConfrontationPrompt",function_owner=Global,label="Confronted?",position={0,3.5,-0.15},rotation={90,180,0},font_color={1,1,1},width=0,height=0,font_size=220})
	LeaderObj.createButton({click_function="ConfrontedYes",function_owner=Global,label="Yes",position={0,2.5,-0.15},rotation={90,180,0},scolor={1,1,1},width=600,height=400,font_size=300,tooltip="Yes: This leader will be eliminated at the end of the Command Phase."})
	LeaderObj.createButton({click_function="ConfrontedNo",function_owner=Global,label="No",position={0,1.5,-0.15},rotation={90,180,0},color={1,1,1},width=600,height=400,font_size=300,tooltip="No: Remove the confrontation tag.  This leader will not be eliminated at the end of the Command Phase."})
end--function 

function ConfrontedYes(LeaderObj)
	--enable confrontation tag...
	LeaderObj.clearButtons()
	LeaderObj.setColorTint({1,0,0})
	LeaderObj.setGMNotes(LeaderObj.getGMNotes().."Confronted;")
	LeaderOnLoad({Leader=LeaderObj})
end--function
	 
function ConfrontedNo(LeaderObj)
	--disable confrontation tag...
	LeaderObj.clearButtons()
	LeaderObj.setColorTint({1,1,1})
	LeaderObj.setGMNotes(string.gsub(LeaderObj.getGMNotes(),"Confronted;",""))
	LeaderOnLoad({Leader=LeaderObj})
end--function 

function GetLeaderTactic(Params)	--{Leader=object,Theater="Space"|"Ground",}
	local TacticValue = 0
	if Params.Leader != nil then
		if Params.Theater == "Space" then
			TacticValue = TacticValue + Params.Leader.getVar("SpaceCombat")
		elseif Params.Theater == "Ground" then
			TacticValue = TacticValue + Params.Leader.getVar("GroundCombat")
		end--if
		for I,Item in pairs(Params.Leader.getAttachments()) do
			--tactical training ring?
			if Item.name == "Tactical Training" then
				TacticValue = TacticValue + 1
				break
			end--if
		end--for
	end--if
	return TacticValue
end--function 

--SOUND EFFECTS====================================================================================================================================

function PlaySound(Params)	--{ID=1}
	if SoundEnabled then
		getObjectFromGUID(IDs.SoundCube).AssetBundle.playTriggerEffect(Params.ID-1)
	end--if
end--function

--UNIT FUNCTIONS====================================================================================================================================

function GetUnitCount(Params) --{Location="",Unit="",Faction="",Theater="",SystemType=""} returns integer count of  matching units.
	if Params.Location == nil then Params.Location = "" end--if
	if Params.Unit == nil then Params.Unit = "" end--if
	if Params.Faction == nil then Params.Faction = "" end--if
	if Params.Theater == nil then Params.Theater = "" end--if
	if Params.SystemType == nil then Params.SystemType = "" end--if
	--SystemType can be: "","Remote","Populous","Imperial","Rebel","Neutral","Queue","Base"
	local UnitCount = 0
	--loop through all units and count them based on params criteria...
	for U,Unit in pairs(getAllObjects()) do
		if Unit.getGMNotes() == nil then Unit.setGMNotes("") end--if
		if Unit.getDescription() == nil then Unit.setDescription("") end--if
		--unit?
		if string.find(Unit.getDescription(),"Unit;") != nil then
			--get location Info
			local Location = ReadTag({Text=Unit.getGMNotes(),Tag="Location",Default=""})
			local LocationType = ""
			local LocationSubType = ""
			local LocationLoyalty = ""
			local LocationSubjugated = nil
			if Location != "" then
				LocationType = Locations[Location].Type
				LocationSubType = Locations[Location].SubType
				LocationLoyalty = Locations[Location].Loyalty
				LocationSubjugation = Locations[Location].Subjugated
			end--if
			--matches criteria?
			if (Params.Location == "" or Params.Location == Location)
			and (Params.Unit == "" or Params.Unit == Unit.getName())
			and (Params.Faction == "" or string.find(Unit.getDescription(),Params.Faction..";") != nil)
			and (Params.Theater == "" or string.find(Unit.getDescription(),Params.Theater..";") != nil)
			and (Params.SystemType == "" or Params.SystemType == LocationType or Params.SystemType == LocationSubType or Params.SystemType == LocationLoyalty or (Params.SystemType == "Imperial" and (LocationSubjugation == true or Location == Game.Systems.DSUC))) then
				UnitCount = UnitCount + 1
			end--if
		end--if
	end--for
    --if location counted, update it with new count... 
	return UnitCount
end--function

function PlaceUnit(Params)	--{Unit="",Position={x,y,z}}
	local Unit = nil
	--any left?
	if Units[Params.Unit].Count < Units[Params.Unit].Max then
		Unit = getObjectFromGUID(Units[Params.Unit].BagID).takeObject({smooth=false,position=Params.Position,rotation={0,Units[Params.Unit].AngleY,0}})
		local Location = GetGrid({Position={Params.Position[1],Params.Position[2],Params.Position[3]}}).Location
		local Faction = Units[Params.Unit].Faction
		local Theater = Units[Params.Unit].Theater
		if Location == "" then
			if Faction == "Imperial" then
				Location = "IMPERIAL DEPLOYMENT"
			else
				Location = "REBEL DEPLOYMENT"
			end--if
		end--if
    --update location table theater info...
		Unit.setVar("Location",Location)
    	Locations[Location].Units[Faction][Theater] = Locations[Location].Units[Faction][Theater] + 1
		--wait 1 second for the unit to move to the placement spot before tagging the location...
		Wait.time(function() Unit.setGMNotes(UpdateTag({Text=Unit.getGMNotes(),Tag="Location",Value=Location})) end,1)
		--shrink if going to queue...
		if string.find(Location," QUEUE ") != nil then
			Unit.setScale({Unit.getScale().x*0.5,Unit.getScale().y*0.5,Unit.getScale().z*0.5})
			if Faction == "Imperial" then 
				if Theater == "Space" then
					Unit.highlightOn({0.4,0.4,1})
				else
					Unit.highlightOn({1,0.5,0})
				end--if
			else 
				if Theater == "Space" then
					Unit.highlightOn({1,1,1})
				else
					Unit.highlightOn({1,0,0})
				end--if
			end--if
		end--if
	else
		printToAll("Cannot Place "..Params.Unit.." Unit. (There are not more in the Supply).")
	end--if
	return Unit
end--function 

function BuildUnit(Params)	--{Unit="",Qty=1,Queue=0}
	for Q=1,Params.Qty do
		table.insert(UnitQueue,{Unit=Params.Unit,BagID=Units[Params.Unit].BagID,Location=Params.Location})
	end--for
end--function

function UnitOnLoad(Params) --{Unit=Obj}
	--update variables on the object... 
	local WarningsOn = true
	if Game.Phase == "Setup" then WarningsOn = false end--if
	if Params.Unit.getDescription() == "CachedObject;" then
		Params.Unit.setLuaScript("") 
		log("Stripped Unit code from CachedObject:"..Params.Unit.getGUID())
		return false
	end--if
	Params.Unit.setVar("Component","Unit")
	if Params.Unit.getDescription() == nil then Params.Unit.setDescription("") end--if
	if string.find(Params.Unit.getDescription(),"Imperial;") != nil then
		Params.Unit.setVar("Faction","Imperial")
	else--assume rebel... 
		Params.Unit.setVar("Faction","Rebel")
	end--if
	if string.find(Params.Unit.getDescription(),"Space;") != nil then
		Params.Unit.setVar("Theater","Space")
	else--assume rebel... 
		Params.Unit.setVar("Theater","Ground")
	end--if
	--highlight on?
	if UnitHighlights then 
		if Params.Unit.getVar("Faction") == "Imperial" then
			if Params.Unit.getVar("Theater") == "Space" then
				Params.Unit.highlightOn({0.4,0.4,1})
			else
				Params.Unit.highlightOn({1,0.5,0})
			end--if
		else
			if Params.Unit.getVar("Theater") == "Space" then
				Params.Unit.highlightOn({1,1,1})
			else
				Params.Unit.highlightOn({1,0,0})
			end--if
		end--if
	end--if unit highlights on 
	--update total counts (only if not in state 2)... 
	if Params.Unit.getStateId() < 2 then 
		if Units[Params.Unit.getName()] == nil then
			print("WTF!?",Params.Unit.getName(),":",Params.Unit.getGUID(),":",Params.Unit.getDescription(),":",Params.Unit.getGMNotes())
		else
			Units[Params.Unit.getName()].Count = Units[Params.Unit.getName()].Count + 1
			log(Params.Unit.getName().." count="..Units[Params.Unit.getName()].Count)
		end--if problem with unit name. 
		--print("  Count=",Units[Params.Unit.getName()].Count)
	end--if
	--check max...
	if Units[Params.Unit.getName()].Count > Units[Params.Unit.getName()].Max and WarningsOn then
		--No longer enforce, just warn--Params.Unit.destruct()
		broadcastToAll(Params.Unit.getName().." Unit Count is over the Maximum Limit! ("..Units[Params.Unit.getName()].Count.." of "..Units[Params.Unit.getName()].Max..")",{1,1,0})
	elseif Units[Params.Unit.getName()].Count == Units[Params.Unit.getName()].Max and Units[Params.Unit.getName()].Max > 1 and WarningsOn then
		broadcastToAll(Params.Unit.getName().." Unit Count is at the Maximum Limit. ("..Units[Params.Unit.getName()].Count.." of "..Units[Params.Unit.getName()].Max..")",{1,1,1})
	end--if
	Params.Unit.setGMNotes("")	--remove prev location, it will be redetected to update count if game is reloaded.
	local Location = UnitUpdateLocation(Params.Unit)
	Params.Unit.setVar("Location",Location)
	if string.find(Params.Unit.getDescription(),"Deploy;") != nil then
		UnitFlagDeployment(Params.Unit)
	end--if
	UpdateUnitBox(Params.Unit.getName())
	UnitDamage({Unit=Params.Unit})
end--function

function UnitOnPickUp(Params) --{Unit=Obj,Player=""}
	--when a unit is picked up from a location, remember it, but don't remove from the location unless dropped into a different location...
	local LastLocation = ReadTag({Text=Params.Unit.getGMNotes(),Tag="Location",Default=""})
	Params.Unit.setVar("LastLocation",LastLocation)
  	--if unit has a previous location... 
	if LastLocation != "" then
		Params.Unit.setVar("LastLocation",LastLocation)
		if Params.Player != nil then
			log(Params.Player.." Player picked up "..Params.Unit.getName().." from "..LastLocation)
		else
			log(Params.Unit.getName().." was picked up from "..LastLocation)
		end--if
	end--if
  --pickup pose?
  if Params.Unit.getName() == "Lambda Shuttle" or Params.Unit.getName() == "Delta Shuttle" then
    if Params.Unit.getStateId() == 1 then
      Params.Unit = Params.Unit.setState(2)
    end--if
  end--if
end--function

function UnitOnDrop(Params)	--{Unit=Obj,Player="",Silent=false}
	if Params.Silent == nil then Params.Silent = false end--if
  	--drop pose?
  	if Params.Unit.getName() == "Lambda Shuttle" or Params.Unit.getName() == "Delta Shuttle" then
	    if Params.Unit.getStateId() == 2 then
      		Params.Unit = Params.Unit.setState(1)
    	end--if
  	end--if
	--if unit dropped into a valid location...
	local Location = UnitUpdateLocation(Params.Unit)
	if Location !="" then
		--player dropped it?
		if Params.Player != nil and not Params.Silent then
			log(Params.Player.." Player dropped "..Params.Unit.getName().." into "..Location)
			local LastLocation = Params.Unit.getVar("LastLocation")
			if LastLocation == nil then LastLocation = "" end--if
			if Location != LastLocation then 
				if LastLocation != "" then
					printToAll(Params.Player.." Player moved "..Params.Unit.getName().." from "..LastLocation.." to "..Location,Params.Player)
				else
					printToAll(Params.Player.." Player dropped "..Params.Unit.getName().." into "..Location,Params.Player)
				end--if report drop
			end--if location changed. 
		else
			log(Params.Unit.getName().." was dropped into "..Location)
		end--if
		local LocationInfo = Locations[Location]
		--log unit tallies... 
		if LocationInfo != nil then
			log(" Rebel Space:"..LocationInfo.Units.Rebel.Space..", Ground:"..LocationInfo.Units.Rebel.Ground..", Recruits:"..LocationInfo.Units.Rebel.Recruits.."\n Imperial Space:"..LocationInfo.Units.Imperial.Space..", Ground:"..LocationInfo.Units.Imperial.Ground)
		end--if
	end--if
	Params.Unit.setVar("LastLocation","")
end--function

function UnitOnDestroy(Params)	--{Unit=Obj}
    --remove from inventory and upate box display if not state 2... 
    if Params.Unit.getStateId() < 2 then 
		Units[Params.Unit.getName()].Count = Units[Params.Unit.getName()].Count - 1
		log(Params.Unit.getName().." count="..Units[Params.Unit.getName()].Count)
		UpdateUnitBox(Params.Unit.getName())
		--remove from location and theater count...
		local Location = ReadTag({Text=Params.Unit.getGMNotes(),Tag="Location",Default=""})
		local Faction = Units[Params.Unit.getName()].Faction
		local Theater = Units[Params.Unit.getName()].Theater
		--if there was a previous location then remove the unit from it...
		if Locations[Location] != nil then
			--do not let the count go below zero... 
			if Locations[Location].Units[Faction][Theater] > 0 then
				Locations[Location].Units[Faction][Theater] = Locations[Location].Units[Faction][Theater] - 1
			end--if
			printToAll(Params.Unit.getName().." was destroyed at "..Location..".",{1,1,0})
			--look for system loyalty marker...
			local MarkerID = ScanForObjectID({Description="LoyaltyMarker;",Origin=Locations[Location].MarkerSpot,Debug=false})
			--if there is a loyalty marker...
			if getObjectFromGUID(MarkerID) != nil then
				--if it is not an imperial loyalty marker...
				if getObjectFromGUID(MarkerID).getName() != "Imperial Loyalty" then
					--if marker is Subjugated...
					if getObjectFromGUID(MarkerID).getRotation().z > 90 and getObjectFromGUID(MarkerID).getRotation().z < 270 then
						--last imperial ground unit leaving populous system? (we know it is subjugated, and not imperial loyal)... 
						if Faction == "Imperial" and Theater == "Ground" and Locations[Location].Subtype == "Populous" and Locations[Location].Units[Faction][Theater] == 0 then
							--remove subjugation status and flip marker over...
							Locations[Location].Subjugated = false
							getObjectFromGUID(MarkerID).setRotationSmooth({0,180,0},false,false)
							getObjectFromGUID(MarkerID).setPositionSmooth({getObjectFromGUID(MarkerID).getPosition().x,0.69,getObjectFromGUID(MarkerID).getPosition().z},false,true)
							printToAll("\n"..Location.." is no longer Subjugated.",{1,0.65,0})
						end--if
					end--if
				end--if  
			end--if
			--is theres a combat marker in the last system, then check to see if we should remove it...
			if Locations[Location].CombatMarkerID != "" then
				CombatCheck({System=Location})
			end--if
		end--if
	end--if
	return Location	--return the location that was just vacated.
end--function

function UnitOnCollision(Params)	--{Unit=Obj,Info=collision_info}
	if Params.Info.collision_object.type == "Infinite" then
		Params.Unit.destruct()
	end--if
end--function 

function UnitUpdateLocation(UnitObj)
	--set Location by grid position (or battlefield location).  If location changed, remove from old location and add to new... 
	--get the unit's faction and theater... 
	local Faction = Units[UnitObj.getName()].Faction
	local Theater = Units[UnitObj.getName()].Theater
	--try to get location from gmnotes... 
	local LastLocation = ReadTag({Text=UnitObj.getGMNotes(),Tag="Location",Default=""})
	--get new location by position of unit on board... 
	local Location = ""
	if not UnitHighlights then UnitObj.highlightOff() end--if leave highlights on?						
	UnitObj.setScale(Units[UnitObj.getName()].Scale)
	--if unit is on the combat board...
	if UnitObj.getPosition().x > 22.5 and UnitObj.getPosition().x < 44.5 and UnitObj.getPosition().z > -11 and UnitObj.getPosition().z < 11 then
		--if there is a current combat location...
		if CombatLocation != nil and CombatLocation != "" then
			Location = CombatLocation
		end--if
		if Faction == "Imperial" then 
			if Theater == "Space" then
				UnitObj.highlightOn({0.4,0.4,1})
			else
				UnitObj.highlightOn({1,0.5,0})
			end--if
		else 
			if Theater == "Space" then
				UnitObj.highlightOn({1,1,1})
			else
				UnitObj.highlightOn({1,0,0})
			end--if
		end--if
	elseif Faction == "Rebel" and UnitObj.getPosition().z > 0 and UnitObj.getPosition().x < -21.5 then
		--assume it's in the rebel base space... 
		Location = "REBEL BASE"
	else --try to get the location from the grid position... 
		--remove any damage... 
		UnitClearDamage(UnitObj)
		--get location... 
		Location = GetGrid({Position=UnitObj.getPosition()}).Location
		if Location != "" then
			UnitObj.setGMNotes("Location:"..Location..";")
		else
			UnitObj.setGMNotes("")
		end--if
		--shrink and highlight if going to queue...
		if string.find(Location,"QUEUE") != nil then
			UnitObj.setScale({Units[UnitObj.getName()].Scale[1]*0.5,Units[UnitObj.getName()].Scale[2]*0.5,Units[UnitObj.getName()].Scale[3]*0.5})
			if Faction == "Imperial" then 
				if Theater == "Space" then
					UnitObj.highlightOn({0.4,0.4,1})
				else
					UnitObj.highlightOn({1,0.5,0})
				end--if
			else 
				if Theater == "Space" then
					UnitObj.highlightOn({1,1,1})
				else
					UnitObj.highlightOn({1,0,0})
				end--if
			end--if
		end--if
	end--if
	local GroundAlertText = ""  --this flags an alert if needed later.
	--did location change?
	log(UnitObj.getName()..":"..UnitObj.getGUID().." moved from '"..LastLocation.."' to '"..Location.."'.")
	if Location != LastLocation then
		--if there was a previous location then remove the unit from it...
		if Locations[LastLocation] != nil then
			log("Removing "..UnitObj.getName()..":"..UnitObj.getGUID().." from '"..LastLocation..".")
			--do not let the count go below zero... 
			if Locations[LastLocation].Units[Faction][Theater] > 0 then
				Locations[LastLocation].Units[Faction][Theater] = Locations[LastLocation].Units[Faction][Theater] - 1
			end--if
			--recruit? then reduce recruit count... 
			if UnitObj.getName() == "Recruit" then
				Locations[LastLocation].Units[Faction].Recruits = Locations[LastLocation].Units[Faction].Recruits - 1
			end--if
			--structure? then reduce structure count... 
      if Units[UnitObj.getName()].Type == "Structure" then
        Locations[LastLocation].Units[Faction].Structures = Locations[LastLocation].Units[Faction].Structures - 1
      end--if
      --look for system loyalty marker...
			local MarkerID = ScanForObjectID({Description="LoyaltyMarker;",Origin=Locations[LastLocation].MarkerSpot,Debug=false})
			--if there is a loyalty marker...
			if getObjectFromGUID(MarkerID) != nil then
				--if it is not an imperial loyalty marker...
				if getObjectFromGUID(MarkerID).getName() != "Imperial Loyalty" then
					--if marker is Subjugated...
					if getObjectFromGUID(MarkerID).getRotation().z > 90 and getObjectFromGUID(MarkerID).getRotation().z < 270 then
						--last imperial ground unit leaving populous system? (we know it is subjugated, and not imperial loyal)... 
						if Faction == "Imperial" and Theater == "Ground" and Locations[LastLocation].Subtype == "Populous" and Locations[LastLocation].Units[Faction][Theater] == 0 then
							--remove subjugation status and flip marker over...
							Locations[LastLocation].Subjugated = false
							getObjectFromGUID(MarkerID).setRotationSmooth({0,180,0},false,false)
							getObjectFromGUID(MarkerID).setPositionSmooth({getObjectFromGUID(MarkerID).getPosition().x,0.69,getObjectFromGUID(MarkerID).getPosition().z},false,true)
							printToAll("\n"..LastLocation.." is no longer Subjugated.",{1,0.65,0})
						end--if
					end--if
				end--if  
			end--if
			--is theres a combat marker in the last system, then check to see if we should remove it...
			if Locations[LastLocation].CombatMarkerID != "" then
				CombatCheck({System=LastLocation})
			end--if
		end--if
		if Locations[Location] != nil then
			log("Adding "..UnitObj.getName()..":"..UnitObj.getGUID().." to '"..Location..".")
			--increment theater count of new location... 
			Locations[Location].Units[Faction][Theater] = Locations[Location].Units[Faction][Theater] + 1
			--recruit? then increment recruits count... 
			if UnitObj.getName() == "Recruit" then
				Locations[Location].Units[Faction].Recruits = Locations[Location].Units[Faction].Recruits + 1
			end--if
			--structure? then increment structure count... 
      if Units[UnitObj.getName()].Type == "Structure" then
        Locations[Location].Units[Faction].Structures = Locations[Location].Units[Faction].Structures + 1
      end--if
      --update new location data... 
			UnitObj.setGMNotes(UpdateTag({Text=UnitObj.getGMNotes(),Tag="Location",Value=Location}))
			--save location as a variable to the object...
			UnitObj.setVar("Location",Location)
			--is this unit an imperial ground unit in a system?
			if Faction == "Imperial" and Theater == "Ground" and Locations[Location].Type == "System" then
				--first imperial ground unit that came from a different location?
				if Locations[Location].Units["Imperial"].Ground == 1 and LastLocation != Location and Game.Phase != "Setup" and Game.Phase != "Refresh" then
					GroundAlertText = "\nImperial Ground Unit have landed in "..Location.."."
				end--if
				local MarkerID = ScanForObjectID({Description="LoyaltyMarker;",Origin=Locations[Location].MarkerSpot,Debug=false})
				--if there is a loyalty marker...
				if getObjectFromGUID(MarkerID) != nil then
					--if Imperial Loyalty Marker...
					if getObjectFromGUID(MarkerID).getName() == "Imperial Loyalty" then
						GroundAlertText = "" --no need to scan Imperial Loyal System.
					elseif getObjectFromGUID(MarkerID).getRotation().z < 90 or getObjectFromGUID(MarkerID).getRotation().z > 270 then  --if marker not already flipped to subjugated...
						--initiate subjugation... 
						Locations[Location].Subjugated = true
						getObjectFromGUID(MarkerID).setRotationSmooth({0,180,180},false,false)
						getObjectFromGUID(MarkerID).setPositionSmooth({getObjectFromGUID(MarkerID).getPosition().x,0.79,getObjectFromGUID(MarkerID).getPosition().z},false,true)
						GroundAlertText = "\nImperial Ground Units have Subjugated "..Location.."."
					end--if
				elseif Location == "CORUSCANT" then
					GroundAlertText = "" --no need to scan Imperial Loyal System (CORUSCANT HAS NO MAKER TO SCAN FOR).
				end--if
			end--if
			--display ground alert message if there is one... 
			if GroundAlertText != "" then
				printToAll(GroundAlertText,{1,0.65,0})
			end--if
			--see if we need a combat marker (any existing will be replaced)...
			if not CombatCheck({System=Location,Initiated=Faction}) then
				--if not in setup, and there was a ground alert...
				if Game.Phase != "Setup" and Loaded and GroundAlertText != "" then
					--prompt to scan for the rebel base...
					ScanForRebelBasePrompt({System=Location})
				end--if
			end--if
		else--remove location tag...
			UnitObj.setGMNotes(RemoveTag({Text=UnitObj.getGMNotes(),Tag="Location"}))
		end--if
	end--if
	return Location
end--function

function UpdateUnitBox(UnitName)
	local Box = getObjectFromGUID(Units[UnitName].BagID)
	if Box != nil then
		local Count = Units[UnitName].Count
		local Max = Units[UnitName].Max
		  Box.clearButtons()
		Box.createButton({click_function="onLoad",function_owner=Global,label=(Count).." of "..Max.."\n"..UnitName.."\nin play.",position={0,1,0.65},width=0,height=0,font_size=90,font_color={0,0,0}})
		Box.createButton({click_function="onLoad",function_owner=Global,label=(Count).." of "..Max.."\n"..UnitName.."\nin play.",position={0,1.01,0.66},width=0,height=0,font_size=90,font_color={1,1,1}})
	end--if
end--function

function UnitFlagDeployment(Unit)
	local Scale = 1 / Unit.getScale().x
  	Unit.clearButtons()
  	Unit.createButton({click_function="UnitFlagDeployment",function_owner=Global,label="*",position=Units[Unit.getName()].DamageOffset,scale={Scale,Scale,Scale},rotation={0,0,0},width=0,height=0,font_size=300,font_color={1,1,0,0.7}})
	--add deploy tag if not already present... 
	if string.find(Unit.getDescription(),"Deploy;") == nil then
		Unit.setDescription(Unit.getDescription().."Deploy;")
	end--if
end--function

function UnitDamage(Params)	--{Unit=Obj}
	Params.Unit.clearButtons()
	local UnitInfo = Units[Params.Unit.getName()]
	local Factor = 1.35
	local Scale = {Factor/Params.Unit.getScale().x,Factor/Params.Unit.getScale().y,Factor/Params.Unit.getScale().z}
	local Rotation = {0,UnitInfo.AngleY,0}
	local ButtonX = 0.1*Scale[1]
	if UnitInfo.Faction == "Imperial" then 
		Rotation[2] = Rotation[2] + 180 
		ButtonX = -ButtonX
	end--if
	local Damage = ReadTag({Text=Params.Unit.getGMNotes(),Tag="Damage",Default="0"})+0
	local DamageOffset = UnitInfo.DamageOffset
	if Params.Unit.getName() == "Death Star" then
		Damage = 0
	elseif Damage != 0 then
		--if not already has a damage token attached, then add one... 
		if #Params.Unit.getAttachments() == 0 then
			local DT = getObjectFromGUID(IDs.Imperial.DamageBag).takeObject()	--get a new damage token from the bag.
			DT.setColorTint(DT.getColorTint():setAt("a",0.8))	--set damage token to semi-transparent.
			DT.setRotation({0,Params.Unit.getRotation().y,0})	--stabilize unit rotation.
			DT.setRotation({0,Params.Unit.getRotation().y,0})
			DT.setPosition({Params.Unit.getPosition().x,Params.Unit.getPosition().y+Units[Params.Unit.getName()].DamageY,Params.Unit.getPosition().z})
			Params.Unit.addAttachment(DT)
		end--if
		if UnitInfo.AngleY == 0 then ButtonX = -ButtonX end--if
		Params.Unit.createButton({click_function="UnitAddDamage",function_owner=Global,label="+",position={DamageOffset[1]+ButtonX,DamageOffset[2]+0.01,DamageOffset[3]},rotation=Rotation,scale=Scale,width=100,height=250,color={1,0,0,0.1},hover_color={1,0,0,1},font_size=100,font_color={0,0,0},tooltip="+1 Damage ("..Params.Unit.getName()..")."})
		Params.Unit.createButton({click_function="UnitRemoveDamage",function_owner=Global,label="-",position={DamageOffset[1]-ButtonX,DamageOffset[2]+0.01,DamageOffset[3]},rotation=Rotation,scale=Scale,width=100,height=250,color={1,0,0,0.1},hover_color={1,0,0,1},font_size=100,font_color={0,0,0},tooltip="-1 Damage ("..Params.Unit.getName()..")."})
		Params.Unit.createButton({click_function="NA",function_owner=Global,label=Damage,position=DamageOffset,rotation=Rotation,scale=Scale,width=0,height=0,font_size=275,font_color={0,0,0}})
		Params.Unit.createButton({click_function="NA",function_owner=Global,label=Damage,position=DamageOffset,rotation=Rotation,scale=Scale,width=0,height=0,font_size=250,font_color={1,1,0}})
	else--no damage... 
		Params.Unit.destroyAttachments()
	end--if
	Params.Unit.setVar("Damage",Damage)
end--function

function UnitAddDamage(UnitObj)
	local Notes = UnitObj.getGMNotes()
	local Damage = ReadTag({Text=Notes,Tag="Damage",Default="0"})+0
	local DamageString = string.match(Notes,"Damage:.-;")
	if DamageString != nil then
		--remove Damage tag...
		Notes = string.gsub(Notes,DamageString,"")
	end--if
	Damage = Damage + 1
	UnitObj.setGMNotes(Notes.."Damage:"..Damage..";")
	printToAll(UnitObj.getName().." Damage increased to "..Damage..".")
	UnitDamage({Unit=UnitObj})
end--function

function UnitRemoveDamage(UnitObj)
	local Damage = ReadTag({Text=UnitObj.getGMNotes(),Tag="Damage",Default="0"})+0
	local DamageString = string.match(UnitObj.getGMNotes(),"Damage:.-;")
	local Notes = string.gsub(UnitObj.getGMNotes(),DamageString,"")
	if Damage > 1 then
		Damage = Damage - 1
		UnitObj.setGMNotes(Notes.."Damage:"..Damage..";")
	else--remove damage tag when zero
		Damage = 0
		UnitObj.setGMNotes(Notes)
	end--if
	printToAll(UnitObj.getName().." Damage decreased to "..Damage..".")
	UnitDamage({Unit=UnitObj})
end--function

function UnitClearDamage(UnitObj)
  if string.find(UnitObj.getGMNotes(),"Damage:") != nil then
    local Damage = ReadTag({Text=UnitObj.getGMNotes(),Tag="Damage",Default="0"})+0
    local DamageString = string.match(UnitObj.getGMNotes(),"Damage:.-;")
    local Notes = string.gsub(UnitObj.getGMNotes(),DamageString,"")
    UnitObj.setGMNotes(Notes)
    UnitObj.clearButtons()
	UnitObj.destroyAttachments()
end--if
end--function

function ToggleUnitHighlights()
	if UnitHighlights then
		UnitHighlights = false
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getVar("Component") == "Unit" then
				Obj.highlightOff()
			end--if
		end--for O,Obj 
	else
		UnitHighlights = true
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getVar("Component") == "Unit" then
				if Obj.getVar("Faction") == "Imperial" then
					if Obj.getVar("Theater") == "Space" then
						Obj.highlightOn({0.4,0.4,1})
					else
						Obj.highlightOn({1,0.5,0})
					end--if
				else
					if Obj.getVar("Theater") == "Space" then
						Obj.highlightOn({1,1,1})
					else
						Obj.highlightOn({1,0,0})
					end--if
				end--if
			end--if
		end--for O,Obj 
	end--if
end--function 

--COMBAT/DICE FUNCTIONS====================================================================================================================================

function CombatCheckAllSystems()
	--check for combat situations...
	for L,Location in pairs(Locations) do
		CombatCheck({System=L})
	end--for
end--function

function ScanForRebelBasePrompt(Params) --{System=""}
	--do not scan during refresh phase... 
	if Game.Phase != "Refresh" and Game.Phase != "Setup" then
		--no need to scan twice... 
		if not Locations[Params.System].Scanned then
			--no need to scan if the rebel base is not hidden... 
			if IsBaseHidden() then
				local Location = Locations[Params.System]
				--don't duplicate prompts if one already exists... 
				if getObjectFromGUID(Location.CombatMarkerID) == nil and Location.Type == "System" then
					--create a scan marker above this location...
					local ScanMarker = getObjectFromGUID(IDs.CombatMarkerBag).takeObject({smooth=false,position={Location.MarkerSpot[1],0,Location.MarkerSpot[3]},rotation={0,180,0}})
					Location.CombatMarkerID=ScanMarker.getGUID()
					ScanMarker.setName(Params.System)
					ScanMarker.setLock(true)
					ScanMarker.setPosition({Location.MarkerSpot[1],0.65,Location.MarkerSpot[3]})
					ScanMarker.setRotation({0,180,0})
					ScanMarker.setDescription("ScanMarker;")
					ScanMarker.clearButtons()
					ScanMarker.createButton({click_function = "ScanForRebelBase",function_owner = Global,label=Params.System.."\nScan for\nRebel Base",position={0,2,0},rotation={0,0,0},width=2400,height=1200,scale={0.75,0.75,0.75},color={0.5,0.5,1,0.9},font_size=300,font_color={0,0,0},tooltip="After all Units have been moved in, or finalizing Imperial Loyalty change, click here to scan for the Rebel Base in this System."})
					ScanMarker.createButton({click_function = "CancelScanForRebelBase",function_owner = Global,label="Cancel Scan",position={0,2,1.3},rotation={0,0,0},width=2400,height=400,scale={0.75,0.75,0.75},color={0.5,0.5,1,0.9},font_size=300,font_color={0,0,0},tooltip="Do NOT scan this System for the Rebel Base."})
				end--if
			else--no need to scan for base, it is not hidden... 
				printToAll("(No need to Scan for the Rebel Base).", {0.5,0.5,1})
			end--if
		end--if
	end--if
end--function
	
function ScanForRebelBase(MarkerObj)
	Locations[MarkerObj.getName()].Scanned = true
	if GetBaseLocation() == MarkerObj.getName() then
		UpdateImperialProbeMap(MarkerObj.getName(),6)
		RevealRebelBase()
	else
		broadcastToAll("No Base detected in "..MarkerObj.getName()..".",{0.5,0.5,1})
		UpdateImperialProbeMap(MarkerObj.getName(),3)
	end--if
	MarkerObj.destruct()
end--function 

function CancelScanForRebelBase(MarkerObj)
	MarkerObj.destruct()
end--function 

function CombatCheck(Params) --{System="",Initiated=""}
	--checks if combat needs to be resolved in the specified location.  returns true/false.
	local CombatFlag = false
	local LocationInfo = Locations[Params.System]
	--only check system locations... 
	if LocationInfo.Type == "System" then
		--log("CombatCheck:"..Params.System.."\n Space:"..LocationInfo.Units.Rebel.Space.." vs "..LocationInfo.Units.Imperial.Space.."\n Ground:"..LocationInfo.Units.Rebel.Ground.." vs "..LocationInfo.Units.Imperial.Ground)
		--opposing units in the same theater?
		if (LocationInfo.Units.Rebel.Space > 0 and LocationInfo.Units.Imperial.Space > 0) or ((LocationInfo.Units.Rebel.Ground - LocationInfo.Units.Rebel.Recruits) > 0 and LocationInfo.Units.Imperial.Ground > 0) then
			log(" Opposing Units in the same Theater detected.")
			local MarkerFlag = true --assume true: if no combat marker, and no combat not already underway for this location, place one, replace scanmarker if present.
			if Params.System == CombatLocation then
				log(" Combat already at:"..CombatLocation)
				MarkerFlag = false  --no need to prompt for combat, it's already happening. 
			end--if
			--if there is an existing marker and we haven't ruled out the need for a new one... 
			if MarkerFlag and getObjectFromGUID(LocationInfo.CombatMarkerID) != nil then
				log(" Existing Marker:"..LocationInfo.CombatMarkerID)
				--if it's a combat marker, no need to make a new one, if it's a scan marker, replace it with a combat marker... 
				if string.find(getObjectFromGUID(LocationInfo.CombatMarkerID).getDescription(),"CombatMarker;") != nil then
					log(" (Do not duplicate Combat Marker)")
					MarkerFlag = false
				else--remove the existing marker (assumed to be scan marker)... 
					getObjectFromGUID(LocationInfo.CombatMarkerID).destruct()
				end--if
			end--if
			--if we need to create a combat marker prompt... 
			if MarkerFlag then 
				--create a combat marker above this location...
				local CombatMarker = getObjectFromGUID(IDs.CombatMarkerBag).takeObject({smooth=false,position={LocationInfo.MarkerSpot[1],0,LocationInfo.MarkerSpot[3]},rotation={180,0,0}})
				LocationInfo.CombatMarkerID=CombatMarker.getGUID()
				CombatMarker.setName(Params.System)
				CombatMarker.setLock(true)
				CombatMarker.setPosition({LocationInfo.MarkerSpot[1],0.65,LocationInfo.MarkerSpot[3]})
				CombatMarker.setRotation({0,180,0})
				local Desc = "CombatMarker;"
				if Params.Initiated != nil then
					Desc = Desc.."Initiated:"..Params.Initiated..";"
				end--if
				CombatMarker.setDescription(Desc)
				CombatMarker.clearButtons()
				CombatMarker.createButton({click_function = "ResolveCombat",function_owner = Global,label=Params.System.."\nResolve Combat!",position={0,2,0},rotation={0,0,0},width=2400,height=1200,scale={1,1,1},color={1,1,0,0.9},font_size=300,font_color={0,0,0},tooltip="After all Units have been moved in, click here to resolve Combat in this System."})
			end--if
			CombatFlag = true
		elseif getObjectFromGUID(LocationInfo.CombatMarkerID) != nil then
			--if Marker Name matches system and combat marker or (scan marker and no imperial ground units) then remove it...
			if getObjectFromGUID(LocationInfo.CombatMarkerID).getName() == Params.System and (string.find(getObjectFromGUID(LocationInfo.CombatMarkerID).getDescription(),"CombatMarker;") != nil or LocationInfo.Units.Imperial.Ground < 1) then
				getObjectFromGUID(LocationInfo.CombatMarkerID).destruct()
				LocationInfo.CombatMarkerID = ""
			end--if
		end--if
		if not SuppressVictoryCheck then
			--imperial victory condition?  Imperial units present, base revealed, no rebel units.
			if LocationInfo.Units.Imperial.Space + LocationInfo.Units.Imperial.Ground > 0 and LocationInfo.Units.Rebel.Space + LocationInfo.Units.Rebel.Ground - LocationInfo.Units.Rebel.Recruits + Locations["REBEL BASE"].Units.Rebel.Space + Locations["REBEL BASE"].Units.Rebel.Ground < 1 then
				if GetBaseLocation() == Params.System then
					if IsBaseRevealed() then
						broadcastToAll("IMPERIAL VICTORY DETECTED!",{1,1,0})
						printToAll("The Rebel Base is revealed, there are Imperial Units present, and no Rebel Units to defend.",{1,1,0})
						PlaySound({ID=12})
					end--if
				end--if
			end--if
		end--if (not suppressing victory check)
		--return combat flag... 
		--log(" Combat:"..tostring(CombatFlag))
	end--if
	return CombatFlag
end--function

function ResolveCombat(CombatObj)
	if CombatLocation == nil then
		CombatLocation = ""
	end--if
    local NewLocation = CombatLocation
    if CombatObj != nil then
        NewLocation = CombatObj.getName()
        CombatObj.destruct()
    end--if
	--combat already underway?
	if CombatLocation == "" or CombatLocation == NewLocation then
        --random combat intro sound for now....
		PlaySound({ID=math.random(38,51)})
		Locations[NewLocation].CombatMarkerID = ""
		CombatLocation = NewLocation
        --imperial ground units?
        if Locations[CombatLocation].Units.Imperial.Ground > 0 then
            --is this the rebel base?
            if IsBaseHidden() then
                if CombatLocation == GetBaseLocation() then
                    RevealRebelBase()
                end--if
            end--if
        end--if
		--ping Combat panels...
		Ping({Position=PanelSpots.RebelCombat.Position,Player="White"})
		Ping({Position=PanelSpots.ImperialCombat.Position,Player="Blue"})
        --allocate any existing units in the combat theater... 
        for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do
            if Obj.getVar("Component") == "Unit" then
                --update existing objects to new combat location...
                UnitUpdateLocation(Obj)
            end--if
        end--for O,Obj 
		--use these as counter/indexes...
		RL=0 IL=0 DSUC=0 DS=0 SSD=0	SD=0 ID=0 AC=0 TS=0 TF=0 ATAT=0 SB=0 ATST=0 AT=0 ST=0 RT=0 RV=0 AS=0 GAT=0 SG=0 IC=0 XW=0 YW=0 UW=0 GR75=0 CC=0 NBF=0 MCC=0 AW=0 BW=0 LF=0 HC=0 EC=0 MC75=0 MC80=0 WV=0 JK=0 TI=0 TB=0 TA=0 TD=0 LSH=0 DSH=0 LC=0 SCTT=0 DTHT=0 DRKT=0
		for O,Obj in pairs(getAllObjects()) do
			--unit or leader?
			if Obj.getVar("Component") == "Unit" or Obj.getVar("Component") == "Leader" then
				--ignore captured leaders... 
				local Captured = false
				if Obj.getVar("Component") == "Leader" then
					--does this leader have an attachment?
					for I,Item in pairs(Obj.getAttachments()) do
						--ring?
						if string.find(Item.description,"Ring;") != nil then
							--captured?
							if Item.name == "Captured" or Item.name == "Carbonite" then
								Captured = true
							end--if
						end--if
					end--for
				end--if (leader)
				--from location and not captured?
				if ReadTag({Text=Obj.getGMNotes(),Tag="Location",Default=""}) == CombatLocation and Captured == false then
                    --if the unit is within the board area, remember its exact position/rotation to return there... 
                    if Obj.getPosition().x > -22 and Obj.getPosition().x < 22 and Obj.getPosition().z > -11 and Obj.getPosition().z < 11 then
                        --store it's position and rotation before moving to combat theater...
                        Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="X",Value=string.format("%.2f",Obj.getPosition().x+25)}))
                        Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="Y",Value=string.format("%.2f",Obj.getPosition().y)}))
                        Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="Z",Value=string.format("%.2f",Obj.getPosition().z+25)}))
                        Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="RX",Value=string.format("%.2f",Obj.getRotation().x)}))
                        Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="RY",Value=string.format("%.2f",Obj.getRotation().y)}))
                        Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="RZ",Value=string.format("%.2f",Obj.getRotation().z)}))
                    end--if
					--rotate based on unit info, if it is a unit... 
					local Rotation = {0,0,0}
					if Units[Obj.getName()] != nil then
						Rotation = {0,Units[Obj.getName()].AngleY,0}
					end--if
					Obj.setRotationSmooth(Rotation,false,false)
					--highlight the units so we can see it better... 
					if Obj.getVar("Component") == "Unit" and Obj.getName() != "Recruit" then 
						if Obj.getVar("Faction") == "Imperial" then 
							if Obj.getVar("Theater") == "Space" then
								Obj.highlightOn({0.4,0.4,1})
							else
								Obj.highlightOn({1,0.5,0})
							end--if
  						else
							if Obj.getVar("Theater") == "Space" then
								Obj.highlightOn({1,1,1})
							else
								Obj.highlightOn({1,0,0})
							end--if
						end--if faction
					end--if
					--move the unit based on it's type...
					if Obj.getName() == "Stormtrooper" then
						ST = ST + 1
                        if ST > #Spots.Combat.ST then ST = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.ST[ST],false,false)
					elseif Obj.getName() == "Assault Tank" then
						AT = AT + 1
                        if AT > #Spots.Combat.AT then AT = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.AT[AT],false,false)
					elseif Obj.getName() == "AT-ST" then
						ATST = ATST + 1
                        if ATST > #Spots.Combat.ATST then ATST = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.ATST[ATST],false,false)
					elseif Obj.getName() == "Shield Bunker" then
						SB = SB + 1
                        if SB > #Spots.Combat.SB then SB = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.SB[SB],false,false)
					elseif Obj.getName() == "AT-AT" then
						ATAT = ATAT + 1
                        if ATAT > #Spots.Combat.ATAT then ATAT = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.ATAT[ATAT],false,false)
					elseif Obj.getName() == "TIE Fighter" then
						TF = TF + 1
                        if TF > #Spots.Combat.TF then TF = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.TF[TF],false,false)
					elseif Obj.getName() == "TIE Striker" then
						TS = TS + 1
                        if TS > #Spots.Combat.TS then TS = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.TS[TS],false,false)
					elseif Obj.getName() == "Assault Carrier" then
						AC = AC + 1
                        if AC > #Spots.Combat.AC then AC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.AC[AC],false,false)
					elseif Obj.getName() == "Star Destroyer" then
						SD = SD + 1
                        if SD > #Spots.Combat.SD then SD = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.SD[SD],false,false)
					elseif Obj.getName() == "Interdictor" then
						ID = ID + 1
                        if ID > #Spots.Combat.ID then ID = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.ID[ID],false,false)
					elseif Obj.getName() == "Super Star Destroyer" then
						SSD = SSD + 1
                        if SSD > #Spots.Combat.SSD then SSD = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.SSD[SSD],false,false)
					elseif Obj.getName() == "Death Star Under Construction" then
						DSUC = DSUC + 1
                        if DSUC > #Spots.Combat.DSUC then DSUC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.DSUC[DSUC],false,false)
					elseif Obj.getName() == "Death Star" then
						DS = DS + 1
                        if DS > #Spots.Combat.DS then DS = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.DS[DS],false,false)
					elseif Obj.getName() == "Rebel Trooper" then
						RT = RT + 1
                        if RT > #Spots.Combat.RT then RT = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.RT[RT],false,false)
					elseif Obj.getName() == "Rebel Vanguard" then
						RV = RV + 1
                        if RV > #Spots.Combat.RV then RV = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.RV[RV],false,false)
					elseif Obj.getName() == "Airspeeder" then
						AS = AS + 1
                        if AS > #Spots.Combat.AS then AS = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.AS[AS],false,false)
					elseif Obj.getName() == "Golan Arms Turret" then
						GAT = GAT + 1
                        if GAT > #Spots.Combat.GAT then GAT = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.GAT[GAT],false,false)
					elseif Obj.getName() == "Ion Cannon" then
						IC = IC + 1
                        if IC > #Spots.Combat.IC then IC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.IC[IC],false,false)
					elseif Obj.getName() == "Shield Generator" then
						SG = SG + 1
                        if SG > #Spots.Combat.SG then SG = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.SG[SG],false,false)
					elseif Obj.getName() == "X-Wing" then
						XW = XW + 1
                        if XW > #Spots.Combat.XW then XW = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.XW[XW],false,false)
					elseif Obj.getName() == "Y-Wing" then
						YW = YW + 1
                        if YW > #Spots.Combat.YW then YW = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.YW[YW],false,false)
					elseif Obj.getName() == "Rebel Transport" then
						GR75 = GR75 + 1
                        if GR75 > #Spots.Combat.GR75 then GR75 = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.GR75[GR75],false,false)
					elseif Obj.getName() == "U-Wing" then
						UW = UW + 1
                        if UW > #Spots.Combat.UW then UW = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.UW[UW],false,false)
					elseif Obj.getName() == "Corellian Corvette" then
						CC = CC + 1
                        if CC > #Spots.Combat.CC then CC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.CC[CC],false,false)
					elseif Obj.getName() == "Nebulon-B Frigate" then
						NBF = NBF + 1
                        if NBF > #Spots.Combat.NBF then NBF = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.NBF[NBF],false,false)
					elseif Obj.getName() == "Mon Cala Cruiser" then
						MCC = MCC + 1
                        if MCC > #Spots.Combat.MCC then MCC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.MCC[MCC],false,false)
					elseif Obj.getVar("Component") == "Leader" then
						if Obj.getVar("Faction") == "Rebel" then
							RL = RL + 1
							if RL > #Spots.Combat.RL then RL = 1 end--if
							Obj.setPositionSmooth(Spots.Combat.RL[RL],false,false)
							Obj.setRotationSmooth({0,0,0})
						else--assume imperial... 
							IL = IL + 1
							if IL > #Spots.Combat.IL then IL = 1 end--if
							Obj.setPositionSmooth(Spots.Combat.IL[IL],false,false)
							Obj.setRotationSmooth({0,180,0})
						end--if
					elseif Obj.getName() == "A-Wing" then
						AW = AW + 1
                        if AW > #Spots.Combat.AW then AW = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.AW[AW],false,false)
					elseif Obj.getName() == "B-Wing" then
						BW = BW + 1
                        if BW > #Spots.Combat.BW then BW = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.BW[BW],false,false)
					elseif Obj.getName() == "Light Freighter" then
						LF = LF + 1
                        if LF > #Spots.Combat.LF then LF = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.LF[LF],false,false)
					elseif Obj.getName() == "Hammerhead Corvette" then
						HC = HC + 1
                        if HC > #Spots.Combat.HC then HC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.HC[HC],false,false)
					elseif Obj.getName() == "Escort Carrier" then
						EC = EC + 1
                        if EC > #Spots.Combat.EC then EC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.EC[EC],false,false)
					elseif Obj.getName() == "MC75 Cruiser" then
						MC75 = MC75 + 1
                        if MC75 > #Spots.Combat.MC75 then MC75 = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.MC75[MC75],false,false)
					elseif Obj.getName() == "MC80 Cruiser" then
						MC80 = MC80 + 1
                        if MC80 > #Spots.Combat.MC80 then MC80 = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.MC80[MC80],false,false)
					elseif Obj.getName() == "Wookiee Veteran" then
						WV = WV + 1
                        if WV > #Spots.Combat.WV then WV = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.WV[WV],false,false)
					elseif Obj.getName() == "Jedi Knight" then
						JK = JK + 1
                        if JK > #Spots.Combat.JK then JK = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.JK[JK],false,false)
					elseif Obj.getName() == "TIE Interceptor" then
						TI = TI + 1
                        if TI > #Spots.Combat.TI then TI = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.TI[TI],false,false)
					elseif Obj.getName() == "TIE Bomber" then
						TB = TB + 1
                        if TB > #Spots.Combat.TB then TB = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.TB[TB],false,false)
					elseif Obj.getName() == "TIE Advanced" then
						TA = TA + 1
                        if TA > #Spots.Combat.TA then TA = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.TA[TA],false,false)
					elseif Obj.getName() == "TIE Defender" then
						TD = TD + 1
                        if TD > #Spots.Combat.TD then TD = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.TD[TD],false,false)
					elseif Obj.getName() == "Lambda Shuttle" then
						LSH = LSH + 1
                        if LSH > #Spots.Combat.LSH then LSH = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.LSH[LSH],false,false)
					elseif Obj.getName() == "Delta Shuttle" then
						DSH = DSH + 1
                        if DSH > #Spots.Combat.DSH then DSH = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.DSH[DSH],false,false)
					elseif Obj.getName() == "Light Cruiser" then
						LC = LC + 1
                        if LC > #Spots.Combat.LC then LC = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.LC[LC],false,false)
					elseif Obj.getName() == "Scout Trooper" then
						SCTT = SCTT + 1
                        if SCTT > #Spots.Combat.SCTT then SCTT = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.SCTT[SCTT],false,false)
					elseif Obj.getName() == "Death Trooper" then
						DTHT = DTHT + 1
                        if DTHT > #Spots.Combat.DTHT then DTHT = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.DTHT[DTHT],false,false)
					elseif Obj.getName() == "Darktrooper" then
						DRKT = DRKT + 1
                        if DRKT > #Spots.Combat.DRKT then DRKT = 1 end--if
						Obj.setPositionSmooth(Spots.Combat.DRKT[DRKT],false,false)
					end--if
				end--if
			end--if
		end--for
	else
		printToAll("Resolve current Combat before starting another.")
	end--if
end--function

function NA()
	--do nothing
end--function

function ExitCombat(PanelObj)
    if CombatLocation == nil then
        printToAll("I don't know which System to return Combat Units to.")
        return false
    end--if
	local X = 0.7
	local Z = 0	
	local Y = 1	--incrementing drop height.
	--restore leader and unit positions and rotation...
	for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		--if it has the RX field, (it was in combat theater)...
		if string.find(Obj.getGMNotes(),"RX:") != nil then
			--read description to get return info...
			Obj.setPositionSmooth({ReadTag({Text=Obj.getGMNotes(),Tag="X",Default="0"})-25,ReadTag({Text=Obj.getGMNotes(),Tag="Y",Default="0"})+0,ReadTag({Text=Obj.getGMNotes(),Tag="Z",Default="0"})-25},false,false)
			Obj.setRotationSmooth({ReadTag({Text=Obj.getGMNotes(),Tag="RX",Default="0"})+0,ReadTag({Text=Obj.getGMNotes(),Tag="RY",Default="0"})+0,ReadTag({Text=Obj.getGMNotes(),Tag="RZ",Default="0"})+0},false,false)
			--remove return tags...
			Obj.setGMNotes(RemoveTag({Text=Obj.getGMNotes(),Tag="X"}))
			Obj.setGMNotes(RemoveTag({Text=Obj.getGMNotes(),Tag="Y"}))
			Obj.setGMNotes(RemoveTag({Text=Obj.getGMNotes(),Tag="Z"}))
			Obj.setGMNotes(RemoveTag({Text=Obj.getGMNotes(),Tag="RX"}))
			Obj.setGMNotes(RemoveTag({Text=Obj.getGMNotes(),Tag="RY"}))
			Obj.setGMNotes(RemoveTag({Text=Obj.getGMNotes(),Tag="RZ"}))
			Obj.setGMNotes(RemoveTag({Text=Obj.getGMNotes(),Tag="Damage"}))
		elseif Obj.getVar("Component") == "Unit" or Obj.getVar("Component") == "Leader" then  --Unit or Leader?(we know it is in the combat zone)... 
			--blind return to the board and drop in the center of the location from incrementing height...
            Obj.setGMNotes("Location:"..CombatLocation..";")
			--drop around the system default location...
			Obj.setPositionSmooth({Locations[CombatLocation].MarkerSpot[1]+X,Y,Locations[CombatLocation].MarkerSpot[3]+Z},false,false)
			Y = Y + 1
			X = X - 0.7  
			if X < -2.1 then
				X = 0.7
				Z = Z + 0.8 
				if Z > 0.8 then
					Z = 0
				end--if 
			end--if
		end--if
        --clear buttons on units only (leave leader buttons alone)...
        if Obj.getVar("Component") == "Unit" then
            Obj.clearButtons()
			Obj.destroyAttachments()
			if not UnitHighlights then Obj.highlightOff() end--if leave highlights on?
        end--if
	end--for
	--reset prevented damage...
	Blocked.Imperial.Black = 0
	Blocked.Imperial.Red = 0
	Blocked.Imperial.Direct = 0
	Blocked.Imperial.IonBlast = 0
	Blocked.Imperial.SpaceDamage = 0
	Blocked.Imperial.GroundDamage = 0
	Blocked.Rebel.Black = 0
	Blocked.Rebel.Red = 0
	Blocked.Rebel.Direct = 0
	Blocked.Rebel.SpaceDamage = 0
	Blocked.Rebel.GroundDamage = 0
	--reset tactic decks if they exist... 
	ResetSpaceTacticsDeck()
	ResetGroundTacticsDeck()
	--remove the combat location name...
	CombatLocation = nil
	CombatBoard.clearButtons()--remove system name from combat board if any.
	Wait.frames(function() CombatCheckAllSystems() end,5)
	ImperialDicePanel.call("DefaultMenu")
	RebelDicePanel.call("DefaultMenu")
	--silently recalc the board after 2 seconds... 
	Wait.time(function() UpdateBoard(false) end,2)
	Game.Flags.ExitingCombat = false
end--function

function ClearCasualties(PanelObj)
	local DamageCount = 0
	local UnitCount = 0
	local Faction = ""
	local Z = 0
	if string.find(PanelObj.getDescription(),"Imperial") != nil then
		Faction = "Imperial"
		Z = -9.5
	else
		Faction = "Rebel"
		Z = 9.5
	end--if
	printToAll("--------------------------------------\nDestroying Units in the "..Faction.." Casualty Zone...")
	for O,Obj in pairs(Physics.cast({origin={33.5,3.2,Z},orientation={0,0,0},direction={0,1,0},type=3,size={16.5,5,1.7},max_distance=0,debug=false})) do
		--if object is a unit or damage marker...
		if Obj.hit_object.getVar("Component") == "Unit" then
			printToAll("  "..Obj.hit_object.getName().." destroyed.")
			UnitCount = UnitCount + 1
			Obj.hit_object.destruct()
		elseif string.find(Obj.hit_object.getDescription(),"DamageMarker;") != nil then
			if Obj.hit_object.getQuantity() > 1 then
				DamageCount = DamageCount + Obj.hit_object.getQuantity()
			else
				DamageCount = DamageCount + 1
			end--if
			Obj.hit_object.destruct()
		end--if
	end--for
	if UnitCount + DamageCount == 0 then
		printToAll("(Nothing was found in the "..Faction.." Casualty Zone).\n")
	elseif UnitCount == 0 then
		printToAll(DamageCount.." Damage Tokens were Removed.\n")
	elseif DamageCount == 0 then
		printToAll(UnitCount.." Units were Destroyed.\n")
	else
		printToAll(UnitCount.." Units were Destroyed.\n"..DamageCount.." Damage Tokens were Removed.\n")
	end
end--function

function ClearDamageTokens(PanelObj)
	--imperial or rebel?
	local Faction = ""
	if string.find(PanelObj.getDescription(),"Imperial;") != nil then
		Faction = "Imperial"
	elseif string.find(PanelObj.getDescription(),"Rebel;") != nil then
		Faction = "Rebel"
	end--if
	--remove unused damage markers on the faction's side of the board...
	for O,Obj in pairs(getAllObjects()) do
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		if string.find(Obj.getDescription(),"DamageMarker;") != nil then
			if Obj.getPosition().z > 0 and Faction == "Rebel" or Obj.getPosition().z < 0 and Faction == "Imperial" then
				Obj.destruct()
			end--if
		end--if
	end--for
end--function

function DiscardTactics(PanelObj)
	function DiscardTacticsCoroutine()
		local H = 0	--incrementing height to keep cards seperated while moving.
		--imperial or rebel?
		local Faction = ""
		if string.find(PanelObj.getDescription(),"Imperial;") != nil then
			Faction = "Imperial"
		elseif string.find(PanelObj.getDescription(),"Rebel;") != nil then
			Faction = "Rebel"
		end--if
		--loop through decks in combat area...
		for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do
			--is it a deck?
			if Obj.tag == "Deck" then
				--loop through deck content...
				for I,Item in pairs(Obj.getObjects()) do
					if string.find(Item.description,"TacticCard;") != nil and Obj != nil then
						--advanced?
						local Advanced = false
				    	if string.find(Item.description,"AdvancedTacticCard;") != nil then
							Advanced = true
						end--if
						local CardFaction = ""
						if string.find(Item.description,"Imperial;") != nil then
							CardFaction = "Imperial"
						elseif string.find(Item.description,"Rebel;") != nil then
							CardFaction = "Rebel"
						end--if
						--space or ground?
						local Theater = ""
						if string.find(Item.description,"Space;") != nil then
							Theater = "Space"
						else--must be ground...
							Theater = "Ground"
						end--if
						--does the card match this faction or not have one?
						if CardFaction == Faction or CardFaction == "" then
							--get deck info for discarding...
							local DeckInfo = nil
							if Advanced then
								DeckInfo = Decks[Faction.."Advanced"..Theater.."TacticDiscard"]
							else
								DeckInfo = Decks[Theater.."TacticDiscard"]
							end--if
							H = H + 0.1
							Obj.takeObject({guid=Item.guid,smooth=true,position={DeckInfo.DropSpot[1],DeckInfo.DropSpot[2]+H,DeckInfo.DropSpot[3]},rotation=DeckInfo.Rotation})
							coroutine.yield(0)
							if Obj.remainder != nil then break end--if--break from this deck if theres no more deck left...
						end--if
					end--if
				end--for
			end--if
		end--for
		H = 0	--reset H for card search.
		--loop through cards in combat area...
		for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if string.find(Obj.getDescription(),"TacticCard;") != nil then
				--advanced?
				local Advanced = false
		    	if string.find(Obj.getDescription(),"AdvancedTacticCard;") != nil then
					Advanced = true
				end--if
				local CardFaction = ""
				if string.find(Obj.getDescription(),"Imperial;") != nil then
					CardFaction = "Imperial"
				elseif string.find(Obj.getDescription(),"Rebel;") != nil then
					CardFaction = "Rebel"
				end--if
				--space or ground?
				local Theater = ""
				if string.find(Obj.getDescription(),"Space;") != nil then
						Theater = "Space"
				else--must be rebel...
					Theater = "Ground"
				end--if
				--does the card match this faction or not have one?
				if CardFaction == Faction or CardFaction == "" then
					--get deck info for discarding...
					local DeckInfo = nil
					if Advanced then
						DeckInfo = Decks[Faction.."Advanced"..Theater.."TacticDiscard"]
					else
						DeckInfo = Decks[Theater.."TacticDiscard"]
					end--if
					H = H + 0.1
					Obj.setRotationSmooth(DeckInfo.Rotation,false,true)
					Obj.setPositionSmooth({DeckInfo.DropSpot[1],DeckInfo.DropSpot[2]+H,DeckInfo.DropSpot[3]},false,true)
					coroutine.yield(0)
				end--if
			end--if
	  	end--for
		--reset?
		ImperialDicePanel.call("DefaultMenu")
		RebelDicePanel.call("DefaultMenu")
		return 1
	end--function
	startLuaCoroutine(Global,"DiscardTacticsCoroutine")
end--function

function DrawSpaceTactic(PanelObj)
	local Faction = ""
	local Color = ""
	local DeckTitle = ""
	if string.find(PanelObj.getDescription(),"Imperial") != nil then
		Faction = "Imperial"
		Color = "Blue"
	else
		Faction = "Rebel"
		Color = "White"
	end--if
	--check deck (Try Base Tactics, then Base Tactics Discard, then Advanced Tactics Discard)... 
	DeckTitle = "SpaceTactic"
	local Deck = getObjectFromGUID(Decks[DeckTitle].ID) 
	--if current space tactic deck was not found... 
	if Deck == nil then
		--scan for a deck at the base tactic deck's location...
		Deck = ScanForObject({Tag="Deck",Origin=Decks[DeckTitle].Spot})
		if Deck != nil then
			Deck.setName(Decks[DeckTitle].DeckName)
			Deck.setDescription(Decks[DeckTitle].DeckTag)
			Decks[DeckTitle].ID = Deck.getGUID()	--update deck guid.
		else--look for card there... 
			Deck = ScanForObject({Tag="Card",Origin=Decks[DeckTitle].Spot})
		end--if
		--if still no base tactic deck, check the discard location... 
		if Deck == nil then
			Deck = ScanForObject({Tag="Deck",Origin=Decks["SpaceTacticDiscard"].Spot})
			if Deck != nil then
				--rebuild the deck and shuffle it before drawing... 
				Deck.shuffle()
				Deck.setPosition(Decks[DeckTitle].Spot)
				Deck.setRotation(Decks[DeckTitle].Rotation)
				Deck.setName(Decks[DeckTitle].DeckName)
				Deck.setDescription(Decks[DeckTitle].DeckTag)
				Decks[DeckTitle].ID = Deck.getGUID()	--update deck guid.
			else--look for card there... 
				Deck = ScanForObject({Tag="Card",Origin=Decks["SpaceTacticDiscard"].Spot})
				--if single card left in discard pile...
				if Deck != nil then
					--restore single card to the deck location and flip face down...
					Deck.setPosition(Decks[DeckTitle].Spot)
					Deck.setRotation(Decks[DeckTitle].Rotation)
				end--if
			end--if
			--if base tactic deck discard could not be found, assume we want to draw from the advanced tactic discard... 
			if Deck == nil then
				DeckTitle = Faction.."AdvancedSpaceTacticDiscard"
				Deck = ScanForObject({Tag="Deck",Origin=Decks[DeckTitle].Spot})
				if Deck != nil then
					Deck.setName(Decks[DeckTitle].DeckName)
					Deck.setDescription(Decks[DeckTitle].DeckTag)
					Decks[DeckTitle].ID = Deck.getGUID()	--update advanced discard deck guid.
					Decks["SpaceTactic"].ID = Deck.getGUID()	--we can re-use base tactic deck guid.
				else--look for card there... 
					Deck = ScanForObject({Tag="Card",Origin=Decks[DeckTitle].Spot})
				end--if
			end--if
		end--if
	end--if
	DealToHand({Deck=DeckTitle,Player=Color,Index=Hands[Faction.."SpaceTactic"].Index,Qty=1,Flip=true})
end--function

function DrawGroundTactic(PanelObj)
	local Faction = ""
	local Color = ""
	local DeckTitle = ""
	if string.find(PanelObj.getDescription(),"Imperial") != nil then
		Faction = "Imperial"
		Color = "Blue"
	else
		Faction = "Rebel"
		Color = "White"
	end--if
	--check deck (Try Base Tactics, then Base Tactics Discard, then Advanced Tactics Discard)... 
	DeckTitle = "GroundTactic"
	local Deck = getObjectFromGUID(Decks[DeckTitle].ID) 
	--if current Ground tactic deck was not found... 
	if Deck == nil then
		--scan for a deck at the base tactic deck's location...
		Deck = ScanForObject({Tag="Deck",Origin=Decks[DeckTitle].Spot})
		if Deck != nil then
			Deck.setName(Decks[DeckTitle].DeckName)
			Deck.setDescription(Decks[DeckTitle].DeckTag)
			Decks[DeckTitle].ID = Deck.getGUID()	--update deck guid.
		else--look for card there... 
			Deck = ScanForObject({Tag="Card",Origin=Decks[DeckTitle].Spot})
		end--if
		--if still no base tactic deck, check the discard location... 
		if Deck == nil then
			Deck = ScanForObject({Tag="Deck",Origin=Decks["GroundTacticDiscard"].Spot})
			if Deck != nil then
				--rebuild the deck and shuffle it before drawing... 
				Deck.shuffle()
				Deck.setPosition(Decks[DeckTitle].Spot)
				Deck.setRotation(Decks[DeckTitle].Rotation)
				Deck.setName(Decks[DeckTitle].DeckName)
				Deck.setDescription(Decks[DeckTitle].DeckTag)
				Decks[DeckTitle].ID = Deck.getGUID()	--update deck guid.
			else--look for card there... 
				Deck = ScanForObject({Tag="Card",Origin=Decks["GroundTacticDiscard"].Spot})
				--if single card left in discard pile...
				if Deck != nil then
					--restore single card to the deck location and flip face down...
					Deck.setPosition(Decks[DeckTitle].Spot)
					Deck.setRotation(Decks[DeckTitle].Rotation)
				end--if
			end--if
			--if base tactic deck discard could not be found, assume we want to draw from the advanced tactic discard... 
			if Deck == nil then
				DeckTitle = Faction.."AdvancedGroundTacticDiscard"
				Deck = ScanForObject({Tag="Deck",Origin=Decks[DeckTitle].Spot})
				if Deck != nil then
					Deck.setName(Decks[DeckTitle].DeckName)
					Deck.setDescription(Decks[DeckTitle].DeckTag)
					Decks[DeckTitle].ID = Deck.getGUID()	--update advanced discard deck guid.
					Decks["GroundTactic"].ID = Deck.getGUID()	--we can re-use base tactic deck guid.
				else--look for card there... 
					Deck = ScanForObject({Tag="Card",Origin=Decks[DeckTitle].Spot})
				end--if
			end--if
		end--if
	end--if
	DealToHand({Deck=DeckTitle,Player=Color,Index=Hands[Faction.."GroundTactic"].Index,Qty=1,Flip=true})
end--function

function ResetSpaceTacticsDeck()
	function ResetSpaceTacticsDeckCoroutine()
		if ResettingTactics then
			local LoopCount = 0
			RepCount = RepCount + 1
			repeat 
				coroutine.yield(0)
				LoopCount = LoopCount + 1
			until not ResettingTactics or LoopCount > 500
			RepCount = RepCount - 1
		end--if
		ResettingTactics = true
		local DeckInfo = Decks["SpaceTactic"]
		local H = 0	--incrementing height to keep cards seperated while moving.
		--loop through everything...
		for O,Obj in pairs(getAllObjects()) do
			--is it a deck?
			if Obj.tag == "Deck" then
				--is it outside the deck's area?
				if (Obj.getPosition().x > DeckInfo.Spot[1]+0.25 or Obj.getPosition().x < DeckInfo.Spot[1]-0.25) or (Obj.getPosition().z > DeckInfo.Spot[3]+0.25 or Obj.getPosition().z < DeckInfo.Spot[3]-0.25) then
					--loop through deck content...
					for I,Item in pairs(Obj.getObjects()) do
						if Item.description == "TacticCard;Space;" and Obj != nil then
							H = H + 0.05
							local CardObj = Obj.takeObject({guid=Item.guid,smooth=false,position={DeckInfo.Spot[1],DeckInfo.Spot[2],DeckInfo.Spot[3]},rotation=DeckInfo.Rotation})
							CardObj.setPositionSmooth(DeckInfo.Spot,false,false)
							CardObj.setRotationSmooth(DeckInfo.Rotation,false,false)
							coroutine.yield(0)
							if Obj == nil then
								break 
							elseif Obj.getQuantity() < 1 then
								break
							end--if
						end--if
					end--for
				end--if
			end--if
		end--for
		--loop through cards in combat area...
		for O,Obj in pairs(getAllObjects()) do
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if Obj.getDescription() == "TacticCard;Space;" then
				--is it outside the deck's area?
				if (Obj.getPosition().x > DeckInfo.Spot[1]+0.25 or Obj.getPosition().x < DeckInfo.Spot[1]-0.25) or (Obj.getPosition().z > DeckInfo.Spot[3]+0.25 or Obj.getPosition().z < DeckInfo.Spot[3]-0.25) then
					H = H + 0.05
					Obj.setRotation(DeckInfo.Rotation)
					Obj.setPosition({DeckInfo.Spot[1],DeckInfo.Spot[2],DeckInfo.Spot[3]})
					Obj.setPositionSmooth({DeckInfo.Spot[1],DeckInfo.Spot[2],DeckInfo.Spot[3]},false,true)
				end--if
				--coroutine.yield(0)
			end--if
	  	end--for
		--wait for a bit, then shuffle... 
		for D=1,20 do coroutine.yield(0) end--for D
		local Deck = GetDeck("SpaceTactic")
		if Deck != nil then
			Deck.shuffle()
		end--if
		ResettingTactics = false
		return 1
	end--function
	startLuaCoroutine(Global,"ResetSpaceTacticsDeckCoroutine")
end--function 

function ResetGroundTacticsDeck()
	function ResetGroundTacticsDeckCoroutine()
		if ResettingTactics then
			local LoopCount = 0
			RepCount = RepCount + 1
			repeat 
				coroutine.yield(0)
				LoopCount = LoopCount + 1
			until not ResettingTactics or LoopCount > 500
			RepCount = RepCount - 1
		end--if
		ResettingTactics = true
		local DeckInfo = Decks["GroundTactic"]
		local H = 0	--incrementing height to keep cards seperated while moving.
		--loop through everything...
		for O,Obj in pairs(getAllObjects()) do
			--is it a deck?
			if Obj.tag == "Deck" then
				--is it outside the deck's area?
				if (Obj.getPosition().x > DeckInfo.Spot[1]+0.25 or Obj.getPosition().x < DeckInfo.Spot[1]-0.25) or (Obj.getPosition().z > DeckInfo.Spot[3]+0.25 or Obj.getPosition().z < DeckInfo.Spot[3]-0.25) then
					--loop through deck content...
					for I,Item in pairs(Obj.getObjects()) do
						if Item.description == "TacticCard;Ground;" and Obj != nil then
							H = H + 0.05
							local CardObj = Obj.takeObject({guid=Item.guid,smooth=false,position={DeckInfo.Spot[1],DeckInfo.Spot[2],DeckInfo.Spot[3]},rotation=DeckInfo.Rotation})
							CardObj.setPositionSmooth(DeckInfo.Spot,false,false)
							CardObj.setRotationSmooth(DeckInfo.Rotation,false,false)
							coroutine.yield(0)
							if Obj == nil then
								break 
							elseif Obj.getQuantity() < 1 then
								break
							end--if
						end--if
					end--for
				end--if
			end--if
		end--for
		--loop through cards in combat area...
		for O,Obj in pairs(getAllObjects()) do
			if Obj.getDescription() == "TacticCard;Ground;" then
				--is it outside the deck's area?
				if (Obj.getPosition().x > DeckInfo.Spot[1]+0.25 or Obj.getPosition().x < DeckInfo.Spot[1]-0.25) or (Obj.getPosition().z > DeckInfo.Spot[3]+0.25 or Obj.getPosition().z < DeckInfo.Spot[3]-0.25) then
					H = H + 0.05
					Obj.setRotation(DeckInfo.Rotation)
					Obj.setPosition({DeckInfo.Spot[1],DeckInfo.Spot[2],DeckInfo.Spot[3]})
					Obj.setPositionSmooth({DeckInfo.Spot[1],DeckInfo.Spot[2],DeckInfo.Spot[3]},false,true)
				end--if
				--coroutine.yield(0)
			end--if
	  	end--for
		--wait for a bit, then shuffle... 
		for D=1,20 do coroutine.yield(0) end--for D
		local Deck = GetDeck("GroundTactic")
		if Deck != nil then
			Deck.shuffle()
		end--if
		ResettingTactics = false
		return 1
	end--function
	startLuaCoroutine(Global,"ResetGroundTacticsDeckCoroutine")
end--function 
		
function GetDamage(PanelObj)
	function GetDamageCoroutine()
		--scan for dice in Rolls and Re-Rolls area, and change into matching damage tokens in the spent area.
		local DamageCount = 0
		local Faction = ""
		local F = 1	--default direction.
		local PanelOffsets = PanelObj.getTable("Offsets")
		local PanelAreas = PanelObj.getTable("Areas")
		local UsedSpot = PanelOffsets.Used.Dice
		local DiceList = {}	--list of dice objects.
		local PreventBlack = 0
		local PreventRed = 0
		local PreventDirect = 0
		local FirstNew = 0	--index noting which dice in DiceList is the first new dice (new receive damage tokens, old/existing do not).
		local Col = 0
		local Row = 0
		local BlockRow = 0
		local BlockCol = 0
		local DiceMarginWide = PanelObj.getVar("DiceMarginWide")
		local DiceMarginHigh = PanelObj.getVar("DiceMarginHigh")
		--imperial or rebel?
		if string.find(PanelObj.getDescription(),"Imperial;") != nil then
			Faction = "Imperial"
			F = -1
			PreventBlack = Blocked.Rebel.Black
			PreventRed = Blocked.Rebel.Red
			PreventDirect = Blocked.Rebel.Direct
		elseif string.find(PanelObj.getDescription(),"Rebel;") != nil then
			Faction = "Rebel"
			F = 1
			PreventBlack = Blocked.Imperial.Black
			PreventRed = Blocked.Imperial.Red
			PreventDirect = Blocked.Imperial.Direct
		end--if
		--get list of, and organize existing dice in blocked box... 
		for O,Obj in pairs(Physics.cast({origin={PanelObj.getPosition().x+PanelOffsets.Blocked.Box[1],PanelObj.getPosition().y+PanelOffsets.Blocked.Box[2],PanelObj.getPosition().z+PanelOffsets.Blocked.Box[3]},orientation={0,0,0},direction={0,1,0},type=3,size=PanelAreas.Blocked,max_distance=0,debug=false})) do
			if string.find(Obj.hit_object.getDescription(),"Dice;") != nil then
				--count the blocked damage... 
				if Obj.hit_object.getRotationValue() == "Direct Hit" then
					PreventDirect = PreventDirect - 1
				elseif Obj.hit_object.getName() == "(Red Dice)" and Obj.hit_object.getRotationValue() == "Hit" then
					PreventRed = PreventRed - 1
				elseif Obj.hit_object.getName() == "(Black Dice)" and Obj.hit_object.getRotationValue() == "Hit" then
					PreventBlack= PreventBlack - 1
				end--if
				--organize the existing die into the spent box...
				Obj.hit_object.setPositionSmooth({PanelObj.getPosition().x+PanelOffsets.Blocked.Dice[1]-F*BlockCol*DiceMarginWide,PanelObj.getPosition().y+PanelOffsets.Blocked.Dice[2],PanelObj.getPosition().z+PanelOffsets.Blocked.Dice[3]-F*BlockRow*DiceMarginHigh},false,false)
				--increment spot... 
				BlockCol = BlockCol + 1
				if BlockCol >= 4 then
					BlockCol = 0
					BlockRow = BlockRow + F
				end--if
			end--if
		end--for O,Obj
		--get list of existing dice in Spent box... 
		for O,Obj in pairs(Physics.cast({origin={PanelObj.getPosition().x+PanelOffsets.Used.Box[1],PanelObj.getPosition().y+PanelOffsets.Used.Box[2],PanelObj.getPosition().z+PanelOffsets.Used.Box[3]},orientation={0,0,0},direction={0,1,0},type=3,size=PanelAreas.Used,max_distance=0,debug=false})) do
			if Obj.hit_object.getVar("Component") == "Dice" then
				table.insert(DiceList,Obj.hit_object)
			end--if
		end--for O,Obj
		FirstNew = #DiceList + 1	--first new dice is after existing ones are counted.
		--get list of dice in rolled box... 
		for O,Obj in pairs(Physics.cast({origin={PanelObj.getPosition().x+PanelOffsets.Rolls.Box[1],PanelObj.getPosition().y+PanelOffsets.Rolls.Box[2],PanelObj.getPosition().z+PanelOffsets.Rolls.Box[3]},orientation={0,0,0},direction={0,1,0},type=3,size=PanelAreas.Rolls,max_distance=0,debug=false})) do
			if Obj.hit_object.getVar("Component") == "Dice" then
				table.insert(DiceList,Obj.hit_object)
			end--if
		end--for O,Obj
		--append list of dice in re-rolled box... 
		for O,Obj in pairs(Physics.cast({origin={PanelObj.getPosition().x+PanelOffsets.ReRolls.Box[1],PanelObj.getPosition().y+PanelOffsets.ReRolls.Box[2],PanelObj.getPosition().z+PanelOffsets.ReRolls.Box[3]},orientation={0,0,0},direction={0,1,0},type=3,size=PanelAreas.ReRolls,max_distance=0,debug=false})) do
			if Obj.hit_object.getVar("Component") == "Dice" then
				table.insert(DiceList,Obj.hit_object)
			end--if
		end--for O,Obj
		--go through dice list...
		for O,Obj in pairs(DiceList) do
			--only assign damage tokens to new dice.. 
			if O < FirstNew then
				--organize the existing die into the spent box...(FixZ)
				Obj.setPositionSmooth({PanelObj.getPosition().x+PanelOffsets.Used.Dice[1]-F*Col*DiceMarginWide,PanelObj.getPosition().y+PanelOffsets.Used.Dice[2],PanelObj.getPosition().z+PanelOffsets.Used.Dice[3]+Row*DiceMarginHigh},false,false)
				--increment spot... 
				Col = Col + 1
				if Col >= 5 then
					Col = 0
					Row = Row + F
				end--if
			else
				local Prevented = false	--flag if specific dice is prevented.
				local DamageState = 0	--1=Any; 2=Red Direct Hit; 3=Red Hit; 4=Black Direct Hit; 5=Black Hit; 6=Green Direct Hit;
				--what type of hit?
				if Obj.getName() == "(Red Dice)" and Obj.getRotationValue() == "Direct Hit" then
					DamageState = 2
					if PreventDirect > 0 then
						PreventDirect = PreventDirect - 1
						Prevented = true
					end--if
				elseif Obj.getName() == "(Red Dice)" and Obj.getRotationValue() == "Hit" then
					DamageState = 3
					if PreventRed > 0 then
						PreventRed = PreventRed - 1
						Prevented = true
					end--if
				elseif Obj.getName() == "(Black Dice)" and Obj.getRotationValue() == "Direct Hit" then
					DamageState = 4
					if PreventDirect > 0 then
						PreventDirect = PreventDirect - 1
						Prevented = true
					end--if
				elseif Obj.getName() == "(Black Dice)" and Obj.getRotationValue() == "Hit" then
					DamageState = 5
					if PreventBlack > 0 then
						PreventBlack = PreventBlack - 1
						Prevented = true
					end--if
				elseif Obj.getName() == "(Green Dice)" and Obj.getRotationValue() == "Direct Hit" then
					DamageState = 6
					if PreventDirect > 0 then
						PreventDirect = PreventDirect - 1
						Prevented = true
					end--if
				end--if
				--if dice was spent/damage marker was produced...
				if Prevented then
					--organize the prevented die into the blocked box...
					Obj.setPositionSmooth({PanelObj.getPosition().x+PanelOffsets.Blocked.Dice[1]-F*BlockCol*DiceMarginWide,PanelObj.getPosition().y+PanelOffsets.Blocked.Dice[2],PanelObj.getPosition().z+PanelOffsets.Blocked.Dice[3]+BlockRow*DiceMarginHigh},false,false)
					--increment spot... 
					BlockCol = BlockCol + 1
					if BlockCol >= 4 then
						BlockCol = 0
						BlockRow = BlockRow + F
					end--if
				elseif DamageState > 0 then
					--move the new die into the spent box...
					Obj.setPositionSmooth({PanelObj.getPosition().x+PanelOffsets.Used.Dice[1]-F*Col*DiceMarginWide,PanelObj.getPosition().y+PanelOffsets.Used.Dice[2],PanelObj.getPosition().z+PanelOffsets.Used.Dice[3]+Row*DiceMarginHigh},false,false)
					--spend the die and spawn damage marker matching the dice...
					DamageCount = DamageCount + 1
					local DamageToken = getObjectFromGUID(IDs[Faction].DamageBag).takeObject({smooth=false,position=Obj.getPosition(),rotation=PanelObj.getRotation()})
					DamageToken = DamageToken.setState(DamageState)
					DamageToken.setRotationSmooth(PanelObj.getRotation())
					DamageToken.setPositionSmooth({PanelObj.getPosition().x+PanelOffsets.Used.Dice[1]-F*Col*DiceMarginWide,PanelObj.getPosition().y+PanelOffsets.Used.Dice[2]+0.5,PanelObj.getPosition().z+PanelOffsets.Used.Dice[3]+Row*DiceMarginHigh},false,false)
					--increment spot... 
					Col = Col + 1
					if Col >= 5 then
						Col = 0
						Row = Row + F
					end--if
				end--if
			end--if
			coroutine.yield(0)
		end--for
		return 1
	end--function
	startLuaCoroutine(Global,"GetDamageCoroutine")
end--function

function ResolveDamage(PanelObj)
	--destroy units with damage >= their defense; delete unused damage markers on this player's side of the board...
	local DamageCount = 0
	local UnitCount = 0
	local Faction = ""
	--get faction... 
	if string.find(PanelObj.getDescription(),"Imperial") != nil then
		Faction = "Imperial"
	else
		Faction = "Rebel"
	end--if
	printToAll("--------------------------------------\nDestroying "..Faction.." Units with full damage...\nRemoving unused Damage Markers...")
	for O,Obj in pairs(getObjectFromGUID(IDs.CombatZone).getObjects()) do
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		--if object is a unit or damage marker...
		if Obj.getVar("Component") == "Unit" and string.find(Obj.getDescription(),Faction..";") != nil then
			local Damage = ReadTag({Text=Obj.getGMNotes(),Tag="Damage",Default="0"})+0
			--enough damage?
			if Damage >= Units[Obj.getName()].Health then
				printToAll("  "..Obj.getName().." destroyed by "..Damage.." damage.")
				UnitCount = UnitCount + 1
				Obj.destruct()
			end--if
		end--if
	end--for
	if UnitCount == 0 then
		printToAll("(No "..Faction.." were Destroyed).\n")
	else
		printToAll(UnitCount.." "..Faction.." Units were Destroyed.\n")
	end
	--reset prevented damage if any... 
	if Faction != "" then
		--reset prevented damage...
		if Faction == "Rebel" then
			if Blocked.Imperial.Black + Blocked.Imperial.Red + Blocked.Imperial.Direct > 0 then
				printToAll("Rebel damage prevention reset.",{1,1,0})
			end--if
 			Blocked.Imperial.Black = 0
			Blocked.Imperial.Red = 0
			Blocked.Imperial.Direct = 0
			Blocked.Imperial.IonBlast = 0
			Blocked.Imperial.SpaceDamage = 0
			Blocked.Imperial.GroundDamage = 0
		elseif Faction == "Imperial" then
			if Blocked.Rebel.Black + Blocked.Rebel.Red + Blocked.Rebel.Direct > 0 then
				printToAll("Imperial damage prevention reset.",{1,1,0})
			end--if
			Blocked.Rebel.Black = 0
			Blocked.Rebel.Red = 0
			Blocked.Rebel.Direct = 0
			Blocked.Rebel.SpaceDamage = 0
			Blocked.Rebel.GroundDamage = 0
		end--if
	end--if
	ImperialDicePanel.call("DefaultMenu")
	RebelDicePanel.call("DefaultMenu")
end--function

function DamageTokenOnLoad(Params)	--{Token=Obj}
	--if string.find(Params.Token.getDescription(),"BlackHit;") != nil then
		--Params.Token.setVar("DamageColor","Black")
	--elseif string.find(Params.Token.getDescription(),"RedHit;") != nil then
		--Params.Token.setVar("DamageColor","Red")
	--else
		--Params.Token.setVar("DamageColor","")
	--end--if
end--function

function DamageTokenOnPickUp(Params)	--{Token=Obj,PlayerColor=""}
	Params.Token.setVar("Colliding",false)
end--function

function DamageTokenOnCollision(Params)	--{Token=Obj,Info=collision_info}
	--already colliding?
	if not Params.Token.getVar("Colliding") then
		Params.Token.setVar("Colliding",true)
		--hit a unit?
		if Params.Info.collision_object.getVar("Component") == "Unit" then
			--attach damage token...
			local DamageOK = true
			local DamageColor = Params.Token.getVar("DamageColor")
			if Params.Info.collision_object.getName() == "Death Star" then
				DamageOK = false  --never damage a death star.
			elseif DamageColor == "Black" and Units[Params.Info.collision_object.getName()].HealthColor != "Black" then
				DamageOK = false  --damage color is not compatible.
			elseif DamageColor == "Red" and Units[Params.Info.collision_object.getName()].HealthColor != "Red" then
				DamageOK = false  --damage color is not compatible.
			end--if
			--damage legal?
			if DamageOK then
				--add damage to unit...
				local Qty = Params.Token.getQuantity()
				if Qty < 1 then Qty = 1 end--if
				for Q = 1,Qty do
					UnitAddDamage(Params.Info.collision_object)
				end--for Q
				Params.Token.destruct()
			else
				broadcastToAll(DamageColor.." is not valid for Target Unit: "..Params.Info.collision_object.getName())
				Wait.time(function() Params.Token.setVar("Colliding",false) end,1)
			end--if
		elseif Params.Info.collision_object.getVar("Component") == "Leader" then
			--imperial leader?
			if Params.Info.collision_object.getVar("Faction") == "Imperial" then
				Params.Token.destruct()
				ConfrontationPrompt(Params.Info.collision_object)
			end--if
		else
			Wait.time(function() Params.Token.setVar("Colliding",false) end,1)
		end--if
	end--if
end--function

function DiceOnLoad(Params)	--{Die=Obj}
	Params.Die.setTable("LastSpot",Params.Die.getPosition())
end--function 
	
function DiceOnPickUp(Params)	--{Die=Obj,PlayerColor=""}
	Params.Die.setTable("LastSpot",Params.Die.getPosition())
end--function 

function DiceOnDrop(Params)	--{Die=Obj,PlayerColor=""}
	Params.Die.setVar("Colliding",false)
end--function 
	
function DiceOnCollision(Params)	--{Die=Obj,Info=collision_info}
	--already colliding?
	if not Params.Die.getVar("Colliding") then
		Params.Die.setVar("Colliding",true)
		--hit a unit?
		if Params.Info.collision_object.getVar("Component") == "Unit" then
			local Damage = 0
			local DiceColor = Params.Die.getVar("DiceColor")
			local Faction = Params.Info.collision_object.getVar("Faction")
			--depending upon dice result... 
			if Params.Info.collision_object.getName() == "Death Star" then
				broadcastToAll("A Death Star cannot be damaged nor healed.")
			elseif Params.Die.getRotationValue() == "Hit" then
				Damage = 1 --assume hit until disproven.
				if DiceColor == "Black" and Units[Params.Info.collision_object.getName()].HealthColor != "Black" then
					Damage = 0
				elseif DiceColor == "Red" and Units[Params.Info.collision_object.getName()].HealthColor != "Red" then
					Damage = 0
				end--if
			elseif  Params.Die.getRotationValue() == "Direct Hit" then
				--direct hit always damages a non-death star unit.
				Damage = 1
			elseif  Params.Die.getRotationValue() == "Special" then
				if DiceColor == "Black" and Units[Params.Info.collision_object.getName()].HealthColor == "Black" then
					Damage = -1
				elseif DiceColor == "Red" and Units[Params.Info.collision_object.getName()].HealthColor == "Red" then
					Damage = -1
				end--if
			else--assume blank... 
				Damage = 0
			end--if
			--damage effect?
			if Damage > 0 then
				UnitAddDamage(Params.Info.collision_object)
			elseif Damage < 0 then
				if Params.Info.collision_object.getVar("Damage") == nil then Params.Info.collision_object.setVar("Damage",0) end--if
				if Params.Info.collision_object.getVar("Damage") == 0 then
					printToAll(Params.Info.collision_object.getName().." has no damage.")
					Damage = 0
				else
					UnitRemoveDamage(Params.Info.collision_object)
				end--if
			else--no effect
				printToAll(Params.Die.getName().." has no effect on "..Params.Info.collision_object.getName()..".")
			end--if
			--dice disposition... 
			if Damage == 0 then
				--return dice to previous spot... 
				Params.Die.setPositionSmooth(Params.Die.getTable("LastSpot"),false,false)
			else--send to used box... 
				local PanelObj = nil
				local F = 1
				local Col = 0
				local Row = 0
				local DiceMarginWide = 1
				local DiceMarginHigh = 1.3
				local DiceList = {}
				--dice that damage go to opposing faction spent box.
				if Damage > 0 then
					if Faction == "Imperial" then
						PanelObj = RebelDicePanel
					else
						PanelObj = ImperialDicePanel
						F = -1
					end--if
				else 
					if Faction == "Imperial" then
						PanelObj = ImperialDicePanel
						F = -1
					else
						PanelObj = RebelDicePanel
					end--if
				end--if
				--dice that heal go to that faction's spent box.
				local PanelOffsets = PanelObj.getTable("Offsets")
				local PanelAreas = PanelObj.getTable("Areas")
				--get list of existing dice in Spent box... 
				for O,Obj in pairs(Physics.cast({origin={PanelObj.getPosition().x+PanelOffsets.Used.Box[1],PanelObj.getPosition().y+PanelOffsets.Used.Box[2],PanelObj.getPosition().z+PanelOffsets.Used.Box[3]},orientation={0,0,0},direction={0,1,0},type=3,size=PanelAreas.Used,max_distance=0,debug=false})) do
					if string.find(Obj.hit_object.getDescription(),"Dice;") != nil then
						table.insert(DiceList,Obj.hit_object)
					end--if
				end--for O,Obj
				table.insert(DiceList,Params.Die)
				--go through dice list...
				for O,Obj in pairs(DiceList) do
					--organize the existing die into the spent box...
					Obj.setPositionSmooth({PanelObj.getPosition().x+PanelOffsets.Used.Dice[1]-F*Col*DiceMarginWide,PanelObj.getPosition().y+PanelOffsets.Used.Dice[2],PanelObj.getPosition().z+PanelOffsets.Used.Dice[3]+Row*DiceMarginHigh},false,false)
					--increment spot... 
					Col = Col + 1
					if Col >= 5 then
						Col = 0
						Row = Row + F
					end--if
				end--for
			end--if
		end--if
	end--if
end--function 

--Panel Shared functions------------------------------------------------------------------------------------------------------------------

function PleaseWait(Params) --{Panel=Obj,Text="",FontSize=200,FontColor={1,1,1}}
  if Params.FontSize == nil then Params.FontSize = 150 end--if
  if Params.FontColor == nil then Params.FontColor = {1,1,1} end--if
  if Params.Text != nil then
    Params.Panel.clearButtons()
    Params.Panel.createButton({click_function="PleaseWait",function_owner=Global,label=Params.Text,position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=Params.FontSize,font_color=Params.FontColor})
  end--if
end--function

function AssignMissions()
	local Panel = nil
	local Color = {1,1,1}
	Game.Turn.Role = ""
	if Game.Turn.Num == 1 then
		Game.Turn.Faction = "Rebel"
		Panel = RebelPanel
		Color = {1,1,1}
	else--imperial
		Game.Turn.Faction = "Imperial"
		Panel = ImperialPanel
		Color = {0.5,0.5,1}
	end--if
  Panel.clearButtons()
  Panel.createButton({click_function="NA",function_owner=Global,label=string.upper(Game.Turn.Faction).." ASSIGNMENTS",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  Panel.createButton({click_function="NA",function_owner=Global,label=string.upper(Game.Turn.Faction).." ASSIGNMENTS",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color=Color})
  Panel.createButton({click_function="NA",function_owner=Global,label=string.upper(Game.Turn.Faction).."S",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  Panel.createButton({click_function="NA",function_owner=Global,label="ASSIGNMENT PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  Panel.createButton({click_function="NA",function_owner=Global,label="Assign Leaders to Missions.",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  function AssignmentsComplete()
    Panel.clearButtons()
    printToAll(Game.Turn.Faction.." Assignments complete.")
		if Game.Turn.Num == 1 then
			NextStep = "AssignmentPhase.ImperialAssignments"
		else--end of assignment phase...
			NextStep = "AssignmentPhase.End"
		end--if
    Step = ""
  end--function
  if Game.Turn.Faction == "Imperial" and Game.AI.Active then
	startLuaCoroutine(Global,"AI_AssignMissionsCoroutine")
  else
	Panel.createButton({click_function="AssignmentsComplete",function_owner=Global,label=Game.Turn.Faction.." Assignments Complete",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip=Game.Turn.Faction.." Assignments are completed."})
  end--if active ai
end--function

function CommandTurnMenu()
	local Panel = nil
	local Color = {1,1,1}
	if Game.Turn.Faction == "Rebel" then
		Panel = RebelPanel
		Color = {1,1,1}
		PleaseWait({Panel=ImperialPanel,Text="Rebel "..Game.Turn.Role.." is\nperforming their turn."})
	else--imperial
		Panel = ImperialPanel
		Color = {0.5,0.5,1}
		PleaseWait({Panel=RebelPanel,Text="Imperial "..Game.Turn.Role.." is\nperforming their turn."})
	end--if
  Panel.clearButtons()
  Panel.createButton({click_function="NA",function_owner=Global,label=string.upper(Game.Turn.Faction).." TURN",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  Panel.createButton({click_function="NA",function_owner=Global,label=string.upper(Game.Turn.Faction).." TURN",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color=Color})
  Panel.createButton({click_function="NA",function_owner=Global,label="("..Game.Turn.Num..") "..string.upper(Game.Turn.Faction.." "..Game.Turn.Role),position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  Panel.createButton({click_function="NA",function_owner=Global,label="COMMAND PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  Panel.createButton({click_function="TurnComplete",function_owner=Global,label="Turn Complete",position={0,0.1,0.35},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Player's Turn is completed."})
  Panel.createButton({click_function="PassTurn",function_owner=Global,label="Pass",position={0.7,0.1,0.85},scale={0.6,0.6,0.6},width=700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Pass your turn the rest of the Command Phase."})
  --AI?
  if Game.Turn.Faction == "Imperial" and Game.AI.Active then
	startLuaCoroutine(Global,"AI_CommandCoroutine")
	Panel.createButton({click_function="NA",function_owner=Global,label="Imperial AI is thinking...",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  else--human... 
	Panel.createButton({click_function="NA",function_owner=Global,label="Reveal a Mission or Activate a System.",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
	if Game.Turn.Faction == "Rebel" and IsBaseHidden() then
	  Panel.createButton({click_function="ConfirmRevealRebelBaseMenu",function_owner=Global,label="Reveal Base",position={-0.7,0.1,0.85},scale={0.6,0.6,0.6},width=700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="At the start of your Turn, during the Command Phase, you may choose to Reveal the Rebel Base's location."})
	end--if
  end--if
  function TurnComplete()
    Panel.clearButtons()
    printToAll(Game.Turn.Faction.." "..Game.Turn.Role.." completed a Turn.")
    Step = ""
  end--function
  function PassTurn()
    Panel.clearButtons()
	Game.Flags.Passed[Game.Turn.Num] = true
    printToAll(Game.Turn.Faction.." "..Game.Turn.Role.." has Passed.")
    Step = ""
  end--function
end--function

function ConfirmRevealRebelBaseMenu()
	RebelPanel.clearButtons()
	RebelPanel.createButton({click_function="NA",function_owner=Global,label=string.upper(Game.Turn.Faction).." TURN",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label=string.upper(Game.Turn.Faction).." TURN",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="("..Game.Turn.Num..") "..string.upper(Game.Turn.Faction.." "..Game.Turn.Role),position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="COMMAND PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="You want to reveal the\nRebel Base's Location!?",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=150,font_color={1,1,1}})
	RebelPanel.createButton({click_function="YesRevealBase",function_owner=Global,label="Yes",position={-0.7,0.1,0.7},scale={0.6,0.6,0.6},width=700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="YES: I want to reveal the Rebel Base (I know what I'm doing)."})
	RebelPanel.createButton({click_function="NoRevealBase",function_owner=Global,label="No",position={0.7,0.1,0.7},scale={0.6,0.6,0.6},width=700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="NO: Keep the Rebel Base's location a secret!"})
	function YesRevealBase()
		RebelPanel.clearButtons()
		RevealRebelBase()
		--wait 1 second before going back to the panel menu so the base has time to reveal itself.
		Wait.time(function() CommandTurnMenu() end,1)
	end--function
	function NoRevealBase()
		RebelPanel.clearButtons()
		CommandTurnMenu()
	end--function 
end--function 

function IsBaseRevealed()
	--returns true if base is revealed. (base is revealed unless there is a facedown probe card signals hidden base)... 
	local Revealed = true
	for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.BaseProbeCardZone).getObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		if string.find(Obj.getDescription(),"ProbeCard;") != nil then
			if (Obj.getRotation().z > 90 and Obj.getRotation().z < 270) or Obj.getGMNotes() == "Hidden" then
				Revealed = false
			end--if
			break
		end--if
	end--for O,Obj 
	return Revealed
end--function 

function IsBaseHidden()
    --returns true if base is hidden. (base is considered hidden if there is a facedown probe card)... 
    local Hidden = false
    for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.BaseProbeCardZone).getObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
        if string.find(Obj.getDescription(),"ProbeCard;") != nil then
            --facedown or hidden gmnote?
            if (Obj.getRotation().z > 90 and Obj.getRotation().z < 270) or Obj.getGMNotes() == "Hidden" then
                Hidden = true
            end--if
            break
        end--if
    end--for O,Obj 
    return Hidden
end--function 
    
function GetRebelBaseSystem()
	--detects and returns the name of the system the rebel base is in, (if able).
	--look for a probe card in the rebel base card spot... 
	for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.BaseProbeCardZone).getObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		--is the object being evaluated a probe card?
		if string.find(Obj.getDescription(),"ProbeCard;") != nil then
			return Obj.getName()
		end--if
	end--for O,Obj 
	return ""
end--function 

function RevealRebelBase()
	--look for a probe card in the rebel base card spot... 
	for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.BaseProbeCardZone).getObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		--is the object being evaluated a probe card?
		if string.find(Obj.getDescription(),"ProbeCard;") != nil then
			--is the probe card face down or hidden?
			if (Obj.getRotation().z > 90 and Obj.getRotation().z < 270) or Obj.getGMNotes() == "Hidden" then
				--flip it, unhide it and announce the base is revealed!
				Obj.setRotationSmooth({0,270,0},false,false)
				Obj.setHiddenFrom()
				Obj.clearButtons()--removes hidden text.
				Obj.setGMNotes("")
				broadcastToAll("The Revel Base has been revealed!",{1,1,0})
				--coroutine.yield(0)
				--blind move rebel base units and leaders to system location... 
				BlindUnitDrop("REBEL BASE",Obj.getName())
			end--if
			break
		end--if
	end--for O,Obj 
end--function 

function BlindUnitDrop(FromLocation,ToLocation)
	function BlindUnitDropCoroutine()
		coroutine.yield(0)
		local X = 0.7
		local Z = 0	
		local Y = 1	--incrementing drop height.
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			--unit?
			if Obj.getVar("Component") == "Unit" or Obj.getVar("Component") == "Leader" then
				--from location?
				if string.find(Obj.getGMNotes(),"Location:"..FromLocation..";") != nil then
					Obj.clearButtons()
					Obj.setPosition({Locations[ToLocation].MarkerSpot[1]+X,Y,Locations[ToLocation].MarkerSpot[3]+Z})
					coroutine.yield(0)
					--nudge in case not full physics
					Obj.setPositionSmooth({Locations[ToLocation].MarkerSpot[1]+X,Y-0.1,Locations[ToLocation].MarkerSpot[3]+Z},true,true)
                    if Obj.getVar("Component") == "Unit" then
						--increment new location count...
						Locations[ToLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] = Locations[ToLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] + 1
						--decrement old location count... 
						if Locations[FromLocation] != nil then
							Locations[FromLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] = Locations[FromLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] - 1
						end--if from location exists 
                        UnitUpdateLocation(Obj)
                    elseif Obj.getVar("Component") == "Leader" then
                        Obj.setVar("Location",ToLocation)
                        Obj.setGMNotes("Location:"..ToLocation..";")
                    end--if
					Y = Y + 1
					X = X - 0.7
					if X < -2.1 then
						X = 0.7
						Z = Z + 0.8
						if Z > 0.8 then
							Z = 0
						end--if 
                    end--if
				end--if
			end--if
		end--O,Obj
		for D=1,10 do coroutine.yield(0) end--for D
		--if opposing units in the revealed base system...
		if CombatCheck({System=ToLocation}) then
			--automatically start (or add to) combat...
			CombatLocation = ToLocation
			ResolveCombat(getObjectFromGUID(Locations[CombatLocation].CombatMarkerID))
		end--if 
		--Wait.frames(function() CombatCheck({System=ToLocation}) end,10)
 		return 1
	end--function 
    startLuaCoroutine(Global,"BlindUnitDropCoroutine")
end--function 

function GetBaseLocation()
	local Location = ""
	for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.BaseProbeCardZone).getObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		if string.find(Obj.getDescription(),"ProbeCard;") != nil then
			Location = Obj.getName()
			break
		end--if
	end--for O,Obj 
	return Location
end--function 
		
function DiscardMissions(Params)  --{Faction="",Size=0}
  --prompt player to discard missions down to 10...
	local Panel = nil
	local Color = {1,1,1}
	if Params.Faction == "Rebel" then
		Panel = RebelPanel
		Color = {1,1,1}
	else--imperial
		Panel = ImperialPanel
		Color = {0.5,0.5,1}
	end--if
  Panel.clearButtons()
  Panel.createButton({click_function="NA",function_owner=Global,label="DISCARDING MISSIONS",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  Panel.createButton({click_function="NA",function_owner=Global,label="DISCARDING MISSIONS",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color=Color})
  Panel.createButton({click_function="NA",function_owner=Global,label=Params.Faction.." PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  Panel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  Panel.createButton({click_function="NA",function_owner=Global,label=Params.Faction.." Mission Hand Size: "..Params.Size.."\n\nDiscard down to 10.",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  Panel.createButton({click_function="IgnoreHandLimit"..Params.Faction,function_owner=Global,label="Ignore Hand Limit",position={-0.65,0.1,0.85},scale={0.6,0.6,0.6},width=900,height=200,color={1,1,0},font_size=100,font_color={0,0,0},tooltip="Continue Anyway (Ignore the Mission Hand Limit of 10)."})
  Panel.createButton({click_function="DoneDiscarding"..Params.Faction,function_owner=Global,label="Done",position={0.65,0.1,0.85},scale={0.6,0.6,0.6},width=900,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Continue: Mission Hand is discarded down to 10."})
  function DoneDiscardingRebel()
    RebelPanel.clearButtons()
    NextStep = "RefreshPhase.II.DiscardMissions"
    Step = ""
  end--function
  function DoneDiscardingImperial()
    ImperialPanel.clearButtons()
    NextStep = "RefreshPhase.II.DiscardMissions"
    Step = ""
  end--function
  function IgnoreHandLimitRebel()
    RebelPanel.clearButtons()
    printToAll("Rebels are ignoring the Mission Hand Limit.")
    Game.Flags.MissionHandOK.Rebel = true
    NextStep = "RefreshPhase.II.DiscardMissions"
    Step = ""
  end--function
	function IgnoreHandLimitImperial()
    ImperialPanel.clearButtons()
    printToAll("Imperials are ignoring the Mission Hand Limit.")
    Game.Flags.MissionHandOK.Imperial = true
    NextStep = "RefreshPhase.II.DiscardMissions"
    Step = ""
  end--function
end--function

function BuildUnits(Params)	--{Faction=""}
  local Panel = nil
  local Color = {1,1,1}
  if Params.Faction == "Rebel" then
      Panel = RebelPanel
      Color = {1,1,1}
  else--imperial
      Panel = ImperialPanel
      Color = {0.5,0.5,1}
  end--if
  Panel.clearButtons()
  Panel.createButton({click_function="NA",function_owner=Global,label="BUILDING UNITS",position={0.01,-0.6,-3.6},rotation={90,0,0},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  Panel.createButton({click_function="NA",function_owner=Global,label="BUILDING UNITS",position={0,-0.6,-3.6},rotation={90,0,0},scale={0.5,1,1},width=0,height=0,font_size=400,font_color=Color})
  Panel.createButton({click_function="NA",function_owner=Global,label=string.upper(Params.Faction),position={0.75,-0.1,-0.83},rotation={0,0,180},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  Panel.createButton({click_function="Build"..Params.Faction.."Units",function_owner=Global,label="Build",position={-0.85,-0.1,-0.83},rotation={0,0,180},scale={0.6,0.6,0.6},width=500,height=200,color={1,1,1},font_size=150,font_color={0,0,0},tooltip="Click here to build the Units."})
  Panel.createButton({click_function="ReScanBuild",function_owner=Global,label="Re-Scan",position={-0.15,-0.1,-0.83},rotation={0,0,180},scale={0.6,0.6,0.6},width=500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Click here to build the Units."})
	Panel.createButton({click_function="FixBuildTiles",function_owner=Global,label="FixTiles",position={-1.1,-0.1,0.9},rotation={0,0,180},scale={0.5,0.5,0.5},width=300,height=100,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Click this button to fix any Build Tiles/Icons that are not displayed properly."})
	function FixBuildTiles()
		for O,Obj in pairs(getAllObjects()) do
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if string.find(Obj.getDescription(),"BuildTile;") != nil then
				local R = {0,0,0}	--assume rebel rotation until proben otherwise.
				if string.find(Obj.getDescription(),"Imperial;") != nil then
					R = {0,180,0}
				end--if
				Obj.setScale({0.25,1,0.25})
				Obj.setPosition({Obj.getPosition().x,0.55,Obj.getPosition().z})
				Obj.setRotation(R)
			end--if
		end--for O,Obj
	end--function 
    function ReScanBuild(PanelObj)
        if Game.Flags.Busy.Rebel or Game.Flags.Busy.Imperial then
            printToAll("Cannot re-scan, building has already started.",{1,1,0})
        else--ok to re-scan... 
            NextStep = "RefreshPhase.V.ii.BuildIcon"
            Step = ""
        end--ok to rescan?
    end--function
    function BuildRebelUnits()
        RebelPanel.clearButtons()
        NextStep = "RefreshPhase.V.ii.BuildRebelUnits"
        Step = ""
    end--function
    function BuildImperialUnits()
        ImperialPanel.clearButtons()
        NextStep = "RefreshPhase.V.ii.BuildImperialUnits"
        Step = ""
    end--function
end--function

--Setup Panel Menus------------------------------------------------------------------------------------------------------------------

function FixAssignmentZones()
    print("No Longer Needed")
end--function

function RebelMissionDeckChoiceMenu()
	local BaseZ = 0.1
	local RotEZ = 0.5
	local GSZ = 0.9
	--randomize button placement...
	local R = math.random(1,6)
	if R == 1 then BaseZ=0.1 RotEZ=0.5 GSZ=0.9 end--if
	if R == 2 then BaseZ=0.1 RotEZ=0.9 GSZ=0.5 end--if
	if R == 3 then BaseZ=0.5 RotEZ=0.1 GSZ=0.9 end--if
	if R == 4 then BaseZ=0.5 RotEZ=0.9 GSZ=0.1 end--if
	if R == 5 then BaseZ=0.9 RotEZ=0.5 GSZ=0.1 end--if
	if R == 6 then BaseZ=0.9 RotEZ=0.1 GSZ=0.5 end--if
	--set camera view...
	if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) end--if
	if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) end--if
	if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel) end--if
	--create menu...
	SetupPanel.clearButtons()
	SetupPanel.setPositionSmooth(PanelSpots.RebelSecret.Position,false,false)
	SetupPanel.setRotationSmooth(PanelSpots.RebelSecret.Rotation,false,false)
	SetupPanel.setScale(PanelSpots.RebelSecret.Scale)
	SetupPanel.setColorTint({1,1,1,1})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="Rebel Mission Deck Choice:",position={0,0.1,-0.2},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="Rebel Player is choosing\nwhich Mission Deck to play with.",position={0,-0.1,0},rotation={0,0,180},scale={1,1,1},width=0,height=0,font_size=125,font_color={1,1,1}})
	SetupPanel.createButton({click_function="ChooseBaseRebelMissions",function_owner=Global,label="Base Game Mission Deck",position={0,0.1,BaseZ},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using the Base Game Rebel Mission Deck."})
	SetupPanel.createButton({click_function="ChooseRotERebelMissions",function_owner=Global,label="Rise of the Empire Mission Deck",position={0,0.1,RotEZ},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using Rise of the Empire Rebel Mission Deck."})
	if Game.Flags.WFL and false then
		SetupPanel.createButton({click_function="ChooseGSRebelMissions",function_owner=Global,label="Galactic Struggle Mission Deck",position={0,0.1,GSZ},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using Galactic Struggle Rebel Mission Deck (fan-made)."})
	end--if
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="(Button order was randomized for secrecy)",position={0,0.1,1.4},scale={1,1,1},width=0,height=0,font_size=75,font_color={1,1,1}})
	function ChooseBaseRebelMissions()
		SetupPanel.clearButtons()
			Game.DeckChoice.Rebel = "Base"
			NextStep = "Setup.7.II.ImperialMissionDeckChoice"
		Step = ""
	end--function
	function ChooseRotERebelMissions()
		SetupPanel.clearButtons()
			Game.DeckChoice.Rebel = "RotE"
			NextStep = "Setup.7.II.ImperialMissionDeckChoice"
		Step = ""
	end--function
	function ChooseGSRebelMissions()
		SetupPanel.clearButtons()
			Game.DeckChoice.Rebel = "GS"
			NextStep = "Setup.7.II.ImperialMissionDeckChoice"
		Step = ""
	end--function
end--function

function ImperialMissionDeckChoiceMenu()
	local BaseZ = 0.1
	local RotEZ = 0.5
	local GSZ = 0.9
	--randomize button placement...
	local R = math.random(1,6)
	if R == 1 then BaseZ=0.1 RotEZ=0.5 GSZ=0.9 end--if
	if R == 2 then BaseZ=0.1 RotEZ=0.9 GSZ=0.5 end--if
	if R == 3 then BaseZ=0.5 RotEZ=0.1 GSZ=0.9 end--if
	if R == 4 then BaseZ=0.5 RotEZ=0.9 GSZ=0.1 end--if
	if R == 5 then BaseZ=0.9 RotEZ=0.5 GSZ=0.1 end--if
	if R == 6 then BaseZ=0.9 RotEZ=0.1 GSZ=0.5 end--if
	--set camera view...
	if Player.Blue.seated then Player.Blue.lookAt(CameraViews.ImperialPanel) end--if
	if Player.Orange.seated then Player.Orange.lookAt(CameraViews.ImperialPanel) end--if
	if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.ImperialPanel) end--if
	--create menu...
	SetupPanel.clearButtons()
	SetupPanel.setPositionSmooth(PanelSpots.ImperialSecret.Position,false,false)
	SetupPanel.setRotation(PanelSpots.ImperialSecret.Rotation)
	SetupPanel.setScale(PanelSpots.ImperialSecret.Scale)
	SetupPanel.setColorTint({1,1,1,1})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="Imperial Mission Deck Choice:",position={0,0.1,-0.2},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="Imperial Player is choosing\nwhich Mission Deck to play with.",position={0,-0.1,0},rotation={0,0,180},scale={1,1,1},width=0,height=0,font_size=125,font_color={1,1,1}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="(Button order was randomized for secrecy)",position={0,0.1,1.4},scale={1,1,1},width=0,height=0,font_size=75,font_color={1,1,1}})
	function ChooseBaseImperialMissions()
		SetupPanel.clearButtons()
		Game.DeckChoice.Imperial = "Base"
		NextStep = "Setup.7.III.BuildMissionDecks"
		Step = ""
	end--function
	function ChooseRotEImperialMissions()
		SetupPanel.clearButtons()
		Game.DeckChoice.Imperial = "RotE"
		NextStep = "Setup.7.III.BuildMissionDecks"
		Step = ""
	end--function
	function ChooseGSImperialMissions()
		SetupPanel.clearButtons()
		Game.DeckChoice.Imperial = "GS"
		NextStep = "Setup.7.III.BuildMissionDecks"
		Step = ""
	end--function
	--AI?
	if Game.AI.Active then
		Wait.time(function() ChooseBaseImperialMissions() end,1)
	else 
		SetupPanel.createButton({click_function="ChooseBaseImperialMissions",function_owner=Global,label="Base Game Mission Deck",position={0,0.1,BaseZ},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using the Base Game Imperial Mission Deck."})
		SetupPanel.createButton({click_function="ChooseRotEImperialMissions",function_owner=Global,label="Rise of the Empire Mission Deck",position={0,0.1,RotEZ},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using Rise of the Empire Imperial Mission Deck."})
		if Game.Flags.WFL and false then
			SetupPanel.createButton({click_function="ChooseGSImperialMissions",function_owner=Global,label="Galactic Struggle Mission Deck",position={0,0.1,GSZ},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using Galactic Struggle Imperial Mission Deck (fan-made)."})
		end--if
	end--if AI active. 
end--function

function ChooseTacticDeckMenu()
  SetupPanel.clearButtons()
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="Choose Tactics Deck:",position={0,0.1,-0.1},scale={1,1,1},width=0,height=0,font_size=125,font_color={1,1,1}})
  SetupPanel.createButton({click_function="ChooseAdvancedTactics",function_owner=Global,label="Use Advanced Tactic Cards",position={0,0.1,0.3},scale={1,1,1},width=1700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using the Rise of the Empire Advanced Tactic Cards."})
  SetupPanel.createButton({click_function="ChooseBaseTactics",function_owner=Global,label="Use Base Tactic Cards (House Rule)",position={0,0.1,1},scale={1,1,1},width=1700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play Rise of the Empire Expansion, but use the base game Tactic Cards."})
  function ChooseAdvancedTactics()
    SetupPanel.clearButtons()
    Game.Flags.AdvancedTactics = true
    NextStep = "Setup.6.PrepareTacticDecksMarkersAndDice.2"
    Step = ""
  end--function
  function ChooseBaseTactics()
    SetupPanel.clearButtons()
		Game.Flags.AdvancedTactics = false
    NextStep = "Setup.6.PrepareTacticDecksMarkersAndDice.2"
    Step = ""
  end--function
end--function

function ChooseMissionDeckTypeMenu()
	SetupPanel.clearButtons()
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="Choose Mission Deck Type:",position={0,0.1,-0.1},scale={1,1,1},width=0,height=0,font_size=125,font_color={1,1,1}})
	SetupPanel.createButton({click_function="ChooseStandardMissionDeckSize",function_owner=Global,label="Use Standard Mission Deck Size",position={0,0.1,0.3},scale={1,1,1},width=1700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using the standard mission deck size."})
	SetupPanel.createButton({click_function="ChooseGalacticStruggleBigDeck",function_owner=Global,label="Use Galactic Struggle Deck",position={0,0.1,0.7},scale={1,1,1},width=1700,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="This builds the Mission Deck using all cards from each faction's mission decks. Instead of drawing 2 missions, each player draws 3 and discards 1."})
	function ChooseStandardMissionDeckSize()
		SetupPanel.clearButtons()
		Game.Flags.GSDeck = false
		NextStep = "Setup.7.PrepareMissionCards.2"
		Step = ""
	end--function
	function ChooseGalacticStruggleBigDeck()
		SetupPanel.clearButtons()
		Game.Flags.GSDeck = true
		NextStep = "Setup.7.PrepareMissionCards.2"
		Step = ""
	end--function
end--function  

function StartSetupMenu()
  SetupPanel.setPositionSmooth(PanelSpots.Default.Position,false,false)
  SetupPanel.setRotationSmooth(PanelSpots.Default.Rotation,false,false)
  SetupPanel.setScale(PanelSpots.Default.Scale)
  SetupPanel.setColorTint({1,1,1,1})
  SetupPanel.clearButtons()
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
  SetupPanel.createButton({click_function="PlayBaseGame",function_owner=Global,label="REBELLION (Base Game)",position={0,0.1,0},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play Star Wars Rebellion with no expansions."})
  SetupPanel.createButton({click_function="PlayRiseOfTheEmpire",function_owner=Global,label="REBELLION: Rise of the Empire",position={0,0.1,0.4},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play Star Wars Rebellion with the Rise of the Empire expansion."})
  SetupPanel.createButton({click_function="PlayWiderFrontLines",function_owner=Global,label="REBELLION: Wider Front Lines",position={0,0.1,0.8},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play Star Wars Rebellion with the Wider Front Lines fan-made expansion. This also requires and includes the Rise of the Empire expansion."})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="(When playing Solo, set your Player Color to Black).",position={0,0.1,1.5},scale={1,1,1},width=0,height=0,color={1,1,1},font_size=50,font_color={0.3,0.3,0.3}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="Blue Seat\nImperial Player 1 (Admiral)",position={-5.3,38,2.6},rotation={90,90,0},scale={3,1,1},width=0,height=0,font_size=150,font_color={0,0.5,1}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="Orange Seat\nImperial Player 2 (General)",position={-5.3,12,2.6},rotation={90,90,0},scale={3,1,1},width=0,height=0,font_size=150,font_color={1,0.5,0}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="White Seat\nRebel Player 1 (Admiral)",position={5.3,38,2.6},rotation={90,270,0},scale={3,1,1},width=0,height=0,font_size=150,font_color={1,1,1}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="Red Seat\nRebel Player 2 (General)",position={5.3,12,2.6},rotation={90,270,0},scale={3,1,1},width=0,height=0,font_size=150,font_color={1,0,0}})
  function PlayBaseGame()
    SetupPanel.clearButtons()
    Game.Flags.RotE = false
    Game.Flags.WFL = false
	Game.SubTitle = ""
    NextStep = "Setup.1.DeterminePlayers"
    Step = ""
  end--function
  function PlayRiseOfTheEmpire()
    SetupPanel.clearButtons()
	Game.Flags.RotE = true
    Game.Flags.WFL = false
	Game.SubTitle = "RISE OF THE EMPIRE"
    NextStep = "Setup.1.DeterminePlayers"
    Step = ""
  end--function
  function PlayWiderFrontLines()
	SetupPanel.clearButtons()
	Game.Flags.RotE = true
	Game.Flags.WFL = true
	Game.SubTitle = "WIDER FRONT LINES"
	NextStep = "Setup.1.DeterminePlayers"
	Step = ""
  end--function
end--function

function DeterminePlayersMenu()
  --prompt for: 2P,3P,4P
  SetupPanel.clearButtons()
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
  SetupPanel.createButton({click_function="Setup2PlayerGame",function_owner=Global,label="2 Player Game",position={0,0.1,-0.1},scale={1,1,1},width=1000,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="2 Player game: 1 Rebel Player vs 1 Imperial Player."})
  SetupPanel.createButton({click_function="Setup3PlayerGame",function_owner=Global,label="3 Player Game",position={0,0.1,0.3},scale={1,1,1},width=1000,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="3 Player game: 1 Rebel Player vs 2 Imperial Players."})
  SetupPanel.createButton({click_function="Setup4PlayerGame",function_owner=Global,label="4 Player Game",position={0,0.1,0.7},scale={1,1,1},width=1000,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="4 Player game: 2 Rebel Players vs 2 Imperial Player."})
  SetupPanel.createButton({click_function="Setup1PlayerGame",function_owner=Global,label="Han Solo mode",position={0,0.1,1.1},scale={1,1,1},width=1000,height=200,color={0.5,0.5,0.5},font_size=100,font_color={0,0,0},tooltip="1 Player game: 1 Rebel Player vs Imperial AI Player.\nTHIS OPTION DOES NOT WORK YET. FOR TESTING ONLY."})
end--function

function ChooseUnitModelsMenu()
	--prompt for painted units or original plastic units... 
	PleaseWait({Panel=SetupPanel,Text="Place Starting Units and Loyalty..."})
	--destroy stray units...
	for O,Obj in pairs(getAllObjects()) do
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		if Obj.getVar("Component") == "Unit" then
			Obj.destruct()
		end--if
	end--for
	NextStep = "Setup.8.PlaceStartingUnitsAndLoyalty"
	SetupPanel.clearButtons()
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="Choose Unit Model Style:",position={0,0.1,-0.1},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	SetupPanel.createButton({click_function="ChooseOriginalUnits",function_owner=Global,label="Original Units",position={0,0.1,0.3},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play with the original style unpainted plastic units."})
	SetupPanel.createButton({click_function="ChoosePaintedUnits",function_owner=Global,label="Painted Units",position={0,0.1,0.7},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play with nicer looking painted units.\nSome might be harder to see on the board at a distance."})
	function ChoosePaintedUnits()
        SetupPanel.clearButtons()
        printToAll("Playing with painted units.")
		Game.Flags.Painted = true	--should already be defaulted to true. 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
			if string.find(Obj.getGMNotes(),"OriginalUnit;") then
				Obj.destruct()
			end--if
		end--for O,Obj 
		Step = ""
	end--function
	function ChooseOriginalUnits()
        SetupPanel.clearButtons()
		printToAll("Playing with original units.")
		LoadOriginalUnits()
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
			if string.find(Obj.getGMNotes(),"PaintedUnit;") then
				if Obj != nil then Obj.destruct() end--if
			end--if
		end--for O,Obj 
		Step = ""
	end--function 
end--function 

function ChooseSetupTypeMenu()
	NextStep = "Setup.8.I.DetermineStartingLoyalty"
	SetupPanel.clearButtons()
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label="Choose Game Setup:",position={0,0.1,-0.1},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	SetupPanel.createButton({click_function="ChooseFirstGameSetup",function_owner=Global,label="First Game Setup",position={0,0.1,0.3},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play with pre-determined Loyalty and Unit Deployment as per pg 16 of the Learn to Play Guide."})
	SetupPanel.createButton({click_function="ChooseAdvancedSetup",function_owner=Global,label="Advanced Setup",position={0,0.1,0.7},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play the Advanced Setup rules. (This is the usual setup for a non-learning game)."})
	SetupPanel.createButton({click_function="ChooseCustomSetup",function_owner=Global,label="Custom Setup",position={0,0.1,1.1},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play with a custom setup.  Players will manually set Starting System Loyalty and remove those Probe cards from the game."})
	function ChooseFirstGameSetup()
        SetupPanel.clearButtons()
        printToAll("Playing with first game setup rules.")
		Game.Type = "First"
		Step = ""
	end--function
	function ChooseAdvancedSetup()
        SetupPanel.clearButtons()
		printToAll("Playing with advanced setup rules.")
		Game.Type = "Advanced"
		Step = ""
	end--function 
	function ChooseCustomSetup()
        SetupPanel.clearButtons()
		printToAll("Playing with a custom setup rules.")
		Game.Type = "Custom"
		Step = ""
	end--function 
end--function 

function ChooseStartingUnitPlacement()
  SetupPanel.clearButtons()
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="Choose Starting Unit Placement:",position={0,0.1,-0.1},scale={1,1,1},width=0,height=0,font_size=125,font_color={1,1,1}})
  SetupPanel.createButton({click_function="ChooseBasePlacement",function_owner=Global,label="Base Game Placement",position={0,0.1,0.3},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using the Base Game Unit List."})
  SetupPanel.createButton({click_function="ChooseRotEPlacement",function_owner=Global,label="Rise of the Empire Placement",position={0,0.1,0.7},scale={1,1,1},width=1500,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Play using Rise of the Empire Unit List."})
  function ChooseBasePlacement()
    SetupPanel.clearButtons()
    Game.Flags.UnitPlacement = "Base"
    NextStep = "Setup.8.II.GatherStartingUnits"
    Step = ""
  end--function
  function ChooseRotEPlacement()
    SetupPanel.clearButtons()
		Game.Flags.UnitPlacement = "RotE"
    NextStep = "Setup.8.II.GatherStartingUnits"
    Step = ""
  end--function
end--function

function SetupCompleteMenu()
  SetupPanel.clearButtons()
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="Setup is Complete.",position={0,0.1,-0.1},scale={1,1,1},width=0,height=0,font_size=125,font_color={1,1,1}})
  SetupPanel.createButton({click_function="StartFirstRound",function_owner=Global,label="A long time ago in a\ngalaxy far, far away...",position={0,0.1,0.7},scale={1,1,1},width=1800,height=500,color={0.9,0.9,0.9},font_size=150,font_color={0.2,0.2,0.5},tooltip="Click here to start round 1 of the game!"})
  SetupPanel.createButton({click_function="NA",function_owner=Global,label="^Click to Start the Game^",position={0,0.1,1.4},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
  function StartFirstRound()
    SetupPanel.clearButtons()
    NextStep = "AssignmentPhase.Start"
    Step = ""
  end--function
end--function

function SettingsMenu()
	SetupPanel.clearButtons()
  	SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
  	SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
	if Game.Phase == "Command" then
		SetupPanel.createButton({click_function="NA",function_owner=Global,label="Round: "..Game.Round..",  Phase: "..Game.Phase.."\nTurn: ("..Game.Turn.Num..")"..Game.Turn.Faction.." "..Game.Turn.Role,position={0,0.1,0},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	else
		SetupPanel.createButton({click_function="NA",function_owner=Global,label="Round: "..Game.Round..",  Phase: "..Game.Phase,position={0,0.1,-0.3},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	end--if
	SetupPanel.createButton({click_function="ResetScript",function_owner=Global,label="Reset Script",position={-1.5,0.1,1.5},scale={0.5,0.5,0.5},width=1000,height=300,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Change the Script's Round/Phase/Turn/Step."})
	SetupPanel.createButton({click_function="ReCalculateBoard",function_owner=Global,label="Re-Calc Board",position={1.5,0.1,1.5},scale={0.5,0.5,0.5},width=1000,height=300,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Re-calculate and update all units and board locations."})
  	function ReCalculateBoard()
		log("\nRe-Calculating the Board...")
		UpdateBoard(true)
		SettingsMenu()
	end--function 
	function ResetScript()
		if NextStep == "" then NextStep = Step end--if
		ResetStepNum = 1
		for S=1,#StepList do
			if StepList[S][2] == NextStep then
				ResetStepNum = S
				print("Current Step is: "..StepList[ResetStepNum][2])
			end--if
		end--for
		ResetScriptMenu()
	end--function
end--function

function ResetScriptMenu()
	SetupPanel.clearButtons()
  	SetupPanel.createButton({click_function="NA",function_owner=Global,label="___Star Wars___",position={0,0.1,-1.35},scale={1,1,1},width=0,height=0,font_size=200,font_color={1,1,0}})
  	SetupPanel.createButton({click_function="NA",function_owner=Global,label="REBELLION",position={0,0.1,-0.85},scale={1,1,1},width=0,height=0,font_size=300,font_color={0.9,0.9,0.9}})
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=Game.SubTitle,position={0,0.1,-0.5},scale={1,1,1},width=0,height=0,font_size=150,font_color={0.6,0.6,0.6}})
  	if Game.Phase == "Command" then
		SetupPanel.createButton({click_function="NA",function_owner=Global,label="Round: "..Game.Round..",  Phase: "..Game.Phase.."\nTurn: ("..Game.Turn.Num..")"..Game.Turn.Faction.." "..Game.Turn.Role,position={0,0.1,-0.3},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	else
		SetupPanel.createButton({click_function="NA",function_owner=Global,label="Round: "..Game.Round..",  Phase: "..Game.Phase,position={0,0.1,-0.3},scale={1,1,1},width=0,height=0,font_size=100,font_color={1,1,1}})
	end--if
	SetupPanel.createButton({click_function="NA",function_owner=Global,label=StepList[ResetStepNum][2],position={0,0.25,1},scale={1,1,1},width=0,height=0,font_size=90,font_color={0.5,0.5,1,0.9}})
	SetupPanel.createButton({click_function="GoBack",function_owner=Global,label="<",position={-1.8,0.1,1},scale={0.5,0.5,0.5},width=300,height=300,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Go back a step in the script."})
	SetupPanel.createButton({click_function="GoForward",function_owner=Global,label=">",position={1.8,0.1,1},scale={0.5,0.5,0.5},width=300,height=300,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Go forward a step in the script."})
	SetupPanel.createButton({click_function="ConfirmReset",function_owner=Global,label="Set Next Step",position={-0.6,0.1,1.5},scale={0.5,0.5,0.5},width=1000,height=300,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Resume the game from this point."})
	SetupPanel.createButton({click_function="CancelReset",function_owner=Global,label="Cancel",position={0.6,0.1,1.5},scale={0.5,0.5,0.5},width=1000,height=300,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Cancel this reset and continue as normal."})
	function GoBack()
		ResetStepNum = ResetStepNum - 1
		if ResetStepNum < 1 then
			ResetStepNum = #StepList
		elseif Game.Players.Total <= 2 and StepList[ResetStepNum][2] == "CommandPhase.4.Rebel.General.Turn" then
			ResetStepNum = ResetStepNum - 4
		elseif Game.Players.Total > 2 and StepList[ResetStepNum][2] == "CommandPhase.2.Imperial.Turn" then
			ResetStepNum = ResetStepNum - 2
		end--if
		ResetScriptMenu()
	end--function
	function GoForward()
		ResetStepNum = ResetStepNum + 1
		if ResetStepNum > #StepList then
			ResetStepNum = 1
		elseif Game.Players.Total <= 2 and StepList[ResetStepNum][2] == "CommandPhase.1.Rebel.Admiral.Turn" then
			ResetStepNum = ResetStepNum + 4
		elseif Game.Players.Total > 2 and StepList[ResetStepNum][2] == "CommandPhase.1.Rebel.Turn" then
			ResetStepNum = ResetStepNum + 2
		end--if
		ResetScriptMenu()
	end--function
	function ConfirmReset()
		SetupPanel.clearButtons()
		--reset components (hidden zones, moved boxes)...
		for D=1,#Game.Leaders.Draws.Rebel do
			if getObjectFromGUID(Game.Leaders.Draws.Rebel[D]) != nil then
				getObjectFromGUID(Game.Leaders.Draws.Rebel[D]).setRotation({0,getObjectFromGUID(Game.Leaders.Draws.Rebel[D]).getRotation().y,180})
				GetDeck("RebelAction").putObject(getObjectFromGUID(Game.Leaders.Draws.Rebel[D]))
			end--if
		end--for
		for D=1,#Game.Leaders.Draws.Imperial do
			if getObjectFromGUID(Game.Leaders.Draws.Imperial[D]) != nil then
				getObjectFromGUID(Game.Leaders.Draws.Imperial[D]).setRotation({0,getObjectFromGUID(Game.Leaders.Draws.Imperial[D]).getRotation().y,180})
				GetDeck("ImperialAction").putObject(getObjectFromGUID(Game.Leaders.Draws.Imperial[D]))
			end--if
		end--for
		Game.Leaders.Recruits.Rebel = {}
		Game.Leaders.Draws.Rebel = {}
		Game.Leaders.Recruits.Imperial = {}
		Game.Leaders.Draws.Imperial = {}
		startLuaCoroutine(Global,"DismissRecruits")
		getObjectFromGUID(IDs.Rebel.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Rebel.Off,false,false)
		getObjectFromGUID(IDs.Imperial.HiddenPanelZone).setPositionSmooth(Spots.HiddenZones.PlayerPanel.Imperial.Off,false,false)
		--move leader bags back to original location...
		getObjectFromGUID(IDs.Rebel.LeaderBag).setPositionSmooth({19,1.47,33},false,false)
		getObjectFromGUID(IDs.Rebel.LeaderBag).setRotation({0,0,0})
		getObjectFromGUID(IDs.Imperial.LeaderBag).setPositionSmooth({19,1.47,-33},false,false)
		getObjectFromGUID(IDs.Imperial.LeaderBag).setRotation({0,180,0})
		--change next step...
		print("Resetting game to step: [",ResetStepNum,"]",StepList[ResetStepNum][2])
		NextStep = StepList[ResetStepNum][2]
		Step = ""
	end--function
	function CancelReset()
		SettingsMenu()
	end--function
end--function

--Rebel Panel Menus---------------------------------------------------------------------------------------------------------------------

function RebelStartingUnitPlacement()
  RebelPanel.clearButtons()
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Place Starting Rebel Units:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
  local LabelText = ""
  if Game.Flags.UnitPlacement == "RotE" then
    LabelText = "Place in the Rebel Base Space, and/or one other\nSystem that does not contain an Imperial Unit:\n1 X-Wing,\nY-Wing,\n1 U-Wing,\n1 Rebel Transport,\n1 Corellian Corvette,\n5 Rebel Troopers,\n1 Rebel Vanguard,\n2 Airspeeders."
  else
    LabelText = "Place in the Rebel Base Space, and/or one other\nSystem that does not contain an Imperial Unit:\n2 X-Wings,\n2 Y-Wings,\n1 Rebel Transport,\n1 Corellian Corvette,\n5 Rebel Troopers,\n2 Airspeeders."
  end--if
  RebelPanel.createButton({click_function="NA",function_owner=Global,label=LabelText,position={0,0.1,0.1},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="(Your Starting Units are in the Rebel Base Space).",position={0,0.1,0.7},scale={0.6,0.6,0.6},width=0,height=0,font_size=50,font_color={0.7,0.7,0.7}})
  RebelPanel.createButton({click_function="RebelStartingUnitPlacementComplete",function_owner=Global,label="Rebel Placement Complete",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Rebel Starting Unit Placement is complete."})
  function RebelStartingUnitPlacementComplete()
    RebelPanel.clearButtons()
    if Game.Type == "Custom" then
      NextStep = "Setup.8.IV.DrawStartingActionCards"
    else
      NextStep = "Setup.8.III.ValidateRebelStartingUnits"
    end
    Step = ""
  end--function
end--function

function RebelStartingUnitPlacementValidation(Params)
  RebelPanel.clearButtons()
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Starting Rebel Unit Placement:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
  if Params.ErrorText == "" then
    RebelPanel.createButton({click_function="NA",function_owner=Global,label="No issues detected with\nRebel Starting Unit Placement.",position={0,0.1,0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,1}})
    RebelPanel.createButton({click_function="ContinueToRebelPlacement",function_owner=Global,label="Proceed to Rebel Starting Unit Placement",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={0.5,1,0.5},font_size=100,font_color={0,0,0},tooltip="Rebel Starting Unit Placement is valid. Proceed to Rebel Starting Unit Placement."})
  else --display the problem...
    RebelPanel.createButton({click_function="NA",function_owner=Global,label=Params.ErrorText,position={0,0.1,0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,0.5}})
    RebelPanel.createButton({click_function="ContinueToActionCardDraw",function_owner=Global,label="Continue Anyway",position={-0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,0},font_size=100,font_color={0,0,0},tooltip="Continue to the next Step without validating placement."})
    RebelPanel.createButton({click_function="ValidateRebelPlacement",function_owner=Global,label="Validate Placement",position={0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Validate Rebel Starting Unit Placement before continuing."})
  end--if
  function ValidateRebelPlacement()
    RebelPanel.clearButtons()
    NextStep = "Setup.8.III.ValidateRebelStartingUnits"
    Step = ""
  end--function
  function ContinueToActionCardDraw()
    RebelPanel.clearButtons()
    NextStep = "Setup.8.IV.DrawStartingActionCards"
    Step = ""
  end--function
end--function

function ResolveRebelExtremist(Params)  --{CardObj=object}
  RebelPanel.clearButtons()
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="RESOLVING: REBEL EXTREMIST",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="RESOLVING: REBEL EXTREMIST",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Immediate Starting Action Card:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL EXTREMIST:\nEither draw 1 starting action\ncard or recruit Saw Gerrera.\n\nIf you recruit Saw Gerrera,\nlose 1 reputation and place\nhim in your leader pool.",position={0,0.1,0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  RebelPanel.createButton({click_function="Draw1StartingAction",function_owner=Global,label="Draw 1 Starting Action",position={-0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=75,font_color={0,0,0},tooltip="Draw 1 Starting Action Card instead of recruiting this leader."})
  RebelPanel.createButton({click_function="RecruitSaw",function_owner=Global,label="Recruit Saw",position={0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=75,font_color={0,0,0},tooltip="Recruit this leader."})
  GetLeader({Name="Saw Gerrera",Smooth=true,Position={0,0.7,24.5},Rotation={0,0,0}})
  function Draw1StartingAction()
    RebelPanel.clearButtons()
    --draw another starting action card, and discard this action card.
    DealToHand({Deck="RebelStartingAction",Player="White",Index=3,Qty=1,Flip=true})
    getObjectFromGUID(Decks.RebelStartingAction.ID).putObject(Params.CardObj)
    printToAll("Rebel Player draws another Starting Action Card.")
    --put saw gerrara away...
    getObjectFromGUID(IDs.Rebel.LeaderBag).putObject(getObjectFromGUID("abc7c0"))
    Game.Flags.Immediate.Action.Rebel = false
    NextStep = "Setup.8.IV.ResolveStartingActionCards"
    Step = ""
  end--function
  function RecruitSaw()
    RebelPanel.clearButtons()
    --recuit saw...
    GetLeader({Name="Saw Gerrera",Smooth=true,Position={-3.5,0.7,20},Rotation={0,0,0}}).setDescription("Leader;Rebel;General;RotE;Recruited;")
    printToAll("Saw Gerrera has been recruited.\nRebels lose 1 reputation.")
    --move rebel marker...
    getObjectFromGUID(IDs.ReputationMarker).setPositionSmooth({-20.61,0.69,2.72},false,false)
    getObjectFromGUID(IDs.ReputationMarker).setRotationSmooth({0,90,0},false,false)
    Ping({Position={-20.61,0.69,2.72}})
    Game.Flags.Immediate.Action.Rebel = false
    table.insert(Game.Leaders.Pools.Rebel,"Saw Gerrera")
    NextStep = "Setup.8.IV.ResolveStartingActionCards"
    Step = ""
  end--function
end--function

function ResolveHelpMeObiWanKenobi(Params)  --{CardObj=object}
	RebelPanel.clearButtons()
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="RESOLVING: HELP ME OBI-WAN KENOBI",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="RESOLVING: HELP ME OBI-WAN KENOBI",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="Immediate Starting Action Card:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="HELP ME OBI-WAN KENOBI:\nPrincess Leia has been captured.\nRebels have recovered one of her droids\nand recruited Obi-Wan Kenobi.\n\nChoose a droid's Action card:",position={0,0.1,0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
	--recruit obi-wan kenobi... 
	GetLeader({Name="Obi-Wan Kenobi",Smooth=true,Position={-3.5,0.7,21},Rotation={0,0,0}})
	printToAll("Rebels have recruited Obi-Wan Kenobi (Help me Obi-Wan Kenobi).")
	--fetch noble sacrifice card...
	GetObjectFromBag({BagID=GetDeck("RebelAction").getGUID(),Name="NOBLE SACRIFICE",Position={-16,3,22},Rotation={0,0,0}})
	--locate death star or dsuc...
	local DS = FindObject({Name="Death Star Under Construction",Description="Unit;"})
	local PL = FindObject({Name="Princess Leia",Description="Leader;"})
	local P = {-1,3,-10}
	if DS != nil then 
		P = {DS.getPosition().x,DS.getPosition().y+2,DS.getPosition().z} 
	else 
		DS = FindObject({Name="Death Star",Description="Unit;"})
		if DS != nil then 
			P = {DS.getPosition().x,DS.getPosition().y+2,DS.getPosition().z} 
		else 
			printToAll("UHOH: Could not locate a Death Star or Death Star Under Construction in play!")
		end--if
	end--if
	--fetch capture ring... 
	LeaderFetchRing({Name="Captured",BagID=IDs.Imperial.RingBag,Smooth=true,Position=P,Rotation={0,0,0}})
	--attach capture ring to princess leia and move her to the death star or dsuc...
	if PL != nil then 
		PL.setRotationSmooth({0,0,0},false,false)
		PL.setPositionSmooth(P,false,false)
	else 
		printToAll("UHOH: Could not locate Princess Leia!")
	end--if
	--resourceful astromech already in play?
	if FindObject({Tag="Card",Name="RESOURCEFUL ASTROMECH"}) == nil then
		RebelPanel.createButton({click_function="ChooseResourcefulAstromech",function_owner=Global,label="Resourceful Astromech",position={-0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=75,font_color={0,0,0},tooltip="Gain the Resourceful Astromech Immediate Action card and R2-D2 ring."})
	end--if
	--human-cyborg relations already in play?
	if FindObject({Tag="Card",Name="HUMAN%-CYBORG RELATIONS"}) == nil then
		RebelPanel.createButton({click_function="ChooseHumanCyborgRelations",function_owner=Global,label="Human-Cyborg Relations",position={0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=75,font_color={0,0,0},tooltip="Gain the Human-Cyborg Relations Immediate Action card and C-3P0 ring."})
	end--if
	function ChooseResourcefulAstromech()
		RebelPanel.clearButtons()
		GetObjectFromBag({BagID=GetDeck("RebelStartingAction").getGUID(),Name="RESOURCEFUL ASTROMECH",Position={-16,3,22},Rotation={0,0,0}})
		printToAll("Rebel Player gains RESOURCEFUL ASTROMECH Action card and the R2-D2 Ring.")
		Game.Flags.Immediate.Action.Rebel = false
		NextStep = "Setup.8.IV.ResolveStartingActionCards"
		Step = ""
	end--function
	function ChooseHumanCyborgRelations()
		RebelPanel.clearButtons()
		GetObjectFromBag({BagID=GetDeck("RebelStartingAction").getGUID(),Name="HUMAN%-CYBORG RELATIONS",Position={-16,3,22},Rotation={0,0,0}})
		printToAll("Rebel Player gains HUMAN-CYBORG RELATIONS Action card and the C-3P0 Ring.")
		Game.Flags.Immediate.Action.Rebel = false
		NextStep = "Setup.8.IV.ResolveStartingActionCards"
		Step = ""
	end--function
end--function
	  
function ChooseRebelBaseStartingLocation()
  RebelPanel.clearButtons()
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL BASE STARTING LOCATION",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL BASE STARTING LOCATION",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Choose Secret Rebel Base Location:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
  local LabelText = "Choose a Probe Card from the Probe Deck\nto be the secret location of the Rebel Base.\nPlace it face down next to the Rebel Base."
  RebelPanel.createButton({click_function="NA",function_owner=Global,label=LabelText,position={0,0.1,0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  RebelPanel.createButton({click_function="RebelBaseChosen",function_owner=Global,label="Rebel Base Step Complete",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Place the Rebel Base Location's Probe Cards and click here to continue."})
  Ping({Position={-23.3,0.7,7.4}})
  function RebelBaseChosen()
    RebelPanel.clearButtons()
    --check for rebel base card...
    Game.Systems.RebelBase.ID = ScanForObjectID({Description="ProbeCard;",Origin={-23.3,0.7,7.4},Size={1,1,1},Debug=false,Type=2})
    if Game.Systems.RebelBase.ID != "" then
      Game.Systems.RebelBase.Name = getObjectFromGUID(Game.Systems.RebelBase.ID).getName()
      printToAll("The Rebel Base Location has been chosen.")
      NextStep = "Setup.10.DrawStartingHand"
      Step = ""
    else--didn't find a probe card where we expected it...
      printToAll("Did not detect a Probe Card at the Rebel Base Location.")
      ChooseRebelBaseStartingLocation()
    end--if
  end--function
end--function

function ResolveRapidMobilization()
	--prompt rebel player to resolve rapid mobilization...
	if Player.White.seated then Player.White.lookAt(CameraViews.RebelPanel) Ping({Player="White",Position={0,1,29}}) end--if
	if Player.Red.seated then Player.Red.lookAt(CameraViews.RebelPanel) Ping({Player="Red",Position={0,1,29}}) end--if
	if Player.Black.seated and not Game.AI.Active then Player.Black.lookAt(CameraViews.RebelPanel) end--if
	ProbeCards = {}
	RebelPanel.clearButtons()
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="RAPID MOBILIZATION",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="RAPID MOBILIZATION",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="COMMAND PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="Resolve Rapid Mobilization",position={0,0.1,-0.35},scale={0.6,0.6,0.6},width=0,height=0,font_size=150,font_color={1,1,1}})
	RebelPanel.createButton({click_function="RapidMobilizationDraw4",function_owner=Global,label="Draw 4 Probe Cards\n(1 Leader)",position={-0.6,0.1,0.1},scale={0.5,0.5,0.5},width=1000,height=400,font_size=100,font_color={0,0,0},tooltip="Attempt to relocate the Rebel Base by drawing 4 Probe Cards (1 Leader resolved the Rapid Mobilization Mission)."})
	RebelPanel.createButton({click_function="RapidMobilizationDraw8",function_owner=Global,label="Draw 8 Probe Cards\n(2 Leaders)",position={0.6,0.1,0.1},scale={0.5,0.5,0.5},width=1000,height=400,font_size=100,font_color={0,0,0},tooltip="Attempt to relocate the Rebel Base by drawing 8 Probe Cards (2 Leaders resolved the Rapid Mobilization Mission)."})
	RebelPanel.createButton({click_function="DoneRapidMobilization",function_owner=Global,label="Done (Rapid Mobilization Complete)",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Finished Resolving Rapid Mobilization."})
	function RapidMobilizationDraw4(PanelObj)
		RapidMobilizationDraw(4)
	end--function 
	function RapidMobilizationDraw8(PanelObj)
		RapidMobilizationDraw(8)
	end--function 
end--function

function DoneRapidMobilization()
	function DoneRapidMobilizationCoroutine()
		local CardCount = 0
		RebelPanel.clearButtons()
		--if there are any probe cards, reshuffle them to the bottom of the probe deck... 
		for C,Card in pairs(ProbeCards) do 
			if Card != nil then
				CardCount = CardCount + 1
				--flip face down...
				Card.setRotation({0,0,180})
				Card.setPositionSmooth({3,0.72,27.25},false,false)
				coroutine.yield(0)
			end--if
		end--for C 
		if CardCount > 0 then
			--wait for a deck to form, and all cards to vanish into it... 
			local Done = true
			local Deck = nil
			RepCount = RepCount + 1
			repeat
				coroutine.yield(0)
				Done = true  --disprove it!
				local DeckCount = 0
				for O,Obj in pairs(Physics.cast({origin={3,0.72,27.25},orientation={0,0,0},direction={0,1,0},type=3,size={1,1,1},max_distance=0,debug=false})) do
					if Obj.hit_object.type == "Card" then
						Done = false
					elseif Obj.hit_object.type == "Deck" then
						DeckCount = DeckCount + 1
						if DeckCount > 1 then
							Done = false
						else 
							Deck = Obj.hit_object
						end--if
					end--if
					if DeckCount < 1 then
						Done = false
					end--if
				end--for
			until Done
			RepCount = RepCount - 1
			coroutine.yield(0)
			Deck.shuffle()
			for D=1,10 do coroutine.yield(0) end--for D
			PlaceBottomProbe(Deck)
			printToAll("Unused Probe Cards were shuffled to the bottom of the Probe Deck.")
		end--if
    --was contingency plan revealed?
    if Game.Flags.ContingencyPlan then
      --toggle off the contingency plan flag... 
      Game.Flags.ContingencyPlan = false
      --prompt rebel player to resolve rapid mobilization a second time... 
      RebelPanel.clearButtons()
      RebelPanel.createButton({click_function="NA",function_owner=Global,label="RAPID MOBILIZATION",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
      RebelPanel.createButton({click_function="NA",function_owner=Global,label="RAPID MOBILIZATION",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
      RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
      RebelPanel.createButton({click_function="NA",function_owner=Global,label="COMMAND PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
      RebelPanel.createButton({click_function="NA",function_owner=Global,label="Resolve Rapid Mobilization again?\n(If you used Contingency Plan).",position={0,0.1,-0.3},scale={0.5,0.5,0.5},width=0,height=0,font_size=150,font_color={1,1,1}})
      RebelPanel.createButton({click_function="ResolveRapidMobilization",function_owner=Global,label="Resolve Rapid Mobilization Again",position={0,0.1,0.5},scale={0.6,0.6,0.6},width=1800,height=200,font_size=100,font_color={0,0,0},tooltip="Resolve Rapid Mobilization a second time (because you revealed it twice using Contingency Plan)."})
      RebelPanel.createButton({click_function="DoneRapidMobilization",function_owner=Global,label="Done (Rapid Mobilization Complete)",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Finished Resolving Rapid Mobilization."})
    else--rapid mobilization is done, go to next step...
      NextStep = "CommandPhase.SweepTheArea"
      Step = ""
    end--if
		return 1
	end--function 
	startLuaCoroutine(Global,"DoneRapidMobilizationCoroutine")
end--function

function RapidMobilizationDraw(DrawCount)
	function RapidMobilizationDrawCoroutine()
		coroutine.yield(0)
		RebelPanel.clearButtons()
		RebelPanel.createButton({click_function="NA",function_owner=Global,label="RAPID MOBILIZATION",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
		RebelPanel.createButton({click_function="NA",function_owner=Global,label="RAPID MOBILIZATION",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
		RebelPanel.createButton({click_function="NA",function_owner=Global,label="RAPID MOBILIZATION",position={0,0.1,-0.85},scale={0.5,0.5,0.5},width=0,height=0,font_size=250,font_color={1,1,1}})
		RebelPanel.createButton({click_function="NA",function_owner=Global,label="Choose a New Base Location:",position={0,0.1,-0.6},scale={0.5,0.5,0.5},width=0,height=0,font_size=150,font_color={0.8,0.8,0.8}})
		RebelPanel.createButton({click_function="DoneRapidMobilization",function_owner=Global,label="Do Not Move the Rebel Base",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Leave the Rebel Base as is, and shuffle all these Cards to the bottom of the Probe Deck."})
		printToAll("Secretly drawing "..DrawCount.." Probe Cards...")
		ProbeCards = {}
		local CardCount = 0
		local X = 3
		local Z = 27.25
		for C=1,DrawCount do
			coroutine.yield(0)
			ProbeCards[C] = DrawFromDeck({Deck="Probe",Smooth=false,Position={X,0.8,Z},Rotation={0,0,0},Hidden={"Blue","Orange"}})
			if ProbeCards[C] != nil then
				CardCount = CardCount + 1
				ProbeCards[C].setHiddenFrom({"Blue","Orange","Grey"})
				ProbeCards[C].clearButtons()
				ProbeCards[C].createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
				--Must have No Imperial Loyalty, No Imperial Units, and not Destroyed... 
				if GetLoyalty({System=ProbeCards[C].getName()}) == "Imperial" then
					ProbeCards[C].createButton({click_function="ConfirmMoveNo",function_owner=Global,label="Imperial\nLoyalty",position={0,0.2,0},scale={0.5,0.5,0.5},color={1,0,0,0.8},width=2000,height=2800,font_size=400,font_color={0,0,0}})
				elseif GetUnitCount({Location=ProbeCards[C].getName(),Faction="Imperial"}) > 0 then
					ProbeCards[C].createButton({click_function="ConfirmMoveNo",function_owner=Global,label="Imperial\nUnits\nDetected",position={0,0.2,0},scale={0.5,0.5,0.5},color={1,0,0,0.8},width=2000,height=2800,font_size=400,font_color={0,0,0}})
				elseif Locations[ProbeCards[C].getName()].Destroyed then
					ProbeCards[C].createButton({click_function="ConfirmMoveNo",function_owner=Global,label="System\nDestroyed",position={0,0.2,0},scale={0.5,0.5,0.5},color={1,0,0,0.8},width=2000,height=2800,font_size=400,font_color={0,0,0}})
				else
					ProbeCards[C].createButton({click_function="EstablishNewBase",function_owner=Global,label="Move Base To:\n"..ProbeCards[C].getName(),position={0,0.2,0},scale={0.5,0.5,0.5},color={1,1,1,0.8},width=1800,height=800,font_size=200,font_color={0,0,0},tooltip="Move the Rebel Base to: "..ProbeCards[C].getName().."."})
				end--if
				X = X - 2
				if X < -3 then
					X = 3
					Z = Z + 2.5
				end--if
			end--if
		end--for C 
    	coroutine.yield(0)
		if CardCount < DrawCount then
			printToAll("There were less than "..DrawCount.." Cards in the Probe Deck.",{1,1,0})
		end--if
		return 1
	end--function
	startLuaCoroutine(Global,"RapidMobilizationDrawCoroutine") 
end--function 	

function EstablishNewBase(CardObj)
	CardObj.clearButtons()
	CardObj.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
	CardObj.createButton({click_function="NA",function_owner=Global,label="Confirm Move To:\n"..CardObj.getName(),position={0,0.2,-0.2},scale={0.5,0.5,0.5},width=0,height=0,font_size=250,font_color={1,1,0}})
	CardObj.createButton({click_function="ConfirmMoveYes",function_owner=Global,label="YES",position={-0.5,0.2,0.4},scale={0.5,0.5,0.5},color={1,1,1,0.8},width=900,height=500,font_size=250,font_color={0,0,0},tooltip="YES: Move the Rebel Base to: "..CardObj.getName().."."})
	CardObj.createButton({click_function="ConfirmMoveNo",function_owner=Global,label="NO",position={0.5,0.2,0.4},scale={0.5,0.5,0.5},color={1,1,1,0.8},width=900,height=500,font_size=250,font_color={0,0,0},tooltip="NO: Do not move the Rebel Base here."})
end--function 
	
function ConfirmMoveYes(CardObj)
    PlaySound({ID=math.random(36,37)})
	--remove card from ProbeCards list...
	for C=1,#ProbeCards do 
		if CardObj == ProbeCards[C] then
			ProbeCards[C] = nil
			break
		end--if
	end--for C
	RevealRebelBase()
	--Give Old base card to Imperial Player... 
	local OldCard = ScanForObject({Description="ProbeCard;",Origin={-23.4,0.5,7.5},Orientation={0,0,0},Size={1,1,1},Debug=false,Type=2})
	printToAll("Rebels have established a new secret base!",{1,1,0})
	if OldCard != nil then
		OldCard.setRotationSmooth(Hands.ImperialProbe.Rotation,false,false)
		OldCard.setPositionSmooth(Hands.ImperialProbe.DrawSpot,false,false)
		printToAll("The Probe Card for the old Base Location ("..OldCard.getName()..") was given to the Imperial Player.")
	end--if
 	--place new base probe card face down next to base space...
	CardObj.setRotation({0,270,180})
	CardObj.setPositionSmooth({-23.42,0.61,7.45},false,false)
	--shuffle remaining cards to the bottom of the probe deck... 
	DoneRapidMobilization()
end--function 

function ConfirmMoveNo(CardObj)
	CardObj.clearButtons()
	CardObj.createButton({click_function="NA",function_owner=Global,label="Hidden",position={0.95,0.2,-0.5},rotation={0,270,0},width=0,height=0,font_size=150,font_color={1,1,1,0.7}})
	--Must have No Imperial Loyalty, No Imperial Units, and not Destroyed... 
	if GetLoyalty({System=CardObj.getName()}) == "Imperial" then
		CardObj.createButton({click_function="ConfirmMoveNo",function_owner=Global,label="Imperial\nLoyalty",position={0,0.2,0},scale={0.5,0.5,0.5},color={1,0,0,0.8},width=2000,height=2800,font_size=400,font_color={0,0,0}})
	elseif GetUnitCount({Location=CardObj.getName(),Faction="Imperial"}) > 0 then
		CardObj.createButton({click_function="ConfirmMoveNo",function_owner=Global,label="Imperial\nUnits\nDetected",position={0,0.2,0},scale={0.5,0.5,0.5},color={1,0,0,0.8},width=2000,height=2800,font_size=400,font_color={0,0,0}})
	elseif Locations[CardObj.getName()].Destroyed then
		CardObj.createButton({click_function="ConfirmMoveNo",function_owner=Global,label="System\nDestroyed",position={0,0.2,0},scale={0.5,0.5,0.5},color={1,0,0,0.8},width=2000,height=2800,font_size=400,font_color={0,0,0}})
	else
		CardObj.createButton({click_function="EstablishNewBase",function_owner=Global,label="Move Base To:\n"..CardObj.getName(),position={0,0.2,0},scale={0.5,0.5,0.5},color={1,1,1,0.8},width=1800,height=800,font_size=200,font_color={0,0,0},tooltip="Move the Rebel Base to: "..CardObj.getName().."."})
	end--if
end--function 

function ResolveImmediateObjective()
  --prompt rebel player to resolve the drawn immediate objective...
  RebelPanel.clearButtons()
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="IMMEDIATE OBJECTIVE",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="IMMEDIATE OBJECTIVE",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="You've drawn an Immediate Objective\nResolve it before continuing.",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  RebelPanel.createButton({click_function="DoneImmediateObjective",function_owner=Global,label="Continue (Card is Resolved)",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Finished Resolving Rapid Mobilization."})
  function DoneImmediateObjective()
    RebelPanel.clearButtons()
    Step = ""
  end--function
end--function

function RefreshPlayObjective()
  --prompt rebel player to play an objective if possible...
  RebelPanel.clearButtons()
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL OBJECTIVE",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL OBJECTIVE",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Can Rebels Play one of their Objectives?",position={0,0.1,-0.45},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  RebelPanel.createButton({click_function="ContinueRetrieveLeaders",function_owner=Global,label="Continue Refresh Phase",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Continue the Refresh Phase..."})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Level I",position={-0.85,0.1,-0.3},scale={0.25,0.25,0.25},width=0,height=0,font_size=150,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Level II",position={0,0.1,-0.3},scale={0.25,0.25,0.25},width=0,height=0,font_size=150,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Level III",position={0.85,0.1,-0.3},scale={0.25,0.25,0.25},width=0,height=0,font_size=150,font_color={1,1,1}})
  ImperialPanel.clearButtons()
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="REBEL OBJECTIVE",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="REBEL OBJECTIVE",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="IMPERIAL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Rebel Player is checking their Objectives...",position={0,0.1,-0.45},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Level I",position={-0.85,0.1,-0.3},scale={0.25,0.25,0.25},width=0,height=0,font_size=150,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Level II",position={0,0.1,-0.3},scale={0.25,0.25,0.25},width=0,height=0,font_size=150,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Level III",position={0.85,0.1,-0.3},scale={0.25,0.25,0.25},width=0,height=0,font_size=150,font_color={1,1,1}})
  UpdateBoard(false)
  ObjectivesList = {}
  --LEVEL I-------------------
  ObjectivesList["Cut Supply Lines"]={Label="",Color={1,0,0},Button="ObjectivePingCutSupplyLines",Level=1,Box="Core",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Defend the People"]={Label="",Color={1,0,0},Button="ObjectivePingDefendThePeople",Level=1,Box="Core",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Defensive Position"]={Label="",Color={1,0,0},Button="ObjectivePingDefensivePosition",Level=1,Box="RotE",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Gather the Fleet"]={Label="",Color={1,0,0},Button="ObjectivePingGatherTheFleet",Level=1,Box="WFL",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Regional Support"]={Label="",Color={1,0,0},Button="ObjectivePingRegionalSupport",Level=1,Box="Core",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Support of the Hutts"]={Label="",Color={1,0,0},Button="ObjectivePingSupportOfTheHutts",Level=1,Box="RotE",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Threaten the Core"]={Label="",Color={1,0,0},Button="ObjectivePingThreatenTheCore",Level=1,Box="RotE",Count=0,PingList={},ToolTip=""}
  --LEVEL II------------------
  ObjectivesList["A Time for Peace"]={Label="",Color={1,0,0},Button="ObjectivePingATimeForPeace",Level=2,Box="RotE",Count=0,PingList={},ToolTip="xxxx"}
  ObjectivesList["Heart of the Empire"]={Label="",Color={1,0,0},Button="ObjectivePingHeartOfTheEmpire",Level=2,Box="Core",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Leave No One Behind"]={Label="",Color={1,0,0},Button="ObjectivePingLeaveNoOneBehind",Level=2,Box="Core",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Popular Support"]={Label="",Color={1,0,0},Button="ObjectivePingPopularSupport",Level=2,Box="Core",Count=0,PingList={},ToolTip=""}
  --LEVEL III-----------------
  ObjectivesList["Establish Outposts"]={Label="",Color={1,0,0},Button="ObjectivePingEstablishOutposts",Level=3,Box="RotE",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Inspire Sympathy"]={Label="",Color={1,0,0},Button="ObjectivePingInspireSympathy",Level=3,Box="Core",Count=0,PingList={},ToolTip=""}
  ObjectivesList["Uprising"]={Label="",Color={1,0,0},Button="ObjectivePingUprising",Level=3,Box="Core",Count=0,PingList={},ToolTip=""}
  --analyze objectives by system/location... 
  for L,Location in pairs(Locations) do 
    --if system... 
    if Location.Type == "System" then
      if Location.Units.Rebel.Structures >= 3 then
        if ObjectivesList["Defensive Position"].Count < Location.Units.Rebel.Structures then
          ObjectivesList["Defensive Position"].Count = Location.Units.Rebel.Structures
        end--if new highest value.
        ObjectivesList["Defensive Position"].ToolTip = ObjectivesList["Defensive Position"].ToolTip..L.."\n"
        table.insert(ObjectivesList["Defensive Position"].PingList,Location.MarkerSpot)
      end--if defensive position
      if Location.Units.Rebel.Space + Location.Units.Rebel.Ground > 0 then
        ObjectivesList["Establish Outposts"].Count = ObjectivesList["Establish Outposts"].Count + 1
        ObjectivesList["Establish Outposts"].ToolTip = ObjectivesList["Establish Outposts"].ToolTip..L.."\n"
        table.insert(ObjectivesList["Establish Outposts"].PingList,Location.MarkerSpot)
      end--if establish outposts. 
      if Location.Destroyed then
        ObjectivesList["Inspire Sympathy"].Count = ObjectivesList["Inspire Sympathy"].Count + 1
        ObjectivesList["Inspire Sympathy"].ToolTip = ObjectivesList["Inspire Sympathy"].ToolTip..L.."\n"
        table.insert(ObjectivesList["Inspire Sympathy"].PingList,Location.MarkerSpot)
      end--if
      if Location.Loyalty == "Rebel" then
        ObjectivesList["Popular Support"].Count = ObjectivesList["Popular Support"].Count + 1
        ObjectivesList["Popular Support"].ToolTip = ObjectivesList["Popular Support"].ToolTip..L.."\n"
        table.insert(ObjectivesList["Popular Support"].PingList,Location.MarkerSpot)
        ObjectivesList["Uprising"].Count = ObjectivesList["Uprising"].Count + 1
        ObjectivesList["Uprising"].ToolTip = ObjectivesList["Uprising"].ToolTip..L.."\n"
        table.insert(ObjectivesList["Uprising"].PingList,Location.MarkerSpot)
        if Location.Units.Rebel.Space + Location.Units.Rebel.Ground > 0 then
          ObjectivesList["Defend the People"].Count = ObjectivesList["Defend the People"].Count + 1
          ObjectivesList["Defend the People"].ToolTip = ObjectivesList["Defend the People"].ToolTip..L.."\n"
          table.insert(ObjectivesList["Defend the People"].PingList,Location.MarkerSpot)
        end--if defend the peoples?
        if Location.Region == 5 then
          ObjectivesList["Support of the Hutts"].Count = ObjectivesList["Support of the Hutts"].Count + 1
          ObjectivesList["Support of the Hutts"].ToolTip = ObjectivesList["Support of the Hutts"].ToolTip..L.."\n"
          table.insert(ObjectivesList["Support of the Hutts"].PingList,Location.MarkerSpot)
        end--if nal hutta region
      end--if
      if (Location.Loyalty == "Imperial" or Location.Subjugated) and not Location.Destroyed and (Location.Sabotaged or Location.Units.Rebel.Space+Location.Units.Rebel.Ground > 0) then
        ObjectivesList["Cut Supply Lines"].Count = ObjectivesList["Cut Supply Lines"].Count + 1
        ObjectivesList["Cut Supply Lines"].ToolTip = ObjectivesList["Cut Supply Lines"].ToolTip..L.."\n"
        table.insert(ObjectivesList["Cut Supply Lines"].PingList,Location.MarkerSpot)
      end--if
      if Game.Flags.WFL and Location.Units.Rebel.Space > 0 then
          local ShipTypes = {XW=0,YW=0,GR75=0,UW=0,AW=0,BW=0,LF=0,CC=0,HC=0,NBF=0,EC=0,MCC=0,MC75=0,MC80=0}
          for O,Obj in pairs(getAllObjects()) do 
            if Obj.getVar("Component") == "Unit" then
              if Obj.getVar("Faction") == "Rebel" then
                if Obj.getVar("Location") == L then
                  if Obj.getName() == "X-Wing" then ShipTypes.XW = 1
                  elseif Obj.getName() == "Y-Wing" then ShipTypes.YW = 1
                  elseif Obj.getName() == "U-Wing" then ShipTypes.UW = 1
                  elseif Obj.getName() == "A-Wing" then ShipTypes.AW = 1
                  elseif Obj.getName() == "B-Wing" then ShipTypes.BW = 1
                  elseif Obj.getName() == "Rebel Transport" then ShipTypes.GR75 = 1
                  elseif Obj.getName() == "Light Freighter" then ShipTypes.LF = 1
                  elseif Obj.getName() == "Corellian Corvette" then ShipTypes.CC = 1
                  elseif Obj.getName() == "Hammerhead Corvette" then ShipTypes.HC = 1
                  elseif Obj.getName() == "Nebulon-B Frigate" then ShipTypes.NBF = 1
                  elseif Obj.getName() == "Escort Carrier" then ShipTypes.EC = 1
                  elseif Obj.getName() == "Mon Cala Cruiser" then ShipTypes.MCC = 1
                  elseif Obj.getName() == "MC75 Cruiser" then ShipTypes.MC75 = 1
                  elseif Obj.getName() == "MC80 Cruiser" then ShipTypes.MC80 = 1
                  end--if shiptype
                end--if location
              end--if rebel
            end--if unit
          end--for O,Obj 
          --if this system has more ships than any other so far... 
          if ObjectivesList["Gather the Fleet"].Count < ShipTypes.XW + ShipTypes.YW + ShipTypes.UW + ShipTypes.AW + ShipTypes.BW + ShipTypes.GR75 + ShipTypes.LF + ShipTypes.CC + ShipTypes.HC + ShipTypes.NBF + ShipTypes.EC + ShipTypes.MCC + ShipTypes.MC75 + ShipTypes.MC80 then
            ObjectivesList["Gather the Fleet"].Count = ShipTypes.XW + ShipTypes.YW + ShipTypes.UW + ShipTypes.AW + ShipTypes.BW + ShipTypes.GR75 + ShipTypes.LF + ShipTypes.CC + ShipTypes.HC + ShipTypes.NBF + ShipTypes.EC + ShipTypes.MCC + ShipTypes.MC75 + ShipTypes.MC80
          end--if
          --if there are 10 or more unique rebel ships and atleast 1 of them is a square ship...
          if ShipTypes.XW + ShipTypes.YW + ShipTypes.UW + ShipTypes.AW + ShipTypes.BW + ShipTypes.GR75 + ShipTypes.LF + ShipTypes.CC + ShipTypes.HC + ShipTypes.NBF + ShipTypes.EC + ShipTypes.MCC + ShipTypes.MC75 + ShipTypes.MC80 >= 10 then
            if ShipTypes.MCC + ShipTypes.MC75 + ShipTypes.MC80 > 0 then
              ObjectivesList["Gather the Fleet"].ToolTip = ObjectivesList["Gather the Fleet"].ToolTip..L.." has "..ObjectivesList["Gather the Fleet"].Count.." unique Rebel Ships and at least 1 is a ■ Ship.\n"
              table.insert(ObjectivesList["Gather the Fleet"].PingList,Location.MarkerSpot)
            else 
              ObjectivesList["Gather the Fleet"].ToolTip = ObjectivesList["Gather the Fleet"].ToolTip..L.." has "..ObjectivesList["Gather the Fleet"].Count.." unique Rebel Ships, but does not have at least 1 ■ Ship.\n"
              ObjectivesList["Gather the Fleet"].Count = 9
            end--if
          end--if
      end--if WFL and 10 rebel space units in a system. 
    end--if system
  end--for L,Location 
  --regional support?
  if Locations["MYGEETO"].Loyalty == "Rebel" and Locations["ORD MANTELL"].Loyalty == "Rebel" then 
    ObjectivesList["Regional Support"].Count = ObjectivesList["Regional Support"].Count + 1
    ObjectivesList["Regional Support"].ToolTip = ObjectivesList["Regional Support"].ToolTip.."All Systems in the Mygeeto Region have Rebel Loyalty.\n"
    table.insert(ObjectivesList["Regional Support"].PingList,Locations["MYGEETO"].MarkerSpot)
  end--if
  if Locations["KASHYYYK"].Loyalty == "Rebel" and Locations["MANDALORE"].Loyalty == "Rebel" and Locations["MALASTARE"].Loyalty == "Rebel" then
    ObjectivesList["Regional Support"].Count = ObjectivesList["Regional Support"].Count + 1
    ObjectivesList["Regional Support"].ToolTip = ObjectivesList["Regional Support"].ToolTip.."All Systems in the Kashyyyk Region have Rebel Loyalty.\n"
    table.insert(ObjectivesList["Regional Support"].PingList,Locations["KASHYYYK"].MarkerSpot)
  end--if
  if Locations["MON CALAMARI"].Loyalty == "Rebel" and Locations["SALEUCAMI"].Loyalty == "Rebel" and Locations["FELUCIA"].Loyalty == "Rebel" then
    ObjectivesList["Regional Support"].Count = ObjectivesList["Regional Support"].Count + 1
    ObjectivesList["Regional Support"].ToolTip = ObjectivesList["Regional Support"].ToolTip.."All Systems in the Mon Calamari Region have Rebel Loyalty.\n"
    table.insert(ObjectivesList["Regional Support"].PingList,Locations["MON CALAMARI"].MarkerSpot)
  end--if
  if Locations["KESSEL"].Loyalty == "Rebel" and Locations["NAL HUTTA"].Loyalty == "Rebel" and Locations["TOYDARIA"].Loyalty == "Rebel" and Locations["BOTHAWUI"].Loyalty == "Rebel" then
    ObjectivesList["Regional Support"].Count = ObjectivesList["Regional Support"].Count + 1
    ObjectivesList["Regional Support"].ToolTip = ObjectivesList["Regional Support"].ToolTip.."All Systems in the Nal Hutta Region have Rebel Loyalty.\n"
    table.insert(ObjectivesList["Regional Support"].PingList,Locations["NAL HUTTA"].MarkerSpot)
  end--if
  if Locations["RODIA"].Loyalty == "Rebel" and Locations["GEONOSIS"].Loyalty == "Rebel" and Locations["RYLOTH"].Loyalty == "Rebel" then
    ObjectivesList["Regional Support"].Count = ObjectivesList["Regional Support"].Count + 1
    ObjectivesList["Regional Support"].ToolTip = ObjectivesList["Regional Support"].ToolTip.."All Systems in the Geonosis Region have Rebel Loyalty.\n"
    table.insert(ObjectivesList["Regional Support"].PingList,Locations["GEONOSIS"].MarkerSpot)
  end--if
  if Locations["SULLUST"].Loyalty == "Rebel" and Locations["NABOO"].Loyalty == "Rebel" and Locations["UTAPAU"].Loyalty == "Rebel" then
    ObjectivesList["Regional Support"].Count = ObjectivesList["Regional Support"].Count + 1
    ObjectivesList["Regional Support"].ToolTip = ObjectivesList["Regional Support"].ToolTip.."All Systems in the Naboo Region have Rebel Loyalty.\n"
    table.insert(ObjectivesList["Regional Support"].PingList,Locations["NABOO"].MarkerSpot)
  end--if
  if Locations["BESPIN"].Loyalty == "Rebel" and Locations["MUSTAFAR"].Loyalty == "Rebel" then
    ObjectivesList["Regional Support"].Count = ObjectivesList["Regional Support"].Count + 1
    ObjectivesList["Regional Support"].ToolTip = ObjectivesList["Regional Support"].ToolTip.."All Systems in the Bespin Region have Rebel Loyalty.\n"
    table.insert(ObjectivesList["Regional Support"].PingList,Locations["BESPIN"].MarkerSpot)
  end--if
  --inventory units in play...
  for O,Obj in pairs(getAllObjects()) do 
    if Obj.getVar("Component") == "Leader" then
      if Obj.getVar("Faction") == "Rebel" and Obj.getVar("Captured") then
        ObjectivesList["Leave No One Behind"].Count = ObjectivesList["Leave No One Behind"].Count + 1
        ObjectivesList["Leave No One Behind"].ToolTip = ObjectivesList["Leave No One Behind"].ToolTip..Obj.getName().." is captured.\n"
        table.insert(ObjectivesList["Leave No One Behind"].PingList,Obj.getPosition())
      end--if
    elseif Obj.getVar("Component") == "Unit" then
      if Obj.getVar("Faction") == "Rebel" then
        if Obj.getVar("Location") == "ORD MANTELL" or Obj.getVar("Location") == "ALDERAAN" or Obj.getVar("Location") == "CORELLIA" or Obj.getVar("Location") == "CORUSCANT" then
          ObjectivesList["Threaten the Core"].Count = ObjectivesList["Threaten the Core"].Count + 1
          table.insert(ObjectivesList["Threaten the Core"].PingList,Obj.getPosition())
        elseif Obj.getVar("Location") == "REBEL QUEUE 1" or Obj.getVar("Location") == "REBEL QUEUE 2" or Obj.getVar("Location") == "REBEL QUEUE 3" then
          if (Units[Obj.getName()].Build == "OS" or Units[Obj.getName()].Build == "BS") and string.sub(ObjectivesList["A Time for Peace"].ToolTip,4,4) != "■" then
            ObjectivesList["A Time for Peace"].ToolTip = string.sub(ObjectivesList["A Time for Peace"].ToolTip,1,3).."■"
            ObjectivesList["A Time for Peace"].Count = ObjectivesList["A Time for Peace"].Count + 1
            table.insert(ObjectivesList["A Time for Peace"].PingList,Obj.getPosition())
          elseif (Units[Obj.getName()].Build == "OC" or Units[Obj.getName()].Build == "BC") and string.sub(ObjectivesList["A Time for Peace"].ToolTip,3,3) != "⬤" then
            ObjectivesList["A Time for Peace"].ToolTip = string.sub(ObjectivesList["A Time for Peace"].ToolTip,1,2).."⬤"..string.sub(ObjectivesList["A Time for Peace"].ToolTip,4,4)
            ObjectivesList["A Time for Peace"].Count = ObjectivesList["A Time for Peace"].Count + 1
            table.insert(ObjectivesList["A Time for Peace"].PingList,Obj.getPosition())
          elseif (Units[Obj.getName()].Build == "OT" or Units[Obj.getName()].Build == "BT") and string.sub(ObjectivesList["A Time for Peace"].ToolTip,1,1) != "▲" then
            ObjectivesList["A Time for Peace"].ToolTip = "▲"..string.sub(ObjectivesList["A Time for Peace"].ToolTip,2,4)
            ObjectivesList["A Time for Peace"].Count = ObjectivesList["A Time for Peace"].Count + 1
            table.insert(ObjectivesList["A Time for Peace"].PingList,Obj.getPosition())
          elseif (Units[Obj.getName()].Build == "OT" or Units[Obj.getName()].Build == "BT") and string.sub(ObjectivesList["A Time for Peace"].ToolTip,2,2) != "▲" then
            ObjectivesList["A Time for Peace"].ToolTip = string.sub(ObjectivesList["A Time for Peace"].ToolTip,1,1).."▲"..string.sub(ObjectivesList["A Time for Peace"].ToolTip,3,4)
            ObjectivesList["A Time for Peace"].Count = ObjectivesList["A Time for Peace"].Count + 1
            table.insert(ObjectivesList["A Time for Peace"].PingList,Obj.getPosition())
          end--if
        end--if
      end--if rebel
    end--if unit
  end--for O,Obj
  --CUT SUPPLY LINES
  if ObjectivesList["Cut Supply Lines"].Count >= 3 then
    ObjectivesList["Cut Supply Lines"].Label = "Cut Supply Lines: Yes ("..ObjectivesList["Cut Supply Lines"].Count.."/3)"
    ObjectivesList["Cut Supply Lines"].Color={0.5,1,0.5}--green
    ObjectivesList["Cut Supply Lines"].ToolTip = "Rebel Player can play Cut Supply Lines:\n"..ObjectivesList["Cut Supply Lines"].ToolTip
  else
    ObjectivesList["Cut Supply Lines"].Label = "Cut Supply Lines: No ("..ObjectivesList["Cut Supply Lines"].Count.."/3)"
    ObjectivesList["Cut Supply Lines"].ToolTip = "Rebel Player cannot play Cut Supply Lines:\nNot enough Sabotaged/Blockaded Systems.\n"..ObjectivesList["Cut Supply Lines"].ToolTip
  end--if cut supply lines
  --DEFEND THE PEOPLE
  if ObjectivesList["Defend the People"].Count >= 4 then
    ObjectivesList["Defend the People"].Label = "Defend the People: Yes ("..ObjectivesList["Defend the People"].Count.."/4)"
    ObjectivesList["Defend the People"].Color={0.5,1,0.5}--green
    ObjectivesList["Defend the People"].ToolTip = "Rebel Player can play Defend the People:\n"..ObjectivesList["Defend the People"].ToolTip
  else
    ObjectivesList["Defend the People"].Label = "Defend the People: No ("..ObjectivesList["Defend the People"].Count.."/4)"
    ObjectivesList["Defend the People"].ToolTip = "Rebel Player cannot play Defend the People:\nNot enough Systems with Rebel units.\n"..ObjectivesList["Defend the People"].ToolTip
  end--if defend the people
  --DEFENSIVE POSITION
  if ObjectivesList["Defensive Position"].Count >= 3 then
    ObjectivesList["Defensive Position"].Label = "Defensive Position: Yes ("..ObjectivesList["Defensive Position"].Count.."/3)"
    ObjectivesList["Defensive Position"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Defensive Position"].Label = "Defensive Position: No ("..ObjectivesList["Defensive Position"].Count.."/3)"
  end--if Defensive Position
  --GATHER THE FLEET
  if ObjectivesList["Gather the Fleet"].Count >= 10 then
    ObjectivesList["Gather the Fleet"].Label = "Gather the Fleet: Yes ("..ObjectivesList["Gather the Fleet"].Count.."/10)"
    ObjectivesList["Gather the Fleet"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Gather the Fleet"].Label = "Gather the Fleet: No ("..ObjectivesList["Gather the Fleet"].Count.."/10)"
  end--if gather the fleet
  --REGIONAL SUPPORT
  if ObjectivesList["Regional Support"].Count >= 1 then
    ObjectivesList["Regional Support"].Label = "Regional Support: Yes ("..ObjectivesList["Regional Support"].Count..")"
    ObjectivesList["Regional Support"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Regional Support"].Label = "Regional Support: No ("..ObjectivesList["Regional Support"].Count..")"
  end--if Regional Support
  --SUPPORT OF THE HUTTS
  if ObjectivesList["Support of the Hutts"].Count >= 3 then
    ObjectivesList["Support of the Hutts"].Label = "Support of the Hutts: Yes ("..ObjectivesList["Support of the Hutts"].Count.."/3)"
    ObjectivesList["Support of the Hutts"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Support of the Hutts"].Label = "Support of the Hutts: No ("..ObjectivesList["Support of the Hutts"].Count.."/3)"
  end--if Support of the Hutts
  --THREATEN THE CORE
  if ObjectivesList["Threaten the Core"].Count >= 5 then
    ObjectivesList["Threaten the Core"].Label = "Threaten the Core: Yes ("..ObjectivesList["Threaten the Core"].Count.."/5)"
    ObjectivesList["Threaten the Core"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Threaten the Core"].Label = "Threaten the Core: No ("..ObjectivesList["Threaten the Core"].Count.."/5)"
  end--if Threaten the Core
  ObjectivesList["Threaten the Core"].ToolTip = "There are "..ObjectivesList["Threaten the Core"].Count.." Rebel Units in/adjacent to Coruscant."
  --A TIME FOR PEACE
  if ObjectivesList["A Time for Peace"].Count >= 4 then
    ObjectivesList["A Time for Peace"].Label = "A Time for Peace: Yes ("..ObjectivesList["A Time for Peace"].Count.."/4)"
    ObjectivesList["A Time for Peace"].Color={0.5,1,0.5}--green
    ObjectivesList["A Time for Peace"].ToolTip = "There are 2 ▲, 1 ●, and 1 ■ units on the Rebel Queue that can be destroyed."
  else
    ObjectivesList["A Time for Peace"].Label = "A Time for Peace: No ("..ObjectivesList["A Time for Peace"].Count.."/4)"
    ObjectivesList["A Time for Peace"].ToolTip = "There must be at least 2 ▲, 1 ●, and 1 ■ units on the Rebel Queue that can be destroyed."
  end--if A Time for Peace
  --HEART OF THE EMPIRE
  if Locations["CORUSCANT"].Units.Imperial.Space+Locations["CORUSCANT"].Units.Imperial.Ground <= 0 and Locations["CORUSCANT"].Units.Rebel.Space+Locations["CORUSCANT"].Units.Rebel.Ground > 0 then
    ObjectivesList["Heart of the Empire"].Label = "Heart of the Empire: Yes ("..(Locations["CORUSCANT"].Units.Rebel.Space+Locations["CORUSCANT"].Units.Rebel.Ground).." vs 0)"
    ObjectivesList["Heart of the Empire"].Color={0.5,1,0.5}--green
    ObjectivesList["Heart of the Empire"].Count = 1
    ObjectivesList["Heart of the Empire"].PingList={{2.58,0.8,-9.65}}
  else
    ObjectivesList["Heart of the Empire"].Label = "Threaten the Core: No ("..(Locations["CORUSCANT"].Units.Rebel.Space+Locations["CORUSCANT"].Units.Rebel.Ground).." vs "..(Locations["CORUSCANT"].Units.Imperial.Space+Locations["CORUSCANT"].Units.Imperial.Ground)..")"
    ObjectivesList["Heart of the Empire"].Count = 0
  end--if Threaten the Core
  ObjectivesList["Heart of the Empire"].ToolTip = "Coruscant has "..(Locations["CORUSCANT"].Units.Rebel.Space+Locations["CORUSCANT"].Units.Rebel.Ground).." Rebel Units vs "..(Locations["CORUSCANT"].Units.Imperial.Space+Locations["CORUSCANT"].Units.Imperial.Ground).." Imperial Units."
  --LEAVE NO ONE BEHIND
  if ObjectivesList["Leave No One Behind"].Count <= 0 then
    ObjectivesList["Leave No One Behind"].Label = "Leave No One Behind: Yes (0)"
    ObjectivesList["Leave No One Behind"].Color={0.5,1,0.5}--green
    ObjectivesList["Leave No One Behind"].ToolTip = "There are no captured Rebel Leaders."
  else
    ObjectivesList["Leave No One Behind"].Label = "Leave No One Behind: No ("..ObjectivesList["Leave No One Behind"].Count..")"
    ObjectivesList["Leave No One Behind"].ToolTip = "There are Captured Rebel Leaders:\n"..ObjectivesList["Leave No One Behind"].ToolTip
  end--if Leave No One Behind
  --POPULAR SUPPORT
  if ObjectivesList["Popular Support"].Count >= 6 then
    ObjectivesList["Popular Support"].Label = "Popular Support: Yes ("..ObjectivesList["Popular Support"].Count.."/6)"
    ObjectivesList["Popular Support"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Popular Support"].Label = "Popular Support: No ("..ObjectivesList["Popular Support"].Count.."/6)"
  end--if popular support
  --ESTABLISH OUTPOSTS
  if ObjectivesList["Establish Outposts"].Count >= 5 then
    ObjectivesList["Establish Outposts"].Label = "Establish Outposts: Yes ("..ObjectivesList["Establish Outposts"].Count.."/5)"
    ObjectivesList["Establish Outposts"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Establish Outposts"].Label = "Establish Outposts: No ("..ObjectivesList["Establish Outposts"].Count.."/5)"
  end--if Establish Outposts
  --INSPIRE SYMPATHY
  if ObjectivesList["Inspire Sympathy"].Count > 0 then
    ObjectivesList["Inspire Sympathy"].Label = "Inspire Sympathy: Yes ("..ObjectivesList["Inspire Sympathy"].Count..")"
    ObjectivesList["Inspire Sympathy"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Inspire Sympathy"].Label = "Inspire Sympathy: No (0)"
  end--if Inspire Sympathy
  --UPRISING
  if ObjectivesList["Uprising"].Count >= 9 then
    ObjectivesList["Uprising"].Label = "Uprising: Yes ("..ObjectivesList["Uprising"].Count.."/9)"
    ObjectivesList["Uprising"].Color={0.5,1,0.5}--green
  else
    ObjectivesList["Uprising"].Label = "Uprising: No ("..ObjectivesList["Uprising"].Count.."/9)"
  end--if popular support
  --display objectives on the panels...
  local Z1 = -0.2
  local Z2 = -0.2
  local Z3 = -0.2
  for I,Item in pairs(ObjectivesList) do 
    if Item.Box == "Core" or (Game.Flags.RotE and Item.Box == "RotE") or (Game.Flags.WFL and Item.Box == "WFL") then 
      if Item.Level == 1 then
        RebelPanel.createButton({click_function=Item.Button,function_owner=Global,label=Item.Label,position={-0.85,0.1,Z1},scale={0.25,0.25,0.25},color=Item.Color,width=1600,height=200,font_size=100,font_color={0,0,0},tooltip=Item.ToolTip})
        ImperialPanel.createButton({click_function=Item.Button,function_owner=Global,label=Item.Label,position={-0.85,0.1,Z1},scale={0.25,0.25,0.25},color=Item.Color,width=1600,height=200,font_size=100,font_color={0,0,0},tooltip=Item.ToolTip})
        Z1 = Z1 + 0.1
      elseif Item.Level == 2 then
        RebelPanel.createButton({click_function=Item.Button,function_owner=Global,label=Item.Label,position={0,0.1,Z2},scale={0.25,0.25,0.25},color=Item.Color,width=1600,height=200,font_size=100,font_color={0,0,0},tooltip=Item.ToolTip})
        ImperialPanel.createButton({click_function=Item.Button,function_owner=Global,label=Item.Label,position={0,0.1,Z2},scale={0.25,0.25,0.25},color=Item.Color,width=1600,height=200,font_size=100,font_color={0,0,0},tooltip=Item.ToolTip})
        Z2 = Z2 + 0.1
      elseif Item.Level == 3 then
        RebelPanel.createButton({click_function=Item.Button,function_owner=Global,label=Item.Label,position={0.85,0.1,Z3},scale={0.25,0.25,0.25},color=Item.Color,width=1600,height=200,font_size=100,font_color={0,0,0},tooltip=Item.ToolTip})
        ImperialPanel.createButton({click_function=Item.Button,function_owner=Global,label=Item.Label,position={0.85,0.1,Z3},scale={0.25,0.25,0.25},color=Item.Color,width=1600,height=200,font_size=100,font_color={0,0,0},tooltip=Item.ToolTip})
        Z3 = Z3 + 0.1
      end--if
    end--if
  end--for I,Item 
  function ContinueRetrieveLeaders()
    RebelPanel.clearButtons()
    NextStep = "RefreshPhase.I.RetrieveLeaders"
    Step = ""
  end--function
end--function

function ObjectivePingCutSupplyLines() 
  if ObjectivesList["Cut Supply Lines"].Count < 3 then
    printToAll("Rebels cannot play the Objective: Cut Supply Lines.")
  else 
    printToAll("Rebels can play the Objective: Cut Supply Lines (if they have it).")
    for P=1,#ObjectivesList["Cut Supply Lines"].PingList do 
      Ping({Position=ObjectivesList["Cut Supply Lines"].PingList[P]}) 
    end--for P
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingDefendThePeople()   
  if ObjectivesList["Defend the People"].Count < 4 then
    printToAll("Rebels cannot play the Objective: Defend the People.")
  else 
    printToAll("Rebels can play the Objective: Defend the People (if they have it).")
    for P=1,#ObjectivesList["Defend the People"].PingList do 
      Ping({Position=ObjectivesList["Defend the People"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingDefensivePosition() 
  if ObjectivesList["Defensive Position"].Count < 3 then
    printToAll("Rebels cannot play the Objective: Defensive Position.")
  else 
    printToAll("Rebels can play the Objective: Defensive Position (if they have it).")
    for P=1,#ObjectivesList["Defensive Position"].PingList do 
      Ping({Position=ObjectivesList["Defensive Position"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingGatherTheFleet() 
  if ObjectivesList["Gather the Fleet"].Count < 10 then
    printToAll("Rebels cannot play the Objective: Gather the Fleet.")
  else 
    printToAll("Rebels can play the Objective: Gather the Fleet (if they have it).")
    for P=1,#ObjectivesList["Gather the Fleet"].PingList do 
      Ping({Position=ObjectivesList["Gather the Fleet"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingRegionalSupport() 
  if ObjectivesList["Regional Support"].Count < 1 then
    printToAll("Rebels cannot play the Objective: Regional Support.")
  else 
    printToAll("Rebels can play the Objective: Regional Support (if they have it).")
    for P=1,#ObjectivesList["Regional Support"].PingList do 
      Ping({Position=ObjectivesList["Regional Support"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingSupportOfTheHutts()
  if ObjectivesList["Support of the Hutts"].Count < 3 then
    printToAll("Rebels cannot play the Objective: Support of the Hutts.")
  else 
    printToAll("Rebels can play the Objective: Support of the Hutts (if they have it).")
    for P=1,#ObjectivesList["Support of the Hutts"].PingList do 
      Ping({Position=ObjectivesList["Support of the Hutts"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingThreatenTheCore()
  if ObjectivesList["Threaten the Core"].Count < 5 then
    printToAll("Rebels cannot play the Objective: Threaten the Core.")
  else 
    printToAll("Rebels can play the Objective: Threaten the Core (if they have it).")
    for P=1,#ObjectivesList["Threaten the Core"].PingList do 
      Ping({Position=ObjectivesList["Threaten the Core"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingATimeForPeace() 
  if ObjectivesList["A Time for Peace"].Count < 4 then
    printToAll("Rebels cannot play the Objective: A Time for Peace.")
  else 
    printToAll("Rebels can play the Objective: A Time for Peace (if they have it).")
    for P=1,#ObjectivesList["A Time for Peace"].PingList do 
      Ping({Position=ObjectivesList["A Time for Peace"].PingList[P]})
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingHeartOfTheEmpire()
  if ObjectivesList["Heart of the Empire"].Count < 1 then
    printToAll("Rebels cannot play the Objective: Heart of the Empire.")
  else 
    printToAll("Rebels can play the Objective: Heart of the Empire (if they have it).")
    for P=1,#ObjectivesList["Heart of the Empire"].PingList do 
      Ping({Position=ObjectivesList["Heart of the Empire"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingLeaveNoOneBehind() 
  if ObjectivesList["Leave No One Behind"].Count > 0 then
    printToAll("Rebels cannot play the Objective: Leave No One Behind.")
  else 
    printToAll("Rebels can play the Objective: Leave No One Behind (if they have it).")
    for P=1,#ObjectivesList["Leave No One Behind"].PingList do 
      Ping({Position=ObjectivesList["Leave No One Behind"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingPopularSupport()
  if ObjectivesList["Popular Support"].Count < 6 then
    printToAll("Rebels cannot play the Objective: Popular Support.")
  else 
    printToAll("Rebels can play the Objective: Popular Support (if they have it).")
    for P=1,#ObjectivesList["Popular Support"].PingList do 
      Ping({Position=ObjectivesList["Popular Support"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingEstablishOutposts()
  if ObjectivesList["Establish Outposts"].Count < 5 then
    printToAll("Rebels cannot play the Objective: Establish Outposts.")
  else 
    printToAll("Rebels can play the Objective: Establish Outposts (if they have it).")
    for P=1,#ObjectivesList["Establish Outposts"].PingList do 
      Ping({Position=ObjectivesList["Establish Outposts"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingInspireSympathy() 
  if ObjectivesList["Inspire Sympathy"].Count < 1 then
    printToAll("Rebels cannot play the Objective: Inspire Sympathy.")
  else 
    printToAll("Rebels can play the Objective: Inspire Sympathy (if they have it).")
    for P=1,#ObjectivesList["Inspire Sympathy"].PingList do 
      Ping({Position=ObjectivesList["Inspire Sympathy"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ObjectivePingUprising() 
  if ObjectivesList["Uprising"].Count < 9 then
    printToAll("Rebels cannot play the Objective: Uprising.")
  else 
    printToAll("Rebels can play the Objective: Uprising (if they have it).")
    for P=1,#ObjectivesList["Uprising"].PingList do 
      Ping({Position=ObjectivesList["Uprising"].PingList[P]}) 
    end--for
  end--if
  RefreshPlayObjective()
end--function 

function ChooseRebelLeaderActionCard()
	log("Start ChooseRebelLeaderActionCard()")
	RebelPanel.clearButtons()
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="RECRUITING LEADER",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="RECRUITING LEADER",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
	--RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL           PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="Recruit a Leader",position={0,0.1,-0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
	--has action card been selected?
	if #Game.Leaders.Draws.Rebel == 1 then
		--display buttons for recruit choices...
		--is there more than 1 choice of recruits still?
		if #Game.Leaders.Recruits.Rebel > 1 then
			RebelPanel.createButton({click_function="ChooseRebelRecruit1",function_owner=Global,label="Choose\n"..Game.Leaders.Recruits.Rebel[1],position={-0.3,0.1,0},scale={0.6,0.6,0.6},width=450,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Leader."})
			RebelPanel.createButton({click_function="ChooseRebelRecruit2",function_owner=Global,label="Choose\n"..Game.Leaders.Recruits.Rebel[2],position={0.3,0.1,0},scale={0.6,0.6,0.6},width=450,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Leader."})
			RebelPanel.createButton({click_function="NA",function_owner=Global,label="(Rebels choose first. Imperials choose which Leader on\nthe card to Recruit after Rebels have declared their choice).",position={0,0.1,0.4},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,1}})
		elseif #Game.Leaders.Recruits.Rebel == 1 then
			RebelPanel.createButton({click_function="ChooseRebelRecruit1",function_owner=Global,label="Choose\n"..Game.Leaders.Recruits.Rebel[1],position={0,0.1,0},scale={0.6,0.6,0.6},width=400,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Leader."})
		end--if
	else  --display buttons for card choices...
		--if we find any leader in the hidden zone... 
		local LeaderFound = false
		for O,Obj in pairs(getObjectFromGUID(IDs.Rebel.HiddenPanelZone).getObjects()) do
			if Obj.getVar("Component") == "Leader" then
				LeaderFound = true
				break
			end--if
		end--for O,Obj
		if LeaderFound then log("Leader found.") else log("Leader NOT found.") end--if
		RebelPanel.createButton({click_function="ChooseRebelActionCard1",function_owner=Global,label="Choose\nthis Card",position={-0.95,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		RebelPanel.createButton({click_function="ChooseRebelActionCard2",function_owner=Global,label="Choose\nthis Card",position={-0.57,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		if Game.Leaders.Draws.Rebel[3] != nil then
			RebelPanel.createButton({click_function="ChooseRebelActionCard3",function_owner=Global,label="Choose\nthis Card",position={-0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif not LeaderFound then
			RebelPanel.createButton({click_function="DrawRebelActionCard3",function_owner=Global,label="Draw\nAnother",position={-0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
		if Game.Leaders.Draws.Rebel[4] != nil then
			RebelPanel.createButton({click_function="ChooseRebelActionCard4",function_owner=Global,label="Choose\nthis Card",position={0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif Game.Leaders.Draws.Rebel[3] != nil and not LeaderFound then
			RebelPanel.createButton({click_function="DrawRebelActionCard4",function_owner=Global,label="Draw\nAnother",position={0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
		if Game.Leaders.Draws.Rebel[5] != nil then
			RebelPanel.createButton({click_function="ChooseRebelActionCard5",function_owner=Global,label="Choose\nthis Card",position={0.57,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif Game.Leaders.Draws.Rebel[4] != nil and not LeaderFound then
			RebelPanel.createButton({click_function="DrawRebelActionCard5",function_owner=Global,label="Draw\nAnother",position={0.57,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
		if Game.Leaders.Draws.Rebel[6] != nil then
			RebelPanel.createButton({click_function="ChooseRebelActionCard6",function_owner=Global,label="Choose\nthis Card",position={0.95,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif Game.Leaders.Draws.Rebel[5] != nil and not LeaderFound then
			RebelPanel.createButton({click_function="DrawRebelActionCard6",function_owner=Global,label="Draw\nAnother",position={0.95,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
	end--if
	log("End ChooseRebelLeaderActionCard()")
	function ChooseRebelRecruit1()
		--recruit is #1
			RebelPanel.clearButtons()
		Game.Leaders.Recruiting.Rebel=Game.Leaders.Recruits.Rebel[1]
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function ChooseRebelRecruit2()
		--recruit is #1
			RebelPanel.clearButtons()
		Game.Leaders.Recruiting.Rebel=Game.Leaders.Recruits.Rebel[2]
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function ChooseRebelActionCard(CardNum)
		RebelPanel.clearButtons()
		--raise the action deck...
		getObjectFromGUID(Decks.RebelAction.ID).setPositionSmooth(Decks.RebelAction.DropSpot,false,false)
		--go through each draw...
		for D,Draw in pairs(Game.Leaders.Draws.Rebel) do
			--unlock
			getObjectFromGUID(Draw).setLock(false)
			--flip face down...
			getObjectFromGUID(Draw).setRotation({0,0,180})
			--move card #1 to Action Hand...
			if D == CardNum then
			CardToHand({Player="White",Index=3,CardID=getObjectFromGUID(Draw).getGUID()})
			else
			getObjectFromGUID(Draw).setPositionSmooth(Decks.RebelAction.DropSpot,false,true)
			end--if
		end--for
		--remove discarded draws...
		Game.Leaders.Draws.Rebel = {Game.Leaders.Draws.Rebel[CardNum]}
		--reprocess step...
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function DrawRebelActionCard(CardNum)
		RebelPanel.clearButtons()
		--draw another action card...
		Game.Leaders.Draws.Rebel[CardNum] = getObjectFromGUID(Decks.RebelAction.ID).takeObject({smooth=true,position=Spots.Recruitment.Rebel.Cards[CardNum],rotation={0,0,180}}).getGUID()
		function DrawActionCardCoroutine()
			--flip the cards...
			RepCount = RepCount + 1
			repeat coroutine.yield(0) until not getObjectFromGUID(Game.Leaders.Draws.Rebel[CardNum]).isSmoothMoving()
			RepCount = RepCount - 1
			getObjectFromGUID(Game.Leaders.Draws.Rebel[CardNum]).flip()
			return 1
		end--function
		startLuaCoroutine(self,"DrawActionCardCoroutine")
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function ChooseRebelActionCard1()
		ChooseRebelActionCard(1)
	end--function
	function ChooseRebelActionCard2()
		ChooseRebelActionCard(2)
	end--function
	function ChooseRebelActionCard3()
		ChooseRebelActionCard(3)
	end--function
	function ChooseRebelActionCard4()
		ChooseRebelActionCard(4)
	end--function
	function ChooseRebelActionCard5()
		ChooseRebelActionCard(5)
	end--function
	function ChooseRebelActionCard6()
		ChooseRebelActionCard(6)
	end--function
	function DrawRebelActionCard3()
		DrawRebelActionCard(3)
	end--function
	function DrawRebelActionCard4()
		DrawRebelActionCard(4)
	end--function
	function DrawRebelActionCard5()
		DrawRebelActionCard(5)
	end--function
	function DrawRebelActionCard6()
		DrawRebelActionCard(6)
	end--function
end--function

function DeployRebelUnits(Params)  --{Error=""}
  if Params.Error == nil then Params.Error = "" end--if
  RebelPanel.clearButtons()
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING UNITS",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING UNITS",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  RebelPanel.createButton({click_function="NA",function_owner=Global,label="Deploy Rebel Units",position={0,0.1,-0.35},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  if Params.Error == "" then
    RebelPanel.createButton({click_function="NA",function_owner=Global,label="Deploy up to 2 Rebel Units per System.",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
    RebelPanel.createButton({click_function="ValidateRebelDeployment",function_owner=Global,label="Rebel Deployment Complete",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Rebel Unit Deployments are completed."})
  else
	printToAll(Params.Error.."\n",{1,1,0})
    RebelPanel.createButton({click_function="NA",function_owner=Global,label=Params.Error,position={0,0.1,0.25},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,0}})
	RebelPanel.createButton({click_function="IgnoreRebelDeploymentRules",function_owner=Global,label="Continue Anyway",position={-0.625,0.1,0.85},scale={0.6,0.6,0.6},width=1000,height=200,color={1,1,0},font_size=100,font_color={0,0,0},tooltip="Continue Anyway (Ignore deployment rules and/or Component limits)."})
	RebelPanel.createButton({click_function="ValidateRebelDeployment",function_owner=Global,label="Validate Deployment",position={0.625,0.1,0.85},scale={0.6,0.6,0.6},width=1000,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Validate Rebel Deployments."})
  end--if
  function IgnoreRebelDeploymentRules()
	broadcastToAll("Rebel Player ignoring deployment rules.",{1,1,0})
	printToAll("Rebel Deployment complete.")
	NextStep = "RefreshPhase.VI.DeployImperialUnits"
	Step = ""
  end--function 
  function ValidateRebelDeployment()
    RebelPanel.clearButtons()
    --recalculate the map...
	UpdateBoard(false)
    --validate deployment...
	local Error = ""
	--reset rebel deployment counts and update loyalty in every location... 
	for L,LocationInfo in pairs(Locations) do 
		LocationInfo.Units.Rebel.Deployed = 0
		LocationInfo.Units.Rebel.Recruits = 0
	end--for L,LocationInfo
	--loop through all rebel units with deploy tag... 
	for O,Obj in pairs(getAllObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		--Rebel unit in a valid location?
		if Obj.getVar("Faction") == "Rebel" and Obj.getVar("Component") == "Unit" and Locations[Obj.getVar("Location")] != nil then
			--has Deploy; tag AND not queue location?
			if string.find(Obj.getDescription(),"Deploy;") != nil and Locations[Obj.getVar("Location")].Type != "Queue" then
				--recruit?
				if Obj.getName() == "Recruit" then
					Locations[Obj.getVar("Location")].Units.Rebel.Recruits = Locations[Obj.getVar("Location")].Units.Rebel.Recruits + 1
				else--combat unit (not a recruit)...
					Locations[Obj.getVar("Location")].Units.Rebel.Deployed = Locations[Obj.getVar("Location")].Units.Rebel.Deployed + 1
				end--if
			end--if
		end--if
	end--for O,Obj 
	--count errors by location... 
	for L,LocationInfo in pairs(Locations) do 
		--location has a deployed combat unit... 
		if LocationInfo.Units.Rebel.Deployed > 0 then
			--illegal deployment?
			if LocationInfo.Type == "Base" then
				--cannot deploy to a revealed rebel base... 
				if IsBaseRevealed() then 
					Error = Error.."Cannot deploy to a revealed Rebel Base.\n"
					if LocationInfo.MarkerSpot != nil then
						Ping({Position=LocationInfo.MarkerSpot,Player="White"})
					end--if
				end--if
			elseif LocationInfo.Sabotaged then
				Error = Error..L.." is Sabotaged.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			elseif LocationInfo.Units.Imperial.Space + LocationInfo.Units.Imperial.Ground > 0 then
				Error = Error..L.." Blockaded by Imperials.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			elseif LocationInfo.Destroyed then
				Error = Error..L.." is Destroyed.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			elseif LocationInfo.Loyalty != "Rebel" then
				Error = Error..L.." is not Rebel Loyal.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			elseif LocationInfo.Units.Rebel.Deployed + LocationInfo.Units.Rebel.Recruits > 2 then
				Error = Error..L.." has more than 2 Deployed Units.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			end--if
		end--if
		--location has a deployed recruit... 
		if LocationInfo.Units.Rebel.Recruits > 0 then
			--illegal recruit deployment?
			if LocationInfo.Sabotaged then
				Error = Error..L.." is Sabotaged.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			elseif LocationInfo.Destroyed then
				Error = Error..L.." is Destroyed.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			elseif LocationInfo.Subtype != "Populous" then
				Error = Error..L.." is not a Populous System (Recruit).\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			elseif LocationInfo.Units.Rebel.Recruits > 2 and LocationInfo.Units.Rebel.Deployed == 0 then
				--only need to check this if there were no other deployed units to this location (otherwise this is a duplicate check).
				Error = Error..L.." has more than 2 Deployed Units.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="White"})
				end--if
			end--if
		end--if
	end--for L,LocationInfo
	--check for unit limit errors... 
	for U,Unit in pairs(Units) do 
		if Unit.Faction == "Rebel" and Unit.Count > Unit.Max then
			Error = Error..U.." count is over the limit ("..Unit.Count.."/"..Unit.Max..").\n"
		end--if
	end--for U,Unit 
	if Error == "" then
		printToAll("Rebel Deployment complete.")
		NextStep = "RefreshPhase.VI.DeployImperialUnits"
		Step = ""
	else--there are rebel deployment errors... 
		DeployRebelUnits({Error=Error})
	end--if
  end--function
end--function

function DeployRebelRecruits(RecruitList)
	local TileSpots = {{2.5,0.65,27},{-2.5,0.65,27},{2.5,0.65,28.5},{-2.5,0.65,28.5},{2.5,0.65,30},{-2.5,0.65,30}}
	local ButtonSpots = {{-0.6,0.15,-0.1},{0.6,0.15,-0.1},{-0.6,0.15,0.27},{0.6,0.15,0.27},{-0.6,0.15,0.62},{0.6,0.15,0.62}}
	RebelPanel.clearButtons()
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING RECRUITS",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING RECRUITS",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
	RebelPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOY REBEL RECRUITS",position={0,0.1,-0.48},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
	--get tiles--
	for R=1,#RecruitList do 
		--get recruit location... 
		local Location = ReadTag({Text=RecruitList[R].getGMNotes(),Tag="Location",Default=""})
		--fetch OT build tile... 
		local TileObj = getObjectFromGUID(IDs.Rebel.OTBag).takeObject({smooth=false,position=TileSpots[R],rotation={0,0,0}})
		TileObj.setLock(true)
		TileObj.setGMNotes("ID:"..RecruitList[R].getGUID()..";")
		RebelPanel.createButton({click_function="NA",function_owner=Global,label=Location,position=ButtonSpots[R],scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,1}})
	end--for R
    RebelPanel.createButton({click_function="ReplaceRebelRecruits",function_owner=Global,label="Replace Rebel Recruits",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Replace Recruit Unit(s) in Rebel Loyal Systems with Orange Triangle Combat Unit(s)."})
	function ReplaceRebelRecruits()
		function ReplaceRebelRecruitsCoroutine()
			RebelPanel.clearButtons()
			for R=1,#RecruitList do 
				--scan for tile at the indexed position... 
				local TileObj = ScanForObject({Description="BuildTile;",Origin=TileSpots[R],Orientation={0,0,0},Size={0.2,0.2,0.2},Debug=false,Type=2})
				getObjectFromGUID(Units[TileObj.getName()].BagID).takeObject({smooth=false,position=RecruitList[R].getPosition(),rotation=RecruitList[R].getRotation()})
				coroutine.yield(0)
				RecruitList[R].destruct()
				coroutine.yield(0)
				TileObj.destruct()
				coroutine.yield(0)
			end--for T
			UpdateBoard(false)
			CombatCheckAllSystems()
			coroutine.yield(0)
			Step = ""
			return 1
		end--function 
		startLuaCoroutine(Global,"ReplaceRebelRecruitsCoroutine")
	end--function
end--function
	
--Imperial Panel Menus------------------------------------------------------------------------------------------------------------------

function ImperialStartingUnitPlacement()
  ImperialPanel.clearButtons()
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0.5,0.5,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="IMPERIAL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Place Starting Imperial Units:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
  local LabelText = ""
  if Game.Flags.UnitPlacement == "RotE" then
    LabelText = "A Death Star was placed in the Imperial Queue 3.\nIn one Remote System: Place 4 TIE Fighters, 1\nStormtrooper, and 1 Death Star Under Construction.\nIn Imperial Systems (Loyal, Subjugated, and the\nRemote System above): Place a total of 8 TIE Fighters, 3\nAssault Carriers, 3 Star Destroyers, 2 TIE Strikers, 12\nStormtroopers, 4 AT-STs, 2 Assault Tanks, and 1 AT-AT."
  else
    LabelText = "In Imperial Systems (Loyal/Subjugated): Place a total of\n12 TIE Fighters, 3 Assault Carriers, 3 Star Destroyers,\n12 Stormtroopers, 5 AT-STs, 1 AT-AT, and 1 Death Star."
  end--if
  LabelText = LabelText.."\n\nImperial Systems:\nSubjugated: "..Game.Systems.Imperial[1]..", "..Game.Systems.Imperial[2].."\nLoyal: CORUSCANT, "..Game.Systems.Imperial[3]..",\n"..Game.Systems.Imperial[4]..", "..Game.Systems.Imperial[5]
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label=LabelText,position={0,0.1,0.1},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,1}})
  function ImperialStartingUnitPlacementComplete()
    ImperialPanel.clearButtons()
	UpdateBoard(false)
	if Game.AI.Active then printToAll("Imperial AI: Setup of starting Imperial units complete.",{0.5,0.5,1}) end--if
    if Game.Type == "Custom" then
      NextStep = "Setup.8.III.PlaceRebelStartingUnits"
    else
      NextStep = "Setup.8.II.ValidateImperialStartingUnits"
    end

    Step = ""
  end--function
  if Game.AI.Active then
	Wait.time(function() SuggestImperialSetup() end,1)
	Wait.time(function() ImperialStartingUnitPlacementComplete() end,3)
  else 
	ImperialPanel.createButton({click_function="ImperialStartingUnitPlacementComplete",function_owner=Global,label="Imperial Placement Complete",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Imperial Starting Unit Placement is complete."})
	--only suggest if using advanced setup...
	if Game.Type == "Advanced" then
		ImperialPanel.createButton({click_function="SuggestImperialSetup",function_owner=Global,label="Suggest",position={0.85,0.1,0.64},scale={0.5,0.5,0.5},width=500,height=150,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Suggest Imperial Starting Deployment."})
	end--if
  end--if ai active. 
end--function

function ImperialStartingUnitPlacementValidation(Params)
  ImperialPanel.clearButtons()
  UpdateBoard(false)
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="STARTING UNIT PLACEMENT",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0.5,0.5,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="IMPERIAL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Starting Imperial Unit Placement:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
  if Params.ErrorText == "" then
    ImperialPanel.createButton({click_function="NA",function_owner=Global,label="No issues detected with\nImperial Starting Unit Placement.",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=50,font_color={1,1,1}})
    ImperialPanel.createButton({click_function="ContinueToImperialPlacement",function_owner=Global,label="Proceed to Rebel Starting Unit Placement",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={0.5,1,0.5},font_size=100,font_color={0,0,0},tooltip="Imperial Starting Unit Placement is valid. Proceed to Rebel Starting Unit Placement."})
  else --display the problem...
    ImperialPanel.createButton({click_function="NA",function_owner=Global,label=Params.ErrorText,position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=50,font_color={1,1,0.5}})
    ImperialPanel.createButton({click_function="ContinueToRebelPlacement",function_owner=Global,label="Continue Anyway",position={-0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,0},font_size=100,font_color={0,0,0},tooltip="Continue to the next Step without validating placement."})
    ImperialPanel.createButton({click_function="ValidateImperialPlacement",function_owner=Global,label="Validate Placement",position={0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Validate Imperial Starting Unit Placement before continuing."})
  end--if
  function ValidateImperialPlacement()
	UpdateBoard(false)
    ImperialPanel.clearButtons()
    NextStep = "Setup.8.II.ValidateImperialStartingUnits"
    Step = ""
  end--function
  function ContinueToRebelPlacement()
    ImperialPanel.clearButtons()
    NextStep = "Setup.8.III.PlaceRebelStartingUnits"
    Step = ""
  end--function
end--function

function ResolveEarlyPromotion(Params)  --{CardObj=object}
  ImperialPanel.clearButtons()
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="RESOLVING: EARLY PROMOTION",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="RESOLVING: EARLY PROMOTION",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0.5,0.5,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="IMPERIAL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Immediate Starting Action Card:",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="EARLY PROMOTION:\n\nEither draw 1 starting action\ncard or recruit Admiral Motti.\n\nIf you recruit Admiral Motti,\n place him and Grand Moff\nTarkin in an Imperial System.",position={0,0.1,0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="Draw1ImperialStartingAction",function_owner=Global,label="Draw 1 Starting Action",position={-0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=75,font_color={0,0,0},tooltip="Draw another Starting Action Card instead."})
  ImperialPanel.createButton({click_function="RecruitMotti",function_owner=Global,label="Recruit Motti",position={0.65,0.1,0.85},scale={0.6,0.6,0.6},width=950,height=200,color={1,1,1},font_size=75,font_color={0,0,0},tooltip="Recruit this Leader."})
  function Draw1ImperialStartingAction()
    ImperialPanel.clearButtons()
    --draw another starting action card, and discard this action card.
    DealToHand({Deck="ImperialStartingAction",Player="Blue",Index=3,Qty=1,Flip=true})
    getObjectFromGUID(Decks.ImperialStartingAction.ID).putObject(Params.CardObj)
    printToAll("Imperial Player draws another Starting Action Card.")
    --put Motti away...
    getObjectFromGUID(IDs.Imperial.LeaderBag).putObject(getObjectFromGUID("666495"))
    Game.Flags.Immediate.Action.Imperial = false
    NextStep = "Setup.8.IV.ResolveStartingActionCards"
    Step = ""
  end--function
  function RecruitMotti()
    ImperialPanel.clearButtons()
    --recuit motti...
    GetLeader({Name="Admiral Motti",Smooth=true,Position={10.6,0.68,-13.8},Rotation={0,180,0}}).setDescription("Leader;Imperial;Admiral;RotE;Recruited;")
    --move tarking and motti togther to the deployment zone...
    GetLeader({Name="Grand Moff Tarkin",Smooth=true,Position={11.6,0.68,-13.8},Rotation={0,180,0}})
    printToAll("Admiral Motti has been recruited.\nPlace Admiral Motti and Grand Moff Tarking in an Imperial System.")
		Game.Flags.Immediate.Action.Imperial = false
    table.insert(Game.Leaders.Pools.Imperial,"Admiral Motti")
    NextStep = "Setup.8.IV.ResolveStartingActionCards"
    Step = ""
  end--function
end--function

function ChooseImperialLeaderActionCard()
	log("Start ChooseRebelLeaderActionCard()")
	ImperialPanel.clearButtons()
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="RECRUITING LEADER",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="RECRUITING LEADER",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0.5,0.5,1}})
	--ImperialPanel.createButton({click_function="NA",function_owner=Global,label="IMPERIAL           PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Recruit a Leader",position={0,0.1,-0.2},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
	--has action card been selected?
	if #Game.Leaders.Draws.Imperial == 1 then
		--is there more than 1 choice of recruits still?
		if #Game.Leaders.Recruits.Imperial > 1 then
		ImperialPanel.createButton({click_function="ChooseImperialRecruit1",function_owner=Global,label="Choose\n"..Game.Leaders.Recruits.Imperial[1],position={-0.3,0.1,0},scale={0.6,0.6,0.6},width=450,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Leader."})
		ImperialPanel.createButton({click_function="ChooseImperialRecruit2",function_owner=Global,label="Choose\n"..Game.Leaders.Recruits.Imperial[2],position={0.3,0.1,0},scale={0.6,0.6,0.6},width=450,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Leader."})
		ImperialPanel.createButton({click_function="NA",function_owner=Global,label="(Imperial Player can choose which Leader on the card\nto Recruit after Rebels have declared their choice).",position={0,0.1,0.4},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,1}})
		elseif #Game.Leaders.Recruits.Imperial == 1 then
		ImperialPanel.createButton({click_function="ChooseImperialRecruit1",function_owner=Global,label="Choose\n"..Game.Leaders.Recruits.Imperial[1],position={0,0.1,0},scale={0.6,0.6,0.6},width=400,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Leader."})
		end--if
	else  --display buttons for card choices...
		--if we find the leader in the hidden zone... 
		local LeaderFound = false
		for O,Obj in pairs(getObjectFromGUID(IDs.Imperial.HiddenPanelZone).getObjects()) do
			if Obj.getVar("Component") == "Leader" then
				LeaderFound = true
				break
			end--if
		end--for O,Obj
		ImperialPanel.createButton({click_function="ChooseImperialActionCard1",function_owner=Global,label="Choose\nthis Card",position={-0.95,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		ImperialPanel.createButton({click_function="ChooseImperialActionCard2",function_owner=Global,label="Choose\nthis Card",position={-0.57,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		if Game.Leaders.Draws.Imperial[3] != nil then
			ImperialPanel.createButton({click_function="ChooseImperialActionCard3",function_owner=Global,label="Choose\nthis Card",position={-0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif not LeaderFound then
			ImperialPanel.createButton({click_function="DrawImperialActionCard3",function_owner=Global,label="Draw\nAnother",position={-0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
		if Game.Leaders.Draws.Imperial[4] != nil then
			ImperialPanel.createButton({click_function="ChooseImperialActionCard4",function_owner=Global,label="Choose\nthis Card",position={0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif Game.Leaders.Draws.Imperial[3] != nil and not LeaderFound then
			ImperialPanel.createButton({click_function="DrawImperialActionCard4",function_owner=Global,label="Draw\nAnother",position={0.185,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
		if Game.Leaders.Draws.Imperial[5] != nil then
			ImperialPanel.createButton({click_function="ChooseImperialActionCard5",function_owner=Global,label="Choose\nthis Card",position={0.57,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif Game.Leaders.Draws.Imperial[4] != nil and not LeaderFound then
			ImperialPanel.createButton({click_function="DrawImperialActionCard5",function_owner=Global,label="Draw\nAnother",position={0.57,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
		if Game.Leaders.Draws.Imperial[6] != nil then
			ImperialPanel.createButton({click_function="ChooseImperialActionCard6",function_owner=Global,label="Choose\nthis Card",position={0.95,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Choose this Action Card."})
		elseif Game.Leaders.Draws.Imperial[5] != nil and not LeaderFound then
			ImperialPanel.createButton({click_function="DrawImperialActionCard6",function_owner=Global,label="Draw\nAnother",position={0.95,0.1,0.85},scale={0.5,0.5,0.5},width=350,height=200,color={1,1,1},font_size=50,font_color={0,0,0},tooltip="Draw another Action Card (because you cannot recruit any of the listed Leaders.)"})
		end--if
	end--if
	function ChooseImperialRecruit1()
		ImperialPanel.clearButtons()
		--recruit is #1
		Game.Leaders.Recruiting.Imperial=Game.Leaders.Recruits.Imperial[1]
		--save and process...
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function ChooseImperialRecruit2()
		ImperialPanel.clearButtons()
		--recruit is #1
		Game.Leaders.Recruiting.Imperial=Game.Leaders.Recruits.Imperial[2]
		--save and process...
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function ChooseImperialActionCard(CardNum)
		ImperialPanel.clearButtons()
		--raise the action deck...
		getObjectFromGUID(Decks.ImperialAction.ID).setPositionSmooth(Decks.ImperialAction.DropSpot,false,false)
		--go through each draw...
		for D,Draw in pairs(Game.Leaders.Draws.Imperial) do
		--unlock
		getObjectFromGUID(Draw).setLock(false)
		--flip face down...
		getObjectFromGUID(Draw).setRotation({0,180,180})
		--move card #1 to Action Hand...
		if D == CardNum then
			CardToHand({Player="Blue",Index=3,CardID=getObjectFromGUID(Draw).getGUID()})
		else
			getObjectFromGUID(Draw).setPositionSmooth(Decks.ImperialAction.DropSpot,false,true)
		end--if
		end--for
		--remove discarded draws...
		Game.Leaders.Draws.Imperial = {Game.Leaders.Draws.Imperial[CardNum]}
		--reprocess step...
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function DrawImperialActionCard(CardNum)
		ImperialPanel.clearButtons()
		--draw another action card...
		Game.Leaders.Draws.Imperial[CardNum] = getObjectFromGUID(Decks.ImperialAction.ID).takeObject({smooth=true,position=Spots.Recruitment.Imperial.Cards[CardNum],rotation={0,180,180}}).getGUID()
		function DrawActionCardCoroutine()
		--flip the cards...
		RepCount = RepCount + 1
		repeat coroutine.yield(0) until not getObjectFromGUID(Game.Leaders.Draws.Imperial[CardNum]).isSmoothMoving()
		RepCount = RepCount - 1
		getObjectFromGUID(Game.Leaders.Draws.Imperial[CardNum]).flip()
		return 1
		end--function
		startLuaCoroutine(self,"DrawActionCardCoroutine")
		NextStep = "RefreshPhase.V.i.ChooseActionCard"
		Step = ""
	end--function
	function ChooseImperialActionCard1()
		ChooseImperialActionCard(1)
	end--function
	function ChooseImperialActionCard2()
		ChooseImperialActionCard(2)
	end--function
	function ChooseImperialActionCard3()
		ChooseImperialActionCard(3)
	end--function
	function ChooseImperialActionCard4()
		ChooseImperialActionCard(4)
	end--function
	function ChooseImperialActionCard5()
		ChooseImperialActionCard(5)
	end--function
	function ChooseImperialActionCard6()
		ChooseImperialActionCard(6)
	end--function
	function DrawImperialActionCard3()
		DrawImperialActionCard(3)
	end--function
	function DrawImperialActionCard4()
		DrawImperialActionCard(4)
	end--function
	function DrawImperialActionCard5()
		DrawImperialActionCard(5)
	end--function
	function DrawImperialActionCard6()
		DrawImperialActionCard(6)
	end--function
end--function

function DeployImperialUnits(Params)  --{Error=""}
  if Params.Error == nil then Params.Error = "" end--if
  ImperialPanel.clearButtons()
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING UNITS",position={0.01,0.6,-3.61},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING UNITS",position={0,0.6,-3.6},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0.5,0.5,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="IMPERIAL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Deploy Imperial Units",position={0,0.1,-0.35},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  if Params.Error == "" then
    ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Deploy up to 2 Imperial Units per System.",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
    ImperialPanel.createButton({click_function="ValidateImperialDeployment",function_owner=Global,label="Imperial Deployment Complete",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Imperial Unit Deployments are completed."})
  else
	printToAll(Params.Error.."\n",{1,1,0})
    ImperialPanel.createButton({click_function="NA",function_owner=Global,label=Params.Error,position={0,0.1,0.25},scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,0}})
	ImperialPanel.createButton({click_function="IgnoreImperialDeploymentRules",function_owner=Global,label="Continue Anyway",position={-0.625,0.1,0.85},scale={0.6,0.6,0.6},width=1000,height=200,color={1,1,0},font_size=100,font_color={0,0,0},tooltip="Continue Anyway (Ignore deployment rules and/or Component limits)."})
	ImperialPanel.createButton({click_function="ValidateImperialDeployment",function_owner=Global,label="Validate Deployment",position={0.625,0.1,0.85},scale={0.6,0.6,0.6},width=1000,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Validate Imperial Deployments."})
  end--if
  function IgnoreImperialDeploymentRules()
	broadcastToAll("Imperial Player ignoring deployment rules.",{1,1,0})
	printToAll("Imperial Deployment complete.")
	NextStep = "RefreshPhase.End"
	Step = ""
  end--function 
  function ValidateImperialDeployment()
    ImperialPanel.clearButtons()
    --validate deployment...
    --recalculate the map...
	UpdateBoard(false)
	local Error = ""
	local DSSystem = ""	--death star desployed system
	--reset Imperial deployment counts and update loyalty in every location... 
	for L,LocationInfo in pairs(Locations) do 
		LocationInfo.Units.Imperial.Deployed = 0
		LocationInfo.Units.Imperial.Bunkers = 0
		LocationInfo.Units.Imperial.OldGround = 0
	end--for L,LocationInfo
	--loop through all Imperial units for initial tallying... 
	--check Death Star deployment rules here (do not include death star in the deployment count in this step)...
	for O,Obj in pairs(getAllObjects()) do 
		if Obj.getDescription() == nil then Obj.setDescription("")  end--if
		--Imperial unit in a valid location?
		if Obj.getVar("Faction") == "Imperial" and Obj.getVar("Component") == "Unit" and Locations[Obj.getVar("Location")] != nil then
			--if not in the queue...
			if Locations[Obj.getVar("Location")].Type != "Queue" then
				--has Deploy; tag?
				if string.find(Obj.getDescription(),"Deploy;") != nil then
					--log("Debug1:"..Obj.getName()..":"..Obj.getVar("Location"))
					--death star?
					if Obj.getName() == "Death Star" then 
						if Locations[Obj.getVar("Location")].Subtype != "Remote" then
							Error = Error..Obj.getVar("Location").." is not Remote (Death Star).\n"
							Ping({Position=Obj.getPosition(),Player="Blue"})
						elseif Locations[Obj.getVar("Location")].Units.Rebel.Space > 0 then
							Error = Error..Obj.getVar("Location").." has Rebel Ships present.\n"
							Ping({Position=Obj.getPosition(),Player="Blue"})
						else 
							DSSystem = Obj.getVar("Location")
						end--if
					elseif Obj.getName() == "Shield Bunker" and Locations[Obj.getVar("Location")].Subtype != "Remote" then
						--log("Debug2:"..Obj.getName()..":"..Obj.getGUID()..":"..Locations[Obj.getVar("Location")].Units.Imperial.Deployed..":"..Locations[Obj.getVar("Location")].Units.Imperial.Ground)
						--Locations[Obj.getVar("Location")].Units.Imperial.Deployed = Locations[Obj.getVar("Location")].Units.Imperial.Deployed + 1
						--must be at least 1 other existing ground units in this system to deploy a shield bunker... 
						if Locations[Obj.getVar("Location")].Units.Imperial.Ground - Locations[Obj.getVar("Location")].Units.Imperial.Deployed <= 1 then
							Error = Error..Obj.getVar("Location").." has no existing Imperial Ground Units.\n"
						end--if
					else--count the unit for deployment... 
						Locations[Obj.getVar("Location")].Units.Imperial.Deployed = Locations[Obj.getVar("Location")].Units.Imperial.Deployed + 1
					end--if
				elseif Obj.getName() == "Shield Bunker" then--existing shield bunker... 
					Locations[Obj.getVar("Location")].Units.Imperial.Bunkers = Locations[Obj.getVar("Location")].Units.Imperial.Bunkers + 1
					Locations[Obj.getVar("Location")].Units.Imperial.OldGround = Locations[Obj.getVar("Location")].Units.Imperial.OldGround + 1
				elseif Obj.getVar("Theater") == "Ground" then--existing (old) ground unit...
					Locations[Obj.getVar("Location")].Units.Imperial.OldGround = Locations[Obj.getVar("Location")].Units.Imperial.OldGround + 1
				end--if
			end--if
		end--if
	end--for O,Obj 
	--count errors by location... 
	for L,LocationInfo in pairs(Locations) do 
		--location has a deployed unit... 
		if LocationInfo.Units.Imperial.Deployed > 0 then
			--illegal deployment?
			if LocationInfo.Sabotaged then
				Error = Error..L.." is Sabotaged.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="Blue"})
				end--if
			elseif LocationInfo.Units.Rebel.Space + LocationInfo.Units.Rebel.Ground - LocationInfo.Units.Rebel.Recruits > 0 then
				Error = Error..L.." Blockaded by Rebels.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="Blue"})
				end--if
			elseif LocationInfo.Destroyed then
				Error = Error..L.." is Destroyed.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="Blue"})
				end--if
			elseif LocationInfo.Loyalty != "Imperial" and LocationInfo.Units.Imperial.OldGround < 1 and LocationInfo.Units.Imperial.Bunkers < 1 then	--not loyal, no existing bunkers, and no existing ground unit...
				Error = Error..L.." is not an Imperial System.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="Blue"})
				end--if
			elseif LocationInfo.Units.Imperial.Deployed > 2 then
				Error = Error..L.." has more than 2 Deployed Units.\n"
				if LocationInfo.MarkerSpot != nil then
					Ping({Position=LocationInfo.MarkerSpot,Player="Blue"})
				end--if
			end--if
		end--if
	end--for L,LocationInfo
	--check for unit limit errors... 
	for U,Unit in pairs(Units) do 
		if Unit.Faction == "Imperial" and Unit.Count > Unit.Max then
			Error = Error..U.." count is over the limit ("..Unit.Count.."/"..Unit.Max..").\n"
		end--if
	end--for U,Unit 
	if Error == "" then
		printToAll("Imperial Deployment complete.")
		NextStep = "RefreshPhase.End"
		Step = ""
	else--there are Imperial deployment errors... 
		DeployImperialUnits({Error=Error})
	end--if
  end--function
end--function

function DeployImperialRecruits(RecruitList)	
	local TileSpots = {{-2.5,0.65,-27},{2.5,0.65,-27},{-2.5,0.65,-28.5},{2.5,0.65,-28.5},{-2.5,0.65,-30},{2.5,0.65,-30}}
	local ButtonSpots = {{-0.6,0.15,-0.1},{0.6,0.15,-0.1},{-0.6,0.15,0.27},{0.6,0.15,0.27},{-0.6,0.15,0.62},{0.6,0.15,0.62}}
	ImperialPanel.clearButtons()
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING RECRUITS",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOYING RECRUITS",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={1,1,1}})
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="IMPERIAL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.65},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
	ImperialPanel.createButton({click_function="NA",function_owner=Global,label="DEPLOY IMPERIAL RECRUITS",position={0,0.1,-0.48},scale={0.6,0.6,0.6},width=0,height=0,font_size=125,font_color={1,1,1}})
	--get tiles--
	for R=1,#RecruitList do 
		--get recruit location... 
		local Location = ReadTag({Text=RecruitList[R].getGMNotes(),Tag="Location",Default=""})
		--fetch OT build tile... 
		local TileObj = getObjectFromGUID(IDs.Imperial.OTBag).takeObject({smooth=false,position=TileSpots[R],rotation={0,180,0}})
		TileObj.setLock(true)
		TileObj.setGMNotes("ID:"..RecruitList[R].getGUID()..";")
		ImperialPanel.createButton({click_function="NA",function_owner=Global,label=Location,position=ButtonSpots[R],scale={0.6,0.6,0.6},width=0,height=0,font_size=75,font_color={1,1,1}})
	end--for R
    ImperialPanel.createButton({click_function="ReplaceImperialRecruits",function_owner=Global,label="Replace Imperial Recruits",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Replace Recruit Unit(s) in Imperial Loyal Systems with Orange Triangle Combat Unit(s)."})
	function ReplaceImperialRecruits()
		function ReplaceImperialRecruitsCoroutine()
			ImperialPanel.clearButtons()
			for R=1,#RecruitList do 
				--scan for tile at the indexed position... 
				local TileObj = ScanForObject({Description="BuildTile;",Origin=TileSpots[R],Orientation={0,0,0},Size={0.2,0.2,0.2},Debug=false,Type=2})
				getObjectFromGUID(Units[TileObj.getName()].BagID).takeObject({smooth=false,position=RecruitList[R].getPosition(),rotation=RecruitList[R].getRotation()})
				coroutine.yield(0)
				RecruitList[R].destruct()
				coroutine.yield(0)
				TileObj.destruct()
				coroutine.yield(0)
			end--for T
			UpdateBoard(false)
			CombatCheckAllSystems()
			coroutine.yield(0)
			Step = ""
			return 1
		end--function 
		startLuaCoroutine(Global,"ReplaceImperialRecruitsCoroutine")
	end--function
end--function
	
function SweepTheArea()
  --prompt imperial player to resolve sweep the area...
  ImperialPanel.clearButtons()
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="SWEEP THE AREA",position={0.01,0.6,-4.01},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0,0,0}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="SWEEP THE AREA",position={0,0.6,-4.0},rotation={90,0,180},scale={0.5,1,1},width=0,height=0,font_size=400,font_color={0.5,0.5,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="REBEL PLAYER",position={0,0.1,-0.85},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="REFRESH PHASE",position={0,0.1,-0.6},scale={0.6,0.6,0.6},width=0,height=0,font_size=200,font_color={0.7,0.7,0.7}})
  ImperialPanel.createButton({click_function="NA",function_owner=Global,label="Resolve Sweep the Area",position={0,0.1,0},scale={0.6,0.6,0.6},width=0,height=0,font_size=100,font_color={1,1,1}})
  ImperialPanel.createButton({click_function="DoneSweepTheArea",function_owner=Global,label="Continue",position={0,0.1,0.85},scale={0.6,0.6,0.6},width=1800,height=200,color={1,1,1},font_size=100,font_color={0,0,0},tooltip="Click after either resolving Sweep the Area, or deciding not to."})
  function DoneSweepTheArea()
    ImperialPanel.clearButtons()
    NextStep = "CommandPhase.SweepTheArea"
    Step = ""
  end--function
end--function

function DestroySystem(Params)--{Object=self,PlayerColor=PlayerColor}
	--a system destroyed marker (Object) was dropped... 
	local Location = GetGrid({Position=Params.Object.getPosition()}).Location
	if Location != "" then
		if Locations[Location].Type == "System" then
			Params.Object.setVelocity({0,0,0})
			Params.Object.setRotationSmooth({0,180,0},false,false)
			Params.Object.setPositionSmooth({Params.Object.getPosition().x,0.69,Params.Object.getPosition().z},false,false)
			local ImperialGround = 0
			local ImperialCapacity = 0
			--destroy all rebel ground units in the location, prompt imperials to destroy ground over the transport limit...
			for O,Obj in pairs(getAllObjects()) do 
				if Obj.getGMNotes() == nil then Obj.setGMNotes("") end--if
				if string.find(Obj.getGMNotes(),"Location:"..Location..";") != nil then
					--unit?
					if Obj.getVar("Component") == "Unit" then
						--ground or space?
						if Obj.getVar("Theater") == "Ground" then
							--rebel?
							if Obj.getVar("Faction") == "Rebel" then
								Obj.destruct()
								printToAll(Obj.getName().." destroyed in "..Location..".")
							else--hop imperial ground unit
								Obj.translate({0,2,0})
								ImperialGround = ImperialGround + 1
							end--if
						elseif Obj.getVar("Theater") == "Space" then
							--imperial?
							if Obj.getVar("Faction") == "Imperial" then
								--transport capacity?
								if Units[Obj.getName()].Transport > 0 then
									ImperialCapacity = ImperialCapacity + Units[Obj.getName()].Transport 
								end--if
							end--if
							--hop all space units...
							Obj.translate({0,2,0})
						end--if
					elseif Obj.getVar("Component") == "Leader" then
						--hop leaders... 
						Obj.translate({0,2,0})
					end--if
				end--if
			end--for O,Obj
			--if not already destroyed... 
			if string.find(Params.Object.getGMNotes(),"Location:"..Location..";") == nil then
				Params.Object.setGMNotes("Location:"..Location..";")
				broadcastToAll(Location.." was destroyed!",{1,1,0})
				--reconcile imperial ground troops against transport capacity... 
				if ImperialGround > ImperialCapacity then
					broadcastToAll("Imperial Player must destroy "..(ImperialGround - ImperialCapacity).." ground units in "..Location..".\n("..ImperialGround.." ground units, but only "..ImperialCapacity.." transport capacity).",{1,1,0})
				end--if
				--destroy loyalty marker if found...
				local MarkerID = ScanForObjectID({Description="LoyaltyMarker;",Origin=Locations[Location].MarkerSpot,Debug=false})
				if getObjectFromGUID(MarkerID) != nil then
					getObjectFromGUID(MarkerID).destruct()
				end--if
				Locations[Location].Destroyed = true
				--imperial victory condition? rebel base system destroyed...
				if GetBaseLocation() == Location then
					broadcastToAll("IMPERIAL VICTORY DETECTED!",{1,1,0})
					printToAll("The System containing the Rebel Base was destroyed.",{1,1,0})
                    PlaySound({ID=12})
				end--if
			end--if
		end--if
	end--if
end--function 

function ToggleImperialHiddenZone()
	if getObjectFromGUID(IDs.Imperial.HiddenMissionZone).getPosition().y > 0 then
		--toggle off...
		getObjectFromGUID(IDs.Imperial.HiddenMissionZone).setPosition({0,-2,-16})
		getObjectFromGUID(IDs.Imperial.HiddenMissionZone).setScale({20,0.5,1})
	else--toggle on...
		getObjectFromGUID(IDs.Imperial.HiddenMissionZone).setPosition({0,0.96,-16})
		getObjectFromGUID(IDs.Imperial.HiddenMissionZone).setScale({20,0.5,1})
	end--if
end--function 

function ToggleRebelHiddenZone()
	if getObjectFromGUID(IDs.Rebel.HiddenMissionZone).getPosition().y > 0 then
		--toggle off...
		getObjectFromGUID(IDs.Rebel.HiddenMissionZone).setPosition({0,-2,16})
		getObjectFromGUID(IDs.Rebel.HiddenMissionZone).setScale({20,0.5,1})
	else--toggle on...
		getObjectFromGUID(IDs.Rebel.HiddenMissionZone).setPosition({0,0.96,16})
		getObjectFromGUID(IDs.Rebel.HiddenMissionZone).setScale({20,0.5,1})
	end--if
end--function 

function LoyaltyMarkerLoad(Object)
	Object.clearButtons()
	if Object.getDescription() == "LoyaltyMarker;Imperial;" then
		log(Object.getGMNotes().." Loyalty set to Imperial.")
		Object.createButton({click_function="LoyaltyMarkerSetNeutral",function_owner=Global,label="⇨",position={0.7,0.1,0},scale={1,1,1},rotation={0,0,0},width=250,height=300,font_size=200,color={0,0,0,0.7},font_color={1,1,1},tooltip="Change to Neutral"})
		Object.createButton({click_function="LoyaltyMarkerSetNeutral",function_owner=Global,label="⇨",position={-0.7,0,0},scale={1,1,1},rotation={0,0,180},width=250,height=300,font_size=200,color={0,0,0,0.7},font_color={1,1,1},tooltip="Cnage to Neutral"})
		--if not in setup, and game is done loading...
		if Loaded then
			printToAll(Object.getGMNotes().." Loyalty set to Imperial.",{1,1,0})
			--not during setup and no existing combat marker...
			if Game.Phase != "Setup" and Locations[Object.getGMNotes()] != nil then
				if getObjectFromGUID(Locations[Object.getGMNotes()].CombatMarkerID) == nil then
					--prompt to scan for the rebel base...
					ScanForRebelBasePrompt({System=Object.getGMNotes()})
				end--if
			end--if
		end--if
	elseif Object.getDescription() == "LoyaltyMarker;Rebel;" then
		log(Object.getGMNotes().." Loyalty set to Rebel.")
		Object.createButton({click_function="LoyaltyMarkerSetNeutral",function_owner=Global,label="⇦",position={-0.7,0.1,0},scale={1,1,1},rotation={0,0,0},width=250,height=300,font_size=200,color={1,1,1,0.7},font_color={0,0,0},tooltip="Change to Neutral"})
		Object.createButton({click_function="LoyaltyMarkerSetNeutral",function_owner=Global,label="⇦",position={0.7,0,0},scale={1,1,1},rotation={0,0,180},width=250,height=300,font_size=200,color={1,1,1,0.7},font_color={0,0,0},tooltip="Change to Neutral"})
		Object.createButton({click_function="LoyaltyMarkerSubjugated",function_owner=Global,label="S",position={0,0.1,0},scale={1,1,1},rotation={0,0,0},width=300,height=750,font_size=200,color={1,1,1,0.1},font_color={0,0,0},tooltip="Flip to Subjugated"})
		Object.createButton({click_function="LoyaltyMarkerNotSubjugated",function_owner=Global,label="N",position={0,0,0},scale={1,1,1},rotation={0,0,180},width=300,height=750,font_size=200,color={1,1,1,0.1},font_color={0,0,0},tooltip="Flip to Remove Subjugation"})
		--if game is done loading...
		if Loaded then
			printToAll(Object.getGMNotes().." Loyalty set to Rebel.",{1,1,0})
		end--if
	else--assume neutral...
		log(Object.getGMNotes().." Loyalty set to Neutral.")
		Object.createButton({click_function="LoyaltyMarkerSetRebel",function_owner=Global,label="⇨",position={0.7,0.1,0},scale={1,1,1},rotation={0,0,0},width=250,height=300,font_size=200,color={1,0,0,0.7},font_color={1,1,1},tooltip="Change to Rebel Loyalty"})
		Object.createButton({click_function="LoyaltyMarkerSetRebel",function_owner=Global,label="⇨",position={-0.7,0,0},scale={1,1,1},rotation={0,0,180},width=250,height=300,font_size=200,color={1,0,0,0.7},font_color={1,1,1},tooltip="Change to Rebel Loyalty"})
		Object.createButton({click_function="LoyaltyMarkerSetImperial",function_owner=Global,label="⇦",position={-0.7,0.1,0},scale={1,1,1},rotation={0,0,0},width=250,height=300,font_size=200,color={0,0,0,0.7},font_color={1,1,1},tooltip="Change to Imperial Loyalty"})
		Object.createButton({click_function="LoyaltyMarkerSetImperial",function_owner=Global,label="⇦",position={0.7,0,0},scale={1,1,1},rotation={0,0,180},width=250,height=300,font_size=200,color={0,0,0,0.7},font_color={1,1,1},tooltip="Change to Imperial Loyalty"})
		Object.createButton({click_function="LoyaltyMarkerSubjugated",function_owner=Global,label="",position={0,0.1,0},scale={1,1,1},rotation={0,0,0},width=300,height=750,font_size=200,color={1,1,1,0.1},font_color={0,0,0},tooltip="Flip to Subjugated"})
		Object.createButton({click_function="LoyaltyMarkerNotSubjugated",function_owner=Global,label="",position={0,0,0},scale={1,1,1},rotation={0,0,180},width=300,height=750,font_size=200,color={1,1,1,0.1},font_color={0,0,0},tooltip="Flip to Remove Subjugation"})
		--if not in setup, and game is done loading...
		if Loaded then
			printToAll(Object.getGMNotes().." Loyalty set to Neutral.",{1,1,0})
		end--if
	end--if
end--function

function LoyaltyMarkerSetImperial(Object,PlayerColor)
	if PlayerColor != nil then
		printToAll(PlayerColor.." player set "..Object.getGMNotes().." Loyalty to Imperials.",{1,1,0})
	else
		printToAll(Object.getGMNotes().." is now Loyal to Imperials.",{1,1,0})
	end--if
	local SystemName = Object.getGMNotes()
	local NewObj = Object.setState(1)
	NewObj.setGMNotes(SystemName)
end--function

function LoyaltyMarkerSetRebel(Object,PlayerColor)
	if PlayerColor != nil then
		printToAll(PlayerColor.." player set "..Object.getGMNotes().." Loyalty to Rebels.",{1,1,0})
	else
		printToAll(Object.getGMNotes().." is now Loyal to Rebels.",{1,1,0})
	end--if
	local SystemName = Object.getGMNotes()
	local NewObj = Object.setState(3)
	NewObj.setGMNotes(SystemName)
end--function

function LoyaltyMarkerSetNeutral(Object,PlayerColor)
	if PlayerColor != nil then
		printToAll(PlayerColor.." player set "..Object.getGMNotes().." Loyalty to Neutral.",{1,1,0})
	else
		printToAll(Object.getGMNotes().." is now Neutral.",{1,1,0})
	end--if
	local SystemName = Object.getGMNotes()
	local NewObj = Object.setState(2)
	NewObj.setGMNotes(SystemName)
end--function

function LoyaltyMarkerSubjugated(Object,PlayerColor)
	if PlayerColor != nil then
		printToAll(PlayerColor.." player set "..Object.getGMNotes().." to Subjugated.",{1,1,0})
	else
		printToAll(Object.getGMNotes().." was set to Subjugated.",{1,1,0})
	end--if
	Object.setRotationSmooth({0,180,180},false,false)
	Object.setPositionSmooth({Object.getPosition().x,0.79,Object.getPosition().z},false,true)
end--function

function LoyaltyMarkerNotSubjugated(Object,PlayerColor)
	if PlayerColor != nil then
		printToAll(PlayerColor.." player removed Subjugation from "..Object.getGMNotes()..".",{1,1,0})
	else
		printToAll("Subjugation was removed from "..O.getGMNotes()..".",{1,1,0})
	end--if
	Object.setRotationSmooth({0,180,0},false,false)
	Object.setPositionSmooth({Object.getPosition().x,0.69,Object.getPosition().z},false,true)
end--function

function MoveUnit(Params)--{Name="",FromLocation="",ToLocation="",Position={},Rotation={},Smooth=true}
	local Result = nil
	if Params.Smooth == nil then Params.Smooth=true end--if
	for O,Obj in pairs(getAllObjects()) do 
		if Obj.getVar("Component") == "Unit" and Obj.getName() == Params.Name and Obj.getVar("Location") == Params.FromLocation then
			Result = Obj
			--increment new location count...
			Locations[Params.ToLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] = Locations[Params.ToLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] + 1
			--decrement old location count... 
			if Locations[Params.FromLocation] != nil then
				Locations[Params.FromLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] = Locations[Params.FromLocation].Units[Obj.getVar("Faction")][Obj.getVar("Theater")] - 1
			end--if from location exists 
			--update unit object...
			Obj.setGMNotes(UpdateTag({Text=Obj.getGMNotes(),Tag="Location",Value=Params.ToLocation}))
			Obj.setVar("Location",Params.ToLocation)
			if Params.Rotation == nil then Params.Rotation = Obj.getRotation() end--if
			if Params.Smooth then
				Obj.setPositionSmooth(Params.Position,false,false)
				Obj.setRotationSmooth(Params.Rotation,false,false)
			else--not smooth... 
				Obj.setPosition(Params.Position)
				Obj.setRotation(Params.Rotation)
				coroutine.yield(0)
			end--if
			break
		end--if
	end--for O,Obj 
	if Result != nil then
		log("Moved "..Params.Name.." from '"..Params.FromLocation.."' to '"..Params.ToLocation.."'.")
	else
		log("Failed to move "..Params.Name.." from '"..Params.FromLocation.."' to '"..Params.ToLocation.."'.")
	end--if
	return Result
end--function 

function BuildTileOnLoad(Params) --{Tile=Obj}
    local ID = Params.Tile.getStateId()
    local States = Params.Tile.getStates()
    local NextState = nil
    local PrevState = nil
    local Location = ReadTag({Text=Params.Tile.getDescription(),Tag="Location",Default=""})
    if States != nil then
        for S,State in pairs(States) do
            if ID == State.id - 1 then
                NextState = State
                --cancel nextstate if it's RotE and RotE is not used or if it's WFL and WFL is not used...
                if not Game.Flags.RotE and string.find(State.description,"RotE;") != nil or not Game.Flags.WFL and string.find(State.description,"WFL;") != nil then
                    NextState = nil
                end--if
            elseif ID == State.id + 1 then
                PrevState = State
            end--if
        end--for
        --display Next Button?
        if NextState != nil then
            Params.Tile.createButton({click_function="NextBuildTileIcon",function_owner=Global,label="⇨",position={1.2,0.1,-1.2},width=500,height=500,font_size=500,tooltip="Change to "..NextState.name})
        end--if
        --display Prev Button?
        if PrevState != nil then
            Params.Tile.createButton({click_function="PrevBuildTileIcon",function_owner=Global,label="⇦",position={-1.2,0.1,-1.2},width=500,height=500,font_size=500,tooltip="Change to "..PrevState.name})
        end--if
    end--if
    --update variables on the object... 
    Params.Tile.setVar("Component","BuildTile")
    Params.Tile.setVar("ID",ID)
    Params.Tile.setTable("States",States)
    Params.Tile.setTable("NextState",NextState)
    Params.Tile.setTable("PrevState",PrevState)
    Params.Tile.setVar("Location",Location)
end--function

function NextBuildTileIcon(Tile)
    local NextObj = Tile.setState(Tile.getTable("NextState").id)
    NextObj.setLock(true)
    NextObj.setVar("Location",Location)
end--function
    
function PrevBuildTileIcon(Tile)
    local PrevObj = Tile.setState(Tile.getTable("PrevState").id)
    PrevObj.setLock(true)
    PrevObj.setVar("Location",Location)
end--function
    
function SuggestImperialSetup()
	if Game.AI.Active then
		printToAll("Imperial AI: Placing starting Imperial units...",{0.5,0.5,1})
	else
		ImperialPanel.removeButton(6)
	end--if
	function SuggestImperialSetupCoroutine()
		--clear locations from all imperial units so they can be moved... 
		for O,Obj in pairs(getAllObjects()) do 
			if Obj.getVar("Component") == "Unit" and Obj.getVar("Faction") == "Imperial" then
				Obj.setVar("Location","")
			end--if 
		end--for O,Obj 
		local Fleets = {}
		if Game.Flags.UnitPlacement == "RotE" then
			if not Game.AI.Active then printToAll("Suggesting Imperial RotE Setup...",{1,1,0}) end--if
			--Fleet1-------------------------------------------------------------------------------------------
			--Saleucami,Mandalore,Mygeeto
			if Locations["SALEUCAMI"].Loyalty == "Imperial" or Locations["SALEUCAMI"].Subjugated then
				table.insert(Fleets,"SALEUCAMI")
			elseif Locations["MANDALORE"].Loyalty == "Imperial" or Locations["MANDALORE"].Subjugated then
				table.insert(Fleets,"MANDALORE")
			else--must be MYGEETO   
				table.insert(Fleets,"MYGEETO")
			end--if
			coroutine.yield(0)
			printToAll("Imperial Fleet1 (Subjugation) starts in "..Fleets[1])
			if Fleets[1] == "SALEUCAMI" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="SALEUCAMI",Position={-11.45,2,6.4},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="SALEUCAMI",Position={-10.4,2,6},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-11,2,5},Smooth=true})
				MoveUnit({Name="TIE Striker",FromLocation="",ToLocation="SALEUCAMI",Position={-10.5,2,5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-10,2,5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="SALEUCAMI",Position={-9,2,5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="SALEUCAMI",Position={-8.5,2,5},Smooth=true})
				MoveUnit({Name="Assault Tank",FromLocation="",ToLocation="SALEUCAMI",Position={-9,2,4},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-9.5,2,4.6},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-9,2,4.6},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-8.5,2,4.6},Smooth=true})
			elseif Fleets[1] == "MANDALORE" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="MANDALORE",Position={-9,2,0},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="MANDALORE",Position={-10,2,0},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-9,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Striker",FromLocation="",ToLocation="MANDALORE",Position={-8.5,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-8,2,-1.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-2.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MANDALORE",Position={-6.5,2,-2.5},Smooth=true})
				MoveUnit({Name="Assault Tank",FromLocation="",ToLocation="MANDALORE",Position={-7.5,2,-3.7},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7.5,2,-3},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-3},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-6.5,2,-3},Smooth=true})
			elseif Fleets[1] == "MYGEETO" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="MYGEETO",Position={-12.5,2,-6},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="MYGEETO",Position={-11.5,2,-6},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MYGEETO",Position={-11,2,-5.5},Smooth=true})
				MoveUnit({Name="TIE Striker",FromLocation="",ToLocation="MYGEETO",Position={-10.5,2,-5.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MYGEETO",Position={-10,2,-5.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MYGEETO",Position={-14.5,2,-5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MYGEETO",Position={-14,2,-5},Smooth=true})
				MoveUnit({Name="Assault Tank",FromLocation="",ToLocation="MYGEETO",Position={-15,2,-6.25},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MYGEETO",Position={-15,2,-5.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MYGEETO",Position={-14.5,2,-5.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MYGEETO",Position={-15,2,-5.5},Smooth=true})
			end--if
			coroutine.yield(0)
			--Fleet2 (Subjugation)----------------------------------------------------------------------------------
			--Rodia, Tatooine (if BO+RY), Dagobah
			if Locations["RODIA"].Loyalty == "Imperial" or Locations["RODIA"].Subjugated then
				table.insert(Fleets,"RODIA")
			elseif Locations["NABOO"].Loyalty != "Rebel" or (Locations["BOTHAWUI"].Loyalty == "Rebel" and Locations["RYLOTH"].Loyalty == "Rebel") then
				table.insert(Fleets,"TATOOINE")
			else--assume dagobah...
				table.insert(Fleets,"DAGOBAH")
			end--if
			coroutine.yield(0)
			printToAll("Imperial Fleet2 (Subjugation) starts in "..Fleets[2])
			if Fleets[2] == "RODIA" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="RODIA",Position={7,2,6.5},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="RODIA",Position={8,2,6.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={5,2,7},Smooth=true})
				MoveUnit({Name="TIE Striker",FromLocation="",ToLocation="RODIA",Position={5.5,2,7},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={6,2,7},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="RODIA",Position={5.5,2,5.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="RODIA",Position={6,2,5.5},Smooth=true})
				MoveUnit({Name="Assault Tank",FromLocation="",ToLocation="RODIA",Position={5.4,2,4},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5,2,5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5.5,2,5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={6,2,5},Smooth=true})
			elseif Fleets[2] == "TATOOINE" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="TATOOINE",Position={3.5,2,9.8},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="TATOOINE",Position={2.5,2,10.3},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="TATOOINE",Position={4.5,2,8.5},Smooth=true})
				MoveUnit({Name="TIE Striker",FromLocation="",ToLocation="TATOOINE",Position={5,2,8.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="TATOOINE",Position={5.5,2,8.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="TATOOINE",Position={7.8,2,10.3},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="TATOOINE",Position={8.3,2,10.3},Smooth=true})
				MoveUnit({Name="Assault Tank",FromLocation="",ToLocation="TATOOINE",Position={8.6,2,9.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="TATOOINE",Position={7.5,2,9.8},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="TATOOINE",Position={8,2,9.8},Smooth=true})
				--MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="TATOOINE",Position={8,2,9.2},Smooth=true})
			elseif Fleets[2] == "DAGOBAH" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="DAGOBAH",Position={14.5,2,0},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="DAGOBAH",Position={15.5,2,0.2},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="DAGOBAH",Position={12.5,2,1.6},Smooth=true})
				MoveUnit({Name="TIE Striker",FromLocation="",ToLocation="DAGOBAH",Position={13,2,1.6},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="DAGOBAH",Position={13.5,2,1.6},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="DAGOBAH",Position={12.2,2,-0.2},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="DAGOBAH",Position={12.8,2,-0.2},Smooth=true})
				MoveUnit({Name="Assault Tank",FromLocation="",ToLocation="DAGOBAH",Position={13.2,2,-1},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="DAGOBAH",Position={12,2,-0.8},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="DAGOBAH",Position={12.5,2,-0.8},Smooth=true})
				--MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="DAGOBAH",Position={12.5,2,-1.4},Smooth=true})
			end--if
			coroutine.yield(0)
			--Fleet3 (DSUC Fleet)... Tatooine (if no Rodia, and rebel have Ryloth+Bothawui), Dagobah
			if Fleets[2] == "TATOOINE" then
				table.insert(Fleets,"TATOOINE")
				MoveUnit({Name="Death Star Under Construction",FromLocation="",ToLocation="TATOOINE",Position={5,2,10},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="TATOOINE",Position={4.5,2,9.2},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="TATOOINE",Position={5,2,9.2},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="TATOOINE",Position={5.5,2,9.2},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="TATOOINE",Position={6,2,9.2},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="TATOOINE",Position={7.5,2,9.2},Smooth=true})
			else--default to dagobah.... 
				table.insert(Fleets,"DAGOBAH")
				MoveUnit({Name="Death Star Under Construction",FromLocation="",ToLocation="DAGOBAH",Position={10.7,2,-2},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="DAGOBAH",Position={12,2,1},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="DAGOBAH",Position={12.5,2,1},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="DAGOBAH",Position={13,2,1},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="DAGOBAH",Position={13.5,2,1},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="DAGOBAH",Position={12,2,-1.4},Smooth=true})
			end--if
			coroutine.yield(0)
			printToAll("Death Star Under Construction starts in "..Fleets[3])
			--Fleet4 (Defense)... Corellia (if Mandalore, but no Sullust), Coruscant
			--if (Fleets[1] == "MANDALORE" or Fleets[2] == "MANDALORE") and not (Locations["SULLUST"].Loyalty == "Imperial" or Locations["SULLUST"].Subjugated) then
				--table.insert(Fleets,"CORELLIA")
				--MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="CORELLIA",Position={6,2,-5.5},Smooth=true})
				--MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORELLIA",Position={3.5,2,-7},Smooth=true})
				--MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORELLIA",Position={4,2,-7},Smooth=true})
				--MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORELLIA",Position={4.5,2,-7},Smooth=true})
				--MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORELLIA",Position={5,2,-7},Smooth=true})
				--MoveUnit({Name="AT-AT",FromLocation="",ToLocation="CORELLIA",Position={8.5,2,-8},Smooth=true})
				--MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORELLIA",Position={6.5,2,-8},Smooth=true})
				--MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORELLIA",Position={7,2,-8},Smooth=true})
				--MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORELLIA",Position={7.5,2,-8},Smooth=true})
			--else--must be coruscant...
				table.insert(Fleets,"CORUSCANT")
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="CORUSCANT",Position={-0.5,2,-8.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORUSCANT",Position={-1.5,2,-10},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORUSCANT",Position={-1,2,-10},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORUSCANT",Position={-0.5,2,-10},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORUSCANT",Position={0,2,-10},Smooth=true})
				MoveUnit({Name="AT-AT",FromLocation="",ToLocation="CORUSCANT",Position={3,2,-8.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORUSCANT",Position={1,2,-9},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORUSCANT",Position={1.5,2,-9},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORUSCANT",Position={2,2,-9},Smooth=true})
			--end--if
			coroutine.yield(0)
			--if Fleet2 joined Fleet3... 
			if Fleets[2] == Fleets[3] and Fleets[4] == "CORELLIA" then
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="CORELLIA",Position={7,2,-5.5},Smooth=true})
			elseif Fleets[2] == Fleets[3] and Fleets[4] == "CORUSCANT" then
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="CORUSCANT",Position={-1.5,2,-8.5},Smooth=true})
			else--assume dagobah... 
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="DAGOBAH",Position={11.2,2,0},Smooth=true})
			end--if
		else--assume base game... 
			if not Game.AI.Active then printToAll("Suggesting Imperial Base Game Setup...",{1,1,0}) end--if			
			--Fleet1 (Subjugation)-------------------------------------------------------------------------------- 
			--Saleucami,Rodia,Mandalore
			if Locations["SALEUCAMI"].Loyalty == "Imperial" or Locations["SALEUCAMI"].Subjugated then
				table.insert(Fleets,"SALEUCAMI")
			elseif Locations["RODIA"].Loyalty == "Imperial" or Locations["RODIA"].Subjugated then
				table.insert(Fleets,"RODIA")
			else--must be mandalore   
				table.insert(Fleets,"MANDALORE")
			end--if
			coroutine.yield(0)
			printToAll("Imperial Fleet1 (Subjugation) starts in "..Fleets[1])
			if Fleets[1] == "SALEUCAMI" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="SALEUCAMI",Position={-11.45,2,6.4},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="SALEUCAMI",Position={-10.4,2,6},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-11,2,5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-10.5,2,5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-10,2,5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="SALEUCAMI",Position={-9,2,5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="SALEUCAMI",Position={-8.5,2,5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-9.5,2,4.6},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-9,2,4.6},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-8.5,2,4.6},Smooth=true})
			elseif Fleets[1] == "RODIA" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="RODIA",Position={7,2,6.5},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="RODIA",Position={8,2,6.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={5,2,7},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={5.5,2,7},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={6,2,7},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="RODIA",Position={5.5,2,5.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="RODIA",Position={6,2,5.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5,2,5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5.5,2,5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={6,2,5},Smooth=true})
			elseif Fleets[1] == "MANDALORE" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="MANDALORE",Position={-9,2,0},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="MANDALORE",Position={-10,2,0},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-9,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-8.5,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-8,2,-1.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-2.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MANDALORE",Position={-6.5,2,-2.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7.5,2,-3},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-3},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-6.5,2,-3},Smooth=true})
			end--if
			coroutine.yield(0)
			--Fleet2 (Subjugation)----------------------------------------------------------------------------------
			--Rodia (if F1 in Saleucami), Mandalore (if F1 in Rodia), MyGeeto (if F1 in Rodia), Sullust, Mustafar
			if (Locations["RODIA"].Loyalty == "Imperial" or Locations["RODIA"].Subjugated) and Fleets[1] == "SALEUCAMI" then
				table.insert(Fleets,"RODIA")
			elseif (Locations["MANDALORE"].Loyalty == "Imperial" or Locations["MANDALORE"].Subjugated) and Fleets[1] == "RODIA" then
				table.insert(Fleets,"MANDALORE")
			elseif (Locations["MYGEETO"].Loyalty == "Imperial" or Locations["MYGEETO"].Subjugated) and Fleets[1] == "RODIA" then
				table.insert(Fleets,"MYGEETO")
			elseif (Locations["SULLUST"].Loyalty == "Imperial" or Locations["SULLUST"].Subjugated) then
				table.insert(Fleets,"SULLUST")
			else--assume mustafar...
				table.insert(Fleets,"MUSTAFAR")
			end--if
			coroutine.yield(0)
			printToAll("Imperial Fleet2 (Subjugation) starts in "..Fleets[2])
			if Fleets[2] == "RODIA" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="RODIA",Position={7,2,6.5},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="RODIA",Position={8,2,6.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={5,2,7},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={5.5,2,7},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={6,2,7},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="RODIA",Position={5.5,2,5.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="RODIA",Position={6,2,5.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5,2,5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5.5,2,5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={6,2,5},Smooth=true})
			elseif Fleets[2] == "MANDALORE" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="MANDALORE",Position={-9,2,0},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="MANDALORE",Position={-10,2,0},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-9,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-8.5,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-8,2,-1.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-2.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MANDALORE",Position={-6.5,2,-2.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7.5,2,-3},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-3},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-6.5,2,-3},Smooth=true})
			elseif Fleets[2] == "MYGEETO" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="MYGEETO",Position={-12.5,2,-6},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="MYGEETO",Position={-11.5,2,-6},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MYGEETO",Position={-11,2,-5.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MYGEETO",Position={-10.5,2,-5.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MYGEETO",Position={-10,2,-5.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MYGEETO",Position={-14.5,2,-5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MYGEETO",Position={-14,2,-5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MYGEETO",Position={-15,2,-5.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MYGEETO",Position={-14.5,2,-5.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MYGEETO",Position={-15,2,-5.5},Smooth=true})
			elseif Fleets[2] == "SULLUST" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="SULLUST",Position={6,2,-2.5},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="SULLUST",Position={7,2,-2.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SULLUST",Position={6.5,2,-4},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SULLUST",Position={7,2,-4},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SULLUST",Position={7.5,2,-4},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="SULLUST",Position={9,2,-3},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="SULLUST",Position={9.5,2,-3},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SULLUST",Position={8.5,2,-3.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SULLUST",Position={9,2,-3.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SULLUST",Position={9.5,2,-3.5},Smooth=true})
			elseif Fleets[2] == "MUSTAFAR" then
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="MUSTAFAR",Position={15.25,2,-2},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="MUSTAFAR",Position={14.5,2,-3},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MUSTAFAR",Position={15.5,2,-3.2},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MUSTAFAR",Position={16,2,-3.2},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MUSTAFAR",Position={16.5,2,-3.2},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MUSTAFAR",Position={17,2,-0.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="MUSTAFAR",Position={17.5,2,-0.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MUSTAFAR",Position={16.5,2,-1},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MUSTAFAR",Position={17,2,-1},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MUSTAFAR",Position={17.5,2,-1},Smooth=true})
			end--if
			coroutine.yield(0)
			--Fleet3 (Death Star/Reinforcement)---------------------------------------------------------------------------
			--MC+KA: Mandalore, Saleucami, Rodia
			--ELSE: Sullust, Rodia, Mandalore
			if Locations["KASHYYYK"].Loyalty == "Rebel" and Locations["MON CALAMARI"].Loyalty == "Rebel" then
				if Locations["MANDALORE"].Loyalty == "Imperial" or Locations["MANDALORE"].Subjugated then
					Fleets[3] = "MANDALORE"
				elseif Locations["SALEUCAMI"].Loyalty == "Imperial" or Locations["SALEUCAMI"].Subjugated then
					Fleets[3] = "SALEUCAMI"
				elseif Locations["RODIA"].Loyalty == "Imperial" or Locations["RODIA"].Subjugated then
					Fleets[3] = "RODIA"
				end--if
			else--assume strong right side... 
				if Locations["SULLUST"].Loyalty == "Imperial" or Locations["SULLUST"].Subjugated then
					Fleets[3] = "SULLUST"
				elseif Locations["RODIA"].Loyalty == "Imperial" or Locations["RODIA"].Subjugated then
					Fleets[3] = "RODIA"
				elseif Locations["MANDALORE"].Loyalty == "Imperial" or Locations["MANDALORE"].Subjugated then
					Fleets[3] = "MANDALORE"
				end--if
			end--if
			coroutine.yield(0)
			printToAll("Imperial Fleet3 (Death Star Reinforcement) starts in "..Fleets[3])
			if Fleets[3] == "MANDALORE" then
				--table.insert(Fleets,"MANDALORE")
				MoveUnit({Name="Death Star",FromLocation="",ToLocation="MANDALORE",Position={-8,2,1},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-7.5,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-1.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="MANDALORE",Position={-6.5,2,-1.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7.5,2,-3.5},Smooth=true})
			elseif Fleets[3] == "SULLUST" then
				--table.insert(Fleets,"SULLUST")
				MoveUnit({Name="Death Star",FromLocation="",ToLocation="SULLUST",Position={11,2,-4},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SULLUST",Position={6.5,2,-3.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SULLUST",Position={7,2,-3.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SULLUST",Position={7.5,2,-3.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SULLUST",Position={8.5,2,-4},Smooth=true})
			elseif Fleets[3] == "RODIA" then
				--table.insert(Fleets,"RODIA")
				MoveUnit({Name="Death Star",FromLocation="",ToLocation="RODIA",Position={4.25,2,6.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={5,2,6.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={5.5,2,6.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="RODIA",Position={6,2,6.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5,2,5.5},Smooth=true})
			elseif Fleets[3] == "SALEUCAMI" then
				--table.insert(Fleets,"SALEUCAMI")
				MoveUnit({Name="Death Star",FromLocation="",ToLocation="SALEUCAMI",Position={-10.5,2,7.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-11,2,4.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-10.5,2,4.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="SALEUCAMI",Position={-10,2,4.5},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-9,2,4},Smooth=true})
			end--if
			coroutine.yield(0)
			--if fleet3 did not reinforce another fleet...
			if Fleets[1] != Fleets[3] and Fleets[2] != Fleets[3] then
				if Fleets[3] == "MANDALORE" then
					MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-3.5},Smooth=true})
				elseif Fleets[3] == "SULLUST"then
					MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SULLUST",Position={9,2,-4},Smooth=true})
				elseif Fleets[3] == "RODIA"then
					MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5.5,2,5.5},Smooth=true})
				elseif Fleets[3] == "SALEUCAMI"then
					MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-9.5,2,4},Smooth=true})
				end--if
			end--if
			coroutine.yield(0)
			--Fleet4 (Defense)-------------------------------------------------------------------------------------------------
			--Corellia (if Subjugation Fleet in Mandalore and Sullust not Imperial), Coruscant
			--if (Fleets[1] == "MANDALORE" or Fleets[2] == "MANDALORE") and not (Locations["SULLUST"].Loyalty == "Imperial" or Locations["SULLUST"].Subjugated) then
				--table.insert(Fleets,"CORELLIA")
				--MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="CORELLIA",Position={6,2,-5.5},Smooth=true})
				--MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="CORELLIA",Position={7,2,-5.6},Smooth=true})
				--MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORELLIA",Position={4,2,-7},Smooth=true})
				--MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORELLIA",Position={4.5,2,-7},Smooth=true})
				--MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORELLIA",Position={5,2,-7},Smooth=true})
				--MoveUnit({Name="AT-AT",FromLocation="",ToLocation="CORELLIA",Position={8.5,2,-8},Smooth=true})
				--MoveUnit({Name="AT-ST",FromLocation="",ToLocation="CORELLIA",Position={7.5,2,-7.5},Smooth=true})
				--MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORELLIA",Position={7,2,-8},Smooth=true})
				--MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORELLIA",Position={7.5,2,-8},Smooth=true})
			--else--must be coruscant...
				table.insert(Fleets,"CORUSCANT")
				MoveUnit({Name="Star Destroyer",FromLocation="",ToLocation="CORUSCANT",Position={-0.5,2,-8.5},Smooth=true})
				MoveUnit({Name="Assault Carrier",FromLocation="",ToLocation="CORUSCANT",Position={-1.5,2,-8.5},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORUSCANT",Position={-1,2,-10},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORUSCANT",Position={-0.5,2,-10},Smooth=true})
				MoveUnit({Name="TIE Fighter",FromLocation="",ToLocation="CORUSCANT",Position={0,2,-10},Smooth=true})
				MoveUnit({Name="AT-AT",FromLocation="",ToLocation="CORUSCANT",Position={3,2,-8.5},Smooth=true})
				MoveUnit({Name="AT-ST",FromLocation="",ToLocation="CORUSCANT",Position={2,2,-8},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORUSCANT",Position={1.5,2,-9},Smooth=true})
				MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORUSCANT",Position={2,2,-9},Smooth=true})
			--end--if
		end--if
		coroutine.yield(0)
		printToAll("Imperial Fleet4 (Home Defense) starts in "..Fleets[4])
		--place 1 stormtrooper on remaining systems... 
		if Locations["CORUSCANT"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORUSCANT",Position={2,2,-8.5},Smooth=true})
		end--if
		coroutine.yield(0)
		if (Locations["CORELLIA"].Loyalty == "Imperial" or Locations["CORELLIA"].Subjugated) and Locations["CORELLIA"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="CORELLIA",Position={8,2,-8},Smooth=true})
		end--if
		coroutine.yield(0)
		if (Locations["MUSTAFAR"].Loyalty == "Imperial" or Locations["MUSTAFAR"].Subjugated) and Locations["MUSTAFAR"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MUSTAFAR",Position={17,2,-1},Smooth=true})
		end--if
		coroutine.yield(0)
		if (Locations["SULLUST"].Loyalty == "Imperial" or Locations["SULLUST"].Subjugated) and Locations["SULLUST"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SULLUST",Position={9,2,-3.5},Smooth=true})
		end--if
		coroutine.yield(0)
		if (Locations["MYGEETO"].Loyalty == "Imperial" or Locations["MYGEETO"].Subjugated) and Locations["MYGEETO"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MYGEETO",Position={-15,2,-6},Smooth=true})
		end--if
		coroutine.yield(0)
		if (Locations["MANDALORE"].Loyalty == "Imperial" or Locations["MANDALORE"].Subjugated) and Locations["MANDALORE"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="MANDALORE",Position={-7,2,-3},Smooth=true})
		end--if
		coroutine.yield(0)
		if (Locations["RODIA"].Loyalty == "Imperial" or Locations["RODIA"].Subjugated) and Locations["RODIA"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="RODIA",Position={5.5,2,5},Smooth=true})
		end--if
		coroutine.yield(0)
		if (Locations["SALEUCAMI"].Loyalty == "Imperial" or Locations["SALEUCAMI"].Subjugated) and Locations["SALEUCAMI"].Units.Imperial.Ground < 1 then
			MoveUnit({Name="Stormtrooper",FromLocation="",ToLocation="SALEUCAMI",Position={-9,2,4.5},Smooth=true})
		end--if
		coroutine.yield(0)
		return 1
	end--function 
	startLuaCoroutine(Global,"SuggestImperialSetupCoroutine")
end--if

function UpdateImperialProbeMap(SystemName,StateID)
	for S,Scan in pairs(Physics.cast({origin=Locations[SystemName].LogSpot,direction={0,1,0},size={0.5,0.5,0.5},type=3,orientation={0,0,0},max_distance=0,debug=false})) do 
		if Scan.hit_object.getName() != "Imperial Probe Map" and Scan.hit_object.type == "Tile" and Scan.hit_object.getStateId() > 0 then
			if Scan.hit_object.getStateId() != StateID and Scan.hit_object.getStateId() != 1 then 
				--only update to stormtrooper icon if it was not already probe icon... 
				if Scan.hit_object.getStateId() == 5 and StateID == 3 then
					--don't auto switch to stormtrooper if we have the probe card. 
				else--change the marker...
					Wait.frames(function() if Scan.hit_object != nil then Scan.hit_object.setState(StateID) end end,1)
				end--if
			end--if
			break
		end--if
	end--for S,Scan
end--function 

function onChat(message, player)
	message = string.upper(message)
	if message == "IMPERIAL_AI" then
		Game.AI.Active = not Game.AI.Active 
		if Game.AI.Active then
			print("Imperial AI is: Online.")
		else
			print("Imperial AI is: Offline.")
		end--if
	elseif message == "ANALYZE" or message == "THINK" then
		print("Check ~ log for results.")
    	AI_AnalyzeSystems()
		AI_AnalyzeFleets()
	elseif message == "REPCOUNT" then
		print("Current RepCount:",RepCount)
	elseif message == "FIXPROBEMAP" then
		startLuaCoroutine(Global,"TempFixProbeMapCoroutine")
	elseif string.find(message,"PING:") != nil then
		local ObjID = string.lower(string.gsub(message,"PING:",""))
		if getObjectFromGUID(ObjID) != nil then
			Ping({Object=getObjectFromGUID(ObjID)})
		else
			print("Could not location Object ID:",ObjID)
		end--if
	end--if
end--function 


function TempFixProbeMapCoroutine()--delete me later
	for L,Location in pairs(Locations) do
		if Location.LogSpot != nil then
			for S,Scan in pairs(Physics.cast({origin=Location.LogSpot,direction={0,1,0},size={0.5,0.5,0.5},type=3,orientation={0,0,0},max_distance=0,debug=true})) do 
				if Scan.hit_object.getGUID() != "828486" and Scan.hit_object.type == "Tile" and Scan.hit_object.getStateId() > 0 then
					local Obj = Scan.hit_object
					print(L)
					for I=1,6 do
						if Obj.getStateId() != I then 
							Obj = Obj.setState(I)
							coroutine.yield(0)
						end--if
						Obj.setName(L)
						Obj.setDescription("LogMarker;Imperial;")
						coroutine.yield(0)
					end--for I
					Obj.setState(2)
					coroutine.yield(0)
				end--if
			end--for S,Scan
		end--if has logspot
		coroutine.yield(0)
	end--for L,Location 
end--function 


function GetUnitStrength(UnitName)
	if Units[UnitName] == nil then
		return 0
	else
		return Units[UnitName].BlackDice + Units[UnitName].RedDice + Units[UnitName].GreenDice + Units[UnitName].Health
	end--if
end--function 

function AI_InitSystemsCoroutine()
	--call this function once when the AI is turned on... 
	log("AI is initializing Systems data...")
	printToAll("Imperial AI: Initializing systems data...",{0.5,0.5,1})
	Game.AI.Systems = nil
	Game.AI.Systems = {}
		--["systemname"] = {
			--Location = "",	--location name of the system (for easy access)
			--UnitIDs = {},	--table of imperial unit object ids in this system.
			--UnitCounts = {},	--count of specific units (legacy)
			--LeaderIDs = {}, --table of object ids for leaders in this system.
			--Score = {
				--Total = 0
				--Threat = {
					--Total = 0
					--Space = 0,	--total combat strength threat in space. 
					--Ground = 0,	--total combat strength threat on ground. 
				--},--threat	
				--Build = 0,	--build value score. 
				--Probe = 0,	--probe value score (increases as the # of rebel base candidates decreases). 
			--},--score
			--Fleets = {},	--table of keys in the Game.AI.Fleets table for fleets in this system. 
			--TargetedBy = {},	--table of keys in the Game.AI.Fleets table for fleets targeting this system. 
			--Patrol = {
				--Space = true,	--does this system need a TIE unit left behind?
				--Ground = false,  --does this system need a ground unit left behind?
			--Starting = true,	--is thsi system a starting imperial system? (won't ever have a probe card in the game).
			--},--
		--},
	--iterate through system locations...
	for L,LocationInfo in pairs(Locations) do
		if LocationInfo.Type == "System" then
			Game.AI.Systems[L] = {Location=L,UnitIDs={},LeaderIDs={},Score={Total=0,Threat={Total=0,Space=0,Ground=0},Build=0,Probe=0},Fleets={},TargetedBy={},Patrol={Space=false,Ground=false},Starting=false,UnitCounts={ST=0,AT=0,ATST=0,ATAT=0,SB=0,SctT=0,DthT=0,DrkT=0,TF=0,TS=0,TB=0,TI=0,TA=0,TD=0,AC=0,LSh=0,DSh=0,SD=0,ID=0,LC=0,SSD=0,DSUC=0,DS=0,RT=0,RV=0,RR=0,AS=0,GAT=0,WV=0,JK=0,SG=0,IC=0,XW=0,YW=0,UW=0,GR75=0,AW=0,BW=0,LF=0,CC=0,NBF=0,HC=0,MCC=0,EC=0,MC75=0,MC80=0}}
			if L == "CORUSCANT" or SearchTable(Game.Systems.Imperial,L) > 0 then
				Game.AI.Systems[L].Starting = true
			end--if
		end--if
	end--for L,LocationInfo 
	return 1
end--function 

function AI_AssignMissionsCoroutine()
	--ai assigns imperial missions... 
	printToAll("Imperial AI: I am thinking about mission assignments...",{0.5,0.5,1})
	Game.AI.LeaderPool = GetLeadersInPool({Faction="Imperial"})
	log("AI: There are "..#Game.AI.LeaderPool.." Leaders in the Imperial Pool.")--AIDebug.
	Game.AI.AssignableMissions = #Game.AI.LeaderPool - Game.AI.FleetCount
	AI_AnalyzeSystems()
	AI_AnalyzeFleets()
	local MissionLimit = 1
	local MissionCount = 0
	--Always assign Fear Will Keep Them In Line if we have it...
	if CardInHand({Player="Blue",Index=Hands.ImperialMission.Index,Name="FEAR WILL KEEP THEM IN LINE"}) then
		if AI_AssignImperialMission({Leader={"Grand Moff Tarkin","Jabba the Hutt","Janus Greejatus","Emperor Palpatine"},Mission="FEAR WILL KEEP THEM IN LINE"}) then
			MissionCount = MissionCount + 1
			coroutine.yield(0)
		end--if success
	end--if FWKTIL
	--opening move? (round 1)
	if Game.Round == 1 then
		if Game.Systems.DSUC == "Dagobah" then 
			MissionLimit = 0
		elseif Game.AI.Systems["ORD MANTELL"].Score.Threat.Total >= 5 or Game.AI.Systems["ALDERAAN"].Score.Threat.Total >= 5 or Game.AI.Systems["CORELLIA"].Score.Threat.Total >= 5 then
			MissionLimit = 0
		end--if
	else--game round > 1... 
		--Brilliant Administrator?
		if CardInHand({Player="Blue",Index=Hands.ImperialAction.Index,Name="BRILLIANT ADMINISTRATOR"}) then
			AI_PlayActionCard({Card="BRILLIANT ADMINISTRATOR",Leader={"Grand Moff Tarkin"}})
			coroutine.yield(0)
		end--if brilliant admin. 

	end--if round 1
	log("AI: I will assign up to "..Game.AI.AssignableMissions.." Mission(s).")--AIDebug.
	--Imperial Propaganda?
	if MissionCount < MissionLimit and CardInHand({Player="Blue",Index=Hands.ImperialMission.Index,Name="IMPERIAL PROPAGANDA"}) then
		if AI_AssignImperialMission({Leader={"Janus Greejatus","Jabba the Hutt","Emperor Palpatine"},Mission="IMPERIAL PROPAGANDA"}) then
			Game.AI.AssignableMissions = Game.AI.AssignableMissions - 1
			coroutine.yield(0)
		end--if success
	end--if IP
	--Display of Power?
	if MissionCount < MissionLimit and CardInHand({Player="Blue",Index=Hands.ImperialMission.Index,Name="DISPLAY OF POWER"}) then
		if AI_AssignImperialMission({Leader={"Jabba the Hutt","Emperor Palpatine"},Mission="DISPLAY OF POWER"}) then
			Game.AI.AssignableMissions = Game.AI.AssignableMissions - 1
			coroutine.yield(0)
		end--if success
	end--if DoP
	--Trade Negotiations?
	if MissionCount < MissionLimit and CardInHand({Player="Blue",Index=Hands.ImperialMission.Index,Name="TRADE NEGOTIATIONS"}) then
		if AI_AssignImperialMission({Leader={"Jabba the Hutt","Janus Greejatus","Emperor Palpatine"},Mission="TRADE NEGOTIATIONS"}) then
			Game.AI.AssignableMissions = Game.AI.AssignableMissions - 1
			coroutine.yield(0)
		end--if success
	end--if TN
	--Gather Intel?
	if Game.AI.AssignableMissions > 0 and Locations["REBEL BASE"].Units.Rebel.Space + Locations["REBEL BASE"].Units.Rebel.Ground >= 8 then
		if AI_AssignImperialMission({Leader={"Boba Fett","Jabba the Hutt","Janus Greejatus","Colonel Yularen","Admiral Piett","Director Krennic","Grand Moff Tarkin","Admiral Ozzel","Soontir Fel","Admiral Motti"},Mission="GATHER INTEL"}) then
			Game.AI.AssignableMissions = Game.AI.AssignableMissions - 1
			coroutine.yield(0)
		end--if success
	end--if GI
	--Construct Factory?
	if Game.AI.AssignableMissions > 0 and CardInHand({Player="Blue",Index=Hands.ImperialMission.Index,Name="CONSTRUCT FACTORY"}) and #GetSystemList({Sabotaged=true,Faction="Imperial",Destroyed=false}) > 0 then
		if AI_AssignImperialMission({Leader={"Admiral Motti","Admiral Ozzel","General Tagge","Moff Jerjerrod","Grand Moff Tarkin","Director Krennic","Grand Admiral Thrawn"},Mission="CONSTRUCT FACTORY"}) then
			Game.AI.AssignableMissions = Game.AI.AssignableMissions - 1
			coroutine.yield(0)
		end--if success
	end--if CF
	--Research and Development?
	if Game.AI.AssignableMissions > 0 and #GetSystemList({Sabotaged=true,Loyalty="Imperial",Destroyed=false}) > 0 then
		if AI_AssignImperialMission({Leader={"Admiral Motti","Admiral Ozzel","General Tagge","Moff Jerjerrod","Grand Moff Tarkin"},Mission="RESEARCH AND DEVELOPMENT"}) then
			Game.AI.AssignableMissions = Game.AI.AssignableMissions - 1
			coroutine.yield(0)
		end--if success
	end--if RaD
	--Intercept Transmission?{0.5,0.5,1}
	--Planetary Conquest?
	--Single Reaction Ignition?
	--Superlaser Online?
	--Construct Super Star Destroyer?
	--Construct Interdictor?
	--continue the game... 
	for D=1,99 do coroutine.yield(0) end--for D
	printToAll("Imperial AI: I have finished my Assignment Phase.",{0.5,0.5,1}) 
	AssignmentsComplete()
	return 1
end--function

function AI_CommandCoroutine()
	printToAll("Imperial AI: I am thinking about my Command Phase turn...",{0.5,0.5,1})
	coroutine.yield(0)
	AI_AnalyzeSystems()
	coroutine.yield(0)
	AI_AnalyzeFleets()
	coroutine.yield(0)
	--activation, action card, or mission?
	--GATHER INTEL? if 8+ units in the Rebel Base do it now... 
	--DEFEND THE CORE (any adjacent core system with 5+ rebel units)...

	--SUBJUGATE ADJACENT REBEL LOYAL SYSTEMS...
	--SUBJUGATE ADJACENT BLUE SQUARE SYSTEMS (Utapau->Mon Calamari->Corellia)... 
	--BLOCKADE ADJACENT REBEL LOYAL SYSTEMS... 
	--DEFEND THE GALAXY... (Any adjacent systems with 5+ rebel units)
	--BLOCKADE ADJACENT BLUE SQUARE SYSTEMS... 
	--ADVANCE ON DISTANT HIGH VALUE TARGET SYSTEMS... 	
	--ANY VALID UNREVEALED MISSIONS?

	return 1
end--function 

function AI_AnalyzeSystems()
	--is Imperial AI on?
	if Game.AI.Active then
		log("Imperial AI is analyzing Systems data...")
		printToAll("Imperial AI: I am analyzing Systems data...",{0.5,0.5,1})
		Game.AI.LeaderPool = GetLeadersInPool({Faction="Imperial"})
		local KnownBase = ""
		UpdateBoard(false)
		--coroutine.yield(0)
		Game.AI.BaseCandidates = GetRebelBaseCandidates()
		log("AI: There are "..#Game.AI.BaseCandidates.." candidate systems for the Rebel Base.")--AIDebug
		--if rebel base location known?
		if IsBaseRevealed() then
			KnownBase = GetBaseLocation()
		elseif #Game.AI.BaseCandidates == 1 then
			KnownBase = Game.AI.BaseCandidates[1]
		end--if
		if KnownBase != "" then
			log("AI: I know the Rebel Base is on "..KnownBase.."!")--AIDebug
		end--if
		--iterate through system locations...
		for S,System in pairs(Game.AI.Systems) do
			--calc probe score... 
			if not Locations[S].Probed and not Locations[S].Scanned and not Locations[S].Subjugated and Locations[S].Loyalty != "Imperial" then
				System.Score.Probe = 32-#Game.AI.BaseCandidates
			end--if not probed/scanned
			--calc build score... 
			System.Score.Build = 0
			for I=1,#Locations[S].Build.Icons do 
				--ignore subjugated, imperial loyal, destroyed, and sabotaged systems... 
				if Locations[S].Loyalty != "Imperial" and Locations[S].Subjugated == false and Locations[S].Destroyed == false and Locations[S].Sabotaged == false then
					if Locations[S].Build.Icons[I] == "OT" then
						System.Score.Build = System.Score.Build + 1
					elseif Locations[S].Build.Icons[I] == "OC" then
						System.Score.Build = System.Score.Build + 2
					elseif Locations[S].Build.Icons[I] == "OS" then
						System.Score.Build = System.Score.Build + 4
					elseif Locations[S].Build.Icons[I] == "BT" then
						System.Score.Build = System.Score.Build + 2
					elseif Locations[S].Build.Icons[I] == "BC" then
						System.Score.Build = System.Score.Build + 3
					elseif Locations[S].Build.Icons[I] == "BS" then
						System.Score.Build = System.Score.Build + 5
					end--if build icons?
				end--if not an imperial system. 
			end--for I
			if Locations[S].Loyalty == "Rebel" and not Locations[S].Subjugated and not Locations[S].Blockaded and not Locations[S].Destroyed then
				System.Score.Build = System.Score.Build + 20
			end--if rebel loyal?
			--total score so far... 
			System.Score.Total = System.Score.Probe + System.Score.Build + System.Score.Threat.Total	--not the final score yet. 
		end--for S,System
		--coroutine.yield(0)
		--iterate through units and leaders in play... 
		for O,Obj in pairs(getAllObjects()) do 
			local Location = Obj.getVar("Location")
			if Obj.getDescription() == nil then Obj.setDescription("")  end--if
			if string.find(Obj.getDescription(),"Unit;") != nil then
				if Game.AI.Systems[Location] != nil then
					Obj.setVar("Role","")--init role
					Obj.setVar("Fleet","")--init fleet
					if Units[Obj.getName()].Faction == "Rebel" then 
						if Units[Obj.getName()].Theater == "Space" then
							Game.AI.Systems[Location].Score.Threat.Space = Game.AI.Systems[Location].Score.Threat.Space + GetUnitStrength(Obj.getName())
						else--assume ground 
							Game.AI.Systems[Location].Score.Threat.Ground = Game.AI.Systems[Location].Score.Threat.Ground + GetUnitStrength(Obj.getName())
						end--if space/ground?
						Game.AI.Systems[Location].Score.Threat.Total = Game.AI.Systems[Location].Score.Threat.Space + Game.AI.Systems[Location].Score.Threat.Ground 
						Game.AI.Systems[Location].Score.Total = Game.AI.Systems[Location].Score.Probe + Game.AI.Systems[Location].Score.Build + Game.AI.Systems[Location].Score.Threat.Total
					end--if rebel/imperial?
					if Obj.getName() == "Stormtrooper" then Game.AI.Systems[Location].UnitCounts.ST = Game.AI.Systems[Location].UnitCounts.ST + 1 end--if
					if Obj.getName() == "AT-ST" then Game.AI.Systems[Location].UnitCounts.ATST = Game.AI.Systems[Location].UnitCounts.ATST + 1 end--if
					if Obj.getName() == "AT-AT" then Game.AI.Systems[Location].UnitCounts.ATAT = Game.AI.Systems[Location].UnitCounts.ATAT + 1 end--if
					if Obj.getName() == "Assault Tank" then Game.AI.Systems[Location].UnitCounts.AT = Game.AI.Systems[Location].UnitCounts.AT + 1 end--if
					if Obj.getName() == "Shield Bunker" then Game.AI.Systems[Location].UnitCounts.SB = Game.AI.Systems[Location].UnitCounts.SB + 1 end--if
					if Obj.getName() == "Scout Trooper" then Game.AI.Systems[Location].UnitCounts.SctT = Game.AI.Systems[Location].UnitCounts.SctT + 1 end--if
					if Obj.getName() == "Death Trooper" then Game.AI.Systems[Location].UnitCounts.DthT = Game.AI.Systems[Location].UnitCounts.DthT + 1 end--if
					if Obj.getName() == "Darktrooper" then Game.AI.Systems[Location].UnitCounts.DrkT = Game.AI.Systems[Location].UnitCounts.DrkT + 1 end--if
					if Obj.getName() == "TIE Fighter" then Game.AI.Systems[Location].UnitCounts.TF = Game.AI.Systems[Location].UnitCounts.TF + 1 end--if
					if Obj.getName() == "TIE Striker" then Game.AI.Systems[Location].UnitCounts.TS = Game.AI.Systems[Location].UnitCounts.TS + 1 end--if
					if Obj.getName() == "TIE Bomber" then Game.AI.Systems[Location].UnitCounts.TB = Game.AI.Systems[Location].UnitCounts.TB + 1 end--if
					if Obj.getName() == "TIE Interceptor" then Game.AI.Systems[Location].UnitCounts.TI = Game.AI.Systems[Location].UnitCounts.TI + 1 end--if
					if Obj.getName() == "TIE Advanced" then Game.AI.Systems[Location].UnitCounts.TA = Game.AI.Systems[Location].UnitCounts.TA + 1 end--if
					if Obj.getName() == "TIE Defender" then Game.AI.Systems[Location].UnitCounts.TD = Game.AI.Systems[Location].UnitCounts.TD + 1 end--if
					if Obj.getName() == "Assault Carrier" then Game.AI.Systems[Location].UnitCounts.AC = Game.AI.Systems[Location].UnitCounts.AC + 1 end--if
					if Obj.getName() == "Lambda Shuttle" then Game.AI.Systems[Location].UnitCounts.LSh = Game.AI.Systems[Location].UnitCounts.LSh + 1 end--if
					if Obj.getName() == "Delta Shuttle" then Game.AI.Systems[Location].UnitCounts.DSh = Game.AI.Systems[Location].UnitCounts.DSh + 1 end--if
					if Obj.getName() == "Star Destroyer" then Game.AI.Systems[Location].UnitCounts.SD = Game.AI.Systems[Location].UnitCounts.SD + 1 end--if
					if Obj.getName() == "Interdictor" then Game.AI.Systems[Location].UnitCounts.ID = Game.AI.Systems[Location].UnitCounts.ID + 1 end--if
					if Obj.getName() == "Light Cruiser" then Game.AI.Systems[Location].UnitCounts.LC = Game.AI.Systems[Location].UnitCounts.LC + 1 end--if
					if Obj.getName() == "Super Star Destroyer" then Game.AI.Systems[Location].UnitCounts.SSD = Game.AI.Systems[Location].UnitCounts.SSD + 1 end--if
					if Obj.getName() == "Death Star Under Construction" then Game.AI.Systems[Location].UnitCounts.DSUC = Game.AI.Systems[Location].UnitCounts.DSUC + 1 end--if
					if Obj.getName() == "Death Star" then Game.AI.Systems[Location].UnitCounts.DS = Game.AI.Systems[Location].UnitCounts.DS + 1 end--if
					if Obj.getName() == "Rebel Trooper" then Game.AI.Systems[Location].UnitCounts.RT = Game.AI.Systems[Location].UnitCounts.RT + 1 end--if
					if Obj.getName() == "Rebel Vanguard" then Game.AI.Systems[Location].UnitCounts.RV = Game.AI.Systems[Location].UnitCounts.RV + 1 end--if
					if Obj.getName() == "Airspeeder" then Game.AI.Systems[Location].UnitCounts.AS = Game.AI.Systems[Location].UnitCounts.AS + 1 end--if
					if Obj.getName() == "Wookiee Veteran" then Game.AI.Systems[Location].UnitCounts.WV = Game.AI.Systems[Location].UnitCounts.WV + 1 end--if
					if Obj.getName() == "Golan Arms Turret" then Game.AI.Systems[Location].UnitCounts.GAT = Game.AI.Systems[Location].UnitCounts.GAT + 1 end--if
					if Obj.getName() == "Jedi Knight" then Game.AI.Systems[Location].UnitCounts.JK = Game.AI.Systems[Location].UnitCounts.JK + 1 end--if
					if Obj.getName() == "Shield Generator" then Game.AI.Systems[Location].UnitCounts.SG = Game.AI.Systems[Location].UnitCounts.SG + 1 end--if
					if Obj.getName() == "Ion Cannon" then Game.AI.Systems[Location].UnitCounts.IC = Game.AI.Systems[Location].UnitCounts.IC + 1 end--if
					if Obj.getName() == "X-Wing" then Game.AI.Systems[Location].UnitCounts.XW = Game.AI.Systems[Location].UnitCounts.XW + 1 end--if
					if Obj.getName() == "Y-Wing" then Game.AI.Systems[Location].UnitCounts.YW = Game.AI.Systems[Location].UnitCounts.YW + 1 end--if
					if Obj.getName() == "U-Wing" then Game.AI.Systems[Location].UnitCounts.UW = Game.AI.Systems[Location].UnitCounts.UW + 1 end--if
					if Obj.getName() == "A-Wing" then Game.AI.Systems[Location].UnitCounts.AW = Game.AI.Systems[Location].UnitCounts.AW + 1 end--if
					if Obj.getName() == "B-Wing" then Game.AI.Systems[Location].UnitCounts.BW = Game.AI.Systems[Location].UnitCounts.BWTF + 1 end--if
					if Obj.getName() == "Rebel Transport" then Game.AI.Systems[Location].UnitCounts.GR75 = Game.AI.Systems[Location].UnitCounts.GR75 + 1 end--if
					if Obj.getName() == "Light Freighter" then Game.AI.Systems[Location].UnitCounts.LF = Game.AI.Systems[Location].UnitCounts.LF + 1 end--if
					if Obj.getName() == "Corellian Corvette" then Game.AI.Systems[Location].UnitCounts.CC = Game.AI.Systems[Location].UnitCounts.CC + 1 end--if
					if Obj.getName() == "Nebulon-B Frigate" then Game.AI.Systems[Location].UnitCounts.NBF = Game.AI.Systems[Location].UnitCounts.NBF + 1 end--if
					if Obj.getName() == "Hammerhead Corvette" then Game.AI.Systems[Location].UnitCounts.HC = Game.AI.Systems[Location].UnitCounts.HC + 1 end--if
					if Obj.getName() == "Mon Cala Cruiser" then Game.AI.Systems[Location].UnitCounts.MCC = Game.AI.Systems[Location].UnitCounts.MCC + 1 end--if
					if Obj.getName() == "Escort Carrier" then Game.AI.Systems[Location].UnitCounts.EC = Game.AI.Systems[Location].UnitCounts.EC + 1 end--if
					if Obj.getName() == "MC75 Cruiser" then Game.AI.Systems[Location].UnitCounts.MC75 = Game.AI.Systems[Location].UnitCounts.MC75 + 1 end--if
					if Obj.getName() == "MC80 Cruiser" then Game.AI.Systems[Location].UnitCounts.MC80 = Game.AI.Systems[Location].UnitCounts.MC80 + 1 end--if
					table.insert(Game.AI.Systems[Location].UnitIDs,Obj.getGUID())
				end--if location exists. 
			elseif string.find(Obj.getDescription(),"Leader;") != nil then
				if Game.AI.Systems[Location] != nil then
					if string.find(Obj.getDescription(),"Imperial;") != nil then
						Game.AI.Systems[Location].Locked = true
					end--if imperial leader present. 
					table.insert(Game.AI.Systems[Location].LeaderIDs,Obj.getGUID())
				end--if location exists. 
			end--if object is unit/leader? 
		end--for U,Unit
		--coroutine.yield(0)

		--display results... 
		for O,Obj in pairs(getAllObjects()) do
			if Obj.type == "3D Text" then
				Obj.destruct()
			end--if
		end--for O,Obj 
		for S,System in pairs(Game.AI.Systems) do
			local T = spawnObject({position={Locations[S].MarkerSpot[1],1,Locations[S].MarkerSpot[3]},type="3DText",rotation={90,0,0}})
			T.TextTool.setValue(tostring(System.Score.Total))
		end--for T,Target 
	end--if

end--function 

function AI_AnalyzeFleets()
	if Game.AI.Active then
		log("Imperial AI is analyzing Imperial forces...")
		printToAll("Imperial AI: I am analyzing my Imperial forces...",{0.5,0.5,1})
		Game.AI.Fleets = nil
		Game.AI.Fleets = {}
		Game.AI.FleetCount = 0
		Game.AI.LeaderPool = GetLeadersInPool({Faction="Imperial"})
		--inventory imperial fleets... 
		for S,System in pairs(Game.AI.Systems) do 
			if System.UnitCounts.DS + System.UnitCounts.SSD + System.UnitCounts.SD + System.UnitCounts.ID + System.UnitCounts.LC + System.UnitCounts.AC + System.UnitCounts.LSh + System.UnitCounts.DSh > 0 then
				--sort units by strength: strongest to weakest... 
				for P=1,#System.UnitIDs-1 do 
					for I=1,#System.UnitIDs-1 do 
						if GetUnitStrength(getObjectFromGUID(System.UnitIDs[I]).getName()) < GetUnitStrength(getObjectFromGUID(System.UnitIDs[I+1]).getName()) then
							local TempID = System.UnitIDs[I]
							System.UnitIDs[I] = System.UnitIDs[I+1]
							System.UnitIDs[I+1] = TempID
						end--if
					end--for I
				end--for P
				--ground patrol? (leave a ground unit behind for subjugation)
				if not Locations[S].Destroyed and not Locations[S].Sabotaged and Locations[S].Subjugated then 
					System.Patrol.Ground = true 
					for U=#System.UnitIDs,1,-1 do 
						if getObjectFromGUID(System.UnitIDs[U]) != nil then
							if getObjectFromGUID(System.UnitIDs[U]).getName() == "Shield Bunker" then
								System.UnitCounts.SB = System.UnitCounts.SB - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							elseif getObjectFromGUID(System.UnitIDs[U]).getName() == "Stormtrooper" then
								System.UnitCounts.ST = System.UnitCounts.ST - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							elseif getObjectFromGUID(System.UnitIDs[U]).getName() == "Scout Trooper" then
								System.UnitCounts.SctT = System.UnitCounts.SctT - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							elseif getObjectFromGUID(System.UnitIDs[U]).getName() == "Death Trooper" then
								System.UnitCounts.DthT = System.UnitCounts.DthT - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							elseif getObjectFromGUID(System.UnitIDs[U]).getName() == "Darktrooper" then
								System.UnitCounts.DrkT = System.UnitCounts.DdwrkT - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							elseif getObjectFromGUID(System.UnitIDs[U]).getName() == "Assault Tank" then
								System.UnitCounts.AT = System.UnitCounts.AT - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							elseif getObjectFromGUID(System.UnitIDs[U]).getName() == "AT-ST" then
								System.UnitCounts.ATST = System.UnitCounts.ATST - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							elseif getObjectFromGUID(System.UnitIDs[U]).getName() == "AT-AT" then
								System.UnitCounts.ATAT = System.UnitCounts.ATAT - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							end--if unit type is ground. 
						end--if unit object exists. 
					end--for U
				end--if ground patrol?
				--space patrol? (leave a TIE unit behind to block rebel base)
				if not Locations[S].Destroyed and SearchTable(Game.Systems.Imperial,S) == 0 then 
					System.SpacePatrol = true 
					for U=#System.UnitIDs,1,-1 do 
						if getObjectFromGUID(System.UnitIDs[U]) != nil then
							if getObjectFromGUID(System.UnitIDs[U]).getName() == "TIE Fighter" then
								System.UnitCounts.TF = System.UnitCounts.TF - 1 
								getObjectFromGUID(System.UnitIDs[U]).setVar("Role","Patrol")
								log(getObjectFromGUID(System.UnitIDs[U]).getName()..":"..getObjectFromGUID(System.UnitIDs[U]).getGUID().." is on patrol in "..S..".")
								table.remove(System.UnitIDs,U)
								break
							end--if unit type is ground. 
						end--if unit object exists. 
					end--for U
				end--if
				--determine # of possible fleets in this system... 
				local CapitalShips = System.UnitCounts.DS + System.UnitCounts.SSD + System.UnitCounts.SD + System.UnitCounts.ID + System.UnitCounts.LC + System.UnitCounts.AC + System.UnitCounts.LSh + System.UnitCounts.DSh 
				local GroundUnits = System.UnitCounts.ST+System.UnitCounts.SctT+System.UnitCounts.DthT+System.UnitCounts.DrkT+System.UnitCounts.AT+System.UnitCounts.ATST+System.UnitCounts.ATAT
				local FleetMax = CapitalShips
				if GroundUnits < CapitalShips then FleetMax = GroundUnits end--if
				log(S.." has "..FleetMax.." potential Fleets:")
				log(" "..CapitalShips.." Capital Ships.")
				log(" "..GroundUnits.." mobile Ground Units.")
				--assign fleet flagships (strongest capital ships have priority)... 
				for F=1,FleetMax do 
					for U=1,#System.UnitIDs do 
						local UnitObj = getObjectFromGUID(System.UnitIDs[U])
						if UnitObj.getVar("Role") == "" and UnitObj.getVar("Fleet") == "" and (Units[UnitObj.getName()].SubType == "Capital" or UnitObj.getName() == "Death Star") then 
							Game.AI.Fleets[UnitObj.getGUID()] = {FlagShipID=UnitObj.getGUID(),System=S,UnitIDs={UnitObj.getGUID()},Target="",Strength={Total=0,Space=0,Ground=0},Capacity=0,Cargo=0,Locked=System.Locked}
							table.insert(System.Fleets,UnitObj.getGUID())
							UnitObj.setVar("Role","Flagship")
							UnitObj.setVar("Fleet",UnitObj.getGUID())
							Game.AI.FleetCount = Game.AI.FleetCount + 1
							Game.AI.Fleets[UnitObj.getGUID()].Capacity = Units[UnitObj.getName()].Transport
							Game.AI.Fleets[UnitObj.getGUID()].Strength.Space = GetUnitStrength(UnitObj.getName())
							Game.AI.Fleets[UnitObj.getGUID()].Strength.Total = Game.AI.Fleets[UnitObj.getGUID()].Strength.Space + Game.AI.Fleets[UnitObj.getGUID()].Strength.Ground
							log("  "..UnitObj.getName()..":"..UnitObj.getGUID().." is Flagship "..F.." of "..S..".")
							break
						end--if
					end--for U
					log("There are now "..Game.AI.FleetCount.." Imperial Fleets.")
				end--for F
				--coroutine.yield(0)
				--add any remaining capital ships round-robin to fleets... 
				local F = 1
				for U=#System.UnitIDs,1,-1 do 
					local UnitObj = getObjectFromGUID(System.UnitIDs[U])
					if UnitObj != nil then
						if UnitObj.getVar("Role") == "" and UnitObj.getVar("Fleet") == "" and (Units[UnitObj.getName()].SubType == "Capital" or UnitObj.getName() == "Death Star") then
							Game.AI.Fleets[System.Fleets[F]].Capacity = Game.AI.Fleets[System.Fleets[F]].Capacity + Units[UnitObj.getName()].Transport
							Game.AI.Fleets[UnitObj.getGUID()].Strength.Space = Game.AI.Fleets[UnitObj.getGUID()].Strength.Space + GetUnitStrength(UnitObj.getName())
							Game.AI.Fleets[UnitObj.getGUID()].Strength.Total = Game.AI.Fleets[UnitObj.getGUID()].Strength.Space + Game.AI.Fleets[UnitObj.getGUID()].Strength.Ground
							UnitObj.setVar("Fleet",System.Fleets[F])
							table.insert(Game.AI.Fleets[System.Fleets[F]].UnitIDs,UnitObj.getGUID())
							log("  Added "..UnitObj.getName()..":"..UnitObj.getGUID().." to Fleet:"..System.Fleets[F]..".")
							F = F + 1
							if F > #System.Fleets then F = 1 end--if
						end--if
					end--if
				end--for U
				--coroutine.yield(0)
				--add any remaining mobile ground and TIEs round-robin to fleets until at capacity or no more to load up... 
				F = 1
				for U=1,#System.UnitIDs do 
					--are all fleets at capacity?
					local UnitObj = getObjectFromGUID(System.UnitIDs[U])
					if UnitObj != nil then
						if UnitObj.getVar("Role") == "" and UnitObj.getVar("Fleet") == "" then
							local Attempts = #System.Fleets
							if F > #System.Fleets then F = 1 end--if
							RepCount = RepCount + 1
							while Attempts > 0 and Game.AI.Fleets[System.Fleets[F]].Cargo >= Game.AI.Fleets[System.Fleets[F]].Capacity do
								--coroutine.yield(0)
								Attempts = Attempts - 1
								F = F + 1
								if F > #System.Fleets then F = 1 end--if
							end--while no capacity. 
							RepCount = RepCount - 1
							--current fleet has room?
							print("F=",F,"; U=",U,";")
							if Game.AI.Fleets[System.Fleets[F]].Cargo <= Game.AI.Fleets[System.Fleets[F]].Capacity then
								UnitObj.setVar("Fleet",System.Fleets[F])
								table.insert(Game.AI.Fleets[System.Fleets[F]].UnitIDs,UnitObj.getGUID())
								log("  Added "..UnitObj.getName()..":"..UnitObj.getGUID().." to Fleet "..System.Fleets[F]..".")
								Game.AI.Fleets[System.Fleets[F]].Cargo = Game.AI.Fleets[System.Fleets[F]].Cargo + 1
								Game.AI.Fleets[System.Fleets[F]].Strength.Ground = Game.AI.Fleets[System.Fleets[F]].Strength.Ground + GetUnitStrength(UnitObj.getName())
								Game.AI.Fleets[System.Fleets[F]].Strength.Total = Game.AI.Fleets[System.Fleets[F]].Strength.Space + Game.AI.Fleets[System.Fleets[F]].Strength.Ground
								F = F + 1
								if F > #System.Fleets then F = 1 end--if
							end--if open capacity. 
							if Attempts < 1 then 
								log("No more Fleets in "..S.." have capacity.")
								break 
							end--if
						end--if
					end--if
				end--for U
			end--if not leader locked and has imperial capital ship. 
		end--for S,System
	end--if AI is on. 
end--function 

function GetRebelBaseCandidates()
	local List = {}
	for L,LocationInfo in pairs(Locations) do 
		if LocationInfo.Type == "System" and not LocationInfo.Probed and not LocationInfo.Scanned and L != "CORUSCANT" then
			table.insert(List,L)
		end--if system 
	end--for L,LocationInfo
	return List
end--function 

function GetSystemList(Params)--{Faction="Imperial",Loyalty="Imperial",Subjugated=false,Destroyed=false,Blockaded=false,SubType="Populous"}
	local ReturnList = {}
	for I,Item in pairs(Locations) do 
		if Item.Type == "System" then
			local Match = true --until proven false... 
			if Params.Faction != nil then
				if Params.Faction == "Rebel" and Item.Loyalty != "Rebel" then Match = false end--if
				if Params.Faction == "Imperial" and Item.Loyalty != "Imperial" and Item.Subjugated == false then Match = false end--if
			end--if faction 
			if Params.Loyalty != nil then
				if Params.Loyalty != Item.Loyalty then Match = false end--if
			end--if
			if Params.Sabotaged != nil then
				if Params.Sabotaged != Item.Sabotaged then Match = false end--if
			end--if
			if Params.Subjugated != nil then
				if Params.Subjugated != Item.Subjugated then Match = false end--if
			end--if
			if Params.Destroyed != nil then
				if Params.Destroyed != Item.Destroyed then Match = false end--if
			end--if
			if Params.Blockaded != nil then
				if Params.Blockaded != Item.Blockaded then Match = false end--if
			end--if
			if Params.SubType != nil then
				if Params.SubType != Item.SubType then Match = false end--if
			end--if
			if Match then
				table.insert(ReturnList,I)
			end--if match 
		end--if
	end--for I,Item 
	return ReturnList
end--function 

function AI_AssignImperialMission(Params)--{Leader={"Grand Moff Tarkin","Jabba the Hutt","Janus Greejatus","Emperor Palpatine"},Mission="FEAR WILL KEEP THEM IN LINE"}
	log("AI_AssignImperialMission:"..Params.Mission)
	local Result = false
	local LeaderObj = nil
	local LeaderObjs = ScanForObjects({Description="Leader;",Origin={0,1.3,-20},Orientation={0,0,0},Size={10,1,7},Debug=false,Type=3})
	for L=1,#Params.Leader do 
		for LL = 1,#LeaderObjs do 
			if LeaderObjs[LL].getName() == Params.Leader[L] then
				LeaderObj = LeaderObjs[LL]
				break
			end--if
		end--for LL
		if LeaderObj != nil then break end--if
	end--for L 
	local CardObj = nil
	for C,Card in pairs(Player.Blue.getHandObjects(Hands.ImperialMission.Index)) do
		if Card.getName() == Params.Mission then
			CardObj = Card
			break 
		end--if
	end--for
	for Slot=1,9 do 
		if #ScanForObjects({Description="Card;",Origin={-11.25+2.25*Slot,0.71,-14.95},Orientation={0,0,0},Size={1,1,1},Debug=false,Type=3}) == 0 then
			if LeaderObj != nil then
				LeaderObj.setPositionSmooth({-11.25+2.25*Slot,0.71,-11.5},false,false)
				if CardObj != nil then
					CardObj.setPosition({-11.25+2.25*Slot,0.71,-14.95})
					CardObj.setRotation({0,180,180})
					Result = true
					break
				end--if card ok to assign. 
			end--if leader ok to assign. 
		end--if
	end--for Slot
	return Result
end--function 

function AI_PlayActionCard(Params)--{Card="",Leader={"",""}}
	log("AI_PlayActionCard:"..Params.Card)
	local Result = false
	local LeaderObj = nil
	local LeaderObjs = ScanForObjects({Description="Leader;",Origin={0,1.3,-20},Orientation={0,0,0},Size={10,1,7},Debug=false,Type=3})
	for L=1,#Params.Leader do 
		for LL = 1,#LeaderObjs do 
			if LeaderObjs[LL].getName() == Params.Leader[L] then
				LeaderObj = LeaderObjs[LL]
				break
			end--if
		end--for LL
		if LeaderObj != nil then break end--if
	end--for L 
	local CardObj = nil
	for C,Card in pairs(Player.Blue.getHandObjects(Hands.ImperialAction.Index)) do
		if Card.getName() == Params.Mission then
			CardObj = Card
			break 
		end--if
	end--for
	for Slot=1,8 do 
		if #ScanForObjects({Description="Card;",Origin={8.44+1.8*(Slot-1),0.71,-18.18},Orientation={0,0,0},Size={1,1,1},Debug=false,Type=3}) == 0 then
			if LeaderObj != nil then
				LeaderObj.setPositionSmooth({-8.44+1.8*(Slot-1),1,-18.18},false,false)
				if CardObj != nil then
					CardObj.setPosition({8.44+1.8*(Slot-1),0.71,-18.18})
					CardObj.setRotation({0,180,0})
					Ping({Position={8.44+1.8*(Slot-1),1,-18.18}})
					Result = true
					break
				end--if card ok to assign. 
			end--if leader ok to assign. 
		end--if
	end--for Slot
	return Result
end--function 

function AI_PlayMissionCard(Params)
end--function 