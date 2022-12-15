local random = math.random
local util_Effect = util.Effect
local util_ScreenShake = util.ScreenShake
local bit_bor = bit.bor
local CurTime = CurTime

-- Because SoundDuration() doesn't work correctly with .mp3 | God I hate it
local dubTime = { "6.8571882247925", "6.8571882247925", "12.800067901611", "8.2052383422852", "11.03453540802", "7.9465532302856", "15.399024963379", "5.54922914505", "19.200021743774", "13.714330673218", "13.714308738708", "13.714308738708", "6", "13.714308738708", "14.400045394897", "6.9798412322998", "13.714330673218", "13.714308738708", "13.714308738708", "13.714308738708", "12.800067901611", "6.4000678062439", "15.867823600769", "3.75", "6.4000906944275", "9.6999998092651" }

local function IsCharacter( ent )
    return ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()
end

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_dubstepgun = {
        model = "models/lambdaplayers/dubstep/w_dubstep.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Dubstep Gun",
        holdtype = "physgun",
        killicon = "lambdaplayers/killicons/icon_jb3_dubstepgun",
        bonemerge = true,
        keepdistance = 100,
        attackrange = 400,

        clip = 1,

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.85,

        OnEquip = function( lambda, wepent )
            wepent.ResetDub = CurTime()
            wepent.Music = nil
        end,

        OnUnequip = function( lambda, wepent )
            wepent.ResetDub = CurTime()
            if wepent.Music then wepent:StopSound(wepent.Music) end
            wepent.Music = nil
        end,

        -- Stop sound on death
        OnDamage = function( lambda, wepent, dmginfo )
            if wepent.Music and IsValid( lambda ) and dmginfo:GetDamage() > lambda:Health() then
                wepent:StopSound(wepent.Music)
            end
        end,

        OnThink = function( self, wepent )
            -- If we stop 'shooting', stop music
            if CurTime() > wepent.ResetDub and wepent.Music then
                wepent:StopSound(wepent.Music)
                wepent.Music = nil
            end

            return 1
        end,

        callback = function( self, wepent, target )
            self.l_WeaponUseCooldown = CurTime() + 0.4

            local rnd = random( 1, 26 )
            
            -- If we start shooting, music is none so we assign one.
            if wepent.Music == nil then
                rnd = random( 1, 26 )
                wepent.Music = "lambdaplayers/weapons/dubstep/dub"..rnd..".mp3"
                wepent:EmitSound(wepent.Music, 80)

                -- We do a loop in a very disguting way but eh. Only 15 repeat because eh
                self:NamedTimer( "looptyloopDubstep", dubTime[rnd], 15, function()
                    if wepent.Music and IsValid(self) then
                        wepent:EmitSound(wepent.Music, 80)
                    else
                        return true
                    end
                end )
            end

            -- The part where you die
            local effect = EffectData()
                effect:SetOrigin( self:GetPos() )
                effect:SetEntity( self )
                effect:SetScale( 250 )
            util_Effect( "ThumperDust", effect, true, true )
            util_ScreenShake( self:GetPos(), 1000, 100, 1, 500 ) -- Shake screens
            local nearby = self:FindInSphere( nil, 300, function( ent ) return IsCharacter( ent ) end )
            for k, ent in ipairs( nearby ) do
                local range = self:GetRangeTo( ent )
                
                local info = DamageInfo()
                    info:SetAttacker( self )
                    info:SetInflictor( wepent )
                    info:SetDamage( 25 - (0.08*range) )
                    info:SetDamageType( bit_bor( DMG_BLAST, DMG_CLUB ) )
                    info:SetDamagePosition( wepent:GetPos() )
                    ent:TakeDamageInfo( info )
            end

            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_PHYSGUN )

            wepent.ResetDub = self.l_WeaponUseCooldown + 0.45

            return true
        end,

        islethal = true,
    }

})