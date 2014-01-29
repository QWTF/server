
void () TF_PlaceItem;

void () TF_StartItem;

void () TF_PlaceGoal;

void () TF_StartGoal;

void () info_tfdetect;

void () info_player_teamspawn;

void () info_tfgoal;

void () info_tfgoal_timer;

void () item_tfgoal;

entity (float gno) Findteamspawn;

void (entity Goal) InactivateGoal;

void (entity Goal) RestoreGoal;

void (entity Goal) RemoveGoal;
float (entity Goal, entity Player, entity AP) IsAffectedBy;

void (entity Goal, entity Player, entity AP, float addb) Apply_Results;
float (entity Goal, entity AP) APMeetsCriteria;

void (entity Goal) SetupRespawn;

void () DoRespawn;

void (entity Item, entity AP) DoItemGroupWork;

void (entity Goal, entity AP) DoTriggerWork;

void (entity Goal, entity Player) RemoveResults;

void () info_tfgoal_use;

void () tfgoal_timer_tick;

void () item_tfgoal_touch;

void () tfgoalitem_remove;

void (entity Item, float PAlive, entity P) tfgoalitem_drop;

void (entity Item) tfgoalitem_checkgoalreturn;

void (entity P) ForceRespawn;

void () CheckModel = {

       if (self.mdl == "models/flag.mdl")
       {
          self.mdl = "progs/tf_stan.mdl";
          if (self.skin == 1.000)
             self.skin = 2.000;
          else if (self.skin == 2.000)
             self.skin = 1.000;
       }

       if (self.mdl == "models/backpack.mdl")
          self.mdl = "progs/backpack.mdl";

       if (self.mdl == "models/keycard.mdl") {
          if (self.owned_by == 1.000) {
             self.mdl = "progs/basbkey.bsp";
          } else if (self.owned_by == 2.000) {
             self.mdl = "progs/basrkey.bsp";
          }
       }
        
       if (self.mdl == "models/w_suit.mdl")
          self.mdl = "progs/suit.mdl";

       if (self.mdl == "models/r_armor.mdl")
          self.mdl = "progs/armor.mdl";

       if (self.mdl == "models/ball.mdl")
          self.mdl = "progs/ball2.mdl";
        
};


void (entity Goal) UpdateAbbreviations = {

   local string st;
   local float flag;

//dprint(Goal.classname);
//dprint("\n");

   if ( (Goal.has_abbreviated == 0.000) ) {

      if ( ((Goal.g_a != 0.000) && (Goal.goal_activation == 0.000)) ) {

         Goal.goal_activation = Goal.g_a;

      }
      if ( ((Goal.g_e != 0.000) && (Goal.goal_effects == 0.000)) ) {

         Goal.goal_effects = Goal.g_e;

      }
      if ( ((Goal.h_i_g != 0.000) && (Goal.has_item_from_group == 0.000)) ) {

         Goal.has_item_from_group = Goal.h_i_g;

      }
      if ( ((Goal.hn_i_g != 0.000) && (Goal.hasnt_item_from_group == 0.000)) ) {

         Goal.hasnt_item_from_group = Goal.hn_i_g;

      }
      if ( ((Goal.r_i_g != 0.000) && (Goal.remove_item_group == 0.000)) ) {

         Goal.remove_item_group = Goal.r_i_g;

      }
      if ( ((Goal.a_s != 0.000) && (Goal.ammo_shells == 0.000)) ) {

         Goal.ammo_shells = Goal.a_s;

      }
      if ( ((Goal.a_n != 0.000) && (Goal.ammo_nails == 0.000)) ) {

         Goal.ammo_nails = Goal.a_n;

      }
      if ( ((Goal.a_r != 0.000) && (Goal.ammo_rockets == 0.000)) ) {

         Goal.ammo_rockets = Goal.a_r;

      }
      if ( ((Goal.a_c != 0.000) && (Goal.ammo_cells == 0.000)) ) {

         Goal.ammo_cells = Goal.a_c;

      }
      if ( ((Goal.rv_s_h != 0.000) && (Goal.remove_spawngroup == 0.000)) ) {

         Goal.remove_spawngroup = Goal.rv_s_h;

      }
      if ( ((Goal.rs_s_h != 0.000) && (Goal.restore_spawngroup == 0.000)) ) {

         Goal.restore_spawngroup = Goal.rs_s_h;

      }
      if ( ((Goal.rv_gr != 0.000) && (Goal.remove_group_no == 0.000)) ) {

         Goal.remove_group_no = Goal.rv_gr;

      }
      if ( ((Goal.rs_gr != 0.000) && (Goal.restore_group_no == 0.000)) ) {

         Goal.restore_group_no = Goal.rs_gr;

      }
      if ( ((Goal.rv_g != 0.000) && (Goal.remove_goal_no == 0.000)) ) {

         Goal.remove_goal_no = Goal.rv_g;

      }
      if ( ((Goal.rs_g != 0.000) && (Goal.restore_goal_no == 0.000)) ) {

         Goal.restore_goal_no = Goal.rs_g;

      }
      if ( (Goal.t_s_h != string_null) ) {

         Goal.team_str_home = Goal.t_s_h;

      }
      if ( (Goal.t_s_m != string_null) ) {

         Goal.team_str_moved = Goal.t_s_m;

      }
      if ( (Goal.t_s_c != string_null) ) {

         Goal.team_str_carried = Goal.t_s_c;

      }
      if ( (Goal.n_s_h != string_null) ) {

         Goal.non_team_str_home = Goal.n_s_h;

      }
      if ( (Goal.n_s_m != string_null) ) {

         Goal.non_team_str_moved = Goal.n_s_m;

      }
      if ( (Goal.n_s_c != string_null) ) {

         Goal.non_team_str_carried = Goal.n_s_c;

      }
      if ( (Goal.b_b != string_null) ) {

         Goal.broadcast = Goal.b_b;

      }
      if ( (Goal.b_t != string_null) ) {

         Goal.team_broadcast = Goal.b_t;

      }
      if ( (Goal.b_n != string_null) ) {

         Goal.non_team_broadcast = Goal.b_n;

      }
      if ( (Goal.b_o != string_null) ) {

         Goal.owners_team_broadcast = Goal.b_o;

      }
      if ( (Goal.n_b != string_null) ) {

         Goal.netname_broadcast = Goal.n_b;

      }
      if ( (Goal.n_t != string_null) ) {

         Goal.netname_team_broadcast = Goal.n_t;

      }
      if ( (Goal.n_n != string_null) ) {

         Goal.netname_non_team_broadcast = Goal.n_n;

      }
      if ( (Goal.n_o != string_null) ) {

         Goal.netname_owners_team_broadcast = Goal.n_o;

      }
      if ( (Goal.d_t != string_null) ) {

         Goal.team_drop = Goal.d_t;

      }
      if ( (Goal.d_n != string_null) ) {

         Goal.non_team_drop = Goal.d_n;

      }
      if ( (Goal.d_n_t != string_null) ) {

         Goal.netname_team_drop = Goal.d_n_t;

      }
      if ( (Goal.d_n_n != string_null) ) {

         Goal.netname_non_team_drop = Goal.d_n_n;

      }
      if ((flagem_checked == 0.000))
	{

         st = infokey (world,"flag_drop");

         if ( (st == "on") )
         {
            toggleflags = (toggleflags | 8.000);
         }

         st = infokey (world,"flag_solid");

         if ( (st == "on") )
         {
            toggleflags = (toggleflags | 16.000);
         }

         flag = stof(infokey (world,"flag_model"));

         if (flag == 1.000 )
         {
		toggleflags = (toggleflags | 4096);
	   }
         else if (flag == 2.000)
         {
		toggleflags = (toggleflags | 8192);
	   }
         else if (flag == 3.000)
         {
		toggleflags = (toggleflags | 16384);
	   }

	   flagem_checked = 1.000;
	}
	

	   if ( (toggleflags & 4096) )
         {
            if ( (((Goal.mdl == "progs/b_s_key.mdl") || (Goal.mdl == "progs/m_s_key.mdl")) || (Goal.mdl == "progs/w_s_key.mdl")) ) {

               precache_model2 ("progs/tf_flag.mdl");
               Goal.mdl = "progs/tf_flag.mdl";
               Goal.skin = 1.000;

            } else {

               if ( (((Goal.mdl == "progs/b_g_key.mdl") || (Goal.mdl == "progs/m_g_key.mdl")) || (Goal.mdl == "progs/w_g_key.mdl")) ) {

                  precache_model2 ("progs/tf_flag.mdl");
                  Goal.mdl = "progs/tf_flag.mdl";
                  Goal.skin = 2.000;


               } else {

                 if ( (Goal.mdl == "progs/tf_stan.mdl") || (Goal.mdl == "progs/flag.mdl")  ) {

                     precache_model2 ("progs/tf_flag.mdl");
                     Goal.mdl = "progs/tf_flag.mdl";

                  }
 
               }

            }

         }
         else if ( (toggleflags & 8192))
         {

            if ( (((Goal.mdl == "progs/b_s_key.mdl") || (Goal.mdl == "progs/m_s_key.mdl")) || (Goal.mdl == "progs/w_s_key.mdl")) ) {

               precache_model2 ("progs/tf_stan.mdl");
               Goal.mdl = "progs/tf_stan.mdl";
               Goal.skin = 1.000;

            } else {

               if ( (((Goal.mdl == "progs/b_g_key.mdl") || (Goal.mdl == "progs/m_g_key.mdl")) || (Goal.mdl == "progs/w_g_key.mdl")) ) {

                  precache_model2 ("progs/tf_stan.mdl");
                  Goal.mdl = "progs/tf_stan.mdl";
                  Goal.skin = 2.000;

               } else {

                 if ( (Goal.mdl == "progs/tf_flag.mdl") || (Goal.mdl == "progs/flag.mdl")  ) {

                     precache_model2 ("progs/tf_stan.mdl");
                     Goal.mdl = "progs/tf_stan.mdl";

                  }
 
               }

            }

         }
         else if ( (toggleflags & 16384))
         {

            if ( (((Goal.mdl == "progs/b_s_key.mdl") || (Goal.mdl == "progs/m_s_key.mdl")) || (Goal.mdl == "progs/w_s_key.mdl")) ) {

               precache_model2 ("progs/flag.mdl");
               Goal.mdl = "progs/flag.mdl";
               Goal.skin = 1.000;

            } else {

               if ( (((Goal.mdl == "progs/b_g_key.mdl") || (Goal.mdl == "progs/m_g_key.mdl")) || (Goal.mdl == "progs/w_g_key.mdl")) ) {

                  precache_model2 ("progs/flag.mdl");
                  Goal.mdl = "progs/flag.mdl";
                  Goal.skin = 0.000;

               } else {

                  if ( (Goal.mdl == "progs/tf_flag.mdl") || (Goal.mdl == "progs/tf_stan.mdl")  ) {

                     precache_model2 ("progs/flag.mdl");
                     Goal.mdl = "progs/flag.mdl";
                     if (Goal.skin == 2.000) Goal.skin = 0.000;
                    
                  }

               }

            }

         }


      Goal.has_abbreviated = 1.000;

   }

};



void () TF_PlaceItem = {

   local float oldz;

   self.flags = 256.000;

   self.velocity = '0.000 0.000 0.000';
   if ( (self.goal_activation & 2048.000) ) {

      self.movetype = 6.000;
      self.origin_z = (self.origin_z + 6.000);
      oldz = self.origin_z;
      if ( !droptofloor () ) {

         dprint ("GoalItem fell out of level at ");
         dprint (vtos (self.origin));
         dprint ("\n");
         dremove (self);
         return ;

      }

   }
   self.movetype = 0.000;
   self.oldorigin = self.origin;
   if ( (self.goal_activation & 512.000) ) {

      if (self.owned_by == 1.000) {

          self.effects = (self.effects | 64.000);

      } else {

         if (self.owned_by == 2.000) {

            self.effects = (self.effects | 128.000);

         } else {
            self.effects = (self.effects | 8.000);
         }
      }
 
 
   }
   if ( (item_list_bit == 0.000) ) {

      item_list_bit = 1.000;

   }
   self.item_list = item_list_bit;
   item_list_bit = (item_list_bit * 2.000);

};

