void () Sentry_Rotate;

void () InitBodyQue;

void () Eluminate = {
   lights = 1;
   lightstyle (0.000,"m");
   lightstyle (1.000,"mmnmmommommnonmmonqnmmo");
   lightstyle (2.000,"abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba");
   lightstyle (3.000,"mmmmmaaaaammmmmaaaaaabcdefgabcdefg");
   lightstyle (4.000,"mamamamamama");
   lightstyle (5.000,"jklmnopqrstuvwxyzyxwvutsrqponmlkj");
   lightstyle (6.000,"nmonqnmomnmomomno");
   lightstyle (7.000,"mmmaaaabcdefgmmmmaaaammmaamm");
   lightstyle (8.000,"mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa");
   lightstyle (9.000,"aaaaaaaazzzzzzzz");
   lightstyle (10.000,"mmamammmmammamamaaamammma");
   lightstyle (11.000,"abcdefghijklmnopqrrqponmlkjihgfedcba");
   lightstyle (63.000,"a");

};

void () Deluminate = {
   lights = 0;
   lightstyle (0.000,"a");
   lightstyle (1.000,"a");
   lightstyle (2.000,"a");
   lightstyle (3.000,"a");
   lightstyle (4.000,"a");
   lightstyle (5.000,"a");
   lightstyle (6.000,"a");
   lightstyle (7.000,"a");
   lightstyle (8.000,"a");
   lightstyle (9.000,"a");
   lightstyle (10.000,"a");
   lightstyle (11.000,"a");
   lightstyle (63.000,"a");
};

void () main = {


   precache_file ("qwprogs.dat");
   precache_file ("gfx.wad");
   precache_file ("quake.rc");
   precache_file ("default.cfg");
   precache_file ("end1.bin");
   precache_file2 ("end2.bin");
   precache_file ("demo1.dem");
   precache_file ("demo2.dem");
   precache_file ("demo3.dem");
   precache_file ("gfx/palette.lmp");
   precache_file ("gfx/colormap.lmp");
   precache_file2 ("gfx/pop.lmp");
   precache_file ("gfx/complete.lmp");
   precache_file ("gfx/inter.lmp");
   precache_file ("gfx/ranking.lmp");
   precache_file ("gfx/vidmodes.lmp");
   precache_file ("gfx/finale.lmp");
   precache_file ("gfx/conback.lmp");
   precache_file ("gfx/qplaque.lmp");
   precache_file ("gfx/menudot1.lmp");
   precache_file ("gfx/menudot2.lmp");
   precache_file ("gfx/menudot3.lmp");
   precache_file ("gfx/menudot4.lmp");
   precache_file ("gfx/menudot5.lmp");
   precache_file ("gfx/menudot6.lmp");
   precache_file ("gfx/menuplyr.lmp");
   precache_file ("gfx/bigbox.lmp");
   precache_file ("gfx/dim_modm.lmp");
   precache_file ("gfx/dim_drct.lmp");
   precache_file ("gfx/dim_ipx.lmp");
   precache_file ("gfx/dim_tcp.lmp");
   precache_file ("gfx/dim_mult.lmp");
   precache_file ("gfx/mainmenu.lmp");
   precache_file ("gfx/box_tl.lmp");
   precache_file ("gfx/box_tm.lmp");
   precache_file ("gfx/box_tr.lmp");
   precache_file ("gfx/box_ml.lmp");
   precache_file ("gfx/box_mm.lmp");
   precache_file ("gfx/box_mm2.lmp");
   precache_file ("gfx/box_mr.lmp");
   precache_file ("gfx/box_bl.lmp");
   precache_file ("gfx/box_bm.lmp");
   precache_file ("gfx/box_br.lmp");
   precache_file ("gfx/sp_menu.lmp");
   precache_file ("gfx/ttl_sgl.lmp");
   precache_file ("gfx/ttl_main.lmp");
   precache_file ("gfx/ttl_cstm.lmp");
   precache_file ("gfx/mp_menu.lmp");
   precache_file ("gfx/netmen1.lmp");
   precache_file ("gfx/netmen2.lmp");
   precache_file ("gfx/netmen3.lmp");
   precache_file ("gfx/netmen4.lmp");
   precache_file ("gfx/netmen5.lmp");
   precache_file ("gfx/sell.lmp");
   precache_file ("gfx/help0.lmp");
   precache_file ("gfx/help1.lmp");
   precache_file ("gfx/help2.lmp");
   precache_file ("gfx/help3.lmp");
   precache_file ("gfx/help4.lmp");
   precache_file ("gfx/help5.lmp");
   precache_file ("gfx/pause.lmp");
   precache_file ("gfx/loading.lmp");
   precache_file ("gfx/p_option.lmp");
   precache_file ("gfx/p_load.lmp");
   precache_file ("gfx/p_save.lmp");
   precache_file ("gfx/p_multi.lmp");
   precache_sound ("misc/menu1.wav");
   precache_sound ("misc/menu2.wav");
   precache_sound ("misc/menu3.wav");
   precache_sound ("ambience/water1.wav");
   precache_sound ("ambience/wind2.wav");
   precache_file2 ("gfx/pop.lmp");


};
entity lastspawn;

