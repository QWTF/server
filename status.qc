float (float tno) TeamFortress_TeamGetScore;
float () TeamFortress_TeamGetWinner;
float () TeamFortress_TeamGetSecond;

string (entity pl) GetStatusSize;
string (entity pl) ClipSize;
string (entity pl) ScannerRange;
string (entity pl) ScannerScanned;
string (entity pl) DisguiseString;
string (entity pl) SentryDetails;
string (entity pl) SentryHealth;

void (entity pl, string s1) CenterPrint =
{
    centerprint (pl, s1);
    pl.StatusRefreshTime = time + 1.5;
};

void (entity pl, string s1, string s2) CenterPrint2 =
{
    centerprint (pl, s1, s2);
    pl.StatusRefreshTime = time + 1.5;
};

void (entity pl, string s1, string s2, string s3) CenterPrint3 =
{
    centerprint (pl,s1,s2,s3);
    pl.StatusRefreshTime = time + 1.5;
};

void (entity pl, float fTime, string s1) StatusPrint =
{
    centerprint (pl, s1);
    pl.StatusRefreshTime = time + fTime;
};

void (entity pl) RefreshStatusBar =
{ //centerprint max 40 characters. inserting \s does not decrease this.

    local string status_size, misc, clip_print;
	
	local float t1_pl, t2_pl, t3_pl, t4_pl, no_teams;
	local string t1name, t2name, t3name, t4name;
	local string t1score, t2score, t3score, t4score;
	local string t1full, t2full, t3full, t4full, t12full, t34full;
	local string st, print_scores, gren1, gren2, gren_print, detpack_print;
	
	if (pl.StatusBarSize == 0) {
		pl.StatusRefreshTime = time + 60;
		return;
	}
	pl.StatusRefreshTime = time + 1.5;

	if (pl.playerclass == PC_UNDEFINED)
		return;
	
	no_teams = 0;
	t1_pl = TeamFortress_TeamGetNoPlayers (1);
    t2_pl = TeamFortress_TeamGetNoPlayers (2);
	t3_pl = TeamFortress_TeamGetNoPlayers (3);
	t4_pl = TeamFortress_TeamGetNoPlayers (4);
	
	if (t1_pl > 0) {
		no_teams = no_teams + 1;
		t1name = "\sBlue\s: ";
		st = ftos(team1score);
		t1score = substring(st, 0, 4);
	}
	if (t2_pl > 0) {
		no_teams = no_teams + 1;
		t2name = "\sRed\s: ";
		if (t1_pl > 0)
			t2name = " \sRed\s: ";
		st = ftos(team2score);
		t2score = substring(st, 0, 4);
	}
	if (t3_pl > 0) {
		no_teams = no_teams + 1;
		t3name = "\sYell\s: ";
		if ( (t1_pl > 0) || (t2_pl > 0) )
			t3name = " \sYell\s: ";
		st = ftos(team3score);
		t3score = substring(st, 0, 4);
	}
	if (t4_pl > 0) {
		no_teams = no_teams + 1;
		t4name = "\sGrn\s: ";
		if ( (t1_pl > 0) || (t2_pl > 0) || (t3_pl > 0) )
			t4name = " \sGrn\s: ";
		st = ftos(team4score);
		t4score = substring(st, 0, 4);
	}
	
	t1full = strcat(t1name,t1score);
	t2full = strcat(t2name,t2score);
	t3full = strcat(t3name,t3score);
	t4full = strcat(t4name,t4score);
	
	t12full = strcat(t1full,t2full);
	t34full = strcat(t3full,t4full);
	print_scores = strcat(t12full,t34full);
	
	
	gren1 = strcat(" \sG1\s:", ftos (self.no_grenades_1));
	gren2 = strcat(" \sG2\s:", ftos (self.no_grenades_2));
	gren_print = strcat(gren1, gren2);
	
	if (pl.playerclass == PC_DEMOMAN) {
		if (self.ammo_detpack > 0)
			detpack_print = strcat(" \sDpack\s:", ftos (self.ammo_detpack));
	}

    status_size = GetStatusSize (pl);
    clip_print = ClipSize (pl);
    misc = "\n";
	
	if (pl.playerclass == PC_SCOUT) {
		local string scanner_to_string, range_to_string;
		
		scanner_to_string = ScannerScanned (pl);
		range_to_string = ScannerRange (pl);
		centerprint (pl, status_size, scanner_to_string, range_to_string, "\n", print_scores, clip_print, gren_print);
		return;
	}
	else if (pl.playerclass == PC_SPY) {
		local string disguise_state;
		disguise_state = DisguiseString (pl);
		
		centerprint (pl, status_size, disguise_state, print_scores, clip_print, gren_print);
		return;
	}
	else if (pl.playerclass == PC_ENGINEER) {
		if (self.has_sentry) {
			local string sentry_health, sentry_details;
			sentry_health = SentryHealth (pl);
			sentry_details = SentryDetails (pl);
			
			centerprint (pl, status_size, sentry_health, sentry_details, print_scores, clip_print, gren_print);
			return;
		}
		else if (self.is_building) {
			misc = "\nBuilding..\n";
		}
	}
	
	centerprint (pl, status_size, misc, print_scores, clip_print, gren_print, detpack_print);

};

