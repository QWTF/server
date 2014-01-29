
void () SniperSight_Update;

/*
void () RemoveFreeze = {

  local entity te;

   te = player_head

   while ( te != world )
   {
 
      if (te.classname == "player")
      {
 
         if (te.is_frozen)
         {
            te.is_frozen = 0.000;
            te.velocity = te.movedir;
            te.tfstate = (te.tfstate - (te.tfstate & 65536.000));
            sprint(te,2.000,"Freeze wears off\n");
            TeamFortress_SetSpeed (te);
         }
      }

      if ((te.classname == "grenade") || (te.classname == "rocket"))
      {
         if (te.is_frozen)
         {
            te.is_frozen = 0.000;
            te.gravity = 1.000;
            te.velocity = te.movedir;
         }
      }

      te = te.nextp;
   }


   dremove (self);

};
*/


void () RemoveFreeze = {

   self.owner.is_frozen = 1.000;
   self.owner.velocity = self.owner.movedir;
   self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 65536.000));
   sprint(self.owner,2.000,"Freeze wears off\n");
   TeamFortress_SetSpeed (self.owner);

   dremove (self);


};

void () FreezePlayer = {

   self.owner.is_frozen = 1.000;
   self.owner.movedir = self.owner.velocity;
   //self.owner.gravity = 0.000;
   self.owner.velocity = '0.000 0.000 0.000';
   //self.owner.maxspeed = 0.000;
   self.owner.tfstate = (self.owner.tfstate | 65536.000);
   TeamFortress_SetSpeed (self.owner);
   sprint(self.owner,2.000,"Freeze bitch!\n");
   self.think = RemoveFreeze;
   self.nextthink = time + 2.6;

};

void () FreezeGrenadeExplode = {

   local entity te;

   if (anti_spam) {

      te = findradius (self.origin, anti_spam);
      while ( te ) {

         te.chain2 = te.chain;

         if ( (te.classname == "info_player_teamspawn") ) {
            spawn_tfog(self.origin);
            dremove (self);
            return;
         }
         te = te.chain2;

      }
   }
   te = findradius (self.origin,240.000);

   while ( te ) {

 	te.chain2 = te.chain;

         if (te.classname == "player")
         {

            newmis = spawn ();
            newmis.owner = te;
            newmis.netname = "freezetimer";
            newmis.pteam = self.owner.pteam;
            newmis.classname = "timer";
            newmis.think = FreezePlayer;
            newmis.nextthink = time + 0.1;
		newmis.owner = te;

         }
/*
         if ((te.classname == "grenade") || (te.classname == "rocket")) {

            if (!te.is_frozen) {
               newmis = spawn ();
               newmis.owner = te;
               newmis.netname = "freezetimer";
               newmis.pteam = self.owner.pteam;
               newmis.classname = "timer";
               newmis.think = RemoveFreeze;
               newmis.nextthink = time + 2.5;

               te.is_frozen = 1.000;
               te.movedir = te.velocity;
               te.velocity = '0 0 0';
            }
         }
      */
	
      te = te.chain2;
   }


   WriteByte (4.000,23.000);
   WriteByte (4.000,4.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);


   dremove (self);
};

void () TeamFortress_SniperWeapon = {


   self.impulse = 0.000;
   if ( (self.tfstate & 2.000) ) {

      return ;

   }
   if ( !((self.carried & WEAP_SNIPER_RIFLE) && (self.carried & WEAP_AUTO_RIFLE)) ) {

      return ;

   }
   if ( (self.ammo_shells < 1.000) ) {

      sprint (self,2.000,"not enough ammo.\n");
      return ;

   }
   if ( (self.current == WEAP_SNIPER_RIFLE) ) {

      self.current = WEAP_AUTO_RIFLE;

   } else {

      self.current = WEAP_SNIPER_RIFLE;

   }
   W_SetCurrentAmmo ();

};

void (float zoom_level) TF_zoom = {

   local string zl;

   if ( (self.tfstate & 4096.000) ) {

      return ;

   }

   zl = ftos (zoom_level);
   stuffcmd (self,"fov ");
   stuffcmd (self,zl);
   stuffcmd (self,"\n");

};

void () MakeDot1 = [ 0.000, MakeDot1 ] {
    SniperSight_Update();
};

void () MakeDot2 = [ 1.000, MakeDot2 ] {
    SniperSight_Update();
};

void () MakeDot3 =  [ 2.000, MakeDot3 ] {
    SniperSight_Update();
};

void () MakeDot4 = [ 3.000, MakeDot4 ] {
    SniperSight_Update();
};

void () SniperSight_Update = {

   local vector org;

   if (!(self.owner.tfstate & 2048.000)) {

      self.owner.tfstate = (self.owner.tfstate - (self.owner.tfstate & 2048.000));
      TeamFortress_SetSpeed (self.owner);
      self.owner.heat = 0.000;
      dremove (self);
      return ;

   }
   makevectors (self.owner.v_angle);
   org = (self.owner.origin + (v_forward * 10.000));
   org_z = (self.owner.absmin_z + (self.owner.size_z * 0.700));
   traceline (org,(org + (v_forward * 9192.000)),0.000,self);
   if ( (trace_fraction == 1.000) ) {

      setorigin (self,self.owner.origin);
      return ;

   }
   self.angles = vectoangles (v_forward);
   setorigin (self,trace_endpos - (v_forward * 1.000));
   self.nextthink = (time + 0.030);

};

void () SniperSight_Create = {

   local entity sight;

   if ( (self.has_disconnected == 1.000) ) {

      return ;

   }

   sight = spawn ();
   sight.owner = self;
   sight.movetype = 8.000;
   sight.solid = 0.000;
   //sight.alpha = 0.500;
   sight.classname = "timer";
   setorigin (sight,self.origin);
   setmodel (sight,"progs/dot.spr");

   if (self.pteam.team == 1.000) {
      sight.think = MakeDot1;
   } else {

      if (self.pteam.team == 2.000) {
         sight.think = MakeDot2;
      } else {

         if (self.pteam.team == 3.000) {
            sight.think = MakeDot3;
         } else {

            if (self.pteam.team == 4.000) {

               sight.think = MakeDot4;
            }
         }
      }
   }


   sight.nextthink = (time + 0.050);

};

void () TeamFortress_AutoZoomToggle = {

   if ( (self.tfstate & 4096.000) ) {

      self.tfstate = (self.tfstate - 4096.000);
      sprint (self,2.000,"autozoom ON\n");

      
   } else {

      self.tfstate = (self.tfstate | 4096.000);
      sprint (self,2.000,"autozoom OFF\n");

   }

};
