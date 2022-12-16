local IsValid = IsValid

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_pistol = {
        model = "models/lambdaplayers/pistol/w_pistol.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Pistol",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_pistol",
        bonemerge = true,
        keepdistance = 500,
        attackrange = 2250,

        clip = 15,
        tracername = "ubt_tracer",
        damage = 5,
        spread = 0.12,
        rateoffire = 0.11,
        muzzleflash = 1,
        shelleject = "ShellEject",
        shelloffpos = Vector( -3, 5, 0 ),
        shelloffang = Angle( -180, 0, 0 ),
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL,
        attacksnd = "lambdaplayers/weapons/pistol/fire1.mp3",

        reloadtime = 1.8,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1,
        reloadsounds = { 
            { 0.0, "lambdaplayers/weapons/pistol/clipout.mp3" }, 
            { 0.34, "lambdaplayers/weapons/pistol/clipin.mp3" },
            { 1.3, "lambdaplayers/weapons/pistol/slideback.mp3" },
            { 1.5, "lambdaplayers/weapons/pistol/slideforward.mp3" }
        },

        islethal = true,
    }

})