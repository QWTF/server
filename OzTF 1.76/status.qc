
void () Status_StartWrite;
void () Status_EndWrite;

//merc skillz!~
void (string str) WriteStr;
void (float f1, float len) WriteRep;

string (float tno) Status_TeamNumToTeamString;
string (float pc) TeamFortress_GetClassName;

//void (float f,float c) WriteIntXX;
//void (float f,float c) WriteIntXXX;
void (float f,float c) WriteIntXXXX;
void (float f) WriteSIntXXXX;	// == -WriteRIntXXX or WriteRIntXXXX

void (float i) WriteSpace;

void (float v, float vmax) WriteBar;

void () RefreshStatusBar =
{

 	local float x; // max 30
	local entity te;
	local float num;
	
	if (self.current_menu)
		return;

	if (self.deadflag)
		return;

      if ((infokey(world, "status") == "Countdown"))
      	return;


	msg_entity = self;

	Status_StartWrite();

      if (round_active) 
      {

            if ((!self.ScannerOn)) {
               if ((self.is_undercover != 2.000)) {

	            te = find (te, classname, "round");

                  WriteSIntXXXX(te.cnt);
	            WriteByte (1, 58);
		      WriteSIntXXXX(te.cnt2);
	            WriteSpace(4);
              }
           }

            if (modetype & 4) {

	 	   if (self.is_detpacking)
		   {
                  WriteStr("setting BOMB");

   			num = stof(infokey (world,"bombarmtime"));
  			if (num < 1.000 || num >  10.000) num = 3.000;

                  WriteBar (time - self.pausetime, num);
			WriteSpace(13);
		   }
            }

	}
      else if (!self.playerclass)
      {
	   Status_EndWrite();
         return;
      }

            if (self.sbar_type & 4.000)
            {
//WriteSpace(23);
               WriteStr("SF:");
		   WriteSIntXXXX (self.real_frags);
               WriteStr(" SD:");
		   WriteSIntXXXX (self.deaths);
	     //WriteByte (1,10);
WriteSpace(1);

            }
            if (self.sbar_type & 8.000)
            {
//WriteSpace(23);
               WriteStr("DR:");
		   WriteSIntXXXX (self.dmg_inflicted);
               WriteStr(" DT:");
		   WriteSIntXXXX (self.dmg_recieved);

	     //WriteByte (1,10);
WriteSpace(1);

            }
            if (self.sbar_type & 16.000)
            {
//WriteSpace(23);
               WriteStr("FT:");
		   WriteSIntXXXX (self.flag_touches);
               WriteStr(" FC:");
		   WriteSIntXXXX (self.flag_captures);

	     WriteByte (1,10);
//WriteSpace(1);

            }
            if (self.sbar_type & 32.000)
            {

	         if (store_obs.cnt == 2)
	         {
                  te = find (world,classname,"item_tfgoal");

                  while ((te != world) && (te.camdist != -1) && (te.team_no == self.pteam.team))
                  {
		         te = find (te, classname, "item_tfgoal");
                  }
//WriteSpace(23);
                  if ((te.owned_by == 1.000) && (te.nextthink - time > 0))
                  {
                     WriteStr("Blue Flag:");
		         WriteSIntXXXX (rint(te.nextthink - time));
                  }
                  if ((te.owned_by == 2.000) && (te.nextthink - time > 0))
                  {
                     WriteStr(" Red Flag:"); 
		         WriteSIntXXXX (rint(te.nextthink - time));
                  }

	     WriteByte (1,10);

               }
            }
      else if (self.stamina && allow_stamina)
      {

         WriteStr("stamina: ");
         WriteBar (self.stamina, 1000);

      }
      else if (self.playerclass == 1) //scout
      {

         te = find (world,netname,"scanner");

         while ((te != world) && (te.owner != self))
         {
		te = find (te, classname, "scanner");
         }

         if ( (self.ScannerOn == 1.000) )
         {
            x = 0;
            if (te.health > 0)
            {

               WriteStr(Status_TeamNumToTeamString(te.pteam.team));
               WriteSpace(1);

               WriteStr(TeamFortress_GetClassName (te.playerclass));
               x = x + 15;
            }
            else
            {
			WriteStr("No Blips");
			x=x+8;
		}

		if (x)
            {
			WriteSpace(18-x);
		}

	      WriteStr("Range: "); 
	      WriteSIntXXXX(te.health);
         }
      }
	else if (self.playerclass == 4)	  // demoman
	{
	 	if (self.is_detpacking)
		{
	            WriteStr("setting detpack");
			WriteSpace(15);
		}
	}
	else if (self.playerclass == 8)
	{
		if (self.is_undercover)
			if (self.is_undercover == 2)
			{
	                  WriteStr("going undercover ");
				WriteSpace(14);
			}
			else
			{
			   x = 0;
                     WriteStr(Status_TeamNumToTeamString(self.undercover_team));
                     WriteSpace(1);
                     WriteStr(TeamFortress_GetClassName (self.undercover_skin));
                     x = x + 20;

			   if (x)
				WriteSpace(30-x);
			}
	}
	else if (self.playerclass == 9)
	{
		x = 0;
		if (self.has_sentry)
		{
			te = find (world, classname, "building_sentrygun");
			while ((te != world) && (te.real_owner != self))
				te = find (te, classname, "building_sentrygun");
			WriteStr("Sentry: ");
		 	//W8C (_S,_e,_n,_t,_r,_y,dperiod,space);
			 WriteSIntXXXX (te.health);
			x = x + 11;
			if (!self.sbar_type & 1.000)
			{
			 	if ((te.ammo_rockets == 0) && (te.ammo_shells == 0))
				{
					WriteStr(" no ammo");
					x = x + 8;
				}
				else if (!te.ammo_shells)
				{
					WriteStr(" no shells");
					x = x + 10;
				}
				else if ((!te.ammo_rockets) && (te.weapon == 3))
				{
					WriteStr(" no rockets");
					x = x + 11;
				}
				else if (te.health != te.max_health)
      			{
					WriteStr(" damaged");

					x = x + 8;
				}
//				else if ((te.ammo_shells != te.maxammo_shells) || ((te.ammo_rockets != te.maxammo_rockets) && (te.weapon == 3)))
//				{
//				 	W8C (space,_n,_o,_t,space,_f,_u,_l);
//					WriteByte (1, _l);
//					x = x + 9;
//				}
			}
			else
			{
			 	WriteByte (1,47);
				WriteSIntXXXX(te.ammo_shells);
				x = x + 4;
				if (te.weapon == 3)
				{
				 	WriteByte (1,47);
					 WriteSIntXXXX(te.ammo_rockets);
					x = x + 3;
				}				
			}
		}
		if ((self.has_dispenser) && (self.sbar_type & 1.000))
		{
		
			newmis = find (world, classname, "building_dispenser");
			while ((newmis != world) && (newmis.real_owner != self))
				newmis = find (newmis, classname, "building_dispenser");
			WriteStr("Dispenser: ");
			 WriteSIntXXXX (newmis.health);
			x = x + 14;
		}
		if ((x >= 0) && (x < 35))
			WriteSpace(35-x);	
	}
	else if (self.playerclass == 5)
	{
            WriteStr("Medikit: ");
		WriteSIntXXXX (self.ammo_medikit);
		WriteSpace(19);
	}
	
	     WriteByte (1,10);
	

           // else 
            //{
	         if (store_obs.cnt == 2)
	         {
                  WriteStr("Blue:");
		      WriteSIntXXXX (pteam1.frags);
                  WriteStr(" Red:");
		      WriteSIntXXXX (pteam2.frags);
               }
	         else
	         {
	         	WriteSIntXXXX (pteam1.frags);
	         	WriteByte(1,47);
	         	WriteSIntXXXX (pteam2.frags);
	         	WriteByte(1,47);
	         	WriteSIntXXXX (pteam3.frags);
	         	WriteByte(1,47);
	         	WriteSIntXXXX (pteam4.frags);
	         }
           // }
	

	if ( (self.playerclass == 11.000) ) {
	
	   Status_EndWrite();
         return;
      }

	if (!self.sbar_type & 1.000)
	{

 	   if (self.current == 128)
		{
       	if ((8 - self.reload_shotgun) > self.ammo_shells) // fixme: ???
         	self.reload_shotgun = (8 - self.ammo_shells);
      	num =(8 - self.reload_shotgun);
   	   }
	   else if (self.current == 256)
	   {
       	if ((16 - self.reload_super_shotgun) > self.ammo_shells)
         	self.reload_super_shotgun = (16 - self.ammo_shells);
      	num =(16 - self.reload_super_shotgun);
		}
   	   else if (self.current == 2048)
	   {
       	if ((6 - self.reload_grenade_launcher) > self.ammo_rockets)
         	self.reload_grenade_launcher = (6 - self.ammo_rockets);
      	num =(6 - self.reload_grenade_launcher);
   	   }
	   else if (self.current == 8192)
	   {
       	if ((4 - self.reload_rocket_launcher) > self.ammo_rockets)
         	self.reload_rocket_launcher = (4 - self.ammo_rockets);
      	num =(4 - self.reload_rocket_launcher);
   	   }
	   else	num = -1;

	   if (num >= 0)
	   {
	//clip
            WriteStr("  √Ã…–∫");
	 	WriteIntXXXX(num,48);
	   }
	   else	WriteSpace(9);
	}
	//grens
         WriteStr(" «±∫");
	   WriteSIntXXXX(self.no_grenades_1);
         WriteStr(" «≤∫");
	   WriteSIntXXXX(self.no_grenades_2);

	Status_EndWrite();
};

