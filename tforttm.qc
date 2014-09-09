//=============================================================
// Functions handling all the help displaying for TeamFortress.
//=============================================================

void (float tno) TeamFortress_TeamSetColor;

void (float tno, float scoretoadd) TeamFortress_TeamIncreaseScore;
float (float tno) TeamFortress_TeamGetLives;
float (float tno) TeamFortress_TeamGetMaxPlayers;
string (float tno) TeamFortress_TeamGetColorString;
float (float tno) TeamFortress_TeamGetIllegalClasses;
string (entity p) TeamFortress_GetSkin;
float arr_team_sizes[8];
float arr_eligible_teams[8];

float () TeamFortress_TeamPutPlayerInTeam =
{
    local float i;
    local float likely_team;
    local float likely_team_index;
    local float ceiling_matches;
    local float eligible_teams_count;
    local float flooring;
    local float ceiling;
    local float number_of_largest_teams;
    local float total_players_to_balance;
    local float teams_to_balance;
    local float total_players_on_maxed_teams;
    
    
	total_players_to_balance = 0;
    teams_to_balance = number_of_teams;
    total_players_on_maxed_teams = 0;
    
    // Populate team size array
    for (i = 0; i <= number_of_teams; i++) {
        arr_team_sizes[i] = TeamFortress_TeamGetNoPlayers (i);
        total_players_to_balance += arr_team_sizes[i];
        		
        // If team is at max players keep track of it
        if (arr_team_sizes[i] == TeamFortress_TeamGetMaxPlayers (i)) {
            teams_to_balance--;
            total_players_on_maxed_teams += arr_team_sizes[i];
        }
    }
    
    // Take the players on the maxed team(s) out of the player pool that we're balancing
    total_players_to_balance -= total_players_on_maxed_teams;
    
    // Most a team should have if it's as balanced as possible
    ceiling = ceil (total_players_to_balance / teams_to_balance);
    
    // Least a team should have if it's as balanced as possible
    flooring = floor (total_players_to_balance / teams_to_balance);
    
    // Number of teams which should have the ceiling number of players if it's as balanced as possible
    number_of_largest_teams = total_players_to_balance - (floor (total_players_to_balance / teams_to_balance) * teams_to_balance);
    
    // Get the number of teams that match or exceed the ceiling
    ceiling_matches = 0;
    for (i = 1;i <= number_of_teams; i++) {
        if (arr_team_sizes[i] >= ceiling) ceiling_matches++;
    }
    
    // Find the eligible teams for the player to auto join
    eligible_teams_count = 0;
    for (i = 1;i <= number_of_teams; i++) {
        if (arr_team_sizes[i] < ceiling && arr_team_sizes[i] < TeamFortress_TeamGetMaxPlayers (i)) { 
            if (ceiling_matches >= number_of_largest_teams) {
                if (arr_team_sizes[i] < flooring) {
                    arr_eligible_teams[eligible_teams_count] = i;
                    eligible_teams_count++;
                }
            }
            else {
                arr_eligible_teams[eligible_teams_count] = i;
                eligible_teams_count++;
            }
        }
    }

    if (teams_to_balance == 0) {
        sprint (self, PRINT_HIGH, "All teams are full.\n");
        
        return 0;
    }
    else {
        likely_team_index = random () * eligible_teams_count;
        likely_team_index = floor (likely_team_index);
        likely_team = arr_eligible_teams[likely_team_index];
        
        return (TeamFortress_TeamSet (likely_team, 1));
    }
};

float (float tno) TeamFortress_TeamGetColor =
{
    if (tno == 1)
		return (BLUE);
    if (tno == 2)
		return (RED);
    if (tno == 3)
		return (YELLOW);
    if (tno == 4)
		return (GREEN);
		
    return (0);
};

void (float tno) TeamFortress_TeamSetColor =
{
    if (tno == 1) {
		team1col = BLUE;
		return;
    }
    if (tno == 2) {
		team2col = RED;
		return;
    }
    if (tno == 3) {
		team3col = YELLOW;
		return;
    }
    if (tno == 4) {
		team4col = GREEN;
		return;
    }
};

