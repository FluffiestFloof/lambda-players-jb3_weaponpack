table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_silencedsmg = {
        model = "models/lambdaplayers/silencedsmg/w_silencedsmg.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Silenced SMG",
        holdtype = "ar2",
        killicon = "lambdaplayers/killicons/icon_jb3_silencedsmg",
        bonemerge = true,
        keepdistance = 450,
        attackrange = 2000,

        clip = 30,
        tracername = "Tracer",
        damage = 5,
        spread = 0.17,
        rateoffire = 0.08,
        muzzleflash = 8,
        shelleject = "ShellEject",
        shelloffpos = Vector( 0, 0, 0 ),
        shelloffang = Angle( -180, 0, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
        attacksnd = "lambdaplayers/weapons/silencedsmg/fire*8*.mp3",

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        reloadanimspeed = 0.9,
        reloadsounds = { 
            { 0.2, "lambdaplayers/weapons/silencedsmg/magout.mp3" },
            { 1.25, "lambdaplayers/weapons/silencedsmg/magin.mp3" },
            { 1.82, "lambdaplayers/weapons/silencedsmg/boltback.mp3" },
            { 2.1, "lambdaplayers/weapons/silencedsmg/boltforward.mp3" }
        },

        islethal = true,
    }

})