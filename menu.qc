//======================================================
// This file handles all menu functions and displays.
//======================================================

void (float class) TeamFortress_SpyChangeSkin;
void (float teamno) TeamFortress_SpyChangeColor;
void (float issilent) TeamFortress_SpyFeignDeath;

void (entity spy) Spy_RemoveDisguise;

void (entity eng, string bld) DestroyBuilding;

void (float objtobuild) TeamFortress_Build;

void () lvl1_sentry_stand;
void () lvl2_sentry_stand;
void () lvl3_sentry_stand;

float (float tno, float autoteam) TeamFortress_TeamSet;
float (float tno) TeamFortress_TeamGetColor;
float () TeamFortress_TeamPutPlayerInTeam;
float (float tno) TeamFortress_TeamIsCivilian;
float (float tno) TeamFortress_TeamGetNoPlayers;
float () TeamFortress_GetNoPlayers;

void () TeamFortress_ChangeTeam;
void () TeamFortress_ChangeClass;
void (entity p) TeamFortress_SetSkin;

void (float type) TeamFortress_DropAmmo;
string (float num) NumberToString100;

void (entity targ, entity inflictor, entity attacker, float damage, float T_flags, float T_AttackType) TF_T_Damage;

void () W_SetCurrentAmmo;

void (entity p) bound_other_ammo;
float (float v) anglemod;

void (float tno, entity ignore, string st) teamsprint;

void () Menu_Team;
void () Menu_Class;
void () Menu_Drop;
void () Menu_Intro;
void () PlayerObserverMode;
void () Menu_ClassHelp;
void () Menu_ClassHelp2;
void () Menu_StuffClassHelp;
void (float inp) Menu_ClassHelp_Input;
void () Menu_DoBindings;
void () Menu_ShowBindings1;
void () Menu_ShowBindings2;
void () Menu_RepeatHelp;
void () Menu_Spy;
void () Menu_Spy_Skin;
void () Menu_Spy_Color;

void (float inp) Menu_Spy_Input;
void (float inp) Menu_Spy_Skin_Input;
void (float inp) Menu_Spy_Color_Input;

void () Menu_Engineer;
void () Menu_EngineerFix_Dispenser;
void () Menu_EngineerFix_SentryGun;
void () Menu_EngineerFix_Mortar;

void (float inp) Menu_Engineer_Input;
void (float inp) Menu_EngineerFix_Dispenser_Input;
void (float inp) Menu_EngineerFix_SentryGun_Input;
void (float inp) Menu_EngineerFix_Mortar_Input;

void () Menu_Dispenser;
void (float inp) Menu_Dispenser_Input;

void (entity pl, string s1) CenterPrint;
void (entity pl, string s1, string s2) CenterPrint2;

void () Menu_Birthday;
void (float inp) Menu_Birthday_Input;

void () ResetMenu =
{
    if (self.StatusBarSize == 0)
	CenterPrint (self, "\n");
    else
	self.StatusRefreshTime = time + 0.1;

    self.menu_count = MENU_REFRESH_RATE;
    self.current_menu = MENU_DEFAULT;
};

void () Player_Menu =
{
    if (self.menu_count > MENU_REFRESH_RATE) {
	self.menu_count = 0;
    } else {
	self.menu_count = self.menu_count + 1;
	return;
    }
    if (self.current_menu == MENU_INTRO) {

	Menu_Intro ();
	if (self.menu_displaytime > 4)
  	    self.current_menu = MENU_DEFAULT;
       else
	    self.menu_displaytime = self.menu_displaytime + 1;

    } else if (self.current_menu == MENU_CLASSHELP) {

	Menu_ClassHelp ();
	if (self.menu_displaytime > 8) {
	    Menu_StuffClassHelp ();
	    self.current_menu = MENU_DEFAULT;
	} else
	    self.menu_displaytime = self.menu_displaytime + 1;

    } else if (self.current_menu == MENU_CLASSHELP2) {

	Menu_ClassHelp2 ();
	if (self.menu_displaytime > 5) {
	    Menu_StuffClassHelp ();
	    self.current_menu = MENU_DEFAULT;
	} else
	    self.menu_displaytime = self.menu_displaytime + 1;

    } else if (self.current_menu == MENU_SHOWBINDS1) {

	Menu_ShowBindings1 ();
	if (self.menu_displaytime > 8)
	    self.current_menu = MENU_DEFAULT;
	else
	    self.menu_displaytime = self.menu_displaytime + 1;

    } else if (self.current_menu == MENU_SHOWBINDS2) {
       
	Menu_ShowBindings2 ();
	if (self.menu_displaytime > 8)
	   self.current_menu = MENU_DEFAULT;
	else
	   self.menu_displaytime = self.menu_displaytime + 1;

    } else if (self.current_menu == MENU_DROP) {

	Menu_Drop ();

    } else if (self.current_menu == MENU_SPY) {

	Menu_Spy ();

    } else if (self.current_menu == MENU_SPY_SKIN) {

	Menu_Spy_Skin ();

    } else if (self.current_menu == MENU_SPY_COLOR) {

	Menu_Spy_Color ();

    } else if (self.current_menu == MENU_ENGINEER) {

	Menu_Engineer ();

    } else if (self.current_menu == MENU_ENGINEER_FIX_DISPENSER) {

	Menu_EngineerFix_Dispenser ();

    } else if (self.current_menu == MENU_ENGINEER_FIX_SENTRYGUN) {

	Menu_EngineerFix_SentryGun ();

    } else if (self.current_menu == MENU_DISPENSER) {

	Menu_Dispenser ();

    } else if ((self.current_menu == 23)
	       || (self.current_menu == 24)
	       || (self.current_menu == 25)) {

	Menu_Birthday ();

    } else if (self.current_menu == MENU_REPEATHELP) {

	Menu_RepeatHelp ();
	self.current_menu = 1;

    } else if (self.current_menu == MENU_PICKBINDS) {

	Menu_DoBindings ();

    } else if (self.current_menu == 20) {

	Menu_Class ();

	} else if (self.current_menu == 21) {
	
	Menu_Team ();
	
    } else if (((self.team_no == 0) && teamplay) && (self.lives != 0)) {

	self.current_menu = MENU_TEAM;
	Menu_Team ();

    } else if ((self.playerclass == 0) && (self.lives != 0)) {

	self.current_menu = MENU_CLASS;
	Menu_Class ();

    } else
	self.current_menu = 0;
};

