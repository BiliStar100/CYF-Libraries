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
SetGlobal("Waves",GetGlobal("Waves")+1)
bs.dir("down")
Arena.Resize(190,Arena.height)
cir={}

function Update()
if frame==30 or frame==110 then
Spawn("Bone8",Arena.width/2,Arena.height/2-0,0,-3,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,-Arena.height/2-60,0,3,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,Arena.height/2-0,0,3,0,0,"white",true)
Spawn("Bone8",Arena.width/2,-Arena.height/2-60,0,-3,0,0,"white",true)
Spawn("Bone8",Arena.width/2+60,0,0,-3,0,0,"orange",true)
Spawn("Bone8",-Arena.width/2-60,0,0,3,0,0,"orange",true)
end
if frame==160 then
radius=200
for i=1,4 do
ba=SpawnAbs("Bone8",320+radius*math.cos(math.rad(i*90)),95+Arena.height/2+radius*math.cos(math.rad(i*90)),i*90,0,0,0,"white",true)
table.insert(cir,ba)
end
end
if frame>=160 and frame<=190 then
radius=radius-2.8
end
if frame>=840 and frame<=870 then
radius=radius-1.2
end
if frame==850 then
bs.back()
end
if frame>=900 and frame<=1500 then
if frame%60==0 then
x1=math.random(40,600)
y1=math.random(120,460)
local Blaster = gb.New(-40, -40, x1, y1, -math.atan2(x1-Player.absx,y1-Player.absy)/math.pi*180+math.random(10,-10), 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.3,1)
Blaster.shootdelay=90
Blaster.holdfire=0
end
end
if frame>1540 and frame<1580 then
radius=radius-5
end
if frame>=1620 and frame<=1680 then
if frame%10==0 then
local Blaster = gb.New(-40, -40, 320-Arena.width/2-20, 115+Arena.height, -math.atan2(320-Arena.width/2-20-Player.absx,115+Arena.height-Player.absy)/math.pi*180, 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.5,1)
Blaster.shootdelay=10
Blaster.holdfire=0
local Blaster = gb.New(-40, -40, 320+Arena.width/2+20, 115+Arena.height, -math.atan2(320+Arena.width/2+20-Player.absx,115+Arena.height-Player.absy)/math.pi*180, 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.5,1)
Blaster.shootdelay=10
Blaster.holdfire=0
end
end
if frame==1750 then
EndWave()
end
---Above are attacks!
for i=1,#cir do
local bullet=cir[i]
if bullet.isactive then
if frame<520 then
bullet.SetVar("roting",2)
elseif frame>=520 and frame<840 then
bullet.SetVar("roting",-3)
else
bullet.SetVar("roting",1)
end
bullet.MoveToAbs(320+radius*math.cos(math.rad(bullet.sprite.rotation+90)),95+Arena.height/2+radius*math.sin(math.rad(bullet.sprite.rotation+90)))
end
end
if frame<850 then
bs.Update()
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
blk=CreateSprite("blk","Top")
Player.SetControlOverride(true)
end

function RemoveChick()
Audio.PlaySound("chick")
blk.Remove()
Player.SetControlOverride(false)
end

function EndingWave()
Player.sprite.color={1,0,0}
Player.sprite.rotation=0
end
function OnHit(bullet)
local color = bullet.GetVar("color")
if color == "white" then
Player.Hurt(6,1)
end
if color == "orange" and not bs.ismoving() then
Player.Hurt(6,1)
end
if color == "cyan" and bs.ismoving() then
Player.Hurt(6,1)
end
if color=="Blaster" then
Player.Hurt(10,0.2)
end
end
--[[
Spawn(Sprite,Sx,Sy,Rot,MoveX,MoveY,KeepRot,color,masked)  --普通骨头（贴图，X，Y，旋转角度，X轴速度，Y轴速度，连续转动速度，颜色，是否遮挡）
Angle(Sprite,Sx,Sy,Angle,masked,Speed,color)  --角度移动（贴图，X，Y，角度，是否遮挡，运动速度，颜色）
Target(Sprite,Sx,Sy,masked,ReachTime,color,Tx,Ty)  --定点射击（贴图，X，Y，是否遮挡，速度(其实就是到达目标坐标的时间），颜色，目标X，目标Y）
]]--