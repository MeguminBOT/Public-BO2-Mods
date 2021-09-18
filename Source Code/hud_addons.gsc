//Include the required libraries for your scripts.
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
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
		level thread drawZombiesCounter();						// Execute Zombie Counter HUD Overlay
    }
}

//// Adds a HUD element showing how many zombies are left
// Credits to *INSERT NAME HERE*
drawZombiesCounter()
{
    level.zombiesCounter = createServerFontString("hudsmall" , 1.9);
    level.zombiesCounter setPoint("CENTER", "CENTER", "CENTER", 190);
    while(true)
    {
    	enemies = get_round_enemy_array().size + level.zombie_total;
        if( enemies != 0 )
        	level.zombiesCounter.label = &"Zombies: ^1";
        else
        	level.zombiesCounter.label = &"Zombies: ^6";
        level.zombiesCounter setValue( enemies );
        wait 0.05;
    }
}


