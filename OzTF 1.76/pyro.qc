
//void (vector org, entity shooter) NapalmGrenadeLaunch;


float (string id_flame) RemoveFlameFromQueue;
entity (string type, entity p_owner) FlameSpawn = {

   if ( (cb_prematch == 1.000) ) {

      return ( world );

   }
   if ( (type != "1") ) {

      return ( world );

   }
   num_world_flames = (num_world_flames + 1.000);
   while ( (num_world_flames > 16.000) ) {

      if ( !RemoveFlameFromQueue (type) ) {

         return ( world );

      }

   }
   newmis = spawn ();
   if ( (type == "1") ) {

      newmis.movetype = 9.000;
      newmis.solid = 2.000;
      newmis.effects = 8.000;
      newmis.flame_id = "1";
      setmodel (newmis,"progs/flame2.mdl");
      setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');

   } else {

      if ( (type == "2") ) {

         newmis.movetype = 10.000;
         newmis.solid = 2.000;
         newmis.flame_id = "2";
         setmodel (newmis,"progs/flame2.mdl");
         newmis.frame = 1.000;
         setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');

      } else {

         if ( (type == "3") ) {

            newmis.movetype = 9.000;
            newmis.solid = 2.000;
            newmis.flame_id = "3";
            setmodel (newmis,"progs/flame2.mdl");
            setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');

         } else {

            if ( (type == "4") ) {

               newmis.movetype = 9.000;
               newmis.flame_id = "4";
               newmis.frame = 1.000;
               newmis.solid = 2.000;
               setmodel (newmis,"progs/flame2.mdl");
               setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');

            }

         }

      }

   }
   newmis.owner = p_owner;
   return ( newmis );

};

void (entity this) FlameDestroy = {

   num_world_flames = (num_world_flames - 1.000);
   dremove (this);

};


float (string id_flame) RemoveFlameFromQueue = {

   local entity tmp;

   if ( (num_world_flames < 20.000) ) {

      dprint ("ERROR in RemoveFlameFromQueue\n");
      return 0.000 ;

   }
   num_world_flames = (num_world_flames - 1.000);
   tmp = find (world,flame_id,"4");
   if ( !tmp ) {

      if ( (id_flame == "4") ) {

         return ( 0.000 );

      }
      tmp = find (world,flame_id,"3");
      if ( !tmp ) {

         if ( (id_flame == "3") ) {

            return ( 0.000 );

         }
         tmp = find (world,flame_id,"2");
         if ( !tmp ) {

            if ( (id_flame == "2") ) {

               return ( 0.000 );

            }
            tmp = find (world,flame_id,"1");
            if ( !tmp ) {

               dprint ("\n\nRemoveFlameFromQueue():BOOM!\n");
               return ( 0.000 );

            }

         }

      }

   }
   dremove (tmp);
   return ( 1.000 );

};
void () Remove = {

   FlameDestroy (self);

};


void () NapalmGrenadeTouch = {

   sound (self,1.000,"weapons/bounce.wav",1.000,1.000);
   if ( (self.velocity == '0.000 0.000 0.000') ) {

      self.avelocity = '0.000 0.000 0.000';

   }

};

