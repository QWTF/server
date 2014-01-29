
float () TeamFortress_TeamGetWinner;
float () TeamFortress_TeamGetSecond;
float (float tno) PTeamGetScore;
float (float tno) TeamFortress_TeamGetNoPlayers;

//void (float tno) TeamFortress_TeamSetColor;

void (float tno, float scoretoadd) TeamFortress_TeamIncreaseScore;
float (float tno) PTeamGetMaxPlayers;
string (float tno) PTeamGetColorString;
float (float tno) TeamFortress_TeamGetIllegalClasses;
string (entity p) TeamFortress_GetSkin;
float () TeamFortress_TeamPutPlayerInTeam = {

   local float i;
   local float j;
   local float k, lowscore;
   local float lowest;
   local float likely_team;

   i = 1.000;
   likely_team = (random () * store_obs.cnt);
   likely_team = ceil (likely_team);
   if ( (likely_team == 0.000) ) {

      likely_team = store_obs.cnt;

   }
   lowest = 33.000;

   while ( (i < (store_obs.cnt + 1.000)) ) {

      j = TeamFortress_TeamGetNoPlayers (i);


      if ( (j < lowest) ) {

         if ( (PTeamGetMaxPlayers (i) > j) ) {

            lowest = j;
            lowscore = PTeamGetScore (i);
            likely_team = i;
         }
      }

      if ( (j == lowest) ) {

         k = PTeamGetScore (i);

         if ( (k < lowscore) ) {

            lowscore = k;
            likely_team = i;

         }
     
      }
      i = (i + 1.000);

   }
   return ( TeamFortress_TeamSet (likely_team) );

};

float (float tno) PTeamGetColor = {


   if ( (tno == 1.000) ) {

      return ( pteam1.colormap );

   }
   else if ( (tno == 2.000) ) {

      return ( pteam2.colormap);

   }
   else if ( (tno == 3.000) ) {

      return ( pteam3.colormap );

   }
   else if ( (tno == 4.000) ) {

      return ( pteam4.colormap );

   }
   else if (!tno) 
   {
       return ( store_obs.colormap );

   }
   return ( -1.000 );

};

float (float tno) PTeamGetMaxPlayers = {


   if ( (tno == 1.000) ) {

      return ( pteam1.maxplayers);

   }
   else if ( (tno == 2.000) ) {

      return ( pteam2.maxplayers);

   }
   else if ( (tno == 3.000) ) {

      return ( pteam3.maxplayers );

   }
   else if ( (tno == 4.000) ) {

      return ( pteam4.maxplayers );

   }

   return ( 0.000 );

};

/*
string (float tno) GetTeamName = {

   local string st;

   if (self.classname == "player") {

      if (!self.playerclass) {
         return ( "observe" );
        
      }
   }

   if ( (tno == 1.000) ) {

      st = infokey (world,"team1");

      if ((st == string_null)) {

         return ( "blue" );

      }

   } else {

      if ( (tno == 2.000) ) {

         st = infokey (world,"team2");

         if ( (st == string_null) ) {

            return ( "red" );

         }

      } else {

         if ( (tno == 3.000) ) {

            st = infokey (world,"team3");

            if ( (st == string_null) ) {

               return ( "yell" );

            }

         } else {

            if ( (tno == 4.000) ) {

               st = infokey (world,"team4");

               if ( (st == string_null) ) {

                  return ( "gren" );

               }

            } else {

               st = "\"\"";

            }

         }

      }

   }
   return ( st );

};
*/

string (float tno) GetPTeamName = {

   local string st;

   if ( (tno == 1.000) )
   {
      st = pteam1.netname;
   }
   else if (tno == 2.000)
   {
      st = pteam2.netname;
   }
   else if (tno == 3.000)
   {
      st = pteam3.netname;
   }
   else if (tno == 4.000)
   {
      st = pteam4.netname;
   }
   else if (tno == 0.000)
   {
      st = store_obs.netname;
   }
   return ( st );
};

void (entity p) SetTeamName = {

   stuffcmd (p,"team ");
   stuffcmd (p, p.pteam.netname);
   stuffcmd (p,"\n");

};

