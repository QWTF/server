void () MsgAdminDis = {

    sprint(self,2,"Administrators disabled by server.\n");
};

void () ImpulseCommands = {

   local float imp;

   imp = self.impulse;

   if (self.last_impulse) {

   if ( imp ) {

         if ( ((self.last_impulse == 168.000) ) ) {

            TeamFortress_SetDetpack (imp);
            self.impulse = 0.000;
            return;
         }

         if (( self.last_impulse == 71.000 )) {

            StatusRes (imp);
            self.impulse = 0.000;
            return;
         }
      }
   }


   if ( (cb_prematch) || (cease_fire) || (round_over) ) {

      if (PreMatchImpulses() ) return;
      if (DeadImpulses() ) return;
      CommandImpulses();
      self.impulse = 0.000;
      return ;

   }


   if ( (imp == 171.000) ) {

      UseSpecialSkill ();
      return;
   }


   if ( ((imp == 9.000) && (self.current_menu != 6.000)) ) {

      self.current_menu = 6.000;
      self.menu_count = 25.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
      return;

   }


/*
 if (self.impulse == 13.000)  {

   if (!allow_crouch)   return;
   
   if (self.is_feigning) return;

   if (!self.crouch) {

      self.crouch = 1.000;
	setsize(self, VEC_HULL3_MIN, VEC_HULL3_MAX);
	self.maxspeed = self.maxspeed / 3;	
   }

 } else  if (self.impulse == 14.000) {

   if (!allow_crouch)   return;

    if (self.crouch) {

       pos = self.origin;
	 traceline(pos, pos, 0.000, self, VEC_HULL_MIN, VEC_HULL_MAX);
	 if (trace_allsolid)	//if player would be stuck
	 {
          self.crouch = 2.000;

          pos = self.origin+'0 0 18';	//can we move them up a little
	    traceline(pos, pos, 0.000, self, VEC_HULL_MIN, VEC_HULL_MAX);
	    if (trace_allsolid)
	    {
	       self.impulse = 0;

	       return;
          }
          self.origin = pos;
       }

       self.crouch = 0.000;
	 setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
       TeamFortress_SetSpeed (self);
 	 //self.maxspeed = self.maxspeed * 3;	
    }
 }
*/


   if ( (imp == 168.000) ) {

      self.last_impulse = imp;
      self.impulse = 0.000;
      return;
   }


   if ( (imp == 170.000) )
   {
      if (pipedelay)
      {

         if ( (time < self.attack_finished) )
         {
            return ;
         }
      }

      TeamFortress_DetonatePipebombs ();
      self.impulse = 0.000;
      return;

   }
   else  if ( (imp == 185.000) )
   {

      TeamFortress_ID ();
      self.impulse = 0.000;
      return;
   }
   else  if ( (imp == 135.000) )
   {

      TeamFortress_Inventory ();
      self.impulse = 0.000;
      return;
   }
   else  if ( ((self.playerclass) && (imp == 181.000)) ) {

      TeamFortress_SaveMe ();
      self.impulse = 0.000;
      return;
   }
   else if ( (imp == 23.000) )
   {
      if ( (ctfmap == 1) || (!server_type) ) {
         TeamFortress_CTF_FlagInfo ();
      } else {
        TeamFortress_DisplayDetectionItems ();
      }
      self.impulse = 0.000;
      return;
   }
   else if ( (imp == 118.000) )
   {
      display_location ();
      self.impulse = 0.000;
      return;
   }

   if ( ((!self.is_building && !self.is_detpacking) && !self.is_feigning) ) {

   if (holdlimit)
   {  
       if ( (time < self.attack_finished) )
       {
        
          self.impulse = 0.000;
          return ;

       }
    }

    if ( (((imp >= 1.000) && (imp < 9.000)) || (imp == 176.000)) ) {

         W_ChangeWeapon ();
         self.impulse = 0.000;
         return;

      } else {

         if ( (allow_hook && ((imp == 22.000) || (imp == 39.000))) ) {


            W_ChangeWeapon ();
            self.impulse = 0.000;
            return;

         } else {

            if ( (imp == 40.000) ) {

               W_ChangeWeapon ();
               self.impulse = 0.000;
               return;

            } else {

               if ( (imp == 10.000) ) {

                  NextWeaponCmd ();
                  self.impulse = 0.000;
                  return;

            } else {

               if ( (imp == 11.000) ) {

                  PrevWeaponCmd ();
                  self.impulse = 0.000;
                  return;

               } else {

                  if ( ((imp == 12.000) && (self.last != 0.000)) ) {

                     W_ChangeWeapon ();
                     self.impulse = 0.000;
                     return;
 
                  } else {

                     if ( (imp == 150.000) ||  (imp == 90.000))  {

                        TeamFortress_PrimeGrenade ();
                        self.impulse = 0.000;
                        return;

                     } else {

                        if ( (imp == 151.000) || (imp ==  91.000) ) {

                           TeamFortress_PrimeGrenade ();
                           self.impulse = 0.000;
                           return;
                        } else {

                           if ( (imp == 173.000) ) {


                              if ( (time < self.attack_finished) )
                              {

                                 return ;

                              }
                              TeamFortress_ReloadCurrentWeapon ();
                              self.impulse = 0.000;
                              return;

                           } else {

                              if ( (imp == 164.000) ) {


                                 TeamFortress_SetDetpack (5.000);
                                 self.impulse = 0.000;
                                 return;

                              } else {

                                 if ( (imp == 165.000) ) {

                                    TeamFortress_SetDetpack (20.000);
                                    self.impulse = 0.000;
                                    return;

                                 } else {

                                    if ( (imp == 166.000) ) {

                                       TeamFortress_SetDetpack (50.000);
                                       self.impulse = 0.000;
                                       return;

                                    } else {

                                       if ( (imp == 167.000) ) {

                                          TeamFortress_SetDetpack (255.000);
                                          self.impulse = 0.000;
                                          return;

                                       } else {

                                          if ( (imp == 172.000) ) {

                                             self.current_menu = 4.000;
                                             self.menu_count = (25.000);
                                             self.impulse = 0.000;
                                             return;
                                          } else {

                                             if ( (imp == 184.000) ) {

                                                TeamFortress_Discard ();
                                                self.impulse = 0.000;
                                                return;

                                             }

                                          }

                                       }

                                    }

                                 }

                              }

                           }

                        }

                     }

                  }

               }

            }

            }

         }

      }

   }

                              
               if ( (imp == 152.000) ) {

                  TeamFortress_ThrowGrenade ();
                  self.impulse = 0.000;
                  return;
               } else {

                  if ( ((self.playerclass) && (imp == 194.000)) ) {

                     DropGoalItems ();
                     self.impulse = 0.000;
                     return;
                  } else {

                     if ( (imp == 169.000) ) {

                        TeamFortress_DetpackStop ();
                        self.impulse = 0.000;
                        return;
                     } else {

                        if ( ((imp == 188.000) && (self.playerclass == 9.000)) ) {

                           DestroyBuilding (self,"building_sentrygun");
                           self.impulse = 0.000;
                           return;
                        } else {

                           if ( ((imp == 187.000) && (self.playerclass == 9.000)) ) {

                              DestroyBuilding (self,"building_dispenser");
                              self.impulse = 0.000;
                              return;
                           } else {

                              if ( ((imp == 177.000) && (self.playerclass == 8.000)) ) {

                                  TeamFortress_SpyGoUndercover ();
                                  self.impulse = 0.000;
                                  return;

                              } else {

                                 if ( ((imp == 178.000) && (self.playerclass == 8.000)) ) {

                                    TeamFortress_SpyFeignDeath (0.000);
                                    self.impulse = 0.000;
                                    return;
                                 } else {

                                    if ( ((imp == 199.000) && (self.playerclass == 8.000)) ) {

                                       TeamFortress_SpyFeignDeath (1.000);
                                       self.impulse = 0.000;
                                       return;
                                    } else {

                                       if ( ((imp == 179.000) && (self.playerclass == 9.000)) ) {

                                          TeamFortress_EngineerBuild ();
                                          self.impulse = 0.000;
                                          return;

                                       } else {

                                          if (DeadImpulses() ) return; 
                                          CommandImpulses();

                                       }

                                    }

                                 }

                              }

                           }

                        }

                     }

                  }

               }


   self.impulse = 0.000;

};



