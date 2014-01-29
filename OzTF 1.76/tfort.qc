
string (entity Goal, entity Player, entity Item) ItemStatus;

void () TeamFortress_CheckClassStats;

void (entity Player, float Armorclass) TeamFortress_DescribeArmor;


void () TeamFortress_Regenerate;

void () UseSpecialSkill = {

   local vector src;

   self.impulse = 0.000;
   if ( (self.playerclass == 1.000) ) {

      self.impulse = 159.000;
      return;

   } else {

      if ( (self.playerclass == 2.000) ) {

         self.impulse = 174.000;
         return;

      } else {

         if ( (self.playerclass == 3.000) ) {

            self.impulse = 173.000;
            return;

         } else {

            if ( (self.playerclass == 4.000) ) {

               self.impulse = 170.000;
               return;

            } else {

               if ( (self.playerclass == 5.000) ) {

                  if ( (self.current == WEAP_SUPER_NAILGUN) ) {

                     self.impulse = 176.000;
                     return;

                  } else {

                     self.impulse = 5.000;
                     return;

                  }

               } else {

                  if ( (self.playerclass == 6.000) ) {

                     if ( (self.current == WEAP_ASSAULT_CANNON )) {

                        if ( (self.tfstate & 2048.000) ) {

                           sprint (self,2.000,"Cannot switch weapons while firing.\n");
                           return;
                        } else {

                           self.impulse = 3.000;
                           return;
                        }

                     } else {

                        self.impulse = 8.000;
                        return;

                     }

                  } else {

                     if ( (self.playerclass == 7.000) ) {

                        if ( (self.current == WEAP_FLAMETHROWER) ) {

                           self.impulse = 7.000;
                           return;

                        } else {

                           self.impulse = 5.000;
                           return;
                        }

                     } else {

                        if ( (self.playerclass == 8.000) ) {

                           self.impulse = 177.000;
                           return;

                        } else {

                           if ( (self.playerclass == 9.000) ) {

                              self.impulse = 179.000;
                              return;

                           } else {

                              if ( (!self.playerclass) ) {

                                 if (CheckClanMode()) return;

                                 src = (self.origin + (v_forward * 10.000));
                                 src_z = (self.absmin_z + (self.size_z * 0.700));
                                 traceline (src,(src + (v_forward * 2048.000)),0.000,self);
                                 if ( (trace_ent != world) ) {

                                    if (trace_ent.netname != string_null) {
                                       sprint3 (self,2.000,"Locked onto ",trace_ent.netname,"\n");
                                    } else {
                                       sprint3 (self,2.000,"Locked onto ",trace_ent.classname,"\n");
                                    }
                                    self.goalentity = trace_ent;
                                    if(!self.tracking) Toggle_Tracking();

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

void () TeamFortress_DisplayLegalClasses = {

   local float gotone;
   local float ill;

   sprint (self,2.000,"Legal Classes for your team are:\n");
   gotone = 0.000;
   ill = TeamFortress_TeamGetIllegalClasses (self.pteam.team);
   if ( (!(store_obs.ammo_nails & 1.000) && !(ill & 1.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Scout");

   }
   if ( (!(store_obs.ammo_nails & 2.000) && !(ill & 2.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;

      if (classtype & 1.000) {
         sprint (self,2.000,"Technician");
      } else {
         sprint (self,2.000,"Sniper");
      }

   }
   if ( (!(store_obs.ammo_nails & 4.000) && !(ill & 4.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Soldier");

   }
   if ( (!(store_obs.ammo_nails & 8.000) && !(ill & 8.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Demolitions Man");

   }
   if ( (!(store_obs.ammo_nails & 16.000) && !(ill & 16.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Combat Medic");

   }
   if ( (!(store_obs.ammo_nails & 32.000) && !(ill & 32.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Heavy Weapons Guy");

   }
   if ( (!(store_obs.ammo_nails & 64.000) && !(ill & 64.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Pyro");

   }
   if ( (!(store_obs.ammo_nails & 256.000) && !(ill & 256.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Spy");

   }
   if ( (!(store_obs.ammo_nails & 512.000) && !(ill & 512.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"Engineer");

   }
   if ( (!(store_obs.ammo_nails & 128.000) && !(ill & 128.000)) ) {

      if ( gotone ) {

         sprint (self,2.000,", ");

      }
      gotone = 1.000;
      sprint (self,2.000,"RandomPC");

   }
   sprint (self,2.000,"\n");

};



void (float inp) TeamFortress_ChangeClass = {

   if ( (!self.playerclass) ) {

      if (round_active && !modetype & 64) {

         if ( !IsLegalClass (inp) ) {
   
             sprint (self,2.000,"Your team cannot play that class.\n");
             TeamFortress_DisplayLegalClasses ();
             return ;

         }
         if ( ClassIsRestricted (self.pteam.team, inp) ) {

            sprint (self,2.000,"Your team already has enough of that class.\n");
            return ;

         }

         if ( TeamFortress_TeamIsCivilian (self.pteam.team) ) {
  
            sprint (self,2.000,"You cannot change class.\n");
            self.nextpc = 11.000;
            return;

         }

         self.nextpc = inp;
         sprint (self,2.000,"Next Round, you will return as a ");
         TeamFortress_PrintClassName (self,self.nextpc,(self.tfstate & 8.000));
         return ;

      }



   } else {


      if ( !IsLegalClass (inp) ) {

         sprint (self,2.000,"Your team cannot play that class.\n");
         TeamFortress_DisplayLegalClasses ();
         return ;

      }
      if ( ClassIsRestricted (self.pteam.team, inp) ) {

         sprint (self,2.000,"Your team already has enough of that class.\n");
         return ;

      }

      if ( TeamFortress_TeamIsCivilian (self.pteam.team) ) {

         inp = 11.000;
      }

      self.nextpc = inp;

      if (rounds) {
         sprint (self,2.000,"Next Round, you will return as a ");
      } else {
         sprint (self,2.000,"After dying, you will return as a ");
      }
      TeamFortress_PrintClassName (self,self.nextpc,(self.tfstate & 8.000));
      return ;

   }
   if ( (teamplay && (self.pteam.team == 0.000)) ) {

      if ( (toggleflags & 64.000) ) {

         if ( (TeamFortress_TeamPutPlayerInTeam () == 0.000) ) {

            return ;

         }

      } else {

         sprint (self,2.000,"You must join a team first. \n");
         return ;

      }

   }

   if ( (self.respawn_time > time) ) {

      return ;

   }
   if (round_over == 2) {
      return;
   }

   if ( (!IsLegalClass (inp ) && (inp != 11.000)) ) {

      sprint (self,2.000,"You cannot play that playerclass on this map. \n");
      TeamFortress_DisplayLegalClasses ();
      return ;

   }

   if ( ClassIsRestricted (self.pteam.team,inp) ) {

      sprint (self,2.000,"Your team has enough of that class.\n");
      return ;

   }


   if ( (inp > 0.000) && (inp < 12.000) ) {

      self.playerclass = (inp);

   } else {

      self.playerclass = 0.000;

   }

   TeamFortress_ExecClassScript (self);

   if ( (self.playerclass == 10.000) ) {

      sprint (self,2.000,"Random Playerclass.\n");
      self.tfstate = (self.tfstate | 8.000);
   }
   self.nextpc = 0.000;
   PutClientInServer();


};

void () TeamFortress_Inventory = {

   local entity tg;
   local string ac;

   if (teamplay) {

      if (!self.pteam.team ) {
         sprint (self,2.000,"You're an observer\n");
         return;
      }
      sprint (self,2.000,"You're in team ");
      ac = ftos (self.pteam.team);
      sprint (self,2.000,ac);
      sprint (self,2.000,", color ");
      ac = ftos (self.pteam.colormap);
      sprint (self,2.000,ac);
      sprint (self,2.000,".\n");
   }

   if ( (self.no_grenades_1 > 0.000) ) {

      sprint (self,2.000,"Gren.Type 1 : ");
      ac = Status_GrenTypeToString(self.tp_grenades_1);
      sprint2 (self,2.000, ac, " (");

      ac = ftos (self.no_grenades_1);
      sprint (self,2.000,ac);
      sprint (self,2.000,")\n");

   }
   if ( (self.no_grenades_2 > 0.000) ) {

      sprint (self,2.000,"Gren.Type 2 : ");
      ac = Status_GrenTypeToString (self.tp_grenades_2);
      sprint2 (self,2.000, ac, " (");

      ac = ftos (self.no_grenades_2);
      sprint (self,2.000,ac);
      sprint (self,2.000,")\n");

   }
   if ( (self.tf_items & 1.000) ) {

      sprint (self,2.000,"Scanner. ");

   }
   if ( (self.carried & 4.000) ) {

      sprint (self,2.000,"Medikit (");
      ac = ftos (self.ammo_medikit);
      sprint (self,2.000,ac);
      sprint (self,2.000,") ");

   }
   if ( (self.ammo_detpack > 0.000) ) {

         ac = ftos (self.ammo_detpack);
         sprint (self,2.000,ac);
         if (modetype & 4) {
            sprint (self,2.000," Bomb");
         } else {
            sprint (self,2.000," Detpack");
         }

         if ( (self.ammo_detpack > 1.000) ) {

            sprint (self,2.000,"s");

         }
         sprint (self,2.000,". ");

      }

   tg = find (world,classname,"item_tfgoal");
   while ( tg ) {

      if ( (tg.owner == self) ) {

         sprint (self,2.000,tg.netname);
         sprint (self,2.000,". ");

      }
      tg = find (tg,classname,"item_tfgoal");

   }
   if ( (self.armorvalue > 0.000) ) {

      TeamFortress_DescribeArmor (self,self.armorclass);

   }
   if ( self.playerclass == 8.000  ) {

      sprint (self,2.000,"Skin : ");
      if ( (self.undercover_skin != 0.000) ) {

         TeamFortress_PrintClassName (self,self.undercover_skin,0.000);

      } else {

         sprint (self,2.000,"Spy\n");

      }
      sprint (self,2.000,"Colors : Team ");
      if ( (self.undercover_team != 0.000) ) {

         ac = ftos (self.undercover_team);

      } else {

         ac = ftos (self.pteam.team);

      }
      sprint (self,2.000,ac);

   }

   sprint (self,2.000,"\n");

};

void () TeamFortress_ShowTF = {

   local string st;

   if ( (toggleflags & 1.000) ) {

      sprint (self,2.000,"Class Persistence On.\n");

   } else {

      sprint (self,2.000,"Class Persistence Off.\n");

   }
   if ( (toggleflags & 64.000) ) {

      sprint (self,2.000,"AutoTeam On.\n");

   }

   if ( (toggleflags & 4.000) ) {

      st = ftos (respawn_delay_time);

   } else {

      st = "No";

   }
   sprint (self,2.000,st);
   if ( (st != "No") ) {

      sprint (self,2.000," second");

   }
   sprint (self,2.000," Respawn Delay.\n");
   if ( (toggleflags & 128.000) ) {

      sprint (self,2.000,"TeamFrags On.\n");

   } else {

      sprint (self,2.000,"TeamFrags Off.\n");

   }
   if ( allow_hook ) {

      sprint (self,2.000,"Grapple On.\n");

   }

   if ( (toggleflags & 2048.000) ) {

      sprint (self,2.000,"Full TeamScore On.\n");

   } else {

      sprint (self,2.000,"Full TeamScore Off.\n");

   }

};

void () TeamFortress_GrenadePrimed;

void () TeamFortress_PrimeGrenade = {

   local float gtype;
   local string gs;
   local string ptime;
   local entity tGrenade;

   if (self.playerclass == 11.000) return;

   if ( (self.tfstate & 1024.000) ) {

      return ;

   }

   if ((self.tfstate & 1.000)) {
      if (self.impulse == 90.000 || self.impulse == 91.000)
         TeamFortress_ThrowGrenade ();
      return;
   } 
   
   if (self.impulse == 90.000) self.impulse = 150;


   if ( (self.impulse == 150.000) ) {

      gtype = self.tp_grenades_1;
      gs = Status_GrenTypeToString(self.tp_grenades_1);

      if ( (self.no_grenades_1 > 0.000) ) {

         // stuffcmd(self,"play gren.wav\n");
         if (!modetype & 2) { 
            self.no_grenades_1 = (self.no_grenades_1 - 1.000);
         }

         if ( (gtype == 10.000) ) {

            ptime = ftos (0.500);
            sprint (self,2.000,"Opening ");
            sprint (self,2.000,gs);
            sprint (self,2.000,"...\n");

         } else {

            ptime = ftos (3.000);
            sprint (self,2.000,gs);
            sprint (self,2.000," primed, ");
            sprint (self,2.000,ptime);
            sprint (self,2.000," seconds...\n");

         }

      } else {

         sprint (self,2.000,"No ");
         sprint (self,2.000,gs);
         sprint (self,2.000,"s left.\n");
         return ;

      }

   }

   if (self.impulse == 91.000) self.impulse = 151;

   if ( (self.impulse == 151.000) ) {

      gtype = self.tp_grenades_2;

      gs = Status_GrenTypeToString(self.tp_grenades_2);


      if ( (self.no_grenades_2 > 0.000) ) {

	   //stuffcmd(self,"play gren.wav\n");
         if (!modetype & 2) { 
            self.no_grenades_2 = (self.no_grenades_2 - 1.000);
         }

         if ( (gtype == 10.000) ) {

            ptime = ftos (0.500);
            sprint (self,2.000,"Opening ");
            sprint (self,2.000,gs);
            sprint (self,2.000,"...\n");

         } else {

            ptime = ftos (3.000);
            sprint (self,2.000,gs);
            sprint (self,2.000," primed, ");
            sprint (self,2.000,ptime);
            sprint (self,2.000," seconds...\n");

         }

      } else {

         sprint (self,2.000,"No ");
         sprint (self,2.000,gs);
         sprint (self,2.000,"s left.\n");
         return ;

      }

   }
   self.tfstate = (self.tfstate | 1.000);
   tGrenade = spawn ();
   tGrenade.owner = self;
   tGrenade.weapon = gtype;
   tGrenade.classname = "timer";
   tGrenade.impulse = self.impulse;
   tGrenade.nextthink = (time + 0.800);
   if ( (gtype == 10.000) ) {

      tGrenade.heat = ((time + 0.500) + 0.500);

   } else {

      tGrenade.heat = ((time + 3.000) + 0.800);

   }
   tGrenade.think = TeamFortress_GrenadePrimed;

};


void () TeamFortress_GrenadePrimed = {

   local entity user;
   local entity oldself;

   user = self.owner;
   if ( (!(user.tfstate & 1024.000) && !user.deadflag) ) {

      self.nextthink = (time + 0.100);
      if ( !self.think ) {

         dremove (self);

      }
      if ( (time > self.heat) ) {

         TeamFortress_ExplodePerson (self);

      }
      return ;

   }
   if ( !(user.tfstate & 1.000) ) {

      dprint ("GrenadePrimed logic error\n");

   }

   user.tfstate = (user.tfstate - (user.tfstate & 1.000));
   user.tfstate = (user.tfstate - (user.tfstate & 1024.000));
   sound (user,1.000,"weapons/ax1.wav",1.000,1.000);
   KickPlayer (-1.000,user);
   newmis = spawn ();
   newmis.owner = user;
   newmis.movetype = 10.000;
   newmis.solid = 2.000;
   newmis.classname = "grenade";
   if (self.impulse == 150)
   {
      newmis.tp_grenades_1 = self.weapon;
   }
   else if (self.impulse == 151)
   {
      newmis.tp_grenades_2 = self.weapon;
   }


   makevectors (user.v_angle);
   if ( user.deadflag ) {

      newmis.velocity = '0.000 0.000 200.000';

   } else {

      if ( user.v_angle_x ) {

         newmis.velocity = ((((v_forward * 600.000) + (v_up * 200.000)) + ((crandom () * v_right) * 10.000)) + ((crandom () * v_up) * 10.000));

      } else {

         newmis.velocity = aim (user,10000.000);
         newmis.velocity = (newmis.velocity * 600.000);
         newmis.velocity_z = 200.000;

      }

   }
   newmis.angles = vectoangles (newmis.velocity);
   newmis.think = SUB_Null;
   newmis.nextthink = self.heat;
   if ( (self.weapon == 1.000) ) {

      newmis.touch = NormalGrenadeTouch;
      newmis.think = NormalGrenadeExplode;
      newmis.skin = 0.000;
      newmis.avelocity = '300.000 300.000 300.000';
      setmodel (newmis,"progs/hgren2.mdl");

   } else {

      if ( (self.weapon == 2.000) ) {

         newmis.touch = ConcussionGrenadeTouch;
         newmis.think = ConcussionGrenadeExplode;
         newmis.skin = 1.000;
         newmis.avelocity = '300.000 300.000 300.000';
         setmodel (newmis,"progs/hgren2.mdl");

      } else {

         if ( (self.weapon == 3.000) ) {

            newmis.touch = NailGrenadeTouch;
            newmis.think = NailGrenadeExplode;
            newmis.skin = 1.000;
            newmis.avelocity = '0.000 300.000 0.000';
            setmodel (newmis,"progs/biggren.mdl");

         } else {

            if ( (self.weapon == 4.000) ) {

               newmis.touch = MirvGrenadeTouch;
               newmis.think = MirvGrenadeExplode;
               newmis.skin = 0.000;
               newmis.avelocity = '0.000 300.000 0.000';
               setmodel (newmis,"progs/biggren.mdl");


            } else {

               if ( (self.weapon == 5.000) ) {

                  newmis.touch = NapalmGrenadeTouch;
                //  if (grentype)
                 //    newmis.think = NapalmGrenadeExplode2; 
                //  else
                     newmis.think = NapalmGrenadeExplode; 
                  newmis.skin = 2.000;
                  newmis.avelocity = '0.000 300.000 0.000';
                  setmodel (newmis,"progs/biggren.mdl");

               } else {

                  if ( (self.weapon == 6.000) ) {

                     newmis.touch = NormalGrenadeTouch;
                     newmis.think = FreezeGrenadeExplode;
                     newmis.skin = 1.000;
                     newmis.avelocity = '300.000 300.000 300.000';
                     setmodel (newmis,"progs/hgren2.mdl");

                  } else {

                     if ( (self.weapon == 7.000) ) {

                        newmis.touch = GasGrenadeTouch;
                        newmis.think = GasGrenadeExplode;
                        newmis.skin = 3.000;
                        newmis.avelocity = '300.000 300.000 300.000';
                        setmodel (newmis,"progs/grenade2.mdl");

                     } else {

                        if ( (self.weapon == 8.000) ) {

                           newmis.touch = EMPGrenadeTouch;
                           newmis.think = EMPGrenadeExplode;
                           newmis.skin = 4.000;
                           newmis.avelocity = '300.000 300.000 300.000';
                           setmodel (newmis,"progs/grenade2.mdl");

                        } else {

                           if ( (self.weapon == 10.000) ) {

                              newmis.touch = CanisterTouch;
                              newmis.think = ScatterCaltrops;
                              newmis.skin = 0.000;
                              newmis.avelocity = '0.000 0.000 0.000';


                           } else {

					if ((self.weapon == 9.000)) {

						newmis.touch = FlashGrenadeTouch;
						newmis.think = FlashGrenadeExplode;
						newmis.skin = 2;
						newmis.avelocity = '300 300 300';
						setmodel (newmis, "progs/hgren2.mdl");
						
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
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,user.origin);
   oldself = self;
   self = self.owner;
   self = oldself;
   dremove (self);

};

void () TeamFortress_ThrowGrenade = {

   if ( !(self.tfstate & 1.000) ) {

      return ;

   }
   self.tfstate = (self.tfstate | 1024.000);

};
float (float pc) IsLegalClass = {

   local float bit;

   if ( (pc == 1.000) ) {

      bit = 1.000;

   } else {

      if ( (pc == 2.000) ) {

         bit = 2.000;

      } else {

         if ( (pc == 3.000) ) {

            bit = 4.000;

         } else {

            if ( (pc == 4.000) ) {

               bit = 8.000;

            } else {

               if ( (pc == 5.000) ) {

                  bit = 16.000;

               } else {

                  if ( (pc == 6.000) ) {

                     bit = 32.000;

                  } else {

                     if ( (pc == 7.000) ) {

                        bit = 64.000;

                     } else {

                        if ( (pc == 8.000) ) {

                           bit = 256.000;

                        } else {

                           if ( (pc == 9.000) ) {

                              bit = 512.000;

                           } else {

                              if ( (pc == 10.000) ) {

                                 bit = 128.000;

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
   if ( ((store_obs.ammo_nails & bit) || (TeamFortress_TeamGetIllegalClasses (self.pteam.team) & bit)) ) {

      return ( 0.000 );

   }
   return ( 1.000 );

};

void (entity p) TeamFortress_SetSpeed = {

   //local string sp;
   local float tf;
   local entity te;
   local float wpdec;
   local float armdec;
   local float medspeed;

   if ( (p.tfstate & 65536.000) ) {


      p.velocity = '0.000 0.000 0.000';
      p.maxspeed = 0.000;
      if (cease_fire || p.is_frozen) p.gravity = 0.000;

      return ;

   } 

   p.gravity = 1.000;

   if ( (p.playerclass == 1.000) ) {

      p.maxspeed = 450.000;


   } else {

      if ( (p.playerclass == 2.000) ) {

         p.maxspeed = 300.000;

      } else {

         if ( (p.playerclass == 3.000) ) {

            p.maxspeed = 240.000;

         } else {

            if ( (p.playerclass == 4.000) ) {

               p.maxspeed = 280.000;

            } else {

               if ( (p.playerclass == 5.000) ) {

                  p.maxspeed = 320.000;

               } else {

                  if ( (p.playerclass == 6.000) ) {

                     p.maxspeed = 230.000;

                  } else {

                     if ( (p.playerclass == 7.000) ) {

                        p.maxspeed = 300.000;

                     } else {

                        if ( (p.playerclass == 11.000) ) {
				   
				   if ((classtype & 64)) {

                              p.maxspeed = 320.000;

				   } else {

                              p.maxspeed = 240.000;
				   }

                        } else {

                           if ( (p.playerclass == 8.000) ) {

                              p.maxspeed = 300.000;

                           } else {

                              if ( (p.playerclass == 9.000) ) {

                                 p.maxspeed = 300.000;

                              } else {

                                 if ( (!p.playerclass) ) {
						
					      p.maxspeed = 500.000;
                                       //p.maxspeed = 0.000;
                                    return ;
						

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

   if (aspeedtype) {

      if (!p.waterlevel) {

         if (p.playerclass && !(p.flags & 512.000))
         {
            p.maxspeed = p.maxspeed / (airspeed * p.armortype);
         }
      }

   }

   if (realistic & 4) {

      
      wpdec = p.num_weaps * 30;

      //bprint(2.000, ftos(wpdec));
      //bprint(2.000,"\n");


      armdec = p.armortype * 50;
      //bprint(2.000, ftos(armdec));
      //bprint(2.000, "\n");
      
      medspeed = 300 - (wpdec + armdec); 
      //p.maxspeed = (p.maxspeed + medspeed / 2);


   }

   tf = 0.000;
   te = find (world,classname,"item_tfgoal");
   while ( ((te != world) && (tf == 0.000)) ) {

      if ( (te.owner == p) ) {

         if ( (te.goal_activation & 2.000) ) {

            tf = 1.000;
            p.maxspeed = (p.maxspeed / 2.000);

         }

      }
      te = find (te,classname,"item_tfgoal");

   }
   if ( (p.tfstate & 32768.000) ) {

      p.maxspeed = (p.maxspeed / 2.000);

   }
   if ( p.leg_damage ) {

      if ( (p.leg_damage > 6.000) ) {

         p.leg_damage = 6.000;

      }
      p.maxspeed = (p.maxspeed * ((10.000 - p.leg_damage) / 10.000));

   }
   if ( (p.tfstate & 2048.000) ) {

	if ( (p.current == WEAP_ASSAULT_CANNON) ) {

         if ( (p.maxspeed > (p.maxspeed / 2.000)) ) {

            p.maxspeed = (p.maxspeed / 2.000);

         }

      } else {

         if ( (p.maxspeed > 80.000) ) {

            p.maxspeed = 80.000;

         }
      }
   }

};

void () TeamFortress_SetHealth = {

   if (modetype & 8) {
      self.max_health = 250;
      return;
   }

   if ( (self.playerclass == 1.000) ) {

      self.max_health = 75.000;

   } else {

      if ( (self.playerclass == 2.000) ) {

         self.max_health = 90.000;

      } else {

         if ( (self.playerclass == 3.000) ) {

            self.max_health = 100.000;

         } else {

            if ( (self.playerclass == 4.000) ) {

               if (modetype & 256)
               {
                  self.max_health = 90.000; 
               }
               else
               {
                  self.max_health = 100.000; 
               }

            } else {

               if ( (self.playerclass == 5.000) ) {

                  self.max_health = 90.000;

               } else {

                  if ( (self.playerclass == 6.000) ) {

                     self.max_health = 100.000;

                  } else {

                     if ( (self.playerclass == 7.000) ) {

                        self.max_health = 100.000;

                     } else {

                        if ( (self.playerclass == 11.000) ) {

                           self.max_health = 100.000;

                        } else {

                           if ( (self.playerclass == 8.000) ) {

                              self.max_health = 90.000;

                           } else {

                              if ( (self.playerclass == 9.000) ) {

                                 self.max_health = 80.000;

                              } else {

                                 if ( (!self.playerclass) ) {

                                    self.max_health = 1.000;
                                    self.takedamage = 0.000;

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

   self.health = self.max_health;


};
string (entity p) TeamFortress_GetSkin = {

   local float pc;
   local string st;

   if ( ((p.playerclass == 11.000) || (p.pteam.team == 0.000)) ) {

      return ( "base" );

   }
   pc = p.playerclass;
   if ( (p.playerclass == 8.000) ) {

      if ( (p.undercover_skin != 0.000) ) {

         pc = p.undercover_skin;

      }

   }

   if (TeamFortress_TeamIsCivilian(p.pteam.team)) {
		
   st = infokey (world,"sk_civilian");
   if ( (st != string_null) ) {

      return ( st );

   }
   return ( "base" );

	      } else {

            if ( (pc == 1.000) ) {

               st = infokey (world,"sk_scout");
               if ( (st != string_null) ) {

                  return ( st );

               }
               return ( "tf_scout" );

            } else {

               if ( (pc == 2.000) ) {

                  if (classtype & 1.000) {

                    st = infokey (world,"sk_plasma");


                     if ( (st != string_null) ) {

                        return ( st );

                     }
                     return ( "tf_plasma" );

                  } else {

                    st = infokey (world,"sk_sniper");


                     if ( (st != string_null) ) {

                        return ( st );

                     }
                     return ( "tf_snipe" );

                  }

               } else {

                  if ( (pc == 3.000) ) {

                     st = infokey (world,"sk_soldier");
                     if ( (st != string_null) ) {

                        return ( st );

                     }
                     return ( "tf_sold" );

                  } else {

                     if ( (pc == 4.000) ) {

                        st = infokey (world,"sk_demoman");
                        if ( (st != string_null) ) {

                           return ( st );

                        }
                        return ( "tf_demo" );

                     } else {

                        if ( (pc == 5.000) ) {

                           st = infokey (world,"sk_medic");
                           if ( (st != string_null) ) {

                              return ( st );

                           }
                           return ( "tf_medic" );

                        } else {

                           if ( (pc == 6.000) ) {

                              st = infokey (world,"sk_hwguy");
                              if ( (st != string_null) ) {

                                 return ( st );

                              }
                              return ( "tf_hwguy" );

                           } else {

                              if ( (pc == 7.000) ) {

                                 st = infokey (world,"sk_pyro");
                                 if ( (st != string_null) ) {

                                    return ( st );

                                 }
                                 return ( "tf_pyro" );

                              } else {

                                 if ( (pc == 8.000) ) {

                                    st = infokey (world,"sk_spy");
                                    if ( (st != string_null) ) {

                                       return ( st );

                                    }
                                    return ( "tf_spy" );

                                 } else {

                                    if ( (pc == 9.000) ) {

                                       st = infokey (world,"sk_engineer");
                                       if ( (st != string_null) ) {

                                          return ( st );

                                       }
                                       return ( "tf_eng" );

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

      return ( "base" );
};

void (entity p) TeamFortress_SetSkin = {

   local string st;

   if ( ((p.playerclass == 8.000) && (p.undercover_skin != 0.000)) ) {

      p.skin = p.undercover_skin;

   } else {

      p.skin = p.playerclass;

   }
   if ( (p.skin != 0.000) ) {

      stuffcmd (p,"skin ");
      st = TeamFortress_GetSkin (p);
      stuffcmd (p,st);
      stuffcmd (p,"\n");

   } else {

      stuffcmd (p,"skin base\n");

   }

};

void () TeamFortress_SetEquipment = {

   local entity te;
   local string st;
   local float kept_items;
   local float noitems;

   if ( (self.classname != "player") ) {

      return ;

   }
   kept_items = (self.tf_items & (131072.000 | 262144.000));
   self.items = 0.000;
   self.last = 0.000;
   self.current = 0.000;
   self.carried = 0.000;
   self.tf_items = 0.000;
   if ( (self.playerclass != 1.000) ) {

      self.tf_items_flags = 0.000;

   }
   self.armorclass = 0.000;
   self.impulse = 0.000;
   self.undercover_skin = 0.000;
   if ( (self.undercover_team != 0.000) ) {

      //self.immune_to_check = (time + 5.000);
      self.undercover_team = 0.000;
      stuffcmd (self,"color ");
      st = ftos (self.pteam.colormap);
      stuffcmd (self,st);
      stuffcmd (self,"\n");

   }
   self.is_building = 0.000;
   self.is_detpacking = 0.000;
   self.is_undercover = 0.000;
   self.is_feigning = 0.000;
   self.is_unabletospy = 0.000;
   self.ammo_medikit = 0.000;
   self.maxammo_medikit = 0.000;
   self.ammo_detpack = 0.000;
   self.maxammo_detpack = 0.000;
   self.items_allowed = 0.000;
   self.armor_allowed = 0.000;
   self.maxarmor = 0.000;
   self.respawn_time = 0.000;
   self.heat = 0.000;
   self.tfstate = (self.tfstate - (self.tfstate & 2.000));

   self.items = (self.items | kept_items);
   if ( (self.playerclass == 1.000) ) {

      self.carried = (((self.carried | WEAP_AXE) | WEAP_SHOTGUN) | WEAP_NAILGUN);
      self.ammo_rockets = 0.000;
      self.ammo_nails = 100.000;
      self.ammo_shells = 25.000;
      self.ammo_cells = 50.000;
      self.maxammo_rockets = 25.000;
      self.maxammo_nails = 200.000;
      self.maxammo_shells = 50.000;
      self.maxammo_cells = 100.000;
      self.no_grenades_1 = 2.000;
      self.no_grenades_2 = 3.000;
      self.tp_grenades_1 = 10.000;
      self.tp_grenades_2 = 2.000;
      self.tf_items = 1.000;
      self.ScannerOn = 0.000;
      if ( (self.tf_items_flags <= 0.000) ) {

         self.tf_items_flags = (self.tf_items_flags | 1.000);

      }
      self.armorclass = (self.armorclass | 0.000);
      self.armortype = 0.300;
      self.armorvalue = 25.000;
      self.armor_allowed = 0.300;
      self.maxarmor = 50.000;
      self.current = WEAP_NAILGUN;
      self.items_allowed = ((WEAP_AXE | WEAP_SHOTGUN) | WEAP_NAILGUN);
      self.items = ((self.items | 1.000) | 4.000);
	self.num_weaps = 3.000;

   } else {

      if ( (self.playerclass == 2.000) ) {

         if (classtype & 1.000) {
            self.carried = ((((self.carried | WEAP_PLASMAGUN) | WEAP_NAILGUN) | WEAP_SHOTGUN) | WEAP_AXE);
            self.ammo_cells = 100.000;
            self.ammo_nails = 0.000;
            self.maxammo_cells = 200.000;
            self.maxammo_nails = 50.000;
            self.armortype = 0.600;
            self.armorvalue = 50.000;
            self.armor_allowed = 0.600;
            self.maxarmor = 130.000;
            self.current = WEAP_PLASMAGUN;
            self.items_allowed = (((WEAP_PLASMAGUN | WEAP_NAILGUN) | WEAP_SHOTGUN) | WEAP_AXE);
            self.items = (((self.items | 1.000) | 4.000) | 16.000);
	      self.num_weaps = 3.000;
         }
         else
         {
            self.carried = ((((self.carried | WEAP_SNIPER_RIFLE) | WEAP_AUTO_RIFLE	) | WEAP_AXE) | WEAP_NAILGUN);
            self.ammo_cells = 0.000;
            self.ammo_nails = 50.000;
            self.maxammo_nails = 100.000;
            self.maxammo_cells = 50.000;
            self.armortype = 0.300;
            self.armorvalue = 0.000;
            self.armor_allowed = 0.300;
            self.maxarmor = 50.000;
            self.current = WEAP_SNIPER_RIFLE;
            self.items_allowed = (((WEAP_SNIPER_RIFLE | WEAP_AUTO_RIFLE	) | WEAP_AXE) | WEAP_NAILGUN);
            self.items = (((self.items | 1.000) | 2.000) | 4.000);
	      self.num_weaps = 4.000;
         }

         self.ammo_rockets = 0.000;
         self.ammo_shells = 60.000;
         self.maxammo_rockets = 25.000;
         self.maxammo_shells = 75.000;
         self.no_grenades_1 = 2.000;
         self.no_grenades_2 = 2.000;
         self.tp_grenades_1 = 1.000;
         self.tp_grenades_2 = 9.000;
         self.tf_items = 0.000;
         self.armorclass = (self.armorclass | 0.000);


      } else {

         if ( (self.playerclass == 3.000) ) {

            self.carried = ((((self.carried | WEAP_AXE) | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN) | WEAP_ROCKET_LAUNCHER);
            self.ammo_rockets = 10.000;
            self.ammo_nails = 0.000;
            self.ammo_shells = 50.000;
            self.ammo_cells = 0.000;
            self.maxammo_rockets = 50.000;
            self.maxammo_nails = 50.000;
            self.maxammo_shells = 100.000;
            self.maxammo_cells = 50.000;
            self.no_grenades_1 = 4.000;
            self.no_grenades_2 = 1.000; //2
            self.tp_grenades_1 = 1.000;
            self.tp_grenades_2 = 3.000;
            self.tf_items = 0.000;
            self.armorclass = (self.armorclass | 0.000);
            self.armortype = 0.800;
            self.armorvalue = 100.000;
            self.armor_allowed = 0.800;
            self.maxarmor = 200.000;
            self.current = WEAP_ROCKET_LAUNCHER;
            self.items_allowed = (((WEAP_AXE | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN) | WEAP_ROCKET_LAUNCHER);
            self.items = (((self.items | 1.000) | 2.000) | 32.000);
		self.num_weaps = 4.000;

         } else {

            if ( (self.playerclass == 4.000) ) {

               self.carried = ((((self.carried | WEAP_AXE) | WEAP_SHOTGUN) | WEAP_GRENADE_LAUNCHER) | WEAP_PIPEBOMB_LAUNCHER);
               self.ammo_rockets = 20.000;
               self.ammo_nails = 0.000;
               self.ammo_shells = 30.000;
               self.ammo_cells = 0.000;
               self.maxammo_rockets = 50.000;
               self.maxammo_nails = 50.000;
               self.maxammo_shells = 70.000;
               self.maxammo_cells = 50.000;
               self.no_grenades_1 = 4.000;

               if (modetype & 256) {
                  self.no_grenades_2 = 4.000;
               } else {
                  self.no_grenades_2 = 2.000; //4
               }

               self.tp_grenades_1 = 1.000;
               self.tp_grenades_2 = 4.000;
               self.tf_items = 0.000;
               self.ammo_detpack = 1.000;
               self.maxammo_detpack = 1.000;
               self.armorclass = (self.armorclass | 2.000);
               self.armortype = 0.600;
               self.armorvalue = 50.000;
               self.armor_allowed = 0.600;
               self.maxarmor = 120.000; 
               self.current = WEAP_GRENADE_LAUNCHER;
               self.items_allowed = (((WEAP_AXE | WEAP_SHOTGUN) | WEAP_GRENADE_LAUNCHER) | WEAP_PIPEBOMB_LAUNCHER);
               self.items = (((self.items | 1.000) | 16.000) | 32.000);
		   self.num_weaps = 3.000;

            } else {

               if ( (self.playerclass == 5.000) ) {

                  self.carried = ((((self.carried | WEAP_MEDIKIT) | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN) | WEAP_SUPER_NAILGUN);
                  self.ammo_rockets = 0.000;
                  self.ammo_nails = 50.000;
                  self.ammo_shells = 50.000;
                  self.ammo_cells = 0.000;
                  self.maxammo_rockets = 25.000;
                  self.maxammo_nails = 150.000;
                  self.maxammo_shells = 80.000;
                  self.maxammo_cells = 50.000;
                  self.no_grenades_1 = 3.000;
                  if (modetype & 256) {
                     self.no_grenades_2 = 2.000;
                  } else {
                     self.no_grenades_2 = 3.000; 
                  }
                  self.tp_grenades_1 = 1.000;
                  if (grentype) 
                     self.tp_grenades_2 = 6.000; //2
                  else
                     self.tp_grenades_2 = 2.000;
                  self.tf_items = 0.000;
                  self.armorclass = (self.armorclass | 0.000);
                  self.armortype = 0.300;
                  self.armorvalue = 50.000;
                  self.armor_allowed = 0.600;
                  self.maxarmor = 100.000;
                  self.current = WEAP_SUPER_NAILGUN;
                  self.ammo_medikit = 50.000;
                  self.maxammo_medikit = 100.000;
                  te = spawn ();
                  te.nextthink = (time + 3.000);
                  te.think = TeamFortress_Regenerate;
                  te.owner = self;
                  te.classname = "timer";
                  self.items_allowed = ((((WEAP_MEDIKIT ) | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN) | WEAP_SUPER_NAILGUN);
                  self.items = (((self.items | 1.000) | 2.000) | 8.000 );
			self.num_weaps = 4.000;

               } else {

                  if ( (self.playerclass == 6.000) ) {

                     self.carried = ((((self.carried | WEAP_ASSAULT_CANNON) | WEAP_AXE) | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN);
                     self.ammo_rockets = 0.000;
                     self.ammo_nails = 0.000;
                     self.ammo_shells = 200.000;
                     self.ammo_cells = 30.000;
                     self.maxammo_rockets = 25.000;
                     self.maxammo_nails = 200.000;
                     self.maxammo_shells = 200.000;
                     self.maxammo_cells = 56.000;
                     self.no_grenades_1 = 4.000;
                     self.no_grenades_2 = 1.000;
                     self.tp_grenades_1 = 1.000;
                     self.tp_grenades_2 = 4.000;
                     self.tf_items = 0.000;
                     self.armorclass = (self.armorclass | 0.000);
                     self.armortype = 0.800;
                     self.armorvalue = 150.000;
                     self.armor_allowed = 0.800;
                     self.maxarmor = 300.000;
                     self.current = WEAP_ASSAULT_CANNON;
                     self.items_allowed = (((WEAP_ASSAULT_CANNON | WEAP_AXE) | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN);
                     self.items = (((self.items | 1.000) | 2.000) | 64.000);
	               self.num_weaps = 4.000;

                  } else {

                     if ( (self.playerclass == 7.000) ) {

				self.carried = ((((self.carried | WEAP_INCENDIARY) | WEAP_FLAMETHROWER) | WEAP_AXE) | WEAP_SHOTGUN);
                        self.ammo_rockets = 20.000;
                        self.ammo_nails = 0.000;
                        self.ammo_shells = 20.000;
                        self.ammo_cells = 120.000;
                        self.maxammo_rockets = 60.000;
                        self.maxammo_nails = 50.000;
                        self.maxammo_shells = 40.000;
                        self.maxammo_cells = 200.000;
                        if (modetype & 256) {
                           self.no_grenades_1 = 1.000;
                           self.no_grenades_2 = 4.000;
                        } else {
                           self.no_grenades_1 = 2.000;
                           self.no_grenades_2 = 3.000;
                        }

                        self.tp_grenades_1 = 1.000;
                        self.tp_grenades_2 = 5.000;
                        self.tf_items = 0.000;
                        self.armorclass = (self.armorclass | 16.000);
                        self.armortype = 0.600;
                        self.armorvalue = 50.000;
                        self.armor_allowed = 0.600;
                        self.maxarmor = 150.000;
                        self.current = WEAP_FLAMETHROWER;
                        self.items_allowed = (((WEAP_INCENDIARY | WEAP_FLAMETHROWER) | WEAP_AXE) | WEAP_SHOTGUN);
                        self.items = (((self.items | 1.000) | 8.000) | 32.000);
                  	self.num_weaps = 4.000;

                     } else {

                        if ( (self.playerclass == 11.000) ) {

				   if (( classtype & 64 || rounds)) {

                              self.ammo_rockets = 10.000;
                              self.ammo_nails = 60.000;
                              self.ammo_shells = 40.000;
                              self.ammo_cells = 8.000;
                              self.maxammo_rockets = 25.000;
                              self.maxammo_nails = 200.000;
                              self.maxammo_shells = 100.000;
                              self.maxammo_cells = 20.000;
                              self.armortype = 0.600;

                              self.maxarmor = 140.000;
                              self.current = WEAP_ROCKET_LAUNCHER;
                              self.items_allowed = ((((((((self.carried | WEAP_AXE) | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN) | WEAP_NAILGUN) | WEAP_SUPER_NAILGUN) | WEAP_GRENADE_LAUNCHER) | WEAP_ROCKET_LAUNCHER) | WEAP_LIGHTNING);


                              self.carried = ((((((((self.carried | WEAP_AXE) | WEAP_SHOTGUN) | WEAP_SUPER_SHOTGUN) | WEAP_NAILGUN) | WEAP_SUPER_NAILGUN) | WEAP_GRENADE_LAUNCHER) | WEAP_ROCKET_LAUNCHER) | WEAP_LIGHTNING);
                              self.items = (((((((self.items | 1.000) | 2.000) | 4.000) | 8.000) | 16.000) | 32.000) | 64.000);
                              self.armor_allowed = 0.600;
					self.num_weaps = 8.000;

 
				   } else {

                              self.ammo_rockets = 0.000;
                              self.ammo_nails = 0.000;
                              self.ammo_shells = 0.000;
                              self.ammo_cells = 0.000;
                              self.maxammo_rockets = 0.000;
                              self.maxammo_nails = 0.000;
                              self.maxammo_shells = 0.000;
                              self.maxammo_cells = 0.000;
                              self.armortype = 0.000;
                              self.armor_allowed = 0.000;
                              self.maxarmor = 0.000;
                              self.current = WEAP_AXE;
                              self.items_allowed = 16.000;
                              self.items = 0.000;

				   }

                           self.no_grenades_1 = 0.000;
                           self.no_grenades_2 = 0.000;
                           self.tp_grenades_1 = 0.000;
                           self.tp_grenades_2 = 0.000;
                           self.tf_items = 0.000;
                           self.armorvalue = 0.000;
                           self.armorclass = (self.armorclass | 0.000);	
			  
                        } else {

                           if ( (self.playerclass == 8.000) ) {

                              self.carried = ((((self.carried | WEAP_AXE) | WEAP_TRANQ) | WEAP_SUPER_SHOTGUN) | WEAP_NAILGUN);
                              self.ammo_rockets = 0.000;
                              self.ammo_nails = 50.000;
                              self.ammo_shells = 40.000;
                              self.ammo_cells = 10.000;
                              self.maxammo_rockets = 15.000;
                              self.maxammo_nails = 100.000;
                              self.maxammo_shells = 40.000;
                              self.maxammo_cells = 30.000;
                              if (modetype & 256) {
                                 self.no_grenades_1 = 2.000;
                                 self.no_grenades_2 = 2.000;
                              } else {
                                 self.no_grenades_1 = 3.000;
                                 self.no_grenades_2 = 2.000;
                              }
                              self.tp_grenades_1 = 1.000;
                              self.tp_grenades_2 = 7.000;
                              self.tf_items = 0.000;
                              self.armorclass = (self.armorclass | 0.000);
                              self.armortype = 0.600;
                              self.armorvalue = 25.000;
                              self.armor_allowed = 0.600;
                              self.maxarmor = 100.000;
                              self.current = WEAP_TRANQ;
                              self.items_allowed = (((WEAP_AXE | WEAP_TRANQ) | WEAP_SUPER_SHOTGUN) | WEAP_NAILGUN);
                              self.items = (((self.items | 1.000) | 2.000) | 4.000);
					self.num_weaps = 4.000;

                           } else {

                              if ( (self.playerclass == 9.000) ) {

                                 self.carried = (((self.carried | WEAP_SPANNER) | WEAP_RAILGUN) | WEAP_SUPER_SHOTGUN);
                                 self.ammo_rockets = 0.000;
                                 self.ammo_nails = 25.000;
                                 self.ammo_shells = 20.000;
                                 self.ammo_cells = 100.000;
                                 self.maxammo_rockets = 30.000;
                                 self.maxammo_nails = 50.000;
                                 self.maxammo_shells = 50.000;
                                 self.maxammo_cells = 200.000;
                                 self.no_grenades_1 = 2.000;
                                 self.no_grenades_2 = 2.000;
                                 self.tp_grenades_1 = 1.000;
                                 self.tp_grenades_2 = 8.000;
                                 self.tf_items = 0.000;
                                 self.armorclass = (self.armorclass | 0.000);
                                 self.armortype = 0.300;
                                 self.armorvalue = 25.000;
                                 self.armor_allowed = 0.600;

                                 if (classtype & 32) {
                                    self.maxarmor = 70.000;
                                 } else {
                                    self.maxarmor = 50.000;
                                 }
                                 self.current = WEAP_RAILGUN;
                                 self.items_allowed = ((WEAP_SPANNER | WEAP_RAILGUN) | WEAP_SUPER_SHOTGUN);
                                 self.items = ((self.items | 1.000) | 2.000);
					   self.num_weaps = 3.000;

                              } else {

                                 if ( (!self.playerclass) ) {

                                    self.items = 0.000;
                                    self.ammo_rockets = 0.000;
                                    self.ammo_nails = 0.000;
                                    self.ammo_shells = 0.000;
                                    self.ammo_cells = 0.000;
                                    self.no_grenades_1 = 0.000;
                                    self.no_grenades_2 = 0.000;
                                    self.tp_grenades_1 = 0.000;
                                    self.tp_grenades_2 = 0.000;
                                    self.armorclass = 0.000;
                                    self.armortype = 0.000;
                                    self.armorvalue = 0.000;
                                    self.weapon = 0.000;
                                    self.current = 0.000;
                                    self.carried = 0.000;
                                    self.flags = 8.000;
                                    self.gravity = 1.000;
                                    self.waterlevel = -1.000;
                                    self.takedamage = 0.000;
                                    self.solid = 0.000;
                                    self.model = string_null;
                                    self.mdl = string_null;
                                    self.modelindex = 0.000;
                                    self.weaponmodel = string_null;
                                    modelindex_player = 0.000;
                                    self.tfstate = (self.tfstate | 2.000);
                                    setmodel (self,string_null);

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


   if (self.playerclass)
   {

      if (modetype & 8)
      {
         self.armorvalue = 200.000;
         self.maxarmor = 200.000;
         self.armortype = 0.8;
         self.armor_allowed = 0.800;
         self.maxammo_rockets = 999.000;
         self.maxammo_nails = 999.000;
         self.maxammo_shells = 999.000;
         self.maxammo_cells = 999.000;
         self.ammo_rockets = 120.000;
         self.ammo_nails = 250.000;
         self.ammo_shells = 250.000;
         self.ammo_cells = 200.000;
         self.health = 250;

      }
      else
      {

         if (rounds) {

            if (!modetype & 64 ) {
               self.armorvalue = self.maxarmor;
               self.ammo_detpack = self.maxammo_detpack;
               self.no_grenades_1 = 4.000;
               self.ammo_rockets = ceil(self.maxammo_rockets / 2);
               if (self.playerclass == 5.000) {
                  self.ammo_nails = 100.000;
               } else { 
                  self.ammo_nails = ceil(self.maxammo_nails / 2);
               }
               if ((self.playerclass != 6.000) && (self.playerclass != 8.000))
                  self.ammo_shells = ceil(self.maxammo_shells / 2);
               self.ammo_cells = ceil(self.maxammo_cells / 2);
            }
         }

         if (stamina) self.stamina = 1000.000;

         if (realdm) {

            self.carried = (WEAP_AXE | WEAP_SHOTGUN);
            self.armor_allowed = 0.800;
	      self.num_weaps = 2.000;
            self.armor_allowed = 0.800;
            self.maxarmor = 200;
            self.armorvalue = 0.000;
            self.armortype = 0.000;
            self.maxammo_rockets = 100.000;
            self.maxammo_nails = 200.000;
            self.maxammo_shells = 100.000;
            self.maxammo_cells = 100.000;
            self.current = WEAP_SHOTGUN;
            self.items = (0 | 1.000);

         }


         if ( modetype & 4 ) {

            self.ammo_detpack = 0.000;

            if (self.pteam == pteam2) {

               self.maxammo_detpack = 1.000;

            } else {

               self.maxammo_detpack = 0.000;

            }

         }

      }


      if (deathmatch == 4.000) {

         self.armorvalue = 200.000;
         self.maxarmor = 200.000;
         self.armortype = 0.8;
         self.armor_allowed = 0.800;
         self.maxammo_rockets = 100.000;
         self.maxammo_nails = 200.000;
         self.maxammo_shells = 100.000;
         self.maxammo_cells = 100.000;
         self.health = 250;
         self.items = (self.items | 1048576.000);
         self.invisible_time = 1.000;
         self.invincible_finished = (time + 4.000);
      }

      if ( allow_hook  ) {

         self.carried = (self.carried | WEAP_HOOK);
      }
   }

   if ( (self.armortype >= 0.800) ) {

      self.items = (self.items | 32768.000);

   } else {

      if ( (self.armortype >= 0.600) ) {

         self.items = (self.items | 16384.000);

      } else {

         if ( (self.armortype >= 0.300) ) {

            self.items = (self.items | 8192.000);

         }

      }

   }


   noitems = (stof(infokey(world,"noitems")));

   if ( noitems & 1.000 )
   {
      self.no_grenades_1 = 0.000;
      self.tp_grenades_1 = 0.000;
   }


   if (noitems & 2.000) 
   {
      self.no_grenades_2 = 0.000;
      self.tp_grenades_2 = 0.000;
   }

   if (noitems & 4.000) 
   {
      self.ammo_detpack = 0.000;
      self.maxammo_detpack = 0.000;
   }

   if (modetype & 2) {

      self.armorvalue = 0.000;
      self.health = 1000.000;
      self.ammo_rockets = self.maxammo_rockets;
      self.ammo_nails = self.maxammo_nails;
      self.ammo_shells = self.maxammo_shells;
      self.ammo_cells = self.maxammo_cells;
   }

   W_SetCurrentAmmo ();

};
float (entity Retriever, float AmmoType) TeamFortress_GetMaxAmmo = {

   if ( (AmmoType == 256.000) ) {

      return ( Retriever.maxammo_shells );

   } else {

      if ( (AmmoType == 512.000) ) {

         return ( Retriever.maxammo_nails );

      } else {

         if ( (AmmoType == 2048.000) ) {

            return ( Retriever.maxammo_cells );

         } else {

            if ( (AmmoType == 1024.000) ) {

               return ( Retriever.maxammo_rockets );

            } else {

               if ( (AmmoType == 4.000) ) {

                  return ( Retriever.maxammo_medikit );

               } else {

                  if ( (AmmoType == 131072.000) ) {

                     return ( Retriever.maxammo_detpack );

                  }

               }

            }

         }

      }

   }
   dprint ("Error in TeamFortress_GetMaxAmmo()\n");
   dprint ("Invalid ammo type passed.\n");
   return ( 0.000 );

};
float (entity Retriever, float WeaponType) TeamFortress_CanGetWeapon = {

   //if (modetype & 8) return 1.000;

   if ( (Retriever.items_allowed & WeaponType) ) {

      return ( 1.000 );

   }
   return ( 0.000 );

};

void (entity Player, float Armorclass) TeamFortress_DescribeArmor = {

   if ( (Armorclass == 0.000) ) {

      return ;

   }
   if ( (Armorclass & 16.000) ) {

      sprint (Player,2.000,"Asbestos ");

   }
   if ( (Armorclass & 2.000) ) {

      sprint (Player,2.000,"Wooden ");

   }
   if ( (Armorclass & 4.000) ) {

      sprint (Player,2.000,"Blast ");

   }
   if ( (Armorclass & 8.000) ) {

      sprint (Player,2.000,"Shockproof ");

   }
   if ( (Armorclass & 1.000) ) {

      sprint (Player,2.000,"Kevlar ");

   }
   sprint (Player,2.000,"armor\n");

};

void (entity Retriever, entity Items) TeamFortress_AddBackpackItems = {

   return ;

};
string (float pc) TeamFortress_GetClassName = {

   if ( (pc == 1.000) )
   {
      return ( "Scout" );
   }
   else if ( (pc == 2.000) )
   {

      if (classtype & 1.000) {
         return ( "Technician" );
      } else {
         return ( "Sniper" );
      }
   }
   else if ( (pc == 3.000) )
   {
      return ( "Soldier" );
   }
   else if ( (pc == 4.000) )
   {
      return ( "Demolitions Man" );
   }
   else if ( (pc == 5.000) )
   {
      return ( "Combat Medic" );
   }
   else if ( (pc == 6.000) )
   {
      return ( "Heavy Weapons Guy" );
   }
   else if ( (pc == 7.000) )
   {
      return ( "Pyro" );
   }
   else if ( (pc == 8.000) )
   {
      return ( "Spy" );
   }
   else if ( (pc == 9.000) )
   {
      return ( "Engineer" );
   }
   else if ( (pc == 10.000) )
   {
      return ( "Random Playerclass" );
   }
   else if ( (pc == 11.000) )
   {
      if (( classtype & 64 )) {
        return ( "Quake Soldier" );
	} else {
         return ( "Civilian" );
      }
   }
   else if ( (pc == 13.000) )
   {
      return ( "Sentry Gun" );
   }
   else if ( (pc == 14.000) )
   {
      return ( "Goal Item" );
   }
   else if ( (pc == 0.000) )
   {
      return ( "Observer" );
   }

   return ( "" );

};

void (entity Viewer, float pc, float rpc) TeamFortress_PrintClassName = {

   local string st;

   st = TeamFortress_GetClassName (pc);
   sprint (Viewer,2.000,st);
   if ( (rpc != 0.000) ) {

      sprint (Viewer,2.000," (Random)");

   }
   sprint (Viewer,2.000,"\n");

};

void () TeamFortress_RemoveTimers = {

   local entity te;

   self.leg_damage = 0.000;
   self.is_undercover = 0.000;
   self.is_building = 0.000;
   self.building = world;
   if ( (self.tfstate & 2048.000) ) {

      self.tfstate = (self.tfstate - 2048.000);
      TeamFortress_SetSpeed (self);
      self.heat = 0.000;

   }
   if ( (self.tfstate & 16.000) ) {

      self.tfstate = (self.tfstate - (self.tfstate & 16.000));

   }
   if ( (self.tfstate & 16384.000) ) {

      self.tfstate = (self.tfstate - (self.tfstate & 16384.000));

   }
   te = find (world,classname,"timer");
   while ( (te != world) ) {

      if ( ((te.owner == self) && (te.no_active_gas_grens <= 0.000)) ) {

         dremove (te);
         te = find (world,classname,"timer");

      } else {

         te = find (te,classname,"timer");

      }

   }
   te = find (world,classname,"grentimer");
   while ( (te != world) ) {

      if ( ((te.owner == self) && (te.no_active_napalm_grens <= 0.000)) ) {

         dremove (te);
         te = find (world,classname,"grentimer");

      } else {

         te = find (te,classname,"grentimer");

      }

   }
   te = find (world,classname,"item_tfgoal");
   while ( te ) {

      if ( (te.owner == self) ) {

         if ( (!(te.goal_activation & 256.000) || (self.has_disconnected == 1.000)) ) {

            tfgoalitem_RemoveFromPlayer (te,self,0.000);

         }
         if ( ((ctfmap == 1) && (te.goal_no == 1.000)) ) {

            bprint (2.000,self.netname);
            bprint (2.000," лост the блуе flag!\n");

         } else {

            if ( ((ctfmap == 1) && (te.goal_no == 2.000)) ) {

               bprint (2.000,self.netname);
               bprint (2.000," лост the ред flag!\n");

            }

         }

      }
      te = find (te,classname,"item_tfgoal");

   }
   te = find (world,classname,"detpack");
   while ( te ) {

      if ( ((te.weaponmode == 1.000) && (te.enemy == self)) ) {

         te.weaponmode = 0.000;

      }
      te = find (te,classname,"detpack");

   }
   TeamFortress_DetonatePipebombs ();
   if ( (self.has_disconnected == 1.000) ) {

      te = find (world,classname,"grenade");
      while ( te ) {

         if ( ((te.owner == self) && (te.model == "progs/caltrop.mdl")) ) {

            dremove (te);
            te = find (world,classname,"grenade");

         } else {

            te = find (te,classname,"grenade");

         }

      }

   }

   self.FlashTime = 0.000;
   self.item_list = 0.000;
   self.is_frozen = 0.000;
   stuffcmd (self, "v_idlescale 0\n");
   CenterPrint (self,"\n");

   if (!round_active) {
      self.menu_count = 25.000;
      self.current_menu = 1.000;
   }
   self.impulse = 0.000;

};

void () TeamFortress_SetupRespawn = {

   local float restime;
   local string db;

   if ( (self.respawn_time > time) ) {

      return ;

   }


   if ( (toggleflags & 4.000) ) {

      restime = respawn_delay_time;

   } else {

      restime = 0.000;

   }


   if (!restime ) {

      self.respawn_time = 0.000;


   } else {

      self.respawn_time = (time + restime);

      if ( (restime > 3.000) ) {

         db = ftos (restime);
         sprint (self,2.000,db);
         sprint (self,2.000," seconds till respawn.\n");

      }
   }

};

void () TeamFortress_CheckClassStats = {


   if ( (self.armortype > self.armor_allowed) ) {

      self.armortype = self.armor_allowed;

   }
   if ( (self.armorvalue > self.maxarmor) ) {

      self.armorvalue = self.maxarmor;

   }

   if ( (self.armortype < 0.000) ) {

      self.armortype = 0.000;

   }
   if ( (self.armorvalue < 0.000) ) {

      self.armorvalue = 0.000;

   }
   if ( (self.ammo_shells > TeamFortress_GetMaxAmmo (self,256.000)) ) {

      self.ammo_shells = TeamFortress_GetMaxAmmo (self,256.000);

   }
   if ( (self.ammo_shells < 0.000) ) {

      self.ammo_shells = 0.000;

   }
   if ( (self.ammo_nails > TeamFortress_GetMaxAmmo (self,512.000)) ) {

      self.ammo_nails = TeamFortress_GetMaxAmmo (self,512.000);

   }
   if ( (self.ammo_nails < 0.000) ) {

      self.ammo_nails = 0.000;

   }
   if ( (self.ammo_rockets > TeamFortress_GetMaxAmmo (self,1024.000)) ) {

      self.ammo_rockets = TeamFortress_GetMaxAmmo (self,1024.000);

   }
   if ( (self.ammo_rockets < 0.000) ) {

      self.ammo_rockets = 0.000;

   }
   if ( (self.ammo_cells > TeamFortress_GetMaxAmmo (self,2048.000)) ) {

      self.ammo_cells = TeamFortress_GetMaxAmmo (self,2048.000);

   }
   if ( (self.ammo_cells < 0.000) ) {

      self.ammo_cells = 0.000;

   }
   if ( (self.ammo_medikit > TeamFortress_GetMaxAmmo (self,4.000)) ) {

      self.ammo_medikit = TeamFortress_GetMaxAmmo (self,4.000);

   }
   if ( (self.ammo_medikit < 0.000) ) {

      self.ammo_medikit = 0.000;

   }
   if ( (self.ammo_detpack > TeamFortress_GetMaxAmmo (self,131072.000)) ) {

      self.ammo_detpack = TeamFortress_GetMaxAmmo (self,131072.000);

   }
   if ( (self.ammo_detpack < 0.000) ) {

      self.ammo_detpack = 0.000;

   }
   if ( (self.no_grenades_1 < 0.000) ) {

      self.no_grenades_1 = 0.000;

   }
   if ( (self.no_grenades_2 < 0.000) ) {

      self.no_grenades_2 = 0.000;

   }
   if ( ((self.health > self.max_health) && !(self.items & 65536.000)) ) {

      TF_T_Damage (self,world,world,(self.max_health - self.health),0.000,256.000);

   }
   if ( (self.health < 0.000) ) {

      T_Heal (self,(self.health - self.health),0.000);

   }
   self.items = (self.items - (self.items & ((8192.000 | 16384.000) | 32768.000)));
   if ( (self.armortype >= 0.800) ) {

      self.items = (self.items | 32768.000);

   } else {

      if ( (self.armortype >= 0.600) ) {

         self.items = (self.items | 16384.000);

      } else {

         if ( (self.armortype >= 0.300) ) {

            self.items = (self.items | 8192.000);

         }

      }

   }

};


void () TeamFortress_AssaultWeapon = {

   self.impulse = 0.000;
   if ( (self.tfstate & 2.000) ) {

      return ;

   }
   if ( !(self.carried & 32768.000) ) {

      return ;

   }
   if ( (self.heat > 0.000) ) {

      sprint (self,2.000,"the assault cannon is still overheated.\n");
      return ;

   }
   if ( (self.ammo_shells < 1.000) ) {

      sprint (self,2.000,"not enough ammo.\n");
      return ;

   }
   if ( (self.ammo_cells < 6.000) ) {

      sprint (self,2.000,"not enough cells to power the assault cannon.\n");
      return ;

   }
   self.current = WEAP_ASSAULT_CANNON;
   W_SetCurrentAmmo ();

};

void (entity Gren) TeamFortress_ExplodePerson = {

   Gren.owner.tfstate = (Gren.owner.tfstate - (Gren.owner.tfstate & 1.000));
   KickPlayer (-2.000,Gren.owner);
   newmis = spawn ();
   newmis.movetype = 10.000;
   newmis.solid = 2.000;
   newmis.classname = "grenade";
   newmis.pteam = Gren.owner.pteam;
   newmis.owner = Gren.owner;
   newmis.velocity = '0.000 0.000 0.000';
   newmis.angles = vectoangles (newmis.velocity);
   if (Gren.impulse == 150)
   {
      newmis.tp_grenades_1 = Gren.weapon;
   }
   else if (Gren.impulse == 151)
   {
      newmis.tp_grenades_2 = Gren.weapon;
   }
   newmis.think = SUB_Null;
   newmis.nextthink = (time + 0.100);


   if ( (Gren.weapon == 1.000) ) {

      newmis.touch = NormalGrenadeTouch;
      //newmis.volume = 2.000;
      newmis.think = NormalGrenadeExplode;
      newmis.skin = 0.000;
      newmis.avelocity = '300.000 300.000 300.000';
      setmodel (newmis,"progs/hgren2.mdl");

   } else {

      if ( (Gren.weapon == 2.000) ) {

         newmis.touch = ConcussionGrenadeTouch;
         newmis.think = ConcussionGrenadeExplode;
         newmis.skin = 1.000;
         newmis.avelocity = '300.000 300.000 300.000';
         setmodel (newmis,"progs/hgren2.mdl");

      } else {

         if ( (Gren.weapon == 3.000) ) {

            newmis.touch = NailGrenadeTouch;
            newmis.think = NailGrenadeExplode;
            newmis.skin = 1.000;
            newmis.avelocity = '0.000 300.000 0.000';
            setmodel (newmis,"progs/biggren.mdl");

         } else {

            if ( (Gren.weapon == 4.000) ) {

               newmis.touch = MirvGrenadeTouch;
               newmis.think = MirvGrenadeExplode;
               newmis.skin = 0.000;
               newmis.avelocity = '0.000 300.000 0.000';
               setmodel (newmis,"progs/biggren.mdl");

            } else {

               if ( (Gren.weapon == 5.000) ) {

                  newmis.touch = NapalmGrenadeTouch;
                  //if (grentype)
                  //   newmis.think = NapalmGrenadeExplode2; 
                  //else
                     newmis.think = NapalmGrenadeExplode; 
                  newmis.skin = 2.000;
                  newmis.avelocity = '0.000 300.000 0.000';
                  setmodel (newmis,"progs/biggren.mdl");

               } else {

                  if ( (Gren.weapon == 6.000) ) {

                        newmis.touch = NormalGrenadeTouch;
                        newmis.think = FreezeGrenadeExplode;
                        newmis.skin = 1.000;
                        newmis.avelocity = '300.000 300.000 300.000';
                        setmodel (newmis,"progs/hgren2.mdl");

                     } else {

                     if ( (Gren.weapon == 7.000) ) {

                        newmis.touch = GasGrenadeTouch;
                        newmis.think = GasGrenadeExplode;
                        newmis.skin = 2.000;
                        newmis.avelocity = '300.000 300.000 300.000';
                        setmodel (newmis,"progs/grenade2.mdl");

                     } else {

                        if ( (Gren.weapon == 8.000) ) {

                           newmis.touch = EMPGrenadeTouch;
                           newmis.think = EMPGrenadeExplode;
                           newmis.skin = 4.000;
                           newmis.avelocity = '300.000 300.000 300.000';
                           setmodel (newmis,"progs/grenade2.mdl");

                        } else {

                           if ( (Gren.weapon == 10.000) ) {

                              newmis.touch = CaltropTouch;
                              newmis.think = ScatterCaltrops;


                           }
				else
				{
					if ((Gren.weapon == 9.000))
					{
						newmis.touch = FlashGrenadeTouch;
						newmis.think = FlashGrenadeExplode;
						newmis.skin = 2.000;
						newmis.avelocity = '300 300 300';
						setmodel (newmis, "progs/grenade2.mdl");
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
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,Gren.owner.origin);


   if ( ((Gren.owner.playerclass == 1.000) && (Gren.weapon != 10.000)) ) {

      bprint3 (1.000,"No ",Gren.owner.netname,", swallowing the grenade isn't very effective!\n");

   } else {

      if ( (Gren.owner.playerclass == 2.000) ) {

         bprint3 (1.000,"Well ",Gren.owner.netname,", don't quit your day job!\n");

      } else {

         if ( (Gren.owner.playerclass == 3.000) ) {

            bprint3 (1.000,"Ummm, ",Gren.owner.netname,", you're supposed to THROW the grenade!\n");

         } else {

            if ( (Gren.owner.playerclass == 4.000) ) {

               bprint3 (1.000,"Ack! ",Gren.owner.netname,"! The grenade is your friend for another reason!\n");

            } else {

               if ( (Gren.owner.playerclass == 5.000) ) {

                  bprint3 (1.000,"No ",Gren.owner.netname,"! Assist your own suicide some other time!\n");

                  } else {

                  if ( (Gren.owner.playerclass == 6.000) ) {

                     bprint3 (1.000,"Hey ",Gren.owner.netname,", you're not THAT heavy!\n");

                  } else {

                     if ( (Gren.owner.playerclass == 7.000) ) {

                        bprint3 (1.000,"Yes ",Gren.owner.netname,", the grenade does explode on '3'!\n");

                     } else {

                        if ( (Gren.owner.playerclass == 8.000) ) {

                           bprint3 (1.000,"You do realize ",Gren.owner.netname,", you can blow your cover in easier ways!\n");

                        } else {

                           if ( (Gren.owner.playerclass == 9.000) ) {

                              bprint3 (1.000,"Hey ",Gren.owner.netname,", study grenade dynamics on your own time!\n");

                           } else {

                              bprint3 (1.000,"No ",Gren.owner.netname,", throw the grenade, not the pin!\n");

                           }

                        }

                     }

                  }

               }

            }

         }

      }

   }
   dremove (Gren);

};

void () NormalGrenadeTouch = {

   if ( (other == self.owner) ) {

      return ;

   }
   sound (self,1.000,"weapons/bounce.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};

void () NormalGrenadeExplode = {

   deathmsg = 8.000;
   T_RadiusDamage (self,self.owner,180.000,world);
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   dremove (self);

};

void () TeamFortress_DisplayDetectionItems = {

   local entity Goal;
   local entity te;

   if (!self.playerclass) return;


   Goal = find (world,classname,"info_tfdetect");
   if ( !Goal ) {

      return ;

   }
   if ( (Goal.display_item_status1) ) {

      te = Finditem (Goal.display_item_status1);
      if ( te ) {

         sprint (self,2.000, ItemStatus (Goal,self,te));

      } else {

         sprint (self,2.000,"Item is missing.\n");

      }

   } else {
      sprint (self,2.000,"\n");
      return ;

   }
   if ( (Goal.display_item_status2) ) {

      te = Finditem (Goal.display_item_status2);
      if ( te ) {

         sprint (self,2.000, ItemStatus (Goal,self,te));

      } else {

         sprint (self,2.000,"Item is missing.\n");

      }

   } else {
      sprint (self,2.000,"\n");
      return ;

   }
   if ( (Goal.display_item_status3) ) {

      te = Finditem (Goal.display_item_status3);
      if ( te ) {

         sprint (self,2.000, ItemStatus (Goal,self,te));

      } else {

         sprint (self,2.000,"Item is missing.\n");

      }

   } else {
      sprint (self,2.000,"\n");
      return ;

   }
   if ( (Goal.display_item_status4) ) {

      te = Finditem (Goal.display_item_status4);
      if ( te ) {

         sprint (self,2.000, ItemStatus (Goal,self,te));

      } else {

         sprint (self,2.000,"Item is missing.\n");

      }

   }


};

void () BioInfection_Decay = {

   local entity te;
   local entity Bio;

   if ( (((teamplay & 16.000) && (self.owner.pteam == self.enemy.pteam)) && (self.owner.pteam.team != 0.000)) ) {

      self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 16.000));
      dremove (self);
      return ;

   } else {

      if ( (self.invincible_finished > time) ) {

         self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 16.000));
         dremove (self);
         return ;

      }

   }
   if ( (!(self.owner.tfstate & 16.000) || (self.owner.playerclass == 5.000)) ) {

      dremove (self);
      return ;

   }
   te = findradius (self.owner.origin,80.000);
   while ( ((te != world) && (te != self.owner)) ) {

      if ( (((te.classname == "player") && (te.deadflag == 0.000)) && (te.playerclass)) ) {

         if ( !(te.tfstate & 16.000) ) {

            if ( (te.playerclass != 5.000) ) {

               if ( !(((teamplay & 16.000) && (self.owner.pteam == self.enemy.pteam)) && (self.owner.pteam.team != 0.000)) ) {

                  Bio = spawn ();
                  Bio.nextthink = 2.000;
                  Bio.think = BioInfection_Decay;
                  Bio.owner = te;
                  Bio.classname = "timer";
                  Bio.enemy = self.enemy;
                  te.tfstate = (te.tfstate | 16.000);
                  te.infection_team_no = self.owner.infection_team_no;
                  sprint (te,1.000,"You have been infected by ");
                  sprint (te,1.000,self.owner.netname);
                  sprint (te,1.000,"!\n");
                  sprint (self.owner,1.000,"You have infected ");
                  sprint (self.owner,1.000,te.netname);
                  sprint (self.owner,1.000,"!\n");

               }

            }

         }

      }
      te = te.chain;

   }
   self.nextthink = (time + 3.000);
   deathmsg = 13.000;
   TF_T_Damage (self.owner,self,self.enemy,8.000,1.000,0.000);
   SpawnBlood (self.owner.origin,30.000);

};

void (string halias, float himpulse1, float himpulse2) TeamFortress_Alias = {

   local string imp;

   stuffcmd (self,"alias ");
   stuffcmd (self,halias);
   stuffcmd (self," \"impulse ");
   imp = ftos (himpulse1);
   stuffcmd (self,imp);
   if ( (himpulse2 != 0.000) ) {

      stuffcmd (self,";wait; impulse ");
      imp = ftos (himpulse2);
      stuffcmd (self,imp);

   }
   stuffcmd (self,"\"\n");

};

void () TeamFortress_Regenerate = {

 local float value;


 if (modetype & 256) 
    value = 2;
 else
    value = 4;

   if ( (self.owner.playerclass == 5.000) ) {

      self.nextthink = (time + 3.000);
      if ( (self.owner.has_disconnected == 1.000) ) {

         dremove (self);
         return ;

      }
      if ( (self.owner.health >= self.owner.max_health) ) {

         return ;

      }
      if ( (self.owner.ammo_medikit == 0.000) ) {

         return ;

      }
      if ( (self.owner.ammo_medikit < value) ) {

         self.owner.health = (self.owner.health + self.owner.ammo_medikit);
         self.owner.ammo_medikit = 0.000;

      } else {

         self.owner.health = (self.owner.health + value);
         self.owner.ammo_medikit = (self.owner.ammo_medikit - value);

      }
      if ( (self.owner.health > self.owner.max_health) ) {

         self.owner.health = self.owner.max_health;

      }

   }

};


float (vector veca, vector vecb) crossproduct = {

   local float result;

   result = ((veca_x * vecb_y) - (vecb_x * veca_y));
   return ( result );

};

void (entity pl, float fr, float type) TF_AddFrags = {

   local entity e;

   if ( ((intermission_running != 0.000) || (intermission_exittime > time)) ) {

      return ;

   }

   if (type == 1.000) {
      pl.real_frags = (pl.real_frags + fr);
   }

   if ( !pl.pteam.team ) {

      return ;

   }
   if ( (toggleflags & 2048.000) ) {

      pl.pteam.frags = (pl.pteam.frags + fr);

   }

   pl.pteam.real_frags = (pl.pteam.real_frags + fr);


   if ( (toggleflags & 2048.000) ) {

      e = player_head;
      while ( e ) {

         if ( (e.pteam == pl.pteam) ) {

            e.frags = e.pteam.frags;

         }
         e = e.nextp;

      }

   } else {

      if ( !(toggleflags & 128.000) ) {

         pl.frags = pl.frags + fr;

      }

   }

};

void (entity p) TeamFortress_ExecClassScript = {

   local string st;

   st = infokey (p,"ec");
   if ( (st == string_null) ) {

      st = infokey (p,"exec_class");

   }

   if ( (st == "on") || (self.tfkey & 2.000) ) {

      if ( (p.playerclass == 1.000) ) {

         stuffcmd (p,"exec scout.cfg\n");

      } else {

         if ( (p.playerclass == 2.000) ) {

            stuffcmd (p,"exec sniper.cfg\n");

         } else {

            if ( (p.playerclass == 3.000) ) {

               stuffcmd (p,"exec soldier.cfg\n");

            } else {

               if ( (p.playerclass == 4.000) ) {

                  stuffcmd (p,"exec demoman.cfg\n");

               } else {

                  if ( (p.playerclass == 5.000) ) {

                     stuffcmd (p,"exec medic.cfg\n");

                  } else {

                     if ( (p.playerclass == 6.000) ) {

                        stuffcmd (p,"exec hwguy.cfg\n");

                     } else {

                        if ( (p.playerclass == 7.000) ) {

                           stuffcmd (p,"exec pyro.cfg\n");

                        } else {

                           if ( (p.playerclass == 8.000) ) {

                              stuffcmd (p,"exec spy.cfg\n");

                           } else {

                              if ( (p.playerclass == 9.000) ) {

                                 stuffcmd (p,"exec engineer.cfg\n");

                              } else {

                                 if ( (p.playerclass == 11.000) ) {

                                    stuffcmd (p,"exec dm.cfg\n");

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

void (entity p) TeamFortress_ExecMapScript = {

   local string st;

   st = infokey (p,"em");
   if ( (st == string_null) ) {

      st = infokey (p,"exec_map");

   }
   if ( (st == "on") || (self.tfkey & 4.000) ) {

      stuffcmd (p,"exec mapdefault.cfg\n");
      stuffcmd (p,"exec ");
      stuffcmd (p,mapname);
      stuffcmd (p,".cfg\n");

   }

};



