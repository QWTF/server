
void () DroppedKeyThink = {

   self.think = SUB_Null;
   self.touch = key_touch;
   self.owner = world;

};

void () DropKey = {

   if ( ((self.items & 131072.000) || (self.items & 262144.000)) ) {

      newmis = spawn ();
      if ( (self.items & 131072.000) ) {

         self.items = (self.items - (self.items & 131072.000));
         newmis.items = 131072.000;
         if ( (world.worldtype == 0.000) ) {

            setmodel (newmis,"progs/w_s_key.mdl");
            newmis.netname = "silver key";
            newmis.noise = "misc/medkey.wav";

         } else {

            if ( (world.worldtype == 1.000) ) {

               setmodel (newmis,"progs/m_s_key.mdl");
               newmis.netname = "silver runekey";
               newmis.noise = "misc/runekey.wav";

            } else {

               if ( (world.worldtype == 2.000) ) {

                  setmodel (newmis,"progs/b_s_key.mdl");
                  newmis.netname = "silver keycard";
                  newmis.noise = "misc/basekey.wav";

               }

            }

         }

      } else {

         if ( (self.items & 262144.000) ) {

            self.items = (self.items - (self.items & 262144.000));
            newmis.items = 262144.000;
            if ( (world.worldtype == 0.000) ) {

               setmodel (newmis,"progs/w_g_key.mdl");
               newmis.netname = "gold key";
               newmis.noise = "misc/medkey.wav";

            } else {

               if ( (world.worldtype == 1.000) ) {

                  setmodel (newmis,"progs/m_g_key.mdl");
                  newmis.netname = "gold runekey";
                  newmis.noise = "misc/runekey.wav";

               } else {

                  if ( (world.worldtype == 2.000) ) {

                     setmodel (newmis,"progs/b_g_key.mdl");
                     newmis.netname = "gold keycard";
                     newmis.noise = "misc/basekey.wav";

                  }

               }

            }

         }

      }
      newmis.owner = self;
      newmis.touch = SUB_Null;
      setorigin (newmis,(self.origin + '0.000 0.000 16.000'));
      makevectors (self.v_angle);
      newmis.velocity = ((normalize (v_forward) * 300.000) + '0.000 0.000 200.000');
      newmis.movetype = 6.000;
      newmis.solid = 1.000;
      newmis.deadflag = 1.000;
      setsize (newmis,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
      newmis.think = DroppedKeyThink;
      newmis.nextthink = (time + 1.500);

   } else {

      sprint (self,2.000,"You don't have a key\n");

   }

};
float () DoorShouldOpen = {

   local entity ptr;
   local float plyrcount;
   local entity plyr1;
   local entity plyr2;

   if ( (coop != 2.000) ) {

      return ( 1.000 );

   }
   plyrcount = 0.000;
   ptr = player_head;
   while ( (ptr != world) ) {

      if ( (((!(ptr.tf_items & self.items) && (ptr.playerclass)) && (ptr.solid != 0.000)) && (ptr.model != string_null)) ) {

         plyrcount = (plyrcount + 1.000);
         if ( (plyrcount == 1.000) ) {

            plyr1 = ptr;

         } else {

            if ( (plyrcount == 2.000) ) {

               plyr2 = ptr;

            }

         }

      }
      ptr = ptr.nextp;

   }
   if ( (plyrcount != 0.000) ) {

      if ( (plyrcount == 1.000) ) {

         bprint (2.000,plyr1.netname);
         bprint (2.000," needs");

      } else {

         if ( (plyrcount == 2.000) ) {

            bprint (2.000,plyr1.netname);
            bprint (2.000," and ");
            bprint (2.000,plyr2.netname);
            bprint (2.000," need");

         } else {

            bprint (2.000,"More players need");

         }

      }
      bprint (2.000," to unlock the ");
      if ( (self.items & 131072.000) ) {

         bprint (2.000,"silver");

      } else {

         bprint (2.000,"gold");

      }
      bprint (2.000," door\n");
      return ( 0.000 );

   }
   bprint (2.000,"The ");
   if ( (self.items & 131072.000) ) {

      bprint (2.000,"silver");

   } else {

      bprint (2.000,"gold");

   }
   bprint (2.000," door has been unlocked\n");
   return ( 1.000 );

};
