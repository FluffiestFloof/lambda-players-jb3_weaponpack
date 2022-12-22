local IsValid = IsValid
local CurTime = CurTime
local Rand = math.Rand
local random = math.random
local bulletData = {
    Damage = 5,
    Force = 5,
    HullSize = 5,
    Num = 1,
    TracerName = "ubt_tracer",
    Spread = Vector( 0.11, 0.11, 0 )
}

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

        reloadtime = 1.8,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1,
        reloadsounds = { 
            { 0.0, "lambdaplayers/weapons/pistol/clipout.mp3" }, 
            { 0.34, "lambdaplayers/weapons/pistol/clipin.mp3" },
            { 1.3, "lambdaplayers/weapons/pistol/slideback.mp3" },
            { 1.5, "lambdaplayers/weapons/pistol/slideforward.mp3" }
        },

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + Rand( 0.11, 0.15 )

            bulletData.Attacker = self
            bulletData.IgnoreEntity = self
            bulletData.Src = wepent:GetPos()
            bulletData.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()

            wepent:EmitSound( "lambdaplayers/weapons/pistol/fire1.mp3", 80, random(99,101), 1, CHAN_WEAPON )
            self:HandleMuzzleFlash( 1 )
            self:HandleShellEject( "ShellEject", Vector( -3, 5, 0 ), Angle( -180, 0, 0 ) )
            wepent:FireBullets( bulletData )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            self.l_Clip = self.l_Clip - 1

            return true
        end,

        islethal = true,
    }

})