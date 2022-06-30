//Include the required libraries for your scripts.
#include common_scripts/utility;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;

//// Remove Perk Limit
increase_perk_limit()
{
	level.perk_purchase_limit = 9;
}

//// Quick Revive regenerates health
// Credits to teh-bandit
quickrevive_tweaks()
{
	self endon("disconnect");

	for (;;)
	{
        self waittill_any("perk_acquired", "perk_lost");

		if (self hasperk("specialty_quickrevive") && self.health < self.maxHealth)
		{
			self.health += 1;
		}
		wait 0.1;
	}
}

//// Stamin Up now also increases Hold Breath duration, reduces Fall Damage and buffed the movement speed a bit more
staminup_tweaks()
{
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
speedcola_tweaks()
{
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