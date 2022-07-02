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


init()
{ 
	replaceFunc( maps/mp/zombies/_zm_weapons::weapon_give, ::weapon_give_override );
	replaceFunc( maps/mp/zombies/_zm_weapons::get_pack_a_punch_weapon_options, ::get_pack_a_punch_weapon_options_override );
	replaceFunc( maps/mp/zombies/_zm_weapons::ammo_give, ::ammo_give_override );	
	
    level.initial_spawn = true;
    level thread onConnect();
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
			self increase_perk_limit();
			self thread quickrevive_tweaks();
			self thread staminup_tweaks();
			self thread speedcola_tweaks();

			// _player.gsc
			self thread setlatepoints();
			self enable_friendly_fire();
			self disable_melee_lunge();
			self thread drop();		

        }

        if(level.initial_spawn)
		{
			level.initial_spawn = false;

			level thread coop_pause();
			level thread fake_reset();

			//_weapons.gsc
			wallbuy_increase_trigger_radius();
			wallbuy_dynamic_increase_trigger_radius();

			wait 10;
			self iprintln("Welcome to PotZombies!" );
			self iprintln("A Harder and more classic zombie experience");
			self iprintln("Major features/changes include:");
			wait 3;
			self iprintln("Bank is disabled");
			self iprintln("Weapon Locker is disabled");
			self iprintln("Perma Upgrades are disabled");
			wait 3;
			self iprintln("More zombies");
			self iprintln("Zombies spawn faster and moves faster");
			self iprintln("Points earned has been massively tweaked");
			wait 3;
			self iprintln("Added perk: Deadshot Daiquiri on Buried and Tranzit");
			self iprintln("Added perk: PHD Flopper on Mob of the Dead, Die Rise, Buried and Tranzit");
			self iprintln("Added Wunderfizz machine on all maps");
			wait 3;
			self iprintln("Mystery Box now costs 1375");
			self iprintln("Wunderfizz now costs 3000");
			self iprintln("Weapons can be dropped by holding down Melee Button");
			wait 3;
			self iprintln("Health set to 190, this allows you to take one extra hit");
			self iprintln("Stamin Up, Speed Cola and Quick Revive has additional effects");
			self iprintln("Fog disabled");
		}
	}
}