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
dir={"up","left","right","down"}
Arena.Resize(150,150)
colors={"cyan","orange"}
RecordColor={}

function Update()
if frame>60 and frame<600 then
bs.Update()
end
if frame>60 and frame%60==0 and frame<600 then
directionar=dir[math.random(1,4)]
if directionar=="down" then
GravitySlap(directionar)
Cross("Bone6",-Arena.width/2-50,-Arena.height/2,true,3,"white",3,0)
Cross("Bone6",Arena.width/2+50,-Arena.height/2,true,-3,"white",-3,0)
Cross("Bone6",-Arena.width/2-50,Arena.height/2,true,-3,"white",3,0)
Cross("Bone6",Arena.width/2+50,Arena.height/2,true,3,"white",-3,0)
Cross("Bone7",0,Arena.height/2+90,true,8,"orange",0,-5)
elseif directionar=="up" then
GravitySlap(directionar)
Cross("Bone6",-Arena.width/2-50,Arena.height/2,true,-3,"white",3,0)
Cross("Bone6",Arena.width/2+50,Arena.height/2,true,3,"white",-3,0)
Cross("Bone6",-Arena.width/2-50,-Arena.height/2,true,-3,"white",3,0)
Cross("Bone6",Arena.width/2+50,-Arena.height/2,true,3,"white",-3,0)
Cross("Bone7",0,-Arena.height/2-90,true,8,"orange",0,5)
elseif directionar=="left" then
GravitySlap(directionar)
Cross("Bone6",-Arena.width/2,Arena.height/2+50,true,3,"white",0,-3)
Cross("Bone6",-Arena.width/2,-Arena.height/2-50,true,-3,"white",0,3)
Cross("Bone6",Arena.width/2,Arena.height/2+50,true,-3,"white",0,-3)
Cross("Bone6",Arena.width/2,-Arena.height/2-50,true,3,"white",-0,3)
Cross("Bone7",Arena.width/2+90,0,true,8,"orange",-5,0)
elseif directionar=="right" then
GravitySlap(directionar)
Cross("Bone6",Arena.width/2,Arena.height/2+50,true,-3,"white",0,-3)
Cross("Bone6",Arena.width/2,-Arena.height/2-50,true,3,"white",0,3)
Cross("Bone6",-Arena.width/2,Arena.height/2+50,true,-3,"white",0,-3)
Cross("Bone6",-Arena.width/2,-Arena.height/2-50,true,3,"white",-0,3)
Cross("Bone7",-Arena.width/2-90,0,true,8,"orange",5,0)
end
end
if frame==600 then
bs.back()
end
if frame>640 and frame<830 then
if frame%25==0 then
Spawn("Bone7",-Arena.width/2,Arena.height/2,90,0,-2,0,"white",true)
Spawn("Bone7",Arena.width/2,-Arena.height/2,90,0,2,0,"white",true)
end
if frame%60==0 then
Spawn("Bone8",Arena.width/2,0,0,-1.6,0,0,"orange",true)
Spawn("Bone8",-Arena.width/2,0,0,1.6,0,0,"orange",true)
end
end
if frame==900 then
Player.MoveTo(0,Player.y)
CleanUp()
Player.sprite.color={0,0,1}
--Player.SetControlOverride(true)
Player.sprite.rotation=90
Arena.Resize(650,160)
end
--[[if frame>=900 then
if Input.Up>0 then
Player.Move(0,2)
end
if Input.Down>0 then
Player.Move(0,-2)
end
end]]--
if frame>930 and frame<=1220 then
if frame%30==0 then
bone1=Spawn("Bone8",Arena.width/2,Arena.height/2,0,-8,0,0,"white",true)
table.insert(Bullets,bone1)
end
if frame%30==15 then
bone2=Spawn("Bone8",Arena.width/2,-Arena.height/2,0,-8,0,0,"white",true)
table.insert(Bullets,bone2)
end
end
if frame>1440 and frame<=1960 then
if frame%8==0 then
bu=Spawn("Bone8",Arena.width/2,100+math.sin(frame*0.1)*21,0,-10,0,0,"white",true)
bd=Spawn("Bone8",Arena.width/2,-90+math.sin(frame*0.1)*21,0,-10,0,0,"white",true)
end
if frame%40==0 then
cb=Spawn("Bone8",Arena.width/2,0,0,-9,0,0,colors[math.random(2)],true)
cala=cb.GetVar("color")
table.insert(RecordColor,cala)
ian=0
end
end
if frame>2020 and frame<2300 then
if frame%30==0 then
ian=ian+1
Spawn("Bone8",-Arena.width/2,0,0,12,0,0,RecordColor[ian],true)
end
if frame%25==0 then
local Blaster = gb.New(-40,-40,600,95+math.random(10,150),-90,90 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.5,1)
end
end
if frame==2320 then
local Blaster = gb.New(-40,-40,600,95+Arena.height/2,-90,90 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.5,1)
end
if frame>2340 and frame<2540 then
if frame%6==0 then
Spawn("Bone8",Arena.width/2,Arena.height/2+8,0,-8,0,0,"white",true)
Spawn("Bone8",Arena.width/2,-Arena.height/2-8,0,-8,0,0,"white",true)
end
end
if frame>=2580 and frame<=2610 then
Arena.Move(-6,0,false)
end
if frame==2600 then
GravitySlap("right")
end
if frame==2630 then
Chick()
CleanUp()
end
if frame>=2600 and frame<2690 then
bs.Update()
end
if frame==2660 then
RemoveChick()
Arena.MoveTo(320,Arena.y)
Arena.Resize(160,160)
Player.SetControlOverride(true)
Player.MoveTo(-200,-200)
bs.dir("left")
local Blaster = gb.New(Player.absx,300,Player.absx,300,0,0 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
local Blaster = gb.New(20,Player.absy,20,Player.absy,90,90 ,"gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
end
if frame==2690 then
Chick()
CleanUp()
end
if frame==2710 then
RemoveChick()
bs.back()
Player.MoveTo(0,0)
rotation=0
radius=180
end
if frame>=2760 and frame<=3400 then
rotation=rotation+4
if frame%4==0 then
local Blaster = gb.New(1000*math.sin(math.rad(rotation)), 1000*math.cos(math.rad(rotation)), 320+radius*math.sin(math.rad(rotation)), 95+Arena.height/2+radius*math.cos(math.rad(rotation)), -rotation, 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.8,1)
Blaster.shootdelay=90
end
end
if frame==3500 then
Chick()
CleanUp()
rotation=0
end
if frame==3520 then
RemoveChick()
Spawn("Bone8",0,0,0,0,0,-3,"cyan",true)
end
if frame>3550 and frame<4800 then
rotation=rotation-3
if frame%4==0 then
local Blaster = gb.New(1000*math.sin(math.rad(rotation)), 1000*math.cos(math.rad(rotation)), 320+radius*math.sin(math.rad(rotation)), 95+Arena.height/2+radius*math.cos(math.rad(rotation)), -rotation, 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.5,1)
Blaster.shootdelay=90
end
end
---Above are attacks!
for i=1,#Bullets do
if Bullets[i].isactive then
Bullets[i].SetVar("velx",Bullets[i].GetVar("velx")+0.06)
end
end
frame=frame+1
Boner.update()
gb.Update()
mask.MoveToAbs(Arena.x,Arena.y+Arena.height/2+5)
mask.Mask("stencil")
mask.Scale(Arena.width,Arena.height)
end;

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
]]--