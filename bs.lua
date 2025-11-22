local self={}
local platforms={}
local shadow={}
local directon=nil
local decrease=0.08
local xspeed=0
local yspeed=0
local OnPlatform=nil
local platformxspd=0
local platformyspd=0
local Falling=nil
self.platforms={}
local Platform=nil

function self.into(dir)
Player.SetControlOverride(true)
direction=dir
ShadowPlayer=CreateSprite("ut-heart","Top")
ShadowPlayer.color={0,0,1}
ShadowPlayer.MoveTo(Player.absx,Player.absy)
ShadowPlayer.rotation=Player.sprite.rotation
table.insert(shadow,ShadowPlayer)
end

function GravitySlap(dir)
Player.SetControlOverride(true)
direction=dir
if not Grounded() then
yspeed=-8
slapping=true
end
end

function self.dir(dir)
direction=dir
Player.SetControlOverride(true)
yspeed=0
end

function self.Update()
if slapping==true and Grounded() then
Audio.PlaySound("Bang",5)
slapping=false
end
for i=1,#self.platforms do
local plat=self.platforms[i]
if plat.isactive then
plat.Move(plat.GetVar("velx"),plat.GetVar("vely"))
local Dir=plat.GetVar("dir")
if Dir=="up" then
plat.sprite.rotation=180
end
if Dir=="left" then
plat.sprite.rotation=-90
end
if Dir=="right" then
plat.sprite.rotation=90
end
if direction=="down" and plat.GetVar("dir")=="down" then
if Player.absx<=plat.absx+plat.sprite.width/2 and Player.absx>=plat.absx-plat.sprite.width/2 then
if Player.absy<=plat.absy+plat.sprite.height/2 and Player.absy>=plat.sprite.height/2+plat.absy-9 then
Player.MoveToAbs(Player.absx,plat.absy+plat.sprite.height/2)
OnPlatform=true
Platform=plat
else
OnPlatform=false
Platform=nil
end
end
end
if direction=="up" and plat.GetVar("dir")=="up" then
if Player.absx<=plat.absx+plat.sprite.width/2 and Player.absx>=plat.absx-plat.sprite.width/2 then
if Player.absy>=plat.absy-plat.sprite.height/2 and Player.absy<=-plat.sprite.height/2+plat.absy+4 then
Player.MoveToAbs(Player.absx,plat.absy-plat.sprite.height/2)
OnPlatform=true
Platform=plat
else
OnPlatform=false
Platform=nil
end
else
OnPlatform=false
Platform=nil
end
end
if direction=="left" and plat.GetVar("dir")=="left" then
if Player.absy<=plat.absy+plat.sprite.width/2 and Player.absy>=plat.absy-plat.sprite.width/2 then
if Player.absx<=plat.absx+plat.sprite.height/2 and Player.absx>=plat.sprite.height/2+plat.absx-4 then
Player.MoveToAbs(plat.absx+plat.sprite.height/2,Player.absy)
OnPlatform=true
Platform=plat
else
OnPlatform=false
Platform=nil
end
else
OnPlatform=false
Platform=nil
end
end
if direction=="right" and plat.GetVar("dir")=="right" then
if Player.absy<=plat.absy+plat.sprite.width/2 and Player.absy>=plat.absy-plat.sprite.width/2 then
if Player.absx>=plat.absx-plat.sprite.height/2 and Player.absx<=-plat.sprite.height/2+plat.absx+4 then
Player.MoveToAbs(plat.absx-plat.sprite.height/2,Player.absy)
OnPlatform=true
Platform=plat
else
OnPlatform=false
Platform=nil
end
else
OnPlatform=false
Platform=nil
end
end
end
end
if Platform then
platformxspd=Platform.GetVar("xspd")
platformyspd=Platform.GetVar("yspd")
else
platformxspd=0
platformyspd=0
end
if Platform then
if Player.absx>Platform.absx+Platform.sprite.width/2 or Player.absx<Platform.absx-Platform.sprite.width/2 then
Platform=nil
OnPlatform=false
end
end
if direction=="down" then
Player.sprite.rotation=0
Player.sprite.color={0,0,1}
Player.Move(DirLR(),DirUD())
end
if direction=="up" then
Player.sprite.rotation=180
Player.sprite.color={0,0,1}
Player.Move(DirLR(),-DirUD())
end
if direction=="left" then
Player.sprite.rotation=-90
Player.sprite.color={0,0,1}
Player.Move(DirUD(),DirLR())
end
if direction=="right" then
Player.sprite.rotation=90
Player.sprite.color={0,0,1}
Player.Move(-DirUD(),DirLR())
end
for i=1,#shadow do
shad=shadow[i]
shad.Scale(shad.xscale+0.08,shad.yscale+0.08)
shad.alpha=shad.alpha-0.022
end
end

function DirLR()
if Input.Cancel>0 then
spd=1
else
spd=2.2
end
if (direction=="up" or direction=="down")then
if Input.Left>0 then
xspeed=-spd
elseif Input.Right>0 then
xspeed=spd
else
xspeed=0
end
end
if (direction=="left" or direction=="right")then
if Input.Up>0 then
xspeed=spd
elseif Input.Down>0 then
xspeed=-spd
else
xspeed=0
end
end
return xspeed+(platformxspd)
end

function DirUD()
if Grounded() then
Falling = false
end
if yspeed<=0 then
Falling=true
else
Falling=false
end
if not Grounded() then
yspeed=yspeed-decrease
end
if Falling==false and Jumper()==-1 then
yspeed=0.07
end
if Grounded() then
if Jumper()>0 then
yspeed=3.5
else
yspeed=0
end
end
return yspeed+(platformyspd)
end

function Grounded()
bool=nil
if     direction == "down"  and (Player.y - (Player.sprite.height/2)) > -(Arena.currentheight/2) and Platform==nil then
        bool = false
        
    elseif direction == "right" and (Player.x + (Player.sprite.width/2))  <  (Arena.currentwidth/2) then
        bool = false
        
    elseif direction == "up"    and (Player.y + (Player.sprite.height/2)) <  (Arena.currentheight/2) then
        bool = false
        
    elseif direction == "left"  and (Player.x - (Player.sprite.width/2))  > -(Arena.currentwidth/2) then
        bool = false
    else
        bool = true
    end
    if OnPlatform then
    bool=true
    end
    if OnPlatform and Jumper()>0 then
    OnPlatform=false
    end
return bool
end

function Jumper()
if direction=="down" then
return Input.Up
end
if direction=="up" then
return Input.Down
end
if direction=="left" then
return Input.Right
end
if direction=="right" then
return Input.left
end
end

function self.ismoving()
local yeeee=nil
if not Grounded() or xspeed~=0 then
yeeee=true
end
if Grounded() and xspeed==0 then
yeeee=false
end
return yeeee
end

function self.back()
Player.sprite.color={1,0,0}
Player.SetControlOverride(false)
Player.sprite.rotation=0
end

return self