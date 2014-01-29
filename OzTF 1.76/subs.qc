

void (vector tdest, float tspeed, void() func) SUB_CalcMove;
void () SUB_CalcMoveDone;
void (vector destangle, float tspeed, void() func) SUB_CalcAngleMove;

void (entity Goal, entity AP) DoGoalWork;

void (entity Goal, entity AP) DoGroupWork;

void () SUB_Null = {


};

void () SUB_Remove = {

   dremove (self);

};



void () SetMovedir = {

   if ( (self.angles == '0.000 -1.000 0.000') ) {

      self.movedir = '0.000 0.000 1.000';

   } else {

      if ( (self.angles == '0.000 -2.000 0.000') ) {

         self.movedir = '0.000 0.000 -1.000';

      } else {

         makevectors (self.angles);
         self.movedir = v_forward;

      }

   }
   
   self.angles = '0.000 0.000 0.000';

};

void () InitTrigger = {

   if ( (self.angles != '0.000 0.000 0.000') ) {

      SetMovedir ();

   }
   self.solid = 1.000;
   setmodel (self,self.model);
   self.movetype = 0.000;
   self.modelindex = 0.000;
   self.model = "";

};


void (vector tdest, float tspeed, void() func) SUB_CalcMove = {

   local vector vdestdelta;
   local float len;
   local float traveltime;

   if ( !tspeed ) {

      objerror ("No speed is defined!");

   }
   self.think1 = func;
   self.finaldest = tdest;
   self.think = SUB_CalcMoveDone;
   if ( (tdest == self.origin) ) {

      self.velocity = '0.000 0.000 0.000';
      self.nextthink = (self.ltime + 0.100);
      return ;

   }
   vdestdelta = (tdest - self.origin);
   len = vlen (vdestdelta);
   traveltime = (len / tspeed);
   if ( (traveltime < 0.030) ) {

      traveltime = 0.030;

   }
   self.nextthink = (self.ltime + traveltime);
   self.velocity = (vdestdelta * (1.000 / traveltime));

};

void () SUB_CalcMoveDone = {

   setorigin (self,self.finaldest);
   self.velocity = '0.000 0.000 0.000';
   self.nextthink = -1.000;
   if ( self.think1 ) {

      self.think1 ();

   }

};

void (vector destangle, float tspeed, void() func) SUB_CalcAngleMove = {

   local vector destdelta;
   local float len;
   local float traveltime;

   if ( !tspeed ) {

      objerror ("No speed is defined!");

   }
   destdelta = (destangle - self.angles);
   len = vlen (destdelta);
   traveltime = (len / tspeed);
   self.nextthink = (self.ltime + traveltime);
   self.avelocity = (destdelta * (1.000 / traveltime));
   self.think1 = func;
   self.finalangle = destangle;
   self.think = SUB_CalcAngleMoveDone;

};

void () SUB_CalcAngleMoveDone = {

   self.angles = self.finalangle;
   self.avelocity = '0.000 0.000 0.000';
   self.nextthink = -1.000;
   if ( self.think1 ) {

      self.think1 ();

   }

};

void () DelayThink = {

   activator = self.enemy;
   SUB_UseTargets ();

   dremove (self);

};

void () SUB_UseTargets = {

   local entity t;
   local entity stemp;
   local entity otemp;
   local entity act;



   if ( self.dont_do_triggerwork ) {

      self.dont_do_triggerwork = 0.000;
      return ;

   }

   if ( self.delay ) {

      t = spawn ();
      t.classname = "DelayedUse";
      t.nextthink = (time + self.delay);
      t.think = DelayThink;
      t.enemy = activator;
      t.message = self.message;
      t.killtarget = self.killtarget;
      t.target = self.target;
      return ;

   }
   if ( ((activator.classname == "player") && (self.message != "")) ) {

      CenterPrint (activator,self.message);
      if ( !self.noise ) {

         sound (activator,2.000,"misc/talk.wav",1.000,1.000);

      }

   }
   if ( (activator.classname == "player") ) {

      DoGroupWork (self,activator);
      DoGoalWork (self,activator);

   }
   if ( self.killtarget ) {

      t = world;
      do {

         t = find (t,targetname,self.killtarget);
         if ( !t ) {

            return ;

         }
         remove (t);

      } while ( 1.000 );

   }
   if ( self.target ) {


      act = activator;
      t = world;
      do {

         t = find (t,targetname,self.target);
         if ( !t ) {


            return ;

         }

         stemp = self;
         otemp = other;
         self = t;
         other = stemp;
         if ( (self.use != SUB_Null) ) {

            if ( self.use ) {

               self.use ();

            }

         }
         self = stemp;
         other = otemp;
         activator = act;

      } while ( 1.000 );

   }

};

void (float normal) SUB_AttackFinished = {

   self.cnt = 0.000;
   if ( (skill < 3.000) ) {

      self.attack_finished = (time + normal);

   }

};