void () NapalmGrenadeNetThink = {

   local entity head;
   local entity te;

   if ( (self.heat == 0.000) ) {

      self.owner.no_active_napalm_grens = (self.owner.no_active_napalm_grens + 1.000);
      if ( (self.owner.no_active_napalm_grens > 1.000) ) {

         te = find (world,classname,"grentimer");
         while ( te ) {

            if ( ((te.owner == self.owner) && (te.no_active_napalm_grens == 1.000)) ) {

               te.weapon = 15.000;
               te.think = RemoveGrenade;
               te.nextthink = (time + 0.100);

            }
            te = find (te,classname,"grentimer");

         }

      }
      self.no_active_napalm_grens = self.owner.no_active_napalm_grens;

   }
   self.nextthink = (time + 1.000);
   self.origin = self.enemy.origin;
   makevectors (self.v_angle);
   traceline (self.origin,self.origin,1.000,self);
   if ( (trace_inwater == 1.000) ) {

      sound (self,2.000,"misc/vapeur2.wav",1.000,1.000);
      RemoveGrenade ();
      return ;

   }
   head = findradius (self.origin,180.000);
   while ( head ) {
	head.chain2 = head.chain;

      if ( head.takedamage ) {

         deathmsg = 15.000;
         TF_T_Damage (head,self.enemy,self.owner,20.000,2.000,16.000);
         other = head;
         Napalm_touch ();

         if ( (other.classname == "player") ) {

            stuffcmd (other,"bf\nbf\n");

         }

      }
      head = head.chain2;

   }
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   self.heat = (self.heat + 1.000);
   if ( (self.heat > 7.000) ) {

      RemoveGrenade ();

   }

};


void () NapalmGrenadeExplode = {

   local entity te;
   local entity head;

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

   sound (self,0.000,"weapons/flmgrexp.wav",1.000,1.000);
   traceline (self.origin,self.origin,1.000,self);
   if ( (trace_inwater == 1.000) ) {

      dremove (self);
      return ;

   }
   self.effects = (self.effects | 8.000);
   head = spawn ();
   head.think = NapalmGrenadeNetThink;
   head.classname = "grentimer";
   head.nextthink = (time + 0.100);
   head.heat = 0.000;
   head.origin = self.origin;
   head.owner = self.owner;
   head.pteam = self.owner.pteam;
   head.enemy = self;

};

/*

void () NapalmGrenadeExplode2 = {

   local float points;
   local vector org;
   local entity te;
   local entity head;

   te = findradius (self.origin,500.000);
   while ( te ) {

      te.chain2 = te.chain;

      if ( (te.classname == "building_antispam") ) {

         spawn_tfog(self.origin);
         dremove (self);
         return;
      }
      te = te.chain2;

   }


   sound (self,0.000,"weapons/flmgrexp.wav",1.000,1.000);
   traceline (self.origin,self.origin,1.000,self);
   if ( (trace_inwater == 1.000) ) {

      sound (self,2.000,"misc/vapeur2.wav",1.000,1.000);
      dremove (self);
      return ;

   }
   self.effects = (self.effects | 8.000);

  // self.origin = self.enemy.origin;
   makevectors (self.v_angle);
   traceline (self.origin,self.origin,1.000,self);

   

   head = findradius (self.origin, 800);
   while ( head ) {
	head.chain2 = head.chain;

      if ( head.takedamage ) {

         points = (0.45 * vlen ((self.origin - head.origin)));

         points = (400.000 - points);

         if ( (head == self.owner) ) {

            points = (points * 0.800);

         }

         if ( (points > 0.000) ) {

            if ( CanDamage (head,self) ) {

               deathmsg = 15.000;
               TF_T_Damage (head,self.enemy,self.owner, points,2.000,16.000);
               other = head;
               Napalm_touch ();

               if ( (other.classname == "player") ) {

                  stuffcmd (other,"bf\nbf\n");

               }

            }

         }

      }

      head = head.chain2;

   }
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);


   dremove (self);


};
*/


void () OnPlayerFlame_touch;

