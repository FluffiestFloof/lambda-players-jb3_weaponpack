local random = math.random
local TraceLine = util.TraceLine
local util_Effect = util.Effect
local CurTime = CurTime
local bulletInfo = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_chargerifle = {
        model = "models/lambdaplayers/chargerifle/w_chargerifle.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Charge Rifle",
        holdtype = "ar2",
        killicon = "lambdaplayers/killicons/icon_jb3_chargerifle",
        bonemerge = true,
        keepdistance = 750,
        attackrange = 4250,

        clip = 50, -- 50 max shots then should switch but eh

        -- Prevent the speed debuff from carrying on if dies
        OnDamage = function( lambda, wepent, dmginfo )
            if IsValid( lambda ) and dmginfo:GetDamage() > lambda:Health() then
                lambda.l_WeaponSpeedMultiplier = 0
            end
        end,

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + 3
            self.l_WeaponSpeedMultiplier = -300

            self:SimpleTimer( 2, function()
                if !IsValid( target ) then self.l_WeaponSpeedMultiplier = 0 return end
                self.l_WeaponSpeedMultiplier = 0

                wepent:EmitSound( "lambdaplayers/weapons/chargerifle/rifle1.mp3", 80, 100, 1, CHAN_WEAPON )

                self:HandleMuzzleFlash( 1 )

                bulletInfo.Attacker = self
                bulletInfo.Damage = 40
                bulletInfo.Force = 40
                bulletInfo.HullSize = 5
                bulletInfo.Num = 1
                bulletInfo.TracerName = "ubt_tracer"
                bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
                bulletInfo.Src = wepent:GetPos()
                bulletInfo.Spread = Vector( 0.08, 0.08, 0 )
                bulletInfo.IgnoreEntity = self
                wepent:FireBullets( bulletInfo )

                self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
                self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )

                -- self.l_Clip = self.l_Clip - 1
            end)

            return true
        end,

        islethal = true,
    }

})