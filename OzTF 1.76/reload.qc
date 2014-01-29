
void (float att_delay) Attack_Finished = {

   if ( (self.tfstate & 32768.000) ) {

      self.attack_finished = (time + (att_delay * 2.000));

   } else {

      self.attack_finished = (time + att_delay);

   }

};


void () W_Reload_shotgun_fin = {

   self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 2.000));
   self.owner.weaponmodel = "progs/v_shot.mdl";
   if (self.voided)
   {
      sprint (self.owner,2.000,"reloading canceled\n");
   }
   else
   {
      sprint (self.owner,2.000,"finished reloading\n");
   }
   dremove (self);
   self.owner.StatusRefreshTime = (time + 0.100);

};

void () W_Reload_super_shotgun_fin = {

   self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 2.000));
   self.owner.weaponmodel = "progs/v_shot2.mdl";
   if (self.voided)
   {
      sprint (self.owner,2.000,"reloading canceled\n");
   }
   else
   {
      sprint (self.owner,2.000,"finished reloading\n");
   }
   dremove (self);
   self.owner.StatusRefreshTime = (time + 0.100);

};

void () W_Reload_grenade_launcher_fin = {

   self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 2.000));
   self.owner.weaponmodel = "progs/v_rock.mdl";
   if (self.voided)
   {
      sprint (self.owner,2.000,"reloading canceled\n");
   }
   else
   {
      sprint (self.owner,2.000,"finished reloading\n");
   }
   //sound (self.owner,0.000,"weapons/gl_draw.wav",1.000,1.000);
   dremove (self);
   self.owner.StatusRefreshTime = (time + 0.100);

};

void () W_Reload_rocket_launcher_fin = {

   self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 2.000));
   self.owner.weaponmodel = "progs/v_rock2.mdl";
   if (self.voided)
   {
      sprint (self.owner,2.000,"reloading canceled\n");
   }
   else
   {
      sprint (self.owner,2.000,"finished reloading\n");
   }
   //sound (self.owner,0.000,"weapons/rl_draw.wav",1.000,1.000);
   dremove (self);
   self.owner.StatusRefreshTime = (time + 0.100);

};


void () Cancel_reload = {


  if (self.owner.current == WEAP_SHOTGUN) {
     self.think = W_Reload_shotgun_fin;
     if (reload_sound)  sound (self.owner,0.000,"weapons/sg_draw.wav",1.000,1.000);
  } 
  else  if (self.owner.current == WEAP_SUPER_SHOTGUN) {
     self.think = W_Reload_super_shotgun_fin;
     if (reload_sound)  sound (self.owner,0.000,"weapons/sg_draw.wav",1.000,1.000);
  } 
  else  if ((self.owner.current == WEAP_GRENADE_LAUNCHER) || (self.owner.current == WEAP_PIPEBOMB_LAUNCHER)){
     self.think = W_Reload_grenade_launcher_fin;
     if (reload_sound)  sound (self.owner,0.000,"weapons/gl_draw.wav",1.000,1.000);
  } 
  else  if (self.owner.current == WEAP_ROCKET_LAUNCHER) {
     self.think = W_Reload_rocket_launcher_fin;
     if (reload_sound)  sound (self.owner,0.000,"weapons/rl_draw.wav",1.000,1.000);
  } 


     self.nextthink = self.pausetime;
 };

void () W_Reload_shotgun = {

   if (self.owner.reload_shotgun) {

      self.owner.reload_shotgun = self.owner.reload_shotgun - 1.000;
	self.think = W_Reload_shotgun;
	self.nextthink = (time + 0.5);
      if (reload_sound)  stuffcmd(self.owner, "play weapons/sg_reload.wav\n");
     // sound (self.owner,1.000,"weapons/sg_reload.wav",1.000,1.000);
      if (!self.owner.reload_shotgun)
         //sound (self.owner,1.000,"weapons/sg_reload.wav",1.000,1.000);
         if (reload_sound)  sound (self.owner,0.000,"weapons/sg_draw.wav",1.000,1.000);

   } else {

      W_Reload_shotgun_fin();
   }
};

void () W_Reload_super_shotgun = {

   if (self.owner.reload_super_shotgun >= 2) {

      self.owner.reload_super_shotgun = self.owner.reload_super_shotgun - 2.000;
	self.think = W_Reload_super_shotgun;
	self.nextthink = (time + 0.7);
      if (reload_sound)  stuffcmd(self.owner, "play weapons/sg_reload.wav\n");
     // sound (self.owner,1.000,"weapons/sg_reload.wav",1.000,1.000);

      if (!self.owner.reload_super_shotgun )
         if (reload_sound)  sound (self.owner,0.000,"weapons/sg_draw.wav",1.000,1.000);

   } else {

      W_Reload_super_shotgun_fin();
   }

};

