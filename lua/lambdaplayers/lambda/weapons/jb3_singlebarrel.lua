table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_singlebarrel = {
        model = "models/lambdaplayers/singlebarrel/w_singlebarrel.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Single Barrel Shotgun",
        holdtype = "shotgun",
        killicon = "lambdaplayers/killicons/icon_jb3_singlebarrel",
        bonemerge = true,
        keepdistance = 350,
        attackrange = 1000,

        clip = 8,
        tracername = "ubt_tracer",
        damage = 6,
        spread = 0.10,
        rateoffire = 0.35,
        muzzleflash = 1,
        bulletcount = 4,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        attacksnd = "lambdaplayers/weapons/singlebarrel/fire1.mp3",

        reloadtime = 3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        reloadanimspeed = 1,
        --[[reloadsounds = { 
            { 0.0, "lambdaplayers/weapons/singlebarrel/pump_out.mp3" }, 
            { 0.3, "lambdaplayers/weapons/singlebarrel/shell_in1.mp3" }, 
            { 0.6, "lambdaplayers/weapons/singlebarrel/shell_in2.mp3" }, 
            { 0.9, "lambdaplayers/weapons/singlebarrel/shell_in3.mp3" }, 
            { 1.2, "lambdaplayers/weapons/singlebarrel/shell_in2.mp3" }, 
            { 1.5, "lambdaplayers/weapons/singlebarrel/shell_in2.mp3" }, 
            { 1.8, "lambdaplayers/weapons/singlebarrel/shell_in1.mp3" }, 
            { 2.1, "lambdaplayers/weapons/singlebarrel/shell_in3.mp3" }, 
            { 2.4, "lambdaplayers/weapons/singlebarrel/shell_in2.mp3" }, 
            { 2.8, "lambdaplayers/weapons/singlebarrel/pump_in.mp3" }
        },]]

        islethal = true,
    }

})