string (float tno) GetTeamName =
{
    local string st;

    if (tno == 1) {
		st = infokey (world, "team1");
		if (st == string_null)
			st = infokey (world, "t1");
		if ((st == string_null) || (st == ""))
			return ("blue");
    }
	else if (tno == 2) {
		st = infokey (world, "team2");
		if (st == string_null)
			st = infokey (world, "t2");
		if ((st == string_null) || (st == ""))
			return ("red");
    }
	else if (tno == 3) {
		st = infokey (world, "team3");
		if (st == string_null)
			st = infokey (world, "t3");
		if ((st == string_null) || (st == ""))
			return ("yell");
    }
	else if (tno == 4) {
		st = infokey (world, "team4");
		if (st == string_null)
			st = infokey (world, "t4");
		if ((st == string_null) || (st == ""))
			return ("gren");
    }
	else {
		st = "\"\"";
    }
	
    return (st);
};

void (entity p) SetTeamName =
{
    local string st;

    stuffcmd (p, "team ");
    st = GetTeamName (p.team_no);
    stuffcmd (p, st);
    stuffcmd (p, "\n");
};

float (float tno, float autoteam) TeamFortress_TeamSet =
{
    local string st;
    local float tc;

    if (teamplay < 1) {
		sprint (self, PRINT_HIGH, "Teamplay is not On, so FortressTeams are inactive.\n");
		return (0);
    }
    if ((tno > number_of_teams) && (number_of_teams != 0)) {
		sprint (self, PRINT_HIGH, "There can be only ");
		st = ftos (number_of_teams);
		sprint (self, PRINT_HIGH, st, " teams on this map.\nTry again\n");
		return (0);
    }
    if (self.team_no == tno) {
		sprint (self, PRINT_HIGH, "You're already in Team No ");
		st = ftos (self.team_no);
		sprint (self, PRINT_HIGH, st, ".\n");
		return (0);
    }
    tc = TeamFortress_TeamGetNoPlayers (tno);
    if (tc >= TeamFortress_TeamGetMaxPlayers (tno)) {
		sprint (self, PRINT_HIGH, "That team is full. Pick another.\n");
		return (0);
    }
    if (TeamFortress_TeamGetColor (tno) == 0) {
		TeamFortress_TeamSetColor (tno);
		if (TeamFortress_TeamGetColor (tno) == 0) {
			sprint (self, PRINT_HIGH, "You can't start a new team with your color, since another ");
			sprint (self, PRINT_HIGH, "already using that color. Change your pants color, then try again.\n");
			return (0);
		}
		bprint (PRINT_HIGH, self.netname, " has started Team No ");
		st = ftos (tno);
		bprint (PRINT_HIGH, st, ".\n");
		self.immune_to_check = time + 10;
		if ((toggleflags & TFLAG_TEAMFRAGS) || (toggleflags & TFLAG_FULLTEAMSCORE)) {
			self.frags = TeamFortress_TeamGetScore (tno);
		}
		stuffcmd (self, "color ");
		tc = TeamFortress_TeamGetColor (tno) - 1;
		st = ftos (tc);
		stuffcmd (self, st);
		stuffcmd (self, "\n");
		self.team_no = tno;
		self.lives = TeamFortress_TeamGetLives (tno);
		SetTeamName (self);
		if (self.playerclass == 0) {
			if (TeamFortress_TeamIsCivilian (self.team_no)) {
				self.impulse = 1;
				TeamFortress_ChangeClass ();
			}
		}
		return (1);
    }
    if (hideconsoletext == 0) {
        bprint (PRINT_HIGH, self.netname, " has joined Team No ");
        st = ftos (tno);
        if (autoteam == 1)
			bprint (PRINT_HIGH, st, ". \sauto\s‘\n"); // brown auto with gold brackets []
        else
			bprint (PRINT_HIGH, st, ".\n");
    }
    stuffcmd (self, "color ");
    tc = TeamFortress_TeamGetColor (tno) - 1;
    st = ftos (tc);
    stuffcmd (self, st);
    stuffcmd (self, "\n");

    self.team_no = tno;
    self.immune_to_check = time + 10;
    self.lives = TeamFortress_TeamGetLives (tno);
    if ((toggleflags & TFLAG_TEAMFRAGS) || (toggleflags & TFLAG_FULLTEAMSCORE)) {
		self.frags = TeamFortress_TeamGetScore (tno);
    }
    if (hideconsoletext == 0)
		TeamFortress_TeamShowMemberClasses (self);
    SetTeamName (self);
    if (self.playerclass == 0) {
		if (TeamFortress_TeamIsCivilian (self.team_no)) {
			self.impulse = 1;
			TeamFortress_ChangeClass ();
		}
    }
    return (1);
};

