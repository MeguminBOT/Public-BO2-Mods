//Script by GerardS0406
//https://forum.plutonium.pw/topic/1822/release-zombies-wunderfizz-script-all-maps

#include maps\mp\zombies\_zm_utility;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

init()
{
    thread setupWunderfizz();
}

setupWunderfizz()
{
	level.wunderfizzChecksPower = getDvarIntDefault( "wunderfizzChecksPower", 1 );
	level.wunderfizzCost = getDvarIntDefault("wunderfizzCost", 1500);
	wunderfizzUseRandomStart = getDvarIntDefault("wunderfizzUseRandomStart", 0 );
	level.wunderfizz_locations = 0;
	if(wunderfizzUseRandomStart)
		level.currentWunderfizzLocation = 0;
	else
		level.currentWunderfizzLocation = 1;
    if(level.script == "zm_nuked")
    {
    	wunderfizzSetup((-649,281,-56), (0,162,0), "zombie_vending_jugg");
    	wunderfizzSetup((-915,286,-56), (0,66,0), "zombie_vending_jugg");
    	wunderfizzSetup((716,21,-57), (0,192,0), "zombie_vending_jugg");
    	//DO NOT TOUCH BELOW IF YOU DON'T KNOW WHAT YOU'RE DOING
    	if(wunderfizzUseRandomStart)
    	{
    		level waittill("connected", player);
    		wait 1;
			level.currentWunderfizzLocation = chooseLocation(level.currentWunderfizzLocation);
			level notify("wunderfizzMove");
    	}
    }
    else if(level.script == "zm_prison")
    {
    	wunderfizzSetup((-377,-3903,-8448), (0,270, 0), "p6_zm_al_vending_jugg_on");
    	wunderfizzSetup((2046, 10332.9, 1336), (0,180,0), "p6_zm_al_vending_jugg_on");
    	wunderfizzSetup((-1056,8673,1336), (0,90,0), "p6_zm_al_vending_jugg_on");
    	wunderfizzSetup((2795,9270,1336), (0,180,0), "p6_zm_al_vending_jugg_on");
    	wunderfizzSetup((-843,5585,-72), (0,13,0), "p6_zm_al_vending_jugg_on");
    	wunderfizzSetup((2724,9563,1708), (0,90,0), "p6_zm_al_vending_jugg_on");
    	//DO NOT TOUCH BELOW IF YOU DON'T KNOW WHAT YOU'RE DOING
    	if(wunderfizzUseRandomStart)
    	{
    		level waittill("connected", player);
    		wait 1;
			level.currentWunderfizzLocation = chooseLocation(level.currentWunderfizzLocation);
			level notify("wunderfizzMove");
    	}
    }
    else if(level.script == "zm_buried")
    {
    	wunderfizzSetup((146,138,10), (0,270,0), "zombie_vending_jugg");
    	wunderfizzSetup((-374,-1103,8), (0,270,0), "zombie_vending_jugg");
    	wunderfizzSetup((-58,-1512,168), (0,180,0), "zombie_vending_jugg");
    	wunderfizzSetup((1521,1366,-14), (0,342,0), "zombie_vending_jugg");
    	wunderfizzSetup((4910,725,2), (0,0,0), "zombie_vending_jugg");
    	wunderfizzSetup((6862,846,108), (0,49,0), "zombie_vending_jugg");
    	//DO NOT TOUCH BELOW IF YOU DON'T KNOW WHAT YOU'RE DOING
    	if(wunderfizzUseRandomStart)
    	{
    		level waittill("connected", player);
    		wait 1;
			level.currentWunderfizzLocation = chooseLocation(level.currentWunderfizzLocation);
			level notify("wunderfizzMove");
    	}
    }
    else if(level.script == "zm_transit")
    {
    	wunderfizzSetup((11168,8120,-576), (0,0,0), "zombie_vending_jugg");
    	wunderfizzSetup((-7103,4952,-56), (0,0,0), "zombie_vending_jugg");
    	wunderfizzSetup((-11824,-1495,228), (0,90,0), "zombie_vending_jugg");
    	wunderfizzSetup((-5043,-7772,-61), (0,180,0), "zombie_vending_jugg");
    	wunderfizzSetup((8371,-5408,264), (0,180,0), "zombie_vending_jugg");
    	wunderfizzSetup((1823,114,88), (0,90,0), "zombie_vending_jugg");
    	//DO NOT TOUCH BELOW IF YOU DON'T KNOW WHAT YOU'RE DOING
    	if(wunderfizzUseRandomStart)
    	{
    		level waittill("connected", player);
    		wait 1;
			level.currentWunderfizzLocation = chooseLocation(level.currentWunderfizzLocation);
			level notify("wunderfizzMove");
    	}
    }
    else if(level.script == "zm_highrise")
    {
    	wunderfizzSetup((2608, 275, 1296), (0,60,0), "zombie_vending_jugg");
    	wunderfizzSetup((1482, 1060, 3395), (0,180,0), "zombie_vending_jugg");
    	wunderfizzSetup((2964, 2698, 2905), (349,0,0), "zombie_vending_jugg");
    	wunderfizzSetup((1648, -635, 2880), (0,150,0), "zombie_vending_jugg");
    	wunderfizzSetup((1809, 1459, 3040), (0,0,0), "zombie_vending_jugg");
    	//DO NOT TOUCH BELOW IF YOU DON'T KNOW WHAT YOU'RE DOING
    	if(wunderfizzUseRandomStart)
    	{
    		level waittill("connected", player);
    		wait 1;
			level.currentWunderfizzLocation = chooseLocation(level.currentWunderfizzLocation);
			level notify("wunderfizzMove");
    	}
    }
}