void () FlameFollow = {

   local vector dir;
   local vector vtemp;
   local vector boundsize;
   local float damage;

   vtemp = self.enemy.absmin;
   boundsize = self.enemy.size;
   self.solid = 0.000;
   self.movetype = 0.000;
   if ( (self.enemy.numflames == 0.000) ) {

      FlameDestroy (self);
      return ;

   }
   if ( (self.enemy.health < 1.000) ) {

      deathmsg = 15.000;
      T_RadiusDamage (self,self,10.000,self);
      self.enemy.numflames = 0.000;
      FlameDestroy (self);
      return ;

   }
   if ( ((self.enemy.armorclass & 16.000) && (self.enemy.armorvalue > 0.000)) ) {

      self.health = 0.000;

   }
   if ( (self.enemy.tfstate & 131072.000) ) {

      self.health = 45.000;
      self.enemy.tfstate = (self.enemy.tfstate - (self.enemy.tfstate & 131072.000));

   }
   if ( (self.health < 1.000) ) {

      if ( ((self.effects != 8.000) || (self.enemy.numflames <= 1.000)) ) {

         self.enemy.numflames = (self.enemy.numflames - 1.000);
         self.enemy.numflames = 0.000;
         FlameDestroy (self);
         return ;

      }

   }
   self.health = (self.health - 1.000);
   if ( (vlen (self.enemy.velocity) < 50.000) ) {

      dir_x = (((random () * boundsize_x) / 2.000) + (boundsize_x / 4.000));
      dir_y = (((random () * boundsize_y) / 2.000) + (boundsize_y / 4.000));
      dir_z = (((random () * boundsize_z) / 3.000) + (boundsize_z / 2.000));
      vtemp = (vtemp + dir);
      setorigin (self,vtemp);
      if ( (self.model != "progs/flame2.mdl") ) {

         self.model = "progs/flame2.mdl";
         setmodel (self,self.model);

      }

   } else {

      if ( (self.model == "progs/flame2.mdl") ) {

         self.model = string_null;
         setmodel (self,self.model);

      }

   }
   if ( (self.enemy.waterlevel > 1.000) ) {

      sound (self,2.000,"misc/vapeur2.wav",1.000,1.000);
      self.enemy.numflames = (self.enemy.numflames - 1.000);
      FlameDestroy (self);
      return ;

   }
   self.nextthink = (time + 0.100);
   if ( ((self.effects == 8.000) && (self.heat >= 3.000)) ) {

      damage = ((self.enemy.numflames * 0.300) * 3.000);
      if ( (damage < 1.000) ) {

         damage = 1.000;

      }
      self.heat = 1.000;
      deathmsg = 15.000;
      TF_T_Damage (self.enemy,self,self.owner,damage,2.000,16.000);

   } else {

      if ( (self.effects == 8.000) ) {

         self.heat = (self.heat + 1.000);

      }

   }

};

void () OnPlayerFlame_touch = {

   local entity flame;
   local vector vtemp;

   if ( (((other != world) && (other.health > 0.000)) && (other != self.enemy)) ) {

      if ( (cb_prematch == 1.000) ) {

         return ;

      }
      if ( (other.numflames >= 4.000) ) {

         other.tfstate = (other.tfstate | 131072.000);
         return ;

      }
      if ( (other.classname == "player") ) {

         if ( (((teamplay & 16.000) && (other.pteam.team > 0.000)) && (other.pteam == self.owner.pteam)) ) {

            return ;

         }
         CenterPrint (other,"You are on fire!\n");
         stuffcmd (other,"bf\n");

      }
      if ( (other.numflames < 1.000) ) {

         flame = FlameSpawn ("1",other);
         sound (flame,2.000,"ambience/fire1.wav",1.000,1.000);

      } else {

         flame = FlameSpawn ("3",other);
         if ( (flame == world) ) {

            return ;

         }

      }
      flame.classname = "fire";
      flame.health = 45.000;
      other.numflames = (other.numflames + 1.000);
      flame.velocity = other.velocity;
      flame.enemy = other;
      flame.touch = OnPlayerFlame_touch;
      flame.owner = self.owner;
      vtemp = self.origin;
      setorigin (flame,vtemp);
      flame.nextthink = (time + 0.100);
      flame.think = FlameFollow;

   }

};

void () QW_Flame_ResetTouch;

