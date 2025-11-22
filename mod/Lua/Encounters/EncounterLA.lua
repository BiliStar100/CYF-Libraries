-- A basic encounter script skeleton you can copy and modify for your own creations.

music = "IFphase1" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "Sans blocked the way!" --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"1"}
wavetimer = 9999
arenasize = {560, 130}
debug = false
require "ANIM/anima"
timer=0
enemies = {
"SANS"
}

enemypositions = {
{0, 0}
}

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"r1","r2","r3","r4"}
SetGlobal("Waves",0)
SetGlobal("Phase",1)
SetGlobal("Phase2Waves",0)

function EncounterStarting()
bg2=CreateSprite("BG2","BelowUI")
bg2.MoveToAbs(320,0)
bg2.alpha=0
bg3=CreateSprite("BG2","BelowUI")
bg3.MoveToAbs(320,480)
bg3.alpha=0
bg3.rotation=180
Audio.LoadFile("IFPhase2")
Audio.Stop("IFPhase2")
Audio.LoadFile("IFPhase1")
Player.lv = 15
Player.hp = 1100
Inventory.AddCustomItems({"Cinnamon.Bun"}, {0})
Inventory.AddCustomItems({"Tea"}, {0})
Inventory.AddCustomItems({"S.Piece"}, {0})
Inventory.AddCustomItems({"Star"}, {0})
Inventory.AddCustomItems({"Cup"}, {0})
Inventory.SetInventory({"Star","Cinnamon.Bun","Cinnamon.Bun","Cinnamon.Bun","S.Piece","Tea","S.Piece","S.Piece"})
    -- If you want to change the game state immediately, this is the placez.
end

function Update()
--Player.Hurt(0,114514)
bg2.Scale(1,math.abs(math.sin(Time.time*2)*6))
--bg2.MoveTo(320,bg2.yscale*4)
bg3.Scale(1,math.abs(math.sin(Time.time*2)*6))
--bg3.MoveTo(320,480-bg3.yscale*4)
if waitfordodge == true and Input.Confirm == 1 then
atktimer=true
waitfordodge=false
end
if atktimer == true then
timer=timer+1
end
if timer>1 and timer<60 then
Leg.x=Leg.x+(200-Leg.x)/10
end
if timer>60 and timer<100 then
Leg.x=Leg.x+(320-Leg.x)/10
end
if timer == 100 then
timer=0
atktimer=false
end
if GetGlobal("Waves")>=10 then
SetGlobal("Phase",2)
end
Head.MoveTo(0,40+1.4*math.sin(Time.time*8)) 
Torso.MoveTo(-2+math.sin(Time.time*4)*2,-5+math.sin(Time.time*8))
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnteringState(new, old)
if new == "ATTACKING" then
waitfordodge = true
end
if old == "ATTACKING" then
waitfordodge=false
end
end

function EnemyDialogueEnding()
Waves=GetGlobal("Waves")
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    if Waves==0 then
            nextwaves={"empty"}
           -- nextwaves={"xfinal"}  --DEBUGS
            --DEBUGS
           if debug == true then 
           DEBUG("Turn 1")
           end
        elseif Waves==1 then
            nextwaves={"1/1"}
           if debug == true then 
           DEBUG("Turn 1")
           end
            --wavetimer=12
        elseif Waves==2 then
            nextwaves={"1/2"}
           if debug == true then 
           DEBUG("Turn 2")
           end
        elseif Waves==3 then
            nextwaves={"1/3"}
           if debug == true then 
           DEBUG("Turn 3")
           end
            --
        elseif Waves==4 then
            nextwaves={"1/4"}
            if debug == true then 
           DEBUG("Turn 4")
           end
            --
        elseif Waves==5 then
            nextwaves={"1/5"}
           if debug == true then 
           DEBUG("Turn 5")
           end
            
        elseif Waves==6 then
            nextwaves={"1/6"}
           if debug == true then 
           DEBUG("Turn 6")
           end
            --wavetimer = 14.0
        elseif Waves==7 then
            nextwaves={"1/7"}
            
           if debug == true then 
           DEBUG("Turn 7")
           end
        elseif Waves==8 then
            nextwaves={"1/8"}
            
           if debug == true then 
           DEBUG("Turn 8")
           end
          elseif Waves==9 then
          
          Audio.Stop()
            nextwaves={"empty"}
            wavetimer=0
            elseif Waves==10 then
            nextwaves={"2/1"}
            bg2.alpha=1
          bg3.alpha=1
         elseif Waves==11 then
            nextwaves={"2/2"}
           elseif Waves==12 then
            nextwaves={"2/3"}
           elseif Waves==13 then
            nextwaves={"2/4"}
           elseif Waves==14 then
            nextwaves={"2/5"}
           elseif Waves>15 then
           if GetGlobal("Phase2Waves")==9 then
           nextwaves={"Final"}
           else
          nextwaves = { possible_attacks[math.random(#possible_attacks)] }
           end
        else
            nextwaves = { possible_attacks[math.random(#possible_attacks)] }
        end
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
if GetGlobal("Phase")~=2 then
wavetimer=0
    nextwaves={}
    else
    
    end
    if ItemID=="S.PIECE" then
        Player.Heal(45)
        BattleDialog({"You eat the Snowman Piece,\rHP maxed out!"})
        end
    if ItemID=="STAR" then
        Player.Heal(900)
        BattleDialog({"You freaking author eater!\rHP maxed out."})
       Inventory.SetInventory({"Tea","Tea","Tea","Star"})
  end
      if ItemID=="CINNAMON.BUN" then
        Player.Heal(22)
        BattleDialog({"You eat the bunny,\rYou recovered 22 HP!"})
 end
    if ItemID=="TEA" then
        Player.Heal(400)
        BattleDialog({"You drank the tea.\rYour HP is maxed out!"})
        end
    if ItemID=="CUP" then
    Player.Hurt(400)
    end
end
