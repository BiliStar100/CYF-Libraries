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
cir1={}
cir2={}
cir3={}
ma=0
colors={"cyan","orange"}

function Update()
ma=ma+1
radius=math.sin(frame*0.04)*75
if frame==20 then
radius=10
Chick()
Arena.ResizeImmediate(130,130)
end
if frame==50 then
RemoveChick()
for i=1,6 do
ba=Spawn("Bone0",radius*math.cos(math.rad(i*60)),radius*math.cos(math.rad(i*60)),i*60,0,0,0,"white",true)
table.insert(cir1,ba)
end
end
if frame==360 then
CleanUp()
Chick()
end
if frame==390 then
RemoveChick()
for i=1,6 do
ba=Spawn("Bone0",radius*math.cos(math.rad(i*60)),radius*math.cos(math.rad(i*60)),i*60,0,0,0,"white",true)
table.insert(cir2,ba)
end
end
if frame==720 then
CX=320
CY=95+65
radius2=110
CleanUp()
Chick()
end
if frame==750 then
RemoveChick()
end
if frame==800 then
Chick()
end
if frame==830 then
RemoveChick()
for i=1,30 do
ba=SpawnAbs("Bone8",CX+radius2*math.cos(math.rad(i*12)),CY+radius2*math.cos(math.rad(i*12)),i*12,0,0,0,"white",true)
table.insert(cir3,ba)
end
end
if frame==1200 then
EndWave()
end
---Above are attacks!
for i=1,#cir1 do
local bullet=cir1[i]
if bullet.isactive then
bullet.sprite.rotation=bullet.sprite.rotation+2
bullet.MoveTo(radius*math.sin(math.rad(bullet.sprite.rotation+ma)),radius*math.cos(math.rad(bullet.sprite.rotation+ma)))
end
end
for i=1,#cir2 do
local bullet=cir2[i]
if bullet.isactive then
bullet.sprite.rotation=bullet.sprite.rotation+2
bullet.MoveTo(radius*math.cos(math.rad(bullet.sprite.rotation+ma)),radius*math.sin(math.rad(bullet.sprite.rotation+ma)))
end
end
for i=1,#cir3 do
local bullet=cir3[i]
if bullet.isactive and frame<=900 then
bullet.sprite.rotation=bullet.sprite.rotation+2
bullet.MoveToAbs(CX+radius2*math.cos(math.rad(bullet.sprite.rotation+90)),CY+radius2*math.sin(math.rad(bullet.sprite.rotation+90)))
if frame==860 then
bullet.SetVar("color",colors[math.random(1,2)])
end
end
if frame==900+i*4 then
bullet.SetVar("velx",-6*math.cos(math.rad(bullet.sprite.rotation+90)))
bullet.SetVar("vely",-6*math.sin(math.rad(bullet.sprite.rotation+90)))
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
end
--[[
Spawn(Sprite,Sx,Sy,Rot,MoveX,MoveY,KeepRot,color,masked)  --普通骨头（贴图，X，Y，旋转角度，X轴速度，Y轴速度，连续转动速度，颜色，是否遮挡）
Angle(Sprite,Sx,Sy,Angle,masked,Speed,color)  --角度移动（贴图，X，Y，角度，是否遮挡，运动速度，颜色）
Target(Sprite,Sx,Sy,masked,ReachTime,color,Tx,Ty)  --定点射击（贴图，X，Y，是否遮挡，速度(其实就是到达目标坐标的时间），颜色，目标X，目标Y）
]]--