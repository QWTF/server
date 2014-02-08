//========================================================
// Functions handling all the help displaying for TeamFortress.
//========================================================

void () TeamFortress_MOTD =
{
    local string ya;

    if (self.motd == 4)
	stuffcmd (self, "is_aliased\n");

    if (self.motd <= 20) {
	self.motd = self.motd + 1;
	return;
    }

    if (self.motd == 21) {
	self.tfstate = self.tfstate | TFSTATE_ZOOMOFF;

	if ((teamplay != 0) && (self.team_no == 0)) {
	    stuffcmd (self, "color ");
	    ya = ftos (0);
	    stuffcmd (self, ya);
	    stuffcmd (self, "\n");
	}

	if (self.got_aliases == FALSE)
	    sprint (self, PRINT_HIGH, "\n");
    
	localcmd("serverinfo qwtfver \"");
	localcmd(tf_version);
	localcmd("\"\n");
	
	sprint (self, PRINT_HIGH, "QuakeWorld TeamFortress v", tf_version, "\n");
	sprint (self, PRINT_HIGH, website, "\n\n");

	self.menu_displaytime = 0;
	self.current_menu = MENU_INTRO;
	self.menu_count = MENU_REFRESH_RATE;
	self.motd = 22;

	if (self.got_aliases == TRUE)
	    return;

	//sprint (self, PRINT_HIGH, "binding aliases...\n"); //why do we need this line? commenting it out
	TeamFortress_Alias ("inv", TF_INVENTORY, 0);
	TeamFortress_Alias ("showtf", TF_SHOWTF, 0);
	TeamFortress_Alias ("autozoom", TF_AUTOZOOM, 0);
	TeamFortress_Alias ("changeclass", TF_CHANGECLASS, 0);
	TeamFortress_Alias ("changeteam", TF_CHANGETEAM, 0);
    TeamFortress_Alias ("rpickup", TF_RPICKUP, 0);
	TeamFortress_Alias ("ready", TF_READY, 0);
	TeamFortress_Alias ("list", TF_LIST, 0);
	TeamFortress_Alias ("scout", TF_CHANGEPC + PC_SCOUT, 0);
	TeamFortress_Alias ("sniper", TF_CHANGEPC + PC_SNIPER, 0);
	TeamFortress_Alias ("soldier", TF_CHANGEPC + PC_SOLDIER, 0);
	TeamFortress_Alias ("demoman", TF_CHANGEPC + PC_DEMOMAN, 0);
	TeamFortress_Alias ("medic", TF_CHANGEPC + PC_MEDIC, 0);
	TeamFortress_Alias ("hwguy", TF_CHANGEPC + PC_HVYWEAP, 0);
	TeamFortress_Alias ("pyro", TF_CHANGEPC + PC_PYRO, 0);
	TeamFortress_Alias ("spy", TF_CHANGEPC + PC_SPY, 0);
	TeamFortress_Alias ("engineer", TF_CHANGEPC + PC_ENGINEER, 0);
	TeamFortress_Alias ("randompc", TF_CHANGEPC + PC_RANDOM, 0);
	TeamFortress_Alias ("is_aliased", TF_ALIAS_CHECK, 0);
	return;
    }
    if (self.motd <= 95)
	self.motd = self.motd + 1;

    if (self.motd == 25) {
	TeamFortress_Alias ("detpipe", TF_PB_DETONATE, 0);
	TeamFortress_Alias ("reload", TF_RELOAD, 0);
	TeamFortress_Alias ("autoscan", TF_SCAN, 0);
	TeamFortress_Alias ("scansound", TF_SCAN_SOUND, 0);
	TeamFortress_Alias ("scan10", TF_SCAN, 0);
	TeamFortress_Alias ("scan30", TF_SCAN, 0);
	TeamFortress_Alias ("scan100", TF_SCAN, 0);
	TeamFortress_Alias ("scanf", TF_SCAN_FRIENDLY, 0);
	TeamFortress_Alias ("scane", TF_SCAN_ENEMY, 0);
	return;
    }
    if (self.motd == 35) {
	TeamFortress_Alias ("primeone", TF_GRENADE_1, 0);
	TeamFortress_Alias ("primetwo", TF_GRENADE_2, 0);
	TeamFortress_Alias ("throwgren", TF_GRENADE_T, 0);
	TeamFortress_Alias ("+gren1", TF_GRENADE_1, 0);
	TeamFortress_Alias ("+gren2", TF_GRENADE_2, 0);
	TeamFortress_Alias ("-gren1", TF_GRENADE_T, 0);
	TeamFortress_Alias ("-gren2", TF_GRENADE_T, 0);
	TeamFortress_Alias ("showscores", TF_TEAM_SCORES, 0);
	TeamFortress_Alias ("showclasses", TF_TEAM_CLASSES, 0);
	TeamFortress_Alias ("query", TF_STATUS_QUERY, 0);
	return;
    }
    if (self.motd == 45) {
	TeamFortress_Alias ("dropkey", TF_DROPKEY, 0);
	TeamFortress_Alias ("dropammo", TF_DROP_AMMO, 0);
	TeamFortress_Alias ("dropitems", TF_DROPITEMS, 0);
	TeamFortress_Alias ("showloc", TF_DISPLAYLOCATION, 0);
	TeamFortress_Alias ("special", TF_SPECIAL_SKILL, 0);
	TeamFortress_Alias ("saveme", TF_MEDIC_HELPME, 0);
	TeamFortress_Alias ("discard", TF_DISCARD, 0);
	TeamFortress_Alias ("id", TF_ID, 0);
	return;
    }
    if (self.motd == 55) {
	TeamFortress_Alias ("flaginfo", FLAG_INFO, 0);
	TeamFortress_Alias ("maphelp", TF_HELP_MAP, 0);
	TeamFortress_Alias ("showids", TF_SHOW_IDS, 0);
	stuffcmd (self, "bind 9 \"impulse 9\"\n");
	stuffcmd (self, "bind 0 \"impulse 10\"\n");
	return;
    }
    if (self.motd == 65) {
	TeamFortress_Alias ("sbar_on", TF_STATUSBAR_ON, 0);
	TeamFortress_Alias ("sbar_off", TF_STATUSBAR_OFF, 0);
	TeamFortress_Alias ("sbar_200", TF_STATUSBAR_RES_START, 0);
	TeamFortress_Alias ("sbar_240", TF_STATUSBAR_RES_START + 1, 0);
	TeamFortress_Alias ("sbar_300", TF_STATUSBAR_RES_START + 2, 0);
	TeamFortress_Alias ("sbar_350", TF_STATUSBAR_RES_START + 3, 0);
	TeamFortress_Alias ("sbar_384", TF_STATUSBAR_RES_START + 4, 0);
	TeamFortress_Alias ("sbar_400", TF_STATUSBAR_RES_START + 5, 0);
	TeamFortress_Alias ("sbar_480", TF_STATUSBAR_RES_START + 6, 0);
	TeamFortress_Alias ("sbar_600", TF_STATUSBAR_RES_START + 7, 0);
	TeamFortress_Alias ("sbar_768", TF_STATUSBAR_RES_START + 8, 0);
	return;
    }
    if (self.motd == 75) {
	TeamFortress_Alias ("+det5", TF_DETPACK_5, 0);
	TeamFortress_Alias ("-det5", TF_DETPACK_STOP, 0);
	TeamFortress_Alias ("+det20", TF_DETPACK_20, 0);
	TeamFortress_Alias ("-det20", TF_DETPACK_STOP, 0);
	TeamFortress_Alias ("+det50", TF_DETPACK_50, 0);
	TeamFortress_Alias ("-det50", TF_DETPACK_STOP, 0);
	return;
    }
    if (self.motd == 85) {
	TeamFortress_Alias ("clan1", 82, 0);
	TeamFortress_Alias ("clan2", 83, 0);
	TeamFortress_Alias ("clan3", 84, 0);
	TeamFortress_Alias ("clan4", 85, 0);
	TeamFortress_Alias ("clan5", 86, 0);
	return;
    }
    if (self.motd == 95) {
	TeamFortress_Alias ("disguise", TF_SPY_SPY, 0);
	TeamFortress_Alias ("feign", TF_SPY_DIE, 0);
	TeamFortress_Alias ("sfeign", TF_SPY_SILENT_DIE, 0);
	TeamFortress_Alias ("build", TF_ENGINEER_BUILD, 0);
	TeamFortress_Alias ("detsentry", TF_ENGINEER_DETSENTRY, 0);
	TeamFortress_Alias ("detdispenser", TF_ENGINEER_DETDISP, 0);
    }
};

void () TeamFortress_HelpMap =
{
    local entity te;

    te = find (world, classname, "info_tfdetect");
    if (te) {
	if (te.non_team_broadcast != string_null) {
	    sprint (self, PRINT_HIGH, te.non_team_broadcast);
	    return;
	}
    }
    sprint (self, PRINT_HIGH, "There is no help for this map.\n");
};
