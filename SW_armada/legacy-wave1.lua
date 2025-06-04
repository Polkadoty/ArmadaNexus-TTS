-- https://github.com/Valadian/TabletopSimulatorIncludeDir/tree/master/TTS_armada/src/custom_db
-- How to use?
--
-- Option 1: Copy paste the contents of this file into the script on "ship db"
--     object. Then put your Ship/Squadron/Card definitions below.
--
-- Option 2: Use Atom with tabletopsimulator plugin
--     Checkout: https://github.com/Valadian/TabletopSimulatorIncludeDir
--     in your include dir.
--     Add the following line to the top of your object script:
--     #include TabletopSimulatorIncludeDir/TTS_armada/src/api/definitions
--
-- After performing the above, you should be able to load your definitions
--     database into the core Armada mod, and your ships/cards will work in
--     fleet spawner, upgrade list!
--
-- Definitions merge multiple tables to reduce duplication of common properties:
-- Examples of Card, Ship, Squadron definitions below.
--
--     Commander = {
--         type="Commander",
--         back = "https://i.imgur.com/fMJMaYo.png" } -- card back
--     Rebel = { factions={"Rebellion"} } -- factions must be a table for cards, since multi faction upgrades exist
--     Card:new(Commander,Rebel,{name="Admiral Ackbar",  front="http://i.imgur.com/HFVv48K.jpg", cost=38})
--
--     REBEL_SHIP = {
--         back = "https://i.imgur.com/vUaQViH.png",  -- card back
--         faction = "Rebellion" }
--     Ship:new(SmallShip,REBEL_SHIP,{
--         name = "GR-75 Medium Transports",
--         front = "https://i.imgur.com/vMgbQB3.png", --Card front image
--         mesh = "http://paste.ee/p/XZLIh",
--         diffuse = "http://i.imgur.com/2A2pAEI.png", -- model texture
--         ruler = "http://paste.ee/r/FSip2", -- custom ruler mesh
--         maneuver = {{"II"},{"I","II"},{"-","I","II"}},
--         defense_tokens = {DEF_SCATTER, DEF_EVADE},
--         shields = {1,1,1,1}, -- Front, left, right, rear
--         cost = 18,
--         aliases = {},
--         command = 1 -- Number of command dials
--     })
--
--     REBEL_SQUAD = {
--         back = "https://i.imgur.com/8s63Ngl.png", --card back
--         faction = "Rebellion"
--     }
--     ship = {
--         mesh = "http://paste.ee/r/ZqCC6",
--         diffuse = "http://i.imgur.com/QSLaqgW.png", --model texture
--         health = 5,
--         move = 2,
--         defense_tokens = {}}
--     Squadron:new(ship, REBEL_SQUAD, {
-- 	       name = "B-wing Squadron",
--         front = "https://i.imgur.com/bB11RGw.png", --card front
--         cost = 14,
--         aliases = {'B-wing Squadrons', "B-wing"}
--     })
--     Squadron:new(ship, REBEL_SQUAD, {
-- 	       name = "Keyan Farlander",
--         front = "https://i.imgur.com/r4bx4xg.png", --card front
--         diffuse = "http://i.imgur.com/r7YB80F.png", --model texture
--         defense_tokens = {DEF_BRACE,DEF_BRACE},
--         cost = 20
--     })
--

--LEGACY_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/ArmadaLegacyTTS-IncludeDir/master/assets/'
CARDS_LEGACY = 'https://raw.githubusercontent.com/eldrxdevelop/ArmadaLegacy/main/'
CUSTOM_ASSETS = '{verifycache}https://raw.githubusercontent.com/spacenavy90/ArmadaNexus-TTS/master/SW_armada/assets/'
ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
function onload()
	printToAll("Loading Armada Legacy wave 1 beta content...",{1,0.5,0})
    --UpdateCard("",,{cost = ,aliases={" [Rebalanced]"}})