getPerks()
{
	perks = [];
	//Order is Rainbow
	if(isDefined(level.zombiemode_using_juggernaut_perk) && level.zombiemode_using_juggernaut_perk)
	{
		perks[perks.size] = "specialty_armorvest";
	}
	if(isDefined(level._custom_perks[ "specialty_nomotionsensor"] ))
	{
		perks[perks.size] = "specialty_nomotionsensor";
	}
	if ( isDefined( level.zombiemode_using_doubletap_perk ) && level.zombiemode_using_doubletap_perk )
	{
		perks[perks.size] = "specialty_rof";
	}
	if ( isDefined( level.zombiemode_using_marathon_perk ) && level.zombiemode_using_marathon_perk )
	{
		perks[perks.size] = "specialty_longersprint";
	}
	if ( isDefined( level.zombiemode_using_sleightofhand_perk ) && level.zombiemode_using_sleightofhand_perk )
	{
		perks[perks.size] = "specialty_fastreload";
	}
	if(isDefined(level.zombiemode_using_additionalprimaryweapon_perk) && level.zombiemode_using_additionalprimaryweapon_perk)
	{
		perks[perks.size] = "specialty_additionalprimaryweapon";
	}
	if ( isDefined( level.zombiemode_using_revive_perk ) && level.zombiemode_using_revive_perk )
	{
		perks[perks.size] = "specialty_quickrevive";
	}
	if ( isDefined( level.zombiemode_using_chugabud_perk ) && level.zombiemode_using_chugabud_perk )
	{
		perks[perks.size] = "specialty_finalstand";
	}
	if ( isDefined( level._custom_perks[ "specialty_grenadepulldeath" ] ))
	{
		perks[perks.size] = "specialty_grenadepulldeath";
	}
	if ( isDefined( level._custom_perks[ "specialty_flakjacket" ]) && level.script != "zm_buried" )
	{
		perks[perks.size] = "specialty_flakjacket";
	}
	if ( isDefined( level.zombiemode_using_deadshot_perk ) && level.zombiemode_using_deadshot_perk )
	{
		perks[perks.size] = "specialty_deadshot";
	}
	if ( isDefined( level.zombiemode_using_tombstone_perk ) && level.zombiemode_using_tombstone_perk )
	{
		perks[perks.size] = "specialty_scavenger";
	}
	return perks;
}