void () TeamFortress_CheckTeamCheats =
{
    if (self.immune_to_check > time)
        return;
    if (self.deadflag)
        return;

    if (self.netname == string_null) {
        KickCheater (self);
    }
    else {
        if (((self.playerclass != 0) && (self.team_no == 0)) && (teamplay > 0)) {
            KickCheater (self);
        }
    }
    
    return;
};

void (float tno, float scoretoadd) TeamFortress_TeamIncreaseScore =
{
    local entity e;

    if ((tno == 0) || (scoretoadd == 0))
		return;

    if (tno == 1)
		team1score = team1score + scoretoadd;

    if (tno == 2)
		team2score = team2score + scoretoadd;

    if (tno == 3)
		team3score = team3score + scoretoadd;

    if (tno == 4)
		team4score = team4score + scoretoadd;

    if ((toggleflags & TFLAG_TEAMFRAGS) || (toggleflags & 2048)) {
		e = find (world, classname, "player");
		while (e) {
			if (e.team_no == tno)
				e.frags = TeamFortress_TeamGetScore (tno);

			e = find (e, classname, "player");
		}
    }
};

float (float tno) TeamFortress_TeamGetScore =
{
    if (tno == 1)
		return (team1score);
    if (tno == 2)
		return (team2score);
    if (tno == 3)
		return (team3score);
    if (tno == 4)
		return (team4score);
	
    return (0);
};

float (float tno) TeamFortress_TeamGetScoreFrags =
{
    if ((toggleflags & TFLAG_TEAMFRAGS) || (toggleflags & TFLAG_FULLTEAMSCORE)) {
		if (tno == 1) {
			return (team1score);
		}
		if (tno == 2) {
			return (team2score);
		}
		if (tno == 3) {
			return (team3score);
		}
		if (tno == 4) {
			return (team4score);
		}
    }
	else {
		if (tno == 1) {
			return (team1frags);
		}
		if (tno == 2) {
			return (team2frags);
		}
		if (tno == 3) {
			return (team3frags);
		}
		if (tno == 4) {
			return (team4frags);
		}
    }
    return (0);
};

float (float tno) TeamFortress_TeamGetLives =
{
    if (tno == 1)
		return (team1lives);
    if (tno == 2)
		return (team2lives);
    if (tno == 3)
		return (team3lives);
    if (tno == 4)
		return (team4lives);
	
    return (0);
};

float (float tno) TeamFortress_TeamGetNoPlayers =
{
    local float size_team;
    local entity search;

    search = find (world, classname, "player");
    while (search != world) {
		if (search.team_no == tno)
			size_team = size_team + 1;
		search = find (search, classname, "player");
    }
    if (tno == 0) {
		search = find (world, classname, "observer");
		while ( (search != world) ) {
			if (search.team_no == tno)
				size_team = size_team + 1;
			search = find (search, classname, "observer");
		}
    }
	
    return (size_team);
};

float () TeamFortress_GetNoPlayers =
{
    local float nump;
    local entity search;

    search = find (world, classname, "player");
    while (search != world) {
		if (search.netname != string_null)
			nump = nump + 1;
		search = find (search, classname, "player");
    }
	
    return (nump);
};

float (float tno) TeamFortress_TeamGetMaxPlayers =
{
    if (tno == 1)
		return (team1maxplayers);
    if (tno == 2)
		return (team2maxplayers);
    if (tno == 3)
		return (team3maxplayers);
    if (tno == 4)
		return (team4maxplayers);
	
    return (0);
};

float () TeamFortress_TeamGetWinner =
{
    local float i;
    local float j;
    local float highest;
    local float highestteam;

    highest = -99999;
    highestteam = 0;
    i = 1;
	
    while (i < (number_of_teams + 1)) {
		j = TeamFortress_TeamGetScoreFrags (i);
		if (j > highest) {
			highest = j;
			highestteam = i;
		}
		i = i + 1;
    }
    return (highestteam);
};

