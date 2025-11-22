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
Arena.Resize(120,Arena.height)
colors={"cyan","orange"}
function Update()
if frame==20 then
Spawn("Bone1",Arena.width/2+15,0,90,-4,0,0,"white",true)
end
if frame==60 then
Cross("Bone6",0,Arena.height/2+60,true,3,"white",0,-3)
Cross("Bone6",0,Arena.height/2+200,true,-3,"white",0,-3)
end
if frame==120 then
Arena.Resize(120,200)
end
if frame==180 then
Cross("Bone6",0,-Arena.height/2-60,true,2.5,"white",0,4)
Cross("Bone6",0,-Arena.height/2-200,true,-2.5,"white",0,4)
end
if frame==310 then
GravitySlap("up")
Spawn("Bone8",Arena.width/2+20,-Arena.height/2+80,0,-2,0,0,"white",true)
Spawn("Bone8",-Arena.width/2-20,-Arena.height/2+80,0,2,0,0,"white",true)
Spawn("Bone2",Arena.width/2+70,Arena.height/2-20,0,-2,0,0,"white",true)
Spawn("Bone2",-Arena.width/2-70,Arena.height/2-20,0,2,0,0,"white",true)
end
if frame==380 then
Arena.Resize(170,Arena.height/4)
end
if frame>400 and frame<=840 then
if frame%50==0 then
Spawn("Bone1",Arena.width/2,Arena.height/2-6,0,-3,0,0,"white",true)
Spawn("Bone1",-Arena.width/2,Arena.height/2-6,0,3,0,0,"white",true)
elseif frame%50==25 then
Spawn("Bone1",Arena.width/2,-Arena.height/2+6,0,-3,0,0,"white",true)
Spawn("Bone1",-Arena.width/2,-Arena.height/2+6,0,3,0,0,"white",true)
end
if frame%90==0 then
SpawnAbs("Bone1",Player.absx,0,0,0,8,0,"white",false)
end
if frame==600 then
GravitySlap("down")
end
end
if frame>=260 and frame<=840 then
bs.Update()
end
if frame==840 then
bs.back()
Chick()
CleanUp()
end
if frame==860 then
RemoveChick()
Arena.ResizeImmediate(130,130)
bone=Spawn("Bone8",0,0,0,0,0,5,"white",false)
bone2=Spawn("Bone8",0,0,0,0,0,-2,"orange",false)
for i=1,30 do
radius2=140
ba=Spawn("Bone8",radius2*math.cos(math.rad(i*12+90)),radius2*math.sin(math.rad(i*12+90))-40,i*12,0,0,0,"white",true)
end
end
if frame==1200 then
bone.SetVar("roting",-3)
bone2.SetVar("color","cyan")
bone2.SetVar("roting",-5)
end
if frame==1500 then
bone.SetVar("velx",6)
end
if frame==1530 then
CleanUp()
Chick()
Player.MoveTo(0,0)
end
if frame==1550 then
RemoveChick()
Spawn("Bone8",0,Arena.height/2,90,0,-2,0,colors[math.random(1,2)],true)
Spawn("Bone8",0,Arena.height/2+40,90,0,-2,0,colors[math.random(1,2)],true)
Spawn("Bone8",0,-Arena.height/2,90,0,2,0,colors[math.random(1,2)],true)
Spawn("Bone8",0,-Arena.height/2-40,90,0,2,0,colors[math.random(1,2)],true)
Spawn("Bone8",-Arena.width/2-80,0,0,2,0,0,colors[math.random(1,2)],true)
Spawn("Bone8",-Arena.width/2-120,0,0,2,0,0,colors[math.random(1,2)],true)
Spawn("Bone8",Arena.width/2+80,0,0,-2,0,0,colors[math.random(1,2)],true)
Spawn("Bone8",Arena.width/2+120,0,0,-2,0,0,colors[math.random(1,2)],true)
end
if frame==1700 then
Chick()
CleanUp()
end
if frame==1720 then
RemoveChick()
Player.MoveTo(-1000,-1000)
end
if frame>1720 and frame<=1820 then
if frame%6==0 then
x1=320-Arena.width/2
y1=95+Arena.height
x2=320+Arena.width/2
y2=95+Arena.height
r1=math.atan2(x1-Player.absx,y1-Player.absy)/math.pi*180
r2=math.atan2(x2-Player.absx,y2-Player.absy)/math.pi*180
bone=SpawnAbs("Bone1",x1,y1,-r1,4*math.cos(math.rad(90+r1)),-4*math.sin(math.rad(90+r1)),0,"white",false)
bone=SpawnAbs("Bone1",x2,y2,-r2,4*math.cos(math.rad(90+r2)),-4*math.sin(math.rad(90+r2)),0,"white",false)
end
end
if frame==1820 then
CleanUp()
Chick()
end
if frame==1850 then
RemoveChick()
Player.MoveTo(-1000,0)
local Blaster = gb.New(320-Arena.width/2+10,95+Arena.height+50,320-Arena.width/2+10,95+Arena.height+50, 0, 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.8,1)
Blaster.holdfire=10
local Blaster = gb.New(320+Arena.width/2-10,95+Arena.height+50,320+Arena.width/2-10,95+Arena.height+50, 0, 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(0.8,1)
Blaster.holdfire=10
local Blaster = gb.New(320,45,320,45,180, 5, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.Scale(1,1)
Blaster.shootdelay=80
Blaster.holdfire=20
end
if frame==1980 then
EndWave()
end
---Above are attacks!
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
if color=="Blaster" then
Player.Hurt(8,0.3)
end
end
--[[
Spawn(Sprite,Sx,Sy,Rot,MoveX,MoveY,KeepRot,color,masked)  --普通骨头（贴图，X，Y，旋转角度，X轴速度，Y轴速度，连续转动速度，颜色，是否遮挡）
Angle(Sprite,Sx,Sy,Angle,masked,Speed,color)  --角度移动（贴图，X，Y，角度，是否遮挡，运动速度，颜色）
Target(Sprite,Sx,Sy,masked,ReachTime,color,Tx,Ty)  --定点射击（贴图，X，Y，是否遮挡，速度(其实就是到达目标坐标的时间），颜色，目标X，目标Y）
]]--