
void (entity p) BanCheater;

void () Admin_CountPlayers =
{
    local string st;
    local float nump;

    nump = TeamFortress_GetNoPlayers ();
    st = ftos (nump);
    sprint3 (self, PRINT_HIGH, "Players In Game : ", st, "\n");
    if (number_of_teams > 0) {
	nump = TeamFortress_TeamGetNoPlayers (1);
	st = ftos (nump);
	sprint3 (self, PRINT_HIGH, "Players In Team1: ", st, "\n");
    }
    if (number_of_teams > 1) {
	nump = TeamFortress_TeamGetNoPlayers (2);
	st = ftos (nump);
	sprint3 (self, PRINT_HIGH, "Players In Team2: ", st, "\n");
    }
    if (number_of_teams > 2) {
	nump = TeamFortress_TeamGetNoPlayers (3);
	st = ftos (nump);
	sprint3 (self, PRINT_HIGH, "Players In Team3: ", st, "\n");
    }
    if (number_of_teams > 3) {
	nump = TeamFortress_TeamGetNoPlayers (4);
	st = ftos (nump);
	sprint3 (self, PRINT_HIGH, "Players In Team4: ", st, "\n");
    }
};

void () Admin_ListIPs =
{
    if (TeamFortress_GetNoPlayers () <= 1) {
	sprint (self, PRINT_HIGH, "No other players in the game.\n");
	self.admin_use = world;
	return;
    }
    self.admin_use = find (self.admin_use, classname, "player");
    while (self.admin_use != world) {
	if ((self.admin_use.netname != string_null) && (self.admin_use != self)) {
	    self.admin_use.ip = infokey (self.admin_use, "ip");
	    sprint (self, PRINT_HIGH, self.admin_use.netname, " (", self.admin_use.ip, ")\n");
	}
	self.admin_use = find (self.admin_use, classname, "player");
    }
    self.admin_use = find (self.admin_use, classname, "observer");
    while (self.admin_use != world) {
	if ((self.admin_use.netname != string_null) && (self.admin_use != self)) {
	    self.admin_use.ip = infokey (self.admin_use, "ip");
	    sprint (self, PRINT_HIGH, self.admin_use.netname, " (", self.admin_use.ip, ") (SPECTATOR)\n");
	}
	self.admin_use = find (self.admin_use, classname, "observer");
    }
    sprint (self, PRINT_HIGH, "End of player list\n");
    self.admin_use = world;
};

void () Admin_CycleDeal =
{
    if (TeamFortress_GetNoPlayers () <= 1) {
	sprint (self, PRINT_HIGH, "No other players in the game.\n");
	self.admin_use = world;
	self.admin_mode = 0;
	return;
    }
    if (self.admin_use.classname != "observer") {
	self.admin_use = find (self.admin_use, classname, "player");
	while ((self.admin_use != world) && ((self.admin_use.netname == string_null)
					     || (self.admin_use == self))) {
	    self.admin_use = find (self.admin_use, classname, "player");
	}
	if (self.admin_use == world) {
	    self.admin_use = find (self.admin_use, classname, "observer");
	    while ((self.admin_use != world) && ((self.admin_use.netname == string_null)
						 || (self.admin_use == self))) {
		self.admin_use = find (self.admin_use, classname, "observer");
	    }
	}
    } else {
	self.admin_use = find (self.admin_use, classname, "observer");
	while ((self.admin_use != world) && ((self.admin_use.netname == string_null)
					     || (self.admin_use == self))) {
	    self.admin_use = find (self.admin_use, classname, "observer");
	}
    }
    if (self.admin_use) {
	self.admin_use.ip = infokey (self.admin_use, "ip");
	self.admin_mode = 1;
	sprint (self, PRINT_HIGH, self.admin_use.netname, " (", self.admin_use.ip, ")");
	if (self.admin_use.classname == "observer") {
	    sprint (self, PRINT_HIGH, " (SPECTATOR)");
	}
	sprint (self, PRINT_HIGH, "\n   KICK/BAN/NEXT?\n");
    } else {
	self.admin_mode = 0;
	sprint (self, PRINT_HIGH, "End of player list\n");
    }
};