void () W_Reload_grenade_launcher = {

   if (self.owner.reload_grenade_launcher) {

      self.owner.reload_grenade_launcher = self.owner.reload_grenade_launcher - 1.000;
	self.think = W_Reload_grenade_launcher;
	self.nextthink = (time + 0.6);
      //sound (self.owner,1.000,"weapons/sg_reload.wav",1.000,1.000);
      if (!self.owner.reload_grenade_launcher)
         if (reload_sound)  sound (self.owner,0.000,"weapons/gl_draw.wav",1.000,1.000);
   } else {

      W_Reload_grenade_launcher_fin();
   }

};

void () W_Reload_rocket_launcher = {

   if (self.owner.reload_rocket_launcher) {

      self.owner.reload_rocket_launcher = self.owner.reload_rocket_launcher - 1.000;
	self.think = W_Reload_rocket_launcher;
	self.nextthink = (time + 0.8);
      //sound (self.owner,1.000,"weapons/sg_reload.wav",1.000,1.000);
      if (!self.owner.reload_rocket_launcher)
         if (reload_sound)  sound (self.owner,0.000,"weapons/rl_draw.wav",1.000,1.000);

   } else {

      W_Reload_rocket_launcher_fin();
   }

};
float () CheckForReload = {

   local entity tWeapon;

//   if (practice) return (0.000);
 
   if ( (self.playerclass != 11.000) ) {

      if ( (self.current == WEAP_SHOTGUN) ) {

         if ( ((self.reload_shotgun >= 8.000) && (self.ammo_shells > 0.000)) ) {


            if ( (self.ammo_shells < 8.000) ) {

               self.reload_shotgun = self.ammo_shells;

            }
            sprint (self,2.000,"reloading... \n");
            self.tfstate = (self.tfstate | 2.000);
            tWeapon = spawn ();
            tWeapon.owner = self;
            tWeapon.classname = "timer";
            tWeapon.weaponmode = 1.000;
            tWeapon.think = W_Reload_shotgun;
            tWeapon.nextthink = (time + 0.400);
            self.weaponmodel = "";
            self.weaponframe = 0.000;
      if (self.StatusBarSize) 
 	     self.StatusRefreshTime = (time + 0.100);
            return ( 1.000 );

         }

      } else {

         if ( (self.current == WEAP_SUPER_SHOTGUN) ) {

            if ( (self.reload_super_shotgun > 16.000) ) {

               self.reload_super_shotgun = 16.000;

            }
            if ( ((self.reload_super_shotgun >= 16.000) && (self.ammo_shells > 0.000)) ) {

               if ( (self.ammo_shells < 16.000) ) {

                  self.reload_super_shotgun = self.ammo_shells;
               }

               sprint (self,2.000,"reloading... \n");
               self.tfstate = (self.tfstate | 2.000);
               tWeapon = spawn ();
               tWeapon.owner = self;
               tWeapon.classname = "timer";
               tWeapon.weaponmode = 1.000;
               tWeapon.nextthink = (time + 0.700);
               tWeapon.think = W_Reload_super_shotgun;
               self.weaponmodel = "";
               self.weaponframe = 0.000;
      if (self.StatusBarSize) 
 	     self.StatusRefreshTime = (time + 0.100);
               return ( 1.000 );

            }

         } else {

            if ( (self.current == WEAP_GRENADE_LAUNCHER) || (self.current == WEAP_PIPEBOMB_LAUNCHER) ) {

               if ( ((self.reload_grenade_launcher >= 6.000) && (self.ammo_rockets > 0.000)) ) {

                  if ( (self.ammo_rockets < 6.000) ) {

                     self.reload_grenade_launcher =  self.ammo_rockets;

                  }
                  sprint (self,2.000,"reloading...\n");
                  self.tfstate = (self.tfstate | 2.000);
                  tWeapon = spawn ();
                  tWeapon.owner = self;
                  tWeapon.classname = "timer";
                  tWeapon.weaponmode = 1.000;
                  tWeapon.nextthink = (time + 0.600);
                  tWeapon.think = W_Reload_grenade_launcher;
                  self.weaponmodel = "";
                  self.weaponframe = 0.000;
      if (self.StatusBarSize) 
 	     self.StatusRefreshTime = (time + 0.100);
                  return ( 1.000 );

               }

            } else {

               if ( (self.current == WEAP_ROCKET_LAUNCHER) ) {

                  if ( ((self.reload_rocket_launcher >= 4.000) && (self.ammo_rockets > 0.000)) ) {

                     if ( (self.ammo_rockets < 4.000) ) {

                        self.reload_rocket_launcher =  self.ammo_rockets;

                     }
                     sprint (self,2.000,"reloading... \n");
                     self.tfstate = (self.tfstate | 2.000);
                     tWeapon = spawn ();
                     tWeapon.owner = self;
                     tWeapon.classname = "timer";
                     tWeapon.weaponmode = 1.000;
                     tWeapon.nextthink = (time + 0.800);
                     tWeapon.think = W_Reload_rocket_launcher;
                     self.weaponmodel = "";
                     self.weaponframe = 0.000;
      if (self.StatusBarSize) 
 	     self.StatusRefreshTime = (time + 0.100);
                     return ( 1.000 );

			}

               }

            }

         }

      }

   }
   return ( 0.000 );

};


