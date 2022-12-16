table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_silencedpistol = {
        model = "models/lambdaplayers/silencedpistol/w_silencedpistol.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Silenced Pistol",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_silencedpistol",
        bonemerge = true,
        keepdistance = 550,
        attackrange = 2500,

        clip = 10,
        tracername = "Tracer",
        damage = 9,
        spread = 0.1,
        rateoffire = 0.15,
        muzzleflash = 8,
        shelleject = "ShellEject",
        --shelloffpos = Vector( 0, 0, 0 ),
        --shelloffang = Angle( -180, 0, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "lambdaplayers/weapons/silencedpistol/fire*4*.mp3",

        reloadtime = 1.7,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1.05,
        reloadsounds = { 
            { 0.1, "lambdaplayers/weapons/silencedpistol/clipout.mp3" },
            { 0.8, "lambdaplayers/weapons/silencedpistol/clipin.mp3" },
            { 1.3, "lambdaplayers/weapons/silencedpistol/slide.mp3" }
        },

        islethal = true,
    }

})