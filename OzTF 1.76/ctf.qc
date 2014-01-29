
void () TeamFortress_CTF_FlagInfo = {

   local entity te;

   te = Finditem (1.000);
   if ( (te.goal_state == 1.000) ) {

      if ( (self == te.owner) ) {

         sprint (self,2.000,"You have the enemy flag.\n");

      } else {

         sprint (self,2.000,te.owner.netname);
         sprint (self,2.000," has");
         if ( (self.pteam == pteam1) ) {

            sprint (self,2.000," your flag.\n");

         } else {

            sprint (self,2.000," the enemy flag.\n");

         }

      }

   } else {

      if ( (te.origin != te.oldorigin) ) {

         if ( (self.pteam == pteam1) ) {

            sprint (self,2.000,"Your flag is lying about.\n");

         } else {

            sprint (self,2.000,"The enemy flag is lying about.\n");

         }

      } else {

         if ( (self.pteam == pteam1) ) {

            sprint (self,2.000,"Your flag is in your base.\n");

         } else {

            sprint (self,2.000,"The enemy flag is in their base.\n");

         }

      }

   }
   te = Finditem (2.000);
   if ( (te.goal_state == 1.000) ) {

      if ( (self == te.owner) ) {

         sprint (self,2.000,"You have the enemy flag.\n");

      } else {

         sprint (self,2.000,te.owner.netname);
         sprint (self,2.000," has");
         if ( (self.pteam == pteam2) ) {

            sprint (self,2.000," your flag.\n");

         } else {

            sprint (self,2.000," the enemy flag.\n");

         }

      }

   } else {

      if ( (te.origin != te.oldorigin) ) {

         if ( (self.pteam == pteam2) ) {

            sprint (self,2.000,"Your flag is lying about.\n");

         } else {

            sprint (self,2.000,"The enemy flag is lying about.\n");

         }

      } else {

         if ( (self.pteam == pteam2) ) {

            sprint (self,2.000,"Your flag is in your base.\n");

         } else {

            sprint (self,2.000,"The enemy flag is in their base.\n");

         }

      }

   }

};