void () Admin_DoKick =
{
    bprint4 (PRINT_HIGH, self.admin_use.netname, " was kicked by ", self.netname, "\n");
    KickCheater (self.admin_use);
    self.admin_mode = 0;
    self.admin_use = world;
};

void () Admin_DoBan =
{
    bprint4 (PRINT_HIGH, self.admin_use.netname, " was banned by ", self.netname, "\n");
    BanCheater (self.admin_use);
    self.admin_mode = 0;
    self.admin_use = world;
};

void () CeaseFire_think =
{
    local entity te;

    if ((time > cb_ceasefire_time) && (self.weapon == 1) && (cease_fire == 1)) {
	cease_fire = 0;
	bprint (PRINT_HIGH, "RESUME FIRE\n");
	te = find (world, classname, "player");
	while (te) {
	    CenterPrint3 (te, "RESUME FIRE\nCalled by: ", self.owner.netname, "\n");
	    te.immune_to_check = time + 10;
	    te.tfstate = te.tfstate - (te.tfstate & 65536);
	    TeamFortress_SetSpeed (te);
	    te = find (te, classname, "player");
	}
	dremove (self);
	return;
    }
    if (!cease_fire) {
	dremove (self);
	return;
    }
    te = find (world, classname, "player");
    while (te) {
	CenterPrint3 (te, "CEASE FIRE\nCalled by: ", self.owner.netname, "\n");
	te = find (te, classname, "player");
    }
    self.nextthink = time + 5;
};

void () Admin_CeaseFire =
{
    local entity te;

    if (!cease_fire) {
	cease_fire = 1;
	bprint (PRINT_HIGH, "CEASE FIRE\n");
	te = find (world, classname, "player");
	while (te) {
	    CenterPrint3 (te, "CEASE FIRE\nCalled by: ", self.netname, "\n");
	    te.immune_to_check = time + 10;
	    te.tfstate = te.tfstate | 65536;
	    TeamFortress_SetSpeed (te);
	    te = find (te, classname, "player");
	}
	te = spawn ();
	te.owner = self;
	te.classname = "ceasefire";
	te.think = CeaseFire_think;
	te.nextthink = time + 5;
    } else {
	te = find (world, classname, "ceasefire");
	if (te)
	    dremove (te);

	cease_fire = 0;
	bprint (PRINT_HIGH, "RESUME FIRE\n");
	te = find (world, classname, "player");
	while (te) {
	    CenterPrint3 (te, "RESUME FIRE\nCalled by: ", self.netname, "\n");
	    te.immune_to_check = time + 10;
	    te.tfstate = te.tfstate - (te.tfstate & 65536);
	    TeamFortress_SetSpeed (te);
	    te = find (te, classname, "player");
	}
    }
};

void (entity p) CheckAutoKick =
{
    local float rnum;
    local entity te;

    if ((p.teamkills >= autokick_kills) && (autokick_kills != 0)) {
	bprint2 (PRINT_HIGH, p.netname, " was kicked for killing teammates.\n");
	sprint (p, PRINT_HIGH, "You were kicked for killing teammates.\n");
	KickCheater (p);
    } else if (autokick_kills != 0) {
	if (p.teamkills == (autokick_kills - 1)) {
	    sprint (p, PRINT_HIGH, "Kill one more teammate, and you're outta here.\n");
	}
	rnum = 0;
	te = find (world, classname, "ak_timer");
	while (te) {
	    if (te.owner == p) {
		rnum = 1;
		te = world;
	    } else
		te = find (te, classname, "ak_timer");
	}
	if (rnum == 0) {
	    te = spawn ();
	    te.classname = "ak_timer";
	    te.owner = p;
	    te.think = autokick_think;
	    te.nextthink = time + autokick_time;
	}
    }
};