void () Status_StartWrite =
{
	local float i;


	if (self.sbar_type & 2.000)
	{
		self.StatusRefreshTime = (time + 1.000);
		WriteByte (1,8);		// start print
		WriteByte (1,2);		// high channel
	}
	else
	{

   
		WriteByte (1,26);		// start centerprint

/*
            if (time < self.CenterPrintTime) 
            {
               if (self.b_b != string_null)
               {
                  i = i - 1.000;
                  WriteStr(self.b_b);
               }
               if (self.b_t != string_null)
               {
                  i = i - 1.000;
                  WriteStr(self.b_t);
               }
               if (self.b_n != string_null)
               {
                  i = i - 1.000;
                  WriteStr(self.b_n);
               }
            }
  */


		self.StatusRefreshTime = (time + 1.500);          
		i = self.StatusBarRes  + self.StatusBarSize;

            if (self.sbar_type & 4) {
              i = i - 1;
            }
            if (self.sbar_type & 8) {
              i = i - 1;
            }
            if (self.sbar_type & 16) {
              i = i - 1;
            }
            if (self.sbar_type & 32) {
              i = i - 1;
            }

		while (i > 0)
		{
		 	WriteByte (1, 10);  		// = \n
		 	i = i - 1;
		}
	}

};

void (float v, float vmax) WriteBar = {


         if (v > vmax * 7 / 8)
         {
		WriteRep(gled,8);
         }
         else if (v > vmax * 6 / 8)
         {
            WriteSpace(1);
		WriteRep(gled,7);
         }
         else if (v > vmax * 5 / 8)
         {
            WriteSpace(2);
		WriteRep(gled,6);
         }
         else if (v > vmax * 4 / 8)
         {
            WriteSpace(3);
		WriteRep(yled,5);
         }
         else if (v > vmax * 3 / 8)
         {
            WriteSpace(4);
		WriteRep(yled,4);
         }
         else if (v > vmax * 2 / 8)
         {
            WriteSpace(5);
		WriteRep(rled,5);
         }
         else if (v > vmax * 1 / 8)
         {
            WriteSpace(6);
            WriteShort (1, rled*256 + rled);
         }
         else 
         {
            WriteSpace(7);
            WriteByte (1, rled);
         }
};


