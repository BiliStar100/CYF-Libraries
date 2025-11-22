frame=0
Bullets={}
mask=CreateSprite("mask","BelowBullet")
mask.Mask("stencil")
mask.Scale(Arena.width,Arena.height+1)
Boner=require"ConvinientBoneSpawner"
gb=require"gb"
SetPPCollision(true)
SetFrameBasedMovement(false)
bs=require"bs"
Fade={}
Arena.Resize(180,Arena.height)
drop={}
posb={-5,25,40}
colors={"orange","cyan"}

function Update()
if frame>30 then
if frame%90==0 then
rot=math.random(25,-25)
bone=Spawn("Bone1",math.random(-Arena.width/2-50,Arena.width/2+50),-Arena.height/2-95,rot,2*math.cos(math.rad(rot+90)),2*math.sin(math.rad(rot+90)),0,"white",false)
table.insert(Bullets,bone)
end
if frame<=720 then
if frame%140==0 then
Spawn("Bone8",-Arena.width/2-30,Arena.height/2+10,20,2,0,0,"white",true)
Spawn("Bone8",Arena.width/2+30,-Arena.height/2-10,20,-2,0,0,"white",true)
elseif frame%140==70 then
Spawn("Bone8",-Arena.width/2-30,-Arena.height/2-10,-20,2,0,0,"white",true)
Spawn("Bone8",Arena.width/2+30,Arena.height/2+10,-20,-2,0,0,"white",true)
end
end
if frame==840 then
bs.into("down")
end
if frame>=840 then
bs.Update()
if frame%90==0 then
extraY=posb[math.random(1,3)]
Spawn("Bone6",Arena.width/2,-Arena.height/2+100+extraY,0,-2,0,0,"white",true)
Spawn("Bone6",Arena.width/2,-Arena.height/2-40+extraY,0,-2,0,0,"white",true)
Spawn("Bone6",-Arena.width/2,-Arena.height/2+100+extraY,0,2,0,0,"white",true)
Spawn("Bone6",-Arena.width/2,-Arena.height/2-40+extraY,0,2,0,0,"white",true)
end
end
end
if frame==1260 then
EndWave()
end
---Above are attacks!
for i=1,#Bullets do
local bullet=Bullets[i]
if bullet.isactive then
if bullet.absy>360 and bullet.GetVar("burst")~=true then
Burst(bullet.absx,bullet.absy)
bullet.SetVar("burst",true)
bullet.Remove()
end
end
end
for i=1,#drop do
local bullet=drop[i]
if bullet.isactive then
bullet.SetVar("vely",bullet.GetVar("vely")-0.1)
if bullet.GetVar("givenspd")~=true then
bullet.SetVar("velx",math.random(-2,2))
bullet.SetVar("roting",math.random(-2,2))
bullet.SetVar("vely",math.random(-2,1))
bullet.SetVar("givenspd",true)
end
end
end
function Burst(X,Y)
if frame<840 then
for i=1,math.random(5,8) do
local bo=SpawnAbs("Bone1",X,Y,math.random(-179,179),0,0,0,"white",false)
table.insert(drop,bo)
Audio.PlaySound("explosion")
local circle = CreateSprite("Circle","Top")
circle.MoveToAbs(X,Y)
circle.Scale(20/480,20/480)
table.insert(Fade,circle)
end
end
if frame>840 then
for i=1,math.random(5,8) do
local bo=SpawnAbs("Bone1",X,Y,math.random(-179,179),0,0,0,colors[math.random(1,2)],false)
table.insert(drop,bo)
Audio.PlaySound("explosion")
local circle = CreateSprite("Circle","Top")
circle.MoveToAbs(X,Y)
circle.Scale(20/480,20/480)
table.insert(Fade,circle)
end
end
end
for i=1,#Fade do
if Fade[i].isactive then
Fade[i].alpha=Fade[i].alpha-0.03
Fade[i].Scale(Fade[i].xscale+2/480,Fade[i].yscale+2/480)
if Fade[i].alpha<0.02 then
Fade[i].Remove()
end
end
end
frame=frame+1
Boner.update()
gb.Update()
mask.MoveToAbs(Arena.x,Arena.y+Arena.height/2+5)
mask.Mask("stencil")
mask.Scale(Arena.width,Arena.height)
end

function Chick()
Audio.PlaySound("chick")
blk=CreateSprite("blk")
end

function RemoveChick()
Audio.PlaySound("chick")
blk.Remove()
end

function EndingWave()
Player.sprite.color={1,0,0}
Player.sprite.rotation=0
end
function OnHit(bullet)
local color = bullet.GetVar("color")
if color == "white" then
Player.Hurt(6,1.5)
end
if color == "orange" and not bs.ismoving() then
Player.Hurt(6,1.5)
end
if color == "cyan" and (Input.Down > 0 or Input.Up > 0 or Input.Left > 0 or Input.Right > 0) then
Player.Hurt(6,1.5)
end
end
--[[
Spawn(Sprite,Sx,Sy,Rot,MoveX,MoveY,KeepRot,color,masked)  --普通骨头（贴图，X，Y，旋转角度，X轴速度，Y轴速度，连续转动速度，颜色，是否遮挡）
Angle(Sprite,Sx,Sy,Angle,masked,Speed,color)  --角度移动（贴图，X，Y，角度，是否遮挡，运动速度，颜色）
Target(Sprite,Sx,Sy,masked,ReachTime,color,Tx,Ty)  --定点射击（贴图，X，Y，是否遮挡，速度(其实就是到达目标坐标的时间），颜色，目标X，目标Y）
]]--