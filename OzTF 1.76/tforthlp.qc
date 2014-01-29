

void () TeamFortress_MOTD = {

   local string ya;

   if ( (self.motd <= 20.000) ) {

      self.motd = (self.motd + 1.000);
      return ;

   }

      if ( (!self.get_aliases) ) {

         return ;

      }
   if ( (self.motd == 21.000) ) {


      if ( ((teamplay != 0.000) && (self.pteam.team == 0.000)) ) {

         stuffcmd (self,"color ");
         ya = ftos (0.000);
         stuffcmd (self,ya);
         stuffcmd (self,"\n");
         stuffcmd (self,"team observe\n");

      }
      if ( (self.get_aliases) ) {

         sprint (self,2.000,"\n\n\n");

      }

      
      sprint (self,2.000,"Oz Team Fortress v1.76\nhttp://oztf.quakeworld.nu/\n");

      self.menu_displaytime = 0.000;
      self.current_menu = 5.000;
      self.menu_count = 25.000;
      self.motd = 22.000;

      if ( (!self.get_aliases) ) {

         return ;

      }
      sprint (self,2.000,"binding aliases...\n");

      /*if (allow_crouch) {
         TeamFortress_Alias ("+duck",13.000,0.000);
         TeamFortress_Alias ("-duck",14.000,0.000);
      } */
      TeamFortress_Alias ("inv",135.000,0.000);
      TeamFortress_Alias ("showtf",136.000,0.000);
      TeamFortress_Alias ("changeclass",99.000,0.000);
      TeamFortress_Alias ("changeteam",95.000,0.000);
      TeamFortress_Alias ("scout",(100.000 + 1.000),0.000);
      if(classtype & 1)
      {
         TeamFortress_Alias ("technician",(100.000 + 2.000),0.000);
      }
      else
      {
         TeamFortress_Alias ("sniper",(100.000 + 2.000),0.000);
      }
      TeamFortress_Alias ("soldier",(100.000 + 3.000),0.000);
      TeamFortress_Alias ("demoman",(100.000 + 4.000),0.000);
      TeamFortress_Alias ("medic",(100.000 + 5.000),0.000);
      TeamFortress_Alias ("hwguy",(100.000 + 6.000),0.000);
      TeamFortress_Alias ("pyro",(100.000 + 7.000),0.000);
      TeamFortress_Alias ("spy",(100.000 + 8.000),0.000);
      TeamFortress_Alias ("engineer",(100.000 + 9.000),0.000);
      TeamFortress_Alias ("randompc",(100.000 + 10.000),0.000);


      return ;

   }
   if ( (self.motd <= 80.000) ) {

      self.motd = (self.motd + 1.000);

   }

   if (self.classname == "observer" && self.motd < 60.000) return;

   if ( (self.motd == 30.000) ) {

      TeamFortress_Alias ("autozoom",174.000,0.000);
      TeamFortress_Alias ("scansound",162.000,0.000);
      TeamFortress_Alias ("autoscan",159.000,0.000);
      TeamFortress_Alias ("scanf",161.000,0.000);
      TeamFortress_Alias ("scane",160.000,0.000);
      TeamFortress_Alias ("dropammo",172.000,0.000);
      TeamFortress_Alias ("dropitems",194.000,0.000);
      TeamFortress_Alias ("saveme",181.000,0.000);
      TeamFortress_Alias ("discard",184.000,0.000);
      TeamFortress_Alias ("id",185.000,0.000);
      TeamFortress_Alias ("detpipe",170.000,0.000);
      TeamFortress_Alias ("reload",173.000,0.000);

      return ;

   }
   if ( (self.motd == 35.000) ) {

      TeamFortress_Alias ("gren1", 90.000,0.000);
      TeamFortress_Alias ("gren2", 91.000,0.000);
      TeamFortress_Alias ("primeone", 150.000,0.000);
      TeamFortress_Alias ("primetwo", 151.000,0.000);
      TeamFortress_Alias ("throwgren",152.000,0.000);
      TeamFortress_Alias ("+gren1",150.000,0.000);
      TeamFortress_Alias ("+gren2",151.000,0.000);
      TeamFortress_Alias ("-gren1",152.000,0.000);
      TeamFortress_Alias ("-gren2",152.000,0.000);

      return ;

   }
   if ( (self.motd == 40.000) ) {

      TeamFortress_Alias ("weapnext",10.000,0.000);
      TeamFortress_Alias ("weapprev",11.000,0.000);
      if (modetype & 4)
      { 

         TeamFortress_Alias ("+bomb",166.000,0.000);
         TeamFortress_Alias ("-bomb",169.000,0.000);
         TeamFortress_Alias ("dropbomb",180.000,0.000);
         return ;

      } else {

         TeamFortress_Alias ("+det5",164.000,0.000);
         TeamFortress_Alias ("-det5",169.000,0.000);
         TeamFortress_Alias ("+det20",165.000,0.000);
         TeamFortress_Alias ("-det20",169.000,0.000);
         TeamFortress_Alias ("+det50",166.000,0.000);
         TeamFortress_Alias ("-det50",169.000,0.000);
         TeamFortress_Alias ("+det255",167.000,0.000);
         TeamFortress_Alias ("-det255",169.000,0.000);
         return ;

      }
      return ;

   }
   if ( (self.motd == 50.000) ) {

      TeamFortress_Alias ("+sbar",182.000,0.000);
      TeamFortress_Alias ("-sbar",183.000,0.000);
      TeamFortress_Alias ("sbar_on",182.000,0.000);
      TeamFortress_Alias ("sbar_off",183.000,0.000);
      TeamFortress_Alias ("sbar_200",71.000,1.000);
      TeamFortress_Alias ("sbar_240",71.000,2.000);
      TeamFortress_Alias ("sbar_300",71.000,3.000);
      TeamFortress_Alias ("sbar_350",71.000,4.000);
      TeamFortress_Alias ("sbar_384",71.000,5.000);
      TeamFortress_Alias ("sbar_400",71.000,6.000);
      TeamFortress_Alias ("sbar_480",71.000,7.000);
      TeamFortress_Alias ("sbar_600",71.000,8.000);
      TeamFortress_Alias ("sbar_768",71.000,9.000);
      return ;

   }
   if ( (self.motd == 60.000) ) {

      TeamFortress_Alias ("showtouches",75.000,0.000);
      TeamFortress_Alias ("disguise",177.000,0.000);
      TeamFortress_Alias ("feign",178.000,0.000);
      TeamFortress_Alias ("sfeign",199.000,0.000);
      TeamFortress_Alias ("build",179.000,0.000);
      TeamFortress_Alias ("detsentry",188.000,0.000);
      TeamFortress_Alias ("detdispenser",187.000,0.000);
      TeamFortress_Alias ("voicemenu",67.000,0.000);
      TeamFortress_Alias ("voice_def",68.000,0.000);
      TeamFortress_Alias ("voice_off",69.000,0.000);
      TeamFortress_Alias ("voice_gen",70.000,0.000);
      stuffcmd (self,"bind 9 \"impulse 9\"\n");
      //stuffcmd (self,"bind 0 \"impulse 10\"\n");
      return ;

   }
   if ( (self.motd == 70.000) ) {

      TeamFortress_Alias ("showfrags",72.000,0.000);
      TeamFortress_Alias ("showfps",73.000,0.000);
      TeamFortress_Alias ("showstats",74.000,0.000);
      TeamFortress_Alias ("showspeed",115.000,0.000);
      TeamFortress_Alias ("showloc",118.000,0.000);
      TeamFortress_Alias ("showclasses",144.000,0.000);

      TeamFortress_Alias ("tracking",41.000,0.000);
      TeamFortress_Alias ("track_player",42.000,0.000);
      TeamFortress_Alias ("track_tfgoal",43.000,0.000);
      TeamFortress_Alias ("track_sentry",44.000,0.000);
      TeamFortress_Alias ("+movein",112.000,0.000);
      TeamFortress_Alias ("+moveout",113.000,0.000);
      TeamFortress_Alias ("-movein",114.000,0.000);

      TeamFortress_Alias ("-moveout",114.000,0.000);
      TeamFortress_Alias ("autotrack",86.000,0.000);


   }

   if ( (self.motd == 80.000) ) {

      TeamFortress_Alias ("commands",88.000,0.000);
      TeamFortress_Alias ("agree",77.000,0.000);
      TeamFortress_Alias ("scores", 76.000,0.000);
      TeamFortress_Alias ("special",171.000,0.000);
      TeamFortress_Alias ("id",185.000,0.000);
      TeamFortress_Alias ("query",119.000,0.000);

      TeamFortress_Alias ("elect",82.000,0.000);
      TeamFortress_Alias ("yes",83.000,0.000);
      TeamFortress_Alias ("no",84.000,0.000);
      TeamFortress_Alias ("break",85.000,0.000);
      TeamFortress_Alias ("about",87.000,0.000);
      TeamFortress_Alias ("modstatus",89.000,0.000);

      TeamFortress_Alias ("flaginfo",23.000,0.000);
      TeamFortress_Alias ("maphelp",131.000,0.000);


      if ( self.is_admin ) {
         if (self.get_admin_aliases) {
            Admin_Aliases();
         }
      }

      self.get_aliases = 0.000;
   }

};

void () TeamFortress_HelpMap = {

   local entity te;

   te = find (world,classname,"info_tfdetect");
   if ( te ) {

      if ( (te.non_team_broadcast != string_null) ) {

         sprint (self,2.000,te.non_team_broadcast);
         return ;

      }

   }
   sprint (self,2.000,"There is no help for this map.\n");

};