void (string str) WriteStr = {

   local float len;
   local float i;
   local string nwstr;

   len = strlen (str);
   for (i = 0; i < len - 1; i = i + 2) 
   {
      nwstr = substr(str , i , 2);
      WriteShort(1,str2short(nwstr));
   }

   if (i == len - 1)
   {
      nwstr = substr(str , i , 1);
      WriteByte(1,str2byte(nwstr));
   }      
};


void (float f1, float len) WriteRep = 
{
   local float i;

   for (i = 0; i < len - 1; i = i + 2) 
   {
      WriteShort(1, f1 * 256 + f1);
   }

   if (i == len - 1)
   {
      WriteByte(1,f1);
   }     

};

/*
void (float f, float c) WriteIntXX =
{
	local float y;
	
	if (f >= 10)
	{
		
		y = floor(f/10);
		WriteByte (1,y + c);
		f = f - y * 10;

		WriteByte (1,f + c);
	}
	else
	{
	 	WriteByte (1, 32);
		WriteByte (1, f + c);
	} 
	
};

void (float f, float c) WriteIntXXX =
{
	local float y;
	
	if (f >= 100)
	{
		y = floor(f/100);
		WriteByte(1,y + c);
		f = f - y * 100; 
		
		y = floor(f/10);
		WriteByte(1,y + c);
		f = f - y * 10;

		WriteByte(1,f + c);
	}
	else
	{
		WriteByte (1, 32);
		WriteIntXX(f,c);
	} 
	
};
*/