-- ARMADA LEGACY WAVE 1 CONTENT 
    --republic ships
	REPUBLIC_SHIP = {
		back = CUSTOM_ASSETS.."ships/republic/card_back.jpg",
        faction = "!Republic"
    }

    Ship:new(SmallShip,REPUBLIC_SHIP, {
        name = "Arquitens-class Assault Cruiser",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/arquitens-class-assault-cruiser-republic-legacy-beta.jpg",
        mesh = CUSTOM_ASSETS.."ships/republic/arq_gar/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/republic/arq_gar/assault_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/republic/arq_gar/ruler.obj", 
        maneuver = {{"II"},{"-","II"},{"-","-","II"}},
        defense_tokens = {DEF_REDIRECT, DEF_SALVO, DEF_EVADE, DEF_EVADE},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 55,
        aliases = {"Arquitens-class Assault Cruiser [LegacyBeta]", "Arquitens-class Assault Cruiser [Legacy]"},
        command = 2
    })

    Ship:new(SmallShip,REPUBLIC_SHIP, {
        name = "Arquitens-class Escort Cruiser",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/arquitens-class-escort-cruiser-republic-legacy-beta.jpg",
        mesh = CUSTOM_ASSETS.."ships/republic/arq_gar/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/republic/arq_gar/escort_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/republic/arq_gar/ruler.obj", 
        maneuver = {{"II"},{"-","II"},{"-","-","II"}},
        defense_tokens = {DEF_REDIRECT, DEF_SALVO, DEF_EVADE, DEF_EVADE},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 60,
        aliases = {"Arquitens-class Escort Cruiser [LegacyBeta]", "Arquitens-class Escort Cruiser [Legacy]"},
        command = 2
    })

------------------------------------
    --separatist ships
    SEPARATIST_SHIP = {
        back =      CUSTOM_ASSETS.."ships/separatist/card_back.jpg",
        faction = "!Separatist"
    }

    Ship:new(SmallShip,SEPARATIST_SHIP, {
        name = "Pinnance-class Corsair",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/pinnance-class-corsair-legacy-beta.jpg",
        mesh = CUSTOM_ASSETS.."ships/separatist/pinnance/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/pinnance/pinnance_a_texture.jpg",
        ruler = CUSTOM_ASSETS.."ships/separatist/pinnance/ruler.obj", 
        maneuver = {{"II"},{"-","II"},{"-","II","I"},{"-","II","-","I"}},
        defense_tokens = {DEF_SALVO, DEF_EVADE, DEF_REDIRECT},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 41,
        aliases = {"Pinnance-class Corsair [LegacyBeta]", "Pinnance-class Corsair [Legacy]"},
        command = 1
        })

    Ship:new(SmallShip,SEPARATIST_SHIP, {
        name = "Pinnance-class Corsair",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/pinnance-class-corvette-legacy-beta.jpg",
        mesh = CUSTOM_ASSETS.."ships/separatist/pinnance/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/pinnance/pinnance_a_texture.jpg",
        ruler = CUSTOM_ASSETS.."ships/separatist/pinnance/ruler.obj", 
        maneuver = {{"II"},{"-","II"},{"-","II","I"},{"-","II","-","I"}},
        defense_tokens = {DEF_SALVO, DEF_EVADE, DEF_REDIRECT},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 44,
        aliases = {"Pinnance-class Corsair [LegacyBeta]", "Pinnance-class Corsair [Legacy]"},
        command = 1
        })

