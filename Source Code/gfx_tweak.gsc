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
	level endon( "end_game" );
	self endon( "disconnect" );
	while ( 1 )
	{
		level waittill( "connected", player );
		self thread visuals();
	}
}

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