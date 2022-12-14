local random = math.random
local CurTime = CurTime
local bulletInfo = {}

-- TODO: Make it non lethal
-- TODO: Make it attack people randomly
-- TODO: Make it trigger taunt/laugh on target if attack from back

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
            
            bulletInfo.Attacker = self
            bulletInfo.Damage = 25
            bulletInfo.Force = 25
            bulletInfo.HullSize = 5
            bulletInfo.Num = 1
            bulletInfo.TracerName = "nil"
            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bulletInfo.Src = wepent:GetPos()
            bulletInfo.Spread = Vector( 0.15, 0.15, 0 )
            bulletInfo.IgnoreEntity = self
            
            self.l_WeaponUseCooldown = CurTime() + 0.8

            wepent:EmitSound( "lambdaplayers/weapons/handgun/shoot"..random( 1, 2 )..".mp3", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            self.l_Clip = self.l_Clip - 1

            wepent:FireBullets( bulletInfo )

            return true
        end,

        islethal = true,
    }

})