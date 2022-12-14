local IsValid = IsValid
local CurTime = CurTime
local Effect = util.Effect
local BlastDamage = util.BlastDamage

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_rocketcrowbar = {
        model = "models/lambdaplayers/rocketcrowbar/w_rocketcrowbar.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Rocket Crowbar",
        holdtype = "melee",
        killicon = "lambdaplayers/killicons/icon_jb3_explodbar",
        ismelee = true,
        bonemerge = true,
        keepdistance = 10,
        attackrange = 55,

        callback = function( self, wepent, target )
            self.l_WeaponUseCooldown = CurTime() + 0.65

            wepent:EmitSound( "Weapon_Crowbar.Single", 70 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE )

            self:SimpleTimer( 0.1, function()
                if !IsValid( target ) or self:GetRangeSquaredTo( target ) > ( 55 * 55 ) then return end

                local effectData = EffectData()
                effectData:SetOrigin( wepent:GetPos() )
                Effect( "Explosion", effectData, true, true )

                BlastDamage( wepent, self, wepent:GetPos(), 300, 20 )
                wepent:EmitSound( "BaseExplosionEffect.Sound", 85, 100, 1, CHAN_WEAPON )

                local dmginfo = DamageInfo()
                dmginfo:SetDamage( 10 )
                dmginfo:SetAttacker( self )
                dmginfo:SetInflictor( wepent )
                dmginfo:SetDamageType( DMG_CLUB )
                dmginfo:SetDamageForce( ( target:WorldSpaceCenter() - self:WorldSpaceCenter() ):GetNormalized() * 10 )
                target:TakeDamageInfo( dmginfo )

                wepent:EmitSound( "Weapon_Crowbar.Melee_Hit", 80, 100, 1, CHAN_WEAPON )
            end)

            return true
        end,

        islethal = true,
    }

})