

void () door_go_down;

void () door_go_up;

void () door_blocked = {

   if ( (other.classname == "detpack") ) {

      sprint (other.owner,2.000,"Your detpack was squashed.\n");
      if ( (other.weaponmode == 1.000) ) {

         TeamFortress_SetSpeed (other.enemy);
         dremove (other.observer_list);

      }
      dremove (other.oldenemy);
      dremove (other);
      return ;

   }

   other.deathtype = "squish";
   TF_T_Damage (other, self, self.goalentity, self.dmg, 0.000, 0.000);

   if ( (self.wait >= 0.000) ) {
      if ( (self.state == 3.000) ) {
         door_go_up ();
      } else {
         door_go_down ();
      }
   }

};

void () door_hit_top = {

   sound (self,2.000,self.noise1,1.000,1.000);
   self.state = 0.000;
   if ( (self.spawnflags & 32.000) ) {

      return ;

   }
   self.think = door_go_down;
   self.nextthink = (self.ltime + self.wait);

};

void () door_hit_bottom = {

   self.goal_state = 2.000;
   sound (self,2.000,self.noise1,1.000,1.000);
   self.state = 1.000;

};

void () door_go_down = {


   sound (self,2.000,self.noise2,1.000,1.000);
   if ( self.max_health ) {

      self.takedamage = 1.000;
      self.health = self.max_health;

   }
   self.state = 3.000;
	if (self.classname == "door_rotating")
		SUB_CalcAngleMove (self.pos1, self.speed, door_hit_bottom);
	else
		SUB_CalcMove (self.pos1, self.speed, door_hit_bottom);

};

void () door_go_up = {


   if ( (self.state == 2.000) ) {

      return ;

   }
   if ( (self.state == 0.000) ) {

      self.nextthink = (self.ltime + self.wait);
      return ;

   }
   sound (self,2.000,self.noise2,1.000,1.000);
   self.state = 2.000;
	if (self.classname == "door_rotating")
		SUB_CalcAngleMove (self.pos2, self.speed, door_hit_top);
else
		SUB_CalcMove (self.pos2, self.speed, door_hit_top);

   SUB_UseTargets ();

};



void () door_fire = {

   local entity oself;
   local entity starte;


   if ( (self.owner != self) ) {

      objerror ("door_fire: self.owner != self");

   }
   if ( self.items ) {

      sound (self,2.000,self.noise4,1.000,1.000);

   }
   self.message = string_null;
   oself = self;
   if ( (self.spawnflags & 32.000) ) {

      if ( ((self.state == 2.000) || (self.state == 0.000)) ) {

         starte = self;
         do {

            door_go_down ();
            self = self.enemy;

         } while ( ((self != starte) && (self != world)) );
         self = oself;
         return ;

      }

   }
   starte = self;
   do {


         door_go_up ();

      self = self.enemy;

   } while ( ((self != starte) && (self != world)) );
   self = oself;

};

void () door_use = {

   local entity oself;

   self.message = "";
   self.owner.message = "";
   self.enemy.message = "";
   oself = self;
   self = self.owner;
   door_fire ();
   self = oself;

};

void () door_trigger_touch = {

   local entity te;

   if ((freeze == 1)) {

	return ;

   }

   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( (!other.playerclass ) ) {

	return;

   }
   if ( !Activated (self,other) ) {

      if ( (self.else_goal != 0.000) ) {

         te = Findgoal (self.else_goal);
         if ( te ) {

            AttemptToActivate (te,other,self);

         }

      }
      return ;

   }
   if ( (time < self.attack_finished) ) {

      return ;

   }
   self.attack_finished = (time + 1.000);
   activator = other;
   self = self.owner;
   door_use ();

};

void () door_killed = {

   local entity oself;

   oself = self;
   self = self.owner;
   self.health = self.max_health;
   self.takedamage = 0.000;
   door_use ();
   self = oself;

};


