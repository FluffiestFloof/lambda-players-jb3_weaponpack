local random = math.random
local CurTime = CurTime
local util_Effect = util.Effect
local Clamp = math.Clamp
local bulletInfo = {}

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
                wepent:EmitSound( "lambdaplayers/weapons/plasmaar/lastshot.mp3", 85, 100, 1, CHAN_WEAPON )
            end
            wepent.BulletSpent = wepent.BulletSpent + 1

            local spred = Clamp( (  wepent.BulletSpent * 0.001 ) , 0.05, 0.2 )

            bulletInfo.Attacker = self
            bulletInfo.Damage = 2
            bulletInfo.Force = 2
            bulletInfo.HullSize = 5
            bulletInfo.Num = 1
            bulletInfo.TracerName = "plasmagun_laser"
            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bulletInfo.Src = wepent:GetPos()
            bulletInfo.Spread = Vector( spred, spred, 0 )
            bulletInfo.IgnoreEntity = self
            bulletInfo.Callback = function( attacker, trace, dmginfo )
                dmginfo:SetDamageType( DMG_DISSOLVE )

                local effect = EffectData()
                    effect:SetStart( trace.HitPos )
                    effect:SetOrigin( trace.HitPos )
                    effect:SetEntity( trace.Entity )
                    effect:SetNormal( trace.HitNormal )
                util_Effect( "HL1GaussWallImpact1", effect, true, true)
            end
            
            self.l_WeaponUseCooldown = CurTime() + Clamp( ( 1 / ( wepent.BulletSpent ) ), 0.004, 0.4 )

            wepent:EmitSound( "lambdaplayers/weapons/plasmaar/plasma"..random( 1, 8 )..".mp3", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
            
            self:HandleMuzzleFlash( 5 )

            wepent:FireBullets( bulletInfo )

            wepent.ResetPew = self.l_WeaponUseCooldown + 0.2

            self.l_Clip = self.l_Clip - 1

            return true
        end,

        islethal = true,
    }

})