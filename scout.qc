//========================================================
// Functions for the SCOUT class and associated weaponry
//========================================================

void () CaltropTouch;
void () CaltropScatterThink;
void () ScatterCaltrops;
void () FlashGrenadeTouch;
void () FlashTimer;
void () FlashGrenadeExplode;
void () ConcussionGrenadeTouch;
void () ConcussionGrenadeExplode;

void (entity inflictor, entity attacker, float bounce, entity ignore) T_RadiusBounce;
entity (entity scanner, float scanrange, float enemies, float friends) T_RadiusScan;

void () CanisterTouch =
{
    sound (self, 1, "weapons/tink1.wav", 1, 1);
    if (self.velocity == '0 0 0')
	self.avelocity = '0 0 0';
};

void () CaltropTouch =
{
    if ((other.classname != "player") || !(other.flags & 512) || other.deadflag)
	return;

    if ((teamplay & 16) && (other != self.owner)
	&& (other.team_no == self.owner.team_no) && (self.owner.team_no != 0))
	return;

    sprint (other, PRINT_HIGH, "Ow, Ow, Ow! Caltrops!\n");
    other.leg_damage = other.leg_damage + 2;
    TeamFortress_SetSpeed (other);
    deathmsg = 41;
    T_Damage (other, self, self.owner, 10);
    dremove (self);
};

void () CaltropScatterThink =
{
    self.nextthink = time + 0.2;
    if (self.velocity == '0 0 0') {
	if (self.flags & 512) {
	    self.nextthink = time + 10 + random () * 5;
	    self.think = SUB_Remove;
	    self.solid = SOLID_TRIGGER;
	    self.movetype = MOVETYPE_TOSS;
	    self.touch = CaltropTouch;
	    self.angles = '90 90 90';
	    sound (self, CHAN_AUTO, "weapons/tink1.wav", 1, ATTN_NORM);
	    setorigin (self, self.origin);
	    return;
	} else {
	    self.nextthink = time + 10 + random () * 5;
	    self.think = SUB_Remove;
	    self.solid = SOLID_TRIGGER;
	    self.movetype = MOVETYPE_TOSS;
	    self.touch = CanisterTouch;
	    setorigin (self, self.origin);
	    return;
	}
    }
    traceline (self.movedir, self.origin, 1, self);
    if (trace_fraction == 1) {
	self.movedir = self.origin;
	return;
    }
    self.velocity = self.velocity * -1;
    self.heat = self.heat + 1;
    if (self.heat > 10) {
	remove (self);
	return;
    }
};

void () ScatterCaltrops =
{
    local float num;
    local entity e;

    num = 6;
    while (num > 0) {
	e = spawn ();
	e.classname = "grenade";
	e.weapon = 10;
	e.owner = self.owner;
	e.team_no = self.owner.team_no;
	setmodel (e, "progs/caltrop.mdl");
	e.mins = '-4 -4 -8';
	e.maxs = '4 4 4';
	e.angles = '0 0 0';
	e.angles_x = random () * 360;
	e.velocity_x = crandom () * 100;
	e.velocity_y = crandom () * 100;
	e.velocity_z = 200 + random () * 100;
	e.avelocity_x = crandom () * 400;
	e.avelocity_y = crandom () * 400;
	e.avelocity_z = crandom () * 400;
	setorigin (e, self.owner.origin);
	e.movedir = e.origin;
	e.heat = 0;
	e.movetype = 10;
	e.solid = 0;
	e.nextthink = time + 0.2;
	e.think = CaltropScatterThink;
	num = num - 1;
    }
    dremove (self);
};

void () FlashGrenadeTouch =
{
    sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
    if (self.velocity == '0 0 0')
	self.avelocity = '0 0 0';
};

void () FlashTimer =
{
    local entity te;
    local string st;

    te = self.owner;
    te.FlashTime = te.FlashTime - 0.6;
    if (te.FlashTime < 5) {
	te.FlashTime = 0;
	stuffcmd (te, "v_cshift; wait; bf\n");
	remove (self);
	return;
    }
    st = ftos (te.FlashTime * 10);
    stuffcmd (te, "v_cshift ");
    stuffcmd (te, st);
    stuffcmd (te, " ");
    stuffcmd (te, st);
    stuffcmd (te, " ");
    stuffcmd (te, st);
    stuffcmd (te, " ");
    stuffcmd (te, st);
    stuffcmd (te, "\n");
    self.nextthink = time + 0.6;
};

