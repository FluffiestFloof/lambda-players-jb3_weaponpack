table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_z89 = {
        model = "models/weapons/w_smg_p90.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Z89",
        holdtype = "smg1",
        killicon = "lambdaplayers/killicons/icon_jb3_z89",
        bonemerge = true,
        keepdistance = 300,
        attackrange = 3000,

        clip = 50,
        tracername = "ubt_tracer",
        damage = 6,
        spread = 0.09,
        rateoffire = 0.06,
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( 0, 0, -5 ),
        shelloffang = Angle( 90, 0, 90 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1,
        attacksnd = "lambdaplayers/weapons/z89/fire*4*.mp3",

        reloadtime = 2.5,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.9,
        reloadsounds = { 
            { 0.3, "lambdaplayers/weapons/z89/clip.mp3" }, 
            { 2.0, "lambdaplayers/weapons/z89/bolt.mp3" }
        },

        islethal = true,
    }

})