void (entity p) SetTeam = {

   local string st;
   local float fl;

     st = infokey (p,"bottomcolor");
     fl = stof (st);

      if ( (fl != p.pteam.colormap) ) {

         stuffcmd (p,"color ");
         st = ftos (p.pteam.colormap);
         stuffcmd (p,st);
         stuffcmd (p,"\n");
      }

      SetTeamName (p);
};

void (entity Player) TeamFortress_TeamShowMemberClasses = {

   local entity e;
   local float found;

   found = 0.000;
   e = player_head;
   while ( e ) {

      if ( (((e.pteam == Player.pteam) || (e.pteam.team == 0.000)) && (e != Player)) ) {

         if ( (e.model != string_null) ) {

            if ( !found ) {

               found = 1.000;
               sprint (self,2.000,"The other members of your team are:\n");

            }
            sprint (Player,2.000,e.netname);
            sprint (Player,2.000," : ");
            TeamFortress_PrintClassName (Player,e.playerclass,(e.tfstate & 8.000));

         }

      }
      e = e.nextp;

   }
   if ( !found ) {

      sprint (Player,2.000,"There are no other players on your team.\n");

   }

};


float (float tno) TeamFortress_TeamSet = {

   local string st;
   local float tc;
   local entity te;

   if ( (teamplay < 1.000) ) {

      sprint (self,2.000,"Teamplay is not On, so FortressTeams are inactive.\n");
      return ( 0.000 );

   }

   if (tno > -6.000 && tno < 0.000) {


      if ( (self.pteam.team) ) {

         if (!cb_prematch)
         {
            Engineer_RemoveBuildings (self);

            te = find (world,classname,"detpack");
            while ( te ) {

               if ( (te.owner == self) ) {

                  dremove (te);
                  te = world;

               }
               te = find (te,classname,"detpack");

            }

            te = find (world,classname,"detpack_timer");
            while ( te ) {

               if ( (te.owner == self) ) {
                  dremove (te);
                  te = world;

               }
               te = find (te,classname,"detpack");

            }

            ClientKill();
         } 
     }


      bprint (2.000,self.netname);


/*

      st = strcat( "[OBS] ",self.netname);
      stuffcmd (self, "name ");
      stuffcmd (self, st);
      stuffcmd (self, "\n");
*/

      if (tno == -1.000)
      {
         self.pteam = pteam1;
         bprint (2.000," is Observering Team No. 1.\n");
      }
      else if (tno == -2.000)
      {
         self.pteam = pteam2;
         bprint (2.000," is Observering Team No. 2.\n");
      }
      else if (tno == -3.000)
      {
         self.pteam = pteam3;
         bprint (2.000," is Observering Team No. 3.\n");
      }
      else if (tno == -4.000)
      {
         self.pteam = pteam4;
         bprint (2.000," is Observering Team No. 4.\n");
      }
      else
      {
         self.pteam = store_obs;
         bprint (2.000," has joined as an Observer.\n");
      }

      SetTeamName (self);

      self.camdist = 160.000;
      self.playerclass = 0.000;
      return(1.000);

   }
   if ( ((tno > store_obs.cnt) && (store_obs.cnt != 0.000)) ) {

      sprint (self,2.000,"There can be only ");
      st = ftos (store_obs.cnt);
      sprint (self,2.000,st);
      sprint (self,2.000," teams on this map.\nTry again\n");
      return ( 0.000 );

   }

   if ( (self.pteam.team == tno) ) {

      sprint (self,2.000,"You are already in that team. Pick another.\n");
      return ( 0.000 );

   }
   if ( (self.pteam) ) {

      if ( (self.respawn_time > time) ) {

         return ( 0.000 );

      }

      if (!cb_prematch)
      {
         Engineer_RemoveBuildings (self);


         te = find (world,classname,"detpack");
         while ( te ) {

            if ( (te.owner == self) ) {

               if ( (te.weaponmode == 1.000) ) {

                  TeamFortress_SetSpeed (te.enemy);
                  dremove (te.oldenemy);
                  dremove (te.observer_list);

               }
               dremove (te);
               te = world;

            }
            te = find (te,classname,"detpack");

         }

         te = find (world,classname,"detpack_timer");
         while ( te ) {

             if ( (te.owner == self) ) {
               dremove (te);
               te = world;

            }
            te = find (te,classname,"detpack");

         }
         self.playerclass = 0.000;

         ClientKill();
      }


      if ( TeamFortress_TeamIsCivilian (tno) ) {

         self.nextpc = 11.000;
      } else {

         self.nextpc = 0.000;
      }

   }

   if (tno < 0) return (1.000);


   tc = TeamFortress_TeamGetNoPlayers (tno);
   if (tc >= PTeamGetMaxPlayers (tno) ) {

      sprint (self,2.000,"That team is full. Pick another.\n");
      return ( 0.000 );

   }


   bprint (2.000,self.netname);
   bprint (2.000," has joined Team No ");
   st = ftos (tno);
   bprint (2.000,st);
   bprint (2.000,".\n");

   //self.playerclass = 0.000;  fixme   already set?

   if (tno == 1.000)
   {
      self.pteam = pteam1;
   }
   else if (tno == 2.000)
   {
      self.pteam = pteam2;
   }
   else if (tno == 3.000)
   {
      self.pteam = pteam3;
   }
   else if (tno == 4.000)
   {
      self.pteam = pteam4;
   }


   TeamFortress_TeamShowMemberClasses (self);

   if ( ((toggleflags & 128.000) || (toggleflags & 2048.000)) ) {

      self.frags = self.pteam.real_frags;

   }

   SetTeam (self);

   return ( 1.000 );

};

   //mvdsvr
