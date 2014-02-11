void (entity Item, entity AP, float method) tfgoalitem_RemoveFromPlayer;
void (entity spy) TeamFortress_SpyCalcName;
void () TeamFortress_SpyUndercoverThink;
void () GasGrenadeMakeGas;
void () T_TranqDartTouch;

void () spy_diea1 = [ 50, spy_diea2 ] {};
void () spy_diea2 = [ 51, spy_diea3 ] {};
void () spy_diea3 = [ 52, spy_diea4 ] {};
void () spy_diea4 = [ 53, spy_diea5 ] {};
void () spy_diea5 = [ 54, spy_diea6 ] {};
void () spy_diea6 = [ 55, spy_diea7 ] {};
void () spy_diea7 = [ 56, spy_diea8 ] {};
void () spy_diea8 = [ 57, spy_diea9 ] {};
void () spy_diea9 = [ 58, spy_diea10 ] {};
void () spy_diea10 = [ 59, spy_diea11 ] {};
void () spy_diea11 = [ 60, spy_diea11 ] {};

void () spy_dieb1 = [ 61, spy_dieb2 ] {};
void () spy_dieb2 = [ 62, spy_dieb3 ] {};
void () spy_dieb3 = [ 63, spy_dieb4 ] {};
void () spy_dieb4 = [ 64, spy_dieb5 ] {};
void () spy_dieb5 = [ 65, spy_dieb6 ] {};
void () spy_dieb6 = [ 66, spy_dieb7 ] {};
void () spy_dieb7 = [ 67, spy_dieb8 ] {};
void () spy_dieb8 = [ 68, spy_dieb9 ] {};
void () spy_dieb9 = [ 69, spy_dieb9 ] {};

void () spy_diec1 = [ 70, spy_diec2 ] {};
void () spy_diec2 = [ 71, spy_diec3 ] {};
void () spy_diec3 = [ 72, spy_diec4 ] {};
void () spy_diec4 = [ 73, spy_diec5 ] {};
void () spy_diec5 = [ 74, spy_diec6 ] {};
void () spy_diec6 = [ 75, spy_diec7 ] {};
void () spy_diec7 = [ 76, spy_diec8 ] {};
void () spy_diec8 = [ 77, spy_diec9 ] {};
void () spy_diec9 = [ 78, spy_diec10 ] {};
void () spy_diec10 = [ 79, spy_diec11 ] {};
void () spy_diec11 = [ 80, spy_diec12 ] {};
void () spy_diec12 = [ 81, spy_diec13 ] {};
void () spy_diec13 = [ 82, spy_diec14 ] {};
void () spy_diec14 = [ 83, spy_diec15 ] {};
void () spy_diec15 = [ 84, spy_diec15 ] {};

void () spy_died1 = [ 85, spy_died2 ] {};
void () spy_died2 = [ 86, spy_died3 ] {};
void () spy_died3 = [ 87, spy_died4 ] {};
void () spy_died4 = [ 88, spy_died5 ] {};
void () spy_died5 = [ 89, spy_died6 ] {};
void () spy_died6 = [ 90, spy_died7 ] {};
void () spy_died7 = [ 91, spy_died8 ] {};
void () spy_died8 = [ 92, spy_died9 ] {};
void () spy_died9 = [ 93, spy_died9 ] {};

void () spy_diee1 = [ 94, spy_diee2 ] {};
void () spy_diee2 = [ 95, spy_diee3 ] {};
void () spy_diee3 = [ 96, spy_diee4 ] {};
void () spy_diee4 = [ 97, spy_diee5 ] {};
void () spy_diee5 = [ 98, spy_diee6 ] {};
void () spy_diee6 = [ 99, spy_diee7 ] {};
void () spy_diee7 = [ 100, spy_diee8 ] {};
void () spy_diee8 = [ 101, spy_diee9 ] {};
void () spy_diee9 = [ 102, spy_diee9 ] {};

void () spy_die_ax1 = [ 41, spy_die_ax2 ] {};
void () spy_die_ax2 = [ 42, spy_die_ax3 ] {};
void () spy_die_ax3 = [ 43, spy_die_ax4 ] {};
void () spy_die_ax4 = [ 44, spy_die_ax5 ] {};
void () spy_die_ax5 = [ 45, spy_die_ax6 ] {};
void () spy_die_ax6 = [ 46, spy_die_ax7 ] {};
void () spy_die_ax7 = [ 47, spy_die_ax8 ] {};
void () spy_die_ax8 = [ 48, spy_die_ax9 ] {};
void () spy_die_ax9 = [ 49, spy_die_ax9 ] {};

