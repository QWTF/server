void (entity Goal, entity AP, entity ActivatingGoal) AttemptToActivate;

//===========================================================================
// TEAMFORTRESS Defs
//===========================================================================
.float playerclass;
.float nextpc;		// The playerclass you'll respawn as
.float last_impulse;	// The previous impulse command from this player
.float armorclass;	// Type of armor being worn
.float tf_items;	// Another flag for player items
.float tf_items_flags;	// Flags for the player items
.float no_grenades_1;	// Number of grenades of type 1 being carried
.float no_grenades_2;	// Number of grenades of type 2 being carried
.float tp_grenades_1;	// 1st type of grenades being carried
.float tp_grenades_2;	// 2nd type of grenades being carried

.float got_aliases;		// TRUE if the player has TeamFortress aliases
.float cheat_check;		// Time when we'll next check for team cheats
.float is_removed;		// TRUE if the entity has been removed
.float is_undercover;		// TRUE for a SPY if they're undercover
.float is_building;		// TRUE for an ENGINEER if they're building something
.float is_detpacking;		// TRUE for a DEMOMAN if they're setting a detpack
.float is_feigning;		// TRUE for a SPY if they're feigning death
.float is_unabletospy;		// TRUE for a SPY if they can't go undercover
.float has_disconnected;	// TRUE if the player has disconnected

.float tfstate;		// State flags for TeamFortress
.entity linked_list;	// Used just like chain. Has to be separate so
			// it doesn't interfere with chain. See T_RadiusScan

.entity observer_list;	// Used by undefined classes, see TF_MovePlayer

// Playerclass handling variables
.float maxammo_shells;
.float maxammo_nails;
.float maxammo_cells;
.float maxammo_rockets;
.float items_allowed;
.float armor_allowed;
.float maxarmor;
.float maxfbspeed;	// Maximum forward/back speed
.float maxstrafespeed;	// Maximum side speed

.float weaponmode;	// Used for multiple mode weapons
.float motd;		// Used to display MOTD
.float current_menu;	// is set to the number of the current menu, is 0 if they are not in a menu
.float menu_count;	// keeps track of display times for menus
.float menu_displaytime;	// keep track of how many times this menu is refreshed

float toggleflags;	// toggleable flags

float respawn_delay_time;

//Up2: For new prematch countdown. Maybe make this a field taken from serverinfo
float prematch_countdown = 11;
float countdown_start_time;
string server_status;
float anti_spam_timer_reminder;
float anti_spam_timer_ready;
float anti_spam_timer_list;
float anti_spam_timer_rpickup;
float anti_spam_timer_hwguy_cannon;
string is_sbar_on;
string sbar_code_executed;


//
// FortressMap stuff
//
float number_of_teams;
float illegalclasses;
float illegalclasses1;
float illegalclasses2;
float illegalclasses3;
float illegalclasses4;
float civilianteams;

float team1col;		// Colours for each of the 4 teams
float team2col;		// If there's enough demand, we'll
float team3col;		// allow more than four teams...
float team4col;
float team1score;	// Goal Score of each team
float team2score;
float team3score;
float team4score;
float team1lives;	// Number of lives each team's players have
float team2lives;
float team3lives;
float team4lives;
float team1maxplayers;	// Max number of players allowed in each team
float team2maxplayers;
float team3maxplayers;
float team4maxplayers;
float team1advantage;	// only used if the teamplay equalisation bits are set
float team2advantage;	// stores the damage ratio players take/give
float team3advantage;
float team4advantage;

.float team_no;		// The team you belong to
.float lives;		// The number of lives you have left

.float infection_team_no; // The team_no of the person who infected you

// CTF stuff
float CTF_Map;

float coop;

.entity building;	// The building the ENGINEER is using
.float building_wait;	// Used to prevent using a building again immediately
.entity real_owner;
.float has_dispenser;	// TRUE for an ENGINEER if he has a dispenser
.float has_sentry;	// TRUE for an ENGINEER if he has a sentry

.float real_frags;	// Used to store the players frags when TeamFrags is On

.float respawn_time;	// players can't respawn within this time.
.float suicide_time;	// players can't suicide within this time.

