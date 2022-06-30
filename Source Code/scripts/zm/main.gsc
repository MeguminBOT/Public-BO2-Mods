//Include the required libraries for your scripts.
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_utility;
#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_magicbox;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_blockers;
#include maps/mp/zombies/_zm_pers_upgrades_system;
#include maps/mp/zombies/_zm_perks;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_pers_upgrades_functions;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_weap_claymore;
#include maps/mp/zombies/_zm_melee_weapon;
#include maps/mp/zombies/_zm_craftables;
#include maps/mp/zombies/_zm_equipment;
#include scripts/zm/_bank;
#include scripts/zm/_hud;
#include scripts/zm/_magicbox;
#include scripts/zm/_perks;
#include scripts/zm/_perkscustom;
#include scripts/zm/_players;
#include scripts/zm/_powerups;
#include scripts/zm/_reset;
#include scripts/zm/_utility;
#include scripts/zm/_visual;
#include scripts/zm/_weapons;


main()
{ 
	level.VERSION = "2.0";

	replaceFunc( maps/mp/zombies/_zm_weapons::weapon_give, ::weapon_give_override );
	replaceFunc( maps/mp/zombies/_zm_weapons::get_pack_a_punch_weapon_options, ::get_pack_a_punch_weapon_options_override );
	replaceFunc( maps/mp/zombies/_zm_weapons::ammo_give, ::ammo_give_override );	
	
    level.initial_spawn = true;
    level thread onConnect();
}

init()
{
}

onConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread connected();
    }
}

connected()
{
    level endon( "game_ended" );
    self endon("disconnect");

    self.initial_spawn = true;

    for(;;)
    {
        self waittill("spawned_player");

    	if(self.initial_spawn)
		{
            self.initial_spawn = false;

			self iprintln("Welcome to PotZombies!");
			self iprintln("A Harder zombie experience");
			self iPrintLn("Version " + level.VERSION);

			// _vision.gsc
			self graphic_tweaks();

			// _hud.gsc
	    	self thread timer_hud();
			self thread health_bar_hud();
			self thread zombie_remaining_hud();
			self thread zone_hud();
			self thread color_hud();
			self thread all_hud_watcher();

			// _powerups.gsc
			self thread max_ammo_refill_clip();
			self thread carpenter_repair_shield();

			// _perks.gsc
			increase_perk_limit();
			self thread quickrevive_tweaks();
			self thread staminup_tweaks();
			self thread speedcola_tweaks();

			// _characters.gsc
			setlatepoints();
			enable_friendly_fire();
			disable_melee_lunge();
        }

        if(level.initial_spawn)
		{
			level.initial_spawn = false;

			level thread coop_pause();
			level thread fake_reset();

			//_weapons.gsc
			wallbuy_increase_trigger_radius();
			level thread wallbuy_dynamic_increase_trigger_radius();


		}
	}
}