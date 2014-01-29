void () StopTimer;

void () Admin_CountPlayers = {

   local string st;
   local float nump;

   nump = TeamFortress_GetNoPlayers ();
   st = ftos (nump);
   sprint3 (self,2.000,"Players In Game : ",st,"\n");
   if ( (store_obs.cnt > 0.000) ) {

      nump = TeamFortress_TeamGetNoPlayers (1.000);
      st = ftos (nump);
      sprint3 (self,2.000,"Players In Team1: ",st,"\n");

   }
   if ( (store_obs.cnt > 1.000) ) {

      nump = TeamFortress_TeamGetNoPlayers (2.000);
      st = ftos (nump);
      sprint3 (self,2.000,"Players In Team2: ",st,"\n");

   }
   if ( (store_obs.cnt > 2.000) ) {

      nump = TeamFortress_TeamGetNoPlayers (3.000);
      st = ftos (nump);
      sprint3 (self,2.000,"Players In Team3: ",st,"\n");

   }
   if ( (store_obs.cnt > 3.000) ) {

      nump = TeamFortress_TeamGetNoPlayers (4.000);
      st = ftos (nump);
      sprint3 (self,2.000,"Players In Team4: ",st,"\n");

   }

};

void () Admin_ListPlayers = {

   local entity pl;
   local float num;
   local string st;

   if ( (TeamFortress_GetNoPlayers () <= 1.000) ) {

      sprint (self,2.000,"No other players in the game.\n");
      return ;

   }
   pl = player_head;
   while ( (pl != world) ) {

      if ( ((pl.netname != string_null) && (pl != self)) ) {

         num = EntityNum (pl);
         st = ftos(num);
         sprint (self,2.000,pl.netname);
         sprint (self,2.000,"   ");
         sprint (self,2.000, st);
         sprint (self,2.000,"\n");

      }
      pl = pl.nextp;

   }
   pl = spec_head;
   while ( (pl != world) ) {

      if ( ((pl.netname != string_null) && (pl != self)) ) {

         num = EntityNum (pl);
         st = ftos(num);
         sprint (self,2.000,pl.netname);
         sprint (self,2.000,"   ");
         sprint (self,2.000, st);
         sprint (self,2.000,"\n");
         sprint (self,2.000," (SPECTATOR)\n");

      }
      pl = pl.nexts;

   }
   sprint (self,2.000,"End of player list\n");
   pl = world;

};

void () Admin_ListIPs = {

   local entity pl;

   if ( (TeamFortress_GetNoPlayers () <= 1.000) ) {

      sprint (self,2.000,"No other players in the game.\n");
      return ;

   }
   pl = player_head;
   while ( (pl != world) ) {

      if ( ((pl.netname != string_null) && (pl != self)) ) {

         pl.ip = infokey (pl,"ip");
         sprint (self,2.000,pl.netname);
         sprint (self,2.000," (");
         sprint (self,2.000,pl.ip);
         sprint (self,2.000,")");
         sprint (self,2.000,"\n");

      }
      pl = pl.nextp;

   }

   pl = spec_head;
   while ( (pl != world) ) {

      if ( ((pl.netname != string_null) && (pl != self)) ) {

         pl.ip = infokey (pl,"ip");
         sprint (self,2.000,pl.netname);
         sprint (self,2.000," (");
         sprint (self,2.000,pl.ip);
         sprint (self,2.000,")");
         sprint (self,2.000," (SPECTATOR)\n");

      }
      pl = pl.nexts;

   }
   sprint (self,2.000,"End of player list\n");
   pl = world;

};

void () Admin_DoKick = {

   bprint4 (2.000,self.admin_use.netname," was kicked by ",self.netname,"\n");

   stuffcmd (self.admin_use,"disconnect\n");
   stuffcmd (self.admin_use,"cmd drop\n");
   self.admin_mode = 0.000;
   self.admin_use = world;

};


void (float num) Admin_KickNum = {


   if ( (TeamFortress_GetNoPlayers () <= 1.000) ) {

      sprint (self,2.000,"No other players in the game.\n");
      return ;
   }

   if (num < 1) {
      sprint (self,2.000,"Number invalid - player not found.\n");
      self.admin_use = world;
      return ;
   }

   self.admin_use = NumEntity(num);

   if ( self.admin_use.classname == "player" || self.admin_use.classname == "observer") {

      Admin_DoKick();

   } else {
      sprint (self,2.000,"Number invalid - player not found.\n");
      self.admin_use = world;
      self.admin_mode = 0.000;
      return ;
   }
};