void () WorldFlame_touch = {

   local entity flame;
   local vector vtemp;

   deathmsg = 15.000;
   TF_T_Damage (other,self,self.enemy,10.000,2.000,16.000);
   self.touch = SUB_Null;
   if ( (self.heat > (time + 1.000)) ) {

      self.think = QW_Flame_ResetTouch;
      self.nextthink = (time + 1.000);

   }
   if ( (((other != world) && (other.solid != 1.000)) && (other.health > 0.000)) ) {

      if ( (cb_prematch == 1.000) ) {

         return ;

      }
      if ( (other.numflames >= 4.000) ) {

         other.tfstate = (other.tfstate | 131072.000);
         return ;

      }
      if ( (other.classname == "player") ) {

         if ( (((teamplay & 16.000) && (other.pteam.team > 0.000)) && (other.pteam == self.owner.pteam)) ) {

            return ;

         }
         CenterPrint (other,"You are on fire!\n");
         stuffcmd (other,"bf\n");

      }
      if ( (other.numflames < 1.000) ) {

         flame = FlameSpawn ("1",other);
         sound (flame,2.000,"ambience/fire1.wav",1.000,1.000);

      } else {

         flame = FlameSpawn ("3",other);
         if ( (flame == world) ) {

            return ;

         }

      }
      flame.classname = "fire";
      flame.health = 0.000;
      other.numflames = (other.numflames + 1.000);
      flame.velocity = other.velocity;
      flame.enemy = other;
      flame.touch = OnPlayerFlame_touch;
      flame.owner = self.owner;
      vtemp = (self.origin + '0.000 0.000 10.000');
      setorigin (flame,vtemp);
      flame.nextthink = (time + 0.150);
      flame.think = FlameFollow;

   }

};

void () QW_Flame_ResetTouch = {

   self.touch = WorldFlame_touch;
   self.think = Remove;
   self.nextthink = self.heat;

};

void () Flamer_stream_touch = {

   local entity flame;
   local vector vtemp;

   if ( (other.classname == "fire") ) {

      return ;

   }
   if ( (other != world) ) {

      if ( ((other.takedamage == 2.000) && (other.health > 0.000)) ) {

         deathmsg = 15.000;
         TF_T_Damage (other,self,self.owner,10.000,2.000,16.000);
         if (cb_prematch ) {

            return ;

         }
         if ( (other.numflames >= 4.000) ) {

            other.tfstate = (other.tfstate | 131072.000);
            return ;

         }
         if ( ((other.armorclass & 16.000) && (other.armorvalue > 0.000)) ) {

            return ;

         }
         if ( (other.classname == "player") ) {

            if ( (((teamplay & 16.000) && (other.pteam.team > 0.000)) && (other.pteam == self.owner.pteam)) ) {

               return ;

            }
            CenterPrint (other,"You are on fire!\n");
            stuffcmd (other,"bf\n");

         }
         if ( (other.numflames < 1.000) ) {

            flame = FlameSpawn ("1",other);
            sound (flame,2.000,"ambience/fire1.wav",1.000,1.000);

         } else {

            flame = FlameSpawn ("3",other);
            if ( (flame == world) ) {

               return ;

            }

         }
         flame.classname = "fire";
         flame.health = 45.000;
         other.numflames = (other.numflames + 1.000);
         flame.velocity = other.velocity;
         flame.enemy = other;
         flame.touch = OnPlayerFlame_touch;
         flame.owner = self.owner;
         vtemp = self.origin;
         setorigin (flame,vtemp);
         flame.nextthink = (time + 0.100);
         flame.think = FlameFollow;

      }

   } else {

      if ( ((random () < 0.300) || (pointcontents ((self.origin + '0.000 0.000 1.000')) != -1.000)) ) {
         self.velocity = '0 0 0';
         return ;
     
      }
      flame = FlameSpawn ("4",other);
      if ( (flame != world) ) {

         flame.touch = WorldFlame_touch;
         flame.classname = "fire";
         vtemp = (self.origin + '0.000 0.000 10.000');
         setorigin (flame,vtemp);
         flame.nextthink = (time + 8.000);
         flame.heat = flame.nextthink;
         flame.think = Remove;
         flame.enemy = self.owner;

      }

      if ((classtype & 16.000)) dremove (self);

   }

};