void () door_touch = {

   local entity te;


   if ( (other.classname != "player") ) {

      return ;

   }


   if ( (self.owner.attack_finished > time) ) {

      return ;

   }

   self.owner.attack_finished = (time + 2.000);

  if ( !self.items ) {

     return ;

   }

   if ( !Activated (self,other) ) {

      if ( (self.else_goal != 0.000) ) {

         te = Findgoal (self.else_goal);
         if ( te ) {

            AttemptToActivate (te,other,self);

         }

      }
      return ;

   }

   if ( (self.owner.message != "") ) {

      CenterPrint (other,self.owner.message);
      sound (other,2.000,"misc/talk.wav",1.000,1.000);

   }

   if ( ((self.items & other.items) != self.items) ) {

      if ( (self.owner.items == 131072.000) ) {

         if ( (world.worldtype == 2.000) ) {

            CenterPrint (other,"You need the silver keycard");
            sound (self,2.000,self.noise3,1.000,1.000);

         } else {

            if ( (world.worldtype == 1.000) ) {

               CenterPrint (other,"You need the silver runekey");
               sound (self,2.000,self.noise3,1.000,1.000);

            } else {

               if ( (world.worldtype == 0.000) ) {

                  CenterPrint (other,"You need the silver key");
                  sound (self,2.000,self.noise3,1.000,1.000);

               }

            }

         }

      } else {

         if ( (world.worldtype == 2.000) ) {

            CenterPrint (other,"You need the gold keycard\n");
            sound (self,2.000,self.noise3,1.000,1.000);

         } else {

            if ( (world.worldtype == 1.000) ) {

               CenterPrint (other,"You need the gold runekey");
               sound (self,2.000,self.noise3,1.000,1.000);

            } else {

               if ( (world.worldtype == 0.000) ) {

                  CenterPrint (other,"You need the gold key");
                  sound (self,2.000,self.noise3,1.000,1.000);

               }

            }

         }

      }
      return ;

   }
   other.items = (other.items - self.items);
   other.tf_items = (other.tf_items | self.items);
//   if ( DoorShouldOpen () ) {

      self.touch = SUB_Null;
      if ( self.enemy ) {

         self.enemy.touch = SUB_Null;

      }
      door_use ();

//   }

};


entity(vector fmins, vector fmaxs) spawn_field =
{
	local entity    trigger;
	local   vector  t1, t2;

	trigger = spawn();
	trigger.movetype = 0.000;
	trigger.solid = 1.000;
	trigger.owner = self;
	trigger.touch = door_trigger_touch;

     trigger.team_no = self.team_no;
   trigger.playerclass = self.playerclass;
   trigger.items_allowed = self.items_allowed;
   trigger.activate_goal_no = self.activate_goal_no;
   trigger.inactivate_goal_no = self.inactivate_goal_no;
   trigger.remove_goal_no = self.remove_goal_no;
   trigger.restore_goal_no = self.restore_goal_no;
   trigger.activate_group_no = self.activate_group_no;
   trigger.inactivate_group_no = self.inactivate_group_no;
   trigger.remove_group_no = self.remove_group_no;
   trigger.restore_group_no = self.restore_group_no;
   trigger.goal_activation = self.goal_activation;
   trigger.goal_effects = self.goal_effects;
   trigger.goal_result = self.goal_result;
   trigger.goal_group = self.goal_group;
   trigger.all_active = self.all_active;
   trigger.last_impulse = self.last_impulse;
   trigger.else_goal = self.else_goal;


	t1 = fmins;
	t2 = fmaxs;
	setsize (trigger, t1 - '60 60 8', t2 + '60 60 8');
	return (trigger);
};


