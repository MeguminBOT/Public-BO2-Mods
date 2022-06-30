//Include the required libraries for your scripts.
#include common_scripts/utility;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;

graphic_tweaks()
{
	self setClientDvar("r_fog", 0);										// Should FOG be enabled? (1 = Yes, 0 = No) (Default = 1)
	self setClientDvar("r_dof_enable", 0);								// Should Depth of Field be enabled? (1 = Yes, 0 = No) (Default = 1)
	self setClientDvar("r_lodBiasRigid", -1000);
	self setClientDvar("r_lodBiasSkinned", -1000);
	self setClientDvar("r_lodScaleRigid", 1);
	self setClientDvar("r_lodScaleSkinned", 1);
	self setclientdvar( "r_enablePlayerShadow", 1 );					// (1 = Yes, 0 = No) Default = 1
	self setclientdvar( "sm_sunquality", 2 );
	self useservervisionset(1);											// (1 = Yes, 0 = No) Default = 1
}