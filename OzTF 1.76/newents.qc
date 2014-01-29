void () DecrementQue = {

   local entity te;

   te = player_head;

   while (( te != world)  )
   {
      if (te.a_n > 1.000) te.a_n = te.a_n - 1.000;
      te = te.nextp;
   }

};



float (entity Player) ping =
{
	local string st;
	local float fl;

	st = infokey (Player, "ping");
	fl = stof (st);
	fl = fl / 1000.000000;
	return (fl);
};


void () ball_reset = {

   self.solid = 1.000;
   self.velocity = '0 0 0';
   self.origin = self.oldorigin;
   setorigin (self,self.origin);


   if ( !droptofloor () ) {

         dprint ("GoalItem fell out of level at ");
         dprint (vtos (self.origin));
         dprint ("\n");
         dremove (self);
         return ;

   }


};


void () ball_spin = {

   local float vel_x;
   local float vel_y;

   if (self.velocity) {
   
     if (self.velocity_x < 0.000) {
        vel_x = self.velocity_x * -1.000;
     } else {
        vel_x = self.velocity_x;
     }

     if (self.velocity_y < 0.000) {
        vel_y = self.velocity_y * -1.000;
     } else {
        vel_y = self.velocity_y;
     }

     self.avelocity_x = (vel_x + vel_y) * 2.000;

   }

};



void (vector o, float z) ball_kick = {

   local vector v;

   v_x = ((o_x * 1.65) + (random() * 20) );
   v_y = ((o_y * 1.65) + (random() * 20) );

   if (o_x < 0.000) {
      o_x = o_x * -1.000;
   }
   if (o_y < 0.000) {
      o_y = o_y * -1.000;
   }

   v_z = ((100 + (random() * 30))  + ((o_y + o_x) * 0.20) + (z * 2.5)  );

   self.flags = self.flags - ( self.flags & 512.000);
   self.velocity = v;

   self.angles = vectoangles (self.velocity);

   ball_spin();




};

void (vector o) ball_fly = {
   local vector v;

	v_x = (o_x * 0.600) + (crandom() * 40);
	v_y = (o_y * 0.600) + (crandom() * 40);

      if (o_x < 0.000) {
         o_x = o_x * -1.000;
      }
      if (o_y < 0.000) {
         o_y = o_y * -1.000;
      }


	v_z = (140 + (crandom() * 40))  + ((o_y + o_x) * 0.20);

      self.flags = self.flags - ( self.flags & 512.000);
	self.velocity = v;

      self.angles = vectoangles (self.velocity);

   ball_spin();


};

void () ball_touch = {

   if (other.classname == "worldspawn") {
		return;
   }
   if (round_over) {
      return;
   }

   if (other.classname == "player") {
      self.oldenemy = other;
	ball_kick(other.velocity, (other.v_angle_x * -1.000));
      return;

   }

   self.oldenemy = other.owner;
   ball_fly(other.velocity);
   return;

};

void () item_ball = {

   self.solid = 1.000;
   self.movetype = 10.000;
   //self.flags= 256.000;

   if ( self.mdl ) {

      precache_model (self.mdl);
      setmodel (self,self.mdl);

   } else {
      precache_model ("progs/ball.mdl");
      self.mdl = "progs/ball.mdl";
      setmodel (self,self.mdl);

   }

   if ( !self.netname ) {

      self.netname = "ball";

   }

   if ( (self.goal_min == '0.000 0.000 0.000') ) {

      self.goal_min = '-12.000 -12.000 -12.000';

   }
   if ( (self.goal_max == '0.000 0.000 0.000') ) {

      self.goal_max = '12.000 12.000 12.000';

   }
   setsize (self,self.goal_min,self.goal_max);

   setorigin (self,self.origin );
   self.oldorigin = self.origin;
   self.touch = ball_touch;

};

void () soccer_goal_touch = {

   if (round_over)  return;

   if (cb_prematch) return;

     if (other.classname == "item_ball") {

        if (other.solid) {


           TeamFortress_TeamIncreaseScore (self.owned_by,self.count);
           TeamFortress_TeamShowScores (2.000);
           sound (self,2.000,self.noise,1.000,0.000);
           round_winner = self.pteam;
           other.solid = 0.000;
        }
        return;

     }

};


void () info_soccer_goal = {
   


   if (!self.noise ) {

      self.noise = "items/tf2kfgc.wav";
   }

   precache_sound (self.noise);
  
   if (self.owned_by == 1.000)
   {
      self.pteam = pteam1;
   }
    else if (self.owned_by == 2.000)
   {
      self.pteam = pteam2;
   }
   else if (self.owned_by == 3.000)
   {
      self.pteam = pteam3;
   }
   else if (self.owned_by == 4.000)
   {
      self.pteam = pteam4;
   }
   InitTrigger();

   self.touch = soccer_goal_touch;

 };


