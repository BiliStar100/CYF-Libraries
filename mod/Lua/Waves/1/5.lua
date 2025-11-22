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
wa={}
top={}
Arena.Resize(160,155)
bs.dir("down")

function Update()
if frame==1 then
for i=1,15 do
topa=Spawn("Bone1",-Arena.width/2+i*12-12,Arena.height/2-14,0,0,0,0,"white",true)
table.insert(top,topa)
end
end
if frame<=480 and frame%30==0 then
plat=CreateProjectileAbs("platform/plat",320+math.random(-Arena.width/2,Arena.width/2),0)
table.insert(bs.platforms,plat)
plat.SetVar("velx",0)
plat.SetVar("vely",4)
plat.SetVar("xspd",0)
plat.SetVar("yspd",4)
plat.SetVar("dir","down")
end
if frame==620 then
Spawn("Bone3",-Arena.width/2,Arena.height/2-30,0,6,0,0,"white",true)
Spawn("Bone3",-Arena.width/2,-Arena.height/2+30,0,6,0,0,"white",true)
Spawn("Bone3",Arena.width/2,Arena.height/2-30,0,-6,0,0,"white",true)
Spawn("Bone3",Arena.width/2,-Arena.height/2+30,0,-6,0,0,"white",true)
for i=1,15 do
tope=Spawn("Bone1",-Arena.width/2+i*12-12,-Arena.height/2-75,0,0,0,0,"white",true)
table.insert(Bullets,tope)
end
end
if frame>=720 and frame%40==0 then
x1=math.random(100,540)
y1=math.random(300,420)
x2=math.random(100,540)
y2=math.random(300,420)
r1=math.atan2(x1-Player.absx,y1-Player.absy)/math.pi*180
r2=math.atan2(x2-Player.absx,y2-Player.absy)/math.pi*180
bone=SpawnAbs("Bone1",x1,y1,-r1,5*math.cos(math.rad(90+r1)),-5*math.sin(math.rad(90+r1)),0,"white",false)
bone.sprite.alpha=0
table.insert(wa,bone)
bone=SpawnAbs("Bone1",x2,y2,-r2,5*math.cos(math.rad(90+r2)),-5*math.sin(math.rad(90+r2)),0,"white",false)
bone.sprite.alpha=0
table.insert(wa,bone)
end
if frame==1100 then
EndWave()
end
---Above are attacks!
for i=1,#top do
if top[i].isactive then
if frame>=520 and frame%20==0 then
top[i].SetVar("drop",true)
end
if top[i].GetVar("drop")==true then
top[i].SetVar("vely",-2)
top[i].SetVar("color","orange")
end
end
end
for i=1,#Bullets do
local bullet=Bullets[i]
if frame>=720 then
if frame%60==0 then
bullet.SetVar("vely",4.5)
end
if frame%60==20 then
bullet.SetVar("vely",0)
end
if frame%60==40 then
bullet.SetVar("vely",-4.5)
end
end
end
for i=1,#wa do
if wa[i].isactive then
wa[i].sprite.alpha=wa[i].sprite.alpha+0.016
end
end
bs.Update()
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
if color == "orange" and not (Input.Down > 0 or Input.Up > 0 or Input.Left > 0 or Input.Right > 0) then
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