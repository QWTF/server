
void (entity rhook) Reset_Grapple = {

   sound (rhook.owner,1.000,"weapons/bounce.wav",1.000,0.000);


   rhook.owner.on_hook = 0.000;
   rhook.owner.gravity = 1.000;
   rhook.owner.hook_out = 0.000;
   rhook.owner.fire_held_down = 0.000;
   rhook.owner.weaponframe = 0.000;
   rhook.think = SUB_Remove;
   rhook.nextthink = time;

};

void () Grapple_Track = {

   //local vector org;
   if ( (!self.owner.on_hook || (self.owner.health <= 0.000)) ) {

      Reset_Grapple (self);
      return ;

   }
/*
  if ( (self.enemy.classname == "player") ) {

      makevectors (self.enemy.v_angle);
      org = self.enemy.origin - (v_forward * 64.000); 
      self.velocity = org;
  }
*/
  else 
  {
      self.velocity = self.enemy.velocity;
  }

      self.nextthink = (time + 0.100);

};
entity () MakeLink = {

   newmis = spawn ();
   newmis.movetype = 9.000;
   newmis.solid = 0.000;
   newmis.owner = self;
   newmis.avelocity = '200.000 200.000 200.000';
   setmodel (newmis,"progs/s_spike.mdl");
   setorigin (newmis,self.origin);
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   return ( newmis );

};

void () Remove_Chain = {

   self.think = SUB_Remove;
   self.nextthink = time;
   if ( self.goalentity ) {

      self.goalentity.think = SUB_Remove;
      self.goalentity.nextthink = time;
      if ( self.goalentity.goalentity ) {

         self.goalentity.goalentity.think = SUB_Remove;
         self.goalentity.goalentity.nextthink = time;

      }

   }

};

void () Update_Chain = {

   local vector temp;

   if ( !self.owner.hook_out ) {

      self.think = Remove_Chain;
      self.nextthink = time;
      return ;

   }
   temp = (self.owner.hook.origin - self.owner.origin);
   setorigin (self,(self.owner.origin + (temp * 0.250)));
   setorigin (self.goalentity,(self.owner.origin + (temp * 0.500)));
   setorigin (self.goalentity.goalentity,(self.owner.origin + (temp * 0.750)));
   self.nextthink = (time + 0.100);

};

void () Build_Chain = {

   self.goalentity = MakeLink ();
   self.goalentity.think = Update_Chain;
   self.goalentity.nextthink = (time + 0.100);
   self.goalentity.owner = self.owner;
   self.goalentity.goalentity = MakeLink ();
   self.goalentity.goalentity.goalentity = MakeLink ();

};
float () Check_Overhead = {

   local vector src;
   local vector end;

   makevectors (self.owner.angles);
   src = (self.owner.origin - '0.000 0.000 24.000');
   end = (self.owner.origin - '0.000 0.000 24.000');
   traceline (src,end,0.000,self.owner);
   if ( (trace_fraction != 1.000) ) {

      return ( 0.000 );

   }
   src = ((self.owner.origin - '0.000 0.000 24.000') - (v_forward * 16.000));
   end = (((self.owner.origin - '0.000 0.000 24.000') - (v_forward * 16.000)) + '0.000 0.000 58.000');
   traceline (src,end,0.000,self.owner);
   if ( (trace_fraction != 1.000) ) {

      return ( 0.000 );

   }
   src = ((self.owner.origin - '0.000 0.000 24.000') + (v_forward * 16.000));
   end = (((self.owner.origin - '0.000 0.000 24.000') + (v_forward * 16.000)) + '0.000 0.000 58.000');
   traceline (src,end,0.000,self.owner);
   if ( (trace_fraction != 1.000) ) {

      return ( 0.000 );

   }
   src = ((self.owner.origin - '0.000 0.000 24.000') - (v_right * 16.000));
   end = (((self.owner.origin - '0.000 0.000 24.000') - (v_right * 16.000)) + '0.000 0.000 58.000');
   traceline (src,end,0.000,self.owner);
   if ( (trace_fraction != 1.000) ) {

      return ( 0.000 );

   }
   src = ((self.owner.origin - '0.000 0.000 24.000') + (v_right * 16.000));
   end = (((self.owner.origin - '0.000 0.000 24.000') + (v_right * 16.000)) + '0.000 0.000 58.000');
   traceline (src,end,0.000,self.owner);
   if ( (trace_fraction != 1.000) ) {

      return ( 0.000 );

   }
   return ( 1.000 );

};

