void () TeamFortress_ThrowGrenade;

void () AutoRecord = {

local float i;
local string tmp;
local entity t;


   if (infokey(world, "serverdemo") != string_null) {
      return;
   }

   localcmd("record ");

   //game type
   if (store_obs.maxammo_shells & 10 && classtype & 64)
   {
      localcmd("tfvsdm_");
   }
   else if (modetype & 64)
   {
      localcmd("quad_");
   }
   else if (modetype & 4)
   {
      localcmd("tfstrike_");
   }
   else if (modetype & 32)
   {
      localcmd("duel_");
   }
   else if (modetype & 16)
   {
      localcmd("speedcap_");
   }
   else if (modetype & 2)
   {
      localcmd("practice_");
   } 
   else if (modetype & 1) {
      localcmd("clan_");
   }
   

   while ( i < store_obs.cnt)
   {
      i = i + 1;

      tmp = GetPTeamName(i);
      localcmd(tmp);
      localcmd("_");

      if ( i < store_obs.cnt)
      {
         localcmd("vs_");
      }
   }
   localcmd("[");
   localcmd(mapname);
   localcmd("]");


   t = find(world, classname, "prematch");

   if (t != world) {
     
      if (world.targetname != string_null) {

         calltimeofday ();
         localcmd("_");
         localcmd(ftos(t.tp_grenades_2));
         localcmd("-");
         localcmd(ftos(t.armorclass));
         localcmd("-");
         localcmd(ftos(t.tf_items));
         localcmd("_");
         localcmd(ftos(t.tp_grenades_1));
         localcmd("-");
         localcmd(ftos(t.no_grenades_2));

       }
   }

   localcmd("\n");


};

void () MatchOvertime = {

   local float f2;
   local string st;

   if (cease_fire ) {
      self.nextthink = time + 1.000;
      return ;
   }

   if (TeamFortress_CheckDraw()) {

	self.cnt2 = self.cnt2 + 1;

      st = infokey (world,"overtime");

      if (st == "on") {
         self.think = MatchOvertime;
         self.nextthink = time + 1;
	   return;
      }

      f2 = stof(st);

      if (( f2 > 0.000 )) {
         
         if (self.cnt2 <= (f2 * 60)) {

            self.think = MatchOvertime;
            self.nextthink = time + 1;
	      return;
         }
      }
   }

   self.think = SUB_Remove;
   self.nextthink = time + 0.5;
   NextLevel ();


};


void (string soundname) PlaySoundAll = {

   local entity te;


   te = player_head;

   while (te) {

      stuffcmd(te,"play ");
      stuffcmd(te, soundname);
      stuffcmd(te,"\n");
      te = te.nextp;

   }


   te = spec_head;

   while (te) {

      stuffcmd(te,"play ");
      stuffcmd(te, soundname);
      stuffcmd(te,"\n");
      te = te.nexts;

   }

};

void () ReturnItem;

void () ball_reset;

void () TeamFortress_AmmoboxThink;

