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
FlashCount=0
colors={"cyan","orange"}
cir={}

function Update()
if frame==1 then
Chick()
CleanUp()
AttackPattern=math.random(1,8)
end
if AttackPattern==1 then
if frame==20 then
RemoveChick()
Arena.ResizeImmediate(180,Arena.height)
end
if frame==20 then
Player.MoveTo(0,0)
Spawn("Bone8",Arena.width/2,0,0,-4,0,0,"cyan",true)
Spawn("Bone8",-Arena.width/2,0,0,4,0,0,"cyan",true)
local Blaster = gb.New(320,95+Arena.height+40,320,95+Arena.height+40,0,0 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=60
Blaster.holdfire=0
local Blaster = gb.New(320,95-40,320,95-40,180,180 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=60
Blaster.holdfire=0
local Blaster = gb.New(320-Arena.width/2-40,95+Arena.height/2,320-Arena.width/2-40,95+Arena.height/2,90,90 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=90
Blaster.holdfire=0
local Blaster = gb.New(320+Arena.width/2+40,95+Arena.height/2,320+Arena.width/2+40,95+Arena.height/2,-90,-90 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=90
Blaster.holdfire=0
end
if frame==160 then
frame=0
end
elseif AttackPattern==2 then
if frame==20 then
RemoveChick()
Arena.ResizeImmediate(180,Arena.height)
xa=math.random(60,580)
ya=math.random(100,380)
for i=1,12 do
local Blaster = gb.New(xa,ya,xa,ya,i*30,i*30, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.6,1)
Blaster.shootdelay=200
Blaster.holdfire=10
end
end
if frame==280 then
frame=0
end
elseif AttackPattern==3 then
if frame==20 then
RemoveChick()
Arena.ResizeImmediate(150,150)
Player.MoveTo(0,0)
radius=200
for i=1,15 do
ba=SpawnAbs("Bone8",320+radius*math.cos(math.rad(i*90)),95+Arena.height/2+radius*math.cos(math.rad(i*90)),i*24,0,0,0,"white",true)
table.insert(cir,ba)
end
Spawn("Bone8",Arena.width/2,0,0,-3,0,0,"cyan",true)
Spawn("Bone8",-Arena.width/2,0,0,3,0,0,"cyan",true)
end
if frame>=20 and frame<=50 then
radius=radius-3
end
if frame>60 and frame<=70 then
radius=radius+4
end
if frame>70 and frame%30==0 then
Spawn("Bone8",Arena.width/2,0,0,-2.5,0,0,colors[math.random(1,2)],true)
Spawn("Bone8",-Arena.width/2,0,0,2.5,0,0,colors[math.random(1,2)],true)
end
if frame==240 then
frame=0
end
elseif AttackPattern==4 then
if frame==20 then
RemoveChick()
Arena.ResizeImmediate(150,150)
extraY=math.random(-40,50)
Player.MoveTo(0,0)
end
if frame>20 and frame<=200 and frame%8==0 then
Spawn("Bone8",Arena.width/2,90+extraY+math.sin(frame*0.1)*21,0,-3,0,0,"white",true)
Spawn("Bone8",Arena.width/2,90+extraY-190+math.sin(frame*0.1)*21,0,-3,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,90+extraY+math.sin(frame*0.1)*21,0,3,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,90+extraY-190+math.sin(frame*0.1)*21,0,3,0,0,"white",true)
end
if frame==240 then
frame=0
end
elseif AttackPattern==5 then
if frame>0 then
bs.Update()
end
if frame==20 then
bs.into("down")
RemoveChick()
Player.SetControlOverride(true)
Player.MoveTo(-50,10)
Arena.Resize(180,150)
bonemid=math.random(1,2)
blasterdir=math.random(1,2)
for i=1,20 do
Spawn("Bone1",-Arena.width/2-12+i*12,Arena.height/2-6,0,0,0,0,"white",true)
Spawn("Bone1",-Arena.width/2-12+i*12,-Arena.height/2+6,0,0,0,0,"white",true)
end
end
if frame%45==0 then
plat=CreateProjectile("platform/48",0-60,-Arena.height/2)
plat.SetVar("velx",0)
plat.SetVar("vely",1.5)
plat.SetVar("xspd",0)
plat.SetVar("yspd",1.5)
plat.SetVar("dir","down")
plat.sprite.SetParent(mask)
table.insert(bs.platforms,plat)
plat=CreateProjectile("platform/48",0+60,-Arena.height/2)
plat.SetVar("velx",0)
plat.SetVar("vely",1.5)
plat.SetVar("xspd",0)
plat.SetVar("yspd",1.5)
plat.SetVar("dir","down")
plat.sprite.SetParent(mask)
table.insert(bs.platforms,plat)
end
if frame%30==0 then
if bonemid==1 then
Spawn("Bone1",0,-Arena.height/2-15,0,0,3,0,"white",true)
end
if bonemid==2 then
Spawn("Bone1",0,Arena.height/2+15,0,0,-3,0,"white",true)
end
end
if blasterdir==1 then
if frame==80 then
local Blaster = gb.New(-50,-50,320-60,300,0,0, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=50
end
if frame==130 then
local Blaster = gb.New(-50,-50,320+60,300,0,900, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=90
end
elseif blasterdir==2 then
if frame==80 then
local Blaster = gb.New(-50,-50,320+60,300,0,900, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=50
end
if frame==130 then
local Blaster = gb.New(-50,-50,320-60,300,0,0, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=90
end
end
if frame==320 then
frame=0
bs.back()
end
elseif AttackPattern==6 then
bs.Update()
if frame==20 then
RemoveChick()
Player.MoveTo(0,-200)
Arena.ResizeImmediate(320,150)
bs.dir("down")
patt=math.random(1,2)
for i=1,3 do
Spawn("Bone8",Arena.width/2+14*i,75+20,0,-6,0,0,"white",true)
Spawn("Bone8",-Arena.width/2-14*i,75-180,0,6,0,0,"white",true)
Spawn("Bone8",Arena.width/2+14*i,75-180,0,-6,0,0,"white",true)
Spawn("Bone8",-Arena.width/2-14*i,75+20,0,6,0,0,"white",true)
end
if patt==1 then
Spawn("Huge",Arena.width/2+56,0,0,-6,0,0,"white",true)
Spawn("Huge",-Arena.width/2-56,0,0,6,0,0,"orange",true)
elseif patt==2 then
Spawn("Huge",Arena.width/2+56,0,0,-6,0,0,"orange",true)
Spawn("Huge",-Arena.width/2-56,0,0,6,0,0,"white",true)
end
end
if frame==60 then
frame=0
end
elseif AttackPattern==7 then
bs.Update()
if frame==20 then
RemoveChick()
patte=math.random(1,2)
bs.dir("down")
Arena.ResizeImmediate(150,150)
if patte==1 then
Player.MoveTo(-2000,-2000)
SpX=-Arena.width/2
elseif patte==2 then
Player.MoveTo(2000,-2000)
SpX=Arena.width/2
end
end
if frame>20 and frame%5==0 and frame<=60 then
Spawn("Bone1",SpX,89,0,0,-8,0,"white",true)
if patte==1 then
SpX=SpX+14
elseif patte==2 then
SpX=SpX-14
end
end
if frame%45==0 then
Spawn("Bone8",0,Arena.height/2,90,0,-6,0,"cyan",true)
end
if frame==80 then
frame=0
end
elseif AttackPattern==8 then
bs.Update()
if frame==20 then
RemoveChick()
bs.dir("down")
Arena.ResizeImmediate(300,160)
Player.MoveTo(0,0)
plat3=CreateProjectile("platform/48",0,-Arena.height/2+45)
plat3.SetVar("velx",0)
plat3.SetVar("vely",0)
plat3.SetVar("xspd",0)
plat3.SetVar("yspd",0)
plat3.SetVar("dir","down")
table.insert(bs.platforms,plat3)
for i=1,30 do
Spawn("Bone1",-Arena.width/2-12+i*12,Arena.height/2-6,0,0,0,0,"white",true)
Spawn("Bone1",-Arena.width/2-12+i*12,-Arena.height/2+6,0,0,0,0,"white",true)
end
end
if frame>30 and frame<=180 and frame%30==0 then
udm=math.random(1,2)
if udm==1 then
Spawn("Bone2",-Arena.width/2,-Arena.height/2+45,0,6,0,0,"white",true)
Spawn("Bone2",Arena.width/2,-Arena.height/2+45,0,-6,0,0,"white",true)
elseif udm==2 then
Spawn("Bone3",-Arena.width/2,-Arena.height/2+45,0,6,0,0,"white",true)
Spawn("Bone3",Arena.width/2,-Arena.height/2+45,0,-6,0,0,"white",true)
end
end
if frame%45==0 then
Spawn("Bone7",-Arena.width/2,Arena.height/2+15,0,5,0,0,"white",true)
Spawn("Bone7",Arena.width/2,Arena.height/2+15,0,-5,0,0,"white",true)
end
if frame==130 then
Spawn("Bone2",Player.x,-Arena.height/2,90,0,8,0,"white",true)
end
if frame%60==0 then
Spawn("Huge",0,-Arena.height/2,90,0,3,0,"cyan",true)
end
if frame==230 then
local Blaster = gb.New(-50,-50,20,135,90,90, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
end
if frame==260 then
local Blaster = gb.New(-50,-50,320,300,0,0, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
end
if frame==300 then
plat3.Remove()
end
if frame==330 then
frame=0
end
end
---Above are attacks!
if FlashCount>=9 then
EndWave()
RemoveChick()
end
for i=1,#cir do
local bullet=cir[i]
if bullet.isactive then
bullet.SetVar("roting",6)
bullet.MoveToAbs(320+radius*math.cos(math.rad(bullet.sprite.rotation+90)),95+Arena.height/2+radius*math.sin(math.rad(bullet.sprite.rotation+90)))
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
blk=CreateSprite("blk","Top")
Player.SetControlOverride(true)
FlashCount=FlashCount+1
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
if color == "orange" and not (Input.Down > 0 or Input.Up > 0 or Input.Left > 0 or Input.Right > 0) then
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
usudjdhdhdjdopaoakhdhirjejvhdieldbclsahjhdnz??n. ?mejkBji
function OnHit(bullet)
local color = bullet.GetVar("color")
if color == "white" then
Player.Hurt(6,1)
end
if color == "orange" and not (Input.Down > 0 or Input.Up > 0 or Input.Left > 0 or Input.Right > 0) then
Player.Hurt(6,1)
end
if color == "cyan" and (Input.Down > 0 or Input.Up > 0 or Input.Left > 0 or Input.Right > 0) then
Player.Hurt(6,1)
end
if color=="Blaster" then
Player.Hurt(10,0.2)
end
end
Blasters deal damge so high and fast that I cum!!!!!!!!!!
Sans is trash and undertale is not trash!!!!!!!!!!!!!
]]--