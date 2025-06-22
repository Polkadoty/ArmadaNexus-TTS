-- https://github.com/Valadian/TabletopSimulatorIncludeDir/tree/master/TTS_armada/src/custom_db
-- Examples
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

--     squad = {
--         mesh = "http://paste.ee/r/ZqCC6",
--         diffuse = "http://i.imgur.com/QSLaqgW.png", --model texture
--         health = 5,
--         move = 2,
--         defense_tokens = {}}
--     Squadron:new(squad, REBEL_SQUAD, {
-- 	       name = "B-wing Squadron",
--         front = "https://i.imgur.com/bB11RGw.png", --card front
--         cost = 14,
--         aliases = {'B-wing Squadrons', "B-wing"}
--     })
--     Squadron:new(squad, REBEL_SQUAD, {
-- 	       name = "Keyan Farlander",
--         front = "https://i.imgur.com/r4bx4xg.png", --card front
--         diffuse = "http://i.imgur.com/r7YB80F.png", --model texture
--         defense_tokens = {DEF_BRACE,DEF_BRACE},
--         cost = 20
--     })
--

ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
function onload()
	printToAll("Loading ARC content...",{1,0.5,0})
    --UpdateCard("",,{cost = ,aliases={" [Rebalanced]"}})
 
	REPUBLIC_SHIP = {
		back = "url",
        faction = "@Republic"
    }

    EMPIRE_SHIP = {
        back = "url",
        faction = "@Empire"
    }

------------------------------------
    --empire squadrons
    EMPIRE_SQUAD = {
        back = "url",
        faction = "@Empire"
    }

    defender = GetDefinition("TIE Defender Squadron",16)
    phantom = GetDefinition("TIE Phantom Squadron",14)

    ------------------------------------
    --rebel squadrons
    REBEL_SQUAD = {
        back = CUSTOM_ASSETS.."squadrons/rebel/card_back.jpg",
        faction = "@Rebellion" 
    }

    ewing = GetDefinition("E-wing Squadron",14)
    z95 = GetDefinition("Z-95 Headhunter Squadron",7)


------------------------------------
Republic = {
    factions={"@Republic"}
}
Separatist = {
    factions={"@Separatist"}
}
CloneWars = {
    factions={"@Republic","@Separatist"}
}
Empire = {
    factions={"@Empire"}
}
Rebel = {
    factions={"@Rebellion"}
}

Commander = { type = "Commander", back = "url" }
DefensiveRetrofit = { type = "DefensiveRetrofit", back = "url" }
FleetCommand = { type = "FleetCommand", back = "url" }
FleetSupport = { type = "FleetSupport", back = "url" }
IonCannons = { type = "IonCannons", back = "url" }
OffensiveRetrofit = { type = "OffensiveRetrofit", back = "url" }
Officer = { type = "Officer", back = "url" }
SuperWeapon = { type = "SuperWeapon", back = "url" }
SupportTeam = { type = "SupportTeam", back = "url" }
Title = { type = "Title", back = "url" }
WeaponsTeam = { type = "WeaponsTeam", back = "url" }

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

printToAll("Finished loading ARC content!",{1,0.5,0})

--------------

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