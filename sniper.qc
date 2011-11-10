//========================================================
// Functions for the SNIPER class and associated weaponry
//========================================================

void () SniperSight_Update;

void () TeamFortress_SniperWeapon =
{
    local float it;

    self.impulse = 0;
    if (self.tfstate & TFSTATE_RELOADING)
	return;

    if (!((self.weapons_carried & WEAP_SNIPER_RIFLE) && (self.weapons_carried & WEAP_AUTO_RIFLE)))
	return;

    if (self.ammo_shells < 1) {
	sprint (self, PRINT_HIGH, "not enough ammo.\n");
	return;
    }

    if (self.current_weapon == WEAP_SNIPER_RIFLE)
	self.current_weapon = WEAP_AUTO_RIFLE;
    else
	self.current_weapon = WEAP_SNIPER_RIFLE;

    W_SetCurrentAmmo ();
};

void (float zoom_level) TF_zoom =
{
    local string zl;

    if (self.tfstate & TFSTATE_ZOOMOFF)
	return;

    zl = ftos (zoom_level);
    stuffcmd (self, "fov ");
    stuffcmd (self, zl);
    stuffcmd (self, "\n");
};

void () SniperSight_Update =
{
    local vector org;

    if (!(self.owner.tfstate & TFSTATE_AIMING) || (self.owner.current_weapon != WEAP_SNIPER_RIFLE)) {

	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & TFSTATE_AIMING);
	TeamFortress_SetSpeed (self.owner);
	self.owner.heat = 0;
	dremove (self);
	return;
    }

    makevectors (self.owner.v_angle);
    org = self.owner.origin + v_forward * 10;
    org_z = self.owner.absmin_z + self.owner.size_z * 0.7;

    traceline (org, org + v_forward * 9192, FALSE, self);

    if (trace_fraction == 1) {
	setorigin (self, self.owner.origin);
	return;
    }
    self.angles = vectoangles (v_forward);
    setorigin (self, trace_endpos);
    self.nextthink = time + 0.1;
};

void () SniperSight_Create =
{
    local entity sight;

    if (self.has_disconnected == TRUE)
	return;

    self.tfstate = self.tfstate | TFSTATE_AIMING;

    sight = spawn ();
    sight.owner = self;
    sight.movetype = MOVETYPE_NOCLIP;
    sight.solid = SOLID_NOT;

    setmodel (sight, "progs/sight.spr");

    sight.classname = "timer";

    setorigin (sight, self.origin);

    sight.think = SniperSight_Update;
    sight.nextthink = time + 0.05;
};

void () TeamFortress_AutoZoomToggle =
{
    if (self.tfstate & TFSTATE_ZOOMOFF) {
	self.tfstate = self.tfstate - TFSTATE_ZOOMOFF;
	sprint (self, PRINT_HIGH, "autozoom ON\n");
    } else {
	self.tfstate = self.tfstate | TFSTATE_ZOOMOFF;
	sprint (self, PRINT_HIGH, "autozoom OFF\n");
    }
};