void () spy_upb1 = [ 69, spy_upb2 ] {};
void () spy_upb2 = [ 68, spy_upb3 ] {};
void () spy_upb3 = [ 67, spy_upb4 ] {};
void () spy_upb4 = [ 66, spy_upb5 ] {};
void () spy_upb5 = [ 65, spy_upb6 ] {};
void () spy_upb6 = [ 64, spy_upb7 ] {};
void () spy_upb7 = [ 63, spy_upb8 ] {};
void () spy_upb8 = [ 62, spy_upb9 ] {};
void () spy_upb9 = [ 61, spy_upb9 ] { player_stand1 (); };

void () spy_upc1 = [ 84, spy_upc2 ] {};
void () spy_upc2 = [ 83, spy_upc3 ] {};
void () spy_upc3 = [ 82, spy_upc4 ] {};
void () spy_upc4 = [ 81, spy_upc5 ] {};
void () spy_upc5 = [ 80, spy_upc6 ] {};
void () spy_upc6 = [ 79, spy_upc7 ] {};
void () spy_upc7 = [ 78, spy_upc8 ] {};
void () spy_upc8 = [ 77, spy_upc9 ] {};
void () spy_upc9 = [ 76, spy_upc10 ] {};
void () spy_upc10 = [ 75, spy_upc11 ] {};
void () spy_upc11 = [ 74, spy_upc12 ] {};
void () spy_upc12 = [ 73, spy_upc13 ] {};
void () spy_upc13 = [ 72, spy_upc14 ] {};
void () spy_upc14 = [ 71, spy_upc15 ] {};
void () spy_upc15 = [ 70, spy_upc15 ] { player_stand1 (); };

void () spy_upd1 = [ 93, spy_upd2 ] {};
void () spy_upd2 = [ 92, spy_upd3 ] {};
void () spy_upd3 = [ 91, spy_upd4 ] {};
void () spy_upd4 = [ 90, spy_upd5 ] {};
void () spy_upd5 = [ 89, spy_upd6 ] {};
void () spy_upd6 = [ 88, spy_upd7 ] {};
void () spy_upd7 = [ 87, spy_upd8 ] {};
void () spy_upd8 = [ 86, spy_upd9 ] {};
void () spy_upd9 = [ 85, spy_upd9 ] { player_stand1 (); };

void () spy_upe1 = [ 94, spy_upe9 ] {};
void () spy_upe9;
void () spy_upe2 = [ 95, spy_upe8 ] {};
void () spy_upe8;
void () spy_upe3 = [ 96, spy_upe7 ] {};
void () spy_upe7;
void () spy_upe4 = [ 97, spy_upe6 ] {};
void () spy_upe6;
void () spy_upe5 = [ 98, spy_upe5 ] {};
void () spy_upe6 = [ 99, spy_upe4 ] {};
void () spy_upe7 = [ 100, spy_upe3 ] {};
void () spy_upe8 = [ 101, spy_upe2 ] {};
void () spy_upe9 = [ 102, spy_upe1 ] { player_stand1 (); };

void () spy_upaxe1 = [ 49, spy_upaxe2 ] {};
void () spy_upaxe2 = [ 48, spy_upaxe3 ] {};
void () spy_upaxe3 = [ 47, spy_upaxe4 ] {};
void () spy_upaxe4 = [ 46, spy_upaxe5 ] {};
void () spy_upaxe5 = [ 45, spy_upaxe6 ] {};
void () spy_upaxe6 = [ 44, spy_upaxe7 ] {};
void () spy_upaxe7 = [ 43, spy_upaxe8 ] {};
void () spy_upaxe8 = [ 42, spy_upaxe9 ] {};
void () spy_upaxe9 = [ 41, spy_upaxe9 ] { player_stand1 (); };

