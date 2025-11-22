local self = {}
Normals={}
Walls={}

function CleanUp()
for i=1,#Normals do
Normals[i].Remove()
end
for i=1,#bs.platforms do
bs.platforms[i].Remove()
end
for i = #gb.blasters, 1, -1 do
            gb.blasters[i].Destroy()
        end
end

function Spawn(Sprite,Sx,Sy,Rot,MoveX,MoveY,KeepRot,color,masked)  --普通骨头（贴图，X，Y，旋转角度，X轴速度，Y轴速度，连续转动速度，颜色，是否遮挡）
Bone=CreateProjectile("Bones/".. Sprite .."",Sx,Sy)
Bone.sprite.rotation=Rot
Bone.SetVar("velx",MoveX)
Bone.SetVar("vely",MoveY)
Bone.SetVar("roting",KeepRot)
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
table.insert(Normals,Bone)
return Bone
end

function Angle(Sprite,Sx,Sy,Angle,masked,Speed,color)  --角度移动（贴图，X，Y，角度，是否遮挡，运动速度，颜色）
Bone=CreateProjectile("Bones/".. Sprite .."",Sx,Sy)
Bone.sprite.rotation=Angle
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
Bone.SetVar("velx",Speed*math.cos(math.rad(Bone.sprite.rotation+90)))
Bone.SetVar("vely",Speed*math.cos(math.rad(Bone.sprite.rotation)))
table.insert(Normals,Bone)
end