void () Admin_CycleDeal = {

   if ( (TeamFortress_GetNoPlayers () <= 1.000) ) {

      sprint (self,2.000,"No other players in the game.\n");
      self.admin_use = world;
      self.admin_mode = 0.000;
      return ;

   }
   if ( (self.admin_use.classname != "observer") ) {

      self.admin_use = player_head;
      while ( ((self.admin_use != world) && ((self.admin_use.netname == string_null) || (self.admin_use == self))) ) {

         self.admin_use = self.admin_use.nextp;

      }
      if ( (self.admin_use == world) ) {

         self.admin_use = spec_head;
         while ( ((self.admin_use != world) && ((self.admin_use.netname == string_null) || (self.admin_use == self))) ) {

            self.admin_use = self.admin_use.nexts;

         }

      }

   } else {

      self.admin_use = spec_head;
      while ( ((self.admin_use != world) && ((self.admin_use.netname == string_null) || (self.admin_use == self))) ) {

         self.admin_use = self.admin_use.nexts;
      }

   }
   if ( self.admin_use ) {

      self.admin_use.ip = infokey (self.admin_use,"ip");
      self.admin_mode = 1.000;
      sprint (self,2.000,"   ");
      sprint (self,2.000,self.admin_use.netname);
      sprint3 (self,2.000," (",self.admin_use.ip,")");
      if ( (self.admin_use.classname == "observer") ) {

         sprint (self,2.000," (SPECTATOR)");

      }
      sprint (self,2.000,"\n");
      sprint (self,2.000,"   KICK/NEXT?\n");

   } else {

      self.admin_mode = 0.000;
      sprint (self,2.000,"End of player list\n");

   }

};

void () CeaseFire_think = {

   local entity te;


   if ( !cease_fire ) {
      dremove (self);
      return ;

   }
   te = player_head;
   while ( te ) {

      CenterPrint3 (te,"CEASE FIRE\nCalled by: ",self.owner.netname,"\n");
      te = te.nextp;

   }
   self.nextthink = (time + 5.000);

};

void () Admin_CeaseFire = {

   local entity te;

   if ( !cease_fire ) {

      if (cb_prematch) {

         StopTimer();
      }

      cease_fire = 1.000;
      bprint (2.000,"CEASE FIRE\n");
      te = player_head;
      while ( te ) {

         CenterPrint3 (te,"CEASE FIRE\nCalled by: ",self.netname,"\n");
         //te.immune_to_check = (time + 5.000);
         te.tfstate = (te.tfstate | 65536.000);
         TeamFortress_SetSpeed (te);
         
         te = te.nextp;

      }
      te = spawn ();
      te.owner = self;
      te.classname = "ceasefire";
      te.think = CeaseFire_think;
      te.nextthink = (time + 5.000);

   } else {

      te = find (world,classname,"ceasefire");
      if ( te ) {

         dremove (te);

      }
      cease_fire = 0.000;

      if (cb_prematch) {

         pmtime = 0.000;
         StartTimer();
      }

      bprint (2.000,"RESUME FIRE\n");
      te = player_head;
      while ( te ) {

         CenterPrint3 (te,"RESUME FIRE\nCalled by: ",self.netname,"\n");
         //te.immune_to_check = (time + 5.000);
         te.tfstate = (te.tfstate - (te.tfstate & 65536.000));
         TeamFortress_SetSpeed (te);

         te = te.nextp;

      }

   }

};

void () autokick_think = {

   self.owner.teamkills = 0.000;
   dremove (self);

};

void (entity p) CheckAutoKick = {

   local float rnum;
   local entity te;

   if ( ((p.teamkills >= autokick_kills) && (autokick_kills != 0.000)) ) {

      bprint2 (2.000,p.netname," was kicked for killing teammates.\n");
      sprint (p,2.000,"You were kicked for killing teammates.\n");
      stuffcmd (p,"disconnect\n");

   } else {

      if ( (autokick_kills != 0.000) ) {

         if ( (p.teamkills == (autokick_kills - 1.000)) ) {

            sprint (p,2.000,"Kill one more teammate, and you're outta here.\n");

         }
         rnum = 0.000;
         te = find (world,classname,"ak_timer");
         while ( te ) {

            if ( (te.owner == p) ) {

               rnum = 1.000;
               te = world;

            } else {

               te = find (te,classname,"ak_timer");

            }

         }
         if ( (rnum == 0.000) ) {

            te = spawn ();
            te.classname = "ak_timer";
            te.owner = p;
            te.think = autokick_think;
            te.nextthink = (time + autokick_time);

         }

      }

   }

};


void() AbortElect =
{
	local entity p;

	elect = 0;
	p = find(world, classname, "player");
	while(p != world) {
		if(p.netname != "") {
			p.vote = 0;
			if(p.is_admin == 2.000) p.is_admin = 0.000;

		}
		p = find(p, classname, "player");
	}
	p = find(world, classname, "spectator");
	while(p != world)
	{
		if(p.netname != "" && p.is_admin == 2.000)	p.is_admin = 0;
		p = find(p, classname, "spectator");
	}

	p = find(world, classname, "electguard");
// Kill timeout checker entity
	if(p.classname == "electguard") dremove(p);
};

