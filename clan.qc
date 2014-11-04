
void () PreMatch_Think =
{
    local string st;
    local entity te;
    local entity oldself;
    local entity gren;
	
	local float time_left;
	time_left = rint ((countdown_start_time + prematch_countdown) - time);

// Quick and ugly hack. Leave countdown menu off by default, have user set serverinfo newcountdown on to use it.

	st = infokey (world, "newcountdown");
	if (st == string_null)
			st = infokey (world, "ncd");

	// Since pipebombs/grens were enabled during pm, we need to clear them before the 10 seconds are up so they don't explode at the
	// start of the match and open any buttons/doors
	te = find (world, classname, "player");
	while (te) {
		oldself = self;
		self = te;
	
		if (self.hook_out) {
			Reset_Grapple (self.hook);
			Attack_Finished (0.75);
			self.hook_out = 1;
		}
		TeamFortress_RemoveTimers ();
		gren = find (world, classname, "grenade");
		
		while (gren) {
			if (gren.owner == self) {
				gren.nextthink = time + 0.1;
			}
			gren = find (gren, classname, "grenade");
		}
		self = oldself;
		te = find (te, classname, "player");
    }

	if ((st == "on") || (st == "1")) {
		local string countdown;
		local string sinfo_timelimit;
		local string tlvalue;
		local string sinfo_fraglimit;
		local string flvalue;
		local string sinfo_rj;
		local string rjvalue;
		local string sinfo_map;
		
		local string limits; local string scoutlim; local string soldlim; local string snipelim; local string demolim;
		local string medlim; local string hwlim; local string pyrlim; local string spylim; local string englim; local string randlim;
		
		local string limit1; local string limit2; local string limit3; local string limit4; local string limit5;
		local string limit6; local string limit7; local string limit8; local string limit9; local string limit10;
		
		local string classlimits; local string classlimits1; local string classlimits2; local string classlimits3; local string classlimits4; 
		local string classlimits5; local string classlimits6; local string classlimits7; local string classlimits8;
		
		local string limscoutshort; local string limsnipeshort; local string limsoldshort; local string limdemoshort; local string limmedshort;
		local string limhwshort; local string limpyrshort; local string limspyshort; local string limengshort; local string limrandshort;

		local string limscoutlong; local string limsnipelong; local string limsoldlong; local string limdemolong; local string limmedlong;
		local string limhwlong; local string limpyrlong; local string limspylong; local string limenglong; local string limrandlong;
		
		local string scoutpad; local string snipepad; local string soldpad; local string demopad; local string medpad; local string hwpad; local string pyrpad; local string spypad; local string engpad; local string randpad;
		
		
		// If the countdown becomes default, move this code to tfort.qc in ready function, then remove the check for sbar_code_executed
		local entity search;
		search = find (world, classname, "player");
		if ( (is_sbar_on == "1")  && (sbar_code_executed != "1") ) {
			while (search) {
				if (search.netname != string_null){
					stuffcmd (search, "impulse 183\n"); // sbar_off because it causes the countdown menu to flicker
					sbar_code_executed = "1";
				}
				search = find (search, classname, "player");
			}
		}
			
		if (time_left > 0) {
			st = ftos (time_left);
			
			te = find (world, classname, "player");	
		
			while (te) { // Countdown menu
				if (self.hook_out < time) {
					sound (te, 0, "buttons/switch04.wav", 1, 0);
					self.hook_out = time + 0.9;
				}
				
					//make sure timelimit, fraglimit, and rj exist and are not more than 4 characters.
					if ((infokey (world, "timelimit")) == string_null)
						tlvalue = "0";
					else if ((strlen(infokey (world, "timelimit"))) > 4)
						tlvalue = "9999";
					else
						tlvalue = (infokey (world, "timelimit"));
						
					if ((infokey (world, "fraglimit")) == string_null)
						flvalue = "0";
					else if ((strlen(infokey (world, "fraglimit"))) > 4)
						flvalue = "9999";
					else
						flvalue = (infokey (world, "fraglimit"));
					
					if ((infokey (world, "rj")) == string_null)
						rjvalue = "0";
					else if ((strlen(infokey (world, "rj"))) > 4)
						rjvalue = "9999";
					else
						rjvalue = (infokey (world, "rj"));				
					
					countdown = strcat("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\sCountdown\s: ", st);
					
					// Properly align countdown
					if ((strlen(st)) > 1) {
						sinfo_timelimit = strcat("  \n\n\sTimelimit\s: ",tlvalue);
					}
					else {
						sinfo_timelimit = strcat("   \n\n\sTimelimit\s: ",tlvalue);
					}
					
					// Properly align timelimit, support up to 9999
					if ((strlen(tlvalue)) > 3) {
						sinfo_fraglimit = strcat("\n\sFraglimit\s: ",flvalue);
					}
					else if ((strlen(tlvalue)) > 2) {
						sinfo_fraglimit = strcat(" \n\sFraglimit\s: ",flvalue);
					}
					else if ((strlen(tlvalue)) > 1) {
						sinfo_fraglimit = strcat("  \n\sFraglimit\s: ",flvalue);
					}
					else if ((strlen(tlvalue)) > 0) {
						sinfo_fraglimit = strcat("   \n\sFraglimit\s: ",flvalue);
					}
					else {
						sinfo_fraglimit = strcat("   \n\sFraglimit\s: ",flvalue);
					}
					
					// Properly align fraglimit, support up to 9999
					if ((strlen(flvalue)) > 3) {
						sinfo_rj = strcat("\n\sRj\s:        ",rjvalue);
					}
					else if ((strlen(flvalue)) > 2) {
						sinfo_rj = strcat(" \n\sRj\s:        ",rjvalue);
					}
					else if ((strlen(flvalue)) > 1) {
						sinfo_rj = strcat("  \n\sRj\s:        ",rjvalue);
					}
					else if ((strlen(flvalue)) > 0) {
						sinfo_rj = strcat("   \n\sRj\s:        ",rjvalue);
					}
					else {
						sinfo_rj = strcat("   \n\sRj\s:        ",rjvalue);
					}
					
					
					// Start class limits logic
						limscoutshort = (infokey (world, "cr_sc"));
						limsnipeshort = (infokey (world, "cr_sn"));
						limsoldshort = (infokey (world, "cr_so"));
						limdemoshort = (infokey (world, "cr_de"));
						limmedshort = (infokey (world, "cr_me"));
						limhwshort = (infokey (world, "cr_hw"));
						limpyrshort = (infokey (world, "cr_py"));
						limspyshort = (infokey (world, "cr_sp"));
						limengshort = (infokey (world, "cr_en"));
						limrandshort = (infokey (world, "cr_ra"));
									
						limscoutlong = (infokey (world, "cr_scout"));
						limsnipelong = (infokey (world, "cr_sniper"));
						limsoldlong = (infokey (world, "cr_soldier"));
						limdemolong = (infokey (world, "cr_demoman"));
						limmedlong = (infokey (world, "cr_medic"));
						limhwlong = (infokey (world, "cr_hwguy"));
						limpyrlong = (infokey (world, "cr_pyro"));
						limspylong = (infokey (world, "cr_spy"));
						limenglong = (infokey (world, "cr_engineer"));
						limrandlong = (infokey (world, "cr_random"));
					
					// Are there any class limits?			
					if (((( limscoutshort	!= string_null) && (stof(limscoutshort)	!= 0)) || (( limscoutlong 	!= string_null) && (stof(limscoutlong) 	!= 0))) ||
						((( limsnipeshort 	!= string_null) && (stof(limsnipeshort)	!= 0)) || (( limsnipelong 	!= string_null) && (stof(limsnipelong)	!= 0))) ||
						((( limsoldshort 	!= string_null) && (stof(limsoldshort)	!= 0)) || (( limsoldlong 	!= string_null) && (stof(limsoldlong) 	!= 0))) ||
						((( limdemoshort 	!= string_null) && (stof(limdemoshort) 	!= 0)) || (( limdemolong 	!= string_null) && (stof(limdemolong)	!= 0))) ||
						((( limmedshort	 	!= string_null) && (stof(limmedshort) 	!= 0)) || (( limmedlong	 	!= string_null) && (stof(limmedlong) 	!= 0))) ||
						((( limhwshort 		!= string_null) && (stof(limhwshort)	!= 0)) || (( limhwlong	 	!= string_null) && (stof(limhwlong)	 	!= 0))) ||
						((( limpyrshort 	!= string_null) && (stof(limpyrshort)	!= 0)) || (( limpyrlong 	!= string_null) && (stof(limpyrlong)	!= 0))) ||
						((( limspyshort 	!= string_null) && (stof(limspyshort) 	!= 0)) || (( limspylong		!= string_null) && (stof(limspylong) 	!= 0))) ||
						((( limengshort	 	!= string_null) && (stof(limengshort) 	!= 0)) || (( limenglong 	!= string_null) && (stof(limenglong) 	!= 0))) ||
						((( limrandshort 	!= string_null) && (stof(limrandshort)	!= 0)) || (( limrandlong 	!= string_null) && (stof(limrandlong) 	!= 0)))) {
										
						if (((stof(limscoutshort) == 1) 	|| (stof(limscoutlong) == 1)) &&
							( (stof(limsnipeshort) == 1) 	|| (stof(limsnipelong) == 1)) &&
							( (stof(limsoldshort) == 1) 	|| (stof(limsoldlong) == 1)	) &&
							( (stof(limdemoshort) == 1) 	|| (stof(limdemolong) == 1)	) &&
							( (stof(limmedshort) == 1) 		|| (stof(limmedlong) == 1)	) &&
							( (stof(limhwshort) == 1) 		|| (stof(limhwlong) == 1)	) &&
							( (stof(limpyrshort) == 1) 		|| (stof(limpyrlong) == 1)	) &&
							( (stof(limspyshort) == 1) 		|| (stof(limspylong) == 1)	) &&
							( (stof(limengshort) == 1) 		|| (stof(limenglong) == 1)	)) { //highlander mode. This if statement MUST come first or else we will get strcat overflow
							
							classlimits = "           Highlander!";
						}
						else { // Not highlander.
							//Scout limit
							if (((limscoutshort != string_null) && (stof(limscoutshort) != 0)) || ((limscoutlong != string_null) && (stof(limscoutlong) != 0))) {
								if ((limscoutshort != string_null) && (stof(limscoutshort) != 0))
									scoutlim = strcat(limscoutshort, " Scout");
								else
									scoutlim = strcat(limscoutlong, " Scout");
							
								if ((strlen(scoutlim)) > 7) {
									scoutpad = strcat("      ", scoutlim);
									limit1 = strcat(scoutpad, "\n");
								}
								else  {
									scoutpad = strcat("        ", scoutlim);
									limit1 = strcat(scoutpad, " \n");
								}
							}
						
							//Sniper limit
							if (((limsnipeshort != string_null) && (stof(limsnipeshort) != 0)) || ((limsnipelong != string_null) && (stof(limsnipelong) != 0))) {
								if ((limsnipeshort != string_null) && (stof(limsnipeshort) != 0))
									snipelim = strcat(limsnipeshort, " Snipe");
								else
									snipelim = strcat(limsnipelong, " Snipe");
							
								if ((strlen(snipelim)) > 7) {
									snipepad = strcat("      ", snipelim);
									limit2 = strcat(snipepad, "\n");
								}
								else  {
									snipepad = strcat("        ", snipelim);
									limit2 = strcat(snipepad, " \n");
								}
							}
						
							//Soldier limit
							if (((limsoldshort != string_null) && (stof(limsoldshort) != 0)) || ((limsoldlong != string_null) && (stof(limsoldlong) != 0))) {
								if ((limsoldshort != string_null) && (stof(limsoldshort) != 0))
									soldlim = strcat(limsoldshort, " Sold");
								else
									soldlim = strcat(limsoldlong, " Sold");
								
								if ((strlen(soldlim)) > 6) {
									soldpad = strcat("     ", soldlim);
									limit3 = strcat(soldpad, "\n");
								}
								else {
									soldpad = strcat("       ", soldlim);
									limit3 = strcat(soldpad, " \n");
								}
							}
							
							//Demoman limit
							if (((limdemoshort != string_null) && (stof(limdemoshort) != 0)) || ((limdemolong != string_null) && (stof(limdemolong) != 0))) {
								if ((limdemoshort != string_null) && (stof(limdemoshort) != 0))
									demolim = strcat(limdemoshort, " Demo");
								else
									demolim = strcat(limdemolong, " Demo");
								
								if ((strlen(demolim)) > 6) {
									demopad = strcat("     ", demolim);
									limit4 = strcat(demopad, "\n");
								}
								else {
									demopad = strcat("       ", demolim);
									limit4 = strcat(demopad, " \n");
								}
							}
							
							//Medic limit
							if (((limmedshort != string_null) && (stof(limmedshort) != 0)) || ((limmedlong != string_null) && (stof(limmedlong) != 0))) {
								if ((limmedshort != string_null) && (stof(limmedshort) != 0))
									medlim = strcat(limmedshort, " Medic");
								else
									medlim = strcat(limmedlong, " Medic");
								
								if ((strlen(medlim)) > 7) {
									medpad = strcat("      ", medlim);
									limit5 = strcat(medpad, "\n");
								}
								else {
									medpad = strcat("        ", medlim);
									limit5 = strcat(medpad, " \n");
								}
							}
						
							//Hwguy limit
							if (((limhwshort != string_null) && (stof(limhwshort) != 0)) || ((limhwlong != string_null) && (stof(limhwlong) != 0))) {
								if ((limhwshort != string_null) && (stof(limhwshort) != 0))
									hwlim = strcat(limhwshort, " HWGuy");
								else
									hwlim = strcat(limhwlong, " HWGuy");
							
								if ((strlen(hwlim)) > 7) {
									hwpad = strcat("      ", hwlim);
									limit6 = strcat(hwpad, "\n");
								}
								else {
									hwpad = strcat("        ", hwlim);
									limit6 = strcat(hwpad, " \n");
								}
							}
						
							//Pyro limit
							if (((limpyrshort != string_null) && (stof(limpyrshort) != 0)) || ((limpyrlong != string_null) && (stof(limpyrlong) != 0))) {
								if ((limpyrshort != string_null) && (stof(limpyrshort) != 0))
									pyrlim = strcat(limpyrshort, " Pyro");
								else
									pyrlim = strcat(limpyrlong, " Pyro");
							
								if ((strlen(pyrlim)) > 6) {
									pyrpad = strcat("     ", pyrlim);
									limit7 = strcat(pyrpad, "\n");
								}
								else {
									pyrpad = strcat("       ", pyrlim);
									limit7 = strcat(pyrpad, " \n");
								}
							}
						
							//Spy limit
							if (((limspyshort != string_null) && (stof(limspyshort) != 0)) || ((limspylong != string_null) && (stof(limspylong) != 0))) {
								if ((limspyshort != string_null) && (stof(limspyshort) != 0))
									spylim = strcat(limspyshort, " Spy");
								else
									spylim = strcat(limspylong, " Spy");
							
								if ((strlen(spylim)) > 5) {
									spypad = strcat("    ", spylim);
									limit8 = strcat(spypad, "\n");
								}
								else {
									spypad = strcat("      ", spylim);
									limit8 = strcat(spypad, " \n");
								}
							}
						
							//Eng limit
							if (((limengshort != string_null) && (stof(limengshort) != 0)) || ((limenglong != string_null) && (stof(limenglong) != 0))) {
								if ((limengshort != string_null) && (stof(limengshort) != 0))
									englim = strcat(limengshort, " Eng");
								else
									englim = strcat(limenglong, " Eng");
							
								if ((strlen(englim)) > 5) {
									engpad = strcat("    ", englim);
									limit9 = strcat(engpad, "\n");
								}
								else {
									engpad = strcat("      ", englim);
									limit9 = strcat(engpad, " \n");
								}
							}
						
							//"Random" limit
							if (((limrandshort != string_null) && (stof(limrandshort) != 0)) || ((limrandlong != string_null) && (stof(limrandlong) != 0))) {
								if ((limrandshort != string_null) && (stof(limrandshort) != 0))
									randlim = strcat(limrandshort, " Rand");
								else
									randlim = strcat(limrandlong, " Rand");
							
								if ((strlen(randlim)) > 6) {
									randpad = strcat("     ", randlim);
									limit10 = strcat(randpad, "\n");
								}
								else {
									randpad = strcat("       ", randlim);
									limit10 = strcat(randpad, " \n");
								}
							}
						
							classlimits1 = strcat(limit1, limit2);
							classlimits2 = strcat(classlimits1, limit3);
							classlimits3 = strcat(classlimits2, limit4);
							classlimits4 = strcat(classlimits3, limit5);
							classlimits5 = strcat(classlimits4, limit6);
							classlimits6 = strcat(classlimits5, limit7);
							classlimits7 = strcat(classlimits6, limit8);
							classlimits8 = strcat(classlimits7, limit9);
							classlimits = strcat(classlimits8, limit10);
						}
						
						// Properly align rj, support up to 9999
						if ((strlen(rjvalue)) > 3) {
							limits = strcat("\n\n\sLimits\s:        \n",classlimits);
						}
						else if ((strlen(rjvalue)) > 2) {
							limits = strcat(" \n\n\sLimits\s:        \n",classlimits);
						}
						else if ((strlen(rjvalue)) > 1) {
							limits = strcat("  \n\n\sLimits\s:        \n",classlimits);
						}
						else if ((strlen(rjvalue)) > 0) {
							limits = strcat("   \n\n\sLimits\s:        \n",classlimits);
						}
						else {
							limits = strcat("   \n\n\sLimits\s:        \n",classlimits);
						}
						
						sinfo_map = strcat("\n\n\sMap\s: ",(infokey (world, "map")));
					}
					else { // no limits, so just print maps
						// Properly align rj, support up to 9999
						if ((strlen(rjvalue)) > 3) {
							sinfo_map = strcat("\n\n\sMap\s: ",(infokey (world, "map")));
						}
						else if ((strlen(rjvalue)) > 2) {
							sinfo_map = strcat(" \n\n\sMap\s: ",(infokey (world, "map")));
						}
						else if ((strlen(rjvalue)) > 1) {
							sinfo_map = strcat("  \n\n\sMap\s: ",(infokey (world, "map")));
						}
						else if ((strlen(rjvalue)) > 0) {
							sinfo_map = strcat("   \n\n\sMap\s: ",(infokey (world, "map")));
						}
						else {
							sinfo_map = strcat("   \n\n\sMap\s: ",(infokey (world, "map")));
						}
					}
				
				
				centerprint (te, countdown, sinfo_timelimit, sinfo_fraglimit, sinfo_rj, limits, sinfo_map); // Print countdown menu
				te = find(te, classname, "player");
			}
			self.nextthink = time + 1;
			return;
		}
		
		if (sbar_code_executed == "1")
			stuffcmd (search, "impulse 182\n"); // sbar_on
			
		localcmd ("serverinfo status2 Match\n");
		localcmd ("serverinfo status Match\n");
		
		bprint (PRINT_HIGH, "MATCH BEGINS NOW\n");
		
		if (game_locked)
			bprint (PRINT_HIGH, "GAME IS NOW LOCKED\n");
	}
	else { // no countdown menu, default countdown instead
		
		if (time_left > 1) {
			st = ftos (time_left);
			bprint2 (PRINT_HIGH, st, " seconds.\n");
			self.nextthink = time + 1;
			return;
		}
		else if (time_left > 0) {
			bprint (PRINT_HIGH, "1 second.\n");
			self.nextthink = time + 1;
			return;
		}
		
		
		localcmd ("serverinfo status2 Match\n");
		localcmd ("serverinfo status Match\n");
		bprint (PRINT_HIGH, "MATCH BEGINS NOW\n");
			
		if (game_locked)
			bprint (PRINT_HIGH, "GAME IS NOW LOCKED\n");
	}

    team4score = 0;
    team3score = 0;
    team2score = 0;
    team1score = 0;
    team4frags = 0;
    team3frags = 0;
    team2frags = 0;
    team1frags = 0;

    te = find (world, classname, "player");
    while (te) {
		oldself = self;
		self = te;
	
		if (self.tf_id == 0) {
			last_id = last_id + 20 + random () * 10;
			self.tf_id = rint (random () * 10 + last_id);
			st = ftos (self.tf_id);
			stuffcmd (self, "setinfo tf_id ");
			stuffcmd (self, st);
			stuffcmd (self, "\n");
			sprint (self, PRINT_HIGH, "Your Battle ID is ", st, "\n");
		}
		if (self.hook_out) {
			Reset_Grapple (self.hook);
			Attack_Finished (0.75);
			self.hook_out = 1;
		}
		TeamFortress_RemoveTimers ();
		self.frags = 0;
		self.real_frags = 0;
		gren = find (world, classname, "grenade");
		
		while (gren) {
			if (gren.owner == self) {
				gren.nextthink = time + 0.1;
			}
			gren = find (gren, classname, "grenade");
		}
		
		TF_T_Damage (self, world, world, self.health + 1, 1, 0);
		self = oldself;
		te = find (te, classname, "player");
    }
};

