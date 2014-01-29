
void (float class) TeamFortress_SpyChangeSkin;

void (float teamno) TeamFortress_SpyChangeColor;

void (float issilent) TeamFortress_SpyFeignDeath;

void (entity spy) Spy_RemoveDisguise;

void (entity eng, string bld) DestroyBuilding;

void (float objtobuild) TeamFortress_Build;

void () lvl2_sentry_stand;

void () lvl3_sentry_stand;

void () lvl2_oldsentry_stand;

void () lvl3_oldsentry_stand;

float (float tno) TeamFortress_TeamSet;

float () TeamFortress_TeamPutPlayerInTeam;
float (float tno) TeamFortress_TeamIsCivilian;
//float (float tno) TeamFortress_TeamGetNoPlayers;
float () TeamFortress_GetNoPlayers;

void (float inp) TeamFortress_ChangeClass;

void (entity p) TeamFortress_SetSkin;

void (float type, float ammo) TeamFortress_DropAmmo;

void (entity targ, entity inflictor, entity attacker, float damage, float T_flags, float T_AttackType) TF_T_Damage;

void () W_SetCurrentAmmo;

void (entity p) bound_other_ammo;
float (float v) anglemod;

void (float tno, entity ignore, string st) teamsprint;

void (float menu_no) DisplayMenu;

void () Menu_Team;

void () Menu_Class;

void () Menu_Drop;

void () Menu_Intro;

void () Menu_ClassHelp;

void () Menu_ClassHelp2;

void () Menu_StuffClassHelp;

void (float inp) Menu_ClassHelp_Input;

void () Menu_RepeatHelp;

void () Menu_Speech;

void () Menu_Speech_Defensive;
void () Menu_Speech_Offensive;
void () Menu_Speech_General;

void (float inp) Menu_Speech_Input;

void (float inp) Menu_Speech_Def_Input;
void (float inp) Menu_Speech_Off_Input;
void (float inp) Menu_Speech_Gen_Input;

void () Menu_Upgrades;

void () Menu_Upgrade_Weapons;
void () Menu_Upgrade_Armor;
void () Menu_Upgrade_Movement;
void () Menu_Upgrade_Other;

void (float inp) Menu_Upgrades_Input;

void (float inp) Menu_Upgrade_Wea_Input;
void (float inp) Menu_Upgrade_Arm_Input;
void (float inp) Menu_Upgrade_Mov_Input;
void (float inp) Menu_Upgrade_Oth_Input;

void () Menu_Spy;

void () Menu_Spy_Skin;

void () Menu_Spy_Color;

void (float inp) Menu_Spy_Input;

void (float inp) Menu_Spy_Skin_Input;

void (float inp) Menu_Spy_Color_Input;

void () Menu_Engineer;

void () Menu_EngineerFix_Dispenser;

void () Menu_EngineerFix_SentryGun;

void (float inp) Menu_Engineer_Input;

void (float inp) Menu_EngineerFix_Dispenser_Input;

void (float inp) Menu_EngineerFix_SentryGun_Input;

void () Menu_Dispenser;

void (float inp) Menu_Dispenser_Input;

void (entity pl, string s1) CenterPrint;

void (entity pl, string s1, string s2) CenterPrint2;

void () ResetMenu = {

   if ( (self.StatusBarSize == 0.000) ) {

      CenterPrint (self,"\n");

   } else {

      self.StatusRefreshTime = (time + 0.100);

   }
   self.menu_count = 25.000;
   self.current_menu = 1.000;

};

