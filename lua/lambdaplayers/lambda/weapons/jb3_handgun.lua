local random = math.random
local CurTime = CurTime
local bullettbl = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_handgun = {
        model = "",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Hand Gun",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_handgun",
        bonemerge = true,
        nodraw = true,
        keepdistance = 400,
        attackrange = 1750,

        clip = 8,

        reloadtime = 1.5,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1,
        reloadsounds = { 
            { 0.3, "lambdaplayers/weapons/handgun/reload"..random( 1, 2 )..".mp3" }
        },

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end
            
            bullettbl.Attacker = self
            bullettbl.Damage = 25
            bullettbl.Force = 25
            bullettbl.HullSize = 5
            bullettbl.Num = 1
            bullettbl.TracerName = "none"
            bullettbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bullettbl.Src = wepent:GetPos()
            bullettbl.Spread = Vector( 0.17, 0.17, 0 )
            bullettbl.IgnoreEntity = self
            
            self.l_WeaponUseCooldown = CurTime() + 0.8

            wepent:EmitSound( "lambdaplayers/weapons/handgun/shoot"..random( 1, 2 )..".mp3", 80 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            self.l_Clip = self.l_Clip - 1

            wepent:FireBullets( bullettbl )

            return true
        end,

        islethal = true,
    }

})