void (float issilent) TeamFortress_SpyFeignDeath =
{
    local float i;
    local float j;
    local entity at_spot;
    local entity te;

    if (self.is_feigning) {
	at_spot = findradius (self.origin, 64);
	i = 1;
	j = 0;
	while (at_spot != world) {
	    if (at_spot.mdl == "progs/detpack.mdl") {
		j = 1;
	    } else if ((birthday == 1) && (at_spot.mdl == "progs/detpack2.mdl")) {
		j = 1;
	    } else if (at_spot.mdl == "progs/turrbase.mdl") {
		j = 1;
	    } else if (at_spot.mdl == "progs/turrgun.mdl") {
		j = 1;
	    } else if (at_spot.mdl == "progs/disp.mdl") {
		j = 1;
	    } else if (((at_spot.classname == "player") && (at_spot.deadflag == 0)) && (self != at_spot)) {
		j = 2;
	    }
	    if (j > 0) {
		i = 0;
	    }
	    at_spot = at_spot.chain;
	}
	if (i == 1) {
	    i = 1 + floor (random () * 5);
	    self.velocity = '0 0 0';
	    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	    self.view_ofs = '0 0 22';
	    self.movetype = 3;
	    self.is_feigning = 0;
	    self.current_weapon = self.weapon;
	    W_SetCurrentAmmo ();
	    self.tfstate = self.tfstate - (self.tfstate & 65536);
	    TeamFortress_SetSpeed (self);
	    if (self.weapon <= 16) {
		spy_upaxe1 ();
		return;
	    }
	    if (i == 1) {
		spy_upb1 ();
	    } else if (i == 2) {
		spy_upc1 ();
	    } else if (i == 3) {
		spy_upd1 ();
	    } else {
		spy_upe1 ();
	    }
	} else if (j == 1) {
	    sprint (self, PRINT_HIGH, "You can't get up with something\non top of you.\n");
	} else {
	    sprint (self, PRINT_HIGH, "You can't get up while someone\nis standing on you.\n");
	}
    } else {
	if (self.is_unabletospy == 1) {
	    sprint (self, PRINT_HIGH, "You can't feign right now.\n");
	    return;
	}
	if (self.hook_out) {
	    sprint (self, PRINT_HIGH, "You can't feign with the hook out.\n");
	    return;
	}
	if (!(self.flags & 512) && (self.waterlevel == 0)) {
	    sprint (self, PRINT_HIGH, "You can't feign in the air.\n");
	    return;
	}
	at_spot = findradius (self.origin, 64);
	while (at_spot != world) {
	    if (((at_spot.classname == "player") && (self != at_spot)) && (at_spot.is_feigning == 1)) {
		sprint (self, PRINT_HIGH, "You can't feign on top of another spy!\n");
		return;
	    }
	    at_spot = at_spot.chain;
	}
	self.immune_to_check = time + 5;
	self.tfstate = self.tfstate | 65536;
	TeamFortress_SetSpeed (self);
	self.is_feigning = 1;
	Attack_Finished (0.8);
	self.invisible_finished = 0;
	self.modelindex = modelindex_player;
	self.weapon = self.current_weapon;
	self.current_weapon = 0;
	self.weaponmodel = "";
	self.weaponframe = 0;
	setsize (self, '-16 -16 -24', '16 16 -16');
	self.view_ofs = '0 0 4';
	self.movetype = 6;
	if (issilent == 0) {
	    DeathSound ();
	}
	self.angles_x = 0;
	self.angles_z = 0;
	if (self.weapon <= 16) {
	    spy_die_ax1 ();
	    return;
	}
	te = find (world, classname, "item_tfgoal");
	while (te) {
	    if (te.owner == self) {
		if (!(te.goal_activation & 256) || (self.has_disconnected == 1)) {
		    tfgoalitem_RemoveFromPlayer (te, self, 0);
		}
		if (CTF_Map == 1) {
		    if (te.goal_no == 1)
			bprint (PRINT_HIGH, self.netname, " лост the блуе flag!\n");
		    else if (te.goal_no == 2)
			bprint (PRINT_HIGH, self.netname, " лост the ред flag!\n");
		}
	    }
	    te = find (te, classname, "item_tfgoal");
	}
	i = 1 + floor ((random () * 6));
	if (i == 1) {
	    spy_diea1 ();
	} else {
	    if (i == 2) {
		spy_dieb1 ();
	    } else {
		if (i == 3) {
		    spy_diec1 ();
		} else {
		    if (i == 4) {
			spy_died1 ();
		    } else {
			spy_diee1 ();
		    }
		}
	    }
	}
    }
};

