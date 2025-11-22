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
Audio.LoadFile("IFPhase2")
SetGlobal("Waves",GetGlobal("Waves")+1)

function Update()
if frame==1 then
Chick()
end
if frame>11*60 and frame<12.5*60 then
blk.alpha=blk.alpha-0.01
end
if frame==13*60 then
RemoveChick()
Arena.ResizeImmediate(360,Arena.height)
end
if frame>=780 and frame<=900 and frame%3==0 then
Spawn("Bone8",Arena.width/2,-Arena.height/2-30+math.sin(frame*0.16)*15,0,-4,0,0,"white",true)
Spawn("Bone8",Arena.width/2,-Arena.height/2+170+math.sin(frame*0.16)*15,0,-4,0,0,"white",true)
end
if frame>=940 and frame<=1080 and frame%3==0 then
Spawn("Bone8",-Arena.width/2,-Arena.height/2-60+math.sin(frame*0.16)*20,0,4,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,-Arena.height/2+140+math.sin(frame*0.16)*20,0,4,0,0,"white",true)
end
if frame>780 and frame<1050 and frame%75==0 then
Spawn("Huge",0,Arena.height/2,90,0,-4,0,"cyan",true)
end
if frame>1100 and frame<1500 then
if frame%30==0 then
Spawn("Bone8",-Arena.width/2,-Arena.height/2-40,0,4.5,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,-Arena.height/2+140,0,4.5,0,0,"white",true)
Spawn("Bone8",Arena.width/2,-Arena.height/2-30,0,-4.5,0,0,"white",true)
Spawn("Bone8",Arena.width/2,-Arena.height/2+150,0,-4.5,0,0,"white",true)
end
if frame==1499 then
Chick()
CleanUp()
Arena.Resize(150,150)
Arena.MoveTo(120,95)
Player.MoveToAbs(-1000,95+Arena.height)
end
end
if frame==1520 then
RemoveChick()
Arena.Resize(150,150)
Arena.MoveTo(120,95)
Player.MoveToAbs(-1000,95+Arena.height)
local Blaster = gb.New(Arena.x-35,95+Arena.height+50,Arena.x-35,95+Arena.height+50, 0, 0, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.shootdelay=60
Blaster.Scale(1,1)
local Blaster = gb.New(Arena.x-90,95+Arena.height-10,Arena.x-90,95+Arena.height-10, 90, 90, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.shootdelay=60
Blaster.Scale(1,1)
end
if frame==1575 then
Spawn("Bone8",-Arena.width/2,0,0,5,0,0,"cyan",true)
Spawn("Bone6",-Arena.width/2,Arena.height/2,0,5,0,0,"white",true)
Spawn("Bone6",-Arena.width/2,-Arena.height/2,0,5,0,0,"white",true)
end
if frame==1620 then
Chick()
CleanUp()
Arena.MoveTo(440,95)
end
if frame>=1660 and frame<1720 and frame%4==0 then
Spawn("Bone8",-Arena.width/2,0,0,5,0,0,"orange",true)
end
if frame==1660 then
RemoveChick()
Player.MoveTo(0,0)
bone1=Spawn("Bone8",Arena.width/2,-Arena.height/2,0,0,0,-5,"white",true)
end
if frame==1690 then
bone1.Remove()
bone2=Spawn("Bone8",-Arena.width/2,Arena.height/2,0,0,0,5,"white",true)
end
if frame==1720 then
Chick()
CleanUp()
Arena.MoveTo(320,95)
end
if frame==1730 then
RemoveChick()
Player.MoveTo(0,Arena.height/2)
end
if frame>=1750 then
bs.Update()
if frame<=2000 and frame%55==0 then
Spawn("Bone8",Arena.width/2,50,0,-4.5,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,50,0,4.5,0,0,"white",true)
Spawn("Bone8",Arena.width/2+80,-110,0,-4.5,0,0,"white",true)
Spawn("Bone8",-Arena.width/2-80,-110,0,4.5,0,0,"white",true)
end
end
if frame==1750 then
GravitySlap("down")
end
if frame==2060 then
GravitySlap("up")
end
if frame==2080 then
local Blaster = gb.New(690,530,320+Arena.width/2-30,95+Arena.height+40,0,0, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.shootdelay=40
Blaster.holdfire=100
Blaster.Scale(3,1)
end
if frame==2120 then
Spawn("Bone8",-Arena.width/2,110,0,3,0,0,"white",true)
Spawn("Bone8",-Arena.width/2,-70,0,3,0,0,"white",true)
Spawn("Bone8",Arena.width/2,110,0,-2,0,0,"white",true)
Spawn("Bone8",Arena.width/2,-70,0,-2,0,0,"white",true)
end
if frame==2260 then
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