void () Napalm_touch = {

   local entity flame;
   local vector vtemp;

   if ( (other.classname == "fire") ) {

      return ;

   }
   if ( (other != world) ) {

      if ( ((other.takedamage == 2.000) && (other.health > 0.000)) ) {

         deathmsg = 15.000;
         TF_T_Damage (other,self,self.owner,6.000,2.000,16.000);
         if (cb_prematch == 1.000 ) {

            return ;

         }
         if ( (other.numflames >= 4.000) ) {

            other.tfstate = (other.tfstate | 131072.000);
            return ;

         }
         if ( ((other.armorclass & 16.000) && (other.armorvalue > 0.000)) ) {

            return ;

         }
         if ( (other.classname == "player") ) {

            if ( (((teamplay & 16.000) && (other.pteam.team > 0.000)) && (other.pteam == self.owner.pteam)) ) {

               return ;

            }
            CenterPrint (other,"You are on fire!\n");
            stuffcmd (other,"bf\n");

         }
         if ( (other.numflames < 1.000) ) {

            flame = FlameSpawn ("1",other);
            sound (flame,2.000,"ambience/fire1.wav",1.000,1.000);

         } else {

            flame = FlameSpawn ("3",other);
            if ( (flame == world) ) {

               return ;

            }

         }
         flame.classname = "fire";
         flame.health = 45.000;
         other.numflames = (other.numflames + 1.000);
         flame.velocity = other.velocity;
         flame.enemy = other;
         flame.touch = OnPlayerFlame_touch;
         flame.owner = self.owner;
         vtemp = self.origin;
         setorigin (flame,vtemp);
         flame.nextthink = (time + 0.100);
         flame.think = FlameFollow;

      }

   } else {

      if ( (pointcontents ((self.origin + '0.000 0.000 1.000')) != -1.000) ) {

         FlameDestroy (self);
         return ;

      }
      flame = FlameSpawn ("4",other);
      if ( (flame != world) ) {

         flame.touch = WorldFlame_touch;
         flame.classname = "fire";
         vtemp = (self.origin + '0.000 0.000 10.000');
         setorigin (flame,vtemp);
         flame.nextthink = (time + 20.000);
         flame.heat = flame.nextthink;
         flame.think = Remove;
         flame.enemy = self.owner;

      }
      FlameDestroy (self);

   }

};

void (float num_bubbles, vector bub_origin) NewBubbles = {

   local entity bubble_spawner;

   bubble_spawner = spawn ();
   setorigin (bubble_spawner,bub_origin);
   bubble_spawner.movetype = 0.000;
   bubble_spawner.solid = 0.000;
   bubble_spawner.nextthink = (time + 0.100);
   if ( (self.classname == "player") ) {

      bubble_spawner.owner = self;

   } else {

      bubble_spawner.owner = self.enemy;

   }
   bubble_spawner.think = DeathBubblesSpawn;
   bubble_spawner.bubble_count = num_bubbles;
   return ;

};

