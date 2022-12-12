local random = math.random
local TraceLine = util.TraceLine
local util_Effect = util.Effect
local CurTime = CurTime
local bullettbl = {}
local tracetbl = {}

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

        -- Stop sound on death
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

                wepent:EmitSound( "lambdaplayers/weapons/chargerifle/rifle1.mp3", 75 )

                self:HandleMuzzleFlash( 1 )

                bullettbl.Attacker = self
                bullettbl.Damage = 40
                bullettbl.Force = 40
                bullettbl.HullSize = 5
                bullettbl.Num = 1
                bullettbl.TracerName = "Tracer"
                bullettbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
                bullettbl.Src = wepent:GetPos()
                bullettbl.Spread = Vector( 0.08, 0.08, 0 )
                bullettbl.IgnoreEntity = self
                wepent:FireBullets( bullettbl )

                self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )
                self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2 )

                -- self.l_Clip = self.l_Clip - 1
            end)

            return true
        end,

        islethal = true,
    }

})