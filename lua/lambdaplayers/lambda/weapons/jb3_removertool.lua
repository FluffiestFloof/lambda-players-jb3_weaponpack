local random = math.random
local TraceLine = util.TraceLine
local util_Effect = util.Effect
local CurTime = CurTime
local bullettbl = {}
local tracetbl = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_removertool = {
        model = "models/weapons/w_toolgun.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Remover Tool",
        holdtype = "revolver",
        killicon = "lambdaplayers/killicons/icon_jb3_removertool",
        bonemerge = true,
        keepdistance = 400,
        attackrange = 2000,

        clip = 1,

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.85,

        callback = function( self, wepent, target )
            wepent:EmitSound( "npc/turret_floor/click1.wav", 80 )
            self:SimpleTimer( 1, function()
                if !IsValid( target ) then return end
                bullettbl.Attacker = self
                bullettbl.Damage = 9000
                bullettbl.Force = 1
                bullettbl.HullSize = 5
                bullettbl.Num = 1
                bullettbl.AmmoType = "AR2AltFire"
                bullettbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
                bullettbl.Src = wepent:GetPos()
                bullettbl.Spread = Vector( 0, 0, 0 ) -- Yep, they don't miss.
                bullettbl.IgnoreEntity = self

                local muzzle = wepent:GetAttachment( 1 )

                tracetbl.start = muzzle.Pos
                tracetbl.endpos = target:WorldSpaceCenter()
                tracetbl.filter = self
                
                local result = TraceLine( tracetbl )

                local effect = EffectData()
                effect:SetStart( muzzle.Pos )
                effect:SetOrigin( result.HitPos )
                effect:SetEntity( wepent )
                effect:SetScale( 4000 )
                util_Effect( "ToolTracer", effect, true, true)

                local effect = EffectData()
                effect:SetStart( result.HitPos )
                effect:SetOrigin( result.HitPos )
                effect:SetEntity( result.Entity )
                effect:SetNormal( result.HitNormal )
                util_Effect( "selection_indicator", effect, true, true)

                wepent:EmitSound( "weapons/airboat/airboat_gun_lastshot" .. random( 1, 2 ) .. ".wav", 80 )

                self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )
                self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )

                wepent:FireBullets( bullettbl )
            end )
            self.l_WeaponUseCooldown = CurTime() + 5

            return true
        end,

        islethal = true,
    }

})