void () Menu_Team =
{
    if ((toggleflags & TFLAG_AUTOTEAM) && teamplay) {
	if (TeamFortress_TeamPutPlayerInTeam ())
	    return;
    }
    if (team_menu_string != string_null) {
	CenterPrint (self, team_menu_string);
	return;
    }

    if (CTF_Map == TRUE) {
	CenterPrint (self, "=== Choose Your Team ===\n\n“‘ Blue Team           \n”‘ Red Team            \n\n\n\n™‘ Bind my keys for me!\n\nFor full details on this patch:\nhttp://www.planetfortress.com/teamfortress/\n");
    } else if (number_of_teams == 1) {
	CenterPrint (self, "=== Choose Your Team ===\n\n“‘ Team One  \n");
    } else if (number_of_teams == 2) {
	CenterPrint (self, "=== Choose Your Team ===\n\n“‘ Team One  \n”‘ Team Two  \n              \n              \n—‘ Auto Team \n");
    } else if (number_of_teams == 3) {
	CenterPrint (self, "=== Choose Your Team ===\n\n“‘ Team One  \n”‘ Team Two  \n•‘ Team Three\n              \n—‘ Auto Team \n");
    } else {
	CenterPrint (self, "=== Choose Your Team ===\n\n“‘ Team One  \n”‘ Team Two  \n•‘ Team Three\n–‘ Team Four \n—‘ Auto Team \n");
    }
};

void (float inp) Menu_Team_Input =
{
    if (inp == 5) {
	TeamFortress_TeamPutPlayerInTeam ();
    } else if ((inp <= number_of_teams) && (inp > 0)) {
	TeamFortress_TeamSet (inp, 0);
    } else if ((number_of_teams == 0) && (inp <= 4)) {
	TeamFortress_TeamSet (inp, 0);
    } else if (inp == 7) {
	self.current_menu = MENU_PICKBINDS;
    }
    ResetMenu ();
    self.impulse = 0;
};

void () Menu_Class =
{
    local entity AD;

    AD = find (world, classname, "info_tfdetect");
    if (AD) {
	if (self.team_no == 1) {
	    if (AD.noise1 != string_null) {
		CenterPrint (self, AD.noise1);
		return;
	    }
	} else {
	    if (self.team_no == 2) {
		if (AD.noise2 != string_null) {
		    CenterPrint (self, AD.noise2);
		    return;
		}
	    } else {
		if (self.team_no == 3) {
		    if (AD.noise3 != string_null) {
			CenterPrint (self, AD.noise3);
			return;
		    }
		} else {
		    if (self.team_no == 4) {
			if (AD.noise4 != string_null) {
			    CenterPrint (self, AD.noise4);
			    return;
			}
		    }
		}
	    }
	}
    }
    if (TeamFortress_TeamIsCivilian (self.team_no)) {
	CenterPrint (self, "Your team can only be Civilians.\n");
    } else {
	if (spy_off == 1) {
	    CenterPrint (self, "=== Choose Your Class ===\n\n“‘ Scout   \n”‘ Sniper  \n•‘ Soldier \n–‘ Demoman \n—‘ Medic   \n˜‘ HWGuy   \n™‘ Pyro    \n›‘ Engineer\n’‘ RandomPC\n");
	} else {
	    if (birthday == 1) {
		CenterPrint (self, "=== Choose Your Class ===\n\n“‘ Scout   \n”‘ Sniper  \n•‘ Soldier \n–‘ Demoman \n—‘ Medic   \n˜‘ HWGuy   \n™‘ Pyro    \nš‘ Spy     \n›‘ Engineer\n’‘ The Birthday Boy\n");
	    } else {
		CenterPrint (self, "=== Choose Your Class ===\n\n“‘ Scout   \n”‘ Sniper  \n•‘ Soldier \n–‘ Demoman \n—‘ Medic   \n˜‘ HWGuy   \n™‘ Pyro    \nš‘ Spy     \n›‘ Engineer\n’‘ RandomPC\n");
	    }
	}
    }
};

void (float inp) Menu_Class_Input =
{
    local float new_class;
    local string st;

    if ((inp > 10) || (inp < 1))
	return;

    self.impulse = inp + 100;

    if (self.playerclass != 0)
	new_class = 1;

    TeamFortress_ChangeClass ();
    ResetMenu ();

    if ((self.playerclass != 0) && (new_class != 1)) {
	st = infokey (self, "ch");
	if (st == string_null)
	    st = infokey (self, "classhelp");
	if (st != "off")
	    self.current_menu = 6;
    }
    self.menu_displaytime = 0;
    self.impulse = 0;
};

void () Menu_Drop =
{
    if (self.playerclass == PC_ENGINEER) {
	CenterPrint (self, "Drop or Make:                   \n“‘ Shells                      \n”‘ Nails                       \n•‘ Rockets                     \n–‘ Cells                       \n—‘ Nothing                     \n\n");
    } else {
	CenterPrint (self, "Drop:                           \n“‘ Shells                      \n”‘ Nails                       \n•‘ Rockets                     \n–‘ Cells                       \n—‘ Nothing                     \n\n");
    }
};

void () Menu_RepeatHelp =
{
    CenterPrint (self, "Press š to see this help again\n");
};

void (float inp) Menu_Drop_Input =
{
    if ((inp > 0) && (inp < 5))
	TeamFortress_DropAmmo (inp);

    if ((inp > 0) && (inp < 6))
	ResetMenu ();

    self.impulse = 0;
};

void (float inp) Menu_DoBindings_Input =
{
    local string st;

    if (inp < 4) {
	self.impulse = 0;
	if (inp == 1) {
	    stuffcmd (self, "bind q \"impulse 23\"\n");
	    stuffcmd (self, "bind e \"impulse 22\"\n");
	    stuffcmd (self, "bind r \"+gren1\"\n");
	    stuffcmd (self, "bind f \"+gren2\"\n");
	    stuffcmd (self, "bind v \"detpipe\"\n");
	    stuffcmd (self, "bind c \"dropammo\"\n");
	    stuffcmd (self, "bind x \"autoscan\"\n");
	    stuffcmd (self, "bind g \"showclasses\"\n");
	    stuffcmd (self, "bind z \"inv\"\n");
	    self.menu_count = 25;
	    self.current_menu = 10;
	    self.menu_displaytime = 0;
	    return;
	} else if (inp == 2) {
            stuffcmd (self, "bind s \"impulse 23\"\n");
            stuffcmd (self, "bind x \"impulse 22\"\n");
            stuffcmd (self, "bind d \"+gren1\"\n");
            stuffcmd (self, "bind c \"+gren2\"\n");
            stuffcmd (self, "bind f \"detpipe\"\n");
            stuffcmd (self, "bind v \"dropammo\"\n");
            stuffcmd (self, "bind b \"autoscan\"\n");
            stuffcmd (self, "bind g \"showclasses\"\n");
            stuffcmd (self, "bind n \"inv\"\n");
            self.menu_count = 25;
            self.current_menu = 11;
            self.menu_displaytime = 0;
            return;
	}
	ResetMenu ();
    }
};