float () TeamFortress_TeamGetSecond =
{
    local float i, j;
    local float highest;
    local float highestteam;
    local float secondteam;
    local float second;

    highestteam = TeamFortress_TeamGetWinner ();
    highest = TeamFortress_TeamGetScoreFrags (highestteam);
    secondteam = 0;
    second = 0;

    i = 1;
    while (i < (number_of_teams + 1)) {
		j = TeamFortress_TeamGetScoreFrags (i);
		if ((j < highest) && (j > second)) {
			second = j;
			secondteam = i;
		}
		i = i + 1;
    }
    return (secondteam);
};

void (float all) TeamFortress_TeamShowScores =
{
    local string st;
    local float i;
    local float j;

    i = 1;
    if (all == 2) {
		while (i <= number_of_teams) {
			if (TeamFortress_TeamGetColor (i) > 0) {
				j = TeamFortress_TeamGetScore (i);
				st = TeamFortress_TeamGetColorString (i);
				bprint (PRINT_HIGH, st, ": ");
				st = ftos (j);
				bprint (PRINT_HIGH, st, " ");
			}
			i = i + 1;
		}
		bprint (PRINT_HIGH, "\n");
		return;
    }
    while (i <= number_of_teams) {
		if (TeamFortress_TeamGetColor (i) > 0) {
			if (all) {
				bprint (PRINT_HIGH, "Team ");
			} else {
				sprint (self, PRINT_HIGH, "Team ");
			}
			
			st = ftos (i);
			
			if (all) {
				bprint (PRINT_HIGH, st);
			} else {
				sprint (self, PRINT_HIGH, st);
			}
			
			if (all) {
				bprint (PRINT_HIGH, " (");
			} else {
				sprint (self, PRINT_HIGH, " (");
			}
			
			st = TeamFortress_TeamGetColorString (i);
			
			if (all) {
				bprint (PRINT_HIGH, st);
			} else {
				sprint (self, PRINT_HIGH, st);
			}
			
			if (all) {
				bprint (PRINT_HIGH, "): ");
			} else {
				sprint (self, PRINT_HIGH, "): ");
			}
			
			j = TeamFortress_TeamGetScore (i);
			st = ftos (j);
			
			if (all) {
				bprint (PRINT_HIGH, st);
			} else {
				sprint (self, PRINT_HIGH, st);
			}
			if (all) {
				bprint (PRINT_HIGH, "\n");
			} else {
				sprint (self, PRINT_HIGH, "\n");
			}
		}
		i = i + 1;
    }
};

string (float tno) TeamFortress_TeamGetColorString =
{
    local float col;

    col = TeamFortress_TeamGetColor (tno);
    if (col == WHITE)
		return ("White");
    if (col == BROWN)
		return ("Brown");
    if (col == BLUE)
		return ("Blue");
    if (col == GREEN)
		return ("Green");
    if (col == RED)
		return ("Red");
    if (col == TAN)
		return ("Tan");
    if (col == PINK)
		return ("Pink");
    if (col == ORANGE)
		return ("Orange");
    if (col == PURPLE)
		return ("Purple");
    if (col == DARKPURPLE)
		return ("DarkPurple");
    if (col == GREY)
		return ("Grey");
    if (col == DARKGREEN)
		return ("DarkGreen");
    if (col == YELLOW)
		return ("Yellow");
    return ("DarkBlue"); // why doesn't this have an if statement?
};

void (entity Player) TeamFortress_TeamShowMemberClasses =
{
    local entity e;
    local float found;

    found = FALSE;
    e = find (world, classname, "player");
    while (e) {
		if (((e.team_no == Player.team_no) || (e.team_no == 0)) && (e != Player)) {
			if (e.model != string_null) {
				if (!found) {
					found = TRUE;
					sprint (self, PRINT_HIGH, "The other members of your team are:\n");
				}
				sprint (Player, PRINT_HIGH, e.netname, " : ");
				TeamFortress_PrintClassName (Player, e.playerclass, e.tfstate & 8);
			}
		}
		e = find (e, classname, "player");
    }
};