void () Player_Menu = {

   if ( (self.menu_count > 25.000) ) {

      self.menu_count = 0.000;

   } else {

      self.menu_count = (self.menu_count + 1.000);
      return ;

   }

   if ( (self.current_menu == 5.000) ) {

      Menu_Intro ();
      if ( (self.menu_displaytime > 6.000) ) {

         self.current_menu = 1.000;

      } else {

         self.menu_displaytime = (self.menu_displaytime + 1.000);

      }

   } else {

      if ( (self.current_menu == 6.000) ) {

         Menu_ClassHelp ();

         if ( (self.menu_displaytime > 8.000) ) {

            Menu_StuffClassHelp ();
            self.current_menu = 1.000;

         } else {

            self.menu_displaytime = (self.menu_displaytime + 1.000);

         }

      } else {

         if ( (self.current_menu == 7.000) ) {

            Menu_ClassHelp2 ();
            if ( (self.menu_displaytime > 5.000) ) {

               Menu_StuffClassHelp ();
               self.current_menu = 1.000;

            } else {

               self.menu_displaytime = (self.menu_displaytime + 1.000);

            }

         } else {

            if ( (self.current_menu == 4.000) ) {

               Menu_Drop ();

            } else {

               if ( (self.current_menu == 12.000) ) {

                  Menu_Spy ();

               } else {

                  if ( (self.current_menu == 13.000) ) {

                     Menu_Spy_Skin ();

                  } else {

                     if ( (self.current_menu == 14.000) ) {

                        Menu_Spy_Color ();

                     } else {

                        if ( (self.current_menu == 15.000) ) {

                           Menu_Engineer ();

                        } else {

                           if ( (self.current_menu == 16.000) ) {

                              Menu_EngineerFix_Dispenser ();

                           } else {

                              if ( (self.current_menu == 17.000) ) {

                                 Menu_EngineerFix_SentryGun ();

                              } else {

                                 if ( (self.current_menu == 19.000) ) {

                                    Menu_Dispenser ();


                                 } else {

                                    if ( (self.current_menu == 8.000) ) {

                                       Menu_RepeatHelp ();
                                       self.current_menu = 1.000;

                                    } else {

                                      if ( (self.current_menu == 20.000) ) {

                                         Menu_Class ();

                                      } else {

                                         if ( (self.current_menu == 2.000) ) {

                                            Menu_Team ();

                                         } else {


                                            if ( ((self.pteam == world) && teamplay) ) {

                                               if (round_over >= 2) {
                                                  return;
                                               }

                                               self.current_menu = 2.000;
                                               Menu_Team ();

                                            } else {

                                               if ((self.playerclass == 0.000) && (self.pteam != store_obs)) { 

                                                  if (round_active && !modetype & 64) {
                                                     return;
                                                  }
                                                  if ( TeamFortress_TeamIsCivilian (self.pteam.team) ) {
                                                  
                                                      PutClientInServer();
                                                      return;
                                                  }

                                                  self.current_menu = 3.000;
                                                  Menu_Class ();

                                               } else {

                                                  if ( (self.current_menu == 21.000) ) {

                                                     Menu_Speech ();

                                                  } else {

                                                     if ( (self.current_menu == 22.000) ) {

                                                        Menu_Speech_Defensive ();

                                                     } else {

                                                        if ( (self.current_menu == 23.000) ) {

                                                           Menu_Speech_Offensive ();

                                                        } else {

                                                           if ( (self.current_menu == 24.000) ) {

                                                              Menu_Speech_General ();

                                                           } else {
                                                        

                                                              if ( (self.current_menu == 25.000) ) {

                                                                 Menu_Upgrades ();

                                                              } else {

                                                                 if ( (self.current_menu == 26.000) ) {

                                                                    Menu_Upgrade_Weapons ();

                                                                 } else {

                                                                    if ( (self.current_menu == 27.000) ) {

                                                                       Menu_Upgrade_Armor ();

                                                                    } else {

                                                                       if ( (self.current_menu == 28.000) ) {

                                                                          Menu_Upgrade_Movement ();

                                                                       } else {

                                                                          if ( (self.current_menu == 29.000) ) {

                                                                             Menu_Upgrade_Other ();

                                                                          } else {

                                                                             self.current_menu = 0.000;

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

                           }

                        }

                     }

                  }

               }

            }

         }

      }

   }

};

void (float menu_no) DisplayMenu = {

   self.current_menu = menu_no;
   if ( (menu_no == 2.000) ) {

      Menu_Team ();

   } else {

      if ( (menu_no == 3.000) ) {


         Menu_Class ();

      }

   }

};

void () Menu_Team = {

   if ( ((toggleflags & 64.000) && teamplay) ) {

      if ( TeamFortress_TeamPutPlayerInTeam () ) {

         ResetMenu ();
         return ;

      }

   }


   //stuffcmd(self,"menu_team\n");


   if ( (team_menu_string != string_null) ) {

      CenterPrint (self,team_menu_string);
      return ;

   }
   if ( (ctfmap == 1) ) {

      CenterPrint (self,"žžž Choose Your Team žžž\n\n“‘ Blue Team  \n”‘ Red Team   \n\n\n");

   } else {


      if ( (store_obs.cnt == 2.000) ) {

         if (modetype & 4) {
            CenterPrint (self,"žžž Choose Your Team žžž\n\n“‘ Counter Terrorists \n”‘ Terrorists         \n\n\n—‘ Auto Team          \n˜‘ Observe            ");
         } else {
            CenterPrint (self,"žžž Choose Your Team žžž\n\n“‘ Team One  \n”‘ Team Two  \n\n\n—‘ Auto Team \n˜‘ Observe   ");
         }

      } else {
         if (modetype & 1)
         {
            CenterPrint (self,"žžž Choose Your Team žžž\n\n“‘ Team One  \n”‘ Team Two  \n•‘ Team Three\n–‘ Team Four \n—‘ Auto Team \n˜‘ Observe T1\n™‘  Observe T2\nš‘ Observe T3\n›‘ Observe T4\n");
         }
         else
         {
            CenterPrint (self,"žžž Choose Your Team žžž\n\n“‘ Team One  \n”‘ Team Two  \n•‘ Team Three\n–‘ Team Four \n—‘ Auto Team \n˜‘ Observe   \n");
         }

      }

   }


};

void (float inp) Menu_Team_Input = {

      if ((inp  > 5.000) && (inp < 10.000))
      {
         if (inp <= 5 + store_obs.cnt) 
         {

            if (modetype & 1) {
               TeamFortress_TeamSet ((inp * -1.000) + 5.000);
               self.current_menu = 0.000;
               Menu_StuffClassHelp();
               Menu_ClassHelp();
               self.impulse = 0.000;
   		   //stuffcmd(self,"reset menu_team\n");

               return;
            }

            TeamFortress_TeamSet (-5.000);
            self.current_menu = 0.000;
            Menu_StuffClassHelp();
            Menu_ClassHelp();
            self.impulse = 0.000;
   		//stuffcmd(self,"reset menu_team\n");
            return;
         }
      
   } else if ( (inp == 5.000) ) {

      TeamFortress_TeamPutPlayerInTeam ();

   } else {

      if ( ((inp <= store_obs.cnt) && (inp > 0.000)) ) {

         TeamFortress_TeamSet (inp);

      } else {

         if ( ((store_obs.cnt == 0.000) && (inp <= 4.000)) ) {

            TeamFortress_TeamSet (inp);

         }

      }

   }

   //stuffcmd(self,"reset menu_team\n");


   ResetMenu ();
   self.impulse = 0.000;

};

void () Menu_Class = {

   local entity AD;



   //stuffcmd(self,"menu_class\n");


   AD = find (world,classname,"info_tfdetect");
   if ( AD ) {

      if ( (self.pteam.team == 1.000) ) {

         if ( (AD.noise1 != string_null) ) {

            CenterPrint (self,AD.noise1);
            return ;

         }

      } else {

         if ( (self.pteam.team == 2.000) ) {

            if ( (AD.noise2 != string_null) ) {

               CenterPrint (self,AD.noise2);
               return ;

            }

         } else {

            if ( (self.pteam.team  == 3.000) ) {

               if ( (AD.noise3 != string_null) ) {

                  CenterPrint (self,AD.noise3);
                  return ;

               }

            } else {

               if ( (self.pteam.team  == 4.000) ) {

                  if ( (AD.noise4 != string_null) ) {

                     CenterPrint (self,AD.noise4);
                     return ;

                  }

               }

            }

         }

      }

   }
   if ( TeamFortress_TeamIsCivilian (self.pteam.team ) ) {

      if (( classtype & 64 )) {

         CenterPrint (self,"Your team can only be Quake Soldiers.\n");

      } else {

         CenterPrint (self,"Your team can only be Civilians.\n");
	}

   } else {

      if (classtype & 1.000) {
         CenterPrint (self,"žžž Choose Your Class žžž\n\n“‘ Scout     \n”‘ Technician\n•‘ Soldier   \n–‘ Demoman   \n—‘ Medic     \n˜‘ HWGuy     \n™‘ Pyro      \nš‘ Spy       \n›‘ Engineer  \n’‘ RandomPC  \n");
      } else {
         CenterPrint (self,"žžž Choose Your Class žžž\n\n“‘ Scout   \n”‘ Sniper  \n•‘ Soldier \n–‘ Demoman \n—‘ Medic   \n˜‘ HWGuy   \n™‘ Pyro    \nš‘ Spy     \n›‘ Engineer\n’‘ RandomPC\n");
      }

   }



};

void (float inp) Menu_Class_Input = {

   local float new_class;
   local string st;

   if ( ((inp > 11.000) || (inp < 1.000)) ) {

      return ;

   }

   if ( (self.playerclass) ) {

      new_class = 1.000;


   }

   TeamFortress_ChangeClass (inp);
   self.impulse = 0.000;
   //stuffcmd(self,"reset menu_class\n");
   ResetMenu ();
   if ( ((self.playerclass) && (new_class != 1.000) && (self.playerclass != 11.000)) ) {



         st = infokey (self,"ch");
         if ( (st == string_null) ) {

            st = infokey (self,"classhelp");

         }


         if ( (st != "off") && (!(self.tfkey & 1.000)) ) {

            self.current_menu = 6.000;

         } else {

            self.current_menu = 1.000;

         }

   }
   self.menu_displaytime = 0.000;

};

void () Menu_Drop = {

   if ( (self.playerclass == 9.000) ) {

      CenterPrint (self,"\nDrop or Make Ammo:            \n“‘ Shells                    \n”‘ Nails                     \n•‘ Rockets                   \n–‘ Cells                     \n—‘ Grenade 1                 \n˜‘ Grenade 2                 \n™‘ Nothing                   \n");

   } else {

      CenterPrint (self,"\nDrop Ammo:                    \n“‘ Shells                    \n”‘ Nails                     \n•‘ Rockets                   \n–‘ Cells                     \n—‘ Grenade 1                 \n˜‘ Grenade 2                 \n™‘ Nothing                   \n");


   }

};

void () Menu_RepeatHelp = {

   CenterPrint (self,"Press › to see this help again\n");

};

void (float inp) Menu_Drop_Input = {

   if ( ((inp > 0.000) && (inp < 7.000)) ) {

      TeamFortress_DropAmmo (inp, 10.000);
   }
  
   ResetMenu ();
   self.impulse = 0.000;

};


void (float inp) Menu_Input = {

   if ( (self.current_menu == 2.000) ) {

      Menu_Team_Input (inp);

   } else {

      if ( ((self.current_menu == 3.000) || (self.current_menu == 20.000)) ) {


         Menu_Class_Input (inp);

      } else {

         if ( (self.current_menu == 4.000) ) {

            Menu_Drop_Input (inp);

         } else {

            if ( (self.current_menu == 12.000) ) {

               Menu_Spy_Input (inp);

            } else {

               if ( (self.current_menu == 13.000) ) {

                  Menu_Spy_Skin_Input (inp);

               } else {

                  if ( (self.current_menu == 14.000) ) {

                     Menu_Spy_Color_Input (inp);

                  } else {

                     if ( (self.current_menu == 15.000) ) {

                        Menu_Engineer_Input (inp);

                     } else {

                        if ( (self.current_menu == 16.000) ) {

                           Menu_EngineerFix_Dispenser_Input (inp);

                        } else {

                           if ( (self.current_menu == 17.000) ) {

                              Menu_EngineerFix_SentryGun_Input (inp);

                           } else {

                              if ( (self.current_menu == 19.000) ) {

                                 Menu_Dispenser_Input (inp);

                               } else {

                                 if ( (self.current_menu == 6.000) ) {

                                    Menu_ClassHelp_Input (inp);

                                 } else {

                                    if ( (self.current_menu == 21.000) ) {

                                       Menu_Speech_Input (inp);

                                    } else {

                                       if ( (self.current_menu == 22.000) ) {

                                          Menu_Speech_Def_Input (inp);

                                       } else {

                                          if ( (self.current_menu == 23.000) ) {

                                             Menu_Speech_Off_Input (inp);

                                          } else {

                                             if ( (self.current_menu == 24.000) ) {

                                                Menu_Speech_Gen_Input (inp);

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

};

void () Menu_Intro = {

   local string st1;
   local string st2;


   st1 = infokey (world,"motd1");
   if ( (st1 != string_null) ) {

      st2 = infokey (world,"motd2");
      centerprint3 (self,st1,"\n",st2);

   } else {


      CenterPrint (self,"Welcome to Oz Team Fortress 1.76\nžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžžŸ\nhttp://oztf.quakeworld.nu/\n");

   }



};

void () Menu_ClassHelp = {

   if ( (self.menu_displaytime < 5.000) ) {

      if ( (self.playerclass == 1.000) ) {

         CenterPrint (self,"ÓÃÏÕÔ Details:               \n\n×ÅÁÐÏÎÓ:                     \n”‘ Shotgun                  \n–‘ Nailgun                  \n\nPress › for alias help\n");

      } else {

         if ( (self.playerclass == 2.000) ) {

            CenterPrint (self,"ÓÎÉÐÅÒ Details:              \n\n×ÅÁÐÏÎÓ:                     \n”‘ Sniper Rifle/Auto Rifle  \n–‘ Nailgun                  \n\nPress › for alias help\n");

         } else {

            if ( (self.playerclass == 3.000) ) {

               CenterPrint (self,"ÓÏÌÄÉÅÒ Details:             \n\n×ÅÁÐÏÎÓ:                     \n”‘ Shotgun                  \n•‘ Super Shotgun            \n™‘ Rocket Launcher          \n\nPress › for alias help\n");

            } else {

               if ( (self.playerclass == 4.000) ) {

                  CenterPrint (self,"ÄÅÍÏÌÉÔÉÏÎÓ ÍÁÎ Details:     \n\n×ÅÁÐÏÎÓ:                     \n”‘ Shotgun                  \n˜‘ Grenade Launcher         \n™‘ Pipebomb Launcher        \n\nPress › for alias help\n");

               } else {

                  if ( (self.playerclass == 5.000) ) {

                     CenterPrint (self,"ÍÅÄÉÃ Details:               \n\n×ÅÁÐÏÎÓ:                     \n“‘ Medikit/BioWeapon        \n”‘ Shotgun                  \n•‘ Super Shotgun            \n—‘ Super Nailgun            \n\nPress › for alias help\n");

                  } else {

                     if ( (self.playerclass == 6.000) ) {

                        CenterPrint (self,"ÈÅÁÖÙ ×ÅÁÐÏÎÓ ÇÕÙ Details:   \n\n×ÅÁÐÏÎÓ:                     \n”‘ Shotgun                  \n•‘ Super Shotgun            \n™‘ Assault Cannon           \n\nPress › for alias help\n");

                     } else {

                        if ( (self.playerclass == 7.000) ) {

                           if (classtype & 16) {
                              CenterPrint (self,"ÐÙÒÏ Details:          \n\n×ÅÁÐÏÎÓ:               \n”‘ Shotgun            \n—‘ Flamethrower       \n™‘ Incendiary Cannon  \n\nPress › for alias help\n");
                           } else {
                              CenterPrint (self,"ÐÙÒÏ Details:                \n\n×ÅÁÐÏÎÓ:                     \n”‘ Shotgun                  \n—‘ Flamethrower             \n˜‘ Light Incendiary Cannon  \n™‘ Heavy Incendiary Cannon  \n\nPress › for alias help\n");
                           }

                        } else {

                           if ( (self.playerclass == 8.000) ) {

                              CenterPrint (self,"ÓÐÙ Details:                 \n\n×ÅÁÐÏÎÓ:                     \n”‘ Tranquiliser Gun         \n•‘ Super Shotgun            \n–‘ Nailgun                  \n\nPress › for alias help\n");

                           } else {

                              if ( (self.playerclass == 9.000) ) {

                                 CenterPrint (self,"ÅÎÇÉÎÅÅÒ Details:            \n\n×ÅÁÐÏÎÓ:                     \n“‘ Spanner                  \n”‘ RailGun                  \n•‘ Super Shotgun            \n\nPress › for alias help\n");

                              } else {

                                 if ( (!self.playerclass) ) {

                                    CenterPrint (self,"\n\n\nObserver Details:             \n\nÃÏÍÍÁÎÄÓ:                     \ntracking: toggle tracking mode\ntrack_player: player camera   \ntrack_sentry: sentrygun camera\ntrack_tfgoal: flag camera     \nspecial: camera lock-on       \n");

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

   } else {

      if ( (self.playerclass == 1.000) ) {

         CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nCaltrops            \nConcussion Grenade  \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nScanner: autoscan,scansound,scane,scanf\n\n\nPress › for alias help\n");

      } else {

         if ( (self.playerclass == 2.000) ) {

            CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nFlash               \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nautozoom : Toggle Rifle Autozooming\n\n\nPress › for alias help\n");

         } else {

            if ( (self.playerclass == 3.000) ) {

               CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nNail Grenade        \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress › for alias help\n");

            } else {

               if ( (self.playerclass == 4.000) ) {

                  CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nMirv Grenade        \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nThe Detpack : +det5,+det20,+det50,+det255\nDetonate Pipebombs : detpipe  \n\n\nPress › for alias help\n");

               } else {

                  if ( (self.playerclass == 5.000) ) {

                     CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nConcussion Grenade  \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress › for alias help\n");

                  } else {

                     if ( (self.playerclass == 6.000) ) {

                        CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nMirv Grenade        \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress › for alias help\n");

                     } else {

                        if ( (self.playerclass == 7.000) ) {

                           CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nNapalm Grenade      \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress › for alias help\n");

                        } else {

                           if ( (self.playerclass == 8.000) ) {

                              CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nHallucinogen Grenade\n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nGo Undercover : disguise\nFeign Death : feign, sfeign\n\n\nPress › for alias help\n");

                           } else {

                              if ( (self.playerclass == 9.000) ) {

                                 CenterPrint (self,"ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nEMP Grenade         \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nStart Building : build  \n\n\nPress › for alias help\n");

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

};

void () Menu_StuffClassHelp = {

   if ( (self.playerclass == 1.000) ) {

      sprint (self,2.000,"ÓÃÏÕÔ Details:\n×ÅÁÐÏÎÓ:\n   ”‘ Shotgun\n   –‘ Nailgun\n");
      sprint (self,2.000,"ÇÒÅÎÁÄÅÓ:\n   Concussion Grenade\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n");
      sprint (self,2.000,"Scanner: autoscan,scansound,scane,scanf\n\n\n");

   } else {

      if ( (self.playerclass == 2.000) ) {

         sprint (self,2.000,"ÓÎÉÐÅÒ Details:\n\n×ÅÁÐÏÎÓ:\n   ”‘ Sniper Rifle/Auto Rifle\n");
         sprint (self,2.000,"–‘ Nailgun\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n\n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n");
         sprint (self,2.000,"  autozoom : Toggle Rifle Autozooming\n\n\n");

      } else {

         if ( (self.playerclass == 3.000) ) {

            sprint (self,2.000,"ÓÏÌÄÉÅÒ Details:\n\n×ÅÁÐÏÎÓ:\n   ”‘ Shotgun\n   •‘ Super Shotgun\n");
            sprint (self,2.000,"   ™‘ Rocket Launcher\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Nail Grenade\n");
            sprint (self,2.000,"ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");

         } else {

            if ( (self.playerclass == 4.000) ) {

               sprint (self,2.000,"ÄÅÍÏÌÉÔÉÏÎÓ ÍÁÎ Details:\n\n×ÅÁÐÏÎÓ:\n   ”‘ Shotgun\n   ˜‘ Grenade/Pipebomb Launcher\n");
               sprint (self,2.000,"ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Mirv Grenade\n");
               sprint (self,2.000,"ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   The Detpack : +det5,+det20,+det50,+det255\n   Detonate Pipebombs : detpipe\n\n\n");

            } else {

               if ( (self.playerclass == 5.000) ) {

                  sprint (self,2.000,"ÍÅÄÉÃ Details:\n\n×ÅÁÐÏÎÓ:\n   “‘ Medikit/BioWeapon\n   ”‘ Shotgun\n   •‘ Super Shotgun\n");
                  sprint (self,2.000,"   —‘ Super Nailgun\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Concussion Grenade\n");
                  sprint (self,2.000,"ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");

               } else {

                  if ( (self.playerclass == 6.000) ) {

                     sprint (self,2.000,"ÈÅÁÖÙ ×ÅÁÐÏÎÓ ÇÕÙ Details:\n\n×ÅÁÐÏÎÓ:\n   ”‘ Shotgun\n   •‘ Super Shotgun\n");
                     sprint (self,2.000,"   ™‘ Assault Cannon\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n");
                     sprint (self,2.000,"   Mirv Grenade\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");

                  } else {

                     if ( (self.playerclass == 7.000) ) {

                        if (classtype & 16) {
                           sprint (self,2.000,"ÐÙÒÏ Details:\n\n×ÅÁÐÏÎÓ:\n   ”‘ Shotgun\n   —‘ Flamethrower\n   ™‘ Incendiary Cannon\n");
                        } else {
                           sprint (self,2.000,"ÐÙÒÏ Details:\n\n×ÅÁÐÏÎÓ:\n   ”‘ Shotgun\n   —‘ Flamethrower\n   ˜‘ Light Incendiary Cannon\n   ™‘ Heavy Incendiary Cannon\n");
                        }
                        sprint (self,2.000,"ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Napalm Grenade\n");
                        sprint (self,2.000,"ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");

                     } else {

                        if ( (self.playerclass == 8.000) ) {

                           sprint (self,2.000,"ÓÐÙ Details:\n\n×ÅÁÐÏÎÓ:\n   ”‘ Tranquiliser Gun\n   •‘ Super Shotgun\n   –‘ Nailgun\n");
                           sprint (self,2.000,"ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Hallucinogenic Grenade\n");
                           sprint (self,2.000,"ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   Go Undercover : disguise\n   Feign Death : feign, sfeign\n\n\n");

                        } else {

                           if ( (self.playerclass == 9.000) ) {

                              sprint (self,2.000,"ÅÎÇÉÎÅÅÒ Details:\n\n×ÅÁÐÏÎÓ:\n   “‘ Spanner\n   ”‘ RailGun\n   •‘ Super Shotgun\n");
                              sprint (self,2.000,"ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   EMP Grenade\n");
                              sprint (self,2.000,"ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   Start Building : build\n\n\n");

                           
                           } else {

                              if ( (!self.playerclass) ) {

                                 sprint (self,2.000,"\n\nObserver Details:\n\n\nÃÏÍÍÁÎÄÓ: \n   tracking:     toggle tracking mode\n   track_player: observe a player\n   track_sentry: observe a sentrygun\n   track_tfgoal: observe a team's flag\n   special:      lock onto and observe an object\n");
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

};

void () Menu_ClassHelp2 = {

   CenterPrint (self,"Commands:\ninv       : Show inventory \n+gren1    : Throw grenade 1\n+gren2    : Throw Grenade 2\nreload    : Force a reload \ndropammo  : drop some ammo \n\n");

};

void (float inp) Menu_ClassHelp_Input = {

  if (TeamFortress_TeamIsCivilian(self.pteam.team)) {
        return;

  } 

   if ( (inp == 9.000) ) {

      Menu_ClassHelp2 ();
      self.menu_count = 25.000;
      self.current_menu = 7.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;

   }

};

void (float type, float num) Menu_Speech_Sound = {

   local string snd;
   local entity te;

   if (type == 1)
   {
      if (num == 1)
      {
         snd = "speech/def_incflag1.wav";
      }
      else if (num == 2)
      {
         snd = "speech/def_flagdanger.wav";
      }
      else if (num == 3)
      {
         snd = "speech/def_flag.wav";
      }
      else if (num == 4)
      {
         snd = "speech/def_fixsenty.wav";
      }

   }
   if (type == 2)
   {
      if (num == 1)
      {
         snd = "speech/off_flaghave.wav";
      }
      else if (num == 2)
      {
         snd = "speech/off_imatt.wav";
      }
      else if (num == 3)
      {
         snd = "speech/off_flagtake.wav";
      }
      else if (num == 4)
      {
         snd = "speech/off_coverme.wav";
      }
      else if (num == 5)
      {
         snd = "speech/off_attsentry.wav";
      }

   }
   if (type == 3)
   {
      if (num == 1)
      {
         snd = "speech/saveme1.wav";
      }
      else if (num == 2)
      {
         snd = "speech/engineer2.wav";
      }
      else if (num == 3)
      {
         snd = "speech/gen_noprob.wav";
      }
      else if (num == 4)
      {
         snd = "speech/gen_gogogo.wav";
      }
      else if (num == 5)
      {
         snd = "speech/gen_giveammo.wav";
      }
      else if (num == 6)
      {
         snd = "speech/gen_movepls.wav";
      }

   }

   te = player_head;
   while ( te ) {

      if ( (te.pteam == self.pteam) ) {

         if (te.pteam.last_sound < time ) {
            stuffcmd(te,"play ");      
            stuffcmd(te,snd);
            stuffcmd(te,"\n");   
         }

      }
      te = te.nextp;

   }
   self.pteam.last_sound = time + 2.000;


};

void () Menu_Speech_Defensive = {

      CenterPrint (self,"žžž Defensive Commands: žžž\n\n“‘ Incoming Flag!\n”‘ Flag in Danger\n•‘ Defend Flag!  \n–‘ Repair Sentry \n’‘ Cancel        \n");

};

void () Menu_Speech_Offensive = {

      CenterPrint (self,"žžž Offensive Commands: žžž\n\n“‘ I Have the Flag!\n”‘ I'm Attacking   \n•‘ Take the Flag   \n–‘ Cover me        \n—‘ Attack Sentry   \n’‘ Cancel          \n");

};

void () Menu_Speech_General = {

      CenterPrint (self,"žžž General Commands: žžž\n\n“‘ Save Me!     \n”‘ Need Engineer\n•‘ No Problem   \n–‘ GO GO GO!    \n—‘ Give me ammo \n˜‘ Move Please  \n’‘ Cancel       \n");

};

void (float inp) Menu_Speech_Def_Input = {

   if ((inp == 10) || (self.pteam.last_sound > time ))
   {
      ResetMenu ();
      return ;

   }
   else if ( (inp > 0.000) && (inp < 5.000) )
   {
      Menu_Speech_Sound(1 , inp);
      ResetMenu ();
      self.impulse = 0.000;
      return ;
   }
 
};


void (float inp) Menu_Speech_Off_Input = {


   if ((inp == 10) || (self.pteam.last_sound > time ))
   {
      ResetMenu ();
      return ;

   }
   else if ( (inp > 0.000) && (inp < 6.000) )
   {
      Menu_Speech_Sound(2 , inp);
      ResetMenu ();
      self.impulse = 0.000;
      return ;
   }
 
};

void (float inp) Menu_Speech_Gen_Input = {

   if ((inp == 10) || (self.pteam.last_sound > time ))
   {
      ResetMenu ();
      return ;

   }
   else if ( (inp > 0.000) && (inp < 7.000) )
   {
      Menu_Speech_Sound(3 , inp);
      ResetMenu ();
      self.impulse = 0.000;
      return ;
   }
 
};


void () Menu_Speech = {

   CenterPrint (self,"žžž Speech Command: žžž\n\n“‘ Defensive  \n”‘ Offensive  \n•‘ General    \n’‘ Cancel     \n");

};

void (float inp) Menu_Speech_Input = {

   if (inp == 10) {

      ResetMenu ();
      return ;

   }
   else if ( (inp == 1.000) )
   {
      Menu_Speech_Defensive ();
      self.menu_count = 25.000;
      self.current_menu = 22.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
   } 
   else if ( (inp == 2.000) )
   {
      Menu_Speech_Offensive ();
      self.menu_count = 25.000;
      self.current_menu = 23.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
   } 
   else if ( (inp == 3.000) )
   {
      Menu_Speech_General ();
      self.menu_count = 25.000;
      self.current_menu = 24.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
   } 

};


// ************** UPGRADES ***************


void () Menu_Upgrade_Weapons = {

      CenterPrint (self,"žžž Defensive Commands: žžž\n\n“‘ Incoming Flag!\n”‘ Flag in Danger\n•‘ Defend Flag!  \n–‘ Repair Sentry \n’‘ Cancel        \n");

};

void () Menu_Upgrade_Armor = {

      CenterPrint (self,"žžž Offensive Commands: žžž\n\n“‘ I Have the Flag!\n”‘ I'm Attacking   \n•‘ Take the Flag   \n–‘ Cover me        \n—‘ Attack Sentry   \n’‘ Cancel          \n");

};

void () Menu_Upgrade_Movement = {

      CenterPrint (self,"žžž General Commands: žžž\n\n“‘ Save Me!     \n”‘ Need Engineer\n•‘ No Problem   \n–‘ GO GO GO!    \n—‘ Give me ammo \n˜‘ Move Please  \n’‘ Cancel       \n");

};

void () Menu_Upgrade_Other = {

      CenterPrint (self,"žžž General Commands: žžž\n\n“‘ Save Me!     \n”‘ Need Engineer\n•‘ No Problem   \n–‘ GO GO GO!    \n—‘ Give me ammo \n˜‘ Move Please  \n’‘ Cancel       \n");

};

void (float inp) Menu_Upgrade_Wea_Input = {

   if ((inp == 10))
   {
      ResetMenu ();
      return ;
   }
};


void (float inp) Menu_Upgrade_Arm_Input = {

   if ((inp == 10))
   {
      ResetMenu ();
      return ;
   }
};

void (float inp) Menu_Upgrade_Mov_Input = {

   if ((inp == 10))
   {
      ResetMenu ();
      return ;
   }
};

void (float inp) Menu_Upgrade_Oth_Input = {

   if ((inp == 10))
   {
      ResetMenu ();
      return ;
   }

};


void () Menu_Upgrades = {

   CenterPrint (self,"žžž Upgrade Command: žžž\n\n“‘ Weapons  \n”‘ Armor  \n•‘ Movement   \n4. Other    \n’‘ Cancel     \n");

};

void (float inp) Menu_Upgrades_Input = {

   if (inp == 10) {

      ResetMenu ();
      return ;

   }
   else if ( (inp == 1.000) )
   {
      Menu_Upgrade_Weapons ();
      self.menu_count = 25.000;
      self.current_menu = 26.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
   } 
   else if ( (inp == 2.000) )
   {
      Menu_Upgrade_Armor ();
      self.menu_count = 25.000;
      self.current_menu = 27.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
   } 
   else if ( (inp == 3.000) )
   {
      Menu_Upgrade_Movement ();
      self.menu_count = 25.000;
      self.current_menu = 28.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
   } 
   else if ( (inp == 4.000) )
   {
      Menu_Upgrade_Other ();
      self.menu_count = 25.000;
      self.current_menu = 29.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;
   } 

};





void () Menu_Spy = {

   if ( ((self.effects & (8.000 | 4.000)) || (self.is_unabletospy == 1.000)) ) {

      ResetMenu ();
      return ;

   }
   if ( self.is_feigning ) {

      if ( ((self.undercover_team != 0.000) && (self.undercover_skin != 0.000)) ) {

         CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Reset Skin and Color        \n—‘ Nothing                     \n\n");

      } else {

         if ( (self.undercover_team != 0.000) ) {

            CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Reset Color                 \n—‘ Nothing                     \n\n");

         } else {

            if ( (self.undercover_skin != 0.000) ) {

               CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Reset Skin                  \n—‘ Nothing                     \n\n");

            } else {

               CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Stop Feigning               \n–‘ Nothing                     \n\n");

            }

         }

      }

   } else {

      if ( ((self.undercover_team != 0.000) && (self.undercover_skin != 0.000)) ) {

         CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Reset Skin and Color        \n—‘ Nothing                     \n\n");

      } else {

         if ( (self.undercover_team != 0.000) ) {

            CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Reset Color                 \n—‘ Nothing                     \n\n");

         } else {

            if ( (self.undercover_skin != 0.000) ) {

               CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Reset Skin                  \n—‘ Nothing                     \n\n");

            } else {

               CenterPrint (self,"Action:                           \n“‘ Change Skin                 \n”‘ Change Color                \n•‘ Start Feigning              \n–‘ Nothing                     \n\n");

            }

         }

      }

   }

};

void (float inp) Menu_Spy_Input = {

   if ( ((inp == 1.000) || (inp == 2.000)) ) {

      if ( (self.effects & (8.000 | 4.000)) ) {

         sprint (self,2.000,"You can't go undercover while glowing.\n");
         ResetMenu ();
         self.impulse = 0.000;
         return ;

      }
      if ( (self.is_unabletospy == 1.000) ) {

         sprint (self,2.000,"You can't go undercover right now.\n");
         ResetMenu ();
         self.impulse = 0.000;
         return ;

      }

   }
   if ( (inp == 1.000) ) {

      Menu_Spy_Skin ();
      self.menu_count = 25.000;
      self.current_menu = 13.000;
      self.menu_displaytime = 0.000;
      self.impulse = 0.000;

   } else {

      if ( (inp == 2.000) ) {

         Menu_Spy_Color ();
         self.menu_count = 25.000;
         self.current_menu = 14.000;
         self.menu_displaytime = 0.000;
         self.impulse = 0.000;

      } else {

         if ( (inp == 3.000) ) {

            TeamFortress_SpyFeignDeath (0.000);
            ResetMenu ();
            self.impulse = 0.000;

         } else {

            if ( (inp == 4.000) ) {

               Spy_RemoveDisguise (self);
               ResetMenu ();
               self.impulse = 0.000;

            } else {

               if ( ((inp == 5.000) && ((self.undercover_team != 0.000) || (self.undercover_skin != 0.000))) ) {

                  ResetMenu ();
                  self.impulse = 0.000;

               } else {

                  if ( (inp == 6.000) ) {
                     if (self.alpha == 0.400)
                     {
                        sprint(self, 2.000, "self.alpha 1\n");
                        self.alpha = 1.000;
                     }
                     else
                     {
                        sprint(self, 2.000, "self.alpha 0.4\n");
                        self.alpha = 0.400;
                     }
                     ResetMenu ();
                     self.impulse = 0.000;
                  }

               }

            }

         }

      }

   }

};

void () Menu_Spy_Skin = {


   if (TeamFortress_TeamIsCivilian(self.undercover_team)) {
      CenterPrint (self,"žžž Change Skin to: žžž\n“‘ Base" ) ;
      return;
   }

   CenterPrint (self,"žžž Change Skin to: žžž\n“‘ Scout   \n”‘ Sniper  \n•‘ Soldier \n–‘ Demoman \n—‘ Medic   \n˜‘ Hvwep   \n™‘ Pyro    \nš‘ Spy     \n›‘ Engineer\n\n");

};

void (float inp) Menu_Spy_Skin_Input = {

   if (TeamFortress_TeamIsCivilian(self.undercover_team)) {

      if ( (inp == 1.000)) {

         TeamFortress_SpyChangeSkin (inp);
         ResetMenu ();
         self.impulse = 0.000;
	      
      }
	return;

   }

   if ( ((inp < 10.000) && (inp > 0.000)) ) {

      TeamFortress_SpyChangeSkin (inp);
      ResetMenu ();
      self.impulse = 0.000;

   }

};

void () Menu_Spy_Color = {

   if ( (store_obs.cnt == 0.000) ) {

      sprint (self,2.000,"No Color changing allowed in deathmatch.\n");
      ResetMenu ();
      self.impulse = 0.000;
      return ;

   }

   if ( (store_obs.cnt == 2.000) ) {

      CenterPrint (self,"žžž Change Color to the Same Color as: žžž\n\n“‘ Team One  \n”‘ Team Two  \n\n");

   } else {

      CenterPrint (self,"žžž Change Color to the Same Color as: žžž\n\n“‘ Team One  \n”‘ Team Two  \n•‘ Team Three\n–‘ Team Four \n\n");

   }

};

void (float inp) Menu_Spy_Color_Input = {



   if ( ((inp >= 1.000) && (inp <= store_obs.cnt)) ) {

      if (( self.undercover_skin != 0.000)) {

         if (TeamFortress_TeamIsCivilian(inp)) {

            CenterPrint (self,"žžž Cannot change Color, You must Reset your Skin. žžž\n");
            return;	   
         }

      }

	
	TeamFortress_SpyChangeColor (inp);
      ResetMenu ();
      self.impulse = 0.000;


   }



};

void () Menu_Engineer = {

   local string s_action;
   local string s_disp;
   local string s_sentry;
  // local string s_teleport;
   local string s_nothing;

   s_action = "Action:                           \n";
   s_nothing = "—‘ Nothing                      \n\n";
   if ( self.has_dispenser ) {

      s_disp = "™‘ Remotely Detonate Dispenser  \n";

   } else {

      if ( (self.ammo_cells >= 100.000) ) {

         s_disp = "“‘ Build Ammo&Armor Dispenser   \n";

      } else {

         s_disp = "\n";

      }

   }
   if ( self.has_sentry ) {

      s_sentry = "š‘ Remotely Detonate Sentry Gun \n";

   } else {

      if ( (self.ammo_cells >= 130.000) ) {

         s_sentry = "”‘ Build Sentry Gun             \n";

      } else {

         s_sentry = "\n";

      }

   }/*
    if (self.has_teleporter != 0) 
	{
		if (self.has_teleporter == 1 && self.ammo_cells >= 80.000)
			s_teleport = ".. Build a Teleporter Pad        \n®® Destroy a Teleporter Pad      \n"; //ofn the number is 5
		else if (self.has_teleporter == 1 && self.ammo_cells < 80.000)
			s_teleport = "®® Destroy a Teleporter Pad      \n"; // 6
		if (self.has_teleporter == 2)
			s_teleport = "®® Destroy Both Teleporter Pads  \n"; // 6
	}
	else if (self.ammo_cells >= 80.000)
		s_teleport = ".. Build a Teleporter Pad        \n";
      }
   } 		*/
   centerprint4 (self,s_action,s_disp,s_sentry,s_nothing);

};

void (float inp) Menu_Engineer_Input = {


   if ( (((inp == 1.000) && (self.ammo_cells >= 100.000)) && (self.has_dispenser != 1.000)) ) {

      TeamFortress_Build (1.000);
      ResetMenu ();
      self.impulse = 0.000;

   } else {

      if ( (((inp == 2.000) && (self.ammo_cells >= 130.000)) && (self.has_sentry != 1.000)) ) {

         TeamFortress_Build (2.000);
         ResetMenu ();
         self.impulse = 0.000;

      } else {

         if ( (((inp == 3.000) && (self.ammo_cells >= 180.000)) && (self.has_sentry != 1.000)) ) {

            TeamFortress_Build (3.000);
            ResetMenu ();
            self.impulse = 0.000;

         } else {

         if ( ((inp == 7.000) && (self.has_dispenser == 1.000)) ) {

            DestroyBuilding (self,"building_dispenser");
            ResetMenu ();
            self.impulse = 0.000;

         } else {

            if ( ((inp == 8.000) && (self.has_sentry == 1.000)) ) {

               DestroyBuilding (self,"building_sentrygun");
               ResetMenu ();
               self.impulse = 0.000;

            } else {

               if ( (inp == 5.000) ) {

                  ResetMenu ();
                  self.impulse = 0.000;

               }

            }

         }

         }

      }

   }

};

void () Menu_EngineerFix_Dispenser = {

   CenterPrint (self,"Action:                            \n“‘ Put Ammo into Dispenser     \n”‘ Put Armor into Dispenser    \n•‘ Repair Dispenser            \n–‘ Dismantle Dispenser         \n—‘ Nothing                     \n\n");

};

float (float cur_ammo, float new_ammo) SetAttribute;

void (float inp) Menu_EngineerFix_Dispenser_Input = {

   local float metalcost;
   local float am;

   if ( ((self.classname != "player") || (self.building == world)) ) {

      return ;

   }
   if ( (inp == 1.000) ) {

      am = (20.000 * 2.000);
      if ( (am > self.ammo_shells) ) {

         am = self.ammo_shells;

      }
      if ( (am > (400.000 - self.building.ammo_shells)) ) {

         am = (400.000 - self.building.ammo_shells);

      }

      self.ammo_shells = SetAttribute(self.ammo_shells, self.ammo_shells - am);
      self.building.ammo_shells = (self.building.ammo_shells + am);
      am = (20.000 * 2.000);
      if ( (am > self.ammo_nails) ) {

         am = self.ammo_nails;

      }
      if ( (am > (600.000 - self.building.ammo_nails)) ) {

         am = (600.000 - self.building.ammo_nails);

      }

      self.ammo_nails = SetAttribute(self.ammo_nails, self.ammo_nails - am);
      self.building.ammo_nails = (self.building.ammo_nails + am);
      am = (10.000 * 2.000);
      if ( (am > self.ammo_rockets) ) {

         am = self.ammo_rockets;

      }
      if ( (am > (300.000 - self.building.ammo_rockets)) ) {

         am = (300.000 - self.building.ammo_rockets);

      }

      self.ammo_rockets  = SetAttribute(self.ammo_rockets, self.ammo_rockets - am);
      self.building.ammo_rockets = (self.building.ammo_rockets + am);
      am = (10.000 * 2.000);
      if ( (am > self.ammo_cells) ) {

         am = self.ammo_cells;

      }
      if ( (am > (400.000 - self.building.ammo_cells)) ) {

         am = (400.000 - self.building.ammo_cells);

      }

      self.ammo_cells = SetAttribute(self.ammo_cells, self.ammo_cells - am);
      self.building.ammo_cells = (self.building.ammo_cells + am);

   } else {

      if ( (inp == 2.000) ) {

         am = (40.000 * 2.000);
         if ( (am > self.armorvalue) ) {

            am = self.armorvalue;

         }
         if ( (am > (500.000 - self.building.armorvalue)) ) {

            am = (500.000 - self.building.armorvalue);

         }

         self.armorvalue = SetAttribute(self.armorvalue, self.armorvalue - am);
         self.building.armorvalue = (self.building.armorvalue + am);

      } else {

         if ( (inp == 3.000) ) {

            metalcost = ((self.building.max_health - self.building.health) / 5.000);
            if ( (metalcost > self.ammo_cells) ) {

               metalcost = self.ammo_cells;

            }

            self.ammo_cells = SetAttribute(self.ammo_cells, self.ammo_cells - am);
            self.building.health = (self.building.health + (metalcost * 5.000));

         } else {

            if ( (inp == 4.000) ) {

               sprint (self,2.000,"You dismantle the Dispenser.\n");

               self.ammo_cells = SetAttribute(self.ammo_cells, self.ammo_cells + (100.000 / 2.000));

               if ( (self.building.real_owner != self) ) {

                  sprint2 (self.building.real_owner,2.000,self.netname," dismantled your Dispenser.\n");
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner,self.netname);
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner," dismantled ");
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner,self.building.real_owner.netname);
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner,"'s Dispenser.\n");

               }
               dremove (self.building);
               self.building.real_owner.has_dispenser = 0.000;

            }

         }

      }

   }
   if ( ((inp >= 1.000) && (inp <= 5.000)) ) {

      ResetMenu ();
      self.impulse = 0.000;
      self.building = world;
      bound_other_ammo (self);
      if ( (self.armorvalue == 0.000) ) {

         self.armortype = 0.000;
         self.armorclass = 0.000;
         self.items = (self.items - (self.items & ((8192.000 | 16384.000) | 32768.000)));

      }
      W_SetCurrentAmmo ();

   }

};

void () Menu_EngineerFix_SentryGun = {

   if ( ((self.building.weapon < 3.000) && (self.ammo_cells >= 130.000)) ) {

      CenterPrint (self,"Action:                            \n“‘ Put Ammo into Sentry Gun    \n”‘ Upgrade Sentry Gun          \n•‘ Repair Sentry Gun           \n–‘ Dismantle Sentry Gun        \n—‘ Nothing                     \n\n˜‘ Rotate SentryGun            \n");

   } else {

      CenterPrint (self,"Action:                            \n“‘ Put Ammo into Sentry Gun    \n\n•‘ Repair Sentry Gun           \n–‘ Dismantle Sentry Gun        \n—‘ Nothing                     \n\n˜‘ Rotate SentryGun            \n");

   }

};

void (float inp) Menu_EngineerFix_SentryGun_Input = {

   local float am;
   local float metalcost;
   local string st;

   if ( (self.building.real_owner.has_sentry == 0.000) ) {

      return ;

   }
   if ( ((self.classname != "player") || (self.building == world)) ) {

      return ;

   }
   if ( (inp == 1.000) ) {

      am = (20.000 * 2.000);
      if ( (am > self.ammo_shells) ) {

         am = self.ammo_shells;

      }
      if ( (am > (self.building.maxammo_shells - self.building.ammo_shells)) ) {

         am = (self.building.maxammo_shells - self.building.ammo_shells);

      }
      self.ammo_shells = SetAttribute(self.ammo_shells, self.ammo_shells - am);
      self.building.ammo_shells = (self.building.ammo_shells + am);
      if ( (self.building.weapon == 3.000) ) {

         am = (10.000 * 2.000);
         if ( (am > self.ammo_rockets) ) {

            am = self.ammo_rockets;

         }
         if ( (am > (self.building.maxammo_rockets - self.building.ammo_rockets)) ) {

            am = (self.building.maxammo_rockets - self.building.ammo_rockets);

         }

         self.ammo_rockets = SetAttribute(self.ammo_rockets, self.ammo_rockets - am);
         self.building.ammo_rockets = (self.building.ammo_rockets + am);

      }

   } else {

      if ( (((self.building.weapon < 3.000) && (inp == 2.000)) && (self.ammo_cells >= 130.000)) ) {


         self.ammo_cells = SetAttribute(self.ammo_cells, self.ammo_cells - 130.000);
         self.building.weapon = (self.building.weapon + 1.000);
         if (sgtype) {
            self.building.max_health = floor(self.building.max_health * 1.250);
         } else {
            self.building.max_health = floor(self.building.max_health * 1.200);
         }
         self.building.health = self.building.max_health;
         self.building.maxammo_shells = (self.building.maxammo_shells * 1.200);
         if ( (self.building.weapon == 2.000) ) {

            sound (self.building,3.000,"weapons/turrset.wav",1.000,1.000);
            if (sgtype) {
               self.building.think = lvl2_sentry_stand;
            } else {
               self.building.think = lvl2_oldsentry_stand;
            }
            self.building.skin = 1.000;

         } else {

            sound (self.building,3.000,"weapons/turrset.wav",1.000,1.000);
            if (sgtype) {
               self.building.think = lvl3_sentry_stand;
            } else {
               self.building.think = lvl3_oldsentry_stand;
            }
            self.building.skin = 2.000;

         }
         sprint (self,2.000,"You upgrade the Sentry Gun to level ");
         st = ftos (self.building.weapon);
         sprint (self,2.000,st);
         sprint (self,2.000,"\n");

      } else {

         if ( (inp == 3.000) ) {

            metalcost = ((self.building.max_health - self.building.health) / 5.000);
            if ( (metalcost > self.ammo_cells) ) {

               metalcost = self.ammo_cells;

            }
            self.ammo_cells = SetAttribute(self.ammo_cells, self.ammo_cells - metalcost);

            self.building.health = (self.building.health + (metalcost * 5.000));

         } else {

            if ( (inp == 4.000) ) {

               sprint (self,2.000,"You dismantle the Sentry Gun.\n");

               self.ammo_cells = SetAttribute(self.ammo_cells, self.ammo_cells - 130.000);

               if ( (self.building.real_owner != self) ) {

                  sprint2 (self.building.real_owner,2.000,self.netname," dismantled your Sentry Gun.\n");
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner,self.netname);
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner," dismantled ");
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner,self.building.real_owner.netname);
                  teamsprint (self.building.real_owner.pteam.team ,self.building.real_owner,"'s Sentry Gun.\n");

               }
               dremove (self.building.trigger_field);
               dremove (self.building);
               self.building.real_owner.has_sentry = 0.000;

            } else {

               if ( (inp == 6.000) ) {

                  sprint (self,2.000,"Rotating 45 degrees to the left...\n");
                  self.building.waitmin = anglemod ((self.building.waitmin + 45.000));
                  self.building.waitmax = anglemod ((self.building.waitmax + 45.000));

               }

            }

         }

      }

   }
   if ( ((inp >= 1.000) && (inp <= 6.000)) ) {

      ResetMenu ();
      self.impulse = 0.000;
      bound_other_ammo (self);
      if ( (self.armorvalue == 0.000) ) {

         self.armortype = 0.000;
         self.armorclass = 0.000;
         self.items = (self.items - (self.items & ((8192.000 | 16384.000) | 32768.000)));

      }
      W_SetCurrentAmmo ();

   }

};


void () Menu_Dispenser = {

   CenterPrint (self,"Use Dispenser:                     \n“‘ Withdraw some ammo          \n”‘ Withdraw some Armor         \n•‘ Nothing                     \n\n");

};

void (float inp) Menu_Dispenser_Input = {

   local float am;
   local float empty;

   empty = 0.000;
   if ( (inp == 1.000) ) {

      if ( ((((self.building.ammo_shells == 0.000) && (self.building.ammo_nails == 0.000)) && (self.building.ammo_rockets == 0.000)) && (self.building.ammo_cells == 0.000)) ) {

         empty = 1.000;

      } else {

         am = (self.maxammo_shells - self.ammo_shells);
         if ( (am > self.building.ammo_shells) ) {

            am = self.building.ammo_shells;

         }
         self.building.ammo_shells = (self.building.ammo_shells - am);
         self.ammo_shells = (self.ammo_shells + am);
         am = (self.maxammo_nails - self.ammo_nails);
         if ( (am > self.building.ammo_nails) ) {

            am = self.building.ammo_nails;

         }
         self.building.ammo_nails = (self.building.ammo_nails - am);
         self.ammo_nails = (self.ammo_nails + am);
         am = (self.maxammo_rockets - self.ammo_rockets);
         if ( (am > self.building.ammo_rockets) ) {

            am = self.building.ammo_rockets;

         }
         self.building.ammo_rockets = (self.building.ammo_rockets - am);
         self.ammo_rockets = (self.ammo_rockets + am);
         am = (self.maxammo_cells - self.ammo_cells);
         if ( (am > self.building.ammo_cells) ) {

            am = self.building.ammo_cells;

         }
         self.building.ammo_cells = (self.building.ammo_cells - am);
         self.ammo_cells = (self.ammo_cells + am);

      }

   } else {

      if ( (inp == 2.000) ) {

         if ( (self.building.armorvalue == 0.000) ) {

            empty = 1.000;

         } else {

            am = (self.maxarmor - self.armorvalue);
            if ( (am > self.building.armorvalue) ) {

               am = self.building.armorvalue;

            }
            if ( (self.armortype == 0.000) ) {

               self.armortype = 0.300;
               self.items = (self.items | 8192.000);

            }
            self.building.armorvalue = (self.building.armorvalue - am);
            self.armorvalue = (self.armorvalue + am);

         }

      }

   }
   if ( ((inp >= 1.000) && (inp <= 3.000)) ) {

      if ( empty ) {

         sprint (self,2.000,"The dispenser is empty.\n");

      }
      ResetMenu ();
      self.impulse = 0.000;
      self.building = world;
      self.building_wait = (time + 0.500);
      bound_other_ammo (self);
      if ( (self.armorvalue == 0.000) ) {

         self.armortype = 0.000;
         self.armorclass = 0.000;
         self.items = (self.items - (self.items & ((8192.000 | 16384.000) | 32768.000)));

      }
      W_SetCurrentAmmo ();

   }

};