void () TeamFortress_SpyGoUndercover =
{
    local entity te;

    if (self.effects & (8 | 4)) {
	sprint (self, PRINT_MEDIUM, "You cannot disguise while glowing.\n");
	return;
    }
    if (self.is_unabletospy == 1) {
	sprint (self, PRINT_HIGH, "You can't go undercover right now.\n");
	return;
    }
    if (invis_only == 1) {
	if ((self.is_undercover == 1) || (self.items & 524288)) {
	    self.items = self.items - 524288;
	    self.invisible_finished = 0;
	    self.invisible_time = 0;
	    self.is_undercover = 0;
	    self.modelindex = modelindex_player;
	} else if (self.is_undercover == 2) {
	    sprint (self, PRINT_HIGH, "You stop going undercover.\n");
	    self.is_undercover = 0;
	} else if (self.ammo_cells > 1) {
	    sprint (self, PRINT_HIGH, "Going undercover...\n");
	    self.is_undercover = 2;
	    te = spawn ();
	    te.classname = "timer";
	    te.owner = self;
	    te.think = TeamFortress_SpyUndercoverThink;
	    te.nextthink = time + 4;
	}
	self.StatusRefreshTime = time + 0.1;
    } else if (self.is_undercover != 2) {
	self.current_menu = MENU_SPY;
	self.menu_count = 25;
    } else {
	sprint (self, PRINT_HIGH, "You stop going undercover.\n");
	self.is_undercover = 0;
    }
};

void (entity spy) TeamFortress_SpyCalcName =
{
    local entity te;

    spy.undercover_name = string_null;
    if (spy.undercover_team != 0) {
	te = find (world, classname, "player");
	while (te) {
	    if ((te.team_no == spy.undercover_team) && (te.skin == spy.undercover_skin)) {
		spy.undercover_name = te.netname;
		te = world;
	    } else {
		te = find (te, classname, "player");
	    }
	}
	if (spy.undercover_name == string_null) {
	    te = find (world, classname, "player");
	    while (te) {
		if (te.team_no == spy.undercover_team) {
		    spy.undercover_name = te.netname;
		    te = world;
		} else {
		    te = find (te, classname, "player");
		}
	    }
	}
    }
};

void () TeamFortress_SpyUndercoverThink =
{
    local float tc;
    local string st;

    if (self.owner.playerclass != 8) {
	return;
    }
    if (self.owner.is_undercover == 2) {
	if (invis_only == 1) {
	    self.owner.items = self.owner.items | 524288;
	    self.owner.frame = 0;
	    self.owner.modelindex = modelindex_eyes;
	    self.owner.is_undercover = 1;
	} else {
	    self.owner.immune_to_check = time + 10;
	    if (self.skin != 0) {
		sprint (self.owner, PRINT_HIGH, "Skin set to ");
		TeamFortress_PrintClassName (self.owner, self.skin, 0);
		self.owner.undercover_skin = self.skin;
		TeamFortress_SetSkin (self.owner);
	    }
	    if (self.team != 0) {
		sprint (self.owner, PRINT_HIGH, "Colors set to Team ");
		st = ftos (self.team);
		sprint (self.owner, PRINT_HIGH, st, "\n");
		self.owner.undercover_team = self.team;
		stuffcmd (self.owner, "color ");
		tc = TeamFortress_TeamGetColor (self.team) - 1;
		st = ftos (tc);
		stuffcmd (self.owner, st);
		stuffcmd (self.owner, "\n");
		TeamFortress_SetSkin (self.owner);
	    }
	    TeamFortress_SpyCalcName (self.owner);
	    if (self.owner.StatusBarSize == 0) {
		CenterPrint (self.owner, "You are now disguised.\n");
	    }
	    self.owner.is_undercover = 1;
	}
    }
    self.owner.StatusRefreshTime = time + 0.1;
    dremove (self);
};

void (float class) TeamFortress_SpyChangeSkin =
{
    local entity te;

    if (class == 8) {
	sprint (self, PRINT_HIGH, "Skin reset.\n");
	self.undercover_skin = 0;
	TeamFortress_SetSkin (self);
	if (self.undercover_team == 0) {
	    self.is_undercover = 0;
	}
	return;
    }
    sprint (self, PRINT_HIGH, "Going undercover...\n");
    self.is_undercover = 2;
    te = spawn ();
    te.classname = "timer";
    te.owner = self;
    te.think = TeamFortress_SpyUndercoverThink;
    te.nextthink = time + 4;
    te.skin = class;
    TeamFortress_SetSkin (self);
};