void () TeamFortress_StatusQuery =
{	
	local float t1_players = TeamFortress_TeamGetNoPlayers (1);
	local float t2_players = TeamFortress_TeamGetNoPlayers (2);
	local float t3_players = TeamFortress_TeamGetNoPlayers (3);
	local float t4_players = TeamFortress_TeamGetNoPlayers (4);
	
	sprint(self, PRINT_HIGH, "players per team: ", ftos (t1_players), " ", ftos (t2_players), " ", ftos (t3_players));
	sprint(self, PRINT_HIGH, " ", ftos (t4_players), "\n"); //can only have 8 arguments
};

float (float tno) TeamFortress_TeamGetIllegalClasses =
{
    if (tno == 1)
		return (illegalclasses1);
    if (tno == 2)
		return (illegalclasses2);
    if (tno == 3)
		return (illegalclasses3);
    if (tno == 4)
		return (illegalclasses4);
		
    return (0);
};

float (float tno) TeamFortress_TeamIsCivilian =
{
    if (tno == 1) {
		if (civilianteams & 1)
			return (1);
    } else if (tno == 2) {
		if (civilianteams & 2)
			return (1);
    } else if (tno == 3) {
		if (civilianteams & 4)
			return (1);
    } else if (civilianteams & 8)
		return (1);

    return (0);
};

float (float tno, float pc) ClassIsRestricted =
{
    local float num;
    local float max;
    local entity te;
    local string st;

    if (tno == 0) {
		return (0);
    }
    if (pc == 1) {
		st = infokey (world, "cr_sc");
		if (st == string_null) {
			st = infokey (world, "cr_scout");
		}
		max = stof (st);
    }
	else {
		if (pc == 2) {
			st = infokey (world, "cr_sn");
			if (st == string_null) {
				st = infokey (world, "cr_sniper");
			}
			max = stof (st);
		}
		else {
			if (pc == 3) {
				st = infokey (world, "cr_so");
				if (st == string_null) {
					st = infokey (world, "cr_soldier");
				}
				max = stof (st);
			}
			else {
				if (pc == 4) {
					st = infokey (world, "cr_de");
					if (st == string_null) {
						st = infokey (world, "cr_demoman");
					}
					max = stof (st);
				}
				else {
					if (pc == 5) {
						st = infokey (world, "cr_me");
						if (st == string_null) {
							st = infokey (world, "cr_medic");
						}
						max = stof (st);
					}
					else {
						if (pc == 6) {
							st = infokey (world, "cr_hw");
							if (st == string_null) {
								st = infokey (world, "cr_hwguy");
							}
							max = stof (st);
						}
						else {
							if (pc == 7) {
								st = infokey (world, "cr_py");
								if (st == string_null) {
									st = infokey (world, "cr_pyro");
								}
								max = stof (st);
							}
							else {
								if (pc == 8) {
									st = infokey (world, "cr_sp");
									if (st == string_null) {
										st = infokey (world, "cr_spy");
									}
									max = stof (st);
								}
								else {
									if (pc == 9) {
										st = infokey (world, "cr_en");
										if (st == string_null) {
											st = infokey (world, "cr_engineer");
										}
										max = stof (st);
									}
									else {
										if (pc == 10) {
											st = infokey (world, "cr_ra");
											if (st == string_null) {
												st = infokey (world, "cr_random");
											}
											max = stof (st);
										}
									}
								}
							}
						}
					}
				}
			}
		}
    }
    if (max > 0) {
		num = 0;
		te = find (world, classname, "player");
		while ( te ) {
			if (te.team_no == tno) {
				if (pc == 10) {
					if (te.tfstate & 8) {
						num = num + 1;
					}
				}
				else {
					if ((te.playerclass == pc) || (te.nextpc == pc)) {
						if (!(te.tfstate & 8)) {
							num = num + 1;
						}
					}
				}
			}
			te = find (te, classname, "player");
		}
		if (num >= max) {
			return (1);
		}
    }
    if (max == -1) {
		return (1);
    }
	
    return (0);
};

void (float tno, entity ignore, string st) teamsprint =
{
    local entity te;

    if (tno == 0)
		return;

    te = find (world, classname, "player");
    while (te) {
		if ((te.team_no == tno) && (te != ignore))
			sprint (te, PRINT_HIGH, st);

		te = find (te, classname, "player");
    }
};
