//Include the required libraries for your scripts.
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;

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
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon("disconnect");
    for(;;)
    {
        self waittill("spawned_player");
		self thread setlatepoints();										// Executes the code for Bonus Points if players join later in the game.
		//self thread inspect();											// Executes the code for Inspect Weapon
		self thread drop();													// Executes the code for Drop Weapon
		self disable_melee_lunge();											// Executes the code for disabling Melee Lunging
		self enable_friendly_fire();										// Executes the code for enabling Friendly Fire
    }
}

//// Gives a set amount of money to people joining late
// Credits to Ashton Biehl
setlatepoints()

{
		if(level.round_number >= 10 && self.score < 5000) // You can change the round and money to your liking.
			self.score = 5000;
	        else if(level.round_number >= 20 && self.score < 10000) // You can change the round and money to your liking.
			self.score = 10000;
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

//// ** CURRENTLY DISABLED DUE TO BEING BUGGY**
//// Adds the ability to inspect your weapon by holding down the "Use/Interact" button
// Credits to teh-bandit
//inspect()
//{
//	level endon("end_game");
//	self endon("disconnect");
//	for (;;) 
//	{
//		if (self usebuttonpressed()) 
//		{
//			duration = 0;
//			while (self usebuttonpressed()) 
//			{
//				duration += 1;
//				if (duration == 25) 
//				{
//					self initialweaponraise(self getcurrentweapon());
//					break;
//				}
//				wait 0.05;
//			}
//		}
//		wait 0.05;
//	}
//}


//// Removes two super annoying things that usually kills you in later rounds. 
// Credits to Jbleezy
enable_friendly_fire()
{
	setDvar( "g_friendlyfireDist", "0" );
}

disable_melee_lunge()
{
	setDvar( "aim_automelee_enabled", 0 );
}