getPerkName(perk)
{
	if(perk == "specialty_armorvest")
		return "Juggernog";
	if(perk == "specialty_rof")
		return "Double Tap";
	if(perk == "specialty_longersprint")
		return "Stamin-Up";
	if(perk == "specialty_fastreload")
		return "Speed Cola";
	if(perk == "specialty_additionalprimaryweapon")
		return "Mule Kick";
	if(perk == "specialty_quickrevive")
		return "Quick Revive";
	if(perk == "specialty_finalstand")
		return "Who's Who";
	if(perk == "specialty_grenadepulldeath")
		return "Electric Cherry";
	if(perk == "specialty_flakjacket")
		return "PHD Flopper";
	if(perk == "specialty_deadshot")
		return "Deadshot Daiquiri";
	if(perk == "specialty_scavenger")
		return "Tombstone";
	if(perk == "specialty_nomotionsensor")
		return "Vulture Aid";
}

getPerkModel(perk)
{
	if(perk == "specialty_armorvest")
	{
		if( level.script == "zm_prison" )
			return "p6_zm_al_vending_jugg_on";
		else
			return "zombie_vending_jugg";
	}
	if(perk == "specialty_nomotionsensor")
		return "p6_zm_vending_vultureaid";
	if(perk == "specialty_rof")
	{
		if(level.script == "zm_prison")
			return "p6_zm_al_vending_doubletap2_on";
		else
			return "zombie_vending_doubletap2";
	}
	if(perk == "specialty_longersprint")
		return "zombie_vending_marathon";
	if(perk == "specialty_fastreload")
	{
		if( level.script == "zm_prison" )
			return "p6_zm_al_vending_sleight_on";
		else
			return "zombie_vending_sleight";
	}
	if(perk == "specialty_quickrevive")
		return "zombie_vending_revive";
	if(perk == "specialty_scavenger")
		return "zombie_vending_tombstone";
	if(perk == "specialty_finalstand")
		return "p6_zm_vending_chugabud";
	if(perk == "specialty_grenadepulldeath")
		return "p6_zm_vending_electric_cherry_on";
	if(perk == "specialty_additionalprimaryweapon")
		return "zombie_vending_three_gun";
	if(perk == "specialty_deadshot")
	{
		if(level.script == "zm_prison")
			return "p6_zm_al_vending_ads_on";
		else
			return "zombie_vending_ads";
	}
}
getPerkBottleModel(perk)
{
	if(perk == "specialty_armorvest")
		return "t6_wpn_zmb_perk_bottle_jugg_world";
	if(perk == "specialty_rof")
		return "t6_wpn_zmb_perk_bottle_doubletap_world";
	if(perk == "specialty_longersprint")
		return "t6_wpn_zmb_perk_bottle_marathon_world";
	if(perk == "specialty_nomotionsensor")
		return "t6_wpn_zmb_perk_bottle_vultureaid_world";
	if(perk == "specialty_fastreload")
		return "t6_wpn_zmb_perk_bottle_sleight_world";
	if(perk == "specialty_flakjacket")
		return "t6_wpn_zmb_perk_bottle_nuke_world";
	if(perk == "specialty_quickrevive")
		return "t6_wpn_zmb_perk_bottle_revive_world";
	if(perk == "specialty_scavenger")
		return "t6_wpn_zmb_perk_bottle_tombstone_world";
	if(perk == "specialty_finalstand")
		return "t6_wpn_zmb_perk_bottle_chugabud_world";
	if(perk == "specialty_grenadepulldeath")
		return "t6_wpn_zmb_perk_bottle_cherry_world";
	if(perk == "specialty_additionalprimaryweapon")
		return "t6_wpn_zmb_perk_bottle_mule_kick_world";
	if(perk == "specialty_deadshot")
		return "t6_wpn_zmb_perk_bottle_deadshot_world";
}