float (entity e1, entity e2) EntitiesTouching =
{
	if (e1.absmin_x > e2.absmax_x)
		return 0.000;
	if (e1.absmin_y > e2.absmax_y)
		return 0.000;
	if (e1.absmin_z > e2.absmax_z)
		return 0.000;
	if (e1.absmax_x < e2.absmin_x)
		return 0.000;
	if (e1.absmax_y < e2.absmin_y)
		return 0.000;
	if (e1.absmax_z < e2.absmin_z)
		return 0.000;
	return 1.000;
};


/*
=============
LinkDoors


=============
*/
void() LinkDoors =
{
	local entity    t, starte;
	local vector    cmins, cmaxs;

	if (self.enemy)
		return;         // already linked by another door
	if (self.spawnflags & 4)
	{
		self.owner = self.enemy = self;
		return;         // don't want to link this door
	}

	cmins = self.absmin;
	cmaxs = self.absmax;
	
	starte = self;
	t = self;
	
	do
	{
		self.owner = starte;                    // master door

		if (self.health)
			starte.health = self.health;
		if (self.targetname)
			starte.targetname = self.targetname;
		if (self.message != "")
			starte.message = self.message;

		t = find (t, classname, self.classname);        
		if (!t)
		{
			self.enemy = starte;            // make the chain a loop

		// shootable, fired, or key doors just needed the owner/enemy links,
		// they don't spawn a field
	
			self = self.owner;

			if (self.health)
				return;
			if (self.targetname)
				return;
			if (self.items)
				return;

			self.owner.trigger_field = spawn_field(cmins, cmaxs);

			return;
		}

		if (EntitiesTouching(self,t))
		{
			if (t.enemy)
				objerror ("cross connected doors");
			
			self.enemy = t;
			self = t;

			if (t.mins_x < cmins_x)
				cmins_x = t.mins_x;
			if (t.mins_y < cmins_y)
				cmins_y = t.mins_y;
			if (t.mins_z < cmins_z)
				cmins_z = t.mins_z;
			if (t.maxs_x > cmaxs_x)
				cmaxs_x = t.maxs_x;
			if (t.maxs_y > cmaxs_y)
				cmaxs_y = t.maxs_y;
			if (t.maxs_z > cmaxs_z)
				cmaxs_z = t.maxs_z;
		}
	} while (1 );

};

void () func_door = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( (world.worldtype == 0.000) ) {

      precache_sound ("doors/medtry.wav");
      precache_sound ("doors/meduse.wav");
      self.noise3 = "doors/medtry.wav";
      self.noise4 = "doors/meduse.wav";

   } else {

      if ( (world.worldtype == 1.000) ) {

         precache_sound ("doors/runetry.wav");
         precache_sound ("doors/runeuse.wav");
         self.noise3 = "doors/runetry.wav";
         self.noise4 = "doors/runeuse.wav";

      } else {

         if ( (world.worldtype == 2.000) ) {

            precache_sound ("doors/basetry.wav");
            precache_sound ("doors/baseuse.wav");
            self.noise3 = "doors/basetry.wav";
            self.noise4 = "doors/baseuse.wav";

         } else {

            dprint ("no worldtype set!\n");

         }

      }

   }
   if ( (self.sounds == 0.000) ) {

      precache_sound ("misc/null.wav");
      precache_sound ("misc/null.wav");
      self.noise1 = "misc/null.wav";
      self.noise2 = "misc/null.wav";

   }
   if ( (self.sounds == 1.000) ) {

      precache_sound ("doors/drclos4.wav");
      precache_sound ("doors/doormv1.wav");
      self.noise1 = "doors/drclos4.wav";
      self.noise2 = "doors/doormv1.wav";

   }
   if ( (self.sounds == 2.000) ) {

      precache_sound ("doors/hydro1.wav");
      precache_sound ("doors/hydro2.wav");
      self.noise2 = "doors/hydro1.wav";
      self.noise1 = "doors/hydro2.wav";

   }
   if ( (self.sounds == 3.000) ) {

      precache_sound ("doors/stndr1.wav");
      precache_sound ("doors/stndr2.wav");
      self.noise2 = "doors/stndr1.wav";
      self.noise1 = "doors/stndr2.wav";

   }
   if ( (self.sounds == 4.000) ) {

      precache_sound ("doors/ddoor1.wav");
      precache_sound ("doors/ddoor2.wav");
      self.noise1 = "doors/ddoor2.wav";
      self.noise2 = "doors/ddoor1.wav";

   }
   SetMovedir ();
   self.max_health = self.health;
   self.solid = 4.000;
   self.movetype = 7.000;
   setorigin (self,self.origin);
   setmodel (self,self.model);
   self.classname = "door";
   self.blocked = door_blocked;
   self.use = door_use;
   if ( (self.spawnflags & 16.000) ) {

      self.items = 131072.000;

   }
   if ( (self.spawnflags & 8.000) ) {

      self.items = 262144.000;

   }
   if ( !self.speed ) {

      self.speed = 100.000;

   }
   if ( !self.wait ) {

      self.wait = 3.000;

   }
   if ( !self.lip ) {

      self.lip = 8.000;

   }
   if ( !self.dmg ) {

      self.dmg = 2.000;

   }
   self.pos1 = self.origin;
   self.pos2 = (self.pos1 + (self.movedir * (fabs ((self.movedir * self.size)) - self.lip)));
   if ( (self.spawnflags & 1.000) ) {

      setorigin (self,self.pos2);
      self.pos2 = self.pos1;
      self.pos1 = self.origin;

   }
   self.state = 1.000;
   if ( self.health ) {

      self.takedamage = 1.000;
      self.th_die = door_killed;

   }
   if ( self.items ) {

      self.wait = -1.000;

   }
   self.touch = door_touch;
   self.think = LinkDoors;
   self.nextthink = (self.ltime + 0.100);

};