void () W_FireFlame = {

   local entity flame;
   local float rn;

   if ( (self.waterlevel > 2.000) ) {

      makevectors (self.v_angle);
      NewBubbles (2.000,(self.origin + (v_forward * 64.000)));
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
   sound (self,0.000,"weapons/flmfire2.wav",1.000,1.000);
   flame = spawn ();
   flame.owner = self;
   flame.movetype = 9.000;
   flame.solid = 2.000;
   flame.classname = "flamerflame";
   makevectors (self.v_angle);
   flame.velocity = aim (self,10000.000);
   flame.velocity = (flame.velocity * 700.000);
   flame.touch = Flamer_stream_touch;
   flame.think = s_explode1;
   flame.nextthink = (time + 0.150);
   setmodel (flame,"progs/s_explod.spr");
   setsize (flame,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (flame,((self.origin + (v_forward * 16.000)) + '0.000 0.000 16.000'));

};

void () IncendiaryRadius = {

local float damg;

  damg = 52.000;
  self.volume = 1.23;

       //damg = 64.000;
   
   deathmsg = 15.000;
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

void () T_IncendiaryTouch = {

   local float damg;
   local entity head;


   if ( (other == self.owner) ) {

      return ;

   }
  
   if  ( (pointcontents (self.origin) == -6.000) ) {
      remove (self);
      return ;
   }

   self.effects = (self.effects | 4.000);
   damg = (35.000 + (random () * 10.000));
   deathmsg = 15.000;

   if ( other.health ) {

      TF_T_Damage (other,self,self.owner,damg,2.000,0.000);

   }
   
   if (classtype & 16.000)
   {

      head = findradius (self.origin, 180);
      while (head) {
	   if (head.takedamage) {
	      traceline (self.origin, head.origin, 1, self);
	      if ((trace_fraction == 1) || ((trace_fraction != 1) && (vlen (self.origin - head.origin) <= 64))) {
		   deathmsg = 15.000;
		   TF_T_Damage (head, self, self.owner, 10, 2.000, 16.000);
		   other = head;
		   Napalm_touch ();
		   if (other.classname == "player") {
		       stuffcmd (other, "bf\nbf\n");
		   }
	      }
	   }
	   head = head.chain;
      }
      self.origin = self.origin - 8 * normalize (self.velocity);
      WriteByte (4.000,23.000);
      WriteByte (4.000,3.000);
      WriteCoord (4.000,self.origin_x);
      WriteCoord (4.000,self.origin_y);
      WriteCoord (4.000,self.origin_z);
      multicast (self.origin,1.000);
      dremove (self);

   }
   else
   {
      IncendiaryRadius();
   }

};

void () W_FireIncendiaryCannon = {

   if ( (self.ammo_rockets < ic_ammo) ) {

      return ;

   }

   self.ammo_rockets = (self.ammo_rockets - ic_ammo);
   self.currentammo = self.ammo_rockets;


   newmis = spawn ();
   newmis.owner = self;
   sound (self,1.000,"weapons/sgun1.wav",1.000,1.000);
   KickPlayer (-3.000,self);
   newmis.movetype = 9.000;
   newmis.solid = 2.000;

   newmis.classname = "rocket";
   makevectors (self.v_angle);
   newmis.velocity = aim (self,1000.000);

   if ((classtype & 16))
   {
      newmis.velocity = (newmis.velocity * 600.000);
   }
   else
   {
      newmis.effects = (newmis.effects | 128.000);
      newmis.velocity = (newmis.velocity * 800.000);
   }

   newmis.angles = vectoangles (newmis.velocity);
   newmis.touch = T_IncendiaryTouch;
   newmis.nextthink = (time + 5.000);
   newmis.think = IncendiaryRadius;
   newmis.weapon = 33.000;
   setmodel (newmis,"progs/missile.mdl");
   setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
   setorigin (newmis,((self.origin + (v_forward * 8.000)) + '0.000 0.000 16.000'));

};

void () TeamFortress_IncendiaryCannon = {

   if ( !(self.carried & 16384.000) ) {

      return ;

   }

   if ( (self.ammo_rockets < ic_ammo) ) {

      sprint (self,2.000,"not enough ammo.\n");
      return ;
   }
   



   self.current = 16384.000;
   W_SetCurrentAmmo ();

};

void () TeamFortress_FlameThrower = {

   if ( !(self.carried & 4096.000) ) {

      return ;

   }
   if ( (self.ammo_cells < 1.000) ) {

      sprint (self,2.000,"not enough ammo.\n");
      return ;

   }
   self.current = 4096.000;
   W_SetCurrentAmmo ();

};
