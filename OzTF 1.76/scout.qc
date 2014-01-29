
void () CaltropTouch;
void () CaltropScatterThink;
void () ScatterCaltrops;

void () ConcussionGrenadeTouch;
void () ConcussionGrenadeExplode;

void () FlashGrenadeTouch;
void () FlashTimer;
void () FlashGrenadeExplode;

void (entity inflictor, entity attacker, float bounce, entity ignore) T_RadiusBounce;
entity (entity scanner, float scanrange, float enemies, float friends) T_RadiusScan;

void () CanisterTouch = {

   sound (self,1.000,"weapons/tink1.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};

void () CaltropTouch = {

   if ( (((other.classname != "player") || !(other.flags & 512.000)) || other.deadflag) ) {

      return ;

   }
   if ( ((((teamplay & 16.000) && (other != self.owner)) && (other.pteam == self.owner.pteam)) && (self.owner.pteam.team != 0.000)) ) {

      return ;

   }

   sprint (other,2.000,"Ow, Ow, Ow! Caltrops!\n");

   if (!modetype & 2)
   {
      other.leg_damage = (other.leg_damage + 2.000);
      TeamFortress_SetSpeed (other);
      deathmsg = 41.000;
      TF_T_Damage (other,self,self.owner,10.000,0.000, 0.000);
   }
   dremove (self);

};

void () CaltropScatterThink = {

   self.nextthink = (time + 0.200);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      if ( (self.flags & 512.000) ) {

         self.nextthink = ((time + 10.000) + (random () * 5.000));
         self.think = SUB_Remove;
         self.solid = 1.000;
         self.movetype = 6.000;
         self.touch = CaltropTouch;
         self.angles = '90.000 90.000 90.000';
         sound (self,0.000,"weapons/tink1.wav",1.000,1.000);
         setorigin (self,self.origin);
         return ;

      } else {

         self.nextthink = ((time + 10.000) + (random () * 5.000));
         self.think = SUB_Remove;
         self.solid = 1.000;
         self.movetype = 6.000;
         self.touch = CanisterTouch;
         setorigin (self,self.origin);
         return ;

      }

   }
   traceline (self.movedir,self.origin,1.000,self);
   if ( (trace_fraction == 1.000) ) {

      self.movedir = self.origin;
      return ;

   }
   self.velocity = (self.velocity * -1.000);
   self.heat = (self.heat + 1.000);
   if ( (self.heat > 10.000) ) {

      remove (self);
      return ;

   }

};

void () ScatterCaltrops = {

   local float num;
   local entity e;

   num = 6.000;
   while ( (num > 0.000) ) {

      e = spawn ();
      e.classname = "grenade";
      e.weapon = 10.000;
      e.owner = self.owner;
      e.pteam = self.owner.pteam;
      setmodel (e,"progs/caltrop.mdl");
      e.mins = '-4.000 -4.000 -8.000';
      e.maxs = '4.000 4.000 4.000';
      e.angles = '0.000 0.000 0.000';
      e.angles_x = (random () * 360.000);
      e.velocity_x = (crandom () * 100.000);
      e.velocity_y = (crandom () * 100.000);
      e.velocity_z = (200.000 + (random () * 100.000));
      e.avelocity_x = (crandom () * 400.000);
      e.avelocity_y = (crandom () * 400.000);
      e.avelocity_z = (crandom () * 400.000);
      setorigin (e,self.owner.origin);
      e.movedir = e.origin;
      e.heat = 0.000;
      e.movetype = 10.000;
      e.solid = 0.000;
      e.nextthink = (time + 0.200);
      e.think = CaltropScatterThink;
      num = (num - 1.000);

   }
   dremove (self);

};


void () ConcussionGrenadeTouch = {

   sound (self,1.000,"weapons/bounce.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};

void () ConcussionGrenadeExplode = {

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


   T_RadiusBounce (self,self.owner,240.000,world);
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   dremove (self);

};


void () ConcussionGrenadeTimer = {

   local string st;
   local vector src;
   local float pos, stumble, fl;

   if ( (self.owner.invincible_finished > time) ) {

      sprint (self.owner,2.000,"Your head feels better now.\n");
      dremove (self);
      return ;

   }

   if ( (self.owner.deadflag > 0.000) ) {

      dremove (self);
      return ;

   }


	self.cnt = self.cnt + 1;
	fl = self.cnt / 15;

   if ((fl == 1) || (fl == 2) || (fl == 3) || (fl == 4) || (fl == 5)) {

      newmis = spawn ();
      setmodel (newmis,"progs/s_bubble.spr");
      setorigin (newmis,self.owner.origin);
      newmis.movetype = 8.000;
      newmis.solid = 0.000;
      newmis.velocity = '0.000 0.000 15.000';
      newmis.nextthink = (time + 0.500);
      newmis.think = bubble_bob;
      newmis.touch = bubble_remove;
      newmis.classname = "bubble";
      newmis.frame = 0.000;
      newmis.cnt = 0.000;
      setsize (newmis,'0 0 0','0 0 0');

   }

 
   if (conctype)
   {

       self.health = (self.health - 20.000);
       if (self.owner.playerclass == 5.000)
       {
          self.health = (self.health - 20.000);
       }
       self.nextthink = (time + 0.500);

	if (!self.spawnflags)
	{

      	stuffcmd (self.owner, "v_iroll_cycle 0.5\n");
       	stuffcmd (self.owner, "v_ipitch_cycle 1\n");
       	stuffcmd (self.owner, "v_iyaw_cycle 2\n");
		self.spawnflags = 1.000;
	}

       st = ftos (self.health / 7.500);
       stuffcmd (self.owner, "v_idlescale ");
       stuffcmd (self.owner, st);
       stuffcmd (self.owner, "\n");



    }
    else
    {
       self.health = (self.health - 10.000);
       if (self.owner.playerclass == 5.000)
       {
          self.health = (self.health - 10.000);
       }


       self.nextthink = (time + 0.250);
       pos = pointcontents (self.owner.origin);
       src_x = ((self.owner.origin_x + self.owner.maxs_x) + 2.000);
       src_y = ((self.owner.origin_y + self.owner.maxs_y) + 2.000);
       src_z = self.owner.origin_z;
       pos = pointcontents (src);
       if ( ((self.owner.flags & 512.000) || (self.owner.flags & 16.000)) ) {

          if ( (!self.owner.is_feigning) || (!self.owner.invincible_finished)) {

	       makevectors (self.owner.v_angle);
             stumble = (crandom () * self.health);
             if (self.owner.playerclass == 6.000) stumble = stumble / 3;

             if ( !((pos == -2.000) && (self.owner.velocity == '0.000 0.000 0.000')) ) {

                if ( (crandom () < 0.000) ) {

                   self.owner.velocity_x = (self.owner.velocity_y + stumble);
                   self.owner.velocity_y = (self.owner.velocity_x + stumble);

                } else {

                   self.owner.velocity_x = ((-1.000 * self.owner.velocity_y) + stumble);
                   self.owner.velocity_y = ((-1.000 * self.owner.velocity_x) + stumble);

                }
             }
          }
       }
    }


    if ( (self.health <= 0.000) ) {

      sprint (self.owner,2.000,"Your head feels better now.\n");
      if (conctype)  stuffcmd (self.owner, "v_idlescale 0\n");
      dremove (self);

    }


};


void () TeamFortress_Scan = {

   local entity list;
   local float scancost;
   local float scanrange;
   local float scen;
   local float scfr;
   local float num;
   local vector lightningvec;
   local float enemy_detected;
   local float any_detected;

   scanrange = 100.000;
   self.owner.impulse = 0.000;
   self.owner.last_impulse = 0.000;
   if ( (self.owner.classname == "player") ) {

      if ( !(self.owner.tf_items & 1.000) ) {

         return ;

      }
      scancost = 2.000;
      if ( (self.owner.ammo_cells <= 0.000) ) {

         sprint (self.owner,2.000,"Not enough cells to run scanner.\n");
         self.owner.ammo_cells = 0.000;
         W_SetCurrentAmmo ();
         self.owner.ScannerOn = 0.000;
         dremove (self);
         return ;

      }
      if ( (scancost > self.owner.ammo_cells) ) {

         scanrange = (self.owner.ammo_cells * 20.000);
         scancost = self.owner.ammo_cells;
         W_SetCurrentAmmo ();

      }
      scen = 0.000;
      scfr = 0.000;
      if ( (self.owner.tf_items_flags & 1.000) ) {

         scen = 1.000;

      }
      if ( (self.owner.tf_items_flags & 2.000) ) {

         scfr = 1.000;

      }
      if ( ((scen == 0.000) && (scfr == 0.000)) ) {

         sprint (self.owner,2.000,"No target specified.\n");
         self.owner.ScannerOn = 0.000;
         dremove (self);
         return ;

      }
      self.owner.ammo_cells = (self.owner.ammo_cells - 2.000);
      if ( (self.owner.ammo_cells < 0.000) ) {

         self.owner.ammo_cells = 0.000;

      }
      W_SetCurrentAmmo ();
      scanrange = (scanrange * 25.000);
      list = T_RadiusScan (self.owner,scanrange,scen,scfr);

   }
   scen = 0.000;
   scfr = 0.000;
   makevectors (self.owner.v_angle);
   if ( (list != world) ) {

      any_detected = 1.000;
      if ( ((((list.pteam.team > 0.000) && (self.owner.pteam.team > 0.000)) && (list.pteam == self.owner.pteam)) && ((list.classname == "player") || (list.classname == "building_sentrygun"))) ) {

         scfr = (scfr + 1.000);
         enemy_detected = 0.000;

      } else {

         if ( ((((list.goal_no > 0.000) && (self.owner.pteam.team > 0.000)) && (list.goal_no == self.owner.pteam.team)) && (list.classname == "item_tfgoal")) ) {

            scfr = (scfr + 1.000);
            enemy_detected = 0.000;

         } else {

            scen = (scen + 1.000);
            enemy_detected = 1.000;

         }

      }
      if ( any_detected ) {

         lightningvec = normalize ((list.origin - self.owner.origin));
         lightningvec = (lightningvec * (vlen ((list.origin - self.owner.origin)) / 5.000));
         lightningvec = (lightningvec + self.owner.origin);
         msg_entity = self.owner;
         WriteByte (1.000,23.000);
         WriteByte (1.000,5.000);
         WriteEntity (1.000,self.owner);
         WriteCoord (1.000,self.owner.origin_x);
         WriteCoord (1.000,self.owner.origin_y);
         WriteCoord (1.000,(self.owner.origin_z + 8.000));
         WriteCoord (1.000,lightningvec_x);
         WriteCoord (1.000,lightningvec_y);
         WriteCoord (1.000,(lightningvec_z + 8.000));
         if ( (self.owner.tf_items_flags & 4.000) ) {

            stuffcmd (self.owner,"play misc/basekey.wav\n");

         }
         num = vlen ((list.origin - self.owner.origin));
         num = (num / 10.000);
         num = (num / 3.000);
         num = rint (num);
         self.health = num;
         if ( (list.classname == "player") ) {

            if ( ((list.playerclass == 8.000) && (list.pteam != self.owner.pteam)) ) {

               if ( (list.undercover_skin != 0.000) ) {

                  self.playerclass = list.undercover_skin;

               } else {

                  self.playerclass = list.playerclass;

               }
               if ( (list.undercover_team != 0.000) ) {

                  self.pteam.team = list.undercover_team;

               } else {

                  self.pteam = list.pteam;

               }

            } else {

               self.playerclass = list.playerclass;
               self.pteam = list.pteam;

            }

         } else {

            if ( (list.classname == "building_sentrygun") ) {

               self.playerclass = 13.000;
               self.pteam = list.pteam;

            } else {

               if ( (list.classname == "item_tfgoal") ) {

                  self.playerclass = 14.000;
                  self.pteam.team = list.goal_no;

               }

            }

         }
         self.owner.StatusRefreshTime = (time + 0.200);

      }

   }
   if ( ((scen == 0.000) && (scfr == 0.000)) ) {

      self.health = 0.000;
      self.owner.StatusRefreshTime = (time + 0.200);
      self.nextthink = (time + 2.000);
      return ;

   }
   W_SetCurrentAmmo ();
   self.nextthink = (time + 2.000);
   return ;

};

void () ScannerSwitch = {

   local entity te;

   if ( (self.ScannerOn != 1.000) ) {

      te = spawn ();
      te.nextthink = (time + 2.000);
      te.think = TeamFortress_Scan;
      te.owner = self;
      te.classname = "timer";
      te.netname = "scanner";
      sprint (self,2.000,"Scanner On.\n");
      self.ScannerOn = 1.000;

   } else {

      te = find (world,netname,"scanner");
      while ( te ) {

         if ( (te.owner == self) ) {

            dremove (te);

         }
         te = find (te,netname,"scanner");

      }
      sprint (self,2.000,"Scanner Off.\n");
      self.ScannerOn = 0.000;

   }

};
void (entity inflictor, entity attacker, float bounce, entity ignore) T_RadiusBounce = {

   local float points;
   local float accel;
   local float length;
   local float nextloop;
   local entity head;
   local entity te;
   local vector org;

   head = findradius (inflictor.origin,(bounce + 40.000));
   while ( head ) {

	head.chain2 = head.chain;
      nextloop = 0.000;

      if ( (head != ignore) ) {

         if ( head.takedamage ) {

            org = (head.origin + ((head.mins + head.maxs) * 0.500));
            points = (0.500 * vlen ((org - inflictor.origin)));
            if ( (points < 0.000) ) {

               points = 0.000;

            }
            accel = (bounce - points);



            if ( ((((head.classname != "building_dispenser") && (head.classname != "building_sentrygun")) && (head.classname != "building_sentrygun_base")) && (points > 0.000)) ) {

               head.velocity = (org - inflictor.origin);
               head.velocity = (head.velocity * (accel / 20.000));

               if ( (head.classname == "player") ) {

                  te = find (world,classname,"timer");

                  while ( (((te.owner != head) || (te.think != ConcussionGrenadeTimer)) && (te != world)) ) {

                     te = find (te,classname,"timer");

                  }

                  if (grenradius & 1) {
                     if ( !CanDamage (head,te) ) nextloop = 1.000;
                  }

                  if (modetype & 2) nextloop = 1.000;

                  if (!nextloop) {

                  if (conctype) {
                     length = 800.000 - points;
                  } else {
                     length = 750.000 - points;
                  }

                  if ( (te != world) ) {

                     te.health = length;
                     te.nextthink = (time + frametime);

                  } else {

                     te = spawn ();
                     te.nextthink = (time + frametime);
                     te.think = ConcussionGrenadeTimer;
                     te.pteam = attacker.pteam;
                     te.classname = "timer";
                     te.owner = head;
                     te.health = length;


                  }
                  }
               }

            }

         }

      }
      head = head.chain2;

   }

};
entity (entity scanner, float scanrange, float enemies, float friends) T_RadiusScan = {

   local entity head;
   local float rangedist;

   rangedist = 0.000;
   head = world;
   while ( (rangedist <= scanrange) ) {

      if ( (rangedist <= 0.000) ) {

         rangedist = 1.000;

      }
      head = findradius (scanner.origin,rangedist);
      while ( head ) {

         if ( (head != scanner) ) {

            if ( (((head.takedamage != 0.000) && (head.health > 0.000)) || (head.classname == "item_tfgoal")) ) {

               if ( (((head.classname == "player") || (head.classname == "building_sentrygun")) && (friends || enemies)) ) {

                  if ( teamplay ) {

                     if ( (((friends != 0.000) && (head.pteam.team > 0.000)) && (scanner.pteam.team > 0.000)) ) {

                        if ( ((head.playerclass == 8.000) && (head.pteam != scanner.pteam)) ) {

                           if ( (head.is_feigning != 1.000 ) ) {

                              if ( (head.undercover_team == scanner.pteam.team) ) {

                                 return ( head );

                              }

                           }

                        } else {

                           if ( (head.pteam == scanner.pteam) ) {

                              return ( head );

                           }

                        }

                     }
                     if ( (((enemies != 0.000) && (head.pteam.team > 0.000)) && (scanner.pteam.team > 0.000)) ) {

                        if ( ((head.playerclass == 8.000) && (head.pteam != scanner.pteam)) ) {

                           if ( (head.is_feigning != 1.000) ) {

                              if ( (head.undercover_team != scanner.pteam.team) ) {

                                 return ( head );

                              }

                           }

                        } else {

                           if ( (head.pteam != scanner.pteam) ) {

                              return ( head );

                           }

                        }

                     }

                  } else {

                     return ( head );

                  }

               } else {

                  if ( ((head.classname == "item_tfgoal") && (friends || enemies)) ) {

                     if ( teamplay ) {

                        if ( ((((friends != 0.000) && (head.goal_no > 0.000)) && (scanner.pteam.team > 0.000)) && (head.goal_no == scanner.pteam.team)) ) {

                           return ( head );

                        }
                        if ( ((((enemies != 0.000) && (head.pteam.team > 0.000)) && (scanner.pteam.team > 0.000)) && (head.goal_no != scanner.pteam.team)) ) {

                           return ( head );

                        }

                     }

                  }

               }

            }

         }
         head = head.chain;

      }
      rangedist = (rangedist + 100.000);

   }
   return ( world );

};



void () FlashGrenadeTouch =
{
	sound (self, 1, "weapons/bounce.wav", 1, 1);
	if ((self.velocity == '0 0 0'))
	{
		self.avelocity = '0 0 0';
	}
};

void () FlashTimer =
{
	local entity te;
	local string st;

	te = self.owner;
	te.FlashTime = (te.FlashTime - 0.6);
	if ((te.FlashTime < 3))
	{
		te.FlashTime = 0.000000;
		stuffcmd (te, "v_cshift 0 0 0 0\n");
		remove (self);
		return;
	}
	st = ftos ((te.FlashTime * 10));
	stuffcmd (te, "v_cshift ");
	stuffcmd (te, st);
	stuffcmd (te, " ");
	stuffcmd (te, st);
	stuffcmd (te, " ");
	stuffcmd (te, st);
	stuffcmd (te, " ");
	stuffcmd (te, st);
	stuffcmd (te, "\n");
	self.nextthink = (time + 0.6);
};

void () FlashGrenadeExplode =
{
	local entity te;
	local string st;
      local float dist;

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

	self.effects = (self.effects | 4);
	WriteByte (4, 23);
	WriteByte (4, 4);
	WriteCoord (4, self.origin_x);
	WriteCoord (4, self.origin_y);
	WriteCoord (4, self.origin_z);
	multicast (self.origin, 1);
	te = findradius (self.origin, 300);
	while (te)
	{
		if ((te.classname == "player"))
		{
			traceline (self.origin, te.origin, 1, self);
			if ((trace_fraction == 1))
			{

                        dist = vlen ((self.origin - te.origin));
				if (dist <= 200)
				{
					deathmsg = 35;
					TF_T_Damage (te, self, self.owner, 60, 2, (16 | 4));
				}
				if ((te.health > 0.000000))
				{

                           if (grenradius & 1)
                           {
                              if ( !CanDamage (te,self) ) return;
                           }
                           
					if ((te.FlashTime == 0.000000))
					{
						newmis = spawn ();
						newmis.classname = "timer";
						newmis.netname = "flashtimer";
						newmis.pteam = self.owner.pteam;
						newmis.owner = te;
						newmis.think = FlashTimer;
						newmis.nextthink = (time + 1);
					}

					if ((te == self.owner))
					{
						if (dist > 40)
						{
						   te.FlashTime  = 16 - (16 * dist / 200);
                                    } 
                                    else 
						{
						   te.FlashTime = 16;
						}
					}
					else
					{
						if (dist > 40)
						{
						   te.FlashTime  = 20 - (20 * dist / 200);
                                    } 
                                    else 
						{
						   te.FlashTime = 20;
						}
					}
					st = ftos ((te.FlashTime * 10));
					stuffcmd (te, "v_cshift ");
					stuffcmd (te, st);
					stuffcmd (te, " ");
					stuffcmd (te, st);
					stuffcmd (te, " ");
					stuffcmd (te, st);
					stuffcmd (te, " ");
					stuffcmd (te, st);
					stuffcmd (te, "\n");
				}
			}
		}
		te = te.chain;
	}
	dremove (self);
};