void () worldspawn = {

   local string st;
   local float fl;


   lastspawn = world;
   store_obs.cnt = 0.000;


      bspversion = cvar("halflifebsp");

      if (bspversion == 1.000)
      {
         bspversion = 30;
      }
      else 
      {
        bspversion = stof(infokey(world, "*bspversion"));
      }

	if (bspversion == 30)	//Half-Life
	{
		VEC_HULL_MIN = '-16 -16 -24';	//Check vertical positioning. We only know the combined height.
		VEC_HULL_MAX = '16 16 48';	//OUCH!!! Different from Q1 - different models may be required.

		VEC_HULL2_MIN = '-32 -32 -24';	//check vertical positioning.
		VEC_HULL2_MAX = '32 32 40';	//OUCH!!! Different from Q1.

		VEC_HULL3_MIN = '-16 -16 -6';	//OUCH!!!! Too large for q2 maps. It will need seperate models/frames.
		VEC_HULL3_MAX = '16 16 30';
	}
/*	else if (bspversion == 38)	//Quake2 (Can actually be anything - that's the big advantage of q2 maps)
	{	//these should really be kept the same sizes as q1.
		VEC_HULL_MIN = '-16 -16 -24';	//non-crouching players.
		VEC_HULL_MAX = '16 16 32';

		VEC_HULL2_MIN = '-32 -32 -24';	//fits with shambler size.
		VEC_HULL2_MAX = '32 32 64';

		VEC_HULL3_MIN = '-16 -16 -24';
		VEC_HULL3_MAX = '16 16 4';	//OUCH!!!! This is q2's default crouch size.
						//QuakeWorld has it's view position locked at org + '0 0 22'
						//this puts the view inside the ceiling when crouching in qw.
	}*/
	else	//Q1 (assume)
	{
		VEC_HULL_MIN = '-16 -16 -24';
		VEC_HULL_MAX = '16 16 32';

		VEC_HULL2_MIN = '-32 -32 -24';
		VEC_HULL2_MAX = '32 32 64';

		VEC_HULL3_MIN = '-16 -16 -6';	//OUCH!!!! Too large for q2 maps. It will need seperate models/frames.
		VEC_HULL3_MAX = '16 16 30';
	}


   InitBodyQue ();
   if ( (self.model == "maps/e1m8.bsp") ) {

      cvar_set ("sv_gravity","100");

   } else {

      st = infokey (world,"gravity");
      if (st == string_null)
      {
         fl = 800.000;
      }
      else
      {
         fl = stof(st);
     
         if (fl > 2000 || fl < 0)
         {
            fl = 800;
         }
      }
      cvar_set ("sv_gravity",ftos(fl));

   }


   cvar_set ("pausable","0");

   st = infokey (world,"friction");
   if (st == string_null)
   {
      fl = 6.000;
   }
   else
   {
      fl = stof(st);
     
      if (fl > 99 || fl < 0)
      {
         fl = 6;
      }
   }
   cvar_set ("sv_friction",ftos(fl));


   st = infokey (world,"waterfriction");
   if (st == string_null)
   {
      fl = 1.000;
   }
   else
   {
      fl = stof(st);
     
      if (fl > 99 || fl < 0)
      {
         fl = 1;
      }

   }

   cvar_set ("sv_waterfriction",ftos(fl));

   st = infokey (world,"exec_map_cfgs");
   if ( (st == "on") ) {

      st = infokey (world,"cycledir");
      if ( (st != string_null) ) {

         localcmd ("exec ");
         localcmd (st);
         localcmd ("/");

      } else {

         localcmd ("exec qwmcycle/");

      }
      localcmd (mapname);
      localcmd (".cfg\n");

   }
   server_type = 0.000;

   st = infokey (world,"*qwe_version");
   if (st != string_null)
   {
      server_type = 1.000;
   }

   st = infokey (world, "*version");
   if (st != string_null)
   {
      st = infokey (world, "*fuh_version");
      if (st == string_null)
      {
         st = infokey (world, "*ez_version");
         if (st == string_null)
         {
            server_type = 1.000;
         }
      }
   }

/* fix me
   if ((strstr (st, "FTE") != ""))
   {
       server_type = 1.000;

   }
*/
   if (!server_type) 
       dprint("Server incompatible - some features have been disabled.\n");

   st = infokey (world,"unique_models");
   if (st == "on") {
      sep_models = 1.000;
   }

   W_Precache ();
   precache_sound ("demon/dland2.wav");
   precache_sound ("misc/h2ohit1.wav");
   precache_sound ("items/itembk2.wav");
   precache_sound ("player/plyrjmp8.wav");
   precache_sound ("player/land.wav");
   precache_sound ("player/land2.wav");
   precache_sound ("player/drown1.wav");
   precache_sound ("player/drown2.wav");
   precache_sound ("player/gasp1.wav");
   precache_sound ("player/gasp2.wav");
   precache_sound ("player/h2odeath.wav");
   precache_sound ("misc/talk.wav");
   precache_sound ("player/teledth1.wav");
   precache_sound ("misc/r_tele1.wav");
   precache_sound ("misc/r_tele2.wav");
   precache_sound ("misc/r_tele3.wav");
   precache_sound ("misc/r_tele4.wav");
   precache_sound ("misc/r_tele5.wav");
   precache_sound ("weapons/lock4.wav");
   precache_sound ("weapons/pkup.wav");
   precache_sound ("items/armor1.wav");
   precache_sound ("weapons/lhit.wav");
   precache_sound ("weapons/lstart.wav");
   precache_sound ("items/damage3.wav");
   precache_sound ("misc/power.wav");
   precache_sound ("player/gib.wav");
   precache_sound ("player/udeath.wav");
   precache_sound ("player/tornoff2.wav");
   precache_sound ("player/pain1.wav");
   precache_sound ("player/pain2.wav");
   precache_sound ("player/pain3.wav");
   precache_sound ("player/pain4.wav");
   precache_sound ("player/pain5.wav");
   precache_sound ("player/pain6.wav");
   precache_sound ("player/death1.wav");
   precache_sound ("player/death2.wav");
   precache_sound ("player/death3.wav");
   precache_sound ("player/death4.wav");
   precache_sound ("player/death5.wav");
   precache_sound ("boss1/sight1.wav");
   precache_sound ("weapons/ax1.wav");
   precache_sound ("player/axhit1.wav");
   precache_sound ("player/axhit2.wav");
   precache_sound ("player/h2ojump.wav");
   precache_sound ("player/slimbrn2.wav");
   precache_sound ("player/inh2o.wav");
   precache_sound ("player/inlava.wav");
   precache_sound ("misc/outwater.wav");
   precache_sound ("player/lburn1.wav");
   precache_sound ("player/lburn2.wav");
   precache_sound ("misc/water1.wav");
   precache_sound ("misc/water2.wav");
   precache_sound ("items/protect.wav");
   precache_sound ("items/protect2.wav");
   precache_sound ("items/protect3.wav");
   //precache_sound ("speech/ctwin.wav");
   //precache_sound ("speech/terwin.wav");
   precache_model ("progs/player.mdl");
   precache_model ("progs/eyes.mdl");
   precache_model ("progs/h_player.mdl");
   precache_model ("progs/gib1.mdl");
   precache_model ("progs/gib2.mdl");
   precache_model ("progs/gib3.mdl");
   precache_model ("progs/s_bubble.spr");
   precache_model ("progs/s_explod.spr");
   precache_model ("progs/s_plasma.spr");   //plasma
   precache_model ("progs/v_axe.mdl");
   precache_model ("progs/v_shot.mdl");
   precache_model ("progs/v_nail.mdl");
   precache_model ("progs/v_rock.mdl");
   precache_model ("progs/v_shot2.mdl");
   precache_model ("progs/v_nail2.mdl");
   precache_model ("progs/v_rock2.mdl");
   precache_model ("progs/grenade.mdl");
   precache_model ("progs/bolt.mdl");
   precache_model ("progs/bolt2.mdl");
   precache_model ("progs/bolt3.mdl");
   precache_model ("progs/lavaball.mdl");
   precache_model ("progs/missile.mdl");
   precache_model ("progs/spike.mdl");
   precache_model ("progs/s_spike.mdl");
   //precache_model ("progs/w_spike.mdl");
   precache_model ("progs/backpack.mdl");
   precache_model ("progs/zom_gib.mdl");
   precache_model ("progs/v_light.mdl");

   //precache_model ("progs/rings.mdl");    
         
   precache_model2 ("progs/laser.mdl"); 
   precache_sound2 ("enforcer/enfire.wav");
   precache_sound2 ("enforcer/enfstop.wav");
   precache_sound2 ("hknight/attack1.wav");
   precache_model2 ("progs/dot.spr");
   precache_model2 ("progs/caltrop.mdl");
   //precache_model2 ("progs/cross1.mdl");
   precache_model2 ("progs/v_medi.mdl");
   //precache_model2 ("progs/v_bio.mdl");
   precache_model2 ("progs/hgren2.mdl");
   precache_model2 ("progs/biggren.mdl");
   precache_model2 ("progs/flare.mdl");
   precache_model2 ("progs/v_srifle.mdl");
   precache_model2 ("progs/v_plasma.mdl"); // plasma
   precache_model2 ("progs/v_asscan.mdl");
   precache_model2 ("progs/detpack.mdl");
   precache_model2 ("progs/ammobox.mdl");
   precache_model2 ("progs/v_knife.mdl");

//   precache_model2 ("progs/v_knife2.mdl");

   precache_model2 ("progs/v_span.mdl");
   precache_model2 ("progs/e_spike1.mdl");
   precache_model2 ("progs/e_spike2.mdl");
   precache_model2 ("progs/v_rail.mdl");

   if (sep_models) 
   {
      precache_model ("progs/v_tranq.mdl");
      precache_model ("progs/v_flame.mdl");
      precache_model ("progs/v_ican.mdl");

   }

   precache_model2 ("progs/turrgun.mdl");
   precache_model2 ("progs/turrbase.mdl");
   precache_model2 ("progs/tgib1.mdl");
   precache_model2 ("progs/tgib2.mdl");
   precache_model2 ("progs/tgib3.mdl");
   precache_model2 ("progs/disp.mdl");
   precache_model2 ("progs/dgib1.mdl");
   precache_model2 ("progs/dgib2.mdl");
   precache_model2 ("progs/dgib3.mdl");
   precache_model2 ("progs/grenade2.mdl");
   precache_model2 ("progs/v_grap.mdl");
   precache_model2 ("progs/hook.mdl");
   precache_model2 ("progs/caltrop.mdl");
   precache_sound ("doors/baseuse.wav");
   precache_sound ("doors/medtry.wav");
   precache_sound2 ("speech/saveme1.wav");
   precache_sound2 ("speech/saveme2.wav");


   Eluminate();

};

