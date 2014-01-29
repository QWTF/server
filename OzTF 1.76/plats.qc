
void () plat_center_touch;

void () plat_outside_touch;

void () plat_trigger_use;

void () plat_go_up;

void () plat_go_down;

void () plat_crush;

void () plat_spawn_inside_trigger = {

   local entity trigger;
   local vector tmin;
   local vector tmax;

   trigger = spawn ();
   trigger.touch = plat_center_touch;
   trigger.movetype = 0.000;
   trigger.solid = 1.000;
   trigger.enemy = self;
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
   tmin = (self.mins + '25.000 25.000 0.000');
   tmax = (self.maxs - '25.000 25.000 -8.000');
   tmin_z = (tmax_z - ((self.pos1_z - self.pos2_z) + 8.000));
   if ( (self.spawnflags & 1.000) ) {

      tmax_z = (tmin_z + 8.000);

   }
   if ( (self.size_x <= 50.000) ) {

      tmin_x = ((self.mins_x + self.maxs_x) / 2.000);
      tmax_x = (tmin_x + 1.000);

   }
   if ( (self.size_y <= 50.000) ) {

      tmin_y = ((self.mins_y + self.maxs_y) / 2.000);
      tmax_y = (tmin_y + 1.000);

   }
   setsize (trigger,tmin,tmax);

};

void () plat_hit_top = {

   sound (self,2.000,self.noise1,1.000,1.000);
   self.state = 0.000;
   self.think = plat_go_down;
   self.nextthink = (self.ltime + 3.000);

};

void () plat_hit_bottom = {

   sound (self,2.000,self.noise1,1.000,1.000);
   self.state = 1.000;

};

void () plat_go_down = {

   sound (self,2.000,self.noise,1.000,1.000);
   self.state = 3.000;
   SUB_CalcMove (self.pos2,self.speed,plat_hit_bottom);

};

void () plat_go_up = {

   sound (self,2.000,self.noise,1.000,1.000);
   self.state = 2.000;
   SUB_CalcMove (self.pos1,self.speed,plat_hit_top);

};

void () plat_center_touch = {

   local entity te;


   if ((freeze == 1)) {

	return ;

   }

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (!other.playerclass) ) {

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
   if ( (other.health <= 0.000) ) {

      return ;

   }
   self = self.enemy;
   if ( (self.state == 1.000) ) {

      plat_go_up ();

   } else {

      if ( (self.state == 0.000) ) {

         self.nextthink = (self.ltime + 1.000);

      }

   }

};

void () plat_outside_touch = {

   local entity te;


   if ((freeze == 1)) {

	return ;

   }

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
   if ( (other.health <= 0.000) ) {

      return ;

   }
   self = self.enemy;
   if ( (self.state == 0.000) ) {

      plat_go_down ();

   }

};

void () plat_trigger_use = {

   if ( self.think ) {

      return ;

   }
   plat_go_down ();

};

void () plat_crush = {

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
   TF_T_Damage (other,self,self,1.000, 0.000, 0.000);
   if ( (self.state == 2.000) ) {

      plat_go_down ();

   } else {

      if ( (self.state == 3.000) ) {

         plat_go_up ();

      } else {

         objerror ("plat_crush: bad self.state\n");

      }

   }

};

void () plat_use = {

   self.use = SUB_Null;
   if ( (self.state != 2.000) ) {

      objerror ("plat_use: not in up state");

   }
   plat_go_down ();

};


