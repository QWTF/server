
void () SpectatorDisconnect;

void () SpectatorImpulseCommand;

void () SpectatorThink;

void () SpectatorConnect = {
  
   local string st;

   self.classname = "observer";
   self.flags = 8.000;
   

   stuffcmd (self,"on_spec_connect\n");

   st = infokey (self,"em");
   if ( (st == string_null) ) {

      st = infokey (self,"exec_map");

   }
   if ( (st == "on") ) {

      stuffcmd (self,"exec spectator.cfg\n");
      stuffcmd (self,"exec ");
      stuffcmd (self,mapname);
      stuffcmd (self,".cfg\n");

   }
   self.motd = 0.000;

   st = infokey (self,"adminpwd");
   Admin_Check(st);

   if (self.is_admin) {
      self.get_admin_aliases = 1.000;
   }

   self.nexts = spec_head; 
   spec_head = self;

   if (!self.camdist) {
      self.camdist = 160.000;
   }


   CheckConnectRate(); 


};

void () SpectatorDisconnect = {

  local entity te;

  if (spec_head == self) 
      spec_head = self.nexts; 

  else 
  {
     te = spec_head; 

     while(te) 
     { 

        if (te.nexts == self) 
           te.nexts = self.nexts; 

        te = te.nexts; 

      } 

   }

};


void () SpectatorImpulseCommand = {


   if ( (self.impulse == 1.000) ) {

      self.goalentity = find (self.goalentity,classname,"info_player_deathmatch");
      if ( (self.goalentity == world) ) {

         self.goalentity = find (self.goalentity,classname,"info_player_deathmatch");

      }
      if ( (self.goalentity != world) ) {

         setorigin (self,self.goalentity.origin);
         self.angles = self.goalentity.angles;
         self.fixangle = 1.000;
         self.last_impulse = self.impulse;
      }
      self.impulse = 0.000;
      return ;

   } else {

   if ( (self.impulse == 9.000) ) {

      fadetoblack();

      self.impulse = 0.000;
      return ;

   } else {

   if ( (self.impulse == 10.000) ) {

      fadefromblack();

      self.impulse = 0.000;
      return ;

   } else {

      if ( (self.impulse == 185.000) ) {

         TeamFortress_ID ();
         self.impulse = 0.000;
         return ;

      } else {

         if ( (self.impulse == 131.000) ) {

            TeamFortress_HelpMap ();
            self.impulse = 0.000;
            return ;

         } else {

            if ( (self.impulse == 119.000) ) {

               TeamFortress_StatusQuery ();
               self.impulse = 0.000;
               return ;

            } else {

               if ( (self.impulse == 145.000) ) {

                  TeamFortress_TeamShowScores (0.000);
                  self.impulse = 0.000;
                  return ;


               } else {  

                  if ( (self.impulse == 23.000) ) {

                     if ( (ctfmap == 1) ) {

                        TeamFortress_CTF_FlagInfo ();
                     } else {

                        TeamFortress_DisplayDetectionItems ();
                     }
                     self.impulse = 0.000;
                     return;
                 }

              }

            }

         }

      }
   }
   }

}

      CommandImpulses();

      self.impulse = 0.000;


};

void () SpectatorThink = {

   Check_Track();

   if ( self.impulse ) {

      SpectatorImpulseCommand ();

   }
   if ( (self.motd <= 65.000) ) {

      TeamFortress_MOTD ();

   }
   if ( ((time > self.StatusRefreshTime) && (self.StatusBarSize != 0.000)) ) {

      RefreshStatusBar() ;

   }
   if (self.is_admin) {
      if (self.get_admin_aliases) {
         Admin_Aliases();
      }
   }
   
};
