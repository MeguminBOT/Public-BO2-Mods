//Include the required libraries for your scripts.
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\zombies\_zm_score;

// Initialize the code
init()
{
	thread initServerDvars(); // Initialize server DVars to be read from dedicated_zm.cfg
	thread high_round_tracker(); // Initialize Highest Round Tracker
    level thread drawZombiesCounter(); // Initialize Zombie Counter HUD Overlay
	precacheshader("damage_feedback"); // Precache shader for Shield Durability HUD Overlay
	precacheshader("zm_riotshield_tomb_icon"); // Precache shader for Shield Durability HUD Overlay
	precacheshader("zm_riotshield_hellcatraz_icon"); // Precache shader for Shield Durability HUD Overlay
	precacheshader("menu_mp_fileshare_custom"); // Precache shader for Shield Durability HUD Overlay
    for(;;)
    {
        level waittill("connected", player);
        player thread welcome();
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
///// Dont touch these unless you know what you're doing. 
/////
///// These ServerDVars are here to prevent needing to recompile everytime you make a small changes.
/////
///// Example:
///// Instead of recompiling _clientids.gsc when changing PerkLimit,
///// just change perk limit inside dedicated_zm.cfg and save, restart the server and you're done!
///// 
///// All of these are now configurable inside dedicated_zm.cfg and will override the values below
////////////////////////////////////////////////////////////////////////////////////////////////////
// Credits to JezuzLizard
initServerDvars()
{
	level.no_end_game_check = getDvarIntDefault( "cmLevelNoEndGameCheck", 0 );
	level.round_number = getDvarIntDefault( "cmLevelRoundNumber", 1 );
	level.cmLevelSoloModeDisabled = getDvarIntDefault( "cmLevelSoloModeDisabled", 0 );
	if ( level.cmLevelSoloModeDisabled )
	{
		level.is_forever_solo_game = undefined;
	}
	level.zombie_ai_limit = getDvarIntDefault( "cmZombieAiLimit", 24 );
	level.zombie_actor_limit = getDvarIntDefault( "cmZombieActorLimit", 32 );
	level.mixed_rounds_enabled = getDvarIntDefault( "cmZombieMidroundDogs", 0 );
	level.zombie_move_speed = getDvarIntDefault( "cmZombieMoveSpeed", 1 );
	level.cmZombieMoveSpeedLocked = getDvarIntDefault( "cmZombieMoveSpeedLocked", 0 );
	level.cmZombieMoveSpeedCap = getDvarIntDefault( "cmZombieMoveSpeedCap", 0 );
	level.cmZombieMoveSpeedCapValue = getDvarIntDefault( "cmZombieMoveSpeedCapValue", 1 );
	level.cmZombieMoveAnimation = getDvar( "cmZombieMoveAnimation" );
	level.cmZombieTotalPermanentOverride = getDvarIntDefault( "cmZombieTotalPermanentOverride", 0 );
	level.cmZombieTotalPermanentOverrideValue = getDvarIntDefault( "cmZombieTotalPermanentOverrideValue", 6 );
	level.cmZombieHealthPermanentOverride = getDvarIntDefault( "cmZombieHealthPermanentOverride", 0 );
	level.cmZombieHealthPermanentOverrideValue = getDvarIntDefault( "cmZombieHealthPermanentOverrideValue", 150 );
	level.cmZombieMaxHealthOverride = getDvarIntDefault( "cmZombieMaxHealthOverride", 0 );
	level.cmZombieMaxHealthOverrideValue = getDvarIntDefault( "cmZombieMaxHealthOverrideValue" , 150 );
	level.cmPlayerMaxHealth = getDvarIntDefault( "cmPlayerMaxHealth", 100 );
	level.player_starting_points = getDvarIntDefault( "cmPlayerStartingPoints", 500 );
	level.perk_purchase_limit = getDvarIntDefault( "cmPlayerPerkLimit", 4 );
	level.default_solo_laststandpistol = getDvar( "cmPlayerSoloLaststandWeapon" );
	level.default_laststandpistol = getDvar( "cmPlayerCoopLaststandWeapon" );
	level.start_weapon = getDvar( "cmPlayerStartWeapon" );
	level.cmZombieDisableWalkers = getDvarIntDefault( "cmZombieDisableWalkers", 0 );
	if ( level.cmZombieDisableWalkers )
	{
		level.speed_change_round = undefined;
	}
	level.cmPowerupNoPowerupDrops = getDvarIntDefault( "cmPowerupNoPowerupDrops", 0 );
	level.cmLevelDoSpectatorsRespawn = getDvarIntDefault( "cmLevelDoSpectatorsRespawn", 1 );
	level.zombie_vars[ "spectators_respawn" ] = level.cmLevelDoSpectatorsRespawn;
	level.cmLevelIntermissionTime = getDvarIntDefault( "cmLevelIntermissionTime", 0 );
	level.zombie_vars["zombie_intermission_time"] = level.cmLevelIntermissionTime;
	level.cmLevelBetweenRoundTime = getDvarIntDefault( "cmLevelBetweenRoundTime", 0 );
	level.zombie_vars["zombie_between_round_time"] = level.cmLevelBetweenRoundTime;
	level.cmLevelGameStartDelay = getDvarIntDefault( "cmLevelGameStartDelay", 0 );
	level.zombie_vars[ "game_start_delay" ] = level.cmLevelGameStartDelay;
	level.cmEquipmentRiotshieldHitPoints = getDvarIntDefault( "cmEquipmentRiotshieldHitPoints", 2250 );
	level.zombie_vars[ "riotshield_hit_points" ] = level.cmEquipmentRiotshieldHitPoints;
	level.cmPerkJuggHealth = getDvarIntDefault( "cmPerkJuggHealth", 250 );
	level.zombie_vars[ "zombie_perk_juggernaut_health" ] = level.cmPerkJuggHealth;	
	level.cmPerkPermaJuggHealth = getDvarIntDefault( "cmPerkPermaJuggHealth", 190 );
	level.zombie_vars[ "zombie_perk_juggernaut_health_upgrade" ] = level.cmPerkPermaJuggHealth;
	level.cmPerkMinPhdExplosionDamage = getDvarIntDefault( "cmPerkMinPhdExplosionDamage", 2000 );
	level.zombie_vars[ "zombie_perk_divetonuke_min_damage" ] = level.cmPerkMinPhdExplosionDamage;
	level.cmPerkMaxPhdExplosionDamage = getDvarIntDefault( "cmPerkMaxPhdExplosionDamage", 5000 );
	level.zombie_vars[ "zombie_perk_divetonuke_max_damage" ] = level.cmPerkMaxPhdExplosionDamage;
	level.cmPerkPhdDamageRadius = getDvarIntDefault( "cmPerkPhdDamageRadius", 300 );
	level.zombie_vars[ "zombie_perk_divetonuke_radius" ] = level.cmPerkPhdDamageRadius;
	level.cmPlayerFourPlayerScorePerZombieKill = getDvarIntDefault( "cmPlayerFourPlayerScorePerZombieKill", 50 );
	level.zombie_vars[ "zombie_score_kill_4player" ] = level.cmPlayerFourPlayerScorePerZombieKill;
	level.cmPlayerThreePlayerScorePerZombieKill = getDvarIntDefault( "cmPlayerThreePlayerScorePerZombieKill", 50 );
	level.zombie_vars[ "zombie_score_kill_3player" ] = level.cmPlayerThreePlayerScorePerZombieKill;
	level.cmPlayerTwoPlayerScorePerZombieKill = getDvarIntDefault( "cmPlayerTwoPlayerScorePerZombieKill", 50 );
	level.zombie_vars[ "zombie_score_kill_2player" ] = level.cmPlayerTwoPlayerScorePerZombieKill;
	level.cmPlayerOnePlayerScorePerZombieKill = getDvarIntDefault( "cmPlayerOnePlayerScorePerZombieKill", 50 );
	level.zombie_vars[ "zombie_score_kill_1player" ] = level.cmPlayerOnePlayerScorePerZombieKill;
	level.cmPlayerPointsPerNormalAttack = getDvarIntDefault( "cmPlayerPointsPerNormalAttack", 10 );
	level.zombie_vars[ "zombie_score_damage_normal" ] = level.cmPlayerPointsPerNormalAttack;
	level.cmPlayerPointsPerLightAttack = getDvarIntDefault( "cmPlayerPointsPerLightAttack", 10 );
	level.zombie_vars[ "zombie_score_damage_light" ] = level.cmPlayerPointsPerLightAttack;
	level.cmPlayerPointsBonusMeleeKill = getDvarIntDefault( "cmPlayerPointsBonusMeleeKill", 80 );
	level.zombie_vars[ "zombie_score_bonus_melee" ] = level.cmPlayerPointsBonusMeleeKill;
	level.cmPlayerPointsBonusHeadshotKill = getDvarIntDefault( "cmPlayerPointsBonusHeadshotKill", 50 );
	level.zombie_vars[ "zombie_score_bonus_head" ] = level.cmPlayerPointsBonusHeadshotKill;
	level.cmPlayerPointsBonusNeckKill = getDvarIntDefault( "cmPlayerPointsBonusNeckKill", 20 );
	level.zombie_vars[ "zombie_score_bonus_neck" ] = level.cmPlayerPointsBonusNeckKill;
	level.cmPlayerPointsBonusTorsoKill = getDvarIntDefault( "cmPlayerPointsBonusTorsoKill", 10 );
	level.zombie_vars[ "zombie_score_bonus_torso" ] = level.cmPlayerPointsBonusTorsoKill;
	level.cmPlayerBleedoutPointsLostAllPlayers = getDvarFloatDefault( "cmPlayerBleedoutPointsLostAllPlayers", 0.1 );
	level.zombie_vars[ "penalty_no_revive" ] = level.cmPlayerBleedoutPointsLostAllPlayers;
	level.cmPlayerBleedoutPointsLostSelf = getDvarFloatDefault( "cmPlayerBleedoutPointsLostSelf", 0.1 );
	level.zombie_vars[ "penalty_died" ] = level.cmPlayerBleedoutPointsLostSelf;
	level.cmPlayerDownedPointsLostSelf = getDvarFloatDefault( "cmPlayerDownedPointsLostSelf", 0.05 );
	level.zombie_vars[ "penalty_downed" ] = level.cmPlayerDownedPointsLostSelf;
	level.cmPlayerStartingLives = getDvarIntDefault( "cmPlayerStartingLives", 1 );
	level.zombie_vars[ "starting_lives" ] = level.cmPlayerStartingLives;
	level.cmPlayerShouldZombify = getDvarIntDefault( "cmPlayerShouldZombify", 0 );
	level.zombie_vars[ "zombify_player" ] = level.cmPlayerShouldZombify;
	level.cmPowerupMaxPerRound = getDvarIntDefault( "cmPowerupMaxPerRound", 4 );
	level.zombie_vars["zombie_powerup_drop_max_per_round"] = level.cmPowerupMaxPerRound;
	level.cmPowerupDropRate = getDvarIntDefault( "cmPowerupDropRate", 2000 );
	level.zombie_vars["zombie_powerup_drop_increment"] = level.cmPowerupDropRate;
	level.cmPowerupAlwaysDrop = getDvarIntDefault( "cmPowerupAlwaysDrop", 0 );
	level.zombie_vars[ "zombie_drop_item" ] = level.cmPowerupAlwaysDrop;
	level.cmPowerupFourPlayerScore = getDvarIntDefault( "cmPowerupFourPlayerScore", 50 );
	level.zombie_vars[ "zombie_score_kill_4p_team" ] = level.cmPowerupFourPlayerScore;
	level.cmPowerupThreePlayerScore = getDvarIntDefault( "cmPowerupThreePlayerScore", 50 );
	level.zombie_vars[ "zombie_score_kill_3p_team" ] = level.cmPowerupThreePlayerScore;
	level.cmPowerupTwoPlayerScore = getDvarIntDefault( "cmPowerupTwoPlayerScore", 50 );
	level.zombie_vars[ "zombie_score_kill_2p_team" ] = level.cmPowerupTwoPlayerScore;
	level.cmPowerupOnePlayerScore = getDvarIntDefault( "cmPowerupOnePlayerScore", 50 );
	level.zombie_vars[ "zombie_score_kill_1p_team" ] = level.cmPowerupOnePlayerScore;
	level.cmTeamAlliesPointsMultiplier = getDvarIntDefault( "cmTeamAlliesPointsMultiplier", 1 );
	level.zombie_vars[ "allies" ][ "zombie_point_scalar" ] = level.cmTeamAlliesPointsMultiplier;
	level.cmTeamAxisPointsMultiplier = getDvarIntDefault( "cmTeamAxisPointsMultiplier", 1 );
	level.zombie_vars[ "axis" ][ "zombie_point_scalar" ] = level.cmTeamAxisPointsMultiplier;
	level.cmWeaponEmpPerkExplosionRadius = getDvarIntDefault( "cmWeaponEmpPerkExplosionRadius", 400 );
	level.zombie_vars[ "emp_perk_off_range" ] = level.cmWeaponEmpPerkExplosionRadius;
	level.cmWeaponEmpPerkOffDuration = getDvarIntDefault( "cmWeaponEmpPerkOffDuration", 90 );
	level.zombie_vars[ "emp_perk_off_time" ] = level.cmWeaponEmpPerkOffDuration;
	level.cmZombieSpawnRate = getDvarFloatDefault( "cmZombieSpawnRate", 2 );
	level.zombie_vars[ "zombie_spawn_delay" ] = level.cmZombieSpawnRate;
	level.cmZombieSpawnRateMultiplier = getDvarFloatDefault( "cmZombieSpawnRateMultiplier", 0.95 );
	level.cmZombieSpawnRateLocked = getDvarIntDefault( "cmZombieSpawnRateLocked", 0 );
	level.cmZombiePerPlayer = getDvarIntDefault( "cmZombiePerPlayer", 6 );
	level.zombie_vars["zombie_ai_per_player"] = level.cmZombiePerPlayer;
	level.cmZombieHealthIncreaseFlat = getDvarIntDefault( "cmZombieHealthIncreaseFlat", 100 );
	level.zombie_vars[ "zombie_health_increase" ] = level.cmZombieHealthIncreaseFlat;
	level.cmZombieHealthIncreaseMultiplier = getDvarFloatDefault( "cmZombieHealthIncreaseMultiplier", 0.1 );
	level.zombie_vars[ "zombie_health_increase_multiplier" ] = level.cmZombieHealthIncreaseMultiplier;
	level.cmZombieHealthStart = getDvarIntDefault( "cmZombieHealthStart", 150 );
	level.zombie_vars[ "zombie_health_start" ] = level.cmZombieHealthStart;
	level.cmZombieNewRunnerInterval = getDvarIntDefault( "cmZombieNewRunnerInterval", 10 );
	level.zombie_vars[ "zombie_new_runner_interval" ] = level.cmZombieNewRunnerInterval;
	level.cmZombieMoveSpeedMultiplier = getDvarIntDefault( "cmZombieMoveSpeedMultiplier", 10 );
	level.zombie_vars[ "zombie_move_speed_multiplier" ] = level.cmZombieMoveSpeedMultiplier;
	level.cmZombieMoveSpeedMultiplierEasy = getDvarIntDefault( "cmZombieMoveSpeedMultiplierEasy", 8 );
	level.zombie_vars[ "zombie_move_speed_multiplier_easy"] = level.cmZombieMoveSpeedMultiplierEasy;
	level.cmZombieMaxAi = getDvarIntDefault( "cmZombieMaxAi", 24 );
	level.zombie_vars[ "zombie_max_ai" ] = level.cmZombieMaxAi;
	level.cmPerkSpeedColaReloadSpeed = getDvarFloatDefault( "cmPerkSpeedColaReloadSpeed", 0.5 );
	setdvar( "perk_weapReloadMultiplier", level.cmPerkSpeedColaReloadSpeed );
	level.cmPerkDoubleTapFireRate = getDvarFloatDefault( "cmPerkDoubleTapFireRate", 0.75 );
	setdvar( "perk_weapRateMultiplier", level.cmPerkDoubleTapFireRate );
	level.cmPerkDeadshotAccuracyModifier = getDvarFloatDefault( "cmPerkDeadshotAccuracyModifier", 0.70 );
	setdvar( "perk_weapSpreadMultiplier", level.cmPerkDeadshotAccuracyModifier );	
	level.cmPlayerReviveTriggerRadius = getDvarIntDefault( "cmPlayerReviveTriggerRadius", 125 );
	setdvar( "revive_trigger_radius", level.cmPlayerReviveTriggerRadius );
	level.cmPlayerLaststandBleedoutTime = getDvarIntDefault( "cmPlayerLaststandBleedoutTime", 45 );
	setdvar( "player_lastStandBleedoutTime", level.cmPlayerLaststandBleedoutTime );
	init_custom_zm_powerups_gsc_exclusive_dvars();
	disable_specific_powerups();
	checks();
	thread zombies_always_drop_powerups();
	thread zombies_per_round_override();
	thread zombie_health_override();
	thread zombie_health_cap_override();
	thread zombie_spawn_delay_fix();
	thread zombie_speed_fix();
	level thread onplayerconnect();
	
}


// Dont touch these, unless you need to add additional scripts here
onplayerconnect()
{
	level endon( "end_game" );
	self endon( "disconnect" );
	while ( 1 )
	{
		level waittill( "connected", player );
		player thread onplayerspawned();
		player thread high_round_info();
	}
}

// Dont touch these, unless you need to add or remove scripts here
onplayerspawned()
{
	self endon( "disconnect" );
	while ( 1 )
	{
		self waittill( "spawned_player" );
		self._retain_perks = getDvarIntDefault( "cmPlayerRetainPerks", 0 );
		if ( !isDefined( self.cmIsFirstSpawn ) || !self.cmIsFirstSpawn )
		{
			self.cmIsFirstSpawn = 1;								// Is this the first time the player has spawnned?
			self thread watch_for_respawn();						// Waits for respawn
			self.health = level.cmPlayerMaxHealth; 					// (UNSURE) Links together with level.cmPlayerMaxHealth for compability reasons
			self.maxHealth = self.health; 							// (UNSURE) Links together with self.health for compability reasons
			self setMaxHealth( level.cmPlayerMaxHealth );			// Calls for Health values from initServerDvars() which then asks for cmPlayerMaxHealth inside dedicated_zm.cfg
			self thread timer_hud();								// Adds the Timer HUD element on player spawn
			self thread zone_hud();									// Adds the Zone HUD element on player spawn
		}
	}
}

// Dont touch these, checks to prevent crashing
checks()
{
	if ( level.mixed_rounds_enabled )
	{
		if ( level.script != "zm_transit" || maps/mp/zombies/_zm_utility::is_classic() || level.scr_zm_ui_gametype == "zgrief" )
		{
			level.mixed_rounds_enabled = 0;
		}
	}
	if ( level.start_weapon == "" || level.start_weapon== "m1911_zm" )
	{
		level.start_weapon = "m1911_zm";
		if ( level.script == "zm_tomb" )
		{
			level.start_weapon = "c96_zm";
		}
	}
	if ( level.default_laststandpistol == "" || level.default_laststandpistol == "m1911_zm" )
	{
		level.default_laststandpistol = "m1911_zm";
		if ( level.script == "zm_tomb" )
		{
			level.default_laststandpistol = "c96_zm";
		}
	}
	if ( level.default_solo_laststandpistol == "" || level.default_solo_laststandpistol == "m1911_upgraded_zm" )
	{
		level.default_solo_laststandpistol = "m1911_upgraded_zm";
		if ( level.script == "zm_tomb" )
		{
			level.default_solo_laststandpistol = "c96_upgraded_zm";
		}
	}

}

// Dont touch these, configure these inside dedicated_zm.cfg instead
disable_specific_powerups()
{
	level.cmPowerupNames = array( "nuke", "insta_kill", "full_ammo", "double_points", "fire_sale", "free_perk", "carpenter", "zombie_blood" );
	array = level.cmPowerupNames;
	level.cmPowerupEnabled = [];
	level.cmPowerupEnabled[ "nuke" ] = spawnstruct();
	level.cmPowerupEnabled[ "nuke" ].name = "nuke";
	level.cmPowerupEnabled[ "nuke" ].active = getDvarIntDefault( "cmPowerupNukeEnabled", 1 );
	level.cmPowerupEnabled[ "insta_kill" ] = spawnstruct();
	level.cmPowerupEnabled[ "insta_kill" ].name = "insta_kill";
	level.cmPowerupEnabled[ "insta_kill" ].active = getDvarIntDefault( "cmPowerupInstaKillEnabled", 1 );
	level.cmPowerupEnabled[ "full_ammo" ] = spawnstruct();
	level.cmPowerupEnabled[ "full_ammo" ].name = "full_ammo";
	level.cmPowerupEnabled[ "full_ammo" ].active = getDvarIntDefault( "cmPowerupMaxAmmoEnabled", 1 );
	level.cmPowerupEnabled[ "double_points" ] = spawnstruct();
	level.cmPowerupEnabled[ "double_points" ].name = "double_points";
	level.cmPowerupEnabled[ "double_points" ].active = getDvarIntDefault( "cmPowerupDoublePointsEnabled", 1 );
	level.cmPowerupEnabled[ "fire_sale" ] = spawnstruct();
	level.cmPowerupEnabled[ "fire_sale" ].name = "fire_sale";
	level.cmPowerupEnabled[ "fire_sale" ].active = getDvarIntDefault( "cmPowerupFireSaleEnabled", 1 );
	level.cmPowerupEnabled[ "free_perk" ] = spawnstruct();
	level.cmPowerupEnabled[ "free_perk" ].name = "free_perk";
	level.cmPowerupEnabled[ "free_perk" ].active = getDvarIntDefault( "cmPowerupPerkBottleEnabled", 1 );
	level.cmPowerupEnabled[ "carpenter" ] = spawnstruct();
	level.cmPowerupEnabled[ "carpenter" ].name = "carpenter";
	level.cmPowerupEnabled[ "carpenter" ].active = getDvarIntDefault( "cmPowerupCarpenterEnabled", 1 );
	level.cmPowerupEnabled[ "zombie_blood" ] = spawnstruct();
	level.cmPowerupEnabled[ "zombie_blood" ].name = "zombie_blood";
	level.cmPowerupEnabled[ "zombie_blood" ].active = getDvarIntDefault( "cmPowerupZombieBloodEnabled", 1 );
	
	// You can expand this list with custom powerups if you'd like just add a new spawnstruct() and add to the array at the top
	for ( i = 0; i < array.size; i++ )
	{	
		if ( !level.cmPowerupEnabled[ array[ i ] ].active )
		{
			name = level.cmPowerupEnabled[ array[ i ] ].name;
			if ( isInArray( level.zombie_include_powerups, name ) )
			{
				arrayremovevalue( level.zombie_include_powerups, name );
			}
			if ( isInArray( level.zombie_powerups, name ) )
			{
				arrayremovevalue( level.zombie_powerups, name );
			}
			if ( isInArray( level.zombie_powerup_array, name ) )
			{
				arrayremovevalue( level.zombie_powerup_array, name );
			}
		}
	}
}

// Dont touch these
disable_all_powerups()
{
	if ( level.cmPowerupNoPowerupDrops )
	{
		flag_clear( "zombie_drop_powerups" );
	}
}

// Dont touch these
zombies_always_drop_powerups()
{
	if ( !level.cmPowerupAlwaysDrop )
	{
		return;
	}
	while ( 1 )
	{
		level.zombie_vars[ "zombie_drop_item" ] = level.cmPowerupAlwaysDrop;
		wait 0.05;
	}
}

// Dont touch these
zombies_per_round_override()
{
	if ( !level.cmZombieTotalPermanentOverride )
	{
		return;
	}
	while ( 1 )
	{
		level waittill( "start_of_round" );
		level.zombie_total = level.cmZombieTotalPermanentOverrideValue;
	}
}

// Dont touch these
zombie_health_override()
{
	if ( !level.cmZombieHealthPermanentOverride )
	{
		return;
	}
	while ( 1 )
	{
		level waittill( "start_of_round" );
		level.zombie_health = level.cmZombieHealthPermanentOverrideValue;
	}
}

// Dont touch these
zombie_health_cap_override()
{
	if ( !level.cmZombieMaxHealthOverride )
	{
		return;
	}
	while ( 1 )
	{
		level waittill( "start_of_round" );
		if ( level.zombie_health > level.cmZombieMaxHealthOverrideValue )
		{
			level.zombie_health = level.cmZombieMaxHealthOverrideValue;
		}
	}
}

// Dont touch these
zombie_spawn_delay_fix()
{
	if ( level.cmZombieSpawnRateLocked )
	{
		return;
	}
	i = 1;
	while ( i <= level.round_number )
	{
		timer = level.cmZombieSpawnRate;
		if ( timer > 0.08 )
		{
			level.cmZombieSpawnRate = timer * level.cmZombieSpawnRateMultiplier;
			i++;
			continue;
		}
		if ( timer < 0.08 )
		{
			level.cmZombieSpawnRate = 0.08;
			break;
		}
		i++;
	}
	while ( 1 )
	{
		level waittill( "start_of_round" );
		if ( level.cmZombieSpawnRate > 0.08 )
		{
			level.cmZombieSpawnRate = level.cmZombieSpawnRate * level.cmZombieSpawnRateMultiplier;
		}
		level.zombie_vars[ "zombie_spawn_delay" ] = level.cmZombieSpawnRate;
	}
}

// Dont touch these
zombie_speed_fix()
{
	if ( level.cmZombieMoveSpeedLocked )
	{
		return;
	}
	if ( level.gamedifficulty == 0 )
	{
		level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier_easy" ];
	}
	else
	{
		level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier" ];
	}
}

// Dont touch these
zombie_speed_override()
{
	if ( !level.cmZombieMoveSpeedLocked )
	{
		return;
	}
	while ( 1 )
	{
		level waittill( "start_of_round" );
		level.zombie_move_speed = getDvarIntDefault( "cmZombieMoveSpeed", 1 );
	}
}

// Dont touch these
zombie_speed_cap_override()
{
	if ( !level.cmZombieMoveSpeedCap )
	{
		return;
	}
	while ( 1 )
	{
		level waittill( "start_of_round" );
		if ( level.zombie_move_speed > level.cmZombieMoveSpeedCapValue )
		{
			level.zombie_move_speed = level.cmZombieMoveSpeedCapValue;
		}
	}
}

// Dont touch these
watch_for_respawn()
{
	self endon( "disconnect" );
	while ( 1 )
	{
		self waittill_any( "spawned_player", "player_revived" );
		wait_network_frame();
		if ( self._retain_perks && self hasPerk( "specialty_armorvest" ) )
		{
			self setMaxHealth( level.cmPerkJuggHealth );
			self.health = level.cmPerkJuggHealth;
			self.maxHealth = self.health;
		}
		else if ( self.pers_upgrades_awarded[ "jugg" ] && maps/mp/zombies/_zm_utility::is_classic() )
		{
			self setMaxHealth( level.cmPerkPermaJuggHealth );
			self.health = level.cmPerkPermaJuggHealth;
			self.maxHealth = self.health;
		}
		else
		{
			self setMaxHealth( level.cmPlayerMaxHealth );
			self.health = level.cmPlayerMaxHealth;
			self.maxHealth = self.health;
		}
	}
}

// Dont touch these, configure these inside dedicated_zm.cfg instead
init_custom_zm_powerups_gsc_exclusive_dvars()
{
	if ( !isDefined( level.custom_zm_powerups_loaded ) || !level.custom_zm_powerups_loaded )
	{
		return;
	}
	level.cmPowerupRandomDropChance = getDvarIntDefault( "cmPowerupRandomDropChance", 2 );
	level.cmPowerupFieldLifetime = getDvarIntDefault( "cmPowerupFieldLifetime", 15 );
	level.cmPowerupFireSaleDuration = getDvarIntDefault( "cmPowerupFireSaleDuration", 30 );
	level.cmPowerupDoublePointsDuration = getDvarIntDefault( "cmPowerupDoublePointsDuration", 30 );
	level.cmPowerupDoublePointsScalar = getDvarIntDefault( "cmPowerupDoublePointsScalar", 2 );
	level.cmPowerupInstaKillDuration = getDvarIntDefault( "cmPowerupInstaKillDuration", 30 );
	level.cmPowerupCarpenterPoints = getDvarIntDefault( "cmPowerupCarpenterPoints", 200 );
	level.cmPowerupNukePoints = getDvarIntDefault( "cmPowerupNukePoints", 400 );
	level.cmPowerupNukeShouldWaitToKillZombies = getDvarIntDefault( "cmPowerupNukeShouldWaitToKillZombies", 1 );
	level.cmPowerupNukeMinTimeToKill = getDvarFloatDefault( "cmPowerupNukeMinTimeToKill", 0.1 );
	level.cmPowerupNukeMaxTimeToKill = getDvarFloatDefault( "cmPowerupNukeMaxTimeToKill", 0.7 );
	level.cmPowerupMaxAmmoAffectsLaststandPlayers = getDvarIntDefault( "cmPowerupMaxAmmoAffectsLastandPlayers", 0 );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////// EVERYTHING FROM HERE ON YOU CAN TOUCH
////// if adding additional code below make sure you add the required #Includes at the top if necessary
////// if adding additional code below make sure you init the code inside the "init()" section if necessary
////// if adding additional code below make sure you init the code inside the "welcome()" section if necessary
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//// When a player joins the server (Use "self iprintln" to add messages on join)
welcome()
{
    self endon("disconnect");
    self waittill("spawned_player");
	wait 5;
//	self iprintln("^7Increased perk limit to 9 perks");
//	self iprintln("^3Fog ^7and ^3Depth of Field ^7is disabled on this server");
//	self iprintln("^7HUD Addons: ^3Zombie Counter^7, ^3Shield Durability ^7, ^3Hitmarkers, ^3Timer ^7and ^3Zone Names ^7enabled");
//	wait 5; 
//	self iprintln("^3Quick Revive ^7now grants a small boost to health regeneration");
//	self iprintln("^3Revive Trigger Radius ^7increased from 75 yards to 125 yards");
//	self iprintln("^7Added 5 seconds delay between every round for Zombies to spawn to prevent weird server crashes");
//	wait 5;
//	self iprintln("^3Black Ops 3 Player Health ^7enabled, you can take one extra hit without Juggernog");
//	self iprintln("^3Black Ops 4 Zombie Health ^7enabled, Zombie health is capped at 11272 on round 35 and onwards");
	self thread visuals();
	level thread bo4zombiehealth();										// Initiates Black Ops 3/4 zombie health values
	self thread shield_hud();											// Initiates the code for Shield Durability HUD
	self thread inspect();
	self thread drop();
	self thread quickrevive();
}

//// Removes annoying FOG. This is my personal preference since I get nauseous when theres fog and dof effects, not really sure why though.
// Credits to teh-bandit
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

//////// CURRENTLY BROKEN //////// 
//// Gives a set amount of money to people joining late
// Credits to Ashton Biehl
//setlatepoints()

//{
//		if(level.round_number >= 5 && self.score < 2500) // You can change the round and money to your liking.
//			self.score = 2500;
//	        else if(level.round_number >= 10 && self.score < 5000) // You can change the round and money to your liking.
//			self.score = 5000; 
//}

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

//// Quick Revive regenerates health
// Credits to teh-bandit
quickrevive()
{
	level endon("end_game");
	self endon("disconnect");
	for (;;)
	{
		if (self hasperk("specialty_quickrevive") && self.health < self.maxHealth)
		{
			self.health += 1;
		}
		wait 0.1;
	}
}

//// Adds a HUD element showing how much durability your Zombie Shield have
// Credits to teh-bandit for the original script
// Credits to TomasFreeman15 for the tweaked HUD icons
// (NOTE: On Tranzit, the shield icon is broken and will show a hitmarker instead)
shield_hud()
{
	self endon("disconnect");
	flag_wait("initial_blackscreen_passed");

	shield_text = self createprimaryprogressbartext();
	shield_text setpoint(undefined, "BOTTOM", +205, +15);
	shield_text.hidewheninmenu = 1;
	
	shield_hud = newClientHudElem(self);
	shield_hud.alignx = "right";
	shield_hud.aligny = "bottom";
	shield_hud.horzalign = "user_right";
	shield_hud.vertalign = "user_bottom";
	shield_hud.x -= 175;
	shield_hud.alpha = 0;
	shield_hud.color = ( 1, 1, 1 );
	shield_hud.hidewheninmenu = 1;
	if(getdvar("mapname") == "zm_transit")
	{
		shield_hud setShader("damage_feedback", 32, 32);
	}
	if(getdvar("mapname") == "zm_tomb")
	{
		shield_hud setShader("zm_riotshield_tomb_icon", 32, 32);
	}
	if(getdvar("mapname") == "zm_prison")
	{
		shield_hud setShader("zm_riotshield_hellcatraz_icon", 32, 32);
	}
	

	for(;;)
	{
		if (self hasweapon("riotshield_zm") || self hasweapon("alcatraz_shield_zm") || self hasweapon("tomb_shield_zm") )
		{
			shield_text.alpha = 1;
			shield_hud.alpha = 1;
		}
		else
		{
			shield_text.alpha = 0;
			shield_hud.alpha = 0;
		}
		shield_text setvalue(2250 - self.shielddamagetaken);
		wait 0.05;
		
		if(self.shielddamagetaken >= 2250)
		{
			shield_text.alpha = 0;
		}
	}
}

//// Adds a HUD element showing time played.
// Credits to Jbleezy
timer_hud()
{
	self endon("disconnect");

	self thread round_timer_hud();

	timer_hud = newClientHudElem(self);
	timer_hud.alignx = "right";
	timer_hud.aligny = "top";
	timer_hud.horzalign = "user_right";
	timer_hud.vertalign = "user_top";
	timer_hud.x -= 5;
	timer_hud.y += 2;
	timer_hud.fontscale = 1.4;
	timer_hud.alpha = 0;
	timer_hud.color = ( 1, 1, 1 );
	timer_hud.hidewheninmenu = 1;
	timer_hud.label = &"Time: ";

	flag_wait( "initial_blackscreen_passed" );
	
	timer_hud.alpha = 1;
	timer_hud setTimerUp(0);
}

//// Adds a HUD element showing round time played.
// Credits to Jbleezy
round_timer_hud()
{
	self endon("disconnect");

	round_timer_hud = newClientHudElem(self);
	round_timer_hud.alignx = "right";
	round_timer_hud.aligny = "top";
	round_timer_hud.horzalign = "user_right";
	round_timer_hud.vertalign = "user_top";
	round_timer_hud.x -= 5;
	round_timer_hud.y += 17;
	round_timer_hud.fontscale = 1.4;
	round_timer_hud.alpha = 0;
	round_timer_hud.color = ( 1, 1, 1 );
	round_timer_hud.hidewheninmenu = 1;
	round_timer_hud.label = &"Round Time: ";

	flag_wait( "initial_blackscreen_passed" );

	round_timer_hud.alpha = 1;

	while (1)
	{
		round_timer_hud setTimerUp(0);
		start_time = int(getTime() / 1000);

		level waittill( "end_of_round" );

		end_time = int(getTime() / 1000);
		time = end_time - start_time;

		set_time_frozen(round_timer_hud, time);
	}
}

//// Adds a HUD element showing time when frozen.
// Credits to Jbleezy
set_time_frozen(hud, time)
{
	level endon( "start_of_round" );

	time -= .1; // need to set it below the number or it shows the next number

	while (1)
	{
		hud setTimer(time);

		wait 0.5;
	}
}

//// Adds a HUD element showing the current zone you're in
// Credits to Jbleezy
zone_hud()
{
	self endon("disconnect");

	zone_hud = newClientHudElem(self);
	zone_hud.alignx = "left";
	zone_hud.aligny = "bottom";
	zone_hud.horzalign = "user_left";
	zone_hud.vertalign = "user_bottom";
	zone_hud.x += 5;
	if (level.script == "zm_buried")
	{
		zone_hud.y -= 125;
	}
	else if (level.script == "zm_tomb")
	{
		zone_hud.y -= 160;
	}
	else
	{
		zone_hud.y -= 100;
	}
	zone_hud.fontscale = 1.4;
	zone_hud.alpha = 0;
	zone_hud.color = ( 1, 1, 1 );
	zone_hud.hidewheninmenu = 1;

	flag_wait( "initial_blackscreen_passed" );

	prev_zone = "";
	while (1)
	{
		zone = self get_zone_name();

		if(prev_zone != zone)
		{
			prev_zone = zone;

			zone_hud fadeovertime(0.25);
			zone_hud.alpha = 0;
			wait 0.25;

			zone_hud settext(zone);

			zone_hud fadeovertime(0.25);
			zone_hud.alpha = 1;
			wait 0.25;

			continue;
		}

		wait 0.05;
	}
}


//// Adds a HUD element showing names for specific locations
// Credits to Jbleezy
get_zone_name()
{
	zone = self get_current_zone();
	if (!isDefined(zone))
	{
		return "";
	}

	name = zone;

	if (level.script == "zm_transit")
	{
		if (zone == "zone_pri")
		{
			name = "Bus Depot";
		}
		else if (zone == "zone_pri2")
		{
			name = "Bus Depot Hallway";
		}
		else if (zone == "zone_station_ext")
		{
			name = "Outside Bus Depot";
		}
		else if (zone == "zone_trans_2b")
		{
			name = "Fog After Bus Depot";
		}
		else if (zone == "zone_trans_2")
		{
			name = "Tunnel Entrance";
		}
		else if (zone == "zone_amb_tunnel")
		{
			name = "Tunnel";
		}
		else if (zone == "zone_trans_3")
		{
			name = "Tunnel Exit";
		}
		else if (zone == "zone_roadside_west")
		{
			name = "Outside Diner";
		}
		else if (zone == "zone_gas")
		{
			name = "Gas Station";
		}
		else if (zone == "zone_roadside_east")
		{
			name = "Outside Garage";
		}
		else if (zone == "zone_trans_diner")
		{
			name = "Fog Outside Diner";
		}
		else if (zone == "zone_trans_diner2")
		{
			name = "Fog Outside Garage";
		}
		else if (zone == "zone_gar")
		{
			name = "Garage";
		}
		else if (zone == "zone_din")
		{
			name = "Diner";
		}
		else if (zone == "zone_diner_roof")
		{
			name = "Diner Roof";
		}
		else if (zone == "zone_trans_4")
		{
			name = "Fog After Diner";
		}
		else if (zone == "zone_amb_forest")
		{
			name = "Forest";
		}
		else if (zone == "zone_trans_10")
		{
			name = "Outside Church";
		}
		else if (zone == "zone_town_church")
		{
			name = "Upper South Town";
		}
		else if (zone == "zone_trans_5")
		{
			name = "Fog Before Farm";
		}
		else if (zone == "zone_far")
		{
			name = "Outside Farm";
		}
		else if (zone == "zone_far_ext")
		{
			name = "Farm";
		}
		else if (zone == "zone_brn")
		{
			name = "Barn";
		}
		else if (zone == "zone_farm_house")
		{
			name = "Farmhouse";
		}
		else if (zone == "zone_trans_6")
		{
			name = "Fog After Farm";
		}
		else if (zone == "zone_amb_cornfield")
		{
			name = "Cornfield";
		}
		else if (zone == "zone_cornfield_prototype")
		{
			name = "Nacht";
		}
		else if (zone == "zone_trans_7")
		{
			name = "Upper Fog Before Power";
		}
		else if (zone == "zone_trans_pow_ext1")
		{
			name = "Fog Before Power";
		}
		else if (zone == "zone_pow")
		{
			name = "Outside Power Station";
		}
		else if (zone == "zone_prr")
		{
			name = "Power Station";
		}
		else if (zone == "zone_pcr")
		{
			name = "Power Control Room";
		}
		else if (zone == "zone_pow_warehouse")
		{
			name = "Warehouse";
		}
		else if (zone == "zone_trans_8")
		{
			name = "Fog After Power";
		}
		else if (zone == "zone_amb_power2town")
		{
			name = "Cabin";
		}
		else if (zone == "zone_trans_9")
		{
			name = "Fog Before Town";
		}
		else if (zone == "zone_town_north")
		{
			name = "North Town";
		}
		else if (zone == "zone_tow")
		{
			name = "Center Town";
		}
		else if (zone == "zone_town_east")
		{
			name = "East Town";
		}
		else if (zone == "zone_town_west")
		{
			name = "West Town";
		}
		else if (zone == "zone_town_south")
		{
			name = "South Town";
		}
		else if (zone == "zone_bar")
		{
			name = "Bar";
		}
		else if (zone == "zone_town_barber")
		{
			name = "Bookstore";
		}
		else if (zone == "zone_ban")
		{
			name = "Bank";
		}
		else if (zone == "zone_ban_vault")
		{
			name = "Bank Vault";
		}
		else if (zone == "zone_tbu")
		{
			name = "Below Bank";
		}
		else if (zone == "zone_trans_11")
		{
			name = "Fog After Town";
		}
		else if (zone == "zone_amb_bridge")
		{
			name = "Bridge";
		}
		else if (zone == "zone_trans_1")
		{
			name = "Fog Before Bus Depot";
		}
	}
	else if (level.script == "zm_nuked")
	{
		if (zone == "culdesac_yellow_zone")
		{
			name = "Yellow House Cul-de-sac";
		}
		else if (zone == "culdesac_green_zone")
		{
			name = "Green House Cul-de-sac";
		}
		else if (zone == "truck_zone")
		{
			name = "Truck";
		}
		else if (zone == "openhouse1_f1_zone")
		{
			name = "Green House Downstairs";
		}
		else if (zone == "openhouse1_f2_zone")
		{
			name = "Green House Upstairs";
		}
		else if (zone == "openhouse1_backyard_zone")
		{
			name = "Green House Backyard";
		}
		else if (zone == "openhouse2_f1_zone")
		{
			name = "Yellow House Downstairs";
		}
		else if (zone == "openhouse2_f2_zone")
		{
			name = "Yellow House Upstairs";
		}
		else if (zone == "openhouse2_backyard_zone")
		{
			name = "Yellow House Backyard";
		}
		else if (zone == "ammo_door_zone")
		{
			name = "Yellow House Backyard Door";
		}
	}
	else if (level.script == "zm_highrise")
	{
		if (zone == "zone_green_start")
		{
			name = "Green Highrise Level 3b";
		}
		else if (zone == "zone_green_escape_pod")
		{
			name = "Escape Pod";
		}
		else if (zone == "zone_green_escape_pod_ground")
		{
			name = "Escape Pod Shaft";
		}
		else if (zone == "zone_green_level1")
		{
			name = "Green Highrise Level 3a";
		}
		else if (zone == "zone_green_level2a")
		{
			name = "Green Highrise Level 2a";
		}
		else if (zone == "zone_green_level2b")
		{
			name = "Green Highrise Level 2b";
		}
		else if (zone == "zone_green_level3a")
		{
			name = "Green Highrise Restaurant";
		}
		else if (zone == "zone_green_level3b")
		{
			name = "Green Highrise Level 1a";
		}
		else if (zone == "zone_green_level3c")
		{
			name = "Green Highrise Level 1b";
		}
		else if (zone == "zone_green_level3d")
		{
			name = "Green Highrise Behind Restaurant";
		}
		else if (zone == "zone_orange_level1")
		{
			name = "Upper Orange Highrise Level 2";
		}
		else if (zone == "zone_orange_level2")
		{
			name = "Upper Orange Highrise Level 1";
		}
		else if (zone == "zone_orange_elevator_shaft_top")
		{
			name = "Elevator Shaft Level 3";
		}
		else if (zone == "zone_orange_elevator_shaft_middle_1")
		{
			name = "Elevator Shaft Level 2";
		}
		else if (zone == "zone_orange_elevator_shaft_middle_2")
		{
			name = "Elevator Shaft Level 1";
		}
		else if (zone == "zone_orange_elevator_shaft_bottom")
		{
			name = "Elevator Shaft Bottom";
		}
		else if (zone == "zone_orange_level3a")
		{
			name = "Lower Orange Highrise Level 1a";
		}
		else if (zone == "zone_orange_level3b")
		{
			name = "Lower Orange Highrise Level 1b";
		}
		else if (zone == "zone_blue_level5")
		{
			name = "Lower Blue Highrise Level 1";
		}
		else if (zone == "zone_blue_level4a")
		{
			name = "Lower Blue Highrise Level 2a";
		}
		else if (zone == "zone_blue_level4b")
		{
			name = "Lower Blue Highrise Level 2b";
		}
		else if (zone == "zone_blue_level4c")
		{
			name = "Lower Blue Highrise Level 2c";
		}
		else if (zone == "zone_blue_level2a")
		{
			name = "Upper Blue Highrise Level 1a";
		}
		else if (zone == "zone_blue_level2b")
		{
			name = "Upper Blue Highrise Level 1b";
		}
		else if (zone == "zone_blue_level2c")
		{
			name = "Upper Blue Highrise Level 1c";
		}
		else if (zone == "zone_blue_level2d")
		{
			name = "Upper Blue Highrise Level 1d";
		}
		else if (zone == "zone_blue_level1a")
		{
			name = "Upper Blue Highrise Level 2a";
		}
		else if (zone == "zone_blue_level1b")
		{
			name = "Upper Blue Highrise Level 2b";
		}
		else if (zone == "zone_blue_level1c")
		{
			name = "Upper Blue Highrise Level 2c";
		}
	}
	else if (level.script == "zm_prison")
	{
		if (zone == "zone_start")
		{
			name = "D-Block";
		}
		else if (zone == "zone_library")
		{
			name = "Library";
		}
		else if (zone == "zone_cellblock_west")
		{
			name = "Cellblock 2nd Floor";
		}
		else if (zone == "zone_cellblock_west_gondola")
		{
			name = "Cellblock 3rd Floor";
		}
		else if (zone == "zone_cellblock_west_gondola_dock")
		{
			name = "Cellblock Gondola";
		}
		else if (zone == "zone_cellblock_west_barber")
		{
			name = "Michigan Avenue";
		}
		else if (zone == "zone_cellblock_east")
		{
			name = "Times Square";
		}
		else if (zone == "zone_cafeteria")
		{
			name = "Cafeteria";
		}
		else if (zone == "zone_cafeteria_end")
		{
			name = "Cafeteria End";
		}
		else if (zone == "zone_infirmary")
		{
			name = "Infirmary 1";
		}
		else if (zone == "zone_infirmary_roof")
		{
			name = "Infirmary 2";
		}
		else if (zone == "zone_roof_infirmary")
		{
			name = "Roof 1";
		}
		else if (zone == "zone_roof")
		{
			name = "Roof 2";
		}
		else if (zone == "zone_cellblock_west_warden")
		{
			name = "Sally Port";
		}
		else if (zone == "zone_warden_office")
		{
			name = "Warden's Office";
		}
		else if (zone == "cellblock_shower")
		{
			name = "Showers";
		}
		else if (zone == "zone_citadel_shower")
		{
			name = "Citadel To Showers";
		}
		else if (zone == "zone_citadel")
		{
			name = "Citadel";
		}
		else if (zone == "zone_citadel_warden")
		{
			name = "Citadel To Warden's Office";
		}
		else if (zone == "zone_citadel_stairs")
		{
			name = "Citadel Tunnels";
		}
		else if (zone == "zone_citadel_basement")
		{
			name = "Citadel Basement";
		}
		else if (zone == "zone_citadel_basement_building")
		{
			name = "China Alley";
		}
		else if (zone == "zone_studio")
		{
			name = "Building 64";
		}
		else if (zone == "zone_dock")
		{
			name = "Docks";
		}
		else if (zone == "zone_dock_puzzle")
		{
			name = "Docks Gates";
		}
		else if (zone == "zone_dock_gondola")
		{
			name = "Upper Docks";
		}
		else if (zone == "zone_golden_gate_bridge")
		{
			name = "Golden Gate Bridge";
		}
		else if (zone == "zone_gondola_ride")
		{
			name = "Gondola";
		}
	}
	else if (level.script == "zm_buried")
	{
		if (zone == "zone_start")
		{
			name = "Processing";
		}
		else if (zone == "zone_start_lower")
		{
			name = "Lower Processing";
		}
		else if (zone == "zone_tunnels_center")
		{
			name = "Center Tunnels";
		}
		else if (zone == "zone_tunnels_north")
		{
			name = "Courthouse Tunnels 2";
		}
		else if (zone == "zone_tunnels_north2")
		{
			name = "Courthouse Tunnels 1";
		}
		else if (zone == "zone_tunnels_south")
		{
			name = "Saloon Tunnels 3";
		}
		else if (zone == "zone_tunnels_south2")
		{
			name = "Saloon Tunnels 2";
		}
		else if (zone == "zone_tunnels_south3")
		{
			name = "Saloon Tunnels 1";
		}
		else if (zone == "zone_street_lightwest")
		{
			name = "Outside General Store & Bank";
		}
		else if (zone == "zone_street_lightwest_alley")
		{
			name = "Outside General Store & Bank Alley";
		}
		else if (zone == "zone_morgue_upstairs")
		{
			name = "Morgue";
		}
		else if (zone == "zone_underground_jail")
		{
			name = "Jail Downstairs";
		}
		else if (zone == "zone_underground_jail2")
		{
			name = "Jail Upstairs";
		}
		else if (zone == "zone_general_store")
		{
			name = "General Store";
		}
		else if (zone == "zone_stables")
		{
			name = "Stables";
		}
		else if (zone == "zone_street_darkwest")
		{
			name = "Outside Gunsmith";
		}
		else if (zone == "zone_street_darkwest_nook")
		{
			name = "Outside Gunsmith Nook";
		}
		else if (zone == "zone_gun_store")
		{
			name = "Gunsmith";
		}
		else if (zone == "zone_bank")
		{
			name = "Bank";
		}
		else if (zone == "zone_tunnel_gun2stables")
		{
			name = "Stables To Gunsmith Tunnel 2";
		}
		else if (zone == "zone_tunnel_gun2stables2")
		{
			name = "Stables To Gunsmith Tunnel";
		}
		else if (zone == "zone_street_darkeast")
		{
			name = "Outside Saloon & Toy Store";
		}
		else if (zone == "zone_street_darkeast_nook")
		{
			name = "Outside Saloon & Toy Store Nook";
		}
		else if (zone == "zone_underground_bar")
		{
			name = "Saloon";
		}
		else if (zone == "zone_tunnel_gun2saloon")
		{
			name = "Saloon To Gunsmith Tunnel";
		}
		else if (zone == "zone_toy_store")
		{
			name = "Toy Store Downstairs";
		}
		else if (zone == "zone_toy_store_floor2")
		{
			name = "Toy Store Upstairs";
		}
		else if (zone == "zone_toy_store_tunnel")
		{
			name = "Toy Store Tunnel";
		}
		else if (zone == "zone_candy_store")
		{
			name = "Candy Store Downstairs";
		}
		else if (zone == "zone_candy_store_floor2")
		{
			name = "Candy Store Upstairs";
		}
		else if (zone == "zone_street_lighteast")
		{
			name = "Outside Courthouse & Candy Store";
		}
		else if (zone == "zone_underground_courthouse")
		{
			name = "Courthouse Downstairs";
		}
		else if (zone == "zone_underground_courthouse2")
		{
			name = "Courthouse Upstairs";
		}
		else if (zone == "zone_street_fountain")
		{
			name = "Fountain";
		}
		else if (zone == "zone_church_graveyard")
		{
			name = "Graveyard";
		}
		else if (zone == "zone_church_main")
		{
			name = "Church Downstairs";
		}
		else if (zone == "zone_church_upstairs")
		{
			name = "Church Upstairs";
		}
		else if (zone == "zone_mansion_lawn")
		{
			name = "Mansion Lawn";
		}
		else if (zone == "zone_mansion")
		{
			name = "Mansion";
		}
		else if (zone == "zone_mansion_backyard")
		{
			name = "Mansion Backyard";
		}
		else if (zone == "zone_maze")
		{
			name = "Maze";
		}
		else if (zone == "zone_maze_staircase")
		{
			name = "Maze Staircase";
		}
	}
	else if (level.script == "zm_tomb")
	{
		if (isDefined(self.teleporting) && self.teleporting)
		{
			return "";
		}

		if (zone == "zone_start")
		{
			name = "Lower Laboratory";
		}
		else if (zone == "zone_start_a")
		{
			name = "Upper Laboratory";
		}
		else if (zone == "zone_start_b")
		{
			name = "Generator 1";
		}
		else if (zone == "zone_bunker_1a")
		{
			name = "Generator 3 Bunker 1";
		}
		else if (zone == "zone_fire_stairs")
		{
			name = "Fire Tunnel";
		}
		else if (zone == "zone_bunker_1")
		{
			name = "Generator 3 Bunker 2";
		}
		else if (zone == "zone_bunker_3a")
		{
			name = "Generator 3";
		}
		else if (zone == "zone_bunker_3b")
		{
			name = "Generator 3 Bunker 3";
		}
		else if (zone == "zone_bunker_2a")
		{
			name = "Generator 2 Bunker 1";
		}
		else if (zone == "zone_bunker_2")
		{
			name = "Generator 2 Bunker 2";
		}
		else if (zone == "zone_bunker_4a")
		{
			name = "Generator 2";
		}
		else if (zone == "zone_bunker_4b")
		{
			name = "Generator 2 Bunker 3";
		}
		else if (zone == "zone_bunker_4c")
		{
			name = "Tank Station";
		}
		else if (zone == "zone_bunker_4d")
		{
			name = "Above Tank Station";
		}
		else if (zone == "zone_bunker_tank_c")
		{
			name = "Generator 2 Tank Route 1";
		}
		else if (zone == "zone_bunker_tank_c1")
		{
			name = "Generator 2 Tank Route 2";
		}
		else if (zone == "zone_bunker_4e")
		{
			name = "Generator 2 Tank Route 3";
		}
		else if (zone == "zone_bunker_tank_d")
		{
			name = "Generator 2 Tank Route 4";
		}
		else if (zone == "zone_bunker_tank_d1")
		{
			name = "Generator 2 Tank Route 5";
		}
		else if (zone == "zone_bunker_4f")
		{
			name = "zone_bunker_4f";
		}
		else if (zone == "zone_bunker_5a")
		{
			name = "Workshop Downstairs";
		}
		else if (zone == "zone_bunker_5b")
		{
			name = "Workshop Upstairs";
		}
		else if (zone == "zone_nml_2a")
		{
			name = "No Man's Land Walkway";
		}
		else if (zone == "zone_nml_2")
		{
			name = "No Man's Land Entrance";
		}
		else if (zone == "zone_bunker_tank_e")
		{
			name = "Generator 5 Tank Route 1";
		}
		else if (zone == "zone_bunker_tank_e1")
		{
			name = "Generator 5 Tank Route 2";
		}
		else if (zone == "zone_bunker_tank_e2")
		{
			name = "zone_bunker_tank_e2";
		}
		else if (zone == "zone_bunker_tank_f")
		{
			name = "Generator 5 Tank Route 3";
		}
		else if (zone == "zone_nml_1")
		{
			name = "Generator 5 Tank Route 4";
		}
		else if (zone == "zone_nml_4")
		{
			name = "Generator 5 Tank Route 5";
		}
		else if (zone == "zone_nml_0")
		{
			name = "Generator 5 Left Footstep";
		}
		else if (zone == "zone_nml_5")
		{
			name = "Generator 5 Right Footstep Walkway";
		}
		else if (zone == "zone_nml_farm")
		{
			name = "Generator 5";
		}
		else if (zone == "zone_nml_celllar")
		{
			name = "Generator 5 Cellar";
		}
		else if (zone == "zone_bolt_stairs")
		{
			name = "Lightning Tunnel";
		}
		else if (zone == "zone_nml_3")
		{
			name = "No Man's Land 1st Right Footstep";
		}
		else if (zone == "zone_nml_2b")
		{
			name = "No Man's Land Stairs";
		}
		else if (zone == "zone_nml_6")
		{
			name = "No Man's Land Left Footstep";
		}
		else if (zone == "zone_nml_8")
		{
			name = "No Man's Land 2nd Right Footstep";
		}
		else if (zone == "zone_nml_10a")
		{
			name = "Generator 4 Tank Route 1";
		}
		else if (zone == "zone_nml_10")
		{
			name = "Generator 4 Tank Route 2";
		}
		else if (zone == "zone_nml_7")
		{
			name = "Generator 4 Tank Route 3";
		}
		else if (zone == "zone_bunker_tank_a")
		{
			name = "Generator 4 Tank Route 4";
		}
		else if (zone == "zone_bunker_tank_a1")
		{
			name = "Generator 4 Tank Route 5";
		}
		else if (zone == "zone_bunker_tank_a2")
		{
			name = "zone_bunker_tank_a2";
		}
		else if (zone == "zone_bunker_tank_b")
		{
			name = "Generator 4 Tank Route 6";
		}
		else if (zone == "zone_nml_9")
		{
			name = "Generator 4 Left Footstep";
		}
		else if (zone == "zone_air_stairs")
		{
			name = "Wind Tunnel";
		}
		else if (zone == "zone_nml_11")
		{
			name = "Generator 4";
		}
		else if (zone == "zone_nml_12")
		{
			name = "Generator 4 Right Footstep";
		}
		else if (zone == "zone_nml_16")
		{
			name = "Excavation Site Front Path";
		}
		else if (zone == "zone_nml_17")
		{
			name = "Excavation Site Back Path";
		}
		else if (zone == "zone_nml_18")
		{
			name = "Excavation Site Level 3";
		}
		else if (zone == "zone_nml_19")
		{
			name = "Excavation Site Level 2";
		}
		else if (zone == "ug_bottom_zone")
		{
			name = "Excavation Site Level 1";
		}
		else if (zone == "zone_nml_13")
		{
			name = "Generator 5 To Generator 6 Path";
		}
		else if (zone == "zone_nml_14")
		{
			name = "Generator 4 To Generator 6 Path";
		}
		else if (zone == "zone_nml_15")
		{
			name = "Generator 6 Entrance";
		}
		else if (zone == "zone_village_0")
		{
			name = "Generator 6 Left Footstep";
		}
		else if (zone == "zone_village_5")
		{
			name = "Generator 6 Tank Route 1";
		}
		else if (zone == "zone_village_5a")
		{
			name = "Generator 6 Tank Route 2";
		}
		else if (zone == "zone_village_5b")
		{
			name = "Generator 6 Tank Route 3";
		}
		else if (zone == "zone_village_1")
		{
			name = "Generator 6 Tank Route 4";
		}
		else if (zone == "zone_village_4b")
		{
			name = "Generator 6 Tank Route 5";
		}
		else if (zone == "zone_village_4a")
		{
			name = "Generator 6 Tank Route 6";
		}
		else if (zone == "zone_village_4")
		{
			name = "Generator 6 Tank Route 7";
		}
		else if (zone == "zone_village_2")
		{
			name = "Church";
		}
		else if (zone == "zone_village_3")
		{
			name = "Generator 6 Right Footstep";
		}
		else if (zone == "zone_village_3a")
		{
			name = "Generator 6";
		}
		else if (zone == "zone_ice_stairs")
		{
			name = "Ice Tunnel";
		}
		else if (zone == "zone_bunker_6")
		{
			name = "Above Generator 3 Bunker";
		}
		else if (zone == "zone_nml_20")
		{
			name = "Above No Man's Land";
		}
		else if (zone == "zone_village_6")
		{
			name = "Behind Church";
		}
		else if (zone == "zone_chamber_0")
		{
			name = "The Crazy Place Lightning Chamber";
		}
		else if (zone == "zone_chamber_1")
		{
			name = "The Crazy Place Lightning & Ice";
		}
		else if (zone == "zone_chamber_2")
		{
			name = "The Crazy Place Ice Chamber";
		}
		else if (zone == "zone_chamber_3")
		{
			name = "The Crazy Place Fire & Lightning";
		}
		else if (zone == "zone_chamber_4")
		{
			name = "The Crazy Place Center";
		}
		else if (zone == "zone_chamber_5")
		{
			name = "The Crazy Place Ice & Wind";
		}
		else if (zone == "zone_chamber_6")
		{
			name = "The Crazy Place Fire Chamber";
		}
		else if (zone == "zone_chamber_7")
		{
			name = "The Crazy Place Wind & Fire";
		}
		else if (zone == "zone_chamber_8")
		{
			name = "The Crazy Place Wind Chamber";
		}
		else if (zone == "zone_robot_head")
		{
			name = "Robot's Head";
		}
	}

	return name;
}

//// Round Record Tracker
// Credits to Cahz
high_round_tracker()
{
	thread high_round_info_giver();
	gamemode = gamemodeName( getDvar( "ui_gametype" ) );
	map = mapName( level.script );
	if( level.script == "zm_transit" && getDvar( "ui_gametype" ) == "zsurvival" )
		map = startLocationName( getDvar( "ui_zm_mapstartlocation" ) );
	//file handling//
	level.basepath = getDvar("fs_basepath") + "/" + getDvar("fs_basegame") + "/";
	path = level.basepath + "/logs/" + map + gamemode + "HighRound.txt";
	file = fopen(path, "r");
	text = fread(file);
	fclose(file);
	//end file handling//
	highroundinfo = strToK( text, ";" );
	level.HighRound = int( highroundinfo[ 0 ] );
	level.HighRoundPlayers = highroundinfo[ 1 ];
	for ( ;; )
	{
		level waittill ( "end_game" );
		if ( level.round_number > level.HighRound )
		{
			level.HighRoundPlayers = "";
			players = get_players();
			for ( i = 0; i < players.size; i++ )
			{
				if( level.HighRoundPlayers == "" )
				{
					level.HighRoundPlayers = players[i].name;
				}
				else
				{
					level.HighRoundPlayers = level.HighRoundPlayers + "," + players[i].name;
				}
			}
			foreach( player in level.players )
			{
				player tell( "New Record: ^1" + level.round_number );
				player tell( "Set by: ^1" + level.HighRoundPlayers );
			}
			log_highround_record( level.round_number + ";" + level.HighRoundPlayers );
		}
	}
}

log_highround_record( newRecord )
{
	gamemode = gamemodeName( getDvar( "ui_gametype" ) );
	map = mapName( level.script );
	if( level.script == "zm_transit" && getDvar( "ui_gametype" ) == "zsurvival" )
		map = startLocationName( getDvar( "ui_zm_mapstartlocation" ) );
	level.basepath = getDvar("fs_basepath") + "/" + getDvar("fs_basegame") + "/";
	path = level.basepath + "/logs/" + map + gamemode + "HighRound.txt";
	file = fopen( path, "w" );
	fputs( newRecord, file );
	fclose( file );
}

startLocationName( location )
{
	if( location == "cornfield" )
		return "Cornfield";
	else if( location == "diner" )
		return "Diner";
	else if( location == "farm" )
		return "Farm";
	else if( location == "power" )
		return "Power";
	else if( location == "town" )
		return "Town";
	else if( location == "transit" )
		return "BusDepot";
	else if( location == "tunnel" )
		return "Tunnel";
}

mapName( map )
{
	if( map == "zm_buried" )
		return "Buried";
	else if( map == "zm_highrise" )
		return "DieRise";
	else if( map == "zm_prison" )
		return "Motd";
	else if( map == "zm_nuked" )
		return "Nuketown";
	else if( map == "zm_tomb" )
		return "Origins";
	else if( map == "zm_transit" )
		return "Tranzit";
	return "NA";
}

gamemodeName( gamemode )
{
	if( gamemode == "zstandard" )
		return "Standard";
	else if( gamemode == "zclassic" )
		return "Classic";
	else if( gamemode == "zsurvival" )
		return "Survival";
	else if( gamemode == "zgrief" )
		return "Grief";
	else if( gamemode == "zcleansed" )
		return "Turned";
	return "NA";
}

high_round_info_giver()
{
	highroundinfo = 1;
	roundmultiplier = 5;
	level endon( "end_game" );
	while( 1 )
	{	
		level waittill( "start_of_round" );
		if( level.round_number == ( highroundinfo * roundmultiplier ))
		{
			highroundinfo++;
			foreach( player in level.players )
			{
				player tell( "Server Highest Round: ^1" + level.HighRound );
				player tell( "Record set by: ^1" + level.HighRoundPlayers );
			}
		}
	}
}

high_round_info()
{
	wait 6;
	self tell( "Server Highest Round: ^1" + level.HighRound );
	self tell( "Record set by: ^1" + level.HighRoundPlayers );
}

//// Adds the ability to drop your weapon by holding down the "Melee" button
// Credits to teh-bandit
drop()
{
	level endon("end_game");
	self endon("disconnect");
	for (;;) 
	{
		if (self meleebuttonpressed()) 
		{
			duration = 0;
			while (self meleebuttonpressed()) 
			{
				duration += 1;
				if (duration == 25) 
				{
					weap = self getCurrentWeapon();
					self dropItem(weap);
					break;
				}
				wait 0.05;
			}
		}
		wait 0.05;
	}
}

//// Adds the ability to inspect your weapon by holding down the "Use/Interact" button
// Credits to teh-bandit
inspect()
{
	level endon("end_game");
	self endon("disconnect");
	for (;;) 
	{
		if (self usebuttonpressed()) 
		{
			duration = 0;
			while (self usebuttonpressed()) 
			{
				duration += 1;
				if (duration == 25) 
				{
					self initialweaponraise(self getcurrentweapon());
					break;
				}
				wait 0.05;
			}
		}
		wait 0.05;
	}
}