float DOOR_REVERSE		= 2;
float DOOR_X_AXIS		= 64;
float DOOR_Y_AXIS		= 128;
//a q2 ent.
void() func_door_rotating =

{

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }

	if (world.worldtype == 0)
	{
		precache_sound ("doors/medtry.wav");
		precache_sound ("doors/meduse.wav");
		self.noise3 = "doors/medtry.wav";
		self.noise4 = "doors/meduse.wav";
	}
	else if (world.worldtype == 1)
	{
		precache_sound ("doors/runetry.wav");
		precache_sound ("doors/runeuse.wav");
		self.noise3 = "doors/runetry.wav";
		self.noise4 = "doors/runeuse.wav";
	}
	else if (world.worldtype == 2)
	{
		precache_sound ("doors/basetry.wav");
		precache_sound ("doors/baseuse.wav");
		self.noise3 = "doors/basetry.wav";
		self.noise4 = "doors/baseuse.wav";
	}
	else
	{
		dprint ("no worldtype set!\n");
	}
	if (self.sounds == 0)
	{
		precache_sound ("misc/null.wav");
		precache_sound ("misc/null.wav");
		self.noise1 = "misc/null.wav";
		self.noise2 = "misc/null.wav";
	}
	if (self.sounds == 1)
	{
		precache_sound ("doors/drclos4.wav");
		precache_sound ("doors/doormv1.wav");
		self.noise1 = "doors/drclos4.wav";
		self.noise2 = "doors/doormv1.wav";
	}
	if (self.sounds == 2)
	{
		precache_sound ("doors/hydro1.wav");
		precache_sound ("doors/hydro2.wav");
		self.noise2 = "doors/hydro1.wav";
		self.noise1 = "doors/hydro2.wav";
	}
	if (self.sounds == 3)
	{
		precache_sound ("doors/stndr1.wav");
		precache_sound ("doors/stndr2.wav");
		self.noise2 = "doors/stndr1.wav";
		self.noise1 = "doors/stndr2.wav";
	}
	if (self.sounds == 4)
	{
		precache_sound ("doors/ddoor1.wav");
		precache_sound ("doors/ddoor2.wav");
		self.noise1 = "doors/ddoor2.wav";
		self.noise2 = "doors/ddoor1.wav";
	}


	if (self.spawnflags & DOOR_X_AXIS)
		self.movedir_z = 1.0;
	else if (self.spawnflags & DOOR_Y_AXIS)
		self.movedir_x = 1.0;
	else // Z_AXIS
		self.movedir_y = 1.0;

	// check for reverse rotation
	if (self.spawnflags & DOOR_REVERSE)
		self.movedir = '0 0 0' - self.movedir;



	self.max_health = self.health;
	self.solid = 4.000;
	self.movetype = 7.000;
	setorigin (self, self.origin);  
	setmodel (self, self.model);
	self.classname = "door_rotating";

	self.blocked = door_blocked;
	self.use = door_use;
	
	if (self.spawnflags & 16.000)
		self.items = 131072;
	if (self.spawnflags & 8.000)
		self.items = 262144;
	
	if (!self.speed)
		self.speed = 100;
	if (!self.wait)
		self.wait = 3;
	if (!self.lip)
		self.lip = 8;
	if (!self.dmg)
		self.dmg = 2;

