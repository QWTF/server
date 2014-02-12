void () player_pain;
void () player_stand1;

void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;

float modelindex_eyes;
float modelindex_player;
float modelindex_null;

void () TeamFortress_CheckTeamCheats;
void (entity Viewer, float pc, float rpc) TeamFortress_PrintClassName;
void () TeamFortress_RemoveTimers;
void (float Suicided) TeamFortress_SetupRespawn;

float (float pc) IsLegalClass;
void () SetupTeamEqualiser;
void () CeaseFire_think;

void (entity eng) Engineer_RemoveBuildings;

void (string halias, float himpulse1, float himpulse2) TeamFortress_Alias;

void (entity p) CheckAutoKick;
void (entity p) KickCheater;

void (entity p) TeamFortress_ExecClassScript;
void (entity p) TeamFortress_ExecMapScript;

void () PreMatch_Think;

void () DumpClanScores;

void (entity p) SetTeamName;

void () autokick_think;
float (float tno, float pc) ClassIsRestricted;

void () Service_Grapple;

void (entity AD) ParseTFDetect;
entity (float ino) Finditem;

void (entity Item, entity AP, entity Goal) tfgoalitem_GiveToPlayer;

void () CTF_FlagCheck;

void () TeamFortress_RandomTheTeams;

string nextmap;
float intermission_running;
float intermission_exittime;
float hideconsoletext;
float rpickup_votes;
float arr_rpickup_voters[32];
float ready_votes;
float arr_ready_voters[32];

void () info_intermission =
{
    if (CheckExistence () == 0) {
		dremove (self);
		return;
    }
};

void () SetChangeParms =
{
    if (self.health <= 0) {
		SetNewParms ();
		return;
    }
    self.items = self.items - (self.items & (IT_KEY1 | IT_KEY2 | IT_INVISIBILITY
					     | IT_INVULNERABILITY | IT_SUIT | IT_QUAD));
    if (self.health > 100)
		self.health = 100;
    if (self.health < 50)
		self.health = 50;

    parm1 = self.items;
    parm2 = self.health;
    parm3 = self.armorvalue;

    if (self.ammo_shells < 25)
		parm4 = 25;
    else
		parm4 = self.ammo_shells;

    parm5 = self.ammo_nails;
    parm6 = self.ammo_rockets;
    parm7 = self.ammo_cells;
    parm8 = self.current_weapon;
    parm9 = self.armortype * 100;
    parm10 = 0;
    parm11 = 0;
    parm12 = 0;
    parm13 = self.StatusBarRes;
    parm14 = self.StatusBarSize;
    parm15 = self.is_admin;
};

void () SetNewParms =
{
    parm1 = 0;
    parm2 = 100;
    parm3 = 0;
    parm4 = 25;
    parm5 = 0;
    parm6 = 0;
    parm6 = 0;
    parm8 = 1;
    parm9 = 0;
    parm10 = 0;
    parm11 = 0;
    parm12 = 0;
    parm13 = 0;
    parm14 = 0;
    parm15 = 0;
};

void () autoteam_think =
{
    toggleflags = toggleflags | TFLAG_AUTOTEAM;
    dremove (self);
};

void () autokick_think =
{
    self.owner.teamkills = 0;
    dremove (self);
};

void () DecodeLevelParms =
{
    local string st;
    local entity ent;

    local entity te;
    local float ti;

    if (serverflags)
		if (world.model == "maps/start.bsp")
			SetNewParms ();

    self.items = parm1;
    self.health = parm2;
    self.armorvalue = parm3;
    self.ammo_shells = parm4;
    self.ammo_nails = parm5;
    self.ammo_rockets = parm6;
    self.ammo_cells = parm7;
    self.current_weapon = parm8;
    self.armortype = parm9 * 0.01;

    if (!(toggleflags & TFLAG_FIRSTENTRY)) {

		toggleflags = parm10;
		flagem_checked = 0;
		allow_hook = 0;
		invis_only = 0;

		if (coop || !deathmatch)
			toggleflags = toggleflags | TFLAG_CLASS_PERSIST;

		nextmap = mapname;
		allow_hook = TRUE;

		ent = find (world, classname, "info_tfdetect");
		if (ent != world) {
			if (teamplay == 0)
				cvar_set ("teamplay", "21?TeamFortress");

			ParseTFDetect (ent);

			if ((number_of_teams <= 0) || (number_of_teams >= 5))
				number_of_teams = 4;
		}
		else {

			ent = find (world, classname, "info_player_team1");
			if ((ent != world) || (CTF_Map == 1)) {
				//CTF_Map = TRUE; // up2: makes no sense
				if (teamplay == 0)
					cvar_set ("teamplay", "21?TeamFortress");

				ent = spawn ();
				ent.nextthink = time + 30;
				ent.think = CTF_FlagCheck;
				number_of_teams = 2;
			}
			else
				number_of_teams = 4;

			team1lives = -1;
			team2lives = -1;
			team3lives = -1;
			team4lives = -1;

			illegalclasses1 = 0;
			illegalclasses2 = 0;
			illegalclasses3 = 0;
			illegalclasses4 = 0;

			team1maxplayers = 100;
			team2maxplayers = 100;
			team3maxplayers = 100;
			team4maxplayers = 100;
			civilianteams = 0;
		}
		bprint (PRINT_HIGH, "Mapname: ", mapname, "\n");

		SetupTeamEqualiser ();

		team1frags = 0;
		team2frags = 0;
		team3frags = 0;
		team4frags = 0;

		team1score = 0;
		team2score = 0;
		team3score = 0;
		team4score = 0;

		autokick_kills = 0;
		autokick_time = 0;

		cease_fire = 0;

		toggleflags = toggleflags - (toggleflags & TFLAG_TEAMFRAGS);
		toggleflags = toggleflags - (toggleflags & TFLAG_CHEATCHECK);

		st = infokey (world, "temp1");
		toggleflags = (toggleflags | TFLAG_FIRSTENTRY) | stof (st);

		local float autoteam_time;
		autoteam_time = 30;

		st = infokey (world, "bd");
		if (st == string_null)
			st = infokey (world, "birthday");

		if (st == "on") {
			birthday = TRUE;
			te = spawn ();
			te.weapon = 10;
			te.nextthink = time + 60;
			te.think = BirthdayTimer;
		}
		else if (st == "off")
			birthday = FALSE;

		st = infokey (world, "c");
		if (st == string_null) // maybe they are using "serverinfo clan" instead of "serverinfo c"
			st = infokey (world, "clan");

		if (st == "on") { // if clan game is set to on
			localcmd ("serverinfo status Prematch\n");
			clanbattle = TRUE;
			clan_scores_dumped = 0;
			game_locked = 0;
			
			// Old PM code used to be here.
				
			st = infokey (world, "cft");
			if (st == string_null)
				st = infokey (world, "ceasefire_time");

			cb_ceasefire_time = stof (st);
			
			if (cb_ceasefire_time != 0) {
				cb_ceasefire_time = time + cb_ceasefire_time * 60;
				if (cb_prematch_time < cb_ceasefire_time) { //up2 fix
				
					cb_prematch_time = cb_ceasefire_time + 5;
					
					if (timelimit && ((time + timelimit) < cb_prematch_time)) {
						timelimit = timelimit + cb_ceasefire_time;
						ti = ceil (timelimit / 60);
						st = ftos (ti);
						cvar_set ("timelimit", st);
					}
				}
				cease_fire = 1;
				bprint (PRINT_HIGH, "CEASE FIRE\n");

				te = find (world, classname, "player");
				while (te) {
					centerprint (te, "CEASE FIRE\n");
					te.immune_to_check = time + 10;
					te.tfstate = te.tfstate | TFSTATE_CANT_MOVE;
					TeamFortress_SetSpeed (te);
					te = find (te, classname, "player");
				}
				te = spawn ();
				te.classname = "ceasefire";
				te.think = CeaseFire_think;
				te.nextthink = time + 5;
				te.weapon = 1;
			}
			
			st = infokey (world, "lg");
			if (st == string_null)
				st = infokey (world, "locked_game");

			if (st == "on")
				game_locked = TRUE;
		}
		else {
			clanbattle = FALSE;
			localcmd ("serverinfo status Public\n");
		}

		st = infokey (world, "a");
		if (st == string_null)
			st = infokey (world, "autoteam");
		if (st == "on")
			toggleflags = toggleflags | TFLAG_AUTOTEAM;
		else if (st == "off")
			toggleflags = toggleflags - (toggleflags & TFLAG_AUTOTEAM);
		else if (stof (st) != 0) {
			toggleflags = toggleflags | TFLAG_AUTOTEAM;
			autoteam_time = stof (st);
		}

		st = infokey (world, "akt");
		if (st == string_null)
			st = infokey (world, "autokick_time");
		autokick_time = stof (st);
		if (autokick_time != 0) {
			st = infokey (world, "akk");
			
			if (st == string_null)
				st = infokey (world, "autokick_kills");
				
			autokick_kills = stof (st);
		}

		st = infokey (world, "t");
		if (st == string_null)
			st = infokey (world, "teamfrags");
		if (st == "on")
			toggleflags = toggleflags | TFLAG_TEAMFRAGS;
		else if (st == "off")
			toggleflags = toggleflags - (toggleflags & TFLAG_TEAMFRAGS);

		st = infokey (world, "fts");
		if (st == string_null)
			st = infokey (world, "fullteamscore");
		if (st == "on")
			toggleflags = toggleflags | TFLAG_FULLTEAMSCORE;

		st = infokey (world, "g");
		if (st == string_null)
			st = infokey (world, "grapple");
		if (st == "off")
			allow_hook = FALSE;
		if (!(toggleflags & TFLAG_GRAPPLE) && (st != "on"))
			allow_hook = FALSE;

		st = infokey (world, "og");
		if (st == string_null)
			st = infokey (world, "old_grenades");
		if (st == string_null)
			st = infokey (world, "old_grens");
		if (st == "on")
			old_grens = TRUE;

		st = infokey (world, "spy");
		if (st == "off")
			spy_off = TRUE;

		st = infokey (world, "s");
		if (st == string_null)
			st = infokey (world, "spyinvis");

		if ((st == "on") || (toggleflags & TFLAG_SPYINVIS))
			invis_only = TRUE;
		else if (st == "off")
			invis_only = FALSE;

		st = infokey (world, "rd");
		if (st == string_null)
			st = infokey (world, "respawn_delay");
		respawn_delay_time = stof (st);
		if (respawn_delay_time)
			toggleflags = toggleflags | TFLAG_RESPAWNDELAY;

		if ((toggleflags & TFLAG_RESPAWNDELAY) && (respawn_delay_time == 0))
			respawn_delay_time = RESPAWN_DELAY_TIME;

		if (toggleflags & TFLAG_AUTOTEAM) {
			toggleflags = toggleflags - (toggleflags & TFLAG_AUTOTEAM);
			ent = spawn ();
			ent.nextthink = time + autoteam_time;
			ent.think = autoteam_think;
		}
    }

    if (parm11)
		self.tfstate = parm11;
    if (self.playerclass == 0)
		self.playerclass = parm12;
    if (parm13)
		self.StatusBarRes = parm13;
    if (parm14)
		self.StatusBarSize = parm14;
    if (parm15)
		self.is_admin = parm15;
};