void () func_glass = {

   self.solid = 2.000;
   setmodel (self,self.model);
   self.movetype = 0.000;
   self.modelindex = 0.000;
   self.model = "";
};

// ===============================================================
// RAIN CODE
// ===============================================================

void() rain_touch =
{
      
	// remove rain when it hits ground or any other object
	dremove(self);
};

void() rain_think =
{
	local float temp1,temp2;
	local vector rain_org, rain_vel;

	rain_org = self.origin + '0 0 64';
	temp1 = random();
		temp2 = random();

		// random direction from func_rain origin
		if (temp1 < 0.5)
			rain_org_x = rain_org_x - 64*random();
		else
			rain_org_x = rain_org_x + 64*random();
		if (temp2 < 0.5)
			rain_org_y = rain_org_y - 64*random();
		else
			rain_org_y = rain_org_y + 64*random();

		newmis = spawn();
		setorigin (newmis, rain_org);
		setmodel (newmis, "progs/s_rain.spr");
		newmis.classname = "raindrop";
		newmis.movetype = 6.000;
		newmis.solid = 1.000;
		setsize (newmis, '0 0 0', '0 0 0');
		rain_vel = '0 0 0';
		rain_vel_z = -20*random();
		newmis.touch = rain_touch;

	self.nextthink = time + 0.5;
	self.think = rain_think;
};


void() func_rain =
{

	precache_model ("progs/s_rain.spr");
	precache_sound("ambience/rain.wav");
ambientsound (self.origin, "ambience/rain.wav", 0.5, 3.000);
	self.think = rain_think;
      //self.touch = func_rain_touch;
	self.nextthink = time  + random();
};


void () nogren_touch = {

     
     if (other.classname == "grenade") {
        if (self.spawnflags == 1.000) {
           if (other.tp_grenades_1) {
              other.think = SUB_Remove;
            }
        }
        else if (self.spawnflags == 2.000)
        {
           if (other.tp_grenades_2) {
              other.think = SUB_Remove;
            }
        }
        return;

     }
     if (other.classname == "grentimer") {

        if (self.spawnflags == 1.000) {
           if (other.tp_grenades_1) {
              other.think = SUB_Remove;
            }
        }
        else if (self.spawnflags == 2.000)
        {
           if (other.tp_grenades_2) {
              other.think = SUB_Remove;
            }
        }
        return;

     }


};


void () func_nogrenades = {

   InitTrigger ();
   self.touch = nogren_touch;
};


void () func_nobuild = {

   InitTrigger ();
   self.touch = nobuild_touch;
};


/*

void () hostage_rescue_touch = {

   if (other.classname != "hostage_entity") {

      return;

   }


   num_hostages = num_hostages - 1;

   if (!num_hostages) round_winner = 1;

   TF_AddFrags (other.enemy, 5.000, 0.000);

   other.solid = 0;
   other.tfstate = 1.000;

   setmodel (other,string_null);
   sound (self,2.000,"speech/rescued.wav",1.000,0.000);
    
};

void () func_hostage_rescue = {

   precache_sound ("speech/rescued.wav");
   InitTrigger ();
   self.touch = hostage_rescue_touch;

};

void () info_hostage_rescue = {


   precache_sound ("speech/rescued.wav");

//   self.touch = hostage_rescue_touch;

};
*/
void () func_bomb_target = {

   precache_sound ("speech/bombpl.wav");
   InitTrigger ();
   self.touch = bomb_target_touch;

};

void () info_bombsite = {

   self.classname = "func_bomb_target";
   func_bomb_target ();
};

