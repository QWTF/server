float () CheckExistence;
entity (float gno) Findgoal;

void (entity te) dremove = {

   if ( (te == world) ) {

      dprint ("***BUG BUG BUG BUG BUG BUG BUG BUG BUG BUG***\n");
      dprint ("WORLD has nearly been removed. Don't worry\n");
      dprint ("***BUG BUG BUG BUG BUG BUG BUG BUG BUG BUG***\n");
      return ;

   }
   if ( (te.is_removed == 1.000) ) {

      return ;

   }
   te.is_removed = 1.000;
   remove (te);

};



void () display_location = {

   local string st;

   st = vtos (self.origin);
   sprint3 (self,2.000,"Location : ",st,"\n");
   st = vtos (self.angles);
   sprint3 (self,2.000,"Angles   : ",st,"\n");

};