/*
void () TeamFortress_CheckTeamCheats = {

   local string st;
   local string sk;
   local float tc;



   if ( (self.immune_to_check > time) ) {

      return ;

   }

   if ( (self.netname == string_null) ) {

         stuffcmd (self,"disconnect\n");

   } else {



      if ( (((self.playerclass) && (self.pteam.team == 0.000)) && (teamplay )) ) {

            stuffcmd (self,"disconnect\n");

      }

   }



   if ( ((teamplay) && (self.pteam.team == 0.000)) ) {

      if (self.motd > 65.000) {


         st = GetTeamName (self.pteam.team);
         if ( (st != infokey (self,"team")) ) {

            SetTeamName (self);


            if ((self.immune_to_check) != floor(time)) {

               self.immune_to_check = (floor(time) + 2);

            } else {

               bprint2 (1.000,self.netname," has been kicked for changing team.\n");
               sprint (self,2.000,"You have been kicked for changing your team. Don't do it.\n");
               stuffcmd (self,"disconnect\n");
               return ;

            }

         }

         st = infokey (self,"bottomcolor");
         tc = stof (st);

         if ( (tc != (TeamFortress_TeamGetColor (self.pteam.team) - 1.000)) ) {


            stuffcmd (self,"color ");
            tc = (TeamFortress_TeamGetColor (self.pteam.team) - 1.000);
            st = ftos (tc);
            stuffcmd (self,st);
            stuffcmd (self,"\n");

            if ((self.immune_to_check) != floor(time)) {

               self.immune_to_check = (floor(time) + 2);

            }
         }
      }
   }

   if (tfstrike) {

      if ( ((self.pteam.team > 0.000) && (teamplay) && (self.playerclass) )) {

         st = infokey (self,"topcolor");
         tc = stof (st);

         if (self.ammo_detpack) {

            if ( tc ) {
               stuffcmd (self,"topcolor 0\n");

               if ((self.immune_to_check) != floor(time)) {

                  self.immune_to_check = (floor(time) + 2);

               } else {

                   bprint2 (1.000,self.netname," has been kicked for changing top color.\n");
                   sprint (self,2.000,"You have been kicked for changing your top color. Don't do it.\n");
                   stuffcmd (self,"disconnect\n");
                   return ;
               }

            }
         } else {

            if(self.pteam.team == 2.000  ) {

               if ( (self.playerclass == 8.000) && (self.undercover_team != 0.000) ) return;

               if ( (tc != (TeamFortress_GetColor (self.pteam.team) - 1.000)) ) {


                  stuffcmd (self,"topcolor ");
                  tc = (TeamFortress_GetColor (self.team_no) - 1.000);
                  st = ftos (tc);
                  stuffcmd (self,st);
                  stuffcmd (self,"\n");

                  if ((self.immune_to_check) != floor(time)) {

                     self.immune_to_check = (floor(time) + 2);

                  } else {

                      bprint2 (1.000,self.netname," has been kicked for changing top color.\n");
                      sprint (self,2.000,"You have been kicked for changing your top color. Don't do it.\n");
                      stuffcmd (self,"disconnect\n");
                      return ;
                  }

               }

            }

         }

      }

   }


   if ( ((self.team_no > 0.000) && (teamplay)) ) {

      st = infokey (self,"bottomcolor");
      tc = stof (st);
      if ( ((self.playerclass == 8.000) && (self.undercover_team != 0.000)) ) {

         if ( ((TeamFortress_GetColor (self.undercover_team) - 1.000) != tc) ) {

            stuffcmd (self,"color ");
            tc = (TeamFortress_GetColor (self.undercover_team) - 1.000);
            st = ftos (tc);
            stuffcmd (self,st);
            stuffcmd (self,"\n");

            if ((self.immune_to_check) != floor(time)) {

               self.immune_to_check = (floor(time) + 2);

            } else {

               bprint2 (1.000,self.netname," has been kicked for changing color.\n");
               sprint (self,2.000,"You have been kicked for changing your pants color. Don't do it.\n");
               stuffcmd (self,"disconnect\n");
               return ;
            }

         }

      } else {

         if ( (tc != (TeamFortress_TeamGetColor (self.team_no) - 1.000)) ) {


            stuffcmd (self,"color ");
            tc = (TeamFortress_TeamGetColor (self.team_no) - 1.000);
            st = ftos (tc);
            stuffcmd (self,st);
            stuffcmd (self,"\n");

            if ((self.immune_to_check) != floor(time)) {

               self.immune_to_check = (floor(time) + 2);

            } else {

                bprint2 (1.000,self.netname," has been kicked for changing color.\n");
                sprint (self,2.000,"You have been kicked for changing your pants color. Don't do it.\n");
                stuffcmd (self,"disconnect\n");
                return ;
            }

         }

      }
      if ( (self.playerclass) ) {

         st = infokey (self,"skin");
         tc = 0.000;
         sk = TeamFortress_GetSkin (self);
         if ( (st != sk) ) {

            TeamFortress_SetSkin (self);


            if ((self.immune_to_check) != floor(time)) {

               self.immune_to_check = (floor(time) + 2);

            } else {

               bprint2 (1.000,self.netname," has been kicked for changing skin.\n");
               sprint (self,2.000,"You have been kicked for changing your skin. Don't do it.\n");
               stuffcmd (self,"disconnect\n");
               return;
            }

         }
         if ( (tc == 8.000) ) {

            self.playerclass = 8.000;

         }

      }
      st = GetTeamName (self.team_no);
      if ( (st != infokey (self,"team")) ) {

         SetTeamName (self);


         if ((self.immune_to_check) != floor(time)) {

            self.immune_to_check = (floor(time) + 2);

         } else {

            bprint2 (1.000,self.netname," has been kicked for changing team.\n");
            sprint (self,2.000,"You have been kicked for changing your team. Don't do it.\n");
            stuffcmd (self,"disconnect\n");
            return ;

         }

      }

   }



};

*/

