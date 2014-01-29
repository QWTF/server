float(float num, float digits) spaceoutnum =
{
 	local float d;
 	d = digits - 1;
	if (num < 0)
	{
 		d = d - 1;
 		num = 0 - num;
 	}

 	if (num >= 10) d = d - 1;
 	if (num >= 100) d = d - 1;
	if (num >= 1000) d = d - 1;
	if (num >= 10000) d = d - 1;
	if (num >= 100000) d = d - 1;
 	if (num >= 1000000) d = d - 1;
 	return (d);
 };
	
string (float num) spacestring = 
{
   local string st;

   st = strcat (st, " ");

   while (num > 0)  {

      st = strcat (st, " ");
      num =  num - 1;
   }

   return (st);
};

string (float num, float digits) spacefornum = 
{
   local string st;
   local float fl;

   fl = spaceoutnum(num, digits);

   st = spacestring(fl);

   return (st);
};

void() ShowVersion =
{
        sprint(self, 2,"\n\nΤθισ ισ Oz Team Fortress φεςσιοξ 1.76         βω Mercury\n\nΣπεγιαμ τθαξψ το Omicron, γςεατοςσ οζ Kombat Teams 2.21\nΑξδ ξοξε οτθες τθεξ τθε γςεατοςσ οζ Team Fortress\n\n\nPlease visit θττπΊ――οϊτζ®ρυαλεχοςμδ®ξυ― for more info. \n\n\n");
};

//Special thanx to Rawhide, Omicron, creators of Kombat Teams 2.21\nAnd none other then the creators of Team Fortress\n\n Also thank you to all those test dummies.\n Including the fatty fv nitemare.\n And the annoying sh33p b0y bliP :)\n\nPlease visit ρχτζ®αυσζοςτςεσσ®γον for more info. \n");

void() Commands =
{
	sprint(self, 2, "αβουτ...... about the Oztf Mod\nνοδστατυσ.. current settings\nβςεαλ...... vote matchend/stop countdown\nεμεγτ...... toggle admin election\nωεσ........ vote yes for current elective\nξο......... change vote\n");

	if (self.is_admin == 1) {

         if (stof(infokey (world,"adminlevel")) > 0)
         {

            sprint(self, 2, "\nAdmin Commands:\n\n");

		sprint(self, 2, "τινεδοχξ... decrease timelimit\nτινευπ..... increase timelimit\nπνδοχξ..... decrease prematch time\nπνυπ....... increase prematch time\nγζδοχξ..... decrease ceasefire time\nγζυπ....... increase ceasefire time\nοτδοχξ..... decrease overtime\n");
		sprint(self, 2, "οτυπ....... increase overtime\nζςαησδοχξ.. reduce fraglimit\nζςαησυπ.... increase fraglimit\nσιμεξγε.... toggle spectator talk\nςεσταςτναπ. restart the current map\nσταςτνατγθ. starts clan match (requires clan mode on)\n");

            if (stof(infokey (world,"adminlevel")) > 1)
            {
	         sprint(self , 2 , "ςεσετ...... reset all settings to standard\nγμαξσετυπ.. set clan settings and restart\nγεασεζιςε.. freeze the gameplay\nζςεεϊε..... (un)freeze the map\nζβσλιξσ.... toggle full bright skins\nζςκυνπ..... toggle forward rocketjump\n");
	         sprint(self , 2 , "ποιξτιξη... toggle pointing\nεξενω...... toggle enemy printing\nηςεξπαγλ... toggle backpacks\nησπεεδ..... modify maximum ground speed\nτπ......... modify teamplay\nηιβσ....... toggle gibs\nσητωπε..... toggle sentry type\nσηζιςε..... toggle sentry fire\n");
               sprint(self , 2 , "πιπεδεμαω.. (dis)allow pipebomb delay\nσομιδδετ... toggle solid detpacks\n");
            }

            if (stof(infokey (world,"adminlevel")) > 2)
            {
               sprint(self , 2 , "δεαμ....... kick a player\nμιστιπσ.... list players ip addresses\n");
            }

            sprint(self, 2, "\n*** The following commands require a map restart ***\n\n");
            sprint(self, 2, "τεανζςαησ.. toggle teamfrags\nζυμμτσ..... toggle full team score\nηςαππμε.... toggle grapple\n");
            if (stof(infokey (world,"adminlevel")) > 1)
            {
               sprint(self , 2 , "γμαξ....... toggle clan mode\nτζφσδν..... toggle tfvsdm mode\nτζστςιλε... toggle tfstrike mode\nςουξδσ..... toggle rounds\nδυεμ....... toggle duel mode\nσπεεδγαπ... toggle speed capture mode\nθιηθμαξδες. toggle highlander mode\nπςαγτιγε... toggle practice mode\n");
            }
         }
      }

	if (self.is_admin == 3) {

         sprint(self, 2, "\nAdmin Commands:\n\n");
         sprint(self, 2, "τινεδοχξ... decrease timelimit\nτινευπ..... increase timelimit\nπνδοχξ..... decrease prematch time\nπνυπ....... increase prematch time\nγζδοχξ..... decrease ceasefire time\nγζυπ....... increase ceasefire time\nοτδοχξ..... decrease overtime\n");
         sprint(self, 2, "οτυπ....... increase overtime\nζςαησδοχξ.. reduce fraglimit\nζςαησυπ.... increase fraglimit\nσιμεξγε.... toggle spectator talk\nςεσταςτναπ. restart the current map\nσταςτνατγθ. starts clan match (requires clan mode on)\n");
         sprint(self, 2, "ςεσετ...... reset all settings to standard\nγμαξσετυπ.. set clan settings and restart\nγεασεζιςε.. freeze the gameplay\nζςεεϊε..... (un)freeze the map\nζβσλιξσ.... toggle full bright skins\nζςκυνπ..... toggle forward rocketjump\n");
         sprint(self, 2, "ποιξτιξη... toggle pointing\nεξενω...... toggle enemy printing\nηςεξπαγλ... toggle backpacks\nησπεεδ..... modify maximum ground speed\nτπ......... modify teamplay\nηιβσ....... toggle gibs\nσητωπε..... toggle sentry type\n");
         sprint(self, 2, "σηζιςε..... toggle sentry fire\nπιπεδεμαω.. (dis)allow pipebomb delay\nσομιδδετ... toggle solid detpacks\nδεαμ....... kick a player\nμιστιπσ.... list players ip addresses\n");
         sprint(self, 2, "\n*** The following commands require a map restart ***\n\n");
         sprint(self, 2, "γμαξ....... toggle clan mode\nτζφσδν..... toggle tfvsdm mode\nτζστςιλε... toggle tfstrike mode\nτεανζςαησ.. toggle teamfrags\nζυμμτσ..... toggle full team score\nηςαππμε.... toggle grapple\n");
         sprint(self, 2, "θιηθμαξδες. toggle highlander mode\nςουξδσ..... toggle rounds\nδυεμ....... toggle duel mode\nσπεεδγαπ... toggle speed capture mode\nπςαγτιγε... toggle practice mode\n");
      }


};

