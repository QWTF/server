
void () PreMatch_Think =
{
    local float time_left;
    local string st;
    local entity te;
    local entity oldself;
    local entity gren;

    time_left = rint (cb_prematch_time - time);
    if (time_left > 60) {
	st = ftos (time_left / 60);
	bprint2 (PRINT_HIGH, st, " minutes left till Match begins.\n");
	if (time_left < 120) {
	    self.nextthink = time + time_left - 60;
	} else {
	    self.nextthink = time + 60;
	}
	return;
    } else if (time_left >= 59) {
	bprint (PRINT_HIGH, "1 minute left till Match begins.\n");
	self.nextthink = time + 30;
	return;
    } else if (time_left >= 29) {
	bprint (PRINT_HIGH, "30 seconds left till Match begins.\n");
	self.nextthink = time + 20;
	return;
    } else if (time_left > 1) {
	st = ftos (time_left);
	bprint2 (PRINT_HIGH, st, " seconds.\n");
	self.nextthink = time + 1;
	return;
    } else if (time_left > 0) {
	bprint (PRINT_HIGH, "1 second.\n");
	self.nextthink = time + 1;
	return;
    }
    bprint (PRINT_HIGH, "MATCH BEGINS NOW\n");
    if (game_locked)
	bprint (PRINT_HIGH, "GAME IS NOW LOCKED\n");

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
    local float winners;
    local float second;
    local float no_teams;
    local float printed;
    local float ti;
    local float tno;
    local float teamfrags;
    local string st;
    local entity te;
    local float t1_pl;
    local float t1_unacc;
    local float t2_pl;
    local float t2_unacc;
    local float t3_pl;
    local float t3_unacc;
    local float t4_pl;
    local float t4_unacc;

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

    bprint (PRINT_HIGH, "\n\n=------= Íáôãè Òåóõìôó =------="); // Match Results in brown
    	
	//Print team names
	bprint (PRINT_HIGH, "\nTeam:        ");
	if (t1_pl > 0) { bprint (PRINT_HIGH, "blue"); }
	else { bprint (PRINT_HIGH, "    "); }
	if (t2_pl > 0) { bprint (PRINT_HIGH, " red"); }
	else { bprint (PRINT_HIGH, "    "); }
	if (t3_pl > 0) { bprint (PRINT_HIGH, "  grn"); }
	else { bprint (PRINT_HIGH, "     "); }
	if (t4_pl > 0) { bprint (PRINT_HIGH, "  yell"); }
	
	//Print the number of players per team, assume 99 max players (two digits)
	bprint (PRINT_HIGH, "\nPlayers:     ");
	
	if (t1_pl > 0) {
		tno = TeamFortress_TeamGetNoPlayers (1);
		st = ftos (tno);
		
		if (t1_pl < 10) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t2_pl > 0) {
		bprint (PRINT_HIGH, "   ");
		tno = TeamFortress_TeamGetNoPlayers (2);
		st = ftos (tno);
		
		if (t2_pl < 10) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t3_pl > 0) {
		bprint (PRINT_HIGH, "   ");
		tno = TeamFortress_TeamGetNoPlayers (3);
		st = ftos (tno);
		
		if (t3_pl < 10) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t4_pl > 0) {
		bprint (PRINT_HIGH, "   ");
		tno = TeamFortress_TeamGetNoPlayers (4);
		st = ftos (tno);
		
		if (t4_pl < 10) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	
	//Print the number of frags per team, assuming 9999 max frags
	bprint (PRINT_HIGH, "\nFrags:       ");
	
	if (t1_pl > 0) {
		st = ftos (team1frags);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t2_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (team2frags);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t3_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (team3frags);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t4_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (team4frags);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	
	//Print unnaccounted for frags per team, assuming 9999 max
	bprint (PRINT_HIGH, "\nUnacc Frags: ");
	
	if (t1_pl > 0) {
		st = ftos (t1_unacc);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t2_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (t2_unacc);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t3_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (t3_unacc);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	else {
		bprint (PRINT_HIGH, "  ");
	}
	
	if (t4_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (t4_unacc);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
	}
	
	//Print Team Scores, assuming 9999 max
	bprint (PRINT_HIGH, "\nTeam Score:  ");
	
	if (t1_pl > 0) {
		st = ftos (team1score);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
    }
	else {
		bprint (PRINT_HIGH, "    ");
	}
	
	if (t2_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (team2score);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
    }
	else {
		bprint (PRINT_HIGH, "    ");
	}
	
	if (t3_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (team3score);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
    }
	else {
		bprint (PRINT_HIGH, "    ");
	}
	
	if (t4_pl > 0) {
		bprint (PRINT_HIGH, " ");
		st = ftos (team4score);
		
		if (stof(st) < 10) {
			bprint2 (PRINT_HIGH, st, "   ");
		}
		else if (stof(st) < 100) {
			bprint2 (PRINT_HIGH, st, "  ");
		}
		else if (stof(st) < 1000) {
			bprint2 (PRINT_HIGH, st, " ");
		}
		else {
			bprint2 (PRINT_HIGH, st);
		}
    }
	
	bprint (PRINT_HIGH, "\n");
	if ((no_teams == 2) && (((team1score == team2score) && teamfrags)
			    || ((team1frags == team2frags) && !teamfrags))) {
	bprint (PRINT_HIGH, "Ôèå íáôãè éó á ÄÒÁ×®"); // The match is a DRAW. in brown
    } else if ((no_teams == 3) && ((((team1score == team2score) == team3score) && teamfrags)
				   || (((team1frags == team2frags) == team3frags) && !teamfrags))) {
	bprint (PRINT_HIGH, "Ôèå íáôãè éó á ÄÒÁ×®"); // The match is a DRAW. in brown
    } else if ((no_teams == 3)
	       && (((((team1score == team2score) == team3score) == team4score) && teamfrags)
		   || ((((team1frags == team2frags) == team3frags) == team4frags) && !teamfrags))) {
	bprint (PRINT_HIGH, "Ôèå íáôãè éó á ÄÒÁ×®"); // The match is a DRAW. in brown
    } else {
	st = GetTeamName (winners);
	bprint (PRINT_HIGH, st, " defeated ");
	if ((winners != 1) && (t1_pl != 0)) {
	    st = GetTeamName (1);
	    bprint (PRINT_HIGH, st);
	    printed = printed + 1;
	}
	if ((winners != 2) && (t2_pl != 0)) {
	    st = GetTeamName (2);
	    if (printed == no_teams) {
		bprint2 (PRINT_HIGH, " and ", st);
	    } else if (printed) {
		bprint2 (PRINT_HIGH, ", ", st);
	    } else {
		bprint (PRINT_HIGH, st);
	    }
	    printed = printed + 1;
	}
	if ((winners != 3) && (t3_pl != 0)) {
	    st = GetTeamName (3);
	    if (printed == no_teams) {
		bprint2 (PRINT_HIGH, " and ", st);
	    } else if (printed) {
		bprint2 (PRINT_HIGH, ", ", st);
	    } else {
		bprint (PRINT_HIGH, st);
	    }
	    printed = printed + 1;
	}
	if ((winners != 4) && (t4_pl != 0)) {
	    st = GetTeamName (4);
	    if (printed == no_teams) {
		bprint2 (PRINT_HIGH, " and ", st);
	    } else if (printed) {
		bprint2 (PRINT_HIGH, ", ", st);
	    } else {
		bprint (PRINT_HIGH, st);
	    }
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
	} else {
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
	if (st != string_null) {
	    stuffcmd (te, "screenshot\n");
	}
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
