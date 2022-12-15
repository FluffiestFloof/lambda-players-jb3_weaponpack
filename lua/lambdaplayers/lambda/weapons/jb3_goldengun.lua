local CurTime = CurTime
local bulletInfo = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_goldengun = {
        model = "models/lambdaplayers/goldengun/w_goldengun.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Golden Gun",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_goldengun",
        bonemerge = true,
        keepdistance = 400,
        attackrange = 2000,

        clip = 1,

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.85,

        callback = function( self, wepent, target )
            self.l_WeaponUseCooldown = CurTime() + 2
            
            bulletInfo.Attacker = self
            bulletInfo.Damage = 9000
            bulletInfo.Force = 1
            bulletInfo.HullSize = 5
            bulletInfo.Num = 1
            bulletInfo.TracerName = "goldengun_laser"
            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bulletInfo.Src = wepent:GetPos()
            bulletInfo.Spread = Vector( 0.10, 0.10, 0 )
            bulletInfo.IgnoreEntity = self
            bulletInfo.Callback = function( attacker, trace, dmginfo )
                if trace.Entity == target then
                    -- TODO: Make the player/lambda target turn to gold.
                    target:EmitSound( "lambdaplayers/weapons/goldengun/hit.mp3", 75 )
                end
            end

            wepent:EmitSound( "lambdaplayers/weapons/goldengun/shoot.mp3", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            wepent:FireBullets( bulletInfo )

            return true
        end,

        islethal = true,
    }

})