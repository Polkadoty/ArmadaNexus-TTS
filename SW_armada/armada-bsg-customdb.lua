-- Definitions merge multiple tables to reduce duplication of common properties:
-- Examples of Card, Ship, Squadron definitions below.
--
-- Commander = {
--     type="Commander",
--     back = CUSTOM_ASSETS.."cards/commanders/back.png" } -- card back
-- Rebel = { factions={"Rebellion_SN","Empire_SN"} } -- factions must be a table for cards, since multi faction upgrades exist
-- Card:new(Commander,Rebel,{name="CommanderName",  front=CUSTOM_ASSETS.."cards/commanders/card.png", cost=38})

-- Ship:new(MediumShip,FACTION_SHIP, {
--     name = "ShipName",
--     front = CUSTOM_ASSETS.."ships/.../_card.png",
--     back = CUSTOM_ASSETS.."ships/.../_card_back.png",
--     mesh = CUSTOM_ASSETS.."ships/.../mesh.obj",
--     diffuse = CUSTOM_ASSETS.."ships/.../diffuse.png",
--     ruler = CUSTOM_ASSETS.."ships/.../ruler.obj", 
--     maneuver = {{"II"}},
--     defense_tokens = {DEF_CONTAIN, DEF_EVADE, DEF_REDIRECT},
--     shields = {2,2,2,1}, -- Front, left, right, rear
--     cost = 69,
--     command = 2
--     aliases = {""},
--     })

-- squadron_Ship = {
--     mesh = CUSTOM_ASSETS.."squadrons/.../mesh.obj",
--     diffuse = CUSTOM_ASSETS.."squadrons/.../diffuse.png",
--     health = 1,
--     move = 1,
--     defense_tokens = {}
-- }
-- Squadron:new(squadron_Ship, FACTION_SQUAD, {
--     name = "squadron_Ship",
--     front = CUSTOM_ASSETS.."squadrons/.../_card.png",
--     cost = 69,
--     aliases = {""}
-- })
--

CUSTOM_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/SNCustomTTS-IncludeDir/master/SW_armada/assets/'
LEGACY_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/ArmadaLegacyTTS-IncludeDir/master/assets/'
ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
function onload()
	printToAll("Loading SpaceNavy custom shipyard...",{1,0.5,0})

-- battlestar galactica
    -- colonial
    COL_SHIP = {
        back = ASSETS_ROOT.."ships/colonial/card_back.jpg",
        faction = "Colonial_SN"
    }
    COL_SQUAD = {
        back = LEGACY_ASSETS.."squadrons/colonial/card_back.jpg",
        faction = "Colonial_SN"
    }
        -- mercury battlestar
    Ship:new(LargeShip,COL_SHIP, {
        name = "Mercury-class Battlestar Mk.1",
        front = CUSTOM_ASSETS.."ships/colonial/mercury/mk1_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/mercury/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/mercury/mk1_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"I"},{"I","-"},{"I","-","I"}},
        defense_tokens = {DEF_SALVO,DEF_BARRAGE,DEF_BRACE,DEF_BARRAGE},
        shields = {3,4,4,2}, -- Front, left, right, rear
        cost = 140,
        command = 4,
        aliases = {"Mercury Battlestar Mk1"}
    })
    Ship:new(LargeShip,COL_SHIP, {
        name = "Mercury-class Battlestar Mk.2",
        front = CUSTOM_ASSETS.."ships/colonial/mercury/mk2_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/mercury/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/mercury/mk2_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"I"},{"I","-"},{"I","-","I"}},
        defense_tokens = {DEF_SALVO,DEF_BARRAGE,DEF_BRACE,DEF_BARRAGE},
        shields = {3,4,4,2}, -- Front, left, right, rear
        cost = 135,
        command = 4,
        aliases = {"Mercury Battlestar Mk2"}
    })
      
        -- jupiter battlestar
    Ship:new(LargeShip,COL_SHIP, {
        name = "Jupiter-class Battlestar Mk.1",
        front = CUSTOM_ASSETS.."ships/colonial/jupiter/mk1_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/jupiter/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/jupiter/mk1_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/jupiter/ruler.obj", 
        maneuver = {{"II"},{"I","-"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_BARRAGE},
        shields = {2,3,3,1}, -- Front, left, right, rear
        cost = 100,
        command = 3,
        aliases = {"Jupiter-class Battlestar Mk1"}
    })
    Ship:new(LargeShip,COL_SHIP, {
        name = "Jupiter-class Battlestar Mk.2",
        front = CUSTOM_ASSETS.."ships/colonial/jupiter/mk2_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/jupiter/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/jupiter/mk2_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/jupiter/ruler.obj", 
        maneuver = {{"II"},{"I","-"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_BARRAGE},
        shields = {2,3,3,1}, -- Front, left, right, rear
        cost = 103,
        command = 3,
        aliases = {"Jupiter-class Battlestar Mk2"}
    })
        -- orion frigate
        -- valkyrie battlestar
        -- adamant frigate
        -- manticore corvette
        -- viper mk2 sqd
        -- viper mk7 sqd
        -- raptor sqd

        -- colonial one
        -- colonial fleet civlian ships
        -- bezerk frigate
        -- defender frigate
        -- blackbird sqd

    -- cylon
        -- basestar
        -- cerberus carrier
        -- phobos tech cruiser
        -- nemesis tech corvette
        -- cerastes gunship
        -- raider sqd
        -- hvy raider sqd
        -- war raider sqd
        -- war hvy raider sqd

        -- hades battlecruiser
        -- attackstar
        -- 

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
--DEF_BARRAGE = ''
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