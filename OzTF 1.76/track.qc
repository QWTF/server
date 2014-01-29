float(entity ent) EntityNum = 
{ 
   local float num = 1; 
   local entity e; 
    
   e = world; 
   do { 
      e = nextent(e); 
       
   } while (e != ent); 

   return num; 
}


entity(float num) NumEntity = 
{ 
   local float fl; 
   local entity e; 

   fl  = 1;
   e = world; 
   do { 
      e = nextent(e); 
      fl = fl + 1;
   } while (fl != num); 

   return e; 
}

void () Spect_Track = {

   local float num;

   num = EntityNum(self.goalentity);
   stuffcmd(self,"track #");
   stuffcmd(self,ftos(num));
   stuffcmd(self,"\n");

};

void () Flymode = {

local entity spot;

        spot = find (world,classname,"info_player_start");
        self.origin = spot.origin;
        if (self.classname == "observer" && self.tracking == 2.000) {
           stuffcmd(self, "+attack; wait; -attack\n");
        }

        self.tracking = 0.000;
        self.gravity = 1.000;
};

void () Toggle_Tracking = {


      if (self.playerclass) return;


      if (self.goalentity == world) return;

      if(!self.tracking) {
         self.tracking = 1.000;
         self.gravity = 0.000;
         sprint(self, 2, "Tracking mode: 3rd Person.\n");

      } else if ((self.goalentity.classname == "player") || (self.goalentity.classname == "building_sentrygun") && (self.tracking == 1.000)) {
         self.tracking = 2.000;
         if (self.classname == "observer" && self.goalentity.classname == "player") Spect_Track();
         sprint(self, 2, "Tracking mode: 1st Person.\n");
      } else  {


        Flymode();
        sprint(self, 2, "Tracking mode: Flymode.\n");
      }

};


void () Track_Object = {

   local vector v1,v2,v3;
   local entity goal;
   local float new;


      if ( (self.goalentity != world) ) {
         if (self.goalentity.solid == 0.000) {
            goal = self.goalentity.owner;
            new = 1.000;
         } else if ((self.goalentity.classname == "player") && (self.goalentity.health <= 0.000)) {
            goal = self.goalentity.enemy;

         } else {
            goal = self.goalentity;
         }

         if (self.a_c) {
            if (self.goalentity != store_obs.goalentity) {
               if (store_obs.goalentity != world) {
                  goal = store_obs.goalentity;
                  self.goalentity = store_obs.goalentity;
                  if (self.classname == "observer" && self.goalentity.classname == "player") Spect_Track();
               }
            }
         }

         if ( (goal.classname == "player") || (goal.classname == "building_sentrygun") && (self.tracking == 2)) {

            if (self.classname == "player") {

               self.origin = goal.origin + self.goalentity.view_ofs;
               if (goal.classname == "player")
               {
                  self.angles_x = goal.angles_x * -1.000;
                  self.angles_y = goal.angles_y;
               }
               else  if (goal.classname == "building_sentrygun")
               {
                  self.angles = goal.angles;
               }
               self.fixangle = 1.000;
               return;
            }

         }  else  if (self.tracking) {

           
            v1 = goal.origin;
            v2 = self.v_angle;
            makevectors(v2);
            v2 = v_forward * self.camdist;
            traceline(v1, v1 - v2, 1.000, goal);
            v2 = v2 * trace_fraction;
            v3 = v1 - (v2 * 0.6);
            v2 = v1 - v2;

            traceline(self.origin, v2, 1.000, goal);
            if (trace_fraction == 1.0) {
               v1 = v3 - self.origin;
               v1 = v1 * 10;
               self.velocity = v1;
            }

            self.origin = v3;
         }

         if (goal.classname == "player") {

            self.items = goal.items;
            self.armorvalue = goal.armorvalue;
            if (goal.health <= 0) {
               self.health = 1.000; 
            } else { 
               self.health = goal.health;
            }
            self.weapon = goal.weapon;
            self.currentammo = goal.currentammo;

         } else if (goal.classname == "building_sentrygun") {

            if (goal.health <= 0) {
               self.health = 1.000; 
            } else { 
               self.health = goal.health;
            }
            self.weapon = goal.weapon;
            self.currentammo = goal.ammo_shells;
         }
         else if (goal.classname == "item_tfgoal") {

            if (goal.origin != goal.oldorigin) {
               self.armorvalue = goal.nextthink - time;
            } else {
               self.armorvalue = 0.000;
            }

            self.health = 1.000; 
            self.currentammo = 0.000;
         }
     }
};


void () Track_Tfgoal = {

  local entity te;

      if (self.classname == "observer") Flymode();


      if (self.pteam != store_obs)
      {
         while (te != world)
         {        
              te = find (te,classname,"item_tfgoal");

              if (te.owned_by == self.pteam.team){break;}
         }
      }
      else
      {
         te = find (self.goalentity,classname,"item_tfgoal");
         if ( (te == world) ) {

            te = find (te,classname,"item_tfgoal");
         } 
      }


      if ( (te != world) ) {
         self.goalentity = te;

         if(!self.tracking) Toggle_Tracking();

         CenterPrint3(self,"You are tracking: ", self.goalentity.netname, ".\n");

      } else {

         CenterPrint(self,"No TF Goals in game to track.\n");
         Flymode();
      }
};