void () StartFrame = {

   teamplay = cvar ("teamplay");
   timelimit = (cvar ("timelimit") * 60.000);
   fraglimit = cvar ("fraglimit");
   deathmatch = cvar ("deathmatch");


};
entity bodyque_head;


void () InitBodyQue = {

   bodyque_head = spawn ();
   bodyque_head.classname = "bodyque";
   bodyque_head.owner = spawn ();
   bodyque_head.owner.classname = "bodyque";
   bodyque_head.owner.owner = spawn ();
   bodyque_head.owner.owner.classname = "bodyque";
   bodyque_head.owner.owner.owner = spawn ();
   bodyque_head.owner.owner.owner.classname = "bodyque";
   bodyque_head.owner.owner.owner.owner = bodyque_head;

};

void (entity ent) CopyToBodyQue = {

   if ( cb_prematch ) {

      return ;

   }
   bodyque_head.angles = ent.angles;
   bodyque_head.model = ent.model;
   bodyque_head.skin = ent.skin;
   bodyque_head.modelindex = ent.modelindex;
   bodyque_head.frame = ent.frame;
   bodyque_head.colormap = ent.colormap;
   bodyque_head.movetype = ent.movetype;
   bodyque_head.velocity = ent.velocity;
   bodyque_head.flags = 0.000;
   setorigin (bodyque_head,ent.origin);
   setsize (bodyque_head,ent.mins,ent.maxs);
  // makestatic(bodyque_head);
   bodyque_head = bodyque_head.owner;

};
