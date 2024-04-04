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

-- star wars
    -- empire
    EMPIRE_SHIP = {
        back = ASSETS_ROOT.."ships/empire/card_back.jpg",
        faction = "Empire_SN"
    }
    EMPIRE_SQUAD = {
        back = ASSETS_ROOT.."ships/empire/card_back.jpg",
        faction = "Empire_SN"
    }
        -- imp dreadnaught
        Ship:new(MediumShip,EMPIRE_SHIP, {
            name = "Dreadnaught-class Imperial Refit",
            front = LEGACY_ASSETS.."ships/empire/dread/dreadnaught-imperial-refit.png",
            mesh = LEGACY_ASSETS.."ships/empire/dread/mesh.obj",
            diffuse = LEGACY_ASSETS.."ships/empire/dread/dread_imp_texture.png",
            ruler = LEGACY_ASSETS.."ships/rebel/nebulon/ruler.obj", 
            maneuver = {{"I"},{"I","I"}},
            defense_tokens = {DEF_REDIRECT, DEF_BRACE, DEF_BRACE},
            shields = {3,3,3,1}, -- Front, left, right, rear
            cost = 64,
            aliases = {"Dreadnaught Imperial Refit [Legacy]"},
            command = 3
            })

        -- interdictor sd
        Ship:new(LargeShip,EMPIRE_SHIP, {
            name = "Interdictor-class Star Destroyer",
            front = LEGACY_ASSETS.."ships/empire/interdictor-sd/interdictor-star-destroyer.png",
            mesh = LEGACY_ASSETS.."ships/empire/interdictor-sd/mesh.obj",
            diffuse = LEGACY_ASSETS.."ships/empire/interdictor-sd/interdictorsd-sd-texture.png",
            ruler = LEGACY_ASSETS.."ships/empire/imperial/ruler.obj",
            maneuver = {{"I"},{"I","I"},{"I","-","I"}},
            defense_tokens = {DEF_REDIRECT, DEF_CONTAIN, DEF_BRACE, DEF_REDIRECT},
            shields = {4,3,3,2}, -- Front, left, right, rear
            cost = 110,
            aliases = {"Interdictor Star Destroyer [Legacy]"},
            command = 3
            })

        -- cantwell arrestor cruiser
        Ship:new(MediumShip,EMPIRE_SHIP, {
            name = "Cantwell-class Arrestor Cruiser",
            front = CUSTOM_ASSETS.."ships/empire/cantwell/cantwell_card.png",
            back = CUSTOM_ASSETS.."ships/empire/cantwell/cantwell_card_back.png",
            mesh = CUSTOM_ASSETS.."ships/empire/cantwell/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/empire/cantwell/diffuse.png",
            ruler = CUSTOM_ASSETS.."ships/empire/cantwell/ruler.obj", 
            maneuver = {{"II"},{"II","-"},{"II","-","-"}},
            defense_tokens = {DEF_CONTAIN, DEF_EVADE, DEF_REDIRECT},
            shields = {2,2,2,1}, -- Front, left, right, rear
            cost = 69,
            aliases = {"Cantwell-class Arrestor Cruiser"},
            command = 2
            })

            -- eclipse ssd
            -- pellaeon sd
            -- escort carrier
            -- tartan cruiser
            -- igv55 survelliance gozanti
            -- vindicator cruiser
            -- clawcraft sqd

    -- rebels
    REBEL_SHIP = {
        back = CUSTOM_ASSETS.."ships/rebel/card_back.png",
        faction = "Rebellion_SN" 
    }
    REBEL_SQUAD = {
        back = CUSTOM_ASSETS.."ships/rebel/card_back.png",
        faction = "Rebellion_SN" 
    }
        -- mc80b
        -- assault frigate mk1 a/b

        -- dauntless heavy cruiser
        -- nebulon b2
        -- neutron star bulk cruiser
        -- mando razor crest

    -- republic
    REPUBLIC_SHIP = {
		back = CUSTOM_ASSETS.."ships/republic/card_back.png",
        faction = "Republic_SN"
    }
        -- dreadnaught
        -- ipv-2 stealth
        -- victory 2 frigate

    REPUBLIC_SQUAD = {
		back = CUSTOM_ASSETS.."ships/republic/card_back.png",
        faction = "Republic_SN"
    }
        -- clone z95 sqd
        -- eta-2 sqd
        -- g9 rigger
        -- laat/i gunship

        -- nu shuttle
    nu_shuttle = {
        mesh = CUSTOM_ASSETS.."squadrons/republic/nu_shuttle/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/republic/nu_shuttle/diffuse.png",
        health = 6,
        move = 2,
        defense_tokens = {}
    }
    Squadron:new(nu_shuttle, REPUBLIC_SQUAD, {
        name = "Nu-class Attack Shuttle",
        front = CUSTOM_ASSETS.."squadrons/republic/nu_shuttle/nu_shuttle_card.png",
        cost = 14,
        aliases = {"Nu-class Attack Shuttle"}
    })

    -- omicron shuttle
    omicron = {
        mesh = CUSTOM_ASSETS.."squadrons/republic/omicron/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/republic/omicron/diffuse.png",
        health = 6,
        move = 2,
        defense_tokens = {}
    }
    Squadron:new(omicron, REPUBLIC_SQUAD, {
        name = "Omicron-class Attack Shuttle",
        front = CUSTOM_ASSETS.."squadrons/republic/omicron/omicron_card.png",
        cost = 14,
        aliases = {"Omicron-class Attack Shuttle"}
    })

    -- cis
    SEPARATIST_SHIP = {
        back =      CUSTOM_ASSETS.."ships/separatist/card_back.png",
        faction = "Separatist_SN"
    }
    SEPARATIST_SQUAD = {
        back =      CUSTOM_ASSETS.."ships/separatist/card_back.png",
        faction = "Separatist_SN"
    }
        -- trident
        -- lucrehulk
        -- subjugator
        -- sith infiltrator
        -- rogue starfighter
        -- hmp gunship
        -- nantex sqd

        -- diamond cruiser
        -- core ship
    -- scum and villany
        -- marauder corvette
        -- starviper sqd
        -- 

    -- old republic
    -- sith empire
    -- new republic
    -- imp remenant
    -- first order
        -- mandator iv dreadnought
        -- xyston sd
    -- resistance

-- halo
    -- unsc
        -- paris frigate
        -- charon frigate
        -- stalwart frigate
        -- halcyon cruiser/autumn class
        -- marathon cruiser
        -- epoch carrier
        -- c709 longsword bomber sqd
        -- c712 longsword fighter sqd
        -- sabre fighter sqd
        -- pelican dropship

        -- MAC cannon station
        -- unsc infinity
        -- halberd destroyer
        -- phoenix carrier
        -- punic supercarrier
        -- orion carrier
        -- valiant cruiser

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
        -- lursu brigantine
        -- rwaru carrack
        -- mjern support
        -- r'sikosh manowar
        -- tarasque fighter
        -- tick boarding craft
        -- 

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