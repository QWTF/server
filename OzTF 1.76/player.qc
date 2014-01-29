void () bubble_bob;

void () Throw_Grapple;

void () T_Dispenser;

void () Headless_Think;

void () player_touch = {

   local entity Bio;
   local entity te;
   local float found;

   if (self.deadflag > 0 )
   {
      return;
   }


   if ((self.playerclass == 8.000)){

      if ( (other.classname == "player") ) {

         if ( ((self.undercover_team != 0.000) || (self.undercover_skin != 0.000)) ) {

            if ( (((other.playerclass == 8.000) || (other.playerclass == 1.000)) && (other.pteam != self.pteam)) ) {

               TF_AddFrags (other,1.000, 0.000);
               bprint (1.000,other.netname);
               bprint (1.000," uncovered an enemy spy!\n");
               Spy_RemoveDisguise (self);

            }

         }
         if ( ((other.undercover_team != 0.000) || (other.undercover_skin != 0.000)) ) {

            if ( (((self.playerclass == 8.000) || (self.playerclass == 1.000)) && (self.pteam != other.pteam)) ) {

               TF_AddFrags (self,1.000, 0.000);
               bprint (1.000,self.netname);
               bprint (1.000," uncovered an enemy spy!\n");
               Spy_RemoveDisguise (other);

            }

         }

      }

   }
   if ( ((self.tfstate & 16.000) && (!cb_prematch) && (!modetype & 2)) ) {

      if ( ((other.classname == "player") && (te.playerclass)) ) {

         if ( !(other.tfstate & 16.000) ) {

            if ( (other.playerclass != 5.000) ) {

               if ( !(((teamplay & 16.000) && (self.owner.pteam == self.enemy.pteam)) && (self.owner.pteam.team != 0.000)) ) {

                  found = 0.000;
                  te = find (world,classname,"timer");
                  while ( ((te != world) && (found == 0.000)) ) {

                     if ( ((te.owner == self) && (te.think == BioInfection_Decay)) ) {

                        found = 1.000;

                     } else {

                        te = find (te,classname,"timer");

                     }

                  }
                  Bio = spawn ();
                  Bio.nextthink = 2.000;
                  Bio.think = BioInfection_Decay;
                  Bio.owner = other;
                  Bio.classname = "timer";
                  Bio.enemy = te.enemy;
                  other.tfstate = (other.tfstate | 16.000);
                  other.infection_team_no = self.infection_team_no;
                  sprint (other,1.000,"You have been infected by ");
                  sprint (other,1.000,self.netname);
                  sprint (other,1.000,"!\n");
                  sprint (self,1.000,"You have infected ");
                  sprint (self,1.000,other.netname);
                  sprint (self,1.000,"!\n");

               }

            }

         }

      }

   }

};

void () player_stand1 = [ 17.000, player_stand1 ] {

   self.weaponframe = 0.000;
   if ( (self.velocity_x || self.velocity_y) ) {

      self.walkframe = 0.000;
      player_run ();
      return ;

   }
   if ( (self.current <= WEAP_AXE) ) {

      if ( (self.walkframe >= 12.000) ) {

         self.walkframe = 0.000;

      }
      self.frame = (17.000 + self.walkframe);

   } else {

      if ( (self.walkframe >= 5.000) ) {

         self.walkframe = 0.000;

      }
      self.frame = (12.000 + self.walkframe);

   }
   self.walkframe = (self.walkframe + 1.000);

};

void () player_run = [ 6.000, player_run ] {

   self.weaponframe = 0.000;
   if ( (!self.velocity_x && !self.velocity_y) ) {

      self.walkframe = 0.000;
      player_stand1 ();
      return ;

   }
   if ( (self.current <= WEAP_AXE) ) {

      if ( (self.walkframe >= 6.000) ) {

         self.walkframe = 0.000;

      }
      self.frame = (0.000 + self.walkframe);

   } else {

      if ( (self.walkframe >= 6.000) ) {

         self.walkframe = 0.000;

      }
      self.frame = (self.frame + self.walkframe);

   }
   self.walkframe = (self.walkframe + 1.000);

};

void () player_shot1 = [ 113.000, player_shot2 ] {

   self.weaponframe = 1.000;
   muzzleflash ();

};

void () player_shot2 = [ 114.000, player_shot3 ] {

   self.weaponframe = 2.000;

};

void () player_shot3 = [ 115.000, player_shot4 ] {

   self.weaponframe = 3.000;

};

void () player_shot4 = [ 116.000, player_shot5 ] {

   self.weaponframe = 4.000;

};

void () player_shot5 = [ 117.000, player_shot6 ] {

   self.weaponframe = 5.000;

};

void () player_shot6 = [ 118.000, player_run ] {

   self.weaponframe = 6.000;

};

void () player_autorifle1 = [ 113.000, player_autorifle2 ] {

   self.weaponframe = 1.000;
   muzzleflash ();

};

void () player_autorifle2 = [ 114.000, player_autorifle3 ] {

   self.weaponframe = 2.000;

};