void (float inp) Menu_Input =
{
    if (self.current_menu == MENU_TEAM) {
	Menu_Team_Input (inp);
    } else if ((self.current_menu == MENU_CLASS) || (self.current_menu == 20)) {
	Menu_Class_Input (inp);
    } else if (self.current_menu == MENU_DROP) {
	Menu_Drop_Input (inp);
    } else if (self.current_menu == MENU_SPY) {
	Menu_Spy_Input (inp);
    } else if (self.current_menu == MENU_SPY_SKIN) {
	Menu_Spy_Skin_Input (inp);
    } else if (self.current_menu == MENU_SPY_COLOR) {
	Menu_Spy_Color_Input (inp);
    } else if (self.current_menu == MENU_ENGINEER) {
	Menu_Engineer_Input (inp);
    } else if (self.current_menu == MENU_ENGINEER_FIX_DISPENSER) {
	Menu_EngineerFix_Dispenser_Input (inp);
    } else if (self.current_menu == MENU_ENGINEER_FIX_MORTAR) {
	Menu_EngineerFix_Mortar_Input (inp);
    } else if (self.current_menu == MENU_ENGINEER_FIX_SENTRYGUN) {
	Menu_EngineerFix_SentryGun_Input (inp);
    } else if (self.current_menu == MENU_DISPENSER) {
	Menu_Dispenser_Input (inp);
    } else if (self.current_menu == 23) {
	Menu_Birthday_Input (inp);
    } else if (self.current_menu == 24) {
	Menu_Birthday_Input (inp);
    } else if (self.current_menu == 25) {
	Menu_Birthday_Input (inp);
    } else if (self.current_menu == MENU_CLASSHELP) {
	Menu_ClassHelp_Input (inp);
    } else if (self.current_menu == MENU_PICKBINDS) {
	Menu_DoBindings_Input (inp);
    }
};

void () Menu_Intro =
{
    local string st1;
    local string st2;
    local string st3;

    st1 = infokey (world, "motd1");
    if (st1 != string_null) {
	st2 = infokey (world, "motd2");
	centerprint (self, st1, "\n", st2);
   } else {
       CenterPrint (self, "Welcome to TeamFortress v2.9\nby TeamFortress Software\n======================================\nwww.planetquake.com/teamfortress");
   }
};

void () Menu_ClassHelp =
{
    if (self.menu_displaytime < 5) {
	if (self.playerclass == 1) {
	    CenterPrint (self, "ÓÃÏÕÔ Details:               \n\n×ÅÁĞÏÎÓ:                     \n”‘ Shotgun                  \n–‘ Nailgun                  \n\nPress š for alias help\n");
	} else if (self.playerclass == 2) {
	    CenterPrint (self, "ÓÎÉĞÅÒ Details:              \n\n×ÅÁĞÏÎÓ:                     \n”‘ Sniper Rifle/Auto Rifle  \n–‘ Nailgun                  \n\nPress š for alias help\n");
	} else if (self.playerclass == 3) {
	    CenterPrint (self, "ÓÏÌÄÉÅÒ Details:             \n\n×ÅÁĞÏÎÓ:                     \n”‘ Shotgun                  \n•‘ Super Shotgun            \n™‘ Rocket Launcher          \n\nPress š for alias help\n");
	} else if (self.playerclass == 4) {
	    CenterPrint (self, "ÄÅÍÏÌÉÔÉÏÎÓ ÍÁÎ Details:     \n\n×ÅÁĞÏÎÓ:                     \n”‘ Shotgun                  \n˜‘ Grenade Launcher         \n™‘ Pipebomb Launcher        \n\nPress š for alias help\n");
	} else if (self.playerclass == 5) {
	    CenterPrint (self, "ÍÅÄÉÃ Details:               \n\n×ÅÁĞÏÎÓ:                     \n“‘ Medikit/BioWeapon        \n”‘ Shotgun                  \n•‘ Super Shotgun            \n—‘ Super Nailgun            \n\nPress š for alias help\n");
	} else if (self.playerclass == 6) {
	    CenterPrint (self, "ÈÅÁÖÙ ×ÅÁĞÏÎÓ ÇÕÙ Details:   \n\n×ÅÁĞÏÎÓ:                     \n”‘ Shotgun                  \n•‘ Super Shotgun            \n™‘ Assault Cannon           \n\nPress š for alias help\n");
	} else if (self.playerclass == 7) {
	    CenterPrint (self, "ĞÙÒÏ Details:                \n\n×ÅÁĞÏÎÓ:                     \n”‘ Shotgun                  \n˜‘ Flamethrower             \n™‘ Incendiary Cannon        \n\nPress š for alias help\n");
	} else if (self.playerclass == 8) {
	    CenterPrint (self, "ÓĞÙ Details:                 \n\n×ÅÁĞÏÎÓ:                     \n”‘ Tranquiliser Gun         \n•‘ Super Shotgun            \n–‘ Nailgun                  \n\nPress š for alias help\n");
	} else if (self.playerclass == 9) {
	    CenterPrint (self, "ÅÎÇÉÎÅÅÒ Details:            \n\n×ÅÁĞÏÎÓ:                     \n“‘ Spanner                  \n”‘ RailGun                  \n•‘ Super Shotgun            \n\nPress š for alias help\n");
	}
    } else if (self.playerclass == 1) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nFlash Grenade       \nConcussion Grenade  \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nScanner: autoscan, scansound, scane, scanf\n\n\nPress š for alias help\n");
    } else if (self.playerclass == 2) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nFlare               \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nautozoom : Toggle Rifle Autozooming\n\n\nPress š for alias help\n");
    } else if (self.playerclass == 3) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nNail Grenade        \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
    } else if (self.playerclass == 4) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nMirv Grenade        \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nThe Detpack : det5, det20, det50\nDetonate Pipebombs : detpipe  \n\n\nPress š for alias help\n");
    } else if (self.playerclass == 5) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nConcussion Grenade  \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
    } else if (self.playerclass == 6) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nMirv Grenade        \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
    } else if (self.playerclass == 7) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nNapalm Grenade      \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
    } else if (self.playerclass == 8) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nHallucinogen Grenade\n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nGo Undercover : disguise\nFeign Death : feign, sfeign\n\n\nPress š for alias help\n");
    } else if (self.playerclass == 9) {
	CenterPrint (self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nEMP Grenade         \n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nStart Building : build  \n\n\nPress š for alias help\n");
    }
};