void (float f, float c) WriteIntXXXX =
{
	local float y;
      local float print;
	
	if (f >= 100000)
	{
		y = floor(f/100000);
		WriteByte(1,y + c);
		f = f - y * 100000; 
            print = 1;
	}
	if (f >= 10000 || print)
	{
		y = floor(f/10000);
		WriteByte(1,y + c);
		f = f - y * 10000;
            print = 1;
	}
	if (f >= 1000 || print)
	{
		y = floor(f/1000);
		WriteByte(1,y + c);
		f = f - y * 1000; 
            print = 1;
	}
	if (f >= 100 || print)
	{
		y = floor(f/100);
		WriteByte(1,y + c);
		f = f - y * 100;
            print = 1;
	}
	if (f >= 10 || print)
	{
		y = floor(f/10);
		WriteByte (1,y + c);
		f = f - y * 10;
		WriteByte (1,f + c);
	
	}
	else
	{
	 	WriteByte (1, 32);
		WriteByte (1,f + c);
	} 
	
};

void (float f) WriteSIntXXXX =
{
	local float i;
	
	if (f >= 0)
	{
	 	WriteIntXXXX(f,COLOR_WHITE);
		return;
	}
	f = 0 - f;
	
	if (f > 99)
	{
		WriteByte (1, 45 + 128);
		WriteIntXXXX(i, COLOR_WHITE);
		return;
	}
	if (f > 9)
	{
	 	WriteByte (1, 32);
		WriteByte (1, 45 + 128);
		WriteIntXXXX(i,COLOR_WHITE);
		return;
	}
	 	
	WriteByte (1, 32);
	WriteByte (1, 45);
	WriteByte (1, i + 48);
	WriteByte (1, 32);
};


void (float i) WriteSpace =
{
 	while (i)
	{
		WriteByte(1, 32);
		i = i - 1;
	}
};

void () Status_EndWrite =
{
	WriteByte (1, 0);		// will put some more code later :)
};
	
void () StatusBar_On =
{

	if (!self.StatusBarSize) {

            self.StatusRefreshTime = (time + 60.000);

	} else {

	   if (self.StatusBarSize) 
		self.StatusRefreshTime = (time + 0.100);
	   
	}
};	
	
// END status bar

float (float f) Impulse2Res =
{
	if (f == 1)
		return SBAR_200;
	if (f == 2)
		return SBAR_240;
	if (f == 3)
		return SBAR_300;
	if (f == 4)
		return SBAR_350;
	if (f == 5)
		return SBAR_384;
	if (f == 6)
		return SBAR_400;
	if (f == 7)
		return SBAR_480;
	if (f == 8)
		return SBAR_600;
	if (f == 9)
		return SBAR_768;
	return f;
};
		

