//Include the required libraries for your scripts.
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_unitrigger;
#include maps\mp\zombies\_zm_pers_upgrades_system;
#include maps\mp\zombies\_zm_pers_upgrades_functions;
#include maps\mp\zombies\_zm_stats;

// Initialize the code
init()
{
	level.initial_spawn = true;
	thread onplayerconnect();
}

// Runs whenever a player connects
onplayerconnect()
{
	while(1)
	{
		level waittill("connecting", player);
		player thread onplayerspawned();
	}
}

// Runs whenever a player spawns
onplayerspawned()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	
	self.initial_spawn = true;
	
	for(;;)
	{
		self waittill( "spawned_player" );

		if(level.initial_spawn)
		{
			level.initial_spawn = false;
			level thread disable_bank();
			level thread disable_pers_upgrades();
		}

		if (self.initial_spawn)
		{	
			self thread bank_clear_account_value();
			self thread disable_weapon_locker();
			self thread weapon_locker_clear_stored_weapondata();
			self thread disable_player_pers_upgrades();
		}
	}
}

// Disables the money bank
disable_bank()
{
	for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
	{
		if(IsDefined(level._unitriggers.trigger_stubs[i].targetname))
		{
			if(level._unitriggers.trigger_stubs[i].targetname == "bank_deposit" || level._unitriggers.trigger_stubs[i].targetname == "bank_withdraw")
			{
				maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( level._unitriggers.trigger_stubs[i] );
			}
		}
	}
	level notify( "stop_bank_teller" );
	bank_teller_dmg_trig = getent( "bank_teller_tazer_trig", "targetname" );
	if(IsDefined(bank_teller_dmg_trig))
	{
		bank_teller_transfer_trig = getent( bank_teller_dmg_trig.target, "targetname" );
		bank_teller_dmg_trig delete();
		bank_teller_transfer_trig delete();
	}
}

// Force set players money bank to 0 when connected to the server
bank_clear_account_value()
{
	self.account_value = 0;
	self maps\mp\zombies\_zm_stats::set_map_stat( "depositBox", player.account_value, level.banking_map );
}

// Disables weapon bank
disable_weapon_locker()
{
	for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
	{
		if(IsDefined(level._unitriggers.trigger_stubs[i].targetname))
		{
			if(level._unitriggers.trigger_stubs[i].targetname == "weapon_locker")
			{
				maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( level._unitriggers.trigger_stubs[i] );
			}
		}
	}
}

// Force clear players weapon bank when connected to the server
weapon_locker_clear_stored_weapondata()
{
	if ( level.weapon_locker_online )
	{
		self maps\mp\zombies\_zm_stats::clear_stored_weapondata( level.weapon_locker_map );
	}
	else
	{
		self.stored_weapon_data = undefined;
	}
}

// Disables perma perk upgrades
disable_pers_upgrades()
{
	level waittill("initial_disable_player_pers_upgrades");
	level.pers_upgrades_keys = [];
	level.pers_upgrades = [];
}

// Force remove perma perks from players when connected to the server
disable_player_pers_upgrades()
{
	if (isDefined(self.pers_upgrades_awarded))
	{
		upgrade = getFirstArrayKey(self.pers_upgrades_awarded);
		while (isDefined(upgrade))
		{
			self.pers_upgrades_awarded[upgrade] = 0;
			upgrade = getNextArrayKey(self.pers_upgrades_awarded, upgrade);
		}
	}
	if (isDefined(level.pers_upgrades_keys))
	{
		index = 0;
		while (index < level.pers_upgrades_keys.size)
		{
			str_name = level.pers_upgrades_keys[index];
			stat_index = 0;
			while (stat_index < level.pers_upgrades[str_name].stat_names.size)
			{
				self maps\mp\zombies\_zm_stats::zero_client_stat(level.pers_upgrades[str_name].stat_names[stat_index], 0);
				stat_index++;
			}
			index++;
		}
	}
	level notify("initial_disable_player_pers_upgrades");
}
