local util_Effect = util.Effect
local CurTime = CurTime
local bulletInfo = {}

-- Currently act like the JB3 version, hit scan and insta kill but will probably make it a projectile weapon for fun.

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_dilbow = {
        model = "models/weapons/w_crossbow.mdl", -- Not the correct model
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Dilbow",
        holdtype = "crossbow",
        killicon = "lambdaplayers/killicons/icon_jb3_dilbow",
        bonemerge = true,
        keepdistance = 400,
        attackrange = 2000,

        clip = 1,

        reloadtime = 1,
        reloadsounds = { 
            { 0.1, "Weapon_Crossbow.BoltElectrify" }
        },

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + 0.75

            bulletInfo.Attacker = self
            bulletInfo.Damage = 15000
            bulletInfo.Force = 1
            bulletInfo.HullSize = 5
            bulletInfo.Num = 1
            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bulletInfo.Src = wepent:GetPos()
            bulletInfo.Spread = Vector( 0.08, 0.08, 0 )
            bulletInfo.IgnoreEntity = self
            bulletInfo.Callback = function( attacker, trace, dmginfo )
                dmginfo:SetDamageType( DMG_ALWAYSGIB ) 
                
                local muzzle = wepent:GetAttachment( 1 )

                local effect = EffectData()
                    effect:SetStart( muzzle.Pos )
                    effect:SetOrigin( trace.HitPos )
                    effect:SetEntity( wepent )
                    effect:SetScale( 4000 )
                util_Effect( "ToolTracer", effect, true, true)
            end

            wepent:EmitSound( "weapons/crossbow/fire1.wav", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )

            wepent:FireBullets( bulletInfo )

            self.l_Clip = self.l_Clip - 1

            return true
        end,

        islethal = true,
    }

})