void () Menu_StuffClassHelp =
{
    if (self.playerclass == 1) {
	sprint (self, PRINT_HIGH, "ÓÃÏÕÔ Details:\n×ÅÁĞÏÎÓ:\n   ”‘ Shotgun\n   –‘ Nailgun\n");
	sprint (self, PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Concussion Grenade\n   Flare\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n");
	sprint (self, PRINT_HIGH, "Scanner: autoscan, scansound, scane, scanf\n\n\n");
    } else if (self.playerclass == 2) {
	sprint (self, PRINT_HIGH, "ÓÎÉĞÅÒ Details:\n\n×ÅÁĞÏÎÓ:\n   ”‘ Sniper Rifle/Auto Rifle\n");
	sprint (self, PRINT_HIGH, "–‘ Nailgun\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n\n\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n");
	sprint (self, PRINT_HIGH, "  autozoom : Toggle Rifle Autozooming\n\n\n");
    } else if (self.playerclass == 3) {
	sprint (self, PRINT_HIGH, "ÓÏÌÄÉÅÒ Details:\n\n×ÅÁĞÏÎÓ:\n   ”‘ Shotgun\n   •‘ Super Shotgun\n");
	sprint (self, PRINT_HIGH, "   ™‘ Rocket Launcher\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Nail Grenade\n");
	sprint (self, PRINT_HIGH, "ÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
    } else if (self.playerclass == 4) {
	sprint (self, PRINT_HIGH, "ÄÅÍÏÌÉÔÉÏÎÓ ÍÁÎ Details:\n\n×ÅÁĞÏÎÓ:\n   ”‘ Shotgun\n   ˜‘ Grenade/Pipebomb Launcher\n");
	sprint (self, PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Mirv Grenade\n");
	sprint (self, PRINT_HIGH, "ÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   The Detpack : det5, det20, det50\n   Detonate Pipebombs : detpipe\n\n\n");
    } else if (self.playerclass == 5) {
	sprint (self, PRINT_HIGH, "ÍÅÄÉÃ Details:\n\n×ÅÁĞÏÎÓ:\n   “‘ Medikit/BioWeapon\n   ”‘ Shotgun\n   •‘ Super Shotgun\n");
	sprint (self, PRINT_HIGH, "   —‘ Super Nailgun\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Concussion Grenade\n");
	sprint (self, PRINT_HIGH, "ÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
    } else if (self.playerclass == 6) {
	sprint (self, PRINT_HIGH, "ÈÅÁÖÙ ×ÅÁĞÏÎÓ ÇÕÙ Details:\n\n×ÅÁĞÏÎÓ:\n   ”‘ Shotgun\n   •‘ Super Shotgun\n");
	sprint (self, PRINT_HIGH, "   ™‘ Assault Cannon\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n");
	sprint (self, PRINT_HIGH, "   Mirv Grenade\nÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
    } else if (self.playerclass == 7) {
	sprint (self, PRINT_HIGH, "ĞÙÒÏ Details:\n\n×ÅÁĞÏÎÓ:\n   ”‘ Shotgun\n   ˜‘ Flamethrower\n   ™‘ Incendiary Cannon\n");
	sprint (self, PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Napalm Grenade\n");
	sprint (self, PRINT_HIGH, "ÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
    } else if (self.playerclass == 8) {
	sprint (self, PRINT_HIGH, "ÓĞÙ Details:\n\n×ÅÁĞÏÎÓ:\n   ”‘ Tranquiliser Gun\n   •‘ Super Shotgun\n   –‘ Nailgun\n");
	sprint (self, PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Hallucinogenic Grenade\n");
	sprint (self, PRINT_HIGH, "ÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   Go Undercover : disguise\n   Feign Death : feign, sfeign\n\n\n");
    } else if (self.playerclass == 9) {
	sprint (self, PRINT_HIGH, "ÅÎÇÉÎÅÅÒ Details:\n\n×ÅÁĞÏÎÓ:\n   “‘ Spanner\n   ”‘ RailGun\n   •‘ Super Shotgun\n");
	sprint (self, PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   EMP Grenade\n");
	sprint (self, PRINT_HIGH, "ÓĞÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   Start Building : build\n\n\n");
    }
};

void () Menu_ClassHelp2 =
{
    CenterPrint (self, "Commands:\ninv       : Show inventory \n+gren1    : Throw grenade 1\n+gren2    : Throw Grenade 2\nreload    : Force a reload \ndropammo  : drop some ammo \n\n");
};

void (float inp) Menu_ClassHelp_Input =
{
    if (inp == 8) {
	Menu_ClassHelp2 ();
	self.menu_count = 25;
	self.current_menu = 7;
	self.menu_displaytime = 0;
	self.impulse = 0;
    }
};

void () Menu_DoBindings =
{
    CenterPrint (self, "“‘ Use keys: E R F V C Q X G Z\n”‘ Use keys: S X D C F V B G N\n•‘ Don't make bindings        \n");
};

void () Menu_ShowBindings1 =
{
    CenterPrint (self, "Ñ.. Flaginfo      \nÅ.. Hook          \nÒ.. Throw Gren 1  \nÆ.. Throw Gren 2  \nÖ.. Det. Pipebombs\nÃ.. Drop ammo     \nØ.. Use Scanner   \nÇ.. Showclasses   \nÚ.. inventory     \n");
};

void () Menu_ShowBindings2 =
{
    CenterPrint (self, "Ó.. Flaginfo      \nØ.. Hook          \nÄ.. Throw Gren 1  \nÃ.. Throw Gren 2  \nÆ.. Det. Pipebombs\nÖ.. Drop ammo     \nÂ.. Use Scanner   \nÇ.. Showclasses   \nÎ.. inventory     \n");
};

void () Menu_Spy =
{
    if ((self.effects & (8 | 4)) || (self.is_unabletospy == 1)) {
	ResetMenu ();
	return;
    }
    if (self.is_feigning) {
	if ((self.undercover_team != 0) && (self.undercover_skin != 0)) {
	    CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Reset Skin and Color        \n—‘ Nothing                     \n\n");
	} else {
	    if (self.undercover_team != 0) {
		CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Reset Color                 \n—‘ Nothing                     \n\n");
	    } else {
		if (self.undercover_skin != 0) {
		    CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Reset Skin                  \n—‘ Nothing                     \n\n");
		} else {
		    CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Nothing                     \n\n");
		}
	    }
	}
    } else {
	if ((self.undercover_team != 0) && (self.undercover_skin != 0)) {
	    CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Reset Skin and Color        \n—‘ Nothing                     \n\n");
	} else {
	    if (self.undercover_team != 0) {
		CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Reset Color                 \n—‘ Nothing                     \n\n");
	    } else {
		if (self.undercover_skin != 0) {
		    CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Reset Skin                  \n—‘ Nothing                     \n\n");
		} else {
		    CenterPrint (self, "Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Nothing                     \n\n");
		}
	    }
	}
    }
};

void (float inp) Menu_Spy_Input =
{
    local float tc;
    local string st;

    if ((inp == 1) || (inp == 2)) {
	if (self.effects & (8 | 4)) {
	    sprint (self, PRINT_HIGH, "You can't go undercover while glowing.\n");
	    ResetMenu ();
	    self.impulse = 0;
	    return;
	}
	if (self.is_unabletospy == 1) {
	    sprint (self, PRINT_HIGH, "You can't go undercover right now.\n");
	    ResetMenu ();
	    self.impulse = 0;
	    return;
	}
    }
    if (inp == 1) {
	Menu_Spy_Skin ();
	self.menu_count = 25;
	self.current_menu = 13;
	self.menu_displaytime = 0;
	self.impulse = 0;
    } else {
	if (inp == 2) {
	    Menu_Spy_Color ();
	    self.menu_count = 25;
	    self.current_menu = 14;
	    self.menu_displaytime = 0;
	    self.impulse = 0;
	} else {
	    if (inp == 3) {
		TeamFortress_SpyFeignDeath (0);
		ResetMenu ();
		self.impulse = 0;
	    } else {
		if (inp == 4) {
		    Spy_RemoveDisguise (self);
		    ResetMenu ();
		    self.impulse = 0;
		} else {
		    if ((inp == 5) && ((self.undercover_team != 0) || (self.undercover_skin != 0))) {
			ResetMenu ();
			self.impulse = 0;
		    }
		}
	    }
	}
    }
};

void () Menu_Spy_Skin =
{
    CenterPrint (self, "Change Skin to:\n“‘ Scout   \n”‘ Sniper  \n•‘ Soldier \n–‘ Demoman \n—‘ Medic   \n˜‘ Hvwep   \n™‘ Pyro    \nš‘ Spy     \n›‘ Engineer\n\n");
};

void (float inp) Menu_Spy_Skin_Input =
{
    if ((inp < 10) && (inp > 0)) {
	TeamFortress_SpyChangeSkin (inp);
	ResetMenu ();
	self.impulse = 0;
    }
};

void () Menu_Spy_Color =
{
    if (number_of_teams == 0) {
	sprint (self, PRINT_HIGH, "No Color changing allowed in deathmatch.\n");
	ResetMenu ();
	self.impulse = 0;
	return;
    }
    if (number_of_teams == 1) {
	CenterPrint (self, "=== Change Color to the Same Color as  ===\n\n“‘ Team One  \n\n");
    } else {
	if (number_of_teams == 2) {
	    CenterPrint (self, "=== Change Color to the Same Color as  ===\n\n“‘ Team One  \n”‘ Team Two  \n\n");
	} else {
	    if (number_of_teams == 3) {
		CenterPrint (self, "=== Change Color to the Same Color as  ===\n\n“‘ Team One  \n”‘ Team Two  \n•‘ Team Three\n\n");
	    } else {
		CenterPrint (self, "=== Change Color to the Same Color as  ===\n\n“‘ Team One  \n”‘ Team Two  \n•‘ Team Three\n–‘ Team Four \n\n");
	    }
	}
    }
};

void (float inp) Menu_Spy_Color_Input =
{
    if ((inp >= 1) && (inp <= number_of_teams)) {
	TeamFortress_SpyChangeColor (inp);
	ResetMenu ();
	self.impulse = 0;
    }
};

void () Menu_Engineer =
{
    local string s_action;
    local string s_disp;
    local string s_sentry;
    local string s_tpent;
    local string s_tpexit;
    local string s_nothing;

    s_action = "Action:                           \n";
    s_nothing = "—‘ Nothing                      \n\n";
    if (self.has_dispenser) {
	s_disp = "™‘ Remotely Detonate Dispenser  \n";
    } else {
	if (self.ammo_cells >= 100) {
	    s_disp = "“‘ Build Ammo&Armor Dispenser   \n";
	} else {
	    s_disp = "\n";
	}
    }
    if (self.has_sentry) {
	s_sentry = "š‘ Remotely Detonate Sentry Gun \n";
    } else {
	if (self.ammo_cells >= 130) {
	    s_sentry = "”‘ Build Sentry Gun             \n";
	} else {
	    s_sentry = "\n";
	}
    }
    centerprint (self, s_action, s_disp, s_sentry, s_nothing);
};

void (float inp) Menu_Engineer_Input =
{
   local entity te;

   if (((inp == 1) && (self.ammo_cells >= 100)) && (self.has_dispenser != 1)) {
      TeamFortress_Build (1);
      ResetMenu ();
      self.impulse = 0;
   } else {
      if (((inp == 2) && (self.ammo_cells >= 130)) && (self.has_sentry != 1)) {
         TeamFortress_Build (2);
         ResetMenu ();
         self.impulse = 0;
      } else {
         if ((inp == 7) && (self.has_dispenser == 1)) {
            DestroyBuilding (self, "building_dispenser");
            ResetMenu ();
            self.impulse = 0;
         } else {
            if ((inp == 8) && (self.has_sentry == 1)) {
               DestroyBuilding (self, "building_sentrygun");
               ResetMenu ();
               self.impulse = 0;
            } else {
               if (inp == 5) {
                  ResetMenu ();
                  self.impulse = 0;
               }
            }
         }
      }
   }
};

void () Menu_EngineerFix_Dispenser =
{
    CenterPrint (self, "Action:                            \n“‘ Put Ammo into Dispenser     \n”‘ Put Armor into Dispenser    \n•‘ Repair Dispenser            \n–‘ Dismantle Dispenser         \n—‘ Nothing                     \n\n");
};

void (float inp) Menu_EngineerFix_Dispenser_Input =
{
    local float metalcost;
    local float am;
    local string f1;

    if ((self.classname != "player") || (self.building == world)) {
	return;
    }
    if (inp == 1) {
	am = (20 * 2);
	if (am > self.ammo_shells) {
	    am = self.ammo_shells;
	}
	if (am > (400 - self.building.ammo_shells)) {
	    am = (400 - self.building.ammo_shells);
	}
	self.ammo_shells = (self.ammo_shells - am);
	self.building.ammo_shells = (self.building.ammo_shells + am);
	am = (20 * 2);
	if (am > self.ammo_nails) {
	    am = self.ammo_nails;
	}
	if (am > (600 - self.building.ammo_nails)) {
	    am = (600 - self.building.ammo_nails);
	}
	self.ammo_nails = (self.ammo_nails - am);
	self.building.ammo_nails = (self.building.ammo_nails + am);
	am = (10 * 2);
	if (am > self.ammo_rockets) {
	    am = self.ammo_rockets;
	}
	if (am > (300 - self.building.ammo_rockets)) {
	    am = (300 - self.building.ammo_rockets);
	}
	self.ammo_rockets = (self.ammo_rockets - am);
	self.building.ammo_rockets = (self.building.ammo_rockets + am);
	am = (10 * 2);
	if (am > self.ammo_cells) {
	    am = self.ammo_cells;
	}
	if (am > (400 - self.building.ammo_cells)) {
	    am = (400 - self.building.ammo_cells);
	}
	self.ammo_cells = (self.ammo_cells - am);
	self.building.ammo_cells = (self.building.ammo_cells + am);
    } else {
	if (inp == 2) {
	    am = (40 * 2);
	    if (am > self.armorvalue) {
		am = self.armorvalue;
	    }
	    if (am > (500 - self.building.armorvalue)) {
		am = (500 - self.building.armorvalue);
	    }
	    self.armorvalue = (self.armorvalue - am);
	    self.building.armorvalue = (self.building.armorvalue + am);
	} else {
	    if (inp == 3) {
		metalcost = ((self.building.max_health - self.building.health) / 5);
		if (metalcost > self.ammo_cells) {
		    metalcost = self.ammo_cells;
		}
		self.ammo_cells = (self.ammo_cells - metalcost);
		self.building.health = (self.building.health + (metalcost * 5));
	    } else {
		if (inp == 4) {
		    sprint (self, PRINT_HIGH, "You dismantle the Dispenser.\n");
		    self.ammo_cells = (self.ammo_cells + (100 / 2));
		    if (self.building.real_owner != self) {
			sprint2 (self.building.real_owner, PRINT_HIGH,
				 self.netname, " dismantled your Dispenser.\n");
			teamsprint (self.building.real_owner.team_no,
				    self.building.real_owner, self.netname);
			teamsprint (self.building.real_owner.team_no,
				    self.building.real_owner, " dismantled ");
			teamsprint (self.building.real_owner.team_no,
				    self.building.real_owner, self.building.real_owner.netname);
			teamsprint (self.building.real_owner.team_no,
				    self.building.real_owner, "'s Dispenser.\n");
		    }
		    dremove (self.building);
		    self.building.real_owner.has_dispenser = 0;
		}
	    }
	}
    }
    if ((inp >= 1) && (inp <= 5)) {
	ResetMenu ();
	self.impulse = 0;
	self.building = world;
	bound_other_ammo (self);
	if (self.armorvalue == 0) {
	    self.armortype = 0;
	    self.armorclass = 0;
	    self.items = (self.items - (self.items & ((8192 | 16384) | 32768)));
	}
	W_SetCurrentAmmo ();
    }
};

void () Menu_EngineerFix_SentryGun =
{
    if ((self.building.weapon < 3) && (self.ammo_cells >= 130)) {
	CenterPrint (self, "Action:                            \n“‘ Put Ammo into Sentry Gun    \n”‘ Upgrade Sentry Gun          \n•‘ Repair Sentry Gun           \n–‘ Dismantle Sentry Gun        \n—‘ Nothing                     \n\n˜‘ Rotate SentryGun            \n");
    } else {
	CenterPrint (self, "Action:                            \n“‘ Put Ammo into Sentry Gun    \n\n•‘ Repair Sentry Gun           \n–‘ Dismantle Sentry Gun        \n—‘ Nothing                     \n\n˜‘ Rotate SentryGun            \n");
    }
};

void (float inp) Menu_EngineerFix_SentryGun_Input =
{
    local float am;
    local float metalcost;
    local string st;

    if (self.building.real_owner.has_sentry == 0) {
	return;
    }
    if ((self.classname != "player") || (self.building == world)) {
	return;
    }
    if (inp == 1) {
	am = (20 * 2);
	if (am > self.ammo_shells) {
	    am = self.ammo_shells;
	}
	if (am > (self.building.maxammo_shells - self.building.ammo_shells)) {
	    am = (self.building.maxammo_shells - self.building.ammo_shells);
	}
	self.ammo_shells = (self.ammo_shells - am);
	self.building.ammo_shells = (self.building.ammo_shells + am);
	if (self.building.weapon == 3) {
	    am = (10 * 2);
	    if (am > self.ammo_rockets) {
		am = self.ammo_rockets;
	    }
	    if (am > (self.building.maxammo_rockets - self.building.ammo_rockets)) {
		am = (self.building.maxammo_rockets - self.building.ammo_rockets);
	    }
	    self.ammo_rockets = (self.ammo_rockets - am);
	    self.building.ammo_rockets = (self.building.ammo_rockets + am);
	}
    } else {
	if (((self.building.weapon < 3) && (inp == 2)) && (self.ammo_cells >= 130)) {
	    self.ammo_cells = self.ammo_cells - 130;
	    self.building.weapon = self.building.weapon + 1;
	    self.building.max_health = self.building.max_health * 1.2;
	    self.building.health = self.building.max_health;
	    self.building.maxammo_shells = self.building.maxammo_shells * 1.2;
	    if (self.building.weapon == 2) {
		sound (self.building, 3, "weapons/turrset.wav", 1, 1);
		self.building.think = lvl2_sentry_stand;
		self.building.skin = 1;
	    } else {
		sound (self.building, 3, "weapons/turrset.wav", 1, 1);
		self.building.think = lvl3_sentry_stand;
		self.building.skin = 2;
	    }
	    sprint (self, PRINT_HIGH, "You upgrade the Sentry Gun to level ");
	    st = ftos (self.building.weapon);
	    sprint (self, PRINT_HIGH, st, "\n");
	} else if (inp == 3) {
	    metalcost = ((self.building.max_health - self.building.health) / 5);
	    if (metalcost > self.ammo_cells) {
		metalcost = self.ammo_cells;
	    }
	    self.ammo_cells = self.ammo_cells - metalcost;
	    self.building.health = self.building.health + metalcost * 5;
	} else if (inp == 4) {
	    sprint (self, PRINT_HIGH, "You dismantle the Sentry Gun.\n");
	    self.ammo_cells = (self.ammo_cells + (130 / 2));
	    if (self.building.real_owner != self) {
		sprint2 (self.building.real_owner, PRINT_HIGH, self.netname, " dismantled your Sentry Gun.\n");
		teamsprint (self.building.real_owner.team_no,
			    self.building.real_owner, self.netname);
		teamsprint (self.building.real_owner.team_no,
			    self.building.real_owner, " dismantled ");
		teamsprint (self.building.real_owner.team_no,
			    self.building.real_owner, self.building.real_owner.netname);
		teamsprint (self.building.real_owner.team_no,
			    self.building.real_owner, "'s Sentry Gun.\n");
	    }
	    dremove (self.building.trigger_field);
	    dremove (self.building);
	    self.building.real_owner.has_sentry = 0;
	} else if (inp == 6) {
	    sprint (self, PRINT_HIGH, "Rotating 45 degrees to the left...\n");
	    self.building.waitmin = anglemod (self.building.waitmin + 45);
	    self.building.waitmax = anglemod (self.building.waitmax + 45);
	}
    }
    if ((inp >= 1) && (inp <= 6)) {
	ResetMenu ();
	self.impulse = 0;
	bound_other_ammo (self);
	if (self.armorvalue == 0) {
	    self.armortype = 0;
	    self.armorclass = 0;
	    self.items = (self.items - (self.items & ((8192 | 16384) | 32768)));
	}
	W_SetCurrentAmmo ();
    }
};

void () Menu_EngineerFix_Mortar =
{
    CenterPrint (self, "Action:                            \n“‘ Reload Mortar               \n•‘ Repair Mortar               \n–‘ Dismantle Mortar            \n—‘ Nothing                     \n\n");
};

void (float inp) Menu_EngineerFix_Mortar_Input =
{
    if ((inp >= 1) && (inp <= 5)) {
	ResetMenu ();
	self.impulse = 0;

	bound_other_ammo (self);

	if (self.armorvalue == 0) {
	    self.armortype = 0;
	    self.armorclass = 0;
	    self.items = self.items - (self.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
	}
	W_SetCurrentAmmo ();
    }
};

void () Menu_Dispenser =
{
    CenterPrint (self, "Use Dispenser:                     \n“‘ Withdraw some ammo          \n”‘ Withdraw some Armor         \n•‘ Nothing                     \n\n");
};

void (float inp) Menu_Dispenser_Input =
{
    local float am;
    local float empty;

    empty = FALSE;
    if (inp == 1) {
	if ((self.building.ammo_shells == 0)
	    && (self.building.ammo_nails == 0)
	    && (self.building.ammo_rockets == 0)
	    && (self.building.ammo_cells == 0)) {
            empty = TRUE;
        } else {
	    am = self.maxammo_shells - self.ammo_shells;
	    if (am > self.building.ammo_shells)
		am = self.building.ammo_shells;
	    self.building.ammo_shells = self.building.ammo_shells - am;
	    self.ammo_shells = self.ammo_shells + am;

	    am = self.maxammo_nails - self.ammo_nails;
	    if (am > self.building.ammo_nails)
		am = self.building.ammo_nails;
	    self.building.ammo_nails = self.building.ammo_nails - am;
	    self.ammo_nails = self.ammo_nails + am;

	    am = self.maxammo_rockets - self.ammo_rockets;
	    if (am > self.building.ammo_rockets)
		am = self.building.ammo_rockets;
	    self.building.ammo_rockets = self.building.ammo_rockets - am;
	    self.ammo_rockets = self.ammo_rockets + am;

	    am = self.maxammo_cells - self.ammo_cells;
	    if (am > self.building.ammo_cells)
		am = self.building.ammo_cells;
	    self.building.ammo_cells = self.building.ammo_cells - am;
	    self.ammo_cells = self.ammo_cells + am;
	}
    } else if (inp == 2) {
	if (self.building.armorvalue == 0) {
            empty = TRUE;
	} else {
            am = self.maxarmor - self.armorvalue;
            if (am > self.building.armorvalue)
		am = self.building.armorvalue;

            if (self.armortype == 0) {
		self.armortype = 0.3;
		self.items = self.items | IT_ARMOR1;
            }
            self.building.armorvalue = self.building.armorvalue - am;
            self.armorvalue = self.armorvalue + am;
	}
    }
    if ((inp >= 1) && (inp <= 3)) {
	if (empty)
	    sprint (self, PRINT_HIGH, "The dispenser is empty.\n");

	ResetMenu ();
	self.impulse = 0;
	self.building = world;
	self.building_wait = time + 0.5;

	bound_other_ammo (self);
	if (self.armorvalue == 0) {
	    self.armortype = 0;
	    self.armorclass = 0;
	    self.items = self.items - (self.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
	}
	W_SetCurrentAmmo ();
    }
};

void () BirthdayTimer =
{
    local entity te;
    local float rnum;

    if (self.weapon > 5) {
	self.weapon = 0;
	self.nextthink = time + 180 + (random () * 60);
	rnum = random ();
	self.team_str_home = string_null;
	if (rnum < 0.02) {
	    self.team_str_moved = "\n\n\n\nHAPPY BIRTHDAY TEAMFORTRESS!\n";
	} else if (rnum < 0.04) {
            self.team_str_moved = "\n\n\n\nCurrent number of Snipers on\nthe Battlements:\n";
            rnum = TeamFortress_GetNoPlayers () / 2;
            rnum = rnum + (random () * rnum);
            rnum = rint (rnum);
            self.team_str_home = NumberToString100 (rnum);
	} else if (rnum < 0.06) {
	    self.team_str_moved = "\n\n\n\nYeeha!\nThe 505, 672nd detpack was\njust laid on the bridge!\n";
	} else if (rnum < 0.08) {
	    self.team_str_moved = "\n\n\n\nIs that an assault cannon in your\n pocket, or are you just playing TF?\n(Blame Ian)\n";
	} else if (rnum < 0.1) {
	    self.team_str_moved = "\n\n\n\n25, 000 downloads\n50 donations\nDamn, but we rock!\n";
	} else if (rnum < 0.12) {
	    self.team_str_moved = "\n\n\n\nTeamFortress is one year old today!\n";
	} else if (rnum < 0.14) {
	    self.team_str_moved = "\n\n\n\nTF II available 2nd quarter 98\n";
	} else if (rnum < 0.16) {
	    self.team_str_moved = "\n\n\n\nhmm.... I wonder what the next\nmessage will be...\n";
	} else if (rnum < 0.18) {
	    self.team_str_moved = "\n\n\n\nKill your friends! Kill your family!\nSnipe your pets! Detpack your house!\nGet TF Now!\n";
	} else if (rnum < 0.2) {
	    self.team_str_moved = "\n\n\n\nDeath to Potatoes!\n";
	} else if (rnum < 0.22) {
	    self.team_str_moved = "\n\n\n\n\"You guys have really fucked up\n urinals, you know that?\"\n   - TyR in Australia\n";
	} else if (rnum < 0.24) {
	    self.team_str_moved = "\n\n\n\nMany potatoes were harmed in the\nmaking of this product.\n";
	} else if (rnum < 0.25) {
	    self.team_str_moved = "\n\n\n\nBAH! I shoulda put the Demoman\nblast armor back while I was at it!\n   - Gudlyf\n";
	} else if (rnum < 0.26) {
	    self.team_str_moved = "\n\n\n\nTwin Peaks will be out... uhh...\nerr... soon.\n";
	} else if (rnum < 0.28) {
	    self.team_str_moved = "\n\n\n\n\"Twin Peaks will be finished tomorrow.\"\n   - TyR, 16th July, 25th July, 2nd August...";
	} else if (rnum < 0.3) {
	    self.team_str_moved = "\n\n\n\n\"After all, TF is an INSULT to the\npurity of CTF!\"\n   - Mjollnir, who was joking... really!";
	} else if (rnum < 0.32) {
	    self.team_str_moved = "\n\n\n\n\"I force them to work.\nElse I cut back their supplies\"\n   - Vomitgod, on TFS\n";
	} else if (rnum < 0.34) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen you had to use imin1 & imin2\nto join a team.\n";
	} else if (rnum < 0.36) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen there were 2 TF servers...\nand they were always down.";
	} else if (rnum < 0.38) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen no-one knew how to use\nhand grenades...\n";
	} else if (rnum < 0.4) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen 2fort was the only TF map.\nWe sure have come a long\nway since then... sigh";
	} else if (rnum < 0.42) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen the sniper rifle just\nkilled in one hit... everytime\n";
	} else if (rnum < 0.44) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen I could download TF in\n1 minute 20 seconds\n";
	} else if (rnum < 0.46) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen I didn't have to download\nANYTHING to play TF\n";
	} else if (rnum < 0.48) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen players used to say\n\"What's that bubble?\"\n";
	} else if (rnum < 0.5) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen The Well actually had a well...\n";
	} else if (rnum < 0.52) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen the motion detector was officially\nthe Scout's best friend, at least\naccording to the readme.txt\n";
	} else if (rnum < 0.54) {
	    self.team_str_moved = "\n\n\n\nI remember the good ol' days...\nwhen  Ian went to jail for punching\nRobin out\n";
	} else if (rnum < 0.56) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #1:\nUmm... How do I set a detpack?\n";
	} else if (rnum < 0.58) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #2:\nUmm... How do I throw a grenade?\n";
	} else if (rnum < 0.6) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #3:\nHey, he is cheating, that soldier just jumped up to the roof!!\n";
	} else if (rnum < 0.62) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #4:\nHow do I throw the pins?\n";
	} else if (rnum < 0.64) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #5:\nWhere do I take the flag!?!?!\n";
	} else if (rnum < 0.66) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #6:\nWhere's the control room?\n";
	} else if (rnum < 0.68) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #7:\nWhy the hell are these backpacks\nexploding?\n";
	} else if (rnum < 0.7) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #8:\nWho's the maniac with the axe?\n";
	} else if (rnum < 0.72) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #9:\nStop shooting me!\nI'm on your team!\nYou tried to attack my with the axe!\n";
	} else if (rnum < 0.74) {
	    self.team_str_moved = "\n\n\n\nTF Newbie Quote #10:\nWhat's this key? I thought this\nwas a CTF style map, guys?\n";
	} else if (rnum < 0.76) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #1:\nUm, Red Medics, please don't\nheal the President.\n";
	} else if (rnum < 0.78) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #2:\nGuys could you NOT set up\nsentries in hunted?\n";
	} else if (rnum < 0.8) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #3:\nWho the hell is on\nthe lift?\n";
	} else if (rnum < 0.82) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #4:\nDISCARD!!\n";
	} else if (rnum < 0.84) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #5:\nDamn Snipers!\n";
	} else if (rnum < 0.86) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #6:\nDamn Snipers!\n";
	} else if (rnum < 0.88) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #7:\nGet a mask or\nget in the WATER!!\n";
	} else if (rnum < 0.9) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #8:\nSpy's, please change colors\noutside our base.\n";
	} else if (rnum < 0.92) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #9:\nI was typing!!\n";
	} else if (rnum < 0.94) {
	    self.team_str_moved = "\n\n\n\nTF Veteran Quote #10:\nWhy is that guy running\nout of our yard with\nthe flag???\n";
	} else if (rnum < 0.96) {
	    self.team_str_moved = "\n\n\n\nTF's original design docs!\nCheck it out!\nwww.teamfortress.com/files/teamfortress/tfdes_1.gif";
	} else if (rnum < 0.98) {
	    self.team_str_moved = "\n\n\n\nTF's original design docs!\nCheck it out!\nwww.teamfortress.com/files/teamfortress/tfdes_2.gif";
	} else
	    self.team_str_moved = "\n\n\n\n\"MJ: Did you hear John Cash wrote TF?\"\n   - VomitGod";

	return;
    } else {
	self.nextthink = time + 1.5;
	self.weapon = self.weapon + 1;
    }
    rnum = random ();
    te = find (world, classname, "player");
    while (te) {
	if (self.team_str_home != string_null)
	    centerprint (te, self.team_str_moved, self.team_str_home);
	else
	    centerprint (te, self.team_str_moved);

	if (self.weapon == 1) {
	    sound (te, 3, "misc/b1.wav", 1, 1);
	} else if (self.weapon <= 4) {
            if (rnum < 0.33) {
		sound (te, 3, "misc/b2.wav", 1, 1);
            } else if (rnum < 0.66) {
		sound (te, 3, "misc/b3.wav", 1, 1);
	    } else 
                sound (te, 3, "misc/b4.wav", 1, 1);
	}
	te = find (te, classname, "player");
    }
};

void () Menu_Birthday =
{
    if (self.current_menu == 24)
	centerprint (self, "3rd Impulse\n");
    else if (self.current_menu == 25)
	centerprint (self, "4th Impulse\n");
};

void (float inp) Menu_Birthday_Input =
{
    local entity te;

    if (self.current_menu == 23) {
	ResetMenu ();
	self.impulse = 0;
	if (inp == 98)
	    self.current_menu = 24;
    } else if (self.current_menu == 24) {
	ResetMenu ();
	self.impulse = 0;
	if (inp == 156)
	    self.current_menu = 25;
    } else if (self.current_menu == 25) {
	ResetMenu ();
	self.impulse = 0;
	if (inp == 96) {
	    birthday = 1;
	    localcmd ("localinfo birthday on\n");
	    bprint (PRINT_HIGH, "IT'S PARTY TIME\n");
	    te = find (world, classname, "player");
	    while (te) {
		centerprint (te, "\n\nHAPPY BIRTHDAY TEAMFORTRESS!\n");
		te = find (te, classname, "player");
	    }
	    te = spawn ();
	    te.weapon = 10;
	    te.nextthink = time + 60;
	    te.think = BirthdayTimer;
	}
    }
};
