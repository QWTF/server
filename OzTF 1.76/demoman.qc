void () NormalGrenadeTouch;

void () NormalGrenadeExplode;

void () MirvGrenadeTouch;

void () MirvGrenadeExplode;

void (vector org, entity shooter) MirvGrenadeLaunch;

void () TeamFortress_DetpackSet;

void () TeamFortress_DetpackTouch;

void () TeamFortress_DetpackDisarm;

void () TeamFortress_DetpackCountDown;

void () TeamFortress_DetonatePipebombs = {

   local entity e;

   e = find (world,classname,"pipebomb");
   while ( (e != world) ) {

      if ( (e.owner == self) ) {

         e.nextthink = time;

      }
      e = find (e,classname,"pipebomb");

   }

};

void () MirvGrenadeTouch = {

   sound (self,1.000,"weapons/bounce.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};

void () MirvGrenadeExplode = {

   local float i;
   local entity te;

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

   deathmsg = 10.000;
   T_RadiusDamage (self,self.owner,100.000,world);
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   self.solid = 0.000;
   i = 0.000;
   while ( (i < 4.000) ) {

      MirvGrenadeLaunch ((self.origin + '0.000 0.000 -1.000'),self.owner);
      i = (i + 1.000);

   }
   dremove(self);

};

void (vector org, entity shooter) MirvGrenadeLaunch = {

   local float xdir;
   local float ydir;
   local float zdir;

   xdir = ((150.000 * random ()) - 75.000);
   ydir = ((150.000 * random ()) - 75.000);
   zdir = (40.000 * random ());
   newmis = spawn ();
   newmis.owner = shooter;
   newmis.movetype = 10.000;
   newmis.solid = 2.000;
   newmis.classname = "grenade";
   newmis.weapon = 10.000;
   newmis.touch = NormalGrenadeTouch;
   newmis.think = NormalGrenadeExplode;
   newmis.nextthink = ((time + 2.000) + random ());
   newmis.velocity_x = (xdir * 2.000);
   newmis.velocity_y = (ydir * 2.000);
   newmis.velocity_z = (zdir * 15.000);
   newmis.avelocity = '250.000 300.000 400.000';
   setmodel (newmis,"progs/grenade2.mdl");
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,org);

};

void (entity bowner) TeamFortress_SetBomb = {

   local string stimer;
   local float timer;
   local entity at_spot;
   local float bombarmtime;

   bowner.is_detpacking = 0.000;

   if ((bowner.pteam.team != 2.000) ) {
      return ;
   }
   if ( !(bowner.ammo_detpack )) {
      sprint (bowner,2.000,"You need the Bomb!\n");
      return ;
   }

   at_spot = findradius (bowner.origin,65.000);
   while ( (at_spot != world) ) {

      if ( ((at_spot.classname == "player") && (bowner != at_spot)) ) {

         sprint (bowner,2.000,"You can't set a bomb on someone!\n");
         bowner.is_detpacking = 0.000;
         return ;

      } else {

         if ( ((at_spot.mdl == "progs/turrbase.mdl") || (at_spot.mdl == "progs/turrgun.mdl")) ) {

            sprint (bowner,2.000,"You can't set a bomb on a sentry gun!\n");
            bowner.is_detpacking = 0.000;
            return ;

         } else {

            if ( (at_spot.mdl == "progs/disp.mdl") ) {

               sprint (bowner,2.000,"You can't set a bomb on a dispenser!\n");
               bowner.is_detpacking = 0.000;
               return ;


            } else {

               if ( (at_spot.classname == "detpack") ) {

                  sprint (bowner,2.000,"Bombs can't be stacked!\n");
                  bowner.is_detpacking = 0.000;
                  return ;

               }

            }

         }

      }
      at_spot = at_spot.chain;

   }
   if ( !(bowner.flags & 512.000) ) {

      sprint (bowner,2.000,"You can't set the bomb in the air!\n");
      bowner.is_detpacking = 0.000;
      return ;

   }


   if (!modetype & 2) { 
      bowner.ammo_detpack = (bowner.ammo_detpack - 1.000);
   }


   stuffcmd (bowner,"topcolor ");
   stuffcmd (bowner, ftos(bowner.pteam.colormap));
   stuffcmd (bowner,"\n");
      



   //bowner.immune_to_check = (time + 5.000);
   bowner.tfstate = (bowner.tfstate | 65536.000);
   bowner.weapon = bowner.current;
   bowner.current = 0.000;
   bowner.weaponmodel = "";
   bowner.weaponframe = 0.000;
   TeamFortress_SetSpeed (bowner);
   if (bowner.is_unabletospy) {
      bowner.is_unabletospy = 0.000;
   }

      timer = stof(infokey (world,"bombtime"));
      if (timer < 5.000 || timer >  90.000) timer = 50.000;


   stimer = ftos (timer);



   bombarmtime = stof(infokey (world,"bombarmtime"));

   if (bombarmtime < 1.000 || bombarmtime >  10.000) bombarmtime = 3.000;
   bowner.pausetime = (time + bombarmtime);
   sprint(bowner,2.000,"Setting Bomb...\n");


   newmis = spawn ();
   newmis.owner = bowner;
   newmis.classname = "timer";
   newmis.netname = "detpack_timer";
   newmis.nextthink = (time + bombarmtime);
   newmis.think = TeamFortress_DetpackSet;
   newmis.health = timer;

};



void (float timer) TeamFortress_SetDetpack = {

   local string stimer;
   local entity te;
   local entity at_spot;

   if (modetype & 4) {
      self.is_detpacking = 1.000; 
      return;
   }

   self.impulse = 0.000;
   self.last_impulse = 0.000;

   if ( (self.ammo_detpack <= 0.000) ) {

      sprint (self,2.000,"You have no detpacks left!\n");

      return ;

   }
   
   at_spot = findradius (self.origin,65.000);
   while ( (at_spot != world) ) {

      if ( ((at_spot.classname == "player") && (self != at_spot)) ) {

         sprint (self,2.000,"You can't set a detpack on someone!\n");
         return ;

      } else {

         if ( ((at_spot.mdl == "progs/turrbase.mdl") || (at_spot.mdl == "progs/turrgun.mdl")) ) {

            sprint (self,2.000,"You can't set a detpack on a sentry gun!\n");
            return ;

         } else {

            if ( (at_spot.mdl == "progs/disp.mdl") ) {

               sprint (self,2.000,"You can't set a detpack on a dispenser!\n");
               return ;


            } else {

               if ( (at_spot.classname == "detpack") ) {

                  sprint (self,2.000,"Detpacks can't be stacked!\n");
                  return ;

               }

            }

         }

      }
      at_spot = at_spot.chain;

   }
   if ( !(self.flags & 512.000) ) {

      sprint (self,2.000,"You can't set detpacks in the air!\n");
      return ;

   }
   te = find (world,classname,"detpack");
   while ( te ) {

      if ( (te.owner == self) ) {

         sprint (self,2.000,"You can only have 1 detpack active at a time.\n");
         return ;

      }
      te = find (te,classname,"detpack");

   }
   if ( (timer < 5.000) ) {

      sprint (self,2.000,"You can't set detpacks for less than 5 seconds.\n");
      return ;

   }
   self.is_detpacking = 1.000;

   if (!modetype & 2) { 
      self.ammo_detpack = (self.ammo_detpack - 1.000);
   }
   //self.immune_to_check = (time + 5.000);
   self.tfstate = (self.tfstate | 65536.000);
   self.weapon = self.current;
   self.current = 0.000;
   self.weaponmodel = "";
   self.weaponframe = 0.000;
   TeamFortress_SetSpeed (self);
   if (self.is_unabletospy) {
      self.is_unabletospy = 0.000;
   }
   stimer = ftos (timer);


   self.pausetime = (time + 3.000);
   sprint (self,2.000,"Setting detpack for ");
   sprint (self,2.000,stimer);
   sprint (self,2.000," seconds...\n");
 
   newmis = spawn ();
   newmis.owner = self;
   newmis.classname = "timer";
   newmis.netname = "detpack_timer";
   newmis.nextthink = (time + 3.000);
   newmis.think = TeamFortress_DetpackSet;
   newmis.health = timer;

};

void () TeamFortress_DetpackStop = {

   local entity detpack_timer;

   self.is_detpacking = 0.000;
   detpack_timer = find (world,netname,"detpack_timer");
   while ( ((detpack_timer.owner != self) && (detpack_timer != world)) ) {

      detpack_timer = find (detpack_timer,netname,"detpack_timer");

   }
   if ( (detpack_timer == world) ) {

      return ;

   }
   sprint (self,2.000,"Detpack retrieved.\n");
   self.ammo_detpack = (self.ammo_detpack + 1.000);
   dremove (detpack_timer);
   self.tfstate = (self.tfstate - (self.tfstate & 65536.000));
   self.current = self.weapon;
   W_SetCurrentAmmo ();
   TeamFortress_SetSpeed (self);
   self.pausetime = time;

};

void () TeamFortress_DetpackSet = {

   local entity countd;
   local entity oldself;
   local string st;


   self.is_detpacking = 0.000;
   self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 65536.000));
   TeamFortress_SetSpeed (self.owner);
   oldself = self;
   self = self.owner;
   self.is_detpacking = 0.000;
   self.current = self.weapon;
   W_SetCurrentAmmo ();
   self = oldself;
   newmis = spawn ();
   newmis.owner = self.owner;
   newmis.origin = (self.owner.origin - '0.000 0.000 23.000');
   newmis.movetype = 10.000;

   st = infokey (world,"soliddet");

   if ( (st == "off") ) {

      newmis.solid = 1.000;

   } else {

      newmis.solid = 2.000;
   }

   newmis.classname = "detpack";
   newmis.flags = 256.000;
   newmis.angles = '90.000 0.000 0.000';
   newmis.angles_y = self.owner.angles_y;
   newmis.velocity = '0.000 0.000 0.000';
   newmis.avelocity = '0.000 0.000 0.000';
   newmis.weaponmode = 0.000;
   newmis.touch = TeamFortress_DetpackTouch;
   setmodel (newmis,"progs/detpack.mdl");
   setsize (newmis,'-16.000 -16.000 0.000','16.000 16.000 8.000');
   setorigin (newmis,self.owner.origin);
   countd = spawn ();
   newmis.linked_list = countd;
   countd.think = TeamFortress_DetpackCountDown;
   countd.health = (self.health - 1.000);
   countd.owner = self.owner;
   countd.classname = "detpack_timer";
   countd.enemy = newmis;
   newmis.oldenemy = countd;
   if ( (self.health <= 255.000) ) {

      countd.nextthink = (time + 1.000);

   } else {

      countd.nextthink = ((time + self.health) - 10.000);
      countd.health = 9.000;

   }
   newmis.nextthink = (time + self.health);
   newmis.think = TeamFortress_DetpackExplode;
   if (modetype & 4) {
      newmis.target = self.owner.target;
      self.owner.target = string_null;

      bprint(2, "The Bomb has been planted!\n");
      sound(self.owner,2.000,"speech/bombpl.wav",1.000,0.000);
   } else {
      sound (self.owner,2.000,"doors/medtry.wav",1.000,1.000);
      sprint (self.owner,2.000,"Detpack set!\n");
   }
   dremove (self);

};


