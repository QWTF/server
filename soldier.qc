//========================================================
// Functions for the SOLDIER class and associated weaponry
//========================================================

void () NailGrenadeExplode;
void () NailGrenadeNailEm;
void () NailGrenadeLaunchNail;

void () NailGrenadeTouch =
{
    if (other == self.owner)
		return;

    // If the Nail Grenade hits a player, it just bounces off
    sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
    if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

void () NailGrenadeExplode =
{
    local entity te;

    self.owner.no_active_nail_grens = self.owner.no_active_nail_grens + 1;
    if (self.owner.no_active_nail_grens > 2) {
		te = find (world, classname, "grenade");
		while (te) {
			if ((te.owner == self.owner) && (te.no_active_nail_grens == 1)) {
				te.weapon = 9;
				te.think = GrenadeExplode;
				te.nextthink = time + 0.1;
			}
			te = find (te, classname, "grenade");
		}
    }
    self.no_active_nail_grens = self.owner.no_active_nail_grens;
    self.movetype = MOVETYPE_FLY;
    setorigin (self, self.origin + '0 0 32');
    self.avelocity = '0 500 0';
    self.nextthink = time + 0.7;
    self.think = NailGrenadeNailEm;
};

void () NailGrenadeNailEm =
{
    self.velocity = '0 0 0';
    self.nextthink = time + 0.1;
    self.think = NailGrenadeLaunchNail;
    self.playerclass = 0;
};

void () NailGrenadeLaunchNail =
{
    local float i, j;
    local float current_yaw;

    i = 0;
    while (i < 3) {
		j = (random () + 2) * 5;
		current_yaw = anglemod (self.angles_y + j);
		self.angles_y = current_yaw;
		self.angles_x = 0;
		self.angles_z = 0;
		makevectors (self.angles);

		deathmsg = DMSG_GREN_NAIL;
		launch_spike (self.origin, v_forward);
		newmis.touch = superspike_touch;
		newmis.weapon = DMSG_GREN_NAIL;

		i = i + 1;
    }
    self.playerclass = self.playerclass + 1;
    self.nextthink = time + 0.1;

    if (self.playerclass > 50) {
		self.weapon = DMSG_GREN_NAIL;
		self.think = GrenadeExplode;
    }
};