void () player_autorifle3 = [ 118.000, player_run ] {

   self.weaponframe = 6.000;

};

void () player_axe1 = [ 119.000, player_axe2 ] {

   self.weaponframe = 1.000;

};

void () player_axe2 = [ 120.000, player_axe3 ] {

   self.weaponframe = 2.000;

};

void () player_axe3 = [ 121.000, player_axe4 ] {

   self.weaponframe = 3.000;
   if ( (self.current == WEAP_AXE) ) {

      W_FireAxe ();

   } else {

      W_FireSpanner ();

   }

};

void () player_axe4 = [ 122.000, player_run ] {

   self.weaponframe = 4.000;

};

void () player_axeb1 = [ 125.000, player_axeb2 ] {

   self.weaponframe = 5.000;

};

void () player_axeb2 = [ 126.000, player_axeb3 ] {

   self.weaponframe = 6.000;

};

void () player_axeb3 = [ 127.000, player_axeb4 ] {

   self.weaponframe = 7.000;
   if ( (self.current == WEAP_AXE) ) {

      W_FireAxe ();

   } else {

      W_FireSpanner ();

   }

};

void () player_axeb4 = [ 128.000, player_run ] {

   self.weaponframe = 8.000;

};

void () player_axec1 = [ 131.000, player_axec2 ] {

   self.weaponframe = 1.000;

};

void () player_axec2 = [ 132.000, player_axec3 ] {

   self.weaponframe = 2.000;

};

void () player_axec3 = [ 133.000, player_axec4 ] {

   self.weaponframe = 3.000;
   if ( (self.current == WEAP_AXE) ) {

      W_FireAxe ();

   } else {

      W_FireSpanner ();

   }

};

void () player_axec4 = [ 134.000, player_run ] {

   self.weaponframe = 4.000;

};

void () player_axed1 = [ 137.000, player_axed2 ] {

   self.weaponframe = 5.000;

};

void () player_axed2 = [ 138.000, player_axed3 ] {

   self.weaponframe = 6.000;

};

void () player_axed3 = [ 139.000, player_axed4 ] {

   self.weaponframe = 7.000;
   if ( (self.current == WEAP_AXE) ) {

      W_FireAxe ();

   } else {

      W_FireSpanner ();

   }

};

void () player_axed4 = [ 140.000, player_run ] {

   self.weaponframe = 8.000;

};

void () player_chain1 = [ 137.000, player_chain1a ] {

   self.weaponframe = 1.000;
   Throw_Grapple ();

};

void () player_chain1a = [ 137.000, player_chain2 ] {

   self.weaponframe = 2.000;

};

void () player_chain2 = [ 138.000, player_chain2a ] {

   self.weaponframe = 3.000;

};

void () player_chain2a = [ 138.000, player_chain3 ] {

   self.weaponframe = 4.000;

};

void () player_chain3 = [ 139.000, player_chain3 ] {

   self.weaponframe = 6.000;
   if ( !self.hook_out ) {

      player_chain5 ();
      return ;

   }
   if ( self.speed >= 750.000)  {

      player_chain4 ();
      return ;

   }

};

void () player_chain4 = [ 73.000, player_chain4 ] {

   self.weaponframe = 6.000;
   if ( !self.hook_out ) {

      player_chain5 ();
      return ;

   }
   if ( self.speed < 750.000)  {

      player_chain3 ();
      return ;

   }

};

void () player_chain5 = [ 140.000, player_run ] {

   self.weaponframe = 0.000;

};

void () player_medikit1 = [ 119.000, player_medikit2 ] {

   self.weaponframe = 1.000;

};

void () player_medikit2 = [ 120.000, player_medikit3 ] {

   self.weaponframe = 2.000;

};

void () player_medikit3 = [ 121.000, player_medikit4 ] {

   self.weaponframe = 3.000;
   W_FireMedikit ();

};

void () player_medikit4 = [ 122.000, player_run ] {

   self.weaponframe = 4.000;

};

void () player_medikitb1 = [ 125.000, player_medikitb2 ] {

   self.weaponframe = 5.000;

};

void () player_medikitb2 = [ 126.000, player_medikitb3 ] {

   self.weaponframe = 6.000;

};

void () player_medikitb3 = [ 127.000, player_medikitb4 ] {

   self.weaponframe = 7.000;
   W_FireMedikit ();

};

void () player_medikitb4 = [ 128.000, player_run ] {

   self.weaponframe = 8.000;

};

void () player_medikitc1 = [ 131.000, player_medikitc2 ] {

   self.weaponframe = 1.000;

};

void () player_medikitc2 = [ 132.000, player_medikitc3 ] {

   self.weaponframe = 2.000;

};

void () player_medikitc3 = [ 133.000, player_medikitc4 ] {

   self.weaponframe = 3.000;
   W_FireMedikit ();

};

void () player_medikitc4 = [ 134.000, player_run ] {

   self.weaponframe = 4.000;

};

void () player_medikitd1 = [ 137.000, player_medikitd2 ] {

   self.weaponframe = 5.000;

};