void () FlashGrenadeExplode =
{
    local float expsize;
    local entity te;
    local entity oldself;
    local string st;

    self.effects = self.effects | EF_BRIGHTLIGHT;
    WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
    WriteByte (MSG_MULTICAST, TE_TAREXPLOSION);
    WriteCoord (MSG_MULTICAST, self.origin_x);
    WriteCoord (MSG_MULTICAST, self.origin_y);
    WriteCoord (MSG_MULTICAST, self.origin_z);
    multicast (self.origin, MULTICAST_PHS);

    te = findradius (self.origin, 300);
    while (te) {
	if (te.classname == "player") {
	    traceline (self.origin, te.origin, 1, self);
	    if (trace_fraction == 1) {
		if (vlen (self.origin - te.origin) <= 200) {
		    deathmsg = DMSG_GREN_FLASH;
		    TF_T_Damage (te, self, self.owner, 60, 2, 16 | 4);
		}
		if (te.health > 0) {
		    if (te.FlashTime == 0) {
			newmis = spawn ();
			newmis.classname = "timer";
			newmis.netname = "flashtimer";
			newmis.team_no = self.owner.team_no;
			newmis.owner = te;
			newmis.think = FlashTimer;
			newmis.nextthink = time + 1;
		    }
		    if (te == self.owner)
			te.FlashTime = 16;
		    else
			te.FlashTime = 24;

		    st = ftos (te.FlashTime * 10);
		    stuffcmd (te, "v_cshift ");
		    stuffcmd (te, st);
		    stuffcmd (te, " ");
		    stuffcmd (te, st);
		    stuffcmd (te, " ");
		    stuffcmd (te, st);
		    stuffcmd (te, " ");
		    stuffcmd (te, st);
		    stuffcmd (te, "\n");
		}
	    }
	}
	te = te.chain;
    }
    dremove (self);
};

void () ConcussionGrenadeTouch =
{
    sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
    if (self.velocity == '0 0 0')
	self.avelocity = '0 0 0';
};

void () ConcussionGrenadeExplode =
{
    T_RadiusBounce (self, self.owner, 240, world);
    WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
    WriteByte (MSG_MULTICAST, TE_EXPLOSION);
    WriteCoord (MSG_MULTICAST, self.origin_x);
    WriteCoord (MSG_MULTICAST, self.origin_y);
    WriteCoord (MSG_MULTICAST, self.origin_z);
    multicast (self.origin, MULTICAST_PHS);
    dremove (self);
};

void () OldConcussionGrenadeTimer =
{
    local string st;

    if (self.owner.invincible_finished > time) {
	stuffcmd (self.owner, "v_idlescale 0; wait; fov 90\n");
	dremove (self);
	return;
    }
    newmis = spawn ();
    setmodel (newmis, "progs/s_bubble.spr");
    setorigin (newmis, self.owner.origin);
    newmis.movetype = 8;
    newmis.solid = 0;
    newmis.velocity = '0 0 15';
    newmis.nextthink = time + 0.5;
    newmis.think = bubble_bob;
    newmis.touch = bubble_remove;
    newmis.classname = "bubble";
    newmis.frame = 0;
    newmis.cnt = 0;
    setsize (newmis, '-8 -8 -8', '8 8 8');

    self.health = self.health - 20;
    if (self.owner.playerclass == 5)
	self.health = self.health - 20;
    if (self.health < 0)
	self.health = 0;

    self.nextthink = time + 5;
    stuffcmd (self.owner, "v_iroll_cycle 0.5\n");
    stuffcmd (self.owner, "v_ipitch_cycle 1\n");
    stuffcmd (self.owner, "v_iyaw_cycle 2\n");

    st = ftos (self.health);
    stuffcmd (self.owner, "v_idlescale ");
    stuffcmd (self.owner, st);
    stuffcmd (self.owner, "\n");

    st = ftos (90 + self.health / 2);
    stuffcmd (self.owner, "fov ");
    stuffcmd (self.owner, st);
    stuffcmd (self.owner, "\n");
    if (self.health == 0)
	dremove (self);
};

