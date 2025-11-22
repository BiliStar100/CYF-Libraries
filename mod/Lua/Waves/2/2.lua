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
Arena.Resize(Arena.width,160)

function Update()
if frame>0 and frame<=1200 then
if frame%40==0 then
Bone=Spawn("Bone3",-Arena.width/2,-Arena.height/2,0,1.6,0,0,"white",true)
table.insert(Bullets,Bone)
end
if frame%50==0 then
Bone=Spawn("Huge",Arena.width/2,Arena.height/2+60,0,-2,0,0,"white",true)
end
if frame%80==0 then
Spawn("Bone8",Arena.width/2,0,0,-2,0,0,"orange",true)
end
if frame%120==0 then
Spawn("Bone8",-Arena.width/2,0,0,4,0,0,"cyan",true)
end
if frame%240==0 then
local Blaster = gb.New(-50,-50,600,105, -90, 20, "gasterintro", "gasterfire", "blaster/spr_gasterblaster_", "blaster/beam")
Blaster.shootdelay=60
Blaster.Scale(0.5,1)
end
end
if frame==1450 then
EndWave()
end
---Above are attacks!
bs.Update()
frame=frame+1
for i=1,#Bullets do
local bullet=Bullets[i]
if bullet.isactive then
bullet.MoveToAbs(bullet.absx,95+math.sin(frame*0.03)*12)
bullet.sprite.rotation=math.sin(frame*0.02)*12
end
end
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