void () ShowScores = {

   local string st;



   stuffcmd(self, "scores ");
   stuffcmd(self, self.netname);
   stuffcmd(self, " ");
   stuffcmd(self, ftos(pteam1.frags));
   stuffcmd(self, " ");
   stuffcmd(self, ftos(pteam2.frags));
   stuffcmd(self, "\n");
   
   if (store_obs.cnt == 2) {
      sprint(self, 2.000, "\n\n");
      sprint(self, 2.000,  " Team Scores:\n Team1:   ");
      st =  ftos(pteam1.frags);
      sprint2(self, 2.000,  st, "     Team2:   ");
      st =  ftos(pteam2.frags);
      sprint2(self, 2.000,  st, "\n");

   
   } else {
      sprint(self, 2.000, "\n\n");
      sprint(self, 2.000,  " Team Scores:\n Team1:   ");
      st =  ftos(pteam1.frags);
      sprint2(self, 2.000,  st, "     Team2:   ");
      st =  ftos(pteam2.frags);
      sprint2(self, 2.000,  st, "\n Team3:   ");
      st =  ftos(pteam3.frags);
      sprint2(self, 2.000,  st, "     Team4:   ");
      st =  ftos(pteam4.frags);
      sprint2(self, 2.000,  st, "\n");

  }

  if ((modetype & 1) && (!cb_prematch)) { 

      st = infokey (world, "status");
      sprint(self, 2.000,  "\n Time: ");
      sprint(self, 2.000,   st );
      sprint(self, 2.000,  "\n");
  }

      

  sprint(self, 2.000, "\n\n");


};


void(entity print) ShowFrags =
{
   local entity te;
   local float eff;
   local string st, sp;


   sprint(print, 2.000, "\n\n");
   sprint(print, 2.000, " Frags  TK's  Deaths  Eff  Name\n");
   sprint(print, 2.000, "\n");


   te = player_head;

   while (te)
   {

      if (te.real_frags <= 0.000) {
         eff = 0.000;
      } else {
         eff = (te.real_frags / (te.real_frags + te.deaths)) * 100;
         eff = rint(eff);

      }

      st = ftos(te.real_frags );
      sp = spacefornum(te.real_frags, 4);
      sprint3(print, 2.000, "  ", st, sp);

      st = ftos(te.teamkills );
      sp = spacefornum(te.teamkills, 3);
      sprint3(print, 2.000, "  ", st, sp);

      st = ftos(te.deaths );
      sp = spacefornum(te.deaths, 5);
      sprint3(print, 2.000, "  ", st, sp);

      st = ftos(eff);
      sp = spacefornum(eff, 3);
      sprint3(print, 2.000, "  ", st, sp);
/*
      st = ftos(te.real_frags);
      if ( te.real_frags < 10)
      {
         sprint3(print, 2.000, "  ", st, "     ");
      }
      else if (te.real_frags < 100)
      {
         sprint3(print, 2.000, "  ", st, "    ");
      }
      else 
      {
         sprint3(print, 2.000, "  ", st, "   ");
      }
      st =  ftos(te.teamkills);
      
      if ( te.teamkills < 10)
      {
         sprint2(print, 2.000,  st, "      ");
      }
      else if (te.teamkills < 100)
      {
         sprint2(print, 2.000,  st, "     ");
      }
      else 
      {
         sprint2(print, 2.000,  st, "    ");
      }

      st =  ftos(te.deaths);

      if (te.deaths < 10)
      {
         sprint2(print, 2.000,  st, "      ");
      }
      else if ( te.deaths < 100)
      {
         sprint2(print, 2.000,  st, "     ");
      }
      else 
      {
         sprint2(print, 2.000,  st, "    ");
      }

      st =  ftos(eff);

      if (eff < 10)
      {

         sprint2(print, 2.000,  st, "     ");

      }
      else if ( eff < 100)
      {
         sprint2(print, 2.000,  st, "    ");
      }
      else 
      {
         sprint2(print, 2.000,  st, "   ");
      }*/

      sprint2(print, 2.000,  te.netname , "\n");


      te = te.nextp;
   }

   if (store_obs.cnt == 2) {
      sprint(print, 2.000, "\n\n");
      sprint(print, 2.000,  " Team Scores:\n Team1:   ");
      st =  ftos(pteam1.frags);
      sprint2(print, 2.000,  st, "     Team2:   ");
      st =  ftos(pteam2.frags);
      sprint2(print, 2.000,  st, "\n");

   
   } else {
      sprint(print, 2.000, "\n\n");
      sprint(print, 2.000,  " Team Scores:\n Team1:   ");
      st =  ftos(pteam1.frags);
      sprint2(print, 2.000,  st, "     Team2:   ");
      st =  ftos(pteam2.frags);
      sprint2(print, 2.000,  st, "\n Team3:   ");
      st =  ftos(pteam3.frags);
      sprint2(print, 2.000,  st, "     Team4:   ");
      st =  ftos(pteam4.frags);
      sprint2(print, 2.000,  st, "\n");

  }
  sprint(print, 2.000, "\n\n");


};