void () TF_StartItem = {

   UpdateAbbreviations (self);
   self.nextthink = (time + 0.200);
   self.think = TF_PlaceItem;
   if ( (self.goal_state == 3.000) ) {

      RemoveGoal (self);

   }

};

void () TF_PlaceGoal = {

   local float oldz;

   if ( (self.classname != "info_tfgoal_timer") ) {

      if ( (self.goal_activation & 1.000) ) {

         self.touch = tfgoal_touch;

      }

   } else {

      self.think = tfgoal_timer_tick;
      self.nextthink = (time + self.search_time);
      self.classname = "info_tfgoal";

   }
   if ( (self.goal_activation & 2048.000) ) {

      self.movetype = 6.000;
      self.origin_z = (self.origin_z + 6.000);
      oldz = self.origin_z;
      if ( !droptofloor () ) {

         dprint ("Goal fell out of level at ");
         dprint (vtos (self.origin));
         dprint ("\n");
         dremove (self);
         return ;

      }

   }
   self.flags = 256.000;
   self.movetype = 0.000;
   self.velocity = '0.000 0.000 0.000';
   self.oldorigin = self.origin;

};

void () TF_StartGoal = {

   UpdateAbbreviations (self);
   self.nextthink = (time + 0.200);
   self.think = TF_PlaceGoal;
   self.use = info_tfgoal_use;
   if ( (self.goal_state == 3.000) ) {

      RemoveGoal (self);

   }

};


float () CheckExistence =
{
	UpdateAbbreviations (self);
	skill = cvar ("skill");
	if (((self.ex_skill_min == -1.000) && (skill < 0.000)))
	{
		return (0.000000);
	}
	else
	{
		if (((self.ex_skill_max == -1.000) && (skill > 0.000)))
		{
			return (0.000);
		}
	}
	if (((self.ex_skill_min && (self.ex_skill_min != -1.000)) && (skill < self.ex_skill_min)))
	{
		return (0.000);
	}
	else
	{
		if (((self.ex_skill_max && (self.ex_skill_max != -1.000)) && (skill > self.ex_skill_max)))
		{
			return (0.000);
		}
	}
	return (1.000);
};


void () info_tfdetect = {

   UpdateAbbreviations (self);

};



void () info_player_teamspawn = {


	if ((CheckExistence () == 0.000))
	{
		dremove (self);
		return;
	}

   if ( ((self.team_no <= 0.000) || (self.team_no > 4.000)) ) {

      objerror ("error: bad team_no associated with info_player_teamspawn\n");
      dremove (self);
      return ;

   }


   if ( self.mdl ) {

      precache_model (self.mdl);
      setmodel (self,self.mdl);

   } else {
      precache_model ("progs/tpad.mdl");
      self.mdl = "progs/tpad.mdl";
      setmodel (self,self.mdl);

   }
   self.oldorigin = self.origin;

   StartItem ();

   if ( (store_obs.cnt < self.team_no) ) {

      store_obs.cnt = self.team_no;

   }
   if ( (self.team_no == 1.000) ) {

      self.team_str_home = "ts1";

   } else {

      if ( (self.team_no == 2.000) ) {

         self.team_str_home = "ts2";

      } else {

         if ( (self.team_no == 3.000) ) {

            self.team_str_home = "ts3";

         } else {

            if ( (self.team_no == 4.000) ) {

               self.team_str_home = "ts4";

            }

         }

      }

   }

};



void () i_p_t = {

   self.classname = "info_player_teamspawn";
   info_player_teamspawn ();

};


void () info_tfgoal = {


   if ((CheckExistence () == 0.000))
   {
	dremove (self);
	return;
   }


   if ( self.noise ) {

      precache_sound (self.noise);
      precache_sound2 (self.noise);

   }

   precache_sound ("items/protect.wav");
   precache_sound ("items/protect2.wav");
   precache_sound ("items/protect3.wav");
   precache_sound ("items/suit.wav");
   precache_sound ("items/suit2.wav");
   precache_sound ("items/inv1.wav");
   precache_sound ("items/inv2.wav");
   precache_sound ("items/inv3.wav");
   precache_sound ("items/damage.wav");
   precache_sound ("items/damage2.wav");
   precache_sound ("items/damage3.wav");

   self.solid = 1.000;

   if (bspversion == 30)  
   {
      CheckModel ();


      if (self.model) {
         setmodel (self,self.model);
         self.movetype = 0.000;
         self.modelindex = 0.000;
         self.model = "";

      } else {

         if ( self.mdl ) {

            precache_model (self.mdl);
            precache_model2 (self.mdl);
            setmodel (self,self.mdl);

         }

         if ( (self.goal_min == '0.000 0.000 0.000') ) {

            self.goal_min = '-16.000 -16.000 -24.000';

         }
         if ( (self.goal_max == '0.000 0.000 0.000') ) {

            self.goal_max = '16.000 16.000 32.000';

         }
         setsize (self,self.goal_min,self.goal_max);
      }

       self.use = info_tfgoal_use;
       self.touch = tfgoal_touch;
       UpdateAbbreviations (self);

   } else {

      if ( self.mdl ) {

         precache_model (self.mdl);
         precache_model2 (self.mdl);
         setmodel (self,self.mdl);

      }

      if ( (self.goal_min == '0.000 0.000 0.000') ) {

         self.goal_min = '-16.000 -16.000 -24.000';

      }
      if ( (self.goal_max == '0.000 0.000 0.000') ) {

         self.goal_max = '16.000 16.000 32.000';

      }
      setsize (self,self.goal_min,self.goal_max);
      TF_StartGoal ();
   }


   if ( (self.goal_state == 0.000) ) {

      self.goal_state = 2.000;

   }

};

void () i_t_g = {

   self.classname = "info_tfgoal";
   info_tfgoal ();

};

void () info_tfgoal_timer = {


   if ((CheckExistence () == 0.000))
   {
	dremove (self);
      return;
   }

   if ( self.mdl ) {

      CheckModel  ();
      precache_model (self.mdl);
      precache_model2 (self.mdl);
      setmodel (self,self.mdl);

   }
   if ( self.noise ) {

      precache_sound (self.noise);
      precache_sound2 (self.noise);

   }
   if ( (self.search_time <= 0.000) ) {

      dprint ("Timer Goal created with no specified time.\n");
      dremove (self);

   }
   self.solid = 0.000;
   if ( (self.goal_state == 0.000) ) {

      self.goal_state = 2.000;

   }
   if ( (self.goal_min == '0.000 0.000 0.000') ) {

      self.goal_min = '-16.000 -16.000 -24.000';

   }
   if ( (self.goal_max == '0.000 0.000 0.000') ) {

      self.goal_max = '16.000 16.000 32.000';

   }
   setsize (self,self.goal_min,self.goal_max);
   TF_StartGoal ();

};

void () i_t_t = {

   self.classname = "info_tfgoal_timer";
   info_tfgoal_timer ();

};

void () item_flag_team1;
void () item_flag_team2;

void () item_tfgoal = {

   local string st;

   if ((CheckExistence () == 0.000))
   {
      dremove (self);
	return;
   }

 	st = infokey (world,"ctfmap");

      if ((st == "on")) {
         ctfmap = 1.000;
	}

   if (ctfmap)
   {
      if (self.team_no == 1.000) 
      {
         self.owned_by = 0.000;
         self.team_no = 0.000;
         item_flag_team2();
         return;
      }
      else if (self.team_no == 2.000) 
      {
         self.owned_by = 0.000;
         self.team_no = 0.000;
         item_flag_team1();
         return;
      }
   }

   if ( self.mdl ) {

      CheckModel   ();

      precache_model (self.mdl);
      precache_model2 (self.mdl);
      setmodel (self,self.mdl);

   } else {

      self.mdl = "";
      setmodel (self,"");

   }
   precache_sound2 ("items/itembk2.wav");
   if ( self.noise ) {

      precache_sound (self.noise);
      precache_sound2 (self.noise);

   }
   self.touch = item_tfgoal_touch;
   if ( (self.goal_state == 0.000) ) {

      self.goal_state = 2.000;

   }
   if ( (self.goal_activation & 8192.000) || (toggleflags & 16.000 )) {

      self.solid = 2.000;

   } else {

      self.solid = 1.000;

   }
   setorigin (self,self.origin);
   if ( !self.netname ) {

      self.netname = "goalitem";

   }
   if ( (self.pausetime <= 0.000) ) {

      self.pausetime = 45.000;

   }
   if ( ((self.delay != 0.000) && (self.pausetime == 0.000)) ) {

      self.pausetime = self.delay;

   }
   if ( (self.goal_min == '0.000 0.000 0.000') ) {

      self.goal_min = '-16.000 -16.000 -24.000';

   }
   if ( (self.goal_max == '0.000 0.000 0.000') ) {

      self.goal_max = '16.000 16.000 32.000';

   }

   setsize (self,self.goal_min,self.goal_max);
   TF_StartItem ();

};

void (entity AD) ParseTFDetect = {

   local float fl;

   if ( (AD.team_broadcast != string_null) ) {

      team_menu_string = AD.team_broadcast;

   }
   localcmd (AD.message);
   cvar_set ("sv_maxspeed","600");

   if ( (AD.hook_out == 1.000) ) {

      allow_hook = 1.000;

   }

   fl = stof(infokey (world,"t1maxplayers"));
   if (fl) {
      AD.ammo_medikit = fl;
   }

   fl = stof(infokey (world,"t2maxplayers"));
   if (fl) {
      AD.ammo_detpack = fl;
   }

   fl = stof(infokey (world,"t3maxplayers"));
   if (fl) {
      AD.maxammo_medikit = fl;
   }

   fl = stof(infokey (world,"t4maxplayers"));
   if (fl) {
      AD.maxammo_detpack = fl;
   }

   if ( (AD.ammo_medikit < 1.000) ) {

      AD.ammo_medikit = 100.000;

   }
   if ( (AD.ammo_detpack < 1.000) ) {

      AD.ammo_detpack = 100.000;

   }
   if ( (AD.maxammo_medikit < 1.000) ) {

      AD.maxammo_medikit = 100.000;

   }
   if ( (AD.maxammo_detpack < 1.000) ) {

      AD.maxammo_detpack = 100.000;

   }

   pteam1.maxplayers = AD.ammo_medikit;
   pteam2.maxplayers = AD.ammo_detpack;
   pteam3.maxplayers = AD.maxammo_medikit;
   pteam4.maxplayers = AD.maxammo_detpack;

   store_obs.ammo_nails = AD.playerclass;

   fl = stof(infokey (world,"t1illclasses"));
   if (fl) {
      AD.maxammo_shells = fl;
   }

   fl = stof(infokey (world,"t2illclasses"));
   if (fl) {
      AD.maxammo_nails = fl;
   }

   fl = stof(infokey (world,"t3illclasses"));
   if (fl) {
      AD.maxammo_rockets = fl;
   }

   fl = stof(infokey (world,"t4illclasses"));
   if (fl) {
      AD.maxammo_cells = fl;
   }

   store_obs.maxammo_shells = 0.000;
   if ( (AD.maxammo_shells == -1.000) ) {

      store_obs.maxammo_shells = (store_obs.maxammo_shells | 1.000);

   }
   if ( (AD.maxammo_nails == -1.000) ) {

      store_obs.maxammo_shells = (store_obs.maxammo_shells | 2.000);

   }
   if ( (AD.maxammo_rockets == -1.000) ) {

      store_obs.maxammo_shells = (store_obs.maxammo_shells | 4.000);

   }
   if ( (AD.maxammo_cells == -1.000) ) {

      store_obs.maxammo_shells = (store_obs.maxammo_shells | 8.000);

   }

};
entity (float ino) Finditem = {

   local entity tg;
   local string st;

   tg = find (world,classname,"item_tfgoal");
   while ( tg ) {

      if ( (tg.goal_no == ino) ) {

         return ( tg );

      }
      tg = find (tg,classname,"item_tfgoal");

   }
   dprint ("Could not find an item with a goal_no of ");
   st = ftos (ino);
   dprint (st);
   dprint (".\n");
   return(world);

};
entity (float gno) Findgoal = {

   local entity tg;
   local string st;

   tg = find (world,classname,"info_tfgoal");
   while ( tg ) {

      if ( (tg.goal_no == gno) ) {

         return ( tg );

      }
      tg = find (tg,classname,"info_tfgoal");

   }
   dprint ("Could not find a goal with a goal_no of ");
   st = ftos (gno);
   dprint (st);
   dprint (".\n");
   return(world);

};
entity (float gno) Findteamspawn = {

   local entity tg;
   local string st;

   tg = find (world,classname,"info_player_teamspawn");
   while ( tg ) {

      if ( (tg.goal_no == gno) ) {

         return ( tg );

      }
      tg = find (tg,classname,"info_player_teamspawn");

   }
   dprint ("Could not find a Teamspawn with a goal_no of ");
   st = ftos (gno);
   dprint (st);
   dprint (".\n");
   return(world);

};

