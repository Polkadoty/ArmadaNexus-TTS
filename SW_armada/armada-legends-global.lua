----#include TTS_armada/src/Global
--italia table: https://i.imgur.com/ZH3BOIY.jpg
ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
LEGACY_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/ArmadaLegacyTTS-IncludeDir/master/assets/'
local SQUAD_MOVE_RULER = 1
local SQUAD_ATTACK_RULER = 2
local SQUAD_ATTACK_CLOSE_RULER = 3
local SQUAD_RULERS = {
    ASSETS_ROOT..'misc/rulers/squad/5.obj', --'http://pastebin.com/raw/QspzqNUx',
    ASSETS_ROOT..'misc/rulers/squad/1.obj', -- 'http://pastebin.com/raw/v9PG9iFC'
    ASSETS_ROOT..'misc/rulers/squad/close.obj'
}
local SQUAD_SPEED_RULERS = {
    ASSETS_ROOT..'misc/rulers/squad/1.obj',
    ASSETS_ROOT..'misc/rulers/squad/2.obj',
    ASSETS_ROOT..'misc/rulers/squad/3.obj',
    ASSETS_ROOT..'misc/rulers/squad/4.obj',
    ASSETS_ROOT..'misc/rulers/squad/5.obj'
}
local SHIPS = {
    {ASSETS_ROOT..'misc/bases/small.obj',"http://paste.ee/r/eDbf1"},
    {ASSETS_ROOT..'misc/bases/medium.obj',"http://paste.ee/r/6LYTT"},
    {ASSETS_ROOT..'misc/bases/large.obj',"http://paste.ee/r/a7mfW"},
    {ASSETS_ROOT..'misc/bases/huge.obj',"http://paste.ee/r/ClCL3"},
    {LEGACY_ASSETS..'dev/wave3/ships/subjugator/massive_base_mesh.obj',"https://pastebin.com/raw/FbinX7mf"}} --custom massive/shortHuge
    -- "https://paste.ee/r/eDbf1",
    -- "https://paste.ee/r/6LYTT",
    -- "https://paste.ee/r/a7mfW",
    -- "https://paste.ee/r/ClCL3"}
local CMD_MESHES = {
    ASSETS_ROOT.."misc/command_dials/eng.jpg", --repair
    ASSETS_ROOT.."misc/command_dials/confire.jpg", --concentrate
    ASSETS_ROOT.."misc/command_dials/nav.jpg", --navigate
    ASSETS_ROOT.."misc/command_dials/squad.jpg"} --squadron
local CMD_NAMES = {}
CMD_NAMES[ASSETS_ROOT.."misc/command_dials/eng.jpg"] = "Repair" --repair
CMD_NAMES[ASSETS_ROOT.."misc/command_dials/confire.jpg"] = "Concentrate Fire" --concentrate
CMD_NAMES[ASSETS_ROOT.."misc/command_dials/nav.jpg"] = "Navigate" --navigate
CMD_NAMES[ASSETS_ROOT.."misc/command_dials/squad.jpg"] = "Squadron" --squadron
local CMD_COLORS = {}
-- CMD_COLORS["http://i.imgur.com/IHXy7k7.jpg"] = {0,0.8,0} --repair
-- CMD_COLORS["http://i.imgur.com/ip3tJaN.jpg"] = {0.8,0,0} --concentrate
-- CMD_COLORS["http://i.imgur.com/hGXCVQo.jpg"] = {0, 0.2, 0.8} --navigate
-- CMD_COLORS["http://i.imgur.com/XbJbScU.jpg"] = {0.5,0,0.5} --squadron
CMD_COLORS[ASSETS_ROOT.."misc/command_dials/eng.jpg"] = {0.4,0.8,0.4} --repair
CMD_COLORS[ASSETS_ROOT.."misc/command_dials/confire.jpg"] = {0.8,0.4,0.4} --concentrate
CMD_COLORS[ASSETS_ROOT.."misc/command_dials/nav.jpg"] = {0.2, 0.4, 0.8} --navigate
CMD_COLORS[ASSETS_ROOT.."misc/command_dials/squad.jpg"] = {0.8,0.4,0.8} --squadron
SUMMA_IMG = "https://i.imgur.com/nhLQ82T.png"
SUMMA_MESH = "https://pastebin.com/raw/vsufjyT7"
SUMMA_RULER = "https://pastebin.com/raw/aTRg2KcU"
local TARGETING_MESHES = {
    "http://i.imgur.com/mFwOs6T.jpg"
}
local SQUAD_COLLIDERS = {ASSETS_ROOT.."misc/bases/squad.obj","http://paste.ee/r/nAMCQ", "https://paste.ee/r/nAMCQ", "http://paste.ee/r/ZKM7E", "https://paste.ee/r/ZKM7E"}
-- local SQUAD = "http://paste.ee/r/ZKM7E"--"http://paste.ee/r/nAMCQ"
-- local SQUAD_HTTPS = "https://paste.ee/r/ZKM7E" --"https://paste.ee/r/nAMCQ"
local A_COLOR = {0,0.5,1.0 }
local B_COLOR = {1.0,0.25,0}
--local A_SECONDARY_COLOR = {0.5,0,1.0 }
--local B_SECONDARY_COLOR = {1.0,1.0,0}
local A_SECONDARY_COLOR = {0,0.3,0.375 }
local B_SECONDARY_COLOR = {0.375,0.3,0}
ruler = nil
rulers = {}
shield_dials = nil
----#include dieRoller/config
timerCounter = 0
dieRollerInfo = {
    redDieRollerGUID = '9e1533',
    blueDieRollerGUID = '3c0658',
    dieRollerZone = {
        red = 'c125cf',
        blue = 'ed1e34'
    },
    buttonInfo = {
        redPlayer = {
            blackAttackButtonGUID = '8bbca8',
            blueAttackButtonGUID = 'fc0871',
            redAttackButtonGUID = '68ab1e'
        },
        bluePlayer = {
            blackAttackButtonGUID = '4bc266',
            blueAttackButtonGUID = 'a83d79',
            redAttackButtonGUID = '520af3'
        }
    },
    blackBagGUID = '7f1ee3',
    blueBagGUID = '835916',
    redBagGUID = 'd27e68',
    dieValues = {
        black = {
            {"hit"},
            {"hit"},
            {"hit"},
            {"hit"},
            {"hit","crit"},
            {"hit","crit"},
            {},
            {}
        },
        blue = {
            {"hit"},
            {"hit"},
            {"hit"},
            {"hit"},
            {"crit"},
            {"crit"},
            {"acc"},
            {"acc"}
        },
        red = {
            {"hit"},
            {"hit"},
            {"hit","hit"},
            {"crit"},
            {"crit"},
            {"acc"},
            {},
            {}
        }
    },
    diePos = {
        {q = 0, c = 0},

        {q = -33	, c = 2},
        {q = 33, c = 2},
        {q = -33	, c = -2},
        {q = 33, c = -2},
        {q = 90, c = -2},
        {q = 90, c = 2},

        {q = 90, c = 4},
        {q = 45, c = 4},
        {q = -45, c = 4},
        {q = 90, c = -4},
        {q = -45, c = -4},
        {q = 45, c = -4},
        {q = 0, c = 4},

        {q = 66, c = 5},
        {q = 66, c = -5},
        {q = -66, c = 5},
        {q = -66, c = -5},
    },
    -- diePos = {
    --     {q = 0, c = 0.5},
    --     {q = 63.434948822922	, c = 1.1180339887499},
    --     {q = 33.69006752598, c = 1.802775637732},
    --     {q = 0, c = 1.5},
    --     {q = -33.69006752598	, c = 1.802775637732},
    --     {q = -63.434948822922, c = 1.1180339887499},
    --     {q = 63.434948822922	, c = -1.1180339887499},
    --     {q = 0, c = -0.5},
    --     {q = -63.434948822922, c = -1.1180339887499},
    --     {q = 75.963756532074, c = 2.0615528128088},
    --     {q = 53.130102354156, c = 2.5},
    --     {q = 38.65980825409, c = 3.2015621187164},
    --     {q = 21.801409486352, c = 2.6925824035673},
    --     {q = 0, c = 2.5},
    --     {q = -21.801409486352, c = 2.6925824035673},
    --     {q = -38.65980825409, c = 3.2015621187164},
    --     {q = -53.130102354156, c = 2.5},
    --     {q = -75.963756532074, c = 2.0615528128088},
    --     {q = 75.963756532074, c = -2.0615528128088},
    --     {q = 53.130102354156, c = -2.5},
    --     {q = 33.69006752598, c = -1.802775637732},
    --     {q = 0, c = -1.5},
    --     {q = -33.69006752598, c = -1.802775637732},
    --     {q = -53.130102354156, c = -2.5},
    --     {q = -75.963756532074, c = -2.0615528128088}
    -- }
}

----#include dieRoller/config

local BOTTOM_REF_WHITE_GUID = 'e60d1a'
local BOTTOM_REF_BLUE_GUID = 'd46b67'
local restrict_squadrons = true
local squadrons_extended_attack = false
hover = {}
function onObjectHover(player_color, hovered_object)
    if hovered_object ~= nil then
        custom = hovered_object.getCustomObject()
        pos = hovered_object.getPosition()
        if custom ~= nil and table.contains(CMD_MESHES,custom.diffuse) then
            -- print("setting: "..math.floor(pos[1])..","..math.floor(pos[3]).." to: "..player_color)
            hover[math.floor(pos[1])*100+math.floor(pos[3])] = player_color
        end
        onObjectHover_asteroid(hovered_object,player_color)
        onObjectHover_scripting_keys(hovered_object,player_color)
    end
end
function onObjectSpawn(obj)
    custom = obj.getCustomObject()
    if custom ~= nil and table.contains(CMD_MESHES,custom.diffuse) then
        pos = obj.getPosition()
        hover_color = hover[math.floor(pos[1])*100+math.floor(pos[3])]
        if hover_color~=nil then
            color = stringColorToRGB(hover_color)
            if hover_color=="White" then
                color = {r=0.4,g=0.4,b=0.4}
            end
            if Player[hover_color].seated then
                obj.setColorTint({1-(1-color.r)/2,1-(1-color.g)/2,1-(1-color.b)/2})
                broadcastToColor("   [COMMAND DIAL] Set to: "..CMD_NAMES[custom.diffuse], hover_color, CMD_COLORS[custom.diffuse])
            end
        else
            -- print("No hover color for: "..math.floor(pos[1])..","..math.floor(pos[3]))
        end
    end
    -- if custom ~= nil and custom.image=="http://i.imgur.com/EUi3Wog.png" then
    drawDatacardButtons(obj)
    onObjectSpawn_asteroid(obj)
end
----#include asteroid
--1-5 Ruler
--2.93
--1.86 (4.79) -0.11
--2.37 (7.16) -0.1
--2.41 (9.57) -0.05
--2.42 (11.99) -0.08

--gravity = 0.74
--proximity = 0.745
--targeting = 0.740
-- objective (0.67) .45

-- squadron cardboard = 1.219


ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
Obstacle = {
    name = "",
    collider = "",
    -- mesh = ""
    -- diffuse = ""
    rulers = {
        --1
        --2
        --3
        --4
        --5
    },
    default = 1,
    scale = 1
}
OBSTACLES = {}
function Obstacle:new (o,...)
    o = o or {}
    o = table.ShallowCopy(o)
    if ... ~= nil then
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                o[k] = v
            end
        end
    end
    setmetatable(o, Obstacle)
    Obstacle.__index = Obstacle
    if o.colliders~="" then
        for _, collider in ipairs(o.colliders) do
            OBSTACLES[collider] = o
        end
    end
    return o
end
function Obstacle.lookup (collider)
    return OBSTACLES[collider]
end

function loadAsteroidDefs()
Obstacle:new({
    name = "Asteroid 1", --Eclair
    colliders = {ASSETS_ROOT.."misc/obstacles/asteroid1/mesh.obj","http://paste.ee/r/Ul5Zt","http://paste.ee/r/u960L"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/asteroid1/1.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid1/2.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid1/3.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid1/4.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid1/5.obj"
    }
    --      measured (ingame) = ratio (ingame scale) = blender scale
    --length = 2.695 (2.77) = 0.9729 * 0.83 = 0.8075
    --width = 1.12 (1.14) = 0.9825 * 0.83 = 0.815
    -- 0.811 DONE
})
Obstacle:new({
    name = "Debris 2", --Chicken leg
    colliders = {ASSETS_ROOT.."misc/obstacles/debris2/mesh.obj","http://paste.ee/r/Fk1So","http://paste.ee/r/xJ3Vm"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/debris2/1.obj",
        ASSETS_ROOT.."misc/obstacles/debris2/2.obj",
        ASSETS_ROOT.."misc/obstacles/debris2/3.obj",
        ASSETS_ROOT.."misc/obstacles/debris2/4.obj",
        ASSETS_ROOT.."misc/obstacles/debris2/5.obj"
    }
    --length = 3.3165 (3.46) = 0.9585 * 0.73 = 0.7 (thigh to tip of drumstick)
    --width = 2.183 (across thigh) (2.3) = 0.9491 * 0.73 = 0.6928
    -- 0.6964
})
Obstacle:new({
    name = "Debris 3", --muffin
    colliders = {ASSETS_ROOT.."misc/obstacles/debris3/mesh.obj","http://paste.ee/r/FJVoR","http://paste.ee/r/WUL3V"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/debris3/1.obj",
        ASSETS_ROOT.."misc/obstacles/debris3/2.obj",
        ASSETS_ROOT.."misc/obstacles/debris3/3.obj",
        ASSETS_ROOT.."misc/obstacles/debris3/4.obj",
        ASSETS_ROOT.."misc/obstacles/debris3/5.obj"
    }
    --length = 2.71 (2.6) = 1.0425 * 0.75 = 0.7817
    --width = 2.647 (across top) (2.55) = 1.038 * 0.75 = 0.7785
    -- 0.78
})
Obstacle:new({
    name = "Asteroid 4", --sharktooth
    colliders = {ASSETS_ROOT.."misc/obstacles/asteroid4/mesh.obj","http://paste.ee/r/sgn4L","http://paste.ee/r/JZSVK"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/asteroid4/1.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid4/2.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid4/3.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid4/4.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid4/5.obj"
    }
    -- 2.492
    --length =  2.15 (2.15) = 80
    --width = 1.56 (1.51) = 1.033 * 0.8 = 0.826
    -- 0.814
})
Obstacle:new({
    name = "Asteroid 5", --tornado
    colliders = {ASSETS_ROOT.."misc/obstacles/asteroid5/mesh.obj","http://paste.ee/r/t10DL","http://paste.ee/r/n43Kl"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/asteroid5/1.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid5/2.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid5/3.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid5/4.obj",
        ASSETS_ROOT.."misc/obstacles/asteroid5/5.obj"

    }
    --length = 2.383 (2.3) = 1.036 *0.75 = 0.777
    --width =2.3 (2.2) = 1.045 *0.75 = 0.784
    -- 0.7805
})

