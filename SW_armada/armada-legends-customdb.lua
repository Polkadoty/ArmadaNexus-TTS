CUSTOM_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/SNCustomTTS-IncludeDir/master/SW_armada/assets/'
LEGACY_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/ArmadaLegacyTTS-IncludeDir/master/assets/'
ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'

function onload()
    printToAll("Loading Armada Legends content...",{1,0.5,0})

-- republic faction
    REPUBLIC_SHIP = {
        back = CUSTOM_ASSETS.."ships/republic/card_back.png",
        faction = "Republic"
    }

    Ship:new(LargeShip,REPUBLIC_SHIP, {
        name = "Rothana I-class Destroyer",
        front = CUSTOM_ASSETS.."ships/republic/rothana/rothana_i.png",
        mesh = CUSTOM_ASSETS.."ships/republic/rothana/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/republic/rothana/rothana_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/republic/rothana/ruler.obj", 
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
        shields = {5,4,4,3}, -- Front, left, right, rear
        cost = 125,
        command = 3,
        aliases = {"Rothana I-class Destroyer [Legends]"}
    })

    Ship:new(LargeShip,REPUBLIC_SHIP, {
        name = "Rothana II-class Destroyer",
        front = CUSTOM_ASSETS.."ships/republic/rothana/rothana_ii.png",
        mesh = CUSTOM_ASSETS.."ships/republic/rothana/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/republic/rothana/rothana_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/republic/rothana/ruler.obj", 
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
        shields = {5,4,4,3}, -- Front, left, right, rear
        cost = 130,
        command = 3,
        aliases = {"Rothana II-class Destroyer [Legends]"}
    })

    REPUBLIC_SQUAD = {
        back = CUSTOM_ASSETS.."squadrons/republic/card_back.png",
        faction = "Republic"
    }

-- separatist faction
    SEPARATIST_SHIP = {
        back =      CUSTOM_ASSETS.."ships/separatist/card_back.png",
        faction = "Separatist"
    }

    Ship:new(MediumShip,SEPARATIST_SHIP, {
        name = "Sabaoth-class Destroyer",
        front = CUSTOM_ASSETS.."ships/separatist/sabaoth/sabaoth_destroyer.png",
        mesh = CUSTOM_ASSETS.."ships/separatist/sabaoth/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/sabaoth/diffuse_sabaoth.png",
        ruler = CUSTOM_ASSETS.."ships/separatist/sabaoth/ruler.obj", 
        maneuver = {{"I"},{"I","II"},{"-","I","I"}},
        defense_tokens = {DEF_SALVO,DEF_CONTAIN,DEF_BRACE,DEF_CONTAIN},
        shields = {4,3,3,2}, -- Front, left, right, rear
        cost = 75,
        command = 2,
        aliases = {"Sabaoth-class Destroyer [Legends]"}
    })

    Ship:new(MediumShip,SEPARATIST_SHIP, {
        name = "Sabaoth-class Light Carrier",
        front = CUSTOM_ASSETS.."ships/separatist/sabaoth/sabaoth_carrier.png",
        mesh = CUSTOM_ASSETS.."ships/separatist/sabaoth/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/sabaoth/diffuse_sabaoth.png",
        ruler = CUSTOM_ASSETS.."ships/separatist/sabaoth/ruler.obj", 
        maneuver = {{"I"},{"I","II"},{"-","I","I"}},
        defense_tokens = {DEF_SALVO,DEF_CONTAIN,DEF_BRACE,DEF_CONTAIN},
        shields = {4,3,3,2}, -- Front, left, right, rear
        cost = 70,
        command = 2,
        aliases = {"Sabaoth-class Light Carrier [Legends]"}
    })

    SEPARATIST_SQUAD = {
        back =      CUSTOM_ASSETS.."squadrons/separatist/card_back.png",
        faction = "Separatist"
    }

-- empire faction
    EMPIRE_SHIP = {
        back = ASSETS_ROOT.."ships/empire/card_back.jpg",
        faction = "Empire"
    }

    EMPIRE_SQUAD = {
        back = ASSETS_ROOT.."squadrons/empire/card_back.jpg",
        faction = "Empire"
    }