void (entity Goal) InactivateGoal = {

   if ( (Goal.goal_state == 1.000) ) {

      if ( (Goal.search_time == 0.000) )
      {
            if ( ((Goal.goal_activation & 8192.000) || (toggleflags & 16.000)) && (Goal.classname == "item_tfgoal") )
		{
			Goal.solid = 2.000;
		}
		else
		{
			Goal.solid = 1.000;
		}

      }
      Goal.goal_state = 2.000;
      if ( (Goal.mdl != string_null) ) {

         setmodel (Goal,Goal.mdl);

      }

   }


};

void (entity Goal) RestoreGoal = {


   if ( (Goal.goal_state == 3.000) ) {

      if ( (Goal.search_time == 0.000) ) {

            if ( ((Goal.goal_activation & 8192.000) || (toggleflags & 16.000)) && (Goal.classname == "item_tfgoal"))
		{
			Goal.solid = 2.000;
		}
		else
		{
			Goal.solid = 1.000;
		}
         

      } else {

         Goal.nextthink = (time + Goal.search_time);

      }
      Goal.goal_state = 2.000;
      if ( (Goal.mdl != string_null) ) {

         setmodel (Goal,Goal.mdl);

      }

   }

};

void (entity Goal) RemoveGoal = {

   Goal.solid = 0.000;
   Goal.goal_state = 3.000;
   if ( (Goal.mdl != string_null) ) {

      setmodel (Goal,string_null);

   }

};
float (entity Goal, entity Player, entity AP) IsAffectedBy = {

   local float genv;

   if ( (!Player.playerclass ) ) {

      return ( 0.000 );

   }
   if ( (Goal.goal_effects & 32.000) ) {

      genv = pointcontents (Goal.origin);
      if ( (pointcontents (Player.origin) != genv) ) {

         return ( 0.000 );

      }

   }
   if ( (Goal.t_length != 0.000) ) {

      if ( (vlen ((Goal.origin - Player.origin)) <= Goal.t_length) ) {

         if ( (Goal.goal_effects & 16.000) ) {

            traceline (Goal.origin,Player.origin,1.000,Goal);
            if ( (trace_fraction == 1.000) ) {

               return ( 1.000 );

            }

         } else {

            return ( 1.000 );

         }

      }

   }
   if ( (Goal.classname != "info_tfgoal_timer") ) {

      if ( ((Goal.goal_effects & 1.000) && (Player == AP)) ) {

         return ( 1.000 );

      }
      if ( ((Goal.goal_effects & 2.000) && (AP.pteam == Player.pteam)) ) {

         return ( 1.000 );

      }
      if ( ((Goal.goal_effects & 4.000) && (AP.pteam != Player.pteam)) ) {

         return ( 1.000 );

      }
      if ( ((Goal.goal_effects & 8.000) && (Player != AP)) ) {

         return ( 1.000 );

      }

   }
   if ( ((Goal.maxammo_shells != 0.000) && (Player.pteam.team == Goal.maxammo_shells)) ) {

      return ( 1.000 );

   }
   if ( ((Goal.maxammo_nails != 0.000) && (Player.pteam.team != Goal.maxammo_shells)) ) {

      return ( 1.000 );

   }
   return ( 0.000 );

};


void (entity Goal, entity Player, entity AP, float addb) Apply_Results = {

   local entity oldself;
   local entity te;
   local entity oldte;
   local float captime;
   local string st;

   stuffcmd (Player,"bf\n");
   if ( (Goal.classname == "item_tfgoal") ) {

      Player.item_list = (Player.item_list | Goal.item_list);

   }

   if ( (Player == AP) ) {

      if ( (Goal.count > 0.000) ) {

         if ( (Player.pteam.team > 0.000) ) {

            if (rounds) {

              if (modetype & 16) {

                 te = find (world,classname,"round");

                 captime = time - te.invisible_time;

                 if (( captime != 0.000 )) {
			   st = ftos(captime);
		         bprint (2.000,Player.netname);
  			   bprint (2.000," Captured the flag in ");
		         bprint (2.000,st);
			   bprint (2.000," seconds\n");
		     }
            
               }
               if(round_active) round_winner = Player.pteam;
            }

            Player.flag_captures = Player.flag_captures + 1.000;
            if (Player.StatusBarSize) 
                Player.StatusRefreshTime = (time + 0.100);
            TeamFortress_TeamIncreaseScore (Player.pteam.team,Goal.count);
            TeamFortress_TeamShowScores (2.000);

         }

      }

   }
   if ( addb ) {

         if ( (Player.health > 0.000) ) {

            if ( (Goal.health > 0.000) ) {

               T_Heal (Player,Goal.health,0.000);

            }
            if ( (Goal.health < 0.000) ) {

               if ( ((0.000 - Player.health) > Goal.health) ) {

                  TF_T_Damage (Player,Goal,Goal,(Player.health - Goal.health),1.000,0.000);

               } else {

                  TF_T_Damage (Player,Goal,Goal,(0.000 - Goal.health),1.000,0.000);

               }

            }

         }
         if ( (Player.health > 0.000) ) {

            if ( (Goal.armortype > 0.000) ) {

               Player.armortype = Goal.armortype;

            } else {

               if ( (Goal.armorvalue > 0.000) ) {

                  Player.armortype = Player.armor_allowed;

               }

            }
            Player.armorvalue = (Player.armorvalue + Goal.armorvalue);
            if ( (Goal.armorclass > 0.000) ) {

               Player.armorclass = Goal.armorclass;

            }

            Player.ammo_shells = (Player.ammo_shells + Goal.ammo_shells);
            Player.ammo_nails = (Player.ammo_nails + Goal.ammo_nails);
            Player.ammo_rockets = (Player.ammo_rockets + Goal.ammo_rockets);
            Player.ammo_cells = (Player.ammo_cells + Goal.ammo_cells);
            Player.ammo_medikit = (Player.ammo_medikit + Goal.ammo_medikit);
            Player.ammo_detpack = (Player.ammo_detpack + Goal.ammo_detpack);
            Player.no_grenades_1 = (Player.no_grenades_1 + Goal.no_grenades_1);
            Player.no_grenades_2 = (Player.no_grenades_2 + Goal.no_grenades_2);
            if ( (Player.no_grenades_1 > 4.000) ) {

               Player.no_grenades_1 = 4.000;

            }
            if ( (Player.no_grenades_2 > 4.000) ) {

               Player.no_grenades_2 = 4.000;

            }
            if ( ((Player.tp_grenades_1 == 3.000) && (Player.no_grenades_1 > 2.000)) ) {

               Player.no_grenades_1 = 2.000;

            }
            if ( ((Player.tp_grenades_2 == 3.000) && (Player.no_grenades_2 > 2.000)) ) {

               Player.no_grenades_2 = 2.000;

            }
            if ( (Player.ammo_detpack > Player.maxammo_detpack) ) {

               Player.ammo_detpack = Player.maxammo_detpack;

            }
            if ( (Player.tfstate & 1.000) ) {

               te = find (world,classname,"primer");
               while ( te ) {

                  if ( (te.owner == Player) ) {

                     if ( ((te.impulse == 151.000) && (Player.no_grenades_2 <= 0.000)) ) {

                        Player.tfstate = (Player.tfstate - (Player.tfstate & 1.000));
                        Player.tfstate = (Player.tfstate - (Player.tfstate & 1024.000));
                        dremove (te);

                     } else {

                        if ( ((te.impulse == 150.000) && (Player.no_grenades_1 <= 0.000)) ) {

                           Player.tfstate = (Player.tfstate - (Player.tfstate & 1.000));
                           Player.tfstate = (Player.tfstate - (Player.tfstate & 1024.000));
                           dremove (te);

                        }

                     }
                  te = world;

                  } else {

                     te = find (te,classname,"primer");

                  }

               }

            }
            if ( (Goal.invincible_finished > 0.000) ) {

               Player.items = (Player.items | 1048576.000);
               Player.invincible_time = 1.000;
               Player.invincible_finished = (time + Goal.invincible_finished);
               if ( (Goal.classname == "item_tfgoal") ) {

                  Player.tfstate = (Player.tfstate | 32.000);
                  Player.invincible_finished = (time + 666.000);

               }

            }
            if ( (Goal.invisible_finished > 0.000) ) {

               Player.items = (Player.items | 524288.000);
               Player.invisible_time = 1.000;
               Player.invisible_finished = (time + Goal.invisible_finished);
               if ( (Goal.classname == "item_tfgoal") ) {

                  Player.tfstate = (Player.tfstate | 64.000);
                  Player.invisible_finished = (time + 666.000);

               }

            }
            if ( (Goal.super_damage_finished > 0.000) ) {

               Player.items = (Player.items | 4194304.000);
               Player.super_time = 1.000;
               Player.super_damage_finished = (time + Goal.super_damage_finished);
               if ( (Goal.classname == "item_tfgoal") ) {

                  Player.tfstate = (Player.tfstate | 128.000);
                  Player.super_damage_finished = (time + 666.000);

               }

            }
            if ( (Goal.radsuit_finished > 0.000) ) {

               Player.items = (Player.items | 2097152.000);
               Player.rad_time = 1.000;
               Player.radsuit_finished = (time + Goal.radsuit_finished);
               if ( (Goal.classname == "item_tfgoal") ) {

                  Player.tfstate = (Player.tfstate | 256.000);
                  Player.radsuit_finished = (time + 666.000);

               }

            }

         }

      if ( Goal.frags ) {

         if ( ((Goal.goal_effects == 1.000) || !(toggleflags & 2048.000)) ) {

            TF_AddFrags (Player,Goal.frags, 0.000);
         }

      }
      oldself = self;
      self = Player;
      TeamFortress_CheckClassStats ();
      W_SetCurrentAmmo ();
      self = oldself;

   }
   if ( ((Player.playerclass == 8.000) && (Goal.goal_result & 16.000)) ) {

      //self.immune_to_check = (time + 5.000);
      Spy_RemoveDisguise (Player);

   }
   if ( ((Goal.items != 0.000) && (Goal.classname != "item_tfgoal")) ) {

      te = Finditem (Goal.items);
      if ( ((te != world) && (te != Goal)) ) {

         tfgoalitem_GiveToPlayer (te,Player,Goal);

      }

   }
   if ( (Goal.axhitme != 0.000) ) {

      te = Finditem (Goal.axhitme);
      if ( (te.owner == Player) ) {

         tfgoalitem_RemoveFromPlayer (te,Player,1.000);

      }

   }
   if ( (Goal.remove_item_group != 0.000) ) {

      te = find (world,classname,"item_tfgoal");
      while ( te ) {

         if ( ((te.group_no == Goal.remove_item_group) && (te.owner == AP)) ) {

            oldte = te;
            te = find (te,classname,"item_tfgoal");
            tfgoalitem_RemoveFromPlayer (oldte,Player,1.000);

         } else {

            te = find (te,classname,"item_tfgoal");

         }

      }

   }
   if ( (Goal.display_item_status1 != 0.000) ) {

      te = Finditem (Goal.display_item_status1);
      if ( te ) {

         sprint (Player,2.000, ItemStatus (Goal,Player,te));

      } else {

         sprint (Player,2.000,"Item is missing.\n");

      }

   }
   if ( (Goal.display_item_status2 != 0.000) ) {

      te = Finditem (Goal.display_item_status2);
      if ( te ) {

         sprint (Player,2.000, ItemStatus (Goal,Player,te));

      } else {

         sprint (Player,2.000,"Item is missing.\n");

      }

   }
   if ( (Goal.display_item_status3 != 0.000) ) {

      te = Finditem (Goal.display_item_status3);
      if ( te ) {

         sprint (Player,2.000, ItemStatus (Goal,Player,te));

      } else {

         sprint (Player,2.000,"Item is missing.\n");

      }

   }
   if ( (Goal.display_item_status4 != 0.000) ) {

      te = Finditem (Goal.display_item_status4);
      if ( te ) {

         sprint (Player,2.000, ItemStatus (Goal,Player,te));

      } else {

         sprint (Player,2.000,"Item is missing.\n");

      }

   }
   if ( (Goal.goal_result & 32.000) ) {

      ForceRespawn (Player);

   }

};



