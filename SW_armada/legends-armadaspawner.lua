-- Bundled by luabundle {"version":"1.6.0"}
local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function(superRequire)
	local loadingPlaceholder = {[{}] = true}

	local register
	local modules = {}

	local require
	local loaded = {}

	register = function(name, body)
		if not modules[name] then
			modules[name] = body
		end
	end

	require = function(name)
		local loadedModule = loaded[name]

		if loadedModule then
			if loadedModule == loadingPlaceholder then
				return nil
			end
		else
			if not modules[name] then
				if not superRequire then
					local identifier = type(name) == 'string' and '\"' .. name .. '\"' or tostring(name)
					error('Tried to require ' .. identifier .. ', but no such module has been registered')
				else
					return superRequire(name)
				end
			end

			loaded[name] = loadingPlaceholder
			loadedModule = modules[name](require, loaded, register, modules)
			loaded[name] = loadedModule
		end

		return loadedModule
	end

	return require, loaded, register, modules
end)(nil)
__bundle_register("__root", function(require, _LOADED, __bundle_register, __bundle_modules)
-- Bundled by luabundle {"version":"1.6.0"}
local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function(superRequire)
	local loadingPlaceholder = {[{}] = true}

	local register
	local modules = {}

	local require
	local loaded = {}

	register = function(name, body)
		if not modules[name] then
			modules[name] = body
		end
	end

	require = function(name)
		local loadedModule = loaded[name]

		if loadedModule then
			if loadedModule == loadingPlaceholder then
				return nil
			end
		else
			if not modules[name] then
				if not superRequire then
					local identifier = type(name) == 'string' and '\"' .. name .. '\"' or tostring(name)
					error('Tried to require ' .. identifier .. ', but no such module has been registered')
				else
					return superRequire(name)
				end
			end

			loaded[name] = loadingPlaceholder
			loadedModule = modules[name](require, loaded, register, modules)
			loaded[name] = loadedModule
		end

		return loadedModule
	end

	return require, loaded, register, modules
end)(nil)
__bundle_register("__root", function(require, _LOADED, __bundle_register, __bundle_modules)
----#include TTS_armada/src/Armada_Spawner
----#include ui/fleetSpawner
function onClick_ToggleUI(player, _, idValue)
    isMinimized = UI.getAttribute("armadaDisplay", "height")=="30"
    switchToCloud = UI.getValue("spawnerTitle")=="Armada Fleet Spawner" and idValue=="cloudBtn"
    switchToSpawn = UI.getValue("spawnerTitle")=="Armada Score Reporter" and idValue=="minimizeBtn"
    if isMinimized or switchToCloud or switchToSpawn then
        UI.show("spawnerTitle")
        UI.hide("shipSpawnerPanel")
        UI.hide("upgradeSpawnerPanel")
        UI.show("tabContainer")
        UI.setAttribute("armadaDisplay", "height", "800")
        UI.setAttribute("armadaDisplay", "width", "400")
        if idValue=="minimizeBtn" then
            UI.show("fleetSpawnerPanel")
            UI.hide("gameReporterPanel")
            UI.show("tabContainer")
            UI.setValue("spawnerTitle","Armada Fleet Spawner")
            UI.setAttribute("spawnerTitle","color","white")
            UI.setAttribute("minimizeBtn", "colors", "transparent|#803030|#800000|transparent")
            UI.setAttribute("minimizeBtn", "tooltip", "Minimize")
            UI.setAttribute("cloudBtn", "colors", "transparent|#308030|#308000|transparent")
            UI.setAttribute("cloudBtn", "tooltip", "Show ScoreReporting")
        elseif idValue=="cloudBtn" then
            UI.hide("fleetSpawnerPanel")
            UI.show("gameReporterPanel")
            UI.hide("tabContainer")
            UI.setValue("spawnerTitle","Armada Score Reporter")
            UI.setAttribute("spawnerTitle","color","#FFA040")
            UI.setAttribute("minimizeBtn", "colors", "transparent|#308030|#008000|transparent")
            UI.setAttribute("minimizeBtn", "tooltip", "Show Armada Fleet Spawner")
            UI.setAttribute("cloudBtn", "colors", "transparent|#803030|#800000|transparent")
            UI.setAttribute("cloudBtn", "tooltip", "Minimize")
        end
        UI.setAttribute("shortTitle","alignment","MiddleLeft")
        UI.show("shortTitle")
        -- UI.setAttribute("armadaDisplay","outlineSize","0 0")
        -- UI.setAttribute("armadaDisplay","outline","white")
    else
        UI.hide("spawnerTitle")
        UI.hide("fleetSpawnerPanel")
        UI.hide("shipSpawnerPanel")
        UI.hide("upgradeSpawnerPanel")
        UI.hide("gameReporterPanel")
        UI.hide("tabContainer")
        UI.setAttribute("armadaDisplay", "height", "30")
        UI.setAttribute("armadaDisplay", "width", "0")
        UI.setAttribute("minimizeBtn", "colors", "transparent|#308030|#008000|transparent")
        UI.setAttribute("minimizeBtn", "tooltip", "Show Armada Fleet Spawner")
        UI.setAttribute("cloudBtn", "colors", "transparent|#308030|#800000|transparent")
        UI.setAttribute("cloudBtn", "tooltip", "Show ScoreReporting")
        UI.setAttribute("shortTitle","alignment","MiddleCenter")
        UI.hide("shortTitle")
        -- UI.setAttribute("armadaDisplay","outlineSize","1 1")
        -- UI.setAttribute("armadaDisplay","outline","#303030")
    end
end
function onClick_selectArmadaTab(player, _, idValue)
    if UI.getAttribute("armadaDisplay", "height")=="30" then
        onClick_ToggleUI(player, _, idValue)
    end
    if idValue=="cloudBtn" then
        idValue="gameReporter"
    end
    if idValue=="minimizeBtn" then
        idValue="fleetSpawner"
    end
    local xml = UI.getXmlTable()
    for i=1,#xml do
        if(xml[i].attributes.id == "armadaDisplay") then
            local armadaPanel = xml[i]
            --xml[i].attributes.height = "70"
            --table.removeKey(xml[i].attributes, "offsetXY")
            for j=1,#(armadaPanel.children) do
                if(armadaPanel.children[j].attributes.class == "buttonPanel") then
                    UI.hide(armadaPanel.children[j].attributes.id)
                end
            end
        end
    end
    UI.show(idValue.."Panel")
    --UI.hide("ship7")
    -- updateStatusUI()
end
fleet_pastes = {}
function onEndEdit_updateList(player, value, id)
    fleet_pastes[player.color] = value
end
FLEETS = {}
ALL_TEAMS = "White|Brown|Red|Orange|Yellow|Green|Teal|Blue|Purple|Pink|Grey|Black"
-- function onClick_fleet_private(player, _, idValue)
--     local color = player.color
--     local currentPrivate = UI.getAttribute("Private", "color")
--     if currentPrivate == color then
--         UI.setAttribute("Private", "color","black")
--         UI.setAttribute("Private", "textColor","white")
--         UI.setAttribute("fleetListPaste", "visibility", "")
--         UI.setAttribute("fleetListPasteStandin", "visibility", "Noone")
--     else
--         other_colors = ALL_TEAMS:gsub(color,"")
--         other_colors = other_colors:gsub("||","|")
--         other_colors = other_colors:gsub("^|","")
--         other_colors = other_colors:gsub("|$","")
--         UI.setAttribute("Private", "color", color)
--         UI.setAttribute("fleetListPaste", "visibility", color)
--         UI.setAttribute("fleetListPasteStandin", "visibility", other_colors)
--     end
-- end
function linesToLineobjs(lines)
    -- first_line = true
    line_objs = {}
    for _,line in ipairs(lines) do
        line = string.gsub(line,"\r","")
        if not line:starts "=" then
            -- print("Parsing line: '"..line.."'")
            orig = line
            line = string.strip(line)
            count = string.match(line, "^[%s ]*[•%-·][%s ]+(%d+)%s+x%s+")
            if count==nil then
                count = string.match(line, "^(%d+)%s+")
            end
            -- if count~=nil then
            --     print("Found count: "..tostring(count))
            -- end
            line = replace(line, "^Author:.*","")
            line = replace(line, "^Faction:.*","")
            line = replace(line, "^Commander:.*","")
            line = replace(line, "^Points:.*","")
            line = replace(line, "^Squadrons:.*","")
            line = replace(line, " Objective:",":") -- Shorten "Assault Objective: " to "Assault:"
            line = replace(line, "Assault: ","") -- Remove objective types
            line = replace(line, "Defense: ","") -- Remove objective types
            line = replace(line, "Navigation: ","") -- Remove objective types
            line = replace(line, "%s%+%s%d+%:%s%d+","") -- handle Starhawk-class Mk.II (150 + 84: 234)
            line = replace(line, "[%s ]+%(com%)","") -- remove " (com)" indicator
            line = replace(line, "[%s ]+%(off%)","") -- remove " (off)" indicator
            line = replace(line, "[%s ]+%(wpn%)","") -- remove " (wpn)" indicator
            line = replace(line, "[%s ]+%(rep off%)","") -- remove " (rep off)" indicator
            line = replace(line, "^[%s ]*[•%-·][%s ]+","") -- remove all bullets NOTE: THAT IS NOT A NORMAL SPACE!
            line = replace(line, "%d+%s+x%s+","") -- remove "• 2 x " for squadrons
            line = replace(line,"^%d+[%s ]+","") -- remove "2 " for squadrons
            -- line = replace(line,"^%-%s+","") -- replace by above
            line = replace(line,"[%s ]+%([%s ]*(%d+)[%s ]+points%)$"," (%1)") -- Shorten " ( 5 points)" -> " (5)"
            line = replace(line,"%[[%s ]+flagship[%s ]+%][%s ]+","") -- remove "[ flagship ]" indicato"
            line = replace(line,"%([%s ]*(%d+)[%s ]*%)$","(%1)") -- shorten "( 5 )" to "(5)"
            line = string.strip(line) -- remove leading/training spaces
            line = replace(line," +"," ") -- remove all multiple spaces
            line_nocost = string.gsub(line,"[%s ]+%([%s ]*%d+[%s ]*%)$","") -- create version without trailing cost" (5)"
            cost = string.match(line,"%((%d+)%)$")
            def = nil
            -- print(line)
            -- print(line_nocost)
            if line~=nil then
                def = CARDS[string.lower(line)] or SHIPS[string.lower(line)] or CARDS[string.lower(line_nocost)] or SHIPS[string.lower(line_nocost)]
            end
            if def~=nil then
                cost = def.cost
                parsed = def.name
            end
            table.insert(line_objs, {
                original = orig,
                parsed = line_nocost,
                cost = cost,
                count = count,
                def = def
            })
        end
    end
    return line_objs
end
lastParsed_lineObjs = nil
fleetOffset = 0
owning_color = nil
function onClick_fleet_parseFleet(player, _, idValue)
    fleetOffsets[player.color]=0
    UI.hide("fleetSpawnerInputLayout")
    UI.show("fleetSpawnerInputParsed")
    -- UI.show("fleetSpawnerHelpInner")
    list = fleet_pastes[player.color]
    -- clearSpawnArea(listSpawner)
    if list==nil or #list==0 then
        printToAll("Paste in fleet to spawn",{1,1,0})
        UI.show("fleetSpawnerInputLayout")
        UI.hide("fleetSpawnerInputParsed")
        -- UI.hide("fleetSpawnerHelpInner")
        return
    end
    lines = list:split("\n")
    lineobjs = linesToLineobjs(lines)
    FLEETS[player.color]=line_objs
    lastParsed_lineObjs = line_objs
    owning_color = player.color
    UI.setAttribute("spacingButton","outlineSize","1 1")
    UI.setAttribute("spacingButton","outline",owning_color) --"#"..Color.fromString(color):toHex(false))
    UI.setAttribute("spacingButton","textColor","white")
    updateParsed(player)
    -- layout(fleet, listSpawner.getPosition(), listSpawner.getRotation())
end
function updateParsed(player)
    -- line_objs = FLEETS[player.color]
    line_objs = lastParsed_lineObjs
    offset = fleetOffset--fleetOffsets[player.color] or 0
    -- UI.setAttribute("fleetMasterLayout", "minHeight", (#line_objs)*30)
    -- for i,obj in ipairs(line_objs) do
    -- print(offset)
    for idx=1+offset,36+offset do
        i = idx-offset
        -- print(i)
        obj  = line_objs[idx]
        if obj~=nil then
            -- print("Setting: 'line"..i.."count' to: '"..tostring(obj.count).."'")
            -- print(obj.original.." Cost: "..tostring(obj.cost))
            UI.setAttribute("line"..i.."Name","visibility","")
            UI.hide("line"..i.."icon")
            if obj.def==nil then
                UI.hide("line"..i.."count")
                UI.hide("line"..i.."_indicator")
                UI.setValue("line"..i.."Name", obj.original)
                UI.setAttribute("line"..i.."Name", "color", "red")
                UI.hide("line"..i.."CostOpen")
                UI.hide("line"..i.."Cost")
                UI.hide("line"..i.."CostClose")
                UI.hide("btn_line"..i.."omit")
                if #obj.original>0 then
                    if obj.origdef~=nil then
                        UI.show("btn_line"..i.."add")
                    end
                    UI.show("btn_line"..i.."search")
                else
                    UI.hide("btn_line"..i.."add")
                    UI.hide("btn_line"..i.."search")
                end
            else
                -- print(obj.parsed)
                -- print(tostring(obj.def.type=="Objective").." "..tostring(obj.def.move~=nil).." "..tostring( obj.def.maneuver~=nil))
                if obj.def.type=="Objective" then
                    UI.show("line"..i.."count")
                    UI.setValue("line"..i.."count","O:")
                    UI.hide("line"..i.."_indicator")
                    UI.setAttribute("line"..i.."Name","visibility",owning_color)
                elseif obj.def.move~=nil then
                    UI.show("line"..i.."_indicator")
                    UI.setValue("line"..i.."_indicator","x")
                    UI.show("line"..i.."count")
                    UI.setValue("line"..i.."count", obj.count or 1)
                elseif obj.def.maneuver~=nil then
                    UI.hide("line"..i.."count")
                    UI.hide("line"..i.."_indicator")
                else --must be a card
                    UI.show("line"..i.."icon")
                    UI.setAttribute("line"..i.."icon","image",obj.def.type)
                    UI.hide("line"..i.."count")
                    UI.show("line"..i.."_indicator")
                    UI.setValue("line"..i.."_indicator"," ")
                end
                UI.setValue("line"..i.."Name", obj.parsed)
                UI.setAttribute("line"..i.."Name", "color", "white")
                if obj.cost==nil then
                    UI.hide("line"..i.."CostOpen")
                    UI.hide("line"..i.."Cost")
                    UI.hide("line"..i.."CostClose")
                else
                    UI.show("line"..i.."CostOpen")
                    UI.show("line"..i.."Cost")
                    UI.setValue("line"..i.."Cost", obj.cost)
                    UI.show("line"..i.."CostClose")
                end
                UI.show("btn_line"..i.."omit")
                UI.hide("btn_line"..i.."add")
                UI.hide("btn_line"..i.."search")
            end
        else

            UI.hide("line"..i.."icon")
            UI.hide("btn_line"..i.."search")
            UI.hide("line"..i.."count")
            UI.hide("line"..i.."_indicator")
            UI.setValue("line"..i.."Name", " ")
            UI.hide("line"..i.."CostOpen")
            UI.hide("line"..i.."Cost")
            UI.hide("line"..i.."CostClose")
            UI.hide("btn_line"..i.."omit")
            UI.hide("btn_line"..i.."add")
        end
    end
    updateScrollButtons(player)
end
function onClick_fleet_backToInput(player, _, idValue)

    UI.show("fleetSpawnerInputLayout")
    UI.hide("fleetSpawnerInputParsed")
    -- UI.hide("fleetSpawnerHelpInner")
end
function onClick_fleet_clear(player, _, idValue)
    listSpawner = findObjectByName("List Spawner ("..player.color..")")
    if listSpawner~=nil then
        clearSpawnArea(listSpawner)
    else
        printToColor("Player Color is invalid: "..player.color, player.color, "Red")
    end
end
function onClick_fleet_spawn(player, _, idValue)

    -- fleet = createSpawningStructure(FLEETS[player.color])
    FLEETS[player.color] = lastParsed_lineObjs
    fleet = createSpawningStructure(lastParsed_lineObjs) --Use visible, NOT last parsed for player
    listSpawner = findObjectByName("List Spawner ("..player.color..")")

    width = layout(player, fleet, listSpawner.getPosition(), listSpawner.getRotation(),0,false) --testrun
    -- print(width)
    base_x = 55-width/2
    spawnDataCard(fleet, vector.add(listSpawner.getPosition(),vector.rotate({base_x-3,0,0.7}, listSpawner.getRotation()[2])), listSpawner.getRotation(),FLEETS[player.color][1].original)
    -- print(base_x)
    layout(player, fleet, listSpawner.getPosition(), listSpawner.getRotation(),base_x,true)
    -- updateFleetCostDisplay(player.color)
    -- Wait.time(|| updateAllScores(),2,0)
end
function Action_fleet_spawn(datacard, color, alt_click)
    if alt_click then
        return
    end
    onClick_fleet_clear({color=color}, _, nil)
    list = datacard.getDescription()
    lines = list:split("\n")
    lineobjs = linesToLineobjs(lines)
    FLEETS[color] = lineobjs
    fleet = createSpawningStructure(lineobjs)
    listSpawner = findObjectByName("List Spawner ("..color..")")
    width = layout(player, fleet, listSpawner.getPosition(), listSpawner.getRotation(),0,false) --testrun
    base_x = 55-width/2
    layout(player, fleet, listSpawner.getPosition(), listSpawner.getRotation(),base_x,true)
    clonedatacard = datacard
    if datacard.getLock() then
        clonedatacard = datacard.clone({
            position = datacard.getPosition()
        })
    end
    clonedatacard.setPositionSmooth(vector.add(listSpawner.getPosition(),vector.rotate({base_x-3,0,0.7}, listSpawner.getRotation()[2])), false, false)
    clonedatacard.setRotationSmooth(listSpawner.getRotation() + Vector(0,180,0), false, false)
    clonedatacard.setLock(false)
    -- Wait.time(|| updateAllScores(),2,0)
    -- Wait.frames(|| updateFleetCostDisplay(color), 10)
end
function GetShipSquadronCardsForColor(color)
    listSpawner = findObjectByName("List Spawner ("..color..")")
    cards = T(getAllObjects()):Where(|o| o.tag=="Card"):Where(|c| inFleetSpawnArea(listSpawner, c)):OrderBy(|c| listSpawner.positionToLocal(c.getPosition())[1] - listSpawner.positionToLocal(c.getPosition())[3]/100)
        :Where(|c| c.getName())
    return cards
end
function GetFleetForColor(color)
    listSpawner = findObjectByName("List Spawner ("..color..")")
    list = T(getAllObjects()):Where(|o| o.tag=="Card" and inFleetSpawnArea(listSpawner, o)):OrderBy(|c| listSpawner.positionToLocal(c.getPosition())[1] - listSpawner.positionToLocal(c.getPosition())[3]/100):Select(|c| c.getName())
    lineobjs = linesToLineobjs(list)
    return createSpawningStructure(lineobjs)
end
function Action_store_fleet(obj, color, alt_click)
    if alt_click then
        return
    end
    listSpawner = findObjectByName("List Spawner ("..color..")")
    list = T(getAllObjects()):Where(|o| o.tag=="Card"):Where(|c| inFleetSpawnArea(listSpawner, c)):OrderBy(|c| listSpawner.positionToLocal(c.getPosition())[1] - listSpawner.positionToLocal(c.getPosition())[3]/100):Select(|c| c.getName())
    lineobjs = linesToLineobjs(list)
    fleet = createSpawningStructure(lineobjs)
    datacardNames = T(getAllObjects()):Where(|c| isDatacard(c) and inFleetSpawnArea(listSpawner, c)):Select(|d| d.getName())

    if #datacardNames>0 then
        obj.setName(datacardNames[1])
        broadcastToColor("Inherited Fleet name from existing datacard...\n"..datacardNames[1],color,{0,1,1})
    else
        obj.setName("Right Click and change Name in Name Field")
    end
    obj.setDescription(fleetToString(fleet))
    broadcastToColor("Stored Fleet to Datacard!", color, {0,1,0})
    -- for _,card in ipairs(list) do
    --     print (card.getName())
    -- end
    faction = nil
    if #fleet.ships > 0 then
        faction = fleet.ships[1].def.faction
    end

    if faction=="Empire" then
        obj.setColorTint({52/255,52/255,52/255})
    elseif faction=="Republic" then
        obj.setColorTint({78/255,0,0})
    elseif faction=="Separatist" then
        obj.setColorTint({23/255,51/255,142/255})
    end

    Global.call('drawDatacardButtons',obj)
end
function fleetToString(fleet)
    if fleet==nil then return "" end
    faction = nil
    commander = nil
    totalPoints = 0
    local str = "\n"
    for _,obj in ipairs(fleet.objectives) do
        str = str..obj.def.category..": "..obj.def.name.."\n"
    end
    str = str.."\n"
    for _,ship in ipairs(fleet.ships) do
        str = str..ship.def.name.." ("..ship.def.cost
        -- if ship.upgradeCost>0 then
        --     str = str.." + "..ship.upgradeCost..": "..(ship.def.cost+ship.upgradeCost)
        -- end
        str = str..")\n"
        for _,def in ipairs(ship.upgrades) do
            str = str.." - "..def.name.." ("..def.cost..")\n"
            if def.type=="Commander" then
                commander = def.name
            end
        end
        str = str.."= "..(ship.def.cost+ship.upgradeCost).." Points\n"
        str = str.."\n"
        faction = ship.def.faction
        totalPoints = totalPoints+ship.def.cost+ship.upgradeCost
    end
    if commander~=nil then
        str = "Commander: "..commander.."\n"..str
    end
    if faction~=nil then
        str = "Faction: "..faction.."\n"..str
    end
    if #fleet.squads>0 then
        squadronCost = 0
        squadronStr = ""
        for _,squad in ipairs(fleet.squads) do
            if squad.count~=nil and squad.count>1 then
                squadronStr = squadronStr.." - "..squad.count.." x "..squad.def.name.." ("..(squad.def.cost*squad.count)..")\n"
            else
                squadronStr = squadronStr.." - "..squad.def.name.." ("..squad.def.cost..")\n"
            end
            squadronCost = squadronCost+squad.def.cost*(squad.count or 1)
        end
        -- str = str.."Squadrons ("..squadronCost.."): \n"
        str = str.."Squadrons: \n"
        str = str..squadronStr
        str = str.."= "..squadronCost.." Points\n"
        totalPoints = totalPoints+squadronCost
    end
    str = str.."\nTotal Points: "..totalPoints
    return str
end
function spawnDataCard(fleet, pos, rot, name)
    faction = nil
    if #fleet.ships > 0 then
        faction = fleet.ships[1].def.faction
    end
    local obj_parameters = {}
    obj_parameters.type = 'Custom_Model'
    obj_parameters.position = pos
    obj_parameters.rotation = vector.add(rot,{0,180,0})
    obj_parameters.scale = {1, 1, 1}


    local datacard = spawnObject(obj_parameters)
    local custom = {}
    -- custom.image = "http://i.imgur.com/EUi3Wog.png"
    -- custom.stackable = true
    custom.mesh = ASSETS_ROOT.."misc/datacard.obj"
    custom.diffuse = ASSETS_ROOT.."misc/datacard_diffuse.png"
    custom.type = 0 --generic
    custom.material = 3 --cardboard
    datacard.setCustomObject(custom)

    if faction=="Empire" then
        datacard.setColorTint({52/255,52/255,52/255})
    elseif faction=="Republic" then
        datacard.setColorTint({78/255,0,0})
    elseif faction=="Separatist" then
        datacard.setColorTint({23/255,51/255,142/255})
    end
    datacard.setName(name)
    datacard.setDescription(fleetToString(fleet))
end
function findObjectByName(name)
    for i,obj in ipairs(getAllObjects()) do
        if obj.getName()==name then return obj end
    end
end
function onClick_fleet_OmitLine(player, _, idValue)
    i = tonumber(idValue:match("line(%d+)omit"))
    idx = i +  fleetOffset -- fleetOffsets[player.color] or 0
    line_objs = lastParsed_lineObjs --FLEETS[player.color]
    if line_objs[idx].origdef == nil then
        line_objs[idx].origdef = line_objs[idx].def
    end
    line_objs[idx].def = nil
    updateParsed(player)
end
function onClick_fleet_AddLine(player, _, idValue)
    i = tonumber(idValue:match("line(%d+)add"))
    line_objs = lastParsed_lineObjs
    -- idx = i + fleetOffsets[player.color] or 0
    idx = i + fleetOffset
    line_objs[idx].def = line_objs[idx].origdef
    updateParsed(player)
end
function onClick_fleet_SearchLine(player, _, idValue)
    line_objs = lastParsed_lineObjs
    i = tonumber(idValue:match("line(%d+)search"))
    -- idx = i + fleetOffsets[player.color] or 0
    idx = i + fleetOffset
    if line_objs[idx].origdef == nil then
        line_objs[idx].origdef = line_objs[idx].def
    end

    bestKey = fuzzyStringSearch(line_objs[idx].original)
    printToColor("The best I can find is: '"..tostring(bestKey).."'",player.color,"Teal")
    def = SHIPS[bestKey]
    if def == nil then
        def = CARDS[bestKey]
    end
    line_objs[idx].def = def
    line_objs[idx].parsed = def.name
    line_objs[idx].cost = def.cost
    updateParsed(player)
end
fleetOffsets = {}
function onClick_fleet_scrollDown(player, _, idValue)
    -- fleetOffsets[player.color] = math.min(34,(fleetOffsets[player.color] or 0)+5)
    -- maxOffset = math.max(#FLEETS[player.color]-36,0)
    -- fleetOffsets[player.color] = math.min(maxOffset, fleetOffsets[player.color])

    fleetOffset = math.min(34,(fleetOffset)+5)
    maxOffset = math.max(#lastParsed_lineObjs-36,0)
    fleetOffset = math.min(maxOffset, fleetOffset)
    updateParsed(player)
    updateScrollButtons(player)
end
function onClick_fleet_scrollUp(player, _, idValue)
    -- fleetOffsets[player.color] = math.max(0,(fleetOffsets[player.color] or 0)-5)
    fleetOffset = math.max(0,fleetOffset-5)
    updateParsed(player)
    updateScrollButtons(player)
end
function updateScrollButtons(player)
    -- if fleetOffsets[player.color]==nil or fleetOffsets[player.color]==0 then
    if fleetOffset==0 then
        UI.setAttribute("parseScrollUp", "iconColor", "#404040")
        -- UI.setAttribute("parseScrollDown", "colors", "transparent|transparent|transparents|transparent")
        -- UI.setAttribute("parseScrollUp", "interactable", "false")
    else
        UI.setAttribute("parseScrollUp", "iconColor", "#FFFFFF")
        -- UI.setAttribute("parseScrollDown", "colors", "transparent|#808080|#404040|transparent")
        -- UI.setAttribute("parseScrollUp", "interactable", "true")
    end

    -- maxOffset = math.max(#FLEETS[player.color]-36,0)
    -- if fleetOffsets[player.color]==maxOffset then
    maxOffset = math.max(#lastParsed_lineObjs-36,0)
    if fleetOffset==maxOffset then
        UI.setAttribute("parseScrollDown", "iconColor", "#404040")
    else
        UI.setAttribute("parseScrollDown", "iconColor", "#FFFFFF")
    end
end
function onClick_toggle_commandPopup(player, _, idValue)
    local active = UI.getAttribute("commandPopup","active")
    if active==nil or active=="true" then
        UI.hide("commandPopup")
    else
        UI.show("commandPopup")
    end
end
VICTORY_TOKEN_VALUE = 0
DOUBLE_OBJECTIVE_SHIP = false
HALF_SCORE_DAMAGED_SHIP = false
MOST_VICTORY_75 = false
function onClick_toggle_victoryToken(player, _, idValue)
    local active = UI.getAttribute("victoryTokenPopup","active")
    if active==nil or active=="true" then
        UI.hide("victoryTokenPopup")
    else
        UI.show("victoryTokenPopup")
    end
end
VICTORY_BUTTONS = {
    "Victory_10","Victory_15","Victory_20","Victory_25","Victory_30","Victory_40","Victory_50","Victory_IntelSweep","Victory_MostWanted","Victory_OpeningSalvo"
}
function onClick_select_victoryToken(player, _, idValue)
    for _,id in ipairs(VICTORY_BUTTONS) do
        UI.setAttribute(id,"color", "black")
        UI.setAttribute(id,"textColor", "white")
        UI.setAttribute(idValue,"fontStyle", "Normal")
    end
    UI.setAttribute(idValue,"color", "#FFFF80")
    UI.setAttribute(idValue,"textColor", "black")
    UI.setAttribute(idValue,"fontStyle", "Bold")
    idValue = idValue:gsub("Victory_","")
    points = tonumber(idValue)
    if points~=nil then
        VICTORY_TOKEN_VALUE = points
    else
        VICTORY_TOKEN_VALUE = 0
    end
    DOUBLE_OBJECTIVE_SHIP = idValue=="MostWanted"
    HALF_SCORE_DAMAGED_SHIP = idValue=="OpeningSalvo"
    MOST_VICTORY_75 = idValue=="IntelSweep"
end
function onClick_show_helpPage(player, _, idValue)
    for i=0,10 do
        UI.hide("helpPage"..i)
        UI.setAttribute("helpPage"..i.."btn","class","pagination")
        UI.setAttribute("helpPage"..i.."btn","color","black")
        UI.setAttribute("helpPage"..i.."btn","textColor","white")
    end
    UI.show(idValue:gsub("btn",""))
    UI.setAttribute(idValue,"class","paginationActive")
    UI.setAttribute(idValue,"color","yellow")
    UI.setAttribute(idValue,"textColor","black")

end
function onClick_dismiss_fleetHelp(plauer, _, idValue)
    UI.hide("fleetSpawnerHelpOuter")
end
spacing = "Compact"
function onClick_fleet_togglespacing(player, _, idValue)
    if spacing=="Compact" then
        spacing="S p a r s e"
    else
        spacing="Compact"
    end
    UI.setAttribute("spacingButton","text",spacing)
    UI.setAttribute("spacingButton","textColor","White")
end
----#include gameReporter

local Http = require("ge_tts/Http")
Http.setProxyUrl('https://ttsarmada.herokuapp.com/forward')
FIREBASE_COLLECTION = 'games'
--FIREBASE_COLLECTION = 'games_vassal'
--FIREBASE_COLLECTION = 'games_vassal_fantasy'

FIRST_FLEET = nil
SECOND_FLEET = nil
function onClick_selectGameReporterTab(player, _, idValue)
    onClick_ToggleUI(player, _, idValue)

    onClick_refreshObjective()
    --Autocalculate Scores?
    updateAllScores()
    for i, color in ipairs(Player.getColors()) do
        UI.hide(color.."1")
        UI.hide(color.."2")
    end
    for color, fleet in pairs(FLEETS) do
        if fleet~=nil then
            UI.show(color.."1")
            UI.show(color.."2")
        end
    end
    --Autocalculate Players
    autoSelectFirstSecondPlayer()
    updateScore()
end
function onClick_selectReportingTab(player, _, idValue)
    UI.show("scoreTabBody")
    UI.show("submitScore")
    UI.hide("resultTabBody")
end
standingOffset = 0
function onClick_standings_scrollUp(player, _, idValue)
    if standingOffset>0 then
        standingOffset = standingOffset - 10
    end
    updateStandingsScrollButtons()
    updateRankings()
end
function onClick_standings_scrollDown(player, _, idValue)
    if standingOffset+10<#rankings then
        standingOffset = standingOffset + 10
    end
    updateStandingsScrollButtons()
    updateRankings()
end
function updateStandingsScrollButtons()
    if standingOffset==0 then
        UI.setAttribute("parseStandingScrollUp", "iconColor", "#404040")
    else
        UI.setAttribute("parseStandingScrollUp", "iconColor", "#FFFFFF")
    end
    if standingOffset+10<#standings then
        UI.setAttribute("parseStandingScrollDown", "iconColor", "#404040")
    else
        UI.setAttribute("parseStandingScrollDown", "iconColor", "#FFFFFF")
    end
end
standings = nil
function onClick_selectStandingsTab(player, _, idValue)
    UI.show("resultTabBody")
    UI.hide("scoreTabBody")
    UI.hide("submitScore")
    if standings == nil then
        standings = {}
        -- result_api = "https://firestore.googleapis.com/v1/projects/ttsarmada/databases/(default)/documents/players/Kelorn"
        -- WebRequest.get(result_api, self, "loadResults")
        ranking_api = "https://firestore.googleapis.com/v1/projects/ttsarmada/databases/(default)/documents/index/ranked"
        WebRequest.get(ranking_api, self, "loadRanked")
    end
    onClick_loadMyStandings(player, _, idValue)
end
function onClick_loadMyStandings(player, _, idValue)
    UI.setValue("myresultName", player.steam_name)
    UI.setValue("myrankedresultName", player.steam_name)
    UI.setValue("myresultGames",0)
    UI.setValue("myrankedresultELO",1000)
    UI.setValue("myrankedresultWins",0)
    UI.setValue("myrankedresultGames",0)
    UI.setValue("myrankedresultRate",0)
    UI.setValue("myrankedresultRanking","")

    if results[player.steam_name]==nil then
        result_api = "https://firestore.googleapis.com/v1/projects/ttsarmada/databases/(default)/documents/players/"..player.steam_name
        -- print(result_api)
        WebRequest.get(result_api, self, "loadResults")
    else
        updateRankings()
    end
end
rankings = {}
function loadRanked(res)
    if res.is_error then
        printToAll(res.error,{1,0,0})
    else
        ranked = JSON.decode(res.text)
        for i,value in ipairs(ranked['fields']['players']['arrayValue']['values']) do
            name = value['stringValue']
            rankings[i] = name
            if results[name]==nil then
                result_api = "https://firestore.googleapis.com/v1/projects/ttsarmada/databases/(default)/documents/players/"..name
                -- print(result_api)
                WebRequest.get(result_api, self, "loadResults")
            end
        end
        updateStandingsScrollButtons()
    end
end
results = {}
function loadResults(res)
    if res.is_error then
        printToAll(res.error,{1,0,0})
    else
        standings = JSON.decode(res.text)

        result = {
            name = standings['fields']['steamname']['stringValue'],
            elo = tonumber(standings['fields']['ranked_elo']['integerValue']),
            unranked_elo = tonumber(standings['fields']['hidden_elo']['integerValue']),
            winrate = 0,
            unranked_winrate = 0
        }
        result.wins = tonumber(standings['fields']['ranked_won']['integerValue'])
        result.games = tonumber(standings['fields']['ranked_played']['integerValue'])
        result.unranked_wins = tonumber(standings['fields']['games_won']['integerValue'])
        result.unranked_games = tonumber(standings['fields']['games_played']['integerValue'])
        if result.games>0 then
            result.winrate = math.floor(100*result.wins/result.games)
        end
        if result.unranked_games>0 then
            result.unranked_winrate = math.floor(100*result.unranked_wins/result.unranked_games)
        end
        results[result.name] = result
        -- print(res.text)
        updateRankings()
    end
end
function updateRankings()
    local max_games = 1
    local max_wins = 1
    local max_elo = 1000
    local min_elo = 1000
    for _,ranking in pairs(results) do
        if ranking.games>max_games then
            max_games = ranking.games
        end
        if ranking.wins>max_wins then
            max_wins = ranking.wins
        end
        if ranking.elo>max_elo then
            max_elo = ranking.elo
        end
        if ranking.elo<min_elo then
            min_elo = ranking.elo
        end
    end
    for i=1,10 do
        name = rankings[standingOffset+i]
        result = results[name]
        if result~=nil then
            UI.show("resultRow"..i)
            UI.setValue("resultRanking"..i,standingOffset+i)
            UI.setValue("resultName"..i,result.name)
            UI.setValue("resultELO"..i,result.elo)
            UI.setAttribute("resultELO"..i, "color", "rgb(1,1,"..(1-math.pow((result.elo-min_elo)/(max_elo-min_elo),2))..")")
            UI.setValue("resultWins"..i,result.wins)
            UI.setAttribute("resultWins"..i, "color", "rgb("..(0.3+0.7*(1-math.pow(result.wins/max_wins,2)))..",1,"..(0.3+0.7*(1-math.pow(result.wins/max_wins,2)))..")")
            UI.setValue("resultGames"..i,result.games)
            UI.setAttribute("resultGames"..i, "color", "rgb("..(0.3+0.7*(1-math.pow(result.games/max_games,2)))..","..(0.3+0.7*(1-math.pow(result.games/max_games,2)))..",1)")
            UI.setValue("resultRate"..i,result.winrate)
            UI.setAttribute("resultRate"..i, "color", "rgb("..math.min(2*(1-result.winrate/100),1)..","..math.min(2*(result.winrate/100),1)..",0)")
        else
            UI.hide("resultRow"..i)
        end
    end
    name = UI.getValue("myresultName")
    result = results[name]
    if result~=nil then
        -- UI.setValue("myresultELO",result.unranked_elo)
        -- UI.setAttribute("myresultELO", "color", "rgb(1,1,"..(1-math.pow((result.unranked_elo-min_elo)/(max_elo-min_elo),2))..")")
        -- UI.setValue("myresultWins",result.unranked_wins)
        -- UI.setAttribute("myresultWins", "color", "rgb("..(0.3+0.7*(1-math.pow(result.unranked_wins/max_wins,2)))..",1,"..(0.3+0.7*(1-math.pow(result.unranked_wins/max_wins,2)))..")")
        UI.setValue("myresultGames",result.unranked_games)
        UI.setAttribute("myresultGames", "color", "rgb("..(0.3+0.7*(1-math.pow(result.unranked_games/max_games,2)))..","..(0.3+0.7*(1-math.pow(result.unranked_games/max_games,2)))..",1)")
        -- UI.setValue("myresultRate",result.unranked_winrate)
        -- UI.setAttribute("myresultRate", "color", "rgb("..math.min(2*(1-result.unranked_winrate/100),1)..","..math.min(2*(result.unranked_winrate/100),1)..",0)")


        UI.setValue("myrankedresultELO",result.elo)
        UI.setAttribute("myrankedresultELO", "color", "rgb(1,1,"..(1-math.pow((result.elo-min_elo)/(max_elo-min_elo),2))..")")
        UI.setValue("myrankedresultWins",result.wins)
        UI.setAttribute("myrankedresultWins", "color", "rgb("..(0.3+0.7*(1-math.pow(result.wins/max_wins,2)))..",1,"..(0.3+0.7*(1-math.pow(result.wins/max_wins,2)))..")")
        UI.setValue("myrankedresultGames",result.games)
        UI.setAttribute("myrankedresultGames", "color", "rgb("..(0.3+0.7*(1-math.pow(result.games/max_games,2)))..","..(0.3+0.7*(1-math.pow(result.games/max_games,2)))..",1)")
        UI.setValue("myrankedresultRate",result.winrate)
        UI.setAttribute("myrankedresultRate", "color", "rgb("..math.min(2*(1-result.winrate/100),1)..","..math.min(2*(result.winrate/100),1)..",0)")

        if result.games<5 then
            UI.setValue("mynotes","Only "..tostring(5-result.games).." games left for Ranked Placement!")
            UI.setAttribute("mynotes","color", "#FF8080")
        else
            UI.setValue("mynotes","")
            for i,ranked_name in ipairs(rankings) do
                if ranked_name==name then
                    UI.setValue("mynotes","Currently Ranked: #"..tostring(i))
                    UI.setValue("myrankedresultRanking",tostring(i))
                    UI.setAttribute("mynotes","color", "#80FF80")
                end
            end
        end
    end
end
function autoSelectFirstSecondPlayer()
    -- for _,color in ipairs(Player.getColors()) do
    --     if FLEETS[color]~=nil then
    --         if FLEETS[color].secondPlayer then
    --             onClick_selectPlayer(color..2,2)
    --             break
    --         end
    --     end
    -- end
    -- for _,color in ipairs(Player.getColors()) do
    --     if FLEETS[color]~=nil then
    --         if not FLEETS[color].secondPlayer then
    --             onClick_selectPlayer(color..1,1)
    --             break
    --         end
    --     end
    -- end
    FIRST_FLEET = nil
    SECOND_FLEET = nil
    for color, fleet in pairs(FLEETS) do
        if fleet.secondPlayer then
            -- SECOND_FLEET = fleet
            onClick_selectPlayer(color..2,2)
            break
        end
    end
    for color, fleet in pairs(FLEETS) do
        if not fleet.secondPlayer then
            -- FIRST_FLEET = fleet
            onClick_selectPlayer(color..1,1)
            break
        end
    end
end
function onClick_refreshObjective(player, _, idValue)
    local objective = findObjective()
    UI.setValue("activeObjective",objective)
    if objective=="None?" then
        UI.setAttribute("activeObjective","color","#FF4040")
        UI.show("objectiveWarning")
        UI.show("objectiveRefresh")
    else
        UI.setAttribute("activeObjective","color","#80FF00")
        UI.hide("objectiveWarning")
        UI.hide("objectiveRefresh")
    end
end
function flatten(fleet)
    cards = {}
    if fleet == nil then return cards end
    for _,obj in ipairs(fleet.objectives) do
        table.insert(cards,obj.def.category..": "..obj.def.name)
    end
    for _,ship in ipairs(fleet.ships) do
        table.insert(cards,ship.def.name.." ("..ship.def.cost..")")
        for _,def in ipairs(ship.upgrades) do
            table.insert(cards," - "..def.name.." ("..def.cost..")")
        end
    end
    for _,squad in ipairs(fleet.squads) do
        if squad.count~=nil and squad.count>1 then
            table.insert(cards," - "..squad.count.." x "..squad.def.name.." ("..(squad.def.cost*squad.count)..")")
        else
            table.insert(cards," - "..squad.def.name.." ("..squad.def.cost..")")
        end
    end
    cardValues = {}
    for _,str in ipairs(cards) do
        table.insert(cardValues, {stringValue = str})
    end
    return cardValues
end
function onClick_score_submit(player, _, idValue)
    player1 = UI.getValue("Player1name")
    player2 = UI.getValue("Player2name")
    --player1score
    --player2score
    player1points = UI.getValue("Player1points")
    player2points = UI.getValue("Player2points")
    objective = UI.getValue("activeObjective")
    print("Getting fleet for player1: "..UI.getAttribute("Player1name","color"))
    fleet = FLEETS[UI.getAttribute("Player1name","color")]
    FIRST_FLEET = fleet
    player1faction = nil
    if fleet==nil then
        print("No fleet found for Player 1!")
        print("Please ensure players are seated on the correct side of the board, and reclick the appropriate colors for first and second player.")
        print("If all else fails, save the game, and reload, and retry score submission")
        return
    end
    if #fleet.ships > 0 then
        player1faction = fleet.ships[1].def.faction
    end
    player1fleet = flatten(fleet)
    if #player1fleet == 0 then
        print("No fleet found for Player 1!")
        return
    end
    print("Getting fleet for player2: "..UI.getAttribute("Player2name","color"))
    fleet = FLEETS[UI.getAttribute("Player2name","color")]
    SECOND_FLEET = fleet
    player2faction = nil
    if fleet==nil then
        print("No fleet found for Player 2!")
        print("Please ensure players are seated on the correct side of the board, and reclick the appropriate colors for first and second player.")
        print("If all else fails, save the game, and reload, and retry score submission")
        return
    end
    if #fleet.ships > 0 then
        player2faction = fleet.ships[1].def.faction
    end
    player2fleet = flatten(fleet)
    if #player2fleet == 0 then
        print("No fleet found for Player 2!")
        return
    end
    submitted = os.date("!%Y%m%dT%H%M%S").."."..string.format("%03d",math.random (999))
    -- print(submitted)
    broadcastToAll("Posting Game to Cloud.....", {1,1,1})
    url = "https://firestore.googleapis.com/v1/projects/ttsarmada/databases/(default)/documents/"..FIREBASE_COLLECTION
    -- url = "https://ttsarmada.herokuapp.com/databases/(default)/documents/games"
    -- print(FIRST_FLEET.score)
    -- print(SECOND_FLEET.score)
    Http.post(url,{
        ['fields'] = {
            player1 = { stringValue = tostring(player1)},
            player1SteamId = { stringValue = tostring(FIRST_FLEET.steam_id)},
            player1fleet = { arrayValue = { values = player1fleet} },
            player1faction = { stringValue = tostring(player1faction)},
            player1score = { integerValue = player1score or 0},
            player1scoreVerified = { integerValue = FIRST_FLEET.score},
            player1points = { integerValue = player1points or 5},
            objective = { stringValue = tostring(objective)},
            player2 = { stringValue = tostring(player2)},
            player2SteamId = { stringValue = tostring(SECOND_FLEET.steam_id)},
            player2fleet = { arrayValue = { values = player2fleet}},
            player2faction = { stringValue = tostring(player2faction)},
            player2score = { integerValue = player2score or 0},
            player2scoreVerified = { integerValue = SECOND_FLEET.score},
            player2points = { integerValue = player2points or 6},
            submitted = { stringValue = submitted},
            ranked = { booleanValue = RANKED},
            tournamentCode = { stringValue = TOURNAMENT_CODE or ""}
        }
    },{['Content-Type']="application/json"}, handle_score_submit)
end
function API_SET_GAMEREPORTER_COLLECTION(collection_name)
    printToAll("Set Game Reporter Collection to: "..collection_name, {0,1,1})
    FIREBASE_COLLECTION = collection_name
end
function handle_score_submit(resp, error)
    --Resp
    --statusCode
    --body>error>message
    if resp~=nil and resp['statusCode']==400 then
        broadcastToAll("Error with posting game!", {1,0,0})
        broadcastToAll("To fix this error: Save game, reload it, resubmit score. This will cause some objectives to score incorrectly, so double check points.", {0,1,1})
        print(resp['body']['error']['message'])
        return
    end
    -- print("Resp: ")
    -- for k,v in pairs(resp) do
    --     print("  ",k,":",v)
    -- end
    if error~=nil then
        broadcastToAll("Error: "..tostring(error), {1,0,0})
        broadcastToAll("To fix this error: Save game, reload it, resubmit score. This will cause some objectives to score incorrectly, so double check points.", {0,1,1})
        return
    end
    broadcastToAll("Game Successfully posted!", {0,1,0})
end
function onClick_selectPlayer1color(player, _, idValue)
    onClick_selectPlayer(idValue,1)
end
function onClick_selectPlayer2color(player, _, idValue)
    onClick_selectPlayer(idValue,2)
end
-- PLAYER_HAS_FLEET = {
--     false, false
-- }
function onClick_selectPlayer(idValue,i)
    color = UI.getAttribute(idValue,"color")
    -- printToAll(color,{1,1,1})
    if i==1 then
        FIRST_FLEET = FLEETS[color]
    else
        SECOND_FLEET = FLEETS[color]
    end
    if FLEETS[color]~=nil then
        -- print(Player[color].steam_name)
        UI.setAttribute("Player"..i.."name", "color", color)
        -- FLEETS[color].color = color
        if FLEETS[color].steam_name~=nil then
            -- FLEETS[color].steam_name = Player[color].steam_name
            -- FLEETS[color].steam_id = Player[color].steam_id
            UI.setValue("Player"..i.."name", FLEETS[color].steam_name)
        else
            -- FLEETS[color].steam_name = "Unknown"
            -- FLEETS[color].steam_id = nil
            UI.setValue("Player"..i.."name", "Unknown?")
        end
        -- FLEETS[color] = buildFleetFromZone(color)
        -- print("Stored fleet in: "..color)
        -- PLAYER_HAS_FLEET[i] = FLEETS[color]~=nil
        -- updateFleetCostDisplay(color)
        UI.show("Player"..i.."listFound")
        UI.hide("Player"..i.."listNotFound")
    else
        -- PLAYER_HAS_FLEET[i] = false
        UI.setAttribute("Player"..i.."name", "color", "#FF4040") --color
        UI.setValue("Player"..i.."name", "?")
        UI.hide("Player"..i.."listFound")
        UI.show("Player"..i.."listNotFound")
    end
    -- local p1hasfleet = PLAYER_HAS_FLEET[1]
    -- local p2hasfleet = PLAYER_HAS_FLEET[2]
    -- print(p1hasfleet,p2hasfleet)
    if FIRST_FLEET~=nil and SECOND_FLEET~=nil then
        Wait.frames(function()
            -- local p1color = UI.getAttribute("Player1name","color")
            -- local p2color = UI.getAttribute("Player2name","color")
            -- print(p1color, p2color)
            -- local p1score = FLEET_SCORE[p1color]
            -- local p2score = FLEET_SCORE[p2color]
            player1score = FIRST_FLEET.objective + SECOND_FLEET.totalDead
            FIRST_FLEET.score = player1score--p2score['lost']+p1score['objective']

            UI.setAttribute("player1score","outline","#80FF00")
            player2score = SECOND_FLEET.objective + FIRST_FLEET.totalDead
            SECOND_FLEET.score = player2score--p1score['lost']+p2score['objective']
            UI.setAttribute("player2score","outline","#80FF00")
            UI.setAttribute("player1score","text",FIRST_FLEET.score)
            UI.setAttribute("player2score","text",SECOND_FLEET.score)
            updateScore()
        end,1)
    end

end
function findObjective(noerror)
    for _,object in ipairs(getAllObjects()) do
        if  vector.length(vector.sub(object.getPosition(),{-40.66,0.97,-0.09}))<2 then
            Action_select_objective(object)
            return object.getName()
        end
    end
    if not noerror then
        printToAll("Click 'Choose' on Objective to move to Proper Location for auto-detection!",{1,0,0})
    end
    return "None?"
end
player1score = nil
function onInput_player1score(player, value, idValue)
    if value~=nil then
        player1score = tonumber(value)
    else
        player1score = value
    end
    updateScore()
    if value==nil then
        UI.setAttribute("player1score","outline","#FF4040")
    else
        UI.setAttribute("player1score","outline","#80FF00")
    end
end
player2score = nil
function onInput_player2score(player, value, idValue)
    if value~=nil then
        player2score = tonumber(value)
    else
        player2score = value
    end
    updateScore()
    if value==nil then
        UI.setAttribute("player2score","outline","#FF4040")
    else
        UI.setAttribute("player2score","outline","#80FF00")
    end
end
player1points=0
player2points=0
function updateScore()
    margin = math.abs((player1score or 0) - (player2score or 0))
    score1 = nil
    score2 = nil
    if margin>=300 then
        score1=10
        score2=1
    elseif margin>=220 then
        score1=9
        score2=2
    elseif margin>=140 then
        score1=8
        score2=3
    elseif margin>=60 then
        score1=7
        score2=4
    else
        score1=6
        score2=5
    end
    if player1score==nil or player2score==nil then
        UI.setValue("Player1iswinner","")
        UI.setValue("Player2iswinner","")
        UI.setValue("Player1points","-")
        UI.setValue("Player2points","-")
    else
        if player1score>player2score then
            player1points=score1
            player2points=score2
            UI.setValue("Player1iswinner","Winner!")
            UI.setValue("Player2iswinner","")
        else
            player1points=score2
            player2points=score1
            UI.setValue("Player1iswinner","")
            UI.setValue("Player2iswinner","Winner!")
        end
        UI.setValue("Player1points",player1points)
        UI.setValue("Player2points",player2points)
    end
end
RANKED = false
function onClick_casualRanked(player, _, idValue)
    if idValue=="casual" then
        RANKED = false
        UI.setAttribute("casual","fontStyle","bold")
        UI.setAttribute("casual","fontSize","18")
        UI.setAttribute("casual","color","#C0C0C0")
        UI.setAttribute("casual","outline","white")
        UI.setAttribute("casual","textColor","black")

        UI.setAttribute("ranked","fontStyle","Normal")
        UI.setAttribute("ranked","fontSize","14")
        UI.setAttribute("ranked","color","black")
        UI.setAttribute("ranked","outline","#443B00")
        UI.setAttribute("ranked","textColor","#443B00")

        UI.hide("rankedWarning")
    else
        RANKED = true
        UI.setAttribute("casual","fontStyle","Normal")
        UI.setAttribute("casual","fontSize","14")
        UI.setAttribute("casual","color","black")
        UI.setAttribute("casual","outline","#404040")
        UI.setAttribute("casual","textColor","#404040")

        UI.setAttribute("ranked","fontStyle","bold")
        UI.setAttribute("ranked","fontSize","18")
        UI.setAttribute("ranked","color","#DAA520")
        UI.setAttribute("ranked","outline","#FFD700")
        UI.setAttribute("ranked","textColor","black")

        UI.show("rankedWarning")

    end
end
TOURNAMENT_CODE = nil
function onInput_tournamentCode(player, value, idValue)
    TOURNAMENT_CODE = value
end

----#include gameReporter
----#include upgradeSpawner
ALL_FACTIONS = {"Rebellion","Empire","Republic","Separatist"}
faction_index = 1

function onClick_selectShipSpawnerTab(player, _, idValue)
    onClick_selectArmadaTab(player, _, idValue)
    --checkFactions
    -- print("Finding Factions")
    factions = T(SHIPS):Select(|s|s.faction):Distinct()
    for _,v in ipairs(factions) do
        if not table.contains(ALL_FACTIONS,v) then
            table.insert(ALL_FACTIONS, v)
            print("Found a new faction: "..v)
        end
    end
    updateFactionButtons()
end
function onClick_selectUpgradeSpawnerTab(player, _, idValue)
    onClick_selectArmadaTab(player, _, idValue)
    factionGroups = T(CARDS):Select(|c|c.factions):Distinct()
    for _,vg in ipairs(factionGroups) do
        for _,v in ipairs(vg) do
            if not table.contains(ALL_FACTIONS,v) then
                table.insert(ALL_FACTIONS, v)
                print("Found a new faction: "..v)
            end
        end
    end
    updateFactionButtons()
end

selected_faction = "Rebellion"
selected_category = nil
function onClick_selectFaction(player, _, idValue)
    selected_faction = UI.getAttribute(idValue,"text")
    -- idValue = idValue:gsub("_upgrade","")
    -- idValue = idValue:gsub("_ship","")
    -- print("Faction: "..idValue)
    updateFactionButtons()
    update_upgrade_card_list()
    update_ship_card_list()
end
function onClick_prevFactions(player, _, idValue)
    faction_index = math.max(1,faction_index-4)
    updateFactionButtons()
end
function onClick_nextFactions(player, _, idValue)
    faction_index = faction_index+4
    updateFactionButtons()
end
function updateFactionButtons()
    for i=1,4 do
        -- print(faction_index+i-1)
        -- print(ALL_FACTIONS[faction_index+i-1])
        UI.setAttribute("ship_faction_"..i,"text",ALL_FACTIONS[faction_index+i-1])
        UI.setAttribute("upgrade_faction_"..i,"text",ALL_FACTIONS[faction_index+i-1])

        if ALL_FACTIONS[faction_index+i-1]==nil then
            UI.setAttribute("ship_faction_"..i,"active",false)
            UI.setAttribute("upgrade_faction_"..i,"active",false)
        else
            UI.setAttribute("ship_faction_"..i,"active",true)
            UI.setAttribute("upgrade_faction_"..i,"active",true)
        end

        if ALL_FACTIONS[faction_index+i-1]==selected_faction then
            UI.setAttribute("ship_faction_"..i,"textColor","#FFD700")
            UI.setAttribute("upgrade_faction_"..i,"textColor","#FFD700")
        else
            UI.setAttribute("ship_faction_"..i,"textColor","#FFFFFF")
            UI.setAttribute("upgrade_faction_"..i,"textColor","#FFFFFF")
        end
    end
    if faction_index>1 then
        UI.show("prevFactions_ship")
        UI.show("prevFactions_upgrade")
    else
        UI.hide("prevFactions_ship")
        UI.hide("prevFactions_upgrade")
    end

    if #ALL_FACTIONS>=faction_index+4 then
        UI.show("nextFactions_ship")
        UI.show("nextFactions_upgrade")
    else
        UI.hide("nextFactions_ship")
        UI.hide("nextFactions_upgrade")
    end
end
selected_special_objectives = false
function onClick_loadCategory(player, _, idValue)
    if selected_category=="Objective" and idValue=="Objective" and selected_special_objectives==false then
        selected_special_objectives = true
    else
        selected_special_objectives = false
    end
    selected_category = idValue
    -- UI.setAttribute(idValue,"colors","#040404|#A0A0A0|white|#040404")
    -- UI.setAttribute(idValue,"color","#A0A0A0")
    for i,v in ipairs({"Objective","Commander","DefensiveRetrofit","ExperimentalRetrofit","FleetCommand","FleetSupport","IonCannons","Objectives","Ordnance","OffensiveRetrofit","Officer","SuperWeapon","SupportTeam","Title","Turbolaser","WeaponsTeam","WeaponsTeamAndOffensiveRetrofit"}) do
        UI.setAttribute(v,"iconColor","#FFFFFF")
    end
    if idValue=="Objective" and selected_special_objectives then
        UI.setAttribute(idValue,"iconColor","rgba(0.267,0.678,0.459)")
    else
        UI.setAttribute(idValue,"iconColor","#FFD700")
    end
    update_upgrade_card_list()
end
function update_upgrade_card_list()
    if selected_category==nil then return end
    cards_of_category = CARDS_BY_CATEGORY[selected_category]
    if selected_category == "Objective" then
        local filtered_cards = {}

        for _, v in pairs(cards_of_category) do
            if (v.category=="Special") == selected_special_objectives then table.insert(filtered_cards, v) end
        end

        cards_of_category = filtered_cards
    end
    if selected_category~="Title" and selected_category~="Objective" then
        table.sort(cards_of_category, function(a, b)
            return a.name < b.name
        end)
    end
    if selected_faction ~= nil then
        -- print(selected_faction)
        local filtered_cards = {}

        for _, v in pairs(cards_of_category) do
            if v.factions==nil or table.contains(v.factions,selected_faction) then table.insert(filtered_cards, v) end
        end

        cards_of_category = filtered_cards
    end
    local last = 0
    local i = 1
    for _,def in pairs(cards_of_category) do
        if def.cost~=nil then
            UI.setAttribute("upgrade"..i, "text",def.name.." ("..def.cost..")")
            UI.setAttribute("upgrade"..i, "textColor","white")
        else
            UI.setAttribute("upgrade"..i, "text",def.name)
            UI.setAttribute("upgrade"..i, "textColor","white")
        end
        if def.category=="Assault" then
            UI.setAttribute("upgrade"..i, "textColor","rgba(0.82,0.22,0.235)")
        elseif def.category=="Defense" then
            UI.setAttribute("upgrade"..i, "textColor","rgba(0.992,0.922,0.031)")
        elseif def.category=="Navigation" then
            UI.setAttribute("upgrade"..i, "textColor","rgba(0.765,0.878,0.949)")
        elseif def.category=="Special" then
            UI.setAttribute("upgrade"..i, "textColor","rgba(0.267,0.678,0.459)")
        end
        last = i
        UI.show("upgrade"..i)
        i = i+1
    end
    for i = last+1,40 do
        UI.hide("upgrade"..i)
        UI.setAttribute("upgrade"..i, "text","")
        -- if last<=20 and i>20 then
        -- end
    end
    if last<=20 then
        UI.setAttribute("upgradeGrid", "cellSize", "400 28")
    else
        UI.setAttribute("upgradeGrid", "cellSize", "200 28")
    end
end
function onClick_spawn_all_upgrades(player, _, idValue)
    for i=1,40 do
        cardName = UI.getAttribute("upgrade"..i,"text")
        -- print(cardName)
        if cardName~="" and cardName~=nil then
            onClick_spawnCard(player, _, "upgrade"..i)
        end
    end
end
function onClick_spawnCard(player, _, idValue)
    cardname = UI.getAttribute(idValue,"text")
    def = CARDS[string.lower(cardname)] or SHIPS[string.lower(cardname)]
    size = {2.5,2,3}
    if def.maneuver~=nil or def.move~=nil then
        size = {4.6,2,8.5}
    end
    if def.defense_tokens~=nil and #def.defense_tokens==6 then
        size = {9,2,8.5}
    end
    if def~=nil then
        x_step = size[1]*1.1
        y_step = size[3]*1.1
        for j=0,math.floor(20/y_step) do
            for i=0,math.floor(48/x_step) do
                pos = vector.add({-24,1.98,11}, {i*x_step,0,j*-y_step})
                local hitList = Physics.cast({
                    origin       = pos,
                    direction    = {0,1,0},
                    type         = 3,
                    size         = size,
                    max_distance = 0,
                    debug        = false,
                })
                if #hitList == 0 then
                    spawnCard(def, {-24, 2, 11}, {i*x_step, 0, j*-y_step}, {0, 0, 0}, nil, false)
                    return
                end
            end
        end
    end
end

----#include upgradeSpawner
----#include shipSpawner

--onClick_selectFaction SEE: upgradeSpawner.ttslua
ship_or_squadrons = nil
function update_ship_card_list()
    if ship_or_squadrons~=nil then
        ships_of_faction = {}
        for k,def in pairs(SHIPS_BY_FACTION[selected_faction]) do
            -- print(def.name.." "..tostring(def.move~=nil).." "..tostring(def.maneuver~=nil).." "..def.faction)
            if (def.maneuver~=nil and ship_or_squadrons=="ships") or
               (def.move~=nil and ship_or_squadrons=="squadrons") then
                -- print(def.name)
                table.insert(ships_of_faction,def)
            end
        end
        last = 0
        for i,def in ipairs(ships_of_faction) do
            UI.setAttribute("ship"..i, "text",def.name.." ("..def.cost..")")
            UI.setAttribute("ship"..i, "textColor","white")
            last = i
            UI.show("ship"..i)
        end
        for i = last+1,40 do
            UI.hide("ship"..i)
            UI.setAttribute("ship"..i, "text","")
            -- if last<=20 and i>20 then
            -- end
        end
        if last<=24 then
            UI.setAttribute("shipGrid", "cellSize", "400 26")
        else
            UI.setAttribute("shipGrid", "cellSize", "200 26")
        end
    end
end
function onClick_spawn_all_ships(player, _, idValue)
    for i=1,40 do
        cardName = UI.getAttribute("ship"..i,"text")
        -- print(cardName)
        if cardName~="" and cardName~=nil then
            onClick_spawnCard(player, _, "ship"..i)
        end
    end
end
function onClick_selectShipSquadron(player, _, idValue)
    ship_or_squadrons = idValue:gsub("_ship","")
    -- print("Faction: "..idValue)
    for i,v in ipairs({"squadrons_ship","ships_ship"}) do
        UI.setAttribute(v,"textColor","#FFFFFF")
    end
    UI.setAttribute(idValue,"textColor","#FFD700")
    update_ship_card_list()
end

----#include shipSpawner
----#include mapSelector
MAPS = {}

MAPS["original"] = "https://i.imgur.com/0KjWlZ5.jpeg"
MAPS["classic_setup"] = "https://i.imgur.com/vyTXggp.jpg"
MAPS["classic_setup_d4"] = "https://i.imgur.com/mW0Sff7.jpg"
MAPS["classic_setup_d5"] = "https://i.imgur.com/CRIHRpv.jpg"
MAPS["classic_setup_center"] = "https://i.imgur.com/DXBXRgh.jpeg"
MAPS["classic_setup_center_d5"] = "https://i.imgur.com/uiVVSBF.jpeg"
MAPS["classic_setup_3ft_d24"] = "https://i.imgur.com/76qYPRN.jpg"
MAPS["classic_setup_3ft_d1"] = "https://i.imgur.com/DcCv5TL.jpeg"
MAPS["take_the_station"] = "https://i.imgur.com/iSATBMI.jpg"
MAPS["fleet_ambush"] = "https://i.imgur.com/pP1DERr.jpeg"
MAPS["classic"] = "https://i.imgur.com/w7gX3wI.jpg"
MAPS["hoth"] = "https://i.imgur.com/b0V8PIb.jpg"
MAPS["scarif"] = "https://i.imgur.com/fhbvvWR.jpg"
MAPS["solar_corona_left"] = "https://i.imgur.com/uYQ4vm5.jpg"
MAPS["solar_corona_right"] = "https://i.imgur.com/5H1j6D7.jpg"
MAPS["doomed_station"] = "https://i.imgur.com/fFKS59s.jpg"
MAPS["italia"] = "https://i.imgur.com/ZH3BOIY.jpg"
MAPS["task_force"] = "https://i.imgur.com/GccejV5.jpeg"
MAPS["urban"] = "https://i.imgur.com/ml1Mwgy.jpeg"
MAPS["rob_shield"] = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/tables/rob_shield.jpg'
MAPS["rob_frozen"] = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/tables/rob_frozen.jpg'
MAPS["rob_dockyard"] = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/tables/rob_dockyard.jpg'
function onClick_select_map(player, _, idValue)
    customUrl = MAPS[idValue]
    if customUrl~=nil then
        Tables.setCustomURL(customUrl)
    else
        print(idValue.." not recognized as custom map")
    end
end
function onClick_ToggleTableSelect(player, _, idValue)
    local active = UI.getAttribute("mapSelectorPopup","active")
    if active==nil or active=="true" then
        UI.hide("mapSelectorPopup")
    else
        UI.show("mapSelectorPopup")
    end

end

----#include mapSelector

----#include ui/fleetSpawner

ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'

DEF_BRACE = '79d121'
DEF_CONTAIN = '68abfc'
DEF_EVADE = 'c09d88'
DEF_REDIRECT = '36f595'
DEF_SCATTER = '895e91'
DEF_SALVO = '5028b2'

ALL_DEFENSE_TOKENS = {
    BRACE = DEF_BRACE,
    CONTAIN = DEF_CONTAIN,
    EVADE = DEF_EVADE,
    REDIRECT = DEF_REDIRECT,
    SCATTER = DEF_SCATTER,
    SALVO = DEF_SALVO
}
SPEED_SOURCE = 'b75a56'
COMMAND_SOURCE = '2516df'
COM_ENG = ''
COM_CON = ''
COM_NAV = ''
COM_SQA = ''
COMMAND_TOKEN_SOURCES = {
    'cc1a75',
    'ed755e',
    'd62f13',
    'dea579'
}

function update()
    for _,card in ipairs(getAllObjects()) do
        if card.tag == 'Card' and card.getName()~=nil then
            local cmd = card.getDescription()
            local oldName = card.getVar('oldName')
            card.setVar('oldName',card.getName())
            if cmd:starts "spawn" then
                if oldName ~= card.getName() then
                    card.setName(oldName)
                end
                local count = tonumber(cmd:match "spawn%s(.*)")
                if count == nil then count = 1 end
                printToAll("Spawn ship '"..card.getName().."'",{0,1,1})
                spawnShip(card.getName(),card.getPosition(),count,card.getRotation()[2])
                card.setDescription("")
                card.clearButtons()
                --card.lock()
            end
        end
    end
end
Ship = {
    collider = "",
    convex = true,
    type = 1,
    material = 3,
    maneuver = {},
    defense_tokens = {},
    shields = {1,1,1,1,1,1},
    cost = 0,
    name = "",
    front = "",
    back = "",
    aliases = {},
    faction = ""
}
function Ship:new (o,...)
    o = o or {}
    o = table.copy(o)
    if ... ~= nil then
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                o[k] = v
            end
        end
    end
    setmetatable(o, Ship)
    Ship.__index = Ship
    Cache(SHIPS,o)
    return o
end
SmallShip = {
    collider = ASSETS_ROOT..'misc/bases/small.obj'
}
MediumShip = {
    collider = ASSETS_ROOT..'misc/bases/medium.obj'
}
LargeShip = {
    collider = ASSETS_ROOT..'misc/bases/large.obj'
}
HugeShip = {
    collider = ASSETS_ROOT..'misc/bases/huge.obj'
}
Squadron = {
    collider = ASSETS_ROOT..'misc/bases/squad.obj', --"http://paste.ee/r/nAMCQ",
    convex = false,
    type = 1,
    material = 1,
    health = 0,
    move = 0,
    defense_tokens = {},
    cost = 0,
    name = "",
    front = "",
    back = "",
    aliases = {},
    faction = ""
}
function Squadron:new (o, ...)
    o = o or {}
    o = table.copy(o)
    if ... ~= nil then
        -- printToAll("Found args: "..tostring(#{...}),{0,1,1})
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                -- printToAll("Copying over: "..k)
                o[k] = v
            end
        end
    end
    setmetatable(o, Squadron)
    Squadron.__index = Squadron
    -- if o.name == nil then
    --     for k, v in pairs(o) do
    --         printToAll(k..":"..tostring(v),{1,0,0})
    --     end
    -- end
    -- if o.cost == nil then
    --     printToAll(o.name.." has no cost",{1,0,0})
    -- end
    Cache(SHIPS,o)
    -- if key~=key_noclass then
    --     printToAll(key.." ~= "..key_noclass,{1,1,0})
    -- end
    return o
end
SHIPS_BY_FACTION = {}
CARDS_BY_CATEGORY = {}
function API_CacheShip(o)
    printToAll("Sideloading Ship: ["..o.name.." ("..o.cost..")]",{.5, 1,.5})
    Cache(SHIPS,o)
end
function API_CacheCard(o)
    -- if o.cost == nil then
    --     printToAll("Sideloading Card: ["..o.name.."]",{.5, 1,.5})
    -- else
        printToAll("Sideloading Card: ["..o.name.." ("..tostring(o.cost)..")]",{.5, 1,.5})
    -- end
    Cache(CARDS,o)
end
function API_PurgeCard(o)
    -- if o.cost == nil then
    --     printToAll("Manually Purging: ["..o.name.."]",{1, .5,.5})
    -- else
        printToAll("Manually Purging: ["..o.name.." ("..tostring(o.cost)..")]",{1, .5,.5})
    -- end
    -- local i = o.name
    -- if o.cost~=nil then
        local i = o.name.." ("..o.cost..")"
    -- end
    for category, arr in pairs(CARDS_BY_CATEGORY) do
        if arr[i]~=nil then
        -- for i,o_cached in ipairs(arr) do
        --     if o_cached.name == o.name and o_cached.cost == o.cost then
            printToAll("Purging existing "..category.." Card entry: ["..o.name.." ("..o.cost..")]!", {1,0,0})
            -- PurgeNGrams(arr[i])
            arr[i] = nil
            return
        --     end
        -- end
        end
    end
    for faction, arr in pairs(SHIPS_BY_FACTION) do
        if arr[i]~=nil then
        -- for i,o_cached in ipairs(arr) do
        --     if o_cached.name == o.name and o_cached.cost == o.cost then
            printToAll("Purging existing "..faction.." Ship entry: ["..o.name.." ("..o.cost..")]!", {1,0,0})
            -- PurgeNGrams(arr[i])
            arr[i] = nil
            return
                --TODO: SHIPS/CARDS still contain old ones? Aliases! Etc.
        --     end
        -- end
        end
    end
end
function API_UpdateCard(update)
    -- if update.cost == nil then
    --     printToAll("Updating Card: ["..update.name.."]",{.5,.5,1})
    -- else
        printToAll("Updating Card: ["..update.name.." ("..tostring(update.cost)..")]",{.5,.5,1})
    -- end
    -- local i = update.name
    -- if update.cost~=nil then
        local i = update.name.." ("..update.cost..")"
    -- end
    for category, arr in pairs(CARDS_BY_CATEGORY) do
        if arr[i]~=nil then
        -- for i,o_cached in ipairs(arr) do
        --     if o_cached.name == update.name and o_cached.cost == update.cost then
            for key, new_value in pairs(update.o) do
                printToAll("Updating "..key.." for "..update.name,{0.5,0.5,0.5})
                arr[i][key] = new_value
            end
            -- if update.cost ~= update.o.cost then --Change Cost?
            --     PurgeNGrams(arr[i])
            -- end
            Cache(CARDS,arr[i])
            return
        --     end
        -- end
        end
    end
    for faction, arr in pairs(SHIPS_BY_FACTION) do
        if arr[i]~=nil then
        -- for i,o_cached in ipairs(arr) do
        --     if o_cached.name == update.name and o_cached.cost == update.cost then
            for key, new_value in pairs(update.o) do
                printToAll("Updating "..key.." for "..update.name,{0.5,0.5,0.5})
                arr[i][key] = new_value
            end
            -- if update.cost ~= update.o.cost then --Change Cost?
            --     PurgeNGrams(arr[i])
            -- end
            Cache(SHIPS,arr[i])
            return
        --     end
        -- end
        end
    end
end
function API_GetDefinition(o)
    for category, arr in pairs(CARDS_BY_CATEGORY) do
        -- local o_cached = arr[o.name]
        -- if o.cost~=nil then
            local o_cached = arr[o.name.." ("..o.cost..")"]
        -- end
        if o_cached~=nil then
        -- for i,o_cached in ipairs(arr) do
        --     if o_cached.name == o.name and o_cached.cost == o.cost then
                return o_cached
        --     end
        -- end
        end
    end
    for faction, arr in pairs(SHIPS_BY_FACTION) do
        -- local o_cached = arr[o.name]
        -- if o.cost~=nil then
            local o_cached = arr[o.name.." ("..o.cost..")"]
        -- end
        if o_cached~=nil then
        -- for i,o_cached in ipairs(arr) do
        --     if o_cached.name == o.name and o_cached.cost == o.cost then
            return o_cached
            -- end
        -- end
        end
    end
    printToAll("No definition found of name: '"..o.name.."' with cost: "..tostring(o.cost), {1,0,0})
    return nil
end
function PurgeNGrams(o)
    if o~=nil then
        for key,ngram in pairs(NGRAMS) do
            for i,obj in ipairs(ngram) do
                if obj==o then
                    NGRAMS[key][i] = nil
                end
            end
        end
    end
end
function UpdateListByNameAndCost(arr,o)
    local i = o.name
    if o.cost~=nil then
        i = o.name.." ("..o.cost..")"
    end
    if arr[i]~=nil then
    -- for i,o_cached in ipairs(arr) do
    --     if o_cached.name == o.name and o_cached.cost == o.cost then
        printToAll("Overwriting existing entry: ["..o.name.." ("..o.cost..")]!", {1,0,0})
        PurgeNGrams(arr[i])
        arr[i] = o
    --     end
    -- end
    end
    arr[i]=o
    -- table.insert(arr,o)
end
function Cache(DEFS,o)
    if o.type~=nil and o.type~=1 then --Is a card? Models have type 1
        if CARDS_BY_CATEGORY[o.type]==nil then
            CARDS_BY_CATEGORY[o.type] = {}
        end
        UpdateListByNameAndCost(CARDS_BY_CATEGORY[o.type],o)
        --table.insert(CARDS_BY_CATEGORY[o.type],o)
    end
    if o.faction~=nil and (o.move~=nil or o.maneuver~=nil) then --Is a ship or squadron?
        if SHIPS_BY_FACTION[o.faction]==nil then
            SHIPS_BY_FACTION[o.faction] = {}
        end
        UpdateListByNameAndCost(SHIPS_BY_FACTION[o.faction],o)
        --table.insert(SHIPS_BY_FACTION[o.faction],o)
    end
    -- FUZZY[string.lower(o.name)] = o
    if o.cost~=nil then
        DEFS[string.lower(o.name.." ("..o.cost..")")] = o
        CacheNgrams(o.name.." ("..o.cost..")")
        DEFS[string.lower(o.name.." "..o.cost)] = o
        CacheNgrams(o.name.." "..o.cost)
    else
        CacheNgrams(o.name)
    end
    DEFS[string.lower(o.name)] = o
    -- CacheNgrams(o.name)
    for _,alias in ipairs(o.aliases) do
        if o.cost~=nil then
            DEFS[string.lower(alias.." ("..o.cost..")")] = o
            CacheNgrams(alias.." ("..o.cost..")")
            DEFS[string.lower(alias.." "..o.cost)] = o
            CacheNgrams(alias.." "..o.cost)
        else
            CacheNgrams(alias)
        end
        DEFS[string.lower(alias)] = o
        -- CacheNgrams(alias)
    end
end
NGRAMS = {}
function CacheNgrams(name)
    name = string.lower(name)
    n = #name
    s = " "..name.." "
    -- if name=="acclamator ii" then
    --     print("Caching Ngrams for "..name)
    -- end
    for i = 1,n do
        sub = string.sub(s,i,i+2)
        -- if name=="acclamator ii" then
        --     print("Adding: '"..name.."' for: '"..sub.."'")
        -- end
        if NGRAMS[sub]==nil then
            NGRAMS[sub]={name}
        else
            table.insert(NGRAMS[sub],name)
        end
    end
end
Card = {
    cost = 0,
    name = "",
    type = "",
    front = "",
    back = "",
    aliases = {},
    iscard = true, -- to replace checking for "type"
    faction = nil
}
function Card:new (o, ...)
    o = o or {}
    o = table.copy(o)
    if ... ~= nil then
        -- printToAll("Found args: "..tostring(#{...}),{0,1,1})
        for i,tab in ipairs({...}) do
            for k, v in pairs(tab) do
                -- printToAll("Copying over: "..k)
                o[k] = v
            end
        end
    end
    setmetatable(o, Card)
    Card.__index = Card
    Cache(CARDS,o)
    return o
end
SHIPS = {}
CARDS = {}
function onObjectSpawn(object)
    --Create a Button on the card for leaving a container
    if object.tag ~= "Figurine" and object.getName()~=nil and (SHIPS[string.lower(object.getName())] != nil or string.starts(object.getDescription(),"Custom")) and not isDatacard(object) then
        createSpawnButtons(object)
    end

    if CARDS[string.lower(object.getName())]~=nil and CARDS[string.lower(object.getName())].type == "Objective" then
        -- print("Found objective: "..object.getName())
        category = CARDS[string.lower(object.getName())].category
        color = {0.82,0.22,0.235} --Assault
        if category == "Defense" then
            color = {0.992,0.922,0.031}
        elseif category == "Navigation" then
            color = {0.765,0.878,0.949}
        elseif category == "Special" then
            color = {0.267,0.678,0.459}
        end
        object.createButton({
            ['click_function'] = "Action_select_objective",
            ['function_owner'] = self,
            ['label'] = "Choose",
            ['position'] = {0,0.25,1.5},
            ['rotation'] =  {0,0,0},
            ['width'] = 800,
            ['height'] = 240,
            ['font_size'] = 180,
            ['color'] = color,
            ['font_color']={0,0,0}})
    end
end
-- #include MapManager
function Action_select_objective(card)
    def = CARDS[string.lower(card.getName())]
    onClick_select_victoryToken(nil, nil, "Victory_0")
    if def~=nil then
        if def.victory~=nil then
            onClick_select_victoryToken(nil, nil, "Victory_"..tostring(def.victory))
        elseif table.contains({"Most Wanted","Opening Salvo","Intel Sweep"},def.name) then
            onClick_select_victoryToken(nil, nil, "Victory_"..def.name:gsub(" ",""))
        end
    end
    card.setPositionSmooth({-40.66,0.97,-0.09}, false, false)
    card.clearButtons()
    Wait.time(||onClick_refreshObjective(),2,0)
    -- TODO: Test map feature!
    -- if MAPS["Objective: "..card.getName()]~=nil then
    --     spawnBlankCanvas()
    --     spawnGuides("Objective: "..card.getName())
    -- else
    --     resetCanvas()
    -- end
end
-- function onObjectLeaveContainer(Container, object)
--     --Create a Button on the card for leaving a container
--     if SHIPS[object.getName()] != nil or string.starts(object.getDescription(),"Custom") then
--         createSpawnButtons(object)
--     end
-- end
function createSpawnButtons(object)
    object.clearButtons()
    scale = {1,1,1}
    if string.match(object.getName(),"Star Dread") then
        scale = {0.5,0,1}
    end
    object.createButton({label = "Spawn: "..object.getName(), click_function = 'Action_Spawn', rotation = {0, 0, 0},
    position = {0, 0.3, 2}, scale = scale, width = (40 * string.len("Spawn: "..object.getName())), height = 100, font_size = 75, function_owner = self, color={0,1,0}, font_color={0,0,0}})
    object.createButton({label = "Done", click_function = 'Action_DoneSpawn', rotation = {0, 0, 0},
    position = {0, 0.3, 2.8}, scale = scale, width = 320, height = 100, font_size = 75, function_owner = self, color={1,0,0}, font_color={1,1,1}})
    -- local data = SHIPS[object.getName()]
    -- data[12] = object.getGUID()
    -- data[13] = {}
    -- object.setTable('Details', data)
    if string.starts(object.getDescription(),"Custom") then
        printToAll("Loading definition for: "..(object.getName()) , {0,1,1})
        object.createButton({label = "Reload Custom Definition", click_function = 'createSpawnButtons', rotation = {0, 0, 0},
        position = {0, 0.3, -2.4}, width = 900, height = 100, font_size = 75, function_owner = self, color={0,1,1}, font_color={0,0,0}})
        -- printToAll("/begin desc",{1,1,1})
        -- printToAll(object.getDescription(),{1,1,1})
        -- printToAll("/end desc",{1,1,1})
        -- Custom|Ship|Large|mesh|diffuse|ruler|II|I,II|-,I,II
        local model_data = string.split(object.getDescription(),'\n',nil,false)
        local ship_data = {}
        -- printToAll(model_data[2],{1,1,1})
        -- printToAll(string.starts(model_data[2],"Ship"),{1,1,1})
        -- printToAll(model_data[3],{1,1,1})
        -- printToAll(string.starts(model_data[3],"Small"),{1,1,1})
        if string.strip(model_data[2])=="Ship" then
            local shields = {1,1,1,1}
            local defense_tokens = {}
            -- 7 will be shields (F,L,R,B)
            -- local shields = list(map(int,string:split(model_data[7],",",nil,false)))
            -- local defense_tokens = string:split(model_data[8],",",nil,false)
            -- 8 will be defense
            local maneuver = {}
            -- lolnope loadstring("maneuver = "..model_data[7])
            if table.contains({"I","II","-"},model_data[7]) then
                table.insert(maneuver,model_data[7]:strip():split(",",nil,false))
                if #model_data>7 then
                    table.insert(maneuver,model_data[8]:strip():split(",",nil,false))
                end
                if #model_data>8 then
                    table.insert(maneuver,model_data[9]:strip():split(",",nil,false))
                end
                if #model_data>9 then
                    table.insert(maneuver,model_data[10]:strip():split(",",nil,false))
                end
            else

                    -- 7 will be shields (F,L,R,B)
                shields = T(model_data[7]:strip():split(",",nil,false)):Select(|s| tonumber(s))
                defense_tokens = T(model_data[8]:strip():split(",",nil,false)):Select(|s| ALL_DEFENSE_TOKENS[s])
                table.insert(maneuver,model_data[9]:strip():split(",",nil,false))
                if #model_data>9 then
                    table.insert(maneuver,model_data[10]:strip():split(",",nil,false))
                end
                if #model_data>10 then
                    table.insert(maneuver,model_data[11]:strip():split(",",nil,false))
                end
                if #model_data>11 then
                    table.insert(maneuver,model_data[12]:strip():split(",",nil,false))
                end
                --TODO: Implement shield/defense tokens
            end
            ship_data = {
                name = object.getName(),
                cost = string.match(object.getName(),"[%s ]+%([%s ]*(%d+)[%s ]*%)$"),
                mesh = string.strip(model_data[4]),
                diffuse = string.strip(model_data[5]),
                ruler = string.strip(model_data[6]),
                maneuver = maneuver,
                defense_tokens = defense_tokens,
                shields = shields,
                convex = true,
                type = 1,
                material = 3,
                command = 1
            }
            if string.strip(model_data[3])=="Small" then
                ship_data.collider = SmallShip.collider
            elseif string.strip(model_data[3])=="Medium" then
                ship_data.collider = MediumShip.collider
            elseif string.strip(model_data[3])=="Large" then
                ship_data.collider = LargeShip.collider
            end
        elseif string.strip(model_data[2])=="Squadron" then
            -- Custom|Squadron|mesh|diffuse|health|move|defense_tokens
            defense_tokens = {}
            if #model_data>6 then
                defense_tokens = T(model_data[7]:strip():split(",",nil,false)):Select(|s| ALL_DEFENSE_TOKENS[s])
            end
            ship_data = {
                name = object.getName(),
                cost = string.match(object.getName(),"[%s ]+%([%s ]*(%d+)[%s ]*%)$"),
                mesh = string.strip(model_data[3]),
                diffuse = string.strip(model_data[4]),
                health =  string.strip(model_data[5]),
                move = string.strip(model_data[6]),
                collider = ASSETS_ROOT..'misc/bases/squad.obj', -- "http://paste.ee/r/ZKM7E", -- "http://paste.ee/r/nAMCQ",
                convex = false,
                type = 1,
                material = 1,
                defense_tokens = defense_tokens}
        end
        object.setTable('Custom',ship_data)
    end
end
function Action_Spawn(card)
    if card.getTable('Custom') != nil then
        printToAll("Spawning Custom Ship",{0,1,1})
        spawnDefinition(card.getTable('Custom'),card.getName(),card.getPosition(),1,card.getRotation()[2], card)
    else
        spawnShip(card.getName(),card.getPosition(),1,card.getRotation()[2],card)
    end
end
function Action_DoneSpawn(card)
    card.clearButtons()
end
function onload()
    self.interactable = false

----#include defs/rebel/ships
REBEL_SHIP = {
    back =      ASSETS_ROOT.."ships/rebel/card_back.jpg",
    faction = "Rebellion"
}
Ship:new(SmallShip,REBEL_SHIP,{
	name = "GR-75 Medium Transports",
    front =     ASSETS_ROOT.."ships/rebel/gr75/transport_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/gr75/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/gr75/transport_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/gr75/ruler.obj",
    maneuver = {{"II"},{"I","II"},{"-","I","II"}},
    defense_tokens = {DEF_SCATTER, DEF_EVADE},
    shields = {1,1,1,1},
    cost = 18,
    aliases = {},
    command = 1
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "GR-75 Combat Retrofits",
    front =     ASSETS_ROOT.."ships/rebel/gr75/combat_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/gr75/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/gr75/combat_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/gr75/ruler.obj",
    maneuver = {{"II"},{"I","II"},{"-","I","II"}},
    defense_tokens = {DEF_SCATTER, DEF_EVADE},
    shields = {1,1,1,1},
    cost = 24,
    aliases = {},
    command = 1
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "CR90 Corvette A",
    front =     ASSETS_ROOT.."ships/rebel/cr90/A_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/cr90/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/cr90/A_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/cr90/ruler.obj",
    maneuver = {{"II"},{"I","II"},{"-","I","II"},{"-","I","I","II"}},
    defense_tokens = {DEF_EVADE, DEF_EVADE, DEF_REDIRECT},
    shields = {2,2,2,1},
    cost = 44,
    aliases = {"CR90 A"},
    command = 1
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "CR90 Corvette B",
    front =     ASSETS_ROOT.."ships/rebel/cr90/B_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/cr90/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/cr90/B_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/cr90/ruler.obj",
    maneuver = {{"II"},{"I","II"},{"-","I","II"},{"-","I","I","II"}},
    defense_tokens = {DEF_EVADE, DEF_EVADE, DEF_REDIRECT},
    shields = {2,2,2,1},
    cost = 39,
    aliases = {"CR90 B"},
    command = 1
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "Nebulon-B Support Refit",
    front =     ASSETS_ROOT.."ships/rebel/nebulon/support_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/nebulon/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/nebulon/support_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/nebulon/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","II"}},
    defense_tokens = {DEF_EVADE, DEF_BRACE, DEF_BRACE},
    shields = {3,1,1,2},
    cost = 51,
    aliases = {},
    command = 2
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "Nebulon-B Escort Frigate",
    front =     ASSETS_ROOT.."ships/rebel/nebulon/escort_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/nebulon/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/nebulon/escort_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/nebulon/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","II"}},
    defense_tokens = {DEF_EVADE, DEF_BRACE, DEF_BRACE},
    shields = {3,1,1,2},
    cost = 57,
    aliases = {},
    command = 2
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "MC30c Scout Frigate",
    front =     ASSETS_ROOT.."ships/rebel/mc30/scout_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc30/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc30/scout_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc30/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","II"},{"-","I","I","-"}},
    defense_tokens = {DEF_EVADE, DEF_EVADE, DEF_REDIRECT, DEF_REDIRECT},
    shields = {3,3,3,2},
    cost = 69,
    aliases = {},
    command = 2
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "MC30c Torpedo Frigate",
    front =     ASSETS_ROOT.."ships/rebel/mc30/torpedo_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc30/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc30/torpedo_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc30/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","II"},{"-","I","I","-"}},
    defense_tokens = {DEF_EVADE, DEF_EVADE, DEF_REDIRECT, DEF_REDIRECT},
    shields = {3,3,3,2},
    cost = 63,
    aliases = {},
    command = 2
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "Modified Pelta-class Command Ship",
    front =     ASSETS_ROOT.."ships/rebel/pelta/command_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/pelta/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/pelta/command_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/pelta/ruler.obj",
    maneuver = {{"II"},{"I","I"}},
    defense_tokens = {DEF_EVADE, DEF_BRACE, DEF_REDIRECT},
    shields = {3,2,2,1},
    cost = 60,
    aliases = {"Modified Pelta Command Ship", "Pelta Command Ship"},
    command = 2
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "Modified Pelta-class Assault Ship",
    front =     ASSETS_ROOT.."ships/rebel/pelta/assault_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/pelta/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/pelta/assault_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/pelta/ruler.obj",
    maneuver = {{"II"},{"I","I"}},
    defense_tokens = {DEF_EVADE, DEF_BRACE, DEF_REDIRECT},
    shields = {3,2,2,1},
    cost = 56,
    aliases = {"Modified Pelta Assault Ship", "Pelta Assault Ship"},
    command = 2
})

Ship:new(SmallShip,REBEL_SHIP,{
	name = "Hammerhead Scout Corvette",
    front =     ASSETS_ROOT.."ships/rebel/hammerhead/scout_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/hammerhead/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/hammerhead/scout_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/hammerhead/ruler.obj",
    maneuver = {{"II"},{"II","I"},{"I","I","-"}},
    defense_tokens = {DEF_EVADE, DEF_REDIRECT, DEF_CONTAIN},
    shields = {2,1,1,1},
    cost = 41,
    aliases = {},
    command = 1
})
Ship:new(SmallShip,REBEL_SHIP,{
	name = "Hammerhead Torpedo Corvette",
    front =     ASSETS_ROOT.."ships/rebel/hammerhead/torpedo_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/hammerhead/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/hammerhead/torpedo_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/hammerhead/ruler.obj",
    maneuver = {{"II"},{"II","I"},{"I","I","-"}},
    defense_tokens = {DEF_EVADE, DEF_REDIRECT, DEF_CONTAIN},
    shields = {2,1,1,1},
    cost = 36,
    aliases = {},
    command = 1
})

Ship:new(MediumShip,REBEL_SHIP,{
	name = "Assault Frigate Mark II A",
    front =     ASSETS_ROOT.."ships/rebel/afm2/A_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/afm2/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/afm2/A_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/afm2/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_EVADE, DEF_BRACE, DEF_REDIRECT},
    shields = {4,3,3,2},
    cost = 81,
    aliases = {"Assault Frigate Mk.II A","Assault Frigate MkII A","Assault Frigate Mk2 A"},
    command = 3
})
Ship:new(MediumShip,REBEL_SHIP,{
	name = "Assault Frigate Mark II B",
    front =     ASSETS_ROOT.."ships/rebel/afm2/B_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/afm2/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/afm2/B_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/afm2/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_EVADE, DEF_BRACE, DEF_REDIRECT},
    shields = {4,3,3,2},
    cost = 72,
    aliases = {"Assault Frigate Mk.II B","Assault Frigate MkII B","Assault Frigate Mk2 B"},
    command = 3
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "MC80 Command Cruiser",
    front =     ASSETS_ROOT.."ships/rebel/mc80/command_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc80/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc80/command_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc80/ruler.obj",
    maneuver = {{"I"},{"I","I"}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_REDIRECT, DEF_CONTAIN},
    shields = {4,4,4,3},
    cost = 106,
    command = 3
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "MC80 Assault Cruiser",
    front =     ASSETS_ROOT.."ships/rebel/mc80/assault_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc80/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc80/assault_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc80/ruler.obj",
    maneuver = {{"I"},{"I","I"}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_REDIRECT, DEF_CONTAIN},
    shields = {4,4,4,3},
    cost = 114,
    aliases = {},
    command = 3
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "MC80 Star Cruiser",
    front =     ASSETS_ROOT.."ships/rebel/mc80l/star_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc80l/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc80l/star_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc80l/ruler.obj",
    maneuver = {{"I"},{"I","-"},{"I","-","I"}},
    defense_tokens = {DEF_BRACE, DEF_BRACE, DEF_REDIRECT},
    shields = {5,2,2,2},
    cost = 96,
    aliases = {},
    command = 3
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "MC80 Battle Cruiser",
    front =     ASSETS_ROOT.."ships/rebel/mc80l/battle_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc80l/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc80l/battle_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc80l/ruler.obj",
    maneuver = {{"I"},{"I","-"},{"I","-","I"}},
    defense_tokens = {DEF_BRACE, DEF_BRACE, DEF_REDIRECT},
    shields = {5,2,2,2},
    cost = 103,
    aliases = {},
    command = 3
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "MC75 Ordnance Cruiser",
    front =     ASSETS_ROOT.."ships/rebel/mc75/ordnance_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc75/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc75/ordnance_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc75/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_CONTAIN, DEF_CONTAIN},
    shields = {4,3,3,3},
    cost = 100,
    aliases = {},
    command = 3
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "MC75 Armored Cruiser",
    front =     ASSETS_ROOT.."ships/rebel/mc75/armored_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/mc75/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/mc75/armored_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/mc75/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_CONTAIN, DEF_CONTAIN},
    shields = {4,3,3,3},
    cost = 104,
    aliases = {},
    command = 3
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "Starhawk-class Battleship Mark I",
    front =     ASSETS_ROOT.."ships/rebel/starhawk/I_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/starhawk/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/starhawk/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/starhawk/ruler.obj",
    maneuver = {{"I"},{"I","I"}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_CONTAIN, DEF_SALVO},
    shields = {6,4,4,2},
    cost = 140,
    aliases = {"Starhawk Battleship Mark I", "Starhawk-class Battleship Mk.I", "Starhawk-class Battleship MkI", "Starhawk-class Mk.I", "Starhawk-class MkI"},
    command = 4
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "Starhawk-class Battleship Mark II",
    front =     ASSETS_ROOT.."ships/rebel/starhawk/II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/rebel/starhawk/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/starhawk/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/rebel/starhawk/ruler.obj",
    maneuver = {{"I"},{"I","I"}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_CONTAIN, DEF_SALVO},
    shields = {6,4,4,2},
    cost = 150,
    aliases = {"Starhawk Battleship Mark II", "Starhawk-class Battleship Mk.II", "Starhawk-class Battleship MkII", "Starhawk-class Mk.II", "Starhawk-class MkII"},
    command = 4
})
Ship:new(LargeShip,REBEL_SHIP,{
	name = "Providence-class Carrier",
    front =     ASSETS_ROOT.."ships/rebel/providence/carrier_card.jpg",
    -- back =      ASSETS_ROOT.."ships/rebel/providence/carrier_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/providence/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/rebel/providence/carrier_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/providence/ruler.obj",
    maneuver = {{"I"},{"I","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_SALVO,DEF_EVADE},
    shields = {5,3,3,2},
    cost = 95,
	aliases = {"Providence Carrier", "Providence-class Carrier (reb)","Providence Carrier (reb)"},
    command = 3
})

----#include defs/rebel/ships
----#include defs/empire/ships
EMPIRE_SHIP = {
    back = ASSETS_ROOT.."ships/empire/card_back.jpg",
    faction = "Empire"
}
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Gozanti-class Cruisers",
    front =     ASSETS_ROOT.."ships/empire/gozanti/cruiser_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/gozanti/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/gozanti/cruiser_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/gozanti/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"I","I","-"}},
    defense_tokens = {DEF_SCATTER, DEF_EVADE},
    shields = {1,1,1,1},
    cost = 23,
    aliases = {"Gozanti Cruisers"},
    command = 1
})
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Gozanti-class Assault Carriers",
    front =     ASSETS_ROOT.."ships/empire/gozanti/assault_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/gozanti/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/gozanti/assault_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/gozanti/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"I","I","-"}},
    defense_tokens = {DEF_SCATTER, DEF_EVADE},
    shields = {1,1,1,1},
    cost = 28,
    aliases = {"Gozanti Assault Carriers"},
    command = 1
})
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Raider I-class Corvette",
    front =     ASSETS_ROOT.."ships/empire/raider/I_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/raider/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/raider/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/raider/ruler.obj",
    maneuver = {{"II"},{"II","II"},{"-","I","I"},{"-","I","I","I"}},
    defense_tokens = {DEF_EVADE,DEF_EVADE,DEF_BRACE},
    shields = {2,2,2,2},
    cost = 44,
    aliases = {"Raider I","Raider I Corvette"},
    command = 1
})
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Raider II-class Corvette",
    front =     ASSETS_ROOT.."ships/empire/raider/II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/raider/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/raider/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/raider/ruler.obj",
    maneuver = {{"II"},{"II","II"},{"-","I","I"},{"-","I","I","I"}},
    defense_tokens = {DEF_EVADE,DEF_EVADE,DEF_BRACE},
    shields = {2,2,2,2},
    cost = 48,
    aliases = {"Raider II","Raider II Corvette"},
    command = 1
})
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Gladiator I-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/empire/gladiator/I_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/gladiator/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/gladiator/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/gladiator/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT},
    shields = {3,2,2,1},
    cost = 56,
    aliases = {"Gladiator I","Gladiator I Star Destroyer"},
    command = 2
})
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Gladiator II-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/empire/gladiator/II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/gladiator/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/gladiator/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/gladiator/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT},
    shields = {3,2,2,1},
    cost = 62,
    aliases = {"Gladiator II","Gladiator II Star Destroyer"},
    command = 2
})
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Arquitens-class Light Cruiser",
    front =     ASSETS_ROOT.."ships/empire/arquitens/light_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/arquitens/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/arquitens/light_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/arquitens/ruler.obj",
    maneuver = {{"II"},{"-","II"},{"-","-","II"}},
    defense_tokens = {DEF_EVADE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN},
    shields = {2,2,2,2},
    cost = 54,
    aliases = {"Arquitens Light Cruiser"},
    command = 2
})
Ship:new(SmallShip,EMPIRE_SHIP,{
	name = "Arquitens-class Command Cruiser",
    front =     ASSETS_ROOT.."ships/empire/arquitens/command_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/arquitens/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/arquitens/command_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/arquitens/ruler.obj",
    maneuver = {{"II"},{"-","II"},{"-","-","II"}},
    defense_tokens = {DEF_EVADE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN},
    shields = {2,2,2,2},
    cost = 59,
    aliases = {"Arquitens Command Cruiser"},
    command = 2
    --maneuver = "II|-,II|-,-,II"
})
Ship:new(MediumShip,EMPIRE_SHIP,{
	name = "Victory I-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/empire/victory/I_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/victory/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/victory/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/victory/ruler.obj",
    maneuver = {{"I"},{"-","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT},
    shields = {3,3,3,1},
    cost = 73,
    aliases = {"Victory I Star Destroyer","Victory I", "VSD I", "VSD 1"},
    command = 3
})
Ship:new(MediumShip,EMPIRE_SHIP,{
	name = "Victory II-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/empire/victory/II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/victory/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/victory/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/victory/ruler.obj",
    maneuver = {{"I"},{"-","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT},
    shields = {3,3,3,1},
    cost = 85,
    aliases = {"Victory II Star Destroyer","Victory II", "VSD II", "VSD 2"},
    command = 3
})
Ship:new(MediumShip,EMPIRE_SHIP,{
	name = "Interdictor Suppression Refit",
    front =     ASSETS_ROOT.."ships/empire/interdictor/suppression_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/interdictor/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/interdictor/suppression_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/interdictor/ruler.obj",
    maneuver = {{"I"},{"I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_CONTAIN,DEF_CONTAIN},
    shields = {3,2,2,2},
    cost = 90,
    aliases = {"Interdictor-class Suppression Refit"},
    command = 2
})
Ship:new(MediumShip,EMPIRE_SHIP,{
	name = "Interdictor Combat Refit",
    front =     ASSETS_ROOT.."ships/empire/interdictor/combat_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/interdictor/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/interdictor/combat_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/interdictor/ruler.obj",
    maneuver = {{"I"},{"I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_CONTAIN,DEF_CONTAIN},
    shields = {3,2,2,2},
    cost = 93,
    aliases = {"Interdictor-class Combat Refit"},
    command = 2
})
Ship:new(MediumShip,EMPIRE_SHIP,{
	name = "Quasar Fire I-class Cruiser-Carrier",
    front =     ASSETS_ROOT.."ships/empire/quasar/I_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/quasar/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/quasar/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/quasar/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT},
    shields = {2,2,2,1},
    cost = 54,
    aliases = {"Quasar Fire I Cruiser-Carrier","Quasar Fire I", "Quasar I"},
    command = 2
})
Ship:new(MediumShip,EMPIRE_SHIP,{
	name = "Quasar Fire II-class Cruiser-Carrier",
    front =     ASSETS_ROOT.."ships/empire/quasar/II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/quasar/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/quasar/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/quasar/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT},
    shields = {2,2,2,1},
    cost = 61,
    aliases = {"Quasar Fire II Cruiser-Carrier","Quasar Fire II", "Quasar II"},
    command = 2
})

Ship:new(LargeShip,EMPIRE_SHIP,{
	name = "Imperial I-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/empire/imperial/I_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/imperial/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/imperial/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/imperial/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN},
    shields = {4,3,3,2},
    cost = 110,
    aliases = {"Imperial I Star Destroyer","Imperial I", "ISD I", "ISD 1"},
    command = 3
})
Ship:new(LargeShip,EMPIRE_SHIP,{
	name = "Imperial Star Destroyer Kuat Refit",
    front =     ASSETS_ROOT.."ships/empire/imperial/kuat_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/imperial/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/imperial/kuat_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/imperial/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN},
    shields = {4,3,3,2},
    cost = 112,
    aliases = {"Imperial Kuat Refit","Kuat Refit", "ISD Kuat Refit"},
    command = 3
})
Ship:new(LargeShip,EMPIRE_SHIP,{
	name = "Imperial II-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/empire/imperial/II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/imperial/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/imperial/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/imperial/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN},
    shields = {4,3,3,2},
    cost = 120,
    aliases = {"Imperial II Star Destroyer","Imperial II", "ISD II", "ISD 2"},
    command = 3
})
Ship:new(LargeShip,EMPIRE_SHIP,{
	name = "Imperial Star Destroyer Cymoon 1 Refit",
    front =     ASSETS_ROOT.."ships/empire/imperial/cymoon_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/imperial/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/imperial/cymoon_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/imperial/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN},
    shields = {4,3,3,2},
    cost = 112,
    aliases = {"Imperial Cymoon 1 Refit","Cymoon 1 Refit", "ISD Cymoon 1 Refit", "ISD Cymoon"},
    command = 3
})

Ship:new(HugeShip,EMPIRE_SHIP,{
	name = "Star Dreadnought Command Prototype",
    front =     ASSETS_ROOT.."ships/empire/ssd/command_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/ssd/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/ssd/command_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/ssd/ruler.obj",
    maneuver = {{"-"},{"-","-"}},
    defense_tokens = {DEF_BRACE,DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN,DEF_CONTAIN},
    shields = {6,3,3,2,3,3},
    cost = 220,
    aliases = {"SSD Command Prototype","Command Prototype"},
    command = 4,
    hull = 22
})
Ship:new(HugeShip,EMPIRE_SHIP,{
	name = "Star Dreadnought Assault Prototype",
    front =     ASSETS_ROOT.."ships/empire/ssd/assault_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/ssd/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/ssd/assault_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/ssd/ruler.obj",
    maneuver = {{"-"},{"-","-"}},
    defense_tokens = {DEF_BRACE,DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN,DEF_CONTAIN},
    shields = {6,3,3,2,3,3},
    cost = 250,
    aliases = {"SSD Assault Prototype","Assault Prototype"},
    command = 4,
    hull = 22
})
Ship:new(HugeShip,EMPIRE_SHIP,{
	name = "Executor I-class Star Dreadnought",
    front =     ASSETS_ROOT.."ships/empire/ssd/executor_I_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/ssd/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/ssd/executor_I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/ssd/ruler.obj",
    maneuver = {{"-"},{"-","-"}},
    defense_tokens = {DEF_BRACE,DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN,DEF_CONTAIN},
    shields = {6,5,5,3,5,5},
    cost = 381,
    aliases = {"Executor I Star Dreadnought", "Executor I SSD","Executor I"},
    command = 4,
    hull = 33
})
Ship:new(HugeShip,EMPIRE_SHIP,{
	name = "Executor II-class Star Dreadnought",
    front =     ASSETS_ROOT.."ships/empire/ssd/executor_II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/ssd/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/ssd/executor_II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/ssd/ruler.obj",
    maneuver = {{"-"},{"-","-"}},
    defense_tokens = {DEF_BRACE,DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_CONTAIN,DEF_CONTAIN},
    shields = {6,5,5,3,5,5},
    cost = 411,
    aliases = {"Executor II Star Dreadnought", "Executor II SSD","Executor II"},
    command = 4,
    hull = 33
})
Ship:new(LargeShip,EMPIRE_SHIP,{
	name = "Onager-class Testbed",
    front =     ASSETS_ROOT.."ships/empire/onager/testbed_card_v2_1.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/onager/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/onager/testbed_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/onager/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"I","I",'-'}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_SALVO},
    shields = {5,2,2,1},
    cost = 116,
    aliases = {"Onager Testbed"},
    command = 3
})
Ship:new(LargeShip,EMPIRE_SHIP,{
	name = "Onager-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/empire/onager/sd_card_v2_1.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/onager/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/onager/sd_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/onager/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"I","I",'-'}},
    defense_tokens = {DEF_BRACE, DEF_REDIRECT, DEF_SALVO},
    shields = {5,2,2,1},
    cost = 120,
    aliases = {"Onager Star Destroyer"},
    command = 3
})
Ship:new(LargeShip,EMPIRE_SHIP,{
	name = "Venator II-class Star Destroyer (imp)",
    front =     ASSETS_ROOT.."ships/empire/venator/II_card.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/venator/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/empire/venator/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/venator/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_CONTAIN,DEF_SALVO},
    shields = {4,3,3,2},
    cost = 100,
	aliases = {"Venator II Star Destroyer (imp)", "Venator II (imp)"},
    command = 3
})

----#include defs/empire/ships
    local ship = nil

----#include defs/rebel/squadrons
REBEL_SQUAD = {
    back =      ASSETS_ROOT.."squadrons/rebel/card_back.jpg",
    faction = "Rebellion"
}
bwing = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/bwing/bo_model.obj",
    health = 5,
    move = 2,
    defense_tokens = {}}
Squadron:new(bwing, REBEL_SQUAD, {
	name = "B-wing Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/bwing/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/bwing/base_diffuse.jpg",
    cost = 14,
    aliases = {'B-wing Squadrons', "B-wing"}
})
Squadron:new(bwing, REBEL_SQUAD, {
	name = "Keyan Farlander",
    front =     ASSETS_ROOT.."squadrons/rebel/bwing/keyan_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/bwing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 20
})
Squadron:new(bwing, REBEL_SQUAD, {
	name = "Ten Numb",
    front =     ASSETS_ROOT.."squadrons/rebel/bwing/ten_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/bwing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 19
})
Squadron:new(bwing, REBEL_SQUAD, {
	name = "Dagger Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/bwing/dagger_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/bwing/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/bwing/bo_sw_model.obj",
    cost = 15
})
ywing = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/ywing/bo_he_model.obj",
    health = 6,
    move = 3,
    defense_tokens = {}}
Squadron:new(ywing, REBEL_SQUAD, {
	name = "Y-wing Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/ywing/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/ywing/base_diffuse.jpg",
    cost = 10,
    aliases = {'Y-wing Squadrons', "Y-wing"}
})
Squadron:new(ywing, REBEL_SQUAD, {
	name = '"Dutch" Vander',
    front =     ASSETS_ROOT.."squadrons/rebel/ywing/dutch_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/ywing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 16,
    aliases = {"Dutch Vander"}
})
Squadron:new(ywing, REBEL_SQUAD, {
	name = 'Norra Wexley',
    front =     ASSETS_ROOT.."squadrons/rebel/ywing/norra_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/ywing/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/ywing/bo_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 17
})
Squadron:new(ywing, REBEL_SQUAD, {
	name = 'Gold Squadron',
    front =     ASSETS_ROOT.."squadrons/rebel/ywing/gold_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/ywing/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/ywing/bo_model.obj",
    cost = 12
})
awing = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/awing/co_model.obj",
    health = 4,
    move = 5,
    defense_tokens = {}}
Squadron:new(awing, REBEL_SQUAD, {
	name = "A-wing Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/awing/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/awing/base_diffuse.jpg",
    cost = 11,
    aliases = {'A-wing Squadrons', "A-wing"}
})
Squadron:new(awing, REBEL_SQUAD, {
	name = "Tycho Celchu",
    front =     ASSETS_ROOT.."squadrons/rebel/awing/tycho_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/awing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 16
})
Squadron:new(awing, REBEL_SQUAD, {
	name = "Shara Bey",
    front =     ASSETS_ROOT.."squadrons/rebel/awing/shara_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/awing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 17
})
Squadron:new(awing, REBEL_SQUAD, {
	name = "Green Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/awing/green_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/awing/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/awing/bo_co_model.obj",
    cost = 12
})
xwing = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/xwing/bo_es_model.obj",
    health = 5,
    move = 3,
    defense_tokens = {}}
Squadron:new(xwing, REBEL_SQUAD, {
	name = "X-wing Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/xwing/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/xwing/base_diffuse.jpg",
    cost = 13,
    aliases = {'X-wing Squadrons', "X-wing"}
})
Squadron:new(xwing, REBEL_SQUAD, {
	name = "Luke Skywalker",
    front =     ASSETS_ROOT.."squadrons/rebel/xwing/luke_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/xwing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 20
})
Squadron:new(xwing, REBEL_SQUAD, {
	name = "Wedge Antilles",
    front =     ASSETS_ROOT.."squadrons/rebel/xwing/wedge_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/xwing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 19
})
Squadron:new(xwing, REBEL_SQUAD, {
	name = "Biggs Darklighter",
    front =     ASSETS_ROOT.."squadrons/rebel/xwing/biggs_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/xwing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 19
})
Squadron:new(xwing, REBEL_SQUAD, {
	name = "Hera Syndulla",
    front =     ASSETS_ROOT.."squadrons/rebel/xwing/hera_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/xwing/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/xwing/bo_do_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 23,
    aliases = {'Hera Syndulla (xwing)','Hera Syndulla (X-wing)'}
})
Squadron:new(xwing, REBEL_SQUAD, {
	name = "Rogue Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/xwing/rogue_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/xwing/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/xwing/bo_ro_model.obj",
    cost = 14
})
yt2400 = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/yt2400/ro_model.obj",
    health = 6,
    move = 4,
    defense_tokens = {}}
Squadron:new(yt2400, REBEL_SQUAD, {
	name = "YT-2400",
    front =     ASSETS_ROOT.."squadrons/rebel/yt2400/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/yt2400/base_diffuse.jpg",
    cost = 16,
    aliases = {'YT-2400s'}
})
Squadron:new(yt2400, REBEL_SQUAD, {
	name = "Dash Rendar",
    front =     ASSETS_ROOT.."squadrons/rebel/yt2400/dash_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/yt2400/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/yt2400/bo_ro_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 24
})
Squadron:new(yt2400, REBEL_SQUAD, {
	name = "Mart Mattin",
    front =     ASSETS_ROOT.."squadrons/rebel/yt2400/mart_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/yt2400/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/yt2400/gr_ro_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 22
})
yt1300 = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/yt1300/co_es_model.obj",
    health = 7,
    move = 2,
    defense_tokens = {}}
Squadron:new(yt1300, REBEL_SQUAD, {
	name = "YT-1300",
    front =     ASSETS_ROOT.."squadrons/rebel/yt1300/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/yt1300/base_diffuse.jpg",
    cost = 13,
    aliases = {'YT-1300s'}
})
Squadron:new(yt1300, REBEL_SQUAD, {
	name = "Han Solo",
    front =     ASSETS_ROOT.."squadrons/rebel/yt1300/han_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/yt1300/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/yt1300/gr_ro_model.obj",
    move = 3,
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 26
})
Squadron:new(yt1300, REBEL_SQUAD, {
	name = "Lando Calrissian",
    front =     ASSETS_ROOT.."squadrons/rebel/yt1300/lando_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/yt1300/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/yt1300/gr_ro_model.obj",
    move = 3,
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 23
})
hwk = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/hwk/co_in_model.obj",
    health = 4,
    move = 3,
    defense_tokens = {}}
Squadron:new(hwk, REBEL_SQUAD, {
	name = "HWK-290",
    front =     ASSETS_ROOT.."squadrons/rebel/hwk/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/hwk/base_diffuse.jpg",
    cost = 12,
    aliases = {'HWK-290s'}
})
Squadron:new(hwk, REBEL_SQUAD, {
	name = "Jan Ors",
    front =     ASSETS_ROOT.."squadrons/rebel/hwk/jan_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/hwk/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 19
})
Squadron:new(hwk, REBEL_SQUAD, {
	name = "Kanan Jarrus",
    front =     ASSETS_ROOT.."squadrons/rebel/hwk/kanan_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/hwk/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/hwk/as_cl_ro_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 19
})
scurrg = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/scurrg/bo_gr_he_model.obj",
    health = 6,
    move = 3 }
Squadron:new(scurrg, REBEL_SQUAD, {
	name = "Scurrg H-6 Bomber",
    front =     ASSETS_ROOT.."squadrons/rebel/scurrg/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/scurrg/base_diffuse.jpg",
    cost = 16,
    aliases = {'Scurrg H-6 Bombers', "Scurrg H-6", "Scurrg"}
})
Squadron:new(scurrg, REBEL_SQUAD, {
	name = "Nym",
    front =     ASSETS_ROOT.."squadrons/rebel/scurrg/nym_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/scurrg/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/scurrg/bo_gr_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 21
})
Squadron:new(scurrg, REBEL_SQUAD, {
	name = "Malee Hurra",
    front =     ASSETS_ROOT.."squadrons/rebel/scurrg/malee_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/scurrg/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/scurrg/bo_gr_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 26
})
z95 = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/z95/sw_model.obj",
    health = 3,
    move = 3,
    defense_tokens = {}}
Squadron:new(z95, REBEL_SQUAD, {
	name = "Z-95 Headhunter Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/z95/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/z95/base_diffuse.jpg",
    cost = 7,
    aliases = {'Z-95 Headhunter Squadrons', "Z-95 Headhunter", "Z-95"}
})
Squadron:new(z95, REBEL_SQUAD, {
	name = "Lieutenant Blount",
    front =     ASSETS_ROOT.."squadrons/rebel/z95/blount_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/z95/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 14,
    aliases = {'Lietenant Blount'}
})
ewing = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/ewing/bo_sn_model.obj",
    health = 5,
    move = 4,
    defense_tokens = {}}
Squadron:new(ewing, REBEL_SQUAD, {
	name = "E-wing Squadron",
    front =     ASSETS_ROOT.."squadrons/rebel/ewing/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/ewing/base_diffuse.jpg",
    cost = 15,
    aliases = {'E-wing Squadrons', "E-wing"}
})
Squadron:new(ewing, REBEL_SQUAD, {
	name = "Corran Horn",
    front =     ASSETS_ROOT.."squadrons/rebel/ewing/corran_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/ewing/ace_diffuse.jpg",
        mesh =      ASSETS_ROOT.."squadrons/rebel/ewing/bo_ro_sn_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 22
})
vcx = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/vcx/he_re_st_model.obj",
    health = 8,
    move = 3,
    defense_tokens = {}}
Squadron:new(vcx, REBEL_SQUAD, {
	name = "VCX-100 Freighter",
    front =     ASSETS_ROOT.."squadrons/rebel/vcx/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/vcx/base_diffuse.jpg",
    cost = 15,
    aliases = {'VCX-100 Freighters', "VCX-100"}
})
Squadron:new(vcx, REBEL_SQUAD, {
	name = "Hera Syndulla",
    front =     ASSETS_ROOT.."squadrons/rebel/vcx/hera_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/vcx/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/rebel/vcx/gr_ro_model.obj",
    defense_tokens = {DEF_BRACE},
    cost = 28,
    aliases = {'Hera Syndulla (Ghost)'}
})
lancer = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/lancer/bo_gr_ro_model.obj",
    health = 4,
    move = 4,
    defense_tokens = {}}
Squadron:new(lancer, REBEL_SQUAD, {
	name = "Lancer-class Pursuit Craft",
    front =     ASSETS_ROOT.."squadrons/rebel/lancer/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/lancer/base_diffuse.jpg",
    cost = 15,
    aliases = {"Lancer Pursuit Craft","Lancer Pursuit Crafts","Lancer-class Pursuit Crafts","Lancer"}
})
Squadron:new(lancer, REBEL_SQUAD, {
	name = "Ketsu Onyo",
    front =     ASSETS_ROOT.."squadrons/rebel/lancer/ketsu_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/lancer/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 22
})

gauntlet = {
    mesh =      ASSETS_ROOT.."squadrons/rebel/guantlet/as_es_model.obj",
    health = 7,
    move = 4,
    defense_tokens = {}}
Squadron:new(gauntlet, REBEL_SQUAD, {
	name = 'Fenn Rau',
    front =     ASSETS_ROOT.."squadrons/rebel/guantlet/fenn_card_v2_1.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/rebel/guantlet/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE},
    cost = 24
})

----#include defs/rebel/squadrons
----#include defs/empire/squadrons
EMPIRE_SQUAD = {
    back = ASSETS_ROOT.."squadrons/empire/card_back.jpg",
    faction = "Empire"
}
tie = {
    mesh =      ASSETS_ROOT.."squadrons/empire/tie/sw_model.obj",
    health = 3,
    move = 4,
    defense_tokens = {}}
Squadron:new(tie, EMPIRE_SQUAD, {
	name = "TIE Fighter Squadron",
    front =     ASSETS_ROOT.."squadrons/empire/tie/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/tie/base_diffuse.jpg",
    cost = 8,
    aliases = {"TIE Fighter Squadrons", "TIE Fighter"}
})
Squadron:new(tie, EMPIRE_SQUAD, {
	name = '"Mauler" Mithel',
    front =     ASSETS_ROOT.."squadrons/empire/tie/mauler_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/tie/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 15,
    aliases = {"Mauler Mithel"}
})
Squadron:new(tie, EMPIRE_SQUAD, {
	name = '"Howlrunner"',
    front =     ASSETS_ROOT.."squadrons/empire/tie/howlrunner_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/tie/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 16,
    aliases = {"Howlrunner"}
})
Squadron:new(tie, EMPIRE_SQUAD, {
	name = 'Valen Rudor',
    front =     ASSETS_ROOT.."squadrons/empire/tie/valen_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/tie/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 13
})
Squadron:new(tie, EMPIRE_SQUAD, {
	name = 'Black Squadron',
    front =     ASSETS_ROOT.."squadrons/empire/tie/black_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/tie/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/tie/co_es_model.obj",
    cost = 9
})
int = {
    mesh =      ASSETS_ROOT.."squadrons/empire/int/co_sw_model.obj",
    health = 3,
    move = 5,
    defense_tokens = {}}
Squadron:new(int, EMPIRE_SQUAD, {
	name = "TIE Interceptor Squadron",
    front =     ASSETS_ROOT.."squadrons/empire/int/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/int/base_diffuse.jpg",
    cost = 11,
    aliases = {"TIE Interceptor Squadrons", "TIE Interceptor"}
})
Squadron:new(int, EMPIRE_SQUAD, {
	name = "Soontir Fel",
    front =     ASSETS_ROOT.."squadrons/empire/int/soontir_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/int/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 18
})
Squadron:new(int, EMPIRE_SQUAD, {
	name = "Ciena Ree",
    front =     ASSETS_ROOT.."squadrons/empire/int/ciena_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/int/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 17
})
Squadron:new(int, EMPIRE_SQUAD, {
	name = "Vult Skerris",
    front =     ASSETS_ROOT.."squadrons/empire/int/vult_card_v2_1.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/int/ace_diffuse.jpg",
    defense_tokens = {DEF_SCATTER,DEF_BRACE},
    cost = 18
})
Squadron:new(int, EMPIRE_SQUAD, {
	name = "Saber Squadron",
    front =     ASSETS_ROOT.."squadrons/empire/int/saber_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/int/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/int/sn_sw_model.obj",
    cost = 12
})
bom = {
    mesh =      ASSETS_ROOT.."squadrons/empire/bom/bo_he_model.obj",
    health = 5,
    move = 4,
    defense_tokens = {}}
Squadron:new(bom, EMPIRE_SQUAD, {
	name = "TIE Bomber Squadron",
    front =     ASSETS_ROOT.."squadrons/empire/bom/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/bom/base_diffuse.jpg",
    cost = 9,
    aliases = {"TIE Bomber Squadrons", "TIE Bomber"}
})
Squadron:new(bom, EMPIRE_SQUAD, {
	name = "Major Rhymer",
    front =     ASSETS_ROOT.."squadrons/empire/bom/rhymer_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/bom/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 16
})
Squadron:new(bom, EMPIRE_SQUAD, {
	name = "Captain Jonus",
    front =     ASSETS_ROOT.."squadrons/empire/bom/jonus_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/bom/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/bom/bo_gr_he_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 16
})
Squadron:new(bom, EMPIRE_SQUAD, {
	name = "Gamma Squadron",
    front =     ASSETS_ROOT.."squadrons/empire/bom/gamma_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/bom/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/bom/bo_gr_model.obj",
    cost = 10
})
adv = {
    mesh =      ASSETS_ROOT.."squadrons/empire/adv/es_model.obj",
    health = 5,
    move = 4,
    defense_tokens = {}}
Squadron:new(adv, EMPIRE_SQUAD, {
	name = "TIE Advanced Squadron",
    front =     ASSETS_ROOT.."squadrons/empire/adv/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/adv/base_diffuse.jpg",
    cost = 12,
    aliases = {"TIE Advanced Squadrons", "TIE Advanced"}
})
Squadron:new(adv, EMPIRE_SQUAD, {
	name = "Darth Vader",
    front =     ASSETS_ROOT.."squadrons/empire/adv/vader_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/adv/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 21,
    aliases = {'Darth Vader (TIE Advanced)'}
})
Squadron:new(adv, EMPIRE_SQUAD, {
	name = "Zertik Strom",
    front =     ASSETS_ROOT.."squadrons/empire/adv/zertik_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/adv/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 15
})
Squadron:new(adv, EMPIRE_SQUAD, {
	name = "Tempest Squadron",
    front =     ASSETS_ROOT.."squadrons/empire/adv/tempest_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/adv/unique_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/adv/bo_es_model.obj",
    cost = 13
})
firespray = {
    mesh =      ASSETS_ROOT.."squadrons/empire/firespray/bo_ro_model.obj",
    health = 6,
    move = 3,
    defense_tokens = {}}
Squadron:new(firespray, EMPIRE_SQUAD, {
	name = "Firespray-31",
    front =     ASSETS_ROOT.."squadrons/empire/firespray/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/firespray/base_diffuse.jpg",
    cost = 18,
    aliases = {"Firespray-31s"}
})
Squadron:new(firespray, EMPIRE_SQUAD, {
	name = "Boba Fett",
    front =     ASSETS_ROOT.."squadrons/empire/firespray/fett_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/firespray/fett_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 26
})
Squadron:new(firespray, EMPIRE_SQUAD, {
	name = "Hondo Ohnaka",
    front =     ASSETS_ROOT.."squadrons/empire/firespray/hondo_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/firespray/fett_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/firespray/bo_gr_ro_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 24
})
jumpmaster = {
    mesh =      ASSETS_ROOT.."squadrons/empire/jumpmaster/in_sw_model.obj",
    health = 4,
    move = 4 }
Squadron:new(jumpmaster, EMPIRE_SQUAD, {
	name = "JumpMaster 5000",
    front =     ASSETS_ROOT.."squadrons/empire/jumpmaster/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/jumpmaster/base_diffuse.jpg",
    cost = 12,
    aliases = {"JumpMaster 5000s"}
})
Squadron:new(jumpmaster, EMPIRE_SQUAD, {
	name = "Dengar",
    front =     ASSETS_ROOT.."squadrons/empire/jumpmaster/dengar_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/jumpmaster/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 20
})
Squadron:new(jumpmaster, EMPIRE_SQUAD, {
	name = "Tel Trevura",
    front =     ASSETS_ROOT.."squadrons/empire/jumpmaster/tel_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/jumpmaster/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/jumpmaster/gr_ro_model.obj",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 17
})
aggressor = {
    mesh =      ASSETS_ROOT.."squadrons/empire/aggressor/co_ro_model.obj",
    health = 5,
    move = 3,
    defense_tokens = {}}
Squadron:new(aggressor, EMPIRE_SQUAD, {
	name = "Aggressor Assault Fighter",
    front =     ASSETS_ROOT.."squadrons/empire/aggressor/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/aggressor/base_diffuse.jpg",
    cost = 16,
    aliases = {"Aggressor Assault Fighters"}
})
Squadron:new(aggressor, EMPIRE_SQUAD, {
	name = "IG-88",
    front =     ASSETS_ROOT.."squadrons/empire/aggressor/ig88_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/aggressor/ace_diffuse.jpg",
    move = 5,
    defense_tokens = {DEF_SCATTER},
    cost = 21
})
Squadron:new(aggressor, EMPIRE_SQUAD, {
	name = "IG-88B",
    front =     ASSETS_ROOT.."squadrons/empire/aggressor/ig88b_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/aggressor/ace_diffuse.jpg",
    move = 5,
    defense_tokens = {DEF_SCATTER},
    cost = 21
})
yv666 = {
    mesh =      ASSETS_ROOT.."squadrons/empire/yv666/gr_he_ro_model.obj",
    health = 7,
    move = 2,
    defense_tokens = {}}
Squadron:new(yv666, EMPIRE_SQUAD, {
	name = "YV-666",
    front =     ASSETS_ROOT.."squadrons/empire/yv666/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/yv666/base_diffuse.jpg",
    cost = 15,
    aliases = {"YV-666s"}
})
Squadron:new(yv666, EMPIRE_SQUAD, {
	name = "Bossk",
    front =     ASSETS_ROOT.."squadrons/empire/yv666/bossk_card.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/yv666/gr_ro_model.obj",
    diffuse =   ASSETS_ROOT.."squadrons/empire/yv666/ace_diffuse.jpg",
    move = 3,
    defense_tokens = {DEF_BRACE},
    cost = 23
})
Squadron:new(yv666, EMPIRE_SQUAD, {
	name = "Moralo Eval",
    front =     ASSETS_ROOT.."squadrons/empire/yv666/moralo_card.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/yv666/gr_ro_model.obj",
    diffuse =   ASSETS_ROOT.."squadrons/empire/yv666/ace_diffuse.jpg",
    move = 3,
    defense_tokens = {DEF_BRACE},
    cost = 22
})
phantom = {
    mesh =      ASSETS_ROOT.."squadrons/empire/pha/cl_model.obj",
    health = 4,
    move = 4,
    defense_tokens = {}}
Squadron:new(phantom, EMPIRE_SQUAD, {
	name = 'TIE Phantom Squadron',
    front =     ASSETS_ROOT.."squadrons/empire/pha/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/pha/base_diffuse.jpg",
    cost = 14,
    aliases = {"TIE Phantom Squadrons", "TIE Phantom"}
})
Squadron:new(phantom, EMPIRE_SQUAD, {
	name = '"Whisper"',
    front =     ASSETS_ROOT.."squadrons/empire/pha/whisper_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/pha/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 20,
    aliases = {"Whisper"}
})
defender = {
    mesh =      ASSETS_ROOT.."squadrons/empire/def/bo_model.obj",
    health = 6,
    move = 5,
    defense_tokens = {}}
Squadron:new(defender, EMPIRE_SQUAD, {
	name = 'TIE Defender Squadron',
    front =     ASSETS_ROOT.."squadrons/empire/def/base_card.jpg",
    diffuse = "http://i.imgur.com/pXxfv23.png",
    cost = 16,
    aliases = {"TIE Defender Squadrons", "TIE Defender"}
})
Squadron:new(defender, EMPIRE_SQUAD, {
	name = 'Maarek Stele',
    front =     ASSETS_ROOT.."squadrons/empire/def/maarek_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/def/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/def/bo_gr_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 21
})
Squadron:new(defender, EMPIRE_SQUAD, {
	name = 'Darth Vader',
    front =     ASSETS_ROOT.."squadrons/empire/def/vader_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/def/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/def/ad_bo_ro_model.obj",
    defense_tokens = {DEF_BRACE,DEF_EVADE},
    cost = 25,
    aliases = {'Darth Vader (defender)','Darth Vader (TIE Defender)'}
})
lambda = {
    mesh =      ASSETS_ROOT.."squadrons/empire/lambda/he_re_st_model.obj",
    health = 6,
    move = 3,
    defense_tokens = {}}
Squadron:new(lambda, EMPIRE_SQUAD, {
	name = 'Lambda-class Shuttle',
    front =     ASSETS_ROOT.."squadrons/empire/lambda/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/lambda/base_diffuse.jpg",
    cost = 15,
    aliases = {'Lambda Shuttle', 'Lambda Shuttles', 'Lambda-class Shuttles'}
})
Squadron:new(lambda, EMPIRE_SQUAD, {
	name = 'Colonel Jendon',
    front =     ASSETS_ROOT.."squadrons/empire/lambda/jendon_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/lambda/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/lambda/he_re_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 20
})
decimator = {
    mesh =      ASSETS_ROOT.."squadrons/empire/decimator/co_he_ro_model.obj",
    health = 8,
    move = 3,
    defense_tokens = {}}
Squadron:new(decimator, EMPIRE_SQUAD, {
	name = 'VT-49 Decimator',
    front =     ASSETS_ROOT.."squadrons/empire/decimator/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/decimator/base_diffuse.jpg",
    cost = 22,
    aliases = {'VT-49 Decimators'}
})
Squadron:new(decimator, EMPIRE_SQUAD, {
	name = 'Morna Kee',
    front =     ASSETS_ROOT.."squadrons/empire/decimator/morna_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/decimator/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/empire/decimator/co_ro_model.obj",
    defense_tokens = {DEF_BRACE},
    cost = 27
})
gauntlet = {
    mesh =      ASSETS_ROOT.."squadrons/empire/guantlet/as_ro_model.obj",
    health = 7,
    move = 4,
    defense_tokens = {}}
Squadron:new(gauntlet, EMPIRE_SQUAD, {
	name = 'Mandalorian Gauntlet Fighter',
    front =     ASSETS_ROOT.."squadrons/empire/guantlet/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/guantlet/base_diffuse.jpg",
    cost = 20,
    aliases = {'Mandalorian Gauntlet Fighters'}
})
Squadron:new(gauntlet, EMPIRE_SQUAD, {
	name = 'Gar Saxon',
    front =     ASSETS_ROOT.."squadrons/empire/guantlet/saxon_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/empire/guantlet/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE},
    cost = 23
})

----#include defs/empire/squadrons
    local ship = nil

----#include defs/republic/ships
REPUBLIC_SHIP = {
    back =      ASSETS_ROOT.."ships/republic/card_back.jpg",
    faction = "Republic"
}

Ship:new(SmallShip,REPUBLIC_SHIP,{
	name = "Consular-class Armed Cruiser",
    front =     ASSETS_ROOT.."ships/republic/consular/armed_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/consular/armed_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/consular/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/consular/armed_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/consular/ruler.obj",
    maneuver = {{"II"},{"II","I"},{"I","I","I"},{"I","-","I","I"}},
    defense_tokens = {DEF_EVADE, DEF_REDIRECT, DEF_CONTAIN},
    shields = {2,2,2,1},
    cost = 37,
	aliases = {"Consular Armed Cruiser","Armed Cruiser"},
    command = 1
})
Ship:new(SmallShip,REPUBLIC_SHIP,{
	name = "Consular-class Charger c70",
    front =     ASSETS_ROOT.."ships/republic/consular/charger_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/consular/armed_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/consular/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/consular/charger_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/consular/ruler.obj",
    maneuver = {{"II"},{"II","I"},{"I","I","I"},{"I","-","I","I"}},
    defense_tokens = {DEF_EVADE, DEF_REDIRECT, DEF_CONTAIN},
    shields = {2,2,2,1},
    cost = 45,
	aliases = {"Consular Charger c70","Charger c70"},
    command = 1
})

Ship:new(MediumShip,REPUBLIC_SHIP,{
	name = "Acclamator I-class Assault Ship",
    front =     ASSETS_ROOT.."ships/republic/acclamator/I_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/acclamator/I_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/acclamator/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/acclamator/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/acclamator/ruler.obj",
    maneuver = {{"I"},{"I","-"},{"-","I","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_SALVO},
    shields = {4,2,2,2},
    cost = 66,
	aliases = {"Acclamator I Assault Ship", "Acclamator I"},
    command = 3
})
Ship:new(MediumShip,REPUBLIC_SHIP,{
	name = "Acclamator II-class Assault Ship",
    front =     ASSETS_ROOT.."ships/republic/acclamator/II_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/acclamator/II_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/acclamator/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/acclamator/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/acclamator/ruler.obj",
    maneuver = {{"I"},{"I","-"},{"-","I","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_SALVO},
    shields = {4,2,2,2},
    cost = 71,
	aliases = {"Acclamator II Assault Ship", "Acclamator II"},
    command = 3
})

Ship:new(LargeShip,REPUBLIC_SHIP,{
	name = "Venator I-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/republic/venator/I_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/venator/I_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/venator/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/venator/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/venator/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_CONTAIN,DEF_SALVO},
    shields = {4,3,3,2},
    cost = 90,
	aliases = {"Venator I Star Destroyer", "Venator I"},
    command = 3
})

--Missing upgrades & cost
Ship:new(LargeShip,REPUBLIC_SHIP,{
	name = "Venator II-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/republic/venator/II_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/venator/II_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/venator/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/venator/II_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/venator/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","I","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_CONTAIN,DEF_SALVO},
    shields = {4,3,3,2},
    cost = 100,
	aliases = {"Venator II Star Destroyer", "Venator II"},
    command = 3
})

Ship:new(SmallShip,REPUBLIC_SHIP,{
	name = "Pelta-class Medical Frigate",
    front =     ASSETS_ROOT.."ships/republic/pelta/medical_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/pelta/medical_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/pelta/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/pelta/medical_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/pelta/ruler.obj",
    maneuver = {{"II"},{"I","I"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT},
    shields = {3,2,2,1},
    cost = 49,
	aliases = {"Pelta Medical Frigate"},
    command = 2
})

Ship:new(SmallShip,REPUBLIC_SHIP,{
    name = "Pelta-class Transport Frigate",
    front =     ASSETS_ROOT.."ships/republic/pelta/transport_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/pelta/transport_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/republic/pelta/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/pelta/transport_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/republic/pelta/ruler.obj",
    maneuver = {{"II"},{"I","I"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT},
    shields = {3,2,2,1},
    cost = 45,
    aliases = {"Pelta Transport Frigate"},
    command = 2
})
Ship:new(MediumShip,REPUBLIC_SHIP,{
	name = "Victory I-class Star Destroyer",
    front =     ASSETS_ROOT.."ships/republic/victory/I_card.jpg",
    -- back =      ASSETS_ROOT.."ships/republic/victory/I_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/empire/victory/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/republic/victory/I_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/victory/ruler.obj",
    maneuver = {{"I"},{"-","I"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_SALVO},
    shields = {3,3,3,1},
    cost = 75,
    aliases = {"Victory I Star Destroyer","Victory I", "VSD I", "VSD 1", "Victory I-class Star Destroyer (gar)", "Victory I Star Destroyer (gar)","Victory I (gar)", "VSD I (gar)", "VSD 1 (gar)"},
    command = 3
})

----#include defs/republic/ships
----#include defs/separatist/ships
SEPARATIST_SHIP = {
    back =      ASSETS_ROOT.."ships/separatist/card_back.jpg",
    faction = "Separatist"
}
Ship:new(SmallShip,SEPARATIST_SHIP,{
	name = "Hardcell-class Transport",
    front =     ASSETS_ROOT.."ships/separatist/hardcell/transport_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/hardcell/transport_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/hardcell/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/hardcell/transport_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/hardcell/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"I","I","-"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT},
    shields = {3,1,1,2},
    cost = 47,
	aliases = {"Hardcell Transport"},
    command = 1
})
Ship:new(SmallShip,SEPARATIST_SHIP,{
	name = "Hardcell-class Battle Refit",
    front =     ASSETS_ROOT.."ships/separatist/hardcell/battle_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/hardcell/battle_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/hardcell/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/hardcell/battle_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/hardcell/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"I","I","-"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT},
    shields = {3,1,1,2},
    cost = 52,
	aliases = {"Hardcell Battle Refit"},
    command = 1
})

Ship:new(MediumShip,SEPARATIST_SHIP,{
	name = "Munificent-class Comms Frigate",
    front =     ASSETS_ROOT.."ships/separatist/munificent/comms_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/munificent/comms_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/munificent/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/munificent/comms_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/munificent/ruler.obj",
    maneuver = {{"I"},{"I","II"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_SALVO},
    shields = {4,3,3,2},
    cost = 70,
	aliases = {"Munificent Comms Frigate"},
    command = 2
})
Ship:new(MediumShip,SEPARATIST_SHIP,{
	name = "Munificent-class Star Frigate",
    front =     ASSETS_ROOT.."ships/separatist/munificent/star_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/munificent/star_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/munificent/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/munificent/star_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/munificent/ruler.obj",
    maneuver = {{"I"},{"I","II"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_SALVO},
    shields = {4,3,3,2},
    cost = 73,
	aliases = {"Munificent Star Frigate"},
    command = 2
})

Ship:new(LargeShip,SEPARATIST_SHIP,{
    name = "Recusant-class Light Destroyer",
    front =     ASSETS_ROOT.."ships/separatist/recusant/light_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/recusant/light_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/recusant/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/recusant/light_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/recusant/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","II","I"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT,DEF_SALVO},
    shields = {3,3,3,2},
    cost = 85,
    aliases = {"Recusant Light Destroyer"},
    command = 3
})
Ship:new(LargeShip,SEPARATIST_SHIP,{
	name = "Recusant-class Support Destroyer",
    front =     ASSETS_ROOT.."ships/separatist/recusant/support_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/recusant/support_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/recusant/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/recusant/support_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/recusant/ruler.obj",
    maneuver = {{"I"},{"I","I"},{"-","II","I"}},
    defense_tokens = {DEF_EVADE,DEF_BRACE,DEF_REDIRECT,DEF_SALVO},
    shields = {3,3,3,2},
    cost = 90,
	aliases = {"Recusant Support Destroyer"},
    command = 3
})

Ship:new(LargeShip,SEPARATIST_SHIP,{
	name = "Providence-class Carrier",
    front =     ASSETS_ROOT.."ships/separatist/providence/carrier_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/providence/carrier_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/providence/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/providence/carrier_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/providence/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"I","-","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_CONTAIN,DEF_SALVO},
    shields = {5,3,3,2},
    cost = 105,
	aliases = {"Providence Carrier"},
    command = 3
})

Ship:new(LargeShip,SEPARATIST_SHIP,{
	name = "Providence-class Dreadnought",
    front =     ASSETS_ROOT.."ships/separatist/providence/dreadnought_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/providence/dreadnought_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/providence/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/providence/dreadnought_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/separatist/providence/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"I","-","-"}},
    defense_tokens = {DEF_BRACE,DEF_REDIRECT,DEF_CONTAIN,DEF_SALVO},
    shields = {5,3,3,2},
    cost = 105,
	aliases = {"Providence Dreadnought"},
    command = 3
})
Ship:new(SmallShip,SEPARATIST_SHIP,{
	name = "Gozanti-class Cruisers",
    front =     ASSETS_ROOT.."ships/separatist/gozanti/cruiser_card.jpg",
    -- back =      ASSETS_ROOT.."ships/separatist/gozanti/cruiser_card_orig_back.jpg",
    mesh =      ASSETS_ROOT.."ships/separatist/gozanti/mesh.obj",
    diffuse =   ASSETS_ROOT.."ships/separatist/gozanti/cruiser_diffuse.jpg",
    ruler =     ASSETS_ROOT.."ships/empire/gozanti/ruler.obj",
    maneuver = {{"II"},{"I","I"},{"I","I","-"}},
    defense_tokens = {DEF_SCATTER, DEF_EVADE},
    shields = {1,1,1,1},
    cost = 27,
    aliases = {"Gozanti Cruisers", "Gozanti-class Cruisers (cis)", "Gozanti Cruisers (cis)"},
    command = 1
})

----#include defs/separatist/ships
    local ship = nil

----#include defs/republic/squadrons
REPUBLIC_SQUAD = {
    back =      ASSETS_ROOT.."ships/republic/card_back.jpg", --TODO: Replace Long Ship version
    faction = "Republic"
}
v19 = {
    mesh =      ASSETS_ROOT.."squadrons/republic/v19/es_sw_model.obj",
    health = 5,
    move = 3,
    defense_tokens = {}}
-- Escort, Swarm
Squadron:new(v19, REPUBLIC_SQUAD, {
	name = "V-19 Torrent Squadron",
    front =     ASSETS_ROOT.."squadrons/republic/v19/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/v19/base_diffuse.jpg",
    cost = 12,
    aliases = {'V-19 Torrent Squadrons', "V-19", "V-19 Torrent"}
})
-- Escort, Swarm
Squadron:new(v19, REPUBLIC_SQUAD, {
	name = '\"Axe\"',
    front =     ASSETS_ROOT.."squadrons/republic/v19/axe_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/v19/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_EVADE},
    cost = 17,
    aliases = {"Axe"}
})

-- Escort, Swarm
Squadron:new(v19, REPUBLIC_SQUAD, {
	name = '\"Kickback\"',
    front =     ASSETS_ROOT.."squadrons/republic/v19/kickback_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/v19/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 16,
    aliases = {"Kickback"}
})

delta = {
    mesh =      ASSETS_ROOT.."squadrons/republic/delta/ad_co_do_model.obj",
    health = 4,
    move = 4,
    defense_tokens = {}}
-- Adept, Counter, Dodge
Squadron:new(delta, REPUBLIC_SQUAD, {
	name = "Delta-7 Aethersprite Squadron",
    front =     ASSETS_ROOT.."squadrons/republic/delta/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/delta/base_diffuse.jpg",
    cost = 17,
    aliases = {'Delta-7 Aethersprite Squadrons', "Delta-7 Aethersprite", "Delta-7"}
})
-- ship.diffuse = ""
-- Adept, Counter, Grit
Squadron:new(delta, REPUBLIC_SQUAD, {
	name = "Ahsoka Tano",
    front =     ASSETS_ROOT.."squadrons/republic/delta/ahsoka_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/delta/ahsoka_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/republic/delta/ad_co_gr_model.obj",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 23
})
-- Adept, Counter
Squadron:new(delta, REPUBLIC_SQUAD, {
	name = "Luminara Unduli",
    front =     ASSETS_ROOT.."squadrons/republic/delta/luminara_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/delta/luminara_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/republic/delta/ad_co_model.obj",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 23
})
-- Adept, Counter, Intel
Squadron:new(delta, REPUBLIC_SQUAD, {
	name = "Kit Fisto",
    front =     ASSETS_ROOT.."squadrons/republic/delta/kit_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/delta/kit_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/republic/delta/ad_co_in_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 26
})
-- Adept, Counter
Squadron:new(delta, REPUBLIC_SQUAD, {
	name = "Plo Koon",
    front =     ASSETS_ROOT.."squadrons/republic/delta/plo_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/delta/plo_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/republic/delta/ad_co_model.obj",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 24
})
--Adept, Counter 2, Dodge 1
Squadron:new(delta, REPUBLIC_SQUAD, {
	name = "Anakin Skywalker",
    front =     ASSETS_ROOT.."squadrons/republic/delta/anakin_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/delta/anakin_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/republic/delta/ad_co_do_model.obj",
    defense_tokens = {DEF_BRACE,DEF_SCATTER},
    cost = 24,
    aliases = {'Anakin Skywalker (delta)', 'Anakin Skywalker (Delta-7)'}
})

ywing = {
    mesh =      ASSETS_ROOT.."squadrons/republic/ywing/bo_he_model.obj",
    health = 6,
    move = 3,
    defense_tokens = {}}
-- Bomber, Heavy
Squadron:new(ywing, REPUBLIC_SQUAD, {
	name = "BTL-B Y-Wing Squadron",
    front =     ASSETS_ROOT.."squadrons/republic/ywing/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/ywing/base_diffuse.jpg",
    cost = 10,
    aliases = {'BTL-B Y-Wing Squadrons', "BTL-B Y-Wing",'BLT-B Y-Wing Squadrons'}
})
-- Adept, Bomber, Heavy
Squadron:new(ywing, REPUBLIC_SQUAD, {
	name = "Anakin Skywalker",
    front =     ASSETS_ROOT.."squadrons/republic/ywing/anakin_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/ywing/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/republic/ywing/ad_bo_he_model.obj",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 19,
    aliases = {'Anakin Skywalker (BTL-B)'}
})
-- Bomber, Heavy
Squadron:new(ywing, REPUBLIC_SQUAD, {
	name = "Matchstick",
    front =     ASSETS_ROOT.."squadrons/republic/ywing/matchstick_card_v2_1.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/ywing/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 16,
    aliases = {'\"Matchstick\"'}
})

arc = {
    mesh =      ASSETS_ROOT.."squadrons/republic/arc/bo_co_model.obj",
    health = 7,
    move = 2,
    defense_tokens = {}}
-- Bomber, Counter
Squadron:new(arc, REPUBLIC_SQUAD, {
	name = "ARC-170 Starfighter Squadron",
    front =     ASSETS_ROOT.."squadrons/republic/arc/base_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/arc/base_diffuse.jpg",
    cost = 15,
    aliases = {'ARC-170 Starfighter Squadrons', "ARC-170 Starfighter", "ARC-170"}
})
-- Bomber, Counter
Squadron:new(arc, REPUBLIC_SQUAD, {
	name = '\"Odd Ball\"',
    front =     ASSETS_ROOT.."squadrons/republic/arc/oddball_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/republic/arc/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_EVADE},
    cost = 23,
    aliases = {"Odd Ball", "Oddball"}
})

----#include defs/republic/squadrons
----#include defs/separatist/squadrons
SEPARATISTS_SQUAD = {
    back =      ASSETS_ROOT.."ships/separatist/card_back.jpg", --TODO: Replace Long Ship version
    faction = "Separatist"
}
vulture = {
    diffuse =   ASSETS_ROOT.."squadrons/separatist/vulture/base_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/separatist/vulture/ai_sw_model.obj",
    health = 3,
    move = 4,
    defense_tokens = {}}
-- AI: Anti-Squadron, Swarm
Squadron:new(vulture, SEPARATISTS_SQUAD, {
	name = "Vulture-class Droid Fighter Squadron",
    front =     ASSETS_ROOT.."squadrons/separatist/vulture/base_card.jpg",
    cost = 8,
    aliases = {'Vulture-class Droid Fighter Squadrons', 'Vulture Droid Fighter Squadron', 'Vulture Droid Fighter Squadrons', "Vultere Droid Fighter", "Vulture", 'Vulture Droid Squadron'}
})
vulture.diffuse = ASSETS_ROOT.."squadrons/separatist/vulture/ace_diffuse.jpg"
vulture.defense_tokens = {DEF_BRACE,DEF_SCATTER}
-- AI: Anti-Squadron, Swarm
Squadron:new(vulture, SEPARATISTS_SQUAD, {
	name = "Haor Chall Prototypes",
    front =     ASSETS_ROOT.."squadrons/separatist/vulture/haor_card.jpg",
    cost = 16
})
-- AI: Anti-Squadron, Swarm, Intel
Squadron:new(vulture, SEPARATISTS_SQUAD, {
	name = "DFS-311",
    front =     ASSETS_ROOT.."squadrons/separatist/vulture/dfs_card.jpg",
    mesh =      ASSETS_ROOT.."squadrons/separatist/vulture/ai_in_sw_model.obj",
    cost = 18
})

hyena = {
    diffuse =   ASSETS_ROOT.."squadrons/separatist/hyena/base_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/separatist/hyena/ai_bo_he_model.obj",
    health = 4,
    move = 4,
    defense_tokens = {}}
--  AI: Battery, Bomber, Heavy
Squadron:new(hyena, SEPARATISTS_SQUAD, {
	name = "Hyena-class Droid Bomber Squadron",
    front =     ASSETS_ROOT.."squadrons/separatist/hyena/base_card.jpg",
    cost = 11,
    aliases = {'Hyena-class Droid Bomber Squadrons','Hyena Droid Bomber Squadron','Hyena Droid Bomber Squadrons', 'Hyena Droid Bomber', 'Hyena','Hyena Bomber Squadron'}
})
--ALIAS
hyena.diffuse = ASSETS_ROOT.."squadrons/separatist/hyena/ace_diffuse.jpg"
hyena.defense_tokens = {DEF_BRACE,DEF_SCATTER}
--  AI: Battery, Bomber, Heavy
Squadron:new(hyena, SEPARATISTS_SQUAD, {
	name = "Baktoid Prototypes",
    front =     ASSETS_ROOT.."squadrons/separatist/hyena/baktoid_card.jpg",
    cost = 16,
    aliases = {"Baktoid Prototype"}
})
--  AI: Battery, Bomber, Heavy
Squadron:new(hyena, SEPARATISTS_SQUAD, {
	name = "DBS-404",
    front =     ASSETS_ROOT.."squadrons/separatist/hyena/dbs_card.jpg",
    cost = 17
})

tri = {
    diffuse =   ASSETS_ROOT.."squadrons/separatist/tri/base_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/separatist/tri/ai_co_sw_model.obj",
    health = 3,
    move = 5,
    defense_tokens = {}}
--  Counter, Swarm, AI:Anti-squadron
Squadron:new(tri, SEPARATISTS_SQUAD, {
	name = "Droid Tri-Fighter Squadron",
    front =     ASSETS_ROOT.."squadrons/separatist/tri/base_card.jpg",
    cost = 11,
    aliases = {'Droid Tri-Fighter Squadrons', "Droid Tri-Fighter", "Tri-Fighter"}
})
tri.diffuse =   ASSETS_ROOT.."squadrons/separatist/tri/ace_diffuse.jpg"
tri.defense_tokens = {DEF_BRACE,DEF_SCATTER}
--  Counter, Swarm, AI:Anti-squadron
Squadron:new(tri, SEPARATISTS_SQUAD, {
	name = "Phlac-Arphocc Prototypes",
    front =     ASSETS_ROOT.."squadrons/separatist/tri/phlacc_card.jpg",
    cost = 19
})
--  Counter, Swarm, AI:Anti-squadron, snipe 3
Squadron:new(tri, SEPARATISTS_SQUAD, {
	name = "DIS-T81",
    front =     ASSETS_ROOT.."squadrons/separatist/tri/dis_card.jpg",
    mesh =      ASSETS_ROOT.."squadrons/separatist/tri/ai_co_sn_sw_model.obj",
    cost = 17
})

belbullab = {
    diffuse =   ASSETS_ROOT.."squadrons/separatist/belbullab/base_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/separatist/belbullab/re_sc_model.obj",
    health = 5,
    move = 4,
    defense_tokens = {}}
--  Relay, Screen
Squadron:new(belbullab, SEPARATISTS_SQUAD, {
	name = "Belbullab-22 Starfighter Squadron",
    front =     ASSETS_ROOT.."squadrons/separatist/belbullab/base_card.jpg",
    cost = 15,
    aliases = {'Belbullab-22 Starfighter Squadrons', "Belbullab-22 Starfighter", "Belbullab-22"}
})
--Relay, Screen
Squadron:new(belbullab, SEPARATISTS_SQUAD, {
	name = "General Grievous",
    front =     ASSETS_ROOT.."squadrons/separatist/belbullab/grievous_card.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/separatist/belbullab/ace_diffuse.jpg",
    defense_tokens = {DEF_BRACE,DEF_BRACE},
    cost = 22
})
--Escort, Relay, Screen
Squadron:new(belbullab, SEPARATISTS_SQUAD, {
	name = "Wat Tambor",
    front =     ASSETS_ROOT.."squadrons/separatist/belbullab/wat_card_v2_1.jpg",
    diffuse =   ASSETS_ROOT.."squadrons/separatist/belbullab/ace_diffuse.jpg",
    mesh =      ASSETS_ROOT.."squadrons/separatist/belbullab/es_re_sc_model.obj",
    defense_tokens = {DEF_BRACE,DEF_EVADE},
    cost = 18
})

----#include defs/separatist/squadrons

----#include defs/cards/commanders
Commander = {
    type="Commander",
    back = "https://i.imgur.com/fMJMaYo.png"
}
--rebel
Rebel = {
    factions={"Rebellion"}
}
Card:new(Commander,Rebel,{name="Admiral Ackbar",  front="http://i.imgur.com/HFVv48K.jpg", cost=38})
Card:new(Commander,Rebel,{name="Admiral Raddus",  front="http://i.imgur.com/2IPtau4.jpg", cost=26})
Card:new(Commander,Rebel,{name="Commander Sato",  front="http://i.imgur.com/ir6QixK.jpg", cost=27})
Card:new(Commander,Rebel,{name="Garm Bel Iblis",  front="http://i.imgur.com/fmlXop3.jpg", cost=25})
Card:new(Commander,Rebel,{name="General Cracken",  front="http://i.imgur.com/0NHwrEL.jpg", cost=26})
Card:new(Commander,Rebel,{name="General Dodonna",  front="http://i.imgur.com/MsS9AN8.jpg", cost=20})
Card:new(Commander,Rebel,{name="General Madine",  front="http://i.imgur.com/ePeK8Ok.jpg", cost=30})
Card:new(Commander,Rebel,{name="General Rieekan",  front="http://i.imgur.com/Q6pSiLj.jpg", cost=34})
Card:new(Commander,Rebel,{name="Kyrsta Agate",  front=ASSETS_ROOT.."cards/commanders/kyrsta_agate_v2_1.jpg", cost=25})
Card:new(Commander,Rebel,{name="Leia Organa",  front="http://i.imgur.com/Xsqh5f0.jpg", cost=28})
Card:new(Commander,Rebel,{name="Mon Mothma",  front="http://i.imgur.com/ZK3rQeb.jpg", cost=27})
Card:new(Commander,Rebel,{name="General Draven",  front=ASSETS_ROOT.."cards/commanders/general_draven_v2_1.jpg", cost=28})

Empire = {
    factions={"Empire"}
}
--imperial
Card:new(Commander,Empire,{name="Admiral Konstantine",  front="http://i.imgur.com/ONoTDBL.jpg", cost=23})
Card:new(Commander,Empire,{name="Admiral Motti",  front="http://i.imgur.com/rkMe17G.jpg", cost=24})
Card:new(Commander,Empire,{name="Admiral Ozzel",  front="http://i.imgur.com/v0nThwx.jpg", cost=20})
Card:new(Commander,Empire,{name="Admiral Piett",  front="http://i.imgur.com/2D3DgQS.jpg", cost=22})
Card:new(Commander,Empire,{name="Admiral Screed",  front="http://i.imgur.com/DUToctV.jpg", cost=26})
Card:new(Commander,Empire,{name="Admiral Sloane",  front="http://i.imgur.com/rzZtf8B.jpg", cost=24})
Card:new(Commander,Empire,{name="Darth Vader",  front="http://i.imgur.com/ysyfpEF.jpg", cost=36})
Card:new(Commander,Empire,{name="Emperor Palpatine",  front="http://i.imgur.com/KBY36Qs.jpg", cost=35})
Card:new(Commander,Empire,{name="General Romodi",  front=ASSETS_ROOT.."cards/commanders/general_romodi_v2_1.jpg", cost=28})
Card:new(Commander,Empire,{name="General Tagge",  front="http://i.imgur.com/LduHiR8.jpg", cost=25})
Card:new(Commander,Empire,{name="Grand Admiral Thrawn",  front="http://i.imgur.com/FSpE1gl.jpg", cost=32})
Card:new(Commander,Empire,{name="Grand Moff Tarkin",  front="http://i.imgur.com/OxvHWmA.jpg", cost=28})
Card:new(Commander,Empire,{name="Moff Jerjerrod",  front="http://i.imgur.com/qZAVH6a.jpg", cost=23})

Republic = {
    factions={"Republic"}
}
--republic
Card:new(Commander,Republic,{name="Bail Organa",  front="https://i.imgur.com/SBYa2yD.jpeg", cost=28})
Card:new(Commander,Republic,{name="Obi-Wan Kenobi",  front="https://i.imgur.com/xkfBnRw.jpeg", cost=28, aliases = {"Obi Wan Kenobi"}})
Card:new(Commander,Republic,{name="Luminara Unduli",  front="https://i.imgur.com/SlkHtHE.png", cost=25})
Card:new(Commander,Republic,{name="Admiral Tarkin",  front="https://i.imgur.com/mJplVe5.png", cost=30})
Card:new(Commander,Republic,{name="Admiral Yularen", front="https://i.imgur.com/QloblZJ.jpeg", cost=24})
Card:new(Commander,Republic,{name="Plo Koon", front="https://i.imgur.com/RY01HsT.jpg", cost=26})
Card:new(Commander,Republic,{name="Anakin Skywalker",  front=ASSETS_ROOT.."cards/commanders/anakin_skywalker_v2_1.jpg", cost=31})

Separatist = {
    factions={"Separatist"}
}
--separatist
Card:new(Commander,Separatist,{name="Count Dooku",  front="https://i.imgur.com/YOm4LIi.jpeg", cost=30})
Card:new(Commander,Separatist,{name="Kraken",  front="https://i.imgur.com/zLNsrOo.jpeg", cost=30})
Card:new(Commander,Separatist,{name="General Grievous",  front="https://i.imgur.com/xLHg92l.png", cost=20})
Card:new(Commander,Separatist,{name="Admiral Trench", front="https://i.imgur.com/eOaryOm.png", cost=36})
Card:new(Commander,Separatist,{name="Mar Tuuk", front="https://i.imgur.com/POTMBXQ.png", cost=28})
Card:new(Commander,Separatist,{name="TF-1726", front="https://i.imgur.com/aptrDok.png", cost=26})

----#include defs/cards/commanders
----#include defs/cards/defensive_retrofit
DefensiveRetrofit = {
    type="DefensiveRetrofit",
    back = "https://i.imgur.com/WXkUkKe.png"
}
CloneWars = {
    factions={"Republic","Separatist"}
}
Card:new(DefensiveRetrofit,CloneWars,{name="Thermal Shields", front="https://i.imgur.com/ih2D2Zz.png", cost=5})

Card:new(DefensiveRetrofit,{name="Advanced Projectors", front="https://i.imgur.com/fREeP77.jpg", cost=6})
Card:new(DefensiveRetrofit,{name="Cluster Bombs", front="https://i.imgur.com/Ngqc1s9.jpg", cost=5})
Card:new(DefensiveRetrofit,{name="Early Warning System", front="https://i.imgur.com/PBh5gdb.jpg", cost=7})
Card:new(DefensiveRetrofit,{name="Electronic Countermeasures", front="https://i.imgur.com/LF2AEZT.jpg", cost=7})
Card:new(DefensiveRetrofit,{name="Reactive Gunnery", front="https://i.imgur.com/rKp36un.jpg", cost=4})
Card:new(DefensiveRetrofit,{name="Redundant Shields", front="https://i.imgur.com/3CmOh4B.jpg", cost=8})
Card:new(DefensiveRetrofit,{name="Reinforced Blast Doors", front="https://i.imgur.com/OVWDAVK.jpg", cost=5})

----#include defs/cards/defensive_retrofit
----#include defs/cards/experimental_retrofit
ExperimentalRetrofit = {
    type="ExperimentalRetrofit",
    back = "https://i.imgur.com/SAnzYjF.png"
}
Card:new(ExperimentalRetrofit,{name="G-8 Experimental Projector", front="https://i.imgur.com/DUzGkon.jpg", cost=8})
Card:new(ExperimentalRetrofit,{name="G7-X Grav Well Projector", front="https://i.imgur.com/BaMEJzl.jpg", cost=2})
Card:new(ExperimentalRetrofit,{name="Grav Shift Reroute", front="https://i.imgur.com/QipiGSD.jpg", cost=2})
Card:new(ExperimentalRetrofit,{name="Targeting Scrambler", front="https://i.imgur.com/KoUrM8N.jpg", cost=5})

----#include defs/cards/experimental_retrofit
----#include defs/cards/fleet_command
FleetCommand = {
    type="FleetCommand",
    back = "https://i.imgur.com/etN596C.png" --TODO: Fix this less awful image
}
CloneWars = {
    factions={"Republic","Separatist"}
}
Card:new(FleetCommand,{name="All Fighters, Follow Me!", front="https://i.imgur.com/pRqJy8Z.jpg", cost=5})
Card:new(FleetCommand,{name="Entrapment Formation!", front="https://i.imgur.com/7ipOGiT.jpg", cost=5})
Card:new(FleetCommand,{name="Intensify Firepower!", front="https://i.imgur.com/X4Pkv96.jpg", cost=6})
Card:new(FleetCommand,{name="Shields to Maximum!", front="https://i.imgur.com/2I3JN7G.jpg", cost=6})
Card:new(FleetCommand,{name="Take Evasive Action!", front="https://i.imgur.com/Grqrp2Y.jpg", cost=6})

Card:new(FleetCommand,Republic,{name="Mercy Mission", front="https://i.imgur.com/G5WinB0.png", cost=0})
Card:new(FleetCommand,Separatist,{name="Jedi Hostage", front="https://i.imgur.com/rtdHtYX.png", cost=3})
Card:new(FleetCommand,CloneWars,{name="Hot Landing", front="https://i.imgur.com/Gst4AaJ.png", cost=3})

----#include defs/cards/fleet_command
----#include defs/cards/fleet_support
FleetSupport = {
    type="FleetSupport",
    back = "https://i.imgur.com/bH1FR0J.png"
}
Card:new(FleetSupport,{name="Bomber Command Center", front="https://i.imgur.com/slRsjXp.jpg", cost=8})
Card:new(FleetSupport,{name="Comms Net", front="https://i.imgur.com/56EgYe9.jpg", cost=2})
Card:new(FleetSupport,{name="Jamming Field", front="https://i.imgur.com/YjACVRj.jpg", cost=2})
Card:new(FleetSupport,{name="Munitions Resupply", front="https://i.imgur.com/IEHG2uc.jpeg", cost=3})
Card:new(FleetSupport,{name="Parts Resupply", front="https://i.imgur.com/trKTRFt.jpg", cost=3})
Card:new(FleetSupport,{name="Repair Crews", front="https://i.imgur.com/sFnhtzi.jpg", cost=4})
Card:new(FleetSupport,{name="Slicer Tools", front="https://i.imgur.com/f3pcTt5.jpg", cost=7})

----#include defs/cards/fleet_support
----#include defs/cards/ion_cannons
IonCannons = {
    type="IonCannons",
    back = "https://i.imgur.com/CzYiC1u.png"
}
Card:new(IonCannons,{name="Heavy Ion Emplacements", front="https://i.imgur.com/S82y39J.jpg", cost=9})
Card:new(IonCannons,{name="High-Capacity Ion Turbines", front="https://i.imgur.com/sNFD2X4.jpg", cost=8})
Card:new(IonCannons,{name="Ion Cannon Batteries", front="https://i.imgur.com/ygkNbuk.jpg", cost=5})
Card:new(IonCannons,{name="Leading Shots", front="https://i.imgur.com/0wvdKHN.jpg", cost=6})
Card:new(IonCannons,{name="MS-1 Ion Cannons", front="https://i.imgur.com/WJpPDTH.jpg", cost=2, aliases={"MS-1 Ion Cannon"}})
Card:new(IonCannons,{name="NK-7 Ion Cannons", front="https://i.imgur.com/pw7KB1o.jpg", cost=10})
Card:new(IonCannons,{name="Overload Pulse", front="https://i.imgur.com/93yRQdH.jpg", cost=8})
Card:new(IonCannons,{name="SW-7 Ion Batteries", front="https://i.imgur.com/rL77eki.jpg", cost=5})
Card:new(IonCannons,{name="Point Defense Ion Cannons", front="https://i.imgur.com/Ed6N3bM.png", cost=4})

----#include defs/cards/ion_cannons
----#include defs/cards/offensive_retrofit
OffensiveRetrofit = {
    type="OffensiveRetrofit",
    back = "https://i.imgur.com/FSY3Hkx.png"
}
--republic
Card:new(OffensiveRetrofit,Republic,{name="Hyperspace Rings", front="https://i.imgur.com/GCSZ4Wy.jpeg", cost=3})
Card:new(OffensiveRetrofit,Republic,{name="SPHA-T", front="https://i.imgur.com/uIvMeUJ.png", cost=7})

--separatist
Card:new(OffensiveRetrofit,Separatist,{name="Hyperwave Signal Boost", front="https://i.imgur.com/NJQuMpr.jpeg", cost=3})
Card:new(OffensiveRetrofit,Separatist,{name="B2 Rocket Troopers", front="https://i.imgur.com/cK6wUox.png", cost=7})

--generic
Card:new(OffensiveRetrofit,{name="Advanced Transponder Net", front="https://i.imgur.com/vm6HKV1.jpg", cost=5}) --modification)
Card:new(OffensiveRetrofit,{name="Boosted Comms", front="https://i.imgur.com/pq9oDK2.jpg", cost=4})
Card:new(OffensiveRetrofit,{name="Disposable Capacitors", front="https://i.imgur.com/sujhLdx.jpg", cost=3})
Card:new(OffensiveRetrofit,{name="Expanded Hangar Bay", front="https://i.imgur.com/uHXkIP2.jpg", cost=5})
Card:new(OffensiveRetrofit,{name="Flag Bridge", front="https://i.imgur.com/qJksgmR.jpg", cost=0}) --modification)
Card:new(OffensiveRetrofit,{name="Hardened Bulkheads", front="https://i.imgur.com/Cz9oxBt.jpg", cost=5})
Card:new(OffensiveRetrofit,{name="Phylon Q7 Tractor Beams", front="https://i.imgur.com/x7VhJXM.jpg", cost=6})
Card:new(OffensiveRetrofit,{name="Point-Defense Reroute", front="https://i.imgur.com/IAIYK4H.jpg", cost=5})
Card:new(OffensiveRetrofit,{name="Proximity Mines", front="https://i.imgur.com/e93H1wf.jpg", cost=4})
Card:new(OffensiveRetrofit,{name="Quad Laser Turrets", front="https://i.imgur.com/HKfQx0O.jpg", cost=5})
Card:new(OffensiveRetrofit,{name="Rapid Launch Bays", front="https://i.imgur.com/PHiQ5fk.jpg", cost=6})
Card:new(OffensiveRetrofit,{name="Reserve Hangar Deck", front="https://i.imgur.com/CuuMCQr.jpg", cost=3})
Card:new(OffensiveRetrofit,{name="Flak Guns", front="https://i.imgur.com/pRgw74R.png", cost=3})

----#include defs/cards/offensive_retrofit
----#include defs/cards/officer
Officer = {
    type="Officer",
    back = "https://i.imgur.com/QvnjHpd.png"
}
-- Rebels
Card:new(Officer,Rebel,{name="Adar Tallon", front="http://i.imgur.com/htbjXKu.jpg", cost=10})
Card:new(Officer,Rebel,{name="Ahsoka Tano", front="http://i.imgur.com/Qu7q6hP.jpg", cost=2})
-- Card:new(Officer,Rebel,{name="Bail Organa", front=""})
Card:new(Officer,Rebel,{name="Captain Rex", front="https://i.imgur.com/AEeHqHn.jpeg", cost=5})
Card:new(Officer,Rebel,{name="Ezra Bridger", front="https://i.imgur.com/7K3X4Po.jpeg", cost=3})
Card:new(Officer,Rebel,{name="General Draven", front="https://i.imgur.com/d3Qyp8a.jpeg", cost=3})
Card:new(Officer,Rebel,{name="Kyrsta Agate", front="https://i.imgur.com/Fwdfoev.jpeg", cost=5})
Card:new(Officer,Rebel,{name="Lando Calrissian", front="https://i.imgur.com/fw8Qm7S.jpeg", cost=4})
Card:new(Officer,Rebel,{name="Leia Organa", front="https://i.imgur.com/bJcJynH.jpg", cost=3})
Card:new(Officer,Rebel,{name="Major Derlin", front="https://i.imgur.com/Q8rOdcb.jpeg", cost=7})
Card:new(Officer,Rebel,{name="Raymus Antilles", front="https://i.imgur.com/1Ae4QfL.jpg", cost=7, aliases={"Ray Antilles"}})
Card:new(Officer,Rebel,{name="Sabine Wren", front="https://i.imgur.com/s6dTW50.jpg", cost=4})
Card:new(Officer,Rebel,{name="Toryn Farr", front="https://i.imgur.com/kjyMTLq.jpeg", cost=7})
Card:new(Officer,Rebel,{name="Walex Blissex", front="https://i.imgur.com/X0OgdJp.jpeg", cost=5})
Card:new(Officer,Rebel,{name="Wedge Antilles", front="https://i.imgur.com/OSOELtb.jpeg", cost=4})

--Imperial
Card:new(Officer,Empire,{name="Admiral Chiraneau", front="https://i.imgur.com/MnfDupy.jpg", cost=10})
Card:new(Officer,Empire,{name="Admiral Montferrat", front="https://i.imgur.com/Y7lJDlF.jpg", cost=5})
Card:new(Officer,Empire,{name="Admiral Ozzel", front="https://i.imgur.com/hPkP4Nf.jpeg", cost=2})
Card:new(Officer,Empire,{name="Admiral Titus", front="https://i.imgur.com/Rm0hVoL.jpeg", cost=2})
Card:new(Officer,Empire,{name="Agent Kallus", front="https://i.imgur.com/Wuz7UVA.jpeg", cost=3})
Card:new(Officer,Empire,{name="Captain Brunson", front="https://i.imgur.com/KJFYNXO.jpg", cost=9})
Card:new(Officer,Empire,{name="Captain Needa", front="https://i.imgur.com/qeUR8rK.jpeg", cost=2})
Card:new(Officer,Empire,{name="Commandant Aresko", front="https://i.imgur.com/3md8wnE.jpeg", cost=7})
Card:new(Officer,Empire,{name="Commander Beck", front="https://i.imgur.com/VPsl8a9.jpeg", cost=3})
Card:new(Officer,Empire,{name="Commander Gherant", front="https://i.imgur.com/IAt9Puz.jpeg", cost=2})
Card:new(Officer,Empire,{name="Commander Vanto", front="https://i.imgur.com/vyMS9Vl.jpeg", cost=7})
Card:new(Officer,Empire,{name="Commander Woldar", front="https://i.imgur.com/nsUrWcO.jpeg", cost=4})
Card:new(Officer,Empire,{name="Darth Vader", front="https://i.imgur.com/wUS7LNn.jpg", cost=1})
Card:new(Officer,Empire,{name="Director Isard", front="https://i.imgur.com/2OKtNz1.jpg", cost=3})
Card:new(Officer,Empire,{name="Director Krennic", front="https://i.imgur.com/MWbTBAg.jpg", cost=8})
Card:new(Officer,Empire,{name="Emperor Palpatine", front="https://i.imgur.com/SAJT8HA.jpg", cost=3})
-- Card:new(Officer,Empire,{name="Governor Pryce", front=""})
Card:new(Officer,Empire,{name="Iden Versio", front="https://i.imgur.com/GspJT2q.jpg", cost=6})
Card:new(Officer,Empire,{name="Instructor Goran", front="https://i.imgur.com/ZpxS19K.jpg", cost=7})
Card:new(Officer,Empire,{name="Lira Wessex", front="https://i.imgur.com/A9ZQ2mz.jpg", cost=2})
Card:new(Officer,Empire,{name="Minister Tua", front="https://i.imgur.com/oBLlFVB.jpg", cost=2})
Card:new(Officer,Empire,{name="Reeva Demesne", front="https://i.imgur.com/hPWCUbI.jpg", cost=4})
Card:new(Officer,Empire,{name="Taskmaster Grint", front="https://i.imgur.com/9U4hKcc.jpg", cost=5})
Card:new(Officer,Empire,{name="The Grand Inquisitor", front="https://i.imgur.com/xzcI49o.jpg", cost=4})
Card:new(Officer,Empire,{name="Wulff Yularen", front="https://i.imgur.com/dvWsOm8.jpg", cost=7})
Card:new(Officer,Empire,{name="Governor Pryce", front=ASSETS_ROOT.."cards/officers/governor_pryce.jpg", cost=7})

--republic
Card:new(Officer,Republic,{name="Clone Captain Zak", front="https://i.imgur.com/A1FePh3.jpeg", cost=5})
Card:new(Officer,Republic,{name="Clone Navigation Officer", front="https://i.imgur.com/Mt2SoH7.jpg", cost=4})
Card:new(Officer,Republic,{name="Barriss Offee", front="https://i.imgur.com/TK5hk9G.png", cost=6})
Card:new(Officer,Republic,{name="Adi Gallia", front="https://i.imgur.com/NtfCKwG.jpeg", cost=3})
Card:new(Officer,Republic,{name="Clone Captain Silver", front="https://i.imgur.com/VzHNQTY.jpg", cost=4})
Card:new(Officer,Republic,{name="Clone Cmdr. Wolffe", front="https://i.imgur.com/pb3QjZp.jpg", cost=6})
Card:new(Officer,Republic,{name="Ahsoka Tano", front="https://i.imgur.com/SVAWnrZ.jpeg", cost=6})

--separatist
Card:new(Officer,Separatist,{name="Rune Haako", front="https://i.imgur.com/aEgMSwp.jpg", cost=4})
Card:new(Officer,Separatist,{name="Wat Tambor", front=ASSETS_ROOT.."cards/officers/wat_tambor_v2_1.jpg", cost=9})
Card:new(Officer,Separatist,{name="T-Series Tactical Droid", front="https://i.imgur.com/8H1wATK.jpeg", cost=4})
Card:new(Officer,Separatist,{name="Shu Mai", front="https://i.imgur.com/8dG1YpO.png", cost=4})
Card:new(Officer,Separatist,{name="TI-99", front="https://i.imgur.com/V9CYOEU.png", cost=4})
Card:new(Officer,Separatist,{name="Tikkes", front="https://i.imgur.com/l7G05tI.png", cost=2})
Card:new(Officer,Separatist,{name="San Hill", front="https://i.imgur.com/AcVqv40.png", cost=3})
Card:new(Officer,Separatist,{name="Passel Argente", front="https://i.imgur.com/fVSYbCJ.png", cost=6})
Card:new(Officer,Separatist,{name="Asajj Ventress", front=ASSETS_ROOT.."cards/officers/asajj_ventress_v2_1.jpg", cost=4})

--generic
Card:new(Officer,{name="Chart Officer", front="https://i.imgur.com/HVWr1Ru.jpg", cost=2})
Card:new(Officer,{name="Damage Control Officer", front="https://i.imgur.com/jsuMjsT.jpg", cost=5})
Card:new(Officer,{name="Defense Liaison", front="https://i.imgur.com/FqhDYBp.jpg", cost=3})
Card:new(Officer,{name="Engineering Captain", front="https://i.imgur.com/gOLEgHZ.jpg", cost=6})
Card:new(Officer,{name="Expert Shield Tech", front="https://i.imgur.com/bB1tz0h.jpg", cost=5})
Card:new(Officer,{name="Flight Commander", front="https://i.imgur.com/IqzvNR7.jpg", cost=3})
Card:new(Officer,{name="Hondo Ohnaka", front="https://i.imgur.com/ka4vK2h.jpg", cost=2})
Card:new(Officer,{name="Intel Officer", front="https://i.imgur.com/VvdtHvv.jpg", cost=7})
Card:new(Officer,{name="Navigation Officer", front="https://i.imgur.com/VKrSVRL.jpg", cost=6})
Card:new(Officer,{name="Skilled First Officer", front="https://i.imgur.com/6ipZf4i.jpg", cost=1})
-- Card:new(Officer,{name="Strategic Adviser", front=""})
Card:new(Officer,{name="Support Officer", front="https://i.imgur.com/fEdzGRr.jpg", cost=4})
Card:new(Officer,{name="Tactical Expert", front="https://i.imgur.com/aAvvHM6.jpg", cost=6})
Card:new(Officer,{name="Veteran Captain", front="https://i.imgur.com/GCmA53j.jpg", cost=3})
Card:new(Officer,{name="Weapons Liaison", front="https://i.imgur.com/XxbObBi.jpg", cost=3})
Card:new(Officer,{name="Wing Commander", front="https://i.imgur.com/FjHlkZC.jpg", cost=6})

----#include defs/cards/officer
----#include defs/cards/ordnance
Ordnance = {
    type="Ordnance",
    back = "https://i.imgur.com/6SrNHUo.png"
}
Card:new(Ordnance,{name="Assault Concussion Missiles", front="https://i.imgur.com/iuWMfEx.jpg", cost=5})
Card:new(Ordnance,{name="Assault Proton Torpedoes", front="https://i.imgur.com/ZHMQWZr.jpg", cost=4})
Card:new(Ordnance,{name="Expanded Launchers", front="https://i.imgur.com/PrpF5Sh.jpg", cost=13})
Card:new(Ordnance,{name="External Racks", front="https://i.imgur.com/0nzMm68.jpg", cost=4})
Card:new(Ordnance,{name="Flechette Torpedoes", front="https://i.imgur.com/ENBODz0.jpg", cost=3})
Card:new(Ordnance,{name="Ordnance Pods", front="https://i.imgur.com/bxshsaj.jpg", cost=3})
Card:new(Ordnance,{name="Rapid Reload", front="https://i.imgur.com/gX8DdhB.jpg", cost=8})
Card:new(Ordnance,{name="Wide-Area Barrage", front="https://i.imgur.com/HA96Xmz.jpg", cost=2})

----#include defs/cards/ordnance
----#include defs/cards/superweapon
SuperWeapon = {
    type="SuperWeapon",
    back = "https://i.imgur.com/wAfp2ow.jpeg"
}
Card:new(SuperWeapon,Rebel,{name="Magnite Crystal Tractor Beam Array", front="https://i.imgur.com/2YpzXNT.jpg", cost=10})
Card:new(SuperWeapon,Empire,{name="Orbital Bombardment Particle Cannons", front="https://i.imgur.com/t9VRV0n.jpg", cost=5}) --modification)
Card:new(SuperWeapon,Empire,{name="Superheavy Composite Beam Turbolasers", front="https://i.imgur.com/a7AycPb.jpg", cost=7}) --modification)

----#include defs/cards/superweapon
----#include defs/cards/support_team
SupportTeam = {
    type="SupportTeam",
    back = "https://i.imgur.com/WjGbQ3t.png"
}
--separatist
Card:new(SupportTeam,Separatist,{name="Battle Droid Reserves", front="https://i.imgur.com/ffhsdrO.jpeg", cost=4})

--generic
Card:new(SupportTeam,{name="Auxiliary Shields Team", front="https://i.imgur.com/SkNnm5P.jpg", cost=3})
Card:new(SupportTeam,{name="Engine Techs", front="https://i.imgur.com/5oEvYoq.jpg", cost=8})
Card:new(SupportTeam,{name="Engineering Team", front="https://i.imgur.com/ZmpFl4q.jpg", cost=5})
Card:new(SupportTeam,{name="Fighter Coordination Team", front="https://i.imgur.com/wKI96Sb.jpg", cost=3})
Card:new(SupportTeam,{name="Medical Team", front="https://i.imgur.com/jwf6kLG.jpg", cost=1})
Card:new(SupportTeam,{name="Nav Team", front="https://i.imgur.com/GdjIeBj.jpg", cost=4})
Card:new(SupportTeam,{name="Projection Experts", front="https://i.imgur.com/0hPAHTI.jpg", cost=6})

----#include defs/cards/support_team
----#include defs/cards/title
Title = {
    type="Title",
    back = "https://i.imgur.com/oBU2CKS.png"
}
--rebel
Card:new(Title,Rebel,{name="Bright Hope", front="https://i.imgur.com/ppRWBhH.jpg", cost=2})
Card:new(Title,Rebel,{name="Quantum Storm", front="https://i.imgur.com/Zvki0aa.jpg", cost=1})

Card:new(Title,Rebel,{name="Dodonna's Pride", front="https://i.imgur.com/XoROjrp.jpg", cost=6, aliases={"Dodonnas Pride"}})
Card:new(Title,Rebel,{name="Jaina's Light", front="https://i.imgur.com/v5gczKg.jpg", cost=2, aliases={"Jainas Light"}})
Card:new(Title,Rebel,{name="Liberator", front="https://i.imgur.com/zPLLjv2.jpg", cost=2})
Card:new(Title,Rebel,{name="Tantive IV", front="https://i.imgur.com/THWav9j.jpg", cost=3})

Card:new(Title,Rebel,{name="Garel's Honor", front="https://i.imgur.com/tl2VV0J.jpg", cost=4, aliases={"Garels Honor"}})
Card:new(Title,Rebel,{name="Task Force Antilles", front="https://i.imgur.com/NWw9f29.jpg", cost=3})
Card:new(Title,Rebel,{name="Task Force Organa", front="https://i.imgur.com/FwbIwpU.jpg", cost=1})

Card:new(Title,Rebel,{name="Redemption", front="https://i.imgur.com/Dp0ayI3.jpg", cost=8})
Card:new(Title,Rebel,{name="Salvation", front="https://i.imgur.com/xjIXfVD.jpg", cost=7})
Card:new(Title,Rebel,{name="Vanguard", front="https://i.imgur.com/4a6la8P.jpg", cost=4})
Card:new(Title,Rebel,{name="Yavaris", front="https://i.imgur.com/qtHU4B2.jpg", cost=5})

Card:new(Title,Rebel,{name="Phoenix Home", front="https://i.imgur.com/4pKVy0F.jpg", cost=3})

Card:new(Title,Rebel,{name="Admonition", front="https://i.imgur.com/rRIV5mH.jpg", cost=6})
Card:new(Title,Rebel,{name="Foresight", front="https://i.imgur.com/HpSit4j.jpg", cost=8})

Card:new(Title,Rebel,{name="Gallant Haven", front="https://i.imgur.com/Foap6UL.jpg", cost=8})
Card:new(Title,Rebel,{name="Paragon", front="https://i.imgur.com/1lMOUvu.jpg", cost=5})

Card:new(Title,Rebel,{name="Defiance", front="https://i.imgur.com/cBm6bOA.jpg", cost=5})
Card:new(Title,Rebel,{name="Home One", front="https://i.imgur.com/ao1aUWd.jpg", cost=7})
Card:new(Title,Rebel,{name="Independence", front="https://i.imgur.com/eeJ4K4e.jpg", cost=8})

Card:new(Title,Rebel,{name="Endeavor", front="https://i.imgur.com/YQO9jve.jpg", cost=4})
Card:new(Title,Rebel,{name="Liberty", front="https://i.imgur.com/gnoxT5J.jpg", cost=3})
Card:new(Title,Rebel,{name="Mon Karren", front="https://i.imgur.com/JbMnQpC.jpg", cost=6})

Card:new(Title,Rebel,{name="Aspiration", front="https://i.imgur.com/O0n3gY9.jpg", cost=3})
Card:new(Title,Rebel,{name="Profundity", front="https://i.imgur.com/P0LQ9NC.jpg", cost=7})

Card:new(Title,Rebel,{name="Mon Calamari Exodus Fleet", front="https://i.imgur.com/Gi02xgi.jpg", cost=5})

Card:new(Title,Rebel,{name="Amity", front="https://i.imgur.com/BcOXgXM.jpg", cost=6})
Card:new(Title,Rebel,{name="Concord", front="https://i.imgur.com/76LdzqR.jpg", cost=12})
Card:new(Title,Rebel,{name="Unity", front="https://i.imgur.com/RP1KPrl.jpg", cost=10})
--imperial
Card:new(Title,Empire,{name="Suppressor", front="https://i.imgur.com/11G4bE0.jpg", cost=4})
Card:new(Title,Empire,{name="Vector", front="https://i.imgur.com/h7NhmMa.jpg", cost=2})

Card:new(Title,Empire,{name="Impetuous", front="https://i.imgur.com/3fOmzlk.jpg", cost=4})
Card:new(Title,Empire,{name="Instigator", front="https://i.imgur.com/dht3fJ6.jpg", cost=4})
Card:new(Title,Empire,{name="Corvus", front="https://i.imgur.com/huKZyhu.jpg", cost=2})

Card:new(Title,Empire,{name="Centicore", front="https://i.imgur.com/y41PoZy.jpg", cost=3})
Card:new(Title,Empire,{name="Hand of Justice", front="https://i.imgur.com/gfeIVpM.jpg", cost=4})

Card:new(Title,Empire,{name="Demolisher", front="https://i.imgur.com/lIICVGX.jpg", cost=10})
Card:new(Title,Empire,{name="Insidious", front="https://i.imgur.com/lJU1Qr0.jpg", cost=3})

Card:new(Title,Empire,{name="Pursuant", front="https://i.imgur.com/8971Me7.jpg", cost=2})
Card:new(Title,Empire,{name="Squall", front="https://i.imgur.com/IPQVSGM.jpg", cost=3})
Card:new(Title,Empire,{name="Stronghold", front="https://i.imgur.com/1UwT76i.jpg", cost=3})

Card:new(Title,Empire,{name="Corrupter", front="https://i.imgur.com/n8Plm1g.jpg", cost=5})
Card:new(Title,Empire,{name="Dominator", front="https://i.imgur.com/d03SuuK.jpg", cost=12})
Card:new(Title,Empire,{name="Harrow", front="https://i.imgur.com/2j7zspi.jpg", cost=3})
Card:new(Title,Empire,{name="Warlord", front="https://i.imgur.com/E8oYSJj.jpg", cost=8})

Card:new(Title,Empire,{name="Interdictor", front="https://i.imgur.com/sIO1x2W.jpg", cost=3})

Card:new(Title,Empire,{name="Cataclysm", front="https://i.imgur.com/BJwwHvW.jpg", cost=5})
Card:new(Title,Empire,{name="Rakehell", front="https://i.imgur.com/R3NVdce.jpg", cost=4})
Card:new(Title,Empire,{name="Sunder", front="https://i.imgur.com/qs97P5O.jpg", cost=10})

Card:new(Title,Empire,{name="Avenger", front="https://i.imgur.com/UOIKPqu.jpg", cost=5})
Card:new(Title,Empire,{name="Chimaera", front="https://i.imgur.com/o5AtxcG.jpg", cost=4})
Card:new(Title,Empire,{name="Devastator", front="https://i.imgur.com/nKieVmI.jpg", cost=10})
Card:new(Title,Empire,{name="Relentless", front="https://i.imgur.com/AT9rKe4.jpg", cost=3})
Card:new(Title,Empire,{name="Sovereign", front="https://i.imgur.com/AnJZEFb.jpg", cost=4})

Card:new(Title,Empire,{name="Seventh Fleet Star Destroyer", front="https://i.imgur.com/G90ZE7x.jpg", cost=5})

Card:new(Title,Empire,{name="Annihilator", front="https://i.imgur.com/R9rr8vA.jpg", cost=8})
Card:new(Title,Empire,{name="Eclipse", front="https://i.imgur.com/Vnmp8CR.jpg", cost=3})
Card:new(Title,Empire,{name="Executor", front="https://i.imgur.com/OGaToRQ.jpg", cost=2})
Card:new(Title,Empire,{name="Ravager", front="https://i.imgur.com/AcTzTTY.jpg", cost=4})

--republic
Card:new(Title,Republic,{name="Radiant VII", front="https://i.imgur.com/kTBiAsS.jpg", cost=1})
Card:new(Title,Republic,{name="Swift Return", front="https://i.imgur.com/lVSb7xQ.jpeg", cost=3})

Card:new(Title,Republic,{name="Implacable", front="https://i.imgur.com/Y8uSW2V.jpeg", cost=4})
Card:new(Title,Republic,{name="Nevoota Bee", front="https://i.imgur.com/bBFNBzc.jpeg", cost=5})

--separatist
Card:new(Title,Separatist,{name="Beast of Burden", front="https://i.imgur.com/0dOnlMq.jpeg", cost=6})
Card:new(Title,Separatist,{name="Foreman's Labor", front="https://i.imgur.com/cfJ004t.jpeg", cost=5, aliases = {"Foremans Labor"}})

Card:new(Title,Separatist,{name="Sa Nalaor", front="https://i.imgur.com/o0RS5kE.jpg", cost=5})
Card:new(Title,Separatist,{name="Tide of Progress XII", front="https://i.imgur.com/rcXW6sg.jpeg", cost=2})

Card:new(Title,Separatist,{name="Invisible Hand", front="https://i.imgur.com/gW84lFN.png", cost=9, aliases = {"Invisible-hand"}})
Card:new(Title,Separatist,{name="Invincible", front="https://i.imgur.com/NcS65Gb.png", cost=5})
Card:new(Title,Separatist,{name="Lucid Voice", front="https://i.imgur.com/b5i7cIW.png", cost=8})

Card:new(Title,Separatist,{name="Patriot Fist", front="https://i.imgur.com/032w54v.png", cost=6})
Card:new(Title,Separatist,{name="Nova Defiant", front="https://i.imgur.com/baLcwQJ.png", cost=4})
Card:new(Title,Separatist,{name="Gilded Aegis", front="https://i.imgur.com/wbFFUaq.png", cost=5})

Card:new(Title,Republic,{name="TB-73", front="https://i.imgur.com/IONCQi6.png", cost=5})
Card:new(Title,Republic,{name="FB-88", front="https://i.imgur.com/l5LNFSR.png", cost=4})

Card:new(Title,Republic,{name="Tranquility", front=ASSETS_ROOT.."cards/titles/tranquility_v2_1.jpg", cost=7})
Card:new(Title,Republic,{name="Triumphant", front="https://i.imgur.com/OTgslNK.png", cost=5})
Card:new(Title,Republic,{name="Resolute", front="https://i.imgur.com/TVoRURO.png", cost=6})

----#include defs/cards/title
----#include defs/cards/turbolaser
Turbolaser = {
    type="Turbolaser",
    back = "https://i.imgur.com/YwrHjHG.png"
}
CloneWars = {
    factions={"Republic","Separatist"}
}
--Republic/Separatist
Card:new(Turbolaser,CloneWars,{name="Swivel-Mount Batteries", front="https://i.imgur.com/QyfrQ24.jpeg", cost=8}) --modification)

--generic
Card:new(Turbolaser,{name="Dual Turbolaser Turrets", front="https://i.imgur.com/RfHrc24.jpg", cost=5}) --modification)
Card:new(Turbolaser,{name="Enhanced Armament", front="https://i.imgur.com/fixRACB.jpg", cost=10}) --modification)
Card:new(Turbolaser,{name="H9 Turbolasers", front="https://i.imgur.com/vPAmdyc.jpg", cost=8}) --modification)
Card:new(Turbolaser,{name="Heavy Fire Zone", front="https://i.imgur.com/f0phD19.jpg", cost=4})
Card:new(Turbolaser,{name="Heavy Turbolaser Turrets", front="https://i.imgur.com/1BzH8yv.jpg", cost=6})
Card:new(Turbolaser,{name="Linked Turbolaser Towers", front="https://i.imgur.com/Zxt5U1V.jpg", cost=7})
Card:new(Turbolaser,{name="Quad Battery Turrets", front="https://i.imgur.com/OpE4elu.jpg", cost=5}) --modification)
Card:new(Turbolaser,{name="Quad Turbolaser Cannons", front="https://i.imgur.com/QdRydD8.jpg", cost=10}) --modification)
Card:new(Turbolaser,{name="Slaved Turrets", front="https://i.imgur.com/J9NmUDb.jpg", cost=6}) --modification)
Card:new(Turbolaser,{name="Spinal Armament", front="https://i.imgur.com/0eLX7ML.jpg", cost=9}) --modification)
Card:new(Turbolaser,{name="Turbolaser Reroute Circuits", front="https://i.imgur.com/6faOpzf.jpg", cost=7})
Card:new(Turbolaser,{name="XI7 Turbolasers", front="https://i.imgur.com/leeZbxw.jpg", cost=6})
Card:new(Turbolaser,{name="XX-9 Turbolasers", front="https://i.imgur.com/ttbae06.jpg", cost=5})
Card:new(Turbolaser,{name="DBY-827 Heavy Turbolaser", front="https://i.imgur.com/wNkyRDb.png", cost=3, aliases = {"DBY-827 Heavy Turbolasers"}})

----#include defs/cards/turbolaser
----#include defs/cards/weapons_team_and_offensive_retrofit
WeaponsTeamAndOffensiveRetrofit = {
    type="WeaponsTeamAndOffensiveRetrofit",
    back = "https://i.imgur.com/mPu7lfL.png"
}
--rebel
Card:new(WeaponsTeamAndOffensiveRetrofit,Rebel,{name="Cham Syndulla", front="https://i.imgur.com/1UBq5nW.jpg", cost=5})
Card:new(WeaponsTeamAndOffensiveRetrofit,Rebel,{name="Jyn Erso", front="https://i.imgur.com/PJTbNuK.jpg", cost=4})
Card:new(WeaponsTeamAndOffensiveRetrofit,Rebel,{name="Shriv Suurgav", front="https://i.imgur.com/0y9SkmF.jpg", cost=6})

--imperial
Card:new(WeaponsTeamAndOffensiveRetrofit,Empire,{name="Darth Vader", front="https://i.imgur.com/8Xu7fJp.jpg", cost=3})

--generic
Card:new(WeaponsTeamAndOffensiveRetrofit,{name="Boarding Engineers", front="https://i.imgur.com/iIj1jTC.jpg", cost=2})
Card:new(WeaponsTeamAndOffensiveRetrofit,{name="Boarding Troopers", front="https://i.imgur.com/U9MB7cI.jpg", cost=3})

----#include defs/cards/weapons_team_and_offensive_retrofit
----#include defs/cards/weapons_team
WeaponsTeam = {
    type="WeaponsTeam",
    back = "https://i.imgur.com/GhAHc4B.png"
}

--rebel
Card:new(WeaponsTeam,Rebel,{name="Caitken and Shollan", front="https://i.imgur.com/5msklkl.jpg", cost=6})

--imperial
Card:new(WeaponsTeam,Empire,{name="Gunnery Chief Varnillian", front="https://i.imgur.com/JG9I88l.jpg", cost=6})

--republic
Card:new(WeaponsTeam,Republic,{name="Clone Gunners", front="https://i.imgur.com/8Rr4vE5.jpeg", cost=4})

--generic
Card:new(WeaponsTeam,{name="Fire-Control Team", front="https://i.imgur.com/VFlRiDL.jpg", cost=2})
Card:new(WeaponsTeam,{name="Flight Controllers", front="https://i.imgur.com/3WO48B6.jpg", cost=6})
Card:new(WeaponsTeam,{name="Gunnery Team", front="https://i.imgur.com/Jw2Qhgz.jpg", cost=7})
Card:new(WeaponsTeam,{name="Local Fire Control", front="https://i.imgur.com/OepfCdw.jpg", cost=4})
Card:new(WeaponsTeam,{name="Ordnance Experts", front="https://i.imgur.com/3SpyXDz.jpg", cost=4})
Card:new(WeaponsTeam,{name="Ruthless Strategists", front="https://i.imgur.com/2mDorqh.jpg", cost=4})
Card:new(WeaponsTeam,{name="Sensor Team", front="https://i.imgur.com/pnn0pOz.jpg", cost=5})
Card:new(WeaponsTeam,{name="Veteran Gunners", front="https://i.imgur.com/mYGP8R6.jpg", cost=5})
Card:new(WeaponsTeam,{name="Weapons Battery Techs", front="https://i.imgur.com/wQ6S57i.jpg", cost=5})

----#include defs/cards/weapons_team

----#include defs/cards/objectives
Objective = {
    type="Objective",
    back = "https://i.imgur.com/6mOLyyo.jpeg"
}

Assault = { category = "Assault" }
Card:new(Assault, Objective, {name="Advanced Gunnery", front="https://i.imgur.com/3dV3CQL.png"})
Card:new(Assault, Objective, {name="Blockade Run", front="https://i.imgur.com/uy3nABn.png", victory=20})
Card:new(Assault, Objective, {name="Close-Range Intel Scan", front="https://i.imgur.com/metfsL6.png", victory=10})
Card:new(Assault, Objective, {name="Ion Storm", front="https://i.imgur.com/EvRHvo6.png", victory=15})
Card:new(Assault, Objective, {name="Marked for Destruction", front="https://i.imgur.com/Jl513DV.png", victory=15})
Card:new(Assault, Objective, {name="Most Wanted", front="https://i.imgur.com/AYUAvDe.png"})
Card:new(Assault, Objective, {name="Opening Salvo", front="https://i.imgur.com/mU3mg9Y.png"})
Card:new(Assault, Objective, {name="Precision Strike", front="https://i.imgur.com/5PrHKKV.png", victory=15})
Card:new(Assault, Objective, {name="Rift Assault", front="https://i.imgur.com/h0sCMti.png", victory=10})
Card:new(Assault, Objective, {name="Station Assault", front="https://i.imgur.com/RZQ6WiC.png", victory=40})
Card:new(Assault, Objective, {name="[Ship Card] Unarmed Station", front="https://i.imgur.com/pr34PEA.jpeg"})
Card:new(Assault, Objective, {name="Surprise Attack", front="https://i.imgur.com/WAg0yAC.png"})
Card:new(Assault, Objective, {name="Targeting Beacons", front="https://i.imgur.com/hkF4kTT.png"})

Defense = { category = "Defense" }
Card:new(Defense, Objective, {name="Abandoned Mining Facility", front="https://i.imgur.com/FisDnrA.png", victory=10})
Card:new(Defense, Objective, {name="Asteroid Tactics", front="https://i.imgur.com/FDqrQoA.png"})
Card:new(Defense, Objective, {name="Capture the VIP", front="https://i.imgur.com/LKfjSzk.png", victory=50})
Card:new(Defense, Objective, {name="Contested Outpost", front="https://i.imgur.com/Ksycqqu.png", victory=20})
Card:new(Defense, Objective, {name="Fighter Ambush", front="https://i.imgur.com/QcWcYBQ.png", victory=15})
Card:new(Defense, Objective, {name="Fire Lanes", front="https://i.imgur.com/1d7wzLM.png", victory=15})
Card:new(Defense, Objective, {name="Fleet Ambush", front="https://i.imgur.com/vm9LLJo.png"})
Card:new(Defense, Objective, {name="Fleet in Being", front="https://i.imgur.com/GIX4wWL.png", victory=15})
Card:new(Defense, Objective, {name="Hyperspace Assault", front="https://i.imgur.com/GqjQIK3.png"})
Card:new(Defense, Objective, {name="Jamming Barrier", front="https://i.imgur.com/hNJ6INI.png"})
Card:new(Defense, Objective, {name="Planetary Ion Cannon", front="https://i.imgur.com/psjZcZb.png"})
Card:new(Defense, Objective, {name="Rift Ambush", front="https://i.imgur.com/a2rih6q.png"})

Navigation = { category = "Navigation" }
Card:new(Navigation, Objective, {name="Dangerous Territory", front="https://i.imgur.com/DIlMCHD.png", victory=15})
Card:new(Navigation, Objective, {name="Doomed Station", front="https://i.imgur.com/SZ8kaLu.png", victory=20})
Card:new(Navigation, Objective, {name="Hyperspace Migration", front="https://i.imgur.com/oQO2QV0.png", victory=20})
Card:new(Navigation, Objective, {name="Infested Fields", front="https://i.imgur.com/FrULG6O.png", victory=15})
Card:new(Navigation, Objective, {name="Intel Sweep", front="https://i.imgur.com/whvJxjk.png"})
Card:new(Navigation, Objective, {name="Minefields", front="https://i.imgur.com/9HOIdHa.png"})
Card:new(Navigation, Objective, {name="Navigational Hazards", front="https://i.imgur.com/FaFVElY.png", victory=15})
Card:new(Navigation, Objective, {name="Salvage Run", front="https://i.imgur.com/VLUPsmd.png", victory=20})
Card:new(Navigation, Objective, {name="Sensor Net", front="https://i.imgur.com/tLdaZPu.png", victory=15})
Card:new(Navigation, Objective, {name="Solar Corona", front="https://i.imgur.com/7YfXYte.png"})
Card:new(Navigation, Objective, {name="Superior Positions", front="https://i.imgur.com/eL4Ow8N.png", victory=15})
Card:new(Navigation, Objective, {name="Volatile Deposits", front="https://i.imgur.com/tiR18cD.png", victory=15})

Special = { category = "Special" }
Card:new(Special, Objective, {name="Base Defense: Armed Station", front="https://i.imgur.com/uuS6Bgr.png"})
Card:new(Special, Objective, {name="[Ship Card] Armed Station", front="https://i.imgur.com/8bxI1du.jpeg"})
Card:new(Special, Objective, {name="Base Defense: Fighter Wing", front="https://i.imgur.com/HSGDnta.png"})
Card:new(Special, Objective, {name="Base Defense: Ion Cannon", front="https://i.imgur.com/qpZfp8c.png"})
Card:new(Special, Objective, {name="Hyperlane Raid", front="https://i.imgur.com/vqS5veh.png", victory=15})
Card:new(Special, Objective, {name="Show of Force", front="https://i.imgur.com/GJvRA00.png", victory=20})
--Corellian Conflict
Card:new(Special, Objective, {name="Asteroids", front="https://i.imgur.com/u27Su4O.png"})
Card:new(Special, Objective, {name="Independent Station", front="https://i.imgur.com/I08mCTY.png"})
Card:new(Special, Objective, {name="Nebula Outskirts", front="https://i.imgur.com/60jSGex.png"})
--Rebellion in the Rim
Card:new(Special, Objective, {name="Double Agent", front="https://i.imgur.com/gsxsug1.png", victory=20})
Card:new(Special, Objective, {name="Hired Scum", front="https://i.imgur.com/uSeL1Iv.png"})
Card:new(Special, Objective, {name="Holonet Override", front="https://i.imgur.com/2DnZ1Ha.png", victory=10})
Card:new(Special, Objective, {name="Pilot Defection", front="https://i.imgur.com/p4tl1sP.png", victory=25})
Card:new(Special, Objective, {name="Prototype Recovery", front="https://i.imgur.com/QIaiFWk.png", victory=30})
Card:new(Special, Objective, {name="Recruit Allies", front="https://i.imgur.com/9PqROM7.png"})
Card:new(Special, Objective, {name="Steal Supplies", front="https://i.imgur.com/ytyYixO.png", victory=15})
Card:new(Special, Objective, {name="Volatile Cargo", front="https://i.imgur.com/N0MR24N.png", victory=15})

Card:new(Special, Objective, {name="Low Fuel", front="https://i.imgur.com/L5Vpk1x.jpeg"})
Card:new(Special, Objective, {name="Low Morale", front="https://i.imgur.com/pVL0ttA.jpeg"})
Card:new(Special, Objective, {name="Low Supplies", front="https://i.imgur.com/TdrrOqs.jpeg"})

----#include defs/cards/objectives
    setRulerMeshes()
    findObjective(true)
    -- drawListSpawnerButtons()
end
function setRulerMeshes()
    for _,ship in ipairs(getAllObjects()) do
        if ship.tag == 'Figurine' then
            for key,ship_def in pairs(SHIPS) do
                --printToAll("Checking Ship Def: "..key,{0,1,1})
                if ship_def.mesh == ship.getCustomObject().mesh then
                    ship.setVar("rulerMesh",ship_def.ruler)
                    --printToAll("set ruler for: "..ship_def.ruler,{0,1,1})
                end
            end
        end
    end
end
-- function drawListSpawnerButtons()
--     for _,listSpawner in ipairs(getAllObjects()) do
--         if listSpawner.getName()=="List Spawner" then
--             Action_CloseListSpawner(listSpawner)
--         end
--     end
-- end
-- function Action_CloseListSpawner(listSpawner)
--     listSpawner.clearButtons()
--     listSpawner.clearInputs()
--     listSpawner.createButton({label = ">", click_function = 'Action_OpenListSpawner', rotation = {0, 0, 0},
--         position = {0.4, 0.4, -5.9}, width = 400, height = 400, font_size = 300, function_owner = self, color={0,1,0}, font_color={0,0,0}})
--
-- end
-- function Action_OpenListSpawner(listSpawner)
--     listSpawner.clearButtons()
--     listSpawner.clearInputs()
--     listSpawner.createButton({label = "<", click_function = 'Action_CloseListSpawner', rotation = {0, 0, 0},
--         position = {-0.4, 0.2, -5.9}, width = 400, height = 400, font_size = 300, function_owner = self, color={1,0,0}, font_color={0,0,0}})
--     listSpawner.createInput({label = "paste list here", input_function = 'Input_UpdateList', rotation = {0, 0, 0},
--         position = {3.2, 0.2, 0}, width = 3000, height = 6000, font_size = 85, function_owner = self, font_color={0,0,0}})
--     listSpawner.createButton({label = "V V V     Spawn!     V V V", click_function = 'Action_SpawnListSpawner', rotation = {0, -90, 0},
--         position = {7, 0.2, 0}, width = 6000, height = 500, font_size = 400, function_owner = self, color={0,1,0}, font_color={0,0,0}})
--     listSpawner.createButton()
-- end
function Input_UpdateList(obj, color, input, stillEditing)
    obj.setVar("list",input)
end
function replace(input, pattern, replace)
    local output = string.gsub(input, pattern, replace)
    -- if output~=input then
    --     printToAll("Applied: '"..pattern.."'. '"..input.."' -> '"..output.."'")
    -- end
    return output
end
A_COLORS = {{1,0,0},
            {1,0.65,0},
            {1,1,0},
            {0.78,0.08,0.52},
            {0.55,0,0},
            {0.94,0.9,0.55},
            {0.87,0.63,0.87},
            {1,0.63,0.87},
            {1,0,1},
            {0.5,0.5,0}}
B_COLORS = {{0.1,0.1,0.44},
            {0.5,1,0},
            {0,0.75,1},
            {0.86,0.86,0.86},
            {0.18,0.55,0.34},
            {0,0,1},
            {0,0.98,0.6},
            {0,1,1},
            {0.48,0.41,0.93},
            {0.18,0.31,0.31}}
function inFleetSpawnArea(listSpawner, obj)
    ll = {1.2,0,-5}
    ur = {109,0,14}
    if math.abs(listSpawner.getPosition()[3])>40 then
        ur = {87, 0, 14}
    end
    return vector.between(listSpawner.positionToLocal(obj.getPosition()), ll, ur)
end
function clearSpawnArea(listSpawner)
    for _,item in ipairs(getAllObjects()) do
        if inFleetSpawnArea(listSpawner,item) and not isDatacard(item) and item.tag~="Scripting" and not string.match(item.getName(),"List Spawner") then
            item.destruct()
        end
    end
end
function isDatacard(object)
    custom = object.getCustomObject()
    return custom ~= nil and (custom.mesh == ASSETS_ROOT.."misc/datacard.obj" or custom.mesh == "http://paste.ee/r/uY3YX")
end
function Action_SpawnListSpawner(player, _, idValue) --listSpawner
    print(player.color)
    listSpawner = findObjectByName("List Spawner ("..player.color..")")
    clearSpawnArea(listSpawner)
    -- local count = 0
    -- for k,v in pairs(SHIPS) do
    --     count = count+1
    -- end
    local list = listSpawner.getVar("list")
    -- print(#list)
    if list==nil or #list==0 then
        printToAll("Paste in fleet to spawn",{1,1,0})
        return
    end
    lines = list:split("\n")
    -- print(#lines)
    -- x = 6
    -- i_y = 0
    -- max_i_y = 3
    -- y_offset = 3.5
    -- x_offset = 2.5

    fleet = {
        objectives = {},
        ships = {},
        squads = {}
    }

    last_ship = nil
    first_line = true
    line_objs = {}
    for _,line in ipairs(lines) do
        if first_line then
            first_line = false
        elseif not line:starts "=" then
            -- print("Parsing line: '"..line.."'")
            orig = line
            line = string.strip(line)
            count = string.match(line, "^•%s+(%d+)%s+x%s+")
            if count==nil then
                count = string.match(line, "^(%d+)%s+")
            end
            -- if count~=nil then
            --     print("Found count: "..tostring(count))
            -- end
            line = replace(line, "^Author:.*","")
            line = replace(line, "^Faction:.*","")
            line = replace(line, "^Commander:.*","")
            line = replace(line, "^Points:.*","")
            line = replace(line, "^Squadrons:.*","")
            line = replace(line, " Objective:",":") -- Shorten "Assault Objective: " to "Assault:"
            line = replace(line, "Assault: ","") -- Remove objective types
            line = replace(line, "Defense: ","") -- Remove objective types
            line = replace(line, "Navigation: ","") -- Remove objective types
            line = replace(line, "%s%+%s%d+%:%s%d+","") -- handle Starhawk-class Mk.II (150 + 84: 234)
            line = replace(line, "[%s ]+%(com%)","") -- remove " (com)" indicator
            line = replace(line, "[%s ]+%(off%)","") -- remove " (off)" indicator
            line = replace(line, "•%s+%d+%s+x%s+","") -- remove "• 2 x " for squadrons
            line = replace(line,"^%d+[%s ]+","") -- remove "2 " for squadrons
            line = replace(line, "^[•%-·][%s ]+","") -- remove all bullets NOTE: THAT IS NOT A NORMAL SPACE!
            -- line = replace(line,"^%-%s+","") -- replace by above
            line = replace(line,"[%s ]+%([%s ]*(%d+)[%s ]+points%)$"," (%1)") -- Shorten " ( 5 points)" -> " (5)"
            line = replace(line,"%[[%s ]+flagship[%s ]+%][%s ]+","") -- remove "[ flagship ]" indicato"
            line = replace(line,"%(%s*(%d+)%s*%)$","(%1)") -- shorten "( 5 )" to "(5)"
            line = string.strip(line) -- remove leading/training spaces
            line = replace(line," +"," ") -- remove all multiple spaces
            line_nocost = string.gsub(line,"[%s ]+%([%s ]*%d+[%s ]*%)$","") -- create version without trailing cost" (5)"
            cost = string.match(line,"[%s ]+%([%s ]*(%d+)[%s ]*%)$")

            if line ~="" then
                def = CARDS[string.lower(line)] or SHIPS[string.lower(line)] or CARDS[string.lower(line_nocost)] or SHIPS[string.lower(line_nocost)]
                if def==nil then
                    def = findDefinitionByName(SHIPS, line, true)
                end
                if def~=nil then
                    if def.type == "Objective" then --IS OBJECTIVE
                        table.insert(fleet.objectives, {def=obj.def})
                    elseif def.maneuver~=nil then --IS SHIP
                        last_ship = {def=def, upgrades = {}}
                        table.insert(fleet.ships, last_ship)
                    elseif def.move~=nil then
                        table.insert(fleet.squads, {def=def, count=tonumber(count)})
                    else --MUST BE UPGRADE????
                        if last_ship==nil then
                            printToAll("Cannot spawn upgrade: "..def.name.." since no ship found?",{1,0,0})
                        else
                            table.insert(last_ship.upgrades, def)
                        end
                    end
                else
                    -- printToAll("No definition found for: '"..line.."'",{1,0,0})
                end
            end
        end
    end

    layout(nil, fleet, listSpawner.getPosition(), listSpawner.getRotation())
end
function createSpawningStructure(lineobjs)
    if lineobjs==nil then return nil end
    fleet = {
        objectives = {},
        ships = {},
        squads = {}
    }
    last_ship = nil
    for _,obj in ipairs(lineobjs) do
        -- if line ~="" then
            -- def = CARDS[string.lower(line)] or SHIPS[string.lower(line)] or CARDS[string.lower(line_nocost)] or SHIPS[string.lower(line_nocost)]
            -- if def==nil then
                -- def = findDefinitionByName(SHIPS, line, true)
            -- end
        if obj.def~=nil then
            if obj.def.type == "Objective" then --IS OBJECTIVE
                table.insert(fleet.objectives, {def=obj.def, card=obj.card})
            elseif obj.def.maneuver~=nil then --IS SHIP
                last_ship = {def=obj.def, upgrades = {}, upgradeCost=0, card=obj.card}
                table.insert(fleet.ships, last_ship)
            elseif obj.def.move~=nil then
                table.insert(fleet.squads, {def=obj.def, count=tonumber(obj.count) or 1, card=obj.card})
            else --MUST BE UPGRADE????
                if last_ship==nil then
                    printToAll("Cannot spawn upgrade: "..obj.def.name.." since no ship found?",{1,0,0})
                else
                    last_ship.upgradeCost = last_ship.upgradeCost+obj.def.cost
                    table.insert(last_ship.upgrades, obj.def)
                end
            end
        else
            -- printToAll("No definition found for: '"..obj.original.."'",{1,0,0})
        end
        -- end
    end
    return fleet
end
-- lines {original="",parse="",cost="", def="",count=nil}
function findDefinitionByName(DEFS, name, fuzzy)
    def = DEFS[string.lower(name)]
    if fuzzy == true then
        printToAll("I can't find: '"..name.."'. Performing deep search...",{1,0,0})
        bestKey = fuzzyStringSearch(name)
        printToAll("The best I can find is: '"..tostring(bestKey).."'")
        def = SHIPS[bestKey]
        if def == nil then
            def = CARDS[bestKey]
        end
    end
    return def
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function fuzzyStringSearch(s)
    s = string.lower(s)
    -- print("#NGRAMS"..tablelength(NGRAMS))
    matches = {}
    n = #s
    s = " "..s.." "
    -- print("Searching: '"..s.."'")
    for i = 1,n do
        sub = string.sub(s,i,i+2)
        -- print("Looking for: '"..sub.."'")
        if NGRAMS[sub]~=nil then
            -- print("Potential "..#(NGRAMS[sub]).." matches for: "..sub)
            for _,match in ipairs(NGRAMS[sub]) do
                -- if match=="tie fighter squadron (8)" or match=="hyena-class droid bomber squadron (11)" then
                --     print(sub.." "..match)
                -- end
                if matches[match]==nil then
                    matches[match] = 1
                else
                    matches[match] = matches[match]+1
                end
            end
        end
    end
    bestCount = 0
    best = nil
    for k,v in pairs(matches) do
        if v>bestCount then
            -- print(k.." "..v.." NGRAM matches")
            bestCount=v
            best = k
        end
    end
    return best
end
--{
--    objectives={def,def,def}
--    ships={{def, upgrades:{def, def, def, def, def},{def, upgrades:{def, def, def, def, def}}
--    squads={{def:def, count:1}}
--}
function donothing() end
function layout(player, fleet, pos, rot, base_x, spawn)
    if base_x==nil then
        base_x=0
    end
    if spawn==nil then
        spawn=true
    end
    local x = base_x --9
    local i_y = 0
    local MAX_I_Y = 3
    local Y_OFFSET = 3.5
    local X_OFFSET = 3
    local OBJ_X_GAP = 4.5
    local SHIP_PRE_X_GAP = 2.5
    local SHIP_POST_X_GAP = 7
    local SQUAD_X_GAP = 5.5
    if spacing=="Compact" then --(#fleet.ships * 2 + #fleet.squads) >12 then
        local x = base_x --8
        OBJ_X_GAP = 3.5
        X_OFFSET = 2.1
        SHIP_PRE_X_GAP = 1
        SHIP_POST_X_GAP = 4
        SQUAD_X_GAP = 4
    end
    local MAX_X = 104
    -- print(x)
    for i,obj in ipairs(fleet.objectives) do
        -- printToAll("Objective: "..def.name,{1,1,1})
        if spawn then
            spawnCard(obj.def, pos, {x,0,4-(i-1)*Y_OFFSET}, vector.add(rot,{0,0,180}))
        end
    end
    x = x+OBJ_X_GAP

    if spawn then
        source = getObjectFromGUID(COMMAND_SOURCE)
        command_source_poses = {
            Vector(-1,0,1),
            Vector(1,0,1),
            Vector(1,0,-1),
            Vector(-1,0,-1)
        }
        command_source_rots = { 0, 90, 180, 270 }
        command_source_guids = {
            'e0b0d2',
            'b83199',
            '630f97',
            '0795c1'
        }
        CMD_COLORS = {
            {0.4,0.8,0.4,1.11}, --repair
            {0.8,0.4,0.4,1.11}, --concentrate
            {0.2, 0.4, 0.8,1.11}, --navigate
            {0.8,0.4,0.8,1.11} --squadron
        }
        --CMD_MESHES
        for i=1,4 do
            local obj_parameters = {}
            obj_parameters.position = vector.add(pos,vector.rotate(vector.add(command_source_poses[i],{x-4,4,9.5}),rot[2])) --{x-2,5,9.5}
            -- print(obj_parameters.position[1],",",obj_parameters.position[2],",",obj_parameters.position[3])
            source = getObjectFromGUID(command_source_guids[i])
            command_source = source.clone(obj_parameters)

            command_source.setRotation(vector.add(rot,{0,i*90 + 45,180}))
            command_source.setScale({0.65,0.65,0.65})
            command_source.setColorTint({0.5,0.5,0.5})
            command_source.createButton({label = i, click_function="donothing", font_size=2000, position=vector.add({0,-0.5,0},{0,0,0.6}), rotation={180,-(i*90+45),0}, color={0,0,0,0.9}, font_color=CMD_COLORS[i], width=0, height=0})
            if i==1 then
                command_source.createButton({label = "Press 1-4\nto switch\nCommands", click_function="donothing", font_size=200, position={0,-0.5,2.1}, rotation={180,225,0}, color={0,0,0}, font_color={1,1,1}, width=0, height=0})
            end
        end

        for i,source_guid in ipairs(COMMAND_TOKEN_SOURCES) do
            source = getObjectFromGUID(source_guid)
            local obj_parameters = {}
            obj_parameters.position = vector.add(pos,vector.rotate(vector.add(vector.scale(command_source_poses[i],2.2),{x-4,-1,9.5}),rot[2]))
            -- obj_parameters.position = vector.add(pos,vector.rotate({x,-1,7.5-i*3},rot[2]-180))
            token_source = source.clone(obj_parameters)
            token_source.setRotation(rot+Vector(0,180,0))
        end
    end
    x = x+OBJ_X_GAP
    -- print(x)
    for i,ship in ipairs(fleet.ships) do
        if #ship.def.shields==6 then -- SSD GAP
            x = math.min(x+2, MAX_X)
        end
        i_y = 0
        -- printToAll("Ship: "..ship.def.name,{0,1,1})
        if spawn then
            spawnCard(ship.def, pos, {x,0,3.3}, rot, 1)
        end
        x = math.min(x+SHIP_PRE_X_GAP, MAX_X)
        if #ship.def.shields==6 then -- SSD GAP
            x = math.min(x+2, MAX_X)
        end
        for _,def in ipairs(ship.upgrades) do
            if i_y==0 then x = math.min(x+X_OFFSET, MAX_X) end
            -- printToAll("Upgrade: "..def.name,{1,1,0})
            -- print("("..x..","..i_y..")")
            if spawn then
                spawnCard(def, pos, {x,0,4-i_y*Y_OFFSET}, rot, nil)
            end
            -- print("math.mod("..i_y.."+1, "..MAX_I_Y..") = "..math.mod(i_y+1,MAX_I_Y))
            i_y = math.mod(i_y+1,MAX_I_Y)
        end
        if #ship.upgrades==0 then
            x = math.min(x+2, MAX_X)
        end
        x = math.min(x+SHIP_POST_X_GAP, MAX_X)
    end
    -- print(x)
    for i,squad in ipairs(fleet.squads) do
        -- if squad.count!=nil and squad.count>1 then
        --     printToAll("Squadron: "..squad.count.."x "..squad.def.name,{0,1,0})
        -- else
        --     printToAll("Squadron: "..squad.def.name,{0,1,0})
        -- end
        if spawn then
            spawnCard(squad.def, pos, {x,0,3.3}, rot, squad.count)
        end
        x = math.min(x+SQUAD_X_GAP, MAX_X)
    end
    -- print(x)
    return x
end
function isShipOrSquad(ship)
    name = string.gsub(ship.getName(),"^%d+ x ","")
    def = SHIPS[string.lower(name)]
    return def~=nil
end

function buildFleetFromZone(color)
    local zone = getObjectFromGUID(FLEETZONES[color])
    local listSpawner = findObjectByName("List Spawner ("..color..")")
    local fleetCards = T(zone.getObjects())
                        :Where(|c| c.tag=="Card" and c.getCustomObject().face~=DAMAGE_FACE)
                        :OrderBy(|c| listSpawner.positionToLocal(c.getPosition())[1] - listSpawner.positionToLocal(c.getPosition())[3]/100)
    local lineobjs = linesToLineobjs(fleetCards:Select(|c| c.getName()))
    for i, obj in ipairs(lineobjs) do
        obj['card'] = fleetCards[i]
    end
    local fleet = createSpawningStructure(lineobjs)
    fleet.datacard = T(zone.getObjects()):Where(isDatacard):FirstOrNil()
    if #fleet.ships==0 then
        fleet = nil
    end
    return fleet
end
----#include Armada_Spawner/ScoreManager
FLEETZONES = {
    ['Red'] = '4f3ef2',
    ['Blue'] = '9923b6',
    ['Yellow'] = '4f3ef2',
    ['White'] = '4f3ef2',
    ['Orange'] = '4f3ef2',
    ['Pink'] = '4f3ef2',
    ['Teal'] = '9923b6',
    ['Green'] = '9923b6',
    ['Brown'] = '9923b6',
    ['Purple'] = '9923b6'
}
OPPONENTZONES = {
    ['Red'] = '9923b6',
    ['Blue'] = '4f3ef2',
    ['Yellow'] = '9923b6',
    ['White'] = '9923b6',
    ['Orange'] = '9923b6',
    ['Pink'] = '9923b6',
    ['Teal'] = '4f3ef2',
    ['Green'] = '4f3ef2',
    ['Brown'] = '4f3ef2',
    ['Purple'] = '4f3ef2'
}
OPPONENTCOLORS = {
    ['Red'] = {'Blue','Teal','Green','Brown','Purple'},
    ['Blue'] = {'Red','Yellow','White','Orange','Pink'},
    ['Yellow'] = {'Blue','Teal','Green','Brown','Purple'},
    ['White'] = {'Blue','Teal','Green','Brown','Purple'},
    ['Orange'] = {'Blue','Teal','Green','Brown','Purple'},
    ['Pink'] = {'Blue','Teal','Green','Brown','Purple'},
    ['Teal'] = {'Red','Yellow','White','Orange','Pink'},
    ['Green'] = {'Red','Yellow','White','Orange','Pink'},
    ['Brown'] = {'Red','Yellow','White','Orange','Pink'},
    ['Purple'] = {'Red','Yellow','White','Orange','Pink'}
}

DAMAGE_FACE = "http://i.imgur.com/l2lA0hL.jpg"
function onClick_RefreshScore(player, _, idValue)
    findObjective()
    updateAllScores()
end
function updateAllScores()
    for _,player in pairs(Player.getPlayers()) do
        if player.seated then
            printToAll("Processing fleet for: "..player.steam_name, Color.fromString(player.color))
            FLEETS[player.color] = buildFleetFromZone(player.color)
            if FLEETS[player.color]~= nil then
                processFleetMetrics(player.color)
            end
        end
    end
    for _,player in ipairs(Player.getPlayers()) do
        if player.seated then
            printToAll("Updating score display for: "..player.steam_name, Color.fromString(player.color))
            if FLEETS[player.color]~= nil then
                updateCardCostDisplayText(player.color)
            end
        end
    end
end
function tokenCount(obj)
    local quantity = obj.getQuantity()
    if quantity<1 then
        quantity = 1
    end
    return quantity
end
function hasObjectiveToken(card)
    for _,ship_GUID in ipairs(card.getTable('spawns')) do
        ship = getObjectFromGUID(ship_GUID)
        prev_transforms = ship.getTable('prev_transforms')
        if prev_transforms~=nil and #prev_transforms>0 then
            for _,token in ipairs(prev_transforms[#prev_transforms][3]) do --[3] == move_objects
                if token.getName()=="Objective" then
                    return true
                end
            end
        end
    end
    return false
end
function isObjectiveCard(card)
    def = CARDS[string.lower(card.getName())]
    return def~=nil and def.type=="Objective"
end
function isDamaged(card)
    damage = card.getTable('damage')
    return damage ~=nil and #damage>0
end
function isDamageCard(obj)
    if obj==nil or obj.tag~="Card" then return false end
    local custom = obj.getCustomObject()
    return obj.tag=="Card" and custom~=nil and custom.face==DAMAGE_FACE
end
function isDamageCardOrDeck(obj)
    if obj.tag=="Card" then
        return isDamageCard(obj)
    end
    if obj.tag=="Deck" then
        --TODO: Check if cards are actually damaged?
        return true
        -- for i,card in ipairs(obj.getObjects()) do
        --     print(card.guid)
        --     print(getObjectFromGUID(card.guid))
        --     if isDamageCard(card) then
        --         return true
        --     end
        -- end
    end
    return false
end
function notInPlayArea(s)
    -- out = (s==nil) or (math.abs(s.getPosition()[3])>18) or (math.abs(s.getPosition()[1])>36)
    -- print("Checking if: "..s.getName().." ["..s.getPosition()[1]..","..s.getPosition()[3].."] in Play Area: "..tostring(out))
    return (s==nil) or (math.abs(s.getPosition()[3])>18) or (math.abs(s.getPosition()[1])>36)
end
function isCrippled(fleetitem, color)
    isHugeShip = fleetitem.def.collider == HugeShip.collider
    if not isHugeShip then return false end
    damageCards = allDamageCardsAndDecks(fleetitem.card,color)
    damage = 0
    for _,obj in ipairs(damageCards) do
        if isDamageCard(obj) then
            damage = damage + 1
        end
        if obj.tag=="Deck" then
            --TODO: Check if cards are actually damaged?
            for i,card in ipairs(obj.getObjects()) do
                damage = damage + 1
                -- if isDamageCard(card) then
                --     damage = damage + 1
                -- end
            end
        end
    end
    return damage>=math.ceil(fleetitem.def.hull/2)
end
function isDamaged(card, color)
    return allDamageCardsAndDecks(card,color):Any()
end
function allDamageCardsAndDecks(card, color)
    fleet = FLEETS[color]
    damageCards = T(getObjectFromGUID(FLEETZONES[color]).getObjects()):Where(isDamageCardOrDeck):OrderBy(|c|c.getPosition()[1])
    if #damageCards==0 then
        return T({})
    end
    shipCards = T(fleet.ships):Select(|s|s.card):OrderBy(|c|c.getPosition()[1])
    index = shipCards:IndexOf(card)
    min = -100
    if index>1 then
        min = (shipCards[index-1].getPosition()[1]+card.getPosition()[1])/2
    end
    max = 100
    if index<#shipCards then
        max = (card.getPosition()[1] + shipCards[index+1].getPosition()[1])/2
    end
    return damageCards:Where(|c|c.getPosition()[1]>min and c.getPosition()[1]<max)
end
function processFleetMetrics(color)
    fleet = FLEETS[color]
    fleet.totalCost = 0
    fleet.totalDead = 0
    -- fleet.bonusCost = 0
    fleet.nonFlotillaCount = 0
    fleet.nonFlotillaDead = 0
    fleet.maxPoints = 0
    fleet.secondPlayer = not #T(getObjectFromGUID(FLEETZONES[color]).getObjects()):Where(isObjectiveCard)==3
    for _, fleetitem in ipairs(fleet.ships) do
        -- fleetitem.bonusCost = 0
        fleetitem.totalDead = 0
        fleetitem.totalCost = fleetitem.def.cost + fleetitem.upgradeCost
        fleet.totalCost = fleet.totalCost + fleetitem.totalCost
        -- for _,spawn in ipairs(fleetitem.card.getTable('spawns')) do
        --     print(spawn)
        -- end
        fleetitem.numDead = #T(fleetitem.card.getTable('spawns')):Select(getObjectFromGUID):Where(notInPlayArea)
        if fleetitem.numDead>0 then
            fleetitem.totalDead = fleetitem.totalCost

            -- Objective Tokens
            if DOUBLE_OBJECTIVE_SHIP and fleetitem.def.shields~=nil and hasObjectiveToken(fleetitem.card) then
                fleetitem.totalDead = fleetitem.totalCost+fleetitem.def.cost
                -- fleet.bonusCost = fleet.bonusCost + fleetitem.def.cost
            end
            -- fleet.totalDead = fleet.totalDead + fleetitem.totalDead
        else
            if HALF_SCORE_DAMAGED_SHIP and isDamaged(fleetitem.card, color) then
            -- fleet.bonusCost = fleet.bonusCost + math.ceil(fleetitem.def.cost/2)
            --TODO: Damaged?
            fleetitem.totalDead = math.ceil(fleetitem.totalCost/2)
            end
            if isCrippled(fleetitem, color) then -- Have to add incase you are playing Opening Salvo (Bad choice)
                fleetitem.totalDead = fleetitem.totalDead + math.ceil(fleetitem.totalCost/2)
            end

        end
        fleet.totalDead = fleet.totalDead + fleetitem.totalDead
        if fleetitem.def.cost>30 then
            fleet.nonFlotillaCount = fleet.nonFlotillaCount + 1
            fleet.nonFlotillaDead = fleet.nonFlotillaDead + fleetitem.numDead
        end
    end
    for _, fleetitem in ipairs(fleet.squads) do
        fleetitem.totalCost = fleetitem.def.cost * (fleetitem.count or 0)
        fleet.totalCost = fleet.totalCost + fleetitem.totalCost
        -- for _,spawn in ipairs(fleetitem.card.getTable('spawns')) do
        --     print(spawn)
        -- end
        fleetitem.numDead = #T(fleetitem.card.getTable('spawns')):Select(getObjectFromGUID):Where(notInPlayArea)
        -- print(fleetitem.numDead)
        if fleetitem.numDead>0 then
            fleetitem.totalDead = fleetitem.def.cost*fleetitem.numDead
            fleet.totalDead = fleet.totalDead + fleetitem.totalDead
        else
            fleetitem.totalDead = 0
        end
    end
    if fleet.nonFlotillaCount==fleet.nonFlotillaDead then
        fleet.totalDead = math.ceil(fleet.totalCost/100)*100 --"Max"
    end
    fleet.victoryTokens = T(getObjectFromGUID(FLEETZONES[color]).getObjects()):Where(|t| t.getName()=="Victory"):Select(tokenCount):Sum()

    fleet.objective = fleet.victoryTokens*VICTORY_TOKEN_VALUE
    if MOST_VICTORY_75 then
        if fleet.victoryTokens>T(OPPONENTCOLORS[color]):Select(|c| FLEETS[c].victoryTokens):Sum() then
            fleet.objective = 75
        end
    end
    if Player[color].seated then
        fleet.steam_name = Player[color].steam_name
        fleet.steam_id = Player[color].steam_id
    end
    fleet.color = color
end
function updateCardCostDisplayText(color)
    fleet = FLEETS[color]
    if fleet==nil then
        printToAll("No Ships found for: "..color,{1,0,0})
        return
    end
    -- processFleetMetrics(color)
    for _, fleetitem in ipairs(fleet.ships) do
        updateCardCostDisplay_forCard(fleet, fleetitem)
    end
    for _, fleetitem in ipairs(fleet.squads) do
        updateCardCostDisplay_forCard(fleet, fleetitem)
    end
    scale = Vector(1,1,1)
    offset = Vector(0,0,0)
    anchor = fleet.datacard
    if anchor==nil then
        anchor = fleet.ships[1].card
        offset = Vector(-4,0,2.6)
        if string.match(anchor.getName(),"Star Dread") then
            scale = Vector(0.5,0,1)
            offset = Vector(-8,0,2.6)
        end
    end
    scale = vector.scale(scale,vector.onedividedby(anchor.getScale()))
    --TODO: draw totals on datacard
    editLabel(anchor, 'btn_TotalValue', "("..fleet.totalCost..")", {position = vector.scale(scale,Vector(0, 0.3, 2.5)+offset), scale = scale, font_color={0.5,0.5,0.5}}, SCORE_BTN_TEMPLATE)

    totalDeadLabel = ""
    if fleet.totalDead>0 then totalDeadLabel = "-"..(fleet.totalDead) end
    editLabel(anchor, 'btn_TotalDead', totalDeadLabel, {position = vector.scale(scale,Vector(0, 0.3, 3.5)+offset), scale = scale, font_color={1,0,0}}, SCORE_BTN_TEMPLATE)

    editLabel(anchor, 'btn_Victory', "+"..fleet.objective, {position = vector.scale(scale,Vector(0, 0.3, 4.5)+offset), scale = scale, font_color={1,1,0}}, SCORE_BTN_TEMPLATE)
end
SCORE_BTN_TEMPLATE = {position = Vector(0, 0, 0),
                     scale = {1,1,1}, width = 0, height = 0, font_size = 400, function_owner = self, font_color={0.5,0.5,0.5}}
function updateCardCostDisplay_forCard(fleet, fleetitem)
    if fleetitem.card~=nil then
        -- fleetitem.card.clearButtons()
        if string.match(fleetitem.card.getName(),"Star Dread") then scale = {0.5,0,1} else scale = {1,1,1} end
        scale = vector.scale(scale,vector.onedividedby(fleetitem.card.getScale()))
        detailLabel = ""
        if fleetitem.upgradeCost~=nil and fleetitem.upgradeCost>0 then --FOR SHIPS
            detailLabel = tostring(fleetitem.def.cost).." + "..tostring(fleetitem.upgradeCost)
        elseif fleetitem.count~=nil and fleetitem.count>0  then --FOR SQUADRONS
            detailLabel = fleetitem.count.." x "..fleetitem.def.cost
        end
        editLabel(fleetitem.card, 'btn_Detail', detailLabel, {position = vector.scale(scale,{0, 0.3, 4.2}), scale = scale, font_color={0.5,0.5,0.5}}, SCORE_BTN_TEMPLATE)

        valueLabel = "("..fleetitem.totalCost..")"
        editLabel(fleetitem.card, 'btn_Value', valueLabel, {position = vector.scale(scale,{0, 0.3, 5.2}), scale = scale, font_color={0.5,0.5,0.5}}, SCORE_BTN_TEMPLATE)

        totalDeadLabel = ""
        if fleetitem.totalDead>0 then totalDeadLabel = "-"..tostring(fleetitem.totalDead)  end
        editLabel(fleetitem.card, 'btn_Dead', totalDeadLabel, {position = vector.scale(scale,{0, 0.3, 6.2}), scale = scale, font_color={1,0,0}}, SCORE_BTN_TEMPLATE)
    end
end
function editLabel(item, uid, label, props, defaults)
    local btn = T(item.getButtons()):Where(|t| t.click_function==uid):FirstOrNil()
    if btn~=nil then
        item.editButton(table.merge({index=btn.index, label=label}, props))
    else
        item.createButton(table.merge(defaults, props, {click_function=uid, label=label}))
    end
    -- table.merge()
end
--TODO: onObjectDestroyed?
function updateCardCostDisplay_onFigurineDeath(color)
    --TODO: update objective tokens?
end
function updateCardCostDisplay_onDamage(color) --ondrop damage card
    --TODO: Add Variable Pointing to owning Ship?
end
function updateCardCostDisplay_onVictoryToken(color) --ondrop victory token
    --TODO: Add to array in fleet?
end

----#include Armada_Spawner/ScoreManager
-- function onObjectEnterScriptingZone_spawner(params) -- zone, object
--     onObjectChangeScriptingZone_ScoreManager(params.zone, params.object)
-- end
-- function onObjectLeaveScriptingZone_spawner(params) -- zone, object
--     onObjectChangeScriptingZone_ScoreManager(params.zone, params.object)
-- end
function spawnCard(def, pos, offset, rot, count, spawnModel)
    if spawnModel==nil then spawnModel=true end
    pos =  vector.add(pos,vector.rotate(offset, rot[2]))
    -- scale = {1.37,1,1.37}
    scale = {1,1,1}
    if def.maneuver~=nil then
        scale = {1.88,1,1.88}
    end
    if def.move~=nil then
        scale = {1.37,1,1.37}
    end
    nick = def.name.." ("..def.cost..")"
    if count~=nil and count > 1 then
        nick = count .. " x " .. nick
    end
    if def.type == "Objective" then
        nick = def.name
    end
    local jsonRepresentation = {
      Name = "CardCustom",
      Transform = {
        posX = pos[1],
        posY = pos[2],
        posZ = pos[3],
        rotX = rot[1],
        rotY = rot[2]+180,
        rotZ = rot[3],
        scaleX = scale[1],
        scaleY = scale[2],
        scaleZ = scale[3]
      },
      Nickname = nick,
      Hands = false,
      CardID = 2111,
      CustomDeck = {
        ["21"] = {
          FaceURL = def.front,
          BackURL = def.back,
          NumWidth = 1,
          NumHeight = 1,
          BackIsHidden = true,
          UniqueBack = false,
          Type = 0
        }
      }
    }
    -- if count~=nil and count>1 then
    --     jsonRepresentation['Nickname'] = "["..count.."]"..jsonRepresentation['Nickname']
    -- end
    -- if count~=nil and count>1 then
    --     jsonRepresentation['Description'] = "spawn "..count
    -- elseif  count~=nil and count==1 then
    --     jsonRepresentation['Description'] = "spawn"
    -- end
    if spawnModel then
        spawnObjectJSON({
            json = JSON.encode(jsonRepresentation),
            callback_function = setCardDescriptionToSpawn
        })
    else
        spawnObjectJSON({
            json = JSON.encode(jsonRepresentation),
            -- callback_function = lockCard
        })
    end
end
-- function lockCard(card)
--     card.lock()
-- end
function setCardDescriptionToSpawn(card)
    -- card.lock()
    count = string.match(card.getName(), "^(%d+) x ")
    if count~=nil then
        count = tonumber(count)
        name = string.gsub(card.getName(),"^%d+ x ","")
        -- card.setName(name)
        -- card.clearButtons()
    else
        name = card.getName()
        count = 1
    end
    if SHIPS[string.lower(name)]~=nil then
        Wait.frames(function() card.clearButtons() end, 2)
        spawnShip(name,card.getPosition(),count,card.getRotation()[2],card)
    end
end
function spawnShip(name,pos,count,rotation, card)
    -- printToAll("Spawning: "..name,{1,0,0})
    local ship_def = SHIPS[string.lower(name)]
    spawnDefinition(ship_def,name,pos,count,rotation, card)
end
-- token_offsets = {{-0.86,0,-3.64},{0.86,0,-3.64},{-0.86,0,-4.94},{0.86,0,-4.94},{-0.86,0,-6.24},{0.86,0,-6.24}}
token_offsets = {{-0.86,0,3.54},{0.86,0,3.54},{-0.86,0,4.84},{0.86,0,4.84},{-0.86,0,6.14},{0.86,0,6.14}}
function addSpawn(card, ship)
    Wait.frames(function()
        cardspawns = card.getTable('spawns') or {}
        table.insert(cardspawns,ship.getGUID())
        card.setTable('spawns',cardspawns)
    end, 1)
end
function spawnDefinition(ship_def, name, pos,count,y_rotation, card)
    --local ship_def = SHIPS[name]
    if ship_def~=nil then
    --for _,ship_def in ipairs(SHIPS) do
    --    if ship_def.name == name then
        rotation_offset = 180
        if ship_def.health~=nil and ship_def.move~=nil then
            name = "("..ship_def.health.."/"..ship_def.health..") ["..ship_def.move.."] "..name
            rotation_offset = 0
        end
        local last_ship = nil
        for i=1, count, 1 do
            local obj_parameters = {}
            obj_parameters.type = 'Custom_Model'
            obj_parameters.position = vector.add({pos[1],1+(i-1)*0.3,pos[3]},vector.rotate({0,0,8},y_rotation-180))
            obj_parameters.rotation = {0,y_rotation-rotation_offset,0 }
            local ship = spawnObject(obj_parameters)
            local custom = {}
            custom.mesh = ship_def.mesh
            custom.collider = ship_def.collider
            custom.diffuse = ship_def.diffuse
            custom.convex = ship_def.convex
            custom.type = ship_def.type
            -- print(ship_def.material)
            custom.material = ship_def.material or 1
            ship.setCustomObject(custom)

            ship.setName(name)
            ship.setVar("rulerMesh",ship_def.ruler)
            ship.setTable("maneuver",ship_def.maneuver)
            ship.setTable("shields",ship_def.shields)
            if card~=nil then
                addSpawn(card, ship)
                ship.setVar('card',card.getGUID())
            end
            last_ship = ship
            wait_then_storeInitialPosition(ship)
        end
        if ship_def.defense_tokens~=nil then
            for i,source_guid in ipairs(ship_def.defense_tokens) do
                source = getObjectFromGUID(source_guid)
                offset = token_offsets[i]
                local obj_parameters = {}
                obj_parameters.position = vector.sub(pos,vector.rotate(offset,y_rotation))
                obj_parameters.rotation = {0,y_rotation+90,0}
                source.takeObject(obj_parameters)
            end
        end
        if ship_def.maneuver~=nil then
            -- for i,source_guid in ipairs(COMMAND_TOKEN_SOURCES) do
            --     source = getObjectFromGUID(source_guid)
            --     offset = {token_offsets[i][1],0,-token_offsets[i][3]*1.1}
            --     local obj_parameters = {}
            --     obj_parameters.position = vector.sub(pos,vector.rotate(offset,y_rotation))
            --     obj_parameters.rotation = {0,y_rotation+90,0}
            --     source.takeObject(obj_parameters)
            -- end

            source = getObjectFromGUID(SPEED_SOURCE)
            offset = {3.44,0,4.19}
            local obj_parameters = {}
            obj_parameters.position = vector.sub(pos,vector.rotate(offset,y_rotation))
            obj_parameters.rotation = {0,y_rotation,0}
            source.takeObject(obj_parameters)


            --Spawn Command Base
            local obj_parameters = {}
            obj_parameters.type = 'Custom_Model'
            obj_parameters.position = vector.sub(pos,vector.rotate({3.44,0,7.5},y_rotation))
            obj_parameters.rotation = {0,y_rotation-rotation_offset,0 }
            obj_parameters.scale = {0.43,0.25,0.43}
            local custom = {}
            local base = spawnObject(obj_parameters)
            base.setColorTint({0,0,0})
            custom.mesh = ASSETS_ROOT.."misc/command_base.obj"
            custom.collider = ASSETS_ROOT.."misc/command_base_collider.obj"
            custom.convex = true
            custom.type = 1
            custom.material = 2 --metal?
            base.setCustomObject(custom)
            base.setName(ship_def.name.."\nCommand Base")
            base.lock()
            Wait.frames(|| SetCmdBaseGUIDonShip(base, last_ship), 1)

        end

        if ship_def.command~=nil then
            for i=1,ship_def.command do
                source = getObjectFromGUID(COMMAND_SOURCE)
                offset = {3.44,-i*0.5,9.5}
                local obj_parameters = {}
                obj_parameters.position = vector.sub(pos,vector.rotate(offset,y_rotation))
                obj_parameters.rotation = {0,y_rotation,180}
                source.takeObject(obj_parameters)
            end
        end
    --    end
    --end
    end
end
function wait_then_storeInitialPosition(ship)
    Wait.frames(|| storeInitialPosition(ship), 10)
end
function SetCmdBaseGUIDonShip(base, ship)
    -- print("Ship: "..ship.getGUID())
    -- print("Base: "..base.getGUID())
    ship.setVar("cmdBaseGUID",base.getGUID())
end
function storeInitialPosition(ship)
    ship.setTable("InitialPosition",ship.getPosition())
end
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
-- function math.mod(a, b)
--     return a-b*math.floor(a/b)
-- end
-- function math.round(x)
--     return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
-- end
-- vector={}
-- function vector.add(pos, offset)
--     return {pos[1] + offset[1],pos[2] + offset[2],pos[3] + offset[3]}
-- end
-- function vector.sub(pos, offset)
--     return {pos[1] - offset[1],pos[2] - offset[2],pos[3] - offset[3]}
-- end
-- function vector.length(v)
--     return math.sqrt(v[1]*v[1]+v[2]*v[2]+v[3]*v[3])
-- end
-- function vector.rotate(direction, yRotation)
--
--     local rotval = math.round(yRotation)
--     local radrotval = math.rad(rotval)
--     local xDistance = math.cos(radrotval) * direction[1] + math.sin(radrotval) * direction[3]
--     local zDistance = math.sin(radrotval) * direction[1] * -1 + math.cos(radrotval) * direction[3]
--     return {xDistance, direction[2], zDistance}
-- end

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
function findObjectByName(name)
    for i,obj in ipairs(getAllObjects()) do
        if obj.getName()==name then return obj end
    end
end

----#include TTS_armada/src/Armada_Spawner
end)
__bundle_register("ge_tts/Http", function(require, _LOADED, __bundle_register, __bundle_modules)
local Base64 = require("ge_tts.Base64")
local Logger = require("ge_tts.Logger")
local Json = require("ge_tts.Json")
local TableUtils = require("ge_tts.TableUtils")

---@shape ge_tts__Http_Response
---@field statusCode number
---@field headers table<string, string>
---@field body string | number[] | table

---@alias ge_tts__Http_Callback fun(response: nil | ge_tts__Http_Response, error: nil | string): void
---
---@type nil | string
local proxyUrl

---@type nil | string
local decodeJsonContentType = 'application/json'

---@class ge_tts__Http
local Http = {}

---@param url string
function Http.setProxyUrl(url)
    proxyUrl = url
end

---@return nil | string
function Http.getProxyUrl()
    return proxyUrl
end

---@param type nil | string
function Http.setDecodeJsonContentType(type)
    decodeJsonContentType = type
end

---@return nil | string
function Http.getDecodeJsonContentType()
    return decodeJsonContentType
end

---@param headers table<string, string>
---@param name string
---@return nil | string, nil | string @value, headerName - `headerName` being the case-sensitive variant of `name` found within headers
function Http.getHeader(headers, name)
    name = name:lower()

    return TableUtils.detect(headers, function(_, key)
        return key:lower() == name
    end)
end

---@param method string
---@param url string
---@param options table<string, any>
---@param callback ge_tts__Http_Callback
function Http.request(method, url, options, callback)
    Logger.assert(proxyUrl, 'Http must be configured with Http.setProxyUrl(\'YOUR_TTS_PROXY_URL\'). Please refer to https://gitlab.com/BenjaminDobell/tts-proxy for details.')

    content = Json.encode(TableUtils.merge(
        {
            headers={},
        },
        options,
        {
            method=method:upper(),
            url=url,
        }
    ))

    WebRequest.put(--[[---@not nil]] proxyUrl, content, function(request)
        if request.is_error then
            callback(nil, request.error)
        elseif request.is_done then
            Json.decodeAsync(request.text, {
                ---@param responseContent table
                onCompletion = function(responseContent)
                    ---@type ge_tts__Http_Response
                    local response = {
                        statusCode = responseContent.status_code,
                        headers = responseContent.headers,
                        body = responseContent.body or ""
                    }

                    if responseContent.base64 then
                        response.body = Base64.decode(response.body)
                        callback(response, nil)
                        return
                    end

                    local contentType = Http.getHeader(response.headers, 'Content-Type')

                    if contentType and (--[[---@not nil]] contentType):lower() == decodeJsonContentType then
                        Json.decodeAsync(request.text, {
                            ---@param value table
                            onCompletion = function(value)
                                response.body = value
                                callback(response, nil)
                            end,
                            onError = function(message)
                                callback(nil, "Failed to parse JSON body: " .. message)
                            end,
                        })
                        return
                    end

                    callback(response, nil)
                end,
                onError = function(message)
                    callback(nil, "Failed to parse proxy wrapper: " .. message)
                end,
            })
        end
    end)
end

---@param method string
---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headersOrNil nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.submit(method, url, body, headersOrNil, callback)
    ---@type table<string, string>
    local headers = headersOrNil or {}

    ---@type table<string, any>
    local options = {headers = headers}

    if type((--[[---@type number[] ]] body)[1]) == 'number' then
        options = TableUtils.copy(options)
        options.base64 = true
        body = Base64.encode(--[[---@type number[] ]] body)
    elseif type(body) == 'table' then
        local contentType, contentTypeHeader = Http.getHeader(headers, 'Content-Type')
        contentTypeHeader = contentTypeHeader or 'Content-Type'

        if not (contentType and (--[[---@not nil]] contentType):sub(-4) == 'json') then
            headers = TableUtils.copy(headers)
            headers[--[[---@not nil]] contentTypeHeader] = 'application/json'
        end

        body = Json.encode(body)
    end

    options.body = body

    Http.request(method, url, options, callback)
end

---@param url string
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.delete(url, headers, callback)
    Http.request('DELETE', url, {headers=headers}, callback)
end

---@param url string
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.get(url, headers, callback)
    Http.request('GET', url, {headers=headers}, callback)
end

---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.patch(url, body, headers, callback)
    Http.submit('PATCH', url, body, headers, callback)
end

---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.post(url, body, headers, callback)
    Http.submit('POST', url, body, headers, callback)
end

---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.put(url, body, headers, callback)
    Http.submit('PUT', url, body, headers, callback)
end

return Http

end)
__bundle_register("ge_tts.TableUtils", function(require, _LOADED, __bundle_register, __bundle_modules)
-- This module operates on tables that contain only positive consecutive integer keys starting at 1 (i.e. a plain array), as well as tables which contain no
-- array component. Behavior is undefined for tables that contain a key for [1] as well as non-consecutive integer or non-integer keys.

---@class ge_tts__TableUtils
local TableUtils = {}

--- Returns true if `tab` contains an entry at index 1. That being the case, this module will assume `tab` only contains sequential positive integer keys.
---@overload fun<V>(tab: V[]): true
---@overload fun<V>(tab: table<boolean, V>): false
---@overload fun<V>(tab: table<string, V>): false
---@overload fun<V>(tab: table<table, V>): false
---@overload fun<V>(tab: table<userdata, V>): false
---@param tab table
---@return boolean
function TableUtils.isArray(tab)
    return tab[1] ~= nil or type(tab[0]) == 'number'
end

---@overload fun<V, MappedV>(tab: V[], func: fun(value: V, key: number): MappedV): MappedV[]
---@generic K, V, MappedV
---@param tab table<K, V>
---@param func fun(value: V, key: K): MappedV
---@return table<K, MappedV>
function TableUtils.map(tab, func)
    ---@type table<K, MappedV>
    local mapped = {}

    if TableUtils.isArray(tab) then
        for i, v in ipairs(--[[---@type V[] ]] tab) do
            mapped[--[[---@type K]] i] = func(v, --[[---@type K]] i)
        end
    else
        for k, v in pairs(tab) do
            mapped[k] = func(v, k)
        end
    end

    return mapped
end

---@generic K, V
---@param tab table<K, V>
---@return table<V, K>
function TableUtils.invert(tab)
    ---@type table<V, K>
    local inverted = {}

    for k, v in pairs(tab) do
        inverted[v] = k
    end

    return inverted
end

---@generic K, V, RemappedK
---@param tab table<K, V>
---@param func fun(value: V, key: K): RemappedK
---@return table<RemappedK, V>
function TableUtils.remap(tab, func)
    local remapped = {}

    for k, v in pairs(tab) do
        remapped[func(v, k)] = v
    end

    return remapped
end

---@overload fun<V>(arr: V[], func: fun(value: V, index: number): boolean): V[]
---@generic K, V
---@param tab table<K, V>
---@param func fun(value: V, key: K): any
---@return table<K, V>
function TableUtils.select(tab, func)
    ---@type table<K, V>
    local selected = {}

    if TableUtils.isArray(tab) then
        local arr = tab
        for i, v in ipairs(--[[---@type V[] ]] arr) do
            if func(v, --[[---@type K]] i) then
                table.insert(--[[---@type V[] ]] selected, v)
            end
        end
    else
        for k, v in pairs(tab) do
            if func(v, k) then
                selected[k] = v
            end
        end
    end

    return selected
end

---@overload fun<V>(arr: V[], func: fun(value: V, index: number): boolean): V[]
---@generic K, V
---@param tab table<K, V>
---@param func fun(value: V, key: K): boolean
---@return table<K, V>
function TableUtils.reject(tab, func)
    return TableUtils.select(tab, function(v, k) return not func(v, k) end)
end

---@overload fun<R, K, V: R>(tab: table<K, V>, func: fun(memo: R, value: V, key: K): R): R
---@generic K, V, R
---@param tab table<K, V>
---@param initial R
---@param func fun(memo: R, value: V, key: K): R
---@return R
function TableUtils.reduce(tab, initial, func)
    local memo = func and initial or next(tab)
    local reducer = func or initial

    ---@type K
    local initialK

    if not func then
        initialK = --[[---@type K]] memo
    end

    for k, v in next, tab, initialK do
        memo = reducer(memo, v, k)
    end

    return memo
end

---@generic K, V
---@param tab table<K, V>
---@param value any
---@return nil | K
function TableUtils.find(tab, value)
    if TableUtils.isArray(tab) then
        for i, v in ipairs(--[[---@type any[] ]] tab) do
            if v == value then
                return --[[---@type K]] i
            end
        end
    else
        for k, v in pairs(tab) do
            if v == value then
                return k
            end
        end
    end

    return nil
end

---@generic K, V
---@param tab table<K, V>
---@param func fun(value: V, key: K): boolean
---@return nil | V, nil | K
function TableUtils.detect(tab, func)
    if TableUtils.isArray(tab) then
        for i, v in ipairs(--[[---@type V[] ]] tab) do
            if func(v, --[[---@type K]] i) then
                return v, --[[---@type K]] i
            end
        end
    else
        for k, v in pairs(tab) do
            if func(v, k) then
                return v, k
            end
        end
    end

    return nil, nil
end

---@overload fun<T>(tab: T): T
---@generic T
---@param tab T
---@param recursive boolean
---@return T
function TableUtils.copy(tab, recursive)
    ---@type table
    local copied = {}

    for k, v in pairs(--[[---@type table]] tab) do
        copied[k] = (recursive and type(v) == 'table' and
            TableUtils.copy(--[[---@type table]] v, true)
        ) or v
    end

    return --[[---@type T]] copied
end

---@generic K, V
---@param tab table
---@vararg table
function TableUtils.inject(tab, ...)
    local otherTables = { ... }

    for _, t in ipairs(otherTables) do
        if TableUtils.isArray(tab) then
            for _, v in ipairs(--[[---@type any[] ]] t) do
                table.insert(--[[---@type any[] ]] tab, v)
            end
        else
            for k, v in pairs(t) do
                tab[k] = v
            end
        end
    end
end

---@overload fun<T>(...: T): T
---@vararg table
---@return table
function TableUtils.merge(...)
    local merged = {}
    TableUtils.inject(merged, ...)
    return merged
end

---@generic V
---@param tab V[][]
---@return V[]
function TableUtils.flatten(tab)
    ---@type V[]
    local flattened = {}

    for _, subTable in ipairs(tab) do
        for _, v in ipairs(subTable) do
            table.insert(flattened, v)
        end
    end

    return flattened
end

---@generic K, V
---@param tab table<K, V>
---@return K[]
function TableUtils.keys(tab)
    ---@type K[]
    local keys = {}

    for k, _ in pairs(tab) do
        table.insert(keys, k)
    end

    return keys
end

---@generic K, V
---@param tab table<K, V>
---@return V[]
function TableUtils.values(tab)
    ---@type V[]
    local values = {}

    for _, v in pairs(tab) do
        table.insert(values, v)
    end

    return values
end

---@param tab table
---@return number
function TableUtils.count(tab)
    local count = 0

    for _, _ in pairs(tab) do
        count = count + 1
    end

    return count
end

---@generic V
---@param arr V[]
---@return V[]
function TableUtils.reverse(arr)
    local reversed = {}

    if TableUtils.isArray(arr) then
        for i = #arr, 1, -1 do
            table.insert(reversed, arr[i])
        end
    end

    return reversed
end

---@overload fun<T>(arr: V[], start: number): V[]
---@generic V
---@param arr V[]
---@param start number
---@param finish number
---@return V[]
function TableUtils.range(arr, start, finish)
    local range = {}

    if TableUtils.isArray(arr) then
        finish = finish and math.min(finish, #arr) or #arr

        for i = start, finish do
            table.insert(range, arr[i])
        end
    end

    return range
end

---@generic V
---@param arr V[]
---@return V[]
function TableUtils.unique(arr)
    local unique = {}

    for _, value in ipairs(arr) do
        if not TableUtils.find(unique, value) then
            table.insert(unique, value)
        end
    end

    return unique
end

local TYPE_STRINGIFIERS = {
    ['nil'] = function(_) return 'nil' end,
    boolean = function(v) return tostring(v) end,
    number = function(v) return tostring(v) end,
    string = function(v) return "'" .. v .. "'" end,
    userdata = function(_) return 'userdata' end,
    ['function'] = function(_) return 'function' end,
    thread = function(_) return 'thread' end,
    table = function(v) return tostring(v) end,
}

---@overload fun(tab: table): string
---@overload fun(tab: table, recursive: boolean): string
---@param tab table
---@param recursive boolean
---@param depth number
---@return string
function TableUtils.dump(tab, recursive, depth)
    depth = depth or 1

    local indentation = string.rep('  ', depth)
    local str = '{'

    ---@type table<any, boolean>
    local ordered_keys = {}

    for i, v in ipairs(--[[---@type any[] ]] tab) do
        ordered_keys[i] = true
        str = str .. '\n' .. indentation .. '[' .. i .. '] = '

        if recursive and type(v) == 'table' then
            str = str .. TableUtils.dump(v, true, depth + 1) .. ','
        else
            local a = TYPE_STRINGIFIERS['nil']
            str = str .. TYPE_STRINGIFIERS[type(v)](v) .. ','
        end
    end

    for k, v in pairs(tab) do
        if not ordered_keys[k] then
            str = str .. '\n' .. indentation .. '[' .. TYPE_STRINGIFIERS[type(k)](k) .. '] = '

            if recursive and type(v) == 'table' then
                str = str .. TableUtils.dump(v, true, depth + 1) .. ','
            else
                str = str .. TYPE_STRINGIFIERS[type(v)](v) .. ','
            end
        end
    end

    str = str .. '\n' .. string.rep('  ', depth - 1) .. '}'

    return str
end

return TableUtils

end)
__bundle_register("ge_tts.Json", function(require, _LOADED, __bundle_register, __bundle_modules)
-- JSON encoding of Color presently fails due to a bug in Color. Fortunately, we can patch Color to fix it.
require("ge_tts.GlobalPatches")

local Coroutine = require("ge_tts.Coroutine")
local TableUtils = require("ge_tts.TableUtils")

local LunaJsonDecoder = require("ge_tts.lunajson.decoder")
local LunaJsonEncoder = require("ge_tts.lunajson.encoder")
local LunaJsonSax = require("ge_tts.lunajson.sax")

---@class ge_tts__JsonNull
local NULL = setmetatable({}, {
    __index = {},
    __newindex = function() error("Attempt to modify JSON.null()") end,
    __metatable = false
})

---@class ge_tts__Json
local Json = {}

---@return ge_tts__JsonNull
function Json.null()
    return NULL
end

---@alias ge_tts__JsonObject table<string, ge_tts__JsonValue>
---@alias ge_tts__JsonArray ge_tts__JsonValue[]
---@alias ge_tts__JsonContainer ge_tts__JsonObject | ge_tts__JsonArray
---@alias ge_tts__JsonValue ge_tts__JsonContainer | number | string | boolean | nil | ge_tts__JsonNull

---@alias __ge_tts__JsonNodeTypeObject 0
---@alias __ge_tts__JsonNodeTypeArray 1
---@alias __ge_tts__JsonNodeTypeKey 2

---@type __ge_tts__JsonNodeTypeObject
local NODE_OBJECT = 0

---@type __ge_tts__JsonNodeTypeArray
local NODE_ARRAY = 1

---@type __ge_tts__JsonNodeTypeKey
local NODE_KEY = 2

---@alias __ge_tts__JsonNodeType __ge_tts__JsonNodeTypeObject | __ge_tts__JsonNodeTypeArray | __ge_tts__JsonNodeTypeKey

---@alias __ge_tts__JsonObjectNode {[1]: __ge_tts__JsonNodeTypeObject, [2]: ge_tts__JsonObject}
---@alias __ge_tts__JsonArrayNode {[1]: __ge_tts__JsonNodeTypeArray, [2]: ge_tts__JsonArray, [3]: number}
---@alias __ge_tts__JsonKeyNode {[1]: __ge_tts__JsonNodeTypeKey, [2]: string }


---@alias __ge_tts__JsonNode __ge_tts__JsonObjectNode | __ge_tts__JsonArrayNode | __ge_tts__JsonKeyNode

---@shape ge_tts__Json_DecodeOptions
---@field encodeArrayLength nil | boolean @Default false. When true, array lengths are encoded as the zeroth element. Thus an empty array can be discerned from an empty table.
---@field nullIdentification nil | boolean @Default true. When true, null values in an array/object are represented by JSON.null() rather than being omitted.

---@shape ge_tts__Json_DecodeAsyncOptions : ge_tts__Json_DecodeOptions
---@field onCompletion fun(data: ge_tts__JsonValue): void
---@field onError fun(message: string): void
---@field charactersPerChunk nil | number @Default 2048 (2 KiB)
---@field framesBetweenChunks nil | number @Default 1

---@type ge_tts__Json_DecodeOptions
local defaultDecodeOptions = {
    encodeArrayLength = false,
    nullIdentification = true,
}

--- Sets the default decoding options used by decode and decodeAsync when called with options omitted.
---@param decodeOptions ge_tts__Json_DecodeOptions
function Json.setDefaultDecodeOptions(decodeOptions)
    defaultDecodeOptions = decodeOptions
end

--- Parses JSON in a pseudo-async fashion using co-operative multi-tasking (i.e. coroutines).
---
--- The parser will only do a limited amount of work each frame before handing off processing back to TTS, thus we
--- don't freeze the game when parsing large JSON.
---
--- Return value is a function that can be called to cancel decoding if it is yet to complete.
---@param json string
---@param options ge_tts__Json_DecodeAsyncOptions
---@return fun(): void
function Json.decodeAsync(json, options)
    local cancelled = false

    options = TableUtils.merge(--[[---@type ge_tts__Json_DecodeAsyncOptions]] defaultDecodeOptions, options)

    Coroutine.start(function()
        ---@type __ge_tts__JsonNode[]
        local stack = {}

        ---@type nil | __ge_tts__JsonNode
        local currentNode

        ---@type ge_tts__JsonValue
        local result

        ---@param value ge_tts__JsonValue
        local function addValue(value)
            if currentNode then
                local nodeType = (--[[---@not nil]] currentNode)[1]

                if value == nil and options.nullIdentification then
                    value = Json.null()
                end

                if nodeType == NODE_KEY then
                    local key = (--[[---@type __ge_tts__JsonKeyNode]] currentNode)[2]

                    local parentNode = --[[---@type __ge_tts__JsonObjectNode]] table.remove(stack)
                    local parentObject = parentNode[2]
                    parentObject[key] = value

                    currentNode = parentNode
                elseif nodeType == NODE_ARRAY then
                    local arrayNode = --[[---@type __ge_tts__JsonArrayNode]] currentNode

                    local array = arrayNode[2]
                    arrayNode[3] = arrayNode[3] + 1 -- Update length
                    array[arrayNode[3]] = value
                end
            else
                result = value
            end
        end

        local handler = {
            startobject = function()
                if currentNode then
                    table.insert(stack, --[[---@not nil]] currentNode)
                end

                currentNode = {NODE_OBJECT , {}}
            end,
            ---@param key string
            key = function(key)
                table.insert(stack, --[[---@not nil]] currentNode)
                currentNode = {NODE_KEY, key}
            end,
            endobject = function()
                local objectNode = (--[[---@type __ge_tts__JsonObjectNode]] currentNode)
                currentNode = table.remove(stack)
                addValue(objectNode[2])
            end,
            startarray = function()
                if currentNode then
                    table.insert(stack, --[[---@not nil]] currentNode)
                end

                currentNode = {NODE_ARRAY , {}, 0}
            end,
            endarray = function()
                local objectNode = (--[[---@type __ge_tts__JsonArrayNode]] currentNode)
                local array = objectNode[2]
                currentNode = table.remove(stack)

                if options.encodeArrayLength then
                    array[0] = objectNode[3]
                end

                addValue(array)
            end,
            string = addValue,
            number = addValue,
            boolean = addValue,
            null = function()
                addValue(nil)
            end,
        }

        ---@type number
        local charactersPerChunk = 0

        if options.charactersPerChunk then
            charactersPerChunk = --[[---@not nil]] options.charactersPerChunk
        end

        if charactersPerChunk <= 0 then
            charactersPerChunk = 2048
        end

        ---@type number
        local framesBetweenChunks

        if options.framesBetweenChunks and framesBetweenChunks > 0 then
            framesBetweenChunks = --[[---@not nil]] options.framesBetweenChunks
        else
            framesBetweenChunks = 1
        end

        local offset = 1
        local length = #json

        local function feed()
            local characterCount = math.min(length - offset + 1, charactersPerChunk)

            if characterCount == 0 or cancelled then
                return nil
            end

            Coroutine.yieldFrames(framesBetweenChunks, function(message)
                if not cancelled then
                    options.onError(message)
                end
            end)

            local nextOffset = offset + characterCount
            local substring = json:sub(offset, nextOffset - 1)
            offset = nextOffset
            return substring
        end

        local parser = --[[---@type {run: fun(): void}]] LunaJsonSax.newparser(feed, handler)
        parser.run()

        if not cancelled then
            options.onCompletion(result)
        end
    end)

    return function()
        cancelled = true
    end
end

local decode = LunaJsonDecoder()

---@overload fun(json: string): ge_tts__JsonValue
---@param json string
---@param options nil | ge_tts__Json_DecodeOptions
---@return ge_tts__JsonValue
function Json.decode(json, options)
    local decodeOptions = TableUtils.merge(defaultDecodeOptions, --[[---@not nil]] options or {})
    local nullValue = decodeOptions.nullIdentification and Json.null() or nil
    return decode(json, 0, nullValue, decodeOptions.encodeArrayLength or false)
end

local encode = LunaJsonEncoder()

---@param json ge_tts__JsonValue
---@return string
function Json.encode(value)
    return encode(value, Json.null())
end

--- Fills gaps (up to the specified length) in sparseArray with Json.null(), then returns it.
---@generic T
---@generic N : number
---@param sparseArray table<N, nil | T>
---@param length number
---@return (T | ge_tts__JsonNull)[]
function Json.nullFillSparseArray(sparseArray, length)
    for i = 1, length do
        if type((--[[---@type T[] ]] sparseArray)[i]) == 'nil' then
            (--[[---@type (T | ge_tts__JsonNull)[] ]] sparseArray)[i] = Json.null()
        end
    end

    return --[[---@type (T | ge_tts__JsonNull)[] ]] sparseArray
end

return Json

end)
__bundle_register("ge_tts.lunajson.sax", function(require, _LOADED, __bundle_register, __bundle_modules)
local setmetatable, tonumber, tostring =
      setmetatable, tonumber, tostring
local floor, inf =
      math.floor, math.huge
local mininteger, tointeger =
      math.mininteger or nil, math.tointeger or nil
local byte, char, find, gsub, match, sub =
      string.byte, string.char, string.find, string.gsub, string.match, string.sub

local function _parse_error(pos, errmsg)
	error("parse error at " .. pos .. ": " .. errmsg, 2)
end

local f_str_ctrl_pat = '[^\32-\255]'
local type, unpack = type, table.unpack or unpack

local _ENV = nil


local function nop() end

local function newparser(src, saxtbl)
	local json, jsonnxt, rec_depth
	local jsonlen, pos, acc = 0, 1, 0

	-- `f` is the temporary for dispatcher[c] and
	-- the dummy for the first return value of `find`
	local dispatcher, f

	-- initialize
	if type(src) == 'string' then
		json = src
		jsonlen = #json
		jsonnxt = function()
			json = ''
			jsonlen = 0
			jsonnxt = nop
		end
	else
		jsonnxt = function()
			acc = acc + jsonlen
			pos = 1
			repeat
				json = src()
				if not json then
					json = ''
					jsonlen = 0
					jsonnxt = nop
					return
				end
				jsonlen = #json
			until jsonlen > 0
		end
		jsonnxt()
	end

	local sax_startobject = saxtbl.startobject or nop
	local sax_key = saxtbl.key or nop
	local sax_endobject = saxtbl.endobject or nop
	local sax_startarray = saxtbl.startarray or nop
	local sax_endarray = saxtbl.endarray or nop
	local sax_string = saxtbl.string or nop
	local sax_number = saxtbl.number or nop
	local sax_boolean = saxtbl.boolean or nop
	local sax_null = saxtbl.null or nop

	--[[
		Helper
	--]]
	local function tryc()
		local c = byte(json, pos)
		if not c then
			jsonnxt()
			c = byte(json, pos)
		end
		return c
	end

	local function parse_error(errmsg)
		return _parse_error(acc + pos, errmsg)
	end

	local function tellc()
		return tryc() or parse_error("unexpected termination")
	end

	local function spaces()  -- skip spaces and prepare the next char
		while true do
			pos = match(json, '^[ \n\r\t]*()', pos)
			if pos <= jsonlen then
				return
			end
			if jsonlen == 0 then
				parse_error("unexpected termination")
			end
			jsonnxt()
		end
	end

	--[[
		Invalid
	--]]
	local function f_err()
		parse_error('invalid value')
	end

	--[[
		Constants
	--]]
	-- fallback slow constants parser
	local function generic_constant(target, targetlen, ret, sax_f)
		for i = 1, targetlen do
			local c = tellc()
			if byte(target, i) ~= c then
				parse_error("invalid char")
			end
			pos = pos+1
		end
		return sax_f(ret)
	end

	-- null
	local function f_nul()
		if sub(json, pos, pos+2) == 'ull' then
			pos = pos+3
			return sax_null(nil)
		end
		return generic_constant('ull', 3, nil, sax_null)
	end

	-- false
	local function f_fls()
		if sub(json, pos, pos+3) == 'alse' then
			pos = pos+4
			return sax_boolean(false)
		end
		return generic_constant('alse', 4, false, sax_boolean)
	end

	-- true
	local function f_tru()
		if sub(json, pos, pos+2) == 'rue' then
			pos = pos+3
			return sax_boolean(true)
		end
		return generic_constant('rue', 3, true, sax_boolean)
	end

	--[[
		Numbers
		Conceptually, the longest prefix that matches to `[-+.0-9A-Za-z]+` (in regexp)
		is captured as a number and its conformance to the JSON spec is checked.
	--]]
	-- deal with non-standard locales
	local radixmark = match(tostring(0.5), '[^0-9]')
	local fixedtonumber = tonumber
	if radixmark ~= '.' then
		if find(radixmark, '%W') then
			radixmark = '%' .. radixmark
		end
		fixedtonumber = function(s)
			return tonumber(gsub(s, '.', radixmark))
		end
	end

	local function number_error()
		return parse_error('invalid number')
	end

	-- fallback slow parser
	local function generic_number(mns)
		local buf = {}
		local i = 1
		local is_int = true

		local c = byte(json, pos)
		pos = pos+1

		local function nxt()
			buf[i] = c
			i = i+1
			c = tryc()
			pos = pos+1
		end

		if c == 0x30 then
			nxt()
			if c and 0x30 <= c and c < 0x3A then
				number_error()
			end
		else
			repeat nxt() until not (c and 0x30 <= c and c < 0x3A)
		end
		if c == 0x2E then
			is_int = false
			nxt()
			if not (c and 0x30 <= c and c < 0x3A) then
				number_error()
			end
			repeat nxt() until not (c and 0x30 <= c and c < 0x3A)
		end
		if c == 0x45 or c == 0x65 then
			is_int = false
			nxt()
			if c == 0x2B or c == 0x2D then
				nxt()
			end
			if not (c and 0x30 <= c and c < 0x3A) then
				number_error()
			end
			repeat nxt() until not (c and 0x30 <= c and c < 0x3A)
		end
		if c and (0x41 <= c and c <= 0x5B or
		          0x61 <= c and c <= 0x7B or
		          c == 0x2B or c == 0x2D or c == 0x2E) then
			number_error()
		end
		pos = pos-1

		local num = char(unpack(buf))
		num = fixedtonumber(num)
		if mns then
			num = -num
			if num == mininteger and is_int then
				num = mininteger
			end
		end
		return sax_number(num)
	end

	-- `0(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_zro(mns)
		local num, c = match(json, '^(%.?[0-9]*)([-+.A-Za-z]?)', pos)  -- skipping 0

		if num == '' then
			if pos > jsonlen then
				pos = pos - 1
				return generic_number(mns)
			end
			if c == '' then
				if mns then
					return sax_number(-0.0)
				end
				return sax_number(0)
			end

			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
				if c == '' then
					pos = pos + #num
					if pos > jsonlen then
						pos = pos - #num - 1
						return generic_number(mns)
					end
					if mns then
						return sax_number(-0.0)
					end
					return sax_number(0.0)
				end
			end
			pos = pos-1
			return generic_number(mns)
		end

		if byte(num) ~= 0x2E or byte(num, -1) == 0x2E then
			pos = pos-1
			return generic_number(mns)
		end

		if c ~= '' then
			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			end
			if c ~= '' then
				pos = pos-1
				return generic_number(mns)
			end
		end

		pos = pos + #num
		if pos > jsonlen then
			pos = pos - #num - 1
			return generic_number(mns)
		end
		c = fixedtonumber(num)

		if mns then
			c = -c
		end
		return sax_number(c)
	end

	-- `[1-9][0-9]*(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_num(mns)
		pos = pos-1
		local num, c = match(json, '^([0-9]+%.?[0-9]*)([-+.A-Za-z]?)', pos)
		if byte(num, -1) == 0x2E then  -- error if ended with period
			return generic_number(mns)
		end

		if c ~= '' then
			if c ~= 'e' and c ~= 'E' then
				return generic_number(mns)
			end
			num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			if not num or c ~= '' then
				return generic_number(mns)
			end
		end

		pos = pos + #num
		if pos > jsonlen then
			pos = pos - #num
			return generic_number(mns)
		end
		c = fixedtonumber(num)

		if mns then
			c = -c
			if c == mininteger and not find(num, '[^0-9]') then
				c = mininteger
			end
		end
		return sax_number(c)
	end

	-- skip minus sign
	local function f_mns()
		local c = byte(json, pos) or tellc()
		if c then
			pos = pos+1
			if c > 0x30 then
				if c < 0x3A then
					return f_num(true)
				end
			else
				if c > 0x2F then
					return f_zro(true)
				end
			end
		end
		parse_error("invalid number")
	end

	--[[
		Strings
	--]]
	local f_str_hextbl = {
		0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
		0x8, 0x9, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
		__index = function()
			return inf
		end
	}
	setmetatable(f_str_hextbl, f_str_hextbl)

	local f_str_escapetbl = {
		['"']  = '"',
		['\\'] = '\\',
		['/']  = '/',
		['b']  = '\b',
		['f']  = '\f',
		['n']  = '\n',
		['r']  = '\r',
		['t']  = '\t',
		__index = function()
			parse_error("invalid escape sequence")
		end
	}
	setmetatable(f_str_escapetbl, f_str_escapetbl)

	local function surrogate_first_error()
		return parse_error("1st surrogate pair byte not continued by 2nd")
	end

	local f_str_surrogate_prev = 0
	local function f_str_subst(ch, ucode)
		if ch == 'u' then
			local c1, c2, c3, c4, rest = byte(ucode, 1, 5)
			ucode = f_str_hextbl[c1-47] * 0x1000 +
			        f_str_hextbl[c2-47] * 0x100 +
			        f_str_hextbl[c3-47] * 0x10 +
			        f_str_hextbl[c4-47]
			if ucode ~= inf then
				if ucode < 0x80 then  -- 1byte
					if rest then
						return char(ucode, rest)
					end
					return char(ucode)
				elseif ucode < 0x800 then  -- 2bytes
					c1 = floor(ucode / 0x40)
					c2 = ucode - c1 * 0x40
					c1 = c1 + 0xC0
					c2 = c2 + 0x80
					if rest then
						return char(c1, c2, rest)
					end
					return char(c1, c2)
				elseif ucode < 0xD800 or 0xE000 <= ucode then  -- 3bytes
					c1 = floor(ucode / 0x1000)
					ucode = ucode - c1 * 0x1000
					c2 = floor(ucode / 0x40)
					c3 = ucode - c2 * 0x40
					c1 = c1 + 0xE0
					c2 = c2 + 0x80
					c3 = c3 + 0x80
					if rest then
						return char(c1, c2, c3, rest)
					end
					return char(c1, c2, c3)
				elseif 0xD800 <= ucode and ucode < 0xDC00 then  -- surrogate pair 1st
					if f_str_surrogate_prev == 0 then
						f_str_surrogate_prev = ucode
						if not rest then
							return ''
						end
						surrogate_first_error()
					end
					f_str_surrogate_prev = 0
					surrogate_first_error()
				else  -- surrogate pair 2nd
					if f_str_surrogate_prev ~= 0 then
						ucode = 0x10000 +
						        (f_str_surrogate_prev - 0xD800) * 0x400 +
						        (ucode - 0xDC00)
						f_str_surrogate_prev = 0
						c1 = floor(ucode / 0x40000)
						ucode = ucode - c1 * 0x40000
						c2 = floor(ucode / 0x1000)
						ucode = ucode - c2 * 0x1000
						c3 = floor(ucode / 0x40)
						c4 = ucode - c3 * 0x40
						c1 = c1 + 0xF0
						c2 = c2 + 0x80
						c3 = c3 + 0x80
						c4 = c4 + 0x80
						if rest then
							return char(c1, c2, c3, c4, rest)
						end
						return char(c1, c2, c3, c4)
					end
					parse_error("2nd surrogate pair byte appeared without 1st")
				end
			end
			parse_error("invalid unicode codepoint literal")
		end
		if f_str_surrogate_prev ~= 0 then
			f_str_surrogate_prev = 0
			surrogate_first_error()
		end
		return f_str_escapetbl[ch] .. ucode
	end

	local function f_str(iskey)
		local pos2 = pos
		local newpos
		local str = ''
		local bs
		while true do
			while true do  -- search '\' or '"'
				newpos = find(json, '[\\"]', pos2)
				if newpos then
					break
				end
				str = str .. sub(json, pos, jsonlen)
				if pos2 == jsonlen+2 then
					pos2 = 2
				else
					pos2 = 1
				end
				jsonnxt()
				if jsonlen == 0 then
					parse_error("unterminated string")
				end
			end
			if byte(json, newpos) == 0x22 then  -- break if '"'
				break
			end
			pos2 = newpos+2  -- skip '\<char>'
			bs = true  -- mark the existence of a backslash
		end
		str = str .. sub(json, pos, newpos-1)
		pos = newpos+1

		if find(str, f_str_ctrl_pat) then
			parse_error("unescaped control string")
		end
		if bs then  -- a backslash exists
			-- We need to grab 4 characters after the escape char,
			-- for encoding unicode codepoint to UTF-8.
			-- As we need to ensure that every first surrogate pair byte is
			-- immediately followed by second one, we grab upto 5 characters and
			-- check the last for this purpose.
			str = gsub(str, '\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)', f_str_subst)
			if f_str_surrogate_prev ~= 0 then
				f_str_surrogate_prev = 0
				parse_error("1st surrogate pair byte not continued by 2nd")
			end
		end

		if iskey then
			return sax_key(str)
		end
		return sax_string(str)
	end

	--[[
		Arrays, Objects
	--]]
	-- arrays
	local function f_ary()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			parse_error('too deeply nested json (> 1000)')
		end
		sax_startarray()

		spaces()
		if byte(json, pos) == 0x5D then  -- check closing bracket ']' which means the array empty
			pos = pos+1
		else
			local newpos
			while true do
				f = dispatcher[byte(json, pos)]  -- parse value
				pos = pos+1
				f()
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)  -- check comma
				if newpos then
					pos = newpos
				else
					newpos = match(json, '^[ \n\r\t]*%]()', pos)  -- check closing bracket
					if newpos then
						pos = newpos
						break
					end
					spaces()  -- since the current chunk can be ended, skip spaces toward following chunks
					local c = byte(json, pos)
					pos = pos+1
					if c == 0x2C then  -- check comma again
						spaces()
					elseif c == 0x5D then  -- check closing bracket again
						break
					else
						parse_error("no closing bracket of an array")
					end
				end
				if pos > jsonlen then
					spaces()
				end
			end
		end

		rec_depth = rec_depth - 1
		return sax_endarray()
	end

	-- objects
	local function f_obj()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			parse_error('too deeply nested json (> 1000)')
		end
		sax_startobject()

		spaces()
		if byte(json, pos) == 0x7D then  -- check closing bracket '}' which means the object empty
			pos = pos+1
		else
			local newpos
			while true do
				if byte(json, pos) ~= 0x22 then
					parse_error("not key")
				end
				pos = pos+1
				f_str(true)  -- parse key
				newpos = match(json, '^[ \n\r\t]*:[ \n\r\t]*()', pos)  -- check colon
				if newpos then
					pos = newpos
				else
					spaces()  -- read spaces through chunks
					if byte(json, pos) ~= 0x3A then  -- check colon again
						parse_error("no colon after a key")
					end
					pos = pos+1
					spaces()
				end
				if pos > jsonlen then
					spaces()
				end
				f = dispatcher[byte(json, pos)]
				pos = pos+1
				f()  -- parse value
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)  -- check comma
				if newpos then
					pos = newpos
				else
					newpos = match(json, '^[ \n\r\t]*}()', pos)  -- check closing bracket
					if newpos then
						pos = newpos
						break
					end
					spaces()  -- read spaces through chunks
					local c = byte(json, pos)
					pos = pos+1
					if c == 0x2C then  -- check comma again
						spaces()
					elseif c == 0x7D then  -- check closing bracket again
						break
					else
						parse_error("no closing bracket of an object")
					end
				end
				if pos > jsonlen then
					spaces()
				end
			end
		end

		rec_depth = rec_depth - 1
		return sax_endobject()
	end

	--[[
		The jump table to dispatch a parser for a value,
		indexed by the code of the value's first char.
		Key should be non-nil.
	--]]
	dispatcher = { [0] =
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_str, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_mns, f_err, f_err,
		f_zro, f_num, f_num, f_num, f_num, f_num, f_num, f_num,
		f_num, f_num, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_ary, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_fls, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_nul, f_err,
		f_err, f_err, f_err, f_err, f_tru, f_err, f_err, f_err,
		f_err, f_err, f_err, f_obj, f_err, f_err, f_err, f_err,
	}

	--[[
		public funcitons
	--]]
	local function run()
		rec_depth = 0
		spaces()
		f = dispatcher[byte(json, pos)]
		pos = pos+1
		f()
	end

	local function read(n)
		if n < 0 then
			error("the argument must be non-negative")
		end
		local pos2 = (pos-1) + n
		local str = sub(json, pos, pos2)
		while pos2 > jsonlen and jsonlen ~= 0 do
			jsonnxt()
			pos2 = pos2 - (jsonlen - (pos-1))
			str = str .. sub(json, pos, pos2)
		end
		if jsonlen ~= 0 then
			pos = pos2+1
		end
		return str
	end

	local function tellpos()
		return acc + pos
	end

	return {
		run = run,
		tryc = tryc,
		read = read,
		tellpos = tellpos,
	}
end

return {
	newparser = newparser
}

end)
__bundle_register("ge_tts.lunajson.encoder", function(require, _LOADED, __bundle_register, __bundle_modules)
local error = error
local byte, find, format, gsub, match = string.byte, string.find, string.format,  string.gsub, string.match
local concat = table.concat
local tostring = tostring
local rawget, pairs, type = rawget, pairs, type
local setmetatable = setmetatable
local huge, tiny = 1/0, -1/0

local f_string_esc_pat = '[^ -!#-[%]^-\255]'
local _ENV = nil


local function newencoder()
	local v, nullv
	local i, builder, visited

	local function f_tostring(v)
		builder[i] = tostring(v)
		i = i+1
	end

	local radixmark = match(tostring(0.5), '[^0-9]')
	local delimmark = match(tostring(12345.12345), '[^0-9' .. radixmark .. ']')
	if radixmark == '.' then
		radixmark = nil
	end

	local radixordelim
	if radixmark or delimmark then
		radixordelim = true
		if radixmark and find(radixmark, '%W') then
			radixmark = '%' .. radixmark
		end
		if delimmark and find(delimmark, '%W') then
			delimmark = '%' .. delimmark
		end
	end

	local f_number = function(n)
		if tiny < n and n < huge then
			local s = format("%.17g", n)
			if radixordelim then
				if delimmark then
					s = gsub(s, delimmark, '')
				end
				if radixmark then
					s = gsub(s, radixmark, '.')
				end
			end
			builder[i] = s
			i = i+1
			return
		end
		error('invalid number')
	end

	local doencode

	local f_string_subst = {
		['"'] = '\\"',
		['\\'] = '\\\\',
		['\b'] = '\\b',
		['\f'] = '\\f',
		['\n'] = '\\n',
		['\r'] = '\\r',
		['\t'] = '\\t',
		__index = function(_, c)
			return format('\\u00%02X', byte(c))
		end
	}
	setmetatable(f_string_subst, f_string_subst)

	local function f_string(s)
		builder[i] = '"'
		if find(s, f_string_esc_pat) then
			s = gsub(s, f_string_esc_pat, f_string_subst)
		end
		builder[i+1] = s
		builder[i+2] = '"'
		i = i+3
	end

	local function f_table(o)
		if visited[o] then
			error("loop detected")
		end
		visited[o] = true

		local tmp = o[0]
		if type(tmp) == 'number' then -- arraylen available
			builder[i] = '['
			i = i+1
			for j = 1, tmp do
				doencode(o[j])
				builder[i] = ','
				i = i+1
			end
			if tmp > 0 then
				i = i-1
			end
			builder[i] = ']'

		else
			tmp = rawget(o, 1)
			if tmp ~= nil then -- detected as array
				builder[i] = '['
				i = i+1
				local j = 2
				repeat
					doencode(tmp)
					tmp = o[j]
					if tmp == nil then
						break
					end
					j = j+1
					builder[i] = ','
					i = i+1
				until false
				builder[i] = ']'

			else -- detected as object
				builder[i] = '{'
				i = i+1
				local tmp = i
				for k, v in pairs(o) do
					if type(k) ~= 'string' then
						error('non-string key: ' .. tostring(k) .. ' (' .. type(k) .. ')')
					end
					f_string(k)
					builder[i] = ':'
					i = i+1
					doencode(v)
					builder[i] = ','
					i = i+1
				end
				if i > tmp then
					i = i-1
				end
				builder[i] = '}'
			end
		end

		i = i+1
		visited[o] = nil
	end

	local dispatcher = {
		boolean = f_tostring,
		number = f_number,
		string = f_string,
		table = f_table,
		__index = function()
			error("invalid type value")
		end
	}
	setmetatable(dispatcher, dispatcher)

	function doencode(v)
		if v == nullv then
			builder[i] = 'null'
			i = i+1
			return
		end
		return dispatcher[type(v)](v)
	end

	local function encode(v_, nullv_)
		v, nullv = v_, nullv_
		i, builder, visited = 1, {}, {}

		doencode(v)
		return concat(builder)
	end

	return encode
end

return newencoder

end)
__bundle_register("ge_tts.lunajson.decoder", function(require, _LOADED, __bundle_register, __bundle_modules)
local setmetatable, tonumber, tostring =
      setmetatable, tonumber, tostring
local floor, inf =
      math.floor, math.huge
local mininteger, tointeger =
      math.mininteger or nil, math.tointeger or nil
local byte, char, find, gsub, match, sub =
      string.byte, string.char, string.find, string.gsub, string.match, string.sub

local function _decode_error(pos, errmsg)
	error("parse error at " .. pos .. ": " .. errmsg, 2)
end

local f_str_ctrl_pat = '[^\32-\255]'
local _ENV = nil


local function newdecoder()
	local json, pos, nullv, arraylen, rec_depth

	-- `f` is the temporary for dispatcher[c] and
	-- the dummy for the first return value of `find`
	local dispatcher, f

	--[[
		Helper
	--]]
	local function decode_error(errmsg)
		return _decode_error(pos, errmsg)
	end

	--[[
		Invalid
	--]]
	local function f_err()
		decode_error('invalid value')
	end

	--[[
		Constants
	--]]
	-- null
	local function f_nul()
		if sub(json, pos, pos+2) == 'ull' then
			pos = pos+3
			return nullv
		end
		decode_error('invalid value')
	end

	-- false
	local function f_fls()
		if sub(json, pos, pos+3) == 'alse' then
			pos = pos+4
			return false
		end
		decode_error('invalid value')
	end

	-- true
	local function f_tru()
		if sub(json, pos, pos+2) == 'rue' then
			pos = pos+3
			return true
		end
		decode_error('invalid value')
	end

	--[[
		Numbers
		Conceptually, the longest prefix that matches to `[-+.0-9A-Za-z]+` (in regexp)
		is captured as a number and its conformance to the JSON spec is checked.
	--]]
	-- deal with non-standard locales
	local radixmark = match(tostring(0.5), '[^0-9]')
	local fixedtonumber = tonumber
	if radixmark ~= '.' then
		if find(radixmark, '%W') then
			radixmark = '%' .. radixmark
		end
		fixedtonumber = function(s)
			return tonumber(gsub(s, '.', radixmark))
		end
	end

	local function number_error()
		return decode_error('invalid number')
	end

	-- `0(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_zro(mns)
		local num, c = match(json, '^(%.?[0-9]*)([-+.A-Za-z]?)', pos)  -- skipping 0

		if num == '' then
			if c == '' then
				if mns then
					return -0.0
				end
				return 0
			end

			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
				if c == '' then
					pos = pos + #num
					if mns then
						return -0.0
					end
					return 0.0
				end
			end
			number_error()
		end

		if byte(num) ~= 0x2E or byte(num, -1) == 0x2E then
			number_error()
		end

		if c ~= '' then
			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			end
			if c ~= '' then
				number_error()
			end
		end

		pos = pos + #num
		c = fixedtonumber(num)

		if mns then
			c = -c
		end
		return c
	end

	-- `[1-9][0-9]*(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_num(mns)
		pos = pos-1
		local num, c = match(json, '^([0-9]+%.?[0-9]*)([-+.A-Za-z]?)', pos)
		if byte(num, -1) == 0x2E then  -- error if ended with period
			number_error()
		end

		if c ~= '' then
			if c ~= 'e' and c ~= 'E' then
				number_error()
			end
			num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			if not num or c ~= '' then
				number_error()
			end
		end

		pos = pos + #num
		c = fixedtonumber(num)

		if mns then
			c = -c
			if c == mininteger and not find(num, '[^0-9]') then
				c = mininteger
			end
		end
		return c
	end

	-- skip minus sign
	local function f_mns()
		local c = byte(json, pos)
		if c then
			pos = pos+1
			if c > 0x30 then
				if c < 0x3A then
					return f_num(true)
				end
			else
				if c > 0x2F then
					return f_zro(true)
				end
			end
		end
		decode_error('invalid number')
	end

	--[[
		Strings
	--]]
	local f_str_hextbl = {
		0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
		0x8, 0x9, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
		__index = function()
			return inf
		end
	}
	setmetatable(f_str_hextbl, f_str_hextbl)

	local f_str_escapetbl = {
		['"']  = '"',
		['\\'] = '\\',
		['/']  = '/',
		['b']  = '\b',
		['f']  = '\f',
		['n']  = '\n',
		['r']  = '\r',
		['t']  = '\t',
		__index = function()
			decode_error("invalid escape sequence")
		end
	}
	setmetatable(f_str_escapetbl, f_str_escapetbl)

	local function surrogate_first_error()
		return decode_error("1st surrogate pair byte not continued by 2nd")
	end

	local f_str_surrogate_prev = 0
	local function f_str_subst(ch, ucode)
		if ch == 'u' then
			local c1, c2, c3, c4, rest = byte(ucode, 1, 5)
			ucode = f_str_hextbl[c1-47] * 0x1000 +
			        f_str_hextbl[c2-47] * 0x100 +
			        f_str_hextbl[c3-47] * 0x10 +
			        f_str_hextbl[c4-47]
			if ucode ~= inf then
				if ucode < 0x80 then  -- 1byte
					if rest then
						return char(ucode, rest)
					end
					return char(ucode)
				elseif ucode < 0x800 then  -- 2bytes
					c1 = floor(ucode / 0x40)
					c2 = ucode - c1 * 0x40
					c1 = c1 + 0xC0
					c2 = c2 + 0x80
					if rest then
						return char(c1, c2, rest)
					end
					return char(c1, c2)
				elseif ucode < 0xD800 or 0xE000 <= ucode then  -- 3bytes
					c1 = floor(ucode / 0x1000)
					ucode = ucode - c1 * 0x1000
					c2 = floor(ucode / 0x40)
					c3 = ucode - c2 * 0x40
					c1 = c1 + 0xE0
					c2 = c2 + 0x80
					c3 = c3 + 0x80
					if rest then
						return char(c1, c2, c3, rest)
					end
					return char(c1, c2, c3)
				elseif 0xD800 <= ucode and ucode < 0xDC00 then  -- surrogate pair 1st
					if f_str_surrogate_prev == 0 then
						f_str_surrogate_prev = ucode
						if not rest then
							return ''
						end
						surrogate_first_error()
					end
					f_str_surrogate_prev = 0
					surrogate_first_error()
				else  -- surrogate pair 2nd
					if f_str_surrogate_prev ~= 0 then
						ucode = 0x10000 +
						        (f_str_surrogate_prev - 0xD800) * 0x400 +
						        (ucode - 0xDC00)
						f_str_surrogate_prev = 0
						c1 = floor(ucode / 0x40000)
						ucode = ucode - c1 * 0x40000
						c2 = floor(ucode / 0x1000)
						ucode = ucode - c2 * 0x1000
						c3 = floor(ucode / 0x40)
						c4 = ucode - c3 * 0x40
						c1 = c1 + 0xF0
						c2 = c2 + 0x80
						c3 = c3 + 0x80
						c4 = c4 + 0x80
						if rest then
							return char(c1, c2, c3, c4, rest)
						end
						return char(c1, c2, c3, c4)
					end
					decode_error("2nd surrogate pair byte appeared without 1st")
				end
			end
			decode_error("invalid unicode codepoint literal")
		end
		if f_str_surrogate_prev ~= 0 then
			f_str_surrogate_prev = 0
			surrogate_first_error()
		end
		return f_str_escapetbl[ch] .. ucode
	end

	-- caching interpreted keys for speed
	local f_str_keycache = setmetatable({}, {__mode="v"})

	local function f_str(iskey)
		local newpos = pos
		local tmppos, c1, c2
		repeat
			newpos = find(json, '"', newpos, true)  -- search '"'
			if not newpos then
				decode_error("unterminated string")
			end
			tmppos = newpos-1
			newpos = newpos+1
			c1, c2 = byte(json, tmppos-1, tmppos)
			if c2 == 0x5C and c1 == 0x5C then  -- skip preceding '\\'s
				repeat
					tmppos = tmppos-2
					c1, c2 = byte(json, tmppos-1, tmppos)
				until c2 ~= 0x5C or c1 ~= 0x5C
				tmppos = newpos-2
			end
		until c2 ~= 0x5C  -- leave if '"' is not preceded by '\'

		local str = sub(json, pos, tmppos)
		pos = newpos

		if iskey then  -- check key cache
			tmppos = f_str_keycache[str]  -- reuse tmppos for cache key/val
			if tmppos then
				return tmppos
			end
			tmppos = str
		end

		if find(str, f_str_ctrl_pat) then
			decode_error("unescaped control string")
		end
		if find(str, '\\', 1, true) then  -- check whether a backslash exists
			-- We need to grab 4 characters after the escape char,
			-- for encoding unicode codepoint to UTF-8.
			-- As we need to ensure that every first surrogate pair byte is
			-- immediately followed by second one, we grab upto 5 characters and
			-- check the last for this purpose.
			str = gsub(str, '\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)', f_str_subst)
			if f_str_surrogate_prev ~= 0 then
				f_str_surrogate_prev = 0
				decode_error("1st surrogate pair byte not continued by 2nd")
			end
		end
		if iskey then  -- commit key cache
			f_str_keycache[tmppos] = str
		end
		return str
	end

	--[[
		Arrays, Objects
	--]]
	-- array
	local function f_ary()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			decode_error('too deeply nested json (> 1000)')
		end
		local ary = {}

		pos = match(json, '^[ \n\r\t]*()', pos)

		local i = 0
		if byte(json, pos) == 0x5D then  -- check closing bracket ']' which means the array empty
			pos = pos+1
		else
			local newpos = pos
			repeat
				i = i+1
				f = dispatcher[byte(json,newpos)]  -- parse value
				pos = newpos+1
				ary[i] = f()
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)  -- check comma
			until not newpos

			newpos = match(json, '^[ \n\r\t]*%]()', pos)  -- check closing bracket
			if not newpos then
				decode_error("no closing bracket of an array")
			end
			pos = newpos
		end

		if arraylen then -- commit the length of the array if `arraylen` is set
			ary[0] = i
		end
		rec_depth = rec_depth - 1
		return ary
	end

	-- objects
	local function f_obj()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			decode_error('too deeply nested json (> 1000)')
		end
		local obj = {}

		pos = match(json, '^[ \n\r\t]*()', pos)
		if byte(json, pos) == 0x7D then  -- check closing bracket '}' which means the object empty
			pos = pos+1
		else
			local newpos = pos

			repeat
				if byte(json, newpos) ~= 0x22 then  -- check '"'
					decode_error("not key")
				end
				pos = newpos+1
				local key = f_str(true)  -- parse key

				-- optimized for compact json
				-- c1, c2 == ':', <the first char of the value> or
				-- c1, c2, c3 == ':', ' ', <the first char of the value>
				f = f_err
				local c1, c2, c3 = byte(json, pos, pos+3)
				if c1 == 0x3A then
					if c2 ~= 0x20 then
						f = dispatcher[c2]
						newpos = pos+2
					else
						f = dispatcher[c3]
						newpos = pos+3
					end
				end
				if f == f_err then  -- read a colon and arbitrary number of spaces
					newpos = match(json, '^[ \n\r\t]*:[ \n\r\t]*()', pos)
					if not newpos then
						decode_error("no colon after a key")
					end
					f = dispatcher[byte(json, newpos)]
					newpos = newpos+1
				end
				pos = newpos
				obj[key] = f()  -- parse value
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)
			until not newpos

			newpos = match(json, '^[ \n\r\t]*}()', pos)
			if not newpos then
				decode_error("no closing bracket of an object")
			end
			pos = newpos
		end

		rec_depth = rec_depth - 1
		return obj
	end

	--[[
		The jump table to dispatch a parser for a value,
		indexed by the code of the value's first char.
		Nil key means the end of json.
	--]]
	dispatcher = { [0] =
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_str, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_mns, f_err, f_err,
		f_zro, f_num, f_num, f_num, f_num, f_num, f_num, f_num,
		f_num, f_num, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_ary, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_fls, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_nul, f_err,
		f_err, f_err, f_err, f_err, f_tru, f_err, f_err, f_err,
		f_err, f_err, f_err, f_obj, f_err, f_err, f_err, f_err,
		__index = function()
			decode_error("unexpected termination")
		end
	}
	setmetatable(dispatcher, dispatcher)

	--[[
		run decoder
	--]]
	local function decode(json_, pos_, nullv_, arraylen_)
		json, pos, nullv, arraylen = json_, pos_, nullv_, arraylen_
		rec_depth = 0

		pos = match(json, '^[ \n\r\t]*()', pos)

		f = dispatcher[byte(json, pos)]
		pos = pos+1
		local v = f()

		if pos_ then
			return v, pos
		else
			f, pos = find(json, '^[ \n\r\t]*', pos)
			if pos ~= #json then
				decode_error('json ended')
			end
			return v
		end
	end

	return decode
end

return newdecoder

end)
__bundle_register("ge_tts.Coroutine", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class ge_tts__Coroutine
local Coroutine = {}

---@param co thread
---@param onError nil | fun(message: string): void
local function resumeWithErrorHandling(co, onError)
    local result, message = coroutine.resume(co)

    if not result then
        if onError then
            (--[[---@not nil]] onError)(message)
        else
            error(message)
        end
    end
end

--- Yields from the current coroutine. Resumes once a condition is met or an optional timeout is reached.
---@overload fun(condition: fun(): boolean): true
---@overload fun(condition: (fun(): boolean), timeout: number): boolean
---@param condition fun(): boolean @Return true when the current coroutine should be resumed.
---@param timeout nil | number @Timeout in seconds (optional).
---@param onError nil | fun(message: string): void @A handler for any errors raised by the current coroutine after it has been resumed.
---@return boolean @True if the condition was met, or false if the (optional) timeout was reached.
function Coroutine.yieldCondition(condition, timeout, onError)
    local co = coroutine.running()

    ---@type nil | boolean
    local conditionMet

    local resume = function()
        conditionMet = true
        resumeWithErrorHandling(co, onError)
    end

    if timeout then
        Wait.condition(resume, condition, --[[---@not nil]] timeout, function()
            conditionMet = false
            resumeWithErrorHandling(co, onError)
        end)
    else
        Wait.condition(resume, condition)
    end

    coroutine.yield()

    if conditionMet == nil then
        error("Coroutine.yieldCondition(): attempt to resume before Wait was completed!")
    end

    return --[[---@not nil]] conditionMet
end

--- Yields from the current coroutine, which will later be resumed after the specified number of frames have passed.
---@overload fun(frames: number): void
---@param frames number
---@param onError nil | fun(message: string): void @A handler for any errors raised by the current coroutine after it has been resumed.
function Coroutine.yieldFrames(frames, onError)
    local co = coroutine.running()

    ---@type boolean
    local done

    Wait.frames(function()
        done = true
        resumeWithErrorHandling(co, onError)
    end, frames)

    coroutine.yield()

    if not done then
        error("Coroutine.yieldFrames(): attempt to resume before Wait was completed!")
    end
end

--- Yields from the current coroutine, which will later be resumed after the specified number of seconds have passed.
---@overload fun(seconds: number): void
---@param seconds number
---@param onError nil | fun(message: string): void @A handler for any errors raised by the current coroutine after it has been resumed.
function Coroutine.yieldSeconds(seconds, onError)
    local co = coroutine.running()

    ---@type boolean
    local done

    Wait.time(function()
        done = true
        resumeWithErrorHandling(co, onError)
    end, seconds)

    coroutine.yield()

    if not done then
        error("Coroutine.yieldSeconds(): attempt to resume before Wait was completed!")
    end
end

--- Creates a co-routine from the specified function, and immediately starts it.
---@param func fun
---@return boolean, any...
function Coroutine.start(func)
    return coroutine.resume(coroutine.create(func))
end

return Coroutine

end)
__bundle_register("ge_tts.GlobalPatches", function(require, _LOADED, __bundle_register, __bundle_modules)
-- From time to time there are bugs in TTS' APIs that we're able to fix/patch in a non-intrusive fashion.

-- Lua Color indexing fix, see: https://github.com/Berserk-Games/Tabletop-Simulator-Lua-Classes/pull/1

---@type {__index: fun(c: any, k: any): any}
local colorMetatable = getmetatable(Color)
local originalColorIndex = colorMetatable.__index

colorMetatable.__index = function(c, k)
    if type(k) ~= 'string' then
        return nil
    end

    return originalColorIndex(c, k)
end

end)
__bundle_register("ge_tts.Logger", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class ge_tts__Logger

---@class ge_tts__static_Logger
---@overload fun(): ge_tts__Logger
local Logger = {}

Logger.ERROR = 1
Logger.WARNING = 2
Logger.INFO = 3
Logger.DEBUG = 4
Logger.VERBOSE = 5

---@alias ge_tts__Logger_LogLevel 1 | 2 | 3 | 4 | 5

---@type table<ge_tts__Logger_LogLevel, string>
local levelPrefixes = {
    [Logger.ERROR] = 'ERROR: ',
    [Logger.WARNING] = 'WARNING: ',
    [Logger.INFO] = '',
    [Logger.DEBUG] = '',
    [Logger.VERBOSE] = '',
}

---@type ge_tts__Logger_LogLevel
local defaultLogLevel = Logger.DEBUG

setmetatable(Logger, {
    __call = function()
        local self = --[[---@type ge_tts__Logger]] {}

        ---@type ge_tts__Logger_LogLevel
        local filterLevel = Logger.INFO

        ---@return ge_tts__Logger_LogLevel
        function self.getFilterLevel()
            return filterLevel
        end

        ---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
        function self.setFilterLevel(level)
            filterLevel = level
        end

        ---@param message string
        ---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
        function self.log(message, level)
            level = level or defaultLogLevel
            if level <= filterLevel then
                print(levelPrefixes[level] .. message)
            end
        end

        ---
        ---If value is false, logs message at level Logger.ERROR and then calls Lua's in-built error(message).
        ---
        ---@param value any
        ---@param message string
        function self.assert(value, message)
            if not value then
                self.log(message, Logger.ERROR)
                error(message, 2)
            end
        end

        return self
    end
})

local defaultLogger = Logger()

---@param logger ge_tts__Logger
function Logger.setDefaultLogger(logger)
    defaultLogger = logger
end

function Logger.getDefaultLogger()
    return defaultLogger
end

---
---When calling log() without specifying a log level, messages will log at the provided log level.
---
---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
function Logger.setDefaultLogLevel(level)
    defaultLogLevel = level
end

---
---Returns the default log level.
---
---@return ge_tts__Logger_LogLevel
function Logger.getDefaultLogLevel()
    return defaultLogLevel
end

---
---Logs a message at the specified log level. If level is omitted, the default log level will be used.
---
---@overload fun(message: string): void
---@param message string
---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
function Logger.log(message, level)
    level = level or defaultLogLevel
    defaultLogger.log(message, level)
end

---
---If value is false, logs message at level Logger.ERROR using the default logger, and then calls Lua's error(message).
---
---@param value any
---@param message string
function Logger.assert(value, message)
    if not value then
        defaultLogger.log(message, Logger.ERROR)
        error(message, 2)
    end
end

return Logger

end)
__bundle_register("ge_tts.Base64", function(require, _LOADED, __bundle_register, __bundle_modules)
-- Base64 implementation originally based on https://github.com/iskolbin/lbase64 (public domain),
-- but modified for simplicity, TTS and to work with number[] buffers, rather than strings.

local TableUtils = require("ge_tts.TableUtils")

---@class ge_tts__Base64
local Base64 = {}

local extract = bit32.extract

local PAD_KEY = 64

---@overload fun(char62: string, char63: string): table<number, number>
---@overload fun(char62: string): table<number, number>
---@overload fun(): table<number, number>
---@param char62 string
---@param char63 string
---@param charPad string
---@return table<number, number>
function Base64.encodingMap(char62, char63, charPad)
    ---@type table<number, number>
    local encodingTable = {}

    for b64code, char in pairs({
        [0] = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
        'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
        'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2',
        '3', '4', '5', '6', '7', '8', '9', char62 or '+', char63 or '/', charPad or '='
    }) do
        encodingTable[b64code] = char:byte()
    end

    return encodingTable
end

---@overload fun(char62: string, char63: string): table<number, number>
---@overload fun(char62: string): table<number, number>
---@overload fun(): table<number, number>
---@param char62 string
---@param char63 string
---@param charPad string
---@return table<number, number>
function Base64.decodingMap(char62, char63, charPad)
    return TableUtils.invert(Base64.encodingMap(char62, char63, charPad))
end

local DEFAULT_ENCODING_MAP = Base64.encodingMap()
local DEFAULT_DECODING_MAP = Base64.decodingMap()

---@overload fun(buffer: number[], pad: boolean): string
---@overload fun(buffer: number[]): string
---@param buffer number[]
---@param pad boolean
---@param map table<number, number>
---@return string
function Base64.encode(buffer, pad, map)
    pad = pad == nil or pad
    map = map or DEFAULT_ENCODING_MAP

    ---@type string[]
    local components = {}
    local index = 1
    local length = #buffer
    local lastComponentSize = length % 3

    for offset = 1, length - lastComponentSize, 3 do
        local a, b, c = --[[---@not nil, nil, nil]] table.unpack(buffer, offset, offset + 2)
        local v = a * 0x10000 + b * 0x100 + c

        components[index] = string.char(map[extract(v, 18, 6)], map[extract(v, 12, 6)], map[extract(v, 6, 6)], map[extract(v, 0, 6)])
        index = index + 1
    end

    if lastComponentSize == 2 then
        local a, b = --[[---@not nil, nil]] table.unpack(buffer, length - 1, length)
        local v = a * 0x10000 + b * 0x100

        components[index] = string.char(map[extract(v, 18, 6)], map[extract(v, 12, 6)], map[extract(v, 6, 6)]) .. (pad and string.char(map[PAD_KEY]) or '')
    elseif lastComponentSize == 1 then
        local v = buffer[length] * 0x10000

        components[index] = string.char(map[extract(v, 18, 6)], map[extract(v, 12, 6)]) .. (pad and string.char(map[PAD_KEY], map[PAD_KEY]) or '')
    end

    return table.concat(components)
end

---@overload fun(b64: string): number[]
---@param b64 string
---@param map table<number, number>
---@return number[]
function Base64.decode(b64, map)
    map = map or DEFAULT_DECODING_MAP

    ---@type number[]
    local buffer = {}
    local offset = 1

    local length = #b64

    if map[--[[---@not nil]] b64:sub(-2, -2):byte()] == PAD_KEY then
        length = length - 2
    elseif map[--[[---@not nil]] b64:sub(-1, -1):byte()] == PAD_KEY then
        length = length - 1
    end

    local lastBlockSize = length % 4
    local fullBlockEnd = length - lastBlockSize

    for i = 1, fullBlockEnd, 4 do
        local a, b, c, d = --[[---@not nil, nil, nil, nil]] b64:byte(i, i + 3)

        local v = map[a] * 0x40000 + map[b] * 0x1000 + map[c] * 0x40 + map[d]

        buffer[offset] = extract(v, 16, 8)
        buffer[offset + 1] = extract(v, 8, 8)
        buffer[offset + 2] = extract(v, 0, 8)

        offset = offset + 3
    end


    if lastBlockSize == 3 then
        local a, b, c = --[[---@not nil, nil, nil]] b64:byte(fullBlockEnd + 1, fullBlockEnd + 3)
        local v = map[a] * 0x40000 + map[b] * 0x1000 + map[c] * 0x40

        buffer[offset] = extract(v, 16, 8)
        buffer[offset + 1] = extract(v, 8, 8)
    elseif lastBlockSize == 2 then
        local a, b = --[[---@not nil, nil]] b64:byte(fullBlockEnd + 1, fullBlockEnd + 2)
        local v = map[a] * 0x40000 + map[b] * 0x1000

        buffer[offset] = extract(v, 16, 8)
    end

    return buffer
end

return Base64

end)
return __bundle_require("__root")
end)
__bundle_register("ge_tts.TableUtils", function(require, _LOADED, __bundle_register, __bundle_modules)
-- This module operates on tables that contain only positive consecutive integer keys starting at 1 (i.e. a plain array), as well as tables which contain no
-- array component. Behavior is undefined for tables that contain a key for [1] as well as non-consecutive integer or non-integer keys.

---@class ge_tts__TableUtils
local TableUtils = {}

--- Returns true if `tab` contains an entry at index 1. That being the case, this module will assume `tab` only contains sequential positive integer keys.
---@overload fun<V>(tab: V[]): true
---@overload fun<V>(tab: table<boolean, V>): false
---@overload fun<V>(tab: table<string, V>): false
---@overload fun<V>(tab: table<table, V>): false
---@overload fun<V>(tab: table<userdata, V>): false
---@param tab table
---@return boolean
function TableUtils.isArray(tab)
    return tab[1] ~= nil or type(tab[0]) == 'number'
end

---@overload fun<V, MappedV>(tab: V[], func: fun(value: V, key: number): MappedV): MappedV[]
---@generic K, V, MappedV
---@param tab table<K, V>
---@param func fun(value: V, key: K): MappedV
---@return table<K, MappedV>
function TableUtils.map(tab, func)
    ---@type table<K, MappedV>
    local mapped = {}

    if TableUtils.isArray(tab) then
        for i, v in ipairs(--[[---@type V[] ]] tab) do
            mapped[--[[---@type K]] i] = func(v, --[[---@type K]] i)
        end
    else
        for k, v in pairs(tab) do
            mapped[k] = func(v, k)
        end
    end

    return mapped
end

---@generic K, V
---@param tab table<K, V>
---@return table<V, K>
function TableUtils.invert(tab)
    ---@type table<V, K>
    local inverted = {}

    for k, v in pairs(tab) do
        inverted[v] = k
    end

    return inverted
end

---@generic K, V, RemappedK
---@param tab table<K, V>
---@param func fun(value: V, key: K): RemappedK
---@return table<RemappedK, V>
function TableUtils.remap(tab, func)
    local remapped = {}

    for k, v in pairs(tab) do
        remapped[func(v, k)] = v
    end

    return remapped
end

---@overload fun<V>(arr: V[], func: fun(value: V, index: number): boolean): V[]
---@generic K, V
---@param tab table<K, V>
---@param func fun(value: V, key: K): any
---@return table<K, V>
function TableUtils.select(tab, func)
    ---@type table<K, V>
    local selected = {}

    if TableUtils.isArray(tab) then
        local arr = tab
        for i, v in ipairs(--[[---@type V[] ]] arr) do
            if func(v, --[[---@type K]] i) then
                table.insert(--[[---@type V[] ]] selected, v)
            end
        end
    else
        for k, v in pairs(tab) do
            if func(v, k) then
                selected[k] = v
            end
        end
    end

    return selected
end

---@overload fun<V>(arr: V[], func: fun(value: V, index: number): boolean): V[]
---@generic K, V
---@param tab table<K, V>
---@param func fun(value: V, key: K): boolean
---@return table<K, V>
function TableUtils.reject(tab, func)
    return TableUtils.select(tab, function(v, k) return not func(v, k) end)
end

---@overload fun<R, K, V: R>(tab: table<K, V>, func: fun(memo: R, value: V, key: K): R): R
---@generic K, V, R
---@param tab table<K, V>
---@param initial R
---@param func fun(memo: R, value: V, key: K): R
---@return R
function TableUtils.reduce(tab, initial, func)
    local memo = func and initial or next(tab)
    local reducer = func or initial

    ---@type K
    local initialK

    if not func then
        initialK = --[[---@type K]] memo
    end

    for k, v in next, tab, initialK do
        memo = reducer(memo, v, k)
    end

    return memo
end

---@generic K, V
---@param tab table<K, V>
---@param value any
---@return nil | K
function TableUtils.find(tab, value)
    if TableUtils.isArray(tab) then
        for i, v in ipairs(--[[---@type any[] ]] tab) do
            if v == value then
                return --[[---@type K]] i
            end
        end
    else
        for k, v in pairs(tab) do
            if v == value then
                return k
            end
        end
    end

    return nil
end

---@generic K, V
---@param tab table<K, V>
---@param func fun(value: V, key: K): boolean
---@return nil | V, nil | K
function TableUtils.detect(tab, func)
    if TableUtils.isArray(tab) then
        for i, v in ipairs(--[[---@type V[] ]] tab) do
            if func(v, --[[---@type K]] i) then
                return v, --[[---@type K]] i
            end
        end
    else
        for k, v in pairs(tab) do
            if func(v, k) then
                return v, k
            end
        end
    end

    return nil, nil
end

---@overload fun<T>(tab: T): T
---@generic T
---@param tab T
---@param recursive boolean
---@return T
function TableUtils.copy(tab, recursive)
    ---@type table
    local copied = {}

    for k, v in pairs(--[[---@type table]] tab) do
        copied[k] = (recursive and type(v) == 'table' and
            TableUtils.copy(--[[---@type table]] v, true)
        ) or v
    end

    return --[[---@type T]] copied
end

---@generic K, V
---@param tab table
---@vararg table
function TableUtils.inject(tab, ...)
    local otherTables = { ... }

    for _, t in ipairs(otherTables) do
        if TableUtils.isArray(tab) then
            for _, v in ipairs(--[[---@type any[] ]] t) do
                table.insert(--[[---@type any[] ]] tab, v)
            end
        else
            for k, v in pairs(t) do
                tab[k] = v
            end
        end
    end
end

---@overload fun<T>(...: T): T
---@vararg table
---@return table
function TableUtils.merge(...)
    local merged = {}
    TableUtils.inject(merged, ...)
    return merged
end

---@generic V
---@param tab V[][]
---@return V[]
function TableUtils.flatten(tab)
    ---@type V[]
    local flattened = {}

    for _, subTable in ipairs(tab) do
        for _, v in ipairs(subTable) do
            table.insert(flattened, v)
        end
    end

    return flattened
end

---@generic K, V
---@param tab table<K, V>
---@return K[]
function TableUtils.keys(tab)
    ---@type K[]
    local keys = {}

    for k, _ in pairs(tab) do
        table.insert(keys, k)
    end

    return keys
end

---@generic K, V
---@param tab table<K, V>
---@return V[]
function TableUtils.values(tab)
    ---@type V[]
    local values = {}

    for _, v in pairs(tab) do
        table.insert(values, v)
    end

    return values
end

---@param tab table
---@return number
function TableUtils.count(tab)
    local count = 0

    for _, _ in pairs(tab) do
        count = count + 1
    end

    return count
end

---@generic V
---@param arr V[]
---@return V[]
function TableUtils.reverse(arr)
    local reversed = {}

    if TableUtils.isArray(arr) then
        for i = #arr, 1, -1 do
            table.insert(reversed, arr[i])
        end
    end

    return reversed
end

---@overload fun<T>(arr: V[], start: number): V[]
---@generic V
---@param arr V[]
---@param start number
---@param finish number
---@return V[]
function TableUtils.range(arr, start, finish)
    local range = {}

    if TableUtils.isArray(arr) then
        finish = finish and math.min(finish, #arr) or #arr

        for i = start, finish do
            table.insert(range, arr[i])
        end
    end

    return range
end

---@generic V
---@param arr V[]
---@return V[]
function TableUtils.unique(arr)
    local unique = {}

    for _, value in ipairs(arr) do
        if not TableUtils.find(unique, value) then
            table.insert(unique, value)
        end
    end

    return unique
end

local TYPE_STRINGIFIERS = {
    ['nil'] = function(_) return 'nil' end,
    boolean = function(v) return tostring(v) end,
    number = function(v) return tostring(v) end,
    string = function(v) return "'" .. v .. "'" end,
    userdata = function(_) return 'userdata' end,
    ['function'] = function(_) return 'function' end,
    thread = function(_) return 'thread' end,
    table = function(v) return tostring(v) end,
}

---@overload fun(tab: table): string
---@overload fun(tab: table, recursive: boolean): string
---@param tab table
---@param recursive boolean
---@param depth number
---@return string
function TableUtils.dump(tab, recursive, depth)
    depth = depth or 1

    local indentation = string.rep('  ', depth)
    local str = '{'

    ---@type table<any, boolean>
    local ordered_keys = {}

    for i, v in ipairs(--[[---@type any[] ]] tab) do
        ordered_keys[i] = true
        str = str .. '\n' .. indentation .. '[' .. i .. '] = '

        if recursive and type(v) == 'table' then
            str = str .. TableUtils.dump(v, true, depth + 1) .. ','
        else
            local a = TYPE_STRINGIFIERS['nil']
            str = str .. TYPE_STRINGIFIERS[type(v)](v) .. ','
        end
    end

    for k, v in pairs(tab) do
        if not ordered_keys[k] then
            str = str .. '\n' .. indentation .. '[' .. TYPE_STRINGIFIERS[type(k)](k) .. '] = '

            if recursive and type(v) == 'table' then
                str = str .. TableUtils.dump(v, true, depth + 1) .. ','
            else
                str = str .. TYPE_STRINGIFIERS[type(v)](v) .. ','
            end
        end
    end

    str = str .. '\n' .. string.rep('  ', depth - 1) .. '}'

    return str
end

return TableUtils

end)
__bundle_register("ge_tts.lunajson.sax", function(require, _LOADED, __bundle_register, __bundle_modules)
local setmetatable, tonumber, tostring =
      setmetatable, tonumber, tostring
local floor, inf =
      math.floor, math.huge
local mininteger, tointeger =
      math.mininteger or nil, math.tointeger or nil
local byte, char, find, gsub, match, sub =
      string.byte, string.char, string.find, string.gsub, string.match, string.sub

local function _parse_error(pos, errmsg)
	error("parse error at " .. pos .. ": " .. errmsg, 2)
end

local f_str_ctrl_pat = '[^\32-\255]'
local type, unpack = type, table.unpack or unpack

local _ENV = nil


local function nop() end

local function newparser(src, saxtbl)
	local json, jsonnxt, rec_depth
	local jsonlen, pos, acc = 0, 1, 0

	-- `f` is the temporary for dispatcher[c] and
	-- the dummy for the first return value of `find`
	local dispatcher, f

	-- initialize
	if type(src) == 'string' then
		json = src
		jsonlen = #json
		jsonnxt = function()
			json = ''
			jsonlen = 0
			jsonnxt = nop
		end
	else
		jsonnxt = function()
			acc = acc + jsonlen
			pos = 1
			repeat
				json = src()
				if not json then
					json = ''
					jsonlen = 0
					jsonnxt = nop
					return
				end
				jsonlen = #json
			until jsonlen > 0
		end
		jsonnxt()
	end

	local sax_startobject = saxtbl.startobject or nop
	local sax_key = saxtbl.key or nop
	local sax_endobject = saxtbl.endobject or nop
	local sax_startarray = saxtbl.startarray or nop
	local sax_endarray = saxtbl.endarray or nop
	local sax_string = saxtbl.string or nop
	local sax_number = saxtbl.number or nop
	local sax_boolean = saxtbl.boolean or nop
	local sax_null = saxtbl.null or nop

	--[[
		Helper
	--]]
	local function tryc()
		local c = byte(json, pos)
		if not c then
			jsonnxt()
			c = byte(json, pos)
		end
		return c
	end

	local function parse_error(errmsg)
		return _parse_error(acc + pos, errmsg)
	end

	local function tellc()
		return tryc() or parse_error("unexpected termination")
	end

	local function spaces()  -- skip spaces and prepare the next char
		while true do
			pos = match(json, '^[ \n\r\t]*()', pos)
			if pos <= jsonlen then
				return
			end
			if jsonlen == 0 then
				parse_error("unexpected termination")
			end
			jsonnxt()
		end
	end

	--[[
		Invalid
	--]]
	local function f_err()
		parse_error('invalid value')
	end

	--[[
		Constants
	--]]
	-- fallback slow constants parser
	local function generic_constant(target, targetlen, ret, sax_f)
		for i = 1, targetlen do
			local c = tellc()
			if byte(target, i) ~= c then
				parse_error("invalid char")
			end
			pos = pos+1
		end
		return sax_f(ret)
	end

	-- null
	local function f_nul()
		if sub(json, pos, pos+2) == 'ull' then
			pos = pos+3
			return sax_null(nil)
		end
		return generic_constant('ull', 3, nil, sax_null)
	end

	-- false
	local function f_fls()
		if sub(json, pos, pos+3) == 'alse' then
			pos = pos+4
			return sax_boolean(false)
		end
		return generic_constant('alse', 4, false, sax_boolean)
	end

	-- true
	local function f_tru()
		if sub(json, pos, pos+2) == 'rue' then
			pos = pos+3
			return sax_boolean(true)
		end
		return generic_constant('rue', 3, true, sax_boolean)
	end

	--[[
		Numbers
		Conceptually, the longest prefix that matches to `[-+.0-9A-Za-z]+` (in regexp)
		is captured as a number and its conformance to the JSON spec is checked.
	--]]
	-- deal with non-standard locales
	local radixmark = match(tostring(0.5), '[^0-9]')
	local fixedtonumber = tonumber
	if radixmark ~= '.' then
		if find(radixmark, '%W') then
			radixmark = '%' .. radixmark
		end
		fixedtonumber = function(s)
			return tonumber(gsub(s, '.', radixmark))
		end
	end

	local function number_error()
		return parse_error('invalid number')
	end

	-- fallback slow parser
	local function generic_number(mns)
		local buf = {}
		local i = 1
		local is_int = true

		local c = byte(json, pos)
		pos = pos+1

		local function nxt()
			buf[i] = c
			i = i+1
			c = tryc()
			pos = pos+1
		end

		if c == 0x30 then
			nxt()
			if c and 0x30 <= c and c < 0x3A then
				number_error()
			end
		else
			repeat nxt() until not (c and 0x30 <= c and c < 0x3A)
		end
		if c == 0x2E then
			is_int = false
			nxt()
			if not (c and 0x30 <= c and c < 0x3A) then
				number_error()
			end
			repeat nxt() until not (c and 0x30 <= c and c < 0x3A)
		end
		if c == 0x45 or c == 0x65 then
			is_int = false
			nxt()
			if c == 0x2B or c == 0x2D then
				nxt()
			end
			if not (c and 0x30 <= c and c < 0x3A) then
				number_error()
			end
			repeat nxt() until not (c and 0x30 <= c and c < 0x3A)
		end
		if c and (0x41 <= c and c <= 0x5B or
		          0x61 <= c and c <= 0x7B or
		          c == 0x2B or c == 0x2D or c == 0x2E) then
			number_error()
		end
		pos = pos-1

		local num = char(unpack(buf))
		num = fixedtonumber(num)
		if mns then
			num = -num
			if num == mininteger and is_int then
				num = mininteger
			end
		end
		return sax_number(num)
	end

	-- `0(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_zro(mns)
		local num, c = match(json, '^(%.?[0-9]*)([-+.A-Za-z]?)', pos)  -- skipping 0

		if num == '' then
			if pos > jsonlen then
				pos = pos - 1
				return generic_number(mns)
			end
			if c == '' then
				if mns then
					return sax_number(-0.0)
				end
				return sax_number(0)
			end

			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
				if c == '' then
					pos = pos + #num
					if pos > jsonlen then
						pos = pos - #num - 1
						return generic_number(mns)
					end
					if mns then
						return sax_number(-0.0)
					end
					return sax_number(0.0)
				end
			end
			pos = pos-1
			return generic_number(mns)
		end

		if byte(num) ~= 0x2E or byte(num, -1) == 0x2E then
			pos = pos-1
			return generic_number(mns)
		end

		if c ~= '' then
			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			end
			if c ~= '' then
				pos = pos-1
				return generic_number(mns)
			end
		end

		pos = pos + #num
		if pos > jsonlen then
			pos = pos - #num - 1
			return generic_number(mns)
		end
		c = fixedtonumber(num)

		if mns then
			c = -c
		end
		return sax_number(c)
	end

	-- `[1-9][0-9]*(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_num(mns)
		pos = pos-1
		local num, c = match(json, '^([0-9]+%.?[0-9]*)([-+.A-Za-z]?)', pos)
		if byte(num, -1) == 0x2E then  -- error if ended with period
			return generic_number(mns)
		end

		if c ~= '' then
			if c ~= 'e' and c ~= 'E' then
				return generic_number(mns)
			end
			num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			if not num or c ~= '' then
				return generic_number(mns)
			end
		end

		pos = pos + #num
		if pos > jsonlen then
			pos = pos - #num
			return generic_number(mns)
		end
		c = fixedtonumber(num)

		if mns then
			c = -c
			if c == mininteger and not find(num, '[^0-9]') then
				c = mininteger
			end
		end
		return sax_number(c)
	end

	-- skip minus sign
	local function f_mns()
		local c = byte(json, pos) or tellc()
		if c then
			pos = pos+1
			if c > 0x30 then
				if c < 0x3A then
					return f_num(true)
				end
			else
				if c > 0x2F then
					return f_zro(true)
				end
			end
		end
		parse_error("invalid number")
	end

	--[[
		Strings
	--]]
	local f_str_hextbl = {
		0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
		0x8, 0x9, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
		__index = function()
			return inf
		end
	}
	setmetatable(f_str_hextbl, f_str_hextbl)

	local f_str_escapetbl = {
		['"']  = '"',
		['\\'] = '\\',
		['/']  = '/',
		['b']  = '\b',
		['f']  = '\f',
		['n']  = '\n',
		['r']  = '\r',
		['t']  = '\t',
		__index = function()
			parse_error("invalid escape sequence")
		end
	}
	setmetatable(f_str_escapetbl, f_str_escapetbl)

	local function surrogate_first_error()
		return parse_error("1st surrogate pair byte not continued by 2nd")
	end

	local f_str_surrogate_prev = 0
	local function f_str_subst(ch, ucode)
		if ch == 'u' then
			local c1, c2, c3, c4, rest = byte(ucode, 1, 5)
			ucode = f_str_hextbl[c1-47] * 0x1000 +
			        f_str_hextbl[c2-47] * 0x100 +
			        f_str_hextbl[c3-47] * 0x10 +
			        f_str_hextbl[c4-47]
			if ucode ~= inf then
				if ucode < 0x80 then  -- 1byte
					if rest then
						return char(ucode, rest)
					end
					return char(ucode)
				elseif ucode < 0x800 then  -- 2bytes
					c1 = floor(ucode / 0x40)
					c2 = ucode - c1 * 0x40
					c1 = c1 + 0xC0
					c2 = c2 + 0x80
					if rest then
						return char(c1, c2, rest)
					end
					return char(c1, c2)
				elseif ucode < 0xD800 or 0xE000 <= ucode then  -- 3bytes
					c1 = floor(ucode / 0x1000)
					ucode = ucode - c1 * 0x1000
					c2 = floor(ucode / 0x40)
					c3 = ucode - c2 * 0x40
					c1 = c1 + 0xE0
					c2 = c2 + 0x80
					c3 = c3 + 0x80
					if rest then
						return char(c1, c2, c3, rest)
					end
					return char(c1, c2, c3)
				elseif 0xD800 <= ucode and ucode < 0xDC00 then  -- surrogate pair 1st
					if f_str_surrogate_prev == 0 then
						f_str_surrogate_prev = ucode
						if not rest then
							return ''
						end
						surrogate_first_error()
					end
					f_str_surrogate_prev = 0
					surrogate_first_error()
				else  -- surrogate pair 2nd
					if f_str_surrogate_prev ~= 0 then
						ucode = 0x10000 +
						        (f_str_surrogate_prev - 0xD800) * 0x400 +
						        (ucode - 0xDC00)
						f_str_surrogate_prev = 0
						c1 = floor(ucode / 0x40000)
						ucode = ucode - c1 * 0x40000
						c2 = floor(ucode / 0x1000)
						ucode = ucode - c2 * 0x1000
						c3 = floor(ucode / 0x40)
						c4 = ucode - c3 * 0x40
						c1 = c1 + 0xF0
						c2 = c2 + 0x80
						c3 = c3 + 0x80
						c4 = c4 + 0x80
						if rest then
							return char(c1, c2, c3, c4, rest)
						end
						return char(c1, c2, c3, c4)
					end
					parse_error("2nd surrogate pair byte appeared without 1st")
				end
			end
			parse_error("invalid unicode codepoint literal")
		end
		if f_str_surrogate_prev ~= 0 then
			f_str_surrogate_prev = 0
			surrogate_first_error()
		end
		return f_str_escapetbl[ch] .. ucode
	end

	local function f_str(iskey)
		local pos2 = pos
		local newpos
		local str = ''
		local bs
		while true do
			while true do  -- search '\' or '"'
				newpos = find(json, '[\\"]', pos2)
				if newpos then
					break
				end
				str = str .. sub(json, pos, jsonlen)
				if pos2 == jsonlen+2 then
					pos2 = 2
				else
					pos2 = 1
				end
				jsonnxt()
				if jsonlen == 0 then
					parse_error("unterminated string")
				end
			end
			if byte(json, newpos) == 0x22 then  -- break if '"'
				break
			end
			pos2 = newpos+2  -- skip '\<char>'
			bs = true  -- mark the existence of a backslash
		end
		str = str .. sub(json, pos, newpos-1)
		pos = newpos+1

		if find(str, f_str_ctrl_pat) then
			parse_error("unescaped control string")
		end
		if bs then  -- a backslash exists
			-- We need to grab 4 characters after the escape char,
			-- for encoding unicode codepoint to UTF-8.
			-- As we need to ensure that every first surrogate pair byte is
			-- immediately followed by second one, we grab upto 5 characters and
			-- check the last for this purpose.
			str = gsub(str, '\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)', f_str_subst)
			if f_str_surrogate_prev ~= 0 then
				f_str_surrogate_prev = 0
				parse_error("1st surrogate pair byte not continued by 2nd")
			end
		end

		if iskey then
			return sax_key(str)
		end
		return sax_string(str)
	end

	--[[
		Arrays, Objects
	--]]
	-- arrays
	local function f_ary()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			parse_error('too deeply nested json (> 1000)')
		end
		sax_startarray()

		spaces()
		if byte(json, pos) == 0x5D then  -- check closing bracket ']' which means the array empty
			pos = pos+1
		else
			local newpos
			while true do
				f = dispatcher[byte(json, pos)]  -- parse value
				pos = pos+1
				f()
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)  -- check comma
				if newpos then
					pos = newpos
				else
					newpos = match(json, '^[ \n\r\t]*%]()', pos)  -- check closing bracket
					if newpos then
						pos = newpos
						break
					end
					spaces()  -- since the current chunk can be ended, skip spaces toward following chunks
					local c = byte(json, pos)
					pos = pos+1
					if c == 0x2C then  -- check comma again
						spaces()
					elseif c == 0x5D then  -- check closing bracket again
						break
					else
						parse_error("no closing bracket of an array")
					end
				end
				if pos > jsonlen then
					spaces()
				end
			end
		end

		rec_depth = rec_depth - 1
		return sax_endarray()
	end

	-- objects
	local function f_obj()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			parse_error('too deeply nested json (> 1000)')
		end
		sax_startobject()

		spaces()
		if byte(json, pos) == 0x7D then  -- check closing bracket '}' which means the object empty
			pos = pos+1
		else
			local newpos
			while true do
				if byte(json, pos) ~= 0x22 then
					parse_error("not key")
				end
				pos = pos+1
				f_str(true)  -- parse key
				newpos = match(json, '^[ \n\r\t]*:[ \n\r\t]*()', pos)  -- check colon
				if newpos then
					pos = newpos
				else
					spaces()  -- read spaces through chunks
					if byte(json, pos) ~= 0x3A then  -- check colon again
						parse_error("no colon after a key")
					end
					pos = pos+1
					spaces()
				end
				if pos > jsonlen then
					spaces()
				end
				f = dispatcher[byte(json, pos)]
				pos = pos+1
				f()  -- parse value
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)  -- check comma
				if newpos then
					pos = newpos
				else
					newpos = match(json, '^[ \n\r\t]*}()', pos)  -- check closing bracket
					if newpos then
						pos = newpos
						break
					end
					spaces()  -- read spaces through chunks
					local c = byte(json, pos)
					pos = pos+1
					if c == 0x2C then  -- check comma again
						spaces()
					elseif c == 0x7D then  -- check closing bracket again
						break
					else
						parse_error("no closing bracket of an object")
					end
				end
				if pos > jsonlen then
					spaces()
				end
			end
		end

		rec_depth = rec_depth - 1
		return sax_endobject()
	end

	--[[
		The jump table to dispatch a parser for a value,
		indexed by the code of the value's first char.
		Key should be non-nil.
	--]]
	dispatcher = { [0] =
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_str, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_mns, f_err, f_err,
		f_zro, f_num, f_num, f_num, f_num, f_num, f_num, f_num,
		f_num, f_num, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_ary, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_fls, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_nul, f_err,
		f_err, f_err, f_err, f_err, f_tru, f_err, f_err, f_err,
		f_err, f_err, f_err, f_obj, f_err, f_err, f_err, f_err,
	}

	--[[
		public funcitons
	--]]
	local function run()
		rec_depth = 0
		spaces()
		f = dispatcher[byte(json, pos)]
		pos = pos+1
		f()
	end

	local function read(n)
		if n < 0 then
			error("the argument must be non-negative")
		end
		local pos2 = (pos-1) + n
		local str = sub(json, pos, pos2)
		while pos2 > jsonlen and jsonlen ~= 0 do
			jsonnxt()
			pos2 = pos2 - (jsonlen - (pos-1))
			str = str .. sub(json, pos, pos2)
		end
		if jsonlen ~= 0 then
			pos = pos2+1
		end
		return str
	end

	local function tellpos()
		return acc + pos
	end

	return {
		run = run,
		tryc = tryc,
		read = read,
		tellpos = tellpos,
	}
end

return {
	newparser = newparser
}

end)
__bundle_register("ge_tts.lunajson.encoder", function(require, _LOADED, __bundle_register, __bundle_modules)
local error = error
local byte, find, format, gsub, match = string.byte, string.find, string.format,  string.gsub, string.match
local concat = table.concat
local tostring = tostring
local rawget, pairs, type = rawget, pairs, type
local setmetatable = setmetatable
local huge, tiny = 1/0, -1/0

local f_string_esc_pat = '[^ -!#-[%]^-\255]'
local _ENV = nil


local function newencoder()
	local v, nullv
	local i, builder, visited

	local function f_tostring(v)
		builder[i] = tostring(v)
		i = i+1
	end

	local radixmark = match(tostring(0.5), '[^0-9]')
	local delimmark = match(tostring(12345.12345), '[^0-9' .. radixmark .. ']')
	if radixmark == '.' then
		radixmark = nil
	end

	local radixordelim
	if radixmark or delimmark then
		radixordelim = true
		if radixmark and find(radixmark, '%W') then
			radixmark = '%' .. radixmark
		end
		if delimmark and find(delimmark, '%W') then
			delimmark = '%' .. delimmark
		end
	end

	local f_number = function(n)
		if tiny < n and n < huge then
			local s = format("%.17g", n)
			if radixordelim then
				if delimmark then
					s = gsub(s, delimmark, '')
				end
				if radixmark then
					s = gsub(s, radixmark, '.')
				end
			end
			builder[i] = s
			i = i+1
			return
		end
		error('invalid number')
	end

	local doencode

	local f_string_subst = {
		['"'] = '\\"',
		['\\'] = '\\\\',
		['\b'] = '\\b',
		['\f'] = '\\f',
		['\n'] = '\\n',
		['\r'] = '\\r',
		['\t'] = '\\t',
		__index = function(_, c)
			return format('\\u00%02X', byte(c))
		end
	}
	setmetatable(f_string_subst, f_string_subst)

	local function f_string(s)
		builder[i] = '"'
		if find(s, f_string_esc_pat) then
			s = gsub(s, f_string_esc_pat, f_string_subst)
		end
		builder[i+1] = s
		builder[i+2] = '"'
		i = i+3
	end

	local function f_table(o)
		if visited[o] then
			error("loop detected")
		end
		visited[o] = true

		local tmp = o[0]
		if type(tmp) == 'number' then -- arraylen available
			builder[i] = '['
			i = i+1
			for j = 1, tmp do
				doencode(o[j])
				builder[i] = ','
				i = i+1
			end
			if tmp > 0 then
				i = i-1
			end
			builder[i] = ']'

		else
			tmp = rawget(o, 1)
			if tmp ~= nil then -- detected as array
				builder[i] = '['
				i = i+1
				local j = 2
				repeat
					doencode(tmp)
					tmp = o[j]
					if tmp == nil then
						break
					end
					j = j+1
					builder[i] = ','
					i = i+1
				until false
				builder[i] = ']'

			else -- detected as object
				builder[i] = '{'
				i = i+1
				local tmp = i
				for k, v in pairs(o) do
					if type(k) ~= 'string' then
						error('non-string key: ' .. tostring(k) .. ' (' .. type(k) .. ')')
					end
					f_string(k)
					builder[i] = ':'
					i = i+1
					doencode(v)
					builder[i] = ','
					i = i+1
				end
				if i > tmp then
					i = i-1
				end
				builder[i] = '}'
			end
		end

		i = i+1
		visited[o] = nil
	end

	local dispatcher = {
		boolean = f_tostring,
		number = f_number,
		string = f_string,
		table = f_table,
		__index = function()
			error("invalid type value")
		end
	}
	setmetatable(dispatcher, dispatcher)

	function doencode(v)
		if v == nullv then
			builder[i] = 'null'
			i = i+1
			return
		end
		return dispatcher[type(v)](v)
	end

	local function encode(v_, nullv_)
		v, nullv = v_, nullv_
		i, builder, visited = 1, {}, {}

		doencode(v)
		return concat(builder)
	end

	return encode
end

return newencoder

end)
__bundle_register("ge_tts.lunajson.decoder", function(require, _LOADED, __bundle_register, __bundle_modules)
local setmetatable, tonumber, tostring =
      setmetatable, tonumber, tostring
local floor, inf =
      math.floor, math.huge
local mininteger, tointeger =
      math.mininteger or nil, math.tointeger or nil
local byte, char, find, gsub, match, sub =
      string.byte, string.char, string.find, string.gsub, string.match, string.sub

local function _decode_error(pos, errmsg)
	error("parse error at " .. pos .. ": " .. errmsg, 2)
end

local f_str_ctrl_pat = '[^\32-\255]'
local _ENV = nil


local function newdecoder()
	local json, pos, nullv, arraylen, rec_depth

	-- `f` is the temporary for dispatcher[c] and
	-- the dummy for the first return value of `find`
	local dispatcher, f

	--[[
		Helper
	--]]
	local function decode_error(errmsg)
		return _decode_error(pos, errmsg)
	end

	--[[
		Invalid
	--]]
	local function f_err()
		decode_error('invalid value')
	end

	--[[
		Constants
	--]]
	-- null
	local function f_nul()
		if sub(json, pos, pos+2) == 'ull' then
			pos = pos+3
			return nullv
		end
		decode_error('invalid value')
	end

	-- false
	local function f_fls()
		if sub(json, pos, pos+3) == 'alse' then
			pos = pos+4
			return false
		end
		decode_error('invalid value')
	end

	-- true
	local function f_tru()
		if sub(json, pos, pos+2) == 'rue' then
			pos = pos+3
			return true
		end
		decode_error('invalid value')
	end

	--[[
		Numbers
		Conceptually, the longest prefix that matches to `[-+.0-9A-Za-z]+` (in regexp)
		is captured as a number and its conformance to the JSON spec is checked.
	--]]
	-- deal with non-standard locales
	local radixmark = match(tostring(0.5), '[^0-9]')
	local fixedtonumber = tonumber
	if radixmark ~= '.' then
		if find(radixmark, '%W') then
			radixmark = '%' .. radixmark
		end
		fixedtonumber = function(s)
			return tonumber(gsub(s, '.', radixmark))
		end
	end

	local function number_error()
		return decode_error('invalid number')
	end

	-- `0(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_zro(mns)
		local num, c = match(json, '^(%.?[0-9]*)([-+.A-Za-z]?)', pos)  -- skipping 0

		if num == '' then
			if c == '' then
				if mns then
					return -0.0
				end
				return 0
			end

			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
				if c == '' then
					pos = pos + #num
					if mns then
						return -0.0
					end
					return 0.0
				end
			end
			number_error()
		end

		if byte(num) ~= 0x2E or byte(num, -1) == 0x2E then
			number_error()
		end

		if c ~= '' then
			if c == 'e' or c == 'E' then
				num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			end
			if c ~= '' then
				number_error()
			end
		end

		pos = pos + #num
		c = fixedtonumber(num)

		if mns then
			c = -c
		end
		return c
	end

	-- `[1-9][0-9]*(\.[0-9]*)?([eE][+-]?[0-9]*)?`
	local function f_num(mns)
		pos = pos-1
		local num, c = match(json, '^([0-9]+%.?[0-9]*)([-+.A-Za-z]?)', pos)
		if byte(num, -1) == 0x2E then  -- error if ended with period
			number_error()
		end

		if c ~= '' then
			if c ~= 'e' and c ~= 'E' then
				number_error()
			end
			num, c = match(json, '^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)', pos)
			if not num or c ~= '' then
				number_error()
			end
		end

		pos = pos + #num
		c = fixedtonumber(num)

		if mns then
			c = -c
			if c == mininteger and not find(num, '[^0-9]') then
				c = mininteger
			end
		end
		return c
	end

	-- skip minus sign
	local function f_mns()
		local c = byte(json, pos)
		if c then
			pos = pos+1
			if c > 0x30 then
				if c < 0x3A then
					return f_num(true)
				end
			else
				if c > 0x2F then
					return f_zro(true)
				end
			end
		end
		decode_error('invalid number')
	end

	--[[
		Strings
	--]]
	local f_str_hextbl = {
		0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
		0x8, 0x9, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, inf, inf, inf, inf, inf, inf, inf,
		inf, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
		__index = function()
			return inf
		end
	}
	setmetatable(f_str_hextbl, f_str_hextbl)

	local f_str_escapetbl = {
		['"']  = '"',
		['\\'] = '\\',
		['/']  = '/',
		['b']  = '\b',
		['f']  = '\f',
		['n']  = '\n',
		['r']  = '\r',
		['t']  = '\t',
		__index = function()
			decode_error("invalid escape sequence")
		end
	}
	setmetatable(f_str_escapetbl, f_str_escapetbl)

	local function surrogate_first_error()
		return decode_error("1st surrogate pair byte not continued by 2nd")
	end

	local f_str_surrogate_prev = 0
	local function f_str_subst(ch, ucode)
		if ch == 'u' then
			local c1, c2, c3, c4, rest = byte(ucode, 1, 5)
			ucode = f_str_hextbl[c1-47] * 0x1000 +
			        f_str_hextbl[c2-47] * 0x100 +
			        f_str_hextbl[c3-47] * 0x10 +
			        f_str_hextbl[c4-47]
			if ucode ~= inf then
				if ucode < 0x80 then  -- 1byte
					if rest then
						return char(ucode, rest)
					end
					return char(ucode)
				elseif ucode < 0x800 then  -- 2bytes
					c1 = floor(ucode / 0x40)
					c2 = ucode - c1 * 0x40
					c1 = c1 + 0xC0
					c2 = c2 + 0x80
					if rest then
						return char(c1, c2, rest)
					end
					return char(c1, c2)
				elseif ucode < 0xD800 or 0xE000 <= ucode then  -- 3bytes
					c1 = floor(ucode / 0x1000)
					ucode = ucode - c1 * 0x1000
					c2 = floor(ucode / 0x40)
					c3 = ucode - c2 * 0x40
					c1 = c1 + 0xE0
					c2 = c2 + 0x80
					c3 = c3 + 0x80
					if rest then
						return char(c1, c2, c3, rest)
					end
					return char(c1, c2, c3)
				elseif 0xD800 <= ucode and ucode < 0xDC00 then  -- surrogate pair 1st
					if f_str_surrogate_prev == 0 then
						f_str_surrogate_prev = ucode
						if not rest then
							return ''
						end
						surrogate_first_error()
					end
					f_str_surrogate_prev = 0
					surrogate_first_error()
				else  -- surrogate pair 2nd
					if f_str_surrogate_prev ~= 0 then
						ucode = 0x10000 +
						        (f_str_surrogate_prev - 0xD800) * 0x400 +
						        (ucode - 0xDC00)
						f_str_surrogate_prev = 0
						c1 = floor(ucode / 0x40000)
						ucode = ucode - c1 * 0x40000
						c2 = floor(ucode / 0x1000)
						ucode = ucode - c2 * 0x1000
						c3 = floor(ucode / 0x40)
						c4 = ucode - c3 * 0x40
						c1 = c1 + 0xF0
						c2 = c2 + 0x80
						c3 = c3 + 0x80
						c4 = c4 + 0x80
						if rest then
							return char(c1, c2, c3, c4, rest)
						end
						return char(c1, c2, c3, c4)
					end
					decode_error("2nd surrogate pair byte appeared without 1st")
				end
			end
			decode_error("invalid unicode codepoint literal")
		end
		if f_str_surrogate_prev ~= 0 then
			f_str_surrogate_prev = 0
			surrogate_first_error()
		end
		return f_str_escapetbl[ch] .. ucode
	end

	-- caching interpreted keys for speed
	local f_str_keycache = setmetatable({}, {__mode="v"})

	local function f_str(iskey)
		local newpos = pos
		local tmppos, c1, c2
		repeat
			newpos = find(json, '"', newpos, true)  -- search '"'
			if not newpos then
				decode_error("unterminated string")
			end
			tmppos = newpos-1
			newpos = newpos+1
			c1, c2 = byte(json, tmppos-1, tmppos)
			if c2 == 0x5C and c1 == 0x5C then  -- skip preceding '\\'s
				repeat
					tmppos = tmppos-2
					c1, c2 = byte(json, tmppos-1, tmppos)
				until c2 ~= 0x5C or c1 ~= 0x5C
				tmppos = newpos-2
			end
		until c2 ~= 0x5C  -- leave if '"' is not preceded by '\'

		local str = sub(json, pos, tmppos)
		pos = newpos

		if iskey then  -- check key cache
			tmppos = f_str_keycache[str]  -- reuse tmppos for cache key/val
			if tmppos then
				return tmppos
			end
			tmppos = str
		end

		if find(str, f_str_ctrl_pat) then
			decode_error("unescaped control string")
		end
		if find(str, '\\', 1, true) then  -- check whether a backslash exists
			-- We need to grab 4 characters after the escape char,
			-- for encoding unicode codepoint to UTF-8.
			-- As we need to ensure that every first surrogate pair byte is
			-- immediately followed by second one, we grab upto 5 characters and
			-- check the last for this purpose.
			str = gsub(str, '\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)', f_str_subst)
			if f_str_surrogate_prev ~= 0 then
				f_str_surrogate_prev = 0
				decode_error("1st surrogate pair byte not continued by 2nd")
			end
		end
		if iskey then  -- commit key cache
			f_str_keycache[tmppos] = str
		end
		return str
	end

	--[[
		Arrays, Objects
	--]]
	-- array
	local function f_ary()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			decode_error('too deeply nested json (> 1000)')
		end
		local ary = {}

		pos = match(json, '^[ \n\r\t]*()', pos)

		local i = 0
		if byte(json, pos) == 0x5D then  -- check closing bracket ']' which means the array empty
			pos = pos+1
		else
			local newpos = pos
			repeat
				i = i+1
				f = dispatcher[byte(json,newpos)]  -- parse value
				pos = newpos+1
				ary[i] = f()
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)  -- check comma
			until not newpos

			newpos = match(json, '^[ \n\r\t]*%]()', pos)  -- check closing bracket
			if not newpos then
				decode_error("no closing bracket of an array")
			end
			pos = newpos
		end

		if arraylen then -- commit the length of the array if `arraylen` is set
			ary[0] = i
		end
		rec_depth = rec_depth - 1
		return ary
	end

	-- objects
	local function f_obj()
		rec_depth = rec_depth + 1
		if rec_depth > 1000 then
			decode_error('too deeply nested json (> 1000)')
		end
		local obj = {}

		pos = match(json, '^[ \n\r\t]*()', pos)
		if byte(json, pos) == 0x7D then  -- check closing bracket '}' which means the object empty
			pos = pos+1
		else
			local newpos = pos

			repeat
				if byte(json, newpos) ~= 0x22 then  -- check '"'
					decode_error("not key")
				end
				pos = newpos+1
				local key = f_str(true)  -- parse key

				-- optimized for compact json
				-- c1, c2 == ':', <the first char of the value> or
				-- c1, c2, c3 == ':', ' ', <the first char of the value>
				f = f_err
				local c1, c2, c3 = byte(json, pos, pos+3)
				if c1 == 0x3A then
					if c2 ~= 0x20 then
						f = dispatcher[c2]
						newpos = pos+2
					else
						f = dispatcher[c3]
						newpos = pos+3
					end
				end
				if f == f_err then  -- read a colon and arbitrary number of spaces
					newpos = match(json, '^[ \n\r\t]*:[ \n\r\t]*()', pos)
					if not newpos then
						decode_error("no colon after a key")
					end
					f = dispatcher[byte(json, newpos)]
					newpos = newpos+1
				end
				pos = newpos
				obj[key] = f()  -- parse value
				newpos = match(json, '^[ \n\r\t]*,[ \n\r\t]*()', pos)
			until not newpos

			newpos = match(json, '^[ \n\r\t]*}()', pos)
			if not newpos then
				decode_error("no closing bracket of an object")
			end
			pos = newpos
		end

		rec_depth = rec_depth - 1
		return obj
	end

	--[[
		The jump table to dispatch a parser for a value,
		indexed by the code of the value's first char.
		Nil key means the end of json.
	--]]
	dispatcher = { [0] =
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_str, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_mns, f_err, f_err,
		f_zro, f_num, f_num, f_num, f_num, f_num, f_num, f_num,
		f_num, f_num, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_ary, f_err, f_err, f_err, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_fls, f_err,
		f_err, f_err, f_err, f_err, f_err, f_err, f_nul, f_err,
		f_err, f_err, f_err, f_err, f_tru, f_err, f_err, f_err,
		f_err, f_err, f_err, f_obj, f_err, f_err, f_err, f_err,
		__index = function()
			decode_error("unexpected termination")
		end
	}
	setmetatable(dispatcher, dispatcher)

	--[[
		run decoder
	--]]
	local function decode(json_, pos_, nullv_, arraylen_)
		json, pos, nullv, arraylen = json_, pos_, nullv_, arraylen_
		rec_depth = 0

		pos = match(json, '^[ \n\r\t]*()', pos)

		f = dispatcher[byte(json, pos)]
		pos = pos+1
		local v = f()

		if pos_ then
			return v, pos
		else
			f, pos = find(json, '^[ \n\r\t]*', pos)
			if pos ~= #json then
				decode_error('json ended')
			end
			return v
		end
	end

	return decode
end

return newdecoder

end)
__bundle_register("ge_tts.Coroutine", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class ge_tts__Coroutine
local Coroutine = {}

---@param co thread
---@param onError nil | fun(message: string): void
local function resumeWithErrorHandling(co, onError)
    local result, message = coroutine.resume(co)

    if not result then
        if onError then
            (--[[---@not nil]] onError)(message)
        else
            error(message)
        end
    end
end

--- Yields from the current coroutine. Resumes once a condition is met or an optional timeout is reached.
---@overload fun(condition: fun(): boolean): true
---@overload fun(condition: (fun(): boolean), timeout: number): boolean
---@param condition fun(): boolean @Return true when the current coroutine should be resumed.
---@param timeout nil | number @Timeout in seconds (optional).
---@param onError nil | fun(message: string): void @A handler for any errors raised by the current coroutine after it has been resumed.
---@return boolean @True if the condition was met, or false if the (optional) timeout was reached.
function Coroutine.yieldCondition(condition, timeout, onError)
    local co = coroutine.running()

    ---@type nil | boolean
    local conditionMet

    local resume = function()
        conditionMet = true
        resumeWithErrorHandling(co, onError)
    end

    if timeout then
        Wait.condition(resume, condition, --[[---@not nil]] timeout, function()
            conditionMet = false
            resumeWithErrorHandling(co, onError)
        end)
    else
        Wait.condition(resume, condition)
    end

    coroutine.yield()

    if conditionMet == nil then
        error("Coroutine.yieldCondition(): attempt to resume before Wait was completed!")
    end

    return --[[---@not nil]] conditionMet
end

--- Yields from the current coroutine, which will later be resumed after the specified number of frames have passed.
---@overload fun(frames: number): void
---@param frames number
---@param onError nil | fun(message: string): void @A handler for any errors raised by the current coroutine after it has been resumed.
function Coroutine.yieldFrames(frames, onError)
    local co = coroutine.running()

    ---@type boolean
    local done

    Wait.frames(function()
        done = true
        resumeWithErrorHandling(co, onError)
    end, frames)

    coroutine.yield()

    if not done then
        error("Coroutine.yieldFrames(): attempt to resume before Wait was completed!")
    end
end

--- Yields from the current coroutine, which will later be resumed after the specified number of seconds have passed.
---@overload fun(seconds: number): void
---@param seconds number
---@param onError nil | fun(message: string): void @A handler for any errors raised by the current coroutine after it has been resumed.
function Coroutine.yieldSeconds(seconds, onError)
    local co = coroutine.running()

    ---@type boolean
    local done

    Wait.time(function()
        done = true
        resumeWithErrorHandling(co, onError)
    end, seconds)

    coroutine.yield()

    if not done then
        error("Coroutine.yieldSeconds(): attempt to resume before Wait was completed!")
    end
end

--- Creates a co-routine from the specified function, and immediately starts it.
---@param func fun
---@return boolean, any...
function Coroutine.start(func)
    return coroutine.resume(coroutine.create(func))
end

return Coroutine

end)
__bundle_register("ge_tts.GlobalPatches", function(require, _LOADED, __bundle_register, __bundle_modules)
-- From time to time there are bugs in TTS' APIs that we're able to fix/patch in a non-intrusive fashion.

-- Lua Color indexing fix, see: https://github.com/Berserk-Games/Tabletop-Simulator-Lua-Classes/pull/1

---@type {__index: fun(c: any, k: any): any}
local colorMetatable = getmetatable(Color)
local originalColorIndex = colorMetatable.__index

colorMetatable.__index = function(c, k)
    if type(k) ~= 'string' then
        return nil
    end

    return originalColorIndex(c, k)
end

end)
__bundle_register("ge_tts.Json", function(require, _LOADED, __bundle_register, __bundle_modules)
-- JSON encoding of Color presently fails due to a bug in Color. Fortunately, we can patch Color to fix it.
require("ge_tts.GlobalPatches")

local Coroutine = require("ge_tts.Coroutine")
local TableUtils = require("ge_tts.TableUtils")

local LunaJsonDecoder = require("ge_tts.lunajson.decoder")
local LunaJsonEncoder = require("ge_tts.lunajson.encoder")
local LunaJsonSax = require("ge_tts.lunajson.sax")

---@class ge_tts__JsonNull
local NULL = setmetatable({}, {
    __index = {},
    __newindex = function() error("Attempt to modify JSON.null()") end,
    __metatable = false
})

---@class ge_tts__Json
local Json = {}

---@return ge_tts__JsonNull
function Json.null()
    return NULL
end

---@alias ge_tts__JsonObject table<string, ge_tts__JsonValue>
---@alias ge_tts__JsonArray ge_tts__JsonValue[]
---@alias ge_tts__JsonContainer ge_tts__JsonObject | ge_tts__JsonArray
---@alias ge_tts__JsonValue ge_tts__JsonContainer | number | string | boolean | nil | ge_tts__JsonNull

---@alias __ge_tts__JsonNodeTypeObject 0
---@alias __ge_tts__JsonNodeTypeArray 1
---@alias __ge_tts__JsonNodeTypeKey 2

---@type __ge_tts__JsonNodeTypeObject
local NODE_OBJECT = 0

---@type __ge_tts__JsonNodeTypeArray
local NODE_ARRAY = 1

---@type __ge_tts__JsonNodeTypeKey
local NODE_KEY = 2

---@alias __ge_tts__JsonNodeType __ge_tts__JsonNodeTypeObject | __ge_tts__JsonNodeTypeArray | __ge_tts__JsonNodeTypeKey

---@alias __ge_tts__JsonObjectNode {[1]: __ge_tts__JsonNodeTypeObject, [2]: ge_tts__JsonObject}
---@alias __ge_tts__JsonArrayNode {[1]: __ge_tts__JsonNodeTypeArray, [2]: ge_tts__JsonArray, [3]: number}
---@alias __ge_tts__JsonKeyNode {[1]: __ge_tts__JsonNodeTypeKey, [2]: string }


---@alias __ge_tts__JsonNode __ge_tts__JsonObjectNode | __ge_tts__JsonArrayNode | __ge_tts__JsonKeyNode

---@shape ge_tts__Json_DecodeOptions
---@field encodeArrayLength nil | boolean @Default false. When true, array lengths are encoded as the zeroth element. Thus an empty array can be discerned from an empty table.
---@field nullIdentification nil | boolean @Default true. When true, null values in an array/object are represented by JSON.null() rather than being omitted.

---@shape ge_tts__Json_DecodeAsyncOptions : ge_tts__Json_DecodeOptions
---@field onCompletion fun(data: ge_tts__JsonValue): void
---@field onError fun(message: string): void
---@field charactersPerChunk nil | number @Default 2048 (2 KiB)
---@field framesBetweenChunks nil | number @Default 1

---@type ge_tts__Json_DecodeOptions
local defaultDecodeOptions = {
    encodeArrayLength = false,
    nullIdentification = true,
}

--- Sets the default decoding options used by decode and decodeAsync when called with options omitted.
---@param decodeOptions ge_tts__Json_DecodeOptions
function Json.setDefaultDecodeOptions(decodeOptions)
    defaultDecodeOptions = decodeOptions
end

--- Parses JSON in a pseudo-async fashion using co-operative multi-tasking (i.e. coroutines).
---
--- The parser will only do a limited amount of work each frame before handing off processing back to TTS, thus we
--- don't freeze the game when parsing large JSON.
---
--- Return value is a function that can be called to cancel decoding if it is yet to complete.
---@param json string
---@param options ge_tts__Json_DecodeAsyncOptions
---@return fun(): void
function Json.decodeAsync(json, options)
    local cancelled = false

    options = TableUtils.merge(--[[---@type ge_tts__Json_DecodeAsyncOptions]] defaultDecodeOptions, options)

    Coroutine.start(function()
        ---@type __ge_tts__JsonNode[]
        local stack = {}

        ---@type nil | __ge_tts__JsonNode
        local currentNode

        ---@type ge_tts__JsonValue
        local result

        ---@param value ge_tts__JsonValue
        local function addValue(value)
            if currentNode then
                local nodeType = (--[[---@not nil]] currentNode)[1]

                if value == nil and options.nullIdentification then
                    value = Json.null()
                end

                if nodeType == NODE_KEY then
                    local key = (--[[---@type __ge_tts__JsonKeyNode]] currentNode)[2]

                    local parentNode = --[[---@type __ge_tts__JsonObjectNode]] table.remove(stack)
                    local parentObject = parentNode[2]
                    parentObject[key] = value

                    currentNode = parentNode
                elseif nodeType == NODE_ARRAY then
                    local arrayNode = --[[---@type __ge_tts__JsonArrayNode]] currentNode

                    local array = arrayNode[2]
                    arrayNode[3] = arrayNode[3] + 1 -- Update length
                    array[arrayNode[3]] = value
                end
            else
                result = value
            end
        end

        local handler = {
            startobject = function()
                if currentNode then
                    table.insert(stack, --[[---@not nil]] currentNode)
                end

                currentNode = {NODE_OBJECT , {}}
            end,
            ---@param key string
            key = function(key)
                table.insert(stack, --[[---@not nil]] currentNode)
                currentNode = {NODE_KEY, key}
            end,
            endobject = function()
                local objectNode = (--[[---@type __ge_tts__JsonObjectNode]] currentNode)
                currentNode = table.remove(stack)
                addValue(objectNode[2])
            end,
            startarray = function()
                if currentNode then
                    table.insert(stack, --[[---@not nil]] currentNode)
                end

                currentNode = {NODE_ARRAY , {}, 0}
            end,
            endarray = function()
                local objectNode = (--[[---@type __ge_tts__JsonArrayNode]] currentNode)
                local array = objectNode[2]
                currentNode = table.remove(stack)

                if options.encodeArrayLength then
                    array[0] = objectNode[3]
                end

                addValue(array)
            end,
            string = addValue,
            number = addValue,
            boolean = addValue,
            null = function()
                addValue(nil)
            end,
        }

        ---@type number
        local charactersPerChunk = 0

        if options.charactersPerChunk then
            charactersPerChunk = --[[---@not nil]] options.charactersPerChunk
        end

        if charactersPerChunk <= 0 then
            charactersPerChunk = 2048
        end

        ---@type number
        local framesBetweenChunks

        if options.framesBetweenChunks and framesBetweenChunks > 0 then
            framesBetweenChunks = --[[---@not nil]] options.framesBetweenChunks
        else
            framesBetweenChunks = 1
        end

        local offset = 1
        local length = #json

        local function feed()
            local characterCount = math.min(length - offset + 1, charactersPerChunk)

            if characterCount == 0 or cancelled then
                return nil
            end

            Coroutine.yieldFrames(framesBetweenChunks, function(message)
                if not cancelled then
                    options.onError(message)
                end
            end)

            local nextOffset = offset + characterCount
            local substring = json:sub(offset, nextOffset - 1)
            offset = nextOffset
            return substring
        end

        local parser = --[[---@type {run: fun(): void}]] LunaJsonSax.newparser(feed, handler)
        parser.run()

        if not cancelled then
            options.onCompletion(result)
        end
    end)

    return function()
        cancelled = true
    end
end

local decode = LunaJsonDecoder()

---@overload fun(json: string): ge_tts__JsonValue
---@param json string
---@param options nil | ge_tts__Json_DecodeOptions
---@return ge_tts__JsonValue
function Json.decode(json, options)
    local decodeOptions = TableUtils.merge(defaultDecodeOptions, --[[---@not nil]] options or {})
    local nullValue = decodeOptions.nullIdentification and Json.null() or nil
    return decode(json, 0, nullValue, decodeOptions.encodeArrayLength or false)
end

local encode = LunaJsonEncoder()

---@param json ge_tts__JsonValue
---@return string
function Json.encode(value)
    return encode(value, Json.null())
end

--- Fills gaps (up to the specified length) in sparseArray with Json.null(), then returns it.
---@generic T
---@generic N : number
---@param sparseArray table<N, nil | T>
---@param length number
---@return (T | ge_tts__JsonNull)[]
function Json.nullFillSparseArray(sparseArray, length)
    for i = 1, length do
        if type((--[[---@type T[] ]] sparseArray)[i]) == 'nil' then
            (--[[---@type (T | ge_tts__JsonNull)[] ]] sparseArray)[i] = Json.null()
        end
    end

    return --[[---@type (T | ge_tts__JsonNull)[] ]] sparseArray
end

return Json

end)
__bundle_register("ge_tts.Logger", function(require, _LOADED, __bundle_register, __bundle_modules)
---@class ge_tts__Logger

---@class ge_tts__static_Logger
---@overload fun(): ge_tts__Logger
local Logger = {}

Logger.ERROR = 1
Logger.WARNING = 2
Logger.INFO = 3
Logger.DEBUG = 4
Logger.VERBOSE = 5

---@alias ge_tts__Logger_LogLevel 1 | 2 | 3 | 4 | 5

---@type table<ge_tts__Logger_LogLevel, string>
local levelPrefixes = {
    [Logger.ERROR] = 'ERROR: ',
    [Logger.WARNING] = 'WARNING: ',
    [Logger.INFO] = '',
    [Logger.DEBUG] = '',
    [Logger.VERBOSE] = '',
}

---@type ge_tts__Logger_LogLevel
local defaultLogLevel = Logger.DEBUG

setmetatable(Logger, {
    __call = function()
        local self = --[[---@type ge_tts__Logger]] {}

        ---@type ge_tts__Logger_LogLevel
        local filterLevel = Logger.INFO

        ---@return ge_tts__Logger_LogLevel
        function self.getFilterLevel()
            return filterLevel
        end

        ---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
        function self.setFilterLevel(level)
            filterLevel = level
        end

        ---@param message string
        ---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
        function self.log(message, level)
            level = level or defaultLogLevel
            if level <= filterLevel then
                print(levelPrefixes[level] .. message)
            end
        end

        ---
        ---If value is false, logs message at level Logger.ERROR and then calls Lua's in-built error(message).
        ---
        ---@param value any
        ---@param message string
        function self.assert(value, message)
            if not value then
                self.log(message, Logger.ERROR)
                error(message, 2)
            end
        end

        return self
    end
})

local defaultLogger = Logger()

---@param logger ge_tts__Logger
function Logger.setDefaultLogger(logger)
    defaultLogger = logger
end

function Logger.getDefaultLogger()
    return defaultLogger
end

---
---When calling log() without specifying a log level, messages will log at the provided log level.
---
---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
function Logger.setDefaultLogLevel(level)
    defaultLogLevel = level
end

---
---Returns the default log level.
---
---@return ge_tts__Logger_LogLevel
function Logger.getDefaultLogLevel()
    return defaultLogLevel
end

---
---Logs a message at the specified log level. If level is omitted, the default log level will be used.
---
---@overload fun(message: string): void
---@param message string
---@param level ge_tts__Logger_LogLevel | `Logger.ERROR` | `Logger.WARNING` | `Logger.INFO` | `Logger.DEBUG` | `Logger.VERBOSE`
function Logger.log(message, level)
    level = level or defaultLogLevel
    defaultLogger.log(message, level)
end

---
---If value is false, logs message at level Logger.ERROR using the default logger, and then calls Lua's error(message).
---
---@param value any
---@param message string
function Logger.assert(value, message)
    if not value then
        defaultLogger.log(message, Logger.ERROR)
        error(message, 2)
    end
end

return Logger

end)
__bundle_register("ge_tts.Base64", function(require, _LOADED, __bundle_register, __bundle_modules)
-- Base64 implementation originally based on https://github.com/iskolbin/lbase64 (public domain),
-- but modified for simplicity, TTS and to work with number[] buffers, rather than strings.

local TableUtils = require("ge_tts.TableUtils")

---@class ge_tts__Base64
local Base64 = {}

local extract = bit32.extract

local PAD_KEY = 64

---@overload fun(char62: string, char63: string): table<number, number>
---@overload fun(char62: string): table<number, number>
---@overload fun(): table<number, number>
---@param char62 string
---@param char63 string
---@param charPad string
---@return table<number, number>
function Base64.encodingMap(char62, char63, charPad)
    ---@type table<number, number>
    local encodingTable = {}

    for b64code, char in pairs({
        [0] = 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
        'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
        'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2',
        '3', '4', '5', '6', '7', '8', '9', char62 or '+', char63 or '/', charPad or '='
    }) do
        encodingTable[b64code] = char:byte()
    end

    return encodingTable
end

---@overload fun(char62: string, char63: string): table<number, number>
---@overload fun(char62: string): table<number, number>
---@overload fun(): table<number, number>
---@param char62 string
---@param char63 string
---@param charPad string
---@return table<number, number>
function Base64.decodingMap(char62, char63, charPad)
    return TableUtils.invert(Base64.encodingMap(char62, char63, charPad))
end

local DEFAULT_ENCODING_MAP = Base64.encodingMap()
local DEFAULT_DECODING_MAP = Base64.decodingMap()

---@overload fun(buffer: number[], pad: boolean): string
---@overload fun(buffer: number[]): string
---@param buffer number[]
---@param pad boolean
---@param map table<number, number>
---@return string
function Base64.encode(buffer, pad, map)
    pad = pad == nil or pad
    map = map or DEFAULT_ENCODING_MAP

    ---@type string[]
    local components = {}
    local index = 1
    local length = #buffer
    local lastComponentSize = length % 3

    for offset = 1, length - lastComponentSize, 3 do
        local a, b, c = --[[---@not nil, nil, nil]] table.unpack(buffer, offset, offset + 2)
        local v = a * 0x10000 + b * 0x100 + c

        components[index] = string.char(map[extract(v, 18, 6)], map[extract(v, 12, 6)], map[extract(v, 6, 6)], map[extract(v, 0, 6)])
        index = index + 1
    end

    if lastComponentSize == 2 then
        local a, b = --[[---@not nil, nil]] table.unpack(buffer, length - 1, length)
        local v = a * 0x10000 + b * 0x100

        components[index] = string.char(map[extract(v, 18, 6)], map[extract(v, 12, 6)], map[extract(v, 6, 6)]) .. (pad and string.char(map[PAD_KEY]) or '')
    elseif lastComponentSize == 1 then
        local v = buffer[length] * 0x10000

        components[index] = string.char(map[extract(v, 18, 6)], map[extract(v, 12, 6)]) .. (pad and string.char(map[PAD_KEY], map[PAD_KEY]) or '')
    end

    return table.concat(components)
end

---@overload fun(b64: string): number[]
---@param b64 string
---@param map table<number, number>
---@return number[]
function Base64.decode(b64, map)
    map = map or DEFAULT_DECODING_MAP

    ---@type number[]
    local buffer = {}
    local offset = 1

    local length = #b64

    if map[--[[---@not nil]] b64:sub(-2, -2):byte()] == PAD_KEY then
        length = length - 2
    elseif map[--[[---@not nil]] b64:sub(-1, -1):byte()] == PAD_KEY then
        length = length - 1
    end

    local lastBlockSize = length % 4
    local fullBlockEnd = length - lastBlockSize

    for i = 1, fullBlockEnd, 4 do
        local a, b, c, d = --[[---@not nil, nil, nil, nil]] b64:byte(i, i + 3)

        local v = map[a] * 0x40000 + map[b] * 0x1000 + map[c] * 0x40 + map[d]

        buffer[offset] = extract(v, 16, 8)
        buffer[offset + 1] = extract(v, 8, 8)
        buffer[offset + 2] = extract(v, 0, 8)

        offset = offset + 3
    end


    if lastBlockSize == 3 then
        local a, b, c = --[[---@not nil, nil, nil]] b64:byte(fullBlockEnd + 1, fullBlockEnd + 3)
        local v = map[a] * 0x40000 + map[b] * 0x1000 + map[c] * 0x40

        buffer[offset] = extract(v, 16, 8)
        buffer[offset + 1] = extract(v, 8, 8)
    elseif lastBlockSize == 2 then
        local a, b = --[[---@not nil, nil]] b64:byte(fullBlockEnd + 1, fullBlockEnd + 2)
        local v = map[a] * 0x40000 + map[b] * 0x1000

        buffer[offset] = extract(v, 16, 8)
    end

    return buffer
end

return Base64

end)
__bundle_register("ge_tts/Http", function(require, _LOADED, __bundle_register, __bundle_modules)
local Base64 = require("ge_tts.Base64")
local Logger = require("ge_tts.Logger")
local Json = require("ge_tts.Json")
local TableUtils = require("ge_tts.TableUtils")

---@shape ge_tts__Http_Response
---@field statusCode number
---@field headers table<string, string>
---@field body string | number[] | table

---@alias ge_tts__Http_Callback fun(response: nil | ge_tts__Http_Response, error: nil | string): void
---
---@type nil | string
local proxyUrl

---@type nil | string
local decodeJsonContentType = 'application/json'

---@class ge_tts__Http
local Http = {}

---@param url string
function Http.setProxyUrl(url)
    proxyUrl = url
end

---@return nil | string
function Http.getProxyUrl()
    return proxyUrl
end

---@param type nil | string
function Http.setDecodeJsonContentType(type)
    decodeJsonContentType = type
end

---@return nil | string
function Http.getDecodeJsonContentType()
    return decodeJsonContentType
end

---@param headers table<string, string>
---@param name string
---@return nil | string, nil | string @value, headerName - `headerName` being the case-sensitive variant of `name` found within headers
function Http.getHeader(headers, name)
    name = name:lower()

    return TableUtils.detect(headers, function(_, key)
        return key:lower() == name
    end)
end

---@param method string
---@param url string
---@param options table<string, any>
---@param callback ge_tts__Http_Callback
function Http.request(method, url, options, callback)
    Logger.assert(proxyUrl, 'Http must be configured with Http.setProxyUrl(\'YOUR_TTS_PROXY_URL\'). Please refer to https://gitlab.com/BenjaminDobell/tts-proxy for details.')

    content = Json.encode(TableUtils.merge(
        {
            headers={},
        },
        options,
        {
            method=method:upper(),
            url=url,
        }
    ))

    WebRequest.put(--[[---@not nil]] proxyUrl, content, function(request)
        if request.is_error then
            callback(nil, request.error)
        elseif request.is_done then
            Json.decodeAsync(request.text, {
                ---@param responseContent table
                onCompletion = function(responseContent)
                    ---@type ge_tts__Http_Response
                    local response = {
                        statusCode = responseContent.status_code,
                        headers = responseContent.headers,
                        body = responseContent.body or ""
                    }

                    if responseContent.base64 then
                        response.body = Base64.decode(response.body)
                        callback(response, nil)
                        return
                    end

                    local contentType = Http.getHeader(response.headers, 'Content-Type')

                    if contentType and (--[[---@not nil]] contentType):lower() == decodeJsonContentType then
                        Json.decodeAsync(request.text, {
                            ---@param value table
                            onCompletion = function(value)
                                response.body = value
                                callback(response, nil)
                            end,
                            onError = function(message)
                                callback(nil, "Failed to parse JSON body: " .. message)
                            end,
                        })
                        return
                    end

                    callback(response, nil)
                end,
                onError = function(message)
                    callback(nil, "Failed to parse proxy wrapper: " .. message)
                end,
            })
        end
    end)
end

---@param method string
---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headersOrNil nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.submit(method, url, body, headersOrNil, callback)
    ---@type table<string, string>
    local headers = headersOrNil or {}

    ---@type table<string, any>
    local options = {headers = headers}

    if type((--[[---@type number[] ]] body)[1]) == 'number' then
        options = TableUtils.copy(options)
        options.base64 = true
        body = Base64.encode(--[[---@type number[] ]] body)
    elseif type(body) == 'table' then
        local contentType, contentTypeHeader = Http.getHeader(headers, 'Content-Type')
        contentTypeHeader = contentTypeHeader or 'Content-Type'

        if not (contentType and (--[[---@not nil]] contentType):sub(-4) == 'json') then
            headers = TableUtils.copy(headers)
            headers[--[[---@not nil]] contentTypeHeader] = 'application/json'
        end

        body = Json.encode(body)
    end

    options.body = body

    Http.request(method, url, options, callback)
end

---@param url string
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.delete(url, headers, callback)
    Http.request('DELETE', url, {headers=headers}, callback)
end

---@param url string
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.get(url, headers, callback)
    Http.request('GET', url, {headers=headers}, callback)
end

---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.patch(url, body, headers, callback)
    Http.submit('PATCH', url, body, headers, callback)
end

---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.post(url, body, headers, callback)
    Http.submit('POST', url, body, headers, callback)
end

---@param url string
---@param body number[] | table<string, any> | string @If provided as a table, it will be JSON encoded. If provided as a number array, numbers are assumed to be [0, 255] and Base64 encoded. Otherwise, the body is a string.
---@param headers nil | table<string, string>
---@param callback ge_tts__Http_Callback
function Http.put(url, body, headers, callback)
    Http.submit('PUT', url, body, headers, callback)
end

return Http

end)
return __bundle_require("__root")