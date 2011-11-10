void (entity Goal, entity Player, entity Item) DisplayItemStatus;
void () TeamFortress_CheckClassStats;
void (entity Player, float Armorclass) TeamFortress_DescribeArmor;
void () TeamFortress_AmmoboxTouch;

float (float tno) num_team_ammoboxes;
void (float tno) RemoveOldAmmobox;
void (float tno) increment_team_ammoboxes;
void (float tno) decrement_team_ammoboxes;

void () TeamFortress_ExplodePerson;
void () TeamFortress_Regenerate;
void () TeamFortress_CheckforCheats;
void () TeamFortress_RegenerateCells;

void () UseSpecialSkill =
{
    local vector src;

    self.impulse = 0;
    if (self.playerclass == PC_SCOUT)
	self.impulse = TF_SCAN;
    else if (self.playerclass == PC_SNIPER)
	self.impulse = TF_AUTOZOOM;
    else if (self.playerclass == PC_SOLDIER)
	self.impulse = TF_RELOAD;
    else if (self.playerclass == PC_DEMOMAN)
	self.impulse = TF_PB_DETONATE;
    else if (self.playerclass == PC_MEDIC) {
	if (self.current_weapon == WEAP_SUPER_NAILGUN)
	    self.impulse = TF_MEDIKIT;
	else
	    self.impulse = 5;
    } else if (self.playerclass == PC_HVYWEAP) {
	if (self.current_weapon == WEAP_ASSAULT_CANNON) {
	    if ((self.tfstate & TFSTATE_AIMING) || (self.tfstate & TFSTATE_CANT_MOVE))
		sprint (self, PRINT_MEDIUM, "Cannot switch weapons while firing.\n");
	    else
		self.impulse = 3;
	} else
	    self.impulse = 7;
    } else if (self.playerclass == PC_PYRO) {
	if (self.current_weapon == WEAP_FLAMETHROWER)
	    self.impulse = 7;
	else
	    self.impulse = 6;
    } else if (self.playerclass == PC_SPY)
	self.impulse = TF_SPY_SPY;
    else if (self.playerclass == PC_ENGINEER)
	self.impulse = TF_ENGINEER_BUILD;
    else if (self.playerclass == PC_UNDEFINED) {
	if (self.enemy == world) {
	    src = self.origin + v_forward * 10;
	    src_z = self.absmin_z + self.size_z * 0.7;
	    traceline (src, src + v_forward * 2048, 0, self);
	    if ((trace_ent != world) && (trace_ent.origin != world.origin)) {
		sprint3 (self, PRINT_HIGH, "Locked onto ", trace_ent.classname, "\n");
		self.enemy = trace_ent;
		self.camdist = vlen (self.enemy.origin - self.origin);
		self.camangle = self.origin - self.enemy.origin;
		self.camangle_z = 0 - self.camangle_z;
		self.camangle = vectoangles (self.camangle);
	    }
	} else {
	    sprint (self, PRINT_HIGH, "Removed Lock\n");
	    self.enemy = world;
	}
    }
};