void () TeamFortress_ReloadCurrentWeapon = {

   local entity tWeapon;

   if ( (self.tfstate & 2.000) )  return ;


   if ( (self.playerclass == 11.000) ) return;
   

   if (modetype & 2) return;

   if ( (self.current == WEAP_SHOTGUN) ) {

      if ( (self.ammo_shells == 0.000) ) {

         sprint (self,2.000,"out of shells.\n");
         return ;

      }
      if ( (self.reload_shotgun == 0.000) ) {

         sprint (self,2.000,"clip full.\n");
         return ;

      }
      if ( ((8.000 - self.reload_shotgun) == self.ammo_shells) ) {

         sprint (self,2.000,"all shells are in the clip.\n");
         return ;

      }


      if ( ((8.000 - self.reload_shotgun) < self.ammo_shells) ) {

         Attack_Finished (0.400);

         sprint (self,2.000,"reloading... \n");
         self.tfstate = (self.tfstate | 2.000);
         tWeapon = spawn ();
         tWeapon.owner = self;
         tWeapon.classname = "timer";
         tWeapon.weaponmode = 1.000;
         tWeapon.think = W_Reload_shotgun;
         tWeapon.nextthink = (time + 0.400);

         self.weaponmodel = "";
         self.weaponframe = 0.000;

      } else {

         sprint (self,2.000,"not enough ammo to reload\n");

      }

   } else {

      if ( (self.current == WEAP_SUPER_SHOTGUN) ) {

         if ( (self.ammo_shells == 0.000) ) {

            sprint (self,2.000,"out of shells.\n");
            return ;

         }
         if ( (self.reload_super_shotgun == 0.000) ) {

            sprint (self,2.000,"clip full.\n");
            return ;

         }
         if ( ((16.000 - self.reload_super_shotgun) == self.ammo_shells) ) {

            sprint (self,2.000,"all shells are in the clip.\n");
            return ;

         }

         if ( (16.000 - self.reload_super_shotgun < self.ammo_shells) ) {

            Attack_Finished (0.700);

            sprint (self,2.000,"reloading...\n");
            self.tfstate = (self.tfstate | 2.000);
            tWeapon = spawn ();
            tWeapon.owner = self;
            tWeapon.classname = "timer";
            tWeapon.weaponmode = 1.000;
            tWeapon.nextthink = (time + 0.700);
            tWeapon.think = W_Reload_super_shotgun;
            self.weaponmodel = "";
            self.weaponframe = 0.000;

         } else {

            sprint (self,2.000,"not enough ammo to reload\n");

         }


      } else {

         if ( (self.current == WEAP_GRENADE_LAUNCHER) || (self.current == WEAP_PIPEBOMB_LAUNCHER) ) {

            if ( (self.ammo_rockets == 0.000) ) {

               sprint (self,2.000,"out of grenades.\n");
               return ;

            }
            if ( (self.reload_grenade_launcher == 0.000) ) {

               sprint (self,2.000,"clip full.\n");
               return ;

            }
            if ( ((6.000 - self.reload_grenade_launcher) == self.ammo_rockets) ) {

               sprint (self,2.000,"all grenades are in the clip.\n");
               return ;

            }
            if ( ((6.000 - self.reload_grenade_launcher) < self.ammo_rockets) ) {

               Attack_Finished (0.600);

               sprint (self,2.000,"reloading...\n");
               self.tfstate = (self.tfstate | 2.000);
               tWeapon = spawn ();
               tWeapon.owner = self;
               tWeapon.classname = "timer";
               tWeapon.weaponmode = 1.000;
               tWeapon.nextthink = (time + 0.600);
               tWeapon.think = W_Reload_grenade_launcher;
               self.weaponmodel = "";
               self.weaponframe = 0.000;

            } else {

               sprint (self,2.000,"not enough ammo to reload\n");

            }

         } else {

            if ( (self.current == WEAP_ROCKET_LAUNCHER) ) {

               if ( (self.ammo_rockets == 0.000) ) {

                  sprint (self,2.000,"out of rockets.\n");
                  return ;

               }
               if ( (self.reload_rocket_launcher == 0.000) ) {

                  sprint (self,2.000,"clip full.\n");
                  return ;

               }
               if ( ((4.000 - self.reload_rocket_launcher) == self.ammo_rockets) ) {

                  sprint (self,2.000,"all rockets are in the clip.\n");
                  return ;

               }
               if ( ((4.000 - self.reload_rocket_launcher) < self.ammo_rockets) ) {

                  Attack_Finished (0.800);

                  sprint (self,2.000,"reloading...\n");
                  self.tfstate = (self.tfstate | 2.000);
                  tWeapon = spawn ();
                  tWeapon.owner = self;
                  tWeapon.classname = "timer";
                  tWeapon.weaponmode = 1.000;
                  tWeapon.nextthink = (time + 0.800);
                  tWeapon.think = W_Reload_rocket_launcher;
                  self.weaponmodel = "";
                  self.weaponframe = 0.000;

               } else {

                  sprint (self,2.000,"not enough ammo to reload\n");

               }

            }

         }

      }

   }

};