void () TeamFortress_DetpackExplode = {

   local float pos;
   local float points;
   local entity head;
   local entity te;
   local vector org;

   bprint (1.000,"FIRE IN THE HOLE!\n");
   sound (self,1.000,"weapons/detpack.wav",1.000,0.000);
   pos = pointcontents (self.origin);
   if ( (((pos != -2.000) && (pos != -6.000)) && (!self.owner.has_disconnected )) ) {

      deathmsg = 12.000;
      head = findradius (self.origin,1000.000);
      while ( head ) {

         head.chain2 = head.chain;

         if ( (head.classname == "info_tfgoal") ) {

            if ( ((head.goal_activation & 2.000) && (head.search_time == 0.000)) ) {

               traceline (self.origin,head.origin,1.000,self);
               if ( (trace_fraction == 1.000) ) {

                  if ( Activated (head,self.owner) ) {

                     DoResults (head,self.owner,1.000);

                  } else {

                     if ( (head.else_goal != 0.000) ) {

                        te = Findgoal (head.else_goal);
                        if ( te ) {

                           AttemptToActivate (te,self.owner,head);

                        }

                     }

                  }

               }

            }

        } else {

            if ( (head.takedamage && (vlen ((head.origin - self.origin)) <= 900.000)) ) {

               org = (head.origin + ((head.mins + head.maxs) * 0.500));
               points = (0.500 * vlen ((self.origin - org)));
               if ( (points < 0.000) ) {

                  points = 0.000;

               }
               points = (700.000 - points);


               if ( points ) {
               
                  if (grenradius & 2)
                  {
                     TF_T_Damage (head,self,self.owner,(points * 2.000),2.000,4.000);
                  }
                  else
                  {
                     if ( CanDamage (head,self) ) {

                        TF_T_Damage (head,self,self.owner,(points * 2.000),2.000,4.000);

                     }
                  }

               }

            }

         }


         head = head.chain2;

      }

      if (modetype & 4) {

         SUB_UseTargets ();
         round_winner = self.owner.pteam;
      }

      WriteByte (4.000,23.000);
      WriteByte (4.000,3.000);
      WriteCoord (4.000,self.origin_x);
      WriteCoord (4.000,self.origin_y);
      WriteCoord (4.000,self.origin_z);
      multicast (self.origin,1.000);

   } else {

      sprint (self.owner,2.000,"Your detpack fizzled out.\n");

   }
   if ( (self.weaponmode == 1.000) ) {

      TeamFortress_SetSpeed (self.enemy);
      dremove (self.oldenemy);
      dremove (self.observer_list);

   }
   dremove(self);

};