void (float tno, float scoretoadd) TeamFortress_TeamIncreaseScore = {

   local entity e;


   if ( ((tno == 0.000) || (scoretoadd == 0.000)) ) {

      return ;

   }
   if ( (tno == 1.000) ) {

      pteam1.frags = (pteam1.frags + scoretoadd);


   }
   if ( (tno == 2.000) ) {

      pteam2.frags = (pteam2.frags + scoretoadd);

   }
   if ( (tno == 3.000) ) {

      pteam3.frags = (pteam3.frags + scoretoadd);

   }
   if ( (tno == 4.000) ) {

      pteam4.frags = (pteam4.frags + scoretoadd);

   }
   if ( ((toggleflags & 128.000) || (toggleflags & 2048.000)) ) {

      e = player_head;
      while ( e ) {

		stuffcmd(e, "team");
		stuffcmd(e, ftos(tno));
		stuffcmd(e, "_score ");
		stuffcmd(e, ftos(scoretoadd));
		stuffcmd(e, "\n");
         	if ( (e.pteam.team == tno) ) {

            	e.frags = e.pteam.frags;


         	}
        	e = e.nextp;

      }

   }

};

float (float tno) PTeamGetScore = {

   if ( (tno == 1.000) ) {

      return ( pteam1.frags);

   }
   if ( (tno == 2.000) ) {

      return ( pteam2.frags );

   }
   if ( (tno == 3.000) ) {

      return ( pteam3.frags );

   }
   if ( (tno == 4.000) ) {

      return ( pteam4.frags );

   }
   return ( 0.000 );

};

