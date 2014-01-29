void () info_null = {

};

void () info_notnull = {

};

void () light_use = {


   if ( (self.spawnflags & 1.000) ) {

      lightstyle (self.style,"m");
      self.spawnflags = (self.spawnflags - 1.000);

   } else {

      lightstyle (self.style,"a");
      self.spawnflags = (self.spawnflags + 1.000);

   }


};


void () light = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.targetname ) {

      dremove (self);
      return ;

   }

   if ( (self.style >= 32.000) ) {

      self.use = light_use;
      if ( (self.spawnflags & 1.000) ) {

         lightstyle (self.style,"a");

      } else {

         lightstyle (self.style,"m");

      }

   }

   //self._color = "255 100 255";

};

void () light_spot = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.targetname ) {

      dremove (self);
      return ;

   }

   if ( (self.style >= 32.000) ) {

      self.use = light_use;
      if ( (self.spawnflags & 1.000) ) {

         lightstyle (self.style,"a");

      } else {

         lightstyle (self.style,"m");

      }

   }

};

void () light_environment = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.targetname ) {

      dremove (self);
      return ;

   }

   if ( (self.style >= 32.000) ) {

      self.use = light_use;
      if ( (self.spawnflags & 1.000) ) {

         lightstyle (self.style,"a");

      } else {

         lightstyle (self.style,"m");

      }

   }

};

void () light_fluoro = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( (self.style >= 32.000) ) {

      self.use = light_use;
      if ( (self.spawnflags & 1.000) ) {

         lightstyle (self.style,"a");

      } else {

         lightstyle (self.style,"m");

      }

   }
   precache_sound ("ambience/fl_hum1.wav");
   ambientsound (self.origin,"ambience/fl_hum1.wav",0.500,3.000);

};

void () light_fluorospark = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.style ) {

      self.style = 10.000;

   }
   precache_sound ("ambience/buzz1.wav");
   ambientsound (self.origin,"ambience/buzz1.wav",0.500,3.000);

};

void () light_globe = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/s_light.spr");
   setmodel (self,"progs/s_light.spr");
   makestatic (self);

};

void () FireAmbient = {

   precache_sound ("ambience/fire1.wav");
   ambientsound (self.origin,"ambience/fire1.wav",0.500,3.000);

};

void () light_torch_small_walltorch = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }

   if ( !self.style ) {

      self.style = 8.000;

   }
   precache_model ("progs/flame.mdl");
   setmodel (self,"progs/flame.mdl");
   FireAmbient ();
   makestatic (self);

};

void () light_flame_large_yellow = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }

   if ( !self.style ) {

      self.style = 7.000;

   }
   precache_model ("progs/flame2.mdl");
   setmodel (self,"progs/flame2.mdl");
   self.frame = 1.000;
   FireAmbient ();
   makestatic (self);

};

void () light_flame_small_yellow = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }

   if ( !self.style ) {

      self.style = 3.000;

   }

   precache_model ("progs/flame2.mdl");
   setmodel (self,"progs/flame2.mdl");
   FireAmbient ();
   makestatic (self);

};

void () light_flame_small_white = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }

   if ( !self.style ) {

      self.style = 3.000;

   }
   precache_model ("progs/flame2.mdl");
   setmodel (self,"progs/flame2.mdl");
   FireAmbient ();
   makestatic (self);

};



void () fire_fly;

void () fire_touch;

void () misc_fireball = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/lavaball.mdl");
   self.classname = "fireball";
   self.nextthink = (time + (random () * 5.000));
   self.think = fire_fly;
   if ( !self.speed ) {

		self.speed = 1000;
   }

};

void () fire_fly = {

   newmis = spawn ();
   newmis.solid = 1.000;
   newmis.movetype = 6.000;
   newmis.velocity = '0.000 0.000 1000.000';
   newmis.velocity_x = ((random () * 100.000) - 50.000);
   newmis.velocity_y = ((random () * 100.000) - 50.000);
   newmis.velocity_z = (self.speed + (random () * 200.000));
   newmis.classname = "fireball";
   setmodel (newmis,"progs/lavaball.mdl");
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,self.origin);
   newmis.nextthink = (time + 5.000);
   newmis.think = SUB_Remove;
   newmis.touch = fire_touch;
   self.nextthink = ((time + (random () * 5.000)) + 3.000);
   self.think = fire_fly;

};


