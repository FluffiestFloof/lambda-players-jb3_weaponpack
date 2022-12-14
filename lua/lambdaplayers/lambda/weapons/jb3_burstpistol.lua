local IsValid = IsValid
local bulletInfo = {
    Damage = 6,
    Force = 6,
    HullSize = 5,
    Num = 1,
    TracerName = "ubt_tracer"
}

local function ShootGun( lambda, wepent, target, sprx, spry )
    local sprx = sprx or 0
    local spry = spry or 0
    bulletInfo.Attacker = lambda
    bulletInfo.Dir = ( target:WorldSpaceCenter() - wepent:GetPos() ):GetNormalized()
    bulletInfo.Src = wepent:GetPos()
    bulletInfo.Spread = Vector( 0.05+sprx, 0.05+spry, 0 )
    bulletInfo.IgnoreEntity = lambda

    wepent:EmitSound( "lambdaplayers/weapons/burstpistol/fire1.mp3", 75, 100, 1, CHAN_WEAPON )
    lambda:HandleMuzzleFlash( 1 )
    lambda:HandleShellEject( "ShellEject", Vector( 1, 4, 0 ), Angle( -90, 0, 0 ) )
    wepent:FireBullets( bulletInfo )
    
    lambda.l_Clip = lambda.l_Clip - 1
end

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

            ShootGun( self, wepent, target )

            self:SimpleTimer(0.05, function()
                ShootGun( self, wepent, target, 0.01, 0.05 )
            end)

            self:SimpleTimer(0.1, function()
                ShootGun( self, wepent, target, 0.03, 0.15 )
            end)

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            return true
        end,

        islethal = true,
    }

})