//// Include the required libraries for your scripts.
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zombies\_zm_score;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_chugabud;
#include maps\mp\zombies\_zm_magicbox;
#include maps\mp\zombies\_zm_powerups;

// Initialize the code
init()
{
	precache(); 											// Precache for models
	thread initServerDvars(); 								// Initialize server DVars to be read from dedicated_zm.cfg
    for	(;;)
    {
        level waittill("connected", player);
		level thread onplayerconnect();
		thread gscRestart(); 								// JezuzLizard fix sound stuff
		thread setPlayersToSpectator(); 					// JezuzLizard fix sound stuff
    }
}

// When players connected
onplayerconnect()
{
	level endon( "end_game" );
    self endon( "disconnect" );
	for (;;)
	{
		level waittill( "connected", player );
		player thread spawnIfRoundOne();
		player thread onplayerspawned();
	}
}

// Precaching stuff
precache()
{	
	PrecacheModel("zombie_x2_icon");
	PrecacheModel("zombie_bomb");
	PrecacheModel("zombie_ammocan");
	PrecacheModel("zombie_x2_icon");
	PrecacheModel("zombie_skull");
	PrecacheModel("p6_anim_zm_buildable_pap");
}

// Dont touch these, unless you need to add or remove scripts here
onplayerspawned()
{
	self endon( "disconnect" );
	for	(;;)
	{
		self waittill( "spawned_player" );
		self._retain_perks = getDvarIntDefault( "cmPlayerRetainPerks", 0 );
		if ( !isDefined( self.cmIsFirstSpawn ) || !self.cmIsFirstSpawn )
		{
			self.cmIsFirstSpawn = 1;								// Is this the first time the player has spawnned?
			self thread watch_for_respawn();						// Waits for respawn
			self.health = level.cmPlayerMaxHealth; 					// (UNSURE) Links together with level.cmPlayerMaxHealth
			self.maxHealth = self.health; 							// (UNSURE) Links together with self.health
			self setMaxHealth( level.cmPlayerMaxHealth );			// Calls for Health values from initServerDvars() which then asks for cmPlayerMaxHealth inside dedicated_zm.cfg
		}
	}
}

// Make almost everything configurable through dedicated_zm.cfg
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
	level.customMysteryBoxPriceEnabled = getDvarIntDefault( "customMysteryBoxPriceEnabled", 0 );
	level.zombie_vars[ "customMysteryBoxPriceEnabled" ] = level.customMysteryBoxPriceEnabled;
	level.customMysteryBoxPrice = getDvarIntDefault( "customMysteryBoxPrice", 950 );
	level.zombie_vars[ "customMysteryBoxPrice" ] = level.customMysteryBoxPrice;
	init_custom_zm_powerups_gsc_exclusive_dvars();	// Powerup Dvars
	disable_specific_powerups();					// Powerup Dvars
	checks();										// Fixes and checks to make the code work properly
	thread zombies_always_drop_powerups();			// Fixes to make the code work properly	
	thread zombies_per_round_override();			// Fixes to make the code work properly
	thread zombie_health_override();				// Fixes to make the code work properly
	thread zombie_health_cap_override();			// Fixes to make the code work properly
	thread zombie_spawn_delay_fix();				// Fixes to make the code work properly
	thread zombie_speed_fix();						// Fixes to make the code work properly
}	

// Make Powerups toggleable through dedicated_zm.cfg
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

// Make Powerups configurable through dedicated_zm.cfg
// Requires _zm_powerups.gsc to be installed into <Plutonium Server Folder>\t6r\data\maps\mp\zombies
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

// Fix several sound bugs
gscRestart()
{
	level waittill( "end_game" );
	wait 30;
	map_restart( false );
}

// Fix several sound bugs
setPlayersToSpectator()
{
	level.no_end_game_check = 1;
	wait 3;
	players = get_players();
	i = 0;
	while ( i < players.size )
	{
		if ( i == 0 )
		{
			i++;
		}
		players[ i ] setToSpectator();
		i++;
	}
	wait 5; 
	spawnAllPlayers();
}

// Fix several sound bugs
setToSpectator()
{
    self.sessionstate = "spectator"; 
    if (isDefined(self.is_playing))
    {
        self.is_playing = false;
    }
}

// When spawning all players
spawnAllPlayers()
{
	players = get_players();
	i = 0;
	while ( i < players.size )
	{
		if ( players[ i ].sessionstate == "spectator" && isDefined( players[ i ].spectator_respawn ) )
		{
			players[ i ] [[ level.spawnplayer ]]();
			if ( level.script != "zm_tomb" || level.script != "zm_prison" || !is_classic() )
			{
				thread maps\mp\zombies\_zm::refresh_player_navcard_hud();
			}
		}
		i++;
	}
	level.no_end_game_check = 0;
}

// If the round is 1, spawn players no matter what
spawnIfRoundOne()
{
	wait 3;
	if ( self.sessionstate == "spectator" && level.round_number == 1 )
		self iprintln("Get ready to be spawned!");
	wait 5;
	if ( self.sessionstate == "spectator" && level.round_number == 1 )
	{
		self [[ level.spawnplayer ]]();
		if ( level.script != "zm_tomb" || level.script != "zm_prison" || !is_classic() )
			thread maps\mp\zombies\_zm::refresh_player_navcard_hud();
	}
}

// Dont touch these, checks to prevent crashing
checks()
{
	if( level.customMysteryBoxPriceEnabled == 1) //custom mystery box price
	{
		level thread setMysteryBoxPrice();
	}
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

// Custom Mystery Box price, configurable inside dedicated_zm.cfg
setMysteryBoxPrice() 
{
	i = 0;
    while (i < level.chests.size)
    {
        level.chests[ i ].zombie_cost = level.customMysteryBoxPrice;
        level.chests[ i ].old_cost = level.customMysteryBoxPrice;
        i++;
    }
}