/*==============================================*/
/* New Weapon variables				*/
/*==============================================*/
.float weapons_carried;	// the weapons the player is carrying
.float current_weapon;	// the weapon the player is using
.float last_weapon;
.float last_weaponmode;

.float ammo_medikit;	// Ammo used for the medikit
.float maxammo_medikit;
.float ammo_detpack;	// Ammo used for the detpack
.float maxammo_detpack;

// variables used for reloading
.float reload_shotgun;
.float reload_super_shotgun;
.float reload_grenade_launcher;
.float reload_rocket_launcher;

// Assault Cannon
.float heat;

// Team Color Cheat Checking
.float immune_to_check;

// Make sure people don't do too many saveme sounds
.float last_saveme_sound;

.float no_active_nail_grens;
.float no_active_napalm_grens;
.float no_active_gas_grens;

/*======================================================================*/
/* TEAMFORTRESS GOALS							*/
/*======================================================================*/
// Variables used in the Goals
.float goal_no;			// Goal number of this goal
.float group_no; 		// Goal group this goal is in
.float goal_state;		// State of this goal
.float owned_by;		// The team this goal/item/whatever belongs to

// Goal Activation details
.float goal_activation;		// Bitfields. Determines how this goal is activated
.float goal_effects;		// Bitfields. Determines which players are affected by this goal
.float goal_result;		// Bitfields. Determines the results of activation
.float goal_group;		// Bitfields. Determines how groups are affected by activation of this goal

.float else_goal;		// A Goal that's activated if this one fails to activate

.float if_goal_is_active;
.float if_goal_is_inactive;
.float if_goal_is_removed;
.float if_group_is_active;
.float if_group_is_inactive;
.float if_group_is_removed;

// Goal Result details
.float activate_goal_no;
.float inactivate_goal_no;
.float remove_goal_no;
.float restore_goal_no;
.float activate_group_no;
.float inactivate_group_no;
.float remove_group_no;
.float restore_group_no;

.vector goal_min;
.vector goal_max;

// Item State behaviour
.float has_item_from_group;
.float hasnt_item_from_group;
.float remove_item_group;
.float return_item_no;
.float if_item_has_moved;
.float if_item_hasnt_moved;

// Spawnpoint behaviour
.float remove_spawnpoint;
.float restore_spawnpoint;
.float remove_spawngroup;
.float restore_spawngroup;

// Item Displaying details
.float display_item_status1;	// Goal displays the status of these items
.float display_item_status2;
.float display_item_status3;
.float display_item_status4;
.string team_str_home;		// Displayed when the item is at home base
.string team_str_moved;		// Displayed when the item has been moved
.string team_str_carried;	// Displayed when the item is being carried
.string non_team_str_home;	// Displayed when the item is at home base
.string non_team_str_moved;	// Displayed when the item has been moved
.string non_team_str_carried;	// Displayed when the item is being carried

// Goal/Timer/GoalItem/Trigger existence checking
.float ex_skill_min;		// Exists when the skill is >= this value
.float ex_skill_max;		// Exists when the skill is <= this value

// Score increases
.float increase_team1;		// Increase the scores of particular teams
.float increase_team2;
.float increase_team3;
.float increase_team4;

// Centerprinting
.string broadcast;		// Centerprinted to all, overridden by the next two
.string team_broadcast;		// Centerprinted to AP's team members, but not the AP
.string non_team_broadcast;	// Centerprinted to non AP's team members
.string owners_team_broadcast;	// Centerprinted to the members of the team that own the Goal/Item
.string netname_broadcast;		// same as above, prepended by AP netname and bprinted
.string netname_team_broadcast;		// same as above, prepended by AP netname and bprinted
.string netname_non_team_broadcast;	// same as above, prepended by AP netname and bprinted
.string netname_owners_team_broadcast;	// same as above, prepended by AP netname and bprinted

.string team_drop;		// Centerprinted to item owners team
.string non_team_drop;		// Centerprinted to everone not on item owners team
.string netname_team_drop;	// same as above, prepended by AP netname and bprinted
.string netname_non_team_drop;	// same as above, prepended by AP netname and bprinted

string team_menu_string;

.float all_active;

.float item_list;		// Used to keep track of which goalitems are 
				// affecting the player at any time.
				// GoalItems use it to keep track of their own 
				// mask to apply to a player's item_list