string (entity pl) GetStatusSize =
{
    if (pl.StatusBarSize == 1) {
		if (pl.StatusBarRes > 7) // 768
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 7) // 600
				return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 6) // 480
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 5) // 400
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 4) // 384
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 3) // 350
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 2) // 300
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 1) // 240
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		
		return ("\n\n\n\n\n\n\n\n\n\n\n"); // 200
    }
	else /* if (pl.StatusBarSize == 2) */ {
		if (pl.StatusBarRes > 7) // 768
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 7) // 600
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 6) // 480
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 5) // 400
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 4) // 384
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 3) // 350
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 2) // 300
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		else if (pl.StatusBarRes == 1) // 240
			return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
		return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n"); // 200
    }
};

void (float res) StatusRes =
{
    self.StatusBarRes = res;
    if (res > 7)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 1024x768.\n");
    else if (res == 7)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 800x600.\n");
    else if (res == 6)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 640x480.\n");
    else if (res == 5)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 640x400.\n");
    else if (res == 4)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 512x384.\n");
    else if (res == 3)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 320x350.\n");
    else if (res == 2)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 400x300.\n");
    else if (res == 1)
		sprint (self, PRINT_HIGH, "Status Bar Res set to 320x240.\n");
    else
		sprint (self, PRINT_HIGH, "Status Bar Res set to 320x200.\n");
};

string (entity pl) ClipSize =
{
	local float clip;
	local string clip_print;

	if (pl.current_weapon == WEAP_SHOTGUN) {
		if ((8 - pl.reload_shotgun) > pl.ammo_shells)
			pl.reload_shotgun = 8 - pl.ammo_shells;
		clip = 8 - pl.reload_shotgun;
		clip_print = strcat (" \sClip\s: ", ftos(clip));
    }
	else if (pl.current_weapon == WEAP_SUPER_SHOTGUN) {
		if ((16 - pl.reload_super_shotgun) > pl.ammo_shells)
			pl.reload_super_shotgun = 16 - pl.ammo_shells;
		clip = (16 - pl.reload_super_shotgun);
		clip_print = strcat (" \sClip\s: ", ftos(clip));
	}
	else if (pl.current_weapon == WEAP_GRENADE_LAUNCHER) {
		if ((6 - pl.reload_grenade_launcher) > pl.ammo_rockets)
			pl.reload_grenade_launcher = (6 - pl.ammo_rockets);
		clip = (6 - pl.reload_grenade_launcher);
		clip_print = strcat (" \sClip\s: ", ftos(clip));
	}
	else if (pl.current_weapon == WEAP_ROCKET_LAUNCHER) {
		if ((4 - pl.reload_rocket_launcher) > pl.ammo_rockets)
			pl.reload_rocket_launcher = (4 - pl.ammo_rockets);
		clip = (4 - pl.reload_rocket_launcher);
		clip_print = strcat (" \sClip\s: ", ftos(clip));
	}
	
	return (clip_print);
};