void () player_medikitd2 = [ 138.000, player_medikitd3 ] {

   self.weaponframe = 6.000;

};

void () player_medikitd3 = [ 139.000, player_medikitd4 ] {

   self.weaponframe = 7.000;
   W_FireMedikit ();

};

void () player_medikitd4 = [ 140.000, player_run ] {

   self.weaponframe = 8.000;

};


void () player_nail1 = [ 103.000, player_nail2 ] {

   muzzleflash ();
   if ( (!self.button0 || intermission_running) ) {

      player_run ();
      return ;

   }
   self.weaponframe = (self.weaponframe + 1.000);
   if ( (self.weaponframe == 9.000) ) {

      self.weaponframe = 1.000;

   }
   SuperDamageSound ();
   if ( (self.nailpos == 0.000) ) {

      W_FireSpikes (4.000);
      self.nailpos = 1.000;

   } else {

      W_FireSpikes (-4.000);
      self.nailpos = 0.000;

   }
   Attack_Finished (0.200);

};

void () player_nail2 = [ 104.000, player_nail1 ] {

   if ( (!self.button0 || intermission_running) ) {

      player_run ();
      return ;

   }
   self.weaponframe = (self.weaponframe + 1.000);
   if ( (self.weaponframe == 9.000) ) {

      self.weaponframe = 1.000;

   }

  // if (classtype & 64) {
      SuperDamageSound ();
      if ( (self.nailpos == 0.000) ) {

         W_FireSpikes (4.000);
         self.nailpos = 1.000;

      } else {

         W_FireSpikes (-4.000);
         self.nailpos = 0.000;

      }
 //  }

   Attack_Finished (0.200);

};

void () player_assaultcannonup1 = [ 103.000, player_assaultcannonup2 ] {

   if ( ((!self.button0 || (self.ammo_shells < 1.000)) || intermission_running)) {

      //self.tfstate = (self.tfstate - (self.tfstate & 2048.000));
      if (classtype & 2.000)
	   self.tfstate = self.tfstate - (self.tfstate & 65536);
      
	TeamFortress_SetSpeed (self);
      self.count = 1.000;
      self.heat = 0.000;
      player_assaultcannondown1 ();
      return ;

   }
   self.fire_held_down = 1.000;
   if ( (self.heat == 1.000) ) {

      sound (self,1.000,"weapons/asscan1.wav",1.000,1.000);

   }
   SuperDamageSound ();
   Attack_Finished (0.100);
   if ( ((self.heat != 2.000) && (self.heat != 4.000)) ) {

      if ( (self.weaponframe >= 3.000) ) {
         self.weaponframe = 0.000;
      } else {
         self.weaponframe = (self.weaponframe + 1.000);
      }

   }
   self.heat = (self.heat + 1.000);
   if ( (self.heat >= 7.000) ) {

      self.heat = 0.000;
      player_assaultcannon1 ();

   }

};

void () player_assaultcannonup2 = [ 103.000, player_assaultcannonup1 ] {

   if ( ((!self.button0 || (self.ammo_shells < 1.000)) || intermission_running) || (!(self.flags & 512))  ) {


      self.tfstate = (self.tfstate - (self.tfstate & 2048.000));
      if (classtype & 2.000) {
	   self.tfstate = self.tfstate - (self.tfstate & 65536);
      }
	TeamFortress_SetSpeed (self);
      self.count = 1.000;
      self.heat = 0.000;
      player_assaultcannondown1 ();
      return ;

   }
   SuperDamageSound ();
   Attack_Finished (0.100);
   if ( (((self.heat != 2.000) && (self.heat != 4.000)) && (self.heat != 7.000)) ) {

      if ( ((self.weaponframe == 2.000) && (self.heat >= 9.000)) ) {

         self.weaponframe = 0.000;

      } else {

         if ( (self.weaponframe >= 3.000) ) {

            self.weaponframe = 0.000;

         } else {

            self.weaponframe = (self.weaponframe + 1.000);

         }

      }

   }
   self.heat = (self.heat + 1.000);
   if ( (self.heat >= 13.000) ) {

      self.heat = 0.000;
      player_assaultcannon1 ();

   }

};