void () Track_Player = {

   local entity te;

      te = self.goalentity.nextp;

      if (( te == world)  )  {
        te = player_head;
      }

      while (( te != world)) {

         if ((!te.playerclass) || (te.deadflag) )  {
           te = te.nextp;
         } else {
            break; 
         }
      }
        



      if ( (te != world) ) {
         self.goalentity = te;
         if(!self.tracking) Toggle_Tracking();
         //if (self.classname == "observer") Spect_Track();
         CenterPrint3(self,"You are tracking: ", self.goalentity.netname, ".\n");

      } else {

         te = player_head;

         if ( te)
         {

            if ((!te.playerclass) || (te.deadflag) )  {
               CenterPrint(self,"No Players in game to track.\n");
               Flymode();
               return;
            }
            self.goalentity = te;
            if(!self.tracking) Toggle_Tracking();
            //if (self.classname == "observer") Spect_Track();
            CenterPrint3(self,"You are tracking: ", self.goalentity.netname, ".\n");
         } else {

            CenterPrint(self,"No Players in game to track.\n");
            Flymode();
         }
      }


};

void () Track_Sentry = {

   local entity te;
         if (self.classname == "observer") Flymode();

      te = find (self.goalentity,classname,"building_sentrygun");
      if ( (te == world) ) {

          te = find (te,classname,"building_sentrygun");
      }

      if (self.pteam != store_obs)
      {
         if (te.pteam != self.pteam)
         {        
               te = find (te,classname,"building_sentrygun");
         }
      }

      if (te != world)
      {

         self.goalentity = te;

         if(!self.tracking) Toggle_Tracking();
         CenterPrint3(self,"You are tracking: ", self.goalentity.owner.netname, "'s Sentry Gun.\n");

      } else {

         CenterPrint(self,"No Sentry Gun's in game to track.\n");
         Flymode();

      }
};


/*
void () Autotrack_Think = {

   local entity te;
   local entity autotrack;
   local entity exception;
   local float pfrags;


   te = find (world,classname,"player");

   while (( te != world)) {

      if ((te.playerclass) || (!te.deadflag) )
      {
         exception = te;

         if (te.real_frags > pfrags)
            autotrack = te;
         if (te.items & (4194304.000 | 1048576.000 | 524288.000))
            autotrack = te; 
         if (te.effects & (8.000 | 4.000))
            autotrack = te; 
      }     
      te = find (te,classname,"player");
   }

   if (autotrack != world)
   {
      self.goalentity = autotrack;
   }
   else
   {
      if (exception != world)
      {
         self.goalentity = exception;
      }
   }

   te = find (world,classname,"player");

   while (( te != world)) {

      if ((te.tracking) && (te.a_c)) {
        te.goalentity = self.goalentity;
      }
   }

   self.nextthink = time + 3.000;

};

void () Toggle_Autotrack = {

local entity autotrack;

      if (store_obs.goalentity == world) {
         autotrack = spawn();
         autotrack.classname = "autotrack";
         autotrack.nextthink = time + 0.100;
         autotrack.think = Autotrack_Think;
         store_obs.goalentity = autotrack;
      }

      if(autotrack.goalentity.classname == "player") {
         self.goalentity = autotrack.goalentity;
         autotrack.nextthink = time + 10.000;
         Track_Object ();
      }

};*/

void () Toggle_Autotrack = {

   local entity te;
   local entity autotrack;
   local entity exception;
   local float pfrags;

   self.a_c = 1.000;

   if (store_obs.goalentity == world) {

      te = player_head;

      while (te)
      {
         if (te.playerclass)
         {
            if (!te.deadflag) 
            {
               exception = te;

               if (te.real_frags > pfrags)
                  autotrack = te;
               if (te.items & (4194304.000 | 1048576.000 | 524288.000))
                  autotrack = te; 
               if (te.effects & (8.000 | 4.000))
                  autotrack = te; 
            }
         }
         te = te.nextp;
      }

      if (autotrack != world)
        store_obs.goalentity = autotrack;
   
      else
      {
         if (exception != world)
         {
            store_obs.goalentity = exception;
         }
      }
   }

   self.goalentity = store_obs.goalentity;
   if(!self.tracking) Toggle_Tracking();

   CenterPrint3(self,"You are tracking: ", self.goalentity.netname, ".\n");

};






void () Check_Track = {

   if (self.tracking) {

     if ((self.goalentity != world) ) {
         Track_Object();
     } 

     if (self.campan == 1)
     {
        self.camdist = self.camdist - (self.fAverageFrameTime / self.fFrameCount) * 100;
        if ( self.camdist < 50) self.camdist = 50;

     }

     if (self.campan == -1)
     {
        self.camdist = self.camdist + (self.fAverageFrameTime / self.fFrameCount) * 100;
        if ( self.camdist > 500) self.camdist = 500;
     }
   }

};