function Target(Sprite,Sx,Sy,masked,ReachTime,color,Tx,Ty,rot)  --定点射击（贴图，X，Y，是否遮挡，速度(其实就是到达目标坐标的时间），颜色，目标X，目标Y）
Bone=CreateProjectile("Bones/".. Sprite .."",Sx,Sy)
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
Bone.SetVar("velx",(Tx-Sx)/ReachTime) --到达目标坐标的时间单位--帧
Bone.SetVar("vely",(Ty-Sy)/ReachTime)
Angle=-(Ty-Sy)/(Tx-Sx)*90
Bone.SetVar("roting",rot)
Bone.sprite.rotation=((Tx-Sx)/(Ty-Sy))*90
table.insert(Normals,Bone)
end

function SpawnAbs(Sprite,Sx,Sy,Rot,MoveX,MoveY,KeepRot,color,masked)  --普通骨头（贴图，X，Y，旋转角度，X轴速度，Y轴速度，连续转动速度，颜色，是否遮挡）
Bone=CreateProjectileAbs("Bones/".. Sprite .."",Sx,Sy)
Bone.sprite.rotation=Rot
Bone.SetVar("velx",MoveX)
Bone.SetVar("vely",MoveY)
Bone.SetVar("roting",KeepRot)
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
table.insert(Normals,Bone)
return Bone
end

function AngleAbs(Sprite,Sx,Sy,Angle,masked,Speed,color)  --角度移动（贴图，X，Y，角度，是否遮挡，运动速度，颜色）
Bone=CreateProjectileAbs("Bones/".. Sprite .."",Sx,Sy)
Bone.sprite.rotation=Angle
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
Bone.SetVar("velx",Speed*math.cos(math.rad(Bone.sprite.rotation+90)))
Bone.SetVar("vely",Speed*math.cos(math.rad(Bone.sprite.rotation)))
table.insert(Normals,Bone)
end

function TargetAbs(Sprite,Sx,Sy,masked,ReachTime,color,Tx,Ty)  --定点射击（贴图，X，Y，是否遮挡，速度(其实就是到达目标坐标的时间），颜色，目标X，目标Y）
Bone=CreateProjectileAbs("Bones/".. Sprite .."",Sx,Sy)
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
Bone.SetVar("velx",(Tx-Sx)/ReachTime) --到达目标坐标的时间单位--帧
Bone.SetVar("vely",(Ty-Sy)/ReachTime)
Angle=-(Ty-Sy)/(Tx-Sx)*90
Bone.sprite.rotation=((Tx-Sx)/(Ty-Sy))*90
Bone.SetVar("roting",rot)
table.insert(Normals,Bone)
end

function Cross(Sprite,Sx,Sy,masked,RotSpeed,color,movex,movey)
Bone=CreateProjectile("Bones/".. Sprite .."",Sx,Sy)
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
Bone.SetVar("roting",RotSpeed)
Bone.SetVar("velx",movex)
Bone.SetVar("vely",movey)
table.insert(Normals,Bone)
Bone=CreateProjectile("Bones/".. Sprite .."",Sx,Sy)
Bone.SetVar("color",color)
Bone.sprite.rotation=90
Bone.SetVar("mask",masked)
Bone.SetVar("roting",RotSpeed)
Bone.SetVar("velx",movex)
Bone.SetVar("vely",movey)
table.insert(Normals,Bone)
end

function CrossT(Sprite,Sx,Sy,masked,RotSpeed,color,Tx,Ty,Time)
Bone=CreateProjectileAbs("Bones/".. Sprite .."",Sx,Sy)
Bone.SetVar("color",color)
Bone.SetVar("mask",masked)
Bone.SetVar("roting",RotSpeed)
Bone.SetVar("velx",(Tx-Sx)/Time) --到达目标坐标的时间单位--帧
Bone.SetVar("vely",(Ty-Sy)/Time)
table.insert(Normals,Bone)
Bone=CreateProjectileAbs("Bones/".. Sprite .."",Sx,Sy)
Bone.SetVar("color",color)
Bone.sprite.rotation=90
Bone.SetVar("mask",masked)
Bone.SetVar("roting",RotSpeed)
Bone.SetVar("velx",(Tx-Sx)/Time) --到达目标坐标的时间单位--帧
Bone.SetVar("vely",(Ty-Sy)/Time)
table.insert(Normals,Bone)
end

function Wall(X,colora)
Wall=CreateProjectile("mask",X,0)
Wall.SetVar("color",colora)
Wall.sprite.yscale=29838
Wall.sprite.xscale=6
Wall.sprite.SetParent(mask)
table.insert(Walls,Wall)
table.insert(Normals,Wall)
end

function BoneMoveTo(Name,PosX,PosY)
Name.MoveTo(PosX,PosY)
end

function self.update()
for i=1,#Walls do
Wall=Walls[i]
local color=Wall.GetVar("color")
if color=="blocker" then
if Player.absx+Player.sprite.width/2<=Wall.absx-2 and Player.absx+Player.sprite.width/2>=Wall.absx-3 then
Player.MoveToAbs(Wall.absx-3.1,Player.absy)
end
if Player.absx-Player.sprite.width/2>=Wall.absx+2 and Player.absx-Player.sprite.width/2<=Wall.absx+3 then
Player.MoveToAbs(Wall.absx+3.1,Player.absy)
end
end
end
for i=1,#Normals do
local bullet=Normals[i]
local color=bullet.GetVar("color")
if bullet.isactive then
if bullet.GetVar("velx")==nil then
bullet.SetVar("velx",0)
end
if bullet.GetVar("rot")==nil then
bullet.SetVar("rot",0)
end
if bullet.GetVar("roting")==nil then
bullet.SetVar("roting",0)
end
if bullet.GetVar("vely")==nil then
bullet.SetVar("vely",0)
end
if bullet.GetVar("color")==nil then
bullet.SetVar("color","white")
end
if color == "orange" then
	bullet.sprite.color = {230/255, 154/255, 34/255}
		end
	if color == "cyan" then
	bullet.sprite.color = {0/255, 162/255, 210/255}
	end
if bullet.GetVar("mask")==nil then
bullet.SetVar("mask",true)
end
bullet.Move(bullet.GetVar("velx"),bullet.GetVar("vely"))
bullet.sprite.rotation=bullet.sprite.rotation+bullet.GetVar("roting")
if bullet.GetVar("mask")==true then
bullet.sprite.SetParent(mask)
end
end
if bullet.absx>700 or bullet.absx<-60 or bullet.absy<-120 or bullet.absy>480 then
bullet.Remove()
end
end
end

return self