//Include the required libraries for your scripts.
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_chugabud;


// Initialize the code
init()
{
	level thread onplayerconnect();
}

// When players connected
onplayerconnect()
{
    for(;;)
    {
		level waittill("connected", player);
		self thread quickrevive();								// Executes tweaks for Quick Revive 
		self thread staminup();									// Executes tweaks for Stamin Up
		self thread speedcola();								// Executes tweaks for Speed Cola
    }
}


//// Quick Revive regenerates health
// Credits to teh-bandit
quickrevive()
{
	level endon("end_game");
	self endon("disconnect");
	for (;;)
	{
		if (self hasperk("specialty_quickrevive") && self.health < self.maxHealth)
		{
			self.health += 1;
		}
		wait 0.1;
	}
}

//// Stamin Up now also increases Hold Breath duration, reduces Fall Damage and buffed the movement speed a bit more
staminup()
{
	level endon("end_game");
	self endon("disconnect");
	for (;;)
	{
		self waittill_any("perk_acquired", "perk_lost");
	
		if (self hasperk("specialty_longersprint"))
		{
			self setperk("specialty_movefaster");
			self setperk("specialty_fallheight");
			self setperk("specialty_stalker");
			self setperk("specialty_holdbreath");
		}
		else
		{
			self unsetperk("specialty_movefaster");
			self unsetperk("specialty_fallheight");
			self unsetperk("specialty_stalker");
			self unsetperk("specialty_holdbreath");
		}
	}
}

//// Speed Cola now also affects Melee, Grenades and Equipment.
speedcola()
{
	level endon("end_game");
	self endon("disconnect");
	for (;;)
	{
		self waittill_any("perk_acquired", "perk_lost");
	
		if (self hasperk("specialty_fastreload"))
		{
			self setperk("specialty_fastweaponswitch");
			self setperk("specialty_fastmeleerecovery");
			self setperk("specialty_fasttoss");
			self setperk("specialty_fastequipmentuse");
		}
		else
		{
			self unsetperk("specialty_fastweaponswitch");
			self unsetperk("specialty_fastmeleerecovery");
			self unsetperk("specialty_fasttoss");
			self unsetperk("specialty_fastequipmentuse");
		}
	}
}