void () TeamFortress_ChangeClass =
{
    local entity spot;
    local entity te;
    local float tc;
    local string st;

    if (self.playerclass != 0) {
	if ((deathmatch != 3) && (cb_prematch_time < time))
	    return;

	if (TeamFortress_TeamIsCivilian (self.team_no)) {
	    sprint (self, PRINT_HIGH, "You cannot change class.\n");
	    return;
	}
	if (!IsLegalClass (self.impulse - 100)) {
	    sprint (self, PRINT_HIGH, "Your team cannot play that class.\n");
	    TeamFortress_DisplayLegalClasses ();
	    return;
	}
	if ((spy_off == 1) && ((self.impulse - 100) == 8)) {
	    sprint (self, PRINT_HIGH, "The spy class has been disabled on the server by the administrator.\n");
	    return;
	}
	if (ClassIsRestricted (self.team_no, (self.impulse - 100))) {
	    sprint (self, PRINT_HIGH, "Your team already has enough of that class.\n");
	    return;
	}
	self.nextpc = self.impulse - 100;
	sprint (self, PRINT_HIGH, "After dying, you will return as a ");
	TeamFortress_PrintClassName (self, self.nextpc, self.tfstate & 8);
	self.immune_to_check = time + 10;
	return;
    }
    if (teamplay && (self.team_no == 0)) {
	if (toggleflags & TFLAG_AUTOTEAM) {
	    if (TeamFortress_TeamPutPlayerInTeam () == 0)
		return;
	} else {
	    sprint (self, PRINT_HIGH, "You must join a team first. \n");
	    return;
	}
    }
    if (self.lives == 0) {
	sprint (self, PRINT_HIGH, "You have no lives left.\n");
	return;
    }
    if (!IsLegalClass ((self.impulse - 100)) && (self.impulse != 1)) {
	sprint (self, PRINT_HIGH, "You cannot play that playerclass on this map. \n");
	TeamFortress_DisplayLegalClasses ();
	return;
    }
    if ((spy_off == 1) && ((self.impulse - 100) == 8)) {
	sprint (self, PRINT_HIGH, "The spy class has been disabled on the server by the administrator.\n");
	return;
    }
    if (ClassIsRestricted (self.team_no, (self.impulse - 100))) {
	sprint (self, PRINT_HIGH, "Your team has enough of that class.\n");
	return;
    }
    TeamFortress_ExecClassScript (self);
    if (self.impulse != 1)
	self.playerclass = self.impulse - 100;
    else
	self.playerclass = 11;

    self.nextpc = 0;
    self.takedamage = 2;
    self.movetype = 3;
    self.flags = FL_CLIENT | FL_ONGROUND;
    self.waterlevel = 0;
    self.air_finished = time + 12;
    self.solid = 3;
    self.pausetime = 0;
    spot = SelectSpawnPoint ();
    self.origin = spot.origin + '0 0 1';
    self.angles = spot.angles;
    self.fixangle = 1;

    setmodel (self, string_null);
    modelindex_null = self.modelindex;
    setmodel (self, "progs/eyes.mdl");
    modelindex_eyes = self.modelindex;
    setmodel (self, "progs/player.mdl");
    modelindex_player = self.modelindex;
    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
    self.view_ofs = '0 0 22';
    player_stand1 ();
    if (deathmatch || coop) {
	makevectors (self.angles);
	spawn_tfog (self.origin + v_forward * 20);
    }
    if (self.playerclass == PC_RANDOM) {
	sprint (self, PRINT_HIGH, "Random Playerclass.\n");
	self.tfstate = self.tfstate | TFSTATE_RANDOMPC;
	self.playerclass = 1 + floor (random () * 9);
    }
    if ((spot.classname == "info_player_teamspawn") && (cb_prematch_time < time)) {
	if (spot.items != 0) {
	    te = Finditem (spot.items);
	    if (te)
		tfgoalitem_GiveToPlayer (te, self, self);
	    if (!(spot.goal_activation & TFSP_MULTIPLEITEMS))
		spot.items = 0;
	}
	if (spot.message) {
	    CenterPrint (self, spot.message);
	    if (!(spot.goal_activation & TFSP_MULTIPLEMSGS))
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
    spot = find (world, classname, "player");
    while (spot) {
	if ((spot.team_no == self.team_no) && (spot != self)) {
	    sprint (spot, PRINT_HIGH, self.netname, " is playing as a ");
	    TeamFortress_PrintClassName (spot, self.playerclass, self.tfstate & 8);
	}
	spot = find (spot, classname, "player");
    }
    TeamFortress_PrintClassName (self, self.playerclass, (self.tfstate & 8));
    TeamFortress_SetEquipment ();
    TeamFortress_SetHealth ();
    TeamFortress_SetSpeed (self);
    TeamFortress_SetSkin (self);
    TeamFortress_ExecClassScript (self);
    if (cease_fire) {
	sprint (self, PRINT_HIGH, "\n\nCEASE FIRE MODE\n");
	self.immune_to_check = time + 10;
	self.tfstate = self.tfstate | TFSTATE_CANT_MOVE;
	TeamFortress_SetSpeed (self);
    }
};

void () TeamFortress_DisplayLegalClasses =
{
    local float gotone;
    local float ill;

    sprint (self, PRINT_HIGH, "Legal Classes for your team are:\n");
    gotone = 0;
    ill = TeamFortress_TeamGetIllegalClasses (self.team_no);
    if (!(illegalclasses & 1) && !(ill & 1)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Scout");
    }
    if (!(illegalclasses & 2) && !(ill & 2)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Sniper");
    }
    if (!(illegalclasses & 4) && !(ill & 4)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Soldier");
    }
    if (!(illegalclasses & 8) && !(ill & 8)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Demolitions Man");
    }
    if (!(illegalclasses & 16) && !(ill & 16)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Combat Medic");
    }
    if (!(illegalclasses & 32) && !(ill & 32)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Heavy Weapons Guy");
    }
    if (!(illegalclasses & 64) && !(ill & 64)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Pyro");
    }
    if (!(illegalclasses & 256) && !(ill & 256)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Spy");
    }
    if (!(illegalclasses & 512) && !(ill & 512)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "Engineer");
    }
    if (!(illegalclasses & 128) && !(ill & 128)) {
	if (gotone) {
	    sprint (self, PRINT_HIGH, ", ");
	}
	gotone = 1;
	sprint (self, PRINT_HIGH, "RandomPC");
    }
    sprint (self, PRINT_HIGH, "\n");
};

void () TeamFortress_Inventory =
{
    local entity tg;
    local string ac;
    local float col;

    col = TeamFortress_TeamGetColor (self.team_no);
    sprint (self, PRINT_HIGH, "You're in team ");
    ac = ftos (self.team_no);
    sprint (self, PRINT_HIGH, ac, ", color ");
    ac = ftos (col);
    sprint (self, PRINT_HIGH, ac, ".\n");
    if (self.lives != -1) {
	ac = ftos (self.lives);
	sprint (self, PRINT_HIGH, "You've got ", ac);
	if (self.lives == 1)
	    sprint (self, PRINT_HIGH, " life.\n");
	else
	    sprint (self, PRINT_HIGH, " lives.\n");
    }
    if (self.no_grenades_1 > 0) {
	sprint (self, PRINT_HIGH, "Gren.Type 1 : ");
	if (self.tp_grenades_1 == GR_TYPE_NORMAL)
	    sprint (self, PRINT_HIGH, " Normal(");
	else if (self.tp_grenades_1 == GR_TYPE_CONCUSSION)
	    sprint (self, PRINT_HIGH, " Concussion(");
	else if (self.tp_grenades_1 == GR_TYPE_NAIL)
	    sprint (self, PRINT_HIGH, " Nail(");
	else if (self.tp_grenades_1 == GR_TYPE_MIRV)
	    sprint (self, PRINT_HIGH, " Mirv(");
	else if (self.tp_grenades_1 == GR_TYPE_NAPALM)
	    sprint (self, PRINT_HIGH, " Napalm(");
	else if (self.tp_grenades_1 == GR_TYPE_FLARE)
	    sprint (self, PRINT_HIGH, " Flare(");
	else if (self.tp_grenades_1 == GR_TYPE_GAS)
	    sprint (self, PRINT_HIGH, " Hallucinogenic(");
	else if (self.tp_grenades_1 == GR_TYPE_EMP)
	    sprint (self, PRINT_HIGH, " EMP(");
	else if (self.tp_grenades_1 == GR_TYPE_CALTROP)
	    sprint (self, PRINT_HIGH, " Caltrop(");
	else if (self.tp_grenades_1 == GR_TYPE_FLASH)
	    sprint (self, PRINT_HIGH, " Flash(");
	else
	    sprint (self, PRINT_HIGH, "BUG(");

	ac = ftos (self.no_grenades_1);
	sprint (self, PRINT_HIGH, ac, ")\n");
    }
    if (self.no_grenades_2 > 0) {
	sprint (self, PRINT_HIGH, "Gren.Type 2 : ");
	if (self.tp_grenades_2 == GR_TYPE_NORMAL)
	    sprint (self, PRINT_HIGH, " Normal(");
	else if (self.tp_grenades_2 == GR_TYPE_CONCUSSION)
	    sprint (self, PRINT_HIGH, " Concussion(");
	else if (self.tp_grenades_2 == GR_TYPE_NAIL)
	    sprint (self, PRINT_HIGH, " Nail(");
	else if (self.tp_grenades_2 == GR_TYPE_MIRV)
	    sprint (self, PRINT_HIGH, " Mirv(");
	else if (self.tp_grenades_2 == GR_TYPE_NAPALM)
	    sprint (self, PRINT_HIGH, " Napalm(");
	else if (self.tp_grenades_2 == GR_TYPE_FLARE)
	    sprint (self, PRINT_HIGH, " Flare(");
	else if (self.tp_grenades_2 == GR_TYPE_GAS)
	    sprint (self, PRINT_HIGH, " Hallucinogenic(");
	else if (self.tp_grenades_2 == GR_TYPE_EMP)
	    sprint (self, PRINT_HIGH, " EMP(");
	else if (self.tp_grenades_2 == GR_TYPE_FLASH)
	    sprint (self, PRINT_HIGH, " Flash(");
	else
	    sprint (self, PRINT_HIGH, "BUG(");

	ac = ftos (self.no_grenades_2);
	sprint (self, PRINT_HIGH, ac, ")\n");
    }
    if (self.tf_items & NIT_SCANNER)
	sprint (self, PRINT_HIGH, "Scanner. ");

    if (self.weapons_carried & WEAP_MEDIKIT) {
	sprint (self, PRINT_HIGH, "Medikit (");
	ac = ftos (self.ammo_medikit);
	sprint (self, PRINT_HIGH, ac, ") ");
    }
    if (self.weapons_carried & WEAP_DETPACK) {
	if (self.ammo_detpack > 0) {
	    ac = ftos (self.ammo_detpack);
	    sprint (self, PRINT_HIGH, ac, " Detpack");
	    if (self.ammo_detpack > 1)
		sprint (self, PRINT_HIGH, "s");
	    sprint (self, PRINT_HIGH, ". ");
	}
    }
    tg = find (world, classname, "item_tfgoal");
    while (tg) {
	if (tg.owner == self) {
	    sprint (self, PRINT_HIGH, tg.netname, ". ");
	}
	tg = find (tg, classname, "item_tfgoal");
    }
    if (self.armorvalue > 0)
	TeamFortress_DescribeArmor (self, self.armorclass);

    if (!invis_only) {
	if ((self.playerclass == PC_SPY) && (invis_only == 0)) {
	    sprint (self, PRINT_HIGH, "Skin : ");
	    if (self.undercover_skin != 0)
		TeamFortress_PrintClassName (self, self.undercover_skin, 0);
	    else
		sprint (self, PRINT_HIGH, "Spy\n");
	    sprint (self, PRINT_HIGH, "Colors : Team ");
	    if (self.undercover_team != 0)
		ac = ftos (self.undercover_team);
	    else
		ac = ftos (self.team_no);
	    sprint (self, PRINT_HIGH, ac);
	}
    }
    sprint (self, PRINT_HIGH, "\n");
};

void () TeamFortress_ShowTF =
{
    local string st;

    if (toggleflags & TFLAG_CLASS_PERSIST)
	sprint (self, PRINT_HIGH, "Class Persistence On.\n");
    else
	sprint (self, PRINT_HIGH, "Class Persistence Off.\n");

    if (toggleflags & TFLAG_CHEATCHECK)
	sprint (self, PRINT_HIGH, "Cheat Checking On.\n");
    else
	sprint (self, PRINT_HIGH, "Cheat Checking Off.\n");

    if (toggleflags & TFLAG_AUTOTEAM)
	sprint (self, PRINT_HIGH, "AutoTeam On.\n");
    else
	sprint (self, PRINT_HIGH, "AutoTeam Off.\n");

    if (toggleflags & TFLAG_RESPAWNDELAY)
	st = ftos (respawn_delay_time);
    else
	st = "No";
    sprint (self, PRINT_HIGH, st);
    if (st != "No")
	sprint (self, PRINT_HIGH, " second");
    sprint (self, PRINT_HIGH, " Respawn Delay.\n");

    if (toggleflags & TFLAG_TEAMFRAGS)
	sprint (self, PRINT_HIGH, "TeamFrags On.\n");
    else
	sprint (self, PRINT_HIGH, "TeamFrags Off.\n");

    if (allow_hook)
	sprint (self, PRINT_HIGH, "Grapple On.\n");
    else
	sprint (self, PRINT_HIGH, "Grapple Off.\n");

    if (toggleflags & TFLAG_FULLTEAMSCORE)
	sprint (self, PRINT_HIGH, "Full TeamScore On.\n");
    else
	sprint (self, PRINT_HIGH, "Full TeamScore Off.\n");
};

void () TeamFortress_GrenadePrimed;

void () TeamFortress_PrimeGrenade =
{
    local float gtype;
    local string gs;
    local string ptime;
    local entity tGrenade;

    if ((self.tfstate & TFSTATE_GRENPRIMED) || (self.tfstate & TFSTATE_GRENTHROWING))
	return;

    if (self.impulse == TF_GRENADE_1) {
	gtype = self.tp_grenades_1;

	if (self.tp_grenades_1 == 2)
	    gs = "Concussion grenade";
	else if (self.tp_grenades_1 == 3)
	    gs = "Nail grenade";
	else if (self.tp_grenades_1 == 4)
	    gs = "Mirv grenade";
	else if (self.tp_grenades_1 == 5)
	    gs = "Napalm grenade";
	else if (self.tp_grenades_1 == 6)
	    gs = "Flare";
	else if (self.tp_grenades_1 == 7)
	    gs = "Gas grenade";
	else if (self.tp_grenades_1 == 8)
	    gs = "EMP grenade";
	else if (self.tp_grenades_1 == 10)
	    gs = "Caltrop canister";
	else if (self.tp_grenades_1 == 9)
	    gs = "Flash grenade";
	else
	    gs = "Grenade";

	if (self.no_grenades_1 > 0) {
	    self.no_grenades_1 = self.no_grenades_1 - 1;
	    if (gtype == 6) {
		newmis = spawn ();
		newmis.owner = self;
		newmis.movetype = 6;
		newmis.solid = 2;
		newmis.classname = "grenade";
		makevectors (self.v_angle);
		newmis.velocity = (v_forward * 600) + (v_up * 25);
		newmis.velocity = newmis.velocity * 700;
		newmis.angles = vectoangles (newmis.velocity);
		newmis.weapon = self.team_no;
		newmis.think = FlareGrenadeExplode;
		newmis.nextthink = time + 0.8;
		newmis.touch = FlareGrenadeTouch;
		newmis.skin = 1;
		newmis.mdl = "flare";
		setmodel (newmis, "progs/flare.mdl");
		setsize (newmis, '0 0 0', '0 0 0');
		setorigin (newmis, self.origin);
		return;
	    }
	    if (gtype == GR_TYPE_CALTROP) {
		ptime = ftos (0.5);
		sprint (self, PRINT_HIGH, "Opening ", gs, "...\n");
	    } else {
		ptime = ftos (3);
		sprint (self, PRINT_HIGH, gs, " primed, ", ptime, " seconds...\n");
	    }
	} else {
	    sprint (self, PRINT_HIGH, "No ", gs, "s left.\n");
	    return;
	}
    }
    if (self.impulse == TF_GRENADE_2) {
	gtype = self.tp_grenades_2;

	if (self.tp_grenades_2 == 2)
	    gs = "Concussion grenade";
	else if (self.tp_grenades_2 == 3)
	    gs = "Nail grenade";
	else if (self.tp_grenades_2 == 4)
	    gs = "Mirv grenade";
	else if (self.tp_grenades_2 == 5)
	    gs = "Napalm grenade";
	else if (self.tp_grenades_2 == 6)
	    gs = "Flare";
	else if (self.tp_grenades_2 == 7)
	    gs = "Gas grenade";
	else if (self.tp_grenades_2 == 8)
	    gs = "EMP grenade";
	else if (self.tp_grenades_2 == 9)
	    gs = "Flash grenade";
	else
	    gs = "Grenade";

	if (self.no_grenades_2 > 0) {
	    self.no_grenades_2 = self.no_grenades_2 - 1;
	    if (gtype == 6) {
		newmis = spawn ();
		newmis.owner = self;
		newmis.movetype = 6;
		newmis.solid = 2;
		newmis.classname = "grenade";
		makevectors (self.v_angle);
		if (self.v_angle_x) {
		    newmis.velocity = v_forward * 1200 + v_up * 200;
		} else {
		    newmis.velocity = aim (self, 10000);
		    newmis.velocity = newmis.velocity * 1200;
		    newmis.velocity_z = 75;
		}
		newmis.angles = vectoangles (newmis.velocity);
		newmis.weapon = self.team_no;
		newmis.think = FlareGrenadeExplode;
		newmis.nextthink = time + 0.8;
		newmis.touch = FlareGrenadeTouch;
		newmis.skin = 1;
		newmis.mdl = "flare";
		setmodel (newmis, "progs/flare.mdl");
		setsize (newmis, '0 0 0', '0 0 0');
		setorigin (newmis, self.origin);
		return;
	    }
	    if (gtype == GR_TYPE_CALTROP) {
		ptime = ftos (0.5);
		sprint (self, PRINT_HIGH, "Opening ", gs, "...\n");
	    } else {
		ptime = ftos (3);
		sprint (self, PRINT_HIGH, gs, " primed, ", ptime, " seconds...\n");
	    }
	} else {
	    sprint (self, PRINT_HIGH, "No ", gs, "s left.\n");
	    return;
	}
    }
    self.tfstate = self.tfstate | 1;
    tGrenade = spawn ();
    tGrenade.owner = self;
    tGrenade.weapon = gtype;
    tGrenade.classname = "timer";
    tGrenade.impulse = self.impulse;
    tGrenade.nextthink = time + 0.8;

    if (gtype == GR_TYPE_CALTROP)
	tGrenade.heat = time + 0.5 + 0.5;
    else
	tGrenade.heat = time + 3 + 0.8;

    tGrenade.think = TeamFortress_GrenadePrimed;
};

void () TeamFortress_GrenadePrimed =
{
    local entity user;
    local entity oldself;

    user = self.owner;
    if (!(user.tfstate & 1024) && !user.deadflag) {
	self.nextthink = time + 0.1;
	if (!self.think)
	    dremove (self);

	if (time > self.heat)
	    TeamFortress_ExplodePerson ();

	return;
    }
    if (!(user.tfstate & 1))
	dprint ("GrenadePrimed logic error\n");

    user.tfstate = user.tfstate - (user.tfstate & TFSTATE_GRENPRIMED);
    user.tfstate = user.tfstate - (user.tfstate & TFSTATE_GRENTHROWING);
    sound (user, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
    KickPlayer (-1, user);
    newmis = spawn ();
    newmis.owner = user;
    newmis.movetype = 10;
    newmis.solid = 2;
    newmis.classname = "grenade";
    makevectors (user.v_angle);
    if (user.deadflag) {
	newmis.velocity = '0 0 200';
    } else if (user.v_angle_x) {
	newmis.velocity = v_forward * 600 + v_up * 200 + crandom () * v_right * 10 + crandom () * v_up * 10;
    } else {
	newmis.velocity = aim (user, 10000);
	newmis.velocity = newmis.velocity * 600;
	newmis.velocity_z = 200;
    }
    newmis.angles = vectoangles (newmis.velocity);
    newmis.think = SUB_Null;
    newmis.nextthink = self.heat;
    if (self.weapon == GR_TYPE_NORMAL) {
	newmis.touch = NormalGrenadeTouch;
	newmis.think = NormalGrenadeExplode;
	newmis.skin = 0;
	newmis.avelocity = '300 300 300';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/hgren2.mdl");
	}
    } else if (self.weapon == GR_TYPE_CONCUSSION) {
	newmis.touch = ConcussionGrenadeTouch;
	newmis.think = ConcussionGrenadeExplode;
	newmis.skin = 1;
	newmis.avelocity = '300 300 300';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/hgren2.mdl");
	}
    } else if (self.weapon == GR_TYPE_NAIL) {
	newmis.touch = NailGrenadeTouch;
	newmis.think = NailGrenadeExplode;
	newmis.skin = 1;
	newmis.avelocity = '0 300 0';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/biggren.mdl");
	}
    } else if (self.weapon == GR_TYPE_MIRV) {
	newmis.touch = MirvGrenadeTouch;
	newmis.think = MirvGrenadeExplode;
	newmis.skin = 0;
	newmis.avelocity = '0 300 0';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/biggren.mdl");
	}
    } else if (self.weapon == GR_TYPE_NAPALM) {
	newmis.touch = NapalmGrenadeTouch;
	newmis.think = NapalmGrenadeExplode;
	newmis.skin = 2;
	newmis.avelocity = '0 300 0';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/biggren.mdl");
	}
    } else if (self.weapon == GR_TYPE_FLARE) {
	newmis.touch = FlareGrenadeTouch;
	newmis.weapon = self.team_no;
	newmis.think = FlareGrenadeExplode;
	newmis.skin = 1;
	newmis.avelocity = '300 300 300';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    newmis.mdl = "flare";
	}
	setmodel (newmis, "progs/flare.mdl");
    } else if (self.weapon == GR_TYPE_GAS) {
	newmis.touch = GasGrenadeTouch;
	newmis.think = GasGrenadeExplode;
	newmis.skin = 3;
	newmis.avelocity = '300 300 300';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/grenade2.mdl");
	}
    } else if (self.weapon == GR_TYPE_EMP) {
	newmis.touch = EMPGrenadeTouch;
	newmis.think = EMPGrenadeExplode;
	newmis.skin = 4;
	newmis.avelocity = '300 300 300';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/grenade2.mdl");
	}
    } else if (self.weapon == GR_TYPE_CALTROP) {
	newmis.touch = CanisterTouch;
	newmis.think = ScatterCaltrops;
	newmis.skin = 0;
	newmis.avelocity = '0 0 0';
    } else if (self.weapon == GR_TYPE_FLASH) {
	newmis.touch = FlashGrenadeTouch;
	newmis.think = FlashGrenadeExplode;
	newmis.skin = 2;
	newmis.avelocity = '300 300 300';
	if ((birthday == 1) && (random () < 0.6)) {
	    setmodel (newmis, "progs/grenade3.mdl");
	} else {
	    setmodel (newmis, "progs/hgren2.mdl");
	}
    }
    setsize (newmis, '0 0 0', '0 0 0');
    setorigin (newmis, user.origin);
    oldself = self;
    self = self.owner;
    self = oldself;
    dremove (self);
};