void (entity Goal, entity Player) RemoveResults = {

   local entity oldself;
   local entity te;
   local float puinvin;
   local float puinvis;
   local float puquad;
   local float purad;

   if ( (Goal.classname == "item_tfgoal") ) {

      if ( !(Player.item_list & Goal.item_list) ) {

         return ;

      }
      if ( (Goal.goal_activation & 1024.000) ) {

         return ;

      }
      Player.item_list = (Player.item_list - (Player.item_list & Goal.item_list));

   }

   if ( (Goal.health > 0.000) ) {

      TF_T_Damage (Player,Goal,Goal,Goal.health,1.000,0.000);

   }
   if ( (Goal.health < 0.000) ) {

      T_Heal (Player,(0.000 - Goal.health),0.000);

   }

   Player.armortype = (Player.armortype - Goal.armortype);
   Player.armorvalue = (Player.armorvalue - Goal.armorvalue);
   Player.armorclass = (Player.armorclass - (Player.armorclass & Goal.armorclass));
   

   if ( Goal.frags ) {

      if ( ((Goal.goal_effects == 1.000) || !(toggleflags & 2048.000)) ) {

         TF_AddFrags (Player,Goal.frags, 0.000);
      }

   }
   Player.ammo_shells = (Player.ammo_shells - Goal.ammo_shells);
   Player.ammo_nails = (Player.ammo_nails - Goal.ammo_nails);
   Player.ammo_rockets = (Player.ammo_rockets - Goal.ammo_rockets);
   Player.ammo_cells = (Player.ammo_cells - Goal.ammo_cells);
   Player.ammo_medikit = (Player.ammo_medikit - Goal.ammo_medikit);
   Player.ammo_detpack = (Player.ammo_detpack - Goal.ammo_detpack);
   Player.no_grenades_1 = (Player.no_grenades_1 - Goal.no_grenades_1);
   Player.no_grenades_2 = (Player.no_grenades_2 - Goal.no_grenades_2);
   if ( (Player.no_grenades_1 > 4.000) ) {

      Player.no_grenades_1 = 4.000;

   }
   if ( (Player.no_grenades_2 > 4.000) ) {

      Player.no_grenades_2 = 4.000;

   }
   if ( ((Player.tp_grenades_1 == 3.000) && (Player.no_grenades_1 > 2.000)) ) {

      Player.no_grenades_1 = 2.000;

   }
   if ( ((Player.tp_grenades_2 == 3.000) && (Player.no_grenades_2 > 2.000)) ) {

      Player.no_grenades_2 = 2.000;

   }
   if ( (Player.ammo_detpack > Player.maxammo_detpack) ) {

      Player.ammo_detpack = Player.maxammo_detpack;

   }
   if ( (Player.tfstate & 1.000) ) {

      te = find (world,classname,"primer");
      while ( te ) {

         if ( (te.owner == Player) ) {

            if ( ((te.impulse == 151.000) && (Player.no_grenades_2 <= 0.000)) ) {

               Player.tfstate = (Player.tfstate - (Player.tfstate & 1.000));
               Player.tfstate = (Player.tfstate - (Player.tfstate & 1024.000));
               dremove (te);

            } else {

               if ( ((te.impulse == 150.000) && (Player.no_grenades_1 <= 0.000)) ) {

                  Player.tfstate = (Player.tfstate - (Player.tfstate & 1.000));
                  Player.tfstate = (Player.tfstate - (Player.tfstate & 1024.000));
                  dremove (te);

               }

            }
            te = world;

         } else {

            te = find (te,classname,"primer");

         }

      }

   }
   puinvin = 0.000;
   puinvis = 0.000;
   puquad = 0.000;
   purad = 0.000;
   te = find (world,classname,"item_tfgoal");
   while ( te ) {

      if ( ((te.owner == Player) && (te != Goal)) ) {

         if ( (te.invincible_finished > 0.000) ) {

            puinvin = 1.000;

         }
         if ( (te.invisible_finished > 0.000) ) {

            puinvis = 1.000;

         }
         if ( (te.super_damage_finished > 0.000) ) {

            puquad = 1.000;

         }
         if ( (te.radsuit_finished > 0.000) ) {

            purad = 1.000;

         }

      }
      te = find (te,classname,"item_tfgoal");

   }
   if ( ((Goal.invincible_finished > 0.000) && !puinvin) ) {

      Player.tfstate = (Player.tfstate - (Player.tfstate & 32.000));
      Player.items = (Player.items | 1048576.000);
      Player.invincible_time = 1.000;
      Player.invincible_finished = (time + Goal.invincible_finished);

   }
   if ( ((Goal.invisible_finished > 0.000) && !puinvis) ) {

      Player.tfstate = (Player.tfstate - (Player.tfstate & 64.000));
      Player.items = (Player.items | 524288.000);
      Player.invisible_time = 1.000;
      Player.invisible_finished = (time + Goal.invisible_finished);

   }
   if ( ((Goal.super_damage_finished > 0.000) && !puquad) ) {

      Player.tfstate = (Player.tfstate - (Player.tfstate & 128.000));
      Player.items = (Player.items | 4194304.000);
      Player.super_time = 1.000;
      Player.super_damage_finished = (time + Goal.super_damage_finished);

   }
   if ( ((Goal.radsuit_finished > 0.000) && !purad) ) {

      Player.tfstate = (Player.tfstate - (Player.tfstate & 256.000));
      Player.items = (Player.items | 2097152.000);
      Player.rad_time = 1.000;
      Player.radsuit_finished = (time + Goal.radsuit_finished);

   }
   oldself = self;
   self = Player;
   TeamFortress_CheckClassStats ();
   W_SetCurrentAmmo ();
   self = oldself;

};


float (entity Goal,entity AP) APMeetsCriteria =
{
	local float gotone;
	local entity te;

	if ((AP != world))
	{
		if (Goal.team_no)
		{
			if ((Goal.team_no != AP.pteam.team))
			{
				return (0.000000);
			}
		}
		if (Goal.playerclass)
		{
			if ((Goal.playerclass != AP.playerclass))
			{
				return (0.000000);
			}
		}
		if (Goal.items_allowed)
		{
			te = Finditem (Goal.items_allowed);
			if ((te.owner != AP))
			{
				return (0.000000);
			}
		}
	}
	if (Goal.if_goal_is_active)
	{
		te = Findgoal (Goal.if_goal_is_active);
		if ((te.goal_state != 1))
		{
			return (0.000000);
		}
	}
	if (Goal.if_goal_is_inactive)
	{
		te = Findgoal (Goal.if_goal_is_inactive);
		if ((te.goal_state != 2))
		{
			return (0.000000);
		}
	}
	if (Goal.if_goal_is_removed)
	{
		te = Findgoal (Goal.if_goal_is_removed);
		if ((te.goal_state != 3))
		{
			return (0.000000);
		}
	}
	if (Goal.if_group_is_active)
	{
		te = find (world, classname, "info_tfgoal");
		while (te)
		{
			if ((te.group_no == Goal.if_group_is_active))
			{
				if ((te.goal_state != 1))
				{
					return (0.000000);
				}
			}
			te = find (te, classname, "info_tfgoal");
		}
	}
	if (Goal.if_group_is_inactive)
	{
		te = find (world, classname, "info_tfgoal");
		while (te)
		{
			if ((te.group_no == Goal.if_group_is_inactive))
			{
				if ((te.goal_state != 2))
				{
					return (0.000000);
				}
			}
			te = find (te, classname, "info_tfgoal");
		}
	}
	if (Goal.if_group_is_removed)
	{
		te = find (world, classname, "info_tfgoal");
		while (te)
		{
			if ((te.group_no == Goal.if_group_is_removed))
			{
				if ((te.goal_state != 3))
				{
					return (0.000000);
				}
			}
			te = find (te, classname, "info_tfgoal");
		}
	}
	if (Goal.if_item_has_moved)
	{
		te = Finditem (Goal.if_item_has_moved);
		if (te)
		{
			if (((te.goal_state != 1) && (te.origin == te.oldorigin)))
			{
				return (0.000000);
			}
		}
	}
	if (Goal.if_item_hasnt_moved)
	{
		te = Finditem (Goal.if_item_hasnt_moved);
		if (te)
		{
			if (((te.goal_state == 1) || (te.origin != te.oldorigin)))
			{
				return (0.000000);
			}
		}
	}
	if ((AP != world))
	{
		gotone = 0.000000;
		if (Goal.has_item_from_group)
		{
			te = find (world, classname, "item_tfgoal");
			while (((te != world) && !gotone))
			{
				if (((te.group_no == Goal.has_item_from_group) && (te.owner == AP)))
				{
					gotone = 1;
				}
				te = find (te, classname, "item_tfgoal");
			}
			if (!gotone)
			{
				return (0.000000);
			}
		}
		if (Goal.hasnt_item_from_group)
		{
			te = find (world, classname, "item_tfgoal");
			while (((te != world) && !gotone))
			{
				if (((te.group_no == Goal.hasnt_item_from_group) && (te.owner == AP)))
				{
					return (0.000000);
				}
				te = find (te, classname, "item_tfgoal");
			}
		}
	}


	return (1.000);
};


void (entity Goal) SetupRespawn = {

   if ( (Goal.search_time != 0.000) ) {

      InactivateGoal (Goal);
      Goal.think = tfgoal_timer_tick;
      Goal.nextthink = (time + Goal.search_time);
      return ;

   }
   if ( (Goal.goal_result & 1.000) ) {

      RemoveGoal (Goal);
      return ;

   }
   if ( (Goal.wait > 0.000) ) {

      Goal.nextthink = (time + Goal.wait);
      Goal.think = DoRespawn;
      return ;

   } else {

      if ( (Goal.wait == -1.000) ) {

         return ;

      }

   }
   InactivateGoal (Goal);

};

void () DoRespawn = {

   RestoreGoal (self);
   InactivateGoal (self);

};
float (entity Goal, entity AP) Activated = {

   local float APMet;
   local float RevAct;
   local float Act;

   if ( (Goal.goal_state == 1.000) ) {

      return ( 0.000 );

   }
   if ( (Goal.goal_state == 3.000) ) {

      return ( 0.000 );

   }
   if ( (Goal.goal_state == 4.000) ) {

      return ( 0.000 );

   }
   APMet = APMeetsCriteria (Goal,AP);
   if ( (Goal.classname == "item_tfgoal") ) {

      RevAct = (Goal.goal_activation & 64.000);

   } else {

      RevAct = (Goal.goal_activation & 4.000);

   }
   Act = 0.000;
   if ( APMet ) {

      if ( !RevAct ) {

         Act = 1.000;

      }

   } else {

      if ( RevAct ) {

         Act = 1.000;

      }

   }
   return ( Act );

};

