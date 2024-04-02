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
-- For questions, message valadian#6997 on discord,
--     or join ArmadaTTS Server: https://discord.gg/3MrP8db
--

CUSTOM_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/SNCustomTTS-IncludeDir/master/SW_armada/assets/'
LEGACY_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/ArmadaLegacyTTS-IncludeDir/master/assets/'
ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
function onload()
	printToAll("Loading SpaceNavy custom shipyard...",{1,0.5,0})

    
-- star wars
    -- empire
    EMPIRE_SHIP = {
        back = ASSETS_ROOT.."ships/empire/card_back.jpg",
        faction = "Empire_SN"
    }
    EMPIRE_SQUAD = {
        back = LEGACY_ASSETS.."squadrons/empire/card_back.jpg",
        faction = "Empire_SN"
    }
        -- interdictor sd
        -- cantwell arrestor cruiser
        Ship:new(MediumShip,EMPIRE_SHIP, {
            name = "Cantwell-class Arrestor Cruiser",
            front = CUSTOM_ASSETS.."ships/empire/cantwell/cantwell_card.png",
            mesh = CUSTOM_ASSETS.."ships/empire/cantwell/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/empire/cantwell/cantwell_texture.png",
            ruler = CUSTOM_ASSETS.."ships/empire/cantwell/ruler.obj", 
            maneuver = {{"I"},{"I","I"}},
            defense_tokens = {DEF_REDIRECT, DEF_BRACE, DEF_BRACE},
            shields = {3,3,3,1}, -- Front, left, right, rear
            cost = 62,
            aliases = {"Cantwell-class Arrestor Cruiser"},
            command = 2
            })
    -- rebels
    REBEL_SHIP = {
        back = LEGACY_ASSETS.."ships/rebel/card_back.jpg",
        faction = "Rebellion_SN" 
    }
    REBEL_SQUAD = {
        back = LEGACY_ASSETS.."squadrons/rebel/card_back.jpg",
        faction = "Rebellion_SN" 
    }
        -- mc80b
        -- assault frigate mk1 a/b
    -- republic
    REPUBLIC_SHIP = {
		back = LEGACY_ASSETS.."ships/republic/card_back.jpg",
        faction = "Republic_SN"
    }
    REPUBLIC_SQUAD = {
		back = LEGACY_ASSETS.."ships/republic/card_back.jpg",
        faction = "Republic_SN"
    }
        -- dreadnaught
        -- ipv-2 stealth
        -- clone z95 sqd
        -- eta-2 sqd
        -- g9 rigger
        -- laat/i gunship
    -- cis
    SEPARATIST_SHIP = {
        back =      LEGACY_ASSETS.."ships/separatist/card_back.jpg",
        faction = "Separatist_SN"
    }
    SEPARATIST_SQUAD = {
        back =      LEGACY_ASSETS.."ships/separatist/card_back.jpg",
        faction = "Separatist_SN"
    }
        -- trident
        -- lucrehulk
        -- subjugator
        -- sith infiltrator
        -- rogue starfighter
        -- hmp gunship
        -- nantex sqd
    -- old republic
    -- sith empire
    -- new republic
    -- imp remenant
    -- first order
    -- resistance

-- halo
    -- unsc
        -- paris frigate
        -- charon frigate
        -- stalwart frigate
        -- halcyon cruiser
        -- marathon cruiser
        -- epoch carrier
        -- c709 longsword bomber sqd
        -- c712 longsword fighter sqd
        -- sabre fighter sqd
        -- pelican dropship

        -- MAC cannon station

    -- covenant
        -- cso supercarrier
        -- cas assault carrier
        -- ors battlecruiser
        -- ccs cruiser
        -- sdv corvette
        -- crs light cruiser
        -- space banshee sqd
        -- seraph sqd
        -- phantom dropship
        -- spirit dropship
        
        -- hekar taa blockade runner
        -- cpv destroyer
        -- adp escort
        -- dsc support ship
        -- rcs armored cruiser

    -- banished
        -- dreadnought
        --karve
        --drekar

    -- forerunner
    -- flood

-- battlestar galactica
    -- colonial
        -- mercury battlestar
        -- jupiter battlestar
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

-- star trek
    -- federation
        -- galaxy
        -- akira
        -- excelsior
        -- constitution refit
        -- miranda
        -- defiant

        -- steamrunner
        -- intrepid
        -- sovereign
        -- prometheus
        -- odyssey
        -- danube runabout
        -- peregrine fighter
        -- delta flyer
        -- starbase/spacedock

    -- klingon
        -- negh'var
        -- k'tinga
        -- d'tai
        -- k'vort
        -- b'rel
        -- d'gavama
        -- d4 class
        -- d5 class
        -- d7 class
        -- vor'cha
        -- augment raider
    
    -- romulan
        -- d'deridex
        -- v'teridex
        -- valdore
        -- d'vorx
        -- lukan
        -- bird of prey
    
    -- dominion
        -- dreadnought
        -- battleship
        -- heavy cruiser
        -- shrike
        -- freighter
        -- jem'hadar attack ship

    -- borg
        -- scout sphere
        -- probe
        -- tactical sphere
        -- tactical cube
        -- assimilation cube
        -- queen ship

    -- cardassian
        -- galor
        -- keldon
        -- haklon
        -- bok'nor
        -- hideki

-- warhammer 40k / battlefleet gothic
    -- imperium
        -- imp navy
        -- ad astartes
        -- ad mech
    -- chaos
    -- eldar
        -- corsairs
        -- craftworld
        -- dark
    -- orks
    -- tyrannid
    -- necrons
    -- tau
        -- protector
        -- merchant

-- the expanse
    -- earth
    -- mars
    -- OPA
    
-- mass effect

-- elite dangerous

-- star citizen

-- stargate

-- babylon 5

-- stellaris

-- sins of a solar empire

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