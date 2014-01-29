// ILLEGALFPS[abortelect

.float fAverageFrameTime;
.float fFrameCount;
.float fFrameReset;
.float fLowestFrameTime;
//.float fIllegalFPSWarnings;
.float real_time;
// ILLEGALFPS]


float () crandom = {

   return ( (2.000 * (random () - 0.500)) );

};

void () autoteam_think =
{
	toggleflags = (toggleflags | 64);
	dremove (self);
};

void () CheckFps = {

   local float r;
   local string tmp;
   local float fps;
   local float maxfps;



	self.fAverageFrameTime = self.fAverageFrameTime + frametime;
	self.fFrameCount = self.fFrameCount + 1;

	if( frametime < self.fLowestFrameTime )
		self.fLowestFrameTime = frametime;
	

	if( self.fFrameReset < time )
	{

		r = self.fAverageFrameTime * 100 / (time - self.real_time);
		tmp = ftos(r);

		if(r > 103 ) {
			bprint5(2 , "WARNING: ", self.netname, "'s speed time is ", tmp, "%\n");
			
			if(r > 105)
				self.rs_g = self.rs_g + 1;
		}
		if(self.rs_g > 3) {
			bprint3(2, "\n", self.netname, " gets kicked for an excessive speed update time\n");
			sprint(self, 2, "Reboot your machine to get rid of this bug\n");
			stuffcmd(self, "disconnect\n");
            	stuffcmd (self, "cmd drop\n");
                  self.rs_g = 0.000;
		}

		fps = floor( 72 * 13 / ( self.fAverageFrameTime / self.fFrameCount * 1000 ) );
		

            tmp = infokey(world, "maxfps");
            maxfps = stof(tmp);

		if (!maxfps) maxfps = 76;

		if( fps > maxfps )
		{
			bprint3(2,"\nWARNING: ", self.netname, "'s frames per second is too high.\n" );	
			sprint(self, 2, "Your FPS is exceeding the quakeworld standard. Lower your fps.\n");

                  if (tmp != string_null)
			self.rv_g = self.rv_g + 1;
			
                  if( self.rv_g > 3 )
			{
			   // kick the player from server!
                     bprint2(2, self.netname, " gets kicked for exceeding fps limits\n");
                     stuffcmd(self, "disconnect\n");
            	   stuffcmd (self, "cmd drop\n");
                  }
		}
		
		// zero these so the average/highest FPS is calculated for each delay period.

		self.real_time = time;
		self.fFrameReset = time + 15;
		self.fAverageFrameTime = 0;
		self.fFrameCount = 0;
		self.fLowestFrameTime = 0.013;
	}

};

void () CheckGspeed = {

   local float maxvel;
   local float medvel;
   local vector dir;

   if (gspeed >= 1.000) {

      maxvel = self.maxspeed * gspeed;
        
      if (self.speed > maxvel) {

         if (gspeedtype == 2) {
            self.gs_interval = time + 0.500;
            medvel = self.speed - maxvel;
		medvel = medvel / 8.000;
            dir = self.velocity;
            self.velocity = normalize(dir) * (self.speed - medvel);
         }
         else 
         {

            self.velocity = normalize(dir) * maxvel;
         }

      }

   }


};



void () PowerupsOff =
{
	local entity te;

	te = find (world, deathtype, "pow");
	while (te)
	{
		if ((te.classname == "item_artifact_invulnerability"))
		{
			te.model = string_null;
		}
		else
		{
			if ((te.classname == "item_artifact_super_damage"))
			{
				te.model = string_null;
			}
			else
			{
				if ((te.classname == "item_artifact_invisibility"))
				{
					te.model = string_null;
				}
			}
		}
		te = find (te, deathtype, "pow");
	}
};

void () PowerupsOn =
{
	local entity te;

	te = find (world, deathtype, "pow");
	while (te)
	{
		if ((te.classname == "item_artifact_invulnerability"))
		{
			te.effects = (te.effects | 128.000000);
			te.think = SUB_regen;
                  te.nextthink = time + 0.100;
		}
		else
		{
			if ((te.classname == "item_artifact_super_damage"))
			{
				te.effects = (te.effects | 64.000000);
			      te.think = SUB_regen;
                        te.nextthink = time + 0.100;
			}
			else
			{
			      te.think = SUB_regen;
                        te.nextthink = time + 0.100;
			}
		}
		te = find (te, deathtype, "pow");
	}
};

float bspversion;