void (float teamno) TeamFortress_SpyChangeColor =
{
    local entity te;
    local string st;
    local float tc;

    if (teamno == self.team_no) {
	sprint (self, PRINT_HIGH, "Colors reset.\n");
	self.immune_to_check = time + 10;
	self.undercover_team = 0;
	stuffcmd (self, "color ");
	tc = TeamFortress_TeamGetColor (self.team_no) - 1;
	st = ftos (tc);
	stuffcmd (self, st);
	stuffcmd (self, "\n");
	if (self.undercover_skin == 0) {
	    self.is_undercover = 0;
	}
	TeamFortress_SetSkin (self);
	return;
    }
    sprint (self, PRINT_HIGH, "Going undercover...\n");
    self.is_undercover = 2;
    te = spawn ();
    te.classname = "timer";
    te.owner = self;
    te.think = TeamFortress_SpyUndercoverThink;
    te.nextthink = time + 4;
    te.team = teamno;
};

void () GasGrenadeTouch =
{
    sound (self, 1, "weapons/bounce.wav", 1, 1);
    if (self.velocity == '0 0 0')
	self.avelocity = '0 0 0';
};

void () GasGrenadeExplode =
{
    local entity te;
    local float pos;

    pos = pointcontents (self.origin);
    if (pos == -1) {
	te = spawn ();
	te.think = GasGrenadeMakeGas;
	te.nextthink = time + 0.1;
	te.classname = "grentimer";
	te.heat = 0;
	te.origin = self.origin;
	te.owner = self.owner;
	te.team_no = self.owner.team_no;
	te.weapon = 0;
	te.enemy = self;
    } else {
	pos = 0;
	while (pos < 10) {
	    newmis = spawn ();
	    setmodel (newmis, "progs/s_bubble.spr");
	    setorigin (newmis, self.origin);
	    newmis.movetype = 8;
	    newmis.solid = 0;
	    newmis.velocity = '0 0 15';
	    newmis.velocity_z = 10 + (random () * 20);
	    newmis.nextthink = time + 0.5;
	    newmis.think = bubble_bob;
	    newmis.classname = "bubble";
	    newmis.frame = 0;
	    newmis.cnt = 0;
	    setsize (newmis, '-8 -8 -8', '8 8 8');
	    pos = pos + 1;
	}
    }
    dremove (self);
};

void () GasGrenadeMakeGas =
{
    local entity te;
    local entity timer;

    if (self.heat == 0) {
	self.owner.no_active_gas_grens = self.owner.no_active_gas_grens + 1;
	if (self.owner.no_active_gas_grens > 2) {
	    te = find (world, classname, "grentimer");
	    while (te) {
		if ((te.owner == self.owner) && (te.no_active_gas_grens == 1)) {
		    te.weapon = 24;
		    te.think = RemoveGrenade;
		    te.nextthink = time + 0.1;
		}
		te = find (te, classname, "grentimer");
	    }
	}
	self.no_active_gas_grens = self.owner.no_active_gas_grens;
    }
    self.nextthink = time + 0.75;
    te = findradius (self.origin, 200);
    while (te != world) {
	if (((te.classname == "player") && (te.deadflag == 0)) && (te.has_disconnected != 1)) {
	    deathmsg = 24;
	    TF_T_Damage (te, world, self.owner, 10, (1 | 2), 0);
	    if (te.tfstate & 16384) {
		timer = find (world, classname, "timer");
		while (((timer.owner != te) || (timer.think != HallucinationTimer)) && (timer != world)) {
		    timer = find (timer, classname, "timer");
		}
		if (timer != world) {
		    timer.health = timer.health + 25;
		    if (old_grens == 1) {
			if (timer.health < 100) {
			    timer.health = 100;
			}
			timer.nextthink = time + 0.5;
		    } else {
			if (timer.health < 150) {
			    timer.health = 150;
			}
			timer.nextthink = time + 0.3;
		    }
		}
	    } else {
		if (old_grens == 1) {
		    stuffcmd (te, "v_cshift 50 25 50 -50\n");
		    sprint (te, PRINT_HIGH, "Far out man!\n");
		} else {
		    sprint (te, PRINT_HIGH, "Run for cover! They're everywhere!\n");
		}
		te.tfstate = te.tfstate | TFSTATE_HALLUCINATING;
		timer = spawn ();
		if (old_grens == 1)
		    timer.nextthink = time + 0.5;
		else
		    timer.nextthink = time + 0.3;
		timer.think = HallucinationTimer;
		timer.classname = "timer";
		timer.owner = te;
		if (old_grens == 1)
		    timer.health = 100;
		else
		    timer.health = 150;
		timer.team_no = self.team_no;
	    }
	}
	te = te.chain;
    }
    self.heat = self.heat + 1;
    if (self.heat == 1) {
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_TAREXPLOSION);
	WriteCoord (MSG_MULTICAST, self.origin_x);
	WriteCoord (MSG_MULTICAST, self.origin_y);
	WriteCoord (MSG_MULTICAST, self.origin_z);
	multicast (self.origin, MULTICAST_PVS);
	return;
    }
    if (self.heat <= 20) {
	self.weapon = self.weapon + 1;
	if (self.weapon == 1) {
	    WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	    WriteByte (MSG_MULTICAST, TE_LAVASPLASH);
	    WriteCoord (MSG_MULTICAST, self.origin_x);
	    WriteCoord (MSG_MULTICAST, self.origin_y);
	    WriteCoord (MSG_MULTICAST, self.origin_z - 24);
	    multicast (self.origin, MULTICAST_PVS);
	} else if (self.weapon == 2)
	    self.weapon = 0;
	return;
    }
    RemoveGrenade ();
};