/*




tokanize ("e-mail icq quote k_nick kf +kf -kf ev +ev -ev w_switch b_switch bw ft fs gender k ln ls lw ss premsg postmsg ke hnw ");
_l_2276 = argc ();


string (float _p_1700) rest =
{
	local string _l_1701;
	local string _l_1702;
	local float _l_1703;
	local float _l_1704;
	local float _l_1705;

	_l_1705 = argc ();
	_l_1704 = _p_1700 - 1.000000;
	if ((!_l_1705 || (argv (_l_1704) == "")))
	{
		return ("");
	}
	_l_1703 = _l_1704;
	while ((_l_1703 <= (_l_1705 - 1.000000)))
	{
		_l_1702 = argv (_l_1703);
		_l_1701 = strcat (_l_1701, _l_1702);
		if ((_l_1703 < (_l_1705 - 1.000000)))
		{
			_l_1701 = strcat (_l_1701, " ");
		}
		_l_1703 = _l_1703 + 1.000000;
	}
	return (_l_1701);
};


float (entity _p_3135) VIP =
{
	if (!msv)
	{
		return (0.000000);
	}
	else
	{
		return (_p_3135.menu.tp_lenght_to_item);
	}
};


void () turn180 =
{
	self.v_angle_y = (self.v_angle_y - 180.000000);
	self.angles = self.v_angle;
	self.fixangle = 1.000000;
};

void () f_jump =
{
	local float _l_11205;

	if ((time < self.attack_finished))
	{
		return;
	}
	if (disallow_kfjump)
	{
		return;
	}
	if (self.noscripts)
	{
		sprint (self, 2.000000, "You have noscripts\n");
		return;
	}
	if ((match_in_progress != 2.000000))
	{
		_l_11205 = w_k_prewar ();
		if ((!allow_prewar_fire () || (k_captains == 2.000000)))
		{
			if ((match_in_progress != 1.000000))
			{
				stuffcmd (self, "bf\n");
				if ((time > (self.k_msgcount + 2.000000)))
				{
					if (!_l_11205)
					{
						sprint (self, 2.000000, "γοξσομεΊ ωου αςε ξοτ αμμοχεδ το ζιςε\n");
					}
					else
					{
						sprint (self, 2.000000, "γοξσομεΊ τωπε ςεαδω το εξαβμε ζιςε\n");
					}
					sprint (self, 3.000000, "\n");
					self.k_msgcount = time;
				}
			}
			return;
		}
	}
	self.v_angle_y = (self.v_angle_y - 180.000000);
	if ((self.weapon != 32.000000))
	{
		self.impulse = 7.000000;
		W_ChangeWeapon ();
	}
	SuperDamageSound ();
	W_Attack ();
	self.v_angle_y = (self.v_angle_y - 180.000000);
	if (allow_bw)
	{
		self.tp_change_back_weapon = 1.000000;
	}
	self.button0 = 0.000000;
	self.impulse = 0.000000;
	self.velocity = (self.velocity * 1.012400);
};

void () look_down =
{
	self.v_angle_x = 80.000000;
	self.angles = self.v_angle;
	self.fixangle = 1.000000;
};

void () centerview =
{
	self.v_angle_x = 0.000000;
	self.angles = self.v_angle;
	self.fixangle = 1.000000;
};

void () r_jump =
{
	local float _l_11225;

	if ((time < self.attack_finished))
	{
		return;
	}
	if (self.noscripts)
	{
		sprint (self, 2.000000, "You have noscripts\n");
		return;
	}
	if ((match_in_progress != 2.000000))
	{
		_l_11225 = w_k_prewar ();
		if ((!allow_prewar_fire () || (k_captains == 2.000000)))
		{
			if ((match_in_progress != 1.000000))
			{
				stuffcmd (self, "bf\n");
				if ((time > (self.k_msgcount + 2.000000)))
				{
					if (!_l_11225)
					{
						sprint (self, 2.000000, "γοξσομεΊ ωου αςε ξοτ αμμοχεδ το ζιςε\n");
					}
					else
					{
						sprint (self, 2.000000, "γοξσομεΊ τωπε ςεαδω το εξαβμε ζιςε\n");
					}
					sprint (self, 3.000000, "\n");
					self.k_msgcount = time;
				}
			}
			return;
		}
	}
	look_down ();
	if ((self.weapon != 32.000000))
	{
		self.impulse = 7.000000;
		W_ChangeWeapon ();
	}
	SuperDamageSound ();
	W_Attack ();
	if (allow_bw)
	{
		self.tp_change_back_weapon = 1.000000;
	}
	centerview ();
	self.button0 = 0.000000;
	self.impulse = 0.000000;
};



void () vote_rpickup =
{
	local float _l_11135;
	local float _l_11136;
	local entity _l_11137;

	if (match_in_progress)
	{
		return;
	}
	w_k_master ();
	if ((w_k_master () && (self.k_admin < 2.000000)))
	{
		locked ();
		return;
	}
	_l_11135 = CountPlayers ();
	if (!self.menu.k_voteunpause)
	{
		k_vrpickup = k_vrpickup + 1.000000;
	}
	_l_11136 = (_l_11135 / 2.000000) + 1.000000;
	_l_11136 = floor (_l_11136);
	if ((k_vrpickup >= _l_11136))
	{
		bprint (2.000000, self.netname, " φοτεσ ζος ςπιγλυπ‘\n");
		_l_11136 = self.k_admin;
		self.k_admin = 2.000000;
		RandomPickup (_l_11136);
		self.k_admin = _l_11136;
		k_vrpickup = 0.000000;
		_l_11137 = find (world, classname, "player");
	}
	else
	{
		if (self.menu.k_voteunpause)
		{
			sprint (self, 2.000000, "Ωου γαξ§τ φοτε νοςε τινεσ");
			sprint (self, 3.000000, "\n");
		}
		else
		{
			bprint (2.000000, self.netname, " φοτεσ ζος ςπιγλυπ‘\n");
			_l_11135 = _l_11136 - k_vrpickup;
			if ((_l_11135 == 1.000000))
			{
				bprint (2.000000, "1 more vote needed\n");
			}
			else
			{
				fbprints (2.000000, _l_11135, " more votes needed\n");
			}
		}
	}
	self.menu.k_voteunpause = 1.000000;
};

*/