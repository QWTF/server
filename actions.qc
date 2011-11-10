//========================================================
// Non Class-Specific Impulse Commands
//========================================================

void () TeamFortress_Discard =
{
    newmis = spawn ();
    if ((self.playerclass == PC_SCOUT)
	|| (self.playerclass == PC_SPY)
	|| (self.playerclass == PC_ENGINEER)) {
	newmis.ammo_rockets = self.ammo_rockets;
    } else if ((self.playerclass == PC_SNIPER)
	       || (self.playerclass == PC_MEDIC)) {
	newmis.ammo_rockets = self.ammo_rockets;
	newmis.ammo_cells = self.ammo_cells;
    } else if ((self.playerclass == PC_SOLDIER)
	       || (self.playerclass == PC_DEMOMAN)) {
	newmis.ammo_cells = self.ammo_cells;
	newmis.ammo_nails = self.ammo_nails;
    } else if (self.playerclass == PC_HVYWEAP) {
	newmis.ammo_rockets = self.ammo_rockets;
	newmis.ammo_nails = self.ammo_nails;
    } else if (self.playerclass == PC_PYRO) {
	newmis.ammo_nails = self.ammo_nails;
    }

    if (!(((newmis.ammo_shells + newmis.ammo_nails) + newmis.ammo_rockets) + newmis.ammo_cells)) {
	dremove (newmis);
	return;
    }
    if (newmis.ammo_shells) {
	self.ammo_shells = 0;
    }
    if (newmis.ammo_nails) {
	self.ammo_nails = 0;
    }
    if (newmis.ammo_rockets) {
	self.ammo_rockets = 0;
    }
    if (newmis.ammo_cells) {
	self.ammo_cells = 0;
    }
    W_SetCurrentAmmo ();
    sound (self, CHAN_ITEM, "weapons/lock4.wav", 1, ATTN_NORM);
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
    newmis.enemy = self;
    newmis.health = time;
    newmis.weapon = 0;
    newmis.movetype = MOVETYPE_TOSS;
    newmis.solid = SOLID_TRIGGER;
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
    setmodel (newmis, "progs/backpack.mdl");
};

void () TeamFortress_SaveMe =
{
    local entity te, tl;

    if (self.last_saveme_sound < time) {
	if (random () < 0.8)
	    sound (self, CHAN_WEAPON, "speech/saveme1.wav", 1, ATTN_NORM);
	else
	    sound (self, CHAN_WEAPON, "speech/saveme2.wav", 1, ATTN_NORM);

	self.last_saveme_sound = time + 4;
    }
    te = find (world, classname, "player");
    while (te) {
	if ((self == te)
	    || (te.playerclass == PC_MEDIC)
	    || (te.playerclass == PC_ENGINEER)
	    || (te.playerclass == PC_SPY)) {
            if (((te.team_no == self.team_no) && (self.team_no != 0)) || (te.playerclass == PC_SPY)) {
		if (visible (te)) {
		    msg_entity = te;
		    tl = spawn ();
		    tl.origin = self.origin;
		    tl.origin_z = tl.origin_z + 32;
		    WriteByte (MSG_ONE, SVC_TEMPENTITY);
		    WriteByte (MSG_ONE, TE_LIGHTNING3);
		    WriteEntity (MSG_ONE, tl);
		    WriteCoord (MSG_ONE, tl.origin_x);
		    WriteCoord (MSG_ONE, tl.origin_y);
		    WriteCoord (MSG_ONE, tl.origin_z + 24);
		    WriteCoord (MSG_ONE, self.origin_x);
		    WriteCoord (MSG_ONE, self.origin_y);
		    WriteCoord (MSG_ONE, self.origin_z);
		    dremove (tl);
		}
	    }
	}
	te = find (te, classname, "player");
    }
};

