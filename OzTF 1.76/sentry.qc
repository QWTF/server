float (float v) anglemod = {

   while ( (v >= 360.000) ) {

      v = (v - 360.000);

   }
   while ( (v < 0.000) ) {

      v = (v + 360.000);

   }
   return ( v );

};

float() FacingIdeal =
{
	local	float	delta;
	
	delta = anglemod(self.angles_y - self.ideal_yaw);
	if (delta > 60 && delta < 290)
		return 0.000;
	return 1.000;
};

float (entity targ) range = {

   local vector spot1;
   local vector spot2;
   local float r;

   spot1 = (self.origin + self.view_ofs);
   spot2 = (targ.origin + targ.view_ofs);
   r = vlen ((spot1 - spot2));
   if ( (r < 120.000) ) {

      return ( 0.000 );

   }
   if ( (r < 500.000) ) {

      return ( 1.000 );

   }
   if ( (r < 1000.000) ) {

      return ( 2.000 );

   }
   return ( 3.000 );

};

vector (entity targ) visible = {

   local vector spot1;
   local vector spot2;

   spot1 = (self.origin + self.view_ofs);
   spot2 = (targ.origin + targ.view_ofs);


   traceline (spot1,spot2,0.000,self);

   if (trace_ent.classname == "func_glass") {
      return ( vector_null );

   }

   traceline (spot1,spot2,1.000,self);


   if ( (trace_inopen && trace_inwater) ) {

      if(infokey(world,"watevis") == "1")
      { 
         return ( vector_null );
      }
      return ( trace_endpos );

   }
   if ( (trace_fraction == 1.000) ) {

      return ( trace_endpos );

   }
   return ( vector_null );

};

float (entity targ) infront = {

   local vector vec;
   local float dot;

   makevectors (self.angles);
   vec = normalize ((targ.origin - self.origin));
   dot = (vec * v_forward);
   if ( (dot > 0.300) ) {

      return ( 1.000 );

   }
   return ( 0.000 );

};



void (entity bld) CheckBelowBuilding;

void (entity gunhead) CheckSentry;

void () Sentry_Rotate;
void () Sentry_Target;

float () Sentry_FindTarget;

float () OldSentry_FindTarget;

void () OldSentry_FoundTarget;

void () Sentry_HuntTarget;

void () Sentry_Pain;

void () Sentry_Die;

float () Sentry_Fire;

float () OldSentry_Fire;

void () Sentry_MuzzleFlash;

void () ai_face = {

   self.ideal_yaw = vectoyaw ((self.enemy.origin - self.origin));
   self.ideal_yaw = anglemod (self.ideal_yaw);
   ChangeYaw ();

};



void () lvl1_sentry_atk3;

void () lvl1_sentry_stand = [ 0.000, lvl1_sentry_stand ] {

   Sentry_Rotate ();
};

void () lvl1_sentry_target = [ 0.000, lvl1_sentry_target ] {
   Sentry_Target ();
};


void () lvl1_sentry_atk1 = [ 1.000, lvl1_sentry_atk2 ] {

   ai_face ();

   if ( Sentry_FindTarget () ) {

      if (Sentry_Fire () == 0.000) {

         lvl1_sentry_target();

      }

   } else {

      lvl1_sentry_stand();
      return;

   }



};


void () lvl1_sentry_atk3 = [ 2.000, lvl1_sentry_atk2 ] {

   ai_face ();
   Sentry_Fire ();

};

void () lvl1_sentry_atk2 = [ 0.000, lvl1_sentry_atk1 ] {

  ai_face ();

};

void () lvl2_sentry_atk2;

void () lvl2_sentry_atk3;

void () lvl2_sentry_stand = [ 3.000, lvl2_sentry_stand ] {

   Sentry_Rotate ();

};

void () lvl2_sentry_target = [ 3.000, lvl2_sentry_target ] {
   Sentry_Target ();
};