/*
void () MsgLimitedAcc = {

    sprint(self,2,"You have limited Access, You cannot use this command.\n");
};

float () AdminComVal3 = {

    if (self.is_admin != 3.000) {
       if (stof(infokey (world,"adminlevel")) < 3)
       {
          MsgLimitedAcc();
          return (0.000);
       }
    }
    return(1.000);
};

float () AdminComVal2 = {


    if (self.is_admin != 3.000) {
       if (stof(infokey (world,"adminlevel")) < 2)
       {
          MsgLimitedAcc();
          return (0.000);
       }
    }
    return(1.000);
};

float () AdminComVal = {

    if (self.is_admin != 3.000) {
       if(!stof(infokey(world, "adminlevel")))
       {
          MsgAdminDis();
          return (0.000);
       }
       if (CheckClanMode()) return(0.000);
    }
    return(1.000);
};
*/
void () CommandImpulses = {

   local float imp;

   imp = self.impulse;


   if (imp == 41.000)
   {

      Toggle_Tracking();
      self.impulse = 0.000;
      return ;
   }
   else if ( (imp == 95.000) ) {

      if (CheckClanMode()) return;

      self.current_menu = 2.000;
      self.menu_count = 25.000; 
      self.impulse = 0.000;
      return;
   }
   else if (imp == 112.000)
   {
      if (self.classname != "observer")
      {
         if (CheckClanMode()) return;
      }
      
      if (self.playerclass) return;

      if (self.tracking != 1.000) return;

       self.campan = 1.000;


      self.impulse = 0.000;
      return ;
   }
   else if (imp == 113.000)
   {

      if (self.classname != "observer")
      {
         if (CheckClanMode()) return;
      }

      if (self.playerclass) return;

      if (self.tracking != 1.000) return;

      self.campan = -1.000;


      self.impulse = 0.000;
      return ;
   }
   else if (imp == 114.000)
   {

      if (self.classname != "observer")
      {
         if (CheckClanMode()) return;
      }

      if (self.playerclass) return;

      if (self.tracking != 1.000) return;

      self.campan = 0;


      self.impulse = 0.000;
      return ;
   }
   else if (imp == 42.000)
   {
      if (self.classname != "observer")
      {
         if (CheckClanMode()) return;
      }
      if ((self.playerclass) || (self.deadflag)) return;


      Track_Player();

      self.last_impulse = imp;

      self.impulse = 0.000;
      return ;
   }
   else if (imp == 43.000)
   {
      if (self.classname != "observer")
      {
         if (CheckClanMode()) return;
      }

      if ((self.playerclass) || (self.deadflag)) return;


      Track_Tfgoal();

      self.last_impulse = imp;

      self.impulse = 0.000;
      return ;
   }
   else if (imp == 44.000)
   {
      if (self.classname != "observer")
      {
         if (CheckClanMode()) return;
      }
      if ((self.playerclass) || (self.deadflag)) return;

      Track_Sentry();
      if(!self.tracking) Toggle_Tracking();

      self.last_impulse = imp;

      self.impulse = 0.000;
      return ;

   }

   else if ( (imp == 86.000) )
   {

      if (self.classname != "observer")
      {
         if (CheckClanMode()) return;
      }

      if ((self.playerclass) || (self.deadflag)) return;

      Toggle_Autotrack();
      if(!self.tracking) Toggle_Tracking();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 180.000) 
   {

      Drop_detpack ();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 67.000) 
   {
      self.current_menu = 21.000;
      self.menu_count = 25.000;
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 68.000) 
   {
      self.current_menu = 22.000;
      self.menu_count = 25.000;
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 69.000) 
   {
      self.current_menu = 23.000;
      self.menu_count = 25.000;
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 70.000) 
   {
      self.current_menu = 24.000;
      self.menu_count = 25.000;
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 72.000) 
   {
      ShowFrags (self);
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 73.000) 
   {
      ShowFps ();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 74.000) 
   {
      ShowStats ();
      self.impulse = 0.000;
      return;
   }
   else if (imp == 115.000)
   {
      ShowSpeed ();
      self.impulse = 0.000;
      return;
   }
   else if (imp == 75.000) 
   {
      ShowTouches ();
      self.impulse = 0.000;
      return;
   }
   else if (imp == 76.000) 
   {
      ShowScores ();
      self.impulse = 0.000;
      return;
   }  
   else if (imp == 77.000) 
   {
      AgreeMiscVote ();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 83.000) 
   {
      VoteYes();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 84.000)
   {
      VoteNo();
      self.impulse = 0.000;
      return;
   }

   else if (imp == 85.000)
   {
      PlayerBreak();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 125.000)
   {
      stuffcmd(self,"menu_options\n");
      self.impulse = 0.000;
      return;
   }
   else if (imp == 126.000)
   {
      stuffcmd(self,"menu_view\n");
      self.impulse = 0.000;
      return;
   }
   else if (imp == 88.000)
   {

      Commands();
      self.impulse = 0.000;
      return;
                 
   } 
   else if (imp == 87.000)
   {

      ShowVersion ();
      self.impulse = 0.000;
      return;
                    
   }
   else if (imp == 89.000)
   {
      ModStatus(); 
      self.impulse = 0.000;
      return;
   }
   else if (imp == 255.000) 
   {
      if( (infokey(world, "*cheats")) == string_null)
      {
         sprint(self, 2, "Cheats are disabled on this server.\n");
         self.impulse = 0.000;
         return;
      }
      Give_Quad ();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 254.000) 
   {
      if( (infokey(world, "*cheats")) == string_null)
      {
         sprint(self, 2, "Cheats are disabled on this server.\n");
         self.impulse = 0.000;
         return;
      }
      Give_Eyes ();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 253.000) 
   {
      if( (infokey(world, "*cheats")) == string_null)
      {
         sprint(self, 2, "Cheats are disabled on this server.\n");
         self.impulse = 0.000;
         return;
      }
      Give_Pent ();
      self.impulse = 0.000;
      return;
   } 
   else if (imp == 82.000) 
   {

      if(!stof(infokey(world, "adminlevel")))
      {
         MsgAdminDis();
      } 
      else
      {
         VoteAdmin();
      }
      self.impulse = 0.000;
      return;
   } 

   self.impulse = 0.000;
   return;

   
};