void () TeamFortress_ID =
{
    local vector src;
    local string st;
    local string cls;

    src = self.origin + v_forward * 10;
    src_z = self.absmin_z + self.size_z * 0.7;

    traceline (src, src + v_forward * 2048, 0, self);
    if ((trace_ent != world) && (trace_ent.origin != world.origin)) {
	if ((trace_ent.classname == "player") && (trace_ent.health > 0)) {
	    if (trace_ent.is_feigning && (self.team_no != 0) && (self.team_no != trace_ent.team_no)) {
		return;
	    }
	    self.StatusRefreshTime = time + 1.5;
	    if (((self.team_no != 0) && (self.team_no == trace_ent.team_no))
		|| (self.classname == "observer")) {
		cls = TeamFortress_GetClassName (trace_ent.playerclass);
		if (self.playerclass == PC_MEDIC) {
		    st = NumberToString1000 (trace_ent.health);
		    centerprint (self, "\n\n\n\n", trace_ent.netname,
				 "\nFriendly ", cls, "\n", st, " health\n");
		    return;
		} else if (self.playerclass == PC_ENGINEER) {
		    st = NumberToString1000 (trace_ent.armorvalue);
		    centerprint (self, "\n\n\n\n", trace_ent.netname,
				 "\nFriendly ", cls, "\n", st, " armor\n");
		    return;
		}
		centerprint (self, "\n\n\n\n", trace_ent.netname, "\nFriendly ", cls);
		return;
	    }
	    if (trace_ent.playerclass == 8) {
		cls = TeamFortress_GetClassName (trace_ent.undercover_skin);
		if ((self.team_no != 0) && (self.team_no == trace_ent.undercover_team)) {
		    if (self.playerclass == 5) {
			st = NumberToString1000 (trace_ent.health);
			if (trace_ent.undercover_skin != 0) {
			    centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly ", cls, "\n", st, " health\n");
			} else {
			    centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly Spy\n", st, " health\n");
			}
			return;
		    } else {
			if (self.playerclass == 9) {
			    st = NumberToString1000 (trace_ent.armorvalue);
			    if (trace_ent.undercover_skin != 0) {
				centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly ", cls, "\n", st, " armor\n");
			    } else {
				centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly Spy\n", st, " armor\n");
			    }
			    return;
			} else {
			    st = NumberToString1000 (trace_ent.armorvalue);
			    if (trace_ent.undercover_skin != 0) {
				centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly ", cls);
			    } else {
				centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly Spy\n");
			    }
			    return;
			}
		    }
		}
		if (trace_ent.undercover_name != string_null) {
		    if (trace_ent.undercover_skin != 0) {
			centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nEnemy ", cls);
		    } else {
			centerprint (self, "\n\n\n\n", trace_ent.undercover_name, "\nEnemy Spy");
		    }
		} else {
		    if (trace_ent.undercover_skin != 0) {
			centerprint (self, "\n\n\n\n", trace_ent.netname, "\nEnemy ", cls);
		    } else {
			centerprint (self, "\n\n\n\n", trace_ent.netname, "\nEnemy Spy");
		    }
		}
	    } else {
		cls = TeamFortress_GetClassName (trace_ent.playerclass);
		centerprint (self, "\n\n\n\n", trace_ent.netname, "\nEnemy ", cls);
	    }
	} else {
	    if (trace_ent.classname == "building_dispenser") {
		self.StatusRefreshTime = time + 1.5;
		if (self == trace_ent.real_owner) {
		    centerprint (self, "\n\n\n\nYour Dispenser");
		} else {
		    centerprint (self, "\n\n\n\nDispenser made by ", trace_ent.real_owner.netname);
		}
	    } else {
		if ((trace_ent.classname == "building_sentrygun") || (trace_ent.classname == "building_sentrygun_base")) {
		    self.StatusRefreshTime = time + 1.5;
		    if (self == trace_ent.real_owner) {
			centerprint (self, "\n\n\n\nYour SentryGun");
		    } else {
			if (!teamplay) {
			    centerprint (self, "\n\n\n\nSentrygun made by\n", trace_ent.real_owner.netname);
			} else {
			    if (((self.team_no != 0) && (self.team_no == trace_ent.team_no)) || (self.playerclass == 0)) {
				centerprint (self, "\n\n\n\nFriendly Sentrygun made by\n", trace_ent.real_owner.netname);
			    } else {
				centerprint (self, "\n\n\n\nEnemy Sentrygun made by\n", trace_ent.real_owner.netname);
			    }
			}
		    }
		}
	    }
	}
    }
};