void () ConcussionGrenadeTimer =
{
/*
Up2 fixme
For later:
if ( (practice == on) && (clanbattle = TRUE) {
}
else {
*/
    local string st;
    local string st2;
    local vector src;
    local float pos;
    local float concadjust;
    local float stumble;

    if (self.owner.invincible_finished > time) {
	sprint (self.owner, PRINT_HIGH, "Your head feels better now.\n");
	self.owner.fixangle = 0;
	dremove (self);
	return;
    }
    if ((self.health == 200) || (self.health == 400) || (self.health == 600)
	|| (self.health == 800) || (self.health == 1000)) {
	newmis = spawn ();
	setmodel (newmis, "progs/s_bubble.spr");
	setorigin (newmis, self.owner.origin);
	newmis.movetype = MOVETYPE_NOCLIP;
	newmis.solid = SOLID_NOT;
	newmis.velocity = '0 0 15';
	newmis.nextthink = time + 0.5;
	newmis.think = bubble_bob;
	newmis.touch = bubble_remove;
	newmis.classname = "bubble";
	newmis.frame = 0;
	newmis.cnt = 0;
	setsize (newmis, '-8 -8 -8', '8 8 8');
    }
    self.health = self.health - 10;
    if (self.owner.playerclass == 5)
	self.health = self.health - 10;

    if (self.health < 0)
	self.health = 0;

    concadjust = 1;
    self.nextthink = time + 0.25 * concadjust;

    if (concadjust > 1)
	self.health = self.health - concadjust;

    pos = pointcontents (self.owner.origin);
    src_x = self.owner.origin_x + self.owner.maxs_x + 2;
    src_y = self.owner.origin_y + self.owner.maxs_y + 2;
    src_z = self.owner.origin_z;
    pos = pointcontents (src);

    if ((self.owner.flags & 512) || (self.owner.flags & 16)) {
	if (!((self.owner.tfstate & TFSTATE_CANT_MOVE)
	      && (self.owner.current_weapon == WEAP_ASSAULT_CANNON))) {
	    if (self.owner.is_feigning == 0) {
		makevectors (self.owner.v_angle);
		stumble = crandom () * self.health;
		if (!((pos == -2) && (self.owner.velocity == '0 0 0'))) {
		    if ((crandom () < 0)) {
			self.owner.velocity_x = self.owner.velocity_y + stumble;
			self.owner.velocity_y = self.owner.velocity_x + stumble;
		    } else {
			self.owner.velocity_x = -1 * self.owner.velocity_y + stumble;
			self.owner.velocity_y = -1 * self.owner.velocity_x + stumble;
		    }
		}
	    }
	}
    }
    if (self.health <= 0) {
	sprint (self.owner, PRINT_HIGH, "Your head feels better now.\n");
	dremove (self);
    }
};

void () ScannerSwitch =
{
    local entity te;

    if (self.ScannerOn != 1) {
	te = spawn ();
	te.nextthink = time + 2;
	te.think = TeamFortress_Scan;
	te.owner = self;
	te.classname = "timer";
	te.netname = "scanner";
	sprint (self, PRINT_HIGH, "Scanner On.\n");
	self.ScannerOn = 1;
    } else {
	te = find (world, netname, "scanner");
	while (te) {
	    if (te.owner == self)
		dremove (te);

	    te = find (te, netname, "scanner");
	}
	sprint (self, PRINT_HIGH, "Scanner Off.\n");
	self.ScannerOn = 0;
    }
};

