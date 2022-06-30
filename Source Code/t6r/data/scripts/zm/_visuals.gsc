#include common_scripts/utility;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;

init()
{
    level waittill("connected", player);
    level thread onplayerconnect();
}

onplayerconnect()
{
    level endon( "game_ended" );
    self endon("disconnect");

    for(;;)
    {
	    level thread visuals();
	}
}

visuals()
{
	setDvar("r_fogOpacity", 0);
	setDvar("r_fog", 0);
	setDvar("r_fog_disable", 1);
	setDvar("r_dof_enable", 0);
	setDvar("r_lodBiasRigid", -1000);
	setDvar("r_lodBiasSkinned", -1000);
	setDvar("r_lodScaleRigid", 1);
	setDvar("r_lodScaleSkinned", 1);
	setDvar("r_enablePlayerShadow", 1);
	setDvar("sm_sunquality", 2);
	self useservervisionset(1);
	self setvisionsetforplayer("", 0);
}