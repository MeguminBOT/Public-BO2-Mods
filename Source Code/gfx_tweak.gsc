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
        self thread visuals();											// Execute Fog, DoF, LoD Dvars
    }
}

// Toggle Fog, LoD, DoF on or off
visuals()
{
	self setClientDvar("r_fog", 0);										// Should FOG be enabled? (1 = Yes, 0 = No) (Default = 1)
	self setClientDvar("r_dof_enable", 0);								// Should Depth of Field be enabled? (1 = Yes, 0 = No) (Default = 1)
	self setClientDvar("r_lodBiasRigid", -1000);						// (1 = Yes, 0 = No) Default = 0
	self setClientDvar("r_lodBiasSkinned", -1000);						// (1 = Yes, 0 = No) Default = 0
	self setClientDvar("r_lodScaleRigid", 1);							// (1 = Yes, 0 = No) Default = 1
	self setClientDvar("r_lodScaleSkinned", 1);							// (1 = Yes, 0 = No) Default = 1
	self useservervisionset(1);											// (1 = Yes, 0 = No) Default = 1
	self setvisionsetforplayer("remote_mortar_enhanced", 0);			// (1 = Yes, 0 = No) Default = 0
}
