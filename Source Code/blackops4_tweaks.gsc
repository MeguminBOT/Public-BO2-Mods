//Include the required libraries for your scripts.
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;

// Initialize the code
init()
{
	level thread bo4zombiehealth();
}

//// Zombie health does not increase past round 35, like in Black Ops 3/4
// Credits to teh-bandit
bo4zombiehealth()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		level waittill("start_of_round");
		if(level.zombie_health > 11272)
		{
			level.zombie_health = 11272;
		}
	}
}