void() ShowTouches =
{
   local entity te;
   local string st, sp;

   sprint(self, 2.000, "\n Flag running:\n");
   sprint(self, 2.000, "\n");
   sprint(self, 2.000, " Touched  Captured  Dropped  Name\n");
   sprint(self, 2.000, "\n");


   te = player_head;

   while (te)
   {

      if (te.flag_touches ) {


      st = ftos(te.flag_touches );
      sp = spacefornum(te.flag_touches, 6);
      sprint3(self, 2.000, "  ", st, sp);

      st = ftos(te.flag_captures );
      sp = spacefornum(te.flag_captures, 7);
      sprint3(self, 2.000, "  ", st, sp);

      st = ftos(te.flag_fumbles );
      sp = spacefornum(te.flag_fumbles, 7);
      sprint3(self, 2.000, "  ", st, sp);

      /*
      if ( te.flag_touches  < 10)
      {
         sprint3(self, 2.000, "  ", st, "       ");
      }
      else if (te.flag_touches < 100)
      {
         sprint3(self, 2.000, "  ", st, "      ");
      }
      else 
      {
         sprint3(self, 2.000, "  ", st, "     ");
      }

      st =  ftos(te.flag_captures);
      
      if ( te.flag_captures < 10)
      {
         sprint2(self, 2.000,  st, "         ");
      }
      else if (te.flag_captures < 100)
      {
         sprint2(self, 2.000,  st, "        ");
      }
      else 
      {
         sprint2(self, 2.000,  st, "       ");
      }

      st =  ftos(te.flag_fumbles);

      if (te.flag_fumbles < 10)
      {
         sprint2(self, 2.000,  st, "         ");
      }
      else if ( te.flag_fumbles < 100)
      {
         sprint2(self, 2.000,  st, "        ");
      }
      else 
      {
         sprint2(self, 2.000,  st, "       ");
      }

*/
      sprint2(self, 2.000,  te.netname , "\n");
      }

      te = te.nextp;
      
   }

   if (store_obs.cnt == 2) {
      sprint(self, 2.000, "\n\n");
      sprint(self, 2.000,  " Team Scores:\n Team1:   ");
      st =  ftos(pteam1.frags);
      sprint2(self, 2.000,  st, "     Team2:   ");
      st =  ftos(pteam2.frags);
      sprint2(self, 2.000,  st, "\n");

   
   } else {
      sprint(self, 2.000, "\n\n");
      sprint(self, 2.000,  " Team Scores:\n Team1:   ");
      st =  ftos(pteam1.frags);
      sprint2(self, 2.000,  st, "     Team2:   ");
      st =  ftos(pteam2.frags);
      sprint2(self, 2.000,  st, "\n Team3:   ");
      st =  ftos(pteam3.frags);
      sprint2(self, 2.000,  st, "     Team4:   ");
      st =  ftos(pteam4.frags);
      sprint2(self, 2.000,  st, "\n");

  }
  sprint(self, 2.000, "\n\n");

};



void() ShowFps =
{
   local entity te;
   local float r;
   local float fps;
   local string st;

   sprint(self, 2.000, "\n\n");
   sprint(self, 2.000, " Fps    Speed       Name\n");
   sprint(self, 2.000, "\n");


   te = player_head;

   while (te)
   {
	
      fps = rint( 1000 / ( te.fAverageFrameTime / te.fFrameCount * 1000 ) );
	st = ftos( fps );
      sprint3(self, 2.000, " ", st, "     ");
      r = fabs(te.fAverageFrameTime * 100 / (time - te.real_time));
	st = ftos(r);
      sprint2(self, 2.000,  st, "%       ");
      sprint2(self, 2.000,  te.netname , "\n");


      te = te.nextp;
   }
   sprint(self, 2.000, "\n\n");



};

void () ShowSpeed = {

   local float dist;
   local string st;

   if (self.speed)
   {
      st = ftos(rint(self.speed));
      sprint3(self, 2.000, " Current Speed:  ", st,"\n");
   }

   if (self.a_speed)
   {
      /*  ends up all 3.69 / 0.36 which is 10.25
          no need to waste calculation if its always
          speed / 10.25
      dist = (self.speed / 36.9 ) / 1000;
      dist = dist * 3600;
      */
      dist = self.speed / 10.25;
      st = ftos(rint(dist));
      sprint3(self, 2.000, " Metric Speed:   ", st," km/h\n");
  }

};


void() ShowStats =
{
   local string st;
   local float eff;

   sprint(self, 2.000, "\n\n");
   sprint3(self, 2.000, " ", self.netname, "'s Statistics\n");
   sprint(self, 2.000, "\n");



   if (self.enemy) 
   
   sprint3(self, 2.000, " Last enemy: ", self.enemy.netname,"\n");

   st = ftos(self.real_frags);
   sprint3(self, 2.000, " Frags:      ", st,"\n");

   st = ftos(self.deaths);
   sprint3(self, 2.000, " Deaths:     ", st,"\n");

   st = ftos(self.teamkills);
   sprint3(self, 2.000, " Teamkills:  ", st,"\n");

   if (self.real_frags <= 0.000) {
      eff = 0.000;
   } else {
      eff = (self.real_frags / (self.real_frags + self.deaths)) * 100;
      eff = rint(eff);
   }

   st = ftos(eff);
   sprint3(self, 2.000, " Efficiency: ", st,"\n\n");


   st = ftos(rint(self.dmg_inflicted));
   sprint3(self, 2.000, " Damage given:  ", st,"\n");

   st = ftos(rint(self.dmg_recieved));
   sprint3(self, 2.000, " Damage taken:  ", st,"\n");

   st = ftos(rint(self.dmg_self));
   sprint3(self, 2.000, " Damage self:   ", st,"\n");

   st = ftos(rint(self.dmg_team));
   sprint3(self, 2.000, " Damage team:   ", st,"\n\n");

   st = ftos(self.flag_touches);
   sprint3(self, 2.000, " Touches:    ", st,"\n");

   st = ftos(self.flag_captures);
   sprint3(self, 2.000, " Captures:   ", st,"\n");

   st = ftos(self.flag_fumbles);
   sprint3(self, 2.000, " Fumbles:    ", st,"\n\n");


   if (self.a_speed) {
      eff = (self.a_speed / self.cnt);
      st = ftos(rint(eff));
      sprint3(self, 2.000, " Average Speed:       ", st,"\n");
   

      if (self.a_gspeed) {
         eff = (self.a_gspeed / self.g_count);
         st = ftos(rint(eff));
         sprint3(self, 2.000, " Average Groundspeed: ", st,"\n");


         eff = ((self.a_speed - self.a_gspeed) / (self.cnt - self.g_count));
         st = ftos(rint(eff));
         sprint3(self, 2.000, " Average Airspeed:    ", st,"\n");
      }

      eff = (self.a_speed / (81.63 * 72));  // assume * 72 fps 
      st = ftos(rint(eff));
      sprint3(self, 2.000, " Distance Travelled:  ", st," metres\n");
   }
   sprint(self, 2.000, "\n\n");


};

