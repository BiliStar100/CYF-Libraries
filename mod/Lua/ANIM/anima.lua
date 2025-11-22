Head=CreateSprite("Sansy/Head0")
Torso=CreateSprite("Sansy/sanstorso")
Leg=CreateSprite("Sansy/sanslegs")
Torso.SetParent(Leg)
Head.SetParent(Torso)
Leg.x = 320
Leg.y = 250
Torso.y = -5 --The torso's height is relative to the legs they're parented to.
Head.y = 40
misstimer = 0
Torso.SetPivot(0.5, 0)
Torso.SetAnchor(0.5, 1)
Leg.SetPivot(0.5, 0)
function miss()
Leg.Move(-3*math.sin(Time.time*2),0)
end
