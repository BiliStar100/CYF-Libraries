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
Arena.Resize(Arena.width,180)

function Update()

if frame%2==0 then
Spawn("Bone3",Arena.width/2,-Arena.height/2,0,-6,0,0,"white",true)
end
if frame==60 then
plat=CreateProjectile("platform/28",0,-Arena.height/2)
plat.SetVar("velx",0)
plat.SetVar("vely",3)
plat.SetVar("xspd",0)
plat.SetVar("yspd",3)
plat.SetVar("dir","down")
table.insert(bs.platforms,plat)
end
if frame==75 then
plat.SetVar("yspd",0)
plat.SetVar("vely",0)
end
if frame==90 then
Spawn("Bone8",Arena.width/2,-Arena.height/2,0,-8,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,-Arena.height/2,0,8,0,0,"white",true)
Spawn("Bone8",Arena.width/2+50,-Arena.height/2+40,0,-2.5,0,0,"white",true)
plat2=CreateProjectile("platform/48",Arena.width/2+20,-Arena.height/2+50)
plat2.SetVar("velx",-2.5)
plat2.SetVar("vely",0)
plat2.SetVar("xspd",-2.5)
plat2.SetVar("yspd",0)
plat2.SetVar("dir","down")
table.insert(bs.platforms,plat2)
plat3=CreateProjectile("platform/48",Arena.width/2+240,-Arena.height/2+50)
plat3.SetVar("velx",-2.5)
plat3.SetVar("vely",0)
plat3.SetVar("xspd",-2.5)
plat3.SetVar("yspd",0)
plat3.SetVar("dir","down")
table.insert(bs.platforms,plat3)
end
if frame==120 then
plat.SetVar("vely",-3)
end
if frame==150 then
plat.Remove()
end
if frame==240 then
Spawn("Bone8",Arena.width/2,-Arena.height/2+40,0,-3,0,0,"white",true)
Spawn("Bone8",Arena.width/2+50,Arena.height/2-20,0,-3,0,0,"white",true)
end
if frame==220 then
plat2=CreateProjectile("platform/48",Arena.width/2+20,-Arena.height/2+50)
plat2.SetVar("velx",-2)
plat2.SetVar("vely",0)
plat2.SetVar("xspd",-2)
plat2.SetVar("yspd",0)
plat2.SetVar("dir","down")
table.insert(bs.platforms,plat2)
end
if frame==280 then
plat2=CreateProjectile("platform/48",-Arena.width/2-20,-Arena.height/2+50)
plat2.SetVar("velx",5)
plat2.SetVar("vely",0)
plat2.SetVar("xspd",5)
plat2.SetVar("yspd",0)
plat2.SetVar("dir","down")
table.insert(bs.platforms,plat2)
Spawn("Bone8",-Arena.width/2,-Arena.height/2,0,1.2,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,Arena.height/2,0,1.2,0,0,"white",true)
end
if frame==360 then
plat2=CreateProjectile("platform/48",Arena.width/2+24,-Arena.height/2+128)
plat2.SetVar("velx",-2)
plat2.SetVar("vely",0)
plat2.SetVar("xspd",-2)
plat2.SetVar("yspd",0)
plat2.SetVar("dir","down")
table.insert(bs.platforms,plat2)
Spawn("Bone8",Arena.width/2,-Arena.height/2+40,0,-2,0,0,"white",true)
Spawn("Bone8",Arena.width/2+20,-Arena.height/2+40,0,-2,0,0,"white",true)
Spawn("Bone8",Arena.width/2+40,-Arena.height/2+40,0,-2,0,0,"white",true)
end
if frame==450 then
Spawn("Bone8",-Arena.width/2,Arena.height/2+10,0,5,0,0,"white",true)
end
if frame==460 then
plat2=CreateProjectile("platform/48",Arena.width/2+24,-Arena.height/2+50)
plat2.SetVar("velx",-3)
plat2.SetVar("vely",0)
plat2.SetVar("xspd",-3)
plat2.SetVar("yspd",0)
plat2.SetVar("dir","down")
table.insert(bs.platforms,plat2)
end
if frame==580 then
local Blaster = gb.New(700,700,Arena.x-220,95+Arena.height+50, 0, 0, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.shootdelay=60
Blaster.Scale(2,1)
end
if frame==590 then
plat2=CreateProjectile("platform/48",-Arena.width/2-24,-Arena.height/2+75)
plat2.SetVar("velx",3)
plat2.SetVar("vely",0)
plat2.SetVar("xspd",3)
plat2.SetVar("yspd",0)
plat2.SetVar("dir","down")
table.insert(bs.platforms,plat2)
end
if frame==640 then
for i=1,5 do
Spawn("Bone8",Arena.width/2+i*12,Arena.height/2-18,0,-4,0,0,"white",true)
end
plat2=CreateProjectile("platform/48",Arena.width/2+24,-Arena.height/2+45)
plat2.SetVar("velx",-4.5)
plat2.SetVar("vely",0)
plat2.SetVar("xspd",-4.5)
plat2.SetVar("yspd",0)
plat2.SetVar("dir","down")
table.insert(bs.platforms,plat2)
end
if frame==740 then
for i=1,5 do
Spawn("Bone8",-Arena.width/2-i*12,Arena.height/2-60,0,7,0,0,"cyan",true)
end
end
if frame==750 then
plat2.SetVar("velx",1)
plat2.SetVar("xspd",1)
end
if frame==780 then
local Blaster = gb.New(700,700,Arena.x-220,plat2.absy, 90, 90, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.shootdelay=45
Blaster.Scale(0.4,1)
end
if frame>=820 and frame<=1200 then
if frame%45==0 then
plat3=CreateProjectile("platform/48",-Arena.width/2-24,-Arena.height/2+50)
plat3.SetVar("velx",3)
plat3.SetVar("vely",0)
plat3.SetVar("xspd",3)
plat3.SetVar("yspd",0)
plat3.SetVar("dir","down")
table.insert(bs.platforms,plat3)
end
if frame<=1140 then
if frame%40==0 then
Spawn("Huge",Arena.width/2,0,0,-3,0,0,"orange",true)
end
if frame%60==0 then
Spawn("Huge",-Arena.width/2,0,0,4,0,0,"cyan",true)
end
end
end
if frame==1260 then
Spawn("Bone8",Arena.width/2+10,Arena.height/2-60,0,-4,0,0,"white",true)
end
if frame==1300 then
EndWave()
end
---Above are attacks!
if frame==60 then
bs.dir("down")
end
if frame>60 then
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
if color == "cyan" and (Input.Down > 0 or Input.Up > 0 or Input.Left > 0 or Input.Right > 0) then
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