void() ModStatus =
{
	local string tmp;
      local float f1;

	tmp = ftos(teamplay);
	sprint3(self, 2, "Τεανπμαω        ", tmp, "\n");
	tmp = ftos((timelimit/60));
	sprint3(self, 2, "Τινεμινιτ       ", tmp, "  ");
	if(timelimit < 10) sprint(self, 2, " ");
	tmp = ftos(fraglimit);
	sprint3(self, 2, "\nΖςαημινιτ       ", tmp, "\n");


      if ( (modetype & 1 )) {
	   sprint(self, 2, "Clan Mode       on\n");
	} else {
	   sprint(self, 2, "Clan Mode       off\n");
	}

      tmp = infokey (world,"overtime");
      if ( stof (tmp)) {
	   sprint3(self, 2, "Overtime        ", tmp, "\n");
	} else {
	   sprint(self, 2, "Overtime        off\n");
	}

      tmp = infokey (world,"teamfrags");
      if ( (tmp == "on") ) {
	   sprint3(self, 2, "Teamfrags       ", tmp, "\n");
      } else {
	   sprint(self, 2, "Teamfrags       off\n");
	}

      tmp = infokey (world,"fullteamscore");
      if ( (tmp == "on") ) {
	   sprint3(self, 2, "Full Team Score ", tmp, "\n");
      } else {
	   sprint(self, 2, "Full Team Score off\n");
	}

	tmp = ftos(gspeed);
	sprint3(self, 2, "Ground speed    ", tmp, "\n");

/*
      if ( tfvsdm ) {
	   sprint(self, 2, "ΤΖφσΔΝ:         on\n");
      } else {
         sprint(self, 2, "ΤΖφσΔΝ:         off\n");
      }
*/

      if ( modetype & 4 ) {
	   sprint(self, 2, "TFStrike:       on\n");
      } else {
         sprint(self, 2, "TFStrike:       off\n");
      }

      if (allow_grenpack) {
	   sprint(self, 2, "Gren Backpacks: on\n");
      }

      if ( (pipedelay)) {
	   sprint(self, 2, "Pipebomb Delay: on\n");
	} else {
	   sprint(self, 2, "Pipebomb Delay: off\n");
	}

      tmp = infokey (world,"gibs");
      if ( (tmp == "off") ) {
	   sprint3(self, 2, "Player Gibs     ", tmp, " \n");
      }

      if (allow_hook) {
	   sprint(self, 2, "Grapple:        on\n");
      } else {
	   sprint(self, 2, "Grapple:        off\n");
	}


      if (!sentry_fire) {
	   sprint(self, 2, "Sentry Fire: Normal\n");
      }
      else if (sentry_fire == 1) {
	   sprint(self, 2, "Sentry Fire: Lightning\n");
      }
      else if (sentry_fire == 2) {
	   sprint(self, 2, "Sentry Fire: Laser\n");
      }


      tmp = infokey (world,"highlander");
      if ( (tmp == "on") ) {
	   sprint(self, 2, "Highlander mode on\n");
      } 

      if (modetype & 32) {
	   sprint(self, 2, "Duel mode:      on\n");
      }

      if (modetype & 16) {
	   sprint(self, 2, "Speed capture:  on\n");
      }

      if (modetype & 2) {
	   sprint(self, 2, "Practice:       on\n");
      }

      if (rounds < 0)
      {
	   sprint(self, 2, "Rounds:         on\n");
      }
      else if (rounds > 1)
      {
         tmp = ftos(rounds);
	   sprint3(self, 2, "Rounds:        ", tmp ,"\n");
      }

	f1 = stof(infokey(world, "fpd"));
	if(f1 & 256) {
	   sprint(self, 2, "ζυμμβςιηθτ σλιξσ disabled\n");
	} else {
	   sprint(self, 2, "ζυμμβςιηθτ σλιξσ enabled\n");
	}

	f1 = stof(infokey(world, "fpd"));
	if(f1 & 128) {
         sprint(self, 2, "ποιξτιξη disabled\n");
	} else {
	   sprint(self, 2, "ποιξτιξη enabled\n");
	}

	if(elect) {
		tmp = ftos(elect);
		sprint3(self, 2, "\nElection in progress\n", tmp, "‘ votes received\n");
	}

}; 

void(float t) TimeDown =
{
	local string tmp;
	local float lowest;
	local float tl;


      lowest = 0.000;
	tl = (timelimit / 60) - t;
	
	if (tl < 1.000) {
	   tl = lowest;

	}
  
	tmp = ftos(tl);
	bprint(2, " ");
	bprint3(2, "Νατγθ μεξητθ σετ το ", tmp, " νιξυτεσ\n");

	timelimit = (tl * 60);
        cvar_set("timelimit", tmp);
};

void(float t) TimeUp =
{
	local string tmp;
	local float highest;
      local float tl;
	

      highest = 70.000;

	tl = (timelimit / 60) + t;
	if (tl > highest) {
           tl = highest;
	}

	tmp = ftos(tl);
        
	bprint(2, " ");
	bprint3(2, "Νατγθ μεξητθ σετ το ", tmp, " νιξυτεσ\n");

	timelimit = (tl * 60);
        cvar_set("timelimit", tmp);
};


void(float t, string option) MiscTimeDown =
{
	local string tmp;
	local float lowest;
	local float ml;

	lowest = 0.000;
        
      tmp = infokey (world, option);

	ml = stof(tmp) - t;

	if(ml < lowest) ml = lowest;
	tmp = ftos(ml);
   
	bprint(2, " ");
      if (option == "cft")
      {
	   bprint3(2, "Ceasefire time σετ το ", tmp, " νιξυτεσ\n");
      }
      else 
      {
         bprint4(2, option, " μεξητθ σετ το ", tmp, " νιξυτεσ\n");
      }
	localcmd("localinfo ");
	localcmd(option);
	localcmd(" ");
	localcmd(tmp);
      localcmd("\n");

};



