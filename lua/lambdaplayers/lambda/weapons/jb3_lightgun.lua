local CurTime = CurTime
local bulletInfo = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_lightgun = {
        model = "models/lambdaplayers/lightgun/w_lightgun.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Light Gun",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_lightgun",
        bonemerge = true,
        keepdistance = 400,
        attackrange = 2000,

        clip = 1,

        reloadtime = 1,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1.3,
        reloadsounds = { 
            { 0.4, "lambdaplayers/weapons/lightgun/reload.mp3" }
        },

        OnEquip = function( lambda, wepent )
            wepent:EmitSound( "lambdaplayers/weapons/lightgun/draw.mp3", 75, 100, 1, CHAN_WEAPON )
        end,

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + 0.75
            
            bulletInfo.Attacker = self
            bulletInfo.Damage = 9000
            bulletInfo.Force = 1
            bulletInfo.HullSize = 5
            bulletInfo.Num = 1
            bulletInfo.TracerName = "lightgun_laser"
            bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bulletInfo.Src = wepent:GetPos()
            bulletInfo.Spread = Vector( 0.12, 0.12, 0 )
            bulletInfo.IgnoreEntity = self
            bulletInfo.Callback = function( attacker, trace, dmginfo )
                dmginfo:SetDamageType( DMG_DISSOLVE )

                if trace.Entity == target then
                    target:EmitSound( "lambdaplayers/weapons/lightgun/hit.mp3", 75 )
                end
            end

            wepent:EmitSound( "lambdaplayers/weapons/lightgun/shoot.mp3", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            wepent:FireBullets( bulletInfo )

            self.l_Clip = self.l_Clip - 1

            return true
        end,

        islethal = true,
    }

})