void () fire_touch = {

   if ( other.takedamage ) {

      TF_T_Damage (other,self,self,20.000,0.000,16.000);

   }
   dremove (self);

};


void () barrel_explode = {

   self.takedamage = 0.000;
   self.classname = "explo_box";
   T_RadiusDamage (self,self,160.000,world);
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,(self.origin_z + 32.000));
   multicast (self.origin,1.000);
   remove (self);

};

void () misc_explobox = {

   local float oldz;

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.solid = 2.000;
   self.movetype = 0.000;
   precache_model ("maps/b_explob.bsp");
   setmodel (self,"maps/b_explob.bsp");
   setsize (self,'0.000 0.000 0.000','32.000 32.000 64.000');
   precache_sound ("weapons/r_exp3.wav");
   self.health = 20.000;
   self.th_die = barrel_explode;
   self.takedamage = 2.000;
   self.origin_z = (self.origin_z + 2.000);
   oldz = self.origin_z;
   droptofloor ();
   if ( ((oldz - self.origin_z) > 250.000) ) {

      dprint ("item fell out of level at ");
      dprint (vtos (self.origin));
      dprint ("\n");
      dremove (self);

   }

};

void () misc_explobox2 = {

   local float oldz;

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.solid = 2.000;
   self.movetype = 0.000;
   precache_model2 ("maps/b_exbox2.bsp");
   setmodel (self,"maps/b_exbox2.bsp");
   setsize (self,'0.000 0.000 0.000','32.000 32.000 32.000');
   precache_sound ("weapons/r_exp3.wav");
   self.health = 20.000;
   self.th_die = barrel_explode;
   self.takedamage = 2.000;
   self.origin_z = (self.origin_z + 2.000);
   oldz = self.origin_z;
   droptofloor ();
   if ( ((oldz - self.origin_z) > 250.000) ) {

      dprint ("item fell out of level at ");
      dprint (vtos (self.origin));
      dprint ("\n");
      dremove (self);

   }

};

void (vector org, vector vec) LaunchLaser;

void () Laser_Touch = {

   local vector org;

   if ( (other == self.owner) ) {

      return ;

   }
   if ( (pointcontents (self.origin) == -6.000) ) {

      dremove (self);
      return ;

   }
   sound (self,1.000,"enforcer/enfstop.wav",1.000,3.000);
   org = (self.origin - (8.000 * normalize (self.velocity)));
   if ( other.health ) {

      SpawnBlood (org,15.000);
      TF_T_Damage (other,self,self.owner,15.000,0.000,8.000);

   } else {

      WriteByte (4.000,23.000);
      WriteByte (4.000,2.000);
      WriteByte (4.000,5.000);
      WriteCoord (4.000,org_x);
      WriteCoord (4.000,org_y);
      WriteCoord (4.000,org_z);
      multicast (org,2.000);

   }
   dremove (self);

};

void (vector org, vector vec) LaunchLaser = {


   sound (self,1.000,"enforcer/enfire.wav",1.000,1.000);

   vec = normalize (vec);
   newmis = spawn ();
   newmis.owner = self;
   newmis.movetype = 5.000;
   newmis.solid = 2.000;
   newmis.effects = 8.000;
   setmodel (newmis,"progs/laser.mdl");
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,org);
   newmis.velocity = (vec * 900.000);
   newmis.angles = vectoangles (newmis.velocity);
   newmis.nextthink = (time + 5.000);
   newmis.think = SUB_Remove;
   newmis.touch = Laser_Touch;

};

void () spikeshooter_use = {

   if ( (self.spawnflags & 2.000) ) {

      sound (self,2.000,"enforcer/enfire.wav",1.000,1.000);
      LaunchLaser (self.origin,self.movedir);

   } else {

      sound (self,2.000,"weapons/spike2.wav",1.000,1.000);
      launch_spike (self.origin,self.movedir);
      newmis.velocity = (self.movedir * 500.000);
      if ( (self.spawnflags & 1.000) ) {

         newmis.touch = superspike_touch;

      }

   }

};

