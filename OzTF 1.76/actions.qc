void () TeamFortress_SaveMe = {

   local entity te;
   local entity tl;

   if ( (self.last_sound < time) ) {

      if ( (random () < 0.800) ) {

         sound (self,1.000,"speech/saveme1.wav",1.000,1.000);

      } else {

         sound (self,1.000,"speech/saveme2.wav",1.000,1.000);

      }
      self.last_sound = (time + 4.000);

   }
   te = player_head;
   while ( te ) {

      if ( ((((self == te) || (te.playerclass == 5.000)) || (te.playerclass == 9.000)) || (te.playerclass == 8.000)) ) {

         if ( (((te.pteam == self.pteam) && (self.pteam.team != 0.000)) || (te.playerclass == 8.000)) ) {

            if ( visible (te) ) {

               msg_entity = te;
               tl = spawn ();
               tl.origin = self.origin;
               tl.origin_z = (tl.origin_z + 32.000);
               WriteByte (1.000,23.000);
               WriteByte (1.000,9.000);
               WriteEntity (1.000,tl);
               WriteCoord (1.000,tl.origin_x);
               WriteCoord (1.000,tl.origin_y);
               WriteCoord (1.000,(tl.origin_z + 24.000));
               WriteCoord (1.000,self.origin_x);
               WriteCoord (1.000,self.origin_y);
               WriteCoord (1.000,self.origin_z);
               dremove (tl);

            }

         }

      }
      te = te.nextp;

   }

};


