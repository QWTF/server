void () ImpulseCommands;

void () player_run;

float (vector veca, vector vecb) crossproduct;

void (vector org, float damage) SpawnBlood;

void (entity rhook) Reset_Grapple;

void () W_PrintWeaponMessage;

void () button_touch;

void () button_fire;

void () RemoveGrenade;

void () SniperSight_Create;

void (float zoom_level) TF_zoom;

void () W_FireFlame;

void () W_FireIncendiaryCannon;

void () W_FireTranq;

void () W_FireRail;

void () W_FireRailgun;

void () W_Precache = {

   precache_sound ("weapons/r_exp3.wav");
   precache_sound ("weapons/rocket1i.wav");
   precache_sound ("weapons/sgun1.wav");
   precache_sound ("weapons/guncock.wav");
   precache_sound ("weapons/ric1.wav");
   precache_sound ("weapons/ric2.wav");
   precache_sound ("weapons/ric3.wav");
   precache_sound ("weapons/spike2.wav");
   precache_sound ("weapons/tink1.wav");
   precache_sound ("weapons/grenade.wav");
   precache_sound ("weapons/bounce.wav");
   precache_sound ("weapons/shotgn2.wav");
   precache_sound ("wizard/wattack.wav");
   precache_sound ("items/r_item1.wav");
   precache_sound ("items/r_item2.wav");
   precache_model ("progs/flame2.mdl");
   precache_sound ("ambience/fire1.wav");
   precache_sound ("blob/land1.wav");
   precache_model ("progs/v_spike.mdl");
   precache_sound ("hknight/hit.wav");
   precache_sound ("weapons/detpack.wav");
   precache_sound ("weapons/turrset.wav");
   precache_sound ("weapons/turrspot.wav");
   precache_sound ("weapons/turridle.wav");
   precache_sound ("weapons/sniper.wav");
   precache_sound ("weapons/hyperb1.wav");
   precache_sound ("weapons/laserhit.wav");
   precache_sound ("weapons/autorifle.wav");
   precache_sound ("weapons/sg_draw.wav");
   precache_sound ("weapons/sg_reload.wav");
   precache_sound ("weapons/gl_draw.wav");
   precache_sound ("weapons/rl_draw.wav");
   precache_sound ("weapons/flmfire2.wav");
   precache_sound ("weapons/flmgrexp.wav");
   precache_sound ("misc/vapeur2.wav");
   precache_sound ("weapons/asscan1.wav");
   precache_sound ("weapons/asscan2.wav");
   precache_sound ("weapons/asscan3.wav");
   precache_sound ("weapons/asscan4.wav");
   precache_sound ("weapons/railgun.wav");
   precache_sound ("weapons/dartgun.wav");

	precache_model ("progs/shell.mdl");
	precache_model ("progs/20mmcase.mdl");

   precache_sound ("weapons/shell2.wav");
   precache_sound ("weapons/tink1.wav");
   precache_sound ("weapons/tink2.wav");

};


void () W_FireAxe = {

   local vector source;
   local vector org;
   local vector def;

   makevectors (self.v_angle);
   source = (self.origin + '0.000 0.000 16.000');
   traceline (source,(source + (v_forward * 64.000)),0.000,self);
   if ( (trace_fraction == 1.000) ) {

      return ;

   }

   if (allow_stamina)
      self.stamina = self.stamina - 15;

   org = (trace_endpos - (v_forward * 4.000));
   if ( trace_ent.takedamage ) {

      trace_ent.axhitme = 1.000;
      SpawnBlood (org,20.000);
      if ( ((self.playerclass != 8.000) || (trace_ent.classname != "player")) ) {

         deathmsg = 17.000;
         TF_T_Damage (trace_ent,self,self,20.000,2.000,0.000);

      } else {

         self.weaponmode = 1.000;
         self.weaponmodel = "progs/v_knife.mdl";
         makevectors (trace_ent.v_angle);
         def = v_right;
         makevectors (self.v_angle);
         if ( (crossproduct (def,v_forward) > 0.000) ) {

            deathmsg = 22.000;
            TF_T_Damage (trace_ent,self,self,120.000,(2.000 | 1.000),0.000);

         } else {

            deathmsg = 17.000;
            TF_T_Damage (trace_ent,self,self,40.000,2.000,0.000);

         }

      }


   } else {

      sound (self,1.000,"player/axhit2.wav",1.000,1.000);
      WriteByte (4.000,23.000);
      WriteByte (4.000,2.000);
      WriteByte (4.000,3.000);
      WriteCoord (4.000,org_x);
      WriteCoord (4.000,org_y);
      WriteCoord (4.000,org_z);
      multicast (org,2.000);

   }

};

void () W_FireSpanner = {

   local vector source;
   local vector org;
   local entity te;

   makevectors (self.v_angle);
   source = (self.origin + '0.000 0.000 16.000');
   traceline (source,(source + (v_forward * 64.000)),0.000,self);
   if ( (trace_fraction == 1.000) ) {

      return ;

   }

   if (allow_stamina)
      self.stamina = self.stamina - 15;

   org = (trace_endpos - (v_forward * 4.000));
   if ( (trace_ent.goal_activation & 8.000) ) {

      if ( Activated (trace_ent,self) ) {

         DoResults (trace_ent,self,1.000);
         if ( (trace_ent.classname == "func_button") ) {

            trace_ent.enemy = self;
            other = self;
            self = trace_ent;
            self.dont_do_triggerwork = 1.000;
            button_fire ();
            self = other;

         }

      } else {

         if ( (trace_ent.else_goal != 0.000) ) {

            te = Findgoal (trace_ent.else_goal);
            if ( te ) {

               AttemptToActivate (te,self,trace_ent);

            }

         } else {

            sound (self,1.000,"player/axhit2.wav",1.000,1.000);
            WriteByte (4.000,23.000);
            WriteByte (4.000,2.000);
            WriteByte (4.000,3.000);
            WriteCoord (4.000,org_x);
            WriteCoord (4.000,org_y);
            WriteCoord (4.000,org_z);
            multicast (org,2.000);

         }

      }
      return ;

   }
   if ( trace_ent.takedamage ) {

      Spanner_Fire();

   } else {

      sound (self,1.000,"player/axhit2.wav",1.000,1.000);
      WriteByte (4.000,23.000);
      WriteByte (4.000,2.000);
      WriteByte (4.000,3.000);
      WriteCoord (4.000,org_x);
      WriteCoord (4.000,org_y);
      WriteCoord (4.000,org_z);
      multicast (org,2.000);

   }

};


void () W_FireMedikit = {

   local vector org;
   local vector source;

   source = (self.origin + '0.000 0.000 16.000');
   traceline (source,(source + (v_forward * 64.000)),0.000,self);
   if ( (trace_fraction == 1.000) ) {

      return ;

   }
   if (allow_stamina)
      self.stamina = self.stamina - 15;



   org = (trace_endpos - (v_forward * 4.000));

   if ( trace_ent.takedamage ) {

      Medikit_Fire ();
   } else {

      sound (self,1.000,"player/axhit2.wav",1.000,1.000);
      WriteByte (4.000,23.000);
      WriteByte (4.000,2.000);
      WriteByte (4.000,3.000);
      WriteCoord (4.000,org_x);
      WriteCoord (4.000,org_y);
      WriteCoord (4.000,org_z);
      multicast (org,2.000);

   }

};

#ifdef CSQC

.float starttime;
float(entity toplayer) SendShell =
{
	WriteByte(MSG_ENTITY, CLASS_SHELL);
	WriteByte(MSG_ENTITY, self.skin);
	WriteCoord(MSG_ENTITY, self.origin_x);
	WriteCoord(MSG_ENTITY, self.origin_y);
	WriteCoord(MSG_ENTITY, self.origin_z);
	WriteAngle(MSG_ENTITY, self.angles_x);
	WriteAngle(MSG_ENTITY, self.angles_y);
	return 1.000;
};
#endif

void () ShellHit =
{

	if ((self.skin == 1.000))
	{
		sound (self, 3.000, "weapons/shell2.wav", 0.500, 1.000);
	}
	else
	{
		if ((random () < 0.500))
		{
			sound (self, 3.000, "weapons/tink1.wav", 0.500, 1.000);
		}
		else
		{
			sound (self, 3.000, "weapons/tink2.wav", 0.600, 1.000);
		}
	}
	return;
};

void () EjectShell =
{

	newmis = spawn ();
	newmis.movetype = 10.000;
	newmis.solid = 1.000;
	newmis.angles = self.angles;

	setsize (newmis, '0 0 0', '0 0 0');
	setorigin (newmis, ((self.origin + (v_forward * 10)) + '0 0 20'));

	makevectors (self.v_angle);
	if (self.v_angle_x)
	{
		newmis.velocity = (((v_forward * 70.000000) + (v_up * 90.000000)) + ((random () * v_right) * 150.000000));
	}
	else
	{

		newmis.velocity = ((newmis.velocity * 70.000000) + ((random () * v_right) * 150.000000));
		newmis.velocity_z = (random () * 90.000);
	}
	if ((random () < 0.300))
	{
		newmis.avelocity = '20 30 40';
	}
	else
	{
		if ((random () < 0.600000))
		{
			newmis.avelocity = '40 20 30';
		}
		else
		{
			newmis.avelocity = '70 50 10';
		}
	}

	if ((self.playerclass == 6.000) && (self.current == WEAP_ASSAULT_CANNON))
	{
		newmis.nextthink = (time + 1.500000);
		setmodel (newmis, "progs/20mmcase.mdl");
	}
	else
	{
		newmis.nextthink = (time + 3.000);
		setmodel (newmis, "progs/shell.mdl");

	}
	newmis.think = SUB_Remove;
	newmis.touch = ShellHit;



	#ifdef CSQC
		newmis.SendEntity = SendShell;
		newmis.Version+=1;
	#endif
};