void () shooter_think = {

   spikeshooter_use ();
   self.nextthink = (time + self.wait);
   newmis.velocity = (self.movedir * 500.000);

};

void () trap_spikeshooter = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   SetMovedir ();
   self.use = spikeshooter_use;
   if ( (self.spawnflags & 2.000) ) {

      precache_model2 ("progs/laser.mdl");
      precache_sound2 ("enforcer/enfire.wav");
      precache_sound2 ("enforcer/enfstop.wav");

   } else {

      precache_sound ("weapons/spike2.wav");

   }

};

void () trap_shooter = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   trap_spikeshooter ();
   if ( (self.wait == 0.000) ) {

      self.wait = 1.000;

   }
   self.nextthink = ((self.nextthink + self.wait) + self.ltime);
   self.think = shooter_think;

};

void () make_bubbles;

void () bubble_remove;

void () air_bubbles = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   dremove (self);

};

void () make_bubbles = {

   newmis = spawn ();
   setmodel (newmis,"progs/s_bubble.spr");
   setorigin (newmis,self.origin);
   newmis.movetype = 8.000;
   newmis.solid = 0.000;
   newmis.velocity = '0.000 0.000 15.000';
   newmis.nextthink = (time + 0.500);
   newmis.think = bubble_bob;
   newmis.touch = bubble_remove;
   newmis.classname = "bubble";
   newmis.frame = 0.000;
   newmis.cnt = 0.000;
   setsize (newmis,'-8.000 -8.000 -8.000','8.000 8.000 8.000');
   self.nextthink = ((time + random ()) + 0.500);
   self.think = make_bubbles;

};

void () bubble_split = {

   newmis = spawn ();
   setmodel (newmis,"progs/s_bubble.spr");
   setorigin (newmis,self.origin);
   newmis.movetype = 8.000;
   newmis.solid = 0.000;
   newmis.velocity = self.velocity;
   newmis.nextthink = (time + 0.500);
   newmis.think = bubble_bob;
   newmis.touch = bubble_remove;
   newmis.classname = "bubble";
   newmis.frame = 1.000;
   newmis.cnt = 10.000;
   setsize (newmis,'-8.000 -8.000 -8.000','8.000 8.000 8.000');
   self.frame = 1.000;
   self.cnt = 10.000;
   if ( (self.waterlevel != 3.000) ) {

      remove (self);

   }

};

void () bubble_remove = {

   if ( (other.classname == self.classname) ) {

      return ;

   }
   dremove (self);

};

void () bubble_bob = {

   local float rnd1;
   local float rnd2;
   local float rnd3;

   self.cnt = (self.cnt + 1.000);
   if ( (self.cnt == 4.000) ) {

      bubble_split ();

   }
   if ( (self.cnt == 20.000) ) {

      dremove (self);

   }
   rnd1 = (self.velocity_x + (-10.000 + (random () * 20.000)));
   rnd2 = (self.velocity_y + (-10.000 + (random () * 20.000)));
   rnd3 = ((self.velocity_z + 10.000) + (random () * 10.000));
   if ( (rnd1 > 10.000) ) {

      rnd1 = 5.000;

   }
   if ( (rnd1 < -10.000) ) {

      rnd1 = -5.000;

   }
   if ( (rnd2 > 10.000) ) {

      rnd2 = 5.000;

   }
   if ( (rnd2 < -10.000) ) {

      rnd2 = -5.000;

   }
   if ( (rnd3 < 10.000) ) {

      rnd3 = 15.000;

   }
   if ( (rnd3 > 30.000) ) {

      rnd3 = 25.000;

   }
   self.velocity_x = rnd1;
   self.velocity_y = rnd2;
   self.velocity_z = rnd3;
   self.nextthink = (time + 0.500);
   self.think = bubble_bob;

};

