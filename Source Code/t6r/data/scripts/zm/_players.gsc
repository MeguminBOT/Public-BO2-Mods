#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_utility;
#include common_scripts/utility;
#include maps/mp/zombies/_zm_audio;
#include scripts/zm/_utility;

enable_friendly_fire()
{
	setDvar( "g_friendlyfireDist", 0 );
}

disable_melee_lunge()
{
	setDvar( "aim_automelee_enabled", 0 );
}


//// Gives a set amount of money to people joining late
// Credits to Ashton Biehl
setlatepoints()
{
		if(level.round_number >= 5 && self.score < 1250) // You can change the round and money to your liking.
			self.score = 1250;
		if(level.round_number >= 10 && self.score < 2500) // You can change the round and money to your liking.
			self.score = 2500;
		if(level.round_number >= 15 && self.score < 5000) // You can change the round and money to your liking.
			self.score = 5000;
	    if(level.round_number >= 20 && self.score < 7500) // You can change the round and money to your liking.
			self.score = 7500;
		else if(level.round_number >= 25 && self.score < 10000) // You can change the round and money to your liking.
			self.score = 1000;
}

//// Adds the ability to drop your weapon by holding down the "Melee" button
// Credits to teh-bandit
drop()
{
	level endon("end_game");
	self endon("disconnect");
	for (;;) 
	{
		if (self meleebuttonpressed()) 
		{
			duration = 0;
			while (self meleebuttonpressed()) 
			{
				duration += 1;
				if (duration == 25) 
				{
					weap = self getCurrentWeapon();
					self dropItem(weap);
					break;
				}
				wait 0.05;
			}
		}
		wait 0.05;
	}
}