//	self.pos1 = self.origin;
//	self.pos2 = self.pos1 + self.movedir*(fabs(self.movedir*self.size) - self.lip);

	self.pos1 = self.angles;
	self.pos2 = self.angles + self.movedir * self.distance;

// DOOR_START_OPEN is to allow an entity to be lighted in the closed position
// but spawn in the open position
	if (self.spawnflags & 1.000)
	{
//		setorigin (self, self.pos2);
		self.pos1 = self.pos2;
		self.pos1 = self.angles;
	}

	self.state = 1.000;

	if (self.health)
	{
		self.takedamage = 1.000;
		self.th_die = door_killed;
	}
	
	if (self.items)
		self.wait = -1;
		
	self.touch = door_touch;

// LinkDoors can't be done until all of the doors have been spawned, so
// the sizes can be detected properly.
	self.think = LinkDoors;
	self.nextthink = self.ltime + 0.1;
};


void () fd_secret_move1;

void () fd_secret_move2;

void () fd_secret_move3;

void () fd_secret_move4;

void () fd_secret_move5;

void () fd_secret_move6;

void () fd_secret_done;

void () fd_secret_use = {

   local float temp;

   self.health = 10000.000;
   if ( (self.origin != self.oldorigin) ) {

      return ;

   }
   if ( (self.spawnflags & 32.000) ) {

      return ;

   }
   self.message = string_null;
   SUB_UseTargets ();
   if ( !(self.spawnflags & 8.000) ) {

      self.th_pain = SUB_Null;
      self.takedamage = 0.000;

   }
   self.velocity = '0.000 0.000 0.000';
   sound (self,2.000,self.noise1,1.000,1.000);
   self.nextthink = (self.ltime + 0.100);
   temp = (1.000 - (self.spawnflags & 2.000));
   makevectors (self.mangle);
   if ( !self.t_width ) {

      if ( (self.spawnflags & 4.000) ) {

         self.t_width = fabs ((v_up * self.size));

      } else {

         self.t_width = fabs ((v_right * self.size));

      }

   }
   if ( !self.t_length ) {

      self.t_length = fabs ((v_forward * self.size));

   }
   if ( (self.spawnflags & 4.000) ) {

      self.dest1 = (self.origin - (v_up * self.t_width));

   } else {

      self.dest1 = (self.origin + (v_right * (self.t_width * temp)));

   }
   self.dest2 = (self.dest1 + (v_forward * self.t_length));
   SUB_CalcMove (self.dest1,self.speed,fd_secret_move1);
   sound (self,2.000,self.noise2,1.000,1.000);

};

void () fd_secret_move1 = {

   self.nextthink = (self.ltime + 1.000);
   self.think = fd_secret_move2;
   sound (self,2.000,self.noise3,1.000,1.000);

};