void () TeamFortress_ID = {

   local vector src;
   local string st;
   local string cls;

   src = (self.origin + (v_forward * 10.000));
   src_z = (self.absmin_z + (self.size_z * 0.700));
   traceline (src,(src + (v_forward * 2048.000)),0.000,self);

   if ( ((trace_ent != world) && (trace_ent.origin != world.origin)) ) {


      if ( ((trace_ent.classname == "player") && (trace_ent.health > 0.000)) ) {

         if ( ((trace_ent.is_feigning && (self.pteam.team != 0.000)) && (self.pteam != trace_ent.pteam)) ) {

            return ;

         }
         self.StatusRefreshTime = (time + 1.500);
         if ( (((self.pteam.team != 0.000) && (self.pteam == trace_ent.pteam)) || (self.classname == "observer")) ) {

            cls = TeamFortress_GetClassName (trace_ent.playerclass);
            if ( (self.playerclass == 5.000) ) {

               st = ftos ( rint (trace_ent.health));
               centerprint7 (self,"\n\n\n\n",trace_ent.netname,"\nFriendly ",cls,"\n",st," health\n");
               return ;

            } else {

               if ( (self.playerclass == 9.000) ) {

                  st = ftos( rint (trace_ent.armorvalue));
                  centerprint7 (self,"\n\n\n\n",trace_ent.netname,"\nFriendly ",cls,"\n",st," armor\n");
                  return ;

               }

            }
            centerprint4 (self,"\n\n\n\n",trace_ent.netname,"\nFriendly ",cls);
            return ;

         }
         if ( (trace_ent.playerclass == 8.000) ) {

            cls = TeamFortress_GetClassName (trace_ent.undercover_skin);
            if ( ((self.pteam.team != 0.000) && (self.pteam.team == trace_ent.undercover_team)) ) {

               if ( (self.playerclass == 5.000) ) {

                  st = ftos ( rint (trace_ent.health));
                  if ( (trace_ent.undercover_skin != 0.000) ) {

                     centerprint7 (self,"\n\n\n\n",trace_ent.undercover_name,"\nFriendly ",cls,"\n",st," health\n");

                  } else {

                     centerprint5 (self,"\n\n\n\n",trace_ent.undercover_name,"\nFriendly Spy\n",st," health\n");

                  }
                  return ;

               } else {

                  if ( (self.playerclass == 9.000) ) {

                     st = ftos ( rint (trace_ent.armorvalue));
                     if ( (trace_ent.undercover_skin != 0.000) ) {

                        centerprint7 (self,"\n\n\n\n",trace_ent.undercover_name,"\nFriendly ",cls,"\n",st," armor\n");

                     } else {

                        centerprint5 (self,"\n\n\n\n",trace_ent.undercover_name,"\nFriendly Spy\n",st," armor\n");

                     }
                     return ;

                  } else {

                     st = ftos ( rint (trace_ent.armorvalue));
                     if ( (trace_ent.undercover_skin != 0.000) ) {

                        centerprint4 (self,"\n\n\n\n",trace_ent.undercover_name,"\nFriendly ",cls);

                     } else {

                        centerprint3 (self,"\n\n\n\n",trace_ent.undercover_name,"\nFriendly Spy\n");

                     }
                     return ;

                  }

               }

            }
            if ( (trace_ent.undercover_name != string_null) ) {

               if ( (trace_ent.undercover_skin != 0.000) ) {

                  centerprint4 (self,"\n\n\n\n",trace_ent.undercover_name,"\nEnemy ",cls);

               } else {

                  centerprint3 (self,"\n\n\n\n",trace_ent.undercover_name,"\nEnemy Spy");

               }

            } else {

               if ( (trace_ent.undercover_skin != 0.000) ) {

                  centerprint4 (self,"\n\n\n\n",trace_ent.netname,"\nEnemy ",cls);

               } else {

                  centerprint3 (self,"\n\n\n\n",trace_ent.netname,"\nEnemy Spy");

               }

            }

         } else {

            cls = TeamFortress_GetClassName (trace_ent.playerclass);
            centerprint4 (self,"\n\n\n\n",trace_ent.netname,"\nEnemy ",cls);

         }

      } else {

         if ( (trace_ent.classname == "building_dispenser") ) {

            self.StatusRefreshTime = (time + 1.500);
            if ( (self == trace_ent.real_owner) ) {

               centerprint (self,"\n\n\n\nYour Dispenser");

            } else {

               centerprint2 (self,"\n\n\n\nDispenser made by ",trace_ent.real_owner.netname);

            }

         } else {

            if ( ((trace_ent.classname == "building_sentrygun") || (trace_ent.classname == "building_sentrygun_base")) ) {

               self.StatusRefreshTime = (time + 1.500);
               if ( (self == trace_ent.real_owner) ) {

                  centerprint (self,"\n\n\n\nYour SentryGun");

               } else {

                  if ( !teamplay ) {

                     centerprint2 (self,"\n\n\n\nSentrygun made by\n",trace_ent.real_owner.netname);

                  } else {

                     if ( (((self.pteam.team != 0.000) && (self.pteam == trace_ent.pteam)) || (!self.playerclass)) ) {

                        centerprint2 (self,"\n\n\n\nFriendly Sentrygun made by\n",trace_ent.real_owner.netname);

                     } else {

                        centerprint2 (self,"\n\n\n\nEnemy Sentrygun made by\n",trace_ent.real_owner.netname);

                     }

                  }

               }

            }

         }

      }

   }

};