void () Anchor_Grapple = {

   local float test;

   if ( (other == self.owner) ) {

      return ;

   }
   if ((other.hook.enemy == self) ) {

      return ;

   }
   if ( ((((other.classname == "missile") || (other.classname == "grenade")) || (other.classname == "spike")) || (other.classname == "hook")) ) {

      return ;

   }
   if ( (pointcontents (self.origin) == -6.000) ) {

      Reset_Grapple (self);
      return ;

   }
   if ( (other.classname == "player") ) {
   //   Reset_Grapple (self);
   //   return ;

   //} else {

      sound (self,1.000,"player/axhit2.wav",1.000,1.000);
      if ( other.takedamage ) {

         deathmsg = 21.000;
         TF_T_Damage (other,self,self.owner,1.000, 0.000, 0.000);

      }


         //self.velocity = '0.000 0.000 0.000';
         //self.avelocity = '0.000 0.000 0.000';
      

   }
   sound (self.owner,1.000,"weapons/tink1.wav",1.000,1.000);
   if ( !self.owner.button0 ) {

      Reset_Grapple (self);
      return ;

   }
   test = Check_Overhead ();
   if ( !test ) {

      Reset_Grapple (self);
      return ;

   }
   self.owner.on_hook = 1.000;
   if ( (self.owner.flags & 512.000) ) {

      self.owner.flags = (self.owner.flags - 512.000);
      setorigin (self.owner,(self.owner.origin + '0.000 0.000 1.000'));

   }
   self.owner.gravity = 0.000;
   self.owner.lefty = 1.000;
   self.enemy = other;
   self.think = Grapple_Track;
   self.nextthink = time;
   self.solid = 0.000;
   self.touch = SUB_Null;

};

void () Throw_Grapple = {

   if ( self.hook_out ) {

      return ;

   }
   KickPlayer (-1.000,self);
   newmis = spawn ();
   newmis.movetype = 9.000;
   newmis.solid = 2.000;
   newmis.owner = self;
   self.hook = newmis;
   newmis.classname = "hook";
   makevectors (self.v_angle);
   newmis.velocity = (v_forward * 800.000);
   newmis.angles = vectoangles (newmis.velocity);
   newmis.touch = Anchor_Grapple;
   newmis.think = Build_Chain;
   newmis.nextthink = (time + 0.100);
   setmodel (newmis,"progs/hook.mdl");
   setorigin (newmis,((self.origin + (v_forward * 16.000)) + '0.000 0.000 16.000'));
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   self.hook_out = 1.000;
   self.fire_held_down = 1.000;

};

void () Service_Grapple = {

   local vector hook_dir;

   if ( !self.button0 ) {

      self.fire_held_down = 0.000;
      if ( (self.current == 1.000) ) {

         Reset_Grapple (self.hook);

      }

   }
   if ( (self.hook.enemy.classname == "player") ) {

      hook_dir = (self.hook.enemy.origin - self.origin);

   } else {

      if ( (self.hook.enemy.classname != "player") ) {

         hook_dir = (self.hook.origin - self.origin);

      }

   }
   self.velocity = ((normalize (hook_dir) * self.maxspeed) * 2.000);
   if ( ((vlen (hook_dir) <= 100.000) && self.lefty) ) {

      if ( self.hook.goalentity ) {

         self.hook.goalentity.think = Remove_Chain;
         self.hook.goalentity.nextthink = time;

      }
      self.lefty = 0.000;

   }

};