Obstacle:new({
    name = "Station",
    colliders = {ASSETS_ROOT.."misc/obstacles/station/mesh.obj","http://paste.ee/r/Hm8Hf","http://paste.ee/r/2r7bq"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/station/1.obj",
        ASSETS_ROOT.."misc/obstacles/station/2.obj",
        ASSETS_ROOT.."misc/obstacles/station/3.obj",
        ASSETS_ROOT.."misc/obstacles/station/4.obj",
        ASSETS_ROOT.."misc/obstacles/station/5.obj"
    }
    --length = 3.3 (3.39) = 0.97 * 0.8 = .7787
    --width =3.488 (3.46) = 1.008 *0.8 = 0.8065
    -- 0.7925
})

Obstacle:new({
    name = "Gas Cloud 1", --double bump?
    colliders = {ASSETS_ROOT.."misc/obstacles/gascloud1/mesh.obj","http://paste.ee/r/CGICy","http://paste.ee/r/oEuEI"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/gascloud1/1.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud1/2.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud1/3.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud1/4.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud1/5.obj"
    }
    --length = 5.227 (5.01) = 1.0433
    --width = 1.526 (1.48) = 1.031
    -- 1.037
})
Obstacle:new({
    name = "Gas Cloud 2",
    colliders = {ASSETS_ROOT.."misc/obstacles/gascloud2/mesh.obj","http://paste.ee/r/N9UN7","http://paste.ee/r/DmDpr"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/gascloud2/1.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud2/2.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud2/3.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud2/4.obj",
        ASSETS_ROOT.."misc/obstacles/gascloud2/5.obj"

    }
    --length = 5.175 (4.99) = 1.037
    --width = 1.538 (1.48) = 1.039
    -- 1.038
})
Obstacle:new({
    name = "Gravity Rift",
    colliders = {ASSETS_ROOT.."misc/obstacles/rift/mesh.obj","http://paste.ee/r/DpEzj","http://paste.ee/r/Vtola"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/rift/1.obj",
        ASSETS_ROOT.."misc/obstacles/rift/2.obj",
        ASSETS_ROOT.."misc/obstacles/rift/3.obj",
        ASSETS_ROOT.."misc/obstacles/rift/4.obj",
        ASSETS_ROOT.."misc/obstacles/rift/5.obj"
    },
    default = 2
    --length = 3.9175 (3.75) = 1.04467
    --width = 3.912 (3.77) = 1.037
    --1.04 * 0.77 = 0.8
})
Obstacle:new({
    name = "Exogorth 1",
    colliders = {ASSETS_ROOT.."misc/obstacles/exogorth1/mesh.obj","http://paste.ee/r/GJm0K","http://paste.ee/r/X9TRv"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/exogorth1/1.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth1/2.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth1/3.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth1/4.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth1/5.obj"
    }
    --length = 2.277 (2.18) = 1.044
    --width = 1.6055 (1.54) = 1.0425
    -- 1.043 * .77 = 0.803
})
Obstacle:new({
    name = "Exogorth 2", --hook?
    colliders = {ASSETS_ROOT.."misc/obstacles/exogorth2/mesh.obj","http://paste.ee/r/I3IZm","http://paste.ee/r/UfCaR"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/exogorth2/1.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth2/2.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth2/3.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth2/4.obj",
        ASSETS_ROOT.."misc/obstacles/exogorth2/5.obj"
    }
    --length 2.222 (2.13) = 1.043
    --width 1.52 (1.43) = 1.063
    -- 1.053 *0.77 = 0.81081
})
Obstacle:new({
    name = "Purrgil 1", --open mouth (hump tail)
    colliders = {ASSETS_ROOT.."misc/obstacles/purrgil1/mesh.obj","http://paste.ee/r/HRGiE","http://paste.ee/r/SQ4Pt"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/purrgil1/1.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil1/2.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil1/3.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil1/4.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil1/5.obj"
    }
    --length = 4.164 (3.98) = 1.046   1.297
    --width = 1.65 (1.57) = 1.051
    -- 0.77 * 1.0485 = 0.807
})
Obstacle:new({ --TODO: Move within 2
    name = "Purrgil 2",
    colliders = {ASSETS_ROOT.."misc/obstacles/purrgil2/mesh.obj","http://paste.ee/r/4QT4q","http://paste.ee/r/TTaOC"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/purrgil2/1.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil2/2.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil2/3.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil2/4.obj",
        ASSETS_ROOT.."misc/obstacles/purrgil2/5.obj"
    }
    --length = 4.157 (3.99) = 1.042
    --width = 1.484 (1.43) = 1.0378
    -- 0.77 * 1.0399 = 0.8
})
Obstacle:new({
    name = "Objective Token",
    colliders = {ASSETS_ROOT.."misc/obstacles/tokens/objective.obj","http://paste.ee/r/9DQmH"},
    rulers = {
        ASSETS_ROOT.."misc/obstacles/tokens/1.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/2.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/3.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/4.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/5.obj"
    },
    scale = 0.5
})
Obstacle:new({
    name = "Gravity Well",
    colliders = {ASSETS_ROOT.."misc/obstacles/tokens/well.obj","http://paste.ee/r/AZMeZ"}, --"http://paste.ee/r/FcelK", --http://paste.ee/r/1KFnT",
    rulers = {
        ASSETS_ROOT.."misc/obstacles/tokens/1.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/2.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/3.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/4.obj",
        ASSETS_ROOT.."misc/obstacles/tokens/5.obj"
    },
    scale = 0.5,
    default = 3
})
Obstacle:new({
    name = "Targeting Token",
    colliders = {ASSETS_ROOT.."misc/obstacles/tokens/ignition.obj","http://paste.ee/r/OGmMO"}, --"http://paste.ee/r/feeFX", --http://paste.ee/r/1pouf",
    rulers = {
        ASSETS_ROOT.."misc/obstacles/tokens/close_med_long.obj"
    },
    scale = 0.5
})
-- Objective 1-2
-- move 2
-- move 2 or 4
-- move 2
-- move obstacle 2
-- purrgil move 2
end
OBSTACLE_BTN_NORMAL = 1
OBSTACLE_BTN_HIGH = 2
OBSTACLE_BTN_NONE = 0
current_obstacle_btn_state = 1
function onClick_ToggleAsteroidBtns(player, _, idValue)
    current_obstacle_btn_state = math.mod(current_obstacle_btn_state + 1,3)
    if current_obstacle_btn_state == OBSTACLE_BTN_NORMAL then
        broadcastToAll("Set obstacle buttons to NORMAL", {0,1,0})
    end
    if current_obstacle_btn_state == OBSTACLE_BTN_HIGH then
        broadcastToAll("Set obstacle buttons to ELEVATED", {1,0,0})
    end
    if current_obstacle_btn_state == OBSTACLE_BTN_NONE then
        broadcastToAll("Set obstacle buttons to HIDDEN", {0,0,0})
    end
    for _,obj in ipairs(getAllObjects()) do
        if isObstacle(obj) then
            update_asteroid_buttons(obj, player.color)
        end
    end

end
function isObstacle(obj)
    custom = obj.getCustomObject()
    return custom~=nil and custom.collider~=nil and Obstacle.lookup(custom.collider)~=nil and custom.diffuse~="" and custom.diffuse~=nil
end
function onObjectHover_asteroid(obj, player)
    if isObstacle(obj) then
        if not obj.getLock() then --Only update while unlocked to recover from flipping
            update_asteroid_buttons(obj,player)
        end
    end
end
function onObjectDropped_asteroid(obj, player)
    if isObstacle(obj) then
        update_asteroid_buttons(obj,player)
    end
end
function onObjectSpawn_asteroid(obj)
    if isObstacle(obj) then
        update_asteroid_buttons(obj)
    end
end
function update_asteroid_buttons(obj,player)
    obj.clearButtons()
    if current_obstacle_btn_state == OBSTACLE_BTN_NONE then
        return
    end
    custom = obj.getCustomObject()
    h = 0.25
    if current_obstacle_btn_state == OBSTACLE_BTN_HIGH then
        h = 2
    end
    z_rot = 0
    if obj.is_face_down then --math.abs(obj.getRotation()[3])>10
        h = -h --0.1
        z_rot = 180
    end
    def = Obstacle.lookup(custom.collider)
    if not obj.getLock() then
        obj.createButton(billboard({label="Lock",click_function="Action_LockAsteroid", position={0,h,0}, rotation={0,0,z_rot}, width=800*def.scale, height=300*def.scale, font_size=200*def.scale, color={0,1,0,0.5}, font_color={1,1,1,2}},obj,player))
    else
        if obj.getVar('ruler')==nil then
            color = {0,0,0,0.5}
            if current_obstacle_btn_state == OBSTACLE_BTN_HIGH then
                color = {1,0,0,0.5}
            end
            obj.createButton(billboard({label="",click_function="Action_LoadLastAsteroidRuler",position={0,h,0}, rotation={0,0,z_rot},width=800*def.scale,height=800*def.scale,color=color,tooltip="Spawn Range Ruler"},obj,player))
        else
            obj.createButton(billboard({label="Clear", position={0,h,0.5}, rotation={0,0,z_rot},click_function="Action_ClearAsteroidRuler",width=800, height=300, font_size=200, color={1,0,0,0.5}, font_color={1,1,1,2}},obj,player))
            obj.createButton(billboard({label="Move", position={0,h,-1.5}, rotation={0,0,z_rot},click_function="Action_MoveAsteroid",width=800, height=300, font_size=200, color={0,0.5,1,0.5}, font_color={1,1,1,2}},obj,player))
            if #def.rulers>1 then
                color = {0,0,0.5,0.5}
                if obj.getVar('last_ruler_size')==1 then color={0,1,0,0.5} end
                obj.createButton(billboard({label="1", click_function="Action_LoadAsteroidRuler1",position = {-1.4,h,-0.5}, rotation={0,0,z_rot}, width=300, height=300, font_size=200, color=color, font_color={1,1,1,2}},obj,player))
                color = {0,0,0.5,0.5}
                if obj.getVar('last_ruler_size')==2 then color={0,1,0,0.5} end
                obj.createButton(billboard({label="2", click_function="Action_LoadAsteroidRuler2",position = {-0.7,h,-0.5}, rotation={0,0,z_rot}, width=300, height=300, font_size=200, color=color, font_color={1,1,1,2}},obj,player))
                color = {0,0,0.5,0.5}
                if obj.getVar('last_ruler_size')==3 then color={0,1,0,0.5} end
                obj.createButton(billboard({label="3", click_function="Action_LoadAsteroidRuler3",position = {0,h,-0.5}, rotation={0,0,z_rot}, width=300, height=300, font_size=200, color=color, font_color={1,1,1,2}},obj,player))
                color = {0,0,0.5,0.5}
                if obj.getVar('last_ruler_size')==4 then color={0,1,0,0.5} end
                obj.createButton(billboard({label="4", click_function="Action_LoadAsteroidRuler4",position = {0.7,h,-0.5}, rotation={0,0,z_rot}, width=300, height=300, font_size=200, color=color, font_color={1,1,1,2}},obj,player))
                color = {0,0,0.5,0.5}
                if obj.getVar('last_ruler_size')==5 then color={0,1,0,0.5} end
                obj.createButton(billboard({label="5", click_function="Action_LoadAsteroidRuler5",position = {1.4,h,-0.5}, rotation={0,0,z_rot}, width=300, height=300, font_size=200, color=color, font_color={1,1,1,2}},obj,player))
            end
        end
    end
end
function billboard(button, obj, player)
    local rotation = 180
    if player~=nil then
        rotation = Player[player].getPointerRotation()
    end
    --TODO: Take into account Z rot?
    y_rot = -obj.getRotation()[2] + rotation
    z_rot = 0
    if button.rotation~=nil then
        z_rot = button.rotation[3]
    end
    button_rot = {0, y_rot, z_rot }
    if math.abs(z_rot)>10 then
        button_pos = vector.rotate(button.position, y_rot)
    else
        button_pos = vector.rotate(button.position, -y_rot)
    end
    button.rotation = button_rot
    button.position = button_pos
    return button
end
function onload_asteroid()
    loadAsteroidDefs()
    for i,obj in ipairs(getAllObjects()) do
        onObjectSpawn_asteroid(obj)
    end
end
function Action_LoadAsteroidRuler1(obj, player, _)  LoadAsteroidRuler(obj, 1, player) end
function Action_LoadAsteroidRuler2(obj, player, _)  LoadAsteroidRuler(obj, 2, player) end
function Action_LoadAsteroidRuler3(obj, player, _)  LoadAsteroidRuler(obj, 3, player) end
function Action_LoadAsteroidRuler4(obj, player, _)  LoadAsteroidRuler(obj, 4, player) end
function Action_LoadAsteroidRuler5(obj, player, _)  LoadAsteroidRuler(obj, 5, player) end
function Action_LoadLastAsteroidRuler(obj, player, alt_click)
    if alt_click then
        return
    end
    size = obj.getVar('last_ruler_size')
    if size==nil then
        def = Obstacle.lookup(obj.getCustomObject().collider)
        size = def.default
    end
    LoadAsteroidRuler(obj,size, player)
end
function LoadAsteroidRuler(obj, size, player) --size 1-5
    obj.lock()
    local old_ruler = obj.getVar('ruler')
    local obstacle_collider = obj.getCustomObject().collider
    def = Obstacle.lookup(obstacle_collider)
    if old_ruler~=nil then
        old_ruler.destruct()
    end

    local obj_parameters = {}
    obj_parameters.type = 'Custom_Model'
    obj_parameters.position = obj.getPosition() --vector.add(obj.getPosition(),{0.1,0,0.1})
    if obj.is_face_down then --math.abs(obj.getRotation()[3])>10
        -- print("face down")
        obj_parameters.rotation = {0,obj.getRotation()[2],180}
    else
        obj_parameters.rotation = {0,obj.getRotation()[2],0}
    end
    local ruler = spawnObject(obj_parameters)
    local custom = {}
    custom.mesh = def.rulers[size]
    custom.collider = obstacle_collider
    ruler.setCustomObject(custom)
    obj.setVar("ruler",ruler)
    obj.setVar('last_ruler_size', size)
    ruler.lock()
    update_asteroid_buttons(obj, player)
end
function Action_MoveAsteroid(obj, player, _)
    -- Spawn Shadow
    -- print(">>> Action_MoveAsteroid")
    local obj_parameters = {}
    obj_parameters.type = 'Custom_Model'
    obj_parameters.position = obj.getPosition()
    obj_parameters.rotation = obj.getRotation()
    -- print("Spawning Object... ")
    local shadow = spawnObject(obj_parameters)
    local custom = {}
    -- print("Getting collider... ")
    local obstacle_collider = obj.getCustomObject().collider
    custom.mesh = obstacle_collider
    custom.collider = obstacle_collider
    custom.material = 3
    -- print("Setting custom... ")
    shadow.setCustomObject(custom)
    -- print("Setting tint... ")
    shadow.setColorTint({0.3,0.3,0.3})
    -- print("Locking shadow... ")
    shadow.lock()
    -- print("Setting shadow var... ")
    obj.setVar("shadow",shadow)

    -- print("Repositioning obstacle... ")
    obj.setPosition(vector.add(obj.getPosition(),{0,1,0}))
    obj.unlock() --DO NOT UNLOCK WITH OVERLAPPING COLLIDERs
    -- Wait.frames(||obj.unlock(), 10)
    -- print("Waiting to update UI... ")
    Wait.frames(||update_asteroid_buttons(obj, player),1)