------------------------------------
    --empire squadrons
    EMPIRE_SQUAD = {
        back = CUSTOM_ASSETS.."squadrons/empire/card_back.jpg",
        faction = "!Empire"
    }

    defender = GetDefinition("TIE Defender Squadron",16)
    phantom = GetDefinition("TIE Phantom Squadron",14)


    Squadron:new(defender, EMPIRE_SQUAD, {
        name = "Dark Squadron",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/Dark_Squadron.jpg",
        --mesh = CUSTOM_ASSETS..".obj",
        diffuse = CUSTOM_ASSETS.."squadrons/empire/def/squad_diffuse.jpg",
        --defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 17,
        aliases = {"Dark Squadron [LegacyBeta]", "Dark Squadron [Legacy]"}
    })

    Squadron:new(phantom, EMPIRE_SQUAD, {
        name = "Shadow Squadron",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/Shadow_Squadron.jpg",
        --mesh = CUSTOM_ASSETS..".obj",
        diffuse = CUSTOM_ASSETS.."squadrons/empire/pha/squad_diffuse.jpg",
        --defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 16,
        aliases = {"Shadow Squadron [LegacyBeta]", "Shadow Squadron [Legacy]"}
    })

    ------------------------------------
    --rebel squadrons
    REBEL_SQUAD = {
        back = CUSTOM_ASSETS.."squadrons/rebel/card_back.jpg",
        faction = "!Rebellion" 
    }

    ewing = GetDefinition("E-wing Squadron",14)
    z95 = GetDefinition("Z-95 Headhunter Squadron",7)

    Squadron:new(ewing, REBEL_SQUAD, {
        name = "Nightmare Squadron",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/Nightmare_Squadron.jpg",
        --mesh = CUSTOM_ASSETS..".obj",
        diffuse = CUSTOM_ASSETS.."squadrons/rebel/ewing/squad_diffuse.jpg",
        --defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 16,
        aliases = {"Nightmare Squadron [LegacyBeta]", "Nightmare Squadron [LegacyBeta]"}
    })

    Squadron:new(z95, REBEL_SQUAD, {
        name = "Bandit Squadron",
        front = CUSTOM_ASSETS.."cards/.legacy/beta/Bandit_Squadron.jpg",
        --mesh = CUSTOM_ASSETS..".obj",
        diffuse = CUSTOM_ASSETS.."squadrons/rebel/z95/squad_diffuse.jpg",
        --defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 16,
        aliases = {"Bandit Squadron [LegacyBeta]", "Bandit Squadron [Legacy]"}
    })

------------------------------------
--new upgrade cards

Republic = {
    factions={"!Republic"}
}
Separatist = {
    factions={"!Separatist"}
}
CloneWars = {
    factions={"!Republic","!Separatist"}
}
Empire = {
    factions={"!Empire"}
}
Rebel = {
    factions={"!Rebellion"}
}

Commander = { type = "Commander", back = CUSTOM_ASSETS .. "cards/commander/back.jpg" }
DefensiveRetrofit = { type = "DefensiveRetrofit", back = CUSTOM_ASSETS .. "cards/defretro/back.jpg" }
FleetCommand = { type = "FleetCommand", back = CUSTOM_ASSETS .. "cards/fleetcom/back.jpg" }
FleetSupport = { type = "FleetSupport", back = CUSTOM_ASSETS .. "cards/fleetsup/back.jpg" }
IonCannons = { type = "IonCannons", back = CUSTOM_ASSETS .. "cards/ion/back.jpg" }
OffensiveRetrofit = { type = "OffensiveRetrofit", back = CUSTOM_ASSETS .. "cards/offretro/back.jpg" }
Officer = { type = "Officer", back = CUSTOM_ASSETS .. "cards/officer/back.jpg" }
SuperWeapon = { type = "SuperWeapon", back = CUSTOM_ASSETS .. "cards/super/back.jpg" }
SupportTeam = { type = "SupportTeam", back = CUSTOM_ASSETS .. "cards/support/back.jpg" }
Title = { type = "Title", back = CUSTOM_ASSETS .. "cards/title/back.jpg" }
WeaponsTeam = { type = "WeaponsTeam", back = CUSTOM_ASSETS .. "cards/wepteam/back.jpg" }