void () TeamFortress_DetpackTouch = {

   local entity disarm;
   local vector src;
   local float defusetime;

 
  CheckBelowBuilding (self);
   if ( (other.classname != "player") ) {

      return ;

   }

   if (!modetype & 4) {
      if ( (other.playerclass != 1.000) ) {

         return ;

      }

   } else {

      if ( (!other.playerclass) || (other.pteam.team == 2.000) ) {

         return ;

      }

   }

   if ( other.deadflag ) {

      return ;

   }
   if ( (self.weaponmode == 1.000) ) {

      return ;

   }
   if ( ((other.pteam == self.owner.pteam) && (self.owner.pteam.team != 0.000)) ) {

      return ;

   }


   makevectors (other.v_angle);
   src = (other.origin + '0.000 0.000 16.000');
   traceline (src,(src + (v_forward * 64.000)),0.000,other);
 
   if (self.solid == 2.000) {
	if ((trace_fraction == 1) || (trace_ent != self))
	{
		return;
	}
   } else {

      if ( (trace_fraction == 1.000)  ) {
 
         return ;

      }
   }
      
   other.tfstate = (other.tfstate | 65536.000);
   TeamFortress_SetSpeed (other);

   disarm = spawn ();
   disarm.owner = other;
   disarm.enemy = self;
   disarm.classname = "timer";

   if (modetype & 4) {
      defusetime = stof(infokey (world,"bombdefusetime"));
      if (defusetime < 3.000 || defusetime > 15.000) defusetime = 8.000;
      disarm.nextthink = (time + defusetime);
      //disarm.weapon = defusetime;
      sprint (other,2.000,"Defusing Bomb...\n");
   } else {
      disarm.nextthink = (time + 3.000);
      sprint (other,2.000,"Disarming detpack...\n");
   }
   disarm.think = TeamFortress_DetpackDisarm;
   self.weaponmode = 1.000;
   self.enemy = other;
   self.observer_list = disarm;

};