float (float tno) PTeamGetScoreFrags = {

   if ( ((toggleflags & 128.000) || (toggleflags & 2048.000)) ) {

      PTeamGetScore (tno);

   } else {

      if ( (tno == 1.000) ) {

         return ( pteam1.real_frags );

      }
      if ( (tno == 2.000) ) {

         return ( pteam2.real_frags );

      }
      if ( (tno == 3.000) ) {

         return ( pteam3.real_frags );

      }
      if ( (tno == 4.000) ) {

         return ( pteam4.real_frags );

      }

   }
   return ( 0.000 );

};

float (float tno) TeamFortress_TeamGetNoPlayers = {

   local float size_team;
   local entity search;

   search = player_head;
   while ( (search != world) ) {

      if ( (search.pteam.team == tno) ) {

         size_team = (size_team + 1.000);

      }
      search = search.nextp;

   }
   if ( (tno == 0.000) ) {

      search = find (world,classname,"observer");
      while ( (search != world) ) {

         if ( (search.pteam.team == tno) ) {

            size_team = (size_team + 1.000);

         }
         search = find (search,classname,"observer");

      }

   }
   return ( size_team );

};

float (float tno) TeamFortress_GetNoPlayersClass = {

   local float size_team;
   local entity search;

   search = player_head;
   while ( (search != world) ) {

      if ( (search.pteam.team == tno) ) {

         if (search.playerclass && !search.deadflag) {
           size_team = (size_team + 1.000);
         }

      }
      search = search.nextp;

   }

   return ( size_team );

};

float () TeamFortress_NoActiveTeams = {

   local float no_teams;
   local float i;
   local float p;

   i = 1;
   
   while (( i <= store_obs.cnt) ) {

      p = TeamFortress_GetNoPlayersClass(i);

      if (p > 0.000){

         no_teams = no_teams + 1;

      }

      i = i + 1;
   }


   return(no_teams);

};

float () TeamFortress_NoTeams = {

   local float no_teams;
   local float i;
   local float p;

   i = 1;
   
   while (( i <= store_obs.cnt) ) {

      p = TeamFortress_TeamGetNoPlayers(i);

      if (p > 0.000){

         no_teams = no_teams + 1;

      }

      i = i + 1;
   }


   return(no_teams);

};

float () TeamFortress_GetNoPlayers = {

   local float nump;
   local entity search;

   search = player_head;
   while ( (search != world) ) {

      if ( (search.netname != string_null) ) {

         nump = (nump + 1.000);

      }
      search = search.nextp;

   }
   return ( nump );

};

float () TeamFortress_TeamGetWinner = {

   local float i;
   local float j;
   local float highest;
   local float highestteam;

   i = 1.000;
   highest = 0.000;
   highestteam = 0.000;
   while ( (i <= store_obs.cnt) ) {

      j = PTeamGetScoreFrags (i);
      if ( (j > highest) ) {

         highest = j;
         highestteam = i;

      }
      i = (i + 1.000);

   }
   return ( highestteam );

};



float () TeamFortress_TeamGetSecond = {

   local float i;
   local float j;
   local float highest;
   local float highestteam;
   local float secondteam;
   local float second;

   i = 1.000;
   highestteam = TeamFortress_TeamGetWinner ();
   highest = PTeamGetScoreFrags (highestteam);
   secondteam = 0.000;
   second = 0.000;
   while ( (i <= store_obs.cnt) ) {

      j = PTeamGetScoreFrags (i);
      if ( ((j < highest) && (j > second)) ) {

         second = j;
         secondteam = i;

      }
      i = (i + 1.000);

   }
   return ( secondteam );

};

float () TeamFortress_CheckDraw = {

   local float i;
   local float j;
   local float score;
   local float score2;
   local float result;
   local float no_teams;

   i = 1.000;
   score2 = 0.000;
   result = 0.000;
   no_teams = TeamFortress_NoActiveTeams();

   while ( (i <= no_teams ) ) {

      j = PTeamGetScore (i);

      if ( ( i > 1.000 )) {

         score2 = j;

         if (( score != score2 )) {

	      result = 0.000;

         } else {

            result = 1.000;

         }

	} else {

         score = j;
         
      }

      i = (i + 1.000);

   }


   return ( result );

};