void () TeamFortress_ThrowGrenade =
{
    if (!(self.tfstate & TFSTATE_GRENPRIMED))
	return;

    self.tfstate = self.tfstate | TFSTATE_GRENTHROWING;
};

float (float pc) IsLegalClass =
{
    local float bit;

    if ((spy_off == TRUE) && (pc == PC_SPY))
	return (FALSE);

    if (pc == PC_SCOUT)
	bit = TF_ILL_SCOUT;
    else if (pc == PC_SNIPER)
	bit = TF_ILL_SNIPER;
    else if (pc == PC_SOLDIER)
	bit = TF_ILL_SOLDIER;
    else if (pc == PC_DEMOMAN)
	bit = TF_ILL_DEMOMAN;
    else if (pc == PC_MEDIC)
	bit = TF_ILL_MEDIC;
    else if (pc == PC_HVYWEAP)
	bit = TF_ILL_HVYWEP;
    else if (pc == PC_PYRO)
	bit = TF_ILL_PYRO;
    else if (pc == PC_SPY)
	bit = TF_ILL_SPY;
    else if (pc == PC_ENGINEER)
	bit = TF_ILL_ENGINEER;
    else if (pc == PC_RANDOM)
	bit = TF_ILL_RANDOMPC;

    if ((illegalclasses & bit) || (TeamFortress_TeamGetIllegalClasses (self.team_no) & bit))
	return (FALSE);

    return (TRUE);
};

void (entity p) TeamFortress_SetSpeed =
{
    local string sp;
    local float tf;
    local entity te;

    stuffcmd (p, "cl_movespeedkey 1\n");
    if (p.tfstate & TFSTATE_CANT_MOVE) {
#ifdef STOP_MOUSE_MOVEMENT
	stuffcmd (p, "m_forward 0\n");
	stuffcmd (p, "m_side 0\n");
#endif
	p.velocity = '0 0 0';
	stuffcmd (p, "cl_backspeed 0\n");
	stuffcmd (p, "cl_forwardspeed 0\n");
	stuffcmd (p, "cl_sidespeed 0\n");
	p.maxspeed = 0;
	return;
    }
#ifdef STOP_MOUSE_MOVEMENT
    else {
	stuffcmd(p,"m_forward 1\n");
	stuffcmd(p,"m_side 0.8\n");
    }
#endif
    if (p.playerclass == PC_SCOUT) {
	p.maxfbspeed = PC_SCOUT_MAXSPEED;
	p.maxstrafespeed = PC_SCOUT_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_SNIPER) {
	p.maxfbspeed = PC_SNIPER_MAXSPEED;
	p.maxstrafespeed = PC_SNIPER_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_SOLDIER) {
	p.maxfbspeed = PC_SOLDIER_MAXSPEED;
	p.maxstrafespeed = PC_SOLDIER_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_DEMOMAN) {
	p.maxfbspeed = PC_DEMOMAN_MAXSPEED;
	p.maxstrafespeed = PC_DEMOMAN_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_MEDIC) {
	p.maxfbspeed = PC_MEDIC_MAXSPEED;
	p.maxstrafespeed = PC_MEDIC_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_HVYWEAP) {
	p.maxfbspeed = PC_HVYWEAP_MAXSPEED;
	p.maxstrafespeed = PC_HVYWEAP_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_PYRO) {
	p.maxfbspeed = PC_PYRO_MAXSPEED;
	p.maxstrafespeed = PC_PYRO_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_CIVILIAN) {
	p.maxfbspeed = PC_CIVILIAN_MAXSPEED;
	p.maxstrafespeed = PC_CIVILIAN_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_SPY) {
	p.maxfbspeed = PC_SPY_MAXSPEED;
	p.maxstrafespeed = PC_SPY_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_ENGINEER) {
	p.maxfbspeed = PC_ENGINEER_MAXSPEED;
	p.maxstrafespeed = PC_ENGINEER_MAXSTRAFESPEED;
    } else if (p.playerclass == PC_UNDEFINED) {
//	p.maxfbspeed = 320;
//	p.maxstrafespeed = 320;
	p.maxfbspeed = 0;
	p.maxstrafespeed = 0;
	p.maxspeed = 0;
	return;
    }
    tf = 0;
    te = find (world, classname, "item_tfgoal");
    while ((te != world) && (tf == 0)) {
	if (te.owner == p) {
	    if (te.goal_activation & TFGI_SLOW) {
		tf = 1;
		p.maxfbspeed = p.maxfbspeed / 2;
		p.maxstrafespeed = p.maxstrafespeed / 2;
	    }
	}
	te = find (te, classname, "item_tfgoal");
    }
    if (p.tfstate & TFSTATE_TRANQUILISED) {
	p.maxfbspeed = p.maxfbspeed / 2;
	p.maxstrafespeed = p.maxstrafespeed / 2;
    }
    if (p.leg_damage) {
	if (p.leg_damage > 6) {
	    p.leg_damage = 6;
	}
	p.maxfbspeed = p.maxfbspeed * (10 - p.leg_damage) / 10;
	p.maxstrafespeed = p.maxstrafespeed * (10 - p.leg_damage) / 10;
    }
    if (p.tfstate & TFSTATE_AIMING) {
	if (p.maxfbspeed > 80) {
	    p.maxfbspeed = 80;
	}
	if (p.maxstrafespeed > 80) {
	    p.maxstrafespeed = 80;
	}
    }
    sp = ftos (p.maxfbspeed);
    stuffcmd (p, "cl_backspeed ");
    stuffcmd (p, sp);
    stuffcmd (p, "\n");
    stuffcmd (p, "cl_forwardspeed ");
    stuffcmd (p, sp);
    stuffcmd (p, "\n");
    sp = ftos (p.maxstrafespeed);
    stuffcmd (p, "cl_sidespeed ");
    stuffcmd (p, sp);
    stuffcmd (p, "\n");
    p.maxspeed = p.maxfbspeed;
};

void () TeamFortress_SetHealth =
{
    if (self.playerclass == PC_SCOUT) {
	self.max_health = PC_SCOUT_MAXHEALTH;
    } else if (self.playerclass == PC_SNIPER) {
	self.max_health = PC_SNIPER_MAXHEALTH;
    } else if (self.playerclass == PC_SOLDIER) {
	self.max_health = PC_SOLDIER_MAXHEALTH;
    } else if (self.playerclass == PC_DEMOMAN) {
	self.max_health = PC_DEMOMAN_MAXHEALTH;
    } else if (self.playerclass == PC_MEDIC) {
	self.max_health = PC_MEDIC_MAXHEALTH;
    } else if (self.playerclass == PC_HVYWEAP) {
	self.max_health = PC_HVYWEAP_MAXHEALTH;
    } else if (self.playerclass == PC_PYRO) {
	self.max_health = PC_PYRO_MAXHEALTH;
    } else if (self.playerclass == PC_CIVILIAN) {
	self.max_health = PC_CIVILIAN_MAXHEALTH;
    } else if (self.playerclass == PC_SPY) {
	self.max_health = PC_SPY_MAXHEALTH;
    } else if (self.playerclass == PC_ENGINEER) {
	self.max_health = PC_ENGINEER_MAXHEALTH;
    } else {
	self.max_health = 1;
	self.takedamage = DAMAGE_NO;
    }
    self.health = self.max_health;
};