void () DumpClanScores =
{
	
	// If we are dumping scores, we have finished a match. Put server in standby
	localcmd ("serverinfo status Standby\n");
    
	local float winners;
    local float no_teams;
    local float printed;
    local float ti;
    local float teamfrags;
    local string st;
    local entity te;
    local float t1_pl;	local string players1;	local float t1_unacc;	local string t1frags;	local string t1unaccfrags;	local string t1score;
    local float t2_pl;	local string players2;	local float t2_unacc;	local string t2frags;	local string t2unaccfrags;	local string t2score;
    local float t3_pl;	local string players3;	local float t3_unacc;	local string t3frags;	local string t3unaccfrags;	local string t3score;
    local float t4_pl;	local string players4;	local float t4_unacc;	local string t4frags;	local string t4unaccfrags;	local string t4score;
    local string space1;	local string space2;	local string space3;
	
	t1_pl = TeamFortress_TeamGetNoPlayers (1);
    t2_pl = TeamFortress_TeamGetNoPlayers (2);
    t3_pl = TeamFortress_TeamGetNoPlayers (3);
    t4_pl = TeamFortress_TeamGetNoPlayers (4);

    printed = 0;
    no_teams = 0;
    
	if (t1_pl) {
		no_teams = no_teams + 1;
    }
    if (t2_pl) {
		no_teams = no_teams + 1;
    }
    if (t3_pl) {
		no_teams = no_teams + 1;
    }
    if (t4_pl) {
		no_teams = no_teams + 1;
    }
    if (no_teams < 2) {
		return;
    }
    t4_unacc = 0;
    t3_unacc = 0;
    t2_unacc = 0;
    t1_unacc = 0;

    ti = 0;

    teamfrags = toggleflags & (TFLAG_TEAMFRAGS | TFLAG_FULLTEAMSCORE);

    te = find (world, classname, "player");
    while (te) {
		if (te.team_no == 1) {
			t1_unacc = t1_unacc + te.real_frags;
		} else if (te.team_no == 2) {
			t2_unacc = t2_unacc + te.real_frags;
		} else if (te.team_no == 3) {
			t3_unacc = t3_unacc + te.real_frags;
		} else if (te.team_no == 4) {
			t4_unacc = t4_unacc + te.real_frags;
		}
		te = find (te, classname, "player");
    }
    t1_unacc = team1frags - t1_unacc;
    t2_unacc = team2frags - t2_unacc;
    t3_unacc = team3frags - t3_unacc;
    t4_unacc = team4frags - t4_unacc;

    winners = TeamFortress_TeamGetWinner ();

    bprint (PRINT_HIGH, "\n\n=-------= \sMatch Results\s =-------="); //covers all four teams
    	
	//Print team names
	bprint (PRINT_HIGH, "\nTeam:        ");
	if (t1_pl > 0) { bprint (PRINT_HIGH, "blue"); }
	else { bprint (PRINT_HIGH, "    "); }
	if (t2_pl > 0) { bprint (PRINT_HIGH, " red"); }
	else { bprint (PRINT_HIGH, "    "); }
	if (t3_pl > 0) { bprint (PRINT_HIGH, "  grn"); }
	else { bprint (PRINT_HIGH, "     "); }
	if (t4_pl > 0) { bprint (PRINT_HIGH, "  yell"); }
	
	//Print the number of PLAYERS per team, assume 99 max players (two digits)
	bprint (PRINT_HIGH, "\nPlayers:     ");
	
	players1 = "     ";
	players2 = "     ";
	players3 = "     ";
	space1 = "";
	space2 = "";
	space3 = "";	

	if (t1_pl > 0) { // players1 + space1 should add to "5" (4 chars for score, 1 for space)
		players1 = ftos (TeamFortress_TeamGetNoPlayers (1));
		
		if (strlen(players1) == 1)
			space1 = "    ";
		else if (strlen(players1) == 2)
			space1 = "   ";
		else if (strlen(players1) == 3)
			space1 = "  ";
		else if (strlen(players1) > 3) { // it's 4 or more?
			players1 = substring(players1, 0, 4); // just take first 4 chars of score
			space1 = " ";
		}
	}
	
	if (t2_pl > 0) {
		players2 = ftos (TeamFortress_TeamGetNoPlayers (2));
		
		if (strlen(players2) == 1)
			space2 = "    ";
		if (strlen(players2) == 2)
			space2 = "   ";
		else if (strlen(players2) == 3)
			space2 = "  ";
		else if (strlen(players2) > 3) { // it's 4 or more?
			players2 = substring(players2, 0, 4);
			space2 = " ";
		}
	}
	
	if (t3_pl > 0) {
		players3 = ftos (TeamFortress_TeamGetNoPlayers (3));
		
		if (strlen(players3) == 1)
			space3 = "    ";
		if (strlen(players3) == 2)
			space3 = "   ";
		else if (strlen(players3) == 3)
			space3 = "  ";
		else if (strlen(players3) > 3) { // it's 4 or more?
			players3 = substring(players3, 0, 4);
			space3 = " ";
		}
	}	

	if (t4_pl > 0) {
		players4 = ftos (TeamFortress_TeamGetNoPlayers (4));
		players4 = substring(players4, 0, 4); //let's just make sure it's at most 4 characters
	}
	
	bprint2 (PRINT_HIGH, players1, space1, players2, space2, players3, space3, players4);

	//Print the number of FRAGS per team, assuming 9999 max frags
	bprint (PRINT_HIGH, "\nFrags:       ");

	t1frags = "     ";
	t2frags = "     ";
	t3frags = "     ";
	space1 = "";
	space2 = "";
	space3 = "";	

	if (t1_pl > 0) { // t1frags + space1 should add to "5" (4 chars for score, 1 for space)
		t1frags = ftos (team1frags);
		
		if (strlen(t1frags) == 1)
			space1 = "    ";
		else if (strlen(t1frags) == 2)
			space1 = "   ";
		else if (strlen(t1frags) == 3)
			space1 = "  ";
		else if (strlen(t1frags) > 3) { // it's 4 or more?
			t1frags = substring(t1frags, 0, 4); // just take first 4 chars of score
			space1 = " ";
		}
	}
	
	if (t2_pl > 0) {
		t2frags = ftos (team2frags);
		
		if (strlen(t2frags) == 1)
			space2 = "    ";
		if (strlen(t2frags) == 2)
			space2 = "   ";
		else if (strlen(t2frags) == 3)
			space2 = "  ";
		else if (strlen(t2frags) > 3) { // it's 4 or more?
			t2frags = substring(t2frags, 0, 4);
			space2 = " ";
		}
	}
	
	if (t3_pl > 0) {
		t3frags = ftos (team3frags);
		
		if (strlen(t3frags) == 1)
			space3 = "    ";
		if (strlen(t3frags) == 2)
			space3 = "   ";
		else if (strlen(t3frags) == 3)
			space3 = "  ";
		else if (strlen(t3frags) > 3) { // it's 4 or more?
			t3frags = substring(t3frags, 0, 4);
			space3 = " ";
		}
	}	

	if (t4_pl > 0) {
		t4frags = ftos (team4frags);
		t4frags = substring(t4frags, 0, 4); //let's just make sure it's at most 4 characters
	}
	
	bprint2 (PRINT_HIGH, t1frags, space1, t2frags, space2, t3frags, space3, t4frags);

	
	//Print UNACCOUNTED FRAGS per team, assuming 9999 max
	bprint (PRINT_HIGH, "\nUnacc Frags: ");
	
	t1unaccfrags = "     ";
	t2unaccfrags = "     ";
	t3unaccfrags = "     ";
	space1 = "";
	space2 = "";
	space3 = "";	

	if (t1_pl > 0) { // t1unaccfrags + space1 should add to "5" (4 chars for score, 1 for space)
		t1unaccfrags = ftos (t1_unacc);
		
		if (strlen(t1unaccfrags) == 1)
			space1 = "    ";
		else if (strlen(t1unaccfrags) == 2)
			space1 = "   ";
		else if (strlen(t1unaccfrags) == 3)
			space1 = "  ";
		else if (strlen(t1unaccfrags) > 3) { // it's 4 or more?
			t1unaccfrags = substring(t1unaccfrags, 0, 4); // just take first 4 chars of score
			space1 = " ";
		}
	}
	
	if (t2_pl > 0) {
		t2unaccfrags = ftos (t2_unacc);
		
		if (strlen(t2unaccfrags) == 1)
			space2 = "    ";
		if (strlen(t2unaccfrags) == 2)
			space2 = "   ";
		else if (strlen(t2unaccfrags) == 3)
			space2 = "  ";
		else if (strlen(t2unaccfrags) > 3) { // it's 4 or more?
			t2unaccfrags = substring(t2unaccfrags, 0, 4);
			space2 = " ";
		}
	}
	
	if (t3_pl > 0) {
		t3unaccfrags = ftos (t3_unacc);
		
		if (strlen(t3unaccfrags) == 1)
			space3 = "    ";
		if (strlen(t3unaccfrags) == 2)
			space3 = "   ";
		else if (strlen(t3unaccfrags) == 3)
			space3 = "  ";
		else if (strlen(t3unaccfrags) > 3) { // it's 4 or more?
			t3unaccfrags = substring(t3unaccfrags, 0, 4);
			space3 = " ";
		}
	}	

	if (t4_pl > 0) {
		t4unaccfrags = ftos (t4_unacc);
		t4unaccfrags = substring(t4unaccfrags, 0, 4); //let's just make sure it's at most 4 characters
	}
	
	bprint2 (PRINT_HIGH, t1unaccfrags, space1, t2unaccfrags, space2, t3unaccfrags, space3, t4unaccfrags);
	
	//Print TEAM SCORE, assuming 9999 max 
	bprint (PRINT_HIGH, "\nTeam Score:  ");

	t1score = "     ";
	t2score = "     ";
	t3score = "     ";
	space1 = "";
	space2 = "";
	space3 = "";	

	if (t1_pl > 0) { // t1score + space1 should add to "5" (4 chars for score, 1 for space)
		t1score = ftos (team1score);
		
		if (strlen(t1score) == 1)
			space1 = "    ";
		else if (strlen(t1score) == 2)
			space1 = "   ";
		else if (strlen(t1score) == 3)
			space1 = "  ";
		else if (strlen(t1score) > 3) { // it's 4 or more?
			t1score = substring(t1score, 0, 4); // just take first 4 chars of score
			space1 = " ";
		}
	}
	
	if (t2_pl > 0) {
		t2score = ftos (team2score);
		
		if (strlen(t2score) == 1)
			space2 = "    ";
		if (strlen(t2score) == 2)
			space2 = "   ";
		else if (strlen(t2score) == 3)
			space2 = "  ";
		else if (strlen(t2score) > 3) { // it's 4 or more?
			t2score = substring(t2score, 0, 4);
			space2 = " ";
		}
	}
	
	if (t3_pl > 0) {
		t3score = ftos (team3score);
		
		if (strlen(t3score) == 1)
			space3 = "    ";
		if (strlen(t3score) == 2)
			space3 = "   ";
		else if (strlen(t3score) == 3)
			space3 = "  ";
		else if (strlen(t3score) > 3) { // it's 4 or more?
			t3score = substring(t3score, 0, 4);
			space3 = " ";
		}
	}	

	if (t4_pl > 0) {
		t4score = ftos (team4score);
		t4score = substring(t4score, 0, 4); //let's just make sure it's at most 4 characters
	}
	
	bprint2 (PRINT_HIGH, t1score, space1, t2score, space2, t3score, space3, t4score);
	//End print Team Scores
	
	
	bprint (PRINT_HIGH, "\n");
	
	if ( (no_teams == 2) && (((team1score == team2score) && teamfrags) || ((team1frags == team2frags) && !teamfrags)) )
		bprint (PRINT_HIGH, "\sThe match is a DRAW.\s");
	else if ((no_teams == 3) && ((((team1score == team2score) == team3score) && teamfrags) || (((team1frags == team2frags) == team3frags) && !teamfrags)))
		bprint (PRINT_HIGH, "\sThe match is a DRAW.\s");
	else if ((no_teams == 4) && (((((team1score == team2score) == team3score) == team4score) && teamfrags) || ((((team1frags == team2frags) == team3frags) == team4frags) && !teamfrags)))
		bprint (PRINT_HIGH, "\sThe match is a DRAW.\s");
	else {
		st = GetTeamName (winners);
		bprint (PRINT_HIGH, st, " defeated ");
		
		if ((winners != 1) && (t1_pl != 0)) {
			st = GetTeamName (1);
			bprint (PRINT_HIGH, st);
			printed = printed + 1;
		}
		if ((winners != 2) && (t2_pl != 0)) {
			st = GetTeamName (2);
			if (printed == no_teams)
				bprint2 (PRINT_HIGH, " and ", st);
			else if (printed)
				bprint2 (PRINT_HIGH, ", ", st);
			else
				bprint (PRINT_HIGH, st);
			printed = printed + 1;
		}
		if ((winners != 3) && (t3_pl != 0)) {
			st = GetTeamName (3);
			if (printed == no_teams)
				bprint2 (PRINT_HIGH, " and ", st);
			else if (printed)
				bprint2 (PRINT_HIGH, ", ", st);
			else
				bprint (PRINT_HIGH, st);
			printed = printed + 1;
		}
		if ((winners != 4) && (t4_pl != 0)) {
			st = GetTeamName (4);
			if (printed == no_teams)
				bprint2 (PRINT_HIGH, " and ", st);
			else if (printed)
				bprint2 (PRINT_HIGH, ", ", st);
			else
				bprint (PRINT_HIGH, st);
		}
    }
    bprint (PRINT_HIGH, "\n\n");

    st = infokey (world, "dtf");
    if (st == string_null)
		st = infokey (world, "dont_tweak_frags");

    if (st != "on") {
		if (teamfrags != 0) {
			if (t1_pl > 0) {
				printed = floor (team1score / t1_pl);
				ti = 0;
				if ((printed * t1_pl) != team1score) {
					ti = team1score - (printed * t1_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 1) {
						te.frags = printed;
					}
					if (ti) {
						te.frags = te.frags + 1;
						ti = ti - 1;
					}
					te = find (te, classname, "player");
				}
			}
			if (t2_pl > 0) {
				printed = floor ((team2score / t2_pl));
				ti = 0;
				if ((printed * t2_pl) != team2score) {
					ti = team2score - (printed * t2_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 2) {
						te.frags = printed;
					}
					if (ti) {
						te.frags = te.frags + 1;
						ti = ti - 1;
					}
					te = find (te, classname, "player");
				}
			}
			if (t3_pl > 0) {
				printed = floor ((team3score / t3_pl));
				ti = 0;
				if ((printed * t3_pl) != team3score) {
					ti = team3score - (printed * t3_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 3) {
						te.frags = printed;
					}
					if (ti) {
						te.frags = te.frags + 1;
						ti = ti - 1;
					}
					te = find (te, classname, "player");
				}
			}
			if (t4_pl > 0) {
				printed = floor ((team4score / t4_pl));
				ti = 0;
				if ((printed * t4_pl) != team4score) {
					ti = team4score - (printed * t4_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 4) {
						te.frags = printed;
					}
					if (ti) {
						te.frags = te.frags + 1;
						ti = ti - 1;
					}
					te = find (te, classname, "player");
				}
			}
		}
		else {
			if ((t1_pl > 0) && (t1_unacc > 0)) {
				printed = floor (t1_unacc / t1_pl);
				ti = 0;
				if ((printed * t1_pl) != t1_unacc) {
					ti = t1_unacc - (printed * t1_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 1) {
						te.frags = te.real_frags + printed;
					if (ti) {
						te.frags = te.frags + 1;
						ti = ti - 1;
					}
					}
					te = find (te, classname, "player");
				}
			}
			if ((t2_pl > 0) && (t2_unacc > 0)) {
				printed = floor ((t2_unacc / t2_pl));
				ti = 0;
				if ((printed * t2_pl) != t2_unacc) {
					ti = t2_unacc - (printed * t2_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 2) {
						te.frags = te.real_frags + printed;
					if (ti) {
						te.frags = te.frags + 1;
						ti = ti - 1;
					}
					}
					te = find (te, classname, "player");
				}
			}
			if ((t3_pl > 0) && (t3_unacc > 0)) {
				printed = floor ((t3_unacc / t3_pl));
				ti = 0;
				if ((printed * t3_pl) != t3_unacc) {
					ti = t3_unacc - (printed * t3_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 3) {
						te.frags = te.real_frags + printed;
					if (ti) {
						te.frags = te.frags + 1;
						ti = ti - 1;
					}
					}
					te = find (te, classname, "player");
				}
			}
			if ((t4_pl > 0) && (t4_unacc > 0)) {
				printed = floor ((t4_unacc / t4_pl));
				ti = 0;
				if ((printed * t4_pl) != t4_unacc) {
					ti = t4_unacc - (printed * t4_pl);
				}
				te = find (world, classname, "player");
				while (te) {
					if (te.team_no == 4) {
						te.frags = te.real_frags + printed;
						if (ti) {
							te.frags = te.frags + 1;
							ti = ti - 1;
						}
					}
					te = find (te, classname, "player");
				}
			}
		}
    }
	
	//End of match results output
	te = find (world, classname, "player");
    while (te) {
		st = infokey (te, "take_sshot");
		if (st != string_null)
			stuffcmd (te, "screenshot\n");
		te = find (te, classname, "player");
    }
	
};

void () TeamFortress_ShowIDs =
{
    local entity te;
    local float got_one;
    local string st;

    if (self.team_no == 0) {
		sprint (self, PRINT_HIGH, "You aren't in a team.\n");
		return;
    }
    got_one = 0;
    sprint (self, PRINT_HIGH, "Existing Team Member IDs:\n");

    te = find (world, classname, "player");
    while (te) {
		if (te.team_no == self.team_no) {
			got_one = 1;
			st = ftos (te.tf_id);
			sprint (self, PRINT_HIGH, te.netname, " : ", st, "\n");
		}
		te = find (te, classname, "player");
    }

    if (!got_one)
		sprint (self, PRINT_HIGH, "NONE\n"); 
    got_one = 0;
    sprint (self, PRINT_HIGH, "Disconnected Team Member IDs:\n");

    te = find (world, classname, "ghost");
    while (te) {
		if (te.team_no == self.team_no) {
			got_one = 1;
			st = ftos (te.tf_id);
			sprint2 (self, 2, st, "\n");
		}
		te = find (te, classname, "ghost");
    }

    if (!got_one)
		sprint (self, PRINT_HIGH, "NONE\n");
};
