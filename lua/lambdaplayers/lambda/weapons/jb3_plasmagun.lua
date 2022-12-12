local random = math.random
local CurTime = CurTime
local util_Effect = util.Effect
local Clamp = math.Clamp
local bullettbl = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_plasmagun = {
        model = "models/lambdaplayers/plasmagun/w_plasmagun.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Plasma Rifle",
        holdtype = "ar2",
        killicon = "lambdaplayers/killicons/icon_jb3_plasmagun",
        bonemerge = true,
        keepdistance = 300,
        attackrange = 1500,

        clip = 500,

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.85,

        OnEquip = function( lambda, wepent )
            wepent.FirstShot = true
            wepent.ResetPew = CurTime()
        end,

        OnUnequip = function( lambda, wepent )
            wepent.FirstShot = nil
        end,

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end
            if CurTime() > wepent.ResetPew then
                wepent.FirstShot = true
                wepent.BulletSpent = 0
                wepent:EmitSound( "lambdaplayers/weapons/plasmaar/lastshot.mp3", 85 )
            end
            wepent.BulletSpent = wepent.BulletSpent + 1

            local spred = Clamp( ( 0.05 + ( wepent.BulletSpent * 0.001 )) , 0.05, 0.2 )

            bullettbl.Attacker = self
            bullettbl.Damage = 2
            bullettbl.Force = 2
            bullettbl.HullSize = 5
            bullettbl.Num = 1
            bullettbl.TracerName = "demon_tracer_laser"
            bullettbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bullettbl.Src = wepent:GetPos()
            bullettbl.Spread = Vector( 0.05+spred, spred*2, 0 )
            bullettbl.IgnoreEntity = self
            
            self.l_WeaponUseCooldown = CurTime() + Clamp( ( 1 / ( wepent.BulletSpent ) ), 0.005, 0.1 )

            wepent:EmitSound( "lambdaplayers/weapons/plasmaar/plasma"..random( 1, 8 )..".mp3", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
            
            self:HandleMuzzleFlash( 5 )

            wepent:FireBullets( bullettbl )

            wepent.ResetPew = self.l_WeaponUseCooldown + 0.2

            self.l_Clip = self.l_Clip - 1

            return true
        end,

        islethal = true,
    }

})