string (entity p) TeamFortress_GetSkin =
{
    local float tn;
    local float pc;
    local string st;

    if ((p.playerclass == 11) || (p.team_no == 0)) {
	return ( "base" );
    }
    tn = p.team_no;
    pc = p.playerclass;
    if (p.playerclass == 8) {
	if (p.undercover_team != 0) {
	    tn = p.undercover_team;
	}
	if (p.undercover_skin != 0) {
	    pc = p.undercover_skin;
	}
    }
    if (tn == 4) {
	if (pc == 1) {
	    st = infokey (world, "sk_t4_scout");
	    if (st != string_null) {
		return ( st );
	    }
	    return ( "tf_scout" );
	} else {
	    if (pc == 2) {
		st = infokey (world, "sk_t4_sniper");
		if (st != string_null) {
		    return ( st );
		}
		return ( "tf_snipe" );
	    } else {
		if (pc == 3) {
		    st = infokey (world, "sk_t4_soldier");
		    if (st != string_null) {
			return ( st );
		    }
		    return ( "tf_sold" );
		} else {
		    if (pc == 4) {
			st = infokey (world, "sk_t4_demoman");
			if (st != string_null) {
			    return ( st );
			}
			return ( "tf_demo" );
		    } else {
			if (pc == 5) {
			    st = infokey (world, "sk_t4_medic");
			    if (st != string_null) {
				return ( st );
			    }
			    return ( "tf_medic" );
			} else {
			    if (pc == 6) {
				st = infokey (world, "sk_t4_hwguy");
				if (st != string_null) {
				    return ( st );
				}
				return ( "tf_hwguy" );
			    } else {
				if (pc == 7) {
				    st = infokey (world, "sk_t4_pyro");
				    if (st != string_null) {
					return ( st );
				    }
				    return ( "tf_pyro" );
				} else {
				    if (pc == 8) {
					st = infokey (world, "sk_t4_spy");
					if (st != string_null) {
					    return ( st );
					}
					return ( "tf_spy" );
				    } else {
					if (pc == 9) {
					    st = infokey (world, "sk_t4_engineer");
					    if (st != string_null) {
						return ( st );
					    }
					    return ( "tf_eng" );
					}
				    }
				}
			    }
			}
		    }
		}
	    }
	}
    } else {
	if (tn == 3) {
	    if (pc == 1) {
		st = infokey (world, "sk_t3_scout");
		if (st != string_null) {
		    return ( st );
		}
		return ( "tf_scout" );
	    } else {
		if (pc == 2) {
		    st = infokey (world, "sk_t3_sniper");
		    if (st != string_null) {
			return ( st );
		    }
		    return ( "tf_snipe" );
		} else {
		    if (pc == 3) {
			st = infokey (world, "sk_t3_soldier");
			if (st != string_null) {
			    return ( st );
			}
			return ( "tf_sold" );
		    } else {
			if (pc == 4) {
			    st = infokey (world, "sk_t3_demoman");
			    if (st != string_null) {
				return ( st );
			    }
			    return ( "tf_demo" );
			} else {
			    if (pc == 5) {
				st = infokey (world, "sk_t3_medic");
				if (st != string_null) {
				    return ( st );
				}
				return ( "tf_medic" );
			    } else {
				if (pc == 6) {
				    st = infokey (world, "sk_t3_hwguy");
				    if (st != string_null) {
					return ( st );
				    }
				    return ( "tf_hwguy" );
				} else {
				    if (pc == 7) {
					st = infokey (world, "sk_t3_pyro");
					if (st != string_null) {
					    return ( st );
					}
					return ( "tf_pyro" );
				    } else {
					if (pc == 8) {
					    st = infokey (world, "sk_t3_spy");
					    if (st != string_null) {
						return ( st );
					    }
					    return ( "tf_spy" );
					} else {
					    if (pc == 9) {
						st = infokey (world, "sk_t3_engineer");
						if (st != string_null) {
						    return ( st );
						}
						return ( "tf_eng" );
					    }
					}
				    }
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (tn == 2) {
		if (pc == 1) {
		    st = infokey (world, "sk_t2_scout");
		    if (st != string_null) {
			return ( st );
		    }
		    return ( "tf_scout" );
		} else {
		    if (pc == 2) {
			st = infokey (world, "sk_t2_sniper");
			if (st != string_null) {
			    return ( st );
			}
			return ( "tf_snipe" );
		    } else {
			if (pc == 3) {
			    st = infokey (world, "sk_t2_soldier");
			    if (st != string_null) {
				return ( st );
			    }
			    return ( "tf_sold" );
			} else {
			    if (pc == 4) {
				st = infokey (world, "sk_t2_demoman");
				if (st != string_null) {
				    return ( st );
				}
				return ( "tf_demo" );
			    } else {
				if (pc == 5) {
				    st = infokey (world, "sk_t2_medic");
				    if (st != string_null) {
					return ( st );
				    }
				    return ( "tf_medic" );
				} else {
				    if (pc == 6) {
					st = infokey (world, "sk_t2_hwguy");
					if (st != string_null) {
					    return ( st );
					}
					return ( "tf_hwguy" );
				    } else {
					if (pc == 7) {
					    st = infokey (world, "sk_t2_pyro");
					    if (st != string_null) {
						return ( st );
					    }
					    return ( "tf_pyro" );
					} else {
					    if (pc == 8) {
						st = infokey (world, "sk_t2_spy");
						if (st != string_null) {
						    return ( st );
						}
						return ( "tf_spy" );
					    } else {
						if (pc == 9) {
						    st = infokey (world, "sk_t2_engineer");
						    if (st != string_null) {
							return ( st );
						    }
						    return ( "tf_eng" );
						}
					    }
					}
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (pc == 1) {
		    st = infokey (world, "sk_t1_scout");
		    if (st != string_null) {
			return ( st );
		    }
		    return ( "tf_scout" );
		} else {
		    if (pc == 2) {
			st = infokey (world, "sk_t1_sniper");
			if (st != string_null) {
			    return ( st );
			}
			return ( "tf_snipe" );
		    } else {
			if (pc == 3) {
			    st = infokey (world, "sk_t1_soldier");
			    if (st != string_null) {
				return ( st );
			    }
			    return ( "tf_sold" );
			} else {
			    if (pc == 4) {
				st = infokey (world, "sk_t1_demoman");
				if (st != string_null) {
				    return ( st );
				}
				return ( "tf_demo" );
			    } else {
				if (pc == 5) {
				    st = infokey (world, "sk_t1_medic");
				    if (st != string_null) {
					return ( st );
				    }
				    return ( "tf_medic" );
				} else {
				    if (pc == 6) {
					st = infokey (world, "sk_t1_hwguy");
					if (st != string_null) {
					    return ( st );
					}
					return ( "tf_hwguy" );
				    } else {
					if (pc == 7) {
					    st = infokey (world, "sk_t1_pyro");
					    if (st != string_null) {
						return ( st );
					    }
					    return ( "tf_pyro" );
					} else {
					    if (pc == 8) {
						st = infokey (world, "sk_t1_spy");
						if (st != string_null) {
						    return ( st );
						}
						return ( "tf_spy" );
					    } else {
						if (pc == 9) {
						    st = infokey (world, "sk_t1_engineer");
						    if (st != string_null) {
							return ( st );
						    }
						    return ( "tf_eng" );
						}
					    }
					}
				    }
				}
			    }
			}
		    }
		}
	    }
	}
    }
};

void (entity p) TeamFortress_SetSkin =
{
    local string st;
    local float tn;

    p.immune_to_check = time + 10;
    if ((p.playerclass == PC_SPY) && (p.undercover_skin != 0))
	p.skin = p.undercover_skin;
    else
	p.skin = p.playerclass;

    if (p.skin != 0) {
	stuffcmd (p, "skin ");
	st = TeamFortress_GetSkin (p);
	stuffcmd (p, st);
	stuffcmd (p, "\n");
    } else
	stuffcmd (p, "skin base\n");
};

void () TeamFortress_SetEquipment =
{
    local entity te;
    local string st;
    local float kept_items;

    if (self.classname != "player")
	return;

    kept_items = self.tf_items & (IT_KEY1 | IT_KEY2);
    
    self.items = 0;
    self.current_weapon = 0;
    self.weapons_carried = 0;
    self.last_weapon = 0;
    self.last_weaponmode = 0;

    self.tf_items = 0;
    if (self.playerclass != PC_SCOUT)
	self.tf_items_flags = 0;

    self.armorclass = 0;
    self.impulse = 0;

    self.undercover_skin = 0;
    if (self.undercover_team != 0) {
	self.immune_to_check = time + 10;
	self.undercover_team = 0;
	stuffcmd (self, "color ");
	st = ftos (TeamFortress_TeamGetColor (self.team_no) - 1);
	stuffcmd (self, st);
	stuffcmd (self, "\n");
    }
    self.is_building = 0;
    self.is_detpacking = 0;
    self.is_undercover = 0;
    self.is_feigning = 0;
    self.is_unabletospy = 0;

    self.ammo_medikit = 0;
    self.maxammo_medikit = 0;
    self.ammo_detpack = 0;
    self.maxammo_detpack = 0;
    self.items_allowed = 0;
    self.armor_allowed = 0;
    self.maxarmor = 0;
    self.weaponmode = 0;
    self.respawn_time = 0;
    self.heat = 0;
    self.tfstate = self.tfstate - (self.tfstate & TFSTATE_RELOADING);

    if (self.team_no == 0)
	self.lives = -1;

    self.items = self.items | kept_items;

    if (self.playerclass == PC_SCOUT) {
	self.weapons_carried = self.weapons_carried | PC_SCOUT_WEAPONS;
	self.ammo_rockets = PC_SCOUT_INITAMMO_ROCKET;
	self.ammo_nails = PC_SCOUT_INITAMMO_NAIL;
	self.ammo_shells = PC_SCOUT_INITAMMO_SHOT;
	self.ammo_cells = PC_SCOUT_INITAMMO_CELL;
	self.maxammo_rockets = PC_SCOUT_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_SCOUT_MAXAMMO_NAIL;
	self.maxammo_shells = PC_SCOUT_MAXAMMO_SHOT;
	self.maxammo_cells = PC_SCOUT_MAXAMMO_CELL;
	self.no_grenades_1 = PC_SCOUT_GRENADE_INIT_1;
	self.no_grenades_2 = PC_SCOUT_GRENADE_INIT_2;

	if (old_grens == 1)
	    self.tp_grenades_1 = GR_TYPE_FLASH;
	else
	    self.tp_grenades_1 = GR_TYPE_CALTROP;

	self.tp_grenades_2 = GR_TYPE_CONCUSSION;

	self.tf_items = PC_SCOUT_TF_ITEMS;
	self.ScannerOn = 0;

	if (self.tf_items_flags <= 0)
	    self.tf_items_flags = self.tf_items_flags | NIT_SCANNER_ENEMY;

	self.armorclass = self.armorclass | 0;
	self.armortype = PC_SCOUT_INITARMORTYPE;
	self.armorvalue = PC_SCOUT_INITARMOR;
	self.armor_allowed = PC_SCOUT_MAXARMORTYPE;
	self.maxarmor = PC_SCOUT_MAXARMOR;
	self.current_weapon = WEAP_NAILGUN;

	self.items_allowed = PC_SCOUT_WEAPONS;

	self.items = self.items | IT_SHOTGUN | IT_NAILGUN;
    } else if (self.playerclass == PC_SNIPER) {
	self.weapons_carried = self.weapons_carried | PC_SNIPER_WEAPONS;
	self.ammo_rockets = PC_SNIPER_INITAMMO_ROCKET;
	self.ammo_nails = PC_SNIPER_INITAMMO_NAIL;
	self.ammo_shells = PC_SNIPER_INITAMMO_SHOT;
	self.ammo_cells = PC_SNIPER_INITAMMO_CELL;
	self.maxammo_rockets = PC_SNIPER_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_SNIPER_MAXAMMO_NAIL;
	self.maxammo_shells = PC_SNIPER_MAXAMMO_SHOT;
	self.maxammo_cells = PC_SNIPER_MAXAMMO_CELL;

	self.no_grenades_1 = PC_SNIPER_GRENADE_INIT_1;
	self.no_grenades_2 = PC_SNIPER_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_SNIPER_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_SNIPER_GRENADE_TYPE_2;
	self.tf_items = PC_SNIPER_TF_ITEMS;

	self.armorclass = self.armorclass | PC_SNIPER_INITARMORCLASS;
	self.armortype = PC_SNIPER_INITARMORTYPE;
	self.armorvalue = PC_SNIPER_INITARMOR;
	self.armor_allowed = PC_SNIPER_MAXARMORTYPE;
	self.maxarmor = PC_SNIPER_MAXARMOR;
	self.current_weapon = WEAP_SNIPER_RIFLE;

	self.items_allowed = PC_SNIPER_WEAPONS;
	self.items = self.items | IT_SHOTGUN | IT_SUPER_SHOTGUN | IT_NAILGUN;
    } else if (self.playerclass == PC_SOLDIER) {
	self.weapons_carried = self.weapons_carried | PC_SOLDIER_WEAPONS;
	self.ammo_rockets = PC_SOLDIER_INITAMMO_ROCKET;
	self.ammo_nails = PC_SOLDIER_INITAMMO_NAIL;
	self.ammo_shells = PC_SOLDIER_INITAMMO_SHOT;
	self.ammo_cells = PC_SOLDIER_INITAMMO_CELL;
	self.maxammo_rockets = PC_SOLDIER_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_SOLDIER_MAXAMMO_NAIL;
	self.maxammo_shells = PC_SOLDIER_MAXAMMO_SHOT;
	self.maxammo_cells = PC_SOLDIER_MAXAMMO_CELL;

	self.no_grenades_1 = PC_SOLDIER_GRENADE_INIT_1;
	self.no_grenades_2 = PC_SOLDIER_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_SOLDIER_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_SOLDIER_GRENADE_TYPE_2;
	self.tf_items = PC_SOLDIER_TF_ITEMS;

	self.armorclass = self.armorclass | PC_SOLDIER_INITARMORCLASS;
	self.armortype = PC_SOLDIER_INITARMORTYPE;
	self.armorvalue = PC_SOLDIER_INITARMOR;
	self.armor_allowed = PC_SOLDIER_MAXARMORTYPE;
	self.maxarmor = PC_SOLDIER_MAXARMOR;
	self.current_weapon = WEAP_ROCKET_LAUNCHER;

	self.items_allowed = PC_SOLDIER_WEAPONS;
	self.items = self.items | IT_SHOTGUN | IT_SUPER_SHOTGUN | IT_ROCKET_LAUNCHER;
    } else if (self.playerclass == PC_DEMOMAN) {
       self.weapons_carried = self.weapons_carried | PC_DEMOMAN_WEAPONS;
       self.ammo_rockets = PC_DEMOMAN_INITAMMO_ROCKET;
       self.ammo_nails = PC_DEMOMAN_INITAMMO_NAIL;
       self.ammo_shells = PC_DEMOMAN_INITAMMO_SHOT;
       self.ammo_cells = PC_DEMOMAN_INITAMMO_CELL;
       self.maxammo_rockets = PC_DEMOMAN_MAXAMMO_ROCKET;
       self.maxammo_nails = PC_DEMOMAN_MAXAMMO_NAIL;
       self.maxammo_shells = PC_DEMOMAN_MAXAMMO_SHOT;
       self.maxammo_cells = PC_DEMOMAN_MAXAMMO_CELL;

       self.no_grenades_1 = PC_DEMOMAN_GRENADE_INIT_1;
       self.no_grenades_2 = PC_DEMOMAN_GRENADE_INIT_2;
       self.tp_grenades_1 = PC_DEMOMAN_GRENADE_TYPE_1;
       self.tp_grenades_2 = PC_DEMOMAN_GRENADE_TYPE_2;
       self.tf_items = PC_DEMOMAN_TF_ITEMS;

       self.ammo_detpack = PC_DEMOMAN_INITAMMO_DETPACK;
       self.maxammo_detpack = PC_DEMOMAN_MAXAMMO_DETPACK;

       self.armorclass = self.armorclass | PC_DEMOMAN_INITARMORCLASS;
       self.armortype = PC_DEMOMAN_INITARMORTYPE;
       self.armorvalue = PC_DEMOMAN_INITARMOR;
       self.armor_allowed = PC_DEMOMAN_MAXARMORTYPE;
       self.maxarmor = PC_DEMOMAN_MAXARMOR;
       self.current_weapon = WEAP_GRENADE_LAUNCHER;

       self.items_allowed = PC_DEMOMAN_WEAPONS;
       self.items = self.items | IT_SHOTGUN | IT_GRENADE_LAUNCHER;
    } else if (self.playerclass == PC_MEDIC) {
	self.weapons_carried = self.weapons_carried | PC_MEDIC_WEAPONS;
	self.ammo_rockets = PC_MEDIC_INITAMMO_ROCKET;
	self.ammo_nails = PC_MEDIC_INITAMMO_NAIL;
	self.ammo_shells = PC_MEDIC_INITAMMO_SHOT;
	self.ammo_cells = PC_MEDIC_INITAMMO_CELL;
	self.maxammo_rockets = PC_MEDIC_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_MEDIC_MAXAMMO_NAIL;
	self.maxammo_shells = PC_MEDIC_MAXAMMO_SHOT;
	self.maxammo_cells = PC_MEDIC_MAXAMMO_CELL;

	self.no_grenades_1 = PC_MEDIC_GRENADE_INIT_1;
	self.no_grenades_2 = PC_MEDIC_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_MEDIC_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_MEDIC_GRENADE_TYPE_2;
	self.tf_items = PC_MEDIC_TF_ITEMS;

	self.armorclass = self.armorclass | PC_MEDIC_INITARMORCLASS;
	self.armortype = PC_MEDIC_INITARMORTYPE;
	self.armorvalue = PC_MEDIC_INITARMOR;
	self.armor_allowed = PC_MEDIC_MAXARMORTYPE;
	self.maxarmor = PC_MEDIC_MAXARMOR;
	self.current_weapon = WEAP_SUPER_NAILGUN;

	self.ammo_medikit = PC_MEDIC_INITAMMO_MEDIKIT;
	self.maxammo_medikit = PC_MEDIC_MAXAMMO_MEDIKIT;

	te = spawn ();
	te.nextthink = time + PC_MEDIC_REGEN_TIME;
	te.think = TeamFortress_Regenerate;
	te.owner = self;
	te.classname = "timer";

	self.items_allowed = PC_MEDIC_WEAPONS;
	self.items = self.items | IT_SHOTGUN | IT_SUPER_SHOTGUN | IT_SUPER_NAILGUN;
    } else if (self.playerclass == PC_HVYWEAP) {
	self.weapons_carried = self.weapons_carried | PC_HVYWEAP_WEAPONS;
	self.ammo_rockets = PC_HVYWEAP_INITAMMO_ROCKET;
	self.ammo_nails = PC_HVYWEAP_INITAMMO_NAIL;
	self.ammo_shells = PC_HVYWEAP_INITAMMO_SHOT;
	self.ammo_cells = PC_HVYWEAP_INITAMMO_CELL;
	self.maxammo_rockets = PC_HVYWEAP_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_HVYWEAP_MAXAMMO_NAIL;
	self.maxammo_shells = PC_HVYWEAP_MAXAMMO_SHOT;
	self.maxammo_cells = PC_HVYWEAP_MAXAMMO_CELL;
	
	self.no_grenades_1 = PC_HVYWEAP_GRENADE_INIT_1;
	self.no_grenades_2 = PC_HVYWEAP_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_HVYWEAP_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_HVYWEAP_GRENADE_TYPE_2;
	self.tf_items = PC_HVYWEAP_TF_ITEMS;

	self.armorclass = self.armorclass | PC_HVYWEAP_INITARMORCLASS;
	self.armortype = PC_HVYWEAP_INITARMORTYPE;
	self.armorvalue = PC_HVYWEAP_INITARMOR;
	self.armor_allowed = PC_HVYWEAP_MAXARMORTYPE;
	self.maxarmor = PC_HVYWEAP_MAXARMOR;
	self.current_weapon = WEAP_SUPER_SHOTGUN;

	self.items_allowed = PC_HVYWEAP_WEAPONS;
	self.items = self.items | IT_SHOTGUN | IT_SUPER_SHOTGUN | IT_ROCKET_LAUNCHER;
    } else if (self.playerclass == PC_PYRO) {
	self.weapons_carried = self.weapons_carried | PC_PYRO_WEAPONS;
	self.ammo_rockets = PC_PYRO_INITAMMO_ROCKET;
	self.ammo_nails = PC_PYRO_INITAMMO_NAIL;
	self.ammo_shells = PC_PYRO_INITAMMO_SHOT;
	self.ammo_cells = PC_PYRO_INITAMMO_CELL;
	self.maxammo_rockets = PC_PYRO_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_PYRO_MAXAMMO_NAIL;
	self.maxammo_shells = PC_PYRO_MAXAMMO_SHOT;
	self.maxammo_cells = PC_PYRO_MAXAMMO_CELL;
	
	self.no_grenades_1 = PC_PYRO_GRENADE_INIT_1;
	self.no_grenades_2 = PC_PYRO_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_PYRO_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_PYRO_GRENADE_TYPE_2;
	self.tf_items = PC_PYRO_TF_ITEMS;

	self.armorclass = self.armorclass | PC_PYRO_INITARMORCLASS;
	self.armortype = PC_PYRO_INITARMORTYPE;
	self.armorvalue = PC_PYRO_INITARMOR;
	self.armor_allowed = PC_PYRO_MAXARMORTYPE;
	self.maxarmor = PC_PYRO_MAXARMOR;
	self.current_weapon = WEAP_FLAMETHROWER;

	self.items_allowed = PC_PYRO_WEAPONS;
	self.items = self.items | IT_SHOTGUN | IT_GRENADE_LAUNCHER | IT_ROCKET_LAUNCHER;
    } else if (self.playerclass == PC_CIVILIAN) {
	self.weapons_carried = self.weapons_carried | PC_CIVILIAN_WEAPONS;
	self.ammo_rockets = PC_CIVILIAN_INITAMMO_ROCKET;
	self.ammo_nails = PC_CIVILIAN_INITAMMO_NAIL;
	self.ammo_shells = PC_CIVILIAN_INITAMMO_SHOT;
	self.ammo_cells = PC_CIVILIAN_INITAMMO_CELL;
	self.maxammo_rockets = PC_CIVILIAN_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_CIVILIAN_MAXAMMO_NAIL;
	self.maxammo_shells = PC_CIVILIAN_MAXAMMO_SHOT;
	self.maxammo_cells = PC_CIVILIAN_MAXAMMO_CELL;
	
	self.no_grenades_1 = PC_CIVILIAN_GRENADE_INIT_1;
	self.no_grenades_2 = PC_CIVILIAN_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_CIVILIAN_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_CIVILIAN_GRENADE_TYPE_2;
	self.tf_items = PC_CIVILIAN_TF_ITEMS;

	self.armorclass = self.armorclass | PC_CIVILIAN_INITARMORCLASS;
	self.armortype = PC_CIVILIAN_INITARMORTYPE;
	self.armorvalue = PC_CIVILIAN_INITARMOR;
	self.armor_allowed = PC_CIVILIAN_MAXARMORTYPE;
	self.maxarmor = PC_CIVILIAN_MAXARMOR;
	self.current_weapon = WEAP_AXE;

	self.items_allowed = PC_CIVILIAN_WEAPONS;
	self.items = 0;
    } else if (self.playerclass == PC_SPY) {
	self.weapons_carried = self.weapons_carried | PC_SPY_WEAPONS;
	self.ammo_rockets = PC_SPY_INITAMMO_ROCKET;
	self.ammo_nails = PC_SPY_INITAMMO_NAIL;
	self.ammo_shells = PC_SPY_INITAMMO_SHOT;
	self.ammo_cells = PC_SPY_INITAMMO_CELL;
	self.maxammo_rockets = PC_SPY_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_SPY_MAXAMMO_NAIL;
	self.maxammo_shells = PC_SPY_MAXAMMO_SHOT;
	self.maxammo_cells = PC_SPY_MAXAMMO_CELL;
	
	self.no_grenades_1 = PC_SPY_GRENADE_INIT_1;
	self.no_grenades_2 = PC_SPY_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_SPY_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_SPY_GRENADE_TYPE_2;
	self.tf_items = PC_SPY_TF_ITEMS;

	self.armorclass = self.armorclass | PC_SPY_INITARMORCLASS;
	self.armortype = PC_SPY_INITARMORTYPE;
	self.armorvalue = PC_SPY_INITARMOR;
	self.armor_allowed = PC_SPY_MAXARMORTYPE;
	self.maxarmor = PC_SPY_MAXARMOR;
	self.current_weapon = WEAP_TRANQ;

	self.items_allowed = PC_SPY_WEAPONS;
	self.items = self.items | IT_SHOTGUN | IT_SUPER_SHOTGUN | IT_NAILGUN;

	if (invis_only == 1) {
	    te = spawn ();
	    te.nextthink = time + PC_SPY_CELL_REGEN_TIME;
	    te.think = TeamFortress_RegenerateCells;
	    te.owner = self;
	    te.classname = "timer";
	}
    } else if (self.playerclass == PC_ENGINEER) {
	self.weapons_carried = self.weapons_carried | PC_ENGINEER_WEAPONS;
	self.ammo_rockets = PC_ENGINEER_INITAMMO_ROCKET;
	self.ammo_nails = PC_ENGINEER_INITAMMO_NAIL;
	self.ammo_shells = PC_ENGINEER_INITAMMO_SHOT;
	self.ammo_cells = PC_ENGINEER_INITAMMO_CELL;
	self.maxammo_rockets = PC_ENGINEER_MAXAMMO_ROCKET;
	self.maxammo_nails = PC_ENGINEER_MAXAMMO_NAIL;
	self.maxammo_shells = PC_ENGINEER_MAXAMMO_SHOT;
	self.maxammo_cells = PC_ENGINEER_MAXAMMO_CELL;
	
	self.no_grenades_1 = PC_ENGINEER_GRENADE_INIT_1;
	self.no_grenades_2 = PC_ENGINEER_GRENADE_INIT_2;
	self.tp_grenades_1 = PC_ENGINEER_GRENADE_TYPE_1;
	self.tp_grenades_2 = PC_ENGINEER_GRENADE_TYPE_2;
	self.tf_items = PC_ENGINEER_TF_ITEMS;

	self.armorclass = self.armorclass | PC_ENGINEER_INITARMORCLASS;
	self.armortype = PC_ENGINEER_INITARMORTYPE;
	self.armorvalue = PC_ENGINEER_INITARMOR;
	self.armor_allowed = PC_ENGINEER_MAXARMORTYPE;
	self.maxarmor = PC_ENGINEER_MAXARMOR;
	self.current_weapon = WEAP_LASER;

	self.items_allowed = PC_ENGINEER_WEAPONS;
	self.items = self.items | IT_SHOTGUN | IT_SUPER_SHOTGUN;
    } else if (self.playerclass == PC_UNDEFINED) {
	self.items = 0;
	self.ammo_rockets = 0;
	self.ammo_nails = 0;
	self.ammo_shells = 0;
	self.ammo_cells = 0;

	self.no_grenades_1 = 0;
	self.no_grenades_2 = 0;
	self.tp_grenades_1 = 0;
	self.tp_grenades_2 = 0;

	self.armorclass = 0;
	self.armortype = 0;
	self.armorvalue = 0;
	self.weapon = 0;
	self.current_weapon = 0;
	self.weapons_carried = 0;

	self.flags = FL_CLIENT | FL_NOTARGET;
	self.waterlevel = 3;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NOCLIP;

	self.model = string_null;
	self.mdl = string_null;
	self.modelindex = 0;
	self.weaponmodel = string_null;
	modelindex_player = 0;
	self.tfstate = self.tfstate | TFSTATE_RELOADING;

	setmodel (self, string_null);
    }

    if (self.armortype >= 0.8)
	self.items = self.items | IT_ARMOR3;
    else if (self.armortype >= 0.6)
	self.items = self.items | IT_ARMOR2;
    else if (self.armortype >= 0.3)
	self.items = self.items | IT_ARMOR1;

    if (allow_hook && (self.playerclass != PC_UNDEFINED))
	self.weapons_carried = self.weapons_carried | WEAP_HOOK;

    W_SetCurrentAmmo ();
};

float (entity Retriever, float AmmoType) TeamFortress_GetMaxAmmo =
{
    if (AmmoType == IT_SHELLS)
	return Retriever.maxammo_shells;
    else if (AmmoType == IT_NAILS)
	return Retriever.maxammo_nails;
    else if (AmmoType == IT_CELLS)
	return Retriever.maxammo_cells;
    else if (AmmoType == IT_ROCKETS)
	return Retriever.maxammo_rockets;
    else if (AmmoType == WEAP_MEDIKIT)
	return Retriever.maxammo_medikit;
    else if (AmmoType == WEAP_DETPACK)
	return Retriever.maxammo_detpack;

    dprint ("Error in TeamFortress_GetMaxAmmo()\n");
    dprint ("Invalid ammo type passed.\n");
    return (0);
};

float (entity Retriever, float WeaponType) TeamFortress_CanGetWeapon =
{
    if (Retriever.items_allowed & WeaponType)
	return TRUE;

    return FALSE;
};

void (entity Player, float Armorclass) TeamFortress_DescribeArmor =
{
    local string st;

    if (Armorclass == 0)
	return;

    if (Armorclass & AT_SAVEFIRE)
	sprint (Player, PRINT_HIGH, "Asbestos ");
    if (Armorclass & AT_SAVENAIL)
	sprint (Player, PRINT_HIGH, "Wooden ");
    if (Armorclass & AT_SAVEEXPLOSION)
	sprint (Player, PRINT_HIGH, "Blast ");
    if (Armorclass & AT_SAVEELECTRICITY)
	sprint (Player, PRINT_HIGH, "Shockproof ");
    if (Armorclass & AT_SAVESHOT)
	sprint (Player, PRINT_HIGH, "Kevlar ");

    sprint (Player, PRINT_HIGH, "armor\n");
};

void (entity Retriever, entity Items) TeamFortress_AddBackpackItems =
{
    return;
};

string (float pc) TeamFortress_GetClassName =
{
    if (pc == PC_SCOUT)
	return "Scout";
    else if (pc == PC_SNIPER)
	return "Sniper";
    else if (pc == PC_SOLDIER)
	return "Soldier";
    else if (pc == PC_DEMOMAN)
	return "Demolitions Man";
    else if (pc == PC_MEDIC)
	return "Combat Medic";
    else if (pc == PC_HVYWEAP)
	return "Heavy Weapons Guy";
    else if (pc == PC_PYRO)
	return "Pyro";
    else if (pc == PC_SPY)
	return "Spy";
    else if (pc == PC_ENGINEER)
	return "Engineer";
    else if (pc == PC_CIVILIAN)
	return "Civilian";
    else if (pc == PC_UNDEFINED)
	return "Observer";
    else if (pc == PC_RANDOM)
	return "Random Playerclass";
};

void (entity Viewer, float pc, float rpc) TeamFortress_PrintClassName =
{
    local string st;

    st = TeamFortress_GetClassName (pc);
    sprint (Viewer, PRINT_HIGH, st);

    if (rpc != 0)
	sprint (Viewer, PRINT_HIGH, " (Random)");

    sprint (Viewer, PRINT_HIGH, "\n");
};

void () TeamFortress_RemoveTimers =
{
    local entity te;

    self.leg_damage = 0;
    self.is_undercover = 0;
    self.is_building = 0;
    self.building = world;
    if (self.tfstate & TFSTATE_AIMING) {
	self.tfstate = self.tfstate - TFSTATE_AIMING;
	TeamFortress_SetSpeed (self);
	self.heat = 0;
    }
    if (self.tfstate & TFSTATE_INFECTED)
	self.tfstate = self.tfstate - (self.tfstate & TFSTATE_INFECTED);
    if (self.tfstate & TFSTATE_HALLUCINATING)
	self.tfstate = self.tfstate - (self.tfstate & TFSTATE_HALLUCINATING);

    te = find (world, classname, "timer");
    while (te != world) {
	if ((te.owner == self) && (te.no_active_gas_grens <= 0)) {
	    dremove (te);
	    te = find (world, classname, "timer");
	} else
	    te = find (te, classname, "timer");
    }

    te = find (world, classname, "grentimer");
    while (te != world) {
	if ((te.owner == self) && (te.no_active_napalm_grens <= 0)) {
	    dremove (te);
	    te = find (world, classname, "grentimer");
	} else
	    te = find (te, classname, "grentimer");
    }

    te = find (world, classname, "item_tfgoal");
    while (te) {
	if (te.owner == self) {
	    if (!(te.goal_activation & TFGI_KEEP) || (self.has_disconnected == 1)) {
		tfgoalitem_RemoveFromPlayer (te, self, 0);
	    }
	    if (CTF_Map == 1) {
		if (te.goal_no == 1) {
		    bprint (PRINT_HIGH, self.netname, " лост the блуе flag!\n");
		} else if (te.goal_no == 2) {
		    bprint (PRINT_HIGH, self.netname, " лост the ред flag!\n");
		}
	    }
	}
	te = find (te, classname, "item_tfgoal");
    }

    te = find (world, classname, "detpack");
    while (te) {
	if ((te.weaponmode == 1) && (te.enemy == self))
	    te.weaponmode = 0;
	te = find (te, classname, "detpack");
    }

    TeamFortress_DetonatePipebombs ();
    if (self.has_disconnected == 1) {
	te = find (world, classname, "grenade");
	while (te) {
	    if ((te.owner == self) && (te.model == "progs/caltrop.mdl")) {
		dremove (te);
		te = find (world, classname, "grenade");
	    } else
		te = find (te, classname, "grenade");
	}
    }
    if (old_grens == 1) {
	stuffcmd (self, "v_idlescale 0\n");
	stuffcmd (self, "v_cshift; wait; bf\n");
	self.FlashTime = 0;
    }
    self.item_list = 0;
    CenterPrint (self, "\n");
    self.menu_count = MENU_REFRESH_RATE;
    self.current_menu = MENU_DEFAULT;
    self.impulse = 0;
};

void (float Suicided) TeamFortress_SetupRespawn =
{
    local float restime;
    local string db;

    if (self.respawn_time > time)
	return;

    if (toggleflags & TFLAG_RESPAWNDELAY)
	restime = respawn_delay_time;
    else
	restime = 0;

    if (cb_prematch_time < time) {
	if (Suicided) {
	    if (self.lives > 0)
		self.lives = self.lives - 1;
	    restime = restime + 7;
	}
    }
    if (cb_prematch_time > time) {
	if (self.lives > 0)
	    self.lives = self.lives - 1;

	if (self.lives != -1) {
	    if (self.lives == 0) {
		sprint (self, PRINT_HIGH, "NO lives left, returning to Observer mode.\n");
		self.playerclass = PC_UNDEFINED;
		self.tfstate = self.tfstate - (self.tfstate & TFSTATE_RANDOMPC);
		self.movetype = MOVETYPE_NOCLIP;
		self.solid = SOLID_NOT;

		self.model = "";
		self.mdl = "";
		self.velocity = '0 0 0';
		self.avelocity = '0 0 0';

		self.enemy = world;
		setmodel (self, "");
		return;
	    }
	    if (self.lives == 1)
		sprint (self, PRINT_HIGH, "LAST life.\n");
	    else {
		db = ftos (self.lives);
		sprint (self, PRINT_HIGH, db, " lives left.\n");
	    }
	}
    }
    self.respawn_time = time + restime;
    if (restime > 3) {
	db = ftos (restime);
	sprint (self, PRINT_HIGH, db, " seconds till respawn.\n");
    }
};

void () TeamFortress_CheckClassStats =
{
    // Check armor
    if (self.armortype > self.armor_allowed)
	self.armortype = self.armor_allowed;
    if (self.armorvalue > self.maxarmor)
	self.armorvalue = self.maxarmor;
    if (self.armortype < 0)
	self.armortype = 0;
    if (self.armorvalue < 0)
	self.armorvalue = 0;

    // Check ammo
    if (self.ammo_shells > TeamFortress_GetMaxAmmo (self, IT_SHELLS))
	self.ammo_shells = TeamFortress_GetMaxAmmo (self, IT_SHELLS);
    if (self.ammo_shells < 0)
	self.ammo_shells = 0;
    if (self.ammo_nails > TeamFortress_GetMaxAmmo (self, IT_NAILS))
	self.ammo_nails = TeamFortress_GetMaxAmmo (self, IT_NAILS);
    if (self.ammo_nails < 0)
	self.ammo_nails = 0;
    if (self.ammo_rockets > TeamFortress_GetMaxAmmo (self, IT_ROCKETS))
	self.ammo_rockets = TeamFortress_GetMaxAmmo (self, IT_ROCKETS);
    if (self.ammo_rockets < 0)
	self.ammo_rockets = 0;
    if (self.ammo_cells > TeamFortress_GetMaxAmmo (self, IT_CELLS))
	self.ammo_cells = TeamFortress_GetMaxAmmo (self, IT_CELLS);
    if (self.ammo_cells < 0)
	self.ammo_cells = 0;
    if (self.ammo_medikit > TeamFortress_GetMaxAmmo (self, WEAP_MEDIKIT))
	self.ammo_medikit = TeamFortress_GetMaxAmmo (self, WEAP_MEDIKIT);
    if (self.ammo_medikit < 0)
	self.ammo_medikit = 0;
    if (self.ammo_detpack > TeamFortress_GetMaxAmmo (self, WEAP_DETPACK))
	self.ammo_detpack = TeamFortress_GetMaxAmmo (self, WEAP_DETPACK);
    if (self.ammo_detpack < 0)
	self.ammo_detpack = 0;

    // Check Grenades
    if (self.no_grenades_1 < 0)
	self.no_grenades_1 = 0;
    if (self.no_grenades_2 < 0)
	self.no_grenades_2 = 0;

    // Check health
    if ((self.health > self.max_health) && !(self.items & IT_SUPERHEALTH))
	TF_T_Damage (self, world, world, self.max_health - self.health, 0, TF_TD_NOSOUND);
    if (self.health < 0)
	T_Heal (self, self.health - self.health, 0);

    // Update armor picture
    self.items = self.items - (self.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
    if (self.armortype >= 0.8)
	self.items = self.items | IT_ARMOR3;
    else if (self.armortype >= 0.6)
	self.items = self.items | IT_ARMOR2;
    else if (self.armortype >= 0.3)
	self.items = self.items | IT_ARMOR1;
};

void (float type) TeamFortress_DropAmmo =
{
    local float ammo;

    if (type == 1) {
	ammo = DROP_SHELLS;
	if (self.ammo_shells < ammo) {
	    if (self.playerclass == PC_ENGINEER) {
		if ((self.ammo_cells / AMMO_COST_SHELLS) > (ammo - self.ammo_shells)) {
		    sprint (self, PRINT_HIGH, "you make some shells.\n");
		    self.ammo_cells = self.ammo_cells - (ammo - self.ammo_shells) * AMMO_COST_SHELLS;
		    self.ammo_shells = ammo;
		}
	    }
	    if (self.ammo_shells < ammo)
		return;
	}
	self.ammo_shells = self.ammo_shells - ammo;
    } else if (type == 2) {
	ammo = DROP_NAILS;
	if (self.ammo_nails < ammo) {
	    if (self.playerclass == PC_ENGINEER) {
		if ((self.ammo_cells / AMMO_COST_NAILS) > (ammo - self.ammo_nails)) {
		    sprint (self, PRINT_HIGH, "you make some nails.\n");
		    self.ammo_cells = self.ammo_cells - (ammo - self.ammo_nails) * AMMO_COST_NAILS;
		    self.ammo_nails = ammo;
		}
	    }
	    if (self.ammo_nails < ammo)
		return;
	}
	self.ammo_nails = self.ammo_nails - ammo;
    } else if (type == 3) {
	ammo = DROP_ROCKETS;
	if (self.ammo_rockets < ammo) {
	    if (self.playerclass == PC_ENGINEER) {
		if ((self.ammo_cells / AMMO_COST_ROCKETS) > (ammo - self.ammo_rockets)) {
		    sprint (self, PRINT_HIGH, "you make some rockets.\n");
		    self.ammo_cells = self.ammo_cells - (ammo - self.ammo_rockets) * AMMO_COST_ROCKETS;
		    self.ammo_rockets = ammo;
		}
	    }
	    if (self.ammo_rockets < ammo)
		return;
	}
	self.ammo_rockets = self.ammo_rockets - ammo;
    } else if (type == 4) {
	ammo = DROP_CELLS;
	if (self.ammo_cells < ammo) {
	    if (self.playerclass == PC_ENGINEER) {
		if ((self.ammo_cells / AMMO_COST_CELLS) > (ammo - self.ammo_cells)) {
		    sprint (self, PRINT_HIGH, "you make some cells.\n");
		    self.ammo_cells = self.ammo_cells - (ammo - self.ammo_cells) * AMMO_COST_CELLS;
		    self.ammo_cells = ammo;
		}
	    }
	    if (self.ammo_cells < ammo)
		return;
	}
	self.ammo_cells = self.ammo_cells - ammo;
    }
    W_SetCurrentAmmo ();
    if (self.team_no != 0) {
	increment_team_ammoboxes (self.team_no);
	if (num_team_ammoboxes (self.team_no) > (20 / number_of_teams)) {
	    RemoveOldAmmobox (self.team_no);
	}
    } else {
	num_world_ammoboxes = num_world_ammoboxes + 1;
	if (num_world_ammoboxes > 20) {
	    RemoveOldAmmobox (0);
	}
    }
    newmis = spawn ();
    newmis.aflag = ammo;
    newmis.weapon = type;
    if (newmis.weapon == 1)
	newmis.ammo_shells = ammo;
    else if (newmis.weapon == 2)
	newmis.ammo_nails = ammo;
    else if (newmis.weapon == 3)
	newmis.ammo_rockets = ammo;
    else if (newmis.weapon == 4)
	newmis.ammo_cells = ammo;
    newmis.enemy = self;
    newmis.health = time;
    newmis.movetype = 6;
    newmis.solid = 1;
    newmis.classname = "ammobox";
    newmis.team_no = self.team_no;
    makevectors (self.v_angle);
    if (self.v_angle_x) {
	newmis.velocity = v_forward * 400 + v_up * 200;
    } else {
	newmis.velocity = aim (self, 10000);
	newmis.velocity = newmis.velocity * 400;
	newmis.velocity_z = 200;
    }
    newmis.avelocity = '0 300 0';
    setsize (newmis, '0 0 0', '0 0 0');
    setorigin (newmis, self.origin);
    newmis.nextthink = time + 30;
    newmis.think = SUB_Remove;
    newmis.touch = TeamFortress_AmmoboxTouch;
    newmis.skin = type - 1;

    if ((birthday == 1) && (random () < 0.6))
	setmodel (newmis, "progs/grenade3.mdl");
    else
	setmodel (newmis, "progs/ammobox.mdl");
};

void () TeamFortress_AmmoboxTouch =
{
    local float took;
    local string quantity;

    took = 0;
    if ((other == self.enemy) && (time < (self.health + 2)))
	return;
    if ((other.tfstate & 65536) || (other.tfstate & 2048))
	return;
    if (other.classname != "player")
	return;
    if (other.health <= 0)
	return;

    num_world_ammoboxes = num_world_ammoboxes - 1;
    decrement_team_ammoboxes (self.team_no);
    if (self.weapon == 0) {
	sprint (other, PRINT_HIGH, "You got ");
	if (self.ammo_shells > 0) {
	    other.ammo_shells = other.ammo_shells + self.ammo_shells;
	    quantity = ftos (self.ammo_shells);
	    sprint2 (other, PRINT_HIGH, quantity, " shells  ");
	}
	if (self.ammo_nails > 0) {
	    other.ammo_nails = other.ammo_nails + self.ammo_nails;
	    quantity = ftos (self.ammo_nails);
	    sprint2 (other, PRINT_HIGH, quantity, " nails  ");
	}
	if (self.ammo_rockets > 0) {
	    other.ammo_rockets = other.ammo_rockets + self.ammo_rockets;
	    quantity = ftos (self.ammo_rockets);
	    sprint2 (other, PRINT_HIGH, quantity, " rockets  ");
	}
	if (self.ammo_cells > 0) {
	    other.ammo_cells = other.ammo_cells + self.ammo_cells;
	    quantity = ftos (self.ammo_cells);
	    sprint2 (other, PRINT_HIGH, quantity, " cells  ");
	}
	sprint3 (other, PRINT_HIGH, " from ", self.enemy.netname, "'s discarded pack.\n");
    } else if (self.weapon == 1) {
	if (other.ammo_shells >= TeamFortress_GetMaxAmmo (other, 256))
	    return;
	other.ammo_shells = other.ammo_shells + self.aflag;
	self.netname = "shells";
    } else if (self.weapon == 2) {
	if (other.ammo_nails >= TeamFortress_GetMaxAmmo (other, 512))
	    return;
	other.ammo_nails = other.ammo_nails + self.aflag;
	self.netname = "nails";
    } else if (self.weapon == 3) {
	if (other.ammo_rockets >= TeamFortress_GetMaxAmmo (other, 1024))
	    return;
	other.ammo_rockets = other.ammo_rockets + self.aflag;
	self.netname = "rockets";
    } else if (self.weapon == 4) {
	if (other.ammo_cells >= TeamFortress_GetMaxAmmo (other, 2048))
	    return;
	other.ammo_cells = other.ammo_cells + self.aflag;
	self.netname = "cells";
    }
    bound_other_ammo (other);
    if (self.weapon > 0) {
	quantity = ftos (self.aflag);
	sprint (other, PRINT_LOW, "You picked up ", quantity, " ", self.netname, "\n");
    }
    sound (other, 3, "weapons/lock4.wav", 1, 1);
    stuffcmd (other, "bf\n");
    dremove (self);
    self = other;
    W_SetCurrentAmmo ();
};

float (float tno) num_team_ammoboxes =
{
    if (tno == 1)
	return (num_team_ammoboxes_1);
    else if (tno == 2)
	return (num_team_ammoboxes_2);
    else if (tno == 3)
	return (num_team_ammoboxes_3);
    else if (tno == 4)
	return (num_team_ammoboxes_4);

    return (0);
};

void (float tno) RemoveOldAmmobox =
{
    local float index;

    if (tno != 0) {
	index = num_team_ammoboxes (tno);
	index = index - (20 / number_of_teams);
    } else
	index = num_world_ammoboxes - 20;

    old = find (world, classname, "ammobox");
    while (index > 0) {
	if (old == world)
	    return;
	if ((old.team_no == tno) || (tno == 0)) {
	    old.think = SUB_Remove;
	    old.nextthink = time + 0.1;
	    index = index - 1;
	    num_world_ammoboxes = num_world_ammoboxes - 1;
	    decrement_team_ammoboxes (old.team_no);
	}
	old = find (old, classname, "ammobox");
    }
};

void (float tno) increment_team_ammoboxes =
{
    if (tno == 1)
	num_team_ammoboxes_1 = num_team_ammoboxes_1 + 1;
    else if (tno == 2)
	num_team_ammoboxes_2 = num_team_ammoboxes_2 + 1;
    else if (tno == 3)
	num_team_ammoboxes_3 = num_team_ammoboxes_3 + 1;
    else if (tno == 4)
	num_team_ammoboxes_4 = num_team_ammoboxes_4 + 1;
};

void (float tno) decrement_team_ammoboxes =
{
    if (tno == 1)
	num_team_ammoboxes_1 = num_team_ammoboxes_1 - 1;
    else if (tno == 2)
	num_team_ammoboxes_2 = num_team_ammoboxes_2 - 1;
    else if (tno == 3)
	num_team_ammoboxes_3 = num_team_ammoboxes_3 - 1;
    else if (tno == 4)
	num_team_ammoboxes_4 = num_team_ammoboxes_4 - 1;
};

void () TeamFortress_AssaultWeapon =
{
    local float it;

    self.impulse = 0;
    if (self.tfstate & TFSTATE_RELOADING)
	return;

    if (!(self.weapons_carried & WEAP_ASSAULT_CANNON))
	return;

    if (self.heat > 0) {
	sprint (self, PRINT_HIGH, "the assault cannon is still overheated.\n");
	return;
    }

    if (self.ammo_shells < 1) {
	sprint (self, PRINT_HIGH, "not enough ammo.\n");
	return;
    }

    if (self.ammo_cells < 6) {
	sprint (self, PRINT_HIGH, "not enough cells to power the assault cannon.\n");
	return;
    }
    self.current_weapon = WEAP_ASSAULT_CANNON;
    W_SetCurrentAmmo ();
};

void () TeamFortress_ExplodePerson =
{
    local entity te;

    self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & 1);
    KickPlayer (-2, self.owner);

    newmis = spawn ();
    newmis.movetype = 10;
    newmis.solid = 2;
    newmis.classname = "grenade";
    newmis.team_no = self.owner.team_no;
    newmis.owner = self.owner;
    newmis.velocity = '0 0 0';
    newmis.angles = vectoangles (newmis.velocity);
    newmis.think = SUB_Null;
    newmis.nextthink = time + 0.1;

    if (self.weapon == GR_TYPE_NORMAL) {
	newmis.touch = NormalGrenadeTouch;
	newmis.think = NormalGrenadeExplode;
	newmis.skin = 0;
	newmis.avelocity = '300 300 300';
	setmodel (newmis, "progs/hgren2.mdl");
    } else if (self.weapon == GR_TYPE_CONCUSSION) {
	newmis.touch = ConcussionGrenadeTouch;
	newmis.think = ConcussionGrenadeExplode;
	newmis.skin = 1;
	newmis.avelocity = '300 300 300';
	setmodel (newmis, "progs/hgren2.mdl");
    } else if (self.weapon == GR_TYPE_NAIL) {
	newmis.touch = NailGrenadeTouch;
	newmis.think = NailGrenadeExplode;
	newmis.skin = 1;
	newmis.avelocity = '0 300 0';
	setmodel (newmis, "progs/biggren.mdl");
    } else if (self.weapon == GR_TYPE_MIRV) {
	newmis.touch = MirvGrenadeTouch;
	newmis.think = MirvGrenadeExplode;
	newmis.skin = 0;
	newmis.avelocity = '0 300 0';
	setmodel (newmis, "progs/biggren.mdl");
    } else if (self.weapon == GR_TYPE_NAPALM) {
	newmis.touch = NapalmGrenadeTouch;
	newmis.think = NapalmGrenadeExplode;
	newmis.skin = 2;
	newmis.avelocity = '0 300 0';
	setmodel (newmis, "progs/biggren.mdl");
    } else if (self.weapon == GR_TYPE_FLARE) {
	sprint (self.owner, PRINT_HIGH, "Flare lit.\n");
	te = spawn ();
	te.touch = SUB_Null;
	te.think = RemoveFlare;
	te.nextthink = time + 25;
	te.owner = self.owner;
	te.solid = 0;
	self.owner.effects = self.owner.effects | EF_BRIGHTLIGHT;
	dremove (self);
	dremove (newmis);
	return;
    } else if (self.weapon == GR_TYPE_GAS) {
	newmis.touch = GasGrenadeTouch;
	newmis.think = GasGrenadeExplode;
	newmis.skin = 2;
	newmis.avelocity = '300 300 300';
	setmodel (newmis, "progs/grenade2.mdl");
    } else if (self.weapon == GR_TYPE_EMP) {
	newmis.touch = EMPGrenadeTouch;
	newmis.think = EMPGrenadeExplode;
	newmis.skin = 4;
	newmis.avelocity = '300 300 300';
	setmodel (newmis, "progs/grenade2.mdl");
    } else if (self.weapon == GR_TYPE_CALTROP) {
	newmis.touch = CaltropTouch;
	newmis.think = ScatterCaltrops;
    } else if (self.weapon == GR_TYPE_FLASH) {
	newmis.touch = FlashGrenadeTouch;
	newmis.think = FlashGrenadeExplode;
	newmis.skin = 1;
	newmis.avelocity = '300 300 300';
	setmodel (newmis, "progs/grenade2.mdl");
    }
    setsize (newmis, '0 0 0', '0 0 0');
    setorigin (newmis, self.owner.origin);
    if (birthday == 1)
	bprint2 (PRINT_MEDIUM, self.owner.netname, " wouldn't let go of his gifts!\n");
    else if ((self.owner.playerclass == PC_SCOUT) && (self.weapon != 10))
	bprint3 (PRINT_MEDIUM,
		 "No ", self.owner.netname, ", swallowing the grenade isn't very effective!\n");
    else if (self.owner.playerclass == PC_SNIPER)
	bprint3 (PRINT_MEDIUM,
		 "Well ", self.owner.netname, ", don't quit your day job!\n");
    else if (self.owner.playerclass == PC_SOLDIER)
	bprint3 (PRINT_MEDIUM,
		 "Ummm, ", self.owner.netname, ", you're supposed to THROW the grenade!\n");
    else if (self.owner.playerclass == PC_DEMOMAN)
	bprint3 (PRINT_MEDIUM,
		 "Ack! ", self.owner.netname, "! The grenade is your friend for another reason!\n");
    else if (self.owner.playerclass == PC_MEDIC)
	bprint3 (PRINT_MEDIUM,
		 "No ", self.owner.netname, "! Assist your own suicide some other time!\n");
    else if (self.owner.playerclass == PC_HVYWEAP)
	bprint3 (PRINT_MEDIUM,
		 "Hey ", self.owner.netname, ", you're not THAT heavy!\n");
    else if (self.owner.playerclass == PC_PYRO)
	bprint3 (PRINT_MEDIUM,
		 "Yes ", self.owner.netname, ", the grenade does explode on '3'!\n");
    else if (self.owner.playerclass == PC_SPY)
	bprint3 (PRINT_MEDIUM,
		 "You do realize ", self.owner.netname, ", you can blow your cover in easier ways!\n");
    else if (self.owner.playerclass == PC_ENGINEER)
	bprint3 (PRINT_MEDIUM,
		 "Hey ", self.owner.netname, ", study grenade dynamics on your own time!\n");
    else
	bprint3 (PRINT_MEDIUM,
		 "No ", self.owner.netname, ", throw the grenade, not the pin!\n");

    dremove (self);
};

void () NormalGrenadeTouch =
{
    if (other == self.owner)
	return;

    sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
    if (self.velocity == '0 0 0')
	self.avelocity = '0 0 0';
};

void () NormalGrenadeExplode =
{
    deathmsg = DMSG_GREN_HAND;
    T_RadiusDamage (self, self.owner, 180, world);

    WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
    WriteByte (MSG_MULTICAST, TE_EXPLOSION);
    WriteCoord (MSG_MULTICAST, self.origin_x);
    WriteCoord (MSG_MULTICAST, self.origin_y);
    WriteCoord (MSG_MULTICAST, self.origin_z);

    multicast (self.origin, MULTICAST_PHS);
    dremove (self);
};

void () TeamFortress_DisplayDetectionItems =
{
    local entity Goal;
    local entity te;

    Goal = find (world, classname, "info_tfdetect");
    if (!Goal)
	return;

    if (Goal.display_item_status1 != 0) {
	te = Finditem (Goal.display_item_status1);
	if (te)
	    DisplayItemStatus (Goal, self, te);
	else
	    sprint (self, PRINT_HIGH, "Item is missing.\n");
    } else
	return;

    if (Goal.display_item_status2 != 0) {
	te = Finditem (Goal.display_item_status2);
	if (te)
	    DisplayItemStatus (Goal, self, te);
	else
	    sprint (self, PRINT_HIGH, "Item is missing.\n");
    } else
	return;

    if (Goal.display_item_status3 != 0) {
	te = Finditem (Goal.display_item_status3);
	if (te)
	    DisplayItemStatus (Goal, self, te);
	else
	    sprint (self, PRINT_HIGH, "Item is missing.\n");
    } else
	return;

    if (Goal.display_item_status4 != 0) {
	te = Finditem (Goal.display_item_status4);
	if (te)
	    DisplayItemStatus (Goal, self, te);
	else
	    sprint (self, PRINT_HIGH, "Item is missing.\n");
    }
};

void () BioInfection_Decay =
{
    local entity te;
    local entity Bio;

    if ((teamplay & 16) && (self.owner.team_no == self.enemy.team_no) && (self.owner.team_no != 0)) {
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & 16);
	dremove (self);
	return;
    } else if (self.invincible_finished > time) {
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & 16);
	dremove (self);
	return;
    }
    if (!(self.owner.tfstate & TFSTATE_INFECTED) || (self.owner.playerclass == PC_MEDIC)) {
	dremove (self);
	return;
    }
    te = findradius (self.owner.origin, 80);
    while ((te != world) && (te != self.owner)) {
	if ((te.classname == "player") && (te.deadflag == 0) && (te.playerclass != 0)) {
	    if (!(te.tfstate & TFSTATE_INFECTED)) {
		if (te.playerclass != PC_MEDIC) {
		    if (!((teamplay & 16) && (self.owner.team_no == self.enemy.team_no)
			  && (self.owner.team_no != 0))) {

			Bio = spawn ();
			Bio.nextthink = 2;
			Bio.think = BioInfection_Decay;
			Bio.owner = te;
			Bio.classname = "timer";
			Bio.enemy = self.enemy;

			te.tfstate = te.tfstate | TFSTATE_INFECTED;
			te.infection_team_no = self.owner.infection_team_no;

			sprint (te, PRINT_MEDIUM, "You have been infected by ", self.owner.netname, "!\n");
			sprint (self.owner, PRINT_MEDIUM, "You have infected ", te.netname, "!\n");
		    }
		}
	    }
	}
	te = te.chain;
    }
    self.nextthink = time + 3;
    deathmsg = 13;
    TF_T_Damage (self.owner, self, self.enemy, 8, TF_TD_IGNOREARMOUR, TF_TD_OTHER);
    SpawnBlood (self.owner.origin, 30);
};

void () BioInfection_MonsterDecay =
{
    self.nextthink = time + 2;

    T_Damage (self.enemy, self, self.owner, 5);
    SpawnBlood (self.enemy.origin, 20);

    if (self.enemy.health < 1)
	dremove (self);
};

void (string halias, float himpulse1, float himpulse2) TeamFortress_Alias =
{
    local string imp;

    stuffcmd (self, "alias ");
    stuffcmd (self, halias);
    stuffcmd (self, " \"impulse ");
    imp = ftos (himpulse1);
    stuffcmd (self, imp);

    if (himpulse2 != 0) {
	stuffcmd (self, ";wait; impulse ");
	imp = ftos (himpulse2);
	stuffcmd (self, imp);
    }
    stuffcmd (self, "\"\n");
};

void () TeamFortress_Regenerate =
{
    if (self.owner.playerclass == PC_MEDIC) {
	self.nextthink = time + PC_MEDIC_REGEN_TIME;

	if (self.owner.has_disconnected == 1) {
	    dremove (self);
	    return;
	}
	if (self.owner.health >= self.owner.max_health)
	    return;

	if (self.owner.ammo_medikit == 0)
	    return;

	if (self.owner.ammo_medikit < PC_MEDIC_REGEN_AMOUNT) {
	    self.owner.health = self.owner.health + self.owner.ammo_medikit;
	    self.owner.ammo_medikit = 0;
	} else {
	    self.owner.health = self.owner.health + PC_MEDIC_REGEN_AMOUNT;
	    self.owner.ammo_medikit = self.owner.ammo_medikit - PC_MEDIC_REGEN_AMOUNT;
	}
	if (self.owner.health > self.owner.max_health)
	    self.owner.health = self.owner.max_health;
    }
};

void () TeamFortress_RegenerateCells =
{
    if (self.owner.playerclass == PC_SPY) {
	self.nextthink = time + PC_SPY_CELL_REGEN_TIME;

	if (self.owner.is_undercover == 1) {
	    if (self.owner.ammo_cells == 0) {
		self.owner.is_undercover = 0;
		self.owner.modelindex = modelindex_player;
		self.owner.items = self.owner.items - (self.owner.items & IT_INVISIBILITY);
	    } else {
		self.owner.ammo_cells = self.owner.ammo_cells - PC_SPY_CELL_USAGE;
		if (self.owner.ammo_cells < 0)
		    self.owner.ammo_cells = 0;
	    }
	} else {
	    if (self.owner.ammo_cells >= self.owner.maxammo_cells)
		return;

	    self.owner.ammo_cells = self.owner.ammo_cells + PC_SPY_CELL_REGEN_AMOUNT;

	    if (self.owner.ammo_cells > self.owner.maxammo_cells)
		self.owner.ammo_cells = self.owner.maxammo_cells;
	}
	return;
    }
};

void () TeamFortress_CheckforCheats =
{
    local float tf;
    local float pf;
    local string st;
    local vector vplf;
    local vector vf;

    self.nextthink = time + 2;
    if (self.owner.immune_to_check > time)
	return;
    if (self.owner.deadflag)
	return;
    if (!(self.owner.flags & 512) || (self.velocity_z != 0))
	return;

    vplf = self.owner.velocity;
    makevectors (self.owner.angles);
    vf = v_forward;
    vf_z = 0;
    vf = normalize (vf);
    tf = vplf_x * vf_x + vplf_y * vf_y;
    pf = self.owner.maxfbspeed + 100;

    if ((self.owner.tfstate & TFSTATE_CANT_MOVE) && (tf > 20)) {
	self.nextthink = time + 0.5;
	self.owner.cheat_level = self.owner.cheat_level + 600;
    }
    if (tf > pf) {
	pf = pf + 100;
	if (tf > pf) {
	    self.nextthink = time + 2;
	    self.owner.cheat_level = self.owner.cheat_level + 300;
	} else {
	    self.nextthink = time + 3;
	    self.owner.cheat_level = self.owner.cheat_level + 150;
	}
	TeamFortress_SetSpeed (self.owner);
    }
    if (self.owner.cheat_level > 1200) {
	self.owner.cheat_level = 0;
	bprint2 (PRINT_MEDIUM, self.owner.netname, " has been kicked for cheating.\n");
	sprint (self.owner, PRINT_HIGH, "You have been kicked for cheating, because of your speed.\n");
	KickCheater (self.owner);
    }
};

void () PlayerObserverMode =
{
    self.current_menu = MENU_DEFAULT;
    self.impulse = 0;
    self.playerclass = PC_UNDEFINED;
    self.lives = 0;
    self.team_no = -1;

    self.flags = FL_CLIENT | FL_NOTARGET | FL_ONGROUND;
    self.waterlevel = 3;
    self.takedamage = DAMAGE_NO;
    self.solid = SOLID_NOT;
    self.movetype = MOVETYPE_NOCLIP;

    sprint (self, PRINT_HIGH, "Observer mode\n");
    CenterPrint (self, "\n");
    stuffcmd (self, "cl_rollangle 0\n");
};

float (vector veca, vector vecb) crossproduct =
{
    local float result;

    result = veca_x * vecb_y - vecb_x * veca_y;
    return (result);
};

void (entity pl, float fr) TF_AddFrags =
{
    local entity e;

    if ((intermission_running != 0) || (intermission_exittime > time))
	return;

    pl.real_frags = pl.real_frags + fr;

    if (!pl.team_no)
	return;

    if (toggleflags & TFLAG_FULLTEAMSCORE) {
	if (pl.team_no == 1)
	    team1score = team1score + fr;
	else if (pl.team_no == 2)
	    team2score = team2score + fr;
	else if (pl.team_no == 3)
	    team3score = team3score + fr;
	else if (pl.team_no == 4)
	    team4score = team4score + fr;
    }

    if (pl.team_no == 1)
	team1frags = team1frags + fr;
    else if (pl.team_no == 2)
	team2frags = team2frags + fr;
    else if (pl.team_no == 3)
	team3frags = team3frags + fr;
    else if (pl.team_no == 4)
	team4frags = team4frags + fr;

    if (toggleflags & TFLAG_FULLTEAMSCORE) {
	e = find (world, classname, "player");
	while (e) {
	    if (e.team_no == pl.team_no)
		e.frags = TeamFortress_TeamGetScore (e.team_no);
	    e = find (e, classname, "player");
	}
    } else if (!(toggleflags & TFLAG_TEAMFRAGS))
	pl.frags = pl.real_frags;
};

void (entity p) TeamFortress_ExecClassScript =
{
    local string st;

    st = infokey (p, "ec");
    if (st == string_null)
	st = infokey (p, "exec_class");

    if (st == "on") {
	if (p.playerclass == PC_SCOUT)
	    stuffcmd (p, "exec scout.cfg\n");
	else if (p.playerclass == PC_SNIPER)
            stuffcmd (p, "exec sniper.cfg\n");
	else if (p.playerclass == PC_SOLDIER)
	    stuffcmd (p, "exec soldier.cfg\n");
	else if (p.playerclass == PC_DEMOMAN)
	    stuffcmd (p, "exec demoman.cfg\n");
	else if (p.playerclass == PC_MEDIC)
	    stuffcmd (p, "exec medic.cfg\n");
	else if (p.playerclass == PC_HVYWEAP)
	    stuffcmd (p, "exec hwguy.cfg\n");
	else if (p.playerclass == PC_PYRO)
	    stuffcmd (p, "exec pyro.cfg\n");
	else if (p.playerclass == PC_SPY)
	    stuffcmd (p, "exec spy.cfg\n");
	else if (p.playerclass == PC_ENGINEER)
	    stuffcmd (p, "exec engineer.cfg\n");
    }
};

void (entity p) TeamFortress_ExecMapScript =
{
    local string st;

    st = infokey (p, "em");
    if (st == string_null)
	st = infokey (p, "exec_map");

    if (st == "on") {
	stuffcmd (p, "exec mapdefault.cfg\n");
	stuffcmd (p, "exec ");
	stuffcmd (p, mapname);
	stuffcmd (p, ".cfg\n");
    }
};

void (entity p) KickCheater =
{
    stuffcmd (p, "disconnect\n");
    p.has_disconnected = 1;
    p.touch = SUB_Null;
    p.health = 0;
    p.solid = SOLID_NOT;
    p.tfstate = p.tfstate | TFSTATE_CANT_MOVE;
    TeamFortress_SetSpeed (p);
    TeamFortress_RemoveTimers ();
};

void (entity p) BanCheater =
{
    local string st;
    stuffcmd (p, "disconnect\n");
};