void () fd_secret_move2 = {

   sound (self,2.000,self.noise2,1.000,1.000);
   SUB_CalcMove (self.dest2,self.speed,fd_secret_move3);

};

void () fd_secret_move3 = {

   sound (self,2.000,self.noise3,1.000,1.000);
   if ( !(self.spawnflags & 1.000) ) {

      self.nextthink = (self.ltime + self.wait);
      self.think = fd_secret_move4;

   }

};

void () fd_secret_move4 = {

   sound (self,2.000,self.noise2,1.000,1.000);
   SUB_CalcMove (self.dest1,self.speed,fd_secret_move5);

};

void () fd_secret_move5 = {

   self.nextthink = (self.ltime + 1.000);
   self.think = fd_secret_move6;
   sound (self,2.000,self.noise3,1.000,1.000);

};

void () fd_secret_move6 = {

   sound (self,2.000,self.noise2,1.000,1.000);
   SUB_CalcMove (self.oldorigin,self.speed,fd_secret_done);

};

void () fd_secret_done = {

   if ( (!self.targetname || (self.spawnflags & 16.000)) ) {

      self.health = 10000.000;
      self.takedamage = 1.000;
      self.th_pain = fd_secret_use;
      self.th_die = fd_secret_use;

   }
   sound (self,2.000,self.noise3,1.000,1.000);

};

void () secret_blocked = {

   if ( (time < self.attack_finished) ) {

      return ;

   }
   self.attack_finished = (time + 0.500);
   TF_T_Damage (other,self,self,self.dmg, 0.000, 0.000);

};

void () secret_touch = {


   if ((freeze == 1)) {

	return ;

   }

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (self.attack_finished > time) ) {

      return ;

   }
   if ( (self.spawnflags & 32.000) ) {

      return ;

   }
   self.attack_finished = (time + 2.000);
   if ( self.message ) {

      CenterPrint (other,self.message);
      sound (other,4.000,"misc/talk.wav",1.000,1.000);

   }

};

void () func_door_secret = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( (self.sounds == 0.000) ) {

      self.sounds = 3.000;

   }
   if ( (self.sounds == 1.000) ) {

      precache_sound ("doors/latch2.wav");
      precache_sound ("doors/winch2.wav");
      precache_sound ("doors/drclos4.wav");
      self.noise1 = "doors/latch2.wav";
      self.noise2 = "doors/winch2.wav";
      self.noise3 = "doors/drclos4.wav";

   }
   if ( (self.sounds == 2.000) ) {

      precache_sound ("doors/airdoor1.wav");
      precache_sound ("doors/airdoor2.wav");
      self.noise2 = "doors/airdoor1.wav";
      self.noise1 = "doors/airdoor2.wav";
      self.noise3 = "doors/airdoor2.wav";

   }
   if ( (self.sounds == 3.000) ) {

      precache_sound ("doors/basesec1.wav");
      precache_sound ("doors/basesec2.wav");
      self.noise2 = "doors/basesec1.wav";
      self.noise1 = "doors/basesec2.wav";
      self.noise3 = "doors/basesec2.wav";

   }
   if ( !self.dmg ) {

      self.dmg = 2.000;

   }
   self.mangle = self.angles;
   self.angles = '0.000 0.000 0.000';
   self.solid = 4.000;
   self.movetype = 7.000;
   self.classname = "door";
   setmodel (self,self.model);
   setorigin (self,self.origin);
   self.touch = secret_touch;
   self.blocked = secret_blocked;
   self.speed = 50.000;
   self.use = fd_secret_use;
   if ( (!self.targetname || (self.spawnflags & 16.000)) ) {

      self.health = 10000.000;
      self.takedamage = 1.000;
      self.th_pain = fd_secret_use;

   }
   self.oldorigin = self.origin;
   if ( !self.wait ) {

      self.wait = 5.000;

   }

};
