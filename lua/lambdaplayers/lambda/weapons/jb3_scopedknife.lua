local IsValid = IsValid

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_scopedknife = {
        model = "models/lambdaplayers/scopedknife/w_scopedknife.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Scoped Knife",
        holdtype = "melee",
        killicon = "lambdaplayers/killicons/icon_jb3_scopedknife",
        ismelee = true,
        bonemerge = true,
        keepdistance = 10,
        attackrange = 55,

        damage = 6,
        rateoffire = 0.2,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
        attacksnd = "lambdaplayers/weapons/knife/knife_slash*2*.mp3",
        hitsnd = "Weapon_Crowbar.Melee_Hit",

        islethal = true,
    }

})