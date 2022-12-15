table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_umbrella = {
        model = "models/lambdaplayers/umbrella/w_umbrella.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Umbrella",
        holdtype = "melee",
        killicon = "lambdaplayers/killicons/icon_jb3_umbrella",
        ismelee = true,
        bonemerge = true,
        keepdistance = 10,
        attackrange = 55,

        damage = 10,
        rateoffire = 0.4,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
        attacksnd = "Weapon_Crowbar.Single",
        hitsnd = "lambdaplayers/weapons/umbrella/hit*3*.mp3",

        islethal = true,
    }

})