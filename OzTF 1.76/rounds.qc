//void () respawn_hostage;

entity () CheckDuelWinner = {

   local float totalp;
   local entity Player;
   local entity winner;

   Player = player_head;

   while ( Player != world ) {


      if (Player.playerclass)
      {
         if (!Player.deadflag) 
         {
            if (Player.health > 0)
            {
               totalp = totalp + 1.000;
               winner = Player;
            }
         }
      }
      Player = Player.nextp;

   }

   if (totalp == 1.000)  {
         return(winner);
   }

   if (!totalp) {
      return(store_obs);
   }

   return(world);

};
entity () CheckWinner = {

   local float team1alive;
   local float team2alive;
   local float team3alive;
   local float team4alive;
   local float nump;
   local float totalp;
   local entity Player;

   
   if (round_winner != world) return (round_winner);

   Player = player_head;

   while ( Player != world ) {


      if (Player.pteam.team) {
         totalp = totalp + 1.000;
     
         if (Player.playerclass) 
         {
            if (!Player.deadflag)
            {
               nump = nump + 1.000;

               if (Player.pteam == pteam1) 
                 team1alive = (team1alive + 1.000);
               
               if (Player.pteam == pteam2) 
                 team2alive = (team2alive + 1.000);
            
               if (Player.pteam == pteam3) 
                team3alive = (team3alive + 1.000);
            
               if (Player.pteam == pteam4) 
                team4alive = (team4alive + 1.000);
            }
         }
      }
      Player = Player.nextp;

   }


   if ((nump > 0.000) && (totalp > 1.000))  {

      if(team1alive && !team2alive && !team3alive && !team4alive) {

         if (modetype & 4) { 
            Player = find (world,classname,"detpack");

            if (Player != world) {
               return(world);
            } 
         }
         return(pteam1);
      }

      if(!team1alive && team2alive && !team3alive && !team4alive) {
         return(pteam2);
      }

      if(!team1alive && !team2alive && team3alive && !team4alive) {
         return(pteam3);
      }

      if(!team1alive && !team2alive && !team3alive && team4alive) {
         return(pteam4);
      }

   }

   if (!nump) {

      if (modetype & 4) {
         Player = find (world,classname,"detpack");

         if (Player != world) {
            return(Player.pteam);
         } 
      }

      return(store_obs);

   }

   return(world);

};


void () RoundOver = {
   local string st;
   local float fl;

   round_over = 2;

   if (round_winner == store_obs) {
      bprint (2.000,"Round Drawn!\n");
   } else {

      if (modetype & 32) {


            if (teamplay) {

               if (round_winner.a_n == 1.000)
               {
                  round_winner.pteam = pteam1;
               }
               else if (self.a_n == 2.000)
               {
                  round_winner.pteam = pteam2;
               }

               st = infokey (round_winner,"bottomcolor");
               fl = stof (st);

                if ( (fl != round_winner.pteam.colormap) ) {

                  stuffcmd (round_winner,"color ");
                  st = ftos (round_winner.pteam.colormap);
                  stuffcmd (round_winner,st);
                  stuffcmd (round_winner,"\n");
               }

               SetTeamName (round_winner);

            }

         bprint (2.000, round_winner.netname);
         bprint (2.000," Wins the Round!\n");
          
      }
      else if (round_winner.team == 1)
      {

          if (modetype & 4) {
             sound (self,2.000,"speech/ctwin.wav",1.000,0.000);
             bprint (2.000,"Counter Terrorists WIN!\n");
             TeamFortress_TeamIncreaseScore (round_winner.team,10.000);
          } else {
             bprint (2.000,"Blue Team Wins the Round!\n");
          }
      }
      else if (round_winner.team == 2)
      {
          if (modetype & 4) {
             sound (self,2.000,"speech/terwin.wav",1.000,0.000);
             bprint (2.000,"Terrorists WIN!\n");
             TeamFortress_TeamIncreaseScore (round_winner.team,10.000);
          } else {
             bprint (2.000,"Red Team Wins the Round!\n");
          }
      }
      else if (round_winner.team == 3)
      {
          bprint (2.000,"Yellow Team Wins the Round!\n");
      }
      else if (round_winner.team == 4)
      {
          bprint (2.000,"Green Team Wins the Round!\n");
      }
   }

   if (TeamFortress_CheckDraw()) {
      if (rounds == 1) {
         rounds = rounds + 1;
      }
   }

   self.think = StartRound;
   self.nextthink = time + 0.500;

};

