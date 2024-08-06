CUSTOM_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/SNCustomTTS-IncludeDir/master/SW_armada/assets/'
LEGACY_ASSETS = 'https://raw.githubusercontent.com/spacenavy90/ArmadaLegacyTTS-IncludeDir/master/assets/'
ASSETS_ROOT = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'

function onload()
    printToAll("Loading Armada Legends content...",{1,0.5,0})

-- republic faction
    REPUBLIC_SHIP = {
        back = CUSTOM_ASSETS.."ships/republic/card_back.png",
        faction = "!Republic"
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
        faction = "!Republic"
    }

-- separatist faction
    SEPARATIST_SHIP = {
        back =      CUSTOM_ASSETS.."ships/separatist/card_back.png",
        faction = "!Separatist"
    }

    Ship:new(MediumShip,SEPARATIST_SHIP, {
        name = "Sabaoth-class Destroyer",
        front = CUSTOM_ASSETS.."ships/separatist/sabaoth/sabaoth_dest_card.png",
        mesh = CUSTOM_ASSETS.."ships/separatist/sabaoth/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/sabaoth/diffuse_dest_sabaoth.png",
        ruler = CUSTOM_ASSETS.."ships/separatist/sabaoth/ruler.obj", 
        maneuver = {{"I"},{"I","II"},{"-","I","I"}},
        defense_tokens = {DEF_SALVO,DEF_CONTAIN,DEF_BRACE,DEF_CONTAIN},
        shields = {4,3,3,2}, -- Front, left, right, rear
        cost = 73,
        command = 2,
        aliases = {"Sabaoth-class Destroyer [Legends]"}
    })
    Ship:new(MediumShip,SEPARATIST_SHIP, {
        name = "Sabaoth-class Light Carrier",
        front = CUSTOM_ASSETS.."ships/separatist/sabaoth/sabaoth_carrier_card.png",
        mesh = CUSTOM_ASSETS.."ships/separatist/sabaoth/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/sabaoth/diffuse_carrier_sabaoth.png",
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
        faction = "!Separatist"
    }

-- empire faction
    EMPIRE_SHIP = {
        back = ASSETS_ROOT.."ships/empire/card_back.jpg",
        faction = "!Empire"
    }

    EMPIRE_SQUAD = {
        back = ASSETS_ROOT.."squadrons/empire/card_back.jpg",
        faction = "!Empire"
    }

    --cx dagger
    cx_dagger = {
        mesh = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/diffuse_cx.png",
        health = 5,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(cx_dagger, EMPIRE_SQUAD, {
        name = "CX Dagger Vessel",
        front = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/cx_card.png",
        cost = 15,
        aliases = {"CX Dagger Vessel [Legends]"}
    })
    Squadron:new(cx_dagger, EMPIRE_SQUAD, {
        name = "CX-2",
        front = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/cx2_card.png",
        diffuse = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/diffuse_ace_cx.png", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 24,
        aliases = {"CX-2 [Legends]"}
    })

-- rebel faction
    REBEL_SHIP = {
        back = CUSTOM_ASSETS.."ships/rebel/card_back.png",
        faction = "!Rebellion" 
    }

    Ship:new(MediumShip,REBEL_SHIP,{
        name = "Quasar Fire II-class Cruiser-Carrier (Rebel)",
        front =     CUSTOM_ASSETS.."ships/rebel/reb_quasar/Rebel_QuasarII.png",
        mesh =      ASSETS_ROOT.."ships/empire/quasar/mesh.obj",
        diffuse =   CUSTOM_ASSETS.."ships/rebel/reb_quasar/rebel_II_diffuse.png",
        ruler =     ASSETS_ROOT.."ships/rebel/reb_quasar/ruler.obj",
        maneuver = {{"II"},{"I","I"},{"-","I","I"}},
        defense_tokens = {DEF_BRACE,DEF_REDIRECT},
        shields = {2,2,2,1},
        cost = 64,
        aliases = {"Rebel Quasar"},
        command = 2
    })

    REBEL_SQUAD = {
        back = CUSTOM_ASSETS.."squadrons/rebel/card_back.png",
        faction = "!Rebellion" 
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
        defense_tokens = {DEF_SALVO,DEF_BARRAGE,DEF_BRACE,DEF_BARRAGE},
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
        defense_tokens = {DEF_SALVO,DEF_BARRAGE,DEF_BRACE,DEF_BARRAGE},
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
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_BARRAGE},
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
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_BARRAGE},
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
        defense_tokens = {DEF_BARRAGE,DEF_EVADE,DEF_EVADE},
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
        defense_tokens = {DEF_BARRAGE,DEF_EVADE,DEF_EVADE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 57,
        command = 2,
        aliases = {"Orion-class Pocket Battlestar [Legends]"}
    })
    
    COL_SQUAD = {
        back = CUSTOM_ASSETS.."ships/colonial/card_back.png",
        faction = "Colonial"
    }

    --viper mk2
    viper_mk2 = {
        mesh = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/diffuse_mk2.png",
        health = 3,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(viper_mk2, COL_SQUAD, {
        name = "Viper MkII Squadron",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/vipermk2_card.png",
        cost = 9,
        aliases = {"Viper MkII Squadron [Legends]"}
    })
    Squadron:new(viper_mk2, COL_SQUAD, {
        name = "Kara Thrace",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/vipermk2_kara.png",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/diffuse_ace_mk2.png", 
        defense_tokens = {DEF_SCATTER,DEF_SCATTER},
        cost = 19,
        aliases = {"Kara Thrace [Legends]"}
    })

    --viper mk7
    viper_mk7 = {
        mesh = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/diffuse_mk7.png",
        health = 4,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(viper_mk7, COL_SQUAD, {
        name = "Viper MkVII Squadron",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/vipermk7_card.png",
        cost = 13,
        aliases = {"Viper MkVII Squadron [Legends]"}
    })
    Squadron:new(viper_mk7, COL_SQUAD, {
        name = "Lee Adama",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/vipermk7_apollo.png",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/diffuse_ace_mk7.png", 
        defense_tokens = {DEF_SCATTER,DEF_BRACE},
        cost = 22,
        aliases = {"Lee Adama [Legends]"}
    })

    --raptor
    raptor = {
        mesh = CUSTOM_ASSETS.."squadrons/colonial/raptor/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/raptor/diffuse_raptor.png",
        health = 5,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(raptor, COL_SQUAD, {
        name = "Assault Raptor Squadron",
        front = CUSTOM_ASSETS.."squadrons/colonial/raptor/assault_raptor_card.png",
        cost = 12,
        aliases = {"Assault Raptor Squadron [Legends]"}
    })
    Squadron:new(raptor, COL_SQUAD, {
        name = "Racetrack",
        front = CUSTOM_ASSETS.."squadrons/colonial/raptor/racetrack_raptor.png",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/raptor/diffuse_ace_raptor.png", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 17,
        aliases = {"Racetrack [Legends]"}
    })


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
        --halcyon
    Ship:new(MediumShip,UNSC_SHIP, {
        name = "Halcyon-class Light Cruiser",
        front = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_light_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/halcyon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/halcyon/diffuse_light_halcyon.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/halcyon/ruler.obj", 
        maneuver = {{"I"},{"-","I"},{"-","I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_BRACE,DEF_BRACE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 78,
        command = 2,
        aliases = {"Halcyon-class Light Cruiser [Legends]"}  
    })
    Ship:new(MediumShip,UNSC_SHIP, {
        name = "Halcyon-class Battle Refit",
        front = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_refit_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/halcyon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/halcyon/diffuse_refit_halcyon.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/halcyon/ruler.obj", 
        maneuver = {{"I"},{"-","I"},{"-","I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_CONTAIN,DEF_BRACE,DEF_BRACE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 82,
        command = 2,
        aliases = {"Halcyon-class Battle Refit [Legends]"} 
    })
    
        -- paris heavy frigate
    Ship:new(SmallShip,UNSC_SHIP, {
        name = "Paris-class Heavy Frigate",
        front = CUSTOM_ASSETS.."ships/unsc/paris/paris_heavy_card.png",
        mesh = CUSTOM_ASSETS.."ships/unsc/paris/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/paris/diffuse_heavy_paris.png",
        ruler = CUSTOM_ASSETS.."ships/unsc/paris/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 55,
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
        defense_tokens = {DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 60,
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
        defense_tokens = {DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 45,
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
        defense_tokens = {DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 50,
        command = 1,
        aliases = {"Stalwart-class Escort Frigate [Legends]"}
    })   

    
    UNSC_SQUAD = {
        back = CUSTOM_ASSETS.."ships/unsc/card_back.png",
        faction = "UNSC"
    }
        --longsword fighter
    ls_fighter = {
        mesh = CUSTOM_ASSETS.."squadrons/unsc/longsword/fighter_mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_fighter.png",
        health = 6,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(ls_fighter, UNSC_SQUAD, {
        name = "Longsword Fighter Squadron",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_fighter_card.png",
        cost = 15,
        aliases = {"Longsword Fighter Squadron [Legends]"}
    })
    Squadron:new(ls_fighter, UNSC_SQUAD, {
        name = "Knife 26",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_fighter_knife26.png",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_ace_fighter.png", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 20,
        aliases = {"Knife 26 [Legends]"}
    })

        --longsword bomber
    ls_bomber = {
        mesh = CUSTOM_ASSETS.."squadrons/unsc/longsword/bomber_mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_bomber.png",
        health = 7,
        move = 2,
        defense_tokens = {}
    }
    Squadron:new(ls_bomber, UNSC_SQUAD, {
        name = "Longsword Bomber Squadron",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_bomber_card.png",
        cost = 17,
        aliases = {"Longsword Bomber Squadron [Legends]"}
    })
    Squadron:new(ls_bomber, UNSC_SQUAD, {
        name = "Master Chief",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_bomber_chief.png",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_ace_bomber.png", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 19,
        aliases = {"Master Chief (LS) [Legends]"}
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
            diffuse = CUSTOM_ASSETS.."ships/covenant/ccs/diffuse_battle_ccs.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/ccs/ruler.obj", 
            maneuver = {{"I"},{"I","I"},{"I","-","I"}},
            defense_tokens = {DEF_REDIRECT,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
            shields = {3,4,4,3}, -- Front, left, right, rear
            cost = 115,
            command = 3,
            aliases = {"CCS-class Battle Cruiser [Legends]"} 
        })
        Ship:new(LargeShip,COV_SHIP, {
            name = "CCS-class Command Cruiser",
            front = CUSTOM_ASSETS.."ships/covenant/ccs/ccs_command_card.png",
            mesh = CUSTOM_ASSETS.."ships/covenant/ccs/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/ccs/diffuse_command_ccs.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/ccs/ruler.obj", 
            maneuver = {{"I"},{"I","I"},{"I","-","I"}},
            defense_tokens = {DEF_REDIRECT,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
            shields = {3,4,4,3}, -- Front, left, right, rear
            cost = 105,
            command = 3,
            aliases = {"CCS-class Command Cruiser [Legends]"} 
        })

        --sdv
        Ship:new(MediumShip,COV_SHIP, {
            name = "SDV-class Heavy Corvette",
            front = CUSTOM_ASSETS.."ships/covenant/sdv/sdv_heavy_card.png",
            mesh = CUSTOM_ASSETS.."ships/covenant/sdv/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/sdv/diffuse_heavy_sdv.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/sdv/ruler.obj", 
            maneuver = {{"II"},{"I","I"},{"I","I","-"}},
            defense_tokens = {DEF_REDIRECT,DEF_EVADE,DEF_BRACE},
            shields = {3,3,3,2}, -- Front, left, right, rear
            cost = 80,
            command = 2,
            aliases = {"SDV-class Heavy Corvette [Legends]"} 
        })
        Ship:new(MediumShip,COV_SHIP, {
            name = "SDV-class Assault Corvette",
            front = CUSTOM_ASSETS.."ships/covenant/sdv/sdv_assault_card.png",
            mesh = CUSTOM_ASSETS.."ships/covenant/sdv/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/sdv/diffuse_assault_sdv.png",
            ruler = CUSTOM_ASSETS.."ships/covenant/sdv/ruler.obj", 
            maneuver = {{"II"},{"I","I"},{"I","I","-"}},
            defense_tokens = {DEF_REDIRECT,DEF_EVADE,DEF_BRACE},
            shields = {3,3,3,2}, -- Front, left, right, rear
            cost = 75,
            command = 2,
            aliases = {"SDV-class Assault Corvette [Legends]"} 
        })

        --cas
        Ship:new(MassiveShip,COV_SHIP, {
            name = "(WIP)CAS-class Assault Carrier",
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
            name = "(WIP)CRS-class Light Cruiser",
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
    Squadron:new(banshee, COV_SQUAD, {
        name = "Dalamenee",
        front = CUSTOM_ASSETS.."squadrons/covenant/banshee/banshee_dalamenee.png",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/banshee/diffuse_ace_banshee.png", 
        defense_tokens = {DEF_SCATTER,DEF_EVADE},
        cost = 14,
        aliases = {"Dalamenee [Legends]"}
    })
    Squadron:new(banshee, COV_SQUAD, {
        name = "Wraith Wing",
        front = CUSTOM_ASSETS.."squadrons/covenant/banshee/banshee_wraith.png",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/banshee/diffuse_sqd_banshee.png", 
        cost = 10,
        aliases = {"Wraith Wing [Legends]"}
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
        cost = 14,
        aliases = {"Seraph Squadron [Legends]"}
    })
    Squadron:new(seraph, COV_SQUAD, {
        name = "Ferko",
        front = CUSTOM_ASSETS.."squadrons/covenant/seraph/seraph_ferko.png",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/seraph/diffuse_ace_seraph.png", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 20,
        aliases = {"Ferko [Legends]"}
    })

    ------upgrades
    Commander = {type="Commander", back = CUSTOM_ASSETS.."cards/commander/back.png"}
    DefensiveRetrofit = {type="DefensiveRetrofit", back = CUSTOM_ASSETS.."cards/defretro/back.png"}
    FleetCommand = {type="FleetCommand", back = CUSTOM_ASSETS.."cards/fleetcom/back.png"}
    FleetSupport = {type="FleetSupport", back = CUSTOM_ASSETS.."cards/fleetsup/back.png"}
    IonCannons = {type="IonCannons", back = CUSTOM_ASSETS.."cards/ion/back.png"}
    OffensiveRetrofit = {type="OffensiveRetrofit", back = CUSTOM_ASSETS.."cards/offretro/back.png"}
    Officer = {type="Officer", back = CUSTOM_ASSETS.."cards/officer/back.png"}
    SuperWeapon = {type="SuperWeapon", back = CUSTOM_ASSETS.."cards/super/back.png"}
    SupportTeam = {type="SupportTeam", back = CUSTOM_ASSETS.."cards/support/back.png"}
    Title = {type="Title", back = CUSTOM_ASSETS.."cards/title/back.png"}
    WeaponsTeam = {type="WeaponsTeam", back = CUSTOM_ASSETS.."cards/wepteam/back.png"}
    -- = {type="", back = CUSTOM_ASSETS.."cards//back.png"}
    
    --starwars
    Empire = {
        factions={"!Empire"}
    }
    Rebel = {
        factions={"!Rebellion"}
    }
    Republic = {
        factions={"!Republic"}
    }
    Separatist = {
        factions={"!Separatist"}
    }
    CloneWars = {
        factions={"!Republic","!Separatist"}
    }
    
    Card:new(Title,Empire,{name="placeholderemp", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_ph.png", cost=4, aliases={"placeholderemp [Legends]"}})
    Card:new(Title,Rebel,{name="Phoenix Home", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_ph.png", cost=4, aliases={"Phoenix Home [Legends]"}})
    Card:new(Title,Rebel,{name="Phoenix Nest", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_pn.png", cost=6, aliases={"Phoenix Nest [Legends]"}})
    Card:new(Title,Republic,{name="Righteous Indignation", front = CUSTOM_ASSETS.."ships/republic/rothana/right_indig.png", cost=4, aliases={"Righteous Indignation [Legends]"}})
    --Card:new(Title,Republic,{name="Deliverance", front = CUSTOM_ASSETS.."ships/republic/rothana/right_indig.png", cost=7, aliases={"Deliverance [Legends]"}})
    Card:new(Title,Separatist,{name="Reaver", front = CUSTOM_ASSETS.."ships/separatist/sabaoth/title_sabaoth_reaver.png", cost=5, aliases={"Reaver [Legends]"}})
    Card:new(Title,Separatist,{name="Parting Handshake", front = CUSTOM_ASSETS.."ships/separatist/sabaoth/title_sabaoth_parthand.png", cost=5, aliases={"Parting Handshake [Legends]"}})
    
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

    Card:new(Commander,UNSC,{name="Captain Keyes",  front = CUSTOM_ASSETS.."cards/~halo/com_capt_keyes.png", cost=30, aliases={"Captain Keyes [Legends]"}})
    Card:new(Commander,UNSC,{name="Captain Wallace",  front = CUSTOM_ASSETS.."cards/~halo/com_capt_wallace.png", cost=20, aliases={"Captain Wallace [Legends]"}})
    Card:new(Commander,UNSC,{name="Commander Keyes",  front = CUSTOM_ASSETS.."cards/~halo/com_cmdr_keyes.png", cost=27, aliases={"Commander Keyes [Legends]"}})
    Card:new(Commander,UNSC,{name="Lord Hood",  front = CUSTOM_ASSETS.."cards/~halo/com_lordhood.png", cost=30, aliases={"Lord Hood [Legends]"}})
    Card:new(Commander,Covenant,{name="Ardo Moretumee",  front = CUSTOM_ASSETS.."cards/~halo/com_ardomoretumee.png", cost=20, aliases={"Ardo Moretumee [Legends]"}})
    Card:new(Commander,Covenant,{name="Atriox",  front = CUSTOM_ASSETS.."cards/~halo/com_atriox.png", cost=35, aliases={"Atriox [Legends]"}})
    Card:new(Commander,Covenant,{name="Prophet of Truth",  front = CUSTOM_ASSETS.."cards/~halo/com_prophettruth.png", cost=30, aliases={"Prophet of Truth [Legends]"}})
    Card:new(Commander,Covenant,{name="Thel Vadamee",  front = CUSTOM_ASSETS.."cards/~halo/com_thelvadamee.png", cost=25, aliases={"Thel Vadamee [Legends]"}})

    Card:new(DefensiveRetrofit,UNSC,{name="Emergency Thrusters",  front = CUSTOM_ASSETS.."cards/~halo/dr_emergthrusters.png", cost=6, aliases={"Emergency Thrusters [Legends]"}})
    Card:new(DefensiveRetrofit,UNSC,{name="Titanium Armor Plating",  front = CUSTOM_ASSETS.."cards/~halo/dr_titarmor.png", cost=4, aliases={"Titanium Armor Plating [Legends]"}})
    Card:new(DefensiveRetrofit,Covenant,{name="Reliable Shields",  front = CUSTOM_ASSETS.."cards/~halo/dr_reliableshields.png", cost=9, aliases={"Reliable Shields [Legends]"}})

    Card:new(FleetCommand,Covenant,{name="Jiralhanae Brutality",  front = CUSTOM_ASSETS.."cards/~halo/fc_jirabrutal.png", cost=7, aliases={"Jiralhanae Brutality [Legends]"}})
    Card:new(FleetCommand,Covenant,{name="Sangheili Honor",  front = CUSTOM_ASSETS.."cards/~halo/fc_sanghonor.png", cost=6, aliases={"Sangehili Honor [Legends]"}})
    Card:new(FleetCommand,Covenant,{name="Will of the Prophets",  front = CUSTOM_ASSETS.."cards/~halo/fc_wotp.png", cost=8, aliases={"Will of the Prophets [Legends]"}})

    Card:new(IonCannons,Covenant,{name="Overcharged Plasma Cells",  front = CUSTOM_ASSETS.."cards/~halo/ic_overplascells.png", cost=9, aliases={"Overcharged Plasma Cells [Legends]"}})
    Card:new(IonCannons,UNSC,{name="Sustain Motor Missiles",  front = CUSTOM_ASSETS.."cards/~halo/ic_sustainmissiles.png", cost=6, aliases={"Sustain Motor Missiles [Legends]"}})

    Card:new(OffensiveRetrofit,Covenant,{name="Plasma Lance",  front = CUSTOM_ASSETS.."cards/~halo/or_plasmalance.png", cost=10, aliases={"Plasma Lance [Legends]"}})
    
    Card:new(Officer,Halo,{name="Combat Coordinator", front = CUSTOM_ASSETS.."cards/~halo/off_combatcoord.png", cost=5, aliases={"Combat Coordinator [Legends]"}})
    Card:new(Officer,Halo,{name="Logistics Coordinator", front = CUSTOM_ASSETS.."cards/~halo/off_logicoord.png", cost=5, aliases={"Logistics Coordinator [Legends]"}})
    Card:new(Officer,UNSC,{name="Cortana (Officer)", front = CUSTOM_ASSETS.."cards/~halo/off_cortana.png", cost=8, aliases={"Cortana (Officer) [Legends]"}})
    Card:new(Officer,UNSC,{name="Avery Johnson (Officer)", front = CUSTOM_ASSETS.."cards/~halo/off_johnson.png", cost=5, aliases={"Avery Johnson (Officer) [Legends]"}})
    Card:new(Officer,UNSC,{name="Kristof Jen", front = CUSTOM_ASSETS.."cards/~halo/off_kristofjen.png", cost=5, aliases={"Kristof Jen [Legends]"}})
    Card:new(Officer,UNSC,{name="Master Chief (Officer)", front = CUSTOM_ASSETS.."cards/~halo/off_masterchief.png", cost=3, aliases={"Master Chief (Officer) [Legends]"}})
    Card:new(Officer,UNSC,{name="Antonio Silva", front = CUSTOM_ASSETS.."cards/~halo/off_silva.png", cost=6, aliases={"Antonio Silva [Legends]"}})
    Card:new(Officer,UNSC,{name="Smart AI", front = CUSTOM_ASSETS.."cards/~halo/off_smartai.png", cost=5, aliases={"Smart AI [Legends]"}})
    Card:new(Officer,Covenant,{name="Lat Ravamee", front = CUSTOM_ASSETS.."cards/~halo/off_latravamee.png", cost=9, aliases={"Lat Ravamee [Legends]"}})
    Card:new(Officer,Covenant,{name="Maccabeus", front = CUSTOM_ASSETS.."cards/~halo/off_maccabeus.png", cost=9, aliases={"Maccabeus [Legends]"}})
    Card:new(Officer,Covenant,{name="Prophet of Stewardship", front = CUSTOM_ASSETS.."cards/~halo/off_prophetsteward.png", cost=2, aliases={"Prophet of Stewardship [Legends]"}})
    Card:new(Officer,Covenant,{name="Rtas Vadumee", front = CUSTOM_ASSETS.."cards/~halo/off_rtasvadumee.png", cost=4, aliases={"Rtas Vadumee [Legends]"}})
    
    Card:new(SuperWeapon,UNSC,{name="Quick-Charge Capacitors",  front = CUSTOM_ASSETS.."cards/~halo/sw_qccaps.png", cost=6, aliases={"Quick-Charge Capacitors [Legends]"}})
    
    Card:new(SupportTeam,Covenant,{name="Huragok Engineer Team",  front = CUSTOM_ASSETS.."cards/~halo/st_huragokeng.png", cost=3, aliases={"Huragok Engineer Team [Legends]"}})

    Card:new(Title,UNSC,{name="UNSC Pillar of Autumn", front = CUSTOM_ASSETS.."ships/unsc/halcyon/title_halcyon_poa.png", cost=7, aliases={"UNSC Pillar of Autumn [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Constantinople", front = CUSTOM_ASSETS.."ships/unsc/halcyon/title_halcyon_const.png", cost=3, aliases={"UNSC Constantinople [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Roman Blue", front = CUSTOM_ASSETS.."ships/unsc/halcyon/title_halcyon_roman.png", cost=2, aliases={"UNSC Roman Blue [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Savannah", front = CUSTOM_ASSETS.."ships/unsc/paris/title_paris_savannah.png", cost=9, aliases={"UNSC Savannah [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Commonwealth", front = CUSTOM_ASSETS.."ships/unsc/paris/title_paris_commonwealth.png", cost=7, aliases={"UNSC Commonwealth [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC In Amber Clad", front = CUSTOM_ASSETS.."ships/unsc/stalwart/title_stalwart_iac.png", cost=8, aliases={"UNSC In Amber Clad [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Meriweather Lewis", front = CUSTOM_ASSETS.."ships/unsc/stalwart/title_stalwart_merilew.png", cost=1, aliases={"UNSC Meriweather Lewis [Legends]"}})
    Card:new(Title,Covenant,{name="Truth and Reconciliation", front = CUSTOM_ASSETS.."ships/covenant/ccs/title_ccs_truthandreco.png", cost=6, aliases={"Truth and Reconciliation [Legends]"}})
    Card:new(Title,Covenant,{name="Purity of Spirit", front = CUSTOM_ASSETS.."ships/covenant/ccs/title_ccs_purityspirit.png", cost=5, aliases={"Purity of Spirit [Legends]"}})
    Card:new(Title,Covenant,{name="Ardent Prayer", front = CUSTOM_ASSETS.."ships/covenant/sdv/title_sdv_ardentprayer.png", cost=4, aliases={"Ardent Prayer [Legends]"}})
    Card:new(Title,Covenant,{name="Elegy's Lament", front = CUSTOM_ASSETS.."ships/covenant/sdv/title_sdv_elegylament.png", cost=3, aliases={"Elegy's Lament [Legends]"}})

    Card:new(WeaponsTeam,UNSC,{name="Cortana (WT)", front = CUSTOM_ASSETS.."cards/~halo/wt_cortana.png", cost=7, aliases={"Cortana (WT) [Legends]"}})
    Card:new(WeaponsTeam,UNSC,{name="UNSC Gunners", front = CUSTOM_ASSETS.."cards/~halo/wt_unscgunners.png", cost=6, aliases={"UNSC Gunners [Legends]"}})

    --bsg
    Colonial = {
        factions={"Colonial"}
    }
    Cylon = {
        factions={"Cylon"}
    }
    BSG = {
        factions={"Colonial","Cylon"}
    }   

    Card:new(Commander,Colonial,{name="Helena Cain", front = CUSTOM_ASSETS.."cards/~bsg/cain_commander.png", cost=34, aliases={"Helena Cain [Legends]"}})
    Card:new(Commander,Colonial,{name="Commander Ozar", front = CUSTOM_ASSETS.."cards/~bsg/ozar_commander.png", cost=29, aliases={"Commander Ozar [Legends]"}})
    Card:new(Commander,Colonial,{name="William Adama", front = CUSTOM_ASSETS.."cards/~bsg/willadama_commander.png", cost=20, aliases={"William Adama [Legends]"}})

    Card:new(DefensiveRetrofit,Colonial,{name="DRADIS", front = CUSTOM_ASSETS.."cards/~bsg/dradis_defretro.png", cost=4, aliases={"DRADIS [Legends]"}})
    Card:new(DefensiveRetrofit,Colonial,{name="Integrated Computer Network", front = CUSTOM_ASSETS.."cards/~bsg/intcomnet_defretro.png", cost=4, aliases={"Integrated Computer Network [Legends]"}})
    Card:new(DefensiveRetrofit,Colonial,{name="Layered Point-Defense", front = CUSTOM_ASSETS.."cards/~bsg/layerpd_defretro.png", cost=10, aliases={"Layered Point-Defense [Legends]"}})
    Card:new(DefensiveRetrofit,Colonial,{name="Networked Point-Defense", front = CUSTOM_ASSETS.."cards/~bsg/netpd_defretro.png", cost=6, aliases={"Networked Point-Defense [Legends]"}})

    Card:new(FleetCommand,Colonial,{name="So Say We All", front = CUSTOM_ASSETS.."cards/~bsg/sswa_fleetcom.png", cost=7, aliases={"So Say We All [Legends]"}})
    Card:new(FleetCommand,Colonial,{name="Suppression Barrage Execute", front = CUSTOM_ASSETS.."cards/~bsg/supbar_fleetcom.png", cost=6, aliases={"Suppression Barrage Execute [Legends]"}})

    Card:new(FleetSupport,Colonial,{name="Missile Pods", front = CUSTOM_ASSETS.."cards/~bsg/missilepods_fleetsup.png", cost=4, aliases={"Missile Pods [Legends]"}})
    Card:new(FleetSupport,Colonial,{name="Strike Munitions", front = CUSTOM_ASSETS.."cards/~bsg/strike_mun_fleetsup.png", cost=8, aliases={"Strike Munitions [Legends]"}})

    Card:new(Officer,Colonial,{name="Jack Fisk", front = CUSTOM_ASSETS.."cards/~bsg/fisk_officer.png", cost=2, aliases={"Jack Fisk [Legends]"}})
    Card:new(Officer,Colonial,{name="Felix Gaeta", front = CUSTOM_ASSETS.."cards/~bsg/gaeta_officer.png", cost=6, aliases={"Felix Gaeta [Legends]"}})
    Card:new(Officer,Colonial,{name="Lee Adama", front = CUSTOM_ASSETS.."cards/~bsg/leeadama_officer.png", cost=7, aliases={"Lee Adama [Legends]"}})
    Card:new(Officer,Colonial,{name="Saul Tigh", front = CUSTOM_ASSETS.."cards/~bsg/tigh_officer.png", cost=5, aliases={"Saul Tigh [Legends]"}})

    Card:new(SuperWeapon,Colonial,{name="Chrome-Composite Stealth Plating", front = CUSTOM_ASSETS.."cards/~bsg/chrome_stealth_super.png", cost=10, aliases={"Chrome-Composite Stealth Plating [Legends]"}})

    Card:new(SupportTeam,Colonial,{name="Damage Control Teams", front = CUSTOM_ASSETS.."cards/~bsg/dmgctrl_sup.png", cost=4, aliases={"Damage Control Teams [Legends]"}})
    Card:new(SupportTeam,Colonial,{name="Galen Tyrol", front = CUSTOM_ASSETS.."cards/~bsg/tyrol_sup.png", cost=5, aliases={"Galen Tyrol [Legends]"}})

    Card:new(Title,Colonial,{name="Acheron", front = CUSTOM_ASSETS.."cards/~bsg/acheron_title.png", cost=7, aliases={"Acheron [Legends]"}})
    Card:new(Title,Colonial,{name="Demeter", front = CUSTOM_ASSETS.."cards/~bsg/demeter_title.png", cost=4, aliases={"Demeter [Legends]"}})
    Card:new(Title,Colonial,{name="Galactica", front = CUSTOM_ASSETS.."cards/~bsg/galactica_title.png", cost=4, aliases={"Galactica [Legends]"}})
    Card:new(Title,Colonial,{name="Osiris", front = CUSTOM_ASSETS.."cards/~bsg/osiris_title.png", cost=9, aliases={"Osiris [Legends]"}})
    Card:new(Title,Colonial,{name="Pegasus", front = CUSTOM_ASSETS.."cards/~bsg/pegasus_title.png", cost=6, aliases={"Pegasus [Legends]"}})
    Card:new(Title,Colonial,{name="Triton", front = CUSTOM_ASSETS.."cards/~bsg/triton_title.png", cost=5, aliases={"Triton [Legends]"}})

    Card:new(OffensiveRetrofit,Colonial,{name="Archer Missiles",  front = CUSTOM_ASSETS.."cards/~bsg/archerm_offretro.png", cost=7, aliases={"Archer Missiles [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Bombing Run",  front = CUSTOM_ASSETS.."cards/~bsg/bombrun_offretro.png", cost=4, aliases={"Bombing Run [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Dual-Purpose KEW",  front = CUSTOM_ASSETS.."cards/~bsg/dualKEW_offretro.png", cost=7, aliases={"Dual-Purpose KEW [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Indiscriminate Firing Solution",  front = CUSTOM_ASSETS.."cards/~bsg/indisfire_offretro.png", cost=4, aliases={"Indiscriminate Firing Solution [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Magnetic Launch Tubes",  front = CUSTOM_ASSETS.."cards/~bsg/magtubes_offretro.png", cost=7, aliases={"Magnetic Launch Tubes [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Networked Fire Control",  front = CUSTOM_ASSETS.."cards/~bsg/netfirecon_offretro.png", cost=5, aliases={"Networked Fire Control [Legends]"}})

    Card:new(WeaponsTeam,Colonial,{name="Colonial Gunners", front = CUSTOM_ASSETS.."cards/~bsg/colgunner_wep.png", cost=5, aliases={"Colonial Gunners [Legends]"}})
    Card:new(WeaponsTeam,Colonial,{name="Gunnery Sergeant", front = CUSTOM_ASSETS.."cards/~bsg/gunsgt_wep.png", cost=6, aliases={"Gunnery Sergeant [Legends]"}})
    Card:new(WeaponsTeam,Colonial,{name="Reactive Gunners", front = CUSTOM_ASSETS.."cards/~bsg/reactgun_wep.png", cost=4, aliases={"Reactive Gunners [Legends]"}})

    Card:new(Title,Cylon,{name="placeholdercyl", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_ph.png", cost=4, aliases={"placeholdercyl [Legends]"}})


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
    DEF_BARRAGE = '44cf22'
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
    
    