void () player_assaultcannon1 = [ 103.000, player_assaultcannon2 ] {

   local string st;

   if ( (!(classtype & 2.000) && (self.speed < 150.000)) || ((classtype & 2.000) && (self.speed < 50.000))  ) {

      muzzleflash ();
      sound (self,1.000,"weapons/asscan2.wav",1.000,1.000);
      if ( (self.weaponframe == 2.000) ) {

         self.weaponframe = 4.000;

      } else {

         self.weaponframe = 2.000;

      }
      SuperDamageSound ();

      W_FireAssaultCannon ();

      if (classtype & 2.000) {

	   stuffcmd (self, "v_idlescale ");
	   if (self.heat < 5) {
	      st = ftos (self.heat * 4);
	   } else {
	      st = "20";
	   }
	   stuffcmd (self, st);
	   stuffcmd (self, "\n");
      }
   } else {

      sound (self,1.000,"weapons/asscan4.wav",1.000,1.000);

      if ( (self.weaponframe == 2.000) ) {

         self.weaponframe = 0.000;

      } else {

         self.weaponframe = 2.000;

      }

      if (classtype & 2.000)
	   stuffcmd (self, "v_idlescale 5\n");

   }
   if ( ((!self.button0 || (self.ammo_shells < 1.000)) || intermission_running) ) {

      self.tfstate = (self.tfstate - (self.tfstate & 2048.000));
      if (classtype & 2.000) {
	   self.tfstate = self.tfstate - (self.tfstate & 65536);
	   stuffcmd (self, "v_idlescale 0\n");
      }
	TeamFortress_SetSpeed (self);
      self.weaponframe = 0.000;
      self.count = 1.000;
      player_assaultcannondown1 ();
      return ;

   }
   Attack_Finished (0.100);

};

void () player_assaultcannon2 = [ 104.000, player_assaultcannon1 ] {

   if (classtype & 2.000) 
	   stuffcmd (self, "v_idlescale 0\n");
   if ( (!(classtype & 2.000) && (self.speed < 135.000)) || ((classtype & 2.000) && (self.speed < 20.000))  ) {

      if ( (self.weaponframe == 2.000) ) {

         self.weaponframe = 4.000;

      } else {

         self.weaponframe = 2.000;

      }
      SuperDamageSound ();
      W_FireAssaultCannon ();
      self.heat = (self.heat + 0.100);
      stuffcmd (self,"bf\n");

   } else {

      if ( (self.weaponframe == 2.000) ) {
         self.weaponframe = 0.000;
      } else {
         self.weaponframe = 2.000;
      }

   }
   if ( ((!self.button0 || (self.ammo_shells < 1.000)) || intermission_running) ) {

      self.tfstate = (self.tfstate - (self.tfstate & 2048.000));
      if (classtype & 2.000) {
	   self.tfstate = self.tfstate - (self.tfstate & 65536);
	   stuffcmd (self, "v_idlescale 0\n");
      }
      TeamFortress_SetSpeed (self);
      self.weaponframe = 0.000;
      self.count = 1.000;
      player_assaultcannondown1 ();
      return ;

   }
   Attack_Finished (0.100);

};

void () player_assaultcannondown1 = [ 103.000, player_assaultcannondown1 ] {

   //local entity tcool;


   if (self.flags & 512.000) {

      if ( (self.count == 1.000) ) {
 
         sound (self,1.000,"weapons/asscan3.wav",1.000,1.000);

      }
   

      if ( (self.count >= 15.000) ) {

         self.heat = 0.000;
         self.fire_held_down = 0.000;
         if (classtype & 2.000) 
	      self.tfstate = self.tfstate - (self.tfstate & 65536);
         self.tfstate = (self.tfstate - (self.tfstate & 2048.000));
         TeamFortress_SetSpeed (self);

         if ( ((self.ammo_shells < 1.000) || (self.ammo_cells < 7.000)) ) {

            self.last = self.current;
            self.current = W_BestWeapon ();
            W_SetCurrentAmmo ();
            W_PrintWeaponMessage ();
            return ;

         }
         player_run ();
         return ;

      }
      if ( ((((self.count != 8.000) && (self.count != 10.000)) && (self.count != 12.000)) && (self.count != 14.000)) ) {

         if ( (self.weaponframe == 3.000) ) {

            self.weaponframe = 0.000;

         } else {

            self.weaponframe = (self.weaponframe + 1.000);

         }

      }
      self.count = (self.count + 1.000);
      Attack_Finished (0.100);

   } else {

      if ( (self.count == 1.000) ) {
 
         sound (self,1.000,"weapons/asscan3.wav",1.000,1.000);

      }

         self.heat = 0.000;
         self.fire_held_down = 0.000;
         if (classtype & 2.000) 
	      self.tfstate = self.tfstate - (self.tfstate & 65536);
         self.tfstate = (self.tfstate - (self.tfstate & 2048.000));
         TeamFortress_SetSpeed (self);

         if ( ((self.ammo_shells < 1.000) || (self.ammo_cells < 7.000)) ) {

            self.last = self.current;
            self.current = W_BestWeapon ();
            W_SetCurrentAmmo ();
            W_PrintWeaponMessage ();
            return ;

         }
         player_run ();
         return ;
   }
};

void () player_light1 = [ 105.000, player_light2 ] {

   muzzleflash ();
   if ( (!self.button0 || intermission_running) ) {

      player_run ();
      return ;

   }
   self.weaponframe = (self.weaponframe + 1.000);
   if ( (self.weaponframe == 5.000) ) {

      self.weaponframe = 1.000;

   }
   SuperDamageSound ();
   W_FireLightning ();
   Attack_Finished (0.200);

};

