local IsValid = IsValid
local CurTime = CurTime
local ents_Create = ents.Create

table.Merge( _LAMBDAPLAYERSWEAPONS, {

    jb3_nailgun = {
        model = "models/lambdaplayers/nailgun/w_nailgun.mdl",
        origin = "Jabroni Brawl: Episode 3",
        prettyname = "Nailgun",
        holdtype = "ar2",
        killicon = "lambdaplayers/killicons/icon_jb3_nailgun",
        bonemerge = true,
        keepdistance = 325,
        attackrange = 1500,

        clip = 200, -- Should run out after 200 and change weapon but eh

        callback = function( self, wepent, target )
            local nail = ents_Create( "jb3_nail" )
            if !IsValid( nail ) then return end

            self.l_WeaponUseCooldown = CurTime() + 0.1
            self:RemoveGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 )
            self:AddGesture( ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1 )

            local spawnAttach = wepent:GetAttachment(2)
            local targetAng = ( target:WorldSpaceCenter() - wepent:GetPos() ):Angle()

            wepent:EmitSound( "lambdaplayers/weapons/nailgun/shoot.mp3", 80 )
            nail:SetPos( wepent:GetAttachment(2).Pos + targetAng:Forward() * 18 + targetAng:Up() * 5 + targetAng:Right() * -1.5 )
            nail:SetAngles( ( target:WorldSpaceCenter() - nail:GetPos() ):Angle() )
            nail:SetOwner( self )
            nail:Spawn()

            nail:GetPhysicsObject():ApplyForceCenter( ( target:WorldSpaceCenter() - self:EyePos() ):Angle():Forward()*5000 )
            
            return true
        end,

        islethal = true,
    }

})