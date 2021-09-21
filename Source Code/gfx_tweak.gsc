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
	level thread visuals();
}

// Toggle Fog, LoD, DoF on or off
visuals()
{
	setDvar("r_fog", 0);												// Should FOG be enabled? (1 = Yes, 0 = No) (Default = 1)
	setDvar("r_dof_enable", 0);											// Should Depth of Field be enabled? (1 = Yes, 0 = No) (Default = 1)
	setDvar("r_lodBiasRigid", -1000);									// (1 = Yes, 0 = No) Default = 0
	setDvar("r_lodBiasSkinned", -1000);									// (1 = Yes, 0 = No) Default = 0
	setDvar("r_lodScaleRigid", 1);										// (1 = Yes, 0 = No) Default = 1
	setDvar("r_lodScaleSkinned", 1);									// (1 = Yes, 0 = No) Default = 1
	self useservervisionset(1);											// (1 = Yes, 0 = No) Default = 1
	self setvisionsetforplayer("remote_mortar_enhanced", 0);			// (1 = Yes, 0 = No) Default = 0
}
