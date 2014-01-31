// button and multiple button

#define BUTTON_START_OUT	32

void () button_return;

void () button_wait =
{
    self.state = STATE_TOP;
    self.nextthink = self.ltime + self.wait;
    self.think = button_return;
    activator = self.enemy;
    SUB_UseTargets ();
    self.frame = 1;
};

void () button_done =
{
    self.state = STATE_BOTTOM;
};

void () button_return =
{
    self.goal_state = TFGS_INACTIVE;
    self.state = STATE_DOWN;
    SUB_CalcMove (self.pos1, self.speed, button_done);
    self.frame = 0;
    if (self.health)
		self.takedamage = DAMAGE_YES;
};

void () button_blocked =	// do nothing, just don't come all the way back out
{
};

void () button_fire =
{
    if ((self.state == STATE_UP) || (self.state == STATE_TOP))
		return;

    sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);

    self.state = STATE_UP;
    SUB_CalcMove (self.pos2, self.speed, button_wait);
};

void () button_use =
{
    self.enemy = activator;
    button_fire ();
};

void () button_touch =
{
    local entity te;
	
	server_status = infokey (world, "status");
	if ((server_status == "Prematch") || (server_status == "Countdown"))
		return;

    if (other.classname != "player")
		return;

    if (self.goal_activation & TFGA_SPANNER)
		return;

    if (other.playerclass == 0)
		return;

    if (!Activated (self, other)) {
		if (self.else_goal != 0) {
			te = Findgoal (self.else_goal);
			if (te)
				AttemptToActivate (te, other, self);
		}
		return;
    }
    self.enemy = other;
    button_fire ();
};

void () button_killed =
{
    if (self.goal_activation & TFGA_SPANNER)
		return;

    self.enemy = damage_attacker;
    self.health = self.max_health;
    self.takedamage = DAMAGE_NO;
    button_fire ();
};

void () func_button =
{
    local float gtemp;
    local float ftemp;

    if (CheckExistence () == FALSE) {
		dremove (self);
		return;
    }

    if (self.sounds == 0) {
		precache_sound ("buttons/airbut1.wav");
		self.noise = "buttons/airbut1.wav";
    }
	else if (self.sounds == 1) {
		precache_sound ("buttons/switch21.wav");
		self.noise = "buttons/switch21.wav";
    }
	else if (self.sounds == 2) {
		precache_sound ("buttons/switch02.wav");
		self.noise = "buttons/switch02.wav";
    }
	else if (self.sounds == 3) {
		precache_sound ("buttons/switch04.wav");
		self.noise = "buttons/switch04.wav";
    }

    SetMovedir ();

    self.movetype = MOVETYPE_PUSH;
    self.solid = SOLID_BSP;
    setmodel (self, self.model);

    self.blocked = button_blocked;
    self.use = button_use;

    if (self.health) {
		self.max_health = self.health;
		self.th_die = button_killed;
		self.takedamage = 1;
    }
	else
		self.touch = button_touch;

    if (!self.speed)
		self.speed = 40;
    if (!self.wait)
		self.wait = 1;
    if (!self.lip)
		self.lip = 4;

    self.state = STATE_BOTTOM;

    self.pos1 = self.origin;
    self.pos2 = self.pos1 + self.movedir * (fabs (self.movedir * self.size) - self.lip);

    if (self.spawnflags & BUTTON_START_OUT)
		button_fire ();
};