float () PreMatchImpulses = {

   local float imp;

   imp = self.impulse;

   if ( ((imp == 9.000) && (self.current_menu != 6.000)) ) {

      self.current_menu = 6.000;
      self.menu_count = 25.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
      return(1.000);

   }

   

   if ( (((imp >= 1.000) && (imp < 9.000)) || (imp == 176.000)) ) {

      W_ChangeWeapon ();
      self.impulse = 0.000;
      return(1.000);

   } else {

      if ( (allow_hook && ((imp == 22.000) || (imp == 39.000))) ) {

         W_ChangeWeapon ();
         self.impulse = 0.000;
         return(1.000);

      } else {

         if ( (imp == 40.000) ) {

            W_ChangeWeapon ();
            self.impulse = 0.000;
            return(1.000);

         } else {

            if ( (imp == 10.000) ) {

               NextWeaponCmd ();
               self.impulse = 0.000;
               return(1.000);
            
            } else {

               if ( (imp == 11.000) ) {

                  PrevWeaponCmd ();
                  self.impulse = 0.000;
                  return(1.000);

               }

            }

         }

      }

   }
   if ( (imp == 135.000) ) {

      TeamFortress_Inventory ();
      self.impulse = 0.000;
      return(1.000);
   } else {

      if ( (imp == 185.000) ) {

         TeamFortress_ID ();
         self.impulse = 0.000;
         return(1.000);
      } else {

         if ( (imp == 23.000) ) {

            if ( (ctfmap == 1) ) {

               TeamFortress_CTF_FlagInfo ();

            } else {

               TeamFortress_DisplayDetectionItems ();

            }
            self.impulse = 0.000;
            return(1.000);
         } else {

            if ( (imp == 118.000) ) {

               display_location ();
               self.impulse = 0.000;
               return(1.000);
            }

         }

      }

   }

   return(0.000);
};