void () Medikit_Fire = {

   local entity te;
   local entity BioInfection;
   local float healam;
   local vector org;

   org = (trace_endpos - (v_forward * 4.000));

      if ( (trace_ent.classname == "player") ) {

         if ( (((trace_ent.pteam == self.pteam) && (self.pteam.team != 0.000)) || coop) ) {

            healam = 200.000;
            te = find (world,classname,"timer");
            while ( (((te.owner != trace_ent) || ((te.think != ConcussionGrenadeTimer))) && (te != world)) ) {

               te = find (te,classname,"timer");

            }
            if ( (te != world) ) {


               SpawnBlood (org,20.000);
               bprint (1.000,self.netname);
               bprint (1.000," cured ");
               bprint (1.000,trace_ent.netname);
               bprint (1.000,"'s concussion\n");
               if ( (te.pteam != self.pteam) ) {

                  TF_AddFrags (self,1.000, 0.000);

               }
               dremove (te);

            }
            if ( (trace_ent.tfstate & 16384.000) ) {

               te = find (world,classname,"timer");
               while ( (((te.owner != trace_ent) || (te.think != HallucinationTimer)) && (te != world)) ) {

                  te = find (te,classname,"timer");

               }
               if ( (te != world) ) {

                  trace_ent.tfstate = (trace_ent.tfstate - (trace_ent.tfstate & 16384.000));
                  SpawnBlood (org,20.000);
                  bprint (1.000,self.netname);
                  bprint (1.000," healed ");
                  bprint (1.000,trace_ent.netname);
                  bprint (1.000," of his hallucinations\n");

                  if ( (te.pteam != self.pteam) ) {

                     TF_AddFrags (self,1.000, 0.000);

                  }
                  dremove (te);

               } else {

                  dprint ("Warning: Error in Hallucination Timer logic.\n");

               }

            }
            if ( (trace_ent.tfstate & 32768.000) ) {

               te = find (world,classname,"timer");
               while ( (((te.owner != trace_ent) || (te.think != TranquiliserTimer)) && (te != world)) ) {

                  te = find (te,classname,"timer");

               }
               if ( (te != world) ) {

                  trace_ent.tfstate = (trace_ent.tfstate - (trace_ent.tfstate & 32768.000));
                  TeamFortress_SetSpeed (trace_ent);
                  SpawnBlood (org,20.000);
                  bprint (1.000,self.netname);
                  bprint (1.000," healed ");
                  bprint (1.000,trace_ent.netname);
                  bprint (1.000,"'s tranquilisation\n");
                  if ( (te.pteam != self.pteam) ) {

                     TF_AddFrags (self,1.000, 0.000);

                  }
                  dremove (te);

               } else {

                  dprint ("Warning: Error in Tranquilisation Timer logic.\n");

               }

		}
				if ((trace_ent.FlashTime > 0.000))
				{
					te = find (world, netname, "flashtimer");
					while ((((te.owner != trace_ent) || (te.classname != "timer")) && (te != world)))
					{
						te = find (te, netname, "flashtimer");
					}
					if ((te != world))
					{
						trace_ent.FlashTime = 0.000;
						SpawnBlood (org, 20);
						bprint (1, self.netname);
						bprint (1, " cured ");
						bprint (1, trace_ent.netname);
						bprint (1, "'s blindness\n");
						if ((te.pteam != self.pteam))
						{
							TF_AddFrags (self, 1.000, 0.000);
						}
						dremove (te);
					}
					else
					{
						dprint ("Warning: Error in Flash Timer logic.\n");
						trace_ent.FlashTime = 0.000;
					}
				}

            if ( (trace_ent.tfstate & 16.000) ) {

               healam = rint ((trace_ent.health / 2.000));
               trace_ent.tfstate = (trace_ent.tfstate - (trace_ent.tfstate & 16.000));
               deathmsg = 23.000;
               TF_T_Damage (trace_ent,self,self,healam, 1.000, 0.000);
               SpawnBlood (org,30.000);
               if ( (self.classname == "player") ) {

                  bprint (1.000,self.netname);
                  bprint (1.000," cured ");
                  bprint (1.000,trace_ent.netname);
                  bprint (1.000,"'s infection\n");
                  if ( (trace_ent.infection_team_no != self.pteam.team) ) {

                     TF_AddFrags (self,1.000, 0.000);

                  }

               }
               return ;

            }
            if ( (trace_ent.numflames > 0.000) ) {

               sound (trace_ent,1.000,"items/r_item1.wav",1.000,1.000);
               trace_ent.numflames = 0.000;
               if ( (self.classname == "player") ) {

                  bprint (1.000,self.netname);
                  bprint (1.000," put out ");
                  bprint (1.000,trace_ent.netname);
                  bprint (1.000,"'s fire.\n");

               }
               return ;

            }
            if ( ((healam > 0.000) && (trace_ent.health < trace_ent.max_health)) ) {

               sound (trace_ent,1.000,"items/r_item1.wav",1.000,1.000);
               trace_ent.axhitme = 1.000;
               SpawnBlood (org,20.000);
               T_Heal (trace_ent,healam,0.000);

            } else {

               if ( ((trace_ent.health >= trace_ent.max_health) && (trace_ent.health < (trace_ent.max_health + 50.000))) ) {

                  healam = 5.000;
                  if ( (healam > (self.ammo_medikit * 5.000)) ) {

                     healam = (self.ammo_medikit * 5.000);

                  }
                  if ( (healam > 0.000) ) {

                     sound (trace_ent,3.000,"items/r_item2.wav",1.000,1.000);
                     T_Heal (trace_ent,healam,1.000);
                     self.ammo_medikit = (self.ammo_medikit - rint ((healam / 5.000)));
                     if ( !(trace_ent.items & 65536.000) ) {

                        trace_ent.items = (trace_ent.items | 65536.000);
                        newmis = spawn ();
                        newmis.nextthink = (time + 5.000);
                        newmis.think = item_megahealth_rot;
                        newmis.owner = trace_ent;

                     }

                  }

               }

            }

         } else {

            trace_ent.axhitme = 1.000;
            SpawnBlood (org,20.000);
            deathmsg = 14.000;
            TF_T_Damage (trace_ent,self,self,10.000, 0.000, 0.000);
            if ( (trace_ent.playerclass == 5.000) ) {

               return ;

            }
            if ( (cb_prematch) ) {

               return ;

            }
            if ( (trace_ent.tfstate & 16.000) ) {

               return ;

            }
            trace_ent.tfstate = (trace_ent.tfstate | 16.000);
            BioInfection = spawn ();
            BioInfection.classname = "timer";
            BioInfection.owner = trace_ent;
            BioInfection.nextthink = (time + 2.000);
            BioInfection.think = BioInfection_Decay;
            BioInfection.enemy = self;
            trace_ent.infection_team_no = self.pteam.team;

         }

      }
};