void () HallucinationTimer =
{
    local entity te;
    local float tmpx;
    local float tmpy;
    local float halltype;
    local float halltype2;
    local string st;

    self.health = self.health - 2.5;
    if (self.owner.playerclass == PC_MEDIC) {
	self.health = self.health - 2.5;
    }
    if (((self.health <= 0) || (self.owner.deadflag != 0)) || (self.owner.has_disconnected == 1)) {
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & 16384);
    }
    if ((self.owner.deadflag != 0) || (self.owner.has_disconnected == 1)) {
	dremove (self);
	return;
    }
    if (!(self.owner.tfstate & 16384)) {
	if (old_grens == 1)
	    stuffcmd (self.owner, "v_cshift; wait; bf\n");
	sprint (self.owner, 2, "You feel a little better now.\n");
	dremove (self);
	return;
    }
    if (old_grens == 1)
	self.nextthink = time + 0.5;
    else
	self.nextthink = time + 0.3;

    if (random () < 0.5)
	KickPlayer (-10, self.owner);

    if (old_grens == 1) {
	stuffcmd (self.owner, "v_cshift ");
	halltype = random () * 100;
	st = ftos (halltype);
	stuffcmd (self.owner, st);
	stuffcmd (self.owner, " ");
	halltype = random () * 100;
	st = ftos (halltype);
	stuffcmd (self.owner, st);
	stuffcmd (self.owner, " ");
	halltype = random () * 100;
	st = ftos (halltype);
	stuffcmd (self.owner, st);
	stuffcmd (self.owner, " -75\n");
    }
    tmpx = random () * 800 - 400;
    tmpy = random () * 800 - 400;
    halltype = random ();
    halltype2 = random ();
    msg_entity = self.owner;
    if (halltype < 0.4) {
	WriteByte (MSG_ONE, SVC_TEMPENTITY);
	if (halltype < 0.25) {
	    WriteByte (MSG_ONE, TE_EXPLOSION);
	} else if (halltype < 0.35) {
	    WriteByte (MSG_ONE, TE_TAREXPLOSION);
	} else {
	    WriteByte (MSG_ONE, TE_LAVASPLASH);
	}
	WriteCoord (MSG_ONE, msg_entity.origin_x + tmpx);
	WriteCoord (MSG_ONE, msg_entity.origin_y + tmpy);
	WriteCoord (MSG_ONE, msg_entity.origin_z);

	if (old_grens != 1)
	    T_Damage (self.owner, self.owner, self.owner, 0);

    } else if (halltype < 0.7) {
	WriteByte (MSG_ONE, SVC_TEMPENTITY);
	WriteByte (MSG_ONE, TE_TELEPORT);
	WriteCoord (MSG_ONE, msg_entity.origin_x + tmpx);
	WriteCoord (MSG_ONE, msg_entity.origin_y + tmpy);
	WriteCoord (MSG_ONE, msg_entity.origin_z);

	if (old_grens != 1) {
	    if (halltype2 < 0.1) {
		stuffcmd (self.owner, "play weapons/r_exp3.wav\n");
	    } else if (halltype2 < 0.15) {
		stuffcmd (self.owner, "play weapons/rocket1i.wav\n");
	    } else if (halltype2 < 0.2) {
		stuffcmd (self.owner, "play weapons/sgun1.wav\n");
	    } else if (halltype2 < 0.25) {
		stuffcmd (self.owner, "play weapons/guncock.wav\n");
	    } else if (halltype2 < 0.3) {
		stuffcmd (self.owner, "play weapons/ric1.wav\n");
	    } else if (halltype2 < 0.35) {
		stuffcmd (self.owner, "play weapons/ric2.wav\n");
	    } else if (halltype2 < 0.4) {
		stuffcmd (self.owner, "play weapons/ric3.wav\n");
	    } else if (halltype2 < 0.45) {
		stuffcmd (self.owner, "play weapons/spike2.wav\n");
	    } else if (halltype2 < 0.5) {
		stuffcmd (self.owner, "play weapons/tink1.wav\n");
	    } else if (halltype2 < 0.55) {
		CenterPrint2 (self.owner, "\n\n\n", "Your team цаптуред the flag!!");
		stuffcmd (self.owner, "play weapons/grenade.wav\n");
	    } else if (halltype2 < 0.6) {
		stuffcmd (self.owner, "play weapons/bounce.wav\n");
	    } else if (halltype2 < 0.65) {
		stuffcmd (self.owner, "play weapons/shotgn2.wav\n");
	    } else if (halltype2 < 0.7) {
		stuffcmd (self.owner, "play wizard/wattack.wav\n");
	    } else if (halltype2 < 0.75) {
		stuffcmd (self.owner, "play items/r_item1.wav\n");
	    } else if (halltype2 < 0.8) {
		stuffcmd (self.owner, "play items/r_item2.wav\n");
	    } else if (halltype2 < 0.85) {
		CenterPrint (self.owner, "You are on fire!\n");
		stuffcmd (self.owner, "play weapons/lhit.wav\n");
	    } else if (halltype2 < 0.9) {
		stuffcmd (self.owner, "play misc/r_tele1.wav\n");
	    } else {
		stuffcmd (self.owner, "play weapons/railgun.wav\n");
	    }
	}
    } else {
	te = spawn ();
	te.origin_x = msg_entity.origin_x + tmpx;
	te.origin_y = msg_entity.origin_y + tmpy;
	te.origin_z = msg_entity.origin_z;

	WriteByte (MSG_ONE, SVC_TEMPENTITY);
	WriteByte (MSG_ONE, TE_LIGHTNING2);
	WriteEntity (MSG_ONE, te);
	WriteCoord (MSG_ONE, te.origin_x);
	WriteCoord (MSG_ONE, te.origin_y);
	WriteCoord (MSG_ONE, te.origin_z);
	tmpx = random () * 800 - 400;
	tmpy = random () * 800 - 400;
	WriteCoord (MSG_ONE, msg_entity.origin_x + tmpx);
	WriteCoord (MSG_ONE, msg_entity.origin_y + tmpy);
	WriteCoord (MSG_ONE, msg_entity.origin_z);

	if (old_grens != 1) {
	    if (halltype2 < 0.1) {
		stuffcmd (self.owner, "play weapons/detpack.wav\n");
	    } else if (halltype2 < 0.2) {
		stuffcmd (self.owner, "play weapons/turrset.wav\n");
	    } else if (halltype2 < 0.3) {
		stuffcmd (self.owner, "play weapons/turrspot.wav\n");
	    } else if (halltype2 < 0.4) {
		stuffcmd (self.owner, "play weapons/turridle.wav\n");
	    } else if (halltype2 < 0.5) {
		stuffcmd (self.owner, "play weapons/sniper.wav\n");
	    } else if (halltype2 < 0.6) {
		CenterPrint2 (self.owner, "\n\n\n", "Your flag has been такен!!");
		stuffcmd (self.owner, "play weapons/flmfire2.wav\n");
	    } else if (halltype2 < 0.7) {
		stuffcmd (self.owner, "play weapons/flmgrexp.wav\n");
	    } else if (halltype2 < 0.8) {
		stuffcmd (self.owner, "play misc/vapeur2.wav\n");
	    } else if (halltype2 < 0.9) {
		stuffcmd (self.owner, "play weapons/asscan1.wav\n");
	    } else {
		stuffcmd (self.owner, "play weapons/asscan2.wav\n");
	    }
	}
	dremove (te);
    }
};