void () ResetAll = {

   local entity te;
   local entity oldself;

   te = player_head;
   while (te) {

     oldself = self;
     self = te;

      if ( self.hook_out ) {

         Reset_Grapple (self.hook);
         Attack_Finished (0.750);
         self.hook_out = 1.000;

      }


      self.menu_count = 25.000;
      self.current_menu = 1.000;

      TeamFortress_ThrowGrenade ();
      TeamFortress_RemoveTimers ();


      if (modetype & 64) {
          ShowFrags(self);
      }
	if ( (self.playerclass == 9.000) ) {

	   Engineer_RemoveBuildings(self);

      }

      if (modetype & 4) {
         if ((self.pteam == pteam2) && (self.playerclass)) {

            self.ammo_detpack = 0.000;
            stuffcmd (self,"topcolor ");
            stuffcmd (self,ftos(self.pteam.colormap));
            stuffcmd (self,"\n");
         }
       }

      self = oldself;
      te = te.nextp;

   }

   te = find (world,classname,"grenade");
   while ( te ) {

      te.think = SUB_Remove;
      te.nextthink = (time + 0.100);
      te = find (te,classname,"grenade");
   }

   te = find (world,classname,"grentimer");
   while ( te ) {

      te.think = SUB_Remove;
      te.nextthink = (time + 0.100);
      te = find (te,classname,"grentimer");

   }


   te = find (world,classname,"detpack");

   while ( te ) {


      if ( (te.weaponmode == 1.000) ) {

         TeamFortress_SetSpeed (te.enemy);
         dremove (te.oldenemy);
         dremove (te.observer_list);

      }
      dremove (te.linked_list);
      dremove (te);
      te = find (te,classname,"detpack");

   }


   te = find (world,classname,"item_tfgoal");
   while (te) {

       if ( (te.origin != te.oldorigin) ) {

     		oldself = spawn ();
     		oldself.enemy = te;
            oldself.weapon = 3.000;
      	oldself.nextthink = (time + 0.200);
      	oldself.think = ReturnItem;

       }
       te = find (te,classname,"item_tfgoal");
   }


   te = find (world,classname,"item_ball");
   while (te) {

       if ( (te.origin != te.oldorigin) ) {
          te.nextthink = (time + 0.300);
          te.think = ball_reset;
       }

       te = find (te,classname,"item_ball");
   }


   te = find (world,classname,"ammobox");
   while (te) {

       te.nextthink = (time + 0.300);
       te.think = TeamFortress_AmmoboxThink;

       te = find (te,classname,"ammobox");
   }

};

void () MatchThink = {

local string tmp;


   if ( self.cnt == -1 ) {
	return;
   }

   if (cease_fire ) {
      self.nextthink = time + 1.000;
      return ;
   }

   self.cnt2 = self.cnt2 - 1;


   if(!TeamFortress_GetNoPlayers ()) {
	 NextLevel();
	 return;
   }

   if(self.cnt2 == -1) 
   {
   // Calculate every 60 seconds.
      self.cnt2 = 59.000;

	self.cnt = self.cnt - 1;
	localcmd("serverinfo status \"");
	tmp = ftos(self.cnt);
	localcmd(tmp);
	localcmd(" min left\"\n");
   }

   if(!self.cnt2) 
   {


      if (self.cnt == 5.000) {

         PlaySoundAll("speech/5_minute.wav");
         tmp = ftos(self.cnt);
         bprint3(2, "", tmp, "‘ minute's remaining\n");
      }

      if (self.cnt == 1.000) {

         PlaySoundAll("speech/1_minute.wav");
         tmp = ftos(self.cnt);
         bprint3(2, "", tmp, "‘ minute remaining\n");
      }

      if(!self.cnt) 
      {

         if (modetype & 64)
         {

            if (store_obs.count < 2.000)
            {
               pmtime = stof(infokey (world,"prematch"));

               if (!pmtime)     pmtime = stof( infokey (world,"cft"));
               ResetAll();
               cb_prematch = 1;
               StartTimer ();
	         self.think = SUB_Remove;
               self.nextthink = time + 0.1;
               return;
            }
         } 

         tmp = infokey (world,"overtime");
         

         if (( stof(tmp) )) {

            if (TeamFortress_CheckDraw()) {

               bprint(2,"Draw, overtime set.\n Golden Cap WINS!!!\n"); 
		   self.cnt2 = 0.000;
               MatchOvertime();
		   self.cnt = -1;
               return;
            }
         }



	   self.think = SUB_Remove;
         self.nextthink = time + 0.1;
         NextLevel ();
         return;

         

      }

   }

   if ((!self.cnt) && (self.cnt2 == 30.000 || self.cnt2 == 15.000 || self.cnt2 <= 10.000)) {


	tmp = ftos(self.cnt2);
	bprint3(2, "", tmp, "‘ second");
	if(self.cnt2 != 1.000) bprint(2, "s");
	bprint(2, " remaining\n");
   }


   self.nextthink = time + 1.000;

};