void (float res) StatusRes = {


   self.last_impulse = 0.000;

   if (!res) return;

   self.StatusBarRes = Impulse2Res(res);

   if ( (res == 9) ) {

      sprint (self,2,"Status Bar Res set to 1024x768.\n");

   } else {

      if ( (res == 8) ) {

         sprint (self,2,"Status Bar Res set to 800x600.\n");

      } else {

         if ( (res == 7) ) {

            sprint (self,2,"Status Bar Res set to 640x480.\n");

         } else {

            if ( (res == 6) ) {

               sprint (self,2,"Status Bar Res set to 640x400.\n");

            } else {

               if ( (res == 5) ) {

                  sprint (self,2,"Status Bar Res set to 512x384.\n");

               } else {

                  if ( (res == 4) ) {

                     sprint (self,2,"Status Bar Res set to 320x350.\n");

                  } else {

                     if ( (res == 3) ) {

                        sprint (self,2,"Status Bar Res set to 400x300.\n");

                     } else {

                        if ( (res == 2) ) {

                           sprint (self,2,"Status Bar Res set to 320x240.\n");


                        } else {

                           if ( (res == 1) ) {

                              sprint (self,2,"Status Bar Res set to 320x200.\n");

                           }

                        }

                     }

                  }

               }

            }

         }

      }

   }

};

void (entity pl, string s1) CenterPrint = {

   //pl.b_b = s1;
   //pl.b_t = string_null;
   //pl.b_n = string_null;
   //pl.CenterPrintTime = (time + 1.500);
   centerprint (pl,s1);
   pl.StatusRefreshTime = (time + 1.500);

};

void (entity pl, string s1, string s2) CenterPrint2 = {

   //pl.b_b = s1;
   //pl.b_t = s2;
   //pl.b_n = string_null;
   centerprint2 (pl,s1,s2);
   pl.StatusRefreshTime = (time + 1.500);

};

void (entity pl, string s1, string s2, string s3) CenterPrint3 = {

   //pl.b_b = s1;
   //pl.b_t = s2;
   //pl.b_n = s3;
   centerprint3 (pl,s1,s2,s3);
   pl.StatusRefreshTime = (time + 1.500);

};

void (string s1, string s2, string s3) PrintPlayers = {

   local entity te;

   te = player_head;

   while (te)
   {

      if (s1 != string_null)
      {
         sprint(te, 2.000, s1);
         if (s2 != string_null)
         {
            sprint(te, 2.000, s2);
            if (s3 != string_null)
            {
               sprint(te, 2.000, s3);
            }
         }
      }
      te = te.nextp;
   }
};

void (string s1, string s2, string s3) PrintSpecs = {

   local entity te;

   te = spec_head;

   while (te)
   {

      if (s1 != string_null)
      {
         sprint(te, 2.000, s1);
         if (s2 != string_null)
         {
            sprint(te, 2.000, s2);
            if (s3 != string_null)
            {
               sprint(te, 2.000, s3);
            }
         }
      }
      te = te.nexts;
   }
};




string(float type) Status_GrenTypeToString =
{
	if (type == 1)
      return "Grenade";
	if (type == 2)
      return "Concussion grenade";
 	if (type == 3)
    	return "Nail grenade";
	if (type == 4)
 	return "Mirv grenade";
 	if (type == 5)
   	return "Napalm grenade";
	if (type == 6)
     	return "Freeze grenade";
	if (type == 7)
     	return "Gas grenade";
	if (type == 8)
     	return "EMP grenade";
 	if (type == 9)
     	return "Flash grenade";
	if (type == 10)
     	return "Caltrop canister";

	return "N/A";
		
};

string (float tno) Status_TeamNumToTeamString =
{
 	if (tno == 1)
		return "blue";
	if (tno == 2)
		return "red";
	if (tno == 3)
		return "yellow";
	if (tno == 4)
		return "green";

   return "observer";
};

