local IsValid = IsValid
local bullettbl = {}

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_burstpistol = {
        model = "models/lambdaplayers/burstpistol/w_burstpistol.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Burst Pistol",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_burstpistol",
        bonemerge = true,
        keepdistance = 325,
        attackrange = 2000,


        clip = 15,

        reloadtime = 1.5,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1,
        reloadsounds = { 
            { 0.0, "lambdaplayers/weapons/burstpistol/clipout.mp3" }, 
            { 0.8, "lambdaplayers/weapons/burstpistol/clipin.mp3" },
            { 1.2, "lambdaplayers/weapons/burstpistol/sliderelease.mp3" }
        },

        callback = function( self, wepent, target )
            if self.l_Clip <= 0 then self:ReloadWeapon() return end

            self.l_WeaponUseCooldown = CurTime() + 0.5
            
            bullettbl.Attacker = self
            bullettbl.Damage = 6
            bullettbl.Force = 6
            bullettbl.HullSize = 5
            bullettbl.Num = 1
            bullettbl.TracerName = "ubttracer"
            bullettbl.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
            bullettbl.Src = wepent:GetPos()
            bullettbl.Spread = Vector( 0.05, 0.05, 0 )
            bullettbl.IgnoreEntity = self

            wepent:EmitSound( "lambdaplayers/weapons/burstpistol/fire1.mp3", 75, 100, 1, CHAN_WEAPON )
            self:HandleMuzzleFlash( 1 )
            self:HandleShellEject( "ShellEject", Vector( 1, 4, 0 ), Angle( -90, 0, 0 ) )
            wepent:FireBullets( bullettbl )
            bullettbl.Spread = Vector( 0.06, 0.2, 0 )

            self:SimpleTimer(0.05, function()
                wepent:EmitSound( "lambdaplayers/weapons/burstpistol/fire1.mp3", 75, 100, 1, CHAN_WEAPON )
                self:HandleMuzzleFlash( 1 )
                self:HandleShellEject( "ShellEject", Vector( 1, 4, 0 ), Angle( -90, 0, 0 ) )
                bullettbl.Src = wepent:GetPos()
                wepent:FireBullets( bullettbl )
                bullettbl.Spread = Vector( 0.07, 0.3, 0 )
            end)

            self:SimpleTimer(0.1, function()
                wepent:EmitSound( "lambdaplayers/weapons/burstpistol/fire1.mp3", 75, 100, 1, CHAN_WEAPON )
                self:HandleMuzzleFlash( 1 )
                self:HandleShellEject( "ShellEject", Vector( 1, 4, 0 ), Angle( -90, 0, 0 ) )
                bullettbl.Src = wepent:GetPos()
                wepent:FireBullets( bullettbl )
            end)

            self.l_Clip = self.l_Clip - 3

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            return true
        end,

        islethal = true,
    }

})