void (float all) TeamFortress_TeamShowScores = {

   local string st;
   local float i;
   local float j;

   i = 1.000;
   if ( (all == 2.000) ) {

      while ( (i <= store_obs.cnt) ) {

         if ( (PTeamGetColor (i) > 0.000) ) {

            j = PTeamGetScore (i);
            st = PTeamGetColorString (i);
            bprint (2.000,st);
            bprint (2.000,": ");
            st = ftos (j);
            bprint (2.000,st);
            bprint (2.000," ");

         }
         i = (i + 1.000);

      }
      bprint (2.000,"\n");
      return ;

   }
   while ( (i <= store_obs.cnt) ) {

      if ( (PTeamGetColor (i) > 0.000) ) {

         if ( all ) {

            bprint (2.000,"Team ");

         } else {

            sprint (self,2.000,"Team ");

         }
         st = ftos (i);
         if ( all ) {

            bprint (2.000,st);

         } else {

            sprint (self,2.000,st);

         }
         if ( all ) {

            bprint (2.000," (");

         } else {

            sprint (self,2.000," (");

         }
         st = PTeamGetColorString (i);
         if ( all ) {

            bprint (2.000,st);

         } else {

            sprint (self,2.000,st);

         }
         if ( all ) {

            bprint (2.000,") : ");

         } else {

            sprint (self,2.000,") : ");

         }
         j = PTeamGetScore (i);
         st = ftos (j);
         if ( all ) {

            bprint (2.000,st);

         } else {

            sprint (self,2.000,st);

         }
         if ( all ) {

            bprint (2.000,"\n");

         } else {

            sprint (self,2.000,"\n");

         }

      }
      i = (i + 1.000);

   }

};
string (float tno) PTeamGetColorString = {

   local float col;

   col = PTeamGetColor (tno);
   if ( (col == 0.000) ) {

      return ( "White" );

   }
   if ( (col == 1.000) ) {

      return ( "Brown" );

   }
   if ( (col == 2.000) ) {

      return ( "Blue" );

   }
   if ( (col == 3.000) ) {

      return ( "Green" );

   }
   if ( (col == 4.000) ) {

      return ( "Red" );

   }
   if ( (col == 5.000) ) {

      return ( "Tan" );

   }
   if ( (col == 6.000) ) {

      return ( "Pink" );

   }
   if ( (col == 7.000) ) {

      return ( "Orange" );

   }
   if ( (col == 8.000) ) {

      return ( "Purple" );

   }
   if ( (col == 9.000) ) {

      return ( "DarkPurple" );

   }
   if ( (col == 10.000) ) {

      return ( "Grey" );

   }
   if ( (col == 11.000) ) {

      return ( "DarkGreen" );

   }
   if ( (col == 12.000) ) {

      return ( "Yellow" );

   }
   return ( "DarkBlue" );

};

void () TeamFortress_StatusQuery = {

   local float ft;
   local string st;

   sprint (self,2.000,"players per team: ");
   ft = TeamFortress_TeamGetNoPlayers (1.000);
   st = ftos (ft);
   sprint (self,2.000,st);
   sprint (self,2.000,"  ");
   ft = TeamFortress_TeamGetNoPlayers (2.000);
   st = ftos (ft);
   sprint (self,2.000,st);
   sprint (self,2.000,"  ");
   ft = TeamFortress_TeamGetNoPlayers (3.000);
   st = ftos (ft);
   sprint (self,2.000,st);
   sprint (self,2.000,"  ");
   ft = TeamFortress_TeamGetNoPlayers (4.000);
   st = ftos (ft);
   sprint (self,2.000,st);
   sprint (self,2.000,"\n");
   st = ftos (teamplay);
   sprint (self,2.000,"Teamplay is ");
   sprint (self,2.000,st);
   sprint (self,2.000,"\n");

};

float (float tno) TeamFortress_TeamGetIllegalClasses = {

   local entity te;

   te = find (world,classname,"info_tfdetect");
   if ( (te != world) ) {

      if ( (tno == 1.000) ) {

         return ( te.maxammo_shells );

      }
      if ( (tno == 2.000) ) {

         return ( te.maxammo_nails );

      }
      if ( (tno == 3.000) ) {

         return ( te.maxammo_rockets );

      }
      if ( (tno == 4.000) ) {

         return ( te.maxammo_cells );

      }

   }
   return ( 0.000 );

};

