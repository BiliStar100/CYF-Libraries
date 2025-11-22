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
Arena.Resize(150,150)
GravitySlap("down")
dir={"up","left","right","down"}
function Update()
if frame>0 and frame%60==0 then
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
if frame==1020 then
EndWave()
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