local IsValid = IsValid

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_doublebarrel = {
        model = "models/lambdaplayers/doublebarrel/w_doublebarrel.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Double Barrel Shotgun",
        holdtype = "shotgun",
        killicon = "lambdaplayers/killicons/icon_jb3_doublebarrel",
        bonemerge = true,
        keepdistance = 550,
        attackrange = 3500,
        offpos = Vector( 0, 0, -3 ),

        clip = 2,
        tracername = "Tracer",
        damage = 7,
        spread = 0.12,
        rateoffire = 0.3,
        muzzleflash = 1,
        shelleject = "none",
        bulletcount = 12,
        attackanim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
        attacksnd = "lambdaplayers/weapons/doublebarrel/fire_placeholder.mp3",

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        reloadanimspeed = 0.9,
        reloadsounds = { 
            { 0.2, "lambdaplayers/weapons/doublebarrel/deploy_2.mp3" }, 
            { 1.0, "lambdaplayers/weapons/doublebarrel/shotgun_reload2.mp3" }, 
            { 2.0, "lambdaplayers/weapons/doublebarrel/deploy_1.mp3" }
        },

        OnEquip = function( lambda, wepent )
            wepent:EmitSound( "lambdaplayers/weapons/doublebarrel/deploy_2.mp3" )
        end,
        
        OnReload = function( self, wepent )
            self:SimpleTimer( 0.2, function() 
                if self.l_Weapon != "jb3_doublebarrel" or !IsValid( wepent ) then return end
                for i = 1, 2 do self:HandleShellEject( "ShotgunShellEject" ) end
            end )
        end,

        islethal = true,
    }

})