void () W_FireTranq =
{
    self.ammo_shells = self.ammo_shells - 1;
    self.currentammo = self.ammo_shells - 1;
    KickPlayer (-2, self);
    newmis = spawn ();
    newmis.owner = self;
    newmis.movetype = 9;
    newmis.solid = 2;
    makevectors (self.v_angle);
    newmis.velocity = v_forward;
    newmis.velocity = newmis.velocity * 1500;
    newmis.angles = vectoangles (newmis.velocity);
    newmis.touch = T_TranqDartTouch;
    newmis.think = SUB_Remove;
    newmis.nextthink = time + 6;
    setmodel (newmis, "progs/spike.mdl");
    setsize (newmis, '0 0 0', '0 0 0');
    setorigin (newmis, self.origin + v_forward * 8 + '0 0 16');
};

void () T_TranqDartTouch =
{
    local entity timer;

    if (other.solid == 1)
	return;

    if (pointcontents (self.origin) == CONTENT_SKY) {
	dremove (self);
	return;
    }
    if (other.takedamage) {
	if ((other.classname == "player") && !((other.team_no == self.owner.team_no) && (teamplay & (2 | 4)))) {
	    if (other.tfstate & 32768) {
		timer = find (world, classname, "timer");
		while (((timer.owner != other) || (timer.think != TranquiliserTimer)) && (timer != world)) {
		    timer = find (timer, classname, "timer");
		}
		if (timer != world) {
		    timer.nextthink = time + 15;
		}
	    } else {
		sprint (other, 2, "You feel tired...\n");
		other.tfstate = other.tfstate | 32768;
		timer = spawn ();
		timer.nextthink = time + 15;
		timer.think = TranquiliserTimer;
		timer.classname = "timer";
		timer.owner = other;
		timer.team_no = self.owner.team_no;
		TeamFortress_SetSpeed (other);
	    }
	}
	spawn_touchblood (9);
	deathmsg = 25;
	TF_T_Damage (other, self, self.owner, 20, 2, 2);
    } else {
	WriteByte (4, 23);
	if (self.classname == "wizspike") {
	    WriteByte (4, 7);
	} else {
	    if (self.classname == "knightspike") {
		WriteByte (4, 8);
	    } else {
		WriteByte (4, 0);
	    }
	}
	WriteCoord (4, self.origin_x);
	WriteCoord (4, self.origin_y);
	WriteCoord (4, self.origin_z);
	multicast (self.origin, 2);
    }
    dremove (self);
};

