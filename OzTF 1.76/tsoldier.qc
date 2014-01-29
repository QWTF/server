
void () NailGrenadeExplode;

void () NailGrenadeNailEm;

void () NailGrenadeLaunchNail;

void () NailGrenadeTouch = {

   if ( (other == self.owner) ) {

      return ;

   }
   sound (self,1.000,"weapons/bounce.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};

void () NailGrenadeExplode = {

   local entity te;
   local float pos;


   if (anti_spam) {

      te = findradius (self.origin, anti_spam);
      while ( te ) {

         te.chain2 = te.chain;

         if ( (te.classname == "info_player_teamspawn") ) {
            spawn_tfog(self.origin);
            dremove (self);
            return;
         }
         te = te.chain2;

      }
   }


   self.owner.no_active_nail_grens = (self.owner.no_active_nail_grens + 1.000);
   if ( (self.owner.no_active_nail_grens > 0.000) ) {

      te = find (world,classname,"grenade");
      while ( te ) {

         if ( ((te.owner == self.owner) && (te.no_active_nail_grens == 1.000)) ) {

            te.weapon = 9.000;
            te.think = GrenadeExplode;
            te.nextthink = (time + 0.100);

         }
         te = find (te,classname,"grenade");

      }

   }
   self.no_active_nail_grens = self.owner.no_active_nail_grens;
   self.velocity = '0 0 0';
   self.movetype = 5.000;


   pos = pointcontents (self.origin + '0.000 0.000 32.000');
   if ( ((pos == -2.000) || (pos == -6.000)) )
   {

      pos = pointcontents (self.origin - '0.000 0.000 32.000');

         if ( ((pos == -2.000) || (pos == -6.000)) )
         {
            setorigin (self,(self.origin));
         } else {
            setorigin (self,(self.origin - '0.000 0.000 32.000'));
         }

   } else {
      setorigin (self,(self.origin + '0.000 0.000 32.000'));
   }

   self.avelocity = '0.000 500.000 0.000';
   self.nextthink = (time + 0.700);
   self.think = NailGrenadeNailEm;

};

void () NailGrenadeNailEm = {

   self.velocity = '0.000 0.000 0.000';
   self.nextthink = (time + 0.100);
   self.think = NailGrenadeLaunchNail;
   self.playerclass = 0.000;

};

void () NailGrenadeLaunchNail = {

   local float i;
   local float j;
   local float cur_yaw;

   i = 0.000;
   while ( (i < 3.000) ) {

      j = ((random () + 2.000) * 5.000);
      cur_yaw = anglemod ((self.angles_y + j));
      self.angles_y = cur_yaw;
      self.angles_x = 0.000;
      self.angles_z = 0.000;
      makevectors (self.angles);
      deathmsg = 9.000;

      if (modetype & 256)
      {
         launch_spike (self.origin,v_forward);
         newmis.touch = superspike_touch;
      }
      else
      {
         launch_spike (self.origin,v_forward);
         newmis.touch = superspike_touch;
      }

      //newmis.owner = self;
      newmis.weapon = 9.000;
      i = (i + 1.000);

   }
   self.playerclass = (self.playerclass + 1.000);
   self.nextthink = (time + 0.100);
   if ( (self.playerclass > 50.000) ) {

      self.weapon = 9.000;
      self.think = GrenadeExplode;

   }

};
