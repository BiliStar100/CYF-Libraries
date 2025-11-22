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
Warnings={}
Arena.Resize(160,Arena.height)
movesp=8
bs.dir("down")
UpG={}
Spec={}

function Update()
bs.Update()
movesp=movesp-0.07
if frame==60 then
bone1=Spawn("Bone1",Arena.width/2,-Arena.height/2+15,0,-movesp,0,0,"white",true)
bone2=Spawn("Bone1",-Arena.width/2,-Arena.height/2+15,0,movesp,0,0,"white",true)
end
if frame>=60 then
bone1.SetVar("velx",-movesp)
bone2.SetVar("velx",movesp)
end
if frame==200 then
movesp=8
bone3=Spawn("Bone3",Arena.width/2,-Arena.height/2+31,0,-movesp,0,0,"white",true)
bone4=Spawn("Bone3",-Arena.width/2,-Arena.height/2+31,0,movesp,0,0,"white",true)
end
if frame>=200 then
bone3.SetVar("velx",-movesp)
bone4.SetVar("velx",movesp)
end
if frame==280 then
Spawn("Bone5",Arena.width/2,-Arena.height/2+50,0,-0.6,0,0,"white",true)
Spawn("Bone5",-Arena.width/2,-Arena.height/2+50,0,0.6,0,0,"white",true)
end
if frame==380 then
bs.dir("up")
end
if frame>420 and frame<=460 then
if frame%8==0 then
bonea=Spawn("Bone1",math.random(-80,80),-Arena.height/2-15,0,0,math.random(0,1),0,"white",true)
table.insert(UpG,bonea)
end
end
if frame>=600 then
if frame%40==0 then
Bone=Spawn("Bone8",-Arena.width/2,-Arena.height/2+20,0,1.6,0,0,"white",true)
table.insert(Spec,Bone)
end
if frame%70==0 then
Spawn("Bone8",Arena.width/2,0,0,-2,0,0,"cyan",true)
end
end
if frame==1200 then
EndWave()
end
---Above are attacks!
for i=1,#Spec do
if Spec[i].isactive then
Spec[i].MoveToAbs(Spec[i].absx,115+math.sin(frame*0.035)*24)
end
end
for i=1,#UpG do
local bullet=UpG[i]
local gravity=0.08
local gravityrot=0.8
if bullet.GetVar("grded")==nil then
bullet.SetVar("grded",0)
end
if bullet.absy+15>=95+Arena.height and bullet.absx>=320-80 and bullet.absx<=320+80 and bullet.GetVar("grded")==0 then
bullet.SetVar("vely",-2)
bullet.SetVar("velx",math.random(-1.2,1.2))
bullet.SetVar("rota",math.random(-1,1))
bullet.SetVar("grded",bullet.GetVar("grded")+1)
end
if bullet.absy+15>=95+Arena.height and bullet.absx>=320-80 and bullet.absx<=320+80 and bullet.GetVar("grded")<=3 then
bullet.SetVar("vely",-2)
bullet.SetVar("grded",bullet.GetVar("grded")+1)
end
bullet.SetVar("vely",bullet.GetVar("vely")+0.08)
if bullet.GetVar("grded")>0 then
bullet.SetVar("roting",bullet.GetVar("roting")+bullet.GetVar("rota")*1/9)
end
end
frame=frame+1
Boner.update()
gb.Update()
mask.MoveToAbs(Arena.x,Arena.y+Arena.height/2+5)
mask.Mask("stencil")
mask.Scale(Arena.width,Arena.height)
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