Card:new(Commander,Republic,{name="Admiral Coburn",  front = CUSTOM_ASSETS.."cards/.legacy/beta/admiral-coburn-commander-legacy-beta.jpg", cost=25, aliases={"Admiral Coburn [LegacyBeta]"}})
Card:new(Commander,Separatist,{name="Poggle the Lesser",  front = CUSTOM_ASSETS.."cards/.legacy/beta/poggle-the-lesser-commander-legacy-beta.jpg", cost=32, aliases={"Poggle the Lesser [LegacyBeta]"}})

Card:new(Title,Republic,{name="Arlionne",  front = CUSTOM_ASSETS.."cards/.legacy/beta/arlionne-title-legacy-beta.jpg", cost=7, aliases={"Arlionne [LegacyBeta]", "Arlionne [Legacy]"}})
Card:new(Title,Republic,{name="Open Circle Fleet",  front = CUSTOM_ASSETS.."cards/.legacy/beta/open-circle-fleet-title-legacy-beta.jpg", cost=5, aliases={"Open Circle Fleet [LegacyBeta]", "Open Circle Fleet [Legacy]"}})
Card:new(Title,Separatist,{name="Baktoid Combat Vessel",  front = CUSTOM_ASSETS.."cards/.legacy/beta/baktoid-combat-vessel-title-legacy-beta.jpg", cost=3, aliases={"Baktoid Combat Vessel [LegacyBeta]", "Baktoid Combat Vessel [Legacy]"}})
Card:new(Title,Separatist,{name="Corsair of Liberty",  front = CUSTOM_ASSETS.."cards/.legacy/beta/corsair-of-liberty-title-legacy-beta.jpg", cost=3, aliases={"Corsair of Liberty [LegacyBeta]", "Corsair of Liberty [Legacy]"}})
Card:new(Title,Separatist,{name="Insatiable",  front = CUSTOM_ASSETS.."cards/.legacy/beta/insatiable-title-legacy-beta.jpg", cost=3, aliases={"Insatiable [LegacyBeta]", "Insatiable [Legacy]"}})
Card:new(Title,Empire,{name="Intrepid",  front = CUSTOM_ASSETS.."cards/.legacy/beta/intrepid-title-legacy-beta.jpg", cost=7, aliases={"Intrepid [LegacyBeta]", "Intrepid [Legacy]"}})
Card:new(Title,Empire,{name="Battle Cruiser",  front = CUSTOM_ASSETS.."cards/.legacy/beta/battle-cruiser-title-legacy-beta.jpg", cost=2, aliases={"Battle Cruiser [LegacyBeta]", "Battle Cruiser [Legacy]"}})
Card:new(Title,Rebel,{name="Nautilian",  front = CUSTOM_ASSETS.."cards/.legacy/beta/nautilian-title-legacy-beta.jpg", cost=5, aliases={"Nautilian [LegacyBeta]", "Nautilian [Legacy]"}})
Card:new(Title,Rebel,{name="Rebel One",  front = CUSTOM_ASSETS.."cards/.legacy/beta/rebel-one-title-legacy-beta.jpg", cost=4, aliases={"Rebel One [LegacyBeta]", "Rebel One [Legacy]"}})

printToAll("Finished loading Armada Legacy wave 1 beta content!",{1,0.5,0})

------------------------------------

--objectives
-- Objective = {
--     type="Objective",
--     back = "https://i.imgur.com/6mOLyyo.jpeg"
-- }
-- Assault = { category = "Assault" }
-- Card:new(Assault, Objective, {name="Advanced Gunnery", front="https://i.imgur.com/3dV3CQL.png"})
-- Defense = { category = "Defense" }
-- Card:new(Defense, Objective, {name="Abandoned Mining Facility", front="https://i.imgur.com/FisDnrA.png", victory=10})
-- Navigation = { category = "Navigation" }
-- Card:new(Navigation, Objective, {name="Dangerous Territory", front="https://i.imgur.com/DIlMCHD.png", victory=15})
-- Special = { category = "Special" }
-- Card:new(Special, Objective, {name="Base Defense: Armed Station", front="https://i.imgur.com/uuS6Bgr.png"})


end

