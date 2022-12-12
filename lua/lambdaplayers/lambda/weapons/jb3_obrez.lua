local random = math.random
local CurTime = CurTime
local bullettbl = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_obrez = {
        model = "models/lambdaplayers/obrez/w_obrez.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Obrez",
        holdtype = "ar2",
        killicon = "lambdaplayers/killicons/icon_jb3_obrez",
        bonemerge = true,
        keepdistance = 800,
        attackrange = 4500,

        clip = 5,

        reloadtime = 4.6,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.55,
        reloadsounds = { 
            { 0.1, "lambdaplayers/weapons/obrez/boltback.mp3" },
            { 2.0, "lambdaplayers/weapons/obrez/clip.mp3" },
            { 4.0, "lambdaplayers/weapons/obrez/boltforward.mp3" }
        },

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + 2.8

            self:SimpleTimer( 0.5, function() -- Aim that beast
                if !IsValid( target ) then return end

                wepent:EmitSound( "lambdaplayers/weapons/obrez/shoot.mp3", 80 )

                self:HandleMuzzleFlash( 1 )

                bullettbl.Attacker = self
                bullettbl.Damage = 50 -- It stings
                bullettbl.Force = 50
                bullettbl.HullSize = 5
                bullettbl.Num = 1
                bullettbl.TracerName = "ubt_tracer"
                bullettbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
                bullettbl.Src = wepent:GetPos()
                bullettbl.Spread = Vector( 0.07, 0.07, 0 )
                bullettbl.IgnoreEntity = self
                wepent:FireBullets( bullettbl )

                self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )
                self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER )
                
                self:SimpleTimer( 1, function()
                    wepent:EmitSound( "lambdaplayers/weapons/obrez/boltback.mp3", 75, 100, 1, CHAN_WEAPON )
                    self:HandleShellEject( "RifleShellEject", Vector(), Angle(-180, 0, 0) )
                    self:SimpleTimer( 0.6, function()
                        wepent:EmitSound( "lambdaplayers/weapons/obrez/boltforward.mp3", 75, 100, 1, CHAN_WEAPON )
                    end)
                end)

                self.l_Clip = self.l_Clip - 1
            end)

            return true
        end,

        islethal = true,
    }

})