void () Calibrate_Level = {

   local string st;
   local float fl;
   local float autoteam_time;
   local entity ent;

      st = infokey (world,"max_pipebombs");

      fl = (stof (st)) + 1.000;
     
      if (fl < 11 || fl > 25)
      {
         if (store_obs.cnt == 4.000)
         {
            store_obs.max_pipebombs = 21.000;
         }
         else
         {
            store_obs.max_pipebombs = 15.000;
         }
      }

      st = infokey (world,"max_ammoboxes");

      fl = (stof (st)) + 1.000;

      if (fl < 13 || fl > 29) {
         store_obs.max_ammoboxes = 21.000;
      }

      st = infokey (world,"grapple");

      if ( (st == "on") || (toggleflags & 1024) ) {
         allow_hook = 1;
      } else {
  	   allow_hook = 0;
      }

 	st = infokey (world,"tfvsdm");

      if ((st == "on")) {

         store_obs.maxammo_shells = 10.000;
	   classtype = classtype | 64;

	}

 	st = infokey (world,"ctfmap");

      if ((st == "on")) {
         ctfmap = 1.000;
	}

 	st = infokey (world,"dmteams");

      fl = stof(st);
      if (fl > 0 && fl < 16) {

         store_obs.maxammo_shells = fl;
	   classtype = classtype | 64;
	}


      st = infokey (world,"realdm");

      if ( (st == "on") ) {
         realdm = 1.000;
	   classtype = classtype | 64;

      }

/*
      st = infokey (world,"obs_teamtrack");

      if ( (st == "on") ) {
         allow_ttrack = 1;
      } else {
  	   allow_ttrack = 0;
      }



      st = infokey (world,"crouching");

      if ( (st == "on") ) {
         if (bspversion == 30) {
  	      allow_crouch = 1;
         } 
      } else {
  	   allow_crouch = 0;
         
      }

*/

      st = infokey (world,"grenpacks");
      if ( (st == "on") ) {
         allow_grenpack = 1;
      } else {
  	   allow_grenpack = 0;
      }

	st = infokey (world, "autoteam");

	if ((st == "on"))
	{
		autoteam_time = 30.000;
		toggleflags = (toggleflags | 64);
	}
	else
	{
		if ((st == "off"))
		{
			toggleflags = (toggleflags - (toggleflags & 64));
		}
		else
		{
			if ((stof (st) != 0.000000))
			{
				toggleflags = (toggleflags | 64);
				autoteam_time = stof (st);
			}
		}
	}


      st = infokey (world,"autokick_time");

      autokick_time = stof (st);
      if ( (autokick_time != 0.000) ) {


         st = infokey (world,"autokick_kills");
         autokick_kills = stof (st);


      }

    // st = infokey (world,"autokick_concs");
    // autokick_concs = stof (st);

      st = infokey (world,"teamfrags");

      if ( (st == "on") ) {

         toggleflags = (toggleflags | 128.000);

      } else {

         if ( (st == "off") ) {

            toggleflags = (toggleflags - (toggleflags & 128.000));

         }

      }
      st = infokey (world,"fullteamscore");

      if ( (st == "on") ) {

         toggleflags = (toggleflags | 2048.000);

      }
      st = infokey (world,"rd");

      respawn_delay_time = stof (st);
      if ( respawn_delay_time ) {

         toggleflags = (toggleflags | 4.000);

      }
      if ( ((toggleflags & 4.000) && (respawn_delay_time == 0.000)) ) {

         respawn_delay_time = 3.000;

      }

	if ((toggleflags & 64))
	{
		toggleflags = (toggleflags - (toggleflags & 64));
		ent = spawn ();
		ent.nextthink = (time + autoteam_time);
		ent.think = autoteam_think;
	}

  
      st = infokey (world,"grenradius");
      grenradius = stof(st);
       
      if (grenradius > 32 || grenradius < 0)
      {
         grenradius = 0;
      }

      st = infokey (world,"holdlimit");
      if (st == "on")
      {
         holdlimit = 1;
      }

      st = infokey (world,"conctype");
      conctype = stof(st);
       
      if (conctype > 1 || conctype < 0)
      {
         conctype = 0;
      }

      st = infokey (world,"grentype");
      grentype = stof(st);
       
      if (grentype > 1 || grentype < 0)
      {
         grentype = 0;
      }

      st = infokey (world,"hwguytype");
      fl = stof(st);
       
      if (fl > 3 || fl < 1)
      {
         fl = 2;
      }
      if (fl == 3.000) fl = 4;

      classtype = classtype | (fl*2);


      st = infokey (world,"pyrotype");
 
      fl = stof(st);
       
      if (fl > 1 || fl < 0)
      {
         fl = 1;

      }

      classtype = classtype | (fl*16);

      st = infokey (world,"engtype");
      fl = stof(st);
       
      if (fl > 1 || fl < 0)
      {
         fl = 1;
         railgun = 1;
      }
      classtype = classtype | (fl*32);

      st = infokey (world,"plasmaclass");
 
      if ( (st == "on") )
      {
         classtype = classtype | 1.000;
      }

      st = infokey (world,"forzamode");
      
      if (st == "on") {
         grenradius = 7;
         classtype = 32+1;
      }

      st = infokey (world,"tfclassic");
      
      if (st == "on") {
         classtype = 2+16;

         st = infokey (world,"holdlimit");
         if (st == "off")
         {
            holdlimit = 0;
         } else {

            holdlimit = 1.000;
         }
         conctype = 0.000;
         grenradius = 0.000;
         grentype = 0.000;
         modetype = (modetype | 256);
      }


      if (classtype & 16)
      {
         ic_ammo = 3.000;
      }
      else
      {
         ic_ammo = 2.000;
      }
      
      st = infokey (world,"real_weapons");

      if ( (st == "on") ) {

         realistic = realistic | 1;
      }

      st = infokey (world,"real_reload");

      if ( (st == "on") ) {

         realistic = realistic | 2;
      }

      st = infokey (world,"sound_reload");

      reload_sound = 1;

      if ( (st == "off") ) {

         reload_sound = 0;
      }

      st = infokey (world,"railgun");

      if ( (st == "on") ) {

         railgun = 1.000;
      }


      st = infokey (world,"light_ents");

      if ( (st == "on") ) {

         light_ents = 1.000;
      }

      st = infokey (world,"stamina");
 
      if ( (st == "on") ) {

         allow_stamina = 1;

      }


      gspeed = stof(infokey (world,"pm_gspeed"));

      if ((gspeed < 1) || (gspeed > 3 ))  {
         gspeed = 0.000;
      }

      gspeedtype = stof(infokey (world,"pm_gspeedtype"));

      if ((gspeedtype < 1) || (gspeedtype > 3 ))  {
         gspeedtype = 0;
      }

      airspeed = stof(infokey (world,"pm_aspeed"));

      if ((gspeed < 1) || (gspeed > 4 ))  {
         airspeed = 0.000;
      }

      st = infokey (world,"sentrytype");
 
      sgtype = stof(st);
       
      if (sgtype > 1 || sgtype < 0)
      {
         sgtype = 1;
      }


      st = infokey (world,"sentryspeed");
 
      sentry_speed = stof(st);
       
      if (sentry_speed > 0.180 || sentry_speed < 0.060)
      {
         sentry_speed = 0.100;
      }

      st = infokey (world,"sentrydelay");
 
      sentry_delay = stof(st);
 
      if (sentry_delay > 1.000 || sentry_delay < 0.100)
      {
         sentry_delay = 0.250;
      }

      st = infokey (world,"sentryfire");

      sentry_fire = stof(st);
      
      if (sentry_fire > 2 || sentry_fire < 0)
      {
         sentry_fire = 0.000;
      }

      st = infokey (world,"pipedelay");
      pipedelay = 1;

      if (st == "off")
      {
         pipedelay = 0;
      } 

      st = infokey (world,"spec_msgs");
  	spec_msgs = 1;

      if (st == "off")
      {
         spec_msgs = 0;
      } 

      st = infokey (world,"powerups");

      if (st == "off")
      {
		PowerupsOff ();
            powerups = 0;
	}
	else
	{
            powerups = 1;
      }


};

