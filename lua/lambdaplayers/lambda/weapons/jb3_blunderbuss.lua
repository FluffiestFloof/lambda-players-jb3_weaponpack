local IsValid = IsValid
local CurTime = CurTime
local util_BlastDamage = util.BlastDamage
local random = math.random
local ents_Create = ents.Create

table.Merge( _LAMBDAPLAYERSWEAPONS, {
-- TO FIX OR IGNORE, KINDA WORKS

    jb3_blunderbuss = {
        model = "models/lambdaplayers/blunderbuss/w_blunderbuss.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Melon Blunderbuss",
        holdtype = "shotgun",
        killicon = "lambdaplayers/killicons/icon_jb3_blunderbus",
        bonemerge = true,
        keepdistance = 800,
        attackrange = 5000,

        clip = 1,

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        reloadanimspeed = 0.85,
        reloadsounds = { 
            { 0, "lambdaplayers/weapons/blunderbuss/grenade_launcher_latchopen.mp3" },
            { 0.5, "lambdaplayers/weapons/blunderbuss/rainstick.mp3" },
            { 1.8, "lambdaplayers/weapons/blunderbuss/grenade_launcher_actionclosed.mp3" }
        },

        callback = function( self, wepent, target )
            local ent = ents.Create( "prop_physics" )
            if !IsValid( ent ) then return end

            self.l_WeaponUseCooldown = CurTime() + 3

            wepent:EmitSound( "lambdaplayers/weapons/blunderbuss/fire.mp3", 80, 100, 1, CHAN_WEAPON )

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW )

            local vecThrow = ( target:WorldSpaceCenter() - self:EyePos() ):Angle()
            ent:SetModel( "models/props_junk/watermelon01.mdl" )
            ent:SetPos( self:EyePos() + vecThrow:Forward() * 32 + vecThrow:Up() * 16 )
            ent:SetAngles( vecThrow )
            ent:SetOwner( self )
            ent:Spawn()
            
            self.l_Clip = self.l_Clip - 1

            local velocity = vecThrow:Forward()

            velocity = velocity * 50000
            velocity = velocity + ( VectorRand() * 500 )
            ent:GetPhysicsObject():ApplyForceCenter( velocity )

            local propCallback = ent:AddCallback('PhysicsCollide', function( ent, data )
                local dmg = data.HitSpeed:Length()
                if IsValid( ent ) and IsValid( data.HitEntity ) and data.HitEntity != self and dmg >= 750 then
                    local propDmg = DamageInfo()
                    propDmg:SetDamage( dmg )
                    propDmg:SetInflictor( IsValid( wepent ) and wepent or ent )
                    propDmg:SetAttacker( IsValid(self) and self or ent )
                    propDmg:SetDamageType( DMG_CRUSH )
                    data.HitEntity:TakeDamageInfo( propDmg )
                    if data.HitEntity:IsPlayer() or data.HitEntity.IsLambdaPlayer or data.HitEntity:IsNPC() then
                        data.HitEntity:EmitSound( "lambdaplayers/weapons/blunderbuss/hitinthemelon.mp3", 80, random(95, 102) )
                    end
                end
            end)
            timer.Simple( 5, function() if IsValid( ent ) then ent:RemoveCallback('PhysicsCollide', propCallback) end end)
            timer.Simple( 20, function() if IsValid( ent ) then ent:Remove() end end)

            return true
        end,

        islethal = true,
    }

})