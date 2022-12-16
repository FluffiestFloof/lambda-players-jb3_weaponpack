table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_cmp2a = {
        model = "models/lambdaplayers/cmp2a/w_cmp2a.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "CMP-2A",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_cmp2a",
        bonemerge = true,
        keepdistance = 325,
        attackrange = 2000,

        clip = 30,
        tracername = "ubt_tracer",
        damage = 5,
        spread = 0.16,
        rateoffire = 0.08,
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 0, 3, 10 ),
        shelloffang = Angle( -180, 0, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "lambdaplayers/weapons/cmp2a/fire*4*.mp3",

        reloadtime = 1.5,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        reloadanimspeed = 1.3,
        reloadsounds = { 
            { 0.0, "lambdaplayers/weapons/cmp2a/clipout.mp3" }, 
            { 0.8, "lambdaplayers/weapons/cmp2a/clipin.mp3" }
        },

        islethal = true,
    }

})