void () player_light2 = [ 106.000, player_light1 ] {
//void () player_light2 = [ 106.000, player_run ] {

   if ( (!self.button0 || intermission_running) ) {

      player_run ();
      return ;

   }
   self.weaponframe = (self.weaponframe + 1.000);
   if ( (self.weaponframe == 5.000) ) {

      self.weaponframe = 1.000;

   }
   SuperDamageSound ();
   W_FireLightning ();
   Attack_Finished (0.200);

};

void () player_rocket1 = [ 107.000, player_rocket2 ] {

   self.weaponframe = 1.000;
   muzzleflash ();

};

void () player_rocket2 = [ 108.000, player_rocket3 ] {

   self.weaponframe = 2.000;

};

void () player_rocket3 = [ 109.000, player_rocket4 ] {

   self.weaponframe = 3.000;

};

void () player_rocket4 = [ 110.000, player_rocket5 ] {

   self.weaponframe = 4.000;

};

void () player_rocket5 = [ 111.000, player_rocket6 ] {

   self.weaponframe = 5.000;

};

void () player_rocket6 = [ 112.000, player_run ] {

   self.weaponframe = 6.000;

};

void (float num_bubbles) DeathBubbles;

void () PainSound = {

   local float rs;

   if ( (self.health < 0.000) ) {

      return ;

   }
   if ( (damage_attacker.classname == "teledeath") ) {

      sound (self,2.000,"player/teledth1.wav",1.000,0.000);
      return ;

   }
   if ( ((self.watertype == -3.000) && (self.waterlevel == 3.000)) ) {

      DeathBubbles (1.000);
      if ( (random () > 0.500) ) {

         sound (self,2.000,"player/drown1.wav",1.000,1.000);

      } else {

         sound (self,2.000,"player/drown2.wav",1.000,1.000);

      }
      return ;

   }
   if ( (self.watertype == -4.000) ) {

      if ( (random () > 0.500) ) {

         sound (self,2.000,"player/lburn1.wav",1.000,1.000);

      } else {

         sound (self,2.000,"player/lburn2.wav",1.000,1.000);

      }
      return ;

   }
   if ( (self.watertype == -5.000) ) {

      if ( (random () > 0.500) ) {

         sound (self,2.000,"player/lburn1.wav",1.000,1.000);

      } else {

         sound (self,2.000,"player/lburn2.wav",1.000,1.000);

      }
      return ;

   }
   if ( (self.pain_finished > time) ) {

      self.axhitme = 0.000;
      return ;

   }
   self.pain_finished = (time + 0.500);
   if ( (self.axhitme == 1.000) ) {

      self.axhitme = 0.000;
      sound (self,2.000,"player/axhit1.wav",1.000,1.000);
      return ;

   }
   rs = rint (((random () * 5.000) + 1.000));
   self.noise = "";
   if ( (rs == 1.000) ) {

      self.noise = "player/pain1.wav";

   } else {

      if ( (rs == 2.000) ) {

         self.noise = "player/pain2.wav";

      } else {

         if ( (rs == 3.000) ) {

            self.noise = "player/pain3.wav";

         } else {

            if ( (rs == 4.000) ) {

               self.noise = "player/pain4.wav";

            } else {

               if ( (rs == 5.000) ) {

                  self.noise = "player/pain5.wav";

               } else {

                  self.noise = "player/pain6.wav";

               }

            }

         }

      }

   }
   sound (self,2.000,self.noise,1.000,1.000);
   return ;

};

void () player_pain1 = [ 35.000, player_pain2 ] {

   PainSound ();
   self.weaponframe = 0.000;

};

void () player_pain2 = [ 36.000, player_pain3 ] {


};

void () player_pain3 = [ 37.000, player_pain4 ] {


};

void () player_pain4 = [ 38.000, player_pain5 ] {


};

void () player_pain5 = [ 39.000, player_pain6 ] {


};

void () player_pain6 = [ 40.000, player_run ] {


};

void () player_axpain1 = [ 29.000, player_axpain2 ] {

   PainSound ();
   self.weaponframe = 0.000;

};

void () player_axpain2 = [ 30.000, player_axpain3 ] {


};

void () player_axpain3 = [ 31.000, player_axpain4 ] {


};

void () player_axpain4 = [ 32.000, player_axpain5 ] {


};

void () player_axpain5 = [ 33.000, player_axpain6 ] {


};

void () player_axpain6 = [ 34.000, player_run ] {


};

void () player_pain = {

   if ( self.weaponframe ) {

      if ( (deathmsg == 37.000) ) {

         PainSound ();

      }
      return ;

   }
   if ( (self.invisible_finished > time) ) {

      return ;

   }
   if ( self.is_feigning ) {

      PainSound ();
      return ;

   }
   if ( (self.button0 && (self.current == WEAP_ASSAULT_CANNON)) ) {

      return ;

   }
   if ( (self.current <= WEAP_AXE) ) {

      player_axpain1 ();

   } else {

      player_pain1 ();

   }

};

void () player_diea1;

void () player_dieb1;

void () player_diec1;

void () player_died1;

void () player_diee1;

void () player_die_ax1;