void () func_wall_use = {

   self.frame = (1.000 - self.frame);

};

void () func_wall = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.angles = '0.000 0.000 0.000';
   self.movetype = 7.000;
   self.solid = 4.000;
   self.use = func_wall_use;
   setmodel (self,self.model);

};


void () func_illusionary = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.angles = '0.000 0.000 0.000';
   self.movetype = 0.000;
   self.solid = 0.000;
   setmodel (self,self.model);
   makestatic (self);

};

void () func_episodegate = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !(serverflags & self.spawnflags) ) {

      return ;

   }
   self.angles = '0.000 0.000 0.000';
   self.movetype = 7.000;
   self.solid = 4.000;
   self.use = func_wall_use;
   setmodel (self,self.model);

};

void () func_bossgate = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( ((serverflags & 15.000) == 15.000) ) {

      return ;

   }
   self.angles = '0.000 0.000 0.000';
   self.movetype = 7.000;
   self.solid = 4.000;
   self.use = func_wall_use;
   setmodel (self,self.model);

};

void () ambient_suck_wind = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/suck1.wav");
   ambientsound (self.origin,"ambience/suck1.wav",1.000,3.000);

};

void () ambient_drone = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/drone6.wav");
   ambientsound (self.origin,"ambience/drone6.wav",0.500,3.000);

};

void () ambient_flouro_buzz = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/buzz1.wav");
   ambientsound (self.origin,"ambience/buzz1.wav",1.000,3.000);

};

void () ambient_drip = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/drip1.wav");
   ambientsound (self.origin,"ambience/drip1.wav",0.500,3.000);

};

void () ambient_comp_hum = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/comp1.wav");
   ambientsound (self.origin,"ambience/comp1.wav",1.000,3.000);

};

void () ambient_thunder = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/thunder1.wav");
   ambientsound (self.origin,"ambience/thunder1.wav",0.500,3.000);

};

void () ambient_light_buzz = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/fl_hum1.wav");
   ambientsound (self.origin,"ambience/fl_hum1.wav",0.500,3.000);

};

void () ambient_swamp1 = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/swamp1.wav");
   ambientsound (self.origin,"ambience/swamp1.wav",0.500,3.000);

};

void () ambient_swamp2 = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound ("ambience/swamp2.wav");
   ambientsound (self.origin,"ambience/swamp2.wav",0.500,3.000);

};

void () ambient_play = {

   sound (self, 2.000, self.message, 1.000,0.000);

};

void () ambient_generic = {

   if ( (CheckExistence () == 0.000) )
   {
      dremove (self);
      return ;
   }

   if (self.message)
      precache_sound (self.message);

   self.use = ambient_play;

   if (!self.targetname)
   {
      ambientsound (self.origin,self.message,1.000,3.000);
   }

};

void () noise_think = {

   self.nextthink = (time + 0.500);
   sound (self,1.000,"enforcer/enfire.wav",1.000,1.000);
   sound (self,2.000,"enforcer/enfstop.wav",1.000,1.000);
   sound (self,3.000,"enforcer/sight1.wav",1.000,1.000);
   sound (self,4.000,"enforcer/sight2.wav",1.000,1.000);
   sound (self,5.000,"enforcer/sight3.wav",1.000,1.000);
   sound (self,6.000,"enforcer/sight4.wav",1.000,1.000);
   sound (self,7.000,"enforcer/pain1.wav",1.000,1.000);

};

void () misc_noisemaker = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_sound2 ("enforcer/enfire.wav");
   precache_sound2 ("enforcer/enfstop.wav");
   precache_sound2 ("enforcer/sight1.wav");
   precache_sound2 ("enforcer/sight2.wav");
   precache_sound2 ("enforcer/sight3.wav");
   precache_sound2 ("enforcer/sight4.wav");
   precache_sound2 ("enforcer/pain1.wav");
   precache_sound2 ("enforcer/pain2.wav");
   precache_sound2 ("enforcer/death1.wav");
   precache_sound2 ("enforcer/idle1.wav");
   self.nextthink = ((time + 0.100) + random ());
   self.think = noise_think;

};