void () lvl2_sentry_atk1 = [ 4.000, lvl2_sentry_atk2 ] {

   ai_face ();

   if ( Sentry_FindTarget () ) {

      if (Sentry_Fire () == 0.000) {

         lvl2_sentry_target();

      }

   } else {

      lvl2_sentry_stand();
      return;
   }

};

void () lvl2_sentry_atk2 = [ 5.000, lvl2_sentry_atk3 ] {

   ai_face ();
   Sentry_Fire ();

};

void () lvl2_sentry_atk3 = [ 3.000, lvl2_sentry_atk1 ] {

   ai_face ();
   Sentry_Fire ();
};

void () lvl3_sentry_atk2;

void () lvl3_sentry_stand = [ 6.000, lvl3_sentry_stand ] {

   Sentry_Rotate ();

};

void () lvl3_sentry_target = [ 6.000, lvl3_sentry_target ] {
   Sentry_Target ();
};

void () lvl3_sentry_atk1 = [ 7.000, lvl3_sentry_atk2 ] {

   ai_face ();

   if ( Sentry_FindTarget () ) {

      if (Sentry_Fire () == 0.000) {

         lvl3_sentry_target();

      }

   } else {

      lvl3_sentry_stand();
      return;
   }


};

void () lvl3_sentry_atk2 = [ 8.000, lvl3_sentry_atk3 ] {

   ai_face ();
   Sentry_Fire ();

};

void () lvl3_sentry_atk3 = [ 6.000, lvl3_sentry_atk1 ] {

   ai_face ();
   Sentry_Fire ();

};


void () Sentry_Target = {

   if ( Sentry_FindTarget () ) {
       Sentry_HuntTarget();
   }

};

// Tf 2.9 sg


void () OldSentry_Rotate =
{
	local float ay;

	self.effects = (self.effects - (self.effects & 8));
	CheckSentry (self);
	if (OldSentry_FindTarget ())
	{
		return;
	}
	if ((self.heat == 0.000000))
	{
		self.ideal_yaw = self.waitmin;
		ChangeYaw ();
		ay = anglemod (self.angles_y);
		ay = rint (ay);
		if ((ay == rint (self.waitmin)))
		{
			CheckBelowBuilding (self.trigger_field);
			self.heat = 1;
			if ((random () < 0.1))
			{
				sound (self, 3, "weapons/turridle.wav", 1, 1);
			}
		}
	}
	else
	{
		self.ideal_yaw = self.waitmax;
		ChangeYaw ();
		ay = anglemod (self.angles_y);
		ay = rint (ay);
		if ((ay == rint (self.waitmax)))
		{
			CheckBelowBuilding (self.trigger_field);
			self.heat = 0.000000;
		}
	}
};


float () Target_IsEnemy = {

   if (self.enemy != world)
   {
      if (!self.enemy.is_feigning) 
      {
         if (self.enemy.health > 0.000000)
         {
            if (visible (self.enemy)) 
            {
               if (!self.enemy.has_disconnected)
               {
                  return(1.000);

               }
            }
         }
      }
   }

   return(0.000);

};
	

void () lvl1_oldsentry_atk3;

void () lvl1_oldsentry_stand = [ 0.000, lvl1_oldsentry_stand ] {
   OldSentry_Rotate ();


};


void () lvl1_oldsentry_atk1 = [ 1.000, lvl1_oldsentry_atk3 ] {

   ai_face ();

	if (!Target_IsEnemy()) 
      {
		lvl1_oldsentry_stand ();
	}
	else
	{
         if ((OldSentry_Fire () == 0.000000))
	   {
		lvl1_oldsentry_atk3 ();
	   }
	}


};


void () lvl1_oldsentry_atk2 = [ 2.000, lvl1_oldsentry_atk3 ] {

   ai_face ();
   OldSentry_Fire ();

};

void () lvl1_oldsentry_atk3 = [ 0.000, lvl1_oldsentry_atk1 ] {

  ai_face ();

};

