void () Napalm_touch;

void () T_MissileTouch;

void () info_player_start;

void (entity targ, entity attacker) ClientObituary;

void (entity Goal, entity AP, float addb) DoResults;
float (entity Goal, entity AP) Activated;


float (entity targ, entity inflictor) CanDamage = {

   local vector offset;

   traceline (inflictor.origin,targ.origin,0.000,self);
   if (trace_ent.classname == "func_glass") {
      return  (0.000);
   }
 


   if ( (targ.movetype == 7.000) ) {

      traceline (inflictor.origin,(0.500 * (targ.absmin + targ.absmax)),1.000,self);
      if ( (trace_fraction == 1.000) ) {

         return ( 1.000 );

      }
      if ( (trace_ent == targ) ) {

         return ( 1.000 );

      }

      return ( 0.000 );

   }



	traceline (inflictor.origin, targ.origin, 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_z = 0.000000;
	offset_y = targ.maxs_y * 0.500000;
	offset_x = targ.maxs_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_x = targ.mins_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_y = targ.mins_y * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_x = targ.maxs_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_z = targ.maxs_z * 0.500000;
	offset_y = targ.maxs_y * 0.500000;
	offset_x = targ.maxs_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_x = targ.mins_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_y = targ.mins_y * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_x = targ.maxs_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_z = targ.mins_z * 0.500000;
	offset_y = targ.maxs_y * 0.500000;
	offset_x = targ.maxs_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_x = targ.mins_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_y = targ.mins_y * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	offset_x = targ.maxs_x * 0.500000;
	traceline (inflictor.origin, (targ.origin + offset), 1.000000, self);
	if ((trace_fraction == 1.000000))
	{
		return (1.000000);
	}
	return (0.000000);

   return ( 0.000 );

};

void (entity targ, entity attacker) Killed = {

   local entity oself;

   oself = self;
   self = targ;
   if ( (self.health < -99.000) ) {

      self.health = -99.000;

   }
   if ( ((self.movetype == 7.000) || (self.movetype == 0.000)) ) {

      self.th_die ();

      self = oself;
      return ;

   }
   self.enemy = attacker;
   if ( (self.flags & 32.000) ) {

      killed_monsters = (killed_monsters + 1.000);
      WriteByte (2.000,27.000);

   }
   ClientObituary (self,attacker);
   self.takedamage = 0.000;
   self.touch = SUB_Null;

   self.th_die ();
   self = oself;

};

/*

void (entity targ, entity inflictor, entity attacker, float damage) T_Damage = {

   local vector dir;
   local entity oldself;
   local entity te;
   local float save;
   local float take;

   if ( !targ.takedamage ) {

      return ;

   }
   if (round_active) {
      round_pause = time;
   }
   if ( (attacker.classname == "player") ) {

      damage = (damage * 0.900);

   }
   if ( (attacker.classname == "player") ) {

      if ( (attacker.super_damage_finished > time) ) {

         damage = (damage * 4.000);

      }
      if ( (targ.classname != "player") ) {

         if ( !Activated (targ,attacker) ) {

            if ( (targ.else_goal != 0.000) ) {

               te = Findgoal (targ.else_goal);
               if ( te ) {

                  AttemptToActivate (te,attacker,targ);

               }

            }
            return ;

         }

      }

   }
   damage_attacker = attacker;

   save = ceil ((targ.armortype * damage));
   if ( (save >= targ.armorvalue) ) {

      save = targ.armorvalue;
      targ.armortype = 0.000;
      targ.armorclass = 0.000;
      targ.items = (targ.items - (targ.items & ((8192.000 | 16384.000) | 32768.000)));

   }
   targ.armorvalue = (targ.armorvalue - save);
   take = ceil ((damage - save));

	if ((targ.flags & 8))
	{
		targ.dmg_take = (targ.dmg_take + take);
		targ.dmg_save = (targ.dmg_save + save);
		targ.dmg_inflictor = inflictor;
	}

   if ( ((inflictor != world) && (targ.movetype == 3.000)) ) {

      dir = (targ.origin - ((inflictor.absmin + inflictor.absmax) * 0.500));
      dir = normalize (dir);
      if ( (((damage < 60.000) & ((attacker.classname == "player") & (targ.classname == "player"))) & (attacker.netname != targ.netname)) ) {

         targ.velocity = (targ.velocity + ((dir * damage) * 11.000));

      } else {

         targ.velocity = (targ.velocity + ((dir * damage) * 8.000));

      }
      if ( (((rj > 1.000) & ((attacker.classname == "player") & (targ.classname == "player"))) & (attacker.netname == targ.netname)) ) {
         targ.velocity = (targ.velocity + ((dir * damage) * rj));

      }


   }


   if ( (targ.flags & 64.000) ) {

      return ;

   }
   if ( (targ.invincible_finished >= time) ) {

      if ( (self.invincible_sound < time) ) {

         sound (targ,3.000,"items/protect3.wav",1.000,1.000);
         self.invincible_sound = (time + 2.000);

      }
      return ;

   }
   if ( ((attacker.classname == "player") && ((targ.classname == "player") || (targ.classname == "building_sentrygun"))) ) {

      if ( (((targ.pteam.team > 0.000) && (targ.pteam.team == attacker.pteam.team)) && (targ != attacker)) ) {

         if ( (teamplay & 16.000) ) {

            return ;

         } else {

            if ( (teamplay & 8.000) ) {

               take = (take / 2.000);

            }

         }

      }

   }
   if ( ((take < 1.000) && (take != 0.000)) ) {

      take = 1.000;

   }
      if ((modetype & 2) && (targ.classname == "player")) {
         targ.health = (1000 + take);
      } else {
         targ.health = (targ.health - take);
      }

   if ( (targ.armorvalue < 1.000) ) {

      targ.armorclass = 0.000;
      targ.armorvalue = 0.000;

   }
   if ( (targ.health <= 0.000) ) {

      Killed (targ,attacker);
      return ;

   }
   oldself = self;
   self = targ;
   if ( self.th_pain ) {

      self.th_pain (attacker,take);
      if ( (skill >= 3.000) ) {

         self.pain_finished = (time + 5.000);

      }

   }
   self = oldself;

};*/

void (entity targ, entity inflictor, entity attacker, float damage, float T_flags, float T_AttackType) TF_T_Damage = {

   local vector dir;
   local entity oldself;
   local entity te;
   local float save;
   local float take;
   local float no_damage;
   local float moment;


   if ( (targ.takedamage == 0.000) ) {

      return ;

   }

   if ( (T_AttackType & 256.000) ) {

      targ.health = damage;
      return ;

   }

   if ( cease_fire ) {

      return ;

   }

   if (round_active) {
      round_pause = time;
   }
   no_damage = 0.000;

      if (targ.classname == "player")
      {
         if (!cb_prematch)
         {
            
            targ.dmg_recieved = targ.dmg_recieved + damage;
            if (targ.StatusBarSize) 
                targ.StatusRefreshTime = (time + 0.100);

            if (attacker.classname == "player")
            {
               if (attacker == targ)
               {
                 attacker.dmg_self = attacker.dmg_self + damage;
                 if (attacker.StatusBarSize) 
                     attacker.StatusRefreshTime = (time + 0.100);
               }
               else if (attacker.pteam.team == targ.pteam.team )
               {
                 attacker.dmg_team = attacker.dmg_team + damage;
                 if (attacker.StatusBarSize) 
                     attacker.StatusRefreshTime = (time + 0.100);
               }
               else
               {
                 attacker.dmg_inflicted = attacker.dmg_inflicted + damage;
                 if (attacker.StatusBarSize) 
                     attacker.StatusRefreshTime = (time + 0.100);
               }
            }
         }
      }

   if ( (attacker.classname == "player") ) {

      damage = (damage * 0.900);
      if ( (attacker.super_damage_finished > time) ) {

         damage = (damage * 4.000);

      }
      if ( (targ.classname != "player") && (targ.killtarget != "building")) {

         if ( !Activated (targ,attacker) ) {

            if ( (targ.else_goal != 0.000) ) {

               te = Findgoal (targ.else_goal);
               if ( te ) {

                  AttemptToActivate (te,attacker,targ);

               }

            }
            return ;

         }

      }

   }
   damage_attacker = attacker;

   if ( ((targ.armorclass != 0.000) && (T_AttackType != 0.000)) ) {

      if ( ((targ.armorclass & 1.000) && (T_AttackType & 1.000)) ) {

         damage = floor ((damage * 0.500));

      }
      if ( ((targ.armorclass & 2.000) && (T_AttackType & 2.000)) ) {

         damage = floor ((damage * 0.500));

      }
      if ( ((targ.armorclass & 4.000) && (T_AttackType & 4.000)) ) {

         damage = floor ((damage * 0.500));

      }
      if ( ((targ.armorclass & 8.000) && (T_AttackType & 8.000)) ) {

         damage = floor ((damage * 0.500));

      }
      if ( ((targ.armorclass & 16.000) && (T_AttackType & 16.000)) ) {

         damage = floor(damage * 0.500); 

      }

   }


   if ( (T_flags & 1.000) ) {

      take = damage;
      save = 0.000;

   } else {

       


      save = ceil ((targ.armortype * damage));
      if (attacker.classname == "player") 
      {

        if (targ.pteam.team > 0.000)
        {

           if (targ.pteam.team == attacker.pteam.team)
           {
           
              if (targ != attacker)
              {

                 if (T_flags & 2.000)
                 {

 
                    if ( (T_AttackType & 4.000) ) {

                        if ( (teamplay & 1024.000) ) {

                           save = 0.000;

                        } else {

                           if ( (teamplay & 512.000) ) {

                              save = (save / 2.000);

                           }

                        }

                     } else {

                        if ( (teamplay & 256.000) ) {

                           save = 0.000;

                        } else {

                           if ( (teamplay & 128.000) ) {

                              save = (save / 2.000);

                           }

                        }

                     }

                  }

               }
               else
               {

                  if (teamplay & 64.000) 
                  {
                     no_damage = 1.000;
                     save = 0.000;
                  } 
                  else if (teamplay & 32.000) 
                  {
                     no_damage = 1.000;
                     save = (save / 2.000);
                  }

               }

            }

         }
  
      }

      if ( (save >= targ.armorvalue) ) {

         save = targ.armorvalue;
         targ.armortype = 0.000;
         targ.armorclass = 0.000;
         targ.items = (targ.items - (targ.items & ((8192.000 | 16384.000) | 32768.000)));

      }

      targ.armorvalue = (targ.armorvalue - save);
      take = ceil ((damage - save));

   }

	if ((targ.flags & 8))
	{
		targ.dmg_take = (targ.dmg_take + take);
		targ.dmg_save = (targ.dmg_save + save);
		targ.dmg_inflictor = inflictor;
	}

   if ( (((inflictor != world) && (targ.movetype == 3.000)) && !(targ.tfstate & 65536.000)) ) {

      if ( (deathmsg != 9.000) ) {

         //targ.immune_to_check = (time + (damage / 20.000));
         dir = (targ.origin - ((inflictor.absmin + inflictor.absmax) * 0.500));
         dir = normalize (dir);
         if ( (targ.playerclass == 6.000) ) {

            moment = (damage / 4.000);
            if ( (damage <= 50.000) ) {

               moment = 0.000;

            }

         }
         else if (inflictor.volume)
         {
            moment = damage * inflictor.volume;
         }
         else
         {
            moment = damage;
         }


         if ( (((moment < 60.000) && ((attacker.classname == "player") && (targ.classname == "player"))) && (attacker.netname != targ.netname)) ) {

           targ.velocity = (targ.velocity + ((dir * moment) * 11.000));

         } else {

            targ.velocity = (targ.velocity + ((dir * moment) * 8.000));

         }


         if ( (((rj > 1.000) && ((attacker.classname == "player") && (targ.classname == "player"))) && (attacker.netname == targ.netname)) ) {

            targ.velocity = (targ.velocity + ((dir * moment) * rj));

         }

      }


   }

/* 

   if ( (inflictor != world) && (targ.classname == "grenade") ) {

      dir = (targ.origin - ((inflictor.absmin + inflictor.absmax) * 0.500));
      dir = normalize (dir);
      if ( (((damage < 60.000) & ((attacker.classname == "player") & (attacker.netname != targ.netname))))) {

         targ.velocity = (targ.velocity + ((dir * damage) * 11.000));

      } else {

         targ.velocity = (targ.velocity + ((dir * damage) * 8.000));

      }

   }

*/
   if ( (targ.flags & 64.000) ) {

      return ;

   }
   if ( (targ.invincible_finished >= time) ) {

      if ( (self.invincible_sound < time) ) {

         sound (targ,3.000,"items/protect3.wav",1.000,1.000);
         self.invincible_sound = (time + 2.000);

      }
      return ;

   }
   if ( ((attacker.classname == "player") && ((targ.classname == "player") || (targ.killtarget == "building")) )) {

      if ( ((((targ.pteam.team > 0.000) && (targ.pteam.team == attacker.pteam.team )) && (targ != attacker)) && (T_flags & 2.000)) ) {

         if ( (T_AttackType & 4.000) ) {

            if ( (teamplay & 16.000) ) {

               no_damage = 1.000;

            } else {

               if ( (teamplay & 8.000) ) {

                  take = (take / 2.000);

               }

            }

         } else {

            if ( (teamplay & 4.000) ) {

               no_damage = 1.000;

            } else {

               if ( (teamplay & 2.000) ) {

                  take = (take / 2.000);

               }

            }

         }

      }

   }
   if ( (T_flags & 4.000) ) {

      if ( (targ == attacker) ) {

         return ;

      }

   }
   if ( (take < 1.000) ) {

      take = 1.000;

   }

   take = rint (take);
   if ( (no_damage == 0.000) ) {

      if ((modetype & 2) && (targ.classname == "player")) {
         targ.health = (1000 + take);
      } else {
         targ.health = (targ.health - take);
      }


   }


   if ( (no_damage == 1.000) ) {

      return ;

   }
   if ( (targ.armorvalue < 1.000) ) {

      targ.armorclass = 0.000;
      targ.armorvalue = 0.000;

   }
   if ( (targ.health <= 0.000) ) {

      if ( (((inflictor.classname == "detpack") && (inflictor.weaponmode == 1.000)) && (inflictor.enemy == targ)) ) {

         deathmsg = 16.000;

      }
      Killed (targ,attacker);
      return ;

   }
   oldself = self;
   self = targ;
   if ( self.th_pain ) {

      self.th_pain (attacker,take);
      if ( (skill >= 3.000) ) {

         self.pain_finished = (time + 5.000);

      }

   }
   self = oldself;

};

void (entity inflictor, entity attacker, float damage, entity ignore) T_RadiusDamage = {

   local float points;
   local entity head;
   local vector org;

   head = findradius (inflictor.origin,(damage + 40.000));
   while ( head ) {

      if ( (head != ignore) ) {

         if ( head.takedamage ) {

            org = (head.origin + ((head.mins + head.maxs) * 0.500));
            points = (0.500 * vlen ((inflictor.origin - org)));
            if ( (points < 0.000) ) {

               points = 0.000;

            }
            points = (damage - points);
            if ( (head == attacker) ) {

               points = (points * 0.750);

            }
            if ( (points > 0.000) ) {

               if ( CanDamage (head,inflictor) ) {

                  if (inflictor.weapon == 33.000)
                  {

                     TF_T_Damage (head,inflictor,attacker,points,2.000,4.000);

                     other = head;
                     Napalm_touch ();
                     if ( (other.classname == "player") ) {

                        stuffcmd (other,"bf\nbf\n");

                     }

                  } else {

                     TF_T_Damage (head,inflictor,attacker,points,2.000,4.000);

                  }

               }

            }

         }

      }
      head = head.chain;

   }

};

void (entity attacker, float damage) T_BeamDamage = {

   local float points;
   local entity head;

   head = findradius (attacker.origin,(damage + 40.000));
   while ( head ) {

      if ( head.takedamage ) {

         points = (0.500 * vlen ((attacker.origin - head.origin)));

         points = (damage - points);
         if ( (head == attacker) ) {

            points = (points * 0.500);

         }
         if ( (points > 0.000) ) {

            if ( CanDamage (head,attacker) ) {

               TF_T_Damage (head,attacker,attacker,points, 0.000, 0.000);

            }

         }

      }
      head = head.chain;

   }

};