void () TeamFortress_Scan =
{
    local string power;
    local entity list;
    local float scancost;
    local float scanrange;
    local float scen;
    local float scfr;
    local float num;
    local vector lightningvec;
    local float enemy_detected;
    local float any_detected;
    local vector vf;
    local vector vr;
    local vector e;
    local float res1;
    local float res2;
    local float res3;
    local float vf_e_angle;
    local float vr_e_angle;

    scanrange = 100;
    self.owner.impulse = 0;
    self.owner.last_impulse = 0;
    if (self.owner.classname == "player") {
	if (!(self.owner.tf_items & 1)) {
	    return;
	}
	scancost = 2;
	if (self.owner.ammo_cells <= 0) {
	    sprint (self.owner, PRINT_HIGH, "Not enough cells to run scanner.\n");
	    self.owner.ammo_cells = 0;
	    W_SetCurrentAmmo ();
	    self.owner.ScannerOn = 0;
	    dremove (self);
	    return;
	}
	if (scancost > self.owner.ammo_cells) {
	    scanrange = self.owner.ammo_cells * 20;
	    scancost = self.owner.ammo_cells;
	    W_SetCurrentAmmo ();
	}
	scen = 0;
	scfr = 0;
	if (self.owner.tf_items_flags & 1) {
	    scen = 1;
	}
	if (self.owner.tf_items_flags & 2) {
	    scfr = 1;
	}
	if ((scen == 0) && (scfr == 0)) {
	    sprint (self.owner, PRINT_HIGH, "No target specified.\n");
	    self.owner.ScannerOn = 0;
	    dremove (self);
	    return;
	}
	self.owner.ammo_cells = self.owner.ammo_cells - 2;
	if (self.owner.ammo_cells < 0) {
	    self.owner.ammo_cells = 0;
	}
	W_SetCurrentAmmo ();
	scanrange = scanrange * 25;
	list = T_RadiusScan (self.owner, scanrange, scen, scfr);
    }
    scen = 0;
    scfr = 0;
    makevectors (self.owner.v_angle);
    if (list != world) {
	any_detected = 1;
	if ((((list.team_no > 0) && (self.owner.team_no > 0)) && (list.team_no == self.owner.team_no)) && ((list.classname == "player") || (list.classname == "building_sentrygun"))) {
	    scfr = scfr + 1;
	    enemy_detected = 0;
	} else {
	    if ((((list.goal_no > 0) && (self.owner.team_no > 0)) && (list.goal_no == self.owner.team_no)) && (list.classname == "item_tfgoal")) {
		scfr = scfr + 1;
		enemy_detected = 0;
	    } else {
		scen = scen + 1;
		enemy_detected = 1;
	    }
	}
	if (any_detected) {
	    lightningvec = normalize ((list.origin - self.owner.origin));
	    lightningvec = lightningvec * (vlen ((list.origin - self.owner.origin)) / 5);
	    lightningvec = lightningvec + self.owner.origin;
	    msg_entity = self.owner;

	    WriteByte (MSG_ONE, SVC_TEMPENTITY);
	    WriteByte (MSG_ONE, TE_LIGHTNING1);
	    WriteEntity (MSG_ONE, self.owner);
	    WriteCoord (MSG_ONE, self.owner.origin_x);
	    WriteCoord (MSG_ONE, self.owner.origin_y);
	    WriteCoord (MSG_ONE, self.owner.origin_z + 8);
	    WriteCoord (MSG_ONE, lightningvec_x);
	    WriteCoord (MSG_ONE, lightningvec_y);
	    WriteCoord (MSG_ONE, lightningvec_z + 8);

	    if (self.owner.tf_items_flags & 4) {
		stuffcmd (self.owner, "play misc/basekey.wav\n");
	    }
	    num = vlen (list.origin - self.owner.origin);
	    num = num / 10;
	    num = num / 3;
	    num = rint (num);
	    self.health = num;
	    if (list.classname == "player") {
		if ((list.playerclass == 8) && (list.team_no != self.owner.team_no)) {
		    if (list.undercover_skin != 0) {
			self.playerclass = list.undercover_skin;
		    } else {
			self.playerclass = list.playerclass;
		    }
		    if (list.undercover_team != 0) {
			self.team_no = list.undercover_team;
		    } else {
			self.team_no = list.team_no;
		    }
		} else {
		    self.playerclass = list.playerclass;
		    self.team_no = list.team_no;
		}
	    } else {
		if (list.classname == "building_sentrygun") {
		    self.playerclass = 13;
		    self.team_no = list.team_no;
		} else {
		    if (list.classname == "item_tfgoal") {
			self.playerclass = 14;
			self.team_no = list.goal_no;
		    }
		}
	    }
	    self.owner.StatusRefreshTime = time + 0.2;
	}
    }
    if ((scen == 0) && (scfr == 0)) {
	self.health = 0;
	self.owner.StatusRefreshTime = time + 0.2;
	self.nextthink = time + 2;
	return;
    }
    W_SetCurrentAmmo ();
    self.nextthink = time + 2;
    return;
};