void () lvl2_oldsentry_atk2;

void () lvl2_oldsentry_atk3;

void () lvl2_oldsentry_stand = [ 3.000, lvl2_oldsentry_stand ] {

   OldSentry_Rotate ();

};

void () lvl2_oldsentry_atk1 = [ 4.000, lvl2_oldsentry_atk2 ] {

   ai_face ();

	if (!Target_IsEnemy()) 
      {
		lvl2_oldsentry_stand ();
	}
	else
	{
         if ((OldSentry_Fire () == 0.000000))
	   {
		lvl2_oldsentry_atk3 ();
	   }
	}

};

void () lvl2_oldsentry_atk2 = [ 5.000, lvl2_oldsentry_atk3 ] {

   ai_face ();
   OldSentry_Fire ();

};

void () lvl2_oldsentry_atk3 = [ 3.000, lvl2_oldsentry_atk1 ] {

   ai_face ();
   OldSentry_Fire ();
};

void () lvl3_oldsentry_atk3;

void () lvl3_oldsentry_stand = [ 6.000, lvl3_oldsentry_stand ] {

   OldSentry_Rotate ();

};


void () lvl3_oldsentry_atk1 = [ 7.000, lvl3_oldsentry_atk2 ] {

   ai_face ();

	if (!Target_IsEnemy()) 
      {
		lvl3_oldsentry_stand ();
	}
	else
	{
         if ((OldSentry_Fire () == 0.000000))
	   {
		lvl3_oldsentry_atk3 ();
	   }
	}
};

void () lvl3_oldsentry_atk2 = [ 8.000, lvl3_oldsentry_atk3 ] {

   ai_face ();
   OldSentry_Fire ();

};

void () lvl3_oldsentry_atk3 = [ 6.000, lvl3_oldsentry_atk1 ] {

   ai_face ();
   OldSentry_Fire ();

};



// old sg end


void () Sentry_Rotate = {

   local float ay;

   self.effects = (self.effects - (self.effects & 8.000));
   CheckSentry (self);

   if ( Sentry_FindTarget () ) {
      self.think = Sentry_HuntTarget;
      self.nextthink = (time + sentry_delay);
      sound (self,2.000,"weapons/turrspot.wav",1.000,1.000);
      return;

   } 


   if ( (self.heat == 0.000) ) {

      self.ideal_yaw = self.waitmin;
      ChangeYaw ();
      ay = anglemod (self.angles_y);
      ay = rint (ay);
      if ( (ay == rint (self.waitmin)) ) {

         CheckBelowBuilding (self.trigger_field);
         self.heat = 1.000;
         if ( (random () < 0.100) ) {

            sound (self,3.000,"weapons/turridle.wav",1.000,1.000);

         }

      }

   } else {

      self.ideal_yaw = self.waitmax;
      ChangeYaw ();
      ay = anglemod (self.angles_y);
      ay = rint (ay);
      if ( (ay == rint (self.waitmax)) ) {

         CheckBelowBuilding (self.trigger_field);
         self.heat = 0.000;

      }

   }


};

