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
bs.dir("down")
Arena.Resize(210,Arena.height)
dirs={"down","up"}
hitnum=0

function Update()
if frame>=20 and frame<=1200 then
if frame<1050 then
if frame%150==0 then
bon=Spawn("Bone8",Arena.width/2,0,0,-1,0,0,"gravity",true)
bon.sprite.color={0,0,1}
end
end
if frame%80==0 then
Spawn("Bone5",-Arena.width/2,Arena.height/2+8,0,1,0,0,"white",true)
Spawn("Bone2",-Arena.width/2-20,Arena.height/2,0,1,0,0,"white",true)
Spawn("Bone5",-Arena.width/2,-Arena.height/2-8,0,1,0,0,"white",true)
end
if frame%80==40 then
Spawn("Bone5",-Arena.width/2,-Arena.height/2-8,0,1,0,0,"white",true)
Spawn("Bone2",-Arena.width/2-20,-Arena.height/2,0,1,0,0,"white",true)
Spawn("Bone5",-Arena.width/2,Arena.height/2+8,0,1,0,0,"white",true)
end
end
if frame==1270 then
GravitySlap("left")
end
if frame==1600 then
EndWave()
end
if frame==1420 then
GravitySlap("right")
end
---Above are attacks!
bs.Update()
frame=frame+1
Boner.update()
gb.Update()
mask.MoveToAbs(Arena.x,Arena.y+Arena.height/2+5)
mask.Mask("stencil")
mask.Scale(Arena.width,Arena.height)
end

function Chick()
Player.SetControlOverride(true)
Audio.PlaySound("chick")
blk=CreateSprite("blk")
end

function RemoveChick()
Player.SetControlOverride(false)
Audio.PlaySound("chick")
if blk then
blk.Remove()
end
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
if color == "gravity" then
bullet.Remove()
Player.Hurt(0,0.1)
hitnum=hitnum+1
while hitnum%2==0 do
bs.dir("down")
break
end
while hitnum%2==1 do
bs.dir("up")
break
end
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