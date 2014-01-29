
void () button_return;

void () button_wait = {

   self.state = 0.000;
   self.nextthink = (self.ltime + self.wait);
   self.think = button_return;
   activator = self.enemy;
   SUB_UseTargets ();
   self.frame = 1.000;

};

void () button_done = {

   self.state = 1.000;

};

void () button_return = {

   self.goal_state = 2.000;
   self.state = 3.000;
   SUB_CalcMove (self.pos1,self.speed,button_done);
   self.frame = 0.000;
   if ( self.health ) {

      self.takedamage = 1.000;

   }

};

void () button_blocked = {


};

void () button_fire = {

   if ( ((self.state == 2.000) || (self.state == 0.000)) ) {

      return ;

   }
   sound (self,2.000,self.noise,1.000,1.000);
   self.state = 2.000;
   SUB_CalcMove (self.pos2,self.speed,button_wait);

};

void () button_use = {

   self.enemy = activator;
   button_fire ();

};

void () button_touch = {

   local entity te;



   if ( (cb_prematch) ) {

      return ;

   }
   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (self.goal_activation & 8.000) ) {

      return ;

   }

   if ( (!other.playerclass ) ) {

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
   self.enemy = other;
   button_fire ();

};

void () button_killed = {

   if ( (self.goal_activation & 8.000) ) {

      return ;

   }
   self.enemy = damage_attacker;
   self.health = self.max_health;
   self.takedamage = 0.000;
   button_fire ();

};


void () func_button = {


   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( (self.sounds == 0.000) ) {

      precache_sound ("buttons/airbut1.wav");
      self.noise = "buttons/airbut1.wav";

   }
   if ( (self.sounds == 1.000) ) {

      precache_sound ("buttons/switch21.wav");
      self.noise = "buttons/switch21.wav";

   }
   if ( (self.sounds == 2.000) ) {

      precache_sound ("buttons/switch02.wav");
      self.noise = "buttons/switch02.wav";

   }
   if ( (self.sounds == 3.000) ) {

      precache_sound ("buttons/switch04.wav");
      self.noise = "buttons/switch04.wav";

   }


   SetMovedir ();
   self.movetype = 7.000;
   self.solid = 4.000;
   setmodel (self,self.model);
   self.blocked = button_blocked;
   self.use = button_use;


   if ( self.health ) {

      self.max_health = self.health;
      self.th_die = button_killed;
      self.takedamage = 1.000;

   } else {

      self.touch = button_touch;

   }
   if ( !self.speed ) {

      self.speed = 40.000;

   }
   if ( !self.wait ) {

      self.wait = 1.000;

   }
   if ( !self.lip ) {

      self.lip = 4.000;

   }
   self.state = 1.000;
   self.pos1 = self.origin;
   self.pos2 = (self.pos1 + (self.movedir * (fabs ((self.movedir * self.size)) - self.lip)));
 

  if ( (self.spawnflags & 32.000) ) {

      button_fire ();

   }

};