void () StartMatch = {

   local string st;
   local float f1,f2;
   local entity te;
   local entity oldself;
   local entity gren;

   lightstyle (0.000,"m");

   bprint (2.000,"MATCH BEGINS NOW\n");
   store_obs.count = store_obs.count + 1.000;

  Initialise_Teams();
  
   te = player_head;
   while ( te ) {

     oldself = self;
     self = te;

      if ( self.hook_out ) {

         Reset_Grapple (self.hook);
         Attack_Finished (0.750);
         self.hook_out = 1.000;
      }

      TeamFortress_RemoveTimers ();

      if (!modetype & 64)
      {
         self.frags = 0.000;
         self.real_frags = 0.000;
      }

      setspawnparms (self);
      PutClientInServer ();

/*  Fte extension
      st = infokey (world, "*version");
      if ((strstr (st, "FTE") != ""))
      {
          ext_HidePicEnt("timer1", self);
      }
*/
      stuffcmd (self,"on_matchstart\n");
      self = oldself;
      te = te.nextp;

   }

   gren = find (world,classname,"grenade");
   while ( gren ) {

      gren.think = GrenadeExplode;
      gren.nextthink = (time + 0.100);
      gren = find (gren,classname,"grenade");
   }

   freeze = 0;
   cb_prematch = 0.000;
   cease_fire = 0.000;

   te = find(world, classname, "prematch");
   te.classname = "match";
   te.cnt = (timelimit / 60);

   te.cnt2 = 60.000;

   if ( te.cnt == 0 ) {

       bprint (2.000,"Warning no timelimit set!\n");
       localcmd("\nserverinfo status \"0 min left\"\n");
       te.cnt = -1.000;
	 te.cnt2 = -1.000;

   } else {

      f1 = floor(self.cnt);

      if (f1 < te.cnt)
      {
        te.cnt2 = (te.cnt - f1) * 60.000;
      } 

      if (te.cnt2 == 60.000) {
        te.cnt = te.cnt - 1.000;
      } else {
        te.cnt = f1;
      }

      localcmd("\nserverinfo status \"");
      st = ftos((te.cnt));
      localcmd(st);
      localcmd(" min left\"\n");
      te.think = MatchThink;
      te.nextthink = time + 1.000;
   }

   st = infokey(world, "spectalk");
   f2 = stof(st);
   if (!f2) {
     st = "0";
   }

   localcmd("sv_spectalk ");
   localcmd(st);
   localcmd("\n");   
   
   f1 = stof(infokey(world, "fpd"));
   f1 = f1 - (f1 & 64) + (f2 * 64);
   localcmd("serverinfo fpd ");
   st = ftos(f1);
   localcmd(st);
   localcmd("\n");

   if (rounds) {
      oldself = spawn();
	oldself.owner = world;
	oldself.classname = "round";
      oldself.nextthink = (time + 1.000);
      oldself.think = StartRound;
   }

};