float (entity targ) Sentry_InRange = {

      local float r;
 
 	r = vlen ((self.origin - targ.origin));
 
 	if (r <= 1350 && infront(targ)) { return(1.000); }
 	else { if (r < 950) { return(1.000); } }
 	return(0.000);
 };


 float () Sentry_FindTarget = {
 	local entity e;
 	local float found;
 	local float r;

      if ( (self.ammo_shells <= 0.000) && (self.ammo_rockets <= 0.000)) {

         return (0.000);
      }

 	found = 0.000;
 	r = 0.000;
 	//e = findradius(self.origin,3000); // get all ents within 3000 units
 	e = player_head;
 	
 	if (!e) {
 		found = -1.000;
 	}
 	
 	//dprint(ftos(time));
 	//dprint(" checking: ");
 	
 	while (found == 0.000) {
 		// I think stupidly long if statements are better than one if statement with lots of &&'s
 		// because if the if parser (or whatever) for qc isn't optimised
 		// in a statement of all AND's it doesn't stop after the first false result
 

 		if (!e.has_disconnected) {

 		   if (e != self.real_owner ) {

 			if (!e.is_feigning) {

 			   if (!e.deadflag) {

 			      if (e.takedamage) {

				   if (!(e.flags & 128)) {

 					if (!(e.items & 524288)) {

 					   if (teamplay) {

 						if (e.pteam) {

 						   if (e.playerclass) {

 						      if (e.pteam != self.pteam ) {

 							   if (e.undercover_team != self.pteam.team) {

                                                if (e.effects & (8.000)) {

 							         if (Sentry_InRange(e)) {

                                                      self.movedir = visible(e);
 							            if (self.movedir != vector_null) {

 									   found = 1;
                                                         //dprint("AP\n");
 								      }

 							         }

 							      } else {

 								   if (Sentry_InRange(e)) {

                                                      self.movedir = visible(e);
 							            if (self.movedir != vector_null) {

 									      found = 1;
                                                            //dprint("Player\n");
 								      }

 								   }

 							      }

 							   }

 						      }

 						   }
 
 						}
 
 					   } else {

 						if (e.playerclass) {

 						   if (Sentry_InRange(e)) {

                                          self.movedir = visible(e);
 							if (self.movedir != vector_null) {

 							   found = 1;
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
 
 		if (found != 1.000) {
 			e = e.nextp;
 			if (!e) {
 				found = -1.000;
 			}
 		}

 	}
 	
 	
 	if (found == 1.000) {
 		self.enemy = e;

 		return(1.000);
 	} else {
 		return(0.000);
 	}
 };

float () OldSentry_FindTarget =
{

	local entity client;
	local float r;
	local float gotone;
	local float loopc;

	r = 0.000000;
	loopc = 0.000000;
	gotone = 0.000000;
	while (((loopc < 12) && (gotone == 0.000000)))
	{
		client = checkclient ();
		gotone = 1;
		if (!client)
		{
			gotone = 0.000000;

		}
		if (((client == self.real_owner) || !client.takedamage))
		{
			gotone = 0.000000;

		}
		if ((client.has_disconnected == 1))
		{
			gotone = 0.000000;

		}
		if (teamplay)
		{
			if (((client.pteam == self.pteam) && (self.pteam.team != 0.000000) ))
			{
				gotone = 0.000000;

			}
			if (((client.undercover_team == self.pteam.team) && (self.pteam.team != 0.000000)))
			{
				gotone = 0.000000;

			}
		}
		if (client.is_feigning)
		{
			gotone = 0.000000;

		}
		if (((client.flags & 128) || (client.items & 524288)))
		{
			gotone = 0.000000;

		}
		if (visible (client) == vector_null)
		{
			gotone = 0.000000;

		}
		r = range (client);
		if ((r == 3))
		{
			gotone = 0.000000;

		}
		else
		{
			if (((r == 2) && !infront (client)))
			{
				gotone = 0.000000;

			}
		}
		loopc = (loopc + 1);
	}

	if (!gotone)
	{

		return (0.000000);
	}


	self.enemy = client;
	if ((self.enemy.classname != "player"))
	{
		self.enemy = self.enemy.enemy;
		if ((self.enemy.classname != "player"))
		{
			self.enemy = world;
			return (0.000000);
		}
	}

	OldSentry_FoundTarget ();
	return (1);
};

void () OldSentry_FoundTarget =
{


	if (((self.ammo_shells > 0.000000) || ((self.ammo_rockets > 0.000000) && (self.weapon == 3))))
	{
		sound (self, 2, "weapons/turrspot.wav", 1, 1);
	}
	Sentry_HuntTarget ();

};


void () Sentry_HuntTarget = {


   if (!sgtype) {

      if ( (self.weapon == 1.000) ) {

         self.think = lvl1_oldsentry_atk1;

      } else {
 
         if ( (self.weapon == 2.000) ) {

            self.think = lvl2_oldsentry_atk1;

         } else {

            self.think = lvl3_oldsentry_atk1;

         }


      }
	self.ideal_yaw = vectoyaw ((self.enemy.origin - self.origin));
	self.nextthink = (time + 0.1);

   } else {

      if ( (self.weapon == 1.000) ) {

         self.think = lvl1_sentry_atk1;

      } else {
 
         if ( (self.weapon == 2.000) ) {

            self.think = lvl2_sentry_atk1;

         } else {

            self.think = lvl3_sentry_atk1;

         }

      }
      self.nextthink = (time + sentry_speed);
   }


   if ( (self.super_damage_finished < time) ) {

      self.super_damage_finished = (time + 0.500);

   }


};

void () Sentry_Pain = {

   self.real_owner.StatusRefreshTime = (time + 0.200);

};

void () Sentry_Explode = {
#ifndef CSQC

   ThrowGib ("progs/tgib2.mdl",-70.000);
   ThrowGib ("progs/tgib2.mdl",-70.000);
   ThrowGib ("progs/tgib2.mdl",-70.000);
#endif
   if ( (self.real_owner.has_disconnected != 1.000) ) {

      deathmsg = 38.000;
      T_RadiusDamage (self,self.real_owner,(75.000 + (self.ammo_rockets * 8.000)),self);

   }
   if ( (self.classname == "building_sentrygun_base") ) {

      if ( self.oldenemy ) {

         dremove (self.oldenemy);

      }

   } else {

      dremove (self.trigger_field);

   }
   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   dremove(self);

};



void (float damg, vector dir, vector spread) FireSentry = {

   local vector direction;
   local vector src;

   makevectors (self.v_angle);
   src = (self.origin + (v_forward * 10.000));
   src_z = (self.absmin_z + (self.size_z * 0.700));
   ClearMultiDamage ();
   traceline (src,(src + (dir * 2048.000)),0.000,self);


   direction = ((dir + ((crandom () * spread_x) * v_right)) + ((crandom () * spread_y) * v_up));
   traceline (src,(src + (direction * 2048.000)),0.000,self);
   if ( (trace_fraction != 1.000) ) {

      if ((self.weapon == 1.000)) {

         TraceAttack (damg,direction);

      } else {
               
         TraceAttack ((damg * 0.8),direction);

      }

   }

   puff_org = (trace_endpos + direction);
   Multi_Finish ();
   ApplyMultiDamage();

};

void () Sentry_Die =
{
	sprint (self.real_owner, 2, "Your sentry gun was destroyed.\n");
	self.real_owner.has_sentry = 0.000000;
	self.think = Sentry_Explode;
	self.nextthink = (time + 0.1);
};


// tf2.9 sg

float () OldSentry_Fire =
{
	local vector dir;


	self.effects = (self.effects - (self.effects & 8));
	dir = (self.enemy.origin - self.origin);
	if ((((self.ideal_yaw - anglemod (self.angles_y)) < -10.000000) || ((self.ideal_yaw - anglemod (self.angles_y)) > 10)))
	{
		return (0.000000);
	}

	if ((((self.weapon == 3) && (self.ammo_rockets > 0.000000)) && (self.super_damage_finished < time)))
	{
		Sentry_MuzzleFlash ();
		sound (self, 1, "weapons/rocket1i.wav", 1, 1);
		newmis = spawn ();
		newmis.owner = self;
		newmis.movetype = 9;
		newmis.solid = 2;
		newmis.velocity = (normalize (((self.enemy.origin - '0 0 16') - self.origin)) * 800);
		newmis.angles = vectoangles (newmis.velocity);
		newmis.weapon = 34;
		newmis.touch = T_MissileTouch;
		newmis.nextthink = (time + 5);
		newmis.think = SUB_Remove;
		setmodel (newmis, "progs/missile.mdl");
		setsize (newmis, '0 0 0', '0 0 0');
		setorigin (newmis, ((self.origin + (v_forward * 8)) + '0 0 16'));
		self.super_damage_finished = (time + 3);
            self.ammo_rockets = (self.ammo_rockets - 1.000);

		if ((self.ammo_rockets == 10))
		{
			sprint (self.real_owner, 2, "Sentry Gun is low on rockets.\n");
		}
	}
      self.ammo_shells = (self.ammo_shells - 1);
	if ((self.ammo_shells < 0.000000))
	{
		self.ammo_shells = 0.000000;
		return (0.000000);
	}
	Sentry_MuzzleFlash ();
	sound (self, 1, "weapons/sniper.wav", 1, 1);
	deathmsg = 27;
	self.v_angle = self.angles;
	FireBullets (4, dir, '0.1 0.1 0');

	if (((self.ammo_shells == 0.000000) && (random () < 0.1)))
	{
		sprint (self.real_owner, 2, "Sentry Gun is out of shells.\n");
	}
	else
	{
		if ((self.ammo_shells == 20))
		{
			sprint (self.real_owner, 2, "Sentry Gun is low on shells.\n");
		}
	}
	if ((((self.ammo_rockets == 0.000000) && (self.weapon == 3)) && (random () < 0.1)))
	{
		sprint (self.real_owner, 2, "Sentry Gun is out of rockets.\n");
	      if ((self.ammo_shells == 0.000000))
	      {
		   return (0.000000);
	      }
	}
	return (1.000);
};

// sg end


float () Sentry_Fire = {

   //local vector dir;
   local float r;
   local vector org;

  if (self.tfstate > time) {
     return(1.000);
  }


   self.effects = (self.effects - (self.effects & 8.000));
   //dir = (self.enemy.origin - (self.origin + '0.000 0.000 16.000'));
   r = vlen(self.movedir);

   //enemy range:
   //dprint(ftos(r));
   //dprint("\n");

   if (r < 150 )
   {
      if ( ((self.ideal_yaw - anglemod (self.angles_y)) < -10.000) || ((self.ideal_yaw - anglemod (self.angles_y)) > 10.000) ) {

         return ( 0.000 );

      }

   }
   else if (r < 250 )
   {
      if ( ((self.ideal_yaw - anglemod (self.angles_y)) < -6.500) || ((self.ideal_yaw - anglemod (self.angles_y)) > 6.500) ) {

         return ( 0.000 );

      }
   }
   else if (r < 400 )
   {
      if ( ((self.ideal_yaw - anglemod (self.angles_y)) < -5.000) || ((self.ideal_yaw - anglemod (self.angles_y)) > 5.000) ) {

        return ( 0.000 );

      }
   }
   else if (r < 650 )
   {
      if ( ((self.ideal_yaw - anglemod (self.angles_y)) < -3.500) || ((self.ideal_yaw - anglemod (self.angles_y)) > 3.500) ) {

        return ( 0.000 );

      }
   }
   else if (r < 900 )
   {
      if ( ((self.ideal_yaw - anglemod (self.angles_y)) < -2.400) || ((self.ideal_yaw - anglemod (self.angles_y)) > 2.400) ) {
        return ( 0.000 );

      }
   }
   else if (r < 1200 )
   {

      if ( ((self.ideal_yaw - anglemod (self.angles_y)) < -1.300) || ((self.ideal_yaw - anglemod (self.angles_y)) > 1.300) ) {

        return ( 0.000 );

      }
   }
   else 
   {
      if ( ((self.ideal_yaw - anglemod (self.angles_y)) < -0.400) || ((self.ideal_yaw - anglemod (self.angles_y)) > 0.400) ) {

        return ( 0.000 );

      }
   }

   if ( (((self.weapon == 3.000) && (self.ammo_rockets > 0.000)) && (self.super_damage_finished < time)) ) {
      
      Sentry_MuzzleFlash ();
      sound (self,1.000,"weapons/rocket1i.wav",1.000,1.000);
      newmis = spawn ();
      newmis.owner = self;
      newmis.movetype = 9.000;
      newmis.solid = 2.000;
      newmis.velocity = (normalize (((self.movedir - '0 0 16') - self.origin)) * 800.000);
      newmis.angles = vectoangles (newmis.velocity);
      newmis.weapon = 34.000;
      newmis.touch = T_MissileTouch;
      newmis.nextthink = (time + 5.000);
      newmis.think = SUB_Remove;
      setmodel (newmis,"progs/missile.mdl");
      setsize (newmis,'0.000 0.000 0.000','0.000 0.000 0.000');
      setorigin (newmis,((self.origin + (v_forward * 8.000)) + '0.000 0.000 16.000'));
      self.super_damage_finished = (time + 3.000);
      self.ammo_rockets = (self.ammo_rockets - 1.000);
      if ( (self.ammo_rockets == 10.000) ) {

         sprint (self.real_owner,2.000,"Sentry Gun is low on rockets.\n");

      }

      if ( self.ammo_rockets == 0.000) {

         sprint (self.real_owner,2.000,"Sentry Gun is out of rockets.\n");

      }

   }

   org = (self.origin + '0.000 0.000 16.000');

   if (sentry_fire == 1.000) {

      if ( (self.ammo_shells > 0.000) ) {

         Sentry_MuzzleFlash ();     
         sound (self,1.000,"weapons/lhit.wav",1.000,1.000);
   

         traceline (org,(self.movedir),1.000,self);
    

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


         if (r <= 700 ) {
            LightningDamage (org, trace_endpos + (v_forward * 4.000),self,23.000);

         } else {

            if (r <= 1100 ) {
               LightningDamage (org, trace_endpos + (v_forward * 4.000),self,17.000);


            }  else  {
               LightningDamage (org, trace_endpos + (v_forward * 4.000),self,10.000);

            }
         }

         self.ammo_shells = (self.ammo_shells - 1.000);


         if ( (self.ammo_shells == 20.000) ) {

            sprint (self.real_owner,2.000,"Sentry Gun is low on shells.\n");

         }

         if ( (self.ammo_shells <= 0.000) ) {

            sprint (self.real_owner,2.000,"Sentry Gun is out of shells.\n");
            self.ammo_shells = 0.000;
      
         }

      }

   } else {

      if ( (self.ammo_shells > 0.000) ) {

         Sentry_MuzzleFlash ();
         self.v_angle = self.angles;
         deathmsg = 27.000;

         if (sentry_fire == 2.000)
         {

            LaunchLaser(org, self.movedir - (self.origin + '0 0 16'));
         }
         else
         {
            sound (self,1.000,"weapons/sniper.wav",1.000,1.000);


            if (r <= 700 ) {

               FireSentry (14.000, self.movedir  - (self.origin + '0 16 32'), '0.100 0.100 0.000');

            } else {

               if (r <= 1100 ) {
                  FireSentry (10.000,self.movedir  - (self.origin + '0 16 32'),'0.300 0.300 0.100');

               }  else  {
                  FireSentry (6.000,self.movedir  - (self.origin + '0 16 32'),'0.700 0.500 0.500');
               }
            }

         }
         self.ammo_shells = (self.ammo_shells - 1.000);
         if ( (self.ammo_shells == 20.000) ) {

            sprint (self.real_owner,2.000,"Sentry Gun is low on shells.\n");

         }

         if ( (self.ammo_shells <= 0.000) ) {

            sprint (self.real_owner,2.000,"Sentry Gun is out of shells.\n");
            self.ammo_shells = 0.000;
      
         }


      
      }

   }

   return (1.000);
};

void () Sentry_MuzzleFlash = {

   self.effects = (self.effects | 8.000);

};
