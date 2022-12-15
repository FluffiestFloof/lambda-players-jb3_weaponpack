local random = math.random
local Rand = math.Rand
local IsValid = IsValid
local CurTime = CurTime

-- Not JB3 accurate. This is melee oriented just because it adds variety.

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_foullanguage = {
        model = "",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Foul Language",
        holdtype = "pistol",
        killicon = "lambdaplayers/killicons/icon_jb3_foullanguage",
        bonemerge = true,
        nodraw = true,
        ismelee = true,
        keepdistance = 60,
        attackrange = 120,

        clip = 1,

        reloadtime = 1.5,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 1,

        callback = function( self, wepent, target )
            self.l_WeaponUseCooldown = CurTime() + Rand( 2, 3 )

            local fuckyou = "lambdaplayers/weapons/foullanguage/fuckyou"..random( 1, 8 )..".wav"
            
            self:EmitSound( fuckyou, 80, 100 )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL )

            self:SimpleTimer( SoundDuration(fuckyou), function()
                if !IsValid( target ) or !self:IsInRange( target, 150 ) then return end

                local dmginfo = DamageInfo()
                dmginfo:SetDamage( 5000 )
                dmginfo:SetAttacker( self )
                dmginfo:SetInflictor( wepent )
                dmginfo:SetDamageType( DMG_BURN ) -- Sick burn.
                dmginfo:SetDamageForce( Vector( 0, 0, 0 ) )
                target:TakeDamageInfo( dmginfo )
            end)

            return true
        end,

        islethal = true,
    }

})