void () PreMatch_Think = {

   local entity p;
   local string num;
   local float fl;

	self.cnt2 = self.cnt2 - 1;
	if(self.cnt2 == 1)  {

		p = player_head;
		while(p != world) {
			if(p.netname != "")
                  {
                        p.respawn_time = (time + 2.000);
				//set to ghost 1 second before matchstart
				p.takedamage = 0;
				p.solid = 0;
				p.movetype = 0;
				p.modelindex = 0;
				p.model = string_null;

			}
			p = p.nextp;
		}
	}
        else if(!self.cnt2)
        {
		self.nextthink = time + 0.1;
		self.think = SUB_Remove;
	
		// Stops the bug where players are set to ghosts 1 second to go and countdown aborts.
		// standby flag needs clearing (sturm)
		p = player_head;
		while (p) 
		{
			if(p.netname != "")
			{
				p.takedamage = 2;
				p.solid = 3;
				p.movetype = 3;
			}
			p = p.nextp;
		}

		StartMatch();
		return;
	}

      fl = self.cnt2 / 60;



      if (fl == 1 || fl == 2 || fl == 3 || fl == 4 || fl == 5 || fl == 6 || fl == 7 || fl == 8 || fl == 9 || fl == 10)
      {


	   num = ftos(fl) ;
         bprint3(2, "Match will begin in ",num," minute(s).\n");

      }

      if (self.cnt2 == 30)
      {

	   num = ftos(self.cnt2 / 60) ;
         bprint(2, "Match will begin in 30 seconds.\n");

      }

      if (self.cnt2 <= 10) 
      { 

         if (self.cnt2 == 10) 
         { 
            lightstyle (0.000,"e");

            if ((infokey(world, "status") != "Countdown")) {

              localcmd("serverinfo status Countdown\n");
	      }
            if (stof(infokey(world, "demo_auto_left")) > 0.000) {
                AutoRecord();
            } 
         }
	   num = ftos(self.cnt2);

           p = player_head;

           while(p)
           {

              if(p.netname != "") {
                
                 //WriteByte(2,26);

		     CenterPrint3(p,"Countdown ",num,"\n");

                 if(self.cnt2 < 6) {
	              cease_fire = 0.000;
                    stuffcmd (p, "play buttons/switch04.wav\n");

/* Fte Extension
                    st = infokey (world, "*version");
                    if ((strstr (st, "FTE") != ""))
                    {
	                 st = ftos(self.cnt2);
	                 st = strcat("textures/wad/num_", st);
	                 st = strcat(st, ".png");
                       ext_ShowPicEnt("timer1", st, -30, -60, 4, p);
                    }
*/

                 }
              }

              p = p.nextp;
           }

         if ((self.cnt2 > 1))
         {
				
             bprint2 (2, num, " seconds.\n");

         }
         else
         {
            bprint (2, "1 second.\n");

         }

      }

	self.nextthink = time + 1;


};


void() StartTimer =
// Spawns the timer and starts the countdown.
{
	local entity timer, p;
	local float f1;
	local string tmp;

	if (!(modetype & 1)) {

         if (self != world) {
	      sprint(self, 2.000, "Clan mode off....\n");
	      sprint(self, 2.000, "Match cannot be started.\n");
         }
         else 
         {
	      dprint("Clan mode off....\n");
	      dprint("Match cannot be started.\n");
         }
	   return;
	}

	if (( modetype & 1) && (cb_prematch == 0.000)) {
	   if (self != world) {
            sprint(self, 2.000, "Clan Battle in progress....\n");
	      sprint(self, 2.000, "Type break to stop the current battle.\n");
         }
         else
         {
            dprint("Clan Battle in progress....\n");
	      dprint("Type break to stop the current battle.\n");
         }
	   return;
	}

      if ((infokey(world, "status") == "Countdown")) {
	   if (self != world) {
	      sprint(self, 2.000, "Countdown in progress....\n");
         }
         else
         {
            dprint("Countdown in progress....\n");
         }
	   return;
	}


	timer = find(world, classname, "prematch");
	while(timer != world) {
		dremove(timer);
		timer = find(timer, classname, "prematch");
	}

// print qizmo settings
	f1 = stof(infokey(world, "fpd"));
	if(f1 & 170) {
		bprint(2, "QiZmo:");
		if(f1 & 2) bprint(2, " פיםוע");
		if(f1 & 8) bprint(2, " לבח");
		if(f1 & 32) bprint(2, " ומוםש");
		if(f1 & 128) bprint(2, " נןימפ");
		bprint(2, " disabled\n");
	}


      f1 = stof(infokey (world,"prematch"));
 

	timer = spawn();
	timer.owner = world;
	timer.classname = "prematch";
	timer.cnt = 0;

      if (pmtime) {
 
         timer.cnt2 = rint(pmtime * 60);
         if (timer.cnt2 < 1 ) {
            timer.cnt2 = 1.000;
         }

      } else {

         lightstyle (0.000,"e");
         if (stof(infokey(world, "demo_auto_left")) > 0.000) {
            AutoRecord();
         } 
         localcmd("serverinfo status Countdown\n");
	   p = player_head;
	   while(p) {
		if(p.netname != "") stuffcmd(p, "play items/protect2.wav\n");
		p = p.nextp;
	   }

	   timer.cnt2 = rint(stof(infokey(world, "count")));

         if (timer.cnt2 < 1 ) {
            timer.cnt2 = 0.000;
         }
      }

	timer.cnt2 = timer.cnt2 + 1;
	timer.nextthink = time + 0.1;
	tmp = ftos(timer.cnt2);

	timer.think = PreMatch_Think;


};