end
function Action_LockAsteroid(obj, player, _)
    obj.lock()
    shadow = obj.getVar('shadow')
    if shadow~=nil then
        shadow.destruct()
    end
    obj.setVar('shadow',nil)
    Action_ClearAsteroidRuler(obj, player, _)
end
function Action_ClearAsteroidRuler(obj, player, _)
    ruler = obj.getVar('ruler')
    if ruler~=nil then
        ruler.destruct()
    end
    obj.setVar('ruler',nil)
    Wait.frames(||update_asteroid_buttons(obj, player),1)
end

----#include asteroid
SPAWNER = nil
function onload(save_string)
    if findObjectByName("PARTY!") then
        UI.hide('cloudBtn')
        UI.hide('refreshBtn')
        UI.hide('tableBtn')
        UI.setAttribute('btnBar', 'height', '240')
    end
    Lighting.ambient_type = 2
    Lighting.ambient_intensity = 2
    Lighting.apply()
     MAGIC_RULER = findObjectByName('Magic Ruler')
     shield_dials = findObjectByName('Shield Dials')
     SPAWNER = findObjectByName('Armada Spawner')
   for i,obj in ipairs(getAllObjects()) do
       drawDatacardButtons(obj)
--        if isShip(ship) then
--            Ship_Initialize(ship)
--        end
--        if isSquad(ship) then
--            Squad_Initialize(ship)
--        end
   end
    if save_string~="" then
        local data = JSON.decode(save_string)
        for i, shipdata in pairs(data) do
            local obj = getObjectFromGUID(shipdata["GUID"])
            if obj~=nil then
                if obj.tag == "Figurine" then
                    obj.setVar('owner',shipdata["owner"])
                    obj.setVar('team',shipdata["team"])
                    obj.setVar('rulerMesh',shipdata["rulerMesh"])
                    obj.setTable('maneuver',shipdata["maneuver"])
                    obj.setTable('shields',shipdata["shields"])
                    obj.setVar('hasShields',shipdata["hasShields"])
                    obj.setVar('cmdBaseGUID',shipdata["cmdBaseGUID"])
                    obj.setTable('InitialPosition',shipdata["InitialPosition"])
                    obj.setVar('card',shipdata["card"])
                    if shipdata["rulerGUID"]~=nil then
                        obj.setVar(getObjectFromGUID(shipdata["rulerGUID"]))
                    end
                    -- obj.setTable('moved_objects',shipdata["moved_objects"])
                elseif obj.tag == "Card" then
                    obj.setTable('spawns',shipdata["spawns"])
                end
            end
        end
    end
    -- drawSquadronButtons()
    onload_asteroid()
end
function isDatacard(object)
    custom = object.getCustomObject()
    return custom ~= nil and (custom.mesh == ASSETS_ROOT.."misc/datacard.obj" or custom.mesh == "http://paste.ee/r/uY3YX")
end
function drawDatacardButtons(obj)
    Wait.time(|| delayed_drawDatacardButtons(obj), 1, 0)
end
function delayed_drawDatacardButtons(obj)
    if obj~=nil and isDatacard(obj) then
        if obj.getDescription()~=nil and #obj.getDescription()>0 then
            obj.clearButtons()
        -- if custom ~= nil and custom.image=="http://i.imgur.com/EUi3Wog.png" then
            obj.createButton({
                ['click_function'] = "Action_fleet_spawn",
                ['function_owner'] = SPAWNER,
                ['label'] = "Spawn\nFleet",
                ['position'] = {0,0.35,-0.42},
                ['rotation'] =  {0,0,0},
                ['width'] = 600,
                ['height'] = 600,
                ['font_size'] = 200,
                ['color'] = {217/256,180/256,109/256,0.9},
                ['font_color']={0,0,0,1.11}})
            name = obj.getName()
            if string.len(name)>24 then
                splits = math.floor(string.len(name)/24)
                split_name = name:split(" ")
                word_count = #split_name
                words_per_line = math.floor(word_count/(splits+1))
                name = ""
                for i,word in ipairs(split_name) do
                    name = name .. word
                    if i~=word_count then
                        if i==words_per_line  then
                            name = name .. "\n"
                        else
                            name = name .. " "
                        end
                    end
                end
            end
            obj.createButton({
                ['click_function'] = "Action_fleet_spawn",
                ['function_owner'] = SPAWNER,
                ['label'] = name,
                ['position'] = {0,0.25,1},
                ['rotation'] =  {0,0,0},
                ['width'] = 1000,
                ['height'] = 450,
                ['font_size'] = 80,
                ['color'] = {0,0,0,0.9},
                ['font_color']={1,1,1,1.11}})
        else
            obj.clearButtons()

            obj.createButton({
                ['click_function'] = "Action_store_fleet",
                ['function_owner'] = SPAWNER,
                ['label'] = "Store\nFleet",
                ['position'] = {0,0.35,-0.42},
                ['rotation'] =  {0,0,0},
                ['width'] = 600,
                ['height'] = 600,
                ['font_size'] = 200,
                ['color'] = {217/256,180/256,109/256,0.9},
                ['font_color']={0,0,0,1.11}})
            obj.createButton({
                ['click_function'] = "Action_store_fleet",
                ['function_owner'] = SPAWNER,
                ['label'] = "EMPTY DATACARD",
                ['position'] = {0,0.25,1},
                ['rotation'] =  {0,0,0},
                ['width'] = 1000,
                ['height'] = 450,
                ['font_size'] = 80,
                ['color'] = {1,0,0,0.9},
                ['font_color']={1,1,1,1.11}})
        end
    end
end
-- function drawSquadronButtons()
--     local white = getObjectFromGUID(BOTTOM_REF_WHITE_GUID)
--     local blue = getObjectFromGUID(BOTTOM_REF_BLUE_GUID)
--     white.clearButtons()
--     blue.clearButtons()
--     local label = "Free"
--     if restrict_squadrons then
--         label = "Normal"
--     end
--     white.createButton(buildButton(label.." Squadron Movement",{click_function="Action_ToggleSquadronMovement",position = {0,0.5,2},width = 2000, height = 200},squad_button_def))
--     blue.createButton(buildButton(label.." Squadron Movement",{click_function="Action_ToggleSquadronMovement",position = {0,0.5,2},width = 2000, height = 200},squad_button_def))
--     local label = "Normal"
--     if squadrons_extended_attack then
--         label = "Rhymer"
--     end
--     white.createButton(buildButton(label.." Squadron Attack",{click_function="Action_ToggleSquadronAttack",position = {0,0.5,2.5},width = 2000, height = 200},squad_button_def))
--     blue.createButton(buildButton(label.." Squadron Movement",{click_function="Action_ToggleSquadronAttack",position = {0,0.5,2.5},width = 2000, height = 200},squad_button_def))
--
--     white.createButton(buildButton("Destroy Ships",{click_function="Action_ToggleDestroyShipButtons",position = {0,0.5,3},width = 2000, height = 200, color={1,0,0}, font_color={1,1,1}},squad_button_def))
--     blue.createButton(buildButton("Destroy Ships",{click_function="Action_ToggleDestroyShipButtons",position = {0,0.5,3},width = 2000, height = 200, color={1,0,0}, font_color={1,1,1}},squad_button_def))
-- end
-- function Action_ToggleSquadronMovement()
--     restrict_squadrons = not restrict_squadrons
--     drawSquadronButtons()
-- end
-- function Action_ToggleSquadronAttack()
--     squadrons_extended_attack = not squadrons_extended_attack
--     drawSquadronButtons()
-- end
function Action_ToggleDestroyShipButtons()
    for _,ship in ipairs(getAllObjects()) do
        if isSquad(ship) then
            clearSquadRulers(ship)
        end
        if isShip(ship) or isSquad(ship) then
            ship.clearButtons()
            ship.createButton(buildRelativeButton(ship, "DESTROY",{click_function="Action_destroy",position={0,1,-0.3},width=800, height=500, color={1, 0, 0 ,0.9}, font_color={1,1,1,1.11}, tooltip="Move Ship to side"},ship_button_def))
        end
    end
    Wait.time(|| redraw_ships(), 3, 0)
end
function redraw_ships()
    for _,ship in ipairs(getAllObjects()) do
        if isShip(ship) then
            drawShipButtons(ship)
        end
        if isSumma(ship) then
            drawSummaButtons(ship)
        end
        if isSquad(ship) then
            updateSquadButtons(ship)
        end
    end
