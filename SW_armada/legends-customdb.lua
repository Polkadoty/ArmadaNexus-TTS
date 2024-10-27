CUSTOM_ASSETS = '{verifycache}https://raw.githubusercontent.com/spacenavy90/SNCustomTTS-IncludeDir/master/SW_armada/assets/'
LEGACY_ASSETS = '{verifycache}https://raw.githubusercontent.com/spacenavy90/ArmadaLegacyTTS-IncludeDir/master/assets/'
ARMADA_ASSETS = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
CARDS_LEGACY = 'https://raw.githubusercontent.com/eldrxdevelop/ArmadaLegacy/main/'

function onload()
    printToAll("Loading Armada Legends content...",{1,0.5,0})

-- republic faction
REPUBLIC_SHIP = {back = CUSTOM_ASSETS.."ships/republic/card_back.jpg",faction = "!Republic"}

    Ship:new(SmallShip,REPUBLIC_SHIP, {
        name = "Arquitens-class Command Cruiser",
        front = CARDS_LEGACY.."Wave I/Ships/arquitens-command-cruiser.png",
        mesh = LEGACY_ASSETS.."ships/republic/rep_arq/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/republic/rep_arq/reparq_command_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/republic/rep_arq/ruler.obj", 
        maneuver = {{"II"},{"-","II"},{"-","-","II"}},
        defense_tokens = {DEF_CONTAIN, DEF_SALVO, DEF_EVADE, DEF_REDIRECT},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 60,
        aliases = {"Arquitens Command Cruiser [OldLegacy]"},
        command = 2
    })

    Ship:new(SmallShip,REPUBLIC_SHIP, {
        name = "Arquitens-class Light Cruiser",
        front = CARDS_LEGACY.."Wave I/Ships/arquitens-light-cruiser.png",
        mesh = LEGACY_ASSETS.."ships/republic/rep_arq/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/republic/rep_arq/reparq_light_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/republic/rep_arq/ruler.obj", 
        maneuver = {{"II"},{"-","II"},{"-","-","II"}},
        defense_tokens = {DEF_CONTAIN, DEF_SALVO, DEF_EVADE, DEF_REDIRECT},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 58,
        aliases = {"Arquitens Light Cruiser [OldLegacy]"},
        command = 2
    })

    Ship:new(SmallShip,REPUBLIC_SHIP, {
        name = "IPV-2C Stealth Corvette",
        front = CARDS_LEGACY.."Wave II/Ships/ipv-2c-stealth-corvette.png",
        mesh = LEGACY_ASSETS.."ships/republic/ipv2/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/republic/ipv2/ipv2-stealth-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/republic/ipv2/ruler.obj", 
        maneuver = {{"II"},{"II","I"},{"II","I","II"},{"I","II","I","II"}},
        defense_tokens = {DEF_REDIRECT, DEF_EVADE, DEF_EVADE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 34,
        aliases = {"IPV-2C Stealth Corvette [OldLegacy]"},
        command = 1
    })

    Ship:new(SmallShip,REPUBLIC_SHIP, {
        name = "IPV-2C Support Corvette",
        front = CARDS_LEGACY.."Wave II/Ships/ipv-2c-support-corvette.png",
        mesh = LEGACY_ASSETS.."ships/republic/ipv2/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/republic/ipv2/ipv2-support-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/republic/ipv2/ruler.obj", 
        maneuver = {{"II"},{"II","I"},{"II","I","II"},{"I","II","I","II"}},
        defense_tokens = {DEF_REDIRECT, DEF_EVADE, DEF_EVADE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 34,
        aliases = {"IPV-2C Support Corvette [OldLegacy]"},
        command = 1
    })
    
    Ship:new(LargeShip,REPUBLIC_SHIP, {
        name = "Rothana I-class Destroyer",
        front = CUSTOM_ASSETS.."ships/republic/rothana/rothana_i.jpg",
        mesh = CUSTOM_ASSETS.."ships/republic/rothana/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/republic/rothana/rothana_diffuse.jpg",
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
        front = CUSTOM_ASSETS.."ships/republic/rothana/rothana_ii.jpg",
        mesh = CUSTOM_ASSETS.."ships/republic/rothana/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/republic/rothana/rothana_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/republic/rothana/ruler.obj", 
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
        shields = {5,4,4,3}, -- Front, left, right, rear
        cost = 130,
        command = 3,
        aliases = {"Rothana II-class Destroyer [Legends]"}
    })

REPUBLIC_SQUAD = {back = CUSTOM_ASSETS.."squadrons/republic/card_back.jpg",faction = "!Republic"}

    eta2 = {
        mesh = LEGACY_ASSETS.."squadrons/republic/eta2/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/republic/eta2/eta2_red_texture.jpg",
        health = 3,
        move = 5,
        defense_tokens = {}
    }
    Squadron:new(eta2, REPUBLIC_SQUAD, {
        name = "ETA-2 Actis Squadron",
        front = CARDS_LEGACY.."Wave I/Squadrons/eta-2-squadron.png",
        cost = 15,
        aliases = {"ETA-2 Actis Squadron [OldLegacy]", "ETA-2", "ETA2"}
    })
    Squadron:new(eta2, REPUBLIC_SQUAD, {
        name = "Anakin Skywalker (ETA-2)",
        front = CARDS_LEGACY.."Wave I/Squadrons/anakin-eta.png",
        diffuse = LEGACY_ASSETS.."squadrons/republic/eta2/eta2_anakin_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 24,
        aliases = {"Anakin Skywalker - ETA-2 Actis Squadron [OldLegacy]"}
    })
    Squadron:new(eta2, REPUBLIC_SQUAD, {
        name = "Obi-Wan Kenobi (ETA-2)",
        front = CARDS_LEGACY.."Wave I/Squadrons/obi-wan-squadron.png",
        diffuse = LEGACY_ASSETS.."squadrons/republic/eta2/eta2_obiwan_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 24,
        aliases = {"Obi-Wan Kenobi - ETA-2 Actis Squadron [OldLegacy]"}
    })
    Squadron:new(eta2, REPUBLIC_SQUAD, {
        name = "Aayla Secura (ETA-2)",
        front = CARDS_LEGACY.."Wave I/Squadrons/aayla-secura.png",
        diffuse = LEGACY_ASSETS.."squadrons/republic/eta2/eta2_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 23,
        aliases = {"Aayla Secura - ETA-2 Actis Squadron [OldLegacy]"}
    })
    Squadron:new(eta2, REPUBLIC_SQUAD, {
        name = "Shaak Ti (ETA-2)",
        front = CARDS_LEGACY.."Wave I/Squadrons/shaak-ti.png",
        diffuse = LEGACY_ASSETS.."squadrons/republic/eta2/eta2_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 22,
        aliases = {"Shaak Ti - ETA-2 Actis Squadron [OldLegacy]"}
    })

    clone_z95 = {
        mesh = LEGACY_ASSETS.."squadrons/republic/clone-z95/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/republic/clone-z95/cz95_red_texture.jpg",
        health = 4,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(clone_z95, REPUBLIC_SQUAD, {
        name = "Clone Z-95 Squadron",
        front = CARDS_LEGACY.."Wave I/Squadrons/clone-z-95-squadron.png",
        cost = 10,
        aliases = {"Clone Z-95 Squadron [OldLegacy]", "Clone Z-95"}
    })
    Squadron:new(clone_z95, REPUBLIC_SQUAD, {
        name = "Stub",
        front = CARDS_LEGACY.."Wave I/Squadrons/stub.png",
        diffuse = LEGACY_ASSETS.."squadrons/republic/clone-z95/cz95_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 15,
        aliases = {"Stub - Clone Z-95 Squadron [OldLegacy]"}
    })

    laat_i = {
        mesh = LEGACY_ASSETS.."squadrons/republic/laati/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/republic/laati/laati_red_texture.jpg",
        health = 6,
        move = 2,
        defense_tokens = {}
    }
    Squadron:new(laat_i, REPUBLIC_SQUAD, {
        name = "LAAT/i Gunship",
        front = CARDS_LEGACY.."Wave I/Squadrons/laat.png",
        cost = 17,
        aliases = {"LAAT/i Gunship [OldLegacy]", "LAAT/i"}
    })
    Squadron:new(laat_i, REPUBLIC_SQUAD, {
        name = "Hawk",
        front = CARDS_LEGACY.."Wave I/Squadrons/hawk.png",
        diffuse = LEGACY_ASSETS.."squadrons/republic/laati/laati_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 25,
        aliases = {"Hawk -LAAT/i Gunship [OldLegacy]"}
    })

    g9_rigger = {
        mesh = LEGACY_ASSETS.."squadrons/republic/g9-rigger/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/republic/g9-rigger/g9rigger_texture.jpg",
        health = 7,
        move = 2,
        defense_tokens = {}
    }
    Squadron:new(g9_rigger, REPUBLIC_SQUAD, {
        name = "G9 Rigger-class Freighter",
        front = CARDS_LEGACY.."Wave I/Squadrons/g-9-freighter.png",
        cost = 13,
        aliases = {"G9 Rigger-class Freighter [OldLegacy]"}
    })
    Squadron:new(g9_rigger, REPUBLIC_SQUAD, {
        name = "Anakin Skywalker (G9)",
        front = CARDS_LEGACY.."Wave I/Squadrons/Twilight.png",
        diffuse = LEGACY_ASSETS.."squadrons/republic/g9-rigger/g9rigger_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE},
        cost = 27,
        aliases = {"Anakin Skywalker - G9 Rigger-class Freighter [OldLegacy]"}
    })

-- separatist faction
SEPARATIST_SHIP = {back = CUSTOM_ASSETS.."ships/separatist/card_back.jpg",faction = "!Separatist"}

    Ship:new(SmallShip,SEPARATIST_SHIP, {
        name = "Trident-class Assault Ships",
        front = CARDS_LEGACY.."Wave I/Ships/trident-assault-ships.png",
        mesh = LEGACY_ASSETS.."ships/separatist/trident/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/separatist/trident/trident_a_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/separatist/trident/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_SCATTER, DEF_EVADE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 30,
        aliases = {"Trident Assault Ships [OldLegacy]"},
        command = 1
        })

    Ship:new(SmallShip,SEPARATIST_SHIP, {
        name = "Trident-class Assault Carriers",
        front = CARDS_LEGACY.."Wave I/Ships/trident-assault-carriers.png",
        mesh = LEGACY_ASSETS.."ships/separatist/trident/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/separatist/trident/trident_c_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/separatist/trident/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_SCATTER, DEF_EVADE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 32,
        aliases = {"Trident Assault Carriers [OldLegacy]"},
        command = 1
        })

    Ship:new(LargeShip,SEPARATIST_SHIP, {
        name = "Lucrehulk-class Battleship",
        front = CARDS_LEGACY.."Wave II/Ships/lucrehulk-battleship.png",
        mesh = LEGACY_ASSETS.."ships/separatist/lucrehulk/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/separatist/lucrehulk/lucrehulk-bs-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/separatist/lucrehulk/ruler.obj", 
        maneuver = {{"-"},{"I","-"}},
        defense_tokens = {DEF_REDIRECT, DEF_CONTAIN, DEF_BRACE, DEF_BRACE},
        shields = {5,5,5,3}, -- Front, left, right, rear
        cost = 144,
        aliases = {"Lucrehulk Battleship [OldLegacy]"},
        command = 4
        })

    Ship:new(LargeShip,SEPARATIST_SHIP, {
        name = "Lucrehulk-class Droid Control Ship",
        front = CARDS_LEGACY.."Wave II/Ships/lucrehulk-droid-control-ship.png",
        mesh = LEGACY_ASSETS.."ships/separatist/lucrehulk/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/separatist/lucrehulk/lucrehulk-dcs-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/separatist/lucrehulk/ruler.obj", 
        maneuver = {{"-"},{"I","-"}},
        defense_tokens = {DEF_REDIRECT, DEF_CONTAIN, DEF_BRACE, DEF_BRACE},
        shields = {5,5,5,3}, -- Front, left, right, rear
        cost = 136,
        aliases = {"Lucrehulk Droid Control [OldLegacy]"},
        command = 4
        })

    Ship:new(MediumShip,SEPARATIST_SHIP, {
        name = "Sabaoth-class Destroyer",
        front = CUSTOM_ASSETS.."ships/separatist/sabaoth/sabaoth_dest_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/separatist/sabaoth/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/sabaoth/diffuse_dest_sabaoth.jpg",
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
        front = CUSTOM_ASSETS.."ships/separatist/sabaoth/sabaoth_carrier_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/separatist/sabaoth/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/sabaoth/diffuse_carrier_sabaoth.jpg",
        ruler = CUSTOM_ASSETS.."ships/separatist/sabaoth/ruler.obj", 
        maneuver = {{"I"},{"I","II"},{"-","I","I"}},
        defense_tokens = {DEF_SALVO,DEF_CONTAIN,DEF_BRACE,DEF_CONTAIN},
        shields = {4,3,3,2}, -- Front, left, right, rear
        cost = 70,
        command = 2,
        aliases = {"Sabaoth-class Light Carrier [Legends]"}
    })

    Ship:new(ShortHugeShip,SEPARATIST_SHIP, {
        name = "Subjugator-class Prototype",
        front = CUSTOM_ASSETS.."ships/separatist/subjugator/Subjugator_prototype.jpg",
        mesh = CUSTOM_ASSETS.."ships/separatist/subjugator/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/subjugator/diffuse_proto.jpg",
        ruler = CUSTOM_ASSETS.."ships/separatist/subjugator/ruler.obj", 
        maneuver = {{"I"},{"-","I"}},
        defense_tokens = {DEF_BRACE, DEF_BRACE, DEF_REDIRECT, DEF_CONTAIN, DEF_SALVO},
        shields = {4,3,3,1,4,4}, --Front, back-left, back-right, rear, front-left, front-right
        cost = 240,
        aliases = {"Subjugator-class Prototype [Legends]"},
        command = 4
        })

    Ship:new(ShortHugeShip,SEPARATIST_SHIP, {
        name = "Subjugator-class Heavy Cruiser",
        front = CUSTOM_ASSETS.."ships/separatist/subjugator/Subjugator_Heavy_cruiser.jpg",
        mesh = CUSTOM_ASSETS.."ships/separatist/subjugator/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/subjugator/diffuse_heavy.jpg",
        ruler = CUSTOM_ASSETS.."ships/separatist/subjugator/ion_ruler.obj", 
        maneuver = {{"I"},{"-","I"}},
        defense_tokens = {DEF_BRACE, DEF_BRACE, DEF_REDIRECT, DEF_CONTAIN, DEF_SALVO},
        shields = {4,3,3,1,4,4}, --Front, back-left, back-right, rear, front-left, front-right
        cost = 225,
        aliases = {"Subjugator-class Heavy Cruiser [Legends]"},
        command = 4
        })

    Ship:new(ShortHugeShip,SEPARATIST_SHIP, {
        name = "Subjugator-class Testbed",
        front = CUSTOM_ASSETS.."ships/separatist/subjugator/Subjugator_testbed.jpg",
        mesh = CUSTOM_ASSETS.."ships/separatist/subjugator/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/separatist/subjugator/diffuse_testbed.jpg",
        ruler = CUSTOM_ASSETS.."ships/separatist/subjugator/beam_ruler.obj", 
        maneuver = {{"I"},{"-","I"}},
        defense_tokens = {DEF_BRACE, DEF_BRACE, DEF_REDIRECT, DEF_CONTAIN, DEF_SALVO},
        shields = {4,3,3,1,4,4}, --Front, back-left, back-right, rear, front-left, front-right
        cost = 225,
        aliases = {"Subjugator-class Testbed [Legends]"},
        command = 4
        })

SEPARATIST_SQUAD = {back = CUSTOM_ASSETS.."squadrons/separatist/card_back.jpg",faction = "!Separatist"}

    nantex = {
        mesh = LEGACY_ASSETS.."squadrons/separatist/nantex/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/nantex/nantex_texture.jpg",
        health = 4,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(nantex, SEPARATIST_SQUAD, {
        name = "Nantex Starfighter Squadron",
        front = CARDS_LEGACY.."Wave I/Squadrons/nantex-squadron.png",
        cost = 11,
        aliases = {"Nantex Starfighter Squadron [OldLegacy]"}
    })
    Squadron:new(nantex, SEPARATIST_SQUAD, {
        name = "Sun Fac",
        front = CARDS_LEGACY.."Wave I/Squadrons/sun-fac.png",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/nantex/nantex_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 19,
        aliases = {"Sun Fac - Nantex Starfighter Squadron [OldLegacy]"}
    })
    Squadron:new(nantex, SEPARATIST_SQUAD, {
        name = "Gorgol",
        front = CARDS_LEGACY.."Wave I/Squadrons/gorgol.png",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/nantex/nantex_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 16,
        aliases = {"Gorgol - Nantex Starfighter Squadron [OldLegacy]"}
    })

    hmp_gunship = {
        mesh = LEGACY_ASSETS.."squadrons/separatist/hmp/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/hmp/hmp_texture.jpg",
        health = 5,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(hmp_gunship, SEPARATIST_SQUAD, {
        name = "HMP Droid Gunship",
        front = CARDS_LEGACY.."Wave I/Squadrons/hmp-gunship.png",
        cost = 16,
        aliases = {"HMP Droid Gunship [OldLegacy]"}
    })
    Squadron:new(hmp_gunship, SEPARATIST_SQUAD, {
        name = "Geonosian Prototype",
        front = CARDS_LEGACY.."Wave I/Squadrons/geonosian-prototype.png",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/hmp/hmp_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 22,
        aliases = {"Geonosian Prototype - HMP Droid Gunship [OldLegacy]"}
    })
    Squadron:new(hmp_gunship, SEPARATIST_SQUAD, {
        name = "DGS-047",
        front = CARDS_LEGACY.."Wave I/Squadrons/dgs-047.png",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/hmp/hmp_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 24,
        aliases = {"DGS-047 - HMP Droid Gunship [OldLegacy]"}
    })

    sith_infil = {
        mesh = LEGACY_ASSETS.."squadrons/separatist/sith-infil/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/sith-infil/sithinfil_texture.jpg",
        health = 6,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(sith_infil, SEPARATIST_SQUAD, {
        name = "Sith Infiltrator",
        front = CARDS_LEGACY.."Wave I/Squadrons/sith-infiltrator.png",
        cost = 17,
        aliases = {"Sith Infiltrator [OldLegacy]"}
    })
    Squadron:new(sith_infil, SEPARATIST_SQUAD, {
        name = "Count Dooku",
        front = CARDS_LEGACY.."Wave I/Squadrons/count-dooku-squadron.png",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/sith-infil/sithinfil_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 25,
        aliases = {"Count Dooku - Sith Infiltrator [OldLegacy]"}
    })

    rogue_fighter = {
        mesh = LEGACY_ASSETS.."squadrons/separatist/rogue/plain_mesh.obj",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/rogue/rogue_texture.jpg",
        health = 5,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(rogue_fighter, SEPARATIST_SQUAD, {
        name = "Rogue Starfighter Squadron",
        front = CARDS_LEGACY.."Wave I/Squadrons/rogue-starfighter-squadron.png",
        cost = 15,
        aliases = {"Rogue Starfighter Squadron [OldLegacy]"}
    })
    Squadron:new(rogue_fighter, SEPARATIST_SQUAD, {
        name = "Magnaguard Protectors",
        front = CARDS_LEGACY.."Wave I/Squadrons/magnaguard-protectors.png",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/rogue/rogue_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 21,
        aliases = {"Magnaguard Protectors - Rogue Starfighter Squadron [OldLegacy]"}
    })
    Squadron:new(rogue_fighter, SEPARATIST_SQUAD, {
        name = "Cad Bane",
        front = CARDS_LEGACY.."Wave I/Squadrons/cad-bane.png",
        diffuse = LEGACY_ASSETS.."squadrons/separatist/rogue/rogue_ace_texture.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 22,
        aliases = {"Cad Bane - Rogue Starfighter Squadron [OldLegacy]"}
    })

-- empire faction
EMPIRE_SHIP = {back = CUSTOM_ASSETS.."ships/empire/card_back.jpg",faction = "!Empire"}

    Ship:new(MediumShip,EMPIRE_SHIP, {
        name = "Dreadnaught-class Imperial Refit",
        front = CARDS_LEGACY.."Wave I/Ships/dreadnaught-imperial-refit.png",
        mesh = LEGACY_ASSETS.."ships/empire/dread/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/empire/dread/dread_imp_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/empire/dread/ruler.obj", 
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_BRACE, DEF_BRACE},
        shields = {3,3,3,1}, -- Front, left, right, rear
        cost = 64,
        aliases = {"Dreadnaught Imperial Refit [OldLegacy]"},
        command = 3
        })

    Ship:new(MediumShip,EMPIRE_SHIP, {
        name = "Dreadnaught-class Katana Refit",
        front = CARDS_LEGACY.."Wave I/Ships/dreadnaught-katana-refit.png",
        mesh = LEGACY_ASSETS.."ships/empire/dread/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/empire/dread/dread_katana_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/empire/dread/ruler.obj", 
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_BRACE, DEF_BRACE},
        shields = {3,3,3,1}, -- Front, left, right, rear
        cost = 62,
        aliases = {"Dreadnaught Katana Refit [OldLegacy]"},
        command = 3
        })

    Ship:new(LargeShip,EMPIRE_SHIP, {
        name = "Interdictor-class Star Destroyer",
        front = CARDS_LEGACY.."Wave II/Ships/interdictor-star-destroyer.png",
        mesh = LEGACY_ASSETS.."ships/empire/interdictor-sd/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/empire/interdictor-sd/interdictorsd-sd-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/empire/interdictor-sd/ruler.obj",
        maneuver = {{"I"},{"I","I"},{"I","-","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_CONTAIN, DEF_BRACE, DEF_REDIRECT},
        shields = {4,3,3,2}, -- Front, left, right, rear
        cost = 110,
        aliases = {"Interdictor Star Destroyer [OldLegacy]"},
        command = 3
        })

    Ship:new(LargeShip,EMPIRE_SHIP, {
        name = "Interdictor-class Prototype",
        front = CARDS_LEGACY.."Wave II/Ships/interdictor-prototype.png",
        mesh = LEGACY_ASSETS.."ships/empire/interdictor-sd/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/empire/interdictor-sd/interdictorsd-proto-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/empire/interdictor-sd/ruler.obj",
        maneuver = {{"I"},{"I","I"},{"I","-","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_CONTAIN, DEF_BRACE, DEF_REDIRECT},
        shields = {4,3,3,2}, -- Front, left, right, rear
        cost = 100,
        aliases = {"Interdictor Prototype [OldLegacy]"},
        command = 3
        })

    --UpdateCard("Interdictor Combat Refit",93,{front = CARDS_LEGACY.."ships/empire/interdictor/interdictor-combat-refit_rebalance.png",aliases = {"Interdictor Combat Refit [OldLegacy]"},cost = 88})
    --UpdateCard("Victory II-class Star Destroyer",85,{cost = 80,aliases={"Victory II Star Destroyer [OldLegacy]"}})

EMPIRE_SQUAD = {back = CUSTOM_ASSETS.."squadrons/empire/card_back.jpg",faction = "!Empire"}

    TIE_ADV = GetDefinition("TIE Advanced Squadron",12)
    TIE_FIG = GetDefinition("TIE Fighter Squadron",8)
    TIE_BOM = GetDefinition("TIE Bomber Squadron",9)
    TIE_INT = GetDefinition("TIE Interceptor Squadron",11)

    Squadron:new(TIE_ADV, EMPIRE_SQUAD, {
        name = "Maarek Stele (TIE/x1)",
        front = CARDS_LEGACY.."Wave I/Squadrons/Maarek Stele Advanced.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/empire/adv/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 18,
        aliases = {"Maarek Stele - TIE Advanced Squadron [OldLegacy]"}
    })

    Squadron:new(TIE_FIG, EMPIRE_SQUAD, {
        name = "Iden Versio",
        front = CARDS_LEGACY.."Wave I/Squadrons/Iden Version Squadron.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/empire/tie/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 17,
        aliases = {"Iden Versio - TIE Fighter Squadron [OldLegacy]"}
    })

    Squadron:new(TIE_BOM, EMPIRE_SQUAD, {
        name = "Tomax Bren",
        front = CARDS_LEGACY.."Wave I/Squadrons/Tomax Bren.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/empire/bom/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 16,
        aliases = {"Tomax Bren - TIE Bomber Squadron [OldLegacy]"}
    })

    Squadron:new(TIE_INT, EMPIRE_SQUAD, {
        name = "Turr Phennir",
        front = CARDS_LEGACY.."Wave I/Squadrons/Turr Phennir.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/empire/int/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 18,
        aliases = {"Turr Phennir - TIE Interceptor Squadron [OldLegacy]"}
    })

    --UpdateCard("Mandalorian Gauntlet Fighter",20,{cost = 18,aliases={"Mandalorian Gauntlet Fighter [OldLegacy]"}})

    --cx dagger
    cx_dagger = {
        mesh = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/diffuse_cx.jpg",
        health = 5,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(cx_dagger, EMPIRE_SQUAD, {
        name = "CX Dagger Vessel",
        front = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/cx_card.jpg",
        cost = 15,
        aliases = {"CX Dagger Vessel [Legends]"}
    })
    Squadron:new(cx_dagger, EMPIRE_SQUAD, {
        name = "CX-2",
        front = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/cx2_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/empire/cx_dagger/diffuse_ace_cx.jpg", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 24,
        aliases = {"CX-2 - CX Dagger Vessel [Legends]"}
    })

-- rebel faction
REBEL_SHIP = {back = CUSTOM_ASSETS.."ships/rebel/card_back.jpg",faction = "!Rebellion" }

    Ship:new(MediumShip,REBEL_SHIP, {
        name = "Assault Frigate Mark I A",
        front = CARDS_LEGACY.."Wave I/Ships/assault-frigate-mki-a.png",
        mesh = LEGACY_ASSETS.."ships/rebel/afm1/afm1a_mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/rebel/afm1/afm1_a_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/rebel/afm1/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"I","I","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_SALVO, DEF_EVADE, DEF_BRACE},
        shields = {3,3,3,2}, -- Front, left, right, rear
        cost = 72,
        aliases = {"Assault Frigate Mark I A [OldLegacy]", "Assault Frig. Mk.I A [OldLegacy]"},
        command = 2
        })

    Ship:new(MediumShip,REBEL_SHIP, {
        name = "Assault Frigate Mark I B",
        front = CARDS_LEGACY.."Wave I/Ships/assault-frigate-mki-b.png",
        mesh = LEGACY_ASSETS.."ships/rebel/afm1/afm1b_mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/rebel/afm1/afm1_b_texture.jpg",
        ruler = LEGACY_ASSETS.."ships/rebel/afm1/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"I","I","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_SALVO, DEF_EVADE, DEF_BRACE},
        shields = {3,3,3,2}, -- Front, left, right, rear
        cost = 68,
        aliases = {"Assault Frigate Mark I B [OldLegacy]", "Assault Frig. Mk.I B [OldLegacy]"},
        command = 2
        })

    Ship:new(LargeShip,REBEL_SHIP, {
        name = "MC80B Command Cruiser",
        front = CARDS_LEGACY.."Wave II/Ships/mc80b-command-cruiser.png",
        mesh = LEGACY_ASSETS.."ships/rebel/mc80b/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/rebel/mc80b/mc80b-command-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/rebel/mc80b/ruler.obj",
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_CONTAIN, DEF_BRACE, DEF_REDIRECT},
        shields = {4,4,4,3}, -- Front, left, right, rear
        cost = 110,
        aliases = {"MC80B Command Cruiser [OldLegacy]", "Command Cruiser [OldLegacy]"},
        command = 3
        })

    Ship:new(LargeShip,REBEL_SHIP, {
        name = "MC80B Heavy Cruiser",
        front = CARDS_LEGACY.."Wave II/Ships/mc80b-heavy-cruiser.png",
        mesh = LEGACY_ASSETS.."ships/rebel/mc80b/mesh.obj",
        diffuse = LEGACY_ASSETS.."ships/rebel/mc80b/mc80b-heavy-texture.jpg",
        ruler = LEGACY_ASSETS.."ships/rebel/mc80b/ruler.obj",
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_REDIRECT, DEF_CONTAIN, DEF_BRACE, DEF_REDIRECT},
        shields = {4,4,4,3}, -- Front, left, right, rear
        cost = 114,
        aliases = {"MC80B Heavy Cruiser [OldLegacy]", "Heavy Cruiser [OldLegacy]"},
        command = 3
        })

    Ship:new(MediumShip,REBEL_SHIP,{
        name = "Quasar Fire II-class Cruiser-Carrier (Rebel)",
        front =     CUSTOM_ASSETS.."ships/rebel/reb_quasar/Rebel_QuasarII.jpg",
        mesh =      ARMADA_ASSETS.."ships/empire/quasar/mesh.obj",
        diffuse =   CUSTOM_ASSETS.."ships/rebel/reb_quasar/rebel_II_diffuse.jpg",
        ruler =     ARMADA_ASSETS.."ships/rebel/reb_quasar/ruler.obj",
        maneuver = {{"II"},{"I","I"},{"-","I","I"}},
        defense_tokens = {DEF_BRACE,DEF_REDIRECT},
        shields = {2,2,2,1},
        cost = 64,
        aliases = {"Rebel Quasar"},
        command = 2
    })

    --UpdateCard("Assault Frigate Mark II A",81,{cost = 78,aliases={"Assault Frig. Mk.II A [OldLegacy]"}})


REBEL_SQUAD = {back = CUSTOM_ASSETS.."squadrons/rebel/card_back.jpg",faction = "!Rebellion" }

    awing = GetDefinition("A-wing Squadron",11)
    bwing = GetDefinition("B-wing Squadron",14)
    xwing = GetDefinition("X-wing Squadron",13)
    ywing = GetDefinition("Y-wing Squadron",10)

    Squadron:new(awing, REBEL_SQUAD, {
        name = "Arvel Crynyo",
        front = CARDS_LEGACY.."Wave I/Squadrons/Arvel Crynyd.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/rebel/awing/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_SCATTER},
        cost = 16,
        aliases = {"Arvel Crynyo - A-wing Squadron [OldLegacy]"}
    })

    Squadron:new(bwing, REBEL_SQUAD, {
        name = "Braylen Stramm",
        front = CARDS_LEGACY.."Wave I/Squadrons/Braylen Stramm.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/rebel/bwing/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 19,
        aliases = {"Braylen Stramm - B-wing Squadron [OldLegacy]"}
    })

    Squadron:new(xwing, REBEL_SQUAD, {
        name = "Corran Horn (X-Wing)",
        front = CARDS_LEGACY.."Wave I/Squadrons/Corran Horn X-wing.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/rebel/xwing/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 20,
        aliases = {"Corran Horn - X-wing Squadron [OldLegacy]"}
    })

    Squadron:new(ywing, REBEL_SQUAD, {
        name = "Horton Salm",
        front = CARDS_LEGACY.."Wave I/Squadrons/Horton Salm.png",
        --mesh = LEGACY_ASSETS..".obj",
        diffuse = LEGACY_ASSETS.."squadrons/rebel/ywing/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 18,
        aliases = {"Horton Salm - Y-wing Squadron [OldLegacy]"}
    })

-- colonial faction
COL_SHIP = {back = CUSTOM_ASSETS.."ships/colonial/card_back.jpg",faction = "Colonial"}
    
        -- mercury battlestar
    Ship:new(LargeShip,COL_SHIP, {
        name = "Mercury-class Battlestar MkI",
        front = CUSTOM_ASSETS.."ships/colonial/mercury/mk1_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/mercury/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/mercury/mk1_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"I"},{"I","-"},{"I","-","I"}},
        defense_tokens = {DEF_SALVO,DEF_BARRAGE,DEF_BRACE,DEF_BARRAGE},
        shields = {3,4,4,2}, -- Front, left, right, rear
        cost = 140,
        command = 4,
        aliases = {"Mercury Battlestar MkI [Legends]"}
    })
    Ship:new(LargeShip,COL_SHIP, {
        name = "Mercury-class Battlestar MkII",
        front = CUSTOM_ASSETS.."ships/colonial/mercury/mk2_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/mercury/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/mercury/mk2_diffuse.jpg",
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
        name = "Jupiter-class Battlestar MkI",
        front = CUSTOM_ASSETS.."ships/colonial/jupiter/mk1_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/jupiter/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/jupiter/mk1_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"I"},{"I","I"},{"-","-","I"}},
        defense_tokens = {DEF_BRACE,DEF_BRACE,DEF_CONTAIN,DEF_SALVO},
        shields = {3,4,4,2}, -- Front, left, right, rear
        cost = 112,
        command = 3,
        aliases = {"Jupiter-class Battlestar MkI [Legends]"}
    })
    Ship:new(LargeShip,COL_SHIP, {
        name = "Jupiter-class Battlestar MkII",
        front = CUSTOM_ASSETS.."ships/colonial/jupiter/mk2_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/jupiter/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/jupiter/mk2_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/mercury/ruler.obj", 
        maneuver = {{"I"},{"I","I"},{"-","-","I"}},
        defense_tokens = {DEF_BRACE,DEF_BRACE,DEF_CONTAIN,DEF_SALVO},
        shields = {3,4,4,2}, -- Front, left, right, rear
        cost = 124,
        command = 3,
        aliases = {"Jupiter-class Battlestar MkII [Legends]"}
    })

        --manticore corvette
    Ship:new(SmallShip,COL_SHIP, {
        name = "Manticore-class Attack Corvette",
        front = CUSTOM_ASSETS.."ships/colonial/manticore/manticore_attack_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/manticore/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/manticore/manticore_attack_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/manticore/ruler.obj", 
        maneuver = {{"II"},{"I","II"},{"I","-","-"}},
        defense_tokens = {DEF_EVADE,DEF_EVADE,DEF_CONTAIN},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 44,
        command = 1,
        aliases = {"Manticore-class Attack Corvette [Legends]"}
    })
    Ship:new(SmallShip,COL_SHIP, {
        name = "Manticore-class Patrol Corvette",
        front = CUSTOM_ASSETS.."ships/colonial/manticore/manticore_patrol_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/manticore/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/manticore/manticore_patrol_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/manticore/ruler.obj", 
        maneuver = {{"II"},{"I","II"},{"I","-","-"}},
        defense_tokens = {DEF_EVADE,DEF_EVADE,DEF_CONTAIN},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 42,
        command = 1,
        aliases = {"Manticore-class Patrol Corvette [Legends]"}
    })

        --adamant carrier-cruiser
    Ship:new(MediumShip,COL_SHIP, {
        name = "Adamant-class Light Carrier",
        front = CUSTOM_ASSETS.."ships/colonial/adamant/adamant_carrier_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/adamant/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/adamant/adamant_carrier_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/adamant/ruler.obj", 
        maneuver = {{"I"},{"I","-"},{"-","I","-"}},
        defense_tokens = {DEF_BRACE,DEF_CONTAIN,DEF_SALVO},
        shields = {1,3,3,1}, -- Front, left, right, rear
        cost = 62,
        command = 3,
        aliases = {"Adamant-class Light Carrier [Legends]"}
    })
    Ship:new(MediumShip,COL_SHIP, {
        name = "Adamant-class Light Frigate",
        front = CUSTOM_ASSETS.."ships/colonial/adamant/adamant_frigate_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/adamant/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/adamant/adamant_frigate_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/adamant/ruler.obj", 
        maneuver = {{"I"},{"I","-"},{"-","I","-"}},
        defense_tokens = {DEF_BRACE,DEF_CONTAIN,DEF_SALVO},
        shields = {1,3,3,1}, -- Front, left, right, rear
        cost = 68,
        command = 3,
        aliases = {"Adamant-class Light Frigate [Legends]"}
    })

        --minotaur heavy cruiser
    Ship:new(MediumShip,COL_SHIP, {
        name = "Minotaur-class Heavy Assault Cruiser",
        front = CUSTOM_ASSETS.."ships/colonial/minotaur/minotaur_assault_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/minotaur/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/minotaur/minotaur_assault_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/minotaur/ruler.obj", 
        maneuver = {{"I"},{"I","I"},{"-","-","I"}},
        defense_tokens = {DEF_BRACE,DEF_CONTAIN,DEF_SALVO},
        shields = {2,3,3,2}, -- Front, left, right, rear
        cost = 90,
        command = 3,
        aliases = {"Minotaur-class Heavy Assault Cruiser [Legends]"}
    })
    Ship:new(MediumShip,COL_SHIP, {
        name = "Minotaur-class Heavy Command Cruiser",
        front = CUSTOM_ASSETS.."ships/colonial/minotaur/minotaur_command_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/minotaur/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/minotaur/minotaur_command_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/minotaur/ruler.obj", 
        maneuver = {{"I"},{"I","I"},{"-","-","I"}},
        defense_tokens = {DEF_BRACE,DEF_CONTAIN,DEF_SALVO},
        shields = {2,3,3,2}, -- Front, left, right, rear
        cost = 80,
        command = 3,
        aliases = {"Minotaur-class Heavy Command Cruiser [Legends]"}
    })

        -- orion frigate
    Ship:new(SmallShip,COL_SHIP, {
        name = "Orion-class Stealth Battlestar",
        front = CUSTOM_ASSETS.."ships/colonial/orion/stealth_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/orion/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/orion/stealth_diffuse.jpg",
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
        front = CUSTOM_ASSETS.."ships/colonial/orion/pocket_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/colonial/orion/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/colonial/orion/pocket_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/colonial/orion/ruler.obj", 
        maneuver = {{"II"},{"II","I"},{"II","I","I"},{"I","I","I","I"}},
        defense_tokens = {DEF_BARRAGE,DEF_EVADE,DEF_EVADE},
        shields = {2,2,2,1}, -- Front, left, right, rear
        cost = 57,
        command = 2,
        aliases = {"Orion-class Pocket Battlestar [Legends]"}
    })
    
COL_SQUAD = {back = CUSTOM_ASSETS.."ships/colonial/card_back.jpg",faction = "Colonial"}

    --viper mk2
    viper_mk2 = {
        mesh = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/diffuse_mk2.jpg",
        health = 3,
        move = 5,
        defense_tokens = {}
    }
    Squadron:new(viper_mk2, COL_SQUAD, {
        name = "Viper MkII Squadron",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/vipermk2_card.jpg",
        cost = 11,
        aliases = {"Viper MkII Squadron [Legends]"}
    })
    Squadron:new(viper_mk2, COL_SQUAD, {
        name = "Kara \"Starbuck\" Thrace",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/kara_vipermk2_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/diffuse_ace_mk2.jpg", 
        defense_tokens = {DEF_SCATTER,DEF_EVADE},
        cost = 22,
        aliases = {"Kara \"Starbuck\" Thrace - Viper MkII Squadron [Legends]"}
    })
    Squadron:new(viper_mk2, COL_SQUAD, {
        name = "\"Hotdog\"",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/hotdog_vipermk2_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk2/diffuse_ace_mk2.jpg", 
        defense_tokens = {DEF_SCATTER,DEF_EVADE},
        cost = 20,
        aliases = {"\"Hotdog\" - Viper MkII Squadron [Legends]"}
    })

    --viper mk7
    viper_mk7 = {
        mesh = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/diffuse_mk7.jpg",
        health = 4,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(viper_mk7, COL_SQUAD, {
        name = "Viper MkVII Squadron",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/vipermk7_card.jpg",
        cost = 13,
        aliases = {"Viper MkVII Squadron [Legends]"}
    })
    Squadron:new(viper_mk7, COL_SQUAD, {
        name = "Lee \"Apollo\" Adama",
        front = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/vipermk7_apollo.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/viper_mk7/diffuse_ace_mk7.jpg", 
        defense_tokens = {DEF_SCATTER,DEF_BRACE},
        cost = 22,
        aliases = {"Lee Adama - Viper MkVII Squadron [Legends]"}
    })

    --raptor
    raptor = {
        mesh = CUSTOM_ASSETS.."squadrons/colonial/raptor/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/raptor/diffuse_raptor.jpg",
        health = 4,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(raptor, COL_SQUAD, {
        name = "Raptor Squadron",
        front = CUSTOM_ASSETS.."squadrons/colonial/raptor/raptor_squadron_card.jpg",
        cost = 15,
        aliases = {"Raptor Squadron [Legends]"}
    })
    Squadron:new(raptor, COL_SQUAD, {
        name = "Sharon \"Athena\" Valeri",
        front = CUSTOM_ASSETS.."squadrons/colonial/raptor/athena_raptor_squadron_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/raptor/diffuse_ace_raptor.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 20,
        aliases = {"Athena - Raptor Squadron [Legends]"}
    })

    --assault raptor
    ass_raptor = {
        mesh = CUSTOM_ASSETS.."squadrons/colonial/ass_raptor/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/ass_raptor/diffuse_ass_raptor.jpg",
        health = 4,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(ass_raptor, COL_SQUAD, {
        name = "Assault Raptor Squadron",
        front = CUSTOM_ASSETS.."squadrons/colonial/ass_raptor/ass_raptor_squadron_card.jpg",
        cost = 14,
        aliases = {"Assault Raptor Squadron [Legends]"}
    })
    Squadron:new(ass_raptor, COL_SQUAD, {
        name = "\"Racetrack\"",
        front = CUSTOM_ASSETS.."squadrons/colonial/ass_raptor/racetrack_ass_raptor_squadron_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/colonial/ass_raptor/diffuse_ace_ass_raptor.jpg", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 23,
        aliases = {"Racetrack - Assault Raptor Squadron [Legends]"}
    })


-- cylon faction
CYL_SHIP = {back = CUSTOM_ASSETS.."ships/cylon/card_back.jpg",faction = "Cylon"}

        -- cylon war basestar
    Ship:new(LargeShip,CYL_SHIP, {
        name = "War Basestar Mk.1",
        front = CUSTOM_ASSETS.."ships/cylon/basestar_war/basestar_mk1_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/basestar_war/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/basestar_war/basestar_mk1_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/basestar_war/ruler.obj", 
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_BRACE,DEF_CONTAIN,DEF_CONTAIN,DEF_SALVO},
        shields = {3,3,3,3}, -- Front, left, right, rear
        cost = 110,
        command = 3,
        aliases = {"War Basestar Mk.1 [Legends]"}
    })
    Ship:new(LargeShip,CYL_SHIP, {
        name = "War Basestar MkII",
        front = CUSTOM_ASSETS.."ships/cylon/basestar_war/basestar_mk2_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/basestar_war/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/basestar_war/basestar_mk2_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/basestar_war/ruler.obj", 
        maneuver = {{"I"},{"I","I"}},
        defense_tokens = {DEF_BRACE,DEF_CONTAIN,DEF_CONTAIN,DEF_SALVO},
        shields = {3,3,3,3}, -- Front, left, right, rear
        cost = 97,
        command = 3,
        aliases = {"War Basestar MkII [Legends]"}
    })

        -- arachne cruiser
    Ship:new(MediumShip,CYL_SHIP, {
        name = "Arachne Missile Cruiser",
        front = CUSTOM_ASSETS.."ships/cylon/arachne/arachne_missile_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/arachne/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/arachne/arachne_missile_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/arachne/ruler.obj", 
        maneuver = {{"I"},{"I","I"},{"I","II","-"}},
        defense_tokens = {DEF_BRACE,DEF_EVADE,DEF_SALVO},
        shields = {3,3,3,1}, -- Front, left, right, rear
        cost = 79,
        command = 3,
        aliases = {"Arachne Missile Cruiser [Legends]"}
    })
    Ship:new(MediumShip,CYL_SHIP, {
        name = "Arachne Carrier Cruiser",
        front = CUSTOM_ASSETS.."ships/cylon/arachne/arachne_carrier_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/arachne/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/arachne/arachne_carrier_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/arachne/ruler.obj", 
        maneuver = {{"I"},{"I","I"},{"I","II","-"}},
        defense_tokens = {DEF_BRACE,DEF_EVADE,DEF_SALVO},
        shields = {3,3,3,1}, -- Front, left, right, rear
        cost = 73,
        command = 3,
        aliases = {"Arachne Carrier Cruiser [Legends]"}
    })

        -- talon frigate
    Ship:new(MediumShip,CYL_SHIP, {
        name = "Talon Light Frigate",
        front = CUSTOM_ASSETS.."ships/cylon/talon/talon_frigate_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/talon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/talon/talon_frigate_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/talon/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","I","I"}},
        defense_tokens = {DEF_BRACE,DEF_EVADE,DEF_CONTAIN},
        shields = {1,3,3,1}, -- Front, left, right, rear
        cost = 56,
        command = 2,
        aliases = {"Talon Light Frigate [Legends]"}
    })
    Ship:new(MediumShip,CYL_SHIP, {
        name = "Talon Light Carrier",
        front = CUSTOM_ASSETS.."ships/cylon/talon/talon_carrier_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/talon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/talon/talon_carrier_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/talon/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","I","I"}},
        defense_tokens = {DEF_BRACE,DEF_EVADE,DEF_CONTAIN},
        shields = {1,3,3,1}, -- Front, left, right, rear
        cost = 64,
        command = 2,
        aliases = {"Talon Light Carrier [Legends]"}
    })

        -- nemesis corvette
    Ship:new(SmallShip,CYL_SHIP, {
        name = "Nemesis Attack Corvette",
        front = CUSTOM_ASSETS.."ships/cylon/nemesis/nemesis_attack_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/nemesis/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/nemesis/nemesis_attack_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/nemesis/ruler.obj", 
        maneuver = {{"II"},{"II","-"},{"I","I","I"},{"I","I","-","I"}},
        defense_tokens = {DEF_EVADE,DEF_EVADE,DEF_CONTAIN},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 42,
        command = 1,
        aliases = {"Nemesis Attack Corvette [Legends]"}
    })
    Ship:new(SmallShip,CYL_SHIP, {
        name = "Nemesis Tech Corvette",
        front = CUSTOM_ASSETS.."ships/cylon/nemesis/nemesis_tech_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/nemesis/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/nemesis/nemesis_tech_diffuse.jpg",
        ruler = CUSTOM_ASSETS.."ships/cylon/nemesis/ruler.obj", 
        maneuver = {{"II"},{"II","-"},{"I","I","I"},{"I","I","-","I"}},
        defense_tokens = {DEF_EVADE,DEF_EVADE,DEF_CONTAIN},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 40,
        command = 1,
        aliases = {"Nemesis Tech Corvette [Legends]"}
    })

        -- cylon modern basestar
    Ship:new(LargeShip,CYL_SHIP, {
        name = "Basestar Mk2 Assault Refit",
        front = CUSTOM_ASSETS.."ships/cylon/basestar_modern/basestar_assault.jpg",
        mesh = CUSTOM_ASSETS.."ships/cylon/basestar_modern/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/cylon/basestar_modern/diffuse_assault.jpg",
        --ruler = CUSTOM_ASSETS.."ships/cylon/basestar_modern/ruler.obj", 
        ruler = ARMADA_ASSETS.."ships/empire/imperial/ruler.obj", 
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
        diffuse = CUSTOM_ASSETS.."ships/cylon/basestar_modern/diffuse_def.jpg",
        --ruler = CUSTOM_ASSETS.."ships/cylon/basestar_modern/ruler.obj", 
        ruler = ARMADA_ASSETS.."ships/empire/imperial/ruler.obj", 
        maneuver = {{"II"},{"-","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_SALVO,DEF_BRACE,DEF_EVADE},
        shields = {2,2,2,2}, -- Front, left, right, rear
        cost = 110,
        command = 3,
        aliases = {"Basestar Mk2 Defense Refit [Legends]"}
    })
    
CYL_SQUAD = {back = CUSTOM_ASSETS.."ships/cylon/card_back.jpg",faction = "Cylon"}

    -- war raider
    war_raider = {
        mesh = CUSTOM_ASSETS.."squadrons/cylon/war_raider/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/cylon/war_raider/diffuse.jpg",
        health = 4,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(war_raider, CYL_SQUAD, {
        name = "War Raider Squadron",
        front = CUSTOM_ASSETS.."squadrons/cylon/war_raider/war-raider-squadron_card.jpg",
        cost = 10,
        aliases = {"War Raider Squadron [Legends]"}
    })
    Squadron:new(war_raider, CYL_SQUAD, {
        name = "Silverfish",
        front = CUSTOM_ASSETS.."squadrons/cylon/war_raider/silverfish_war-raider-squadron_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/cylon/war_raider/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 23,
        aliases = {"Silverfish - War Raider Squadron [Legends]"}
    })
    Squadron:new(war_raider, CYL_SQUAD, {
        name = "Liberator",
        front = CUSTOM_ASSETS.."squadrons/cylon/war_raider/liberator_war-raider-squadron_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/cylon/war_raider/ace_diffuse.jpg", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 26,
        aliases = {"Liberator - War Raider Squadron [Legends]"}
    })

    -- wardriver
    wardriver = {
        mesh = CUSTOM_ASSETS.."squadrons/cylon/wardriver/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/cylon/wardriver/diffuse.jpg",
        health = 4,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(wardriver, CYL_SQUAD, {
        name = "Wardriver Squadron",
        front = CUSTOM_ASSETS.."squadrons/cylon/wardriver/wardriver_card.jpg",
        cost = 16,
        aliases = {"Wardriver Squadron [Legends]"}
    })
    Squadron:new(wardriver, CYL_SQUAD, {
        name = "E-47",
        front = CUSTOM_ASSETS.."squadrons/cylon/wardriver/e47_wardriver_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/cylon/wardriver/ace_diffuse.jpg", 
        defense_tokens = {DEF_EVADE,DEF_SCATTER},
        cost = 26,
        aliases = {"E-47 - Wardriver Squadron [Legends]"}
    })
    
    -- vespid bomber
    vespid = {
        mesh = CUSTOM_ASSETS.."squadrons/cylon/vespid/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/cylon/vespid/diffuse.jpg",
        health = 4,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(vespid, CYL_SQUAD, {
        name = "Vespid Bomber Squadron",
        front = CUSTOM_ASSETS.."squadrons/cylon/vespid/vespid_card.jpg",
        cost = 12,
        aliases = {"Vespid Bomber Squadron [Legends]"}
    })
    Squadron:new(vespid, CYL_SQUAD, {
        name = "Helios-07",
        front = CUSTOM_ASSETS.."squadrons/cylon/vespid/helios07_vespid_card.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/cylon/vespid/ace_diffuse.jpg", 
        defense_tokens = {DEF_EVADE,DEF_SCATTER},
        cost = 26,
        aliases = {"Helios-07 - Vespid Bomber Squadron [Legends]"}
    })

-- UNSC faction
UNSC_SHIP = {back = CUSTOM_ASSETS.."ships/unsc/card_back.jpg",faction = "UNSC"}

        --halcyon
    Ship:new(MediumShip,UNSC_SHIP, {
        name = "Halcyon-class Light Cruiser",
        front = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_light_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/unsc/halcyon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/halcyon/diffuse_light_halcyon.jpg",
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
        front = CUSTOM_ASSETS.."ships/unsc/halcyon/halcyon_refit_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/unsc/halcyon/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/halcyon/diffuse_refit_halcyon.jpg",
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
        front = CUSTOM_ASSETS.."ships/unsc/paris/paris_heavy_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/unsc/paris/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/paris/diffuse_heavy_paris.jpg",
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
        front = CUSTOM_ASSETS.."ships/unsc/paris/paris_missile_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/unsc/paris/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/paris/diffuse_missile_paris.jpg",
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
        front = CUSTOM_ASSETS.."ships/unsc/stalwart/stalwart_light_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/unsc/stalwart/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/stalwart/diffuse_light_stalwart.jpg",
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
        front = CUSTOM_ASSETS.."ships/unsc/stalwart/stalwart_escort_card.jpg",
        mesh = CUSTOM_ASSETS.."ships/unsc/stalwart/mesh.obj",
        diffuse = CUSTOM_ASSETS.."ships/unsc/stalwart/diffuse_escort_stalwart.jpg",
        ruler = CUSTOM_ASSETS.."ships/unsc/stalwart/ruler.obj", 
        maneuver = {{"II"},{"I","I"},{"-","II","I"}},
        defense_tokens = {DEF_CONTAIN,DEF_EVADE,DEF_BRACE},
        shields = {2,1,1,1}, -- Front, left, right, rear
        cost = 50,
        command = 1,
        aliases = {"Stalwart-class Escort Frigate [Legends]"}
    })   

    
UNSC_SQUAD = {back = CUSTOM_ASSETS.."ships/unsc/card_back.jpg",faction = "UNSC"}

        --longsword fighter
    ls_fighter = {
        mesh = CUSTOM_ASSETS.."squadrons/unsc/longsword/fighter_mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_fighter.jpg",
        health = 6,
        move = 3,
        defense_tokens = {}
    }
    Squadron:new(ls_fighter, UNSC_SQUAD, {
        name = "Longsword Fighter Squadron",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_fighter_card.jpg",
        cost = 15,
        aliases = {"Longsword Fighter Squadron [Legends]"}
    })
    Squadron:new(ls_fighter, UNSC_SQUAD, {
        name = "Knife 26",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_fighter_knife26.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_ace_fighter.jpg", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 20,
        aliases = {"Knife 26 - Longsword Fighter Squadron [Legends]"}
    })

        --longsword bomber
    ls_bomber = {
        mesh = CUSTOM_ASSETS.."squadrons/unsc/longsword/bomber_mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_bomber.jpg",
        health = 7,
        move = 2,
        defense_tokens = {}
    }
    Squadron:new(ls_bomber, UNSC_SQUAD, {
        name = "Longsword Bomber Squadron",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_bomber_card.jpg",
        cost = 17,
        aliases = {"Longsword Bomber Squadron [Legends]"}
    })
    Squadron:new(ls_bomber, UNSC_SQUAD, {
        name = "Master Chief",
        front = CUSTOM_ASSETS.."squadrons/unsc/longsword/ls_bomber_chief.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/unsc/longsword/diffuse_ls_ace_bomber.jpg", 
        defense_tokens = {DEF_BRACE,DEF_BRACE},
        cost = 19,
        aliases = {"Master Chief - Longsword Bomber Squadron [Legends]"}
    })


COV_SHIP = {back = CUSTOM_ASSETS.."ships/covenant/back.jpg",faction = "Covenant"}

        --ccs
        Ship:new(LargeShip,COV_SHIP, {
            name = "CCS-class Battle Cruiser",
            front = CUSTOM_ASSETS.."ships/covenant/ccs/ccs_battle_card.jpg",
            mesh = CUSTOM_ASSETS.."ships/covenant/ccs/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/ccs/diffuse_battle_ccs.jpg",
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
            front = CUSTOM_ASSETS.."ships/covenant/ccs/ccs_command_card.jpg",
            mesh = CUSTOM_ASSETS.."ships/covenant/ccs/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/ccs/diffuse_command_ccs.jpg",
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
            front = CUSTOM_ASSETS.."ships/covenant/sdv/sdv_heavy_card.jpg",
            mesh = CUSTOM_ASSETS.."ships/covenant/sdv/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/sdv/diffuse_heavy_sdv.jpg",
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
            front = CUSTOM_ASSETS.."ships/covenant/sdv/sdv_assault_card.jpg",
            mesh = CUSTOM_ASSETS.."ships/covenant/sdv/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/sdv/diffuse_assault_sdv.jpg",
            ruler = CUSTOM_ASSETS.."ships/covenant/sdv/ruler.obj", 
            maneuver = {{"II"},{"I","I"},{"I","I","-"}},
            defense_tokens = {DEF_REDIRECT,DEF_EVADE,DEF_BRACE},
            shields = {3,3,3,2}, -- Front, left, right, rear
            cost = 75,
            command = 2,
            aliases = {"SDV-class Assault Corvette [Legends]"} 
        })

        --cas
        Ship:new(ShortHugeShip,COV_SHIP, {
            name = "(WIP)CAS-class Assault Carrier",
            front = CUSTOM_ASSETS.."ships/covenant/cas/cas_assault_card.jpg",
            mesh = CUSTOM_ASSETS.."ships/covenant/cas/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/cas/diffuse_cas.jpg",
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
            front = CUSTOM_ASSETS.."ships/covenant/crs/crs_light_card.jpg",
            mesh = CUSTOM_ASSETS.."ships/covenant/crs/mesh.obj",
            diffuse = CUSTOM_ASSETS.."ships/covenant/crs/diffuse_crs.jpg",
            ruler = CUSTOM_ASSETS.."ships/covenant/crs/ruler.obj", 
            maneuver = {{"I"},{"-","I"},{"-","I","I"}},
            defense_tokens = {DEF_REDIRECT,DEF_SALVO,DEF_BRACE,DEF_REDIRECT},
            shields = {2,2,2,1}, -- Front, left, right, rear
            cost = 85,
            command = 1,
            aliases = {"CRS-class Light Cruiser [Legends]"} 
        })

COV_SQUAD = {back = CUSTOM_ASSETS.."ships/covenant/back.jpg",faction = "Covenant"}

        --space banshee
    banshee = {
        mesh = CUSTOM_ASSETS.."squadrons/covenant/banshee/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/banshee/diffuse_banshee.jpg",
        health = 3,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(banshee, COV_SQUAD, {
        name = "Banshee Squadron",
        front = CUSTOM_ASSETS.."squadrons/covenant/banshee/banshee_card.jpg",
        cost = 8,
        aliases = {"Banshee Squadron [Legends]"}
    })
    Squadron:new(banshee, COV_SQUAD, {
        name = "Dalamenee",
        front = CUSTOM_ASSETS.."squadrons/covenant/banshee/banshee_dalamenee.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/banshee/diffuse_ace_banshee.jpg", 
        defense_tokens = {DEF_SCATTER,DEF_EVADE},
        cost = 14,
        aliases = {"Dalamenee - Banshee Squadron [Legends]"}
    })
    Squadron:new(banshee, COV_SQUAD, {
        name = "Wraith Wing",
        front = CUSTOM_ASSETS.."squadrons/covenant/banshee/banshee_wraith.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/banshee/diffuse_sqd_banshee.jpg", 
        cost = 10,
        aliases = {"Wraith Wing - Banshee Squadron [Legends]"}
    })

        --seraph
    seraph = {
        mesh = CUSTOM_ASSETS.."squadrons/covenant/seraph/mesh.obj",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/seraph/diffuse_seraph.jpg",
        health = 5,
        move = 4,
        defense_tokens = {}
    }
    Squadron:new(seraph, COV_SQUAD, {
        name = "Seraph Squadron",
        front = CUSTOM_ASSETS.."squadrons/covenant/seraph/seraph_card.jpg",
        cost = 14,
        aliases = {"Seraph Squadron [Legends]"}
    })
    Squadron:new(seraph, COV_SQUAD, {
        name = "Ferko",
        front = CUSTOM_ASSETS.."squadrons/covenant/seraph/seraph_ferko.jpg",
        diffuse = CUSTOM_ASSETS.."squadrons/covenant/seraph/diffuse_ace_seraph.jpg", 
        defense_tokens = {DEF_BRACE,DEF_EVADE},
        cost = 20,
        aliases = {"Ferko - Seraph Squadron [Legends]"}
    })

    ------upgrades
Commander = {type="Commander", back = CUSTOM_ASSETS.."cards/commander/back.jpg"}

DefensiveRetrofit = {type="DefensiveRetrofit", back = CUSTOM_ASSETS.."cards/defretro/back.jpg"}

FleetCommand = {type="FleetCommand", back = CUSTOM_ASSETS.."cards/fleetcom/back.jpg"}

FleetSupport = {type="FleetSupport", back = CUSTOM_ASSETS.."cards/fleetsup/back.jpg"}

IonCannons = {type="IonCannons", back = CUSTOM_ASSETS.."cards/ion/back.jpg"}

OffensiveRetrofit = {type="OffensiveRetrofit", back = CUSTOM_ASSETS.."cards/offretro/back.jpg"}

Officer = {type="Officer", back = CUSTOM_ASSETS.."cards/officer/back.jpg"}
        Card:new(Officer,Separatist,{name="Sai Sircu", front = CUSTOM_ASSETS.."cards/officers/sai-sircu-officer.jpg", cost=9, aliases={"Sai Sircu [Legends]"}})

SuperWeapon = {type="SuperWeapon", back = CUSTOM_ASSETS.."cards/super/back.jpg"}
        Card:new(SuperWeapon,Separatist,{name="Ion Pulse Emitter", front = CUSTOM_ASSETS.."cards/officers/Superweapon_Ion_Pulse_Emitter.jpg", cost=7, aliases={"Ion Pulse Emitter [Legends]"}})
        Card:new(SuperWeapon,Separatist,{name="Ionic Plasma Rotors", front = CUSTOM_ASSETS.."cards/officers/Superweapon_Ionic_plasma_rotors.jpg", cost=6, aliases={"Ionic Plasma Rotors [Legends]"}})
        Card:new(SuperWeapon,Separatist,{name="Kyber Beam Cannon", front = CUSTOM_ASSETS.."cards/officers/Superweapon_Kyber_ion_canon.jpg", cost=10, aliases={"Kyber Beam Cannon [Legends]"}})

SupportTeam = {type="SupportTeam", back = CUSTOM_ASSETS.."cards/support/back.jpg"}

Title = {type="Title", back = CUSTOM_ASSETS.."cards/title/back.jpg"}
        Card:new(Title,Separatist,{name="Devastation", front = CUSTOM_ASSETS.."cards/officers/Title_Devastation.jpg", cost=5, aliases={"Devastation [Legends]"}})
        Card:new(Title,Separatist,{name="Malevolence", front = CUSTOM_ASSETS.."cards/officers/Title_Malevolence.jpg", cost=7, aliases={"Malevolence [Legends]"}})
        Card:new(Title,Separatist,{name="Subjugator", front = CUSTOM_ASSETS.."cards/officers/Title_Subjugator.jpg", cost=3, aliases={"Subjugator [Legends]"}})

WeaponsTeam = {type="WeaponsTeam", back = CUSTOM_ASSETS.."cards/wepteam/back.jpg"}


-- = {type="", back = CUSTOM_ASSETS.."cards//back.jpg"}
    
    --starwars (new content factions)
Empire = {factions={"!Empire"}}
Rebel = {factions={"!Rebellion"}}
Republic = {factions={"!Republic"}}
Separatist = {factions={"!Separatist"}}
CloneWars = {factions={"!Republic","!Separatist"}}


-- Armada Legacy (Old)
    Card:new(Commander,Republic,{name="Admiral Coburn",  front = LEGACY_ASSETS.."cards/commanders/admiral-coburn.jpg", cost=25, aliases={"Admiral Coburn [OldLegacy]"}})
    Card:new(Commander,Republic,{name="Yoda",  front = LEGACY_ASSETS.."cards/commanders/yoda.jpg", cost=27, aliases={"Yoda [OldLegacy]"}})
    Card:new(Commander,Separatist,{name="Riff Tamson",  front = LEGACY_ASSETS.."cards/commanders/riff-tamson.jpg", cost=32, aliases={"Riff Tamson [OldLegacy]"}})
    Card:new(Commander,Separatist,{name="Nute Gunray",  front = LEGACY_ASSETS.."cards/commanders/nute-gunray.jpg", cost=20, aliases={"Nute Gunray [OldLegacy]"}})
    Card:new(Commander,Empire,{name="Gilad Pellaeon",  front = LEGACY_ASSETS.."cards/commanders/gilad-pellaeon.jpg", cost=20, aliases={"Gilad Pellaeon [OldLegacy]"}})
    Card:new(Commander,Empire,{name="Admiral Rogriss",  front = LEGACY_ASSETS.."cards/commanders/admiral-rogriss.jpg", cost=25, aliases={"Admiral Rogriss [OldLegacy]"}})
    Card:new(Commander,Rebel,{name="Admiral Nantz",  front = LEGACY_ASSETS.."cards/commanders/admiral-nantz.jpg", cost=26, aliases={"Admiral Nantz [OldLegacy]"}})
    Card:new(Commander,Rebel,{name="Han Solo",  front = LEGACY_ASSETS.."cards/commanders/han-solo-commander.jpg", cost=30, aliases={"Han Solo [OldLegacy]"}})
    --UpdateCard("General Madine",30,{cost = 27,aliases={"General Madine [OldLegacy]"}})
    --UpdateCard("Darth Vader",36,{cost = 32,aliases={"Darth Vader [OldLegacy]"}})
    --UpdateCard("Emperor Palpatine",35,{cost = 31,aliases={"Emperor Palpatine [OldLegacy]"}})
    --UpdateCard("Obi-Wan Kenobi",28,{cost = 25,aliases={"Obi-Wan Kenobi [OldLegacy]"}})
    --UpdateCard("Admiral Trench",36,{cost = 32,aliases={"Admiral Trench [OldLegacy]"}})

    Card:new(DefensiveRetrofit,{name="Cloaking Device", front = LEGACY_ASSETS.."cards/defretro/cloaking-device.jpg", cost=10, aliases={"Cloaking Device [OldLegacy]"}})
    Card:new(DefensiveRetrofit,{name="Flares", front = LEGACY_ASSETS.."cards/defretro/flares.jpg", cost=5, aliases={"Flares [OldLegacy]"}})
    --UpdateCard("Redundant Shields",8,{cost = 6,aliases={"Redundant Shields [OldLegacy]"}})

    Card:new(ExperimentalRetrofit,{name="Cloaking Field", front = LEGACY_ASSETS.."cards/exp/cloaking-field.jpg", cost=5, aliases={"Cloaking Field [OldLegacy]"}})
    Card:new(ExperimentalRetrofit,{name="Grav Cone Projector", front = LEGACY_ASSETS.."cards/exp/grav-cone-projector.jpg", cost=10, aliases={"Grav Cone Projector [OldLegacy]"}})
    Card:new(ExperimentalRetrofit,{name="Reversed Grav Well Projector", front = LEGACY_ASSETS.."cards/exp/reversed-grav-well-projector.jpg", cost=2, aliases={"Reversed Grav Well Projector [OldLegacy]"}})
    
    --UpdateCard("NK-7 Ion Cannons", 10,{cost = 8,aliases={"NK-7 Ion Cannons [OldLegacy]"}})
    --UpdateCard("Point Defense Ion Cannons", 4,{cost = 6,aliases={"Point Defense Ion Cannons [OldLegacy]"}})

    Card:new(OffensiveRetrofit,{name="Advanced Guidance System", front = LEGACY_ASSETS.."cards/offretro/advanced-guidance-system.jpg", cost=4, aliases={"Advanced Guidance System [OldLegacy]"}})
    Card:new(OffensiveRetrofit,{name="Drill Beak", front = LEGACY_ASSETS.."cards/offretro/drill-beak.jpg", cost=5, aliases={"Drill Beak [OldLegacy]"}})
    Card:new(OffensiveRetrofit,{name="Enhanced Propulsion", front = LEGACY_ASSETS.."cards/offretro/enhanded-propulsion.jpg", cost=2, aliases={"Enhanced Propulsion [OldLegacy]"}})
    Card:new(OffensiveRetrofit,{name="Reserve Bulk Hangar", front = LEGACY_ASSETS.."cards/offretro/reserve-bulk-hangar.jpg", cost=9, aliases={"Reserve Bulk Hangar [OldLegacy]"}})
    Card:new(OffensiveRetrofit,{name="Tractor Tentacles", front = LEGACY_ASSETS.."cards/offretro/tractor-tentacles.jpg", cost=3, aliases={"Tractor Tentacles [OldLegacy]"}})
    --UpdateCard("Advanced Transponder Net",5,{cost = 3,aliases={"Advanced Transponder Net [OldLegacy]"}})

    Card:new(Officer,Republic,{name="Aayla Secura", front = LEGACY_ASSETS.."cards/officers/aayla-secura-officer.jpg", cost=5, aliases={"Aayla Secura [OldLegacy]"}})
    Card:new(Officer,Republic,{name="Admiral Yularen", front = LEGACY_ASSETS.."cards/officers/admiral-yularen-officer.jpg", cost=7, aliases={"Admiral Yularen [OldLegacy]"}})
    Card:new(Officer,Separatist,{name="K2-B4", front = LEGACY_ASSETS.."cards/officers/k2-b4.jpg", cost=6, aliases={"K2-B4 [OldLegacy]"}})
    Card:new(Officer,Separatist,{name="Poggle the Lesser", front = LEGACY_ASSETS.."cards/officers/poggle-the-lesser.jpg", cost=6, aliases={"Poggle the Lesser [OldLegacy]"}})
    Card:new(Officer,Empire,{name="Prince Admiral Krennel", front = LEGACY_ASSETS.."cards/officers/prince-admiral-krennel.jpg", cost=6, aliases={"Prince Admiral Krennel [OldLegacy]"}})
    Card:new(Officer,Empire,{name="Joruus C'baoth", front = LEGACY_ASSETS.."cards/officers/joruus-cbaoth.jpg", cost=8, aliases={"Joruus C'baoth [OldLegacy]"}})
    Card:new(Officer,Rebel,{name="Captain Onoma", front = LEGACY_ASSETS.."cards/officers/captain-onoma.jpg", cost=4, aliases={"Captain Onoma [OldLegacy]"}})
    Card:new(Officer,Rebel,{name="Borsk Fey'lya", front = LEGACY_ASSETS.."cards/officers/borsk-feylya.jpg", cost=7, aliases={"Borsk Fey'lya [OldLegacy]"}})
    
    Card:new(Ordnance,{name="Long Range Concussion Missiles", front = LEGACY_ASSETS.."cards/ord/long-range-concussion-missiles.jpg", cost=4, aliases={"Long Range Concussion Missiles [OldLegacy]"}})
    Card:new(Ordnance,{name="Tracking Torpedoes", front = LEGACY_ASSETS.."cards/ord/tracking-torpedoes.jpg", cost=6, aliases={"Tracking Torpedoes [OldLegacy]"}})
    --UpdateCard("Expanded Launchers", 13,{cost = 11,aliases={"Expanded Launchers [OldLegacy]"}})

    Card:new(SuperWeapon,Separatist,{name="Interception Protocols", front = LEGACY_ASSETS.."cards/cencon/interception-protocols.jpg", cost=5, aliases={"Interception Protocols [OldLegacy]"}})
    Card:new(SuperWeapon,Separatist,{name="Rogue Protocols", front = LEGACY_ASSETS.."cards/cencon/rogue-protocols.jpg", cost=10, aliases={"Rogue Protocols [OldLegacy]"}})
    Card:new(SuperWeapon,Separatist,{name="Targeting Protocols", front = LEGACY_ASSETS.."cards/cencon/targeting-protocols.jpg", cost=7, aliases={"Targeting Protocols [OldLegacy]"}})

    Card:new(SupportTeam,Republic,{name="Clone Engineers", front = LEGACY_ASSETS.."cards/support/clone-engineers.jpg", cost=3, aliases={"Clone Engineers [OldLegacy]"}})
    Card:new(SupportTeam,{name="Mon Calamari Shield Techs", front = LEGACY_ASSETS.."cards/support/mon-calamari-shield-techs.jpg", cost=5, aliases={"Mon Calamari Shield Techs [OldLegacy]"}})
    Card:new(SupportTeam,{name="Repair Team", front = LEGACY_ASSETS.."cards/support/repair-team.jpg", cost=2, aliases={"Repair Team [OldLegacy]"}})

    Card:new(Title,Republic,{name="Carrion Spike", front = LEGACY_ASSETS.."cards/titles/carrion-spike.jpg", cost=6, aliases={"Carrion Spike [OldLegacy]"}})
    Card:new(Title,Republic,{name="Stellar Rise", front = LEGACY_ASSETS.."cards/titles/stellar-rise.jpg", cost=3, aliases={"Stellar Rise [OldLegacy]"}})
    Card:new(Title,Republic,{name="Surrogator", front = LEGACY_ASSETS.."cards/titles/surrogator.jpg", cost=5, aliases={"Surrogator [OldLegacy]"}})
    Card:new(Title,Separatist,{name="Neimoidian Grasp", front = LEGACY_ASSETS.."cards/titles/neimoidian-grasp.jpg", cost=2, aliases={"Neimoidian Grasp [OldLegacy]"}})
    Card:new(Title,Separatist,{name="Grappler", front = LEGACY_ASSETS.."cards/titles/grappler.jpg", cost=3, aliases={"Grappler [OldLegacy]"}})
    Card:new(Title,Separatist,{name="Procurer", front = LEGACY_ASSETS.."cards/titles/procurer.jpg", cost=5, aliases={"Procurer [OldLegacy]"}})
    Card:new(Title,Separatist,{name="Profusion", front = LEGACY_ASSETS.."cards/titles/profusion.jpg", cost=4, aliases={"Profusion [OldLegacy]"}})
    Card:new(Title,Separatist,{name="Vuuntun Palaa", front = LEGACY_ASSETS.."cards/titles/vuuntun-palaa.jpg", cost=7, aliases={"Vuuntun Palaa [OldLegacy]"}})
    Card:new(Title,Empire,{name="Abrogator", front = LEGACY_ASSETS.."cards/titles/abrogator.jpg", cost=5, aliases={"Abrogator [OldLegacy]"}})
    Card:new(Title,Empire,{name="Binder", front = LEGACY_ASSETS.."cards/titles/binder.jpg", cost=5, aliases={"Binder [OldLegacy]"}})
    Card:new(Title,Empire,{name="Eternal Wrath", front = LEGACY_ASSETS.."cards/titles/eternal-wrath.jpg", cost=6, aliases={"Eternal Wrath [OldLegacy]"}})
    Card:new(Title,Empire,{name="Isolator", front = LEGACY_ASSETS.."cards/titles/isolator.jpg", cost=6, aliases={"Isolator [OldLegacy]"}})
    Card:new(Title,Empire,{name="Katana Fleet Dreadnaught", front = LEGACY_ASSETS.."cards/titles/katana-fleet-dreadnaught.jpg", cost=2, aliases={"Katana Fleet Dreadnaught [OldLegacy]"}})
    Card:new(Title,Empire,{name="Vendetta", front = LEGACY_ASSETS.."cards/titles/vendetta.jpg", cost=6, aliases={"Vendetta [OldLegacy]"}})
    Card:new(Title,Rebel,{name="Allegiant", front = LEGACY_ASSETS.."cards/titles/allegiant.jpg", cost=5, aliases={"Allegiant [OldLegacy]"}})
    Card:new(Title,Rebel,{name="Liberty Star", front = LEGACY_ASSETS.."cards/titles/liberty-star.jpg", cost=6, aliases={"Liberty Star [OldLegacy]"}})
    Card:new(Title,Rebel,{name="Mon Remonda", front = LEGACY_ASSETS.."cards/titles/mon-remonda.jpg", cost=7, aliases={"Mon Remonda [OldLegacy]"}})
    Card:new(Title,Rebel,{name="Remember Alderaan", front = LEGACY_ASSETS.."cards/titles/remember-alderaan.jpg", cost=3, aliases={"Remember Alderaan [OldLegacy]"}})
    Card:new(Title,Rebel,{name="Tyrant's Bane", front = LEGACY_ASSETS.."cards/titles/tyrants-bane.jpg", cost=8, aliases={"Tyrant's Bane [OldLegacy]"}})

    Card:new(Turbolaser,{name="Light Turbolaser Cannons", front = LEGACY_ASSETS.."cards/turbo/light-turbolaser-cannons.jpg", cost=6, aliases={"Light Turbolaser Cannons [OldLegacy]"}})
    Card:new(Turbolaser,{name="XV9 Turbolasers", front = LEGACY_ASSETS.."cards/turbo/xv9-turbolasers.jpg", cost=5, aliases={"XV9 Turbolasers [OldLegacy]"}})

    Card:new(WeaponsTeamAndOffensiveRetrofit,Separatist,{name="Asajj Ventress", front = LEGACY_ASSETS.."cards/wepoff/asajj-ventress-boarding-team.jpg", cost=7, aliases={"Asajj Ventress [OldLegacy]"}})
    Card:new(WeaponsTeamAndOffensiveRetrofit,Separatist,{name="BX Commando Droids", front = LEGACY_ASSETS.."cards/wepoff/bx-commando-droids.jpg", cost=2, aliases={"BX Commando Droids [OldLegacy]"}})

    Card:new(WeaponsTeam,{name="Targeting Team", front = LEGACY_ASSETS.."cards/wepteam/targeting-team.jpg", cost=5, aliases={"Targeting Team [OldLegacy]"}})

    -- Armada Legends
    Card:new(Title,Empire,{name="placeholderemp", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_ph.jpg", cost=4, aliases={"placeholderemp [Legends]"}})
    Card:new(Title,Rebel,{name="Phoenix Home", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_ph.jpg", cost=4, aliases={"Phoenix Home [Legends]"}})
    Card:new(Title,Rebel,{name="Phoenix Nest", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_pn.jpg", cost=6, aliases={"Phoenix Nest [Legends]"}})
    Card:new(Title,Republic,{name="Righteous Indignation", front = CUSTOM_ASSETS.."ships/republic/rothana/right_indig.jpg", cost=4, aliases={"Righteous Indignation [Legends]"}})
    --Card:new(Title,Republic,{name="Deliverance", front = CUSTOM_ASSETS.."ships/republic/rothana/right_indig.jpg", cost=7, aliases={"Deliverance [Legends]"}})
    Card:new(Title,Separatist,{name="Reaver", front = CUSTOM_ASSETS.."ships/separatist/sabaoth/title_sabaoth_reaver.jpg", cost=5, aliases={"Reaver [Legends]"}})
    Card:new(Title,Separatist,{name="Parting Handshake", front = CUSTOM_ASSETS.."ships/separatist/sabaoth/title_sabaoth_parthand.jpg", cost=5, aliases={"Parting Handshake [Legends]"}})

    --halo
    UNSC = {factions={"UNSC"}}
    Covenant = {factions={"Covenant"}}
    Halo = {factions={"UNSC","Covenant"}}

    Card:new(Commander,UNSC,{name="Captain Keyes",  front = CUSTOM_ASSETS.."cards/.halo/com_capt_keyes.jpg", cost=30, aliases={"Captain Keyes [Legends]"}})
    Card:new(Commander,UNSC,{name="Captain Wallace",  front = CUSTOM_ASSETS.."cards/.halo/com_capt_wallace.jpg", cost=20, aliases={"Captain Wallace [Legends]"}})
    Card:new(Commander,UNSC,{name="Commander Keyes",  front = CUSTOM_ASSETS.."cards/.halo/com_cmdr_keyes.jpg", cost=27, aliases={"Commander Keyes [Legends]"}})
    Card:new(Commander,UNSC,{name="Lord Hood",  front = CUSTOM_ASSETS.."cards/.halo/com_lordhood.jpg", cost=30, aliases={"Lord Hood [Legends]"}})
    Card:new(Commander,Covenant,{name="Ardo Moretumee",  front = CUSTOM_ASSETS.."cards/.halo/com_ardomoretumee.jpg", cost=20, aliases={"Ardo Moretumee [Legends]"}})
    Card:new(Commander,Covenant,{name="Atriox",  front = CUSTOM_ASSETS.."cards/.halo/com_atriox.jpg", cost=35, aliases={"Atriox [Legends]"}})
    Card:new(Commander,Covenant,{name="Prophet of Truth",  front = CUSTOM_ASSETS.."cards/.halo/com_prophettruth.jpg", cost=30, aliases={"Prophet of Truth [Legends]"}})
    Card:new(Commander,Covenant,{name="Thel Vadamee",  front = CUSTOM_ASSETS.."cards/.halo/com_thelvadamee.jpg", cost=25, aliases={"Thel Vadamee [Legends]"}})

    Card:new(DefensiveRetrofit,UNSC,{name="Emergency Thrusters",  front = CUSTOM_ASSETS.."cards/.halo/dr_emergthrusters.jpg", cost=6, aliases={"Emergency Thrusters [Legends]"}})
    Card:new(DefensiveRetrofit,UNSC,{name="Titanium Armor Plating",  front = CUSTOM_ASSETS.."cards/.halo/dr_titarmor.jpg", cost=4, aliases={"Titanium Armor Plating [Legends]"}})
    Card:new(DefensiveRetrofit,Covenant,{name="Reliable Shields",  front = CUSTOM_ASSETS.."cards/.halo/dr_reliableshields.jpg", cost=9, aliases={"Reliable Shields [Legends]"}})

    Card:new(FleetCommand,Covenant,{name="Jiralhanae Brutality",  front = CUSTOM_ASSETS.."cards/.halo/fc_jirabrutal.jpg", cost=7, aliases={"Jiralhanae Brutality [Legends]"}})
    Card:new(FleetCommand,Covenant,{name="Sangheili Honor",  front = CUSTOM_ASSETS.."cards/.halo/fc_sanghonor.jpg", cost=6, aliases={"Sangehili Honor [Legends]"}})
    Card:new(FleetCommand,Covenant,{name="Will of the Prophets",  front = CUSTOM_ASSETS.."cards/.halo/fc_wotp.jpg", cost=8, aliases={"Will of the Prophets [Legends]"}})

    Card:new(IonCannons,Covenant,{name="Overcharged Plasma Cells",  front = CUSTOM_ASSETS.."cards/.halo/ic_overplascells.jpg", cost=9, aliases={"Overcharged Plasma Cells [Legends]"}})
    Card:new(IonCannons,UNSC,{name="Sustain Motor Missiles",  front = CUSTOM_ASSETS.."cards/.halo/ic_sustainmissiles.jpg", cost=6, aliases={"Sustain Motor Missiles [Legends]"}})

    Card:new(OffensiveRetrofit,Covenant,{name="Plasma Lance",  front = CUSTOM_ASSETS.."cards/.halo/or_plasmalance.jpg", cost=10, aliases={"Plasma Lance [Legends]"}})
    
    Card:new(Officer,Halo,{name="Combat Coordinator", front = CUSTOM_ASSETS.."cards/.halo/off_combatcoord.jpg", cost=5, aliases={"Combat Coordinator [Legends]"}})
    Card:new(Officer,Halo,{name="Logistics Coordinator", front = CUSTOM_ASSETS.."cards/.halo/off_logicoord.jpg", cost=5, aliases={"Logistics Coordinator [Legends]"}})
    Card:new(Officer,UNSC,{name="Cortana (Officer)", front = CUSTOM_ASSETS.."cards/.halo/off_cortana.jpg", cost=8, aliases={"Cortana (Officer) [Legends]"}})
    Card:new(Officer,UNSC,{name="Avery Johnson (Officer)", front = CUSTOM_ASSETS.."cards/.halo/off_johnson.jpg", cost=5, aliases={"Avery Johnson (Officer) [Legends]"}})
    Card:new(Officer,UNSC,{name="Kristof Jen", front = CUSTOM_ASSETS.."cards/.halo/off_kristofjen.jpg", cost=5, aliases={"Kristof Jen [Legends]"}})
    Card:new(Officer,UNSC,{name="Master Chief (Officer)", front = CUSTOM_ASSETS.."cards/.halo/off_masterchief.jpg", cost=3, aliases={"Master Chief (Officer) [Legends]"}})
    Card:new(Officer,UNSC,{name="Antonio Silva", front = CUSTOM_ASSETS.."cards/.halo/off_silva.jpg", cost=6, aliases={"Antonio Silva [Legends]"}})
    Card:new(Officer,UNSC,{name="Smart AI", front = CUSTOM_ASSETS.."cards/.halo/off_smartai.jpg", cost=5, aliases={"Smart AI [Legends]"}})
    Card:new(Officer,Covenant,{name="Lat Ravamee", front = CUSTOM_ASSETS.."cards/.halo/off_latravamee.jpg", cost=9, aliases={"Lat Ravamee [Legends]"}})
    Card:new(Officer,Covenant,{name="Maccabeus", front = CUSTOM_ASSETS.."cards/.halo/off_maccabeus.jpg", cost=9, aliases={"Maccabeus [Legends]"}})
    Card:new(Officer,Covenant,{name="Prophet of Stewardship", front = CUSTOM_ASSETS.."cards/.halo/off_prophetsteward.jpg", cost=2, aliases={"Prophet of Stewardship [Legends]"}})
    Card:new(Officer,Covenant,{name="Rtas Vadumee", front = CUSTOM_ASSETS.."cards/.halo/off_rtasvadumee.jpg", cost=4, aliases={"Rtas Vadumee [Legends]"}})
    
    Card:new(SuperWeapon,UNSC,{name="Quick-Charge Capacitors",  front = CUSTOM_ASSETS.."cards/.halo/sw_qccaps.jpg", cost=6, aliases={"Quick-Charge Capacitors [Legends]"}})
    
    Card:new(SupportTeam,Covenant,{name="Huragok Engineer Team",  front = CUSTOM_ASSETS.."cards/.halo/st_huragokeng.jpg", cost=3, aliases={"Huragok Engineer Team [Legends]"}})

    Card:new(Title,UNSC,{name="UNSC Pillar of Autumn", front = CUSTOM_ASSETS.."ships/unsc/halcyon/title_halcyon_poa.jpg", cost=7, aliases={"UNSC Pillar of Autumn [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Constantinople", front = CUSTOM_ASSETS.."ships/unsc/halcyon/title_halcyon_const.jpg", cost=3, aliases={"UNSC Constantinople [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Roman Blue", front = CUSTOM_ASSETS.."ships/unsc/halcyon/title_halcyon_roman.jpg", cost=2, aliases={"UNSC Roman Blue [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Savannah", front = CUSTOM_ASSETS.."ships/unsc/paris/title_paris_savannah.jpg", cost=9, aliases={"UNSC Savannah [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Commonwealth", front = CUSTOM_ASSETS.."ships/unsc/paris/title_paris_commonwealth.jpg", cost=7, aliases={"UNSC Commonwealth [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC In Amber Clad", front = CUSTOM_ASSETS.."ships/unsc/stalwart/title_stalwart_iac.jpg", cost=8, aliases={"UNSC In Amber Clad [Legends]"}})
    Card:new(Title,UNSC,{name="UNSC Meriweather Lewis", front = CUSTOM_ASSETS.."ships/unsc/stalwart/title_stalwart_merilew.jpg", cost=1, aliases={"UNSC Meriweather Lewis [Legends]"}})
    Card:new(Title,Covenant,{name="Truth and Reconciliation", front = CUSTOM_ASSETS.."ships/covenant/ccs/title_ccs_truthandreco.jpg", cost=6, aliases={"Truth and Reconciliation [Legends]"}})
    Card:new(Title,Covenant,{name="Purity of Spirit", front = CUSTOM_ASSETS.."ships/covenant/ccs/title_ccs_purityspirit.jpg", cost=5, aliases={"Purity of Spirit [Legends]"}})
    Card:new(Title,Covenant,{name="Ardent Prayer", front = CUSTOM_ASSETS.."ships/covenant/sdv/title_sdv_ardentprayer.jpg", cost=4, aliases={"Ardent Prayer [Legends]"}})
    Card:new(Title,Covenant,{name="Elegy's Lament", front = CUSTOM_ASSETS.."ships/covenant/sdv/title_sdv_elegylament.jpg", cost=3, aliases={"Elegy's Lament [Legends]"}})

    Card:new(WeaponsTeam,UNSC,{name="Cortana (WT)", front = CUSTOM_ASSETS.."cards/.halo/wt_cortana.jpg", cost=7, aliases={"Cortana (WT) [Legends]"}})
    Card:new(WeaponsTeam,UNSC,{name="UNSC Gunners", front = CUSTOM_ASSETS.."cards/.halo/wt_unscgunners.jpg", cost=6, aliases={"UNSC Gunners [Legends]"}})

--bsg
Colonial = {factions={"Colonial"}}
Cylon = {factions={"Cylon"}}
BSG = {factions={"Colonial","Cylon"}}

    Card:new(Commander,Colonial,{name="Helena Cain", front = CUSTOM_ASSETS.."cards/.bsg/.old/cain_commander.jpg", cost=34, aliases={"Helena Cain [Legends]"}})
    Card:new(Commander,Colonial,{name="Commander Ozar", front = CUSTOM_ASSETS.."cards/.bsg/.old/ozar_commander.jpg", cost=29, aliases={"Commander Ozar [Legends]"}})
    Card:new(Commander,Colonial,{name="William Adama", front = CUSTOM_ASSETS.."cards/.bsg/.old/willadama_commander.jpg", cost=20, aliases={"William Adama [Legends]"}})

    Card:new(DefensiveRetrofit,Colonial,{name="DRADIS", front = CUSTOM_ASSETS.."cards/.bsg/.old/dradis_defretro.jpg", cost=4, aliases={"DRADIS [Legends]"}})
    Card:new(DefensiveRetrofit,Colonial,{name="Integrated Computer Network", front = CUSTOM_ASSETS.."cards/.bsg/.old/intcomnet_defretro.jpg", cost=4, aliases={"Integrated Computer Network [Legends]"}})
    Card:new(DefensiveRetrofit,Colonial,{name="Layered Point-Defense", front = CUSTOM_ASSETS.."cards/.bsg/.old/layerpd_defretro.jpg", cost=10, aliases={"Layered Point-Defense [Legends]"}})
    Card:new(DefensiveRetrofit,Colonial,{name="Networked Point-Defense", front = CUSTOM_ASSETS.."cards/.bsg/.old/netpd_defretro.jpg", cost=6, aliases={"Networked Point-Defense [Legends]"}})

    Card:new(FleetCommand,Colonial,{name="So Say We All", front = CUSTOM_ASSETS.."cards/.bsg/.old/sswa_fleetcom.jpg", cost=7, aliases={"So Say We All [Legends]"}})
    Card:new(FleetCommand,Colonial,{name="Suppression Barrage Execute", front = CUSTOM_ASSETS.."cards/.bsg/.old/supbar_fleetcom.jpg", cost=6, aliases={"Suppression Barrage Execute [Legends]"}})

    Card:new(FleetSupport,Colonial,{name="Missile Pods", front = CUSTOM_ASSETS.."cards/.bsg/.old/missilepods_fleetsup.jpg", cost=4, aliases={"Missile Pods [Legends]"}})
    Card:new(FleetSupport,Colonial,{name="Strike Munitions", front = CUSTOM_ASSETS.."cards/.bsg/.old/strike_mun_fleetsup.jpg", cost=8, aliases={"Strike Munitions [Legends]"}})

    Card:new(Officer,Colonial,{name="Jack Fisk", front = CUSTOM_ASSETS.."cards/.bsg/.old/fisk_officer.jpg", cost=2, aliases={"Jack Fisk [Legends]"}})
    Card:new(Officer,Colonial,{name="Felix Gaeta", front = CUSTOM_ASSETS.."cards/.bsg/.old/gaeta_officer.jpg", cost=6, aliases={"Felix Gaeta [Legends]"}})
    Card:new(Officer,Colonial,{name="Lee Adama", front = CUSTOM_ASSETS.."cards/.bsg/.old/leeadama_officer.jpg", cost=7, aliases={"Lee Adama [Legends]"}})
    Card:new(Officer,Colonial,{name="Saul Tigh", front = CUSTOM_ASSETS.."cards/.bsg/.old/tigh_officer.jpg", cost=5, aliases={"Saul Tigh [Legends]"}})

    Card:new(SuperWeapon,Colonial,{name="Chrome-Composite Stealth Plating", front = CUSTOM_ASSETS.."cards/.bsg/.old/chrome_stealth_super.jpg", cost=10, aliases={"Chrome-Composite Stealth Plating [Legends]"}})

    Card:new(SupportTeam,Colonial,{name="Damage Control Teams", front = CUSTOM_ASSETS.."cards/.bsg/.old/dmgctrl_sup.jpg", cost=4, aliases={"Damage Control Teams [Legends]"}})
    Card:new(SupportTeam,Colonial,{name="Galen Tyrol", front = CUSTOM_ASSETS.."cards/.bsg/.old/tyrol_sup.jpg", cost=5, aliases={"Galen Tyrol [Legends]"}})

    Card:new(Title,Colonial,{name="Acheron", front = CUSTOM_ASSETS.."cards/.bsg/.old/acheron_title.jpg", cost=7, aliases={"Acheron [Legends]"}})
    Card:new(Title,Colonial,{name="Demeter", front = CUSTOM_ASSETS.."cards/.bsg/.old/demeter_title.jpg", cost=4, aliases={"Demeter [Legends]"}})
    Card:new(Title,Colonial,{name="Galactica", front = CUSTOM_ASSETS.."cards/.bsg/.old/galactica_title.jpg", cost=4, aliases={"Galactica [Legends]"}})
    Card:new(Title,Colonial,{name="Osiris", front = CUSTOM_ASSETS.."cards/.bsg/.old/osiris_title.jpg", cost=9, aliases={"Osiris [Legends]"}})
    Card:new(Title,Colonial,{name="Pegasus", front = CUSTOM_ASSETS.."cards/.bsg/.old/pegasus_title.jpg", cost=6, aliases={"Pegasus [Legends]"}})
    Card:new(Title,Colonial,{name="Triton", front = CUSTOM_ASSETS.."cards/.bsg/.old/triton_title.jpg", cost=5, aliases={"Triton [Legends]"}})

    Card:new(OffensiveRetrofit,Colonial,{name="Archer Missiles",  front = CUSTOM_ASSETS.."cards/.bsg/.old/archerm_offretro.jpg", cost=7, aliases={"Archer Missiles [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Bombing Run",  front = CUSTOM_ASSETS.."cards/.bsg/.old/bombrun_offretro.jpg", cost=4, aliases={"Bombing Run [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Dual-Purpose KEW",  front = CUSTOM_ASSETS.."cards/.bsg/.old/dualKEW_offretro.jpg", cost=7, aliases={"Dual-Purpose KEW [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Indiscriminate Firing Solution",  front = CUSTOM_ASSETS.."cards/.bsg/.old/indisfire_offretro.jpg", cost=4, aliases={"Indiscriminate Firing Solution [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Magnetic Launch Tubes",  front = CUSTOM_ASSETS.."cards/.bsg/.old/magtubes_offretro.jpg", cost=7, aliases={"Magnetic Launch Tubes [Legends]"}})
    Card:new(OffensiveRetrofit,Colonial,{name="Networked Fire Control",  front = CUSTOM_ASSETS.."cards/.bsg/.old/netfirecon_offretro.jpg", cost=5, aliases={"Networked Fire Control [Legends]"}})

    Card:new(WeaponsTeam,Colonial,{name="Colonial Gunners", front = CUSTOM_ASSETS.."cards/.bsg/.old/colgunner_wep.jpg", cost=5, aliases={"Colonial Gunners [Legends]"}})
    Card:new(WeaponsTeam,Colonial,{name="Gunnery Sergeant", front = CUSTOM_ASSETS.."cards/.bsg/.old/gunsgt_wep.jpg", cost=6, aliases={"Gunnery Sergeant [Legends]"}})
    Card:new(WeaponsTeam,Colonial,{name="Reactive Gunners", front = CUSTOM_ASSETS.."cards/.bsg/.old/reactgun_wep.jpg", cost=4, aliases={"Reactive Gunners [Legends]"}})

    Card:new(Title,Cylon,{name="placeholdercyl", front = CUSTOM_ASSETS.."ships/rebel/reb_quasar/title_rebquasar_ph.jpg", cost=4, aliases={"placeholdercyl [Legends]"}})

    printToAll("Finished loading Armada Legends collection!",{1,0.5,0})

end
    
    -- DO NOT MODIFY CODE BELOW THIS, OR MOD DB MAY NOT WORK!
    ARMADA_ASSETS = 'https://raw.githubusercontent.com/valadian/TabletopSimulatorIncludeDir/master/TTS_armada/assets/'
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
    SmallShip = { collider = ARMADA_ASSETS..'misc/bases/small.obj' } --"http://paste.ee/r/eDbf1"
    MediumShip = { collider = ARMADA_ASSETS..'misc/bases/medium.obj' } --"http://paste.ee/r/6LYTT"
    LargeShip = { collider = ARMADA_ASSETS..'misc/bases/large.obj'} --"http://paste.ee/r/a7mfW"
    ShortHugeShip = { collider = CUSTOM_ASSETS..'misc/bases/shorthuge_collider.obj'} --https://pastebin.com/raw/EnRBX4Lb
    HugeShip = { collider = ARMADA_ASSETS..'misc/bases/huge.obj' } --"http://paste.ee/r/ClCL3"
    Squadron = { collider = ARMADA_ASSETS..'misc/bases/squad.obj', convex = false, type = 1, --"http://paste.ee/r/ZKM7E" --http://paste.ee/r/nAMCQ
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
    function GetDefinition(name, cost)
        local o = {}
        o['name'] = name
        o['cost'] = cost or 0
        spawner = findObjectByName("Armada Spawner")
        if spawner~=nil then
            return spawner.call("API_GetDefinition",o)
        end
    end