void() StopTimer =
{
// Whenever a countdown or match stops, remove the timer and reset everything.
	local entity t;

      if (infokey(world, "serverdemo") != string_null) {
         localcmd("cancel\n");
      } 

      if (cb_prematch) {

	   t = find(world, classname, "prematch");
	   while(t != world) {
	      t.nextthink = time + 0.1;
	      t.think = SUB_Remove;
	      t = find(t, classname, "prematch");
	   }

	   localcmd("serverinfo status Standby\n");
         lightstyle (0.000,"m");
	   return;
	}


	t = find(world, classname, "match");
	if(t != world)
      {
         dremove(t);
	   localcmd("serverinfo status Normal\n");
         NextLevel();
      } else {
         bprint(2.000, "No match to break.\n");
      }
	
};

void() PlayerBreak =
{
	local float f1, f2;
      local string tmp;

      if (intermission_running) return;

	if (self.classname != "player") {
         return;
      }

	if (cb_prematch) {

         if (!pmtime) {

	      bprint2(2, self.netname, " stops the countdown\n");
	      StopTimer();
	   }

	   return;
	}


      tmp = infokey (world,"votetime");

      f1 = (stof(tmp) * 60);

      if (f1 > time) {
         sprint(self, 2.000, "You cannot break at this time.\n");
         return;
      }

      if (self.allowvote > time)
      {
         return;
      }

      self.allowvote = time + 3.000;


	if(self.bvote) {
		bprint2(2, self.netname, " קיפטהעבקף ");
		if(infokey(self, "gender") == "f") bprint(2, "טוע ");
		else bprint(2, "טיף ");
		bprint(3, "vote\n");
		self.bvote = 0;
		v_break = v_break - 1;
		return;
	}

	if (modetype & 1) {
	   	bprint2(3, self.netname, " votes for stopping the match\n");
	   
	} else {

         	bprint2(3, self.netname, " votes to end the current map\n");
      }

	self.bvote = 1;
	v_break = v_break + 1;
	f1 = TeamFortress_GetNoPlayers ();
	f2 = (floor(f1 / 2)) + 1;
	if(v_break >= f2) {
	      if (modetype & 1) {
		   bprint(2, "Match stopped by majority vote\n");
            } else {
               bprint(2, "Map ended by majority vote\n");
            }
		StopTimer();
		return;
	}

	if ( v_break != 0.000 ) {
		f1 = f2 - v_break;
		tmp = ftos(f1);
		bprint3(2, "", tmp, "‘ more vote");
		if(f1 > 1) bprint(2, "s");
		bprint(2, " needed\n");
	}

};

void () RemoveVotes = {


	if(self.bvote) {
		bprint2(2, self.netname, " קיפטהעבקף ");
		if(infokey(self, "gender") == "f") bprint(2, "טוע ");
		else bprint(2, "טיף ");
		bprint(3, "vote\n");
		self.bvote = 0;
		v_break = v_break - 1;
	}

      if (self.mvote) {
		self.mvote = 0;
		v_misc = v_misc - 1;
	}

      if (elect) {

        if(self.is_admin == 2.000) {
		bprint2(2, self.netname, " aborts election!");
		bprint(3, "\n");
		AbortElect();
        }

      }

};