void () DeathBubblesSpawn = {

   if ( (self.owner.waterlevel != 3.000) ) {
      dremove(self);
      return ;

   }
   newmis = spawn ();
   setmodel (newmis,"progs/s_bubble.spr");
   setorigin (newmis,(self.owner.origin + '0.000 0.000 24.000'));
   newmis.movetype = 8.000;
   newmis.solid = 0.000;
   newmis.velocity = '0.000 0.000 15.000';
   newmis.nextthink = (time + 0.500);
   newmis.think = bubble_bob;
   newmis.classname = "bubble";
   newmis.frame = 0.000;
   newmis.cnt = 0.000;
   setsize (newmis,'-8.000 -8.000 -8.000','8.000 8.000 8.000');
   self.nextthink = (time + 0.100);
   self.think = DeathBubblesSpawn;
   self.air_finished = (self.air_finished + 1.000);
   if ( (self.air_finished >= self.bubble_count) ) {

      dremove (self);

   }

};

void (float num_bubbles) DeathBubbles = {

   local entity bubble_spawner;

   bubble_spawner = spawn ();
   setorigin (bubble_spawner,self.origin);
   bubble_spawner.movetype = 0.000;
   bubble_spawner.solid = 0.000;
   bubble_spawner.nextthink = (time + 0.100);
   bubble_spawner.think = DeathBubblesSpawn;
   bubble_spawner.air_finished = 0.000;
   bubble_spawner.owner = self;
   bubble_spawner.bubble_count = num_bubbles;
   return ;

};

void () DeathSound = {

   local float rs;

   if ( (self.waterlevel == 3.000) ) {

      if ( self.is_feigning ) {

         DeathBubbles (2.000);

      } else {

         DeathBubbles (10.000);

      }
      sound (self,2.000,"player/h2odeath.wav",1.000,0.000);
      return ;

   }
   rs = rint (((random () * 4.000) + 1.000));
   if ( (rs == 1.000) ) {

      self.noise = "player/death1.wav";

   }
   if ( (rs == 2.000) ) {

      self.noise = "player/death2.wav";

   }
   if ( (rs == 3.000) ) {

      self.noise = "player/death3.wav";

   }
   if ( (rs == 4.000) ) {

      self.noise = "player/death4.wav";

   }
   if ( (rs == 5.000) ) {

      self.noise = "player/death5.wav";

   }
   sound (self,2.000,self.noise,1.000,0.000);
   return ;

};

void () PlayerDead = {

   self.nextthink = -1.000;
   self.deadflag = 2.000;

};
vector (float dm) VelocityForDamage = {

   local vector v;

   v_x = (100.000 * crandom ());
   v_y = (100.000 * crandom ());
   v_z = (200.000 + (100.000 * random ()));
   if ( (dm > -50.000) ) {

      v = (v * 0.700);

   } else {

      if ( (dm > -200.000) ) {

         v = (v * 2.000);

      } else {

         v = (v * 10.000);

      }

   }
   return ( v );

};


void (string gibname, float dm) ThrowGib = {

   newmis = spawn ();
   newmis.origin = self.origin;
   setmodel (newmis,gibname);
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   newmis.velocity = VelocityForDamage (dm);
   newmis.movetype = 10.000;
   newmis.solid = 0.000;
   newmis.avelocity_x = (random () * 600.000);
   newmis.avelocity_y = (random () * 600.000);
   newmis.avelocity_z = (random () * 600.000);
   newmis.think = SUB_Remove;
   newmis.ltime = time;
   newmis.nextthink = ((time + 10.000) + (random () * 10.000));
   newmis.frame = 0.000;
   newmis.flags = 0.000;

};

void (string gibname, float dm) ThrowHead = {

   setmodel (self,gibname);
   self.skin = 0.000;
   self.frame = 0.000;
   self.nextthink = -1.000;
   self.movetype = 10.000;
   self.takedamage = 0.000;
   self.solid = 0.000;
   self.view_ofs = '0.000 0.000 8.000';
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   self.velocity = VelocityForDamage (dm);
   self.origin_z = (self.origin_z - 24.000);
   self.flags = (self.flags - (self.flags & 512.000));
   self.avelocity = (crandom () * '0.000 600.000 0.000');

};

void (string gibname) HeadShotThrowHead = {

   setmodel (self,gibname);
   self.frame = 0.000;
   self.nextthink = -1.000;
   self.movetype = 10.000;
   self.takedamage = 0.000;
   self.solid = 0.000;
   self.view_ofs = '0.000 0.000 8.000';
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   self.velocity = (normalize (self.head_shot_vector) * 600.000);
   self.origin_z = (self.origin_z + 24.000);
   self.flags = (self.flags - (self.flags & 512.000));
   self.avelocity = '0.000 0.000 0.000';

};


void () KillPlayer = {

   self.owner.deadflag = 2.000;
   dremove (self);

};

#ifdef CSQC