void () Medikit_Fire;
void () Spanner_Fire;

void () CheckUse = {

   if (self.playerclass) {

      traceline (self.origin + '0 0 16',(self.origin + '0 0 16' + (v_forward * 80.000)),0.000,self);

      if ( (trace_fraction != 1.000) ) {

         if ( (trace_ent.classname == "func_button") ) {

            trace_ent.enemy = self;
            other = self;
            self = trace_ent;
            self.enemy = other;
            self.use();
            self = other;
         
            stuffcmd( self, "-use\n");
         } 

         if (self.playerclass == 5.000)
         {
            if ( trace_ent.takedamage ) {
               if (self.attack_finished < time)
               Medikit_Fire ();
               stuffcmd( self, "-use\n");
            }
         }
         else if (self.playerclass == 9.000) 
         {
            if ( trace_ent.takedamage ) {
               if (self.attack_finished < time)
               Spanner_Fire ();
            }
         }
      }
   }

};


void() fadetoblack =
{
	local float fade;
	local string x;

	fade = 10;
	while( fade <= 250 )
	{
		x = ftos( fade );
		stuffcmd( self, "v_cshift 0 0 0 " );
		stuffcmd( self, x );
		stuffcmd( self, ";wait\n" );
		fade = fade + 10;
	}
	stuffcmd( self, "v_cshift 0 0 0 255\n" );
};

void() fadefromblack =
{
	local float fade;
	local string x;

	fade = 250;
	while( fade >= 0 )
	{
		x = ftos( fade );
		stuffcmd( self, "v_cshift 0 0 0 " );
		stuffcmd( self, x );
		stuffcmd( self, ";wait\n" );
		fade = fade - 10;
	}
	stuffcmd( self, "v_cshift 0 0 0 0\n" );
};