void (entity Goal, entity AP, entity ActivatingGoal) AttemptToActivate = {

   local entity te;

   if (cb_prematch) return;

   if (round_over) return;

   if ( Activated (Goal,AP) ) {
	

      if ( (ActivatingGoal == Goal) ) {

         DoResults (Goal,AP,1.000);

      } else {

         if ( (ActivatingGoal != world) ) {

            DoResults (Goal,AP,(ActivatingGoal.goal_result & 2.000));

         } else {

            DoResults (Goal,AP,0.000);

         }

      }

   } else {

      if ( (Goal.else_goal != 0.000) ) {

         te = Findgoal (Goal.else_goal);
         if ( te ) {

            AttemptToActivate (te,AP,Goal);

         }

      }

   }

};

void (entity Goal, entity AP) DoGoalWork = {

   local entity te;
   local entity RI;

   if ( (Goal.activate_goal_no != 0.000) ) {

      te = Findgoal (Goal.activate_goal_no);
      if ( te ) {

         AttemptToActivate (te,AP,Goal);

      }

   }
   if ( (Goal.inactivate_goal_no != 0.000) ) {

      te = Findgoal (Goal.inactivate_goal_no);
      if ( te ) {

         InactivateGoal (te);

      }

   }
   if ( (Goal.restore_goal_no != 0.000) ) {

      te = Findgoal (Goal.restore_goal_no);
      if ( te ) {

         RestoreGoal (te);

      }

   }
   if ( (Goal.remove_goal_no != 0.000) ) {

      te = Findgoal (Goal.remove_goal_no);
      if ( te ) {

         RemoveGoal (te);

      }

   }
   if ( (Goal.return_item_no != 0.000) ) {

      te = Finditem (Goal.return_item_no);
      if ( te ) {

         if ( (te.goal_state == 1.000) ) {

            tfgoalitem_RemoveFromPlayer (te,te.owner,1.000);

         }
         RI = spawn ();
         RI.enemy = te;
         RI.weapon = 2.000;
         RI.think = ReturnItem;
         RI.nextthink = (time + 0.100);
         te.solid = 0.000;

      }

   }
   if ( (Goal.remove_spawnpoint != 0.000) ) {

      te = Findteamspawn (Goal.remove_spawnpoint);
      if ( te ) {

         te.goal_state = 3.000;
         te.team_str_home = string_null;

      }

   }
   if ( (Goal.restore_spawnpoint != 0.000) ) {

      te = Findteamspawn (Goal.restore_spawnpoint);
      if ( te ) {

         if ( (te.goal_state == 3.000) ) {

            te.goal_state = 2.000;
            if ( (te.team_no == 1.000) ) {

               te.team_str_home = "ts1";

            } else {

               if ( (te.team_no == 2.000) ) {

                  te.team_str_home = "ts2";

               } else {

                  if ( (te.team_no == 3.000) ) {

                     te.team_str_home = "ts3";

                  } else {

                     if ( (te.team_no == 4.000) ) {

                        te.team_str_home = "ts4";

                     }

                  }

               }

            }

         }

      }

   }

};

void (entity Goal, entity AP) DoGroupWork = {

   local string st;
   local entity tg;
   local float allset;

   if ( (Goal.all_active != 0.000) ) {

      if ( (Goal.last_impulse == 0.000) ) {

         dprint ("Goal ");
         st = ftos (Goal.goal_no);
         dprint (st);
         dprint (" has a .all_active specified, but no .last_impulse\n");

      } else {

         allset = 1.000;
         tg = find (world,classname,"info_tfgoal");
         while ( tg ) {

            if ( (tg.group_no == Goal.all_active) ) {

               if ( (tg.goal_state != 1.000) ) {

                  allset = 0.000;

               }

            }
            tg = find (tg,classname,"info_tfgoal");

         }
         if ( allset ) {

            tg = Findgoal (Goal.last_impulse);
            if ( tg ) {

               DoResults (tg,AP,(Goal.goal_result & 2.000));

            }

         }

      }

   }
   if ( (Goal.activate_group_no != 0.000) ) {

      tg = find (world,classname,"info_tfgoal");
      while ( tg ) {

         if ( (tg.group_no == Goal.activate_group_no) ) {

            DoResults (tg,AP,0.000);

         }
         tg = find (tg,classname,"info_tfgoal");

      }

   }
   if ( (Goal.inactivate_group_no != 0.000) ) {

      tg = find (world,classname,"info_tfgoal");
      while ( tg ) {

         if ( (tg.group_no == Goal.inactivate_group_no) ) {

            InactivateGoal (tg);

         }
         tg = find (tg,classname,"info_tfgoal");

      }

   }
   if ( (Goal.remove_group_no != 0.000) ) {

      tg = find (world,classname,"info_tfgoal");
      while ( tg ) {

         if ( (tg.group_no == Goal.remove_group_no) ) {

            RemoveGoal (tg);

         }
         tg = find (tg,classname,"info_tfgoal");

      }

   }
   if ( (Goal.restore_group_no != 0.000) ) {

      tg = find (world,classname,"info_tfgoal");
      while ( tg ) {

         if ( (tg.group_no == Goal.restore_group_no) ) {

            RestoreGoal (tg);

         }
         tg = find (tg,classname,"info_tfgoal");

      }

   }
   if ( (Goal.remove_spawngroup != 0.000) ) {

      tg = find (world,classname,"info_player_teamspawn");
      while ( tg ) {

         if ( (tg.group_no == Goal.remove_spawngroup) ) {

            tg.goal_state = 3.000;
            tg.team_str_home = string_null;

         }
         tg = find (tg,classname,"info_player_teamspawn");

      }

   }
   if ( (Goal.restore_spawngroup != 0.000) ) {

      tg = find (world,classname,"info_player_teamspawn");
      while ( tg ) {

         if ( (tg.group_no == Goal.restore_spawngroup) ) {

            tg.goal_state = 2.000;
            if ( (tg.team_no == 1.000) ) {

               tg.team_str_home = "ts1";

            } else {

               if ( (tg.team_no == 2.000) ) {

                  tg.team_str_home = "ts2";

               } else {

                  if ( (tg.team_no == 3.000) ) {

                     tg.team_str_home = "ts3";

                  } else {

                     if ( (tg.team_no == 4.000) ) {

                        tg.team_str_home = "ts4";

                     }

                  }

               }

            }

         }
         tg = find (tg,classname,"info_player_teamspawn");

      }

   }

};

void (entity Item, entity AP) DoItemGroupWork = {

   local entity tg;
   local entity carrier;
   local float allcarried;
   local string st;

   allcarried = 1.000;
   if ( (Item.distance != 0.000) ) {

      if ( (Item.pain_finished == 0.000) ) {

         dprint ("GoalItem ");
         st = ftos (Item.goal_no);
         dprint (st);
         dprint (" has a .distance specified, but no .pain_finished\n");

      }
      tg = find (world,classname,"item_tfgoal");
      while ( tg ) {

         if ( (tg.group_no == Item.distance) ) {

            if ( (tg.goal_state != 1.000) ) {

               allcarried = 0.000;

            }

         }
         tg = find (tg,classname,"item_tfgoal");

      }
      if ( (allcarried == 1.000) ) {

         tg = Findgoal (Item.pain_finished);
         if ( tg ) {

            DoResults (tg,AP,(Item.goal_result & 2.000));

         }

      }

   }
   allcarried = 1.000;
   if ( (Item.speed != 0.000) ) {

      if ( (Item.attack_finished == 0.000) ) {

         dprint ("GoalItem ");
         st = ftos (Item.goal_no);
         dprint (st);
         dprint (" has a .speed specified, but no .attack_finished\n");

      }
      carrier = world;
      tg = find (world,classname,"item_tfgoal");
      while ( tg ) {

         if ( (tg.group_no == Item.speed) ) {

            if ( (tg.goal_state != 1.000) ) {

               allcarried = 0.000;

            } else {

               if ( (carrier == world) ) {

                  carrier = tg.owner;

               } else {

                  if ( (carrier != tg.owner) ) {

                     allcarried = 0.000;

                  }

               }

            }

         }
         tg = find (tg,classname,"item_tfgoal");

      }
      if ( (allcarried == 1.000) ) {

         tg = Findgoal (Item.attack_finished);
         if ( tg ) {

            DoResults (tg,AP,(Item.goal_result & 2.000));

         }

      }

   }

};