void() ElectThink =
{
	bprint(2, "The voting has timed out.\nElection aborted\n");
	self.nextthink = -1;
	AbortElect();
};

void() VoteAdmin =
{
	local float f1, f2, f3;
	local string tmp;
	local entity electguard;

      if (self.electtime > time)
      {
         sprint(self, 2.000, "You cannot elect at this time.\n");
         return;
      }

      self.electtime = time + 3.000;


	if ((self.is_admin == 1.000) || (self.is_admin == 3.000)) {
		sprint(self, 2, "You are already an admin\n");
		return;
	}

        if(self.is_admin == 2.000) {
		bprint2(2, self.netname, " aborts election!");
		bprint(3, "\n");
		AbortElect();
		return;
	}
// Only one election per server because otherwise we wouldn't know how to count
// "yes"s or "no"s

	if(elect != 0) {
		sprint(self, 2, "An election is already in progress\n");
		return;
	}


	bprint2(2, self.netname, " has requested admin rights!\n");

	self.is_admin = 2.000;
	elect = 1;



      tmp = infokey (world,"votespercentage");

      f3 = stof(tmp);
      if (f3 < 5 || f3 > 95) {
         f3 = 50;
      }
      f3 = f3 / 100;

	f1 = TeamFortress_GetNoPlayers ();
	f2 = (elect / f1);

	if(f2 > f3) {

		if(self.is_admin == 2.000) {

			bprint2(2, self.netname, " ηαιξσ αδνιξ στατυσ!");
			bprint(3, "\n");
			sprint(self, 2, "Type γονναξδσ for admin commands.\n");
			self.is_admin = 1.000;
			self.get_admin_aliases = 1.000;
			elect = 0;
		}

        } else {

		bprint(2, "Type");
		bprint(3, " yes");
		bprint(2, " in console to approve\n");
		sprint(self, 2, "Type εμεγτ to abort election\n");
		electguard = spawn(); // Check the 1 minute timeout for election
		electguard.owner = world;
		electguard.classname = "electguard";
		electguard.think = ElectThink;
		electguard.nextthink = time + 60;
	}
};

void() VoteYes =
{
	local float f1, f2, f3;
	local string tmp;
	local entity p;


	if( !elect) {
		return;
	}

	if(self.is_admin == 2.000) {
		sprint(self, 2, "You cannot vote for yourself\n");
		return;
	}

	if(self.vote) {
		sprint(self, 2, "--- your vote is still good ---\n");
		return;
	}
// register the vote

	elect = elect + 1;
	bprint2(2, self.netname, " gives ");
	if(infokey(self, "gender") == "f") bprint(2, "her");
		else bprint(2, "his");
	bprint(2, " vote\n");
	self.vote = 1;



      tmp = infokey (world,"votespercentage");

      f3 = stof(tmp);
      if (f3 < 5 || f3 > 95) {
         f3 = 50;
      }
      f3 = f3 / 100;

	f1 = TeamFortress_GetNoPlayers ();
	f2 = (elect / f1);

	if(f2 >= f3) {
		p = find(world, classname, "player");
		while(p.is_admin != 2.000) p = find(p, classname, "player");

		if(p.is_admin == 2.000) {
// s: election was admin election
			bprint2(2, p.netname, " ηαιξσ αδνιξ στατυσ!");
			bprint(3, "\n");
			sprint(p, 2, "Type γονναξδσ for admin commands.\n");
			p.is_admin = 1.000;
			p.get_admin_aliases = 1.000;
                  AbortElect();

             }

           self.vote = 0;
        }

// calculate how many more votes are needed
	if ( elect != 0 ) {
		f1 = f2 - elect;
		tmp = ftos(rint(f1));
		bprint3(2, "", tmp, "‘ more vote");
		if(f1 > 1) bprint(2, "s");
		bprint(2, " needed\n");
	}
};


void() VoteNo =
{
	local float f1, f2;
	local string tmp;

// withdraw one's vote
	if(self.is_admin == 1.000)  {
		return;
	}

        if(elect == 0 || self.is_admin == 2.000 || self.vote == 0.000) return;
	bprint2(2, self.netname, " withdraws ");
	if(infokey(self, "gender") == "f") bprint(2, "her");
		else bprint(2, "his");
	bprint(2, " vote\n");
	self.vote = 0;
	elect = elect - 1;
	f1 = TeamFortress_GetNoPlayers ();
	f2 = (floor(f1 / 2)) + 1;
	f1 = f2 - elect;
	tmp = ftos(f1);
	bprint3(2, "", tmp, "‘ more vote");
	if(f1 > 1) bprint(2, "s");
	bprint(2, " needed\n");
};