float item_list_bit;		// Global, used to determine what the bit of
				// each new GoalItem will be.

.float delay_time;		// For delayed goal results
.float dont_do_triggerwork;

// Abbreviations for the above
.float g_a;	// goal_activation
.float g_e;	// goal_effects

.string t_s_h;	// team_str_home
.string t_s_m;	// team_str_moved
.string t_s_c;	// team_str_carried
.string n_s_h;	// non_team_str_home
.string n_s_m;	// non_team_str_moved
.string n_s_c;	// non_team_str_carried

.string b_b;	// broadcast
.string b_t;	// team_broadcast
.string b_n;	// non_team_broadcast
.string b_o;	// owners_team_broadcast
.string n_b;	// netname_broadcast
.string n_t;	// netname_team_broadcast
.string n_n;	// netname_non_team_broadcast
.string n_o;	// netname_owners_team_broadcast

.string d_t;	// team_drop
.string d_n;	// non_team_drop
.string d_n_t;	// netname_team_drop
.string d_n_n;	// netname_non_team_drop

.float h_i_g;
.float hn_i_g;
.float r_i_g;
.float a_s;
.float a_n;
.float a_r;
.float a_c;
.float rv_s_h;
.float rs_s_h;
.float rv_gr;
.float rs_gr;
.float rv_g;
.float rs_g;
.float has_abbreviated;

//============================================================================

float num_world_flames;
.float numflames;	// number of flames on entity
.string flame_id;	// has to be string so that the C function find() can be used

// pipebomb limits
// when the limit is exceeded, older pipebombs explode
float num_world_pipebombs;
float num_team_pipebombs_1;
float num_team_pipebombs_2;
float num_team_pipebombs_3;
float num_team_pipebombs_4;

// flare limits
float num_world_flares;
float num_team_flares_1;
float num_team_flares_2;
float num_team_flares_3;
float num_team_flares_4;

// ammobox limits
// when the limit is exceeded, older ammoboxes disappear
float num_world_ammoboxes;
float num_team_ammoboxes_1;
float num_team_ammoboxes_2;
float num_team_ammoboxes_3;
float num_team_ammoboxes_4;

// Spy variables
.float undercover_team;
.float undercover_skin;
.string undercover_name;

float live_camera;
.float camdist;
.vector camangle;
.entity camera_list;

float already_chosen_map;

// grappling hook variables
.entity hook;
.float on_hook;
.float hook_out;
.float fire_held_down;	// flag - TRUE if player is still holding down the
			// fire button after throwing a hook.

// sniper location damage stuff
.vector head_shot_vector;
.float leg_damage;

.float cheat_level;

// flash grenade level
.float FlashTime;
.float nailpos;

// status bar stuff
.float StatusBarSize;	// the size of the bar. 1 is default, 0 is off
.float StatusBarRes;	// the gfx res the player's running in
.float StatusRefreshTime;	// time to next refresh the status bar
				// any function that uses a CenterPrintnt
				// should reset this value

.float ScannerOn;

float clanbattle;
float clan_scores_dumped;
float cb_prematch_time;
float cb_ceasefire_time;
float game_locked;
float team1frags;
float team2frags;
float team3frags;
float team4frags;
float last_id;

.float tf_id;

float spy_off;
float old_grens;
float invis_only;
float allow_hook;
float flagem_checked;
float cease_fire;

.float teamkills;

float autokick_time;
float autokick_kills;

.float is_admin;
.float admin_mode;
.entity admin_use;
.string ip;

float deathmsg;		// Global, which is set before every T_Damage, to indicate
			// the death message that should be used.

float birthday;
float intermission_running;
float intermission_exittime;

//============================================================================

void (float psize, entity p) KickPlayer =
{
    msg_entity = p;
    if (psize > -3)
        WriteByte (MSG_ONE, SVC_SMALLKICK);
    else
	WriteByte (MSG_ONE, SVC_BIGKICK);
};

void () muzzleflash =
{
    WriteByte (MSG_MULTICAST, SVC_MUZZLEFLASH);
    WriteEntity (MSG_MULTICAST, self);
    multicast (self.origin, MULTICAST_PVS);
};