void () TeamFortress_DetpackDisarm = {

   if ( (self.owner.deadflag) ) {

      dremove (self);
      return ;

   }

   if (modetype & 4) { 

      //if (self.weapon > 0) {
        // CenterPrint3(self.owner, "Defusing Bomb in ", ftos(self.weapon), " second(s)\n");  
        // self.weapon = self.weapon - 1;
        // self.nextthink = (time + 1.000);
        // return;
     // }

      bprint (1.000,self.enemy.owner.netname);
      bprint (1.000,"'s bomb was defused by ");
      bprint (1.000,self.owner.netname);
      bprint (1.000,"\n");
      round_winner = self.owner.pteam;

   } else {

      bprint (1.000,self.enemy.owner.netname);
      bprint (1.000,"'s detpack was defused by ");
      bprint (1.000,self.owner.netname);
      bprint (1.000,"\n");

   }


   self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 65536.000));
   TF_AddFrags (self.owner,1.000, 0.000);
   TeamFortress_SetSpeed (self.owner);
   dremove (self.enemy.oldenemy);
   dremove (self.enemy);
   dremove (self);

};

void () TeamFortress_DetpackCountDown = {

   local string cd;


   cd = ftos (self.health);
   CheckBelowBuilding (self.enemy);
   self.nextthink = (time + 1.000);
   self.health = (self.health - 1.000);

   if ( (self.health < 10.000) ) {


      sprint (self.owner,2.000,cd);
      sprint (self.owner,2.000,"...\n");
      if ( ((self.health < 5.000) && (self.has_disconnected == 0.000)) ) {

         sound (self.enemy,2.000,"doors/baseuse.wav",1.000,1.000);
         self.has_disconnected = 1.000;

      }
      if ( ((self.health < 5.000) && (self.enemy.skin == 0.000)) ) {

         self.enemy.skin = 1.000;

      } else {

         self.enemy.skin = 0.000;

      }
      if ( (self.health <= 0.000) ) {

         dremove (self);

      }

   }

};
