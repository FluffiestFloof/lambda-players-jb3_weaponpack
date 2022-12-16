local random = math.random
local CurTime = CurTime
local bulletInfo = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_xm16e1 = {
        model = "models/lambdaplayers/patriot/w_patriot.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "XM16E1",
        holdtype = "ar2",
        killicon = "lambdaplayers/killicons/icon_jb3_xm16e1",
        bonemerge = true,
        keepdistance = 300,
        attackrange = 1500,

        clip = 9001,

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.85,

        OnEquip = function( lambda, wepent )
            wepent:EmitSound( "lambdaplayers/weapons/patriot/patriotdeploy.mp3", 75, 100, 1, CHAN_WEAPON )
        end,

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end
            
            bulletInfo.Attacker = self
            bulletInfo.Damage = 3
            bulletInfo.Force = 3
            bulletInfo.HullSize = 5
            bulletInfo.Num = 1
            bulletInfo.TracerName = "ubt_tracer"
            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bulletInfo.Src = wepent:GetPos()
            bulletInfo.Spread = Vector( 0.15, 0.15, 0 )
            bulletInfo.IgnoreEntity = self
            
            self.l_WeaponUseCooldown = CurTime() + 0.1

            wepent:EmitSound( "lambdaplayers/weapons/patriot/fire"..random( 1, 4 )..".mp3", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
            
            self:HandleMuzzleFlash( 1 )
            self:HandleShellEject( "RifleShellEject", Vector( -2, 5, 0 ), Angle( 0, 0, -180 ) )

            wepent:FireBullets( bulletInfo )

            return true
        end,

        islethal = true,
    }

})