-- DO NOT MODIFY CODE BELOW THIS, OR MOD DB MAY NOT WORK!
ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
function table.copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
    copy = orig
    end
    return copy
end
function findObjectByName(name)
    for i,obj in ipairs(getAllObjects()) do
        if obj.getName()==name then return obj end
    end
end
DEF_BRACE = '79d121'
DEF_CONTAIN = '68abfc'
DEF_EVADE = 'c09d88'
DEF_REDIRECT = '36f595'
DEF_SCATTER = '895e91'
DEF_SALVO = '5028b2'
Ship = { collider = "", convex = true, type = 1, material = 3, maneuver = {},
    defense_tokens = {}, shields = {1,1,1,1,1,1}, cost = 0, name = "",
    front = "", back = "", aliases = {}, faction = "" }
DefaultShip = table.copy(Ship)
function Ship:new (...)
    o = table.copy(DefaultShip)
    if ... ~= nil then
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                o[k] = v
            end
        end
    end
    setmetatable(o, Ship)
    Ship.__index = Ship
    spawner = findObjectByName("Armada Spawner")
    if spawner~=nil then
        spawner.call("API_CacheShip",o)
    end
    return o
end
SmallShip = { collider = ASSETS_ROOT..'misc/bases/small.obj' } --"http://paste.ee/r/eDbf1"
MediumShip = { collider = ASSETS_ROOT..'misc/bases/medium.obj' } --"http://paste.ee/r/6LYTT"
LargeShip = { collider = ASSETS_ROOT..'misc/bases/large.obj'} --"http://paste.ee/r/a7mfW"
--SquareShip = { collider = CUSTOM_ASSETS..'misc/bases/square.obj'}
--MassiveShip = { collider = CUSTOM_ASSETS..'misc/bases/massive.obj'}
HugeShip = { collider = ASSETS_ROOT..'misc/bases/huge.obj' } --"http://paste.ee/r/ClCL3"
Squadron = { collider = ASSETS_ROOT..'misc/bases/squad.obj', convex = false, type = 1, --"http://paste.ee/r/ZKM7E" --http://paste.ee/r/nAMCQ
    material = 1, health = 0, move = 0, defense_tokens = {}, cost = 0,
    name = "", front = "", back = "", aliases = {}, faction = "" }
DefaultSquad = table.copy(Squadron)
function Squadron:new (...)
    o = table.copy(DefaultSquad)
    if ... ~= nil then
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                o[k] = v
            end
        end
    end
    setmetatable(o, Squadron)
    Squadron.__index = Squadron
    spawner = findObjectByName("Armada Spawner")
    if spawner~=nil then
        spawner.call("API_CacheShip",o)
    end
    return o
end
Card = { cost = 0, name = "", type = "", front = "", back = "", aliases = {},
    iscard = true,  faction = nil
}
DefaultCard = table.copy(Card)
function Card:new (...)
    o = table.copy(DefaultCard)
    if ... ~= nil then
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                o[k] = v
            end
        end
    end
    setmetatable(o, Card)
    Card.__index = Card
    spawner = findObjectByName("Armada Spawner")
    if spawner~=nil then
        spawner.call("API_CacheCard",o)
    end
    return o
end
function PurgeCard (name, cost)
    o = {}
    o['name'] = name
    o['cost'] = cost
    spawner = findObjectByName("Armada Spawner")
    if spawner~=nil then
        spawner.call("API_PurgeCard",o)
    end
end
function UpdateCard(current_name, current_cost, o) -- MUST
    local update = {}
    update['name'] = current_name
    update['cost'] = current_cost or 0
    update['o'] = o
    spawner = findObjectByName("Armada Spawner")
    if spawner~=nil then
        spawner.call("API_UpdateCard",update)
    end
end
function GetDefinition(name, cost)
    local o = {}
    o['name'] = name
    o['cost'] = cost or 0
    spawner = findObjectByName("Armada Spawner")
    if spawner~=nil then
        return spawner.call("API_GetDefinition",o)
    end
end