-- rebel faction
    REBEL_SHIP = {
        back = CUSTOM_ASSETS.."ships/rebel/card_back.png",
        faction = "Rebellion" 
    }

    Ship:new(MediumShip,REBEL_SHIP,{
        name = "Quasar Fire II-class Cruiser-Carrier (Rebel)",
        front =     CUSTOM_ASSETS.."ships/empire/quasar/Rebel_QuasarII.png",
        mesh =      ASSETS_ROOT.."ships/empire/quasar/mesh.obj",
        diffuse =   CUSTOM_ASSETS.."ships/empire/quasar/rebel_II_diffuse.png",
        ruler =     ASSETS_ROOT.."ships/empire/quasar/ruler.obj",
        maneuver = {{"II"},{"I","I"},{"-","I","I"}},
        defense_tokens = {DEF_BRACE,DEF_REDIRECT},
        shields = {2,2,2,1},
        cost = 64,
        aliases = {"Rebel Quasar"},
        command = 2
    })

    REBEL_SQUAD = {
        back = CUSTOM_ASSETS.."squadrons/rebel/card_back.png",
        faction = "Rebellion" 
    }

-- colonial faction
    COL_SHIP = {
        back = CUSTOM_ASSETS.."ships/colonial/card_back.png",
        faction = "Colonial"
    }
    
        -- mercury battlestar
    Ship:new(LargeShip,COL_SHIP, {
        name = "Mercury-class Battlestar Mk.1",
        front = CUSTOM_ASSETS.."ships/colonial/mercury/mk1_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/mercury/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/mercury/mk1_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"I"},{"I","-"},{"I","-","I"}},
        defense_tokens = {DEF_SALVO,DEF_CONTAIN,DEF_BRACE,DEF_CONTAIN},
        shields = {3,4,4,2}, -- Front, left, right, rear
        cost = 140,
        command = 4,
        aliases = {"Mercury Battlestar Mk1 [Legends]"}
    })
    Ship:new(LargeShip,COL_SHIP, {
        name = "Mercury-class Battlestar Mk.2",
        front = CUSTOM_ASSETS.."ships/colonial/mercury/mk2_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/mercury/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/mercury/mk2_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"I"},{"I","-"},{"I","-","I"}},
        defense_tokens = {DEF_SALVO,DEF_CONTAIN,DEF_BRACE,DEF_CONTAIN},
        shields = {3,4,4,2}, -- Front, left, right, rear
        cost = 135,
        command = 4,
        aliases = {"Mercury Battlestar Mk2 [Legends]"}
    })
      
        -- jupiter battlestar
    Ship:new(LargeShip,COL_SHIP, {
        name = "Jupiter-class Battlestar Mk.1",
        front = CUSTOM_ASSETS.."ships/colonial/jupiter/mk1_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/jupiter/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/jupiter/mk1_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"II"},{"I","-"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_CONTAIN},
        shields = {2,3,3,1}, -- Front, left, right, rear
        cost = 100,
        command = 3,
        aliases = {"Jupiter-class Battlestar Mk1 [Legends]"}
    })
    Ship:new(LargeShip,COL_SHIP, {
        name = "Jupiter-class Battlestar Mk.2",
        front = CUSTOM_ASSETS.."ships/colonial/jupiter/mk2_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/jupiter/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/jupiter/mk2_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"II"},{"I","-"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_CONTAIN},
        shields = {2,3,3,1}, -- Front, left, right, rear
        cost = 103,
        command = 3,
        aliases = {"Jupiter-class Battlestar Mk2 [Legends]"}
    })

        -- orion frigate
    Ship:new(SmallShip,COL_SHIP, {
        name = "Orion-class Stealth Battlestar",
        front = CUSTOM_ASSETS.."ships/colonial/orion/stealth_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/orion/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/orion/stealth_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/orion/ruler.obj", 
        maneuver = {{"II"},{"II","I"},{"II","I","I"},{"I","I","I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_EVADE,DEF_EVADE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 54,
        command = 2,
        aliases = {"Orion-class Stealth Battlestar [Legends]"}
    })
    Ship:new(SmallShip,COL_SHIP, {
        name = "Orion-class Pocket Battlestar",
        front = CUSTOM_ASSETS.."ships/colonial/orion/pocket_card.png",
        mesh = CUSTOM_ASSETS.."ships/colonial/orion/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/orion/pocket_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/colonial/orion/ruler.obj", 
        maneuver = {{"II"},{"II","I"},{"II","I","I"},{"I","I","I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_EVADE,DEF_EVADE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 57,
        command = 2,
        aliases = {"Orion-class Pocket Battlestar [Legends]"}
    })
    
    COL_SQUAD = {
        back = CUSTOM_ASSETS.."ships/colonial/card_back.png",
        faction = "Colonial"
    }


-- cylon faction
    CYL_SHIP = {
        back = CUSTOM_ASSETS.."ships/cylon/card_back.png",
        faction = "Cylon"
    }

        -- cylon modern basestar
    Ship:new(LargeShip,CYL_SHIP, {
        name = "Basestar Mk2 Assault Refit",
        front = CUSTOM_ASSETS.."ships/cylon/basestar_modern/basestar_assault.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/basestar_modern/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/basestar_modern/diffuse_assault.png",
        --ruler = CUSTOM_ASSETS.."ships/cylon/basestar_modern/ruler.obj", 
        ruler = ASSETS_ROOT.."ships/empire/imperial/ruler.obj", 
        maneuver = {{"II"},{"-","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_EVADE},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 120,
        command = 3,
        aliases = {"Basestar Mk2 Assault Refit [Legends]"}
    })
    Ship:new(LargeShip,CYL_SHIP, {
        name = "Basestar Mk2 Defense Refit",
        front = CUSTOM_ASSETS.."ships/cylon/basestar_modern/basestar_def.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/basestar_modern/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/basestar_modern/diffuse_def.png",
        --ruler = CUSTOM_ASSETS.."ships/cylon/basestar_modern/ruler.obj", 
        ruler = ASSETS_ROOT.."ships/empire/imperial/ruler.obj", 
        maneuver = {{"II"},{"-","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_EVADE},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 110,
        command = 3,
        aliases = {"Basestar Mk2 Defense Refit [Legends]"}
    })
    
    CYL_SQUAD = {
        back = CUSTOM_ASSETS.."ships/cylon/card_back.png",
        faction = "Cylon"
    }

-- UNSC faction
    UNSC_SHIP = {
        back = CUSTOM_ASSETS.."ships/unsc/card_back.png",
        faction = "UNSC"
    }
    
        -- paris heavy frigate
    Ship:new(SmallShip,UNSC_SHIP, {
        name = "Paris-class Heavy Frigate",
        front = CUSTOM_ASSETS.."ships/unsc/paris/paris_heavy_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/paris/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/paris/diffuse_heavy_paris.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/paris/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 60,
        command = 1,
        aliases = {"Paris-class Heavy Frigate [Legends]"}
    })
    
    Ship:new(SmallShip,UNSC_SHIP, {
        name = "Paris-class Missile Frigate",
        front = CUSTOM_ASSETS.."ships/unsc/paris/paris_missile_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/paris/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/paris/diffuse_missile_paris.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/paris/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 65,
        command = 1,
        aliases = {"Paris-class Missile Frigate [Legends]"}
    })

        --stalwart
    Ship:new(SmallShip,UNSC_SHIP, {
        name = "Stalwart-class Light Frigate",
        front = CUSTOM_ASSETS.."ships/unsc/stalwart/stalwart_light_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/stalwart/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/stalwart/diffuse_light_stalwart.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/stalwart/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 55,
        command = 1,
        aliases = {"Stalwart-class Light Frigate [Legends]"}
    })

    Ship:new(SmallShip,UNSC_SHIP, {
        name = "Stalwart-class Escort Frigate",
        front = CUSTOM_ASSETS.."ships/unsc/stalwart/stalwart_escort_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/stalwart/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/stalwart/diffuse_escort_stalwart.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/stalwart/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 60,
        command = 1,
        aliases = {"Stalwart-class Escort Frigate [Legends]"}
    })   

        --halcyon
    Ship:new(MediumShip,UNSC_SHIP, {
        name = "Halcyon-class Light Cruiser",
        front = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_light_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/halcyon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_light_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/halcyon/ruler.obj", 
        maneuver = {{"I"},{"-","I"},{"-","I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_BRACE,DEF_BRACE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 80,
        command = 2,
        aliases = {"Halcyon-class Light Cruiser [Legends]"}  
    })
        
    Ship:new(MediumShip,UNSC_SHIP, {
        name = "Halcyon-class Battle Refit",
        front = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_refit_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/halcyon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_refit_diffuse.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/halcyon/ruler.obj", 
        maneuver = {{"I"},{"-","I"},{"-","I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_BRACE,DEF_BRACE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 85,
        command = 2,
        aliases = {"Halcyon-class Battle Refit [Legends]"} 
    })
    
    UNSC_SQUAD = {
        back = CUSTOM_ASSETS.."ships/unsc/card_back.png",
        faction = "UNSC"
    }
        --longsword fighter
    ls_fighter = {
        mesh = CUSTOM_ASSETS.."squadrons/unsc/longsword/fighter_mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/longsword_fighter_diffuse.png",
        health = 6,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(ls_fighter, UNSC_SQUAD, {
        name = "Longsword Fighter Squadron",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/longsword_fght_card.png",
        cost = 17,
        aliases = {"Longsword Fighter Squadron [Legends]"}
    })

        --longsword bomber
    ls_bomber = {
        mesh = CUSTOM_ASSETS.."squadrons/unsc/longsword/bomber_mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/longsword_bomber_diffuse.png",
        health = 7,
        move = 2,
        defense_tokens = {}
    }
    Squadron:new(ls_bomber, UNSC_SQUAD, {
        name = "Longsword Bomber Squadron",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/longsword_bomb_card.png",
        cost = 19,
        aliases = {"Longsword Bomber Squadron [Legends]"}
    })


    COV_SHIP = {
        back = CUSTOM_ASSETS.."ships/covenant/back.jpg",
        faction = "Covenant"
    }
        --ccs
        Ship:new(LargeShip,COV_SHIP, {
            name = "CCS-class Battle Cruiser",
            front = CUSTOM_ASSETS.."ships/covenant/ccs/ccs_battle_card.png",
            mesh = CUSTOM_ASSETS.."ships/covenant/ccs/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/ccs/diffuse_ccs.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/ccs/ruler.obj", 
            maneuver = {{"I"},{"-","I"},{"-","I","I"}},
            defense_tokens = {DEF_REDIRECT,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
            shields = {2,2,2,1}, -- Front, left, right, rear
            cost = 85,
            command = 3,
            aliases = {"CCS-class Battle Cruiser [Legends]"} 
        })

        --sdv
        Ship:new(MediumShip,COV_SHIP, {
            name = "SDV-class Heavy Corvette",
            front = CUSTOM_ASSETS.."ships/covenant/sdv/sdv_heavy_card.png",
            mesh = CUSTOM_ASSETS.."ships/covenant/sdv/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/sdv/diffuse_sdv.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/sdv/ruler.obj", 
            maneuver = {{"I"},{"-","I"},{"-","I","I"}},
            defense_tokens = {DEF_REDIRECT,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
            shields = {2,2,2,1}, -- Front, left, right, rear
            cost = 85,
            command = 2,
            aliases = {"SDV-class Heavy Corvette [Legends]"} 
        })

        --cas
        Ship:new(MassiveShip,COV_SHIP, {
            name = "CAS-class Assault Carrier",
            front = CUSTOM_ASSETS.."ships/covenant/cas/cas_assault_card.png",
            mesh = CUSTOM_ASSETS.."ships/covenant/cas/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/cas/diffuse_cas.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/cas/ruler.obj", 
            maneuver = {{"I"},{"-","I"},{"-","I","I"}},
            defense_tokens = {DEF_REDIRECT,DEF_SALVO,DEF_BRACE,DEF_REDIRECT,DEF_REDIRECT,DEF_REDIRECT},
            shields = {2,2,2,1}, -- Front, left, right, rear
            cost = 85,
            command = 4,
            aliases = {"CAS-class Assault Carrier [Legends]"}
        }) 

        --crs
        Ship:new(SmallShip,COV_SHIP, {
            name = "CRS-class Light Cruiser",
            front = CUSTOM_ASSETS.."ships/covenant/crs/crs_light_card.png",
            mesh = CUSTOM_ASSETS.."ships/covenant/crs/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/crs/diffuse_crs.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/crs/ruler.obj", 
            maneuver = {{"I"},{"-","I"},{"-","I","I"}},
            defense_tokens = {DEF_REDIRECT,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
            shields = {2,2,2,1}, -- Front, left, right, rear
            cost = 85,
            command = 1,
            aliases = {"CRS-class Light Cruiser [Legends]"} 
        })

    COV_SQUAD = {
        back = CUSTOM_ASSETS.."ships/covenant/back.jpg",
        faction = "Covenant"
    }
        --space banshee
    banshee = {
        mesh = CUSTOM_ASSETS.."squadrons/covenant/banshee/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/banshee/diffuse_banshee.png",
        health = 3,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(banshee, COV_SQUAD, {
        name = "Banshee Squadron",
        front = CUSTOM_ASSETS.."squadrons/covenant/banshee/banshee_card.png",
        cost = 8,
        aliases = {"Banshee Squadron [Legends]"}
    })

        --seraph
    seraph = {
        mesh = CUSTOM_ASSETS.."squadrons/covenant/seraph/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/seraph/diffuse_seraph.png",
        health = 5,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(seraph, COV_SQUAD, {
        name = "Seraph Squadron",
        front = CUSTOM_ASSETS.."squadrons/covenant/seraph/seraph_card.png",
        cost = 15,
        aliases = {"Seraph Squadron [Legends]"}
    })


    ------upgrades
    Commander = {
        type="Commander",
        back = CUSTOM_ASSETS.."/cards/commanders/back.png"
    }
    Title = {
        type="Title",
        back = CUSTOM_ASSETS.."/cards/titles/back.png"
    }
    
    --halo    
    UNSC = {
        factions={"UNSC"}
    }
    Covenant = {
        factions={"Covenant"}
    }
    Halo = {
        factions={"UNSC","Covenant"}
    }    

    Card:new(Commander,UNSC,{name="Captain Keyes",  front = CUSTOM_ASSETS.."cards/commanders/capt_keyes_card.png", cost=30, aliases={"Captain Keyes [Legends]"}})
    Card:new(Commander,UNSC,{name="Captain Wallace",  front = CUSTOM_ASSETS.."cards/commanders/capt_wallace_card.png", cost=20, aliases={"Captain Wallace [Legends]"}})
    Card:new(Commander,UNSC,{name="Commander Keyes",  front = CUSTOM_ASSETS.."cards/commanders/cmdr_keyes_card.png", cost=25, aliases={"Commander Keyes [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Pillar of Autumn", front = CUSTOM_ASSETS.."cards/titles/titles_halcyon_poa.png", cost=10, aliases={"UNSC Pillar of Autumn [Legends]"}})   
    Card:new(Title,UNSC,{name="UNSC Constantinople", front = CUSTOM_ASSETS.."cards/titles/titles_halcyon_const.png", cost=5, aliases={"UNSC Constantinople [Legends]"}})   
    Card:new(Title,UNSC,{name="UNSC Roman Blue", front = CUSTOM_ASSETS.."cards/titles/titles_halcyon_roman.png", cost=2, aliases={"UNSC Roman Blue [Legends]"}})   
    Card:new(Title,UNSC,{name="UNSC Savannah", front = CUSTOM_ASSETS.."cards/titles/title_paris_savannah.png", cost=7, aliases={"UNSC Savannah [Legends]"}})   
    Card:new(Title,UNSC,{name="UNSC Commonwealth", front = CUSTOM_ASSETS.."cards/titles/title_paris_commonwealth.png", cost=5, aliases={"UNSC Commonwealth [Legends]"}})   
    Card:new(Title,UNSC,{name="UNSC In Amber Clad", front = CUSTOM_ASSETS.."cards/titles/titles_stalwart_iac.png", cost=7, aliases={"UNSC In Amber Clad [Legends]"}})   
    Card:new(Title,UNSC,{name="UNSC Meriweather Lewis", front = CUSTOM_ASSETS.."cards/titles/titles_stalwart_merilew.png", cost=2, aliases={"UNSC Meriweather Lewis [Legends]"}})   

    --bsg

    --starwars

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
    MassiveShip = { collider = LEGACY_ASSETS..'dev/wave3/ships/subjugator/massive_base_mesh.obj'} --https://pastebin.com/raw/FbinX7mf
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
    
    