void () RoundThink = {

   local string tmp;
   local float fl;




   if (round_pause + 0.750 < time) {
      if (modetype & 32) {
          round_winner = CheckDuelWinner ();
      } else {
         round_winner = CheckWinner();
      }
   }

   if (round_winner != world)
   {

	self.think = RoundOver;
      self.nextthink = time + 0.1;
      return;
   }

   if ( self.cnt == -1 ) {
	return;
   }

   
   if(!TeamFortress_GetNoPlayers ()) {
 
      self.think = StartRound;
      self.nextthink = time + 3.000;
      return;
   }


   self.cnt2 = self.cnt2 - 0.5;

   if(self.cnt2 == -1) 
   {
   // Calculate every 60 seconds.
      self.cnt2 = 59.000;

	self.cnt = self.cnt - 1;
//	localcmd("serverinfo status \"");
//	tmp = ftos(self.cnt);
//	localcmd(tmp);
//	localcmd(" min left\"\n");
   }

   if(!self.cnt2) 
   {

      if ((self.cnt == 1.000) || (self.cnt == 5.000)) {

         tmp = ftos(self.cnt);
         bprint3(2, "", tmp, "‘ minute");
         if(self.cnt != 1.000) bprint(2, "s");
         bprint(2, " remaining\n");
      }


      if(!self.cnt) 
      {


         bprint (2.000,"ROUND TIME OVER\n");

         if (modetype & 4) {
            round_winner = pteam1;
         } else {
            round_winner = store_obs;
         }

	   self.think = RoundOver;
         self.nextthink = time + 0.1;

         return;

         

      } 

   }

   if ((!self.cnt) && (self.cnt2 == 30.000 || self.cnt2 == 15.000 || self.cnt2 <= 10.000)) {

      fl = ceil(self.cnt2);
      if (!(fl - self.cnt2)) {

	   tmp = ftos(self.cnt2);
	   bprint3(2, "", tmp, "‘ second");
	   if(self.cnt2 != 1.000) bprint(2, "s");
	   bprint(2, " remaining\n");

      }
   }


   self.nextthink = time + 0.500;

};



float () tfs_givebomb = {

   local float counter;
   local entity te;
   local float the_one;


      te = player_head;

      while ( te != world)
      {

         if ((te.pteam == pteam2) && (te.playerclass))
         {
            counter = counter + 1.000;
         }

         te = te.nextp;
      }

      if (counter == 1.000)
      {
         the_one = counter;
      }
      else if (counter > 1.000)
      {
         the_one = ceil (random() * counter);
      }

      return (the_one);

};

void () RoundBegin = {

   local entity te;
   local entity oldself;
   local float bomber;
   local float counter;


   te = find (world,classname,"func_breakable");

   while ( te ) {


      oldself = self;
      self = te;

      if (!(self.spawnflags & 1.000))

         self.use(); 

      te = self;
      self = oldself;
      
      te = find (te,classname,"func_breakable");
   }

/*
   te = find (world,classname,"hostage_entity");
   while ( te  ) {

	te.think = respawn_hostage;
	te.nextthink = time + 0.100;

      te = find (te,classname,"hostage_entity");
   }

*/
   te = find (world,classname,"func_bomb_target");

   if ( te != world ) {
      bomber = tfs_givebomb();
   }


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

      if (modetype & 32) {
         if (self.deadflag ) {

           PutClientInServer() ;

         } else {
            if ( (self.tfstate & 8.000) ) {
               self.tfstate = 8.000;
            } else {
               self.tfstate = 0.000;
            }
/*
         if(!self.playerclass) {
            self.playerclass = 3.000;
            PutClientInServer() ; 
         }       
	   else
         {
*/

            setmodel (self,string_null);
            modelindex_null = self.modelindex;
            setmodel (self,"progs/eyes.mdl");
            modelindex_eyes = self.modelindex;
            setmodel (self,"progs/player.mdl");
            modelindex_player = self.modelindex;

            self.takedamage = 2.000;
            self.flags = 8.000;
            self.air_finished = (time + 12.000);
            self.dmg = 2.000;
            self.super_damage_finished = 0.000;
            self.radsuit_finished = 0.000;
            self.invisible_finished = 0.000;
            self.invincible_finished = 0.000;
            self.effects = 0.000;
            self.invincible_time = 0.000;
            self.reload_shotgun = 0.000;
            self.reload_super_shotgun = 0.000;
            self.reload_grenade_launcher = 0.000;
            self.reload_rocket_launcher = 0.000;
            self.on_hook = 0.000;
            self.hook_out = 0.000;
            self.fire_held_down = 0.000;
            TeamFortress_SetEquipment ();
            TeamFortress_SetHealth ();
            TeamFortress_SetSpeed (self);
            stuffcmd (self,"v_cshift; wait; bf\n");
           // }

         }
         stuffcmd (self, "play fight.wav\n");

      } else {
         //setspawnparms (self);
         PutClientInServer ();

         if (modetype & 4) {
            if ((self.pteam == pteam2) && (self.playerclass)) {
               counter = counter + 1.000;

               if ( counter == bomber) {
                  self.ammo_detpack = 1.000;

                  stuffcmd (self,"topcolor 0\n");
                  CenterPrint( self, "You have the bomb!\n");
                  if (self.playerclass == 8.000) {
                     self.is_unabletospy = 1.000;
                  }
               }
            }
         }
      }


      self = oldself;
      te = te.nextp;

   }
   

   bprint (2.000,"ROUND BEGINS NOW\n");

   round_active = 1;
   round_over = 0;
   if (modetype & 16) self.invisible_time = time;



   if (!self.cnt) {

       self.cnt = 3.000;
	 self.cnt2 = 60.000;

   } else {
      counter = floor(self.cnt);

      if (counter < self.cnt) {
           self.cnt2 = (self.cnt - counter) * 60.000;
      } else {
         self.cnt2 = 60.000;
      }
      
      if (self.cnt2 == 60.000) {
         self.cnt = self.cnt - 1.000;
      } else {
        self.cnt = counter;
      }
   }

   self.think = RoundThink;
   self.nextthink = time + 0.100;
};

