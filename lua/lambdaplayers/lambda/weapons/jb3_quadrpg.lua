local random = math.random
local ents_Create = ents.Create
local util_BlastDamage = util.BlastDamage
local CurTime = CurTime

local function ShootRocket( lambda, wepent, target, posup, posright )
    local rocket = ents_Create( "m202_rocket" )
    if !IsValid( rocket ) then return end

    local spawnAttach = wepent:GetAttachment(2)
    local targetAng = ( target:WorldSpaceCenter() - wepent:GetPos() ):Angle()
    
    wepent:EmitSound( "lambdaplayers/weapons/quadrpg/fire.mp3", 80, 100, 1, CHAN_WEAPON )
    
    rocket:SetPos( wepent:GetAttachment(2).Pos + targetAng:Up() * posup + targetAng:Right() * posright )
    rocket:SetAngles( ( target:WorldSpaceCenter() - rocket:GetPos() ):Angle()+ AngleRand( -2, 2) )
    rocket:SetOwner( lambda )
    rocket:SetAbsVelocity( lambda:GetForward() * 300 + Vector( 0, 0, 128 ) )
    rocket:Spawn()
    
    lambda:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG )
    lambda:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG )
end

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_quadrpg = {
        model = "models/lambdaplayers/quadrpg/w_quadrpg.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Quad Rocket Launcher",
        holdtype = "rpg",
        killicon = "lambdaplayers/killicons/icon_jb3_quadrpg",
        bonemerge = true,
        keepdistance = 600,
        attackrange = 3500,

        clip = 4,

        reloadtime = 2.3,
        reloadanim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        reloadanimspeed = 0.85,

        callback = function( self, wepent, target )
            self.l_WeaponUseCooldown = CurTime() + 5

            self:SimpleTimer( 0.18, function()
                ShootRocket( self, wepent, target, 2.5, 2.5 )
            end)
            self:SimpleTimer( 0.36, function()
                ShootRocket( self, wepent, target, 2.5, -2.5 )
            end)
            self:SimpleTimer( 0.54, function()
                ShootRocket( self, wepent, target, -2.5, 2.5 )
            end)
            self:SimpleTimer( 0.72, function()
                ShootRocket( self, wepent, target, -2.5, -2.5 )
            end)

            return true
        end,

        islethal = true,
    }

})