wunderfizzSetup(origin, angles, model)
{
	level.wunderfizz_locations++;
	collision = spawn("script_model", origin);
    collision setModel("collision_geo_cylinder_32x128_standard");
    collision rotateTo(angles, .1);
	wunderfizzMachine = spawn("script_model", origin);
	wunderfizzMachine setModel(model);
	wunderfizzMachine rotateTo(angles, .1);
	wunderfizzBottle = spawn("script_model", origin);
	wunderfizzBottle setModel("tag_origin");
	wunderfizzBottle.angles = angles;
	wunderfizzBottle.origin += vectorScale( ( 0, 0, 1 ), 55 );
	wunderfizzMachine.bottle = wunderfizzBottle;
	wunderfizzMachine.location = level.wunderfizz_locations;
	wunderfizzMachine.uses = 0;
	perks = getPerks();
	cost = level.wunderfizzCost;
	trig = spawn("trigger_radius", origin, 1, 50, 50);
	trig SetCursorHint("HINT_NOICON");
	wunderfizzMachine thread wunderfizz(origin, angles, model, cost, perks, trig, wunderfizzBottle);
}

wunderfizz(origin, angles, model, cost, perks, trig, wunderfizzBottle )
{
	self thread playLocFX();
	if(level.wunderfizzChecksPower && level.script != "zm_prison" && level.script != "zm_nuked")
	{
		trig SetHintString("Power Must Be Activated First");
		flag_wait("power_on");
		trig SetHintString(" ");
	}
	else
	{
		trig SetHintString(" ");
	}
	for(;;)
	{
		if(level.currentWunderfizzLocation == self.location)
		{
			self ShowPart("j_ball");
			for(;;)
			{
				trig SetHintString("Hold ^3&&1^7 to buy Perk-a-Cola [Cost: " + cost + "]");
				trig waittill("trigger", player);
				if(player UseButtonPressed() && player.score >= cost && player.isDrinkingPerk == 0)
				{
					if(player.num_perks < level.perk_purchase_limit)
					{
						if(player.num_perks < perks.size)
						{
							self thread wunderfizzSounds();
							player playsound("zmb_cha_ching");
							self.uses++;
							player.score -= cost;
							trig setHintString(" ");
							rtime = 3;
							wunderfx = SpawnFX(level._effect["wunderfizz_loop"], self.origin,AnglesToForward(angles),AnglesToUp(angles));
							TriggerFX(wunderfx);
							self thread perk_bottle_motion();
							wait .1;
							while(rtime>0)
							{
								for(;;)
								{
									perkForRandom = perks[randomInt(perks.size)];
									if(!(player hasPerk(perkForRandom) || (player maps/mp/zombies/_zm_perks::has_perk_paused(perkForRandom))))
									{
                                        self setModel(getPerkModel(perkForRandom));
                                        break;
									}
								}
								wait .1;
								rtime -= .1;
							}
							self notify( "done_cycling" );
							if((self.uses >= RandomIntRange(3,7)) && (level.wunderfizz_locations > 1))
							{
                                self setModel("zombie_teddybear");
                                self.angles = angles + (0,-90,0);
                                wunderfx Delete();
                                trig SetHintString("Wunderfizz is Moving");
                                wait 7;
                                level.currentWunderfizzLocation = chooseLocation(level.currentWunderfizzLocation);
                                level notify("wunderfizzMove");
                                self.angles = angles;
                                self setModel(model);
                                self.uses = 0;
                                break;
							}
							else
                            {
								perklist = array_randomize(perks);
								for(j=0;j<perklist.size;j++)
								{
									if(!(player hasPerk(perklist[j]) || (self maps/mp/zombies/_zm_perks::has_perk_paused(perklist[j]))))
									{
										perkName = getPerkName(perklist[j]);
                                        if(level.script == "zm_prison")
                                        {
                                            self setModel(getPerkModel(perklist[j]));
                                            fx = SpawnFX(level._effect["electriccherry"], origin, AnglesToForward(angles),AnglesToUp(angles));
                                        }
                                        else
                                        {
                                            self setModel(getPerkModel(perklist[j]) + "_on");
                                            fx = SpawnFX(level._effect["tombstone_light"], origin, AnglesToForward(angles),AnglesToUp(angles));
                                        }
                                        TriggerFX(fx);
										trig SetHintString("Hold ^3&&1^7 for " + perkName);
										time = 7;
										while(time > 0)
										{
											if(player UseButtonPressed() && distance(player.origin, trig.origin) < 65)
											{
												player thread givePerk(perklist[j]);
												break;
											}
											TriggerFX(wunderfx);
											wait .2;
											time -= .2;
										}
										self setModel(model);
										self.bottle setModel("tag_origin");
										trig SetHintString(" ");
										level notify("wunderSpinStop");
										fx Delete();
										break;
									}
								}
								wunderfx Delete();
								wait 2;
								trig SetHintString("Hold ^3&&1^7 to buy Perk-a-Cola [Cost: " + cost + "]");
							}
						}
						else
						{
							trig SetHintString("You Have All " + perks.size + " Perks");
							wait 2;
							trig SetHintString("Hold ^3&&1^7 to buy Perk-a-Cola [Cost: " + cost + "]");
						}
					}
					else{
						trig SetHintString("You Can Only Hold " + level.perk_purchase_limit + " Perks");
						wait 2;
						trig SetHintString("Hold ^3&&1^7 to buy Perk-a-Cola [Cost: " + cost + "]");
					}
				}
				wait .1;
			}
		}
		else{
			trig SetHintString("Wunderfizz Orb is at Another Location");
			self HidePart("j_ball");
			level waittill("wunderfizzMove");
		}
		wait .1;
	}
}