void () RoundInit = {

   local string num;
   local float fl;
   local entity p;

      fl = TeamFortress_NoTeams(); 


      if (fl < 1.000) {
         self.nextthink = time + 2.000;
         return;
      }


	self.cnt2 = self.cnt2 - 1;

	if(self.cnt2 == 2)  {
         round_over = 2;
      }

/*
	if(self.cnt2 == 1)  {

		p = find(world, classname, "player");
		while(p != world ) {
			if(p.netname != "")
                  {

				//set to ghost 1 second before matchstart
				p.takedamage = 0;
				p.solid = 0;
				p.movetype = 0;
				p.modelindex = 0;
				p.model = string_null;
			}
			p = find(p, classname, "player");
		}
	}
        else if(!self.cnt2)
        {
		self.nextthink = time + 0.1;
		self.think = RoundBegin;
	
		// Stops the bug where players are set to ghosts 1 second to go and countdown aborts.
		// standby flag needs clearing (sturm)
		p = find(world, classname, "player");
		while(p != world) 
		{
			if(p.netname != "")
			{
				p.takedamage = 2;
				p.solid = 3;
				p.movetype = 3;
			}
			p = find(p, classname, "player");
		}

		return;
	}

*/

      if(self.cnt2 == 1)
      {
	    self.nextthink = time + 1.000;
	    self.think = RoundBegin;
      }

      if (self.cnt2 <= 5) 
      { 
	   num = ftos(self.cnt2);

           p = player_head;
           while(p)
           {
              if(p.netname != "") {
                 CenterPrint3(p,"Round begins in: ",num," second(s).\n");
                 cease_fire = 0.000;
                 if (modetype & 32) {
                    if (self.cnt2 == 3)
                    {
                       stuffcmd (p, "play 3.wav\n");
                    }
                    else if (self.cnt2 == 2)
                    {
                       stuffcmd (p, "play 2.wav\n");
                    }
                    else if (self.cnt2 == 1)
                    {
                       stuffcmd (p, "play 1.wav\n");
                    }
                 } else {
                    stuffcmd (p, "play buttons/switch04.wav\n");
                 }
              }
              p = p.nextp;
           }
      }

	self.nextthink = time + 1.000;


};


void () StartRound = {

   local string st;
   local float fl;

   if (rounds == 1) {
      NextLevel();
      bprint (2.000,"Rounds Over!\n");
   }
   if (rounds > 1) {
      rounds = rounds - 1;
   }

   if ( intermission_running ) {

      return;

   }

   if  (round_active) {
   

      round_active = 0;
   }

   round_winner = world;
   round_over = 1;


   if (modetype & 32) 
   {
      fl = TeamFortress_NoActiveTeams();
      //fl = TeamFortress_NoTeams();

      if (fl < 1.000 ) {

         self.nextthink = (time + 3.000); 
         return;
      }

      if (fl == 1.000 ) {
         self.weapon = self.weapon + 1.000;
/*

         te = find (world,classname,"player");
         while ( te != world ) {
      oldself = self;
      self = te;
            if (self.a_n == 2.000) {
         if(!self.playerclass) {
            self.playerclass = 3.000;
            PutClientInServer() ; 
          }
            }
      self = oldself;
            te = find (te,classname,"player");
         }
*/
         if (self.weapon == 10.000) 
         bprint(2.000, "Waiting for challenger to join.\n");

         self.nextthink = (time + 1.000); 
         return;
      }
   } else {

      fl = TeamFortress_NoTeams();

      if (fl < 1.000 ) { 

         self.nextthink = (time + 3.000); 
         return;
      }

      if (fl == 1.000 ) { //1
         self.weapon = self.weapon + 1.000;

         if (self.weapon == 10.000) 
         bprint(2.000, "Scoring will not start until more teams join.\n");

         self.nextthink = (time + 1.000); 
         return;
      }
   }


   ResetAll();


   
   //te = find(world, classname, "round");

   st = infokey (world,"count");
   fl = stof(st);

   if (fl < 3 || fl > 20) {
      fl = 10;
   }

   self.cnt2 = fl;
   st = infokey (world,"round_time");
   self.cnt = stof(st);
   self.think = RoundInit;
   self.nextthink = time + 2.000;

};