void () TranquiliserTimer =
{
    self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & 32768);
    TeamFortress_SetSpeed (self.owner);
    sprint (self.owner, PRINT_HIGH, "You feel more alert now\n");
    dremove (self);
};

void (entity spy) Spy_RemoveDisguise =
{
    local string st;
    local float tc;

    if (invis_only != 1) {
	if (spy.playerclass == 8) {
	    if (spy.undercover_team != 0) {
		spy.immune_to_check = time + 10;
		spy.undercover_team = 0;
		stuffcmd (spy, "color ");
		tc = TeamFortress_TeamGetColor (spy.team_no) - 1;
		st = ftos (tc);
		stuffcmd (spy, st);
		stuffcmd (spy, "\n");
	    }
	    if (spy.undercover_skin != 0) {
		spy.immune_to_check = time + 10;
		spy.undercover_skin = 0;
		spy.skin = 0;
	    }
	    spy.is_undercover = 0;
	    self.StatusRefreshTime = time + 0.1;
	    TeamFortress_SetSkin (spy);
	    TeamFortress_SpyCalcName (spy);
	}
    } else if (spy.is_undercover) {
	spy.is_undercover = 0;
	spy.modelindex = modelindex_player;
	if (spy.items & 524288) {
	    spy.invisible_finished = 0;
	    spy.invisible_time = 0;
	    spy.items = spy.items - 524288;
	}
	self.StatusRefreshTime = time + 0.1;
    }
};