float(entity ent) WriteGibs =
{
	WriteByte(MSG_ENTITY, CLASS_GIB);
	WriteByte(MSG_ENTITY, self.cnt);
	WriteByte(MSG_ENTITY, -self.health);
	WriteCoord(MSG_ENTITY, self.origin_x);
	WriteCoord(MSG_ENTITY, self.origin_y);
	WriteCoord(MSG_ENTITY, self.origin_z);
	return 1.000;
};

void(float type) ThrowCSQCGibs =
{
	self.cnt = type;
	self.Version = self.Version+1;
	self.SendEntity = WriteGibs;
	if (type != GIB_PLAYER)
	{	//schedule removal after a second.
		self.think = SUB_Remove;
		self.nextthink = time+1;
	}	

};

#endif

void () GibPlayer = {




   if (deathmsg == 29.000) 
      HeadShotThrowHead("progs/h_player.mdl");
   else
      ThrowHead ("progs/h_player.mdl",self.health);

   ThrowGib ("progs/gib1.mdl",self.health);
   ThrowGib ("progs/gib2.mdl",self.health);
   ThrowGib ("progs/gib3.mdl",self.health);

#ifdef CSQC

	ThrowCSQCGibs(0);

#endif

   if ( (deathmsg == 36.000) ) {

      newmis = spawn ();
      newmis.owner = self;
      newmis.think = KillPlayer;
      newmis.nextthink = (time + 1.000);

   } else {

      self.deadflag = 2.000;

   }
   TeamFortress_SetupRespawn ();
   if ( (damage_attacker.classname == "teledeath") ) {

      sound (self,2.000,"player/teledth1.wav",1.000,0.000);
      self.respawn_time = ((time + 2.000) + (random () * 2.000));
      return ;

   }
   if ( (damage_attacker.classname == "teledeath2") ) {

      sound (self,2.000,"player/teledth1.wav",1.000,0.000);
      self.respawn_time = ((time + 2.000) + (random () * 2.000));
      return ;

   }
   if ( (random () < 0.500) ) {

      sound (self,2.000,"player/gib.wav",1.000,0.000);

   } else {

      sound (self,2.000,"player/udeath.wav",1.000,0.000);

   }

};

void () DecrementQue;

void () PlayerDie = {

   local entity te;
   local float i;

   if ( self.hook_out ) {

      Reset_Grapple (self.hook);
      Attack_Finished (0.750);
      self.hook_out = 1.000;

   }

   if ( (self.heat && (self.current == WEAP_ASSAULT_CANNON)) ) {
      self.count = 0.000;
      sound (self,1.000,"weapons/asscan3.wav",1.000,1.000);
   }

   self.items = (self.items - (self.items & 524288.000));
   self.invisible_finished = 0.000;
   self.invincible_finished = 0.000;
   self.super_damage_finished = 0.000;
   self.radsuit_finished = 0.000;
   self.modelindex = modelindex_player;
   if ( ((self.tfstate & 16.000) && (self == self.enemy)) ) {

      te = find (world,classname,"timer");
      while ( te ) {

         if ( ((te.owner == self) && (te.think == BioInfection_Decay)) ) {

            logfrag (te.enemy,self);
            TF_AddFrags (te.enemy,1.000, 1.000);

         }
         te = find (te,classname,"timer");

      }

   }
   TeamFortress_RemoveTimers ();
   if ( (deathmatch || coop) ) {

      DropBackpack ();


      if(modetype & 4) {

         if (self.is_detpacking) {
            self.ammo_detpack = 1.000;
         }

         Drop_detpack();
      }

   }
   self.weaponmodel = "";
   self.view_ofs = '0.000 0.000 -8.000';
   self.deadflag = 1.000;
   self.solid = 0.000;
   self.flags = (self.flags - (self.flags & 512.000));
   self.movetype = 6.000;

   if(rounds) {

      self.respawn_time = time + 2.500;

      if (modetype & 32) {
         DecrementQue();
         self.a_n = TeamFortress_GetNoPlayers();

      } 
      
   } else {
      if (self.respawn_time < time) {
         self.respawn_time = time + respawn_delay_time;
      }
   }


   if (( !intermission_running )  && ( !cb_prematch )) {
      self.deaths = self.deaths + 1.000;
   }


   if ( (self.velocity_z < 10.000) ) {

      self.velocity_z = (self.velocity_z + (random () * 300.000));

   }

   if ( (self.health < -40.000) ) {

      if (infokey (world,"gibs") != "off" ) {

         GibPlayer ();
         return ;

      }
   }
   DeathSound ();
   self.angles_x = 0.000;
   self.angles_z = 0.000;

   if ( (self.current <= WEAP_AXE) ) {

      player_die_ax1 ();
      TeamFortress_SetupRespawn ();
      return ;

   }
   i = (1.000 + floor ((random () * 6.000)));
   if ( (i == 1.000) ) {

      player_diea1 ();

   } else {

      if ( (i == 2.000) ) {

         player_dieb1 ();

      } else {

         if ( (i == 3.000) ) {

            player_diec1 ();

         } else {

            if ( (i == 4.000) ) {

               player_died1 ();

            } else {

               player_diee1 ();

            }

         }

      }

   }
   TeamFortress_SetupRespawn ();
};

