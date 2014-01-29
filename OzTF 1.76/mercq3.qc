//q3
void () ammo_bullets = { item_spikes();};
void () ammo_slugs = { item_cells();};
void () ammo_grenades = { item_rockets();};

void() weapon_shotgun    = {weapon_supershotgun ();};
void() weapon_railgun       = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/g_light.mdl");
   setmodel (self,"progs/g_light.mdl");
   self.weapon = 3.000;
   self.netname = "Railgun";
   self.touch = weapon_touch;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();
};




void () item_armor_body = {self.classname="item_armorInv"; item_armorInv();};
void () item_armor_combat = {self.classname="item_armor2";item_armor2();};

void () item_quad = {self.classname="item_artifact_super_damage"; item_artifact_super_damage();};


void () item_health_small = {
   self.spawnflags = self.spawnflags & 1; 
   item_health ();
};
void () item_health_large = { item_health ();};
void () item_health_mega = {
   self.classname = "item_health";
   self.spawnflags = 2.000; 
   item_health ();
};

void () armor_shard_touch = {

   local float value;

   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( (other.classname != "player") ) {

      return ;

   }
   if ( other.is_feigning ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }

   if (round_over) return;

   if (!other.armorvalue) return;

   value = other.armorvalue + 5.000;

   if ( (value > other.maxarmor) ) {

      value = other.maxarmor;

   }

   other.armorvalue = value;

   self.solid = 0.000;
   self.model = string_null;

   if (modetype & 8) TeamFortress_SetSpeed(other); 

   if ( (deathmatch != 2.000) ) {

      self.nextthink = (time + 20.000);

   }
   if ( coop ) {

      self.nextthink = (time + 40.000);

   }
   self.think = SUB_regen;
   sound (other,3.000,"items/armor1.wav",1.000,1.000);
   stuffcmd (other,"bf\n");
   activator = other;
};

void () item_armor_shard = {

   self.touch = armor_shard_touch;

   precache_model ("models/powerups/armor/shard.md3");
   setmodel (self,"models/powerups/armor/shard.md3");
   self.mdl = "models/powerups/armor/shard.md3";
   self.solid = 1.000;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

}

void () item_invis = {self.origin_z = self.origin_z + 16; item_artifact_invisibility ();};

void () team_CTF_bluespawn = {self.origin_z = self.origin_z + 8; info_player_team1();};

void () team_CTF_redspawn = {self.origin_z = self.origin_z + 8; info_player_team2();};


void () team_CTF_blueflag = {item_flag_team1();};

void () team_CTF_redflag = {item_flag_team2();};

//team_CTF_blueplayer

void () misc_teleporter_dest = {info_teleport_destination(); };

void () target_position = {};

void () target_location = { dremove(self);};

void () target_speaker = {

   if (self.spawnflags & 1) {
      if (self.noise) {
         dremove(self);
         //precache_sound (self.noise);
         //ambientsound (self.origin,self.noise,0.700,3.000);
      }
   } else {
      trigger_push();
   }
};

void () info_player_intermission = {info_intermission();};


void () func_static = {
   InitTrigger ();
};

void () misc_model = {

   if (self.model == "models/mapobjects/storch/storch2.md3")
   {
       light_torch_small_walltorch ();
   }
   else if (self.model == "models/mapobjects/gratelamp/gratelamp.md3")
   {
       light_flame_large_yellow ();
   }
   else
   {
      precache_model (self.model);
      InitTrigger ();
   }
};


//q3f + fe 
.string allowteams;

void (string fullentdata) ConvertQ3Fent = {

  local float args;
  local string key;
  local string value;
 

  tokanize(fullentdata);
  args = argc() - 2; 

  while(args>0)
  {

      key = (argv(args - 1));
      value = (argv(args));

      if (key == "carried_message")
      {
         self.message = value;
      }
      else if (key == "carried_all_message")
      {
         self.team_broadcast = value;
      }
      else if (key == "inactive_all_message")
      {
         self.noise4 = value;
      }

     // else if (key == "active_flaginfo")
     // {

     // }

     args = args - 2;
  }

};


float (string fullentdata) CheckQ3FcapPoint = {

  local float args;
  local float active;
  local string key;
  local string value;
 

  tokanize(fullentdata);
  args = argc() - 2; 

  while(args>0)
  {

      key = (argv(args - 1));
      value = (argv(args));

      if (key == "teamscore")
      {
         self.count = stof(value);
         self.frags = stof(value);
         active = 1.000;
      }
      else if (key == "holding")
      {
         if (value == "redflag") {
            self.team_no = 2.000;
            self.axhitme = 1.000;
         }
         if (value == "blueflag") {
            self.team_no = 1.000;
            self.axhitme = 2.000;
         }
         active = 1.000;
      }
      else if (key == "active_message")
      {
         self.message = value;
      }

      
     args = args - 2;
  }

  return (active);
};


void () func_goalinfo = {

   local string tmp;

   if (__fullspawndata != "")
   {
       dprint("MULTI MANAGER spawned!\n");
       tmp = __fullspawndata;
       ConvertQ3Fent(tmp);

   }
   else
     dprint("no server support for multi_manager\n");

   if (self.allowteams == "blue") {
      self.team_no = 1.000;
   }
   else if (self.allowteams == "red")
   {
      self.team_no = 2.000;
   }

   self.classname = "info_tfgoal";
   self.mdl = self.model;
   info_tfgoal();
};

void () func_goalitem = {

   local string tmp;

   if (__fullspawndata != "")
   {
       dprint("MULTI MANAGER spawned!\n");
       tmp = __fullspawndata;
       ConvertQ3Fent(tmp);

   }
   else
     dprint("no server support for multi_manager\n");

   if (self.allowteams == "blue") {
      self.team_no = 1.000;
   }
   else if (self.allowteams == "red")
   {
      self.team_no = 2.000;
   }

   self.classname = "item_tfgoal";
   self.mdl = self.model;
   item_tfgoal();
};

void () fe_spawn = {

   if (self.allowteams == "blue") {
      self.team_no = 1.000;
      self.classname = "info_player_teamspawn";
   }
   else if (self.allowteams == "red")
   {
      self.team_no = 2.000;
      self.classname = "info_player_teamspawn";
   }
   else
   {
      self.classname = "info_player_spawn";
   }
};