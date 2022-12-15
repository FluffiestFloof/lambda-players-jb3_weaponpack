local random = math.random
local util_Effect = util.Effect
local CurTime = CurTime
local bulletInfo = {}

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
            self.l_WeaponUseCooldown = CurTime() + 3

            bulletInfo.Attacker = self
            bulletInfo.Damage = 5000
            bulletInfo.Force = 1
            bulletInfo.HullSize = 5
            bulletInfo.Num = 1
            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bulletInfo.Src = wepent:GetPos()
            bulletInfo.Spread = Vector( 0.08, 0.08, 0 )
            bulletInfo.IgnoreEntity = self
            bulletInfo.Callback = function( attacker, trace, dmginfo )
                dmginfo:SetDamageType( DMG_REMOVENORAGDOLL ) 
                
                local muzzle = wepent:GetAttachment( 1 )

                local effect = EffectData()
                    effect:SetStart( muzzle.Pos )
                    effect:SetOrigin( trace.HitPos )
                    effect:SetEntity( wepent )
                    effect:SetScale( 4000 )
                util_Effect( "ToolTracer", effect, true, true)

                local effect = EffectData()
                    effect:SetStart( trace.HitPos )
                    effect:SetOrigin( trace.HitPos )
                    effect:SetEntity( trace.Entity )
                    effect:SetNormal( trace.HitNormal )
                util_Effect( "selection_indicator", effect, true, true)

                if trace.Entity == target then
                    local effect = EffectData()
                        effect:SetOrigin( target:WorldSpaceCenter() )
                        effect:SetMagnitude( 1 )
                        effect:SetScale( 2 )
                        effect:SetRadius( 4 )
                        effect:SetEntity( target )
                    util_Effect( "entity_remove", effect, true, true )

                    -- Simulate deleting the entity by preventing ragdoll
                    if target:IsPlayer() then
                        self:Hook( "PlayerDeath", "JB3RemoverTool", function( victim, inflictor, attacker )
                            if target == victim and wepent == inflictor and self == attacker then
                                target:GetRagdollEntity():Remove()
                            end
                            return false
                        end)
                    end
                end
            end

            wepent:EmitSound( "weapons/airboat/airboat_gun_lastshot" .. random( 1, 2 ) .. ".wav", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )

            wepent:FireBullets( bulletInfo )

            return true
        end,

        islethal = true,
    }

})