void () TeamFortress_ReloadCurrentWeapon =
{
    local float rt;
    local entity tWeapon;

    if (self.tfstate & 2) {
	return;
    }
    if (self.current_weapon == 128) {
	if (self.ammo_shells == 0) {
	    sprint (self, PRINT_HIGH, "out of shells.\n");
	    return;
	}
	if (self.reload_shotgun == 0) {
	    sprint (self, PRINT_HIGH, "clip full.\n");
	    return;
	}
	if ((8 - self.reload_shotgun) == self.ammo_shells) {
	    sprint (self, PRINT_HIGH, "all shells are in the clip.\n");
	    return;
	}
	if (self.reload_shotgun < self.ammo_shells) {
	    Attack_Finished (0.4);
	    rt = (8 - self.reload_shotgun) / 8;
	    rt = 2 - 2 * rt;
	    self.reload_shotgun = 0;
	    if (self.ammo_shells < 8) {
		self.reload_shotgun = 8 - self.ammo_shells;
	    }
	    sprint (self, PRINT_HIGH, "reloading...\n");
	    self.tfstate = self.tfstate | 2;
	    tWeapon = spawn ();
	    tWeapon.owner = self;
	    tWeapon.classname = "timer";
	    tWeapon.nextthink = time + rt;
	    tWeapon.think = W_Reload_shotgun;
	    self.weaponmodel = "";
	    self.weaponframe = 0;
	} else {
	    sprint (self, PRINT_HIGH, "not enough ammo to reload\n");
	}
    } else {
	if (self.current_weapon == 256) {
	    if (self.ammo_shells == 0) {
		sprint (self, PRINT_HIGH, "out of shells.\n");
		return;
	    }
	    if (self.reload_super_shotgun == 0) {
		sprint (self, PRINT_HIGH, "clip full.\n");
		return;
	    }
	    if ((16 - self.reload_super_shotgun) == self.ammo_shells) {
		sprint (self, PRINT_HIGH, "all shells are in the clip.\n");
		return;
	    }
	    if (self.reload_super_shotgun < self.ammo_shells) {
		Attack_Finished (0.7);
		rt = (16 - self.reload_super_shotgun) / 16;
		rt = 3 - (3 * rt);
		self.reload_super_shotgun = 0;
		if (self.ammo_shells < 16) {
		    self.reload_super_shotgun = 16 - self.ammo_shells;
		}
		sprint (self, PRINT_HIGH, "reloading...\n");
		self.tfstate = self.tfstate | 2;
		tWeapon = spawn ();
		tWeapon.owner = self;
		tWeapon.classname = "timer";
		tWeapon.nextthink = time + rt;
		tWeapon.think = W_Reload_super_shotgun;
		self.weaponmodel = "";
		self.weaponframe = 0;
	    } else {
		sprint (self, PRINT_HIGH, "not enough ammo to reload\n");
	    }
	} else {
	    if (self.current_weapon == 2048) {
		if (self.ammo_rockets == 0) {
		    sprint (self, PRINT_HIGH, "out of grenades.\n");
		    return;
		}
		if (self.reload_grenade_launcher == 0) {
		    sprint (self, PRINT_HIGH, "clip full.\n");
		    return;
		}
		if ((6 - self.reload_grenade_launcher) == self.ammo_rockets) {
		    sprint (self, PRINT_HIGH, "all grenades are in the clip.\n");
		    return;
		}
		if (self.reload_grenade_launcher < self.ammo_rockets) {
		    Attack_Finished (0.6);
		    rt = (6 - self.reload_grenade_launcher) / 6;
		    rt = 4 - 4 * rt;
		    self.reload_grenade_launcher = 0;
		    if (self.ammo_rockets < 6) {
			self.reload_grenade_launcher = 6 - self.ammo_rockets;
		    }
		    sprint (self, PRINT_HIGH, "reloading...\n");
		    self.tfstate = self.tfstate | 2;
		    tWeapon = spawn ();
		    tWeapon.owner = self;
		    tWeapon.classname = "timer";
		    tWeapon.nextthink = time + rt;
		    tWeapon.think = W_Reload_grenade_launcher;
		    self.weaponmodel = "";
		    self.weaponframe = 0;
		} else {
		    sprint (self, PRINT_HIGH, "not enough ammo to reload\n");
		}
	    } else {
		if (self.current_weapon == 8192) {
		    if (self.ammo_rockets == 0) {
			sprint (self, PRINT_HIGH, "out of rockets.\n");
			return;
		    }
		    if (self.reload_rocket_launcher == 0) {
			sprint (self, PRINT_HIGH, "clip full.\n");
			return;
		    }
		    if ((4 - self.reload_rocket_launcher) == self.ammo_rockets) {
			sprint (self, PRINT_HIGH, "all rockets are in the clip.\n");
			return;
		    }
		    if (self.reload_rocket_launcher < self.ammo_rockets) {
			Attack_Finished (0.8);
			rt = (4 - self.reload_rocket_launcher) / 4;
			rt = 5 - (5 * rt);
			self.reload_rocket_launcher = 0;
			if (self.ammo_rockets < 4) {
			    self.reload_rocket_launcher = 4 - self.ammo_rockets;
			}
			sprint (self, PRINT_HIGH, "reloading...\n");
			self.tfstate = self.tfstate | 2;
			tWeapon = spawn ();
			tWeapon.owner = self;
			tWeapon.classname = "timer";
			tWeapon.nextthink = time + rt;
			tWeapon.think = W_Reload_rocket_launcher;
			self.weaponmodel = "";
			self.weaponframe = 0;
		    } else {
			sprint (self, PRINT_HIGH, "not enough ammo to reload\n");
		    }
		}
	    }
	}
    }
};

void (float messageno) TeamFortress_Message =
{
    local entity te, tl;
    local string wstr;

    wstr = infokey (world, "clanmsgs");
    if (wstr != "on")
	return;

    if (self.last_saveme_sound > time)
	return;

    self.last_saveme_sound = time + 3;
    if (messageno == 1)
	wstr = "play clan1.wav\n";
    else if (messageno == 2)
	wstr = "play clan2.wav\n";
    else if (messageno == 3)
	wstr = "play clan3.wav\n";
    else if (messageno == 4)
	wstr = "play clan4.wav\n";
    else if (messageno == 5)
	wstr = "play clan5.wav\n";

    te = find (world, classname, "player");
    while (te) {
	if ((te.team_no == self.team_no) && (self.team_no != 0))
	    stuffcmd (te, wstr);
	te = find (te, classname, "player");
    }
};