void () Spanner_Fire = {

local float healam;
local vector org;

   org = (trace_endpos - (v_forward * 4.000));

   if ( (trace_ent.classname == "building_dispenser") ) {

      Engineer_UseDispenser (trace_ent);
      return ;

   } else {

      if ( (trace_ent.classname == "building_sentrygun") ) {

         Engineer_UseSentryGun (trace_ent);
         return ;

      } else {

         if ( (trace_ent.classname == "building_sentrygun_base") ) {

            if ( trace_ent.oldenemy ) {

               Engineer_UseSentryGun (trace_ent.oldenemy);

            }
            return ;

         } else {

            if ( (trace_ent.classname == "building_antispam") ) {

               trace_ent.think = T_Antispam;
               trace_ent.nextthink = time + 0.200;
               return ;

            } else {

               if ( (trace_ent.classname == "player") ) {

                  if ( ((((trace_ent.pteam == self.pteam) && (self.pteam.team != 0.000)) && teamplay) || coop) ) {

                     healam = 10.000;
                     if ( (self.ammo_cells < healam) ) {

                        healam = self.ammo_cells;

                     }
                     if ( (trace_ent.armortype == 0.000) ) {

                        return ;

                     }
                     if ( ((trace_ent.maxarmor - trace_ent.armorvalue) < (healam * 4.000)) ) {

                        healam = ceil (((trace_ent.maxarmor - trace_ent.armorvalue) / 4.000));

                     }
                     if ( (healam > 0.000) ) {

                        trace_ent.armorvalue = (trace_ent.armorvalue + (healam * 4.000));
                        if ( (trace_ent.armorvalue > trace_ent.maxarmor) ) {

                           trace_ent.armorvalue = trace_ent.maxarmor;

                        }
                        self.ammo_cells = (self.ammo_cells - healam);
                        sound (trace_ent,1.000,"items/r_item1.wav",1.000,1.000);
                        WriteByte (4.000,23.000);
                        WriteByte (4.000,2.000);
                        WriteByte (4.000,3.000);
                        WriteCoord (4.000,org_x);
                        WriteCoord (4.000,org_y);
                        WriteCoord (4.000,org_z);
                        multicast (org,2.000);
                        W_SetCurrentAmmo ();
                        stuffcmd( self, "-use\n");
                     }
                     return ;

                  }

               }
               trace_ent.axhitme = 1.000;
               SpawnBlood (org,20.000);
               deathmsg = 32.000;
               TF_T_Damage (trace_ent,self,self,20.000,2.000,0.000);
               stuffcmd( self, "-use\n");
            }

         }

      }
   }
};