void(float t, string option) MiscTimeUp =
{
	local string tmp;
	local float highest;
	local float ml;

	highest = 15.000;
        
      tmp = infokey (world, option);

	ml = stof(tmp);

      ml = ml + t;

      if (ml > highest) {

	   ml = highest;

	}
	tmp = ftos(ml);

	bprint(2, " ");
      if (option == "cft")
      {
	   bprint3(2, "Ceasefire time σετ το ", tmp, " νιξυτεσ\n");
      }
      else 
      {
         bprint4(2, option, " μεξητθ σετ το ", tmp, " νιξυτεσ\n");
      }
	localcmd("localinfo ");
	localcmd(option);
	localcmd(" ");
	localcmd(tmp);
      localcmd("\n");
};

void (float add) FragLimit =
{
	local string tmp;

	fraglimit = fraglimit + add;
	if(fraglimit < 0) fraglimit = 0;
	tmp = ftos(fraglimit);
	bprint(2, " ");
	bprint3(2, "Ζςαημινιτ σετ το ", tmp, "\n");
	cvar_set("fraglimit", tmp);
};

void() ChangeTP =
{
	local string tmp;
	local string desc;


	if (teamplay ==  1.000) {

         teamplay = 11.000;
	   tmp = "11?TeamFortress";
	   desc = "Team-members inflict half damamge.\n";

      } else {

         if (teamplay ==  11.000) {

            teamplay = 13.000;
		tmp = "13?TeamFortress";
	      desc = "Team-members take half damage from area effects, No damage from direct fire.\n";

         } else {

            if (teamplay == 13.000) {

               teamplay = 19.000;
 		   tmp = "19?TeamFortress";
	         desc = "Team-members take half damage from direct fire.\n";

            } else {

               if (teamplay == 19.000) {

                  teamplay = 21.000;
 		      tmp = "21?TeamFortress";
	            desc = "Team-members inflicts armor damage only.\n";

               } else {

                  if (teamplay == 21.000) {

                     teamplay = 641.000;
		         tmp = "641?TeamFortress";
		         desc = "Team-members inflict half damage to armor.\n";

                  } else {

                     if (teamplay == 641.000) {

                        teamplay = 1301.000;
		            tmp = "1301?TeamFortress";
		            desc = "Team-members inflict no damage.\n";

                     } else {

                        teamplay = 1.000;
		            tmp = "1?TeamFortress";
	   			desc = "Teamplay On\n";
		         } 
		      }
               }
            }
         }
      }

      cvar_set("teamplay", tmp);
	bprint3(2.000, " Teamplay set to: ", ftos(teamplay), " - ");
	bprint(2.000,  desc);

	
};


void() RestartMap =
{

	localcmd("map ");
	localcmd(mapname);
	localcmd("\n");

};


void() ToggleSpecTalk =
{
	local float tmp, tmp2;
	local string s1;


	tmp2 = stof(infokey(world, "fpd"));

	tmp2 = tmp2 - (tmp2 & 64);

	
	tmp = stof(infokey(world, "spectalk"));
	bprint(2, " Spectalk ");
	if(tmp != 0) {
		localcmd("sv_spectalk 0\nserverinfo fpd ");
		tmp2 = tmp2 + 64;
		s1 = ftos(tmp2);
		localcmd(s1);
		localcmd("\nlocalinfo spectalk 0\n");
		bprint(2, "off: πμαωεςσ γαξ ξο μοξηες θεας σπεγτατοςσ\n");
		return;
	}
	localcmd("sv_spectalk 1\nserverinfo fpd ");
	s1 = ftos(tmp2);
	localcmd(s1);
	localcmd("\nlocalinfo spectalk 1\n");
	bprint(2, "on: πμαωεςσ γαξ ξοχ θεας σπεγτατοςσ\n");
	return;

};


void() GroundSpeed =
{
	local string desc;
        
	if (gspeed == 0.000)
      {
         gspeed = 1.000;
	   desc = "Maximum Ground Speed set to maximum Class Speed.";
      }
      else if (gspeed ==  1.000)
      {
         gspeed = 1.250;
         desc = "Maximum Ground Speed set to 1.25 times the maximum Class Speed.";
      }
      else if (gspeed ==  1.250)
      {
         gspeed = 1.500;
	   desc = "Maximum Ground Speed set to 1.5 times the maximum Class Speed.";
      }
      else if (gspeed ==  1.500)
      {
         gspeed = 1.750;
	   desc = "Maximum Ground Speed set to 1.75 times the maximum Class Speed.";
      }
      else if (gspeed ==  1.750)
      {
         gspeed = 2.000;
	   desc = "Maximum Ground Speed set to 2 times the maximum Class Speed.";
      }
      else 
      {
          gspeed = 0.000;
	    desc = "Ground Speed Normal.";
      }

	bprint3(2.000, " ",  desc,"\n");
	localcmd("localinfo pm_gspeed ");
	localcmd(ftos(gspeed));
	localcmd("\n");
	
};


void() ToggleFreeze = {

	bprint(2, " ");

	if (( freeze == 0 )) {

	   freeze = 1;
	   localcmd("localinfo freeze on\n");
	   bprint2(2, self.netname, " freezes map\n");

	} else {

	   freeze = 0;
	   localcmd("localinfo freeze off\n");
	   bprint2(2, self.netname, " unfreezes map\n");

	}
};

void (string option) Toggle_Misc = {

   local string st;

      st = infokey (world, option);

      if ( (st == "on") ) {

         st = "off";

      } else {
	   st = "on";

	}

	localcmd("localinfo ");
	localcmd(option);
	localcmd(" ");
	localcmd(st);
	localcmd("\n");

	bprint(2, " ");
	bprint4(2, option, " set to ", st, " \n");

};

/*
void() ClanMode = 
	   localcmd("localinfo clan on\n");
	   bprint(2, "Map Restart needed to take affect!\n")

void() Toggle_TFvsDM = 

	bprint3(2, "TFvsDM Mode set to ", st, "\n"

void() Toggle_SpeedCap 
	bprint3(2, "Speed Capture Mode set to ", st, "\n");

void() Toggle_Practice = 
	bprint3(2, "Practice Mode set to ", st, "\n");

void() Toggle_TFStrike = 
	bprint3(2, "TFStrike Mode set to ", st, "\n");

void() Toggle_Duel = 
	bprint3(2, "Duel Mode set to ", st, "\n");

void() Toggle_Rounds = 

void () Toggle_Teamfrags = {
	bprint3(2, "Teamfrags set to ", st, " \n");

void () Toggle_Fullts = {
	bprint3(2, "Full Team Score set to ", st, " \n");

void () Toggle_Grapple = {
	bprint3(2, "Grapple set to ", st, " \n");

void () Toggle_Gibs = {
	bprint3(2, "Gibs set to ", st, " \n");

void () Toggle_Highlander = {
	bprint3(2, "Highlander mode set to ", st, " \n");

*/
	
void() ResetSetup = {

   cvar_set("teamplay", "21?TeamFortress");
   cvar_set("timelimit", "40");

   localcmd("localinfo sentrytype 0\n");
   localcmd("localinfo pipedelay on\n");
   localcmd("localinfo tfvsdm off\n");
   localcmd("localinfo clan off\n");
   localcmd("localinfo teamfrags on\n");
   localcmd("localinfo fullteamscore off\n");
   localcmd("localinfo grapple off\n");
   localcmd("localinfo rounds off\n");
   localcmd("localinfo duel off\n");
   localcmd("localinfo speedcap off\n");

   RestartMap();

};

void () ClanSetup = {

   local float f1;

   cvar_set("teamplay", "1?TeamFortress");
   cvar_set("timelimit", "35");

   localcmd("localinfo prematch 5\n");
   localcmd("localinfo sentrytype 0\n");
   localcmd("localinfo pipedelay on\n");
   localcmd("localinfo clan on\n");
   localcmd("localinfo teamfrags on\n");
   localcmd("localinfo fullteamscore off\n");
   localcmd("localinfo grapple off\n");
   localcmd("localinfo rounds off\n");
   localcmd("localinfo duel off\n");
   localcmd("localinfo speedcap off\n");

   f1 = stof(infokey(world, "fpd"));
   if (!(f1 & 256)) { 
      localcmd("serverinfo fpd ");
      f1 = (f1 | 256);
      localcmd(ftos(f1));
      localcmd("\n");
   }
   localcmd("serverinfo fbskins 0\n");
   localcmd("localinfo observermode off\n");
 

   RestartMap();

};

void() Toggle_Quad = 
{

   cvar_set("teamplay", "1?TeamFortress");
   cvar_set("timelimit", "10");

   localcmd("localinfo prematch 3\n");
   localcmd("localinfo clan on\n");
   localcmd("localinfo teamfrags on\n");
   localcmd("localinfo fullteamscore off\n");
   localcmd("localinfo duel off\n");
   localcmd("localinfo speedcap off\n");
  // localcmd("localinfo cr_soldier 1\n");
   localcmd("localinfo quadmode on\n");


   RestartMap();
};


/*
void() Toggle_Observer = {

   local string st;

	if (( !allow_ttrack )) {

	   allow_ttrack = 1;
         st = "on";
	   localcmd("localinfo obs_teamtrack on\n");


	} else {

	   allow_ttrack = 0;
         st = "off";
	   localcmd("localinfo obs_teamtrack off\n");

	}

	bprint(2, " ");
	bprint3(2, "Observer Team-Only Tracking set to ", st, " \n");
};
*/

void() TogglePointing =
{
	local float f1, f2;
	local string s1;

	bprint(2, " ");
	f1 = stof(infokey(world, "fpd"));
	f2 = f1 - (f1 & 128);
	if(f1 & 128) {
		localcmd("serverinfo fpd ");
		s1 = ftos(f2);
		localcmd(s1);
		localcmd("\n");
		bprint(2, "ποιξτιξη enabled\n");
		return;
	} else {
		localcmd("serverinfo fpd ");
		f2 = f2 + 128;
		s1 = ftos(f2);
		localcmd(s1);
		localcmd("\n");
		bprint(2, "ποιξτιξη disabled\n");
	}
};

void() ToggleEnemy =
{
	local float f1, f2;
	local string s1;

	bprint(2, " ");
	f1 = stof(infokey(world, "fpd"));
	f2 = f1 - (f1 & 32);
	if(f1 & 32) {
		localcmd("serverinfo fpd ");
		s1 = ftos(f2);
		localcmd(s1);
		localcmd("\n");
		bprint(2, "enemy reporting allowed\n");
		return;
	} else {
		localcmd("serverinfo fpd ");
		f2 = f2 + 32;
		s1 = ftos(f2);
		localcmd(s1);

		localcmd("\n");
		bprint(2, "enemy reporting disallowed\n");
	}
};

void() ToggleFbskins =
{
	local float f1, f2;
	local string s1;

	bprint(2, " ");
	f1 = stof(infokey(world, "fpd"));
	f2 = f1 - (f1 & 256);
	if(f1 & 256) {
		localcmd("serverinfo fpd ");
		s1 = ftos(f2);
		localcmd(s1);
		localcmd("\n");
            localcmd("serverinfo fbskins 1\n");
		bprint(2, "Fullbright skins enabled\n");
		return;
	} else {
		localcmd("serverinfo fpd ");
		f2 = f2 + 256;
		s1 = ftos(f2);
		localcmd(s1);
		localcmd("\n");
            localcmd("serverinfo fbskins 0\n");
		bprint(2, "Fullbright skins disabled\n");


	}
};



void() Toggle_Frj =
{
	local float f1, f2;
	local string s1;

	bprint(2, " ");
	f1 = stof(infokey(world, "fpd"));
	f2 = f1 - (f1 & 32768);
	if(f1 & 32768) {
		localcmd("serverinfo fpd ");
		s1 = ftos(f2);
		localcmd(s1);
		localcmd("\n");
		bprint(2, "Forward Rocketjump enabled\n");
		return;
	} else {
		localcmd("serverinfo fpd ");
		f2 = f2 + 32768;
		s1 = ftos(f2);
		localcmd(s1);
		localcmd("\n");
		bprint(2, "Forward Rocketjump disabled\n");
	}
};

void () Toggle_flag_emu = {

local string st;
local float fl;

      fl = stof(infokey (world,"flag_model"));

      if (fl == 0.000)
      {
         fl = 1.000;
	   st = "TF Flag.";
      }
      else if (fl == 1.000)
      {
         fl = 2.000;
	   st = "TF Standard.";
      }
      else if (fl == 2.000)
      {
         fl = 3.000;
	   st = "CTF Flag.";
      }
      else 
      {
         fl = 0.000;
	   st = "Map default.";
	}


	localcmd("localinfo flag_model ");
	localcmd(ftos(fl));
	localcmd("\n");

	bprint(2, " ");
	bprint3(2, "Goal Item model set to ", st, " \n");

};


void () Toggle_Grenpacks = {


   local string st;

      st = infokey (world,"grenpacks");

	bprint(2, " ");
      if ( (st == "on") ) {

         st = "off";
         allow_grenpack = 0;
	   bprint(2, "Backpacks Normal.\n");

      } else {

         st = "on";
         allow_grenpack = 1;
	   bprint(2, "Backpacks now Include Grenades / Detpack.\n");
	}

	localcmd("localinfo grenpacks ");
	localcmd(st);
	localcmd("\n");

};

void () Toggle_SentryType = {

   local string st;

   bprint(2, " ");
   if (sgtype == 0)
   {
      sgtype = 1;
	bprint(2, "Sentries Special (Oztf).\n");

   }
   else
   {
      sgtype = 0;
	bprint(2, "Sentries Normal (TF 2.9).\n");

   }

   st = ftos(sgtype);

   localcmd("localinfo sentrytype ");
   localcmd(st);
   localcmd("\n");


};

void () Toggle_SentryFire = {

   local string st;
   local float fl;

   if (!sgtype) {
      if (self == world) {
         dprint("Sentry type is currently Normal. Change sentry type to enable firing mode.\n");
      } else {
         sprint(self, 2.000, "Sentry type is currently Normal. Change sentry type to enable firing mode.\n");
      }
      return;
   }

      st = infokey (world,"sentryfire");
      fl = stof(st);
 
      if ( (fl < 1) || (fl > 2) )
      {
         st = "Lightning";
         sentry_fire = 1.000;

      }
      else if (fl == 1) {
         st = "Laser"; 
         sentry_fire = 2.000;

      } 
      else
      { 
         st = "Normal";
         sentry_fire = 0;

	}

	localcmd("localinfo sentryfire ");
	localcmd(ftos(sentry_fire));
	localcmd("\n");

	bprint(2, " ");
	bprint3(2, "Sentry Fire set to ", st, " \n");

};

void () Toggle_PipeDelay = {

   local string st;

      st = infokey (world,"pipedelay");

      if ( (st == "off") ) {

	   st = "on";
         pipedelay = 1;

      } else {

         st = "off";
         pipedelay = 0;
	}

	localcmd("localinfo pipedelay ");
	localcmd(st);
	localcmd("\n");

	bprint(2, " ");
	bprint3(2, "Demoman Pipebomb Delay set to ", st, " \n");

};


void () Toggle_Detpack = {

      local string st;

      st = infokey (world,"soliddet");

      if ( (st == "on") ) {

         st = "off";
      } else {

	   st = "on";
	}

	localcmd("localinfo soliddet ");
	localcmd(st);
	localcmd("\n");

	bprint(2, " ");
	bprint3(2, "Solid Detpacks σετ το ", st, " \n");

};

void () Toggle_Lighting = {

   if (lights) { 
      Deluminate();
      
   } else {
      Eluminate();
   } 

};

void () Give_Quad = {

      if (!self.playerclass || self.deadflag) return;

      sound (self,2.000,"items/damage.wav",1.000,1.000);
      stuffcmd (self,"bf\n");
      self.items = (self.items | 4194304.000);
      self.super_time = 1.000;
      self.super_damage_finished = (time + 300.000);
};

void () Give_Eyes = {

      if (!self.playerclass || self.deadflag) return;

      sound (self,2.000,"items/inv1.wav",1.000,1.000);
      stuffcmd (self,"bf\n");
      self.items = (self.items | 524288.000);
      self.invisible_time = 1.000;
      self.invisible_finished = (time + 30.000);
};

void () Give_Pent = {

      if (!self.playerclass || self.deadflag) return;

      sound (self,2.000,"items/protect.wav",1.000,1.000);
      stuffcmd (self,"bf\n");
      self.items = (self.items | 1048576.000);
      self.invincible_time = 1.000;
      self.invincible_finished = (time + 300.000);

};


void() AbortMiscVote =
{
	local entity p;

	v_misc = 0;
	p = player_head;
	while(p) {
		if(p.netname != "") {
			p.mvote = 0;

		}
	   p = p.nextp;
	}

	p = find(world, classname, "miscvote");
// Kill timeout checker entity
	if(p.classname == "miscvote") dremove(p);
};

void() MiscVoteThink =
{
	bprint(2, "The voting has timed out.\nVote aborted\n");
	self.nextthink = -1;
	AbortMiscVote();
};



void () AgreeMiscVote = {

	local float f1, f2;
	local string tmp;
      local entity mv;


     if (intermission_running) return;

	if (self.classname != "player") return;

      if (self.allowvote > time)
      {
         return;
      }


      self.allowvote = time + 3.000;


	if(self.mvote) {
		bprint2(2, self.netname, " χιτθδςαχσ ");
		if(infokey(self, "gender") == "f") bprint(2, "θες ");
		else bprint(2, "θισ ");
		bprint(3, "vote\n");
		self.mvote = 0;
		v_misc = v_misc - 1;
		return;
	}


      self.mvote = 1;

	v_misc = v_misc + 1;

	f1 = TeamFortress_GetNoPlayers ();
	f2 = (floor(f1 / 2)) + 1;
	if(v_misc >= f2)
      {

	    mv = find(world, classname, "miscvote");

	    if (mv.classname == "miscvote") 
          {
             if (mv.weapon == 1.000) {

                localcmd("map ");
                localcmd(mv.netname);
                localcmd("\n");
             }
             else if (mv.weapon == 2.000) 
             {
                 Toggle_Misc(mv.netname);
             }

             AbortMiscVote();
	       return;
          }

	}

	if ( v_misc != 0.000 ) {
		f1 = f2 - v_misc;
		tmp = ftos(f1);
		bprint3(2, "", tmp, "‘ more vote");
		if(f1 > 1) bprint(2, "s");
		bprint(2, " needed\n");
	}

};


void (string Misc, float type) PlayerMiscVote =
{
	local float f1, f2;
      local string st, tmp;
      local entity miscvote;

      if (intermission_running) return;

	if (self.classname != "player")
         return;

	if ((modetype & 1) && (!cb_prematch))
	   return;

	if(v_misc) {
     
         sprint(self, 2.000, "Vote currently active. You cannot vote at this time.\n");
         return;
      }

      tmp = infokey (world,"votetime");

      f1 = (stof(tmp) * 60);

      if (f1 > time) {
         sprint(self, 2.000, "You cannot vote at this time.\n");
         return;
      }


	if(self.mvote == 2.000) {
		bprint2(2, self.netname, " χιτθδςαχσ ");
		if(infokey(self, "gender") == "f") bprint(2, "θες ");
		else bprint(2, "θισ ");
		bprint(3, "vote\n");
		self.mvote = 0;
		v_misc = v_misc - 1;
            AbortMiscVote ();
		return;
	}


	if (Misc != string_null) {
         bprint(2, self.netname);
         if (type == 1)   bprint(3, " votes for map ");
         else if (type == 2)  bprint(3, " votes for mode ");
         else if (type == 3)  bprint(3, " votes for setting ");
         bprint2(2, Misc, "\n");


	   miscvote = spawn();
         miscvote.owner = world;
	   miscvote.classname = "miscvote";
	   miscvote.think = MiscVoteThink;
         miscvote.weapon = type;

         tmp = infokey (world,"vote_timeout");
         f1 = stof(tmp);
         if ((f1 > 10) && (f1 < 120))
         {
	      miscvote.nextthink = time + f1;
         }
         else
         {
            miscvote.nextthink = time + 30;
         }
      }


      if (type == 1)
      {
         st = strstr (Misc, ".bsp");

         if (st != string_null)
         {
            f1 = strlen (Misc);
            tmp = substr(Misc , 0 , f1 - 4);
         }
      }
      miscvote.netname = Misc;

      self.mvote = 2;
	v_misc = v_misc + 1;

	f1 = TeamFortress_GetNoPlayers ();
	f2 = (floor(f1 / 2)) + 1;
	if(v_misc >= f2) {

          if (type == 1.000) 
          {
             localcmd("map ");
             localcmd(Misc);
             localcmd("\n");
          }
          else if (type == 2.000) 
          {
              Toggle_Misc(Misc);
          }
          v_misc = 0.000;
          self.mvote = 0.000;
          dremove (miscvote);
          return;
	}
	sprint(self, 2, "Type cmd abort, to abort vote\n");

	if ( v_misc != 0.000 ) {
		f1 = f2 - v_misc;
		st = ftos(f1);
		bprint3(2, "", tmp, "‘ more vote");
		if(f1 > 1) bprint(2, "s");
		bprint(2, " needed\n");
	}

};



void () RandomPickup =
{
	local entity te;
	local float fl;
	local float fl2;
	local float fl3;
	local float fl4;
	local float fl5;
	local float fl6;
	local float fl7;


	if (!cb_prematch)
	{
		return;
	}
	if (!teamplay)
	{
		sprint (self, 2.000000, "Teamplay is not set.\n");
		return;
	}

      if (store_obs.cnt != 2.000) {

		sprint (self, 2.000000, "This command can only be used with 2 teams.\n");
		return;
	}

	fl2 = 1.000000;
	fl3 = 0.000000;
	fl4 = 0.000000;

	fl = TeamFortress_GetNoPlayers  ();

	if ((fl < 3.000000))
	{
		sprint (self, 2.000000, "You need at least 3 players to do this\n");
		return;
	}

	fl3 = fl / 2.000000;
	te = player_head;
	while (te)
	{
		if ((te.netname != ""))
		{
			//stuffcmd (te, "color 0\nteam \"\"\n");
			fl5 = random ();
			fl5 = random ();

			if ((fl6 >= fl3))
			{
				te.pteam = pteam2;
			}
			else
			{
				if ((fl7 >= fl3))
				{
			      	te.pteam = pteam1;
				}
				else
				{
					if ((fl5 < 0.500000))
					{
						fl6 =  fl6 + 1.000;
						te.pteam = pteam1;
					}
					else
					{
						fl7 = fl7 + 1.000;
						te.pteam = pteam2;
					}		

				}
			}
		}

            SetTeam(te);
		te = te.nextp;
	}


};



void () TogglePowerups =
{
     local string st;

	bprint (2.000000, " Ποχεςυπσ ");
	if (powerups)
	{
		bprint (2.000000, "disabled\n");
		PowerupsOff ();

            powerups = 0;
            st = "off";
	}
	else
	{
		bprint (2.000000, "enabled\n");
		PowerupsOn ();
            powerups = 1;
            st = "on";
	}

	localcmd("localinfo powerups ");
	localcmd(st);
	localcmd("\n");
};


void () ToggleSpecMsgs =
{

   local string st;

	if (!spec_msgs)
	{
         spec_msgs = 1;
         st = "on";
	}
	else
	{
         spec_msgs = 0;
         st = "off";
	}

	localcmd("localinfo spec_msgs ");
	localcmd(st);
	localcmd("\n");

	bprint(2, " ");
	bprint3(2, "Messages for spectators  σετ το ", st, " \n");

};


void (entity p) unpause_player =
{
	msg_entity = p;
	WriteByte (1.000000, 24.000000);
	WriteByte (1.000000, 0.000000);
};

void (entity p) pause_player =
{
	msg_entity = p;
	WriteByte (1.000000, 24.000000);
	WriteByte (1.000000, 1.000000);
};

void () PausePlayers =
{
	local entity te;

	te = find (world, classname, "player");
	while (te)
	{
		if ((te.netname != ""))
		{
			pause_player (te);
		}
		te = find (te, classname, "player");
	}
	te = find (world, classname, "spectator");
	while (te)
	{
		if ((te.netname != ""))
		{

			pause_player (te);

		}
		te = find (te, classname, "spectator");
	}
};