entity () FindIntermission =
{
    local entity spot;
    local float cyc;

    spot = find (world, classname, "info_intermission");
    if (spot)
	return (spot);

    spot = find (world, classname, "info_player_start");
    if (spot)
	return (spot);

    spot = find (world, classname, "info_player_deathmatch");
    if (spot) {
	cyc = random () * 6;
	while (cyc > 1) {
	    spot = find (spot, classname, "info_player_deathmatch");
	    if (!spot)
		spot = find (spot, classname, "info_player_deathmatch");
	    cyc = cyc - 1;
	}
	return (spot);
    }
    objerror ("FindIntermission: no spot");
};

entity (entity start_point) FindNextIntermission =
{
    local entity spot;

    if (deathmatch) {
		if ((start_point.classname == "info_intermission") || (start_point == world)) {
			spot = find (start_point, classname, "info_intermission");
			if (spot)
				return (spot);
			else
				start_point = world;
		}
		
		if ((start_point.classname == "info_player_deathmatch") || (start_point == world)) {
			spot = find (start_point, classname, "info_player_deathmatch");
			if (spot)
				return (spot);
		}
		
		spot = find (world, classname, "info_intermission");
		
		if (spot)
			return (spot);

		spot = find (world, classname, "info_player_deathmatch");
		
		if (spot)
			return (spot);
    }
	else {
		spot = find (world, classname, "info_player_start");
		if (spot)
			return (spot);
    }
    return (FindIntermission ());
};

void () TF_MovePlayer =
{
    local entity place;

    place = FindNextIntermission (self.observer_list);
    self.observer_list = place;
    setorigin (self, place.origin + '0 0 1');
    self.angles = place.angles;
    self.fixangle = 1;
};

void () GotoNextMap =
{
    local float nextlevel;
    local string sl;
    local string st;

    if (nextmap != mapname) {
	changelevel (nextmap);
	already_chosen_map = TRUE;
    }

    sl = infokey (world, mapname);
    if (sl != string_null) {
	nextmap = sl;
	already_chosen_map = TRUE;
	return;
    }

    if (!already_chosen_map) {

	sl = infokey (world, "n");
	nextlevel = stof (sl);
	nextlevel = nextlevel + 1;
	sl = ftos (nextlevel);

	localcmd ("serverinfo n ");
	localcmd (sl);
	localcmd ("\n");

	st = infokey (world, "cd");
	if (st == string_null)
	    st = infokey (world, "cycledir");

	if (st != string_null) {
	    localcmd ("exec ");
	    localcmd (st);
	    localcmd ("/map");
	} else
	    localcmd ("exec qwmcycle/map");

	localcmd (sl);
	localcmd (".cfg\n");
	already_chosen_map = TRUE;
    }
    if (infokey (world, "n") == "0")
	already_chosen_map = FALSE;
};