void () func_plat = {


   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.t_length ) {

      self.t_length = 80.000;

   }
   if ( !self.t_width ) {

      self.t_width = 10.000;

   }
   if ( (self.sounds == 0.000) ) {

      self.sounds = 2.000;

   }
   if ( (self.sounds == 1.000) ) {

      precache_sound ("plats/plat1.wav");
      precache_sound ("plats/plat2.wav");
      self.noise = "plats/plat1.wav";
      self.noise1 = "plats/plat2.wav";

   }
   if ( (self.sounds == 2.000) ) {

      precache_sound ("plats/medplat1.wav");
      precache_sound ("plats/medplat2.wav");
      self.noise = "plats/medplat1.wav";
      self.noise1 = "plats/medplat2.wav";

   }
   self.mangle = self.angles;
   self.angles = '0.000 0.000 0.000';
   self.classname = "plat";
   self.solid = 4.000;
   self.movetype = 7.000;
   setorigin (self,self.origin);
   setmodel (self,self.model);
   setsize (self,self.mins,self.maxs);
   self.blocked = plat_crush;
   if ( !self.speed ) {

      self.speed = 150.000;

   }
   self.pos1 = self.origin;
   self.pos2 = self.origin;
   if ( self.height ) {

      self.pos2_z = (self.origin_z - self.height);

   } else {

      self.pos2_z = ((self.origin_z - self.size_z) + 8.000);

   }
   self.use = plat_trigger_use;
   plat_spawn_inside_trigger ();
   if ( self.targetname ) {

      self.state = 2.000;
      self.use = plat_use;

   } else {

      setorigin (self,self.pos2);
      self.state = 1.000;

   }

};


void () train_next;

void () func_train_find;

void () train_blocked = {

   if ( (time < self.attack_finished) ) {

      return ;

   }
   self.attack_finished = (time + 0.500);
   TF_T_Damage (other,self,self,self.dmg,0.000, 0.000);

};

void () train_use = {

   if ( (self.think != func_train_find) ) {

      return ;

   }
   train_next ();

};

void () train_wait = {

   if ( self.wait ) {

      self.nextthink = (self.ltime + self.wait);
      sound (self,2.000,self.noise,1.000,1.000);

   } else {

      self.nextthink = (self.ltime + 0.100);

   }
   self.think = train_next;

};

void () train_next = {

   local entity targ;

   targ = find (world,targetname,self.target);
   self.target = targ.target;
   if ( !self.target ) {

      objerror ("train_next: no next target");

   }
   if ( targ.wait ) {

      self.wait = targ.wait;

   } else {

      self.wait = 0.000;

   }
   sound (self,2.000,self.noise1,1.000,1.000);
   SUB_CalcMove ((targ.origin - self.mins),self.speed,train_wait);

};

void () func_train_find = {

   local entity targ;

   targ = find (world,targetname,self.target);
   self.target = targ.target;
   setorigin (self,(targ.origin - self.mins));
   if ( !self.targetname ) {

      self.nextthink = (self.ltime + 0.100);
      self.think = train_next;

   }

};

void () func_train = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.speed ) {

      self.speed = 100.000;

   }
   if ( !self.target ) {

      objerror ("func_train without a target");

   }
   if ( !self.dmg ) {

      self.dmg = 2.000;

   }
   if ( (self.sounds == 0.000) ) {

      self.noise = "misc/null.wav";
      precache_sound ("misc/null.wav");
      self.noise1 = "misc/null.wav";
      precache_sound ("misc/null.wav");

   }
   if ( (self.sounds == 1.000) ) {

      self.noise = "plats/train2.wav";
      precache_sound ("plats/train2.wav");
      self.noise1 = "plats/train1.wav";
      precache_sound ("plats/train1.wav");

   }
   self.cnt = 1.000;
   self.solid = 4.000;
   self.movetype = 7.000;
   self.blocked = train_blocked;
   self.use = train_use;
   self.classname = "train";
   setmodel (self,self.model);
   setsize (self,self.mins,self.maxs);
   setorigin (self,self.origin);
   self.nextthink = (self.ltime + 0.100);
   self.think = func_train_find;

};

void () misc_teleporttrain = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.speed ) {

      self.speed = 100.000;

   }
   if ( !self.target ) {

      objerror ("func_train without a target");

   }
   self.cnt = 1.000;
   self.solid = 0.000;
   self.movetype = 7.000;
   self.blocked = train_blocked;
   self.use = train_use;
   self.avelocity = '100.000 200.000 300.000';
   self.noise = "misc/null.wav";
   precache_sound ("misc/null.wav");
   self.noise1 = "misc/null.wav";
   precache_sound ("misc/null.wav");
   precache_model2 ("progs/teleport.mdl");
   setmodel (self,"progs/teleport.mdl");
   setsize (self,self.mins,self.maxs);
   setorigin (self,self.origin);
   self.nextthink = (self.ltime + 0.100);
   self.think = func_train_find;

};