playLocFX()
{
	level waittill("connected", player);
	for(;;)
	{
		fx = SpawnFX(level._effect["lght_marker"], self.origin);
		if(self.location == level.currentWunderfizzLocation)
		{
			TriggerFX(fx);
		}
		level waittill("wunderfizzMove");
		fx Delete();
	}
}

chooseLocation(currLoc)
{
	for(;;)
	{
		loc = RandomIntRange(1, level.wunderfizz_locations + 1);
		if(currLoc != loc)
		{
			return loc;
		}
		wait .1;
	}
}


perk_bottle_motion()
{
	putouttime = 3;
	putbacktime = 10;
	v_float = anglesToForward( self.angles - ( 0, 90, 0 ) ) * 10;
	self.bottle.origin = self.origin + ( 0, 0, 53 );
	self.bottle.angles = self.angles;
	self.bottle.origin -= v_float;
	self.bottle moveto( self.bottle.origin + v_float, putouttime, putouttime * 0.5 );
	self.bottle.angles += ( 0, 0, 10 );
	self.bottle rotateyaw( 720, putouttime, putouttime * 0.5 );
	self waittill( "done_cycling" );
	self.bottle.angles = self.angles;
	self.bottle moveto( self.bottle.origin - v_float, putbacktime, putbacktime * 0.5 );
	self.bottle rotateyaw( 90, putbacktime, putbacktime * 0.5 );
}

wunderfizzSounds()
{
	sound_ent = spawn("script_origin", self.origin);
	sound_ent StopSounds();
	sound_ent PlaySound( "zmb_rand_perk_start");
	sound_ent PlayLoopSound("zmb_rand_perk_loop", 0.5);
	level waittill("wunderSpinStop");
	sound_ent StopLoopSound(1);
	sound_ent PlaySound("zmb_rand_perk_stop");
	sound_ent Delete();
}

givePerk(perk)
{
	if(!(self hasPerk(perk) || (self maps/mp/zombies/_zm_perks::has_perk_paused(perk))))
	{
		self.isDrinkingPerk = 1;
		gun = self maps/mp/zombies/_zm_perks::perk_give_bottle_begin(perk);
        evt = self waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete");
        if (evt == "weapon_change_complete")
        self thread maps/mp/zombies/_zm_perks::wait_give_perk(perk, 1);
       	self maps/mp/zombies/_zm_perks::perk_give_bottle_end(gun, perk);
       	self.isDrinkingPerk = 0;
    	if (self maps/mp/zombies/_zm_laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission)
        	return;
    	self notify("burp");
	}
}