float () DeadImpulses = {
   local string st;
   local float imp;

   imp = self.impulse;

   if ( (imp == 136.000) ) {

      TeamFortress_ShowTF ();
      self.impulse = 0.000;
      return(1.000);

   } else {

      if ( (imp == 174.000) ) {

         TeamFortress_AutoZoomToggle ();
         self.impulse = 0.000;
         return(1.000);

      } else {

         if ( (imp == 137.000) ) {

            TeamFortress_DisplayLegalClasses ();
            self.impulse = 0.000;
            return(1.000);

         } else {

            if ( ((imp > 100.000) && (imp <= (100.000 + 11.000))) ) {

               TeamFortress_ChangeClass (imp - 100);
               self.impulse = 0.000;
               return(1.000);
               
            } else {

               if ( (((self.playerclass) && (imp == 99.000))  && (!cb_prematch)) ) {

                  self.current_menu = 20.000;
                  self.menu_count = 25.000;  
                  self.impulse = 0.000;
                  return(1.000);
                  
               } else {

                  if ( (imp == 71.000) ) {

                     self.last_impulse = imp;
                     return(1.000);
                 }
 
              }

            }

         }

      }

   }
   if ( (imp == 131.000) ) {

      TeamFortress_HelpMap ();
      self.impulse = 0.000;
      return(1.000);
   } else {

      if ( (imp == 119.000) ) {

         TeamFortress_StatusQuery ();
         self.impulse = 0.000;
         return(1.000);
         
      } else {

         if ( (imp == 140.000) ) {

      	if (CheckClanMode()) return(1.000);

            TeamFortress_TeamSet (1.000);
            self.impulse = 0.000;
            return(1.000);
            
         } else {

            if ( (imp == 141.000) ) {

      	   if (CheckClanMode()) return(1.000);
               TeamFortress_TeamSet (2.000);
               self.impulse = 0.000;
               return(1.000);
               
            } else {

               if ( (imp == 142.000) ) {

     			if (CheckClanMode()) return(1.000);
                  TeamFortress_TeamSet (3.000);
                  self.impulse = 0.000;
                  return(1.000);
                  
               } else {

                  if ( (imp == 143.000) ) {

			   if (CheckClanMode()) return(1.000);
                     TeamFortress_TeamSet (4.000);
                     self.impulse = 0.000;
                     return(1.000);
                  } else {

                     if ( (imp == 145.000) ) {

                        TeamFortress_TeamShowScores (0.000);
                        self.impulse = 0.000;
                        return(1.000);
                     } else {

                        if ( (imp == 144.000) ) {

                           TeamFortress_TeamShowMemberClasses (self);
                           self.impulse = 0.000;
                           return(1.000);
                        } else {

                           if ( ((self.playerclass == 1.000) && (imp == 159.000)) ) {

                              ScannerSwitch ();
                              self.impulse = 0.000;
                              return(1.000);
                           } else {

                              if ( ((self.playerclass == 1.000) && (imp == 162.000)) ) {

                                 sprint (self,2.000,"Scanner sound: ");
                                 
                                 if ( (self.tf_items_flags & 4.000) ) {

                                    self.tf_items_flags = (self.tf_items_flags - 4.000);
                                    sprint (self,2.000,"Off\n");

                                 } else {

                                    self.tf_items_flags = (self.tf_items_flags | 4.000);
                                    sprint (self,2.000,"On\n");

                                 }
                                 self.impulse = 0.000;
                                 return(1.000);

                              } else {

                                 if ( ((self.playerclass == 1.000) && (imp == 160.000)) ) {

                                    sprint (self,2.000,"Scanning for: ");
                                    if ( (self.tf_items_flags & 1.000) ) {

                                       self.tf_items_flags = (self.tf_items_flags - 1.000);
                                       if ( (self.tf_items_flags & 2.000) ) {

                                          sprint (self,2.000,"Friendlies Only.\n");

                                       } else {

                                          sprint (self,2.000,"Nothing\n");

                                       }

                                    } else {

                                       self.tf_items_flags = (self.tf_items_flags | 1.000);
                                       if ( (self.tf_items_flags & 2.000) ) {

                                          sprint (self,2.000,"Friendlies and Enemies\n");

                                       } else {

                                          sprint (self,2.000,"Enemies Only\n");

                                       }

                                    }
                                    self.impulse = 0.000;
                                    return(1.000);

                                 } else {

                                    if ( ((self.playerclass == 1.000) && (imp == 161.000)) ) {

                                       sprint (self,2.000,"Scanning for: ");
                                       if ( (self.tf_items_flags & 2.000) ) {

                                          self.tf_items_flags = (self.tf_items_flags - 2.000);
                                          if ( (self.tf_items_flags & 1.000) ) {

                                             sprint (self,2.000,"Enemies Only.\n");

                                          } else {

                                             sprint (self,2.000,"Nothing\n");

                                          }

                                       } else {

                                          self.tf_items_flags = (self.tf_items_flags | 2.000);
                                          if ( (self.tf_items_flags & 1.000) ) {

                                             sprint (self,2.000,"Friendlies and Enemies\n");

                                          } else {

                                             sprint (self,2.000,"Friendlies Only\n");

                                          }
                                  
                                       }
                                       self.impulse = 0.000;
                                       return(1.000);

                                    } else {

                                       if ( (imp == 182.000) ) {

                                          if (!server_type) 
                                          {
                                             sprint(self,2.000, "Server incompatible - Unable to activate status bar.\n");
                                             self.impulse = 0.000;
                                             return(1.000);
                                          }


                                          if (self.StatusBarSize) {
                                             self.impulse = 0.000;
                                             return(1.000);
                                          }

                                          st = infokey (self,"sbs");
                                          if ( (st == string_null) ) {

                                             st = infokey (self,"sbar_size");

                                          }

                                          self.StatusBarSize = stof (st);

                                          if ( ((self.StatusBarSize > 10.000) || (self.StatusBarSize < 1.000)) ) {

                                             self.StatusBarSize = 3.000;

                                          } 

							StatusBar_On();
                                          self.impulse = 0.000;
                                          return(1.000);

                                       } else {

                                          if ( (imp == 183.000) ) {

                                             if (!self.StatusBarSize) {
                                                self.impulse = 0.000;
                                                return(1.000);
                                             }
                                             self.StatusBarSize = 0.000;
							   StatusBar_On();
                                             self.impulse = 0.000;
                                             return(1.000);

                                          }

                                       }

                                    }

                                 }

                              }

                           }

                        }

                     }

                  }

               }

            }

         }

      }

   }

   return(0.000);
};