void () ExitIntermission =
{
    dprint ("Exiting intermission...\n");
    if (deathmatch) {
	dprint ("Exit Intermission in Deathmatch.\n");
	GotoNextMap ();
	return;
    }

    intermission_exittime = time + 1;
    intermission_running = intermission_running + 1;

    if (intermission_running == 2) {

	if (world.model == "maps/e1m7.bsp") {

	    WriteByte (MSG_ALL, SVC_CDTRACK);
	    WriteByte (MSG_ALL, 2);
	    WriteByte (MSG_ALL, 3);

	    if (!cvar ("registered")) {

		WriteByte (MSG_ALL, SVC_FINALE);
		WriteString (MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed, \nrealm of Earth Magic, you are ready to\ncomplete your task in...");

	    } else {

		WriteByte (MSG_ALL, SVC_FINALE);
		WriteString (MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed, \nrealm of Earth Magic, you are ready to\ncomplete your task. A...");

	    }
	    return;

	} else if (world.model == "maps/e2m6.bsp") {

	    WriteByte (MSG_ALL, SVC_CDTRACK);
	    WriteByte (MSG_ALL, 2);
	    WriteByte (MSG_ALL, 3);

	    WriteByte (MSG_ALL, SVC_FINALE);
	    WriteString (MSG_ALL, "The Rune of Black Magic throbs evilly in\nyour hand and whispers dark thoughts\ninto your brain. You learn the inmost\nlore of the Hell-Mother; Shub-Niggurath!\nYou now know that she is behind all the\nterrible plotting which has led to so\nmuch death...");
	    return;

	} else if (world.model == "maps/e3m6.bsp") {

	    WriteByte (MSG_ALL, SVC_CDTRACK);
	    WriteByte (MSG_ALL, 2);
	    WriteByte (MSG_ALL, 3);

	    WriteByte (MSG_ALL, SVC_FINALE);
	    WriteString (MSG_ALL, "The charred viscera of diabolic horrors\nbubble viscously as you seize the Rune\nof Hell Magic. Its heat scorches your\nhand, and its terrible secrets blight\nyour mind. Gathering the shreds of your\ncourage, you shake the devil's shackles\nfrom your ...");
	    return;

	} else if (world.model == "maps/e4m7.bsp") {

	    WriteByte (MSG_ALL, SVC_CDTRACK);
	    WriteByte (MSG_ALL, 2);
	    WriteByte (MSG_ALL, 3);
	    WriteByte (MSG_ALL, SVC_FINALE);
	    WriteString (MSG_ALL, "Despite the awful might of the Elder\nWorld, you have achieved the Rune of\nElder Magic, capstone of all types of\narcane wisdom. Beyond good and evil, \nbeyond life and death, the Rune\npulsates, heavy with import. Patient and\npotent, the Elder Being...");
	    return;
	}
	GotoNextMap ();
    }
    if (intermission_running == 3) {

	if (!cvar ("registered")) {
	    WriteByte (MSG_ALL, SVC_SELLSCREEN);
	    return;
	}
	if ((serverflags & 15) == 15) {
	    WriteByte (MSG_ALL, SVC_FINALE);
	    WriteString (MSG_ALL, "Now, you have all four Runes. You sense\ntremendous invisible forces moving to\nunseal ancient barriers. Shub-Niggurath\nhad hoped to use the Runes Herself to\nclear off the Earth, but now instead, \nyou will use them to enter her home and\nconfront he...");
	    return;
	}
    }
    dprint ("Exit Intermission.\n");
    GotoNextMap ();
};

void () IntermissionThink =
{
    local float minp;
    local float maxp;
    local float currp;
    local string sl;
    local string st;

    if (time < intermission_exittime)
	return;
    if ((!self.button0 && !self.button1) && !self.button2)
	return;

    dprint ("Intermission think.\n");
    GotoNextMap ();

    sl = infokey (world, "nmap");
    if (sl != string_null) {
	st = infokey (world, "minp");
	minp = stof (st);
	st = infokey (world, "maxp");
	maxp = stof (st);

	currp = TeamFortress_GetNoPlayers ();
	dprint ("MAP CYCLING: Player Counting... ");
	if ((currp >= minp) && (currp <= maxp)) {
	    dprint ("within range. Changing maps...\n");

	    st = infokey (world, "cd");
	    if (st == string_null)
		st = infokey (world, "cycledir");
	    if (st != string_null) {
		localcmd ("exec ");
		localcmd (st);
		localcmd ("/");
	    } else
		localcmd ("exec qwmcycle/");

	    localcmd (sl);
	    localcmd (".cfg\n");
	} else {
	    dprint ("outside range. Next map.\n");
	    already_chosen_map = 0;
	}
	localcmd ("localinfo minp \"\"\n");
	localcmd ("localinfo maxp \"\"\n");
	localcmd ("localinfo nmap \"\"\n");
    }
};

void () execute_changelevel =
{
    local entity pos;

    dprint ("execute_changelevel()\n");

    intermission_running = 1;
    intermission_exittime = time + 5;

    pos = FindIntermission ();

    WriteByte (MSG_ALL, SVC_CDTRACK);
    WriteByte (MSG_ALL, 3);

    WriteByte (MSG_ALL, SVC_INTERMISSION);
    WriteCoord (MSG_ALL, pos.origin_x);
    WriteCoord (MSG_ALL, pos.origin_y);
    WriteCoord (MSG_ALL, pos.origin_z);
    WriteAngle (MSG_ALL, pos.mangle_x);
    WriteAngle (MSG_ALL, pos.mangle_y);
    WriteAngle (MSG_ALL, pos.mangle_z);

    other = find (world, classname, "player");
    while (other != world) {
	other.takedamage = DAMAGE_NO;
	other.solid = SOLID_NOT;
	other.movetype = MOVETYPE_NONE;
	other.modelindex = 0;
	other = find (other, classname, "player");
    }
    if (!clan_scores_dumped) {
	DumpClanScores ();
	clan_scores_dumped = 1;
    }
};

void () changelevel_touch =
{
    if (other.classname != "player")
	return;

    if ((cvar ("samelevel") == 2) || ((cvar ("samelevel") == 3) && (mapname != "start")))
	return;

    bprint (PRINT_HIGH, other.netname, " exited the level\n");

    nextmap = self.map;
    SUB_UseTargets ();

    if ((self.spawnflags & 1) && (deathmatch == 0)) {
	GotoNextMap ();
	return;
    }
    self.touch = SUB_Null;
    self.think = execute_changelevel;
    self.nextthink = time + 0.1;
};

void () trigger_changelevel =
{
    if (CheckExistence () == 0) {
	dremove (self);
	return;
    }
    if (!self.map)
	objerror ("changelevel trigger doesn't have map");

    InitTrigger ();
    self.touch = changelevel_touch;
};

void () set_suicide_frame;

void () respawn =
{
    if (self.has_disconnected == 1)
		return;
    if (cease_fire)
		return;

    if (coop) {
		CopyToBodyQue (self);
		setspawnparms (self);
		PutClientInServer ();
    }
	else if (deathmatch) {
		CopyToBodyQue (self);
		SetNewParms ();
		PutClientInServer ();
    }
	else
		localcmd ("restart\n");
};

void () ClientKill =
{
    local entity te;

    if (self.has_disconnected == 1)
	return;
    if (self.suicide_time > time)
	return;
    if (self.deadflag)
	return;
    if (self.playerclass == PC_UNDEFINED)
	return;

    // players can't suicide again for 10 seconds
    self.suicide_time = time + 5 + random () * 5;

    bprint (PRINT_MEDIUM, self.netname, " suicides\n");

    set_suicide_frame ();
    self.modelindex = modelindex_player;

    // If infected, give the medic a frag
    if (self.tfstate & TFSTATE_INFECTED) {
	te = find (world, classname, "timer");
	while (te) {
	    if ((te.owner == self) && (te.think == BioInfection_Decay)) {
		logfrag (te, self);
		TF_AddFrags (te.enemy, 1);
	    }
	    te = find (te, classname, "timer");
	}
    } else
	logfrag (self, self);

    TF_AddFrags (self, -1);

    self.weaponmodel = "";
    self.view_ofs = '0 0 -8';
    self.movetype = MOVETYPE_NONE;

    TeamFortress_RemoveTimers ();
    TeamFortress_SetupRespawn (TRUE);

    self.health = -1;
    self.th_die ();
    self.deadflag = DEAD_RESPAWNABLE;
    self.tfstate = self.tfstate | TFSTATE_RESPAWN_READY;
    self.takedamage = 0;
};

entity lastspawn_team1;
entity lastspawn_team2;
entity lastspawn_team3;
entity lastspawn_team4;

entity (float team_num) FindTeamSpawnPoint =
{
    local entity spot;
    local entity at_spot;
    local float spot_found;
    local float attempts;

    if (team_num == 1) {
	spot = lastspawn_team1;
	attempts = 0;
	while (1) {
	    attempts = attempts + 1;

	    spot = find (spot, team_str_home, "ts1");
	    if (spot == world)
		spot = find (world, team_str_home, "ts1");
	    if (spot == world)
		return (world);

	    at_spot = findradius (spot.origin, 40);
	    spot_found = 1;
	    while (at_spot != world) {
		if ((at_spot.classname == "player") && (at_spot.deadflag == 0))
		    spot_found = 0;
		at_spot = at_spot.chain;
	    }
	    if (!Activated (spot, self))
		spot_found = 0;
	    if (spot_found || (attempts >= 30)) {
		lastspawn_team1 = spot;
		return (spot);
	    }
	}
    } else if (team_num == 2) {
	spot = lastspawn_team2;
	attempts = 0;
	while (1) {
	    attempts = attempts + 1;
	    spot = find (spot, team_str_home, "ts2");
	    if (spot == world)
		spot = find (world, team_str_home, "ts2");
	    if (spot == world)
		return (world);
	    at_spot = findradius (spot.origin, 40);
	    spot_found = 1;
	    while (at_spot != world) {
		if ((at_spot.classname == "player") && (at_spot.deadflag == 0))
		    spot_found = 0;
		at_spot = at_spot.chain;
	    }
	    if (!Activated (spot, self))
		spot_found = 0;
	    if (spot_found || (attempts >= 30)) {
		lastspawn_team2 = spot;
		return (spot);
	    }
	}
    } else if (team_num == 3) {
	spot = lastspawn_team3;
	attempts = 0;
	while (1) {
	    attempts = attempts + 1;
	    spot = find (spot, team_str_home, "ts3");
	    if (spot == world)
		spot = find (world, team_str_home, "ts3");
	    if (spot == world)
		return (world);
	    at_spot = findradius (spot.origin, 40);
	    spot_found = 1;
	    while (at_spot != world) {
		if ((at_spot.classname == "player") && (at_spot.deadflag == 0))
		    spot_found = 0;
		at_spot = at_spot.chain;
	    }
	    if (!Activated (spot, self))
		spot_found = 0;
	    if (spot_found || (attempts >= 30)) {
		lastspawn_team3 = spot;
		return (spot);
	    }
	}
    } else if (team_num == 4) {
	spot = lastspawn_team4;
	attempts = 0;
	while (1) {
	    attempts = attempts + 1;
	    spot = find (spot, team_str_home, "ts4");
	    if (spot == world)
		spot = find (world, team_str_home, "ts4");
	    if (spot == world)
		return (world);
	    at_spot = findradius (spot.origin, 40);
	    spot_found = 1;
	    while (at_spot != world) {
		if ((at_spot.classname == "player") && (at_spot.deadflag == 0))
		    spot_found = 0;
		at_spot = at_spot.chain;
	    }
	    if (!Activated (spot, self))
		spot_found = 0;
	    if (spot_found || (attempts >= 30)) {
		lastspawn_team4 = spot;
		return (spot);
	    }
	}
    }
    return (world);
};

void (entity e) ValidateUser = {};

entity () SelectSpawnPoint =
{
    local entity spot;
    local entity at_spot;
    local float spot_found;
    local float attempts;

    if (self.team_no != 0) {
	spot = FindTeamSpawnPoint (self.team_no);
	if (spot != world)
	    return (spot);
    }
    if (coop) {
	lastspawn = find (lastspawn, classname, "info_player_coop");
	if (lastspawn == world) {
	    lastspawn = find (world, classname, "info_player_coop");
	}
	if (lastspawn != world) {
	    return (lastspawn);
	}
    } else {
	if (deathmatch) {
	    spot = find (lastspawn, classname, "info_player_deathmatch");
	    if (spot == world) {
		spot = find (world, classname, "info_player_deathmatch");
	    }
	    attempts = 0;
	    while ((spot != world) && (attempts < 100)) {
		attempts = attempts + 1;
		at_spot = findradius (spot.origin, 40);
		spot_found = 1;
		while (at_spot) {
		    if ((at_spot.classname == "player") && (at_spot.deadflag == 0)) {
			spot_found = 0;
		    }
		    at_spot = at_spot.chain;
		}
		if (spot_found || (attempts >= 10)) {
		    lastspawn = spot;
		    return (spot);
		}
		spot = find (spot, classname, "info_player_deathmatch");
		if (spot == world) {
		    spot = find (world, classname, "info_player_deathmatch");
		}
	    }
	}
    }
    if (serverflags) {
	spot = find (world, classname, "info_player_start2");
	if (spot) {
	    return (spot);
	}
    }
    spot = find (world, classname, "info_player_start");
    if (!spot) {
	error ("PutClientInServer: no info_player_start on level\n");
    }
    return (spot);
};

void () PlayerDie;
void () TeamFortress_SetHealth;
void () TeamFortress_SetEquipment;
void () player_touch;

void () PutClientInServer =
{
    local float iszoom;
    local float oldclass;
    local entity spot;
    local entity te;
	
	
	server_status = infokey (world, "status2");

    self.touch = player_touch;
    self.classname = "player";
    self.health = 100;
    self.solid = SOLID_SLIDEBOX;
    self.movetype = MOVETYPE_WALK;

    self.show_hostile = 0;
    self.FlashTime = 0;
    self.max_health = 100;
    self.flags = FL_CLIENT;

    self.air_finished = time + 12;
    self.dmg = 2;
    self.super_damage_finished = 0;
    self.radsuit_finished = 0;
    self.invisible_finished = 0;
    self.invincible_finished = 0;
    self.effects = 0;
    self.invincible_time = 0;

    self.reload_shotgun = 0;
    self.reload_super_shotgun = 0;
    self.reload_grenade_launcher = 0;
    self.reload_rocket_launcher = 0;

    self.immune_to_check = time + 10;
    self.on_hook = 0;
    self.hook_out = 0;
    self.fire_held_down = 0;

    DecodeLevelParms ();

    if (self.playerclass == 0) {
	if (TeamFortress_TeamIsCivilian (self.team_no)) {
	    self.impulse = 1;
	    TeamFortress_ChangeClass ();
	}
    }
    if ((deathmatch == 3) && (self.nextpc != 0)) {
	self.playerclass = self.nextpc;
	self.nextpc = 0;
	if (self.playerclass == PC_RANDOM)
	    self.tfstate = self.tfstate | TFSTATE_RANDOMPC;
	else {
	    self.tfstate = self.tfstate - (self.tfstate & TFSTATE_RANDOMPC);
	    TeamFortress_ExecClassScript (self);
	}
    }
    iszoom = 0;
    if (self.tfstate & TFSTATE_ZOOMOFF)
	iszoom = 1;

    if (self.tfstate & TFSTATE_RANDOMPC) {
	oldclass = self.playerclass;
	self.playerclass = 1 + floor (random () * (10 - 1));
	while (!IsLegalClass (self.playerclass) || (self.playerclass == oldclass)
	       || ClassIsRestricted (self.team_no, self.playerclass)) {
	    self.playerclass = 1 + floor (random () * (10 - 1));
	}
	self.tfstate = TFSTATE_RANDOMPC;
	TeamFortress_ExecClassScript (self);
    } else
	self.tfstate = 0;

    if (iszoom == 1)
	self.tfstate = self.tfstate | TFSTATE_ZOOMOFF;

    if (self.playerclass != PC_ENGINEER)
	Engineer_RemoveBuildings (self);

    self.takedamage = 2;

    if (hideconsoletext == 0) TeamFortress_PrintClassName (self, self.playerclass, self.tfstate & TFSTATE_RANDOMPC);
    TeamFortress_SetEquipment ();
    TeamFortress_SetHealth ();
    TeamFortress_SetSpeed (self);
    TeamFortress_SetSkin (self);

    stuffcmd (self, "v_idlescale 0\nfov 90\n");
    stuffcmd (self, "v_cshift; wait; bf\n");
    SetTeamName (self);
    W_SetCurrentAmmo ();

    self.attack_finished = time + 0.3;
    self.th_pain = player_pain;
    self.th_die = PlayerDie;
    self.height = 0;

    TF_zoom (90);

    self.deadflag = 0;
    self.pausetime = 0;

    spot = SelectSpawnPoint ();
    if (self.playerclass != 0)
	spawn_tdeath (spot.origin, self);

    self.observer_list = spot;
    self.origin = spot.origin + '0 0 1';
    self.angles = spot.angles;
    self.fixangle = 1;

	if ((spot.classname == "info_player_teamspawn") && (server_status == "Match")) {
	if (spot.items != 0) {
	    te = Finditem (spot.items);
	    if (te)
		tfgoalitem_GiveToPlayer (te, self, self);
	    if (!(spot.goal_activation & TFGA_TOUCH))
		spot.items = 0;
	}
	if (spot.message) {
	    CenterPrint (self, spot.message);
	    if (!(spot.goal_activation & 2))
		spot.message = string_null;
	}
	if (spot.activate_goal_no != 0) {
	    te = Findgoal (spot.activate_goal_no);
	    if (te)
		AttemptToActivate (te, self, spot);
	}
	if (spot.goal_effects == 1) {
	    spot.classname = "deadpoint";
	    spot.team_str_home = string_null;
	    spot.nextthink = time + 1;
	    spot.think = SUB_Remove;
	}
    }
    setmodel (self, string_null);
    modelindex_null = self.modelindex;

    setmodel (self, "progs/eyes.mdl");
    modelindex_eyes = self.modelindex;

    setmodel (self, "progs/player.mdl");
    modelindex_player = self.modelindex;

    if (self.playerclass == 0) {
	self.modelindex = modelindex_null;
	self.current_menu = MENU_DEFAULT;
    }
    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
    self.view_ofs = '0 0 22';
    self.velocity = '0 0 0';
    player_stand1 ();

    if (deathmatch || coop) {
	makevectors (self.angles);
	if (self.playerclass != 0)
	    spawn_tfog (self.origin + v_forward * 20);
    }

    if (stof (infokey (world, "rj")) != 0)
	rj = stof (infokey (world, "rj"));
    else
	rj = 1;

    if (cease_fire) {
		sprint (self, PRINT_HIGH, "\n\nCEASE FIRE MODE\n");
		self.immune_to_check = time + 10;
		self.tfstate = self.tfstate | TFSTATE_CANT_MOVE;
		TeamFortress_SetSpeed (self);
    }
};

void () info_player_start =
{
    if (CheckExistence () == FALSE) {
	dremove (self);
	return;
    }
};

void () info_player_start2 =
{
    if (CheckExistence () == FALSE) {
	dremove (self);
	return;
    }
};

void () testplayerstart =
{
    if (CheckExistence () == FALSE) {
	dremove (self);
	return;
    }
};

void () info_player_deathmatch =
{
    if (CheckExistence () == FALSE) {
	dremove (self);
	return;
    }
};

void () info_player_coop =
{
    if (CheckExistence () == FALSE) {
	dremove (self);
	return;
    }
};

void (entity c) PrintClientScore =
{
    if ((c.frags > -10) && (c.frags < 0))
	bprint (PRINT_MEDIUM, " ");
    else if (c.frags >= 0) {
	if (c.frags < 100)
            bprint (PRINT_MEDIUM, " ");
	if (c.frags < 10)
            bprint (PRINT_MEDIUM, " ");
    }
    bprint (PRINT_MEDIUM, ftos (c.frags), " ", c.netname, "\n");
};

void () DumpScore =
{
    local entity e;
    local entity sort;
    local entity walk;

    if (world.chain) {
	error ("DumpScore: world.chain is set");
    }
    e = find (world, classname, "player");
    sort = world;
    while (e) {
	if (!sort) {
	    sort = e;
	    e.chain = world;
	} else if (e.frags > sort.frags) {
	    e.chain = sort;
	    sort = e;
	} else {
	    walk = sort;
	    do {
		if (!walk.chain) {
		    e.chain = world;
		    walk.chain = e;
		} else if (walk.chain.frags < e.frags) {
		    e.chain = walk.chain;
		    walk.chain = e;
		} else
		    walk = walk.chain;
	    } while (walk.chain != e);
	}
	e = find (e, classname, "player");
    }
    bprint (PRINT_MEDIUM, "\n");
    while (sort) {
	PrintClientScore (sort);
	sort = sort.chain;
    }
    bprint (PRINT_MEDIUM, "\n");
};

float already_cycled;

void () NextLevel =
{
    local entity o;

    if (already_cycled)
	return;

    already_cycled = 1;
    o = spawn ();
    o.map = nextmap;
    o.think = execute_changelevel;
    o.nextthink = time + 0.1;
};

void () CheckRules =
{
/*
Well, with new /ready command, players can take as much time as they want before the Match starts. However, "time" will always keep increasing.
We don't want the timer in timelimit to start until the match has started.
Also, this function is executed every 0.1 seconds.
*/
	local string clan_battle;
	local string minutes;
	local float time_remaining;
	local float minutes_round;
	local string bracket_open;
		
	time_remaining = rint (timelimit - (time - (countdown_start_time + prematch_countdown) ));
	bracket_open = "\[";
	
	clan_battle = infokey (world, "c");
	if (clan_battle == string_null) // maybe they are using "serverinfo clan" instead of "serverinfo c"
		clan_battle = infokey (world, "clan");
	
	if (clan_battle == "on") {
		
		server_status = infokey (world, "status2");
		
		if ((server_status == "Match") && (anti_spam_timer_reminder < time) && timelimit) {
			if (time_remaining > 121) {
				if ( (time_remaining / 60) > (rint (time_remaining / 60) ) ) {
					anti_spam_timer_reminder = time + (time_remaining - ( ( rint(time_remaining / 60) ) * 60 ) );
				}
				else {
					anti_spam_timer_reminder = time + 59;
					minutes_round = rint (time_remaining / 60); // or else we would get " x.0 minutes.." after the first iteration
					minutes = ftos (minutes_round);
					
					bprint2 (PRINT_HIGH, bracket_open, "");
					bprint2 (PRINT_HIGH, minutes, "\] minutes remaining\n");
					
					localcmd("serverinfo status \"");
					localcmd(minutes);
					localcmd(" min left");
					localcmd("\"\n");
				}
			}
			if (time_remaining == 120) {
				anti_spam_timer_reminder = time + 59;
				bprint (PRINT_HIGH, "\[2\] minutes remaining\n");
				
				localcmd("serverinfo status \"");
				localcmd("2 min left");
				localcmd("\"\n");
				
			}
			if (time_remaining == 60) {
				anti_spam_timer_reminder = time + 29;
				bprint (PRINT_HIGH, "\[1\] minute remaining\n");
				
				localcmd("serverinfo status \"");
				localcmd("1 min left");
				localcmd("\"\n");
			}
			if (time_remaining == 30) {
				anti_spam_timer_reminder = time + 19;
				bprint (PRINT_HIGH, "\[30\] seconds remaining\n");
			}
			if (time_remaining == 10) {
				anti_spam_timer_reminder = time + 5;
				bprint (PRINT_HIGH, "\[10\] seconds remaining\n");
			}
		}
		
		if (timelimit && ( (time - (countdown_start_time + prematch_countdown) ) >= timelimit) )
			NextLevel ();
		else if (fraglimit && (self.frags >= fraglimit))
			NextLevel ();
	}
	else { // not a team game
		if (timelimit && (time >= timelimit))
			NextLevel ();
		else if (fraglimit && (self.frags >= fraglimit))
			NextLevel ();
	}
};

void () PlayerDeathThink =
{
    local float forward;

    if (self.flags & FL_ONGROUND) {
	forward = vlen (self.velocity);
	forward = forward - 20;
	if (forward <= 0)
	    self.velocity = '0 0 0';
	else
	    self.velocity = forward * normalize (self.velocity);
    }
    if (self.deadflag == DEAD_DEAD) {
	if (self.button2 || self.button1 || self.button0)
	    return;
	self.deadflag = DEAD_RESPAWNABLE;
	self.tfstate = self.tfstate - (self.tfstate & TFSTATE_RESPAWN_READY);
	return;
    }
    if ((!self.button2 && !self.button1) && !self.button0) {
	if (self.tfstate & TFSTATE_RESPAWN_READY) {
	    if (self.respawn_time <= time) {
		self.button0 = 0;
		self.button1 = 0;
		self.button2 = 0;
		respawn ();
	    }
	}
	return;
    } else {
	self.tfstate = self.tfstate | TFSTATE_RESPAWN_READY;
	if (self.respawn_time <= time) {
	    self.button0 = 0;
	    self.button1 = 0;
	    self.button2 = 0;
	    respawn ();
	}
	return;
    }
};

void () PlayerJump =
{
    local entity te;
    local float stumble;

    if (self.has_disconnected == 1)
	return;
    if (self.flags & FL_WATERJUMP)
	return;

    if (self.waterlevel >= 2) {
	if (self.watertype == -3)
	    self.velocity_z = 100;
	else if (self.watertype == -4)
	    self.velocity_z = 80;
	else
	    self.velocity_z = 50;

	if (self.swim_flag < time) {
	    self.swim_flag = time + 1;
	    if (random () < 0.5)
		sound (self, CHAN_BODY, "misc/water1.wav", 1, ATTN_NORM);
	    else
		sound (self, CHAN_BODY, "misc/water2.wav", 1, ATTN_NORM);
	}
	if (self.fire_held_down && (self.current_weapon == WEAP_ASSAULT_CANNON)) {
	    stuffcmd (self, "v_idlescale 0\n");
	    self.tfstate = self.tfstate | TFSTATE_AIMING;
	    TeamFortress_SetSpeed (self);
	    self.tfstate = self.tfstate - (self.tfstate & TFSTATE_CANT_MOVE);
	    TeamFortress_SetSpeed (self);
	    self.weaponframe = 0;
	    self.heat = 0;
	    self.count = 1;
	    player_assaultcannondown1 ();
	}
	return;
    }
    if (!(self.flags & FL_ONGROUND))
	return;
    if (!(self.flags & FL_JUMPRELEASED))
	return;

    self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
    self.button2 = 0;

    sound (self, CHAN_BODY, "player/plyrjmp8.wav", 1, ATTN_NORM);

    if (self.fire_held_down && (self.current_weapon == WEAP_ASSAULT_CANNON)) {
	stuffcmd (self, "v_idlescale 0\n");
	sprint (self, PRINT_MEDIUM, "You cannot fire the assault cannon without your feet on the ground...\n");
	self.tfstate = self.tfstate | TFSTATE_AIMING;
	TeamFortress_SetSpeed (self);
	self.tfstate = self.tfstate - (self.tfstate & TFSTATE_CANT_MOVE);
	TeamFortress_SetSpeed (self);
	self.weaponframe = 0;
	self.count = 1;
	self.heat = 0;
	player_assaultcannondown1 ();
    }
    if (old_grens != 1) {
	te = find (world, classname, "timer");
	while (((te.owner != self) || (te.think != ConcussionGrenadeTimer)) && (te != world))
	    te = find (te, classname, "timer");

	if ((te != world) && (te != self)) {
	    crandom ();
	    stumble = crandom () * (te.health / 100);
	    if (crandom () < 0) {
		self.velocity_x = self.velocity_y + stumble;
		self.velocity_y = self.velocity_x + stumble;
	    } else {
		self.velocity_x = (-1 * self.velocity_y) + stumble;
		self.velocity_y = (-1 * self.velocity_x) + stumble;
	    }
	}
    }
};

.float dmgtime;

void () WaterMove =
{
    if (self.movetype == MOVETYPE_NOCLIP)
	return;
    if (self.health < 0)
	return;

    if (self.waterlevel != 3) {
	if (self.air_finished < time) {
	    sound (self, 2, "player/gasp2.wav", 1, 1);
	} else if (self.air_finished < (time + 9)) {
	    sound (self, 2, "player/gasp1.wav", 1, 1);
	}
	self.air_finished = time + 12;
	self.dmg = 2;
    } else if (self.air_finished < time) {
	if (self.pain_finished < time) {
	    self.dmg = self.dmg + 2;
	    if (self.dmg > 15)
		self.dmg = 10;
	    TF_T_Damage (self, world, world, self.dmg, 1, 0);
	    self.pain_finished = time + 1;
	}
    }
    if (!self.waterlevel) {
	if (self.flags & 16) {
	    sound (self, 4, "misc/outwater.wav", 1, 1);
	    self.flags = self.flags - 16;
	}
	return;
    }
    if (self.watertype == -5) {
	if (self.dmgtime < time) {
	    if (self.radsuit_finished > time)
		self.dmgtime = time + 1;
	    else
		self.dmgtime = time + 0.2;
	    TF_T_Damage (self, world, world, (10 * self.waterlevel), 0, 16);
	}
    } else if (self.watertype == -4) {
	if ((self.dmgtime < time) && (self.radsuit_finished < time)) {
	    self.dmgtime = time + 1;
	    T_Damage (self, world, world, (4 * self.waterlevel));
	}
    }
    if (!(self.flags & 16)) {
	if (self.watertype == -5) {
	    sound (self, 4, "player/inlava.wav", 1, 1);
	}
	if (self.watertype == -3) {
	    sound (self, 4, "player/inh2o.wav", 1, 1);
	}
	if (self.watertype == -4) {
	    sound (self, 4, "player/slimbrn2.wav", 1, 1);
	}
	self.flags = self.flags + 16;
	self.dmgtime = 0;
    }
};

void () CheckWaterJump =
{
    local vector start;
    local vector end;

    makevectors (self.angles);
    start = self.origin;
    start_z = start_z + 8;
    v_forward_z = 0;
    normalize (v_forward);
    end = start + v_forward * 24;

    traceline (start, end, 1, self);
    if (trace_fraction < 1) {
	start_z = start_z + self.maxs_z - 8;
	end = start + v_forward * 24;
	self.movedir = trace_plane_normal * -50;

	traceline (start, end, 1, self);
	if (trace_fraction == 1) {
	    self.flags = self.flags | FL_WATERJUMP;
	    self.velocity_z = 225;
	    self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
	    self.teleport_time = time + 2;
	    return;
	}
    }
};

void () PlayerPreThink =
{
    if (self.is_feigning && (self.waterlevel == 1)) {
	self.watertype = -3;
	self.waterlevel = 3;
    }
    if (self.cheat_level > 0) {
	self.cheat_level = self.cheat_level - 1;
    }
    if (intermission_running) {
	IntermissionThink ();
	return;
    }
    makevectors (self.v_angle);
    if (self.playerclass == 0) {
	if ((self.button2 && (self.current_menu == 2)) && (self.team_no == 0)) {
	    if (TeamFortress_TeamPutPlayerInTeam ()) {
		self.current_menu = 3;
		self.menu_count = 25;
	    }
	}
    }
    if (self.view_ofs == '0 0 0') {
	return;
    }
    CheckRules ();
    if (self.playerclass != 0) {
	WaterMove ();
    }
    if (self.deadflag >= 2) {
	PlayerDeathThink ();
	return;
    }
    if ((self.undercover_team || self.undercover_skin) || self.is_undercover) {
	if (self.effects & (8 | 4)) {
	    sprint (self, PRINT_MEDIUM, "The glowing removes your disguise.\n");
	    Spy_RemoveDisguise (self);
	}
    }
    if (self.deadflag == 1) {
	return;
    }
    if (!self.is_feigning) {
	if (self.button2) {
	    PlayerJump ();
	} else {
	    self.flags = self.flags | 4096;
	}
    } else if (self.waterlevel) {
	self.velocity_z = -100;
    }
    if ((time < self.pausetime) || (cease_fire == 1)) {
		self.velocity = '0 0 0';
    }
    if (((time > self.attack_finished) && (self.currentammo == 0)) && (self.weapon > 16)) {
	self.weapon = W_BestWeapon ();
	W_SetCurrentAmmo ();
    }
    if (self.on_hook) {
	Service_Grapple ();
    }
};

void () CheckPowerups =
{
    local float lighton;
    local entity te;

    if (self.health <= 0) {
	return;
    }
    if (self.playerclass == 0) {
	self.modelindex = modelindex_null;
    } else {
	if ((self.is_undercover == 1) && (invis_only == 1)) {
	    self.frame = 0;
	    self.modelindex = modelindex_eyes;
	} else {
	    if (self.invisible_finished) {
		if (self.tfstate & 64) {
		    if (self.invisible_finished < (time + 10)) {
			self.invisible_finished = time + 666;
		    }
		}
		if (self.invisible_sound < time) {
		    sound (self, 0, "items/inv3.wav", 0.5, 2);
		    self.invisible_sound = time + ((random () * 3) + 1);
		}
		if (self.invisible_finished < (time + 3)) {
		    if (self.invisible_time == 1) {
			sprint (self, PRINT_HIGH, "Ring of Shadows magic is fading\n");
			stuffcmd (self, "bf\n");
			sound (self, 0, "items/inv2.wav", 1, 1);
			self.invisible_time = time + 1;
		    }
		    if (self.invisible_time < time) {
			self.invisible_time = time + 1;
			stuffcmd (self, "bf\n");
		    }
		}
		if (self.invisible_finished < time) {
		    self.items = self.items - 524288;
		    self.invisible_finished = 0;
		    self.invisible_time = 0;
		}
		self.frame = 0;
		self.modelindex = modelindex_eyes;
	    } else {
		self.modelindex = modelindex_player;
	    }
	}
    }
    if (self.invincible_finished) {
	if (self.tfstate & 32) {
	    if (self.invincible_finished < (time + 10)) {
		self.invincible_finished = time + 666;
	    }
	}
	if (self.invincible_finished < (time + 3)) {
	    if (self.invincible_time == 1) {
		sprint (self, PRINT_HIGH, "Protection is almost burned out\n");
		stuffcmd (self, "bf\n");
		sound (self, 0, "items/protect2.wav", 1, 1);
		self.invincible_time = time + 1;
	    }
	    if (self.invincible_time < time) {
		self.invincible_time = time + 1;
		stuffcmd (self, "bf\n");
	    }
	}
	if (self.invincible_finished < time) {
	    self.items = self.items - 1048576;
	    self.invincible_time = 0;
	    self.invincible_finished = 0;
	}
	if (self.invincible_finished > time) {
	    self.effects = self.effects | 8;
	    self.effects = self.effects | 128;
	} else {
	    lighton = 0;
	    te = find (world, classname, "item_tfgoal");
	    while (te) {
		if (te.owner == self) {
		    if (te.goal_activation & 1) {
			lighton = 1;
		    }
		}
		te = find (te, classname, "item_tfgoal");
	    }
	    if (!lighton) {
		self.effects = self.effects - (self.effects & 8);
		self.effects = self.effects - (self.effects & 128);
	    }
	}
    }
    if (self.super_damage_finished) {
	if (self.tfstate & 128) {
	    if (self.super_damage_finished == (time + 10)) {
		self.super_damage_finished = time + 666;
	    }
	}
	if (self.super_damage_finished < (time + 3)) {
	    if (self.super_time == 1) {
		sprint (self, PRINT_HIGH, "Quad Damage is wearing off\n");
		stuffcmd (self, "bf\n");
		sound (self, 0, "items/damage2.wav", 1, ATTN_NORM);
		self.super_time = time + 1;
	    }
	    if (self.super_time < time) {
		self.super_time = time + 1;
		stuffcmd (self, "bf\n");
	    }
	}
	if (self.super_damage_finished < time) {
	    self.items = self.items - 4194304;
	    self.super_damage_finished = 0;
	    self.super_time = 0;
	}
	if (self.super_damage_finished > time) {
	    self.effects = self.effects | 8;
	    self.effects = self.effects | 64;
	} else {
	    lighton = 0;
	    te = find (world, classname, "item_tfgoal");
	    while (te) {
		if (te.owner == self) {
		    if (te.goal_activation & TFGA_TOUCH)
			lighton = 1;
		}
		te = find (te, classname, "item_tfgoal");
	    }
	    if (!lighton) {
		self.effects = self.effects - (self.effects & 8);
		self.effects = self.effects - (self.effects & 64);
	    }
	}
    }
    if (self.radsuit_finished) {
	self.air_finished = time + 12;
	if (self.tfstate & 256) {
	    if (self.radsuit_finished == (time + 10)) {
		self.radsuit_finished = time + 666;
	    }
	}
	if (self.radsuit_finished < (time + 3)) {
	    if (self.rad_time == 1) {
		sprint (self, PRINT_HIGH, "Air supply in Biosuit expiring\n");
		stuffcmd (self, "bf\n");
		sound (self, 0, "items/suit2.wav", 1, 1);
		self.rad_time = time + 1;
	    }
	    if (self.rad_time < time) {
		self.rad_time = time + 1;
		stuffcmd (self, "bf\n");
	    }
	}
	if (self.radsuit_finished < time) {
	    self.items = self.items - 2097152;
	    self.rad_time = 0;
	    self.radsuit_finished = 0;
	}
    }
};

void () PlayerPostThink =
{
    local float fdmg;

    if (self.view_ofs == '0 0 0') {
	return;
    }
    if (self.deadflag) {
	DeadImpulses ();
	self.impulse = 0;
	return;
    }
    if (((self.jump_flag < -300) && (self.flags & 512)) && (self.health > 0)) {
	if (self.watertype == -3) {
	    sound (self, 4, "player/h2ojump.wav", 1, ATTN_NORM);
	} else {
	    if (self.jump_flag < -650) {
		fdmg = 5;
		fdmg = (fdmg * (self.jump_flag / 300)) * -1;
		if (self.playerclass == 1) {
		    fdmg = fdmg / 2;
		} else {
		    if (self.playerclass == 6) {
			fdmg = fdmg * 1.5;
		    }
		}
		fdmg = rint (fdmg);
		TF_T_Damage (self, world, world, fdmg, 1, 0);
		sound (self, 2, "player/land2.wav", 1, ATTN_NORM);
		self.deathtype = "falling";
	    } else {
		sound (self, 2, "player/land.wav", 1, ATTN_NORM);
	    }
	}
    }
    self.jump_flag = self.velocity_z;
    CheckPowerups ();
    W_WeaponFrame ();
    if (self.motd <= 95) {
	TeamFortress_MOTD ();
    } else {
	if (self.cheat_check == 0) {
	    self.cheat_check = time + 5;
	} else {
	    if ((time > self.StatusRefreshTime) && (self.StatusBarSize != 0)) {
		RefreshStatusBar (self);
	    }
	}
    }
    if (self.cheat_check <= time) {
	TeamFortress_CheckTeamCheats ();
	self.cheat_check = time + 3;
    }
};

void () ClientConnect =
{
    local entity te;
    local string st2;
    local float got_one;
	
	
	server_status = infokey (world, "status");

    bprint (PRINT_HIGH, self.netname, " entered the game\n");

    self.motd = 0;
    self.got_aliases = 0;

    if (self.netname == string_null)
		KickCheater (self);

    TeamFortress_Alias ("id", TF_ID, 0);

    local string st;
	local string status_bar_size;
	local string status_bar_res;	
	
    status_bar_res = infokey (self, "sbr");
    if (status_bar_res == string_null)
		status_bar_res = infokey (self, "sbar_res");

    if (status_bar_res == "768")
		self.StatusBarRes = 8;
    else if (status_bar_res == "600")
		self.StatusBarRes = 7;
    else if (status_bar_res == "480")
		self.StatusBarRes = 6;
    else if (status_bar_res == "400")
		self.StatusBarRes = 5;
    else if (status_bar_res == "384")
		self.StatusBarRes = 4;
    else if (status_bar_res == "350")
		self.StatusBarRes = 3;
    else if (status_bar_res == "300")
		self.StatusBarRes = 2;
    else if (status_bar_res == "240")
		self.StatusBarRes = 1;
    else
		self.StatusBarRes = 0;

    status_bar_size = infokey (self, "sbs");
    if (status_bar_size == string_null)
		status_bar_size = infokey (self, "sbar_size");

    self.StatusBarSize = stof (status_bar_size);
    if ((self.StatusBarSize > 2) || (self.StatusBarSize < 0))
		self.StatusBarSize = 0;
		
	if ( (status_bar_res != string_null) && (status_bar_size != string_null) ) {
		is_sbar_on = "1";
	}

    TeamFortress_ExecMapScript (self);
    self.has_disconnected = 0;

    if (intermission_running)
		GotoNextMap ();

    st2 = infokey (world, "apw");
    if (st2 == string_null)
		st2 = infokey (world, "adminpwd");

    st = infokey (self, "apw");
    if (st == string_null)
		st = infokey (self, "adminpwd");

    if ((st2 != string_null) && (st != string_null) && (st == st2)) {
		self.is_admin = TRUE;
		stuffcmd (self, "setinfo apw \"");
		stuffcmd (self, "\"\n");
		stuffcmd (self, "setinfo adminpwd \"");
		stuffcmd (self, "\"\n");
		TeamFortress_Alias ("countplayers", 192, 0);
		TeamFortress_Alias ("deal", 189, 0);
		TeamFortress_Alias ("kick", 190, 0);
		TeamFortress_Alias ("ban", 191, 0);
		TeamFortress_Alias ("next", 195, 0);
		TeamFortress_Alias ("ceasefire", 193, 0);
		TeamFortress_Alias ("listips", 198, 0);
    }
	else
		self.is_admin = FALSE;

    if (clanbattle && (self.has_disconnected != 1)) {
		got_one = 0;
		st = infokey (self, "tf_id");
		self.tf_id = stof (st);
		if ((st != string_null) && (self.tf_id != 0)) {
			sprint (self, PRINT_HIGH, "Welcome back!\n");
			te = find (world, classname, "ghost");
			while (te) {
				if (te.tf_id == self.tf_id) {
					got_one = 1;
					TeamFortress_TeamSet (te.team_no, 0);
					self.frags = te.frags;
					self.real_frags = te.real_frags;
					if (!(toggleflags & TFLAG_TEAMFRAGS) && !(toggleflags & TFLAG_FULLTEAMSCORE)) {
					self.frags = self.real_frags;
					}
					self.playerclass = te.playerclass;
					self.tfstate = te.tfstate;
					dremove (te);
					te = world;
				}
				else
					te = find (te, classname, "ghost");
			}
		}
		server_status = infokey (world, "status2");
		if (!got_one) {
			if (game_locked && (server_status == "Match")) {
				sprint (self, PRINT_HIGH, "Closed Server. Clan Battle in progress.\n");
				KickCheater (self);
				return;
			}
			last_id = last_id + 20 + random () * 10;
			self.tf_id = rint (random () * 10 + last_id);
			st = ftos (self.tf_id);
			stuffcmd (self, "setinfo tf_id ");
			stuffcmd (self, st);
			stuffcmd (self, "\n");
			sprint (self, PRINT_HIGH, "Your Battle ID is ", st, "\n");
		}
    }
	server_status = infokey (world, "status");
    if ((server_status == "Prematch") || (server_status == "Countdown"))
		sprint (self, PRINT_HIGH, "CURRENTLY IN PREMATCH TIME\n");
};

void () ClientDisconnect =
{
    local entity te;
    local string st;
    local float fr;
    local float i;
    local float rpickup_voter;
    local float total_players;
    local float rpickup_votes_needed;
	
	
	server_status = infokey (world, "status");
    
    fr = rint (self.frags);
    st = ftos (fr);
    bprint4 (PRINT_HIGH, self.netname, " left the game with ", st, " frags\n");
    sound (self, 4, "player/tornoff2.wav", 1, ATTN_NONE);
    self.has_disconnected = 1;
    TeamFortress_RemoveTimers ();
    Engineer_RemoveBuildings (self);
    te = find (world, classname, "detpack");
    while (te) {
		if (te.owner == self) {
			if (te.weaponmode == 1) {
				TeamFortress_SetSpeed (te.enemy);
				dremove (te.oldenemy);
				dremove (te.observer_list);
			}
			dremove (te);
			te = world;
		}
		te = find (te, classname, "detpack");
    }
    if (clanbattle && (self.tf_id != 0)) {
		te = spawn ();
		te.classname = "ghost";
		te.tf_id = self.tf_id;
		te.team_no = self.team_no;
		te.frags = self.frags;
		te.real_frags = self.real_frags;
		te.netname = self.netname;
		te.playerclass = self.playerclass;
		if (self.tfstate & 8) {
			te.tfstate = 8;
		}
    }
    set_suicide_frame ();
    self.netname = string_null;
    self.team_no = -1;
    self.solid = 0;
    setsize (self, '0 0 0', '0 0 0');
    
	if ((server_status == "Prematch") || (server_status == "Countdown")) { // Prohibit rpickup use after pm
		rpickup_voter = 0;
		for (i = 0; i < rpickup_votes; i++) {
			if (arr_rpickup_voters[i] == self.tf_id) {
				rpickup_votes--;
				arr_rpickup_voters[i] = -1;
				rpickup_voter = 1;
			}
		}
	
    
		total_players = 0;
		if (rpickup_voter != 1) {
			for (i = 0; i <= number_of_teams; i++) {
				total_players += TeamFortress_TeamGetNoPlayers (i);
			}
    
			// Calculate how many votes are needed for a majority
			rpickup_votes_needed = floor (total_players / 2) + 1;
			
			if (rpickup_votes >= rpickup_votes_needed) {
				TeamFortress_RandomTheTeams ();
			}
		}
	}
};

void (entity targ, entity attacker) ClientObituary =
{
    local float rnum;
    local string deathstring;
    local string deathstring2;

    rnum = random ();
	
	server_status = infokey (world, "status");
    //if ((cb_prematch_time + 3) > time)
	if ((server_status == "Prematch") || (server_status == "Countdown"))
		return;

    if (targ.classname == "player") {
	if (attacker.classname == "teledeath") {
	    bprint (PRINT_MEDIUM, targ.netname, " was telefragged by ", attacker.owner.netname, "\n");

	    if ((attacker.owner.team_no != targ.team_no) || (attacker.owner.team_no < 1))
		TF_AddFrags (attacker.owner, 1);

	    return;
	}
	if (attacker.classname == "teledeath2") {
	    bprint (PRINT_MEDIUM, "Satan's power deflects ", targ.netname, "'s telefrag\n");
	    TF_AddFrags (targ, -1);
	    logfrag (targ, targ);
	    return;
	}
	if (deathmsg == 37) {
	    bprint (PRINT_MEDIUM, targ.netname, " shoots his teammate one too many times.\n");
	    return;
	}
	if ((attacker.classname == "info_tfgoal") || (attacker.classname == "item_tfgoal")) {
	    if (attacker.deathtype != "") {
		bprint (PRINT_MEDIUM, targ.netname, attacker.deathtype);
	    }
	    logfrag (targ, targ);
	    return;
	}
	if ((attacker.classname == "player") || (attacker.classname == "bot")) {
	    if (targ == attacker) {
		// killed self
		TF_AddFrags (attacker, -1);

		if ((birthday == 1) && (random () < 0.3)) {
		    if (random () < 0.1) {
			bprint (PRINT_MEDIUM, "It's ", targ.netname,
				"'s party and he'll cry if he wants to!\n");
			return;
		    }

		    bprint (PRINT_MEDIUM, targ.netname);
		    if (random () < 0.5)
			bprint (PRINT_MEDIUM, " gets too selfish with his gifts\n");
		    else
			bprint (PRINT_MEDIUM, " wasn't born so beautiful after all\n");
		    return;
		}

		bprint (PRINT_MEDIUM, targ.netname);

		if (deathmsg == DMSG_GREN_HAND) {
		    if (targ.playerclass == PC_SNIPER)
			deathstring = " got splattered by his own grenade\n";
		    else if (targ.playerclass == PC_SOLDIER)
		        deathstring = " sat on his own grenade\n";
		    else if (targ.playerclass == PC_DEMOMAN)
			deathstring = " got to know his grenade too well\n";
		    else if (targ.playerclass == PC_MEDIC)
			deathstring = " caught the end of his own grenade\n";
		    else if (targ.playerclass == PC_HVYWEAP)
			deathstring = " got too close to his own grenade\n";
		    else if (targ.playerclass == PC_PYRO)
			deathstring = " let his own grenade get the best of him\n";
		    else if (targ.playerclass == PC_SPY)
			deathstring = " tiptoed over his own grenade\n";
		    else if (targ.playerclass == PC_ENGINEER)
			deathstring = " stared at his grenade too long\n";
		    else
		        deathstring = " grenades himself\n";
		} else if (deathmsg == DMSG_GREN_NAIL)
		    deathstring = " hammers himself\n";
		else if (deathmsg == DMSG_GREN_MIRV) {
		    if (targ.playerclass == PC_DEMOMAN)
			deathstring = " practiced his own Mirv dance\n";
		    else if (targ.playerclass == PC_HVYWEAP)
			deathstring = " allowed his Mirv to turn against him\n";
		    else
		        deathstring = " goes to pieces\n";
		} else if (deathmsg == DMSG_GREN_PIPE)
		    deathstring = " ambushes himself with his own pipebombs\n";
		else if (deathmsg == 40)
		    deathstring = " tried to juggle his own pipebombs\n";
		else if (deathmsg == DMSG_GREN_GAS)
		    deathstring = " chokes on his own gas\n";
		else if (deathmsg == DMSG_GREN_EMP)
		    deathstring = " explodes his ammo and body\n";
		else if (deathmsg == 41)
		    deathstring = " stepped on too many of his own caltrops\n";
		else if (deathmsg == DMSG_GREN_FLASH)
		    deathstring = " is charred by his own flash grenade\n";
		else if (deathmsg == DMSG_GREN_EMP_AMMO)
		    deathstring = " detonates an ammo box too close to him\n";
		else if (deathmsg == DMSG_DETPACK)
		    deathstring = " set the detpack and forgot to run\n";
		else if (deathmsg == DMSG_BIOWEAPON)
		    deathstring = " died impossibly!\n";
		else if (deathmsg == DMSG_ROCKETL) {
		    if (rnum)
			deathstring = " becomes bored with life\n";
		    else
			deathstring = " checks if his weapon is loaded\n";
		} else if (deathmsg == DMSG_INCENDIARY)
		    deathstring = " chars himself with an incendiary rocket\n";
		else if (deathmsg == DMSG_GRENADEL)
		    deathstring = " tries to put the pin back in\n";
		else if (deathmsg == DMSG_FLAME)
		    deathstring = " torches himself\n";
		else if ((deathmsg == DMSG_LIGHTNING) && (targ.waterlevel > 1)) {
		    bprint (PRINT_MEDIUM, " discharges into the water.\n");
		    return;
		} else if (deathmsg == 38)
		    deathstring = " gets too friendly with his sentrygun.\n";
		else if (deathmsg == 39)
		    deathstring = " dispenses with himself.\n";

		bprint (PRINT_MEDIUM, deathstring);
		return;
	    } else if ((teamplay && (attacker.team_no == targ.team_no)) && (attacker.team_no > 0)) {
		// killed a team member
		TF_AddFrags (attacker, -1);

		if (targ.undercover_team == 0)
		    attacker.teamkills = attacker.teamkills + 1;

		if ((birthday == 1) && (random () < 0.3)) {
		    if (random () < 0.3)
		        bprint2 (PRINT_MEDIUM, targ.netname, " is a party-pooper!\n");
		    else
		        bprint2 (PRINT_MEDIUM, targ.netname, " gives gifts to his teammates!\n");
		    return;
		}

		deathstring2 = "\n";

		if (rnum < 0.25)
		    deathstring = " mows down teammate ";
		else if (rnum < 0.5)
		    deathstring = " checks his glasses after killing ";
		else if (rnum < 0.75) {
		    deathstring = " gets a frag for the other team with ";
		    deathstring2 = "'s death\n";
		} else
		    deathstring = " killed his supposed friend ";

		if (deathmsg == DMSG_MEDIKIT) {
		    bprint (PRINT_MEDIUM, targ.netname, " didn't survive the operation by ",
			    attacker.netname, "\n");
		    return;
		}

		bprint (PRINT_MEDIUM, attacker.netname, deathstring, targ.netname, deathstring2);
		CheckAutoKick (attacker);
		return;
	    } else {
		TF_AddFrags (attacker, 1);
		logfrag (attacker, targ);

		if ((birthday == 1) && (random () < 0.5)) {
		
		    if (deathmsg == DMSG_GREN_NAIL) {
		        deathstring = " chews on ";
		        deathstring2 = "'s nails!\n";
		    } else if (deathmsg == DMSG_GREN_MIRV) {
		        deathstring = " gathers the darling buds of ";
		        deathstring2 = "'s Mirv grenade\n";
		    } else if (deathmsg == DMSG_GREN_EMP) {
		        deathstring = "'s presents go up in ";
		        deathstring2 = "'s EMP presence.\n";
		    } else if (deathmsg == DMSG_GREN_FLASH) {
		        bprint (PRINT_MEDIUM, targ.netname, " goes POP!\n");
		        return;
		    } else if (deathmsg == DMSG_GREN_EMP_AMMO) {
		        deathstring = " stands to near ";
		        deathstring2 = "'s birthday surprise\n";
		    } else if (deathmsg == DMSG_DETPACK) {
		        deathstring = " eats ";
		        deathstring2 = "'s good cheer!\n";
		        if (random () < 0.1)
		    	bprint (PRINT_MEDIUM, "Damn that jokey smurf!\n");
		    } else if (deathmsg == DMSG_DETPACK_DIS) {
		        deathstring = " cut the red ribbon of ";
		        deathstring2 = "'s detpack\n";
		    } else if (deathmsg == DMSG_GRENADEL) {
		        deathstring = " recieves a gift from ";
		        deathstring2 = "\n";
		        if (targ.health < -40) {
		    	deathstring = " plays pass-the-parcel with ";
		    	deathstring2 = "\n";
		        }
		    } else if (deathmsg == DMSG_ROCKETL) {
		        deathstring = " rides ";
		        deathstring2 = "'s firecracker\n";
		        if (targ.health < -40) {
			    bprint (PRINT_MEDIUM, targ.netname, " gets turned into little ",
				    targ.netname, "'s by ", attacker.netname, deathstring2);
			    return;
		        }
		    } else if (deathmsg == DMSG_FLAME) {
		        if (rnum < 0.5) {
		    	deathstring = " gets too close to ";
		    	deathstring2 = "'s kitchen\n";
		        } else {
		    	deathstring = " plays with ";
		    	deathstring2 = "'s fire\n";
		        }
		    } else if (deathmsg == DMSG_SNIPERRIFLE) {
		        if (rnum <= 0.3) {
		    	deathstring = " blocks ";
		    	deathstring2 = "'s birthday bullet with his chest\n";
		        } else {
		    	deathstring = " gets party popped by ";
		    	deathstring2 = "\n";
		        }
		    } else if (deathmsg == DMSG_SNIPERHEADSHOT) {
		        if (rnum <= 0.5) {
		    	deathstring = " ALMOST catches ";
		    	deathstring2 = "'s bullet between his teeth!\n";
		        } else {
		    	deathstring = " loves snipers like ";
		    	deathstring2 = "\n";
		        }
		    } else if (deathmsg == DMSG_SNIPERLEGSHOT) {
		        deathstring = " won't run crying to ";
		        deathstring2 = " anymore\n";
		    } else if (deathmsg == DMSG_AUTORIFLE) {
		        deathstring = " collects ";
		        deathstring2 = "'s highspeed gifts.\n";
		    } else if (deathmsg == DMSG_ASSAULTCANNON) {
		        deathstring = " died. I blame ";
		        deathstring2 = "\n";
		    } else if (deathmsg == DMSG_BACKSTAB) {
		        deathstring = " gets a gift in the back from ";
		        deathstring2 = "\n";
		    } else if (deathmsg == DMSG_SSHOTGUN) {
		        deathstring = " gets a double of ";
		        deathstring2 = "'s buck\n";
		    } else if (deathmsg == DMSG_TRANQ) {
		        deathstring = " is all partied out by ";
		        deathstring2 = "\n";
		    } else if (deathmsg == DMSG_LASERBOLT) {
		        deathstring = " gets derailed by ";
		        deathstring2 = "\n";
		    } else if (deathmsg == DMSG_NAILGUN) {
		        deathstring = " gets no say in it, no say in it at all! sings ";
		        deathstring2 = "\n";
		    } else if (deathmsg == DMSG_INCENDIARY) {
		        deathstring = " gets all fired up by ";
		        deathstring2 = "\n";
		    } else {
		        if (random () < 0.5)
		    	deathstring = " recieves a gift from ";
		        else
		    	deathstring = " has a happy birthday, thanks to ";
		        deathstring2 = "\n";
		    }
		
		    bprint (PRINT_MEDIUM, targ.netname, deathstring, attacker.netname, deathstring2);
		    return;
		}
		
		if (deathmsg == DMSG_GREN_HAND) {
		    if (attacker.playerclass == PC_SNIPER) {
		        deathstring = " got up-close and personal with ";
		        deathstring2 = "'s grenade\n";
		    } else if (attacker.playerclass == PC_SOLDIER) {
		        deathstring = " played catch with ";
		        deathstring2 = "'s grenade\n";
		    } else if (attacker.playerclass == PC_DEMOMAN) {
		        deathstring = " received a pineapple enema from ";
		        deathstring2 = "\n";
		    } else if (attacker.playerclass == PC_MEDIC) {
		        deathstring = " fetched ";
		        deathstring2 = "'s pineapple\n";
		    } else if (attacker.playerclass == PC_HVYWEAP) {
		        deathstring = " caught too much shrapnel from ";
		        deathstring2 = "'s grenade\n";
		    } else if (attacker.playerclass == PC_PYRO) {
		        deathstring = " tried to pick up ";
		        deathstring2 = "'s hot potato\n";
		    } else if (attacker.playerclass == PC_SPY) {
		        deathstring = " thought ";
		        deathstring2 = " was tossing him a spare grenade\n";
		    } else if (attacker.playerclass == PC_ENGINEER) {
		        deathstring = " stops to ponder the technical details of ";
		        deathstring2 = "'s grenade\n";
		    } else {
		        deathstring = " surfs on a grenade from ";
		        deathstring2 = "\n";
		    }
		} else if (deathmsg == DMSG_GREN_NAIL) {
		    deathstring = " gets flayed by ";
		    deathstring2 = "'s nail grenade\n";
		} else if (deathmsg == DMSG_GREN_MIRV) {
		    if (attacker.playerclass == PC_DEMOMAN) {
		        deathstring = " does a dance on ";
		        deathstring2 = "'s Mirv grenade\n";
		    } else {
		        deathstring = " gets spammed by ";
		        deathstring2 = "'s Mirv grenade\n";
		    }
		} else if (deathmsg == DMSG_GREN_PIPE) {
		    deathstring = " is caught by ";
		    deathstring2 = "'s pipebomb trap\n";
		} else if (deathmsg == 40) {
		    deathstring = " fell victim to ";
		    deathstring2 = "'s fireworks\n";
		} else if (deathmsg == DMSG_GREN_GAS) {
		    deathstring = " gags on ";
		    deathstring2 = "'s noxious gasses\n";
		} else if (deathmsg == DMSG_GREN_EMP) {
		    deathstring = "'s ammo detonates him as ";
		    deathstring2 = "'s EMP fries it\n";
		} else if (deathmsg == 41) {
		    deathstring = " stepped on too many of ";
		    deathstring2 = "'s caltrops\n";
		} else if (deathmsg == DMSG_GREN_FLASH) {
		    deathstring = " is charred by ";
		    deathstring2 = "'s flash grenade\n";
		} else if (deathmsg == DMSG_GREN_EMP_AMMO) {
		    deathstring = " stands near some ammo as ";
		    deathstring2 = "'s EMP nukes it\n";
		} else if (deathmsg == DMSG_DETPACK) {
		    deathstring = " reaches orbit via ";
		    deathstring2 = "'s detpack\n";
		} else if (deathmsg == DMSG_DETPACK_DIS) {
		    deathstring = " cut the red wire of ";
		    deathstring2 = "'s detpack\n";
		} else if (deathmsg == DMSG_BIOWEAPON) {
		    deathstring = " dies from ";
		    deathstring2 = "'s mysterious tropical disease\n";
		} else if (deathmsg == DMSG_BIOWEAPON_ATT) {
		    deathstring = " escapes infection from ";
		    deathstring2 = " by dying first\n";
		} else if (deathmsg == DMSG_GRENADEL) {
		    deathstring = " eats ";
		    deathstring2 = "'s pineapple\n";
		    if (targ.health < -40) {
		        deathstring = " was gibbed by ";
		        deathstring2 = "'s grenade\n";
		    }
		} else if (deathmsg == DMSG_ROCKETL) {
		    deathstring = " rides ";
		    deathstring2 = "'s rocket\n";
		    if (targ.health < -40) {
		        deathstring = " was gibbed by ";
		        deathstring2 = "'s rocket\n";
		    }
		} else if (deathmsg == DMSG_FLAME) {
		    if (rnum < 0.2) {
		        deathstring = " is burnt up by ";
		        deathstring2 = "'s flame\n";
		    } else if (rnum < 0.4) {
		        deathstring = " is fried by ";
		        deathstring2 = "'s fire\n";
		    } else if (rnum < 0.6) {
		        deathstring = " feels ";
		        deathstring2 = "'s fire of wrath\n";
		    } else if (rnum < 0.8) {
		        deathstring = " is reduced to ashes by ";
		        deathstring2 = "\n";
		    } else {
		        deathstring = " is grilled by ";
		        deathstring2 = "'s flame\n";
		    }
		} else if (deathmsg == DMSG_AXE) {
		    deathstring2 = "\n";
		    if (attacker.playerclass == PC_SPY)
		        deathstring = " was knife-murdered by ";
		    else if (attacker.playerclass == PC_SCOUT)
		        deathstring = "'s mellon was split by ";
		    else if (attacker.playerclass == PC_SNIPER)
		        deathstring = " was put on the chop block by ";
		    else if (attacker.playerclass == PC_SOLDIER) {
		        deathstring = " was sliced and diced by ";
		        deathstring2 = "'s blade\n";
		    } else if (attacker.playerclass == PC_DEMOMAN) {
		        deathstring = " is split from crotch to sternum by ";
		        deathstring2 = "'s axe swing\n";
		    } else if (attacker.playerclass == PC_HVYWEAP)
		        deathstring = " is split in two with a powerful axe blow from ";
		    else if (attacker.playerclass == PC_PYRO) {
		        deathstring = "'s death put another notch on ";
		        deathstring2 = "'s axe\n";
		    } else
		        deathstring = " was ax-murdered by ";
		} else if (deathmsg == DMSG_SPANNER) {
		    deathstring = " was spanner-murdered by ";
		    deathstring2 = "\n";
		} else if (deathmsg == DMSG_SHOTGUN) {
		    if (attacker.playerclass == PC_SCOUT) {
		        deathstring = " got too close to ";
		        deathstring2 = "'s muzzleflash\n";
		    } else if (attacker.playerclass == PC_SOLDIER) {
		        deathstring = " practices being ";
		        deathstring2 = "'s clay pigeon\n";
		    } else if (attacker.playerclass == PC_DEMOMAN) {
		        deathstring = " was on the receiving end of ";
		        deathstring2 = "'s shotgun barrel\n";
		    } else if (attacker.playerclass == PC_MEDIC) {
		        deathstring = " was fed a lead diet by ";
		        deathstring2 = "\n";
		    } else if (attacker.playerclass == PC_HVYWEAP) {
		        deathstring = " got blasted by ";
		        deathstring2 = "'s last resort\n";
		    } else if (attacker.playerclass == PC_PYRO) {
		        deathstring = " got more than a powderburn from ";
		        deathstring2 = "'s shotgun blast\n";
		    } else {
		        deathstring = " chewed on ";
		        deathstring2 = "'s boomstick\n";
		    }
		} else if (deathmsg == DMSG_SSHOTGUN) {
		    if (attacker.playerclass == PC_SOLDIER) {
		        deathstring = " was turned into swiss cheese by ";
		        deathstring2 = "'s buckshot\n";
		    } else if (attacker.playerclass == PC_MEDIC) {
		        deathstring = " got a double-dose of ";
		        deathstring2 = "'s buckshot\n";
		    } else if (attacker.playerclass == PC_HVYWEAP) {
		        deathstring = " unfortunately forgot ";
		        deathstring2 = " carried a super-shotgun\n";
		    } else if (attacker.playerclass == PC_SPY) {
		        deathstring = " gets ventilated by ";
		        deathstring2 = "'s super-shotgun blast\n";
		    } else if (attacker.playerclass == PC_ENGINEER) {
		        deathstring = "'s body got chuck full of ";
		        deathstring2 = "'s lead pellets\n";
		    } else {
		        deathstring = " ate 2 loads of ";
		        deathstring2 = "'s buckshot\n";
		    }
		} else if (deathmsg == DMSG_NAILGUN) {
		    if (attacker.playerclass == PC_SCOUT) {
		        deathstring = " caught one too many nails from ";
		        deathstring2 = "\n";
		    } else if (attacker.playerclass == PC_SNIPER) {
		        deathstring = " ran into ";
		        deathstring2 = "'s nails\n";
		    } else if (attacker.playerclass == PC_SPY) {
		        deathstring = " was turned into ";
		        deathstring2 = "'s pin-cushion\n";
		    } else {
		        deathstring = " was nailed by ";
		        deathstring2 = "\n";
		    }
		} else if (deathmsg == DMSG_SNAILGUN) {
		    deathstring = " was punctured by ";
		    deathstring2 = "\n";
		} else if (deathmsg == DMSG_LIGHTNING) {
		    deathstring = " accepts ";
		    if (attacker.waterlevel > 1)
		        deathstring2 = "'s discharge\n";
		    else
		        deathstring2 = "'s shaft\n";
		} else if (deathmsg == DMSG_HOOK) {
		    deathstring = " grappled with ";
		    deathstring2 = "\n";
		} else if (deathmsg == DMSG_SNIPERRIFLE) {
		    if (rnum <= 0.3) {
		        deathstring = " takes a bullet in the chest from ";
		        deathstring2 = "\n";
		    } else {
		        deathstring = " succumbs to sniperfire from ";
		        deathstring2 = "\n";
		    }
		} else if (deathmsg == DMSG_SNIPERHEADSHOT) {
		    if (rnum <= 0.5) {
		        deathstring = " gets a third eye from ";
		        deathstring2 = "\n";
		    } else {
		        deathstring = " gets his head blown off by ";
		        deathstring2 = "\n";
		    }
		} else if (deathmsg == DMSG_SNIPERLEGSHOT) {
		    if (rnum <= 0.5) {
		        deathstring = " is made legless by ";
		        deathstring2 = "\n";
		    } else {
		        deathstring = " gets his legs blown off by ";
		        deathstring2 = "\n";
		    }
		} else if (deathmsg == DMSG_AUTORIFLE) {
		    deathstring = " collects ";
		    deathstring2 = "'s bullet spray.\n";
		} else if (deathmsg == DMSG_ASSAULTCANNON) {
		    deathstring = " gets sawn in half by ";
		    deathstring2 = "\n";
		} else if (deathmsg == DMSG_BACKSTAB) {
		    deathstring = " gets knifed from behind by ";
		    deathstring2 = "\n";
		} else if (deathmsg == DMSG_TRANQ) {
		    deathstring = " is put to sleep by ";
		    deathstring2 = "\n";
		} else if (deathmsg == DMSG_LASERBOLT) {
		    deathstring = " gets a hole in his heart from ";
		    deathstring2 = "'s railgun\n";
		} else if (deathmsg == DMSG_INCENDIARY) {
		    deathstring = " gets well done by ";
		    deathstring2 = "'s incendiary rocket\n";
		} else if (deathmsg == 38) {
		    deathstring = " gets destroyed by ";
		    deathstring2 = "'s exploding sentrygun\n";
		} else if (deathmsg == 39) {
		    deathstring = " didn't insert the correct change into ";
		    deathstring2 = "'s dispenser.\n";
		}
		
		if ((attacker.has_disconnected == 1) || (attacker.netname == string_null)) {
		    deathstring = " died.";
		    deathstring2 = "\n";
		}
		bprint (PRINT_MEDIUM, targ.netname, deathstring, attacker.netname, deathstring2);
	    }
	    return;
	} else if (attacker.classname == "building_sentrygun") {
	    if (targ == attacker.real_owner) {
		if (deathmsg == DMSG_SENTRYGUN_ROCKET)
		    deathstring = " intercepts his sentry gun's rocket\n";
		else if (deathmsg == DMSG_SENTRYGUN_BULLET)
		    deathstring = " crossed his sentry gun's line of fire\n";

		bprint (PRINT_MEDIUM, targ.netname, deathstring);
	    } else if ((teamplay && (attacker.team_no == targ.team_no)) && (attacker.team_no > 0)) {
		bprint (PRINT_MEDIUM, targ.netname, " obstructs his team's sentry gun\n");
	    } else {
		TF_AddFrags (attacker.real_owner, 1);
		logfrag (attacker.real_owner, targ);

		if (deathmsg == DMSG_SENTRYGUN_ROCKET) {
		    deathstring = " hates ";
		    deathstring2 = "'s sentry gun\n";
		} else if (deathmsg == DMSG_SENTRYGUN_BULLET) {
		    deathstring = " is mown down by ";
		    deathstring2 = "'s sentry gun\n";
		}
		bprint (PRINT_MEDIUM, targ.netname, deathstring, attacker.real_owner.netname, deathstring2);
	    }
	} else {
	    logfrag (targ, targ);
	    TF_AddFrags (targ, -1);

	    rnum = targ.watertype;
	    bprint (PRINT_MEDIUM, targ.netname);

	    if (rnum == -3) {
		if (birthday == 1) {
		    if (random () < 0.5)
			deathstring = " bobs for apples\n";
		    else
			deathstring = " drowns in the punch\n";
		} else if (random () < 0.5)
		    deathstring = " sleeps with the fishes\n";
		else
		    deathstring = " sucks it down\n";
	    } else if (rnum == -4) {
		if (random () < 0.5)
		    deathstring = " gulped a load of slime\n";
		else
		    deathstring = " can't exist on slime alone\n";
	    } else if (rnum == -5) {
		if (targ.health < -15)
		    deathstring = " burst into flames\n";
		else if (random () < 0.5)
		    deathstring = " turned into hot slag\n";
		else
		    deathstring = " visits the Volcano God\n";
	    } else if (attacker.classname == "explo_box")
		deathstring = " blew up\n";
	    else if ((attacker.solid == SOLID_BSP) && (attacker != world))
		deathstring = " was squished\n";
	    else if (targ.deathtype == "falling") {
		targ.deathtype = string_null;
		deathstring = " fell to his death\n";
	    } else if ((attacker.classname == "trap_shooter")
		       || (attacker.classname == "trap_spikeshooter"))
		deathstring = " was spiked\n";
	    else if (attacker.classname == "fireball")
		deathstring = " ate a lavaball\n";
	    else if (attacker.classname == "trigger_changelevel")
		deathstring = " tried to leave\n";
	    else
		deathstring = " died\n";

	    bprint (PRINT_MEDIUM, deathstring);
	}
    } else if (targ.classname == "building_sentrygun") {
	if (attacker.classname == "teledeath") {
	    bprint (PRINT_MEDIUM, targ.real_owner.netname,
		    "'s sentrygun was telefragged by ", attacker.owner.netname, "\n");
	    return;
	}
	if (attacker.classname == "player") {
	    if (attacker == targ.real_owner) {
		bprint (PRINT_MEDIUM, targ.real_owner.netname, " destroys his sentrygun\n");
		return;
	    }
	    bprint (PRINT_MEDIUM, targ.real_owner.netname,
		    "'s sentrygun was destroyed by ", attacker.netname, "\n");

	    if ((attacker.team_no > 0) && (attacker.team_no == targ.real_owner.team_no)) {
		TF_AddFrags (attacker, -1);
		attacker.teamkills = attacker.teamkills + 1;
		CheckAutoKick (attacker);
	    } else
		TF_AddFrags (attacker, 1);

	    return;
	}
    } else if (targ.classname == "building_dispenser") {
	if ((attacker.team_no > 0) && (attacker.team_no == targ.real_owner.team_no)) {
	    TF_AddFrags (attacker, -1);
	    attacker.teamkills = attacker.teamkills + 1;
	    CheckAutoKick (attacker);
	}
    }
};