vector () wall_velocity = {

   local vector vel;

   vel = normalize (self.velocity);
   vel = normalize (((vel + (v_up * (random () - 0.500))) + (v_right * (random () - 0.500))));
   vel = (vel + (2.000 * trace_plane_normal));
   vel = (vel * 200.000);
   return ( vel );

};

void (vector org, vector vel) SpawnMeatSpray = {

   local entity missile;

   missile = spawn ();
   missile.owner = self;
   missile.movetype = 10.000;
   missile.solid = 0.000;
   makevectors (self.angles);
   missile.velocity = vel;
   missile.velocity_z = ((missile.velocity_z + 250.000) + (50.000 * random ()));
   missile.avelocity = '3000.000 1000.000 2000.000';
   missile.nextthink = (time + 1.000);
   missile.think = SUB_Remove;
   setmodel (missile,"progs/zom_gib.mdl");
   setsize (missile,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (missile,org);

};

void (vector org, float damage) SpawnBlood = {

   WriteByte (4.000,23.000);
   WriteByte (4.000,12.000);
   WriteByte (4.000,1.000);
   WriteCoord (4.000,org_x);
   WriteCoord (4.000,org_y);
   WriteCoord (4.000,org_z);
   multicast (org,2.000);

};

void (float damage) spawn_touchblood = {

   local vector vel;

   vel = (wall_velocity () * 0.200);
   SpawnBlood ((self.origin + (vel * 0.010)),damage);

};
/*
void (vector org, vector vel) SpawnChunk = {

   particle (org,(vel * 0.020),0.000,10.000);

};
*/
entity multi_ent;
float multi_damage /* = 0.000 */;
vector blood_org /* = '0.000 0.000 0.000' */;
float blood_count /* = 0.000 */;
vector puff_org /* = '0.000 0.000 0.000' */;
float puff_count /* = 0.000 */;


void () ClearMultiDamage = {

   multi_ent = world;
   multi_damage = 0.000;
   blood_count = 0.000;
   puff_count = 0.000;

};

void () ApplyMultiDamage = {

   if ( !multi_ent ) {

      return ;

   }
   TF_T_Damage (multi_ent,self,self,multi_damage,2.000,1.000);

};

void (entity hit, float damage) AddMultiDamage = {

   if ( !hit ) {

      return ;

   }
   if ( (hit != multi_ent) ) {

      ApplyMultiDamage ();
      multi_damage = damage;
      multi_ent = hit;

   } else {

      multi_damage = (multi_damage + damage);

   }

};

void () Multi_Finish = {

   if ( puff_count ) {
      WriteByte (4.000,23.000);
      WriteByte (4.000,2.000);
      WriteByte (4.000,puff_count);
      WriteCoord (4.000,puff_org_x); 
      WriteCoord (4.000,puff_org_y);
      WriteCoord (4.000,puff_org_z);
      multicast (puff_org,2.000);

   }

   if ( blood_count ) {

      WriteByte (4.000,23.000);
      WriteByte (4.000,12.000);
      WriteByte (4.000,blood_count);
      WriteCoord (4.000,blood_org_x); 
      WriteCoord (4.000,blood_org_y);
      WriteCoord (4.000,blood_org_z);
      multicast (puff_org,2.000);

   }

};

void (float damage, vector dir) TraceAttack = {

   local vector vel;
   local vector org;


   vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
   vel = (vel + (2.000 * trace_plane_normal));
   vel = (vel * 200.000);
   org = (trace_endpos - (dir * 4.000));
   if ( trace_ent.takedamage ) {

      blood_count = (blood_count + 1.000);
      blood_org = org;
      AddMultiDamage (trace_ent,damage);

   } else {

      puff_count = (puff_count + 1.000);

   }

};

void (float shotcount, vector dir, vector spread) FireBullets = {

   local vector direction;
   local vector src;

   makevectors (self.v_angle);
   src = (self.origin + (v_forward * 10.000));
   src_z = (self.absmin_z + (self.size_z * 0.700));
   ClearMultiDamage ();
   traceline (src,(src + (dir * 2048.000)),0.000,self);
   puff_org = (trace_endpos - (dir * 4.000));
   while ( (shotcount > 0.000) ) {

      direction = ((dir + ((crandom () * spread_x) * v_right)) + ((crandom () * spread_y) * v_up));
      traceline (src,(src + (direction * 2048.000)),0.000,self);
      if ( (trace_fraction != 1.000) ) {

         if ( (self.current != 32768.000) ) {

            TraceAttack (4.000,direction);

         } else {

            if (!(classtype & 2)) {
               TraceAttack (5.000,direction);
            } else {
               TraceAttack (8.000,direction);
            }

         }

      }

      shotcount = (shotcount - 1.000);
      if ( (self.current == WEAP_ASSAULT_CANNON) ) {

         puff_org = (trace_endpos + direction);
         Multi_Finish ();

      }

   }
   ApplyMultiDamage ();
   if ( (self.current != 32768.000)) {

      Multi_Finish ();

   }

};

float (float cur_val, float new_val) SetAttribute = {

	if (modetype & 2) return(cur_val);

	return(new_val);

};

void () W_FireShotgun = {

   local vector dir;

   sound (self,1.000,"weapons/guncock.wav",1.000,1.000);
   KickPlayer (-2.000,self);
   if (!modetype & 2) { 
      self.ammo_shells = (self.ammo_shells - 1.000);
      self.currentammo = self.ammo_shells;
      if (allow_stamina)
         self.stamina = self.stamina - 70;
   }
   dir = aim (self,100000.000);
   deathmsg = 1.000;

   EjectShell ();
   FireBullets (6.000,dir,'0.040 0.040 0.000');
};

void () W_FireSuperShotgun = {

   local vector dir;

   if ( (self.currentammo == 1.000) ) {

      W_FireShotgun ();
      return ;

   }
   sound (self,1.000,"weapons/shotgn2.wav",1.000,1.000);
   KickPlayer (-4.000,self);
   if (!modetype & 2) { 
      self.ammo_shells = (self.ammo_shells - 2.000);
      self.currentammo = self.ammo_shells;
      if (allow_stamina)
         self.stamina = self.stamina - 100;
   }
   dir = aim (self,100000.000);
   deathmsg = 2.000;

   EjectShell ();
   FireBullets (14.000,dir,'0.140 0.080 0.000');

};

void (vector direction, float damage, vector spread) FireSniperBullet = {

   local vector src;
   local vector dir;


   makevectors (self.v_angle);
   src = (self.origin + (v_forward * 10.000));
   src_z = (self.absmin_z + (self.size_z * 0.700));
   ClearMultiDamage ();
   dir = ((direction + ((crandom () * spread_x) * v_right)) + ((crandom () * spread_y) * v_up));
   traceline (src,(src + (dir * 4096.000)),0.000,self);
   if ( (trace_fraction != 1.000) ) {

      TraceAttack (damage,direction);

   }
   puff_org = (trace_endpos + direction);
   Multi_Finish ();

   ApplyMultiDamage ();

};

void () W_FireSniperRifle = {

   local vector dir;
   local vector src;
   local float dam_mult;
   local float zdif;
   local float use_this;
   local float x;
   local vector f;
   local vector g;
   local vector h;
   local float heattime;

   sound (self,1.000,"weapons/sniper.wav",1.000,1.000);
   KickPlayer (-2.000,self);
   if (!modetype & 2) { 
      self.ammo_shells = (self.ammo_shells - 1.000);
      self.currentammo = self.ammo_shells;
      if (allow_stamina)
         self.stamina = self.stamina - 270;
   }
   makevectors (self.v_angle);
   src = (self.origin + (v_forward * 10.000));
   src_z = (self.absmin_z + (self.size_z * 0.700));
   use_this = 0.000;
   traceline (src,(src + (dir * 8092.000)),0.000,self);
   if ( (trace_fraction != 1.000) ) {

      if ( (trace_ent != world) ) {

         if ( (trace_ent.classname == "player") ) {

            use_this = 1.000;

         }

      }

   }
   KickPlayer (-4.000,self);
   if ( !use_this ) {

      dir = aim (self,10000.000);
      traceline (src,(src + (dir * 3072.000)),0.000,self);

   }

   heattime = time - self.heat;

   self.heat = (heattime * (72 * 3)) + 50;

   if (self.heat > 401.000) self.heat = 401;

   deathmsg = 18.000;
   dam_mult = 0.800;
   if ( trace_ent ) {


      if ( (trace_ent.classname == "player") ) {

         f = (trace_endpos - src);
         g_x = trace_endpos_x;
         g_y = trace_endpos_y;
         g_z = 0.000;
         h_x = trace_ent.origin_x;
         h_y = trace_ent.origin_y;
         h_z = 0.000;
         x = vlen ((g - h));
         f = ((normalize (f) * x) + trace_endpos);
         zdif = (f_z - trace_ent.origin_z);
         deathmsg = 18.000;
         trace_ent.head_shot_vector = '0.000 0.000 0.000';
         if ( (zdif < 0.000) ) {

            dam_mult = 0.400;
            trace_ent.leg_damage = (trace_ent.leg_damage + 1.000);
            TeamFortress_SetSpeed (trace_ent);
            deathmsg = 28.000;
            TF_T_Damage (trace_ent,self,self,(self.heat * dam_mult),2.000,1.000);
            if ( (trace_ent.health > 0.000) ) {

               sprint (trace_ent,0.000,"Leg injury!\n");
               sprint (self,1.000,"Leg shot - that'll slow him down!\n");

            }
            return ;

         } else {

            if ( (zdif > 20.000) ) {

               dam_mult = 1.200;
               stuffcmd (trace_ent,"bf\n");
               trace_ent.head_shot_vector = (trace_ent.origin - self.origin);
               deathmsg = 29.000;
               TF_T_Damage (trace_ent,self,self,(self.heat * dam_mult),2.000,1.000);
               if ( (trace_ent.health > 0.000) ) {

                  sprint (trace_ent,0.000,"Head injury!\n");
                  sprint (self,1.000,"Head shot - that's gotta hurt!\n");

               }
               return ;

            } else {

               deathmsg = 18.000;

            }

         }

      }

   }

  
   ClearMultiDamage ();
   if ( (trace_fraction != 1.000) ) {

      TraceAttack ((self.heat * dam_mult),dir);

   }
   ApplyMultiDamage ();

};

void () W_FireAutoRifle = {

   local vector dir;

   sound (self,1.000,"weapons/autorifle.wav",1.000,1.000);
   KickPlayer (-1.000,self);
   if (!modetype & 2) { 
      self.ammo_shells = (self.ammo_shells - 1.000);
      self.currentammo = self.ammo_shells;
      if (allow_stamina)
         self.stamina = self.stamina - 30;
   }
   makevectors (self.v_angle);
   dir = v_forward;
   deathmsg = 19.000;
   FireSniperBullet (dir,8.000, '0.04 0.04 0');

};

void () s_plasma1 = [ 0.000, s_plasma2 ] {};
void () s_plasma2 = [ 1.000, s_plasma3 ] {};
void () s_plasma3 = [ 2.000, s_plasma4 ] {};
void () s_plasma4 = [ 3.000, s_plasma1 ] {};


void () Plasma_stream_touch = {

  if ( ((other.takedamage == 2.000) && (other.health > 0.000)) ) {

         TF_T_Damage (other,self,self.owner,20.000,2.000,8.000);
         if (cb_prematch ) return ;
         
   } else {

         T_RadiusDamage (self,self.owner,27.000,other);
         self.origin = (self.origin - (8.000 * normalize (self.velocity)));
   }

   deathmsg = 18.000;
   sound (self,0.000,"weapons/laserhit.wav",1.000,1.000);
   dremove(self);

};

#ifdef CSQC

float(entity toplayer) SendPlasma =
{
	WriteByte(MSG_ENTITY, CLASS_PLASMA);
	WriteCoord(MSG_ENTITY, self.origin_x);
	WriteCoord(MSG_ENTITY, self.origin_y);
	WriteCoord(MSG_ENTITY, self.origin_z);
	WriteAngle(MSG_ENTITY, self.angles_x);
	WriteAngle(MSG_ENTITY, self.angles_y);
	//WriteByte(MSG_ENTITY, ));
	return 1.000;
};
#endif

void () W_FirePlasma = {

   local float rn;
   local entity plasma;

   if ( (self.waterlevel > 2.000) ) {

      makevectors (self.v_angle);
      //NewBubbles (2.000,(self.origin + (v_forward * 64.000)));
      rn = random ();
      if ( (rn < 0.500) ) {

         sound (self,1.000,"misc/water1.wav",1.000,1.000);

      } else {

         sound (self,1.000,"misc/water2.wav",1.000,1.000);

      }
      return ;

   }
   if (!modetype & 2) { 
      self.ammo_cells = (self.ammo_cells - 1.000);
      self.currentammo = self.ammo_cells;
   }

   sound (self,0.000,"weapons/hyperb1.wav",1.000,1.000);
   plasma = spawn ();
   plasma.owner = self;
   plasma.movetype = 9.000;
   plasma.solid = 2.000;
   plasma.volume = 2.500;
   //plasma.effects = (plasma.effects | 64.000);
   plasma.classname = "plasma";
   makevectors (self.v_angle);
   plasma.velocity = aim (self,10000.000);
   plasma.velocity = (plasma.velocity * 1000.000);
   plasma.angles = vectoangles (plasma.velocity);
   plasma.touch = Plasma_stream_touch;
   setmodel (plasma,"progs/s_plasma.spr");
   plasma.think = s_plasma1;
   plasma.nextthink = (time + 0.050);
   //setmodel (plasma,"progs/laser.mdl");
   setsize (plasma,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (plasma,((self.origin + (v_forward * 16.000)) + '0.000 0.000 16.000'));

   #ifdef CSQC

	plasma.SendEntity = SendPlasma;
	//newmis.starttime = time;
	plasma.Version+=1;

   #endif
};

void () W_FireAssaultCannon = {

   local vector dir;

   KickPlayer (-4.000,self);
   if (!modetype & 2) { 
      self.ammo_shells = (self.ammo_shells - 1.000);
      self.currentammo = self.ammo_shells;
      if (allow_stamina)
         self.stamina = self.stamina - 50;
   }
   dir = aim (self,100000.000);
   deathmsg = 20.000;

   if (!(classtype & 2)) {
      if ( self.velocity == '0 0 0')
      {
         FireBullets (4.500,dir,'0.050 0.050 0');
      } else {
         FireBullets (4.000,dir,'0.100 0.100 0.000');
      }
   } else {
      FireBullets (5, dir, '0.1 0.1 0');
   }
   EjectShell ();
};

void () s_explode1 = [ 0.000, s_explode2 ] {

};
void () s_explode2 = [ 1.000, s_explode3 ] {};
void () s_explode3 = [ 2.000, s_explode4 ] {};
void () s_explode4 = [ 3.000, s_explode5 ] {};
void () s_explode5 = [ 4.000, s_explode6 ] {};
void () s_explode6 = [ 5.000, SUB_Remove ] {};

void () MissileRadius = {

local float damg;

   if ( (self.owner.classname == "building_sentrygun") ) {

      damg = 150.000; 

   } else {

      if ((self.playerclass == 11.000)) {

         damg = 120.000; 
	
	} else {

	   damg = 92.000;
      }

   }

   deathmsg = self.weapon;
   T_RadiusDamage (self,self.owner,damg,other);

   self.origin = (self.origin - (8.000 * normalize (self.velocity)));
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   dremove (self);

};

void () T_MissileTouch = {

   local float damg;

   if ( self.voided ) {

      return ;

   }
   self.voided = 1.000;
   if ( (pointcontents (self.origin) == -6.000) ) {

      dremove (self);
      return ;

   }

   if ((self.playerclass == 11.000)) {

      damg = (100.000 + (random () * 20.000));

   } else {

      damg = (92.000 + (random () * 20.000));
   }

   deathmsg = self.weapon;
   if ( other.health ) {

      TF_T_Damage (other,self,self.owner,damg,2.000,0.000);

   }

   MissileRadius();
};

void () RealisticMove = {

   if (self.attack_finished < time)
   {
      if (self.weapon == 6.000)
      {
         MissileRadius();
      }
      else
      {
         SUB_Remove();
      }

      return;
   }

   if (vlen(self.velocity) < vlen(self.movedir))
   {
      self.velocity_x = self.velocity_x + (self.movedir_x / 20);
      self.velocity_y = self.velocity_y + (self.movedir_y / 20);
      self.velocity_z = self.velocity_z + (self.movedir_z / 20);
   }

   self.nextthink = time + 0.01;

};

#ifdef CSQC

float(entity toplayer) SendRocket =
{
	WriteByte(MSG_ENTITY, CLASS_ROCKET);
	WriteCoord(MSG_ENTITY, self.origin_x);
	WriteCoord(MSG_ENTITY, self.origin_y);
	WriteCoord(MSG_ENTITY, self.origin_z);
	WriteAngle(MSG_ENTITY, self.angles_x);
	WriteAngle(MSG_ENTITY, self.angles_y);
	//WriteByte(MSG_ENTITY, ));
	return 1.000;
};
#endif

void () W_FireRocket = {

   local vector pvel;

   if (!modetype & 2) { 
      self.ammo_rockets = (self.ammo_rockets - 1.000);
      self.currentammo = self.ammo_rockets;
      if (allow_stamina)
         self.stamina = self.stamina - 300;
   }
   sound (self,1.000,"weapons/sgun1.wav",1.000,1.000);
   KickPlayer (-2.000,self);
   newmis = spawn ();
   newmis.owner = self;
   newmis.movetype = 9.000;
   newmis.solid = 2.000;

   makevectors (self.v_angle);
   newmis.velocity = v_forward;

   if ( (self.playerclass == 11.000 )) {
      newmis.movedir = (newmis.velocity * 1000.000);
   } else {
      newmis.movedir = (newmis.velocity * 900.000);
   }

   newmis.angles = vectoangles (newmis.movedir);

   if (realistic & 1) {
 
      pvel_x = (self.velocity_x / 2) + (newmis.movedir_x / 3);
      pvel_y = (self.velocity_y / 2) + (newmis.movedir_y / 3);
      pvel_z = (self.velocity_z / 2) + (newmis.movedir_z / 3);

      newmis.velocity =  pvel; 
      //pvel = (self.origin + '0 0 16');

      //traceline (pvel,(pvel + (v_forward * 700.000)),1.000,self);
      //newmis.dest = trace_endpos;
      newmis.think = RealisticMove;
      newmis.nextthink = time + 0.01;
      newmis.attack_finished = (time + 6.000);
   }
   else
   {
      newmis.velocity = newmis.movedir;
      newmis.nextthink = (time + 6.000);
      newmis.think = MissileRadius;
   }

   newmis.classname = "rocket";
   newmis.touch = T_MissileTouch;
   newmis.voided = 0.000;


   
   newmis.weapon = 6.000;
   setmodel (newmis,"progs/missile.mdl");
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,((self.origin + (v_forward * 8.000)) + '0.000 0.000 16.000'));

   #ifdef CSQC

	newmis.SendEntity = SendRocket;
	//newmis.starttime = time;
	newmis.Version+=1;

   #endif
};

void (entity from, float damage) LightningHit = {

   WriteByte (4.000,23.000);
   WriteByte (4.000,13.000);
   WriteCoord (4.000,trace_endpos_x);
   WriteCoord (4.000,trace_endpos_y);
   WriteCoord (4.000,trace_endpos_z);
   multicast (trace_endpos,2.000);
   deathmsg = 7.000;
   TF_T_Damage (trace_ent,from,from,damage,2.000,8.000);

};

void (vector p1, vector p2, entity from, float damage) LightningDamage = {

   local entity e1;
   local entity e2;
   local vector f;

   f = (p2 - p1);
   normalize (f);
   f_x = (0.000 - f_y);
   f_y = f_x;
   f_z = 0.000;
   f = (f * 16.000);
   e2 = world;
   e1 = world;
   traceline (p1,p2,0.000,self);
   if ( trace_ent.takedamage ) {

      LightningHit (from,damage);
      if ( (self.classname == "player") ) {

         if ( (other.classname == "player") ) {

            trace_ent.velocity_z = (trace_ent.velocity_z + 400.000);

         }

      }

   }
   e1 = trace_ent;
   traceline ((p1 + f),(p2 + f),0.000,self);
   if ( ((trace_ent != e1) && trace_ent.takedamage) ) {

      LightningHit (from,damage);

   }
   e2 = trace_ent;
   traceline ((p1 - f),(p2 - f),0.000,self);
   if ( (((trace_ent != e1) && (trace_ent != e2)) && trace_ent.takedamage) ) {

      LightningHit (from,damage);

   }

};

void () W_FireLightning = {

   local vector org;
   local float cells;

   if ( (self.ammo_cells < 1.000) ) {

      self.last = self.current;
      self.current = W_BestWeapon ();
      W_SetCurrentAmmo ();
      W_PrintWeaponMessage ();
      return ;

   }
   if ( (self.waterlevel > 1.000) ) {

      cells = self.ammo_cells;
      self.ammo_cells = 0.000;
      W_SetCurrentAmmo ();
      deathmsg = 7.000;
      T_RadiusDamage (self,self,(35.000 * cells),world);
      return ;

   }
   if ( (self.t_width < time) ) {

      sound (self,1.000,"weapons/lhit.wav",1.000,1.000);
      self.t_width = (time + 0.600);

   }
   KickPlayer (-2.000,self);
   if (!modetype & 2) { 
      self.ammo_cells = (self.ammo_cells - 1.000);
      self.currentammo = self.ammo_cells;
      if (allow_stamina)
         self.stamina = self.stamina - 40;
   }
   org = (self.origin + '0.000 0.000 16.000');
   traceline (org,(org + (v_forward * 600.000)),1.000,self);
   WriteByte (4.000,23.000);
   WriteByte (4.000,6.000);
   WriteEntity (4.000,self);
   WriteCoord (4.000,org_x);
   WriteCoord (4.000,org_y);
   WriteCoord (4.000,org_z);
   WriteCoord (4.000,trace_endpos_x);
   WriteCoord (4.000,trace_endpos_y);
   WriteCoord (4.000,trace_endpos_z);
   multicast (org,1.000);
   LightningDamage (self.origin,(trace_endpos + (v_forward * 4.000)),self,30.000);


};


void (entity player) ExplodeOldPipebomb = {

   local entity old;
   local float index;

   if ( (player != world) ) {

      index = player.pteam.num_pipebombs;
      index = (index - (store_obs.max_pipebombs / store_obs.cnt));
   } else {

      index = (store_obs.num_pipebombs - store_obs.max_pipebombs);

   }



   old = find (world,classname,"pipebomb");
   while ( (index > 0.000) ) {

      if ( (old == world) ) {

         store_obs.num_pipebombs = 0.000;
         pteam1.num_pipebombs = 0.000;
         pteam2.num_pipebombs = 0.000;
         pteam3.num_pipebombs = 0.000;
         pteam4.num_pipebombs = 0.000;
         return ;

      }
      if ( (old.owner == player) || (player == world) ) {

         old.nextthink = (time + 0.500);
         index = (index - 1.000);

      }
      old = find (old,classname,"pipebomb");

   }

};




void () GrenadeExplode = {

   local entity te;

   if ( self.voided ) {

      return ;

   }
   self.voided = 1.000;
   if ( (self.classname == "pipebomb") ) {

      store_obs.num_pipebombs = (store_obs.num_pipebombs - 1.000);
      self.owner.pteam.num_pipebombs = self.owner.pteam.num_pipebombs - 1.000;

      if ( !(self.flags & 512.000) ) {

         self.weapon = 40.000;

      }

   }
   if ( (self.owner.has_disconnected != 1.000) ) {

      deathmsg = self.weapon;
      T_RadiusDamage (self,self.owner,120.000,world);

   }
   if ( (self.no_active_nail_grens != 0.000) ) {

      self.no_active_nail_grens = 0.000;
      self.owner.no_active_nail_grens = (self.owner.no_active_nail_grens - 1.000);
      te = find (world,classname,"grenade");
      while ( te ) {

         if ( ((te.owner == self.owner) && (te.no_active_nail_grens > 0.000)) ) {

            te.no_active_nail_grens = (te.no_active_nail_grens - 1.000);

         }
         te = find (te,classname,"grenade");

      }

   }
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   dremove (self);

};


void () PipebombTouch = {

   if ( (other.classname != "worldspawn") ) {

      return ;

   }

   sound (self,1.000,"weapons/bounce.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};

void () GrenadeTouch = {

   if ( (other == self.owner) ) {

      return ;

   }
   if ( (other.takedamage == 2.000) ) {

      GrenadeExplode ();
      return ;

   }
   sound (self,1.000,"weapons/bounce.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};


void (entity te) InitGrenade = {

   local vector pvel;

   if (!modetype & 2) { 
      self.ammo_rockets = (self.ammo_rockets - 1.000);
      self.currentammo = self.ammo_rockets;
      if (allow_stamina)
         self.stamina = self.stamina - 180;
   }
   sound (self,1.000,"weapons/grenade.wav",1.000,1.000);
   KickPlayer (-2.000,self);

   te.voided = 0.000;
   te.owner = self;
   te.movetype = 10.000;
   te.solid = 2.000;


   makevectors (self.v_angle);
   if ( self.v_angle_x ) {

      te.movedir = ((((v_forward * 600.000) + (v_up * 200.000)) + ((crandom () * v_right) * 10.000)) + ((crandom () * v_up) * 10.000));

   } else {

      te.movedir = aim (self,10000.000);
      te.movedir = (te.movedir * 600.000);
      te.movedir_z = 200.000;

   }
   te.avelocity = '300.000 300.000 300.000';
   te.angles = vectoangles (te.movedir);

   if (realistic & 1) 
   {

      pvel_x = (self.velocity_x / 2);
      pvel_y = (self.velocity_y / 2);
      pvel_z = (self.velocity_z / 2);
      te.velocity =  pvel + te.movedir;
   }
   else
   {
      te.velocity =  te.movedir;
   }


   te.think = GrenadeExplode;
   setmodel (te,"progs/grenade2.mdl");
   setsize (te,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (te,self.origin);



};
#ifdef CSQC

float(entity toplayer) SendGrenade =
{
	WriteByte(MSG_ENTITY, CLASS_GRENADE);
	WriteByte(MSG_ENTITY, self.skin);
	WriteCoord(MSG_ENTITY, self.origin_x);
	WriteCoord(MSG_ENTITY, self.origin_y);
	WriteCoord(MSG_ENTITY, self.origin_z);
	WriteCoord(MSG_ENTITY, self.velocity_x);
	WriteCoord(MSG_ENTITY, self.velocity_y);
	WriteCoord(MSG_ENTITY, self.velocity_z);
	WriteAngle(MSG_ENTITY, self.angles_x);
	WriteAngle(MSG_ENTITY, self.angles_y);

	return 1.000;
};
#endif

void () W_FireGrenade = {

      newmis = spawn ();

      InitGrenade(newmis);

      newmis.weapon = 5.000;
      newmis.classname = "grenade";
      newmis.skin = 1.000;
      newmis.touch = GrenadeTouch;
      newmis.nextthink = (time + 2.500);

   #ifdef CSQC

	newmis.SendEntity = SendGrenade;
	newmis.starttime = time;
	newmis.Version+=1;

   #endif
};

void () W_FirePipebomb = {

      newmis = spawn ();

      InitGrenade(newmis);

      if ( (self.pteam) ) {

         self.pteam.num_pipebombs = self.pteam.num_pipebombs + 1.000;
         if ( (self.pteam.num_pipebombs > (store_obs.max_pipebombs / store_obs.cnt)) ) {

            ExplodeOldPipebomb (self);

         }

      } else {

         store_obs.num_pipebombs = (store_obs.num_pipebombs + 1.000);
         if ( (store_obs.num_pipebombs > store_obs.max_pipebombs ) ) {

            ExplodeOldPipebomb (world);

         }

      }
      newmis.classname = "pipebomb";
      newmis.touch = PipebombTouch;
      newmis.skin = 2.000;
      newmis.nextthink = (time + 120.000);
      newmis.weapon = 11.000;
      newmis.pteam = self.pteam;

   #ifdef CSQC

	newmis.SendEntity = SendGrenade;
	newmis.starttime = time;
	newmis.Version+=1;

   #endif

};

#ifdef CSQC

float(entity toplayer) SendNail =
{
	vector v;
	v = self.origin + self.velocity*(time-self.starttime);
	WriteByte(MSG_ENTITY, CLASS_NAIL);
	WriteCoord(MSG_ENTITY, v_x);
	WriteCoord(MSG_ENTITY, v_y);
	WriteCoord(MSG_ENTITY, v_z);
	WriteAngle(MSG_ENTITY, self.angles_x);
	WriteAngle(MSG_ENTITY, self.angles_y);
	//WriteByte(MSG_ENTITY, );

	return 1.000;
};
#endif

void () spike_touch;

void () superspike_touch;

void (vector org, vector dir) launch_spike = {

   local vector pvel;

   newmis = spawn ();
   newmis.voided = 0.000;
   newmis.owner = self;
   newmis.movetype = 9.000;
   newmis.solid = 2.000;
   newmis.angles = vectoangles (dir);
   newmis.touch = spike_touch;
   newmis.weapon = 3.000;
   newmis.classname = "spike";

   newmis.movedir = (dir * 1000.000);

  if (realistic & 1) {

      pvel_x = (self.velocity_x / 2) + (newmis.movedir_x / 3);
      pvel_y = (self.velocity_y / 2) + (newmis.movedir_y / 3);
      pvel_z = (self.velocity_z / 2) + (newmis.movedir_z / 3);
      newmis.velocity =  pvel;
      newmis.attack_finished = (time + 3.000);
      newmis.think = RealisticMove;
      newmis.nextthink = time + 0.01;
   }
   else
   {
      newmis.velocity = newmis.movedir;
      newmis.think = SUB_Remove;
      newmis.nextthink = (time + 3.000);
   }


   setmodel (newmis,"progs/spike.mdl");
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,org);


   #ifdef CSQC

	newmis.SendEntity = SendNail;
	newmis.starttime = time;
	newmis.Version+=1;

   #endif

};


void () W_FireSuperSpikes = {

   local vector dir;

   sound (self,1.000,"weapons/spike2.wav",1.000,1.000);
   if (!modetype & 2) { 
      self.ammo_nails = (self.ammo_nails - 2.000);
      self.currentammo = self.ammo_nails;
      if (allow_stamina)
         self.stamina = self.stamina - 30;
   }
   dir = aim (self,1000.000);
   launch_spike ((self.origin + '0.000 0.000 16.000'),dir);
   newmis.touch = superspike_touch;
   newmis.weapon = 4.000;
   setmodel (newmis,"progs/s_spike.mdl");
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   KickPlayer (-2.000,self);



};

void (float ox) W_FireSpikes = {

   local vector dir;

   makevectors (self.v_angle);
   if ( ((self.ammo_nails >= 2.000) && (self.current == WEAP_SUPER_NAILGUN)) ) {

      W_FireSuperSpikes ();
      return ;

   }
   if ( (self.ammo_nails < 1.000) ) {

      self.last = self.current;
      self.current = W_BestWeapon ();
      W_SetCurrentAmmo ();
      W_PrintWeaponMessage ();
      return ;

   }
   sound (self,1.000,"weapons/rocket1i.wav",1.000,1.000);
   if (!modetype & 2) { 

      if (allow_stamina)
         self.stamina = self.stamina - 20;

   //   if ( (self.ammo_nails == 1.000) )
   //   {
         self.ammo_nails = (self.ammo_nails - 1.000);
   //   }
   //   else
   //   {
   //      self.ammo_nails = (self.ammo_nails - 2.000);
   //   }
      self.currentammo = self.ammo_nails;
   }
   dir = aim (self,1000.000);
   if (light_ents) 
   {
	deathmsg = 3.000000;
	FireSniperBullet (dir, 4.000, '0 0 0');

   }
   else
   {
      launch_spike (((self.origin + '0.000 0.000 16.000') + (v_right * ox)),dir);
   }
   KickPlayer (-2.000,self);

};
//.float hit_z;

void () spike_touch = {


   if ( self.voided ) {

      return ;

   }
   self.voided = 1.000;
   if ( (other.solid == 1.000) ) {

      return ;

   }
   if ( (pointcontents (self.origin) == -6.000) ) {

      dremove (self);
      return ;

   }
   if ( other.takedamage ) {

      spawn_touchblood (9.000);
      deathmsg = self.weapon;
      if ( (self.owner.classname == "grenade") ) {

         TF_T_Damage (other,self,self.owner.owner,9.000,2.000,2.000);

      } else {

         TF_T_Damage (other,self,self.owner,18.000,2.000,2.000);

      }

   } else {


      WriteByte (4.000,23.000);
      WriteByte (4.000,0.000);
      //WriteByte (4.000,7.000);
      //WriteByte (4.000,8.000);
      WriteCoord (4.000,self.origin_x);
      WriteCoord (4.000,self.origin_y);
      WriteCoord (4.000,self.origin_z);
      multicast (self.origin,1.000);

   }
   dremove (self);

};

void () superspike_touch = {

   local float ndmg;

   if ( self.voided ) {

      return ;

   }
   self.voided = 1.000;
   if ( (other == self.owner) ) {

      return ;

   }
   if ( (other.solid == 1.000) ) {

      return ;

   }
   if ( (pointcontents (self.origin) == -6.000) ) {

      dremove (self);
      return ;

   }

   if ( other.takedamage ) {

      spawn_touchblood (18.000);
      deathmsg = self.weapon;
      if ( (deathmsg == 9.000) ) {

         ndmg = 30.000;

      } else {

         ndmg = 18.000;

      }
      if ( (self.owner.classname == "grenade") ) {

         TF_T_Damage (other,self,self.owner.owner,ndmg,2.000,2.000);

      } else {

         TF_T_Damage (other,self,self.owner,ndmg,2.000,2.000);

      }

   } else {

      WriteByte (4.000,23.000);
      if ( (self.owner.classname == "grenade") ) {
         WriteByte (4.000,8.000);
      } else {
         WriteByte (4.000,1.000);
      }
      WriteCoord (4.000,self.origin_x);
      WriteCoord (4.000,self.origin_y);
      WriteCoord (4.000,self.origin_z);
      multicast (self.origin,1.000);

   }
   dremove (self);

};

void () set_ca_none = {
	self.currentammo = 0.000;
	self.weaponmodel = "";
};

void () set_ca_hook = {

      self.currentammo = 0.000;
      self.weaponmodel = "progs/v_grap.mdl";

};
void () set_ca_medi = {
       self.currentammo = self.ammo_medikit;
       self.weaponmodel = "progs/v_medi.mdl";


};
void () set_ca_span = {

       self.currentammo = self.ammo_cells;
       self.weaponmodel = "progs/v_span.mdl";


};
void () set_ca_axe = {

      self.currentammo = 0.000;
      if ( (self.playerclass == 8.000) ) {

         self.weaponmodel = "progs/v_knife.mdl";

      } else {

         if (modetype & 4) {
            self.weaponmodel = "progs/v_knife.mdl";
         } else {
            self.weaponmodel = "progs/v_axe.mdl";

         }

      }
};
void () set_ca_sr = {
       self.currentammo = self.ammo_shells;
       self.weaponmodel = "progs/v_srifle.mdl";
       self.items = (self.items | 256.000);
       self.weapon = 1.000;
};
void () set_ca_ar = {

       self.currentammo = self.ammo_shells;
       self.items = (self.items | 256.000);
       self.weaponmodel = "progs/v_srifle.mdl";
       self.weapon = 2.000;
};

void () set_ca_sg = {
       self.currentammo = self.ammo_shells;
       self.items = (self.items | 2048.000);
       if ( !(self.tfstate & 2.000) ) {

       self.weaponmodel = "progs/v_shot.mdl";

       }
       self.items = (self.items | 256.000);
       self.weapon = 1.000;
};
void () set_ca_ssg = {
       self.currentammo = self.ammo_shells;
       if ( !(self.tfstate & 2.000) ) {

       self.weaponmodel = "progs/v_shot2.mdl";
       self.weaponframe = 0.000;

       }
       self.items = (self.items | 256.000);
       self.weapon = 2.000;
};
void () set_ca_ng = {

       self.currentammo = self.ammo_nails;
       self.weaponmodel = "progs/v_nail.mdl";
       self.items = (self.items | 512.000);
       self.weapon = 4.000;

};
void () set_ca_sng = {
       self.currentammo = self.ammo_nails;
       self.weaponmodel = "progs/v_nail2.mdl";
       self.items = (self.items | 512.000);
       self.weapon = 8.000;
};

void () set_ca_gren = {
       self.currentammo = self.ammo_rockets;
       if ( !(self.tfstate & 2.000) ) {
          self.weaponmodel = "progs/v_rock.mdl";
       }


       self.items = (self.items | 1024.000);
};
void () set_ca_gl = {
       set_ca_gren();
       self.weapon = 16.000;
};
void () set_ca_pbl = {
       set_ca_gren();
       self.weapon = 32.000;
};
void () set_ca_ft = {

       self.currentammo = self.ammo_cells;
      if (sep_models) 
      {
         self.weaponmodel = "progs/v_flame.mdl";
      }
      else
      {
         self.weaponmodel = "progs/v_rock.mdl";
      }


       self.items = (self.items | 2048.000);
       self.weapon = 8.000;
};
void () set_ca_rl = {

      self.currentammo = self.ammo_rockets;
      if ( !(self.tfstate & 2.000) ) {

         self.weaponmodel = "progs/v_rock2.mdl";
      }
      self.items = (self.items | 1024.000);
      self.weapon = 32.000;
};
void () set_ca_ic = {
      self.currentammo = self.ammo_rockets;
      if (sep_models) 
      {
         self.weaponmodel = "progs/v_ican.mdl";
      }
      else
      {
         self.weaponmodel = "progs/v_rock2.mdl";
      }
      self.items = (self.items | 1024.000);
      self.weapon = 32.000;
};
void () set_ca_ac = {
      self.currentammo = self.ammo_shells;
	self.weaponmodel = "progs/v_asscan.mdl";
      self.items = (self.items | 256.000);
      self.weapon = 64.000;
};
void () set_ca_lg = {

      self.currentammo = self.ammo_cells;
      self.weaponmodel = "progs/v_light.mdl";
      self.items = (self.items | 2048.000);
      self.weapon = 64.000;
};
void () set_ca_pl = {

       self.currentammo = self.ammo_cells;
       self.items = (self.items | 2048.000);
       self.weaponmodel = "progs/v_plasma.mdl";
       self.weapon = 16.000;
};
void () set_ca_tr = {
      self.currentammo = self.ammo_shells;
      if (sep_models) 
      {
         self.weaponmodel = "progs/v_tranq.mdl";
      }
      else
      {
         self.weaponmodel = "progs/v_shot.mdl";
      }
      
      self.items = (self.items | 256.000);
      self.weapon = 1.000;
};
void () set_ca_rg = {
      self.currentammo = self.ammo_nails;
      self.weaponmodel = "progs/v_rail.mdl";
      self.items = (self.items | 512.000);
      self.weapon = 1.000;
};

var void() weapnum_setammo[21] = {
	set_ca_none,
	set_ca_hook,
	set_ca_medi,
	set_ca_span,
	set_ca_axe,
	set_ca_sr,
	set_ca_ar,
 	set_ca_sg,
 	set_ca_ssg,
 	set_ca_ng,
 	set_ca_sng,
 	set_ca_gl,
 	set_ca_pbl,
	set_ca_ft,
 	set_ca_rl,
	set_ca_ic,
	set_ca_ac,
 	set_ca_lg,
	set_ca_pl,
	set_ca_tr,
 	set_ca_rg
};



void () W_SetCurrentAmmo = {

   local float i, b;

   if ( ((self.health <= 0.000) || (self.current == 0.000)) ) {

      return ;

   }
   if ( ((self.current == WEAP_ASSAULT_CANNON) && (self.tfstate & 2048.000)) ) {

      return ;

   }

   player_run ();


   self.items = (self.items - (self.items & (((256.000 | 512.000) | 1024.000) | 2048.000)));
   self.weapon = 0.000;


   for (b = 1; b < WEAP_LAST;  b *= 2)
   {
        i++;
        if (self.current == b)  
        {
            break;
        }
   }

   self.th_melee = weapnum_setammo[i];
   self.th_melee();
   if (self.StatusBarSize) 
       self.StatusRefreshTime = (time + 0.100);
   self.weaponframe = 0.000;
};

float () W_BestWeapon = {

   local float it;

   it = self.carried;
   if ( (((self.ammo_cells >= 1.000) && (it & WEAP_LIGHTNING)) && (self.waterlevel <= 1.000)) ) {

      return ( WEAP_LIGHTNING );

   } else {

      if ( (((self.ammo_cells >= 7.000) && (self.ammo_shells >= 1.000)) && (it & WEAP_ASSAULT_CANNON)) ) {

         return ( WEAP_ASSAULT_CANNON );

      } else {

         if ( ((self.ammo_cells >= 1.000) && (it & WEAP_FLAMETHROWER)) ) {

            return ( WEAP_FLAMETHROWER );

         } else {

            if ( ((self.ammo_nails >= 2.000) && (it & WEAP_SUPER_NAILGUN)) ) {

               return ( WEAP_SUPER_NAILGUN );

            } else {

               if ( ((self.ammo_shells >= 2.000) && (it & WEAP_SUPER_SHOTGUN)) ) {

                  return ( WEAP_SUPER_SHOTGUN );

               } else {

                  if ( ((self.ammo_nails >= 1.000) && (it & WEAP_RAILGUN)) ) {

                     return ( WEAP_RAILGUN );

                  } else {

                     if ( ((self.ammo_nails >= 1.000) && (it & WEAP_NAILGUN)) ) {

                        return ( WEAP_NAILGUN );

                     } else {

                        if ( ((self.ammo_shells >= 1.000) && (it & WEAP_SHOTGUN)) ) {

                           return ( WEAP_SHOTGUN );

                        } else {

                           if ( ((self.ammo_shells >= 1.000) && (it & WEAP_TRANQ)) ) {

                              return ( WEAP_TRANQ );

                           } else {

                              if ( (it & WEAP_AXE) ) {

                                 return ( WEAP_AXE );

                              } else {

                                 if ( (it & WEAP_SPANNER) ) {

                                    return ( WEAP_SPANNER );

                                 } else {

                                    if ( (it & WEAP_MEDIKIT) ) {

                                       return ( WEAP_MEDIKIT );

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
   return ( 0.000 );

};
float () W_CheckNoAmmo = {

      if ( (self.current == WEAP_MEDIKIT) ) {

         return ( 1.000 );
   

      } else {

         if ( (((self.current == WEAP_AXE) || (self.current == WEAP_HOOK)) || (self.current == WEAP_SPANNER)) ) {

            return ( 1.000 );

         } else {

            if (self.current == WEAP_INCENDIARY) {
		
               if (self.currentammo >= ic_ammo)
               {
                  return ( 1.000 );
               }
		} 
            else if ((self.current == WEAP_ASSAULT_CANNON) && (self.ammo_cells < 7.000))
            {
              sprint (self,2.000,"Insufficient cells to power up the Assault Cannon.\n");
              return (0.000);
            }
            else
            { 
               if ( (self.currentammo > 0.000) )
               {
                  return ( 1.000 );
               }

            }

         }

      }
      sprint (self,2.000,"not enough ammo.\n");
      return ( 0.000 );
  

};


void () player_axe1;

void () player_axeb1;

void () player_axec1;

void () player_axed1;

void () player_shot1;

void () player_nail1;

void () player_light1;

void () player_rocket1;

void () player_autorifle1;

void () player_assaultcannon1;

void () player_assaultcannonup1;

void () player_assaultcannondown1;

void () player_medikit1;

void () player_medikitb1;

void () player_medikitc1;

void () player_medikitd1;

void () player_chain1;

void () player_chain2;

void () player_chain3;

void () player_chain4;

void () player_chain5;

void () attack_none =
{
	player_run();
};


void () attack_axe =
{
	local float r;

      Attack_Finished (0.500);
      sound (self,1.000,"weapons/ax1.wav",1.000,1.000);
      r = random ();
      if ( (r < 0.250) ) {

         player_axe1 ();

      } else {

         if ( (r < 0.500) ) {

            player_axeb1 ();

         } else {

            if ( (r < 0.750) ) {

               player_axec1 ();

            } else {

               player_axed1 ();

            }

         }

      }
};

void () attack_medi =
{
	local float r;

	sound (self,1.000,"weapons/ax1.wav",1.000,1.000);
	r = random ();
	   if ( (r < 0.250) ) {

	      player_medikit1 ();

         } else {

            if ( (r < 0.500) ) {

               player_medikitb1 ();

            } else {

               if ( (r < 0.750) ) {

                  player_medikitc1 ();

               } else {

                  player_medikitd1 ();

               }

            }

         }

	Attack_Finished (0.500);
};

void () attack_span =
{
      Attack_Finished (0.500);
      sound (self,1.000,"weapons/ax1.wav",1.000,1.000);
      player_axe1 ();

};

void () attack_hook =
{
      if ( !self.hook_out )
          player_chain1 ();

      Attack_Finished (0.100);
};

void () attack_sg =
{
      if ( (CheckForReload ()) ) return ;
      player_shot1 ();
      W_FireShotgun ();
      self.reload_shotgun = (self.reload_shotgun + 1.000);
      CheckForReload ();
      Attack_Finished (0.500);
};

void () attack_ssg =
{
      if ( (CheckForReload ()) )   return ;

      player_shot1 ();
      W_FireSuperShotgun ();
      self.reload_super_shotgun = (self.reload_super_shotgun + 2.000);
      CheckForReload ();
      Attack_Finished (0.700);
};

void () attack_ng =
{
	player_nail1 ();
};

void () gren_end = {

     self.reload_grenade_launcher = (self.reload_grenade_launcher + 1.000);
     CheckForReload ();
     Attack_Finished (0.600);
};

void () attack_gl =
{
     if ( (CheckForReload ()) )  return ;
     player_rocket1 ();
     W_FireGrenade ();
     gren_end();
};

void () attack_pbl =
{
     if ( (CheckForReload ()) )  return ;
     player_rocket1 ();
     W_FirePipebomb ();
     gren_end();

};

void () attack_rl =
{
     if ( (CheckForReload ()) )  return ;
     player_rocket1 ();
     W_FireRocket ();
     self.reload_rocket_launcher = (self.reload_rocket_launcher + 1.000);
     if (self.StatusBarSize) 
	  self.StatusRefreshTime = (time + 0.100);
     CheckForReload ();
     Attack_Finished (0.800);
};

void () attack_lg =
{
	player_light1 ();
	Attack_Finished (1.100);
	sound (self,0.000,"weapons/lstart.wav",1.000,1.000);
};

void () attack_sr =
{
      if (self.flags & 512.000) 
	{
         player_shot1 ();
         W_FireSniperRifle ();
         Attack_Finished (1.700);
      }
};

void () attack_pl =
{
	player_autorifle1 ();
      W_FirePlasma ();
      Attack_Finished (0.125);
};

void () attack_ar =
{
	player_autorifle1 ();
      W_FireAutoRifle ();
      Attack_Finished (0.100);

};

void () attack_ac =
{
   self.ammo_cells = (self.ammo_cells - 7.000);
   self.heat = 1.000;
   if (classtype & 2.000)
      self.tfstate = (self.tfstate | 65536.000);
   self.tfstate = (self.tfstate | 2048.000);
   TeamFortress_SetSpeed (self);
   player_assaultcannonup1 ();
   
};

void () attack_ft =
{
      player_shot1 ();
      W_FireFlame ();
	if ( (self.waterlevel > 2.000) )
	{
         Attack_Finished (1.000);
      }
	else
	{
         Attack_Finished (0.150);
      }
};

void () attack_ic =
{
      player_rocket1 ();
      W_FireIncendiaryCannon ();

      if (classtype & 16)
      {
         Attack_Finished (1.200);
      }
      else
     {
         Attack_Finished (0.900);
      }
};

void () attack_tr =
{
     sound (self,1.000,"weapons/dartgun.wav",1.000,1.000);
     player_shot1 ();
     W_FireTranq ();
     Attack_Finished (1.500);
};

void () attack_rg =
{

     sound (self,1.000,"weapons/railgun.wav",1.000,1.000);
     player_shot1 ();
     if (railgun) 
        W_FireRailgun ();
     else
        W_FireRail ();
     Attack_Finished (0.400);
};

var void() weapnum_attack[21] = {
	attack_none,
	attack_hook,
	attack_medi,
	attack_span,
	attack_axe,
	attack_sr,
	attack_ar,
 	attack_sg,
 	attack_ssg,
 	attack_ng,
 	attack_ng,
 	attack_gl,
	attack_pbl,
	attack_ft,
 	attack_rl,
	attack_ic,
	attack_ac,
 	attack_lg,
	attack_pl,
	attack_tr,
 	attack_rg
};



void () W_Attack = {

   local float b;
   local float i;
   local entity te;


   if ( !W_CheckNoAmmo () ) {

      self.current = W_BestWeapon ();
      W_SetCurrentAmmo ();
      W_PrintWeaponMessage ();
      return ;

   }
   if (allow_stamina) {
     if (self.stamina < 0.000) {
        return;
     }
   }   
   if ( (self.has_disconnected == 1.000) ) {

      return ;

   }
   if ( (!self.playerclass) ) {

      return ;

   }
   
   if ( (self.tfstate & 2.000) ) {

      if (realistic & 2.000) {
         te = find (world,classname,"timer");
         while ( (te != world) ) {

            if (te.owner == self && te.weaponmode) {

               if (te.voided) return;
               te.think = Cancel_reload;
               te.pausetime = te.nextthink;
               te.nextthink = time + 0.01;
               te.voided = 1.000;
               return;

            } else {

               te = find (te,classname,"timer");
            }

         }
      }

      return ;
   }

   if ( ((self.is_undercover || (self.undercover_team != 0.000)) || (self.undercover_skin != 0.000)) ) {

      Spy_RemoveDisguise (self);

   }
   makevectors (self.v_angle);
   self.show_hostile = (time + 1.000);

   for (b = 1; b < WEAP_LAST;  b *= 2)
   {
        i++;
        if (self.current == b)  
        {
            break;
        }
   }

   self.th_missile = weapnum_attack[i];
   self.th_missile();

};

void () W_PrintWeaponMessage = {

   if ( (self.current == WEAP_AXE) ) {

      if ( (self.playerclass != 8.000) ) {

         sprint (self,1.000,"Axe selected\n");

      }

   } else {

      if ( (self.current == WEAP_HOOK) && allow_hook ) {

         sprint (self,1.000,"grappling hook selected\n");

      } else {

         if ( (self.current == WEAP_GRENADE_LAUNCHER) ) {

            if ((self.playerclass != 11.000)) {

               sprint (self,1.000,"Normal grenade mode\n");

            } else {

               if ( (self.current == WEAP_PIPEBOMB_LAUNCHER) ) {

                  sprint (self,1.000,"Pipebomb mode\n");

               }

            }

         } else {

            if ( (self.current == WEAP_SNIPER_RIFLE) ) {

               sprint (self,1.000,"Sniper rifle ready\n");

            } else {

               if ( (self.current == WEAP_AUTO_RIFLE) ) {


                  sprint (self,1.000,"Rifle on fully auto\n");

               } else {

                  if ( (self.current == WEAP_TRANQ) ) {

                     sprint (self,1.000,"Tranquiliser gun selected\n");

                  } else {

                     if ( (self.current == WEAP_MEDIKIT) ) {

                        sprint (self,1.000,"Medikit/Bioweapon readied\n");

                     } else {
				
			      if ( (self.current == WEAP_INCENDIARY )) {

				   sprint(self,1.000,"Incendiary Cannon\n");
				   
				}

                     }

                  }

               }

            }

         }

      }

   }

};
/*

float(float wn) weaponmask =
 {
	float r;
 	r = 1;
 	while(wn)
 	{
		r *= 2;
		wn -= 1;
	}
	return r;
 };


float (float weap) weap_item = {


    if (weap == WEAP_HOOK) 
    {
        return (0.000);
    }
    else if (weap ==  WEAP_MEDIKIT) 
    {
        return(0.000);
    }
    else if (weap == WEAP_SPANNER) 
    {
        return(0.000);
    }
    else if (weap == WEAP_AXE) 
    {
        return(0.000);
    }
    else if (weap == WEAP_SNIPER_RIFLE) 
    {
          ammo_ch_shells(1);
    }
    else if (weap == WEAP_AUTO_RIFLE) 
    {
          ammo_ch_shells(1);
    }
    else if (weap == WEAP_SHOTGUN) 
    {
          ammo_ch_shells(1);
    }
    else if (weap == WEAP_SUPER_SHOTGUN) 
    {
          ammo_ch_shells(2);
    }
    else if (weap == WEAP_NAILGUN) 
    {
          ammo_ch_nails(1);
    }
    else if (weap == WEAP_SUPER_NAILGUN) 
    {
          ammo_ch_nails(2);
    }
    else if (weap == WEAP_GRENADE_LAUNCHER) 
    {
          ammo_ch_rocks(1);
    }
    else if (weap == WEAP_FLAMETHROWER) 
    {
          ammo_ch_cells(1);
    }
    else if (weap == WEAP_ROCKET_LAUNCHER) 
    {
          ammo_ch_rocks(1);
    }
    else if (weap == WEAP_INCENDIARY) 
    {
          ammo_ch_rocks(ic_ammo);
    }
    else if (weap == WEAP_ASSAULT_CANNON) 
    {
          ammo_ch_shells(1);
          ammo_ch_cells(7);
    }
    else if (weap == WEAP_LIGHTNING) 
    {
          ammo_ch_cells(1);
    }
    else if (weap == WEAP_TRANQ) 
    {
          ammo_ch_shells(1);
    }
    else if (weap == WEAP_RAILGUN) 
    {
          ammo_ch_nails(1);
    }
    else if (weap == WEAP_PLASMAGUN) 
    {
          ammo_ch_cells(1);
    }
    return(0.000);
};

*/

float () imp_1 = {

   if (self.carried & WEAP_MEDIKIT)
   {
       return (WEAP_MEDIKIT);
   }
   else if (self.carried & WEAP_SPANNER)
   { 
       return (WEAP_SPANNER);
   }
   else 
   { 
       return (WEAP_AXE);
   } 
};

void () W_ChangeWeapon = {

   local float fl, imp;

   if ( (self.tfstate & 2.000) ) {

      return ;

   }
   fl = self.current;
   imp = self.impulse;

   if ( (imp == 1.000) ) {

        if (allow_hook) {
           if ((fl == WEAP_AXE) || (fl == WEAP_MEDIKIT) || (fl == WEAP_SPANNER))
           {
              fl = WEAP_HOOK;
              if ( self.hook_out )
              {
                Reset_Grapple (self.hook);
              }
           }
           else
           {
              fl = imp_1();
           }
        } 
        else
        {
           fl = imp_1();
        }


   } else {

      if ( (allow_hook && ((imp == 22.000) || (imp == 39.000))) ) {

         fl = WEAP_HOOK;

      } else {

         if ( (imp == 40.000) ) {

            fl = imp_1();

         } else {

            if ( (imp == 2.000) ) {

               if ( (self.carried & WEAP_SNIPER_RIFLE) ) {

                  fl = WEAP_SNIPER_RIFLE;

               } else {

                  if ( (self.carried & WEAP_SHOTGUN) ) {

                     fl = WEAP_SHOTGUN;

                  } else {

                     if ( (self.carried & WEAP_TRANQ) ) {

                        fl = WEAP_TRANQ;


                     } else {

                           fl = WEAP_RAILGUN;
                     }

                  }

               }

            } else {

               if ( (imp == 3.000) ) {

                  if ( (self.carried & WEAP_AUTO_RIFLE) ) {

                     fl = WEAP_AUTO_RIFLE;

                  } else {

                     fl = WEAP_SUPER_SHOTGUN;

                  }

               } else {

                  if ( (imp == 4.000) ) {

                     fl = WEAP_NAILGUN;

                  } else {

                     if ( (imp == 5.000) ) {

				if (self.carried & WEAP_SUPER_NAILGUN) {

                           fl = WEAP_SUPER_NAILGUN;

                        } else {

                           fl = WEAP_FLAMETHROWER;
				}

                     } else {

                        if ( (imp == 6.000) ) {
                           
                              if ( (self.carried & WEAP_GRENADE_LAUNCHER) ) {

                                 fl = WEAP_GRENADE_LAUNCHER;

                              } else {

                                 fl = WEAP_PLASMAGUN;

                              }

                           

                        } else {

                           if ( (imp == 7.000) ) {

                              if ( (self.carried & WEAP_INCENDIARY) ) {

                                 fl = WEAP_INCENDIARY;
					   
                              } else {

                                 if ( (self.carried & WEAP_ROCKET_LAUNCHER) ) {

                                    fl = WEAP_ROCKET_LAUNCHER;

                                 } else {

                                    //if ( (self.carried & WEAP_PIPEBOMB_LAUNCHER) ) {

                                       fl = WEAP_PIPEBOMB_LAUNCHER;

                                    //}

                                 }

                              }

                           } else {

                              if ( (imp == 8.000) ) {

                                 if ( (self.carried & WEAP_LIGHTNING) ) {

                                    fl = WEAP_LIGHTNING;

                                 } else {

                                       fl = WEAP_ASSAULT_CANNON;
                                 }

                              } else {

                                 if ( (imp == 176.000) ) {

                                    fl = WEAP_MEDIKIT;

                                 } else {

                                    if ( (imp == 12.000) ) {

                                       fl = self.last;

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
   self.impulse = 0.000;
   if (!(self.carried & fl)) {

      sprint (self,2.000,"no weapon.\n");
      return ;

   }



   self.last = self.current;
   self.current = fl;

   W_SetCurrentAmmo ();
   W_PrintWeaponMessage ();


};


void (float weap) SetWeapon = {

      self.last = self.current;
      self.current = weap;
      if ( (self.carried & self.current) ) {

         W_SetCurrentAmmo ();
         W_PrintWeaponMessage ();
     }

};

void () PrevWeaponCmd = {

   local float i;

   if ( ((self.weaponmodel == string_null) || (self.current == 0.000)) ) {

      return ;

   }
   if ( (self.tfstate & 2.000) ) {

      return ;

   }

   for (i = self.current; i > WEAP_HOOK;  i *= 0.5)
   {
       if (i != self.current)
       {

          if (self.carried & i)
          {
             SetWeapon(i);
             break;
          }
      }
   }

  
   if (i == WEAP_HOOK)
   {
         if (self.carried & WEAP_HOOK && self.current != WEAP_HOOK) 
         {
             SetWeapon(WEAP_HOOK);
             return; 
         }

          for (i = WEAP_LAST; i > WEAP_HOOK;  i *= 0.5)
          {

              if (i & self.carried ) {

                 SetWeapon(i);
                 break;
              }
          }
   }


};

void () NextWeaponCmd = {

   local float i;

   if ( ((self.weaponmodel == string_null) || (self.current == 0.000)) ) {

      return ;

   }
   if ( (self.tfstate & 2.000) ) {

      return ;

   }



   for (i = self.current; i < WEAP_LAST;  i *= 2)
   {
       if (i != self.current)
       {

          if (self.carried & i)
          {
             SetWeapon(i);
             break;
          }
      }
   }

  
   if (i == WEAP_LAST)
   {
          if (self.carried & WEAP_HOOK) {
             SetWeapon(WEAP_HOOK);
             return; 
          }
          
          for (i = WEAP_HOOK; i < WEAP_LAST; i *= 2)
          {
              if (i & self.carried ) {
                 SetWeapon(i);
                 break;
              }
          }
   }


};

// everytime a impulse is pressed, this procedure is looped. If the time pressed is greated then 1 frame,
// it is loooped many times until impulse = 0.
// therefore after each procedure the addition of impulse = 0 and a return was added after each procedure
// to prevent excessive loops. Known to cause sticky grenades and un-useable impulses during loops.
// also procedures prematch and dead impulses was defined as a float to return to the weaponframe instead
// of just returning to impulse commands. Since commands is the last lot of impulses it was not needed to return directly.

float () PreMatchImpulses;

void () CommandImpulses;

float () DeadImpulses;

float () CheckClanMode = {

    if (( modetype & 1) && (!cb_prematch)) {
       sprint(self, 2.000, "Clan Battle in progress....\n");
       self.impulse = 0.000;
       return 1;
    }
    return 0;
};

void () SuperDamageSound = {

   if ( (self.super_damage_finished > time) ) {

      if ( (self.super_sound < time) ) {

         self.super_sound = (time + 1.000);
         sound (self,4.000,"items/damage3.wav",1.000,1.000);

      }

   }
   return ;

};

void () W_WeaponFrame = {

   local vector tv;

   if ( !(self.tfstate & 2048.000) ) {

      if ( ((self.height > 29.000) && (self.height < self.oldheight)) ) {

         self.height = (self.height + 8.000);
         if ( (self.height > self.oldheight) ) {

            self.height = self.oldheight;

         }
         TF_zoom (self.height);

      }

   }

   if (round_active) {

      if ( (self.pteam.netname == "observe") ) {

         if (self.playerclass || self.deadflag) return;

         if (self.last_impulse) {

            if ( self.impulse ) {

               if (( self.last_impulse == 71.000 )) {

                  StatusRes (self.impulse);
                  self.impulse = 0.000;
                  return;
               }
            }
         }
         if (self.impulse) {

            if (DeadImpulses() ) return;
            CommandImpulses();
            self.impulse = 0.000;
         }
         return;
      }
   }


   if ( (self.current_menu > 0.000) ) {

	Player_Menu ();

	if ( (self.impulse > 0.000) && (self.impulse < 11.000) )
	{

		if ((self.pteam.team == 0.000) && teamplay) 
		{

			Menu_Team_Input (self.impulse);

		} else {

			if ( (!self.playerclass) )
			{
				if (round_active) return;
				Menu_Class_Input (self.impulse);
			}
		}
		Menu_Input (self.impulse);
	}

   }

   if ((self.current == WEAP_ASSAULT_CANNON) || (self.current == WEAP_SPANNER)) { 

      if ( (time < self.attack_finished) ) {

         return ;

      }
   }

   if ( ((self.impulse != 0.000) && (self.has_disconnected == 0.000)) ) {

      ImpulseCommands ();

   }


   if ( cease_fire ) {

      return ;

   }

   if (round_over) {
      return;
   }

   if ( (((self.is_building != 0.000) || (self.is_detpacking != 0.000)) || (self.is_feigning != 0.000)) ) {

      return ;

   }

   if (self.button0)
   {

      if ((self.current != WEAP_SNIPER_RIFLE) && (self.current != WEAP_ASSAULT_CANNON) && (self.current != WEAP_RAILGUN))
      {
         if (self.tfstate & 2048.000)
         {
            self.tfstate = (self.tfstate - (self.tfstate & 2048.000));
            TeamFortress_SetSpeed (self);
            self.heat = 0.000;
            self.fire_held_down = 0.000;
         }

      }
      else if (self.current == WEAP_SNIPER_RIFLE)
      {
         if (time > (self.attack_finished - 0.200))
         {
            if (self.height > 30.000)
            {  
               self.height = (self.height - 5.000);
               TF_zoom (self.height);
            }
         }
      }
   }



   if ( (time < self.attack_finished) ) {

      return ;

   }

   if ((!self.button0) && (self.fire_held_down)) {

      self.fire_held_down = 0.000;

      if ( (self.tfstate & 2048.000) )
      {
         if ( (self.current != WEAP_ASSAULT_CANNON) )
         {
            W_Attack ();
         }

         self.tfstate = (self.tfstate - 2048.000);
         TeamFortress_SetSpeed (self);
         self.heat = 0.000;

      }
      else
      {
         if ((!self.is_frozen) && (self.tfstate & 65536)) {

	      self.tfstate = self.tfstate - 65536.000;
	      TeamFortress_SetSpeed (self);
	      self.heat = 0.000;
         }
      }

      player_run ();
      return;

   }
   if ( (self.button0 && !self.fire_held_down) ) {

      if ( (self.current == WEAP_SNIPER_RIFLE) ) {

         tv = self.velocity;
         tv_z = 0.000;
         if ( (vlen (tv) <= 50.000) ) {

            SniperSight_Create ();
            //self.heat = 50.000;
            self.heat = time;
            self.oldheight =  stof(infokey(self,"fov"));
            if (!self.oldheight) self.oldheight = 100;
            self.height = self.oldheight;
            self.fire_held_down = 1.000;
            self.tfstate = (self.tfstate | 2048.000);
            TeamFortress_SetSpeed (self);

         }      

      } else {

         if ( (self.current == WEAP_ASSAULT_CANNON) ) {

            if (self.flags & 512.000) {

               SuperDamageSound ();
               W_Attack ();
            }

         } else {

            if ( (self.current == WEAP_RAILGUN ) && (railgun) ) {

               self.fire_held_down = 1.000;
               self.heat = time;
               self.tfstate = (self.tfstate | 2048.000);
               TeamFortress_SetSpeed (self);
               

            } else {

               SuperDamageSound ();
               W_Attack ();
            }
         }
      }
   }


};

void () RemoveGrenade = {

   local entity te;

   if ( (self.no_active_napalm_grens > 0.000) ) {

      self.no_active_napalm_grens = 0.000;
      self.owner.no_active_napalm_grens = (self.owner.no_active_napalm_grens - 1.000);
      if ( (self.owner.no_active_napalm_grens < 0.000) ) {

         self.owner.no_active_napalm_grens = 0.000;

      }
      te = find (world,classname,"grentimer");
      while ( te ) {

         if ( ((te.owner == self.owner) && (te.no_active_napalm_grens > 0.000)) ) {

            te.no_active_napalm_grens = (te.no_active_napalm_grens - 1.000);

         }
         te = find (te,classname,"grentimer");

      }
      dremove (self.enemy);
      dremove (self);

   }
   if ( (self.no_active_gas_grens > 0.000) ) {

      self.no_active_gas_grens = 0.000;
      self.owner.no_active_gas_grens = (self.owner.no_active_gas_grens - 1.000);
      if ( (self.owner.no_active_gas_grens < 0.000) ) {

         self.owner.no_active_gas_grens = 0.000;

      }
      te = find (world,classname,"grentimer");
      while ( te ) {

         if ( ((te.owner == self.owner) && (te.no_active_gas_grens > 0.000)) ) {

            te.no_active_gas_grens = (te.no_active_gas_grens - 1.000);

         }
         te = find (te,classname,"grentimer");

      }
      dremove (self);

   }

};