string (entity pl) DisguiseString =
{
    local string under_team, under_class, disguise_print;
		
	if (pl.undercover_team == 1)
		under_team = "Blue";
	if (pl.undercover_team == 2)
		under_team = "Red";
	if (pl.undercover_team == 3)
		under_team = "Yell";
	if (pl.undercover_team == 4)
		under_team = "Grn";

	if (!pl.undercover_skin) {
		under_class = ("\n");
	} else if (pl.undercover_skin == 1) {
		under_class = (" Scout\n");
	} else if (pl.undercover_skin == 2) {
		under_class = (" Sniper\n");
	} else if (pl.undercover_skin == 3) {
		under_class = (" Soldier\n");
	} else if (pl.undercover_skin == 4) {
		under_class = (" Demoman\n");
	} else if (pl.undercover_skin == 5) {
		under_class = (" Medic\n");
	} else if (pl.undercover_skin == 6) {
		under_class = (" Hvy Wpns\n");
	} else if (pl.undercover_skin == 7) {
		under_class = (" Pyro\n");
	} else if (pl.undercover_skin == 8) {
		under_class = (" Spy\n");
	} else
		under_class = (" Engineer\n");
	
	if (pl.is_undercover == 0)
		under_class = ("Not undercover\n");
    if (pl.is_undercover == 2) {
		under_class = (" Going undercover..\n");
	}
    if (invis_only)
		under_class = ("Undercover\n");
	
	disguise_print = strcat(under_team, under_class);
	return (disguise_print);
};

string (entity pl) ScannerRange =
{
	local entity te;
	local float range;
	local string rangeprint;
	
		te = find (world, netname, "scanner");
	while ((te != world) && (te.owner != pl))
		te = find (te, netname, "scanner");	
	
	if ( (pl.ScannerOn != 1) || (te.health < 1) )
		rangeprint = "";
	else {
		range = te.health;
		rangeprint = strcat (ftos(range), " m");
	}
	
	return (rangeprint);
};

string (entity pl) ScannerScanned =
{
    local entity te;
	local string team_name, player_class, scanned_print, st;

    te = find (world, netname, "scanner");
    while ((te != world) && (te.owner != pl))
		te = find (te, netname, "scanner");

    if (pl.ScannerOn != 1)
		scanned_print =  ("Scanner off");

    if (te.health > 0) {
		if (te.team_no == 1)
			team_name = "Blue ";
		if (te.team_no == 2)
			team_name = "Red ";
		if (te.team_no == 3)
			team_name = "Yell ";
		if (te.team_no == 4)
			team_name = "Grn ";
			
		if (!te.playerclass)
			player_class = ("");
		else if (te.playerclass == 1)
			player_class = ("Scout");
		else if (te.playerclass == 2)
			player_class = ("Sniper");
		else if (te.playerclass == 3)
			player_class = ("Soldier");
		else if (te.playerclass == 4)
			player_class = ("Demoman");
		else if (te.playerclass == 5)
			player_class = ("Medic");
		else if (te.playerclass == 6)
			player_class = ("Hvy Wpns");
		else if (te.playerclass == 7)
			player_class = ("Pyro");
		else if (te.playerclass == 8)
			player_class = ("Spy");
		else if (te.playerclass == 9)
			player_class = ("Engineer");
		else if (te.playerclass == 11)
			player_class = ("Civilian");
		else if (te.playerclass == 13)
			player_class = ("Sentry Gun");
		else if (te.playerclass == 14)
			player_class = ("Goal Item");
		else
			player_class = ("");
		
		st = strcat(team_name, player_class);
		scanned_print = strcat(st, ", ");
	}
	else if (pl.ScannerOn == 1)
		scanned_print = ("Scanning..");
		
	return (scanned_print);
};

string (entity pl) SentryDetails =
{
    local entity te;

    te = find (world, classname, "building_sentrygun");
    while (te) {
		if (te.real_owner == self) {
			if (te.ammo_shells == 0) {
				if ((te.ammo_rockets == 0) && (te.weapon == 3))
					return (" no ammo\n");
				else
					return (" no shells\n");
			}
			else if ((te.ammo_rockets == 0) && (te.weapon == 3))
				return (" no rockets\n");
			else
				return ("\n");
		}
		te = find (te, classname, "building_sentrygun");
    }
    return ("\n");
};

string (entity pl) SentryHealth =
{
    local entity te;
	local string sg_print;
	local float st;

    te = find (world, classname, "building_sentrygun");
    while (te) {
		if (te.real_owner == self) {
			st = rint (te.health);
			sg_print = strcat("SENTRY: ", ftos(st));
			return(sg_print);
		}
		te = find (te, classname, "building_sentrygun");
    }
    return ("SENTRY: 0 health"); // Why is this needed?
};