void (entity Goal, entity AP) DoTriggerWork = {

   local entity t;

   if ( Goal.killtarget ) {

      t = world;
      do {

         t = find (t,targetname,Goal.killtarget);
         if ( (t != world) ) {

            dremove (t);

         }

      } while ( (t != world) );

   }
   if ( Goal.target ) {

      t = world;
      activator = AP;
      do {

         t = find (t,targetname,Goal.target);
         if ( (t == world) ) {

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
         activator = AP;

      } while ( (t != world) );

   }

};

void () DelayedResult = {

   if ( (self.enemy.goal_state == 4.000) ) {

      DoResults (self.enemy,self.owner,self.weapon);

   }
   dremove (self);

};


void (entity te) PrintSelfCTF = {

   local float winners;

   winners = floor ( random () * 8);

                        if ( (winners < 1.000) ) {

                           CenterPrint2 (te,"\n\n\n","You got the enemy flag!\n\nFlee!");

                        } else {

                           if ( (winners < 2.000) ) {

                              CenterPrint2 (te,"\n\n\n","You got the enemy flag!\n\nHead for home!");

                           } else {

                              if ( (winners < 4.000) ) {

                                 CenterPrint2 (te,"\n\n\n","You got the enemy flag!\n\nReturn to base!");

                              } else {

                                 if ( (winners < 5.00) ) {

                                    CenterPrint2 (te,"\n\n\n","You got the enemy flag!\n\n<Insert witty comment here>");

                                 } else {

                                    if ( (winners < 6.000) ) {

                                       CenterPrint2 (te,"\n\n\n","You got the enemy flag!\n\nZed's dead baby, Zed's dead...");

                                    } else {

                                       if ( (winners < 7.000) ) {

                                          CenterPrint2 (te,"\n\n\n","You got the enemy flag!\n\n");

                                       } else {

                                          CenterPrint2 (te,"\n\n\n","Is that a flag in your pocket\nor a you just happy to see me?");

                                       }

                                    }

                                 }

                              }

                           }

                        }

};

void (entity Goal, entity AP, float addb) DoResults = {

   local entity te;
   local float winners;
   local float gotone;

   if (cb_prematch) return;

   if (round_over) return;


   if ( (Goal.goal_state == 1.000) ) {

      return ;

   }
   if ( ((Goal.delay_time > 0.000) && (Goal.goal_state != 4.000)) ) {

      Goal.goal_state = 4.000;
      te = spawn ();
      te.think = DelayedResult;
      te.nextthink = (time + Goal.delay_time);
      te.owner = AP;
      te.enemy = Goal;
      te.weapon = addb;
      return ;

   }
   UpdateAbbreviations (Goal);
   Goal.goal_state = 2.000;
   if ( ((Goal.classname == "info_tfgoal") && (Goal.mdl != string_null)) ) {

      setmodel (Goal,string_null);

   }
   if (Goal.classname == "item_tfgoal") {

      AP.flag_touches = AP.flag_touches + 1.000;
      if (AP.StatusBarSize) 
          AP.StatusRefreshTime = (time + 0.100);

      if (spec_msgs)
          PrintSpecs (AP.netname," took the ",Goal.netname);

   }

   if ( Goal.noise ) {

      sound (other,3.000,Goal.noise,1.000,1.000);

   }
   
   if ( (Goal.increase_team1 != 0.000) ) {

      TeamFortress_TeamIncreaseScore (1.000,Goal.increase_team1);
      winners = 1.000;

   }
   if ( (Goal.increase_team2 != 0.000) ) {

      TeamFortress_TeamIncreaseScore (2.000,Goal.increase_team2);
      winners = 1.000;

   }
   if ( (Goal.increase_team3 != 0.000) ) {

      TeamFortress_TeamIncreaseScore (3.000,Goal.increase_team3);
      winners = 1.000;

   }
   if ( (Goal.increase_team4 != 0.000) ) {

      TeamFortress_TeamIncreaseScore (4.000,Goal.increase_team4);
      winners = 1.000;

   }
   if ( (winners == 1.000) ) {

      TeamFortress_TeamShowScores (2.000);

      if (Goal.owned_by)
      {
         if (spec_msgs)  
            PrintSpecs (AP.netname," captured the ",Goal.netname);
      }


   }
   if ( (ctfmap == 1) ) {

      if ( (AP != world) ) {

         if ( (Goal.goal_no == 1.000) ) {

            bprint2(2.000, AP.netname, " гот the блуе flag!\n");
            AP.items = (AP.items | 131072.000);
            AP.effects = (AP.effects | 96.000);

         } else {

            if ( (Goal.goal_no == 2.000) ) {

               bprint2 (2.000,AP.netname, " гот the ред flag!\n");
               AP.items = (AP.items | 262144.000);
               AP.effects = (AP.effects | 144.000);

            } else {

               if ( (Goal.goal_no == 3.000) ) {

                  bprint2 (2.000,AP.netname, " цаптуред the ред flag!\n");
                  AP.items = (AP.items - (AP.items & 262144.000));
                  AP.effects = (AP.effects - (AP.effects & 144.000));

               } else {

                  if ( (Goal.goal_no == 4.000) ) {
                     bprint2 (2.000,AP.netname, " цаптуред the блуе flag!\n");
                     AP.items = (AP.items - (AP.items & 131072.000));
                     AP.effects = (AP.effects - (AP.effects & 96.000));

                  }

               }

            }

         }
         if (Goal.noise2 == "ctf")
         {
            te = player_head;
            while ( te ) {


              if ((te.pteam.team != Goal.owned_by)) 
              {
                  if ( te == AP)
                  {
                     if (Goal.goal_no < 3) {
                        PrintSelfCTF(te);
                     } else {
                        CenterPrint (te,"\n\n\nYou цаптуред the flag!!\n");
                     }
                  }
                  else
                  {
                     if (Goal.goal_no < 3) {
                        CenterPrint (te,"\n\n\nYour team гот the енемы flag!!\n");
                     } else {
                        CenterPrint (te,"\n\n\nYour team цаптуред the flag!!\n");
                     }
                  }
               } else {

                  if (Goal.goal_no < 3) {
                     CenterPrint (te,"\n\n\nYour flag has been такен!!\n");
                  } else {
                     CenterPrint (te,"\n\n\nYour flag was цаптуред!!");
                  }
               }
               te = te.nextp;

            }

         }

      }

   }
   gotone = 0.000;
   te = player_head;

   while ( te ) {

      if (!ctfmap) {

         if ( (Goal.broadcast != string_null) ) {

            CenterPrint2 (te,"\n\n\n",Goal.broadcast);
         }

         if ( (Goal.netname_broadcast != string_null) ) {

            sprint (te,2.000,AP.netname);
            sprint (te,2.000,Goal.netname_broadcast);

         } else if (Goal.classname == "item_tfgoal") {

            sprint (te,2.000,AP.netname);
            sprint (te,2.000," took the ");
            sprint (te,2.000,Goal.netname);
            sprint (te,2.000,"\n");
         }



         if ( (AP == te) ) {

            if ( (Goal.message != string_null) ) {

               CenterPrint2 (te,"\n\n\n",Goal.message);

            }

         } else {

            if ( (AP.pteam == te.pteam) ) {

               if ( ((Goal.owners_team_broadcast != string_null) && (te.team_no == Goal.owned_by)) ) {

                  CenterPrint2 (te,"\n\n\n",Goal.owners_team_broadcast);

               } else {

                  if ( (Goal.team_broadcast != string_null) ) {
   
                     CenterPrint2 (te,"\n\n\n",Goal.team_broadcast);

                  }

               }
               if ( ((Goal.netname_owners_team_broadcast != string_null) && (te.pteam.team == Goal.owned_by)) ) {

                  sprint (te,2.000,AP.netname);
                  sprint (te,2.000,Goal.netname_owners_team_broadcast);

               } else {

                  if ( (Goal.netname_team_broadcast != string_null) ) {

                     sprint (te,2.000,AP.netname);
                     sprint (te,2.000,Goal.netname_team_broadcast);

                  } 

               }

            } else {

               if ( ((Goal.owners_team_broadcast != string_null) && (te.pteam.team == Goal.owned_by)) ) {

                  CenterPrint2 (te,"\n\n\n",Goal.owners_team_broadcast);

               } else {

                  if ( (Goal.non_team_broadcast != string_null) ) {

                     CenterPrint2 (te,"\n\n\n",Goal.non_team_broadcast);

                  }

               }
               if ( ((Goal.netname_owners_team_broadcast != string_null) && (te.pteam.team == Goal.owned_by)) ) {

                  sprint (te,2.000,AP.netname);
                  sprint (te,2.000,Goal.netname_owners_team_broadcast);

               } else {

                  if ( (Goal.netname_non_team_broadcast != string_null) ) {

                     sprint (te,2.000,AP.netname);
                     sprint (te,2.000,Goal.netname_non_team_broadcast);

                  } 

               }

            }

         }

      }

      if ( IsAffectedBy (Goal,te,AP) ) {

         if ( ((Goal.search_time != 0.000) && (Goal.goal_effects & 64.000)) ) {

            if ( APMeetsCriteria (Goal,te) ) {

               Apply_Results (Goal,te,AP,addb);
               gotone = 1.000;

            }

         } else {

            Apply_Results (Goal,te,AP,addb);
            gotone = 1.000;

         }

      }
      te = te.nextp;

   }

   if ( (Goal.classname != "item_tfgoal") ) {

      Goal.goal_state = 1.000;

   }
   if ( (Goal.goal_result & 4.000) ) {

      TeamFortress_TeamShowScores (1.000);
      winners = TeamFortress_TeamGetWinner ();
      te = player_head;
      while ( te ) {

         te.takedamage = 0.000;
         te.movetype = 0.000;
         te.velocity = '0.000 0.000 0.000';
         te.avelocity = '0.000 0.000 0.000';
         te = te.nextp;

      }
      te = spawn ();
      te.nextthink = (time + 5.000);
      te.think = execute_changelevel;
      dremove (Goal);
      return ;

   }
   DoGroupWork (Goal,AP);
   DoGoalWork (Goal,AP);
   DoTriggerWork (Goal,AP);
   if ( (Goal.classname == "info_tfgoal") ) {

      SetupRespawn (Goal);


   }

};

void () tfgoal_touch = {

   local entity te;


   if ( !(self.goal_activation & 1.000) ) {

      return ;

   }

   if (other.classname == "trigger_hurt") {

      self.nextthink = (time + 0.500);
   }
   if ( (other.classname != "player") ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }

   if (cb_prematch) return ;

   if (round_over) return;

   if ( (self.goal_state == 1.000) ) {

      return ;

   }


   if ( (ctfmap == 1) ) {

      if ( ((self.goal_no == 3.000) && (other.pteam == pteam1)) ) {

         te = Finditem (1.000);
         if ( ((te.goal_state == 1.000) || (te.origin != te.oldorigin)) ) {

            return ;

         }

      }
      if ( ((self.goal_no == 4.000) && (other.pteam == pteam2)) ) {

         te = Finditem (2.000);
         if ( ((te.goal_state == 1.000) || (te.origin != te.oldorigin)) ) {

            return ;

         }

      }

   }

   AttemptToActivate (self,other,self);

};

void () info_tfgoal_use = {

   if ( (cb_prematch) ) {

      return ;
   }

   if (round_over) return;


   AttemptToActivate (self,activator,self);

};

void () tfgoal_timer_tick = {


   if ( (self.goal_state != 3.000) ) {

      if ( APMeetsCriteria (self,world) ) {

         DoResults (self,world,1.000);

      } else {

         InactivateGoal (self);
         self.think = tfgoal_timer_tick;
         self.nextthink = (time + self.search_time);

      }

   }

};

void () item_tfgoal_touch = {

   local entity te;

   if ( (other.classname != "player") ) {

      return ;
   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if (other.rs_g > time) return;

   if ( (other.health <= 0.000) ) {

      return ;

   }

   if (cb_prematch) return;

   if (round_over) return;

   if ( other.is_feigning ) {

      return ;

   }
   if ( (other == self.owner) ) {

      return ;

   }

   if ( (ctfmap == 1) ) {
	
      if ( (self.goal_no == 1.000) ) {

         if ( (self.origin != self.oldorigin) ) {

            if ( (other.pteam == pteam1) ) {

               bprint (2.000,other.netname);
               bprint (2.000," ретурнед the блуе flag!\n");
               te = player_head;
               while (te) {

                  if ( (te.pteam == pteam1) ) {

                     CenterPrint2 (te,"\n\n\n","Your flag was ретурнед!!");

                  } else {

                     CenterPrint2 (te,"\n\n\n","The енемы flag was ретурнед!!");

                  }
                  te = te.nextp;

               }
               self.goal_state = 2.000;
               self.solid = 1.000;
               self.touch = item_tfgoal_touch;
               self.origin = self.oldorigin;
               setmodel (self,self.mdl);
               setorigin (self,self.origin);
               sound (self,2.000,"items/itembk2.wav",1.000,1.000);
               
               return ;

            }

         } else {

            if ( (other.pteam == pteam1) ) {

               return ;

            }

         }

      } else {


         if ( (self.goal_no == 2.000) ) {

            if ( (self.origin != self.oldorigin) ) {

               if ( (other.pteam == pteam2) ) {

                  bprint (2.000,other.netname);
                  bprint (2.000," ретурнед the ред flag!\n");
                  te = player_head;
                  while ( te ) {

                     if ( (te.pteam == pteam2) ) {

                        CenterPrint (te,"\n\n\n Your flag was ретурнед!!");

                     } else {

                        CenterPrint (te,"\n\n\n The енемы flag was ретурнед!!");

                     }
                     te = te.nextp;

                  }
                  self.goal_state = 2.000;
                  self.solid = 1.000;
                  self.touch = item_tfgoal_touch;
                  self.origin = self.oldorigin;
                  setmodel (self,self.mdl);
                  setorigin (self,self.origin);
                  sound (self,2.000,"items/itembk2.wav",1.000,1.000);
                  return ;

               }

            } else {

               if ( (other.pteam == pteam2) ) {

                  return ;

               }

            }

         }

      }

   }
   

   if ( Activated (self,other) ) {

      tfgoalitem_GiveToPlayer (self,other,self);
      if ( (other.health > 0.000) ) {

         self.goal_state = 1.000;

      }

   } else {

      if ( (self.else_goal != 0.000) ) {

         te = Findgoal (self.else_goal);
         if ( te ) {

            AttemptToActivate (te,other,self);

         }

      }

   }

};

void (entity Item, entity AP, entity Goal) tfgoalitem_GiveToPlayer = {

   Item.owner = AP;
   if ( (Item.mdl != string_null) ) {

      setmodel (Item,string_null);

   }
   Item.solid = 0.000;

   if ( (Item.goal_activation & 1.000) ) {

      if (Item.mdl == "progs/flag.mdl")
      {
         if (Item.owned_by == 1.000)
         {  
            AP.effects = (AP.effects | 16.000);
         }
         else if (Item.owned_by == 2.000)
         {
            AP.effects = (AP.effects | 32.000);
         }
      
      } 

      AP.effects = (AP.effects | 8.000);

   }


   if ( (Item.goal_activation & 2.000) ) {

      TeamFortress_SetSpeed (AP);

   }
   if ( (Item.goal_activation & 512.000) ) {

      if (Item.owned_by == 1.000)   {

         Item.effects = (Item.effects | 64.000);

      } else {
         if (Item.owned_by == 2.000)  {

            Item.effects = (Item.effects | 128.000);

         } else {
            Item.effects = (Item.effects | 8.000);
         }
      }
   }
   if ( (Item.items & 131072.000) ) {

      AP.items = (AP.items | 131072.000);

   }
   if ( (Item.items & 262144.000) ) {

      AP.items = (AP.items | 262144.000);

   }

   if ( (Goal != Item) ) {

      if ( (Goal.goal_result & 8.000) ) {

         Item.goal_state = 1.000;
         return ;

      }

   }
   if ( ((AP.playerclass == 8.000) && (Item.goal_result & 16.000)) ) {

      AP.is_unabletospy = 1.000;

   }
   DoResults (Item,AP,1.000);
   DoItemGroupWork (Item,AP);

};

void () ReturnItem = {

   local entity te;

   self.enemy.goal_state = 2.000;

   if (self.enemy.classname == "item_tfgoal") {
      if (((self.enemy.goal_activation & 8192.000)) || ((toggleflags & 16.000))) {

         self.enemy.solid = 2.000;

      } else {

         self.enemy.solid = 1.000;

      }
   }
   self.flags = self.flags - ( self.flags & 512.000);
   self.enemy.movetype = 0.000;
   self.enemy.camdist = 0.000;
   self.enemy.touch = item_tfgoal_touch;
   self.enemy.origin = self.enemy.oldorigin;
   if ( (self.enemy.mdl != string_null) ) {

      setmodel (self.enemy,self.enemy.mdl);

   }
   setorigin (self.enemy,self.enemy.origin);
   sound (self.enemy,2.000,"items/itembk2.wav",1.000,1.000);
   tfgoalitem_checkgoalreturn (self.enemy);
   if ( (self.weapon != 2.000) ) {

      if ( ((self.enemy.noise3 != string_null) || (self.enemy.noise4 != string_null)) ) {

         te = player_head;
         while ( te ) {

            if ( (te.pteam.team == self.enemy.owned_by) ) {

               CenterPrint2 (te,"\n\n\n",self.enemy.noise3);

            } else {

               CenterPrint2 (te,"\n\n\n",self.enemy.noise4);

            }
            te = te.nextp;

         }

      }

   }
   dremove (self);

};

void (entity Item, entity AP, float method) tfgoalitem_RemoveFromPlayer = {

   local entity te;
   local float lighton;
   local float slowon;
   local float key1on;
   local float key2on;
   local float spyoff;
   local entity DelayReturn;

   if ( (Item == world) ) {

      objerror ("error: tfgoalitem_RemoveFromPlayer(): Item == world");
      return ;

   }
   lighton = 0.000;
   slowon = 0.000;
   key1on = 0.000;
   key2on = 0.000;
   spyoff = 0.000;
   te = find (world,classname,"item_tfgoal");
   while ( te ) {

      if ( ((te.owner == AP) && (te != Item)) ) {

         if ( (te.goal_activation & 1.000) ) {

            lighton = 1.000;

         }
         if ( (te.goal_activation & 2.000) ) {

            slowon = 1.000;

         }
         if ( (te.items & 131072.000) ) {

            key1on = 1.000;

         }
         if ( (te.items & 262144.000) ) {

            key2on = 1.000;

         }
         if ( (te.goal_result & 16.000) ) {

            spyoff = 1.000;

         }

      }
      te = find (te,classname,"item_tfgoal");

   }
   if ( !lighton ) {

      if ( (AP.invincible_finished > (time + 3.000)) ) {

         lighton = 1.000;

      } else {

         if ( (AP.super_damage_finished > (time + 3.000)) ) {

            lighton = 1.000;

         }

      }

   }
   if ( !lighton ) {

      AP.effects = (AP.effects - (AP.effects & 8.000));
      AP.effects = (AP.effects - (AP.effects & 80.000));
      AP.effects = (AP.effects - (AP.effects & 160.000));

   }
   if ( (Item.goal_activation & 512.000) ) {


      if (Item.owned_by == 1.000)   {

         Item.effects = (Item.effects | 64.000);


      } else {
         if (Item.owned_by == 2.000)  {

             Item.effects = (Item.effects | 128.000);

         } else {
            Item.effects = (Item.effects | 8.000);
         }
      }

   }
   if ( !spyoff ) {

      AP.is_unabletospy = 0.000;

   }
   if ( !key1on ) {

      AP.items = (AP.items - (AP.items & 131072.000));

   }
   if ( !key2on ) {

      AP.items = (AP.items - (AP.items & 262144.000));

   }
   te = player_head;
   while ( te ) {

      if ( IsAffectedBy (Item,te,AP) ) {

         RemoveResults (Item,te);

      }
      te = te.nextp;

   }
   if ( ((method == 0.000) || (method == 2.000)) ) {

      AP.flag_fumbles = AP.flag_fumbles + 1.000;
      if (AP.StatusBarSize) 
          AP.StatusRefreshTime = (time + 0.100);

      te = player_head;
      while ( te ) {

         if ( (te.pteam.team == Item.owned_by) ) {

            if ( (Item.team_drop != string_null) ) {

               CenterPrint2 (te,"\n\n\n",Item.team_drop);

            }
            if ( (Item.netname_team_drop != string_null) ) {


               if (bspversion == 30 || mapname == "tf2k")
               { 
                 sprint (te,2.000,AP.netname);
                 sprint (te,2.000," ");
                 sprint (te,2.000,Item.netname_team_drop);
                 sprint (te,2.000,"\n");
               }
               else
               {
                  sprint (te,2.000,AP.netname);
                  sprint (te,2.000,Item.netname_team_drop);
               }

            }
            else
            {
               sprint (te,2.000,AP.netname);
               sprint (te,2.000," dropped ");
               sprint (te,2.000,Item.netname);
               sprint (te,2.000,"\n");
            }

         } else {

            if ( (Item.non_team_drop != string_null) ) {

               CenterPrint2 (te,"\n\n\n",Item.non_team_drop);

            }
            if ( (Item.netname_non_team_drop != string_null) ) {


               if (bspversion == 30 || mapname == "tf2k")
               {
                  sprint (te,2.000,AP.netname);
                  sprint (te,2.000," ");
                  sprint (te,2.000,Item.netname_non_team_drop);
                  sprint (te,2.000,"\n");

               } else {
                  sprint (te,2.000,AP.netname);
                  sprint (te,2.000,Item.netname_non_team_drop);
               }
            } else {

               sprint (te,2.000,AP.netname);
               sprint (te,2.000," dropped ");
               sprint (te,2.000,Item.netname);
               sprint (te,2.000,"\n");
            }
         }
         te = te.nextp;

      }
      if ( (Item.goal_activation & 8.000) ) {

         DelayReturn = spawn ();
         DelayReturn.enemy = Item;
         if ( (method == 0.000) ) {

            DelayReturn.weapon = 0.000;

         } else {

            DelayReturn.weapon = 1.000;

         }
         DelayReturn.think = ReturnItem;
         DelayReturn.nextthink = (time + 0.500);

      } else {

         if ( (Item.goal_activation & 4.000) ) {

            if ( ((method == 2.000) && ((Item.goal_activation & 4096.000) || (toggleflags & 8.000))  ) ) {

               tfgoalitem_drop (Item,1.000,AP);

            } else {

               tfgoalitem_drop (Item,0.000,AP);

            }

         } else {

            Item.owner = world;
            dremove (Item);
            TeamFortress_SetSpeed (AP);
            return ;

         }

      }
      Item.owner = world;
      Item.flags = (Item.flags - (Item.flags & 512.000));
      setsize (Item,Item.goal_min,Item.goal_max);
      TeamFortress_SetSpeed (AP);
      return ;

   } else {

      if ( (method == 1.000) ) {

         if ( (Item.goal_activation & 16.000) ) {

            DelayReturn = spawn ();
            DelayReturn.enemy = Item;
            DelayReturn.weapon = 2.000;
            DelayReturn.think = ReturnItem;
            DelayReturn.nextthink = (time + 0.500);
            Item.owner = world;
            TeamFortress_SetSpeed (AP);
            return ;

         }
         Item.solid = 0.000;
         Item.owner = world;
         TeamFortress_SetSpeed (AP);
         return ;

      }

   }
   objerror ("Invalid method passed into tfgoalitem_RemoveFromPlayer\n");

};

void () tfgoalitem_dropthink = {

   local float pos;
   local string st;

   self.movetype = 6.000;
   if ( (self.pausetime != 0.000) ) {

      pos = pointcontents (self.origin);
      if ( (pos == -4.000) ) {

         self.nextthink = (time + (self.pausetime / 4.000));

      } else {

         if ( (pos == -5.000) ) {

            self.nextthink = (time + 5.000);

         } else {

            if ( ((pos == -2.000) || (pos == -6.000)) ) {

               if ( (self.camdist < 3.000) ) {

                 // self.origin = self.camangle;
                  setorigin (self,self.origin);
                  self.velocity_z = 400.000;
                  self.velocity_x = (-50.000 + (random () * 100.000));
                  self.velocity_y = (-50.000 + (random () * 100.000));
                  self.goal_state = 2.000;
                  self.movetype = 6.000;

                  if ( (self.goal_activation & 8192.000) || (toggleflags & 16.000)) {

                     self.solid = 2.000;

                  } else {

                     self.solid = 1.000;

                  }
                  if ( (self.mdl != string_null) ) {

                     setmodel (self,self.mdl);

                  }
                  setsize (self,self.goal_min,self.goal_max);
                  self.camdist = (self.camdist + 1.000);
                  self.nextthink = (time + 5.000);
                  self.think = tfgoalitem_dropthink;
                  return ;

               } else {

                  self.nextthink = (time + 2.000);

               }

            } else {
               self.camdist = -1.000;
               self.nextthink = (time + self.pausetime);

            }

         }

      }

      st = infokey(world, "noreturn");
      if (st != "on") {
         self.think = tfgoalitem_remove;
      }

   }

};

void () tfgoalitem_droptouch = {

   self.touch = item_tfgoal_touch;
   self.nextthink = (time + 4.250);
   self.think = tfgoalitem_dropthink;

};

void (entity Item, float PAlive, entity P) tfgoalitem_drop = {

   local string st;
   local float fl;

   Item.origin = Item.owner.origin;
   setorigin (Item,Item.origin);
   //Item.camangle = (Item.owner.origin - '0.000 0.000 8.000');
   Item.camdist = 0.000;
   Item.velocity_z = 400.000;
   Item.velocity_x = (-50.000 + (random () * 100.000));
   Item.velocity_y = (-50.000 + (random () * 100.000));
   Item.goal_state = 2.000;
   Item.movetype = 6.000;
   if (((Item.goal_activation & 8192.000)) || ((toggleflags & 16.000))) {

      Item.solid = 2.000;

   } else {

      Item.solid = 1.000;

   }
   if ( (Item.mdl != string_null) ) {

      setmodel (Item,Item.mdl);

   }
   setsize (Item,Item.goal_min,Item.goal_max);
   Item.owner = P;

   st = infokey (world,"flag_delay");
   fl = stof(st);

   if (fl > 0 && fl < 10) {
      P.rs_g = time + fl;
   }

   if ( (PAlive == 1.000) ) {

      makevectors (P.v_angle);
      if ( P.v_angle_x ) {

         Item.velocity = ((v_forward * 400.000) + (v_up * 200.000));

      } else {

         Item.velocity = aim (P,10000.000);
         Item.velocity = (Item.velocity * 400.000);
         Item.velocity_z = 200.000;

      }
      Item.touch = SUB_Null;
      Item.nextthink = (time + 0.750);
      Item.think = tfgoalitem_droptouch;

   } else {

      Item.touch = item_tfgoal_touch;
      Item.nextthink = (time + 5.000);
      Item.think = tfgoalitem_dropthink;

   }

};

void () tfgoalitem_remove = {

   local entity te;

   if ( (self.goal_state == 1.000) ) {

      return ;

   }
   if ( (self.goal_activation & 32.000) ) {

      te = spawn ();
      te.enemy = self;
      te.weapon = 3.000;
      te.nextthink = (time + 0.100);
      te.think = ReturnItem;
      return ;

   }
   dremove (self);

};

void (entity Item) tfgoalitem_checkgoalreturn = {

   local entity te;

   if ( (Item.impulse != 0.000) ) {

      te = Findgoal (Item.impulse);
      if ( te ) {

         te = Findgoal (Item.impulse);
         if ( te ) {

            AttemptToActivate (te,world,Item);

         }

      }

   }

};

string (entity Goal, entity Player, entity Item) ItemStatus = {

   local string tmp;

   if ( (Item.goal_state == 1.000) ) {

      if ( ((Goal.team_str_carried != string_null) || (Goal.non_team_str_carried != string_null)) ) {

         if ( (Player.pteam.team == Item.owned_by) ) {

            tmp = Goal.team_str_carried;

         } else {

            tmp = Goal.non_team_str_carried;

         }

         tmp = strcat(tmp, " ");
         //sprint (Player,2.000," ");
         if ( (Player == Item.owner) ) {

            //sprint (Player,2.000,"You");
            tmp = strcat(tmp, "You");

         } else {

            //sprint (Player,2.000,Item.owner.netname);
            tmp = strcat(tmp, Item.owner.netname);

         }
         //sprint (Player,2.000,".\n");
         tmp = strcat(tmp, ".\n");

         return(tmp);
      }

   } else {

      if ( (Item.origin != Item.oldorigin) ) {

         if ( ((Goal.team_str_moved != string_null) || (Goal.non_team_str_moved != string_null)) ) {

            if ( (Player.pteam.team == Item.owned_by) ) {

               tmp = Goal.team_str_moved;
		   
               if ((Item.camdist < 0) && (Item.nextthink - time > 0))
               {
                  tmp = strcat(tmp, " Return Time: ");
                  tmp = strcat(tmp, ftos(rint(Item.nextthink - time)));
                  tmp = strcat(tmp, " seconds");
                    // sprint3 (Player,2.000, " Return time: ", ftos(rint(Item.nextthink - time)), " seconds.");
                  
               }

            } else {


               tmp = Goal.non_team_str_moved;
               if ((Item.camdist < 0) && (Item.nextthink - time > 0))
               {
                  tmp = strcat(tmp, " Return Time: ");
                  tmp = strcat(tmp, ftos(rint(Item.nextthink - time)));
                  tmp = strcat(tmp, " seconds");
                  //sprint3 (Player,2.000, " Return time: ", ftos(rint(Item.nextthink - time)), " seconds.");
               }
            }
            //sprint (Player,2.000,"\n");

            tmp = strcat(tmp, ".\n");

            return(tmp);
         }

      } else {

         if ( ((Goal.team_str_home != string_null) || (Goal.non_team_str_home != string_null)) ) {

            if ( (Player.pteam.team == Item.owned_by) ) {

               tmp = (Goal.team_str_home);

            } else {

               tmp = Goal.non_team_str_home;

            }

            tmp = strcat(tmp, ".\n");
            return(tmp);

         } else {

            if ( (Player.pteam.team == Item.owned_by) ) {

               tmp = ("Your flag is at base\n");

            } else {

               tmp = ("Enemy flag is at base\n");

            }

            return(tmp);

         }

      }

   }


};

void () info_player_team2 = {

   ctfmap = 1;
   self.classname = "info_player_teamspawn";
   self.team_no = 2.000;
   self.goal_effects = 1.000;
   self.team_str_home = "ts2";

};

void () info_player_team1 = {

   ctfmap = 1;
   self.classname = "info_player_teamspawn";
   self.team_no = 1.000;
   self.goal_effects = 1.000;
   self.team_str_home = "ts1";

};

void () item_flag_team1 = {

   local entity dp;

   ctfmap = 1;
   UpdateAbbreviations (self);
   precache_model ("progs/flag.mdl");
   precache_sound ("ogre/ogwake.wav");
   precache_sound ("boss2/pop2.wav");
   self.classname = "item_tfgoal";
   self.owned_by = 1.000;
   self.netname = "Team 1 Flag";
   //self.broadcast = " гот the enemy team's flag!\n";
   //self.deathtype = "You've got the enemy flag!\n";
   self.noise = "ogre/ogwake.wav";
   self.noise2 = "ctf";
   self.mdl = "progs/flag.mdl";
   self.skin = 1.000;
   setmodel (self,self.mdl);
   self.goal_no = 1.000;
   self.goal_activation = (((((1.000 | 4.000) | 128.000) | 32.000) | 16.000) | 512.000);
   self.goal_effects = 1.000;
   self.effects = 64.000;
   //self.pausetime = 128.000;
   self.pausetime = 15.000;
   self.goal_min = '-16.000 -16.000 -24.000';
   self.goal_max = '16.000 16.000 32.000';
   setsize (self,self.goal_min,self.goal_max);
   self.touch = item_tfgoal_touch;
   self.goal_state = 2.000;
   self.solid = 1.000;
   setorigin (self,self.origin);
   self.nextthink = (time + 0.200);
   self.think = TF_PlaceItem;
   dp = spawn ();
   dp.origin = self.origin;
   dp.classname = "info_tfgoal";
   dp.goal_activation = 1.000;
   dp.team_no = 1.000;
   dp.owned_by = 1.000;
   dp.items_allowed = 2.000;
   dp.goal_no = 3.000;
   dp.goal_effects = 3.000;
   //dp.broadcast = " цаптуред the enemy flag!\n";
   //dp.message = "You цаптуред the enemy flag!\n";
   dp.noise = "boss2/pop2.wav";
   dp.goal_result = 2.000;
   dp.activate_goal_no = 5.000;
   dp.axhitme = 2.000;
   dp.count = 10.000;
   dp.frags = 10.000;
   dp.solid = 1.000;
   dp.goal_state = 2.000;
   dp.goal_min = '-16.000 -16.000 -24.000';
   dp.goal_max = '16.000 16.000 32.000';
   setsize (dp,dp.goal_min,dp.goal_max);
   dp.nextthink = (time + 0.200);
   dp.think = TF_PlaceGoal;
   dp = spawn ();
   dp.origin = dp.origin;
   dp.classname = "info_tfgoal";
   dp.noise2 = "ctf";
   dp.goal_effects = 1.000;
   dp.frags = 5.000;
   dp.goal_activation = 0.000;
   dp.goal_no = 5.000;
   dp.solid = 0.000;
   dp.goal_state = 2.000;
   dp.goal_min = '-16.000 -16.000 -24.000';
   dp.goal_max = '16.000 16.000 32.000';
   setsize (dp,dp.goal_min,dp.goal_max);
   dp.nextthink = (time + 0.200);
   dp.think = TF_PlaceGoal;

};

void () item_flag_team2 = {

   local entity dp;

   ctfmap = 1;
   UpdateAbbreviations (self);
   precache_model ("progs/flag.mdl");
   precache_sound ("ogre/ogwake.wav");
   precache_sound ("boss2/pop2.wav");
   self.classname = "item_tfgoal";
   self.netname = "Team 2 Flag";
  // self.broadcast = " гот the enemy team's flag!\n";
  // self.deathtype = "You've got the enemy flag!\n";
   self.noise = "ogre/ogwake.wav";
   self.noise2 = "ctf";
   self.mdl = "progs/flag.mdl";
   setmodel (self,self.mdl);
   self.skin = 0.000;
   self.owned_by = 2.000;
   self.goal_no = 2.000;
   self.goal_activation = (((((1.000 | 4.000) | 128.000) | 32.000) | 16.000) | 512.000);
   self.goal_effects = 1.000;
   self.pausetime = 15.000;
   //self.pausetime = 128.000;
   self.effects = 128.000;
   self.goal_min = '-16.000 -16.000 -24.000';
   self.goal_max = '16.000 16.000 32.000';
   setsize (self,self.goal_min,self.goal_max);
   self.touch = item_tfgoal_touch;
   self.goal_state = 2.000;
   self.solid = 1.000;
   setorigin (self,self.origin);
   self.nextthink = (time + 0.200);
   self.think = TF_PlaceItem;
   dp = spawn ();
   dp.origin = self.origin;
   dp.classname = "info_tfgoal";
   dp.goal_activation = 1.000;
   dp.team_no = 2.000;
   dp.owned_by = 2.000;
   dp.items_allowed = 1.000;
   dp.goal_no = 4.000;
   dp.goal_effects = 3.000;
 //  dp.broadcast = " цаптуред the enemy flag!\n";
 //  dp.message = "You цаптуред the enemy flag!\n";
   dp.noise = "boss2/pop2.wav";
   dp.goal_result = 2.000;
   dp.activate_goal_no = 6.000;
   dp.axhitme = 1.000;
   dp.count = 10.000;
   dp.frags = 10.000;
   dp.solid = 1.000;
   dp.goal_state = 2.000;
   dp.goal_min = '-16.000 -16.000 -24.000';
   dp.goal_max = '16.000 16.000 32.000';
   setsize (dp,dp.goal_min,dp.goal_max);
   dp.nextthink = (time + 0.200);
   dp.think = TF_PlaceGoal;
   dp = spawn ();
   dp.origin = dp.origin;
   dp.classname = "info_tfgoal";
   dp.noise2 = "ctf";
   dp.goal_effects = 1.000;
   dp.frags = 5.000;
   dp.goal_activation = 0.000;
   dp.goal_no = 6.000;
   dp.solid = 0.000;
   dp.goal_state = 2.000;
   dp.goal_min = '-16.000 -16.000 -24.000';
   dp.goal_max = '16.000 16.000 32.000';
   setsize (dp,dp.goal_min,dp.goal_max);
   dp.nextthink = (time + 0.200);
   dp.think = TF_PlaceGoal;

};

void () CTF_FlagCheck = {

   local entity te;
   local float flagcount;
   local float pos;

   flagcount = 0.000;
   te = find (world,classname,"item_tfgoal");
   while ( (te != world) ) {

      if ( (te.goal_no == 1.000) ) {

         pos = pointcontents (te.origin);
         if ( ((pos == -2.000) || (pos == -6.000)) ) {

            dprint ("*****BUG*****\nFlag(s) outside world.\n");
            te.nextthink = (time + 0.200);
            te.think = tfgoalitem_remove;

         }
         flagcount = (flagcount + 1.000);

      } else {

         if ( (te.goal_no == 2.000) ) {

            pos = pointcontents (te.origin);
            if ( ((pos == -2.000) || (pos == -6.000)) ) {

               dprint ("*****BUG*****\nFlag(s) outside world.\n");
               te.nextthink = (time + 0.200);
               te.think = tfgoalitem_remove;

            }
            flagcount = (flagcount + 1.000);

         }

      }
      te = find (te,classname,"item_tfgoal");

   }


   if ( !rounds) {

      if ( (flagcount != 2.000) ) {

         dprint ("*****BUG*****\nFlag(s) missing.\n");

      }
   }
   self.nextthink = (time + 30.000);

};

void (entity P) ForceRespawn = {

   local entity spot;
   local entity te;
   local entity oldself;

   oldself = self;
   self = P;
   spot = SelectSpawnPoint ();
   if ( (self.playerclass) ) {

      spawn_tdeath (spot.origin,self);

   }
   self.observer_list = spot;
   self.origin = (spot.origin + '0.000 0.000 1.000');
   self.angles = spot.angles;
   self.fixangle = 1.000;
   if ( ((spot.classname == "info_player_teamspawn") && (!cb_prematch)) ) {

      if ( (spot.items != 0.000) ) {

         te = Finditem (spot.items);
         if ( te ) {

            tfgoalitem_GiveToPlayer (te,self,self);

         }
         if ( !(spot.goal_activation & 1.000) ) {

            spot.items = 0.000;

         }

      }
      if ( spot.message ) {

         CenterPrint (self,spot.message);
         if ( !(spot.goal_activation & 2.000) ) {

            spot.message = string_null;

         }

      }
      if ( (spot.activate_goal_no != 0.000) ) {

         te = Findgoal (spot.activate_goal_no);
         if ( te ) {

            AttemptToActivate (te,self,spot);

         }

      }
      if ( (spot.goal_effects == 1.000) ) {

         spot.classname = "deadpoint";
         spot.team_str_home = string_null;
         spot.nextthink = (time + 1.000);
         spot.think = SUB_Remove;

      }

   }
   if ( (deathmatch || coop) ) {

      makevectors (self.angles);
      if ( (self.playerclass) ) {

         spawn_tfog ((self.origin + (v_forward * 20.000)));

      }

   }
   self = oldself;

};

void () DropGoalItems = {

   local entity te;

   te = find (world,classname,"item_tfgoal");
   while ( te ) {

      if ( (te.owner == self) ) {

         if ( (te.goal_activation & 4096.000) || (toggleflags & 8.000)) {

            tfgoalitem_RemoveFromPlayer (te,self,2.000);

         }

      }
      te = find (te,classname,"item_tfgoal");

   }


};