end
function Action_destroy(ship)
    pos = ship.getTable("InitialPosition")
    pos = Vector(pos['x'],pos['y'],pos['z'])
    -- print(#pos)
    -- print(pos['x'])
    -- print(pos['y'])
    -- print(pos['z'])
    if pos[3]>0 then
        pos = pos:setAt(3,pos[3]+8)
    else
        pos = pos:setAt(3,pos[3]-8)
    end
    ship.lock()
    local ruler = ship.getVar('ruler')
    if ruler~=nil then
        ruler.destruct()
    end
    if isShip(ship) then
        ship.setVar('ruler',nil)
        MAGIC_RULER.call("API_MOVE_SHIP",{ship=ship,pos=pos,rot={0,0,0}})
    else
        squad_move_rulers[ship.getGUID()]=nil
        ship.setPositionSmooth(pos, false, true)
    end
    -- Wait.frames(|| spawner.call('updateFleetCostDisplay',ship.getVar('owner')),20)
end
function onSave()
    local save = {}
    for i, ship in ipairs(getAllObjects()) do
        if ship.tag == "Figurine" then -- and ship.getVar('owner')~=nil
            local data = {}
            data["GUID"] = ship.getGUID()
            data["rulerMesh"] = ship.getVar('rulerMesh')
            data["maneuver"] = ship.getTable('maneuver')
            data["owner"] = ship.getVar('owner')
            data["team"] = ship.getVar('team')
            data["shields"] = ship.getTable('shields')
            data["hasShields"] = ship.getVar('hasShields')
            data["cmdBaseGUID"] = ship.getVar('cmdBaseGUID')
            data["InitialPosition"] = ship.getTable('InitialPosition')
            data["card"] = ship.getVar('card')
            if ship.getVar('ruler')~=nil then
                data["rulerGUID"] = ship.getVar('ruler').guid
            end
            -- data["moved_objects"] = ship.getTable('moved_objects')
            save[ship.getGUID()] = data
        end
        if ship.tag == "Card" then
            local data = {}
            data["GUID"] = ship.getGUID()
            data["spawns"] = ship.getTable('spawns')
            save[ship.getGUID()] = data
        end
    end
    local save_string = JSON.encode_pretty(save)
    return save_string
end
function update()
    for _,ship in ipairs(getAllObjects()) do
        -- if ship.getName() == 'Summa' then
        --     if not ship.getVar('init') then
        --         Initialize(ship)
        --     end
        -- end
        if ship.tag == 'Figurine' and ship.name ~= '' then
            local cmd = ship.getDescription()
            local oldName = ship.getVar('oldName')
            ship.setVar('oldName',ship.getName())
            if not ship.getVar('init') then
                Initialize(ship)
            end
            if isSquad(ship) then
                stopDropLock(ship)
            elseif isShip(ship) then
                CheckShip(ship)
            end
            if cmd~="" then
                if oldName ~= ship.getName() then
                    ship.setName(oldName)
                end
                ship.setDescription("")
                if cmd=="checkscale" then
                    printToAll(ship.getScale()[1],{0,1,1})
                end
                if cmd:starts "setscale " then
                    local s = string.gsub(cmd,"setscale ","")
                    ship.setScale({s,s,s})
                end
                if cmd=="checkpos" then
                    printToAll(vector.tostring(ship.getPosition()),{0,1,1})
                end
                if cmd=="checkrot" then
                    printToAll(tostring(ship.getRotation()[2]),{0,1,1})
                end
                if cmd:starts "var " then
                    printToAll(ship.getVar(cmd:match "var%s(.*)"),{0,1,0})
                end
                if isSquad(ship) then
                    if cmd=="r" then
                        spawnSquadRuler(ship,SQUAD_MOVE_RULER)
                    end
                    if cmd=="checkscale" then
                        printToAll(ship.getScale()[1],{0,1,1})
                    end
                    if cmd:starts "health" then
                        squad.UpdateName(ship,cmd:match "health%s(.*)",nil,nil)
                    end
                    if cmd:starts "maxhealth" then
                        squad.UpdateName(ship,nil,cmd:match "maxhealth%s(.*)",nil)
                    end
                    if cmd:starts "speed" then
                        squad.UpdateName(ship,nil,nil,cmd:match "speed%s(.*)")
                    end
                    --stopDropLock(ship)
                elseif isShip(ship) then
--                    CheckShip(ship)
                    if cmd =="shields" then
                        spawnShields(ship)
                    end
                    if cmd =="cmds" then
                        printCmds(ship)
                    end
                end
            end
        end
    end
    restrictMoveDistance(moving_with_ruler)
end

function printCmds(ship)
    --printToAll("printCmds",{1,0,0})
    local owner = ship.getVar('owner')
    --printToAll(owner,{1,0,0})
    if owner==nil then
        printToAll('Ship has no owner, pick it up to claim ownership',{1,0,0})
    elseif not table.contains(getSeatedPlayers(),owner) then
        printToAll('No player seated at: '..owner,{1,0,0})
    else
        cmdBaseGUID = ship.getVar("cmdBaseGUID")
        -- print(cmdBaseGUID)
        cmdBase = getObjectFromGUID(cmdBaseGUID)
        -- print(cmdBase)
        local cmds = {}
        local foundShipCommands = false
        local foundBaseCommands = false
        for i,token in ipairs(getAllObjects()) do
            local custom = token.getCustomObject()
            local tokenDiffuse = custom.diffuse
            local isDial = custom~=nil and table.contains(CMD_MESHES,custom.diffuse)
            local offset = vector.rotate(vector.sub(token.getPosition(),ship.getPosition()),-ship.getRotation()[2])
            local size = ship_size[ship.getVar('size')]
            local isOnBase = math.abs(offset[1])<math.abs(size[1]) and math.abs(offset[3])<math.abs(size[3])
            local isOnCommandBase = false
            if cmdBase~=nil then
                local cmdBaseOffset = vector.sub(token.getPosition(),cmdBase.getPosition())
                isOnCommandBase = math.abs(cmdBaseOffset[1])<1.5 and math.abs(cmdBaseOffset[3])<1.5
            end
            if isOnBase and isDial then
                table.insert(cmds,token)
                foundShipCommands = true
            end
            if isOnCommandBase and isDial then
                table.insert(cmds,token)
                foundBaseCommands = true
            end
        end
        if foundShipCommands and foundBaseCommands then
            broadcastToColor("Warning: Commands on Ship and Cmd Base!", owner, {1,0.5,0})
        end
        printToColor("===================================",owner, {1,1,1})
        printToColor("The below list is in reverse order:",owner, {1,1,1})
        table.sort(cmds, function(a,b) return a.getPosition()[2] < b.getPosition()[2] end)
        for i,token in ipairs(cmds) do
            broadcastToColor("#"..(1+#cmds-i).." "..CMD_NAMES[token.getCustomObject().diffuse], owner, CMD_COLORS[token.getCustomObject().diffuse] )
        end
        broadcastToColor("Cmds for: "..ship.getName(), owner, {0,1,0} )
        printToColor("===================================",owner, {1,1,1})
    end
end
dial = {}
function dial.name(dial)
    local mesh = dial.getCustomObject().diffuse
    if mesh == "http://i.imgur.com/IHXy7k7.jpg" then
        return "Repair"
    elseif mesh == "http://i.imgur.com/hGXCVQo.jpg" then
        return "Navigate"
    elseif mesh == "http://i.imgur.com/ip3tJaN.jpg" then
            return "Concentrate Fire"
    elseif mesh == "http://i.imgur.com/XbJbScU.jpg" then
            return "Squadron"
    end
    return ""
end
--shieldedShip = nil
ship_size = {
    {0.807,0,1.398}, --small
    {1.201,0,2.008}, --med
    {1.496,0,2.539}, --large
    {1.496,0,2.539,2.539*3+3.68}, --huge (=11.297)
    --{1.201,0,2.008,9.10} --custom massive doublemed
    {1.496,0,2.539,9.10} --custom massive shortHuge
}
shield_pos = {
    {0.634,0,1.176,-1.176}, --small
    {1.028,0,1.835,-1.835}, --med
    {1.323,0,2.377,-2.377}, --large
    {1.323,0,2.377,2.539*2+2.377+3.68}, --huge (=11.135)
    --{1.055,0,1.835,6.4} --custom massive doublemed / sides mirror offset, zero, rear offset, front offset
    {1.4,0,2.45,8.2} --custom massive shortHuge / sides mirror offset, zero, rear offset, front offset
}
function spawnShields(ship)
--    local pos = ship.getPosition()
--    ship.unlock()
--    ship.setPosition({pos[1],15,pos[3]})
    ship.lock()
    local size = getSize(ship)
    local o = shield_pos[math.mod(size-1,5)+1]
    local offsets = { --front, left, right, rear
        {0,0,math.abs(o[4])},
        {-math.abs(o[1]),0,0},
        {math.abs(o[1]),0,0},
        {0,0,-math.abs(o[3])},
    }
    if size==4 then --huge size, array 4 in ships[]
        table.insert(offsets,{-math.abs(o[1]),0,2.539*2+3.68}) --front left
        table.insert(offsets,{math.abs(o[1]),0,2.539*2+3.68}) --front right
    elseif size==5 then --custom massive size, array 5 in ships[] 
        --table.insert(offsets,{-math.abs(o[1]),0,4.50}) --doublemed
        --table.insert(offsets,{math.abs(o[1]),0,4.50}) --doublemed
        table.insert(offsets,{-math.abs(o[1]),0,5.75}) --shortHuge
        table.insert(offsets,{math.abs(o[1]),0,5.75}) --shortHuge

    end

    local world = ship.getPosition()
    local ground = {world[1],1,world[3]}
    local shields = ship.getTable("shields")
    for i,pos in ipairs(offsets) do

        local offset = vector.rotate(pos, ship.getRotation()[2])

        local params = {}
        params.position = vector.add(ground,offset)
        params.rotation = ship.getRotation()
        params.callback = 'fixshieldheight'
        params.callback_owner = Global
        local shieldValue = 1
        if shields~=nil then
            shieldValue = shields[i]
        end
        params.params = {ship,shieldValue}
        --params.callback_function = function(obj) fixshieldheight(obj, {ship, shieldValue}) end
        local shield = shield_dials.takeObject(params)
        -- TODO: move up to 1.36
    end
end
function fixshieldheight(object, params)
    -- printToAll("object==nil"..tostring(object==nil),{1,1,1})
    -- printToAll("params==nil"..tostring(params==nil),{1,1,1})
    -- printToAll("params[1]==nil"..tostring(params[1]==nil),{1,1,1})
    -- printToAll("params[2]"..tostring(params[2]),{1,1,1})
    local pos = object.getPosition()
    local rot = object.getRotation()
    object.lock() --lock 1 state
    if params[2]>1 then
        object = object.setState(params[2])
        object.lock()
    end
    object.setPositionSmooth({pos[1],1.36,pos[3]},false,true)
    object.setRotationSmooth({0,rot[2],0},false,true)
--    local ship = params[1]
--    local size = ship_size[ship.getVar('size')]
--    for _,obj in ipairs(getAllObjects()) do
--        local offset = vector.rotate(vector.sub(obj.getPosition(),ship.getPosition()),-ship.getRotation()[2])
--        if math.abs(offset[1])<math.abs(size[1]) and math.abs(offset[3])<math.abs(size[3]) then
--            -- WAS ON BASE
--            local pos = obj.getPosition()
--            pos[2] = 1.36
--            obj.setPosition(pos)
--            obj.lock()
--        end
--    end
    --http://i.imgur.com/WQJNmkt.png
end
--function spawnShieldsCorout()
--    local size = getSize(shieldedShip)
--    local o = button_pos[size]
--    local offsets = {
--        {o[1],0,0},
--        {-o[1],0,0},
--        {0,0,o[3]},
--        {0,0,-o[3]},
--    }
--
--    local world = shieldedShip.getPosition()
--    local ground = {world[1],0,world[2]}
--    shieldedShip.lock()
--    shieldedShip.setPosition(newpos)
--    for i,pos in ipairs(offsets) do
--
--        local offset = vector.rotate(pos, shieldedShip.getRotation()[2])
--
--        local params = {}
--        params.position = vector.add(ground,offset)
--        local shield = shield_dials.takeObject(params)
----        for i=1, 150, 1 do
----            coroutine.yield(0)
----        end
----            --delay
----        shield.lock()
----        local pos = shield.getPosition()
----        pos[2] = 0
----        shield.setPosition(pos)
--    end
--    return true
--end
function stopDropLock(squadron)
    local stop = squadron.getVar('stop')
    local drop = squadron.getVar('drop')
    if stop~=nil and stop>0 then
        squadron.setVar('stop',stop-1)
    elseif stop~=nil and stop==0 then
        squadron.setVar('stop',nil)
        --squadron.setVar('drop',30)
        squadron.unlock()
--    elseif drop~=nil and drop>0 then
--        squadron.setVar('drop',drop-1)
--    elseif drop~=nil and drop==0 then
--        squadron.setVar('drop',nil)
        --squadron.lock()
    end
end
function restrictMoveDistance(squadron)
    local distances = {2.93,4.875,7.25,9.625,12}
    if squadron~=nil and restrict_squadrons then
        local ruler = squad_move_rulers[squadron.getGUID()]
        if ruler~=nil then
            local speed = squadron.getVar('speed_override') or squad.speed(squadron)
            local maxDistance = distances[speed] -- * 1.206
            local offset = vector.sub(squadron.getPosition(),ruler.getPosition())
            offset[2] = 0
            local distance = vector.length(offset)
            if distance>maxDistance then
                local restricted = vector.prod(offset,maxDistance/distance)
                local new_pos = vector.add(ruler.getPosition(),restricted)
                new_pos[2] = squadron.getPosition()[2]
                squadron.setPosition(new_pos)
            end
        end
    end
end
function Initialize(ship)
    if isShip(ship) then
        ship.setVar('init',true)
        ship.setVar('size',getSize(ship))
        drawShipButtons(ship)
    elseif isSumma(ship) then
        ship.setVar('init',true)
        ship.setVar('size',1) --SMALL
        drawSummaButtons(ship)
    elseif isSquad(ship) then
        ship.setVar('init',true)
        --printToAll(vector.tostring(ship.getColorTint()),{0,1,1})
        --local btint = {1.0,0.9,0.4}
        --printToAll(vector.tostring(btint),{0,1,1})
        --printToAll("compare "..ship.getColorTint()[1].." "..btint[1].." = "..tostring(math.approxeq(ship.getColorTint()[1],btint[1])),{0,1,1})
        --printToAll("compare "..ship.getColorTint()[2].." "..btint[2].." = "..tostring(math.approxeq(ship.getColorTint()[2],btint[2])),{0,1,1})
        --printToAll("compare "..ship.getColorTint()[3].." "..btint[3].." = "..tostring(math.approxeq(ship.getColorTint()[3],btint[3])),{0,1,1})
        if vector.eq(ship.getColorTint(),B_COLOR) then
            ship.setVar('state',"B")
        else
            ship.setVar('state',"A")
        end
        updateSquadButtons(ship)
        updateColor(ship)
    end
end
squad = {}
function squad.UpdateName(ship, new_health, new_maxhealth, new_speed)
    local health = squad.health(ship)
    local maxHealth = squad.maxhealth(ship)
    local speed = squad.speed(ship)
    local name = squad.name(ship)
    if new_health~=nil and health ~= new_health then
        printToAll("Changing health for '"..name.."' from "..health.." to "..new_health,{0,1,1})
        health = new_health
    end
    if new_maxhealth~=nil and maxHealth ~= new_maxhealth then
        printToAll("Changing maxhealth for '"..name.."' from "..maxHealth.." to "..new_maxhealth,{0,1,1})
        maxHealth = new_maxhealth
    end
    if new_speed~=nil and speed ~= new_speed then
        printToAll("Changing speed for '"..name.."' from "..speed.." to "..new_speed,{0,1,1})
        speed = new_speed
    end
    ship.setName("("..health.."/"..maxHealth..") ["..speed.."] "..name)
end
function Action_PlusHealth(ship)
    local health = squad.health(ship)
    local maxHealth = squad.maxhealth(ship)
    if health<maxHealth then
        squad.UpdateName(ship,health+1)
    end
    updateSquadButtons(ship)
end
function Action_MinusHealth(ship)
    local health = squad.health(ship)
    if health>0 then
        squad.UpdateName(ship,health-1)
    end
    updateSquadButtons(ship)
end
function squad.health(squad)
    local health = squad.getName():match "%((%d)/?%d?%)"
    if health == nil then return 5
    else return tonumber(health) end
end
function squad.maxhealth(squad)
    local health = squad.getName():match "%(%d/?(%d?)%)"
    if health == nil then return 5
    else return tonumber(health) end
end
function squad.speed(squad)
    local speed = squad.getName():match "%[(%d)%]"
    if speed == nil then return 5
    else return tonumber(speed) end
end
function squad.name(squad)
    local name = squad.getName():match "%(?%d?/?%d?%)?%s?%[?%d?%]?%s?(.*)$"
    return name
end
function CheckShip(ship)
    local savedSize = ship.getVar('size')
    local sizeFromName = getSize(ship)
    if savedSize~=sizeFromName then
        drawShipButtons(ship)
        ship.setVar('size',sizeFromName)
    end
end
--button_pos = {{0.85,0.5,-1.7},
--              {1.4,0.5,-2.5},
--              {1.8,0.5,-3.3},
--              {-0.85,0.5,1.7},
--              {-1.4,0.5,2.5},
--              {-1.8,0.5,3.3}}
function drawSummaButtons(ship)
    ship.setVar('size',1)
    ship.setTable('maneuver',{{"I"},{"I","-"}})
    local index = 1
    clearButtons(ship)
    local left_pos = vector.add(vector.scale(ship_size[index],vector.onedividedby(ship.getScale())),{-0.3,0.4,-0.3})
    local right_pos = vector.scale(left_pos, {-1,1,1})
    local back_left_pos = {left_pos[1],0.4,-left_pos[3]}
    -- local front_pos = vector.scale(left_pos, {0,1,1})
    local left_rev_pos = vector.add({0,0,-.4}, left_pos)
    local right_rev_pos = vector.add({0,0,-.4}, right_pos)
    ship.createButton(buildRelativeButton(ship, "M",{click_function="Action_ruler_left",position=left_pos,tooltip="Notch Maneuvering\nRuler on Left"},ship_button_def))
    ship.createButton(buildRelativeButton(ship, "M",{click_function="Action_ruler_right",position=right_pos,tooltip="Notch Maneuvering\nRuler on Right"},ship_button_def))
    -- ship.createButton(buildRelativeButton(ship, "V",{click_function="Action_summa_reverse",position=front_pos,tooltip="Flip Direction"},ship_button_def))
    ship.createButton(buildRelativeButton(ship, "W",{click_function="Action_ruler_left_rev",position=left_rev_pos,tooltip="Notch Maneuvering\nRuler on Left"},ship_button_def))
    ship.createButton(buildRelativeButton(ship, "W",{click_function="Action_ruler_right_rev",position=right_rev_pos,tooltip="Notch Maneuvering\nRuler on Right"},ship_button_def))
    ship.createButton(buildRelativeButton(ship, "R",{click_function="Action_toggle_summa_ruler",position=back_left_pos,tooltip="Toggle Range Ruler"},ship_button_def))
end
function Action_summa_reverse(ship)
    ship.setPosition(vector.add(vector.rotate({0,0,2.10},ship.getRotation()[2]),ship.getPosition()))
    local rot = ship.getRotation()
    ship.setRotation({rot[1],rot[2]+180,rot[3]})
end
function drawShipButtons(ship)
    --printToAll('drawShipButtons for '..ship.getName(),{0,1,1})
    local name = ship.getName()
    local index = ship.getVar('size') --getSize(ship)
--    local index
--    if name:match " S$" then index = 1 ship.setVar('size',1) end
--    if name:match " M$" then index = 2 ship.setVar('size',2) end
--    if name:match " L$" then index = 3 ship.setVar('size',3) end
--    if name:match " SR$" then index = 4 ship.setVar('size',4) end
--    if name:match " MR$" then index = 5 ship.setVar('size',5) end
--    if name:match " LR$" then index = 6 ship.setVar('size',6) end
    if index~=nil then
        clearButtons(ship)
        local left_pos = vector.add(vector.scale(ship_size[index],vector.onedividedby(ship.getScale())),{-0.3,0.6,-0.3})
        local right_pos = vector.scale(left_pos, {-1,1,1})
        local back_left_pos = {left_pos[1],0.6,-left_pos[3]}
        local back_right_pos = {-left_pos[1],0.6,-left_pos[3]}
        ship.createButton(buildRelativeButton(ship, "M",{click_function="Action_ruler_left",position=left_pos,tooltip="Notch Maneuvering\nRuler on Left"},ship_button_def))
        ship.createButton(buildRelativeButton(ship, "M",{click_function="Action_ruler_right",position=right_pos,tooltip="Notch Maneuvering\nRuler on Right"},ship_button_def))
        ship.createButton(buildRelativeButton(ship, "R",{click_function="Action_toggle_ruler",position=back_left_pos,tooltip="Cycle Measuring Rulers"},ship_button_def))
        -- ship.createButton(buildRelativeButton(ship, "r",{click_function="Action_15range_ruler",position=vector.add(back_left_pos,{0,0,0.4})},ship_button_def))
        ship.createButton(buildRelativeButton(ship, "C",{click_function="Action_cmds",position=back_right_pos,tooltip="Whisper Commands on\nShip or Command Base"},ship_button_def))
        if not ship.getVar('hasShields') then
            ship.createButton(buildRelativeButton(ship, "After Ship Setup:",{click_function="Action_shields",position={0,0.6,0.4},width=800, height=100, color={0,0,0,0.9}, font_size=80, font_color={135/256, 206/256, 235/256,1.11}},ship_button_def))
            ship.createButton(buildRelativeButton(ship, "Spawn\nShields",{click_function="Action_shields",position={0,0.6,-0.3},width=800, height=500, color={135/256, 206/256, 235/256,0.9}, font_color={1,1,1,1.11}, tooltip="After Setup, Spawn Shields and Lock Ship"},ship_button_def))
        end
    end
end
function Action_shields(ship)
    ship.clearButtons()
    ship.setDescription("shields")
    ship.setVar('hasShields',true)
    drawShipButtons(ship)
end
ATTACK_RULERS = {
    ASSETS_ROOT.."misc/rulers/ship/small/collider.obj",
    ASSETS_ROOT.."misc/rulers/ship/medium/collider.obj",
    ASSETS_ROOT.."misc/rulers/ship/large/collider.obj",
    ASSETS_ROOT.."misc/rulers/ship/huge/collider.obj",
    LEGACY_ASSETS.."dev/wave3/ships/subjugator/attack_collider.obj" --custom massive shortHuge
}
RANGE_RULER_MESH = {
    ASSETS_ROOT.."misc/rulers/ship/small/mesh.obj",
    ASSETS_ROOT.."misc/rulers/ship/medium/mesh.obj",
    ASSETS_ROOT.."misc/rulers/ship/large/mesh.obj",
    ASSETS_ROOT.."misc/rulers/ship/huge/mesh.obj",
    LEGACY_ASSETS.."dev/wave3/ships/subjugator/massive_range_ruler.obj" --custom massive shortHuge
}
function Action_cmds(ship)
    printCmds(ship)
end
function Action_toggle_summa_ruler(ship)
    local ruler = ship.getVar('ruler')
    if ruler == nil then
        --12 range ruler
        ship.lock()
        --local mesh = ship.getVar("rulerMesh")
        local obj_parameters = {}
        obj_parameters.type = 'Custom_Model'
        local rot = {0,ship.getRotation()[2],0}
        obj_parameters.position = ship.getPosition()
        obj_parameters.rotation = rot
        obj_parameters.scale = {1,0.5,1}
        local newruler = spawnObject(obj_parameters)
        local custom = {}
        custom.mesh = SUMMA_RULER
        custom.collider = ATTACK_RULERS[1]
        newruler.setCustomObject(custom)
        newruler.lock()
        Wait.time(|| newruler~=nil and newruler.setRotation(rot),1,0)
        ship.setVar('ruler',newruler)
    else
        ruler.destruct()
        ship.setVar('ruler',nil)
    end
end
function Action_toggle_ruler(ship)
    local ruler = ship.getVar('ruler')
    if ruler == nil then
        Action_attack_ruler(ship)
    else
        custom = ruler.getCustomObject()
        if table.contains(RANGE_RULER_MESH, custom.mesh) then
            ruler.destruct()
            ship.setVar('ruler',nil)
        else
            ruler.destruct()
            ship.setVar('ruler',nil)
            Action_15range_ruler(ship)
        end
    end
end
function Action_15range_ruler(ship)
    local ruler = ship.getVar('ruler')
    if ruler == nil then
        ship.lock()
        --local mesh = ship.getVar("rulerMesh")
        local obj_parameters = {}
        obj_parameters.type = 'Custom_Model'
        local rot = {0,ship.getRotation()[2],0}
        obj_parameters.position = ship.getPosition()
        obj_parameters.rotation = rot
        local newruler = spawnObject(obj_parameters)
        local custom = {}
        custom.mesh = RANGE_RULER_MESH[ship.getVar('size')]
        custom.collider = ATTACK_RULERS[ship.getVar('size')]
        newruler.setCustomObject(custom)
        newruler.lock()
        Wait.time(|| newruler~=nil and newruler.setRotation(rot),1,0)
        ship.setVar('ruler',newruler)
    else
        ruler.destruct()
        ship.setVar('ruler',nil)
    end
end
function Action_attack_ruler(ship)
    local ruler = ship.getVar('ruler')
    if ruler == nil then
        ship.lock()
        local mesh = ship.getVar("rulerMesh")
        local obj_parameters = {}
        obj_parameters.type = 'Custom_Model'
        local rot = {0,ship.getRotation()[2],0}
        obj_parameters.position = ship.getPosition()
        obj_parameters.rotation = ship.getRotation()
        local newruler = spawnObject(obj_parameters)
        local custom = {}
        custom.mesh = mesh
        custom.collider = ATTACK_RULERS[ship.getVar('size')]
        newruler.setCustomObject(custom)
        newruler.lock()
        Wait.time(|| newruler~=nil and newruler.setRotation(rot),1,0)
        ship.setVar('ruler',newruler)
    else
        ruler.destruct()
        ship.setVar('ruler',nil)
    end
end
function getSize(ship)
    local index
    local ship_collider = ship.getCustomObject().collider
    --printToAll("Ship Collider: '"..ship_collider.."'",{1,1,1})
    for i,collider_group in ipairs(SHIPS) do
        for j,collider in ipairs(collider_group) do
            --printToAll(tostring(i)..") '"..collider.."'",{1,1,1})
            if collider==ship_collider then
                return i
            end
        end
    end
    --ship.setVar('size',index)
    -- printToAll('size for '..ship.getName()..' is '..tostring(index),{0,1,1})
    return nil
--    local sizes = {S=1,M=2,L=3,SR=4,MR=5,LR=6 }
--    local sizeFromName = ship.getName():match "%s(%u%u?)$"
--    local size
--    if sizeFromName~=nil then
--        --printToAll("Found size "..sizeFromName,{0,1,1})
--        size = sizes[sizeFromName]
--    end
--    return size
end
function updateSquadButtons(ship)
    clearButtons(ship)
    local state = ship.getVar('state')
--    if state ~= "A" then
    local y = 0.3
    local r = 0.4*(1-squad.health(ship)/squad.maxhealth(ship))
    local g = 0.8*(squad.health(ship)/squad.maxhealth(ship))
    local s = 1/math.max(r,g)
    health_color = {r*s,g*s,0,100}
    health_color_bg = {r*s,g*s,0,0.1}

    ship.createButton(buildButton("-",{click_function="Action_MinusHealth",position = {-0.3,y,0},color=health_color_bg,font_color={1,1,1,10},height = 150,width = 150,font_size = 80,tooltip=ship.getName().."\nDamage"},squad_button_def))
    ship.createButton(buildButton(tostring(squad.health(ship)),{position = {0,y,0},color={1,1,1,0.01},font_color=health_color,height = 0,width = 0,font_size = 225,tooltip=ship.getName()},squad_button_def))
    ship.createButton(buildButton("+",{click_function="Action_PlusHealth",position = {0.3,y,0},color=health_color_bg,font_color={1,1,1,10},height = 150,width = 150,font_size = 80,tooltip=ship.getName().."\nHeal"},squad_button_def))
    ship.createButton(buildButton("Attack",{click_function="Action_Attack",position = {0,y,0.5}, width=350,height=200,font_size=100, color={0,0,0,0.8}, font_color={1,1,1,1.25},tooltip=ship.getName().."\nAttack"},squad_button_def))
    ship.createButton(buildButton("Move",{click_function="Action_Move",position = {0,y,-0.5}, width=350,height=200,font_size=100, color={0,0,0,0.8}, font_color={1,1,1,1.25},tooltip=ship.getName().."\nMove"},squad_button_def))
    ship.createButton(buildButton("Activate",{position = {0.6,0.15,0}, rotation = {0,90,0},width=250,font_size=70, color={0,0,0,0},tooltip=ship.getName().."\nActivate"},squad_button_def))
    ship.createButton(buildButton("Activate",{position = {-0.6,0.15,0}, rotation = {0,90,0}, width=250,font_size=70, color={0,0,0,0},tooltip=ship.getName().."\nActivate"},squad_button_def))

    -- context Menus are dumb, don't pass object
    -- ship.addContextMenuItem("Move", Action_Move)
    -- ship.addContextMenuItem("Attack", Action_Activate)
    -- ship.addContextMenuItem("Activate", Action_Attack)
    -- ship.addContextMenuItem("(+) Health)", Action_PlusHealth)
    -- ship.addContextMenuItem("(-) Health)", Action_MinusHealth)
--    elseif state ~= "B" then
--        squad.createButton(buildButton("B",{position = {1.5,0,0}},squad_button_def))
--    end
end
function updateColor(squad)
    local state = squad.getVar('state')
    local team = squad.getVar('team')
    if team == 2 then
        if state == "A" then squad.setColorTint(A_SECONDARY_COLOR) --({0.3,1.0,1.0}) -- {0.78,0.86,0.99} C9DCFD
        elseif state == "B" then squad.setColorTint(B_SECONDARY_COLOR) --({1.0,0.9,0.4})  -- {0.52,0.29,0.19} FD8A5B
        end
    else
        if state == "A" then squad.setColorTint(A_COLOR)
        elseif state == "B" then squad.setColorTint(B_COLOR)
        end
    end
end
function Action_Activate(squad)
    local state = squad.getVar('state')
    if state == "A" then squad.setVar('state',"B")
    else squad.setVar('state',"A") end --if state == "B" then
    updateSquadButtons(squad)
    updateColor(squad)
    squad.lock()
end
undos = {}
function Action_Move(squad)
    undos[squad.getGUID()] = squad.getPosition()
    spawnSquadRuler(squad,SQUAD_MOVE_RULER)
end
function Action_Undo(squad)
    local old_pos = undos[squad.getGUID()]
    if old_pos~=nil then
        squad.setPosition(old_pos)
        local squad_rot = squad.getRotation()
        squad.setRotation({0,squad_rot[2],0})
        squad.unlock()
    end
end
function Action_Attack(squad)
    spawnSquadRuler(squad,SQUAD_ATTACK_RULER)
end
function isShip(ship)
    for i,collider_group in ipairs(SHIPS) do
        if table.contains(collider_group,ship.getCustomObject().collider) then
            return true
        end
    end
    return false
--    local name = ship.getName()
--    return ship.tag == "Figurine" and (name:match " S$" or name:match " M$" or name:match " L$"
--        or name:match " SR$" or name:match " MR$" or name:match " LR$")
end
function isSumma(obj)
    if obj.getCustomObject().mesh==SUMMA_MESH then
      return true
    end
    return false
end
function isSquad(ship)
    return table.contains(SQUAD_COLLIDERS, ship.getCustomObject().collider) --SQUAD ==ship.getCustomObject().collider or SQUAD_HTTPS ==ship.getCustomObject().collider
--    local name = ship.getName()
--    return ship.tag == "Figurine" and name:match " Sq$"
end
squad_move_rulers = {}
function Action_ToggleFreeMove(squad, player)
    restrict_squadrons = not restrict_squadrons
    local ruler = squad.getVar('ruler')
    squad_move_rulers[squad.getGUID()]=nil
    ruler.destruct()
    spawnSquadRuler(squad,SQUAD_MOVE_RULER)
end
function Action_OverrideSpeed1(squad, player) OverrideSpeed(squad, 1) end
function Action_OverrideSpeed2(squad, player) OverrideSpeed(squad, 2) end
function Action_OverrideSpeed3(squad, player) OverrideSpeed(squad, 3) end
function Action_OverrideSpeed4(squad, player) OverrideSpeed(squad, 4) end
function Action_OverrideSpeed5(squad, player) OverrideSpeed(squad, 5) end
function OverrideSpeed(squad, speed)
    squad.setVar("speed_override",speed)
    local ruler = squad.getVar('ruler')
    squad_move_rulers[squad.getGUID()]=nil
    ruler.destruct()
    spawnSquadRuler(squad,SQUAD_MOVE_RULER)
end
function Action_ToggleRhymerAttack(squad, player)
    extended_attack = squad.getVar("extended_attack") or false
    squad.setVar("extended_attack",not extended_attack)
    local ruler = squad.getVar('ruler')
    squad_move_rulers[squad.getGUID()]=nil
    ruler.destruct()
    spawnSquadRuler(squad,SQUAD_ATTACK_RULER)
end
SQUADRON_STATIC_COLLIDER = ASSETS_ROOT..'misc/squad_static_collider.obj'
SQUADRON_MOVING_COLLIDER = ASSETS_ROOT..'misc/squad_moving_collider.obj'
function spawnSquadRuler(squadron,type)
    clearButtons(squadron)
    btn_y = 1.5
    if type==SQUAD_MOVE_RULER then
        --spawn follow along range ruler
        local attackruler = spawnObject({
            type = 'Custom_Model', position = squadron.getPosition(), rotation = { 0, 0, 0 }
        })
        attackruler.setColorTint({0.5,0,0})
        attackruler.setCustomObject({
            mesh = SQUAD_RULERS[SQUAD_ATTACK_RULER], collider = SQUADRON_MOVING_COLLIDER --'http://pastebin.com/raw/fnyPsyke'
        })
        squadron.addAttachment(attackruler)
        attackruler2 = spawnObject({
            type = 'Custom_Model', position = squadron.getPosition(), rotation = { 180, 0, 0 }
        })
        attackruler2.setColorTint({0.5,0,0})
        attackruler2.setCustomObject({
            mesh = SQUAD_RULERS[SQUAD_ATTACK_RULER], collider = SQUADRON_MOVING_COLLIDER --'http://pastebin.com/raw/fnyPsyke'
        })
        squadron.addAttachment(attackruler2)

        if squadron.getVar('extended_attack') then
            local attackruler = spawnObject({
                type = 'Custom_Model', position = squadron.getPosition(), rotation = { 0, 0, 0 }
            })
            attackruler.setColorTint({0.5,0,0.5})
            attackruler.setCustomObject({
                mesh = SQUAD_RULERS[SQUAD_ATTACK_CLOSE_RULER], collider = SQUADRON_MOVING_COLLIDER --'http://pastebin.com/raw/fnyPsyke'
            })
            squadron.addAttachment(attackruler)
            attackruler2 = spawnObject({
                type = 'Custom_Model', position = squadron.getPosition(), rotation = { 180, 0, 0 }
            })
            attackruler2.setColorTint({0.5,0,0.5})
            attackruler2.setCustomObject({
                mesh = SQUAD_RULERS[SQUAD_ATTACK_CLOSE_RULER], collider = SQUADRON_MOVING_COLLIDER  -- 'http://pastebin.com/raw/fnyPsyke'
            })
            squadron.addAttachment(attackruler2)
        end
        squadron.unlock()
        current_speed = squadron.getVar('speed_override') or squad.speed(squadron)
        squadron.createButton(buildButton("Undo",{position={0,0.3,0.4},width=400,font_size=100, color={1,0,0,0.3}, font_color={1,1,1,3.33}},squad_button_def))
        -- squadron.createButton(buildButton("Toggle Free Move",{click_function="Action_ToggleFreeMove", position={0,0.3,4},width=400,font_size=100, color={0,0,1,0.3}, font_color={1,1,1,3.33}},squad_button_def))
        font_color = {1,1,1,3.33}
        if squad.speed(squadron)==1 then font_color = {0,1,0,3.33} end
        color = {0,0,0,0.3}
        if current_speed==1 then color = {0,0,1,0.8} end
        squadron.createButton(buildButton("1",{click_function="Action_OverrideSpeed1", position={-0.8,btn_y,4},width=200,font_size=100, color=color, font_color=font_color},squad_button_def))
        font_color = {1,1,1,3.33}
        if squad.speed(squadron)==2 then font_color = {0,1,0,3.33} end
        color = {0,0,0,0.3}
        if current_speed==2 then color = {0,0,1,0.8} end
        squadron.createButton(buildButton("2",{click_function="Action_OverrideSpeed2", position={-0.4,btn_y,4},width=200,font_size=100, color=color, font_color=font_color},squad_button_def))
        font_color = {1,1,1,3.33}
        if squad.speed(squadron)==3 then font_color = {0,1,0,3.33} end
        color = {0,0,0,0.3}
        if current_speed==3 then color = {0,0,1,0.8} end
        squadron.createButton(buildButton("3",{click_function="Action_OverrideSpeed3", position={0,btn_y,4},width=200,font_size=100, color=color, font_color=font_color},squad_button_def))
        font_color = {1,1,1,3.33}
        if squad.speed(squadron)==4 then font_color = {0,1,0,3.33} end
        color = {0,0,0,0.3}
        if current_speed==4 then color = {0,0,1,0.8} end
        squadron.createButton(buildButton("4",{click_function="Action_OverrideSpeed4", position={0.4,btn_y,4},width=200,font_size=100, color=color, font_color=font_color},squad_button_def))
        font_color = {1,1,1,3.33}
        if squad.speed(squadron)==5 then font_color = {0,1,0,3.33} end
        color = {0,0,0,0.3}
        if current_speed==5 then color = {0,0,1,0.8} end
        squadron.createButton(buildButton("5",{click_function="Action_OverrideSpeed5", position={0.8,btn_y,4},width=200,font_size=100, color=color, font_color=font_color},squad_button_def))
    else
        squadron.createButton(buildButton("Toggle Rhymer/Snipe Attack",{click_function="Action_ToggleRhymerAttack", position={0,btn_y,4},width=2000,font_size=100, color={0,0,1,0.3}, font_color={1,1,1,3.33}},squad_button_def))

    end
    local world = squadron.getPosition()
    local scale = squadron.getScale()
    --local s = scale[2] --2.30362
    --scale = {scale[1]*s,scale[2]*s,scale[3]*s}
    local obj_parameters = {}
    obj_parameters.type = 'Custom_Model'
    obj_parameters.position = world
    if type==SQUAD_MOVE_RULER then
        obj_parameters.position = undos[squadron.getGUID()]
    end
    obj_parameters.rotation = { 0, 0, 0 }
    local newruler = spawnObject(obj_parameters)
    local custom = {}
    -- Attack mesh http://pastebin.com/raw/v9PG9iFC
    -- custom.mesh = 'http://pastebin.com/raw/QspzqNUx'
    custom.mesh = SQUAD_RULERS[type]
    free_move = squadron.getVar('free_move') or (not restrict_squadrons)
    if type == SQUAD_MOVE_RULER and not free_move then
        --printToAll("[:630] Normal Move using speed: "..tostring(squad.speed(squadron)),{1,1,1})
        --printToAll(SQUAD_SPEED_RULERS[squad.speed(squadron)],{1,1,1})
        custom.mesh = SQUAD_SPEED_RULERS[squadron.getVar('speed_override') or squad.speed(squadron)]
    end
    extended_attack = squadron.getVar('extended_attack')
    if extended_attack==nil then
        extended_attack = squadrons_extended_attack
    end
    if type == SQUAD_ATTACK_RULER and extended_attack then
        custom.mesh = SQUAD_RULERS[SQUAD_ATTACK_CLOSE_RULER]
    end
    custom.collider = SQUADRON_STATIC_COLLIDER --'http://pastebin.com/raw/fnyPsyke'
    newruler.setCustomObject(custom)
    newruler.lock()
    newruler.scale(scale)
    squadron.createButton(buildButton("Done",{position={0,0.3,-0.4},width=400,font_size=100, color={0,1,0,0.3}, font_color={1,1,1,3.33}},squad_button_def))
    squadron.setVar('ruler',newruler)
    newruler.setVar('parent',squadron)
    if type==SQUAD_MOVE_RULER then
        if restrict_squadrons then
            if squadron.getVar('speed_override')~=nil and squadron.getVar('speed_override')~= squad.speed(squadron) then
                newruler.setColorTint({1,0,1})
            else
                newruler.setColorTint({1,1,0})
            end
        end
    end
    if type==SQUAD_ATTACK_RULER then
        if extended_attack then
            newruler.setColorTint({1,0,1})
        else
            newruler.setColorTint({1,0,0})
        end
    end
    squad_move_rulers[squadron.getGUID()] = newruler
end
moving_with_ruler = nil
function onObjectPickedUp( player_color, picked_up_object )
    if isSquad(picked_up_object) and squad_move_rulers[picked_up_object.getGUID()]~=nil then
        --moving squad with ruler
        moving_with_ruler = picked_up_object
    end
end
function onObjectDropped( player_color, dropped_object )
    if dropped_object==moving_with_ruler then
        moving_with_ruler.lock()
        restrictMoveDistance(moving_with_ruler)
--        local newpos = moving_with_ruler.getPosition()
--        newpos[2] = 0.5
--        moving_with_ruler.setPosition(newpos)
        --TODO: implement unlock and drop
        --stop,drop,lock
        moving_with_ruler.setVar('stop',2)
        moving_with_ruler=nil
    end
    local droppos = dropped_object.getPosition()
    if dropped_object.tag == "Figurine" then
        dropped_object.setVar('owner',player_color)
        if isSquad(dropped_object) then
            local team = 1
            if table.contains({"Green", "Teal", "Brown","Blue","Purple"},player_color) then
                --Red, Purple, White, Blue, Yellow
                team = 2
            end
            if dropped_object.getVar('team')==nil then
                dropped_object.setVar('team',team)
                updateColor(dropped_object)
            end
        end
    end
    local custom = dropped_object.getCustomObject()
    local isDial = custom~=nil and table.contains(CMD_MESHES,custom.diffuse)
    -- local wasDropped = dropped_object.getVar('dropped')==true
    if isDial then -- and not wasDropped
        local ship = findShip(dropped_object.getPosition())
        local isCommandBase = false
        if ship==nil then
            ship = findCommandBase(dropped_object.getPosition())
            isCommandBase = true
        end
        if ship~=nil and (ship.getVar('owner')==player_color or ship.getVar('owner')==nil) then
            --lift existing tokens
            --increase others to 0.36
            for i,token in ipairs(getAllObjects()) do
                local other_custom = token.getCustomObject()
                local otherIsDial = other_custom~=nil and table.contains(CMD_MESHES,other_custom.diffuse)
                local offset = vector.rotate(vector.sub(token.getPosition(),ship.getPosition()),-ship.getRotation()[2])
                local size = nil
                if isCommandBase then
                    size = {1.5, 0, 1.5}
                else
                    size = ship_size[ship.getVar('size')]
                end
                local isOnBase = math.abs(offset[1])<math.abs(size[1]) and math.abs(offset[3])<math.abs(size[3])
                if otherIsDial and isOnBase and token~=dropped_object then
                    --printToAll("moving: "..token.getGUID(),{1,0,0})
                    local pos = token.getPosition()
                    token.setPositionSmooth({pos[1],(pos[2]-1)*2+3,pos[3]},false, true)
                end
            end
            --printToAll("DialDroppedNearOwnedShip",{0,1,0})

            --move to 1.76
            local shippos = ship.getPosition()
            local shippos = ship.getPosition()
            if isCommandBase then
                dropped_object.setPositionSmooth({shippos[1],3,shippos[3]}, false, true) --shippos[2]+0.807
                dropped_object.setRotationSmooth(vector.add(ship.getRotation(),{0,180,0}),false, true)
            else
                local offset = {0,0,-ship_size[ship.getVar('size')][3]+0.9 }
                local rotoff = vector.rotate(offset,ship.getRotation()[2])
                dropped_object.setPositionSmooth({shippos[1]+rotoff[1],3,shippos[3]+rotoff[3]},false, true) --shippos[2]+0.807
                dropped_object.setRotationSmooth({0,ship.getRotation()[2]+180,0},false, true)
            end
--            dropped_object.lock()
            -- dropped_object.setVar('dropped',true)
            local color = stringColorToRGB(player_color)
            if player_color=="White" then
                color.r = 0.4
                color.g = 0.4
                color.b = 0.4
            end
            dropped_object.setColorTint({1-(1-color.r)/2,1-(1-color.g)/2,1-(1-color.b)/2})
        end
    end

    -- local isChip = dropped_object.tag == "Chip"
    -- if isChip then
    --     local isRulerChip = table.contains(RULER_DESCRIPTIONS, dropped_object.getDescription())
    --     local isTargeting = custom~=nil and table.contains(TARGETING_MESHES,custom.diffuse)
    --     if isRulerChip then
    --         Draw_token_buttons(dropped_object)
    --     end
    -- end
    onObjectDropped_asteroid(dropped_object, player_color)
end
RULER_DESCRIPTIONS = {"R,C-L", "D,1", "D,3"} --, "R,C", "R,M", "R,L", "D,1-5",
token_button_def = {position = {0,0.3,0},rotation = {0,180,0},height = 150,width = 300,font_size = 100}
flipped_token_button_def = {position = {0,-0.3,0},rotation = {0,180,180},height = 150,width = 300,font_size = 100}
dark_token_button_def = {position = {0,0.3,0},rotation = {0,180,0},height = 150,width = 300,font_size = 100, color={0,0,0}, font_color={0.83,0.26,0.1}}
dark_flipped_token_button_def = {position = {0,-0.3,0},rotation = {0,180,180},height = 150,width = 300,font_size = 100, color={0,0,0}, font_color={0.56,0.74,0.87}}
function get_token_def(token, dark)
    rot = token.getRotation()
    if rot[3]>160 and rot[3]<200 then --FLIPPED
        if dark ~= nil then
            return dark_flipped_token_button_def
        else
            return flipped_token_button_def
        end
    else
        if dark ~= nil then
            return dark_token_button_def
        else
            return token_button_def
        end
    end
end
function Draw_token_buttons(token)
    token.clearButtons()
    local ruler = token.getVar('ruler')
    if not token.getLock() then
        token.createButton(buildRelativeButton(token, "Lock",{click_function="Action_lock_token",color={0,0.8,0},font_color={1,1,1}},get_token_def(token)))
    else
        tokendef = get_token_def(token,1)
        token.createButton(buildRelativeButton(token, "Ruler",{click_function="Action_ruler_token",position=vector.add(tokendef.position,{0,0,-1})},tokendef))
        if ruler~=nil then
            tokendef = get_token_def(token)
            token.createButton(buildRelativeButton(token, "Delete",{click_function="Action_delete_token", position=vector.add(tokendef.position,{0,0,1}), color={0.8,0,0}, font_color={1,1,1}}, tokendef))
        end
    end
end
function Action_lock_token(token)
    token.lock()
    Draw_token_buttons(token)
end
function Action_delete_token(token)
    local ruler = token.getVar('ruler')
    ruler.destruct()
    token.destruct()
end
function Action_ruler_token(token)
    local ruler = token.getVar('ruler')
    if ruler == nil then
        token.lock()
        --local mesh = ship.getVar("rulerMesh")
        local obj_parameters = {}
        obj_parameters.type = 'Custom_Model'
        obj_parameters.position = token.getPosition()
        -- obj_parameters.rotation = token.getRotation()
        local newruler = spawnObject(obj_parameters)
        local custom = {}
        if token.getDescription()=="R,C-L" then
            custom.mesh = ASSETS_ROOT..'misc/obstacles/tokens/close_med_long.obj' --'http://paste.ee/p/EyvUW'
        elseif token.getDescription()=="D,3" then
            custom.mesh = ASSETS_ROOT..'misc/obstacles/tokens/3.obj' --'http://paste.ee/p/LSrUO'
        elseif token.getDescription()=="D,1" then
            custom.mesh= ASSETS_ROOT..'misc/obstacles/tokens/1.obj' --'http://paste.ee/p/veBPe'
        end
        custom.collider = ASSETS_ROOT..'misc/obstacles/tokens/ruler_collider.obj' --'http://paste.ee/p/B97T2'
        custom.material = 3
        newruler.setCustomObject(custom)
        newruler.lock()
        newruler.setColorTint({0.45, 0.13, 0.13})
        token.setVar('ruler',newruler)
    else
        ruler.destruct()
        token.setVar('ruler',nil)
    end
    Draw_token_buttons(token)
end

function findShip(position)
    for i,ship in ipairs(getAllObjects()) do
        if ship.tag == "Figurine" then
            local offset = vector.rotate(vector.sub(position,ship.getPosition()),-ship.getRotation()[2])
            local size = ship_size[ship.getVar('size')]
            if size ~=nil then
                local isOnBase = math.abs(offset[1])<math.abs(size[1]) and math.abs(offset[3])<math.abs(size[3])
                if isOnBase then
                    return ship
                end
            end
        end
    end
    return nil
end
function findCommandBase(position)
    COMMAND_BASE_COLLIDER = ASSETS_ROOT.."misc/command_base_collider.obj"
    for i,base in ipairs(getAllObjects()) do
        if base.tag == "Figurine" then
            local offset = vector.sub(position,base.getPosition())
            local isOnBase = math.abs(offset[1])<1.5 and math.abs(offset[3])<1.5
            if isOnBase then
                return base
            end
        end
    end
end
function clearSquadRulers(squad)
    local ruler = squad.getVar('ruler')
    if ruler then
        squad_move_rulers[squad.getGUID()]=nil
        ruler.destruct()
        squad.setVar('ruler',nil)
        squad.destroyAttachments()
    end
    squad.lock()
end
function Action_Done(squad)
    clearSquadRulers(squad)
    updateSquadButtons(squad)
end
function Action_ruler_left(ship, player_clicker_color, alt_click)
    hovered_ships[player_clicker_color] = ship
    ship.highlightOn(player_clicker_color,0.2)

    moveRuler(ship, -1, player_clicker_color)
end
function Action_ruler_right(ship, player_clicker_color, alt_click)
    hovered_ships[player_clicker_color] = ship
    ship.highlightOn(player_clicker_color,0.2)

    moveRuler(ship, 1, player_clicker_color)
end
function Action_ruler_left_rev(ship, player_clicker_color, alt_click)
    moveRuler(ship, -1, player_clicker_color,true)
end
function Action_ruler_right_rev(ship, player_clicker_color, alt_click)
    moveRuler(ship, 1, player_clicker_color,true)
end
function moveRuler(ship, direction, player_clicker_color,reversed)
    ship.lock()
    local size = ship.getVar('size')
    if size==nil then
        printToAll("Error: Cannot find ship size for: "..ship.getName(),{1,0,0})
        printToAll("This should not happen, report to Valadian",{1,0,0})
        return
    end
    local b_pos = ship_size[size]
    local pos = vector.add({b_pos[1]*direction,0,b_pos[3]},{0.32*direction,0,-0.78})
    local rotation_offset = 0
    if reversed then
        rotation_offset = 180
        pos = vector.add(pos,{0,0,0.87})
    end
    local rot = ship.getRotation()[2]
    local rotated = vector.rotate(pos, rot)
    --if size>3 then rot=rot+180 end

    if rulers[player_clicker_color]==nil then
        rulers[player_clicker_color]=MAGIC_RULER.clone()
    end
    myruler = rulers[player_clicker_color]
    myruler.lock()
    myruler.setPositionSmooth(vector.add(ship.getPosition(),rotated),false,true)
    myruler.setRotationSmooth({0,rot + rotation_offset,0 },false,true)
    myruler.setVar('ship',ship)
    if ship.getTable('maneuver')==nil or #ship.getTable('maneuver')==0 then
        printToAll("Warning: Ship has no maneuver table: "..ship.getName(),{1,1,0})
        printToAll("This should not happen, report to Valadian",{1,1,0})
    end
    myruler.setTable('maneuver',ship.getTable('maneuver'))
end
ship_button_def = {position = {0,0.3,0},rotation = {0,180,0},height = 250,width = 250,font_size = 160, font_color={1,1,1,1.11}, color={0,0,0,0.90}}
squad_button_def = {position = {0,0.17,0},rotation = {0,0,0},height = 150,width = 125,font_size = 150, font_color={1,1,1,1.25}, color={0,0,0,0.80}}
function buildRelativeButton(object, label, def, defaults)
    local scale = object.getScale()[1]
    if def.position==nil then def.position = defaults.position end
    if def.rotation==nil then def.rotation = defaults.rotation end
    --if def.width==nil then def.width = 100 + string.len(label)*DEFAULT_WIDTH_PER_CHAR end
    if def.width==nil then def.width = defaults.width / scale end
    if def.height==nil then def.height = defaults.height / scale end
    if def.font_size==nil then def.font_size = defaults.font_size / scale end
    if def.click_function==nil then def.click_function = 'Action_'..label end
    if def.function_owner==nil then def.function_owner = self end
    if defaults.color==nil then defaults.color = {1,1,1} end
    if defaults.font_color==nil then defaults.font_color = {0,0,0} end
    if def.color==nil then def.color = defaults.color end
    if def.font_color==nil then def.font_color = defaults.font_color end
    if def.tooltip==nil then def.tooltip = defaults.tooltip end
    return {['click_function'] = def.click_function, ['function_owner'] = def.function_owner, ['label'] = label, ['position'] = def.position, ['rotation'] =  def.rotation, ['width'] = def.width, ['height'] = def.height, ['font_size'] = def.font_size, ['color'] = def.color, ['font_color'] = def.font_color, ['tooltip'] = def.tooltip}
end
function buildButton(label, def, defaults)
    if def.position==nil then def.position = defaults.position end
    if def.rotation==nil then def.rotation = defaults.rotation end
    --if def.width==nil then def.width = 100 + string.len(label)*DEFAULT_WIDTH_PER_CHAR end
    if def.width==nil then def.width = defaults.width end
    if def.height==nil then def.height = defaults.height end
    if def.font_size==nil then def.font_size = defaults.font_size end
    if def.click_function==nil then def.click_function = 'Action_'..label end
    if def.function_owner==nil then def.function_owner = self end
    if def.color==nil then def.color={1,1,1} end
    if def.font_color==nil then def.font_color={0,0,0} end
    if def.tooltip==nil then def.tooltip = defaults.tooltip end
    return {['click_function'] = def.click_function, ['function_owner'] = def.function_owner, ['label'] = label, ['position'] = def.position, ['rotation'] =  def.rotation, ['width'] = def.width, ['height'] = def.height, ['font_size'] = def.font_size, ['color'] = def.color, ['font_color']=def.font_color, ['tooltip'] = def.tooltip}
end
function clearButtons(object)
    --this is a workaround for obj.clearButtons() being broken as of v7.10
    if object.getButtons() ~= nil then
        for i=#object.getButtons()-1,0,-1 do
            object.removeButton(i)
        end
    end
end

hovered_ships = {}
ruler_index = {}
function onObjectHover_scripting_keys(hovered_object,player_color)
    -- Disable hover, causes confusing behaviors
    -- if isShip(hovered_object) and hovered_object.getVar('owner')==player_color then
    --     if hovered_ships[player_color]~=nil then
    --         hovered_ships[player_color].highlightOff()
    --     end
    --     hovered_ships[player_color] = hovered_object
    --     hovered_object.highlightOn(player_color,0.2)
    -- end
end
----#include rulerProxy
function onClick_ToggleRulerGUI(player, _, idValue)
    local active = UI.getAttribute("rulerProxyPopup_"..player.color,"active")
    if active==nil or active=="true" then
        UI.hide("rulerProxyPopup_"..player.color)
    else
        UI.show("rulerProxyPopup_"..player.color)
    end
end
function onClick_moveRulerLeft(player, _, idValue)
    if hovered_ships[player.color]==nil then
        print("Need to select ship first")
        return
    end
    moveRuler(hovered_ships[player.color],-1,player.color)
    Player[player.color].lookAt({
        position = hovered_ships[player.color].positionToWorld(Vector(-3,0,4)) ,
        pitch    = 45,
        yaw      = hovered_ships[player.color].getRotation()[2],
        distance = 8,
    })
    Wait.frames(|| updateRulerDisplay(player.color), 1)
end
function onClick_moveRulerRight(player, _, idValue)
    if hovered_ships[player.color]==nil then
        print("Need to select ship first")
        return
    end
    moveRuler(hovered_ships[player.color],1,player.color)
    Player[player.color].lookAt({
        position = hovered_ships[player.color].positionToWorld(Vector(3,0,4)) ,
        pitch    = 45,
        yaw      = hovered_ships[player.color].getRotation()[2],
        distance = 8,
    })
    Wait.frames(|| updateRulerDisplay(player.color), 1)
end
function yawToNumber(yaw)
    value = 0
    if yaw=="I" then value = 1 end
    if yaw=="II" then value = 2 end
    return value
end
function updateRulerDisplay(color)
    ship = hovered_ships[color]
    ruler = rulers[color]
    numcmds = 0
    cmds = {}
    if ruler~=nil then
        numcmds = ruler.call("API_GET_NUM_CMDS")
        for i=1,numcmds do
            table.insert(cmds,ruler.call("API_GET_CMD_AT",i))
        end
    end
    if ship~=nil then
        maneuver = ship.getTable('maneuver')
        -- print("maneuver~=nil: ",maneuver~=nil)
        -- print("#maneuver: ",#maneuver)
        -- print("#cmds: ",#cmds)
        -- print("maneuver~=nil: ",maneuver~=nil)
        for i=0,4 do
            if i==#cmds then
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "colors", "#A0A0A0|#A0A0A0|white|#A0A0A0")
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "color", "black")
                if i>#maneuver then
                    UI.setAttribute("ruler_"..color.."_"..tostring(i), "outline", "red")
                else
                    UI.setAttribute("ruler_"..color.."_"..tostring(i), "outline", "yellow")
                end
            else
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "colors", "transparent|#A0A0A0|white|transparent")
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "color", "#606060")
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "outline", "white")
            end
            for j=-2,2 do
                if cmds[i]~=nil and tonumber(cmds[i])==j then
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "colors", "white|#A0A0A0|white|white")

                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "color", "black")
                    if maneuver~=nil and #cmds<=#maneuver and math.abs(j)>yawToNumber(maneuver[#cmds][i]) then
                        UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "outline", "#FF0000")
                    else
                        UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "outline", "#00FF00")
                    end
                else
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "color", "#606060")
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "colors", "transparent|#A0A0A0|white|transparent")
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "outline", "white")
                end
            end
        end
        if maneuver~=nil and #cmds>0 and #cmds<=#maneuver then
            yaws = maneuver[numcmds]
            for i,yaw in ipairs(yaws) do
                for j=-2,2 do
                    if math.abs(j)>yawToNumber(yaw) then
                        UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "textColor", "#A00000")
                    else
                        UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "textColor", "#FFFFFF")
                    end
                end
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "textColor", "#FFFFFF")
            end
            for i=#yaws+1,#maneuver do
                for j=-2,2 do
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "textColor", "#606060")
                end
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "textColor", "#606060")
            end
            for i=#maneuver+1,4 do
                for j=-2,2 do
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "textColor", "#404040")
                end
                UI.setAttribute("ruler_"..color.."_"..tostring(i), "textColor", "#404040")
            end
            UI.setAttribute("ruler_"..color.."_0", "textColor", "#404040")
        else
            for i=1,4 do
                for j=-2,2 do
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "textColor", "#404040")
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "outline", "white")
                    if maneuver~=nil and i<=#cmds and j==cmds[i] then
                        UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "colors", "#404040|#A0A0A0|white|#404040")
                    else
                        UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "colors", "transparent|#A0A0A0|white|transparent")
                    end
                    UI.setAttribute("ruler_"..color.."_"..tostring(j).."_"..tostring(i), "textColor", "#404040")
                end
                if maneuver~=nil and i<=#maneuver then
                    UI.setAttribute("ruler_"..color.."_"..tostring(i), "textColor", "#606060")
                else
                    UI.setAttribute("ruler_"..color.."_"..tostring(i), "textColor", "#404040")
                end
            end
            UI.setAttribute("ruler_"..color.."_0", "textColor", "#404040")
        end
    end
    if ruler~=nil then
        -- cmd = ruler.getTable('cmd') --NO WORKY
        -- print('#cmd: ',#cmd)
    end
end
function onClick_prevShip(player, _, idValue)
    selectNextShip(player.color,1)
    if hovered_ships[player.color]==nil then
        print("No Ships found")
        return
    end
    UI.setValue("ruler_"..player.color.."_ShipName",hovered_ships[player.color].getName())
    -- print("ruler_"..color.."_ShipName")
    UI.setAttribute("ruler_"..player.color.."_ShipName","color","#"..hovered_ships[player.color].getColorTint():toHex())
    updateRulerDisplay(player.color)
end
function onClick_nextShip(player, _, idValue)
    selectNextShip(player.color,-1)
    if hovered_ships[player.color]==nil then
        print("No Ships found")
        return
    end
    UI.setValue("ruler_"..player.color.."_ShipName",hovered_ships[player.color].getName())
    -- print("ruler_"..color.."_ShipName")
    UI.setAttribute("ruler_"..player.color.."_ShipName","color","#"..hovered_ships[player.color].getColorTint():toHex())
    updateRulerDisplay(player.color)
end
function onClick_setSpeed(player, _, idValue)
    ruler = rulers[player.color]
    if ruler==nil then
        onClick_moveRulerLeft(player, _, idValue)
        ruler = rulers[player.color]
    end
    if ruler~=nil then
        color, speed = idValue:match("ruler_(%w+)_(%d)")
        -- speed = idValue:gsub("ruler_","")
        speed = tonumber(speed)
        params= {
            speed = speed
        }
        ruler.call("API_SetSpeed",params)
    else
        print("No Ruler found?")
    end
    Wait.frames(|| updateRulerDisplay(player.color), 1)
end
function onClick_setYaw(player, _, idValue)
    color, value, idx = idValue:match("ruler_(%w+)_(-?%d)_(%d)")
    ruler = rulers[player.color]
    if ruler==nil then
        if tonumber(value)<=0 then
            onClick_moveRulerLeft(player, _, idValue)
        else
            onClick_moveRulerRight(player, _, idValue)
        end
        ruler = rulers[player.color]
    end
    if ruler~=nil then
        params = {
            idx = tonumber(idx),
            value = tonumber(value)
        }
        ruler.call("API_SetYaw",params)
    end
    Wait.frames(|| updateRulerDisplay(player.color), 1)
end
function onClick_rotateRulerLeft(player, _, idValue)
    ruler = rulers[player.color]
    if ruler~=nil then
        ruler.call("Action_RulerLeft0")
    end
end
function onClick_rotateRulerRight(player, _, idValue)
    ruler = rulers[player.color]
    if ruler~=nil then
        ruler.call("Action_RulerRight0")
    end
end
function onClick_move(player, _, idValue)
    ruler = rulers[player.color]
    if ruler~=nil then
        ruler.call("API_move")
    end
end
function onClick_done(player, _, idValue)
    ruler = rulers[player.color]
    if ruler~=nil then
        ruler.call("API_done")
    end
end
function onClick_undo(player, _, idValue)
    ruler = rulers[player.color]
    if ruler~=nil then
        ruler.call("API_undo")
    end
end

----#include rulerProxy
function selectNextShip(color, dir)
    if hovered_ships[color]~=nil then
        hovered_ships[color].highlightOff()
    end
    curs_rot = 0
    if color~=nil then
        curs_rot = Player[color].getPointerRotation()
    end
    -- print(curs_rot)
    ships = T(getAllObjects())
        :Where(isShip)
        :Where(|s| s~=hovered_ships[color])
        :Where(|s| s.getVar('owner')==color)

    if #ships>1 then
        relative_pos = Vector(0,0,0)
        if hovered_ships[color]~=nil then
            relative_pos = hovered_ships[color].getPosition()
        end
        ships = ships:OrderBy(function(s)
            -- print(" = = = ",s.getName()," = = = ")
            offset = vector.sub(s.getPosition(),relative_pos)
            -- print("Global: ",vector.tostring(offset))
            relative_offset = vector.rotate(offset,180-curs_rot)
            -- print("Rot: ",curs_rot+180)
            -- print("Local: ",vector.tostring(relative_offset))
            x_delta = relative_offset[1]
            if x_delta<0 then
                x_delta = x_delta+200
            end
            -- print("x_delta: ",x_delta)
            return x_delta
        end )
    end
    if #ships>0 then
        if dir>0 then
            -- print("selecting: ",ships[1].getName())
            hovered_ships[color] = ships[#ships]
        else
            -- print("selecting: ",ships[#ships].getName())
            hovered_ships[color] = ships[1]
        end

        -- Player[color].lookAt({
        --     position = hovered_ships[color].getPosition() ,
        --     pitch    = 45,
        --     yaw      = hovered_ships[color].getRotation()[2],
        --     distance = 20,
        -- })
        hovered_ships[color].highlightOn(color,0.2)
    end
    if hovered_ships[color]~=nil then
        Player[color].lookAt({
            position = hovered_ships[color].positionToWorld(Vector(0,0,4)) ,
            pitch    = 45,
            yaw      = hovered_ships[color].getRotation()[2],
            distance = 8,
        })
    end
    return hovered_ships[color]
end
function onScriptingButtonDown(index, color)
    if ruler_index[color]==nil then
        ruler_index[color] = 0
    end

    PREV_SHIP_HOTKEY = 1
    NEXT_SHIP_HOTKEY = 3
    RULER_LEFT_HOTKEY = 4
    RULER_RIGHT_HOTKEY = 6
    YAW_LEFT_HOTKEY = 7
    YAW_RIGHT_HOTKEY = 9
    SHRINK_RULER_HOTKEY = 2
    PREV_RULER_HOTKEY = 5
    NEXT_RULER_HOTKEY = 8
    MOVE_UNDO_HOTKEY = 10




    if index==PREV_SHIP_HOTKEY or index==NEXT_SHIP_HOTKEY then --next/prev ship
        selectNextShip(color, index==PREV_SHIP_HOTKEY and 1 or 0)
        -- if hovered_ships[color]~=nil then
        --     hovered_ships[color].highlightOff()
        -- end
        -- curs_rot = 0
        -- if color~=nil then
        --     curs_rot = Player[color].getPointerRotation()
        -- end
        -- -- print(curs_rot)
        -- ships = T(getAllObjects())
        --     :Where(isShip)
        --     :Where(|s| s~=hovered_ships[color])
        --     :Where(|s| s.getVar('owner')==color)
        --
        -- if #ships>1 then
        --     relative_pos = Vector(0,0,0)
        --     if hovered_ships[color]~=nil then
        --         relative_pos = hovered_ships[color].getPosition()
        --     end
        --     ships = ships:OrderBy(function(s)
        --         -- print(" = = = ",s.getName()," = = = ")
        --         offset = vector.sub(s.getPosition(),relative_pos)
        --         -- print("Global: ",vector.tostring(offset))
        --         relative_offset = vector.rotate(offset,180-curs_rot)
        --         -- print("Rot: ",curs_rot+180)
        --         -- print("Local: ",vector.tostring(relative_offset))
        --         x_delta = relative_offset[1]
        --         if x_delta<0 then
        --             x_delta = x_delta+200
        --         end
        --         -- print("x_delta: ",x_delta)
        --         return x_delta
        --     end )
        -- end
        -- if #ships>0 then
        --     if index==PREV_SHIP_HOTKEY then
        --         -- print("selecting: ",ships[1].getName())
        --         hovered_ships[color] = ships[#ships]
        --     else
        --         -- print("selecting: ",ships[#ships].getName())
        --         hovered_ships[color] = ships[1]
        --     end
        --
        --     -- Player[color].lookAt({
        --     --     position = hovered_ships[color].getPosition() ,
        --     --     pitch    = 45,
        --     --     yaw      = hovered_ships[color].getRotation()[2],
        --     --     distance = 20,
        --     -- })
        --     hovered_ships[color].highlightOn(color,0.2)
        -- end
    end
    --index 1/3 change ships
    if hovered_ships[color]~=nil then
        if rulers[color]==nil then
            ruler_index[color] = 0
        end
        if index==RULER_LEFT_HOTKEY then
            moveRuler(hovered_ships[color],-1,color)
            Player[color].lookAt({
                position = hovered_ships[color].positionToWorld(Vector(-3,0,4)) ,
                pitch    = 45,
                yaw      = hovered_ships[color].getRotation()[2],
                distance = 8,
            })
        end
        if index==RULER_RIGHT_HOTKEY then
            moveRuler(hovered_ships[color],1,color)
            Player[color].lookAt({
                position = hovered_ships[color].positionToWorld(Vector(3,0,4)) ,
                pitch    = 45,
                yaw      = hovered_ships[color].getRotation()[2],
                distance = 8,
            })
        end
        -- MUST WAIT FOR RULER TO BE SPAWNED
        Wait.frames(function()
            if rulers[color]~=nil then
                if index==MOVE_UNDO_HOTKEY then
                    rulers[color].call('API_move')
                else
                    params = {index=ruler_index[color],color=color}
                    if index==YAW_LEFT_HOTKEY then
                        rulers[color].call('API_rulerLeft')
                    elseif index==YAW_RIGHT_HOTKEY then
                        rulers[color].call('API_rulerRight')
                    elseif index==NEXT_RULER_HOTKEY then
                        rulers[color].call('API_incrementIndex')
                    elseif index==PREV_RULER_HOTKEY then
                        rulers[color].call('API_decrementIndex')
                    elseif index==SHRINK_RULER_HOTKEY then
                        rulers[color].call('Action_RemoveRuler')
                    end
                    Wait.frames(|| rulers[color].call("API_highlightIndex",params), 1)
                end
            end
        end,1)

    end
    -- ruler = rulers[color]
    -- if ruler==nil or ruler.getVar('ship')==nil or ruler.getVar('ship')==
    -- print(index)
end
--includes util/math
----#include ../../util/vector
----#include math
function math.round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
function math.round(num, idp)
    if num == nil then return nil end
    local mult = 10^(idp or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end
function math.imod(i,mod)
    return i - math.floor((i-1)/mod)*mod --math.fmod(a,b)+1
end
function math.mod(a,b)
    return a - math.floor(a/b)*b
end
function math.approxeq(a, b)
    return math.abs(a-b)<0.01
end
function math.sign(x)
    if x<0 then return -1
    elseif x>0 then return 1
    else return 0 end
end
function math.clamp(val, lower, upper)
    assert(val and lower and upper, "sent nil value to clamp")
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

----#include math

vector = {}
function vector.length(v)
    return math.sqrt(v[1]*v[1]+v[2]*v[2]+v[3]*v[3])
end
function vector.add(pos, offset)
    return {pos[1] + offset[1],pos[2] + offset[2],pos[3] + offset[3]}
end
function vector.sub(pos, offset)
    return {pos[1] - offset[1],pos[2] - offset[2],pos[3] - offset[3]}
end
function vector.scale(v,s)
    if type(s)=="table" then
        return {v[1] * s[1],v[2] * s[2],v[3] * s[3]}
    elseif type(s)=="number" then
        return {v[1] * s,v[2] * s,v[3] * s}
    else
        printToAll("Error: Cannot scale vector by type: "..type(s))
        return nil
    end
end
function vector.prod(v,s)
    return {v[1] * s,v[2] * s,v[3] * s}
end
function vector.onedividedby(v)
    return {1/v[1],1/v[2] ,1/v[3]}
end
function vector.rotate(direction, yRotation)

    local rotval = math.round(yRotation)
    local radrotval = math.rad(rotval)
    local xDistance = math.cos(radrotval) * direction[1] + math.sin(radrotval) * direction[3]
    local zDistance = math.sin(radrotval) * direction[1] * -1 + math.cos(radrotval) * direction[3]
    return Vector(xDistance, direction[2], zDistance)
end
function vector.toangle(v)
    return math.atan2(-v[3],v[1])*180/math.pi - 90
end
function vector.angle2D(vec1, vec2)
    if vec2 == nil then
        vec2 = {1}
        for k = 2, #vec1, 1 do
            table.insert(vec2, 0)
        end
    end
    local angle = ( math.atan2(vec2[3], vec2[1]) - math.atan2(vec1[3], vec1[1]) )
    if angle>math.pi then
        angle = angle - math.pi*2
    end
    if angle<-math.pi then
        angle = angle + math.pi*2
    end
    return angle
end
function vector.eq(a,b)
    return math.approxeq(a[1],b[1]) and math.approxeq(a[2],b[2]) and math.approxeq(a[3],b[3])
end
function vector.tostring(v)
    return "{"..math.round(v[1],3)..","..math.round(v[2],3)..","..math.round(v[3],3).."}"
end
function vector.distance(v1,v2)
    x = (v1[1]-v2[1])*(v1[1]-v2[1])
    y = (v1[3]-v2[3])*(v1[3]-v2[3])
    return math.sqrt(math.abs((x+y)))
end
function vector.cross2D(u,v)
    return u[3]*v[1]-u[1]*v[3]
end
function vector.dot(a,b)
    return a[3]*b[3] + a[1]*b[1]
end
function vector.forward(obj)
    local direction = obj.getRotation()
    local rotval = math.round(direction[2])
    local radrotval = math.rad(rotval)
    local xForward = math.sin(radrotval) * -1
    local zForward = math.cos(radrotval) * -1
    -- log(guid .. " for x: "..round(xForward,2).." y: "..round(zForward,2))
    return {xForward, 0, zForward}
end
function vector.between(v,ll,ur)
    return ((v[1]>ll[1] and v[1]<ur[1]) or (v[1]<ll[1] and v[1]>ur[1])) and
           ((v[3]>ll[3] and v[3]<ur[3]) or (v[3]<ll[3] and v[3]>ur[3]))
end

----#include ../../util/vector
----#include ../../util/string
function string.starts(String,Start)
    if String==nil then
        return false
    end
    return string.sub(String,1,string.len(Start))==Start
end
function string:split(this,sSeparator, nMax, bRegexp)
    return string.split(this,sSeparator, nMax, bRegexp)
end
function string.split(str, sSeparator, nMax, bRegexp)
   assert(sSeparator ~= '')
   if type(nMax)=="string" then
       print("string.split('"..tostring(str).."','"..tostring(sSeparator).."',"..tostring(nMax)..","..tostring(bRegexp))
   end
   assert(nMax == nil or nMax >= 1)

   local aRecord = {}

   if str:len() > 0 then
      local bPlain = not bRegexp
      nMax = nMax or -1

      local nField, nStart = 1, 1
      local nFirst,nLast = str:find(sSeparator, nStart, bPlain)
      while nFirst and nMax ~= 0 do
         aRecord[nField] = str:sub(nStart, nFirst-1)
         nField = nField+1
         nStart = nLast+1
         nFirst,nLast = str:find(sSeparator, nStart, bPlain)
         nMax = nMax-1
      end
      aRecord[nField] = str:sub(nStart)
   end

   return aRecord
end
function string:strip(self)
    return string.strip(self)
end
function string.strip(str)
    str = string.gsub(str, '^%s*', '')
    str = string.gsub(str, '%s*$', '')
    return str
end

function string.hexToColor(stringColor)
    color_table = {tonumber("0x"..stringColor:sub(1,2),16)/255, tonumber("0x"..stringColor:sub(3,4),16)/255, tonumber("0x"..stringColor:sub(5,6),16)/255}
    return color_table
end

----#include ../../util/string
-- Importing table doesn't work?
----#include ../../util/table
table.Distinct = function(t)
    local distinct = T{}
    for k,v in pairs(t) do
        if not distinct:Contains(v) then
            table.insert(distinct,v)
        end
    end

    return distinct
end
table.Sum = function(t)
    local sum = 0
    for k,v in pairs(t) do
        sum = sum + v
    end

    return sum
end
table.FirstOrNil = function(t)
    if #t>0 then
        return t[1]
    else
        return nil
    end
end
table.removeByValue = function(table1, value)
    for k,v in pairs(table1) do
      if v == value then
          table.remove(table1, k)
          break
      end
    end
end
function table_to_csv(t)
    local csv = ""
    for i,val in ipairs(t) do
        csv = csv..tostring(val)
        if i!=#t then
            csv = csv..","
        end
    end
    return csv
end
-- table.OrderBy = function(t, selector)
--
-- end
table.OrderBy = function(t, selector)
    function compare(a,b)
        return selector(a)<selector(b)
    end
    table.sort(t, compare)
    return t
end
table.OrderByDesc = function(t, selector)
    function compare(a,b)
        return selector(a)>selector(b)
    end
    table.sort(t, compare)
    return t
end
table.Select = function(t, selector)
    local result = T{}
    for _,value in ipairs(t) do
        table.insert(result, selector(value))
    end
    return result
end

table.Where = function(t, predicate)
    local result = T{}
    for _,value in ipairs(t) do
        if predicate(value) then
            table.insert(result, value)
        end
    end
    return result
end

table.CountIf =function(t, predicate)
    local result = 0
    for _,value in ipairs(t) do
        if predicate(value) then
            result=result+1
        end
    end
    return result
end
function table.contains(self,val)
    for index, value in ipairs (self) do
        if value == val then
            return true
        end
    end

    return false
end
table.Contains = function(tab, el)
    for k,v in pairs(tab) do
        if v == el then
            return true
        end
    end
    return false
end
-- Shallow table copy
-- Does not include metatables
table.ShallowCopy = function(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else
        copy = orig
    end
    return copy
end
table.IndexOf = function(t,item)
    for i,v in ipairs(t) do
        if v==item then
            return i
        end
    end
    return -1
end
table.Any = function(t)
    return #t>0
end
table.Keys = function(tbl)
    local keyset={}
    local n=0

    for k,v in pairs(tbl) do
      n=n+1
      keyset[n]=k
    end
    return keyset
end
function T(t)
    local tmp = {}
    if t~=nil then
        local i = 1
        for _,val in pairs(t) do
            tmp[i]=val
            i=i+1
        end
    end
    return setmetatable(tmp, {__index = table})
end
function table.removeKey(t, k)
	local i = 0
	local keys, values = {},{}
	for k,v in pairs(t) do
		i = i + 1
		keys[i] = k
		values[i] = v
	end

	while i>0 do
		if keys[i] == k then
			table.remove(keys, i)
			table.remove(values, i)
			break
		end
		i = i - 1
	end

	local a = {}
	for i = 1,#keys do
		a[keys[i]] = values[i]
	end

	return a
end
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function table.merge(self, ...)
    if self == nil then
        copy = {}
    else
        copy = table.copy(self)
    end
    if ... ~= nil then
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                copy[k] = v
            end
        end
    end
    return copy
end

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

function table.contains(self, val)
    for index, value in ipairs (self) do
        if value == val then
            return true
        end
    end

    return false
end

----#include ../../util/table
-- function table.contains(self, val)
--     for index, value in ipairs (self) do
--         if value == val then
--             return true
--         end
--     end
--
--     return false
-- end
-- function table.copy(orig)
--     local orig_type = type(orig)
--     local copy
--     if orig_type == 'table' then
--         copy = {}
--         for orig_key, orig_value in pairs(orig) do
--             copy[orig_key] = orig_value
--         end
--     else -- number, string, boolean, etc
--     copy = orig
--     end
--     return copy
-- end
function findObjectByName(name)
    for i,obj in ipairs(getAllObjects()) do
        if obj.getName()==name then return obj end
    end
end

----#include TTS_armada/src/Global