void (entity inflictor, entity attacker, float bounce, entity ignore) T_RadiusBounce =
{
    local float points;
    local entity head;
    local entity te;
    local vector org;
    local string st;
    local string st2;

    head = findradius (inflictor.origin, bounce + 40);
    while (head) {
	if (head != ignore) {
	    if (head.takedamage) {
		org = head.origin + (head.mins + head.maxs) * 0.5;
		points = 0.5 * vlen (org - inflictor.origin);
		if (points < 0)
		    points = 0;
		points = bounce - points;

		if ((head.classname != "building_dispenser")
		    && (head.classname != "building_sentrygun")
		    && (head.classname != "building_sentrygun_base")
		    && (points > 0)) {
		    head.velocity = org - inflictor.origin;
		    head.velocity = head.velocity * (points / 20);
		    if (head.classname != "player") {
			if (head.flags & FL_ONGROUND)
			    head.flags = head.flags - FL_ONGROUND;
		    } else {
			te = find (world, classname, "timer");
			if (old_grens == TRUE)
			    while (((te.owner != head) || (te.think != OldConcussionGrenadeTimer))
				   && (te != world))
				te = find (te, classname, "timer");
			else
			    while (((te.owner != head) || (te.think != ConcussionGrenadeTimer))
				   && (te != world))
				te = find (te, classname, "timer");

			if (te != world) {
			    if (old_grens == TRUE) {
				stuffcmd (head, "v_idlescale 100\n");
				stuffcmd (head, "fov 130\n");
				te.health = 100;
				te.nextthink = time + 5;
			    } else {
				te.health = 750;
				te.nextthink = time + 0.25;
			    }
			} else {
			    if (old_grens == TRUE) {
				stuffcmd (head, "v_idlescale 100\n");
				stuffcmd (head, "fov 130\n");
				stuffcmd (head, "bf\n");
				te = spawn ();
				te.nextthink = time + 5;
				te.think = OldConcussionGrenadeTimer;
				te.team_no = attacker.team_no;
				te.classname = "timer";
				te.owner = head;
				te.health = 100;
			    } else {
				te = spawn ();
				te.nextthink = time + 0.25;
				te.think = ConcussionGrenadeTimer;
				te.team_no = attacker.team_no;
				te.classname = "timer";
				te.owner = head;
				te.health = 750;
			    }
			}
		    }
		}
	    }
	}
	head = head.chain;
    }
};

entity (entity scanner, float scanrange, float enemies, float friends) T_RadiusScan =
{
    local entity head;
    local float rangedist;

    rangedist = 0;
    head = world;
    while (rangedist <= scanrange) {
	if (rangedist <= 0) {
	    rangedist = 1;
	}
	head = findradius (scanner.origin, rangedist);
	while ( head ) {
	    if (head != scanner) {
		if (((head.takedamage != 0) && (head.health > 0)) || (head.classname == "item_tfgoal")) {
		    if (((head.classname == "player")
			 || (head.classname == "building_sentrygun"))
			&& (friends || enemies)) {
			if (teamplay) {
			    if (((friends != 0) && (head.team_no > 0)) && (scanner.team_no > 0)) {
				if ((head.playerclass == 8) && (head.team_no != scanner.team_no)) {
				    if ((head.is_feigning != 1) && (invis_only != 1)) {
					if (head.undercover_team == scanner.team_no) {
					    return (head);
					}
				    }
				} else if (head.team_no == scanner.team_no) {
				    return (head);
				}
			    }
			    if (((enemies != 0) && (head.team_no > 0)) && (scanner.team_no > 0)) {
				if ((head.playerclass == 8) && (head.team_no != scanner.team_no)) {
				    if ((head.is_feigning != 1) && (invis_only != 1)) {
					if (head.undercover_team != scanner.team_no) {
					    return (head);
					}
				    }
				} else if (head.team_no != scanner.team_no) {
				    return (head);
				}
			    }
			} else {
			    return (head);
			}
		    } else if ((head.classname == "item_tfgoal") && (friends || enemies)) {
			if (teamplay) {
			    if ((friends != 0) && (head.goal_no > 0)
				&& (scanner.team_no > 0) && (head.goal_no == scanner.team_no)) {
				return (head);
			    }
			    if ((enemies != 0) && (head.team_no > 0)
				&& (scanner.team_no > 0) && (head.goal_no != scanner.team_no)) {
				return (head);
			    }
			}
		    }
		}
	    }
	    head = head.chain;
	}
	rangedist = rangedist + 100;
    }
    return (world);
};