void () set_suicide_frame = {

   if ( (self.model != "progs/player.mdl") ) {

      return ;

   }
   setmodel (self,string_null);
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');

};

void () player_diea1 = [ 50.000, player_diea2 ] {};

void () player_diea2 = [ 51.000, player_diea3 ] {};

void () player_diea3 = [ 52.000, player_diea4 ] {};

void () player_diea4 = [ 53.000, player_diea5 ] {};

void () player_diea5 = [ 54.000, player_diea6 ] {};

void () player_diea6 = [ 55.000, player_diea7 ] {};

void () player_diea7 = [ 56.000, player_diea8 ] {};

void () player_diea8 = [ 57.000, player_diea9 ] {};

void () player_diea9 = [ 58.000, player_diea10 ] {};

void () player_diea10 = [ 59.000, player_diea11 ] {};

void () player_diea11 = [ 60.000, player_diea11 ] {
   PlayerDead ();
};

void () player_dieb1 = [ 61.000, player_dieb2 ] {};

void () player_dieb2 = [ 62.000, player_dieb3 ] {};

void () player_dieb3 = [ 63.000, player_dieb4 ] {};

void () player_dieb4 = [ 64.000, player_dieb5 ] {};

void () player_dieb5 = [ 65.000, player_dieb6 ] {};

void () player_dieb6 = [ 66.000, player_dieb7 ] {};

void () player_dieb7 = [ 67.000, player_dieb8 ] {};

void () player_dieb8 = [ 68.000, player_dieb9 ] {};

void () player_dieb9 = [ 69.000, player_dieb9 ] {
   PlayerDead ();
};

void () player_diec1 = [ 70.000, player_diec2 ] {};

void () player_diec2 = [ 71.000, player_diec3 ] {};

void () player_diec3 = [ 72.000, player_diec4 ] {};

void () player_diec4 = [ 73.000, player_diec5 ] {};

void () player_diec5 = [ 74.000, player_diec6 ] {};

void () player_diec6 = [ 75.000, player_diec7 ] {};

void () player_diec7 = [ 76.000, player_diec8 ] {};

void () player_diec8 = [ 77.000, player_diec9 ] {};

void () player_diec9 = [ 78.000, player_diec10 ] {};

void () player_diec10 = [ 79.000, player_diec11 ] {};

void () player_diec11 = [ 80.000, player_diec12 ] {};

void () player_diec12 = [ 81.000, player_diec13 ] {};

void () player_diec13 = [ 82.000, player_diec14 ] {};

void () player_diec14 = [ 83.000, player_diec15 ] {};

void () player_diec15 = [ 84.000, player_diec15 ] {
   PlayerDead ();
};

void () player_died1 = [ 85.000, player_died2 ] {};

void () player_died2 = [ 86.000, player_died3 ] {};

void () player_died3 = [ 87.000, player_died4 ] {};

void () player_died4 = [ 88.000, player_died5 ] {};

void () player_died5 = [ 89.000, player_died6 ] {};

void () player_died6 = [ 90.000, player_died7 ] {};

void () player_died7 = [ 91.000, player_died8 ] {};

void () player_died8 = [ 92.000, player_died9 ] {};

void () player_died9 = [ 93.000, player_died9 ] {
   PlayerDead ();
};

void () player_diee1 = [ 94.000, player_diee2 ] {};

void () player_diee2 = [ 95.000, player_diee3 ] {};

void () player_diee3 = [ 96.000, player_diee4 ] {};

void () player_diee4 = [ 97.000, player_diee5 ] {};

void () player_diee5 = [ 98.000, player_diee6 ] {};

void () player_diee6 = [ 99.000, player_diee7 ] {};

void () player_diee7 = [ 100.000, player_diee8 ] {};

void () player_diee8 = [ 101.000, player_diee9 ] {};

void () player_diee9 = [ 102.000, player_diee9 ] {
   PlayerDead ();
};

void () player_die_ax1 = [ 41.000, player_die_ax2 ] {};

void () player_die_ax2 = [ 42.000, player_die_ax3 ] {};

void () player_die_ax3 = [ 43.000, player_die_ax4 ] {};

void () player_die_ax4 = [ 44.000, player_die_ax5 ] {};

void () player_die_ax5 = [ 45.000, player_die_ax6 ] {};

void () player_die_ax6 = [ 46.000, player_die_ax7 ] {};

void () player_die_ax7 = [ 47.000, player_die_ax8 ] {};

void () player_die_ax8 = [ 48.000, player_die_ax9 ] {};

void () player_die_ax9 = [ 49.000, player_die_ax9 ] {
   PlayerDead ();
};

void () Headless_Think = {

   self.frame = (self.frame + 1.000);
   if ( ((self.frame == 7.000) || (self.frame == 18.000)) ) {

      self.nextthink = ((time + 10.000) + (random () * 10.000));
      self.think = SUB_Remove;
      return ;

   }
   self.nextthink = (time + 0.100);

};
