---------------| Developed by BabyDrill#7768 |---------------
Config = {

    MarkerPesca = {
        id = -1,
        key = 'E',
        colore = { r = 255, b = 255, g = 255 },
        grandezza = vector3(0.7, 0.7, 0.7),
        distanza = 10.0
    },

    BlipPesca = {
        id = 68,
        colore = 5,
        grandezza = 0.8
    },

    Pesca = {

        Posizione = { x = 714.12042236328, y = 4099.4653320313, z = 35.785179138184 },

        SpawnBarca = { x = 717.50549316406, y = 4076.0437011719, z = 29.084981918335 },

        Deposito = {
            posizione = { x = 718.29125976563, y = 4101.3540039063, z = 31.344591140747 },
            marker = {
                id = 35,
                key = 51,
                colore = vector3(224, 50, 50),
                grandezza = vector3(1.0, 1.0, 1.0),
                distanza = 10.0
            }
        },

        SpawnPesci = { x = 1809.1544189453, y = 4203.0854492188, z = 29.262701034546 },

        [1] = {["Pescatore"] = {["x"] = 714.48840332031, ["y"] = 4099.556640625, ["z"] = 35.785179138184, ["h"] = 90.0,["hash"] = "a_m_o_soucent_03", ["anim_dict"] = "anim@amb@nightclub@peds@"}},

        Barca = "dinghy4",

        Item = {
            
            CannaDaPesca = {name = "cannapesca", prezzo = 500},

            PesceNormale = {name = "spigole", label = "a Spigola", prezzo = 10},

            PesceRaro = {name = "pescespada", label = " Pesce Spada", prezzo = 20},

            PesceLeggendario = {name = "squali", label = "o Squalo Bianco", prezzo = 30}

        },

        Tempo = {
            
            Min = 5000,

            Max = 15000
        }
    }
}

Lang = {
    ["pesca"] = "Premi [~r~E~w~] per parlare con il pescatore!",
    ["pescainfo"] = "Premi [~r~E~w~] per pescare!",
    ["deposito"] = "Premi [~r~E~w~] per depositare la barca!",
-----------------------------------------------------------------
    ["soldi"] = "Non hai abbastanza soldi!",
    ["materiale"] = "Non hai abbastanza materiali!",
    ["venduto"] = "Hai venduto ",
    ["soldi2"] = "per $",
    ["prontopesca"] = "Ottimo, Sei diventato un pescatore!",
-----------------------------------------------------------------
    ["pescepreso"] = "Hai preso un pesce!",
    ["vendita1"] = "Vendi Pesce",
    ["vendita2"] = "Vendi Pesce Spada",
    ["vendita3"] = "Vendi Squalo Bianco",
-----------------------------------------------------------------
    ["pesceitem"] = "Bravo! Hai preso un",
    ["pescenonpreso"] = "Non sei riuscito a prendere un pesce, ritenta!",
    ["cannapescarotta"] = "Hai rotto la tua canna da pesca! Riparala!",
    ["cannapesca"] = "Devi avere una canna da pesca per pescare!",
    ["recatiallapesca"] = "Recati nella zona di pesca già settata sul tuo gps!",
    ["veicolo"] = "Per pescare devi rimanere sul bordo della barca!",
    ["pescatore_blip"] = "Peschereccio",
    ["pesca_blip"] = "Zona di Pesca",
    ["opzione"] = "Scegli un'opzione",
    ["opzione1"] = "Inizia a Pescare per $"
} 
---------------| Developed by BabyDrill#7768 |---------------