float (float tno) TeamFortress_TeamIsCivilian = {


   if ( (tno == 1.000) ) {

      if ( (store_obs.maxammo_shells & 1.000) ) {

         return ( 1.000 );

      }

   } else {

      if ( (tno == 2.000) ) {

         if ( (store_obs.maxammo_shells & 2.000) ) {

            return ( 1.000 );

         }

      } else {

         if ( (tno == 3.000) ) {

            if ( (store_obs.maxammo_shells & 4.000) ) {

               return ( 1.000 );

            }

         } else {

            if ( (store_obs.maxammo_shells & 8.000) ) {

               return ( 1.000 );

            }

         }

      }

   }
   return ( 0.000 );

};

float (float tno) CheckClassAvailable = {

   local float pc;

   pc = 1.000;
   
   while (pc < 10) {

      if (!ClassIsRestricted(tno,pc)) {

         return(1.000);
      }

      pc = pc + 1;
   }

   return(0.000);
};

float (float tno, float pc) ClassIsRestricted = {

   local float num;
   local float pmax;
   local entity te;
   local string st;

   if ( (tno == 0.000) ) {

      return ( 0.000 );

   }

   if ( (pc == 1.000) ) {

      st = infokey (world,"cr_scout");
      pmax = stof (st);

   } else {

      if ( (pc == 2.000) ) {

         st = infokey (world,"cr_sniper");
         pmax = stof (st);

      } else {

         if ( (pc == 3.000) ) {

            st = infokey (world,"cr_soldier");
            pmax = stof (st);

         } else {

            if ( (pc == 4.000) ) {

               st = infokey (world,"cr_demoman");
               pmax = stof (st);

            } else {

               if ( (pc == 5.000) ) {

                  st = infokey (world,"cr_medic");
                  pmax = stof (st);

               } else {

                  if ( (pc == 6.000) ) {

                     st = infokey (world,"cr_hwguy");
                     pmax = stof (st);

                  } else {

                     if ( (pc == 7.000) ) {

                        st = infokey (world,"cr_pyro");
                        pmax = stof (st);

                     } else {

                        if ( (pc == 8.000) ) {

                           st = infokey (world,"cr_spy");
                           pmax = stof (st);

                        } else {

                           if ( (pc == 9.000) ) {

                              st = infokey (world,"cr_engineer");
                              pmax = stof (st);

                           } else {

                              if ( (pc == 10.000) ) {

                                 st = infokey (world,"cr_random");
                                 pmax = stof (st);

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
   
   if (!pmax) {

      st = infokey (world,"highlander");
      if ( (st == "on") ) {
         pmax = 1.000;
      } 
   } 

   if ( (pmax == -1.000) ) {

      return ( 1.000 );

   }
   if ( (pmax > 0.000) ) {

      num = 0.000;
      te = player_head;
      while ( te ) {

         if ( (te.pteam.team == tno) ) {

            if ( (pc == 10.000) ) {

               if ( (te.tfstate & 8.000) ) {

                  num = (num + 1.000);

               }

            } else {

               if ( ((te.playerclass == pc) || (te.nextpc == pc)) ) {

                  if ( !(te.tfstate & 8.000) ) {

                     num = (num + 1.000);

                  }

               }

            }

         }
         te = te.nextp;

      }


      if ( (num >= pmax) ) {

         return ( 1.000 );

      }

   }

   return ( 0.000 );

};

void (float tno, entity ignore, string st) teamsprint = {

   local entity te;

   if ( (tno == 0.000) ) {

      return ;

   }
   te = player_head;
   while ( te ) {

      if ( ((te.pteam.team == tno) && (te != ignore)) ) {

         sprint (te,2.000,st);

      }
      te = te.nextp;

   }

};
/*
entity () TeamFortress_TopFragger = {

   local entity te;
   local float j;
   local entity highest;

   te = player_head;
   while (te != world) {

      j = te.real_frags;

      if (j > highest.real_frags){
         highest = te;
      }

      te = te.nextp;
   }

   return ( highest );

};
*/