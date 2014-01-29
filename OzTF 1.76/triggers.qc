
entity stemp;
entity otemp;

void () TeamFortress_DetpackExplode;

void () trigger_reactivate = {

   self.solid = 1.000;

};

void () multi_wait = {

   if ( self.max_health ) {

      self.health = self.max_health;
      self.takedamage = 1.000;
      self.solid = 2.000;

   }

};

void () multi_trigger = {

   if ( (self.nextthink > time) ) {

      return ;

   }
   if ( (self.classname == "trigger_secret") ) {

      if ( (self.enemy.classname != "player") ) {

         return ;

      }
      found_secrets = (found_secrets + 1.000);
      WriteByte (2.000,28.000);

   }
   if ( self.noise ) {

      sound (self,2.000,self.noise,1.000,1.000);

   }
   self.takedamage = 0.000;
   activator = self.enemy;
   SUB_UseTargets ();
   if ( (self.wait > 0.000) ) {

      self.think = multi_wait;
      self.nextthink = (time + self.wait);

   } else {

      self.touch = SUB_Null;
      self.nextthink = (time + 0.100);
      self.think = SUB_Remove;

   }

};

void () multi_killed = {

   self.enemy = damage_attacker;
   multi_trigger ();

};

void () multi_use = {

   self.enemy = activator;
   multi_trigger ();

};

void () multi_touch = {

   local entity te;

   if ( (other.classname != "player") ) {

      return ;

   }

   if ( (freeze == 1) ) {

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
   if ( (self.movedir != '0.000 0.000 0.000') ) {

      makevectors (other.angles);
      if ( ((v_forward * self.movedir) < 0.000) ) {

         return ;

      }

   }
   self.enemy = other;
   multi_trigger ();

};

string __fullspawndata;
float (string fullentdata) CheckQ3FcapPoint;
void () info_tfgoal;

void () trigger_multiple = {

   local string tmp;

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if (bspversion == 46) {
       tmp = __fullspawndata;

       if ( CheckQ3FcapPoint (tmp)) {
          self.classname = "info_tfgoal";
          info_tfgoal();
          return;
       }

   }

   if ( (self.sounds == 1.000) ) {

      precache_sound ("misc/secret.wav");
      self.noise = "misc/secret.wav";

   } else {

      if ( (self.sounds == 2.000) ) {

         precache_sound ("misc/talk.wav");
         self.noise = "misc/talk.wav";

      } else {

         if ( (self.sounds == 3.000) ) {

            precache_sound ("misc/trigger1.wav");
            self.noise = "misc/trigger1.wav";

         }

      }

   }
   if ( !self.wait ) {

      self.wait = 0.200;

   }
   self.use = multi_use;
   InitTrigger ();
   if ( self.health ) {

      if ( (self.spawnflags & 1.000) ) {

         objerror ("health and notouch don't make sense\n");

      }
      self.max_health = self.health;
      self.th_die = multi_killed;
      self.takedamage = 1.000;
      self.solid = 2.000;
      setorigin (self,self.origin);

   } else {

      if ( !(self.spawnflags & 1.000) ) {

         self.touch = multi_touch;

      }

   }

};

void () trigger_once = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.wait = -1.000;
   trigger_multiple ();

};

void () trigger_relay = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }



   self.use = SUB_UseTargets;


};

void () trigger_secret = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   total_secrets = (total_secrets + 1.000);
   self.wait = -1.000;
   if ( !self.message ) {

      self.message = "You found a secret area!";

   }
   if ( !self.sounds ) {

      self.sounds = 1.000;

   }
   if ( (self.sounds == 1.000) ) {

      precache_sound ("misc/secret.wav");
      self.noise = "misc/secret.wav";

   } else {

      if ( (self.sounds == 2.000) ) {

         precache_sound ("misc/talk.wav");
         self.noise = "misc/talk.wav";

      }

   }
   trigger_multiple ();

};

void () counter_use = {

   self.count = (self.count - 1.000);
   if ( (self.count < 0.000) ) {

      return ;

   }
   if ( (self.count != 0.000) ) {

      if ( ((activator.classname == "player") && ((self.spawnflags & 1.000) == 0.000)) ) {

         if ( (self.count >= 4.000) ) {

            CenterPrint (activator,"There are more to go...");

         } else {

            if ( (self.count == 3.000) ) {

               CenterPrint (activator,"Only 3 more to go...");

            } else {

               if ( (self.count == 2.000) ) {

                  CenterPrint (activator,"Only 2 more to go...");

               } else {

                  CenterPrint (activator,"Only 1 more to go...");

               }

            }

         }

      }
      return ;

   }
   if ( ((activator.classname == "player") && ((self.spawnflags & 1.000) == 0.000)) ) {

      CenterPrint (activator,"Sequence completed!");

   }
   self.enemy = activator;
   multi_trigger ();

};

void () trigger_counter = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.wait = -1.000;
   if ( !self.count ) {

      self.count = 2.000;

   }
   self.use = counter_use;

};

void () play_teleport = {

   local float v;
   local string tmpstr;

   v = (random () * 5.000);
   if ( (v < 1.000) ) {

      tmpstr = "misc/r_tele1.wav";

   } else {

      if ( (v < 2.000) ) {

         tmpstr = "misc/r_tele2.wav";

      } else {

         if ( (v < 3.000) ) {

            tmpstr = "misc/r_tele3.wav";

         } else {

            if ( (v < 4.000) ) {

               tmpstr = "misc/r_tele4.wav";

            } else {

               tmpstr = "misc/r_tele5.wav";

            }

         }

      }

   }
   sound (self,2.000,tmpstr,1.000,1.000);
   dremove (self);

};

void (vector org) spawn_tfog = {

   local entity s;

   s = spawn ();
   s.origin = org;
   s.nextthink = (time + 0.200);
   s.think = play_teleport;
   WriteByte (4.000,23.000);
   WriteByte (4.000,11.000);
   WriteCoord (4.000,org_x);
   WriteCoord (4.000,org_y);
   WriteCoord (4.000,org_z);
   multicast (org,1.000);

};

void () tdeath_touch = {


   if ( (other == self.owner) ) {

      return ;

   }
   if ( (other.classname == "player") ) {

      if ( (other.invincible_finished > time) ) {

         self.classname = "teledeath2";

      }
      if ( (self.owner.classname != "player") ) {

         TF_T_Damage (self.owner,self,self,5000.000, 1.000, 0.000);
         return ;

      }

   }
   if ( other.health ) {

      TF_T_Damage (other,self,self,5000.000, 1.000 , 0.000);

   }


};

void (vector org, entity death_owner) spawn_tdeath = {

   local entity death;

   death = spawn ();
   death.classname = "teledeath";
   death.movetype = 0.000;
   death.solid = 1.000;
   death.angles = '0.000 0.000 0.000';
   setsize (death,(death_owner.mins - '4.000 4.000 4.000'),(death_owner.maxs + '4.000 4.000 4.000'));
   setorigin (death,org);
   death.touch = tdeath_touch;
   death.nextthink = (time + 0.200);
   death.think = SUB_Remove;
   death.owner = death_owner;
   force_retouch = 2.000;

};

void () teleport_touch = {

   local entity t;
   local entity te;
   local vector org;

   if ( self.targetname ) {

      if ( (self.nextthink < time) ) {

         return ;

      }

   }
   if ( (self.spawnflags & 1.000) ) {

      if ( (other.classname != "player") ) {

         return ;

      }

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
   if ( ((other.health <= 0.000) || (other.solid != 3.000)) ) {

      return ;

   }
   SUB_UseTargets ();
   spawn_tfog (other.origin);
   t = find (world,targetname,self.target);
   if ( !t ) {

      objerror ("couldn't find target");

   }
   makevectors (t.mangle);
   org = (t.origin + (32.000 * v_forward));
   spawn_tfog (org);
   spawn_tdeath (t.origin,other);
   if ( !other.health ) {

      other.origin = t.origin;
      other.velocity = ((v_forward * other.velocity_x) + (v_forward * other.velocity_y));
      return ;

   }
   setorigin (other,t.origin);
   other.angles = t.mangle;
   if ( (other.classname == "player") ) {

      if ( ((other.weapon == 1.000) && other.hook_out) ) {

         sound (other,1.000,"weapons/bounce2.wav",1.000,1.000);
         other.on_hook = 0.000;
         other.hook_out = 0.000;
         other.fire_held_down = 0.000;
         other.weaponframe = 0.000;
         other.attack_finished = (time + 0.750);

      }
      other.fixangle = 1.000;
      other.teleport_time = (time + 0.700);
      if ( (other.flags & 512.000) ) {

         other.flags = (other.flags - 512.000);

      }
      other.velocity = (v_forward * 300.000);

   }
   other.flags = (other.flags - (other.flags & 512.000));

};

void () info_teleport_destination = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.mangle = self.angles;
   self.angles = '0.000 0.000 0.000';
   self.model = "";
   self.origin = (self.origin + '0.000 0.000 27.000');
   if ( !self.targetname ) {

      objerror ("no targetname");

   }

};

void () teleport_use = {

   self.nextthink = (time + 0.200);
   force_retouch = 2.000;
   self.think = SUB_Null;

};

void () trigger_teleport = {

   local vector o;

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   InitTrigger ();
   self.touch = teleport_touch;
   if ( !self.target ) {

      objerror ("no target");

   }
   self.use = teleport_use;
   if ( !(self.spawnflags & 2.000) ) {

      precache_sound ("ambience/hum1.wav");
      o = ((self.mins + self.maxs) * 0.500);
      ambientsound (o,"ambience/hum1.wav",0.500,3.000);

   }

};

void () trigger_skill_touch = {

   local entity te;

   if ( (other.classname != "player") ) {

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
   cvar_set ("skill",self.message);

};

void () trigger_setskill = {

   dremove (self);
   return ;

};

void () trigger_onlyregistered_touch = {

   local entity te;

   if ( (other.classname != "player") ) {

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
   if ( (self.attack_finished > time) ) {

      return ;

   }
   self.attack_finished = (time + 2.000);
   if ( cvar ("registered") ) {

      self.message = "";
      SUB_UseTargets ();
      dremove (self);

   } else {

      if ( (self.message != "") ) {

         CenterPrint (other,self.message);
         sound (other,4.000,"misc/talk.wav",1.000,1.000);

      }

   }

};

void () trigger_onlyregistered = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("misc/talk.wav");
   InitTrigger ();
   self.touch = trigger_onlyregistered_touch;

};




//void () hurt_on = {

  // self.solid = 1.000;
  // self.nextthink = -1.000;

//};

void () hurt_touch = {

   local entity te;

   if (other.classname == "item_tfgoal") {
      other.nextthink = time;
   }

   if ( other.takedamage ) {

      if ( !Activated (self,other) ) {

         if ( (self.else_goal != 0.000) ) {

            te = Findgoal (self.else_goal);
            if ( te ) {

               AttemptToActivate (te,other,self);

            }

         }
         return ;

      }

      if (self.cnt > 0)
         {
         self.cnt = self.cnt - 1;
         if (self.cnt == 0)
            {
            self.touch = SUB_Null;
            self.nextthink = time + 0.1;
            self.think = SUB_Remove;
            }
         }

     

     // self.solid = 0.000;


      deathmsg = 36.000;
      TF_T_Damage (other,self,self,self.dmg,1.000,0.000);

     // self.think = hurt_on;
    //  self.nextthink = (time + 0.100);


   }

};

void () hurt_use = {

   if ( (self.spawnflags & 1.000) ) {

      self.touch = hurt_touch;
      self.spawnflags = (self.spawnflags - 1.000);

   } else {

      self.touch = SUB_Null;
      self.spawnflags = (self.spawnflags + 1.000);

   }

};

void () trigger_hurt = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   InitTrigger ();
   self.touch = hurt_touch;
   self.use = hurt_use;
   if ( !self.dmg ) {

      self.dmg = 5.000;

   }

};

void () trigger_push_touch = {

   local entity te;

   if ( !Activated (self,other) ) {

      if ( (self.else_goal != 0.000) ) {

         te = Findgoal (self.else_goal);
         if ( te ) {

            AttemptToActivate (te,other,self);

         }

      }
      return ;

   }

	if (other.movetype == 0.000 || other.movetype == 7.000)
		return;

	other.velocity = self.movedir;

	if (!(self.spawnflags & 2.000))
	if (other.classname == "player")
	if (other.fly_sound < time)
	{
		if (self.target)
		{
			other.fly_sound = time + 0.2;
			sound (other, 4.000, "player/plyrjmp8.wav", 1, 1.000);
			sound (other, 0.000, "ambience/windfly.wav", 1, 1.000);
		}
		else
		{
			other.fly_sound = time + 1.5;
			sound (other, 0.000, "ambience/windfly.wav", 1, 1.000);
		}
      }

   if ( (self.spawnflags & 1.000) ) {

      dremove (self);

   }

};

void() trigger_push_findtarget =
{
	local float flighttime, dist, grav;
	local vector org;

	// find the target
	self.enemy = find(world, targetname, self.target);
	if (!self.enemy)
		objerror("trigger_push: target not found\n");

	// where the center is
	org = (self.absmin + self.absmax) * 0.5;

	// figure out how long it will take to hit the point considering gravity
	grav = cvar("sv_gravity");
	flighttime = sqrt((self.enemy.origin_z - org_z) / (0.5 * grav));
	if (!flighttime)
	{
		dremove(self);
		return;
	}

	// how far in X and Y to move
	self.movedir = (self.enemy.origin - org);
	self.movedir_z = 0;
	dist = vlen(self.movedir);

	// finally calculate the velocity
	self.movedir = normalize(self.movedir) * (dist / flighttime);
	self.movedir_z = flighttime * grav;
};

void () trigger_push = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   InitTrigger ();
   precache_sound ("ambience/windfly.wav");
   self.touch = trigger_push_touch;
   if ( !self.speed ) {

      self.speed = 1000.000;

   }
//q3
	self.movedir = self.movedir * self.speed * 10; // why the * 10 I dunno...
	if (self.target)
	{
		self.think = trigger_push_findtarget;
		self.nextthink = time + 0.2;
	}

};
void () func_pushable = {trigger_push();};

void () trigger_monsterjump_touch = {

   if ( ((other.flags & ((32.000 | 1.000) | 2.000)) != 32.000) ) {

      return ;

   }
   other.velocity_x = (self.movedir_x * self.speed);
   other.velocity_y = (self.movedir_y * self.speed);
   if ( !(other.flags & 512.000) ) {

      return ;

   }
   other.flags = (other.flags - 512.000);
   other.velocity_z = self.height;

};

void () trigger_monsterjump = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.speed ) {

      self.speed = 200.000;

   }
   if ( !self.height ) {

      self.height = 200.000;

   }
   if ( (self.angles == '0.000 0.000 0.000') ) {

      self.angles = '0.000 360.000 0.000';

   }
   InitTrigger ();
   self.touch = trigger_monsterjump_touch;

};



