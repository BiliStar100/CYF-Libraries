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
extraY=0
Arena.Resize(155,Arena.height)

function Update()
if frame<=50 and frame>0 then
if frame%15==0 then
extraY=math.random(-20,20)
Spawn("Bone6",Arena.width/2,70+extraY,0,-3,0,0,"white",true)
Spawn("Bone6",Arena.width/2,-80+extraY,0,-3,0,0,"white",true)
end
end
if frame>=80 then
bs.Update()
if frame==80 then
bs.into("down")
end
if frame==90 then
b1=Spawn("Bone1",0,-80,0,0,0.8,0,"white",true)
b2=Spawn("Bone1",0,-80,0,0,0.8,0,"white",true)
end
if frame==120 then
b1.SetVar("vely",0)
b2.SetVar("vely",0)
end
if frame==130 then
b1.SetVar("velx",-1.2)
b2.SetVar("velx",1.2)
end
if frame>=130 and frame<=250 then
if frame%10==0 then
SpawnAbs("Bone1",b1.absx,b1.absy,0,0,0,0,"white",true)
SpawnAbs("Bone1",b2.absx,b2.absy,0,0,0,0,"white",true)
end
end
if frame==200 then
plat=CreateProjectileAbs("platform/plat",320,95)
table.insert(bs.platforms,plat)
plat.SetVar("velx",0)
plat.SetVar("vely",1.5)
plat.SetVar("xspd",0)
plat.SetVar("yspd",0)
plat.SetVar("dir","down")
end
if frame==220 then
plat.SetVar("vely",0)
end
if frame>=220 and frame<=960 then
Spad=math.sin(frame*0.035)*1
plat.SetVar("xspd",Spad)
plat.SetVar("velx",Spad)
end
end
if frame>=260 and frame<=600 then
if frame%60==0 then
Spawn("Bone8",-Arena.width/2,0,0,3,0,0,"cyan",true)
end
if frame%60==30 then
Spawn("Bone6",-Arena.width/2,-70,0,3,0,0,"white",true)
end
end
if frame>630 and frame<=1000 then
extraY=math.random(-20,20)
if frame%120==0 then
Spawn("Bone6",Arena.width/2,-60+extraY,0,-1.5,0,0,"white",true)
Spawn("Bone6",Arena.width/2,80+extraY,0,-1.5,0,0,"white",true)
elseif frame%120==60 then
Spawn("Bone6",-Arena.width/2,-60+extraY,0,1.5,0,0,"white",true)
Spawn("Bone6",-Arena.width/2,80+extraY,0,1.5,0,0,"white",true)
end
end
if frame==1030 then
Spawn("Bone6",Arena.width/2,-Arena.height/2,90,0,4,0,"white",true)
end

if frame==1100 then
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