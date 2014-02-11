float (float tno) TeamFortress_TeamGetScore;
float () TeamFortress_TeamGetWinner;
float () TeamFortress_TeamGetSecond;
string (float num) NumberToString10;
string (float num) NumberToString1000;

string (entity pl) GetStatusSize;
string (float num) BlueScoreToString100;
string (float num) BlueScoreToString1000;
string (float num) RedScoreToString100;
string (float num) RedScoreToString1000;
string (float num) YellowScoreToString100;
string (float num) YellowScoreToString1000;
string (float num) GreenScoreToString100;
string (float num) GreenScoreToString1000;
string (entity pl) ClipSizeToString100;
string (entity pl) RangeToString;
string (entity pl) ScannerToString;
string (entity pl) DisguiseToString;
string (entity pl) SentryDetailsToString;
string (entity pl) SentryHealthToString;

void (entity pl, string s1) CenterPrint =
{
    centerprint (pl, s1);
    pl.StatusRefreshTime = time + 1.5;
};

void (entity pl, string s1, string s2) CenterPrint2 =
{
    centerprint (pl, s1, s2);
    pl.StatusRefreshTime = time + 1.5;
};

void (entity pl, string s1, string s2, string s3) CenterPrint3 =
{
    centerprint (pl,s1,s2,s3);
    pl.StatusRefreshTime = time + 1.5;
};

void (entity pl, float fTime, string s1) StatusPrint =
{
    centerprint (pl, s1);
    pl.StatusRefreshTime = time + fTime;
};

void (entity pl) RefreshStatusBar =
{
    local string s1, s2, s3, s4, s5, s6, s7;
    local float win, sec;

    if (pl.StatusBarSize == 0) {
	pl.StatusRefreshTime = time + 60;
	return;
    }
    pl.StatusRefreshTime = time + 1.5;

    if (pl.playerclass == PC_UNDEFINED)
	return;

    s1 = GetStatusSize ();

    win = TeamFortress_TeamGetWinner ();
    sec = TeamFortress_TeamGetSecond ();
    if ((TeamFortress_TeamGetScore (win) > 100) || (TeamFortress_TeamGetScore (sec) > 100)) {

	if (win == 0)
	    s3 = BlueScoreToString1000 (team1score);
	else if (win == 1)
            s3 = BlueScoreToString1000 (team1score);
        else if (win == 2)
	    s3 = RedScoreToString1000 (team2score);
	else if (win == 3)
	    s3 = YellowScoreToString1000 (team3score);
	else
	    s3 = GreenScoreToString1000 (team4score);

	if (sec == 0)
	    s4 = RedScoreToString1000 (team2score);
	else if (sec == 1)
            s4 = BlueScoreToString1000 (team1score);
	else if (sec == 2)
	    s4 = RedScoreToString1000 (team2score);
	else if (sec == 3)
	    s4 = YellowScoreToString1000 (team3score);
	else
	    s4 = GreenScoreToString1000 (team4score);

    } else {

	if (win == 0)
            s3 = BlueScoreToString1000 (team1score);
        else if (win == 1)
            s3 = BlueScoreToString100 (team1score);
	else if (win == 2)
            s3 = RedScoreToString100 (team2score);
	else if (win == 3)
            s3 = YellowScoreToString100 (team3score);
	else
            s3 = GreenScoreToString100 (team4score);

	if (sec == 0)
            s4 = RedScoreToString1000 (team2score);
	else if (sec == 1)
            s4 = BlueScoreToString100 (team1score);
	else if (sec == 2)
            s4 = RedScoreToString100 (team2score);
	else if (sec == 3)
	    s4 = YellowScoreToString100 (team3score);
	else
            s4 = GreenScoreToString100 (team4score);
    }

    s5 = ClipSizeToString100 (pl);
    s2 = "\n";
    if (pl.playerclass == PC_SCOUT) {

	s2 = ScannerToString (pl);
	s6 = RangeToString (pl);
	s7 = "\n";
	centerprint (pl, s1, s2, s6, s7, s3, s4, s5);
	return;

    } else if (pl.playerclass == PC_DEMOMAN) {

	if (self.is_detpacking) {
	    s2 = "  setting detpack                      \n";
	}

    } else if (pl.playerclass == PC_SPY) {

	s2 = DisguiseToString (pl);
	centerprint (pl, s1, s2, s3, s4, s5);

    } else if (pl.playerclass == PC_ENGINEER) {

	if (self.has_sentry) {

	    s2 = SentryHealthToString (pl);
	    s6 = SentryDetailsToString (pl);
	    centerprint (pl, s1, s2, s6, s3, s4, s5, s7);
	    return;

	} else if (self.is_building) {
	    s2 = "  building                             \n";
	}
   }
   centerprint (pl, s1, s2, s3, s4, s5, s6, s7);
};

string (entity pl) GetStatusSize =
{
    if (pl.StatusBarSize == 1) {

	if (pl.StatusBarRes > 7) // 768
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

	else if (pl.StatusBarRes == 7) // 600
            return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 6) // 480

	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 5) // 400
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 4) // 384
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 3) // 350
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 2) // 300
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 1) // 240
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	// 200
	return ("\n\n\n\n\n\n\n\n\n\n\n");

    } else /* if (pl.StatusBarSize == 2) */ {

	if (pl.StatusBarRes > 7) // 768
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 7) // 600
            return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 6) // 480
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 5) // 400
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 4) // 384
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 3) // 350
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 2) // 300
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	else if (pl.StatusBarRes == 1) // 240
	    return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	// 200
	return ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    }
};

void (float res) StatusRes =
{
    self.StatusBarRes = res;
    if (res > 7)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 1024x768.\n");
    else if (res == 7)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 800x600.\n");
    else if (res == 6)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 640x480.\n");
    else if (res == 5)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 640x400.\n");
    else if (res == 4)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 512x384.\n");
    else if (res == 3)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 320x350.\n");
    else if (res == 2)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 400x300.\n");
    else if (res == 1)
	sprint (self, PRINT_HIGH, "Status Bar Res set to 320x240.\n");
    else
	sprint (self, PRINT_HIGH, "Status Bar Res set to 320x200.\n");
};

string (float num) NumberToString10 =
{
    if (num < 5) {
		if (num == 0)
			return (" 0");
		else if (num == 1)
            return (" 1");
		else if (num == 2)
			return (" 2");
		else if (num == 3)
			return (" 3");
		else
			return (" 4");
   }
   else {
       if (num == 5)
		return (" 5");
       else if (num == 6)
		return (" 6");
       else if (num == 7)
		return (" 7");
       else if (num == 8)
		return (" 8");
       else if (num == 9)
		return (" 9");
       else
		return ("10");
   }
};

string (float num) NumberToString100 =
{
    if (num < 10) {
		if (num < 5) {
			if (num == 0)
				return (" 0");
			else if (num == 1)
				return (" 1");
			else if (num == 2)
				return (" 2");
			else if (num == 3)
				return (" 3");
			else
				return (" 4");
		}
	else if (num == 5)
	    return (" 5");
	else if (num == 6)
	    return (" 6");
	else if (num == 7)
	    return (" 7");
	else if (num == 8)
	    return (" 8");
	else
	    return (" 9");
    } 
	else if (num < 20) {
	if (num < 15) {
	    if (num == 10)
		return ("10");
	    else if (num == 11)
		return ("11");
	    else if (num == 12)
		return ("12");
	    else if (num == 13)
		return ("13");
	    else
		return ("14");
	} else if (num == 15)
	    return ("15");
	else if (num == 16)
	    return ("16");
	else if (num == 17)
	    return ("17");
	else if (num == 18)
	    return ("18");
	else
	    return ("19");
    } else if (num < 30) {
	if (num < 25) {
	    if (num == 20)
		return ("20");
	    else if (num == 21)
		return ("21");
	    else if (num == 22)
		return ("22");
	    else if (num == 23)
		return ("23");
	    else
		return ("24");
	} else if (num == 25)
	    return ("25");
	else if (num == 26)
	    return ("26");
	else if (num == 27)
	    return ("27");
	else if (num == 28)
	    return ("28");
	else
	    return ("29");
    } else if (num < 40) {
	if (num < 35) {
	    if (num == 30)
		return ("30");
	    else if (num == 31)
		return ("31");
	    else if (num == 32)
		return ("32");
	    else if (num == 33)
		return ("33");
	    else
		return ("34");
	} else if (num == 35)
	    return ("35");
	else if (num == 36)
	    return ("36");
	else if (num == 37)
	    return ("37");
	else if (num == 38)
	    return ("38");
	else
	    return ("39");
    } else if (num < 50) {
	if (num < 45) {
	    if (num == 40)
		return ("40");
	    else if (num == 41)
		return ("41");
	    else if (num == 42)
		return ("42");
	    else if (num == 43)
		return ("43");
	    else
		return ("44");
	} else if (num == 45)
	    return ("45");
	else if (num == 46)
	    return ("46");
	else if (num == 47)
	    return ("47");
	else if (num == 48)
	    return ("48");
	else
	    return ("49");
    } else if (num < 60) {
	if (num < 55) {
	    if (num == 50)
		return ("50");
	    else if (num == 51)
		return ("51");
	    else if (num == 52)
		return ("52");
	    else if (num == 53)
		return ("53");
	    else
		return ("54");
	} else if (num == 55)
	    return ("55");
	else if (num == 56)
	    return ("56");
	else if (num == 57)
	    return ("57");
	else if (num == 58)
	    return ("58");
	else
	    return ("59");
    } else if (num < 70) {
	if (num < 65) {
	    if (num == 60)
		return ("60");
	    else if (num == 61)
		return ("61");
	    else if (num == 62)
		return ("62");
	    else if (num == 63)
		return ("63");
	    else
		return ("64");
	} else if (num == 65)
	    return ("65");
	else if (num == 66)
	    return ("66");
	else if (num == 67)
	    return ("67");
	else if (num == 68)
	    return ("68");
	else
	    return ("69");
    } else if (num < 80) {
	if (num < 75) {
	    if (num == 70)
		return ("70");
	    else if (num == 71)
		return ("71");
	    else if (num == 72)
		return ("72");
	    else if (num == 73)
		return ("73");
	    else
		return ("74");
	} else if (num == 75)
	    return ("75");
	else if (num == 76)
	    return ("76");
	else if (num == 77)
	    return ("77");
	else if (num == 78)
	    return ("78");
	else
	    return ("79");
    } else if (num < 90) {
	if (num < 85) {
	    if (num == 80)
		return ("80");
	    else if (num == 81)
		return ("81");
	    else if (num == 82)
		return ("82");
	    else if (num == 83)
		return ("83");
	    else
		return ("84");
	} else if (num == 85)
	    return ("85");
	else if (num == 86)
	    return ("86");
	else if (num == 87)
	    return ("87");
	else if (num == 88)
	    return ("88");
	else
	    return ("89");
    } else if (num < 100) {
	if (num < 95) {
	    if (num == 90)
		return ("90");
	    else if (num == 91)
		return ("91");
	    else if (num == 92)
		return ("92");
	    else if (num == 93)
		return ("93");
	    else
		return ("94");
	} else if (num == 95)
	    return ("95");
	else if (num == 96)
	    return ("96");
	else if (num == 97)
	    return ("97");
	else if (num == 98)
	    return ("98");
	else
	    return ("99");
    }
};

string (float num) NumberToString1000 =
{
    if (num < 100) {
	if (num < 50) {
	    if (num < 10) {
		return ("  0");
	    } else if (num < 20) {
		return (" 10");
	    } else if (num < 30) {
		return (" 20");
	    } else if (num < 40) {
		return (" 30");
	    } else
		return (" 40");
	} else if (num < 60) {
	    return (" 50");
	} else if (num < 70) {
	    return (" 60");
	} else if (num < 80) {
	    return (" 70");
	} else if (num < 90) {
	    return (" 80");
	} else if (num < 100) {
	    return (" 90");
	}
    } else {
	if (num < 200) {
	    if (num < 150) {
		if (num < 110) {
		    return ("100");
		} else {
		    if (num < 120) {
			return ("110");
		    } else {
			if (num < 130) {
			    return ("120");
			} else {
			    if (num < 140) {
				return ("130");
			    } else {
				return ("140");
			    }
			}
		    }
		}
	    } else {
		if (num < 160) {
		    return ("150");
		} else {
		    if (num < 170) {
			return ("160");
		    } else {
			if (num < 180) {
			    return ("170");
			} else {
			    if (num < 190) {
				return ("180");
			    } else {
				if (num < 200) {
				    return ("190");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 300) {
		if (num < 250) {
		    if (num < 210) {
			return ("200");
		    } else {
			if (num < 220) {
			    return ("210");
			} else {
			    if (num < 230) {
				return ("220");
			    } else {
				if (num < 240) {
				    return ("230");
				} else {
				    return ("240");
				}
			    }
			}
		    }
		} else {
		    if (num < 260) {
			return ("250");
		    } else {
			if (num < 270) {
			    return ("260");
			} else {
			    if (num < 280) {
				return ("270");
			    } else {
				if (num < 290) {
				    return ("280");
				} else {
				    if (num < 300) {
					return ("290");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 400) {
		    if (num < 350) {
			if (num < 310) {
			    return ("300");
			} else {
			    if (num < 320) {
				return ("310");
			    } else {
				if (num < 330) {
				    return ("320");
				} else {
				    if (num < 340) {
					return ("330");
				    } else {
					return ("340");
				    }
				}
			    }
			}
		    } else {
			if (num < 360) {
			    return ("350");
			} else {
			    if (num < 370) {
				return ("360");
			    } else {
				if (num < 380) {
				    return ("370");
				} else {
				    if (num < 390) {
					return ("380");
				    } else {
					if (num < 400) {
					    return ("390");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 500) {
			if (num < 450) {
			    if (num < 410) {
				return ("400");
			    } else {
				if (num < 420) {
				    return ("410");
				} else {
				    if (num < 430) {
					return ("420");
				    } else {
					if (num < 440) {
					    return ("430");
					} else {
					    return ("440");
					}
				    }
				}
			    }
			} else {
			    if (num < 460) {
				return ("450");
			    } else {
				if (num < 470) {
				    return ("460");
				} else {
				    if (num < 480) {
					return ("470");
				    } else {
					if (num < 490) {
					    return ("480");
					} else {
					    if (num < 500) {
						return ("490");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 600) {
			    if (num < 550) {
				if (num < 510) {
				    return ("500");
				} else {
				    if (num < 520) {
					return ("510");
				    } else {
					if (num < 530) {
					    return ("520");
					} else {
					    if (num < 540) {
						return ("530");
					    } else {
						return ("540");
					    }
					}
				    }
				}
			    } else {
				if (num < 560) {
				    return ("550");
				} else {
				    if (num < 570) {
					return ("560");
				    } else {
					if (num < 580) {
					    return ("570");
					} else {
					    if (num < 590) {
						return ("580");
					    } else {
						if (num < 600) {
						    return ("590");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 700) {
				if (num < 650) {
				    if (num < 610) {
					return ("600");
				    } else {
					if (num < 620) {
					    return ("610");
					} else {
					    if (num < 630) {
						return ("620");
					    } else {
						if (num < 640) {
						    return ("630");
						} else {
						    return ("640");
						}
					    }
					}
				    }
				} else {
				    if (num < 660) {
					return ("650");
				    } else {
					if (num < 670) {
					    return ("660");
					} else {
					    if (num < 680) {
						return ("670");
					    } else {
						if (num < 690) {
						    return ("680");
						} else {
						    if (num < 700) {
							return ("690");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 800) {
				    if (num < 750) {
					if (num < 710) {
					    return ("700");
					} else {
					    if (num < 720) {
						return ("710");
					    } else {
						if (num < 730) {
						    return ("720");
						} else {
						    if (num < 740) {
							return ("730");
						    } else {
							return ("740");
						    }
						}
					    }
					}
				    } else {
					if (num < 760) {
					    return ("750");
					} else {
					    if (num < 770) {
						return ("760");
					    } else {
						if (num < 780) {
						    return ("770");
						} else {
						    if (num < 790) {
							return ("780");
						    } else {
							if (num < 800) {
							    return ("790");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 900) {
					if (num < 850) {
					    if (num < 810) {
						return ("800");
					    } else {
						if (num < 820) {
						    return ("810");
						} else {
						    if (num < 830) {
							return ("820");
						    } else {
							if (num < 840) {
							    return ("830");
							} else {
							    return ("840");
							}
						    }
						}
					    }
					} else {
					    if (num < 860) {
						return ("850");
					    } else {
						if (num < 870) {
						    return ("860");
						} else {
						    if (num < 880) {
							return ("870");
						    } else {
							if (num < 890) {
							    return ("880");
							} else {
							    if (num < 900) {
								return ("890");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 1000) {
					    if (num < 950) {
						if (num < 910) {
						    return ("900");
						} else {
						    if (num < 920) {
							return ("910");
						    } else {
							if (num < 930) {
							    return ("920");
							} else {
							    if (num < 940) {
								return ("930");
							    } else {
								return ("940");
							    }
							}
						    }
						}
					    } else {
						if (num < 960) {
						    return ("950");
						} else {
						    if (num < 970) {
							return ("960");
						    } else {
							if (num < 980) {
							    return ("970");
							} else {
							    if (num < 990) {
								return ("980");
							    } else {
								if (num < 1000) {
								    return ("990");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) BlueScoreToString100 =
{
    if (num < 10) {
	if (num < 5) {
	    if (num == 0) {
		return ("  Blue:  0");
	    } else if (num == 1) {
		return ("  Blue:  1");
	    } else if (num == 2) {
		return ("  Blue:  2");
	    } else if (num == 3) {
		return ("  Blue:  3");
	    } else
		return ("  Blue:  4");
	} else if (num == 5) {
	    return ("  Blue:  5");
	} else if (num == 6) {
	    return ("  Blue:  6");
	} else if (num == 7) {
	    return ("  Blue:  7");
	} else if (num == 8) {
	    return ("  Blue:  8");
	} else if (num == 9) {
	    return ("  Blue:  9");
	}
    } else {
	if (num < 20) {
	    if (num < 15) {
		if (num == 10) {
		    return ("  Blue: 10");
		} else {
		    if (num == 11) {
			return ("  Blue: 11");
		    } else {
			if (num == 12) {
			    return ("  Blue: 12");
			} else {
			    if (num == 13) {
				return ("  Blue: 13");
			    } else {
				return ("  Blue: 14");
			    }
			}
		    }
		}
	    } else {
		if (num == 15) {
		    return ("  Blue: 15");
		} else {
		    if (num == 16) {
			return ("  Blue: 16");
		    } else {
			if (num == 17) {
			    return ("  Blue: 17");
			} else {
			    if (num == 18) {
				return ("  Blue: 18");
			    } else {
				if (num == 19) {
				    return ("  Blue: 19");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 30) {
		if (num < 25) {
		    if (num == 20) {
			return ("  Blue: 20");
		    } else {
			if (num == 21) {
			    return ("  Blue: 21");
			} else {
			    if (num == 22) {
				return ("  Blue: 22");
			    } else {
				if (num == 23) {
				    return ("  Blue: 23");
				} else {
				    return ("  Blue: 24");
				}
			    }
			}
		    }
		} else {
		    if (num == 25) {
			return ("  Blue: 25");
		    } else {
			if (num == 26) {
			    return ("  Blue: 26");
			} else {
			    if (num == 27) {
				return ("  Blue: 27");
			    } else {
				if (num == 28) {
				    return ("  Blue: 28");
				} else {
				    if (num == 29) {
					return ("  Blue: 29");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 40) {
		    if (num < 35) {
			if (num == 30) {
			    return ("  Blue: 30");
			} else {
			    if (num == 31) {
				return ("  Blue: 31");
			    } else {
				if (num == 32) {
				    return ("  Blue: 32");
				} else {
				    if (num == 33) {
					return ("  Blue: 33");
				    } else {
					return ("  Blue: 34");
				    }
				}
			    }
			}
		    } else {
			if (num == 35) {
			    return ("  Blue: 35");
			} else {
			    if (num == 36) {
				return ("  Blue: 36");
			    } else {
				if (num == 37) {
				    return ("  Blue: 37");
				} else {
				    if (num == 38) {
					return ("  Blue: 38");
				    } else {
					if (num == 39) {
					    return ("  Blue: 39");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 50) {
			if (num < 45) {
			    if (num == 40) {
				return ("  Blue: 40");
			    } else {
				if (num == 41) {
				    return ("  Blue: 41");
				} else {
				    if (num == 42) {
					return ("  Blue: 42");
				    } else {
					if (num == 43) {
					    return ("  Blue: 43");
					} else {
					    return ("  Blue: 44");
					}
				    }
				}
			    }
			} else {
			    if (num == 45) {
				return ("  Blue: 45");
			    } else {
				if (num == 46) {
				    return ("  Blue: 46");
				} else {
				    if (num == 47) {
					return ("  Blue: 47");
				    } else {
					if (num == 48) {
					    return ("  Blue: 48");
					} else {
					    if (num == 49) {
						return ("  Blue: 49");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 60) {
			    if (num < 55) {
				if (num == 50) {
				    return ("  Blue: 50");
				} else {
				    if (num == 51) {
					return ("  Blue: 51");
				    } else {
					if (num == 52) {
					    return ("  Blue: 52");
					} else {
					    if (num == 53) {
						return ("  Blue: 53");
					    } else {
						return ("  Blue: 54");
					    }
					}
				    }
				}
			    } else {
				if (num == 55) {
				    return ("  Blue: 55");
				} else {
				    if (num == 56) {
					return ("  Blue: 56");
				    } else {
					if (num == 57) {
					    return ("  Blue: 57");
					} else {
					    if (num == 58) {
						return ("  Blue: 58");
					    } else {
						if (num == 59) {
						    return ("  Blue: 59");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 70) {
				if (num < 65) {
				    if (num == 60) {
					return ("  Blue: 60");
				    } else {
					if (num == 61) {
					    return ("  Blue: 61");
					} else {
					    if (num == 62) {
						return ("  Blue: 62");
					    } else {
						if (num == 63) {
						    return ("  Blue: 63");
						} else {
						    return ("  Blue: 64");
						}
					    }
					}
				    }
				} else {
				    if (num == 65) {
					return ("  Blue: 65");
				    } else {
					if (num == 66) {
					    return ("  Blue: 66");
					} else {
					    if (num == 67) {
						return ("  Blue: 67");
					    } else {
						if (num == 68) {
						    return ("  Blue: 68");
						} else {
						    if (num == 69) {
							return ("  Blue: 69");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 80) {
				    if (num < 75) {
					if (num == 70) {
					    return ("  Blue: 70");
					} else {
					    if (num == 71) {
						return ("  Blue: 71");
					    } else {
						if (num == 72) {
						    return ("  Blue: 72");
						} else {
						    if (num == 73) {
							return ("  Blue: 73");
						    } else {
							return ("  Blue: 74");
						    }
						}
					    }
					}
				    } else {
					if (num == 75) {
					    return ("  Blue: 75");
					} else {
					    if (num == 76) {
						return ("  Blue: 76");
					    } else {
						if (num == 77) {
						    return ("  Blue: 77");
						} else {
						    if (num == 78) {
							return ("  Blue: 78");
						    } else {
							if (num == 79) {
							    return ("  Blue: 79");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 90) {
					if (num < 85) {
					    if (num == 80) {
						return ("  Blue: 80");
					    } else {
						if (num == 81) {
						    return ("  Blue: 81");
						} else {
						    if (num == 82) {
							return ("  Blue: 82");
						    } else {
							if (num == 83) {
							    return ("  Blue: 83");
							} else {
							    return ("  Blue: 84");
							}
						    }
						}
					    }
					} else {
					    if (num == 85) {
						return ("  Blue: 85");
					    } else {
						if (num == 86) {
						    return ("  Blue: 86");
						} else {
						    if (num == 87) {
							return ("  Blue: 87");
						    } else {
							if (num == 88) {
							    return ("  Blue: 88");
							} else {
							    if (num == 89) {
								return ("  Blue: 89");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 100) {
					    if (num < 95) {
						if (num == 90) {
						    return ("  Blue: 90");
						} else {
						    if (num == 91) {
							return ("  Blue: 91");
						    } else {
							if (num == 92) {
							    return ("  Blue: 92");
							} else {
							    if (num == 93) {
								return ("  Blue: 93");
							    } else {
								return ("  Blue: 94");
							    }
							}
						    }
						}
					    } else {
						if (num == 95) {
						    return ("  Blue: 95");
						} else {
						    if (num == 96) {
							return ("  Blue: 96");
						    } else {
							if (num == 97) {
							    return ("  Blue: 97");
							} else {
							    if (num == 98) {
								return ("  Blue: 98");
							    } else {
								if (num == 99) {
								    return ("  Blue: 99");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) BlueScoreToString1000 =
{
    if (num < 100) {
	if (num < 50) {
	    if (num < 10) {
		return ("  Blue:  0");
	    } else if (num < 20) {
		return ("  Blue: 10");
	    } else if (num < 30) {
		return ("  Blue: 20");
	    } else if (num < 40) {
		return ("  Blue: 30");
	    } else
		return ("  Blue: 40");
	} else if (num < 60) {
	    return ("  Blue: 50");
	} else if (num < 70) {
	    return ("  Blue: 60");
	} else if (num < 80) {
	    return ("  Blue: 70");
	} else if (num < 90) {
	    return ("  Blue: 80");
	} else if (num < 100) {
	    return ("  Blue: 90");
	}
    } else {
	if (num < 200) {
	    if (num < 150) {
		if (num < 110) {
		    return ("  Blue:100");
		} else {
		    if (num < 120) {
			return ("  Blue:110");
		    } else {
			if (num < 130) {
			    return ("  Blue:120");
			} else {
			    if (num < 140) {
				return ("  Blue:130");
			    } else {
				return ("  Blue:140");
			    }
			}
		    }
		}
	    } else {
		if (num < 160) {
		    return ("  Blue:150");
		} else {
		    if (num < 170) {
			return ("  Blue:160");
		    } else {
			if (num < 180) {
			    return ("  Blue:170");
			} else {
			    if (num < 190) {
				return ("  Blue:180");
			    } else {
				if (num < 200) {
				    return ("  Blue:190");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 300) {
		if (num < 250) {
		    if (num < 210) {
			return ("  Blue:200");
		    } else {
			if (num < 220) {
			    return ("  Blue:210");
			} else {
			    if (num < 230) {
				return ("  Blue:220");
			    } else {
				if (num < 240) {
				    return ("  Blue:230");
				} else {
				    return ("  Blue:240");
				}
			    }
			}
		    }
		} else {
		    if (num < 260) {
			return ("  Blue:250");
		    } else {
			if (num < 270) {
			    return ("  Blue:260");
			} else {
			    if (num < 280) {
				return ("  Blue:270");
			    } else {
				if (num < 290) {
				    return ("  Blue:280");
				} else {
				    if (num < 300) {
					return ("  Blue:290");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 400) {
		    if (num < 350) {
			if (num < 310) {
			    return ("  Blue:300");
			} else {
			    if (num < 320) {
				return ("  Blue:310");
			    } else {
				if (num < 330) {
				    return ("  Blue:320");
				} else {
				    if (num < 340) {
					return ("  Blue:330");
				    } else {
					return ("  Blue:340");
				    }
				}
			    }
			}
		    } else {
			if (num < 360) {
			    return ("  Blue:350");
			} else {
			    if (num < 370) {
				return ("  Blue:360");
			    } else {
				if (num < 380) {
				    return ("  Blue:370");
				} else {
				    if (num < 390) {
					return ("  Blue:380");
				    } else {
					if (num < 400) {
					    return ("  Blue:390");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 500) {
			if (num < 450) {
			    if (num < 410) {
				return ("  Blue:400");
			    } else {
				if (num < 420) {
				    return ("  Blue:410");
				} else {
				    if (num < 430) {
					return ("  Blue:420");
				    } else {
					if (num < 440) {
					    return ("  Blue:430");
					} else {
					    return ("  Blue:440");
					}
				    }
				}
			    }
			} else {
			    if (num < 460) {
				return ("  Blue:450");
			    } else {
				if (num < 470) {
				    return ("  Blue:460");
				} else {
				    if (num < 480) {
					return ("  Blue:470");
				    } else {
					if (num < 490) {
					    return ("  Blue:480");
					} else {
					    if (num < 500) {
						return ("  Blue:490");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 600) {
			    if (num < 550) {
				if (num < 510) {
				    return ("  Blue:500");
				} else {
				    if (num < 520) {
					return ("  Blue:510");
				    } else {
					if (num < 530) {
					    return ("  Blue:520");
					} else {
					    if (num < 540) {
						return ("  Blue:530");
					    } else {
						return ("  Blue:540");
					    }
					}
				    }
				}
			    } else {
				if (num < 560) {
				    return ("  Blue:550");
				} else {
				    if (num < 570) {
					return ("  Blue:560");
				    } else {
					if (num < 580) {
					    return ("  Blue:570");
					} else {
					    if (num < 590) {
						return ("  Blue:580");
					    } else {
						if (num < 600) {
						    return ("  Blue:590");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 700) {
				if (num < 650) {
				    if (num < 610) {
					return ("  Blue:600");
				    } else {
					if (num < 620) {
					    return ("  Blue:610");
					} else {
					    if (num < 630) {
						return ("  Blue:620");
					    } else {
						if (num < 640) {
						    return ("  Blue:630");
						} else {
						    return ("  Blue:640");
						}
					    }
					}
				    }
				} else {
				    if (num < 660) {
					return ("  Blue:650");
				    } else {
					if (num < 670) {
					    return ("  Blue:660");
					} else {
					    if (num < 680) {
						return ("  Blue:670");
					    } else {
						if (num < 690) {
						    return ("  Blue:680");
						} else {
						    if (num < 700) {
							return ("  Blue:690");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 800) {
				    if (num < 750) {
					if (num < 710) {
					    return ("  Blue:700");
					} else {
					    if (num < 720) {
						return ("  Blue:710");
					    } else {
						if (num < 730) {
						    return ("  Blue:720");
						} else {
						    if (num < 740) {
							return ("  Blue:730");
						    } else {
							return ("  Blue:740");
						    }
						}
					    }
					}
				    } else {
					if (num < 760) {
					    return ("  Blue:750");
					} else {
					    if (num < 770) {
						return ("  Blue:760");
					    } else {
						if (num < 780) {
						    return ("  Blue:770");
						} else {
						    if (num < 790) {
							return ("  Blue:780");
						    } else {
							if (num < 800) {
							    return ("  Blue:790");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 900) {
					if (num < 850) {
					    if (num < 810) {
						return ("  Blue:800");
					    } else {
						if (num < 820) {
						    return ("  Blue:810");
						} else {
						    if (num < 830) {
							return ("  Blue:820");
						    } else {
							if (num < 840) {
							    return ("  Blue:830");
							} else {
							    return ("  Blue:840");
							}
						    }
						}
					    }
					} else {
					    if (num < 860) {
						return ("  Blue:850");
					    } else {
						if (num < 870) {
						    return ("  Blue:860");
						} else {
						    if (num < 880) {
							return ("  Blue:870");
						    } else {
							if (num < 890) {
							    return ("  Blue:880");
							} else {
							    if (num < 900) {
								return ("  Blue:890");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 1000) {
					    if (num < 950) {
						if (num < 910) {
						    return ("  Blue:900");
						} else {
						    if (num < 920) {
							return ("  Blue:910");
						    } else {
							if (num < 930) {
							    return ("  Blue:920");
							} else {
							    if (num < 940) {
								return ("  Blue:930");
							    } else {
								return ("  Blue:940");
							    }
							}
						    }
						}
					    } else {
						if (num < 960) {
						    return ("  Blue:950");
						} else {
						    if (num < 970) {
							return ("  Blue:960");
						    } else {
							if (num < 980) {
							    return ("  Blue:970");
							} else {
							    if (num < 990) {
								return ("  Blue:980");
							    } else {
								if (num < 1000) {
								    return ("  Blue:990");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) RedScoreToString100 =
{
    if (num < 10) {
	if (num < 5) {
	    if (num == 0) {
		return ("  Red :  0");
	    } else if (num == 1) {
		return ("  Red :  1");
	    } else if (num == 2) {
		return ("  Red :  2");
	    } else if (num == 3) {
		return ("  Red :  3");
	    } else
		return ("  Red :  4");
	} else if (num == 5) {
	    return ("  Red :  5");
	} else if (num == 6) {
	    return ("  Red :  6");
	} else if (num == 7) {
	    return ("  Red :  7");
	} else if (num == 8) {
	    return ("  Red :  8");
	} else if (num == 9) {
	    return ("  Red :  9");
	}
    } else {
	if (num < 20) {
	    if (num < 15) {
		if (num == 10) {
		    return ("  Red : 10");
		} else {
		    if (num == 11) {
			return ("  Red : 11");
		    } else {
			if (num == 12) {
			    return ("  Red : 12");
			} else {
			    if (num == 13) {
				return ("  Red : 13");
			    } else {
				return ("  Red : 14");
			    }
			}
		    }
		}
	    } else {
		if (num == 15) {
		    return ("  Red : 15");
		} else {
		    if (num == 16) {
			return ("  Red : 16");
		    } else {
			if (num == 17) {
			    return ("  Red : 17");
			} else {
			    if (num == 18) {
				return ("  Red : 18");
			    } else {
				if (num == 19) {
				    return ("  Red : 19");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 30) {
		if (num < 25) {
		    if (num == 20) {
			return ("  Red : 20");
		    } else {
			if (num == 21) {
			    return ("  Red : 21");
			} else {
			    if (num == 22) {
				return ("  Red : 22");
			    } else {
				if (num == 23) {
				    return ("  Red : 23");
				} else {
				    return ("  Red : 24");
				}
			    }
			}
		    }
		} else {
		    if (num == 25) {
			return ("  Red : 25");
		    } else {
			if (num == 26) {
			    return ("  Red : 26");
			} else {
			    if (num == 27) {
				return ("  Red : 27");
			    } else {
				if (num == 28) {
				    return ("  Red : 28");
				} else {
				    if (num == 29) {
					return ("  Red : 29");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 40) {
		    if (num < 35) {
			if (num == 30) {
			    return ("  Red : 30");
			} else {
			    if (num == 31) {
				return ("  Red : 31");
			    } else {
				if (num == 32) {
				    return ("  Red : 32");
				} else {
				    if (num == 33) {
					return ("  Red : 33");
				    } else {
					return ("  Red : 34");
				    }
				}
			    }
			}
		    } else {
			if (num == 35) {
			    return ("  Red : 35");
			} else {
			    if (num == 36) {
				return ("  Red : 36");
			    } else {
				if (num == 37) {
				    return ("  Red : 37");
				} else {
				    if (num == 38) {
					return ("  Red : 38");
				    } else {
					if (num == 39) {
					    return ("  Red : 39");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 50) {
			if (num < 45) {
			    if (num == 40) {
				return ("  Red : 40");
			    } else {
				if (num == 41) {
				    return ("  Red : 41");
				} else {
				    if (num == 42) {
					return ("  Red : 42");
				    } else {
					if (num == 43) {
					    return ("  Red : 43");
					} else {
					    return ("  Red : 44");
					}
				    }
				}
			    }
			} else {
			    if (num == 45) {
				return ("  Red : 45");
			    } else {
				if (num == 46) {
				    return ("  Red : 46");
				} else {
				    if (num == 47) {
					return ("  Red : 47");
				    } else {
					if (num == 48) {
					    return ("  Red : 48");
					} else {
					    if (num == 49) {
						return ("  Red : 49");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 60) {
			    if (num < 55) {
				if (num == 50) {
				    return ("  Red : 50");
				} else {
				    if (num == 51) {
					return ("  Red : 51");
				    } else {
					if (num == 52) {
					    return ("  Red : 52");
					} else {
					    if (num == 53) {
						return ("  Red : 53");
					    } else {
						return ("  Red : 54");
					    }
					}
				    }
				}
			    } else {
				if (num == 55) {
				    return ("  Red : 55");
				} else {
				    if (num == 56) {
					return ("  Red : 56");
				    } else {
					if (num == 57) {
					    return ("  Red : 57");
					} else {
					    if (num == 58) {
						return ("  Red : 58");
					    } else {
						if (num == 59) {
						    return ("  Red : 59");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 70) {
				if (num < 65) {
				    if (num == 60) {
					return ("  Red : 60");
				    } else {
					if (num == 61) {
					    return ("  Red : 61");
					} else {
					    if (num == 62) {
						return ("  Red : 62");
					    } else {
						if (num == 63) {
						    return ("  Red : 63");
						} else {
						    return ("  Red : 64");
						}
					    }
					}
				    }
				} else {
				    if (num == 65) {
					return ("  Red : 65");
				    } else {
					if (num == 66) {
					    return ("  Red : 66");
					} else {
					    if (num == 67) {
						return ("  Red : 67");
					    } else {
						if (num == 68) {
						    return ("  Red : 68");
						} else {
						    if (num == 69) {
							return ("  Red : 69");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 80) {
				    if (num < 75) {
					if (num == 70) {
					    return ("  Red : 70");
					} else {
					    if (num == 71) {
						return ("  Red : 71");
					    } else {
						if (num == 72) {
						    return ("  Red : 72");
						} else {
						    if (num == 73) {
							return ("  Red : 73");
						    } else {
							return ("  Red : 74");
						    }
						}
					    }
					}
				    } else {
					if (num == 75) {
					    return ("  Red : 75");
					} else {
					    if (num == 76) {
						return ("  Red : 76");
					    } else {
						if (num == 77) {
						    return ("  Red : 77");
						} else {
						    if (num == 78) {
							return ("  Red : 78");
						    } else {
							if (num == 79) {
							    return ("  Red : 79");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 90) {
					if (num < 85) {
					    if (num == 80) {
						return ("  Red : 80");
					    } else {
						if (num == 81) {
						    return ("  Red : 81");
						} else {
						    if (num == 82) {
							return ("  Red : 82");
						    } else {
							if (num == 83) {
							    return ("  Red : 83");
							} else {
							    return ("  Red : 84");
							}
						    }
						}
					    }
					} else {
					    if (num == 85) {
						return ("  Red : 85");
					    } else {
						if (num == 86) {
						    return ("  Red : 86");
						} else {
						    if (num == 87) {
							return ("  Red : 87");
						    } else {
							if (num == 88) {
							    return ("  Red : 88");
							} else {
							    if (num == 89) {
								return ("  Red : 89");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 100) {
					    if (num < 95) {
						if (num == 90) {
						    return ("  Red : 90");
						} else {
						    if (num == 91) {
							return ("  Red : 91");
						    } else {
							if (num == 92) {
							    return ("  Red : 92");
							} else {
							    if (num == 93) {
								return ("  Red : 93");
							    } else {
								return ("  Red : 94");
							    }
							}
						    }
						}
					    } else {
						if (num == 95) {
						    return ("  Red : 95");
						} else {
						    if (num == 96) {
							return ("  Red : 96");
						    } else {
							if (num == 97) {
							    return ("  Red : 97");
							} else {
							    if (num == 98) {
								return ("  Red : 98");
							    } else {
								if (num == 99) {
								    return ("  Red : 99");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) RedScoreToString1000 =
{
    if (num < 100) {
	if (num < 50) {
	    if (num < 10) {
		return ("  Red :  0");
	    } else if (num < 20) {
		return ("  Red : 10");
	    } else if (num < 30) {
		return ("  Red : 20");
	    } else if (num < 40) {
		return ("  Red : 30");
	    } else
		return ("  Red : 40");
	} else if (num < 60) {
	    return ("  Red : 50");
	} else if (num < 70) {
	    return ("  Red : 60");
	} else if (num < 80) {
	    return ("  Red : 70");
	} else if (num < 90) {
	    return ("  Red : 80");
	} else if (num < 100) {
	    return ("  Red : 90");
	}
    } else {
	if (num < 200) {
	    if (num < 150) {
		if (num < 110) {
		    return ("  Red :100");
		} else {
		    if (num < 120) {
			return ("  Red :110");
		    } else {
			if (num < 130) {
			    return ("  Red :120");
			} else {
			    if (num < 140) {
				return ("  Red :130");
			    } else {
				return ("  Red :140");
			    }
			}
		    }
		}
	    } else {
		if (num < 160) {
		    return ("  Red :150");
		} else {
		    if (num < 170) {
			return ("  Red :160");
		    } else {
			if (num < 180) {
			    return ("  Red :170");
			} else {
			    if (num < 190) {
				return ("  Red :180");
			    } else {
				if (num < 200) {
				    return ("  Red :190");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 300) {
		if (num < 250) {
		    if (num < 210) {
			return ("  Red :200");
		    } else {
			if (num < 220) {
			    return ("  Red :210");
			} else {
			    if (num < 230) {
				return ("  Red :220");
			    } else {
				if (num < 240) {
				    return ("  Red :230");
				} else {
				    return ("  Red :240");
				}
			    }
			}
		    }
		} else {
		    if (num < 260) {
			return ("  Red :250");
		    } else {
			if (num < 270) {
			    return ("  Red :260");
			} else {
			    if (num < 280) {
				return ("  Red :270");
			    } else {
				if (num < 290) {
				    return ("  Red :280");
				} else {
				    if (num < 300) {
					return ("  Red :290");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 400) {
		    if (num < 350) {
			if (num < 310) {
			    return ("  Red :300");
			} else {
			    if (num < 320) {
				return ("  Red :310");
			    } else {
				if (num < 330) {
				    return ("  Red :320");
				} else {
				    if (num < 340) {
					return ("  Red :330");
				    } else {
					return ("  Red :340");
				    }
				}
			    }
			}
		    } else {
			if (num < 360) {
			    return ("  Red :350");
			} else {
			    if (num < 370) {
				return ("  Red :360");
			    } else {
				if (num < 380) {
				    return ("  Red :370");
				} else {
				    if (num < 390) {
					return ("  Red :380");
				    } else {
					if (num < 400) {
					    return ("  Red :390");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 500) {
			if (num < 450) {
			    if (num < 410) {
				return ("  Red :400");
			    } else {
				if (num < 420) {
				    return ("  Red :410");
				} else {
				    if (num < 430) {
					return ("  Red :420");
				    } else {
					if (num < 440) {
					    return ("  Red :430");
					} else {
					    return ("  Red :440");
					}
				    }
				}
			    }
			} else {
			    if (num < 460) {
				return ("  Red :450");
			    } else {
				if (num < 470) {
				    return ("  Red :460");
				} else {
				    if (num < 480) {
					return ("  Red :470");
				    } else {
					if (num < 490) {
					    return ("  Red :480");
					} else {
					    if (num < 500) {
						return ("  Red :490");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 600) {
			    if (num < 550) {
				if (num < 510) {
				    return ("  Red :500");
				} else {
				    if (num < 520) {
					return ("  Red :510");
				    } else {
					if (num < 530) {
					    return ("  Red :520");
					} else {
					    if (num < 540) {
						return ("  Red :530");
					    } else {
						return ("  Red :540");
					    }
					}
				    }
				}
			    } else {
				if (num < 560) {
				    return ("  Red :550");
				} else {
				    if (num < 570) {
					return ("  Red :560");
				    } else {
					if (num < 580) {
					    return ("  Red :570");
					} else {
					    if (num < 590) {
						return ("  Red :580");
					    } else {
						if (num < 600) {
						    return ("  Red :590");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 700) {
				if (num < 650) {
				    if (num < 610) {
					return ("  Red :600");
				    } else {
					if (num < 620) {
					    return ("  Red :610");
					} else {
					    if (num < 630) {
						return ("  Red :620");
					    } else {
						if (num < 640) {
						    return ("  Red :630");
						} else {
						    return ("  Red :640");
						}
					    }
					}
				    }
				} else {
				    if (num < 660) {
					return ("  Red :650");
				    } else {
					if (num < 670) {
					    return ("  Red :660");
					} else {
					    if (num < 680) {
						return ("  Red :670");
					    } else {
						if (num < 690) {
						    return ("  Red :680");
						} else {
						    if (num < 700) {
							return ("  Red :690");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 800) {
				    if (num < 750) {
					if (num < 710) {
					    return ("  Red :700");
					} else {
					    if (num < 720) {
						return ("  Red :710");
					    } else {
						if (num < 730) {
						    return ("  Red :720");
						} else {
						    if (num < 740) {
							return ("  Red :730");
						    } else {
							return ("  Red :740");
						    }
						}
					    }
					}
				    } else {
					if (num < 760) {
					    return ("  Red :750");
					} else {
					    if (num < 770) {
						return ("  Red :760");
					    } else {
						if (num < 780) {
						    return ("  Red :770");
						} else {
						    if (num < 790) {
							return ("  Red :780");
						    } else {
							if (num < 800) {
							    return ("  Red :790");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 900) {
					if (num < 850) {
					    if (num < 810) {
						return ("  Red :800");
					    } else {
						if (num < 820) {
						    return ("  Red :810");
						} else {
						    if (num < 830) {
							return ("  Red :820");
						    } else {
							if (num < 840) {
							    return ("  Red :830");
							} else {
							    return ("  Red :840");
							}
						    }
						}
					    }
					} else {
					    if (num < 860) {
						return ("  Red :850");
					    } else {
						if (num < 870) {
						    return ("  Red :860");
						} else {
						    if (num < 880) {
							return ("  Red :870");
						    } else {
							if (num < 890) {
							    return ("  Red :880");
							} else {
							    if (num < 900) {
								return ("  Red :890");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 1000) {
					    if (num < 950) {
						if (num < 910) {
						    return ("  Red :900");
						} else {
						    if (num < 920) {
							return ("  Red :910");
						    } else {
							if (num < 930) {
							    return ("  Red :920");
							} else {
							    if (num < 940) {
								return ("  Red :930");
							    } else {
								return ("  Red :940");
							    }
							}
						    }
						}
					    } else {
						if (num < 960) {
						    return ("  Red :950");
						} else {
						    if (num < 970) {
							return ("  Red :960");
						    } else {
							if (num < 980) {
							    return ("  Red :970");
							} else {
							    if (num < 990) {
								return ("  Red :980");
							    } else {
								if (num < 1000) {
								    return ("  Red :990");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) YellowScoreToString100 =
{
    if (num < 10) {
	if (num < 5) {
	    if (num == 0) {
		return ("  Yell:  0");
	    } else if (num == 1) {
		return ("  Yell:  1");
	    } else if (num == 2) {
		return ("  Yell:  2");
	    } else if (num == 3) {
		return ("  Yell:  3");
	    } else
		return ("  Yell:  4");
	} else if (num == 5) {
	    return ("  Yell:  5");
	} else if (num == 6) {
	    return ("  Yell:  6");
	} else if (num == 7) {
	    return ("  Yell:  7");
	} else if (num == 8) {
	    return ("  Yell:  8");
	} else if (num == 9) {
	    return ("  Yell:  9");
	}
    } else {
	if (num < 20) {
	    if (num < 15) {
		if (num == 10) {
		    return ("  Yell: 10");
		} else {
		    if (num == 11) {
			return ("  Yell: 11");
		    } else {
			if (num == 12) {
			    return ("  Yell: 12");
			} else {
			    if (num == 13) {
				return ("  Yell: 13");
			    } else {
				return ("  Yell: 14");
			    }
			}
		    }
		}
	    } else {
		if (num == 15) {
		    return ("  Yell: 15");
		} else {
		    if (num == 16) {
			return ("  Yell: 16");
		    } else {
			if (num == 17) {
			    return ("  Yell: 17");
			} else {
			    if (num == 18) {
				return ("  Yell: 18");
			    } else {
				if (num == 19) {
				    return ("  Yell: 19");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 30) {
		if (num < 25) {
		    if (num == 20) {
			return ("  Yell: 20");
		    } else {
			if (num == 21) {
			    return ("  Yell: 21");
			} else {
			    if (num == 22) {
				return ("  Yell: 22");
			    } else {
				if (num == 23) {
				    return ("  Yell: 23");
				} else {
				    return ("  Yell: 24");
				}
			    }
			}
		    }
		} else {
		    if (num == 25) {
			return ("  Yell: 25");
		    } else {
			if (num == 26) {
			    return ("  Yell: 26");
			} else {
			    if (num == 27) {
				return ("  Yell: 27");
			    } else {
				if (num == 28) {
				    return ("  Yell: 28");
				} else {
				    if (num == 29) {
					return ("  Yell: 29");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 40) {
		    if (num < 35) {
			if (num == 30) {
			    return ("  Yell: 30");
			} else {
			    if (num == 31) {
				return ("  Yell: 31");
			    } else {
				if (num == 32) {
				    return ("  Yell: 32");
				} else {
				    if (num == 33) {
					return ("  Yell: 33");
				    } else {
					return ("  Yell: 34");
				    }
				}
			    }
			}
		    } else {
			if (num == 35) {
			    return ("  Yell: 35");
			} else {
			    if (num == 36) {
				return ("  Yell: 36");
			    } else {
				if (num == 37) {
				    return ("  Yell: 37");
				} else {
				    if (num == 38) {
					return ("  Yell: 38");
				    } else {
					if (num == 39) {
					    return ("  Yell: 39");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 50) {
			if (num < 45) {
			    if (num == 40) {
				return ("  Yell: 40");
			    } else {
				if (num == 41) {
				    return ("  Yell: 41");
				} else {
				    if (num == 42) {
					return ("  Yell: 42");
				    } else {
					if (num == 43) {
					    return ("  Yell: 43");
					} else {
					    return ("  Yell: 44");
					}
				    }
				}
			    }
			} else {
			    if (num == 45) {
				return ("  Yell: 45");
			    } else {
				if (num == 46) {
				    return ("  Yell: 46");
				} else {
				    if (num == 47) {
					return ("  Yell: 47");
				    } else {
					if (num == 48) {
					    return ("  Yell: 48");
					} else {
					    if (num == 49) {
						return ("  Yell: 49");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 60) {
			    if (num < 55) {
				if (num == 50) {
				    return ("  Yell: 50");
				} else {
				    if (num == 51) {
					return ("  Yell: 51");
				    } else {
					if (num == 52) {
					    return ("  Yell: 52");
					} else {
					    if (num == 53) {
						return ("  Yell: 53");
					    } else {
						return ("  Yell: 54");
					    }
					}
				    }
				}
			    } else {
				if (num == 55) {
				    return ("  Yell: 55");
				} else {
				    if (num == 56) {
					return ("  Yell: 56");
				    } else {
					if (num == 57) {
					    return ("  Yell: 57");
					} else {
					    if (num == 58) {
						return ("  Yell: 58");
					    } else {
						if (num == 59) {
						    return ("  Yell: 59");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 70) {
				if (num < 65) {
				    if (num == 60) {
					return ("  Yell: 60");
				    } else {
					if (num == 61) {
					    return ("  Yell: 61");
					} else {
					    if (num == 62) {
						return ("  Yell: 62");
					    } else {
						if (num == 63) {
						    return ("  Yell: 63");
						} else {
						    return ("  Yell: 64");
						}
					    }
					}
				    }
				} else {
				    if (num == 65) {
					return ("  Yell: 65");
				    } else {
					if (num == 66) {
					    return ("  Yell: 66");
					} else {
					    if (num == 67) {
						return ("  Yell: 67");
					    } else {
						if (num == 68) {
						    return ("  Yell: 68");
						} else {
						    if (num == 69) {
							return ("  Yell: 69");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 80) {
				    if (num < 75) {
					if (num == 70) {
					    return ("  Yell: 70");
					} else {
					    if (num == 71) {
						return ("  Yell: 71");
					    } else {
						if (num == 72) {
						    return ("  Yell: 72");
						} else {
						    if (num == 73) {
							return ("  Yell: 73");
						    } else {
							return ("  Yell: 74");
						    }
						}
					    }
					}
				    } else {
					if (num == 75) {
					    return ("  Yell: 75");
					} else {
					    if (num == 76) {
						return ("  Yell: 76");
					    } else {
						if (num == 77) {
						    return ("  Yell: 77");
						} else {
						    if (num == 78) {
							return ("  Yell: 78");
						    } else {
							if (num == 79) {
							    return ("  Yell: 79");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 90) {
					if (num < 85) {
					    if (num == 80) {
						return ("  Yell: 80");
					    } else {
						if (num == 81) {
						    return ("  Yell: 81");
						} else {
						    if (num == 82) {
							return ("  Yell: 82");
						    } else {
							if (num == 83) {
							    return ("  Yell: 83");
							} else {
							    return ("  Yell: 84");
							}
						    }
						}
					    }
					} else {
					    if (num == 85) {
						return ("  Yell: 85");
					    } else {
						if (num == 86) {
						    return ("  Yell: 86");
						} else {
						    if (num == 87) {
							return ("  Yell: 87");
						    } else {
							if (num == 88) {
							    return ("  Yell: 88");
							} else {
							    if (num == 89) {
								return ("  Yell: 89");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 100) {
					    if (num < 95) {
						if (num == 90) {
						    return ("  Yell: 90");
						} else {
						    if (num == 91) {
							return ("  Yell: 91");
						    } else {
							if (num == 92) {
							    return ("  Yell: 92");
							} else {
							    if (num == 93) {
								return ("  Yell: 93");
							    } else {
								return ("  Yell: 94");
							    }
							}
						    }
						}
					    } else {
						if (num == 95) {
						    return ("  Yell: 95");
						} else {
						    if (num == 96) {
							return ("  Yell: 96");
						    } else {
							if (num == 97) {
							    return ("  Yell: 97");
							} else {
							    if (num == 98) {
								return ("  Yell: 98");
							    } else {
								if (num == 99) {
								    return ("  Yell: 99");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) YellowScoreToString1000 =
{
    if (num < 100) {
	if (num < 50) {
	    if (num < 10) {
		return ("  Yell:  0");
	    } else if (num < 20) {
		return ("  Yell: 10");
	    } else if (num < 30) {
		return ("  Yell: 20");
	    } else if (num < 40) {
		return ("  Yell: 30");
	    } else
		return ("  Yell: 40");
	} else if (num < 60) {
	    return ("  Yell: 50");
	} else if (num < 70) {
	    return ("  Yell: 60");
	} else if (num < 80) {
	    return ("  Yell: 70");
	} else if (num < 90) {
	    return ("  Yell: 80");
	} else if (num < 100) {
	    return ("  Yell: 90");
	}
    } else {
	if (num < 200) {
	    if (num < 150) {
		if (num < 110) {
		    return ("  Yell:100");
		} else {
		    if (num < 120) {
			return ("  Yell:110");
		    } else {
			if (num < 130) {
			    return ("  Yell:120");
			} else {
			    if (num < 140) {
				return ("  Yell:130");
			    } else {
				return ("  Yell:140");
			    }
			}
		    }
		}
	    } else {
		if (num < 160) {
		    return ("  Yell:150");
		} else {
		    if (num < 170) {
			return ("  Yell:160");
		    } else {
			if (num < 180) {
			    return ("  Yell:170");
			} else {
			    if (num < 190) {
				return ("  Yell:180");
			    } else {
				if (num < 200) {
				    return ("  Yell:190");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 300) {
		if (num < 250) {
		    if (num < 210) {
			return ("  Yell:200");
		    } else {
			if (num < 220) {
			    return ("  Yell:210");
			} else {
			    if (num < 230) {
				return ("  Yell:220");
			    } else {
				if (num < 240) {
				    return ("  Yell:230");
				} else {
				    return ("  Yell:240");
				}
			    }
			}
		    }
		} else {
		    if (num < 260) {
			return ("  Yell:250");
		    } else {
			if (num < 270) {
			    return ("  Yell:260");
			} else {
			    if (num < 280) {
				return ("  Yell:270");
			    } else {
				if (num < 290) {
				    return ("  Yell:280");
				} else {
				    if (num < 300) {
					return ("  Yell:290");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 400) {
		    if (num < 350) {
			if (num < 310) {
			    return ("  Yell:300");
			} else {
			    if (num < 320) {
				return ("  Yell:310");
			    } else {
				if (num < 330) {
				    return ("  Yell:320");
				} else {
				    if (num < 340) {
					return ("  Yell:330");
				    } else {
					return ("  Yell:340");
				    }
				}
			    }
			}
		    } else {
			if (num < 360) {
			    return ("  Yell:350");
			} else {
			    if (num < 370) {
				return ("  Yell:360");
			    } else {
				if (num < 380) {
				    return ("  Yell:370");
				} else {
				    if (num < 390) {
					return ("  Yell:380");
				    } else {
					if (num < 400) {
					    return ("  Yell:390");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 500) {
			if (num < 450) {
			    if (num < 410) {
				return ("  Yell:400");
			    } else {
				if (num < 420) {
				    return ("  Yell:410");
				} else {
				    if (num < 430) {
					return ("  Yell:420");
				    } else {
					if (num < 440) {
					    return ("  Yell:430");
					} else {
					    return ("  Yell:440");
					}
				    }
				}
			    }
			} else {
			    if (num < 460) {
				return ("  Yell:450");
			    } else {
				if (num < 470) {
				    return ("  Yell:460");
				} else {
				    if (num < 480) {
					return ("  Yell:470");
				    } else {
					if (num < 490) {
					    return ("  Yell:480");
					} else {
					    if (num < 500) {
						return ("  Yell:490");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 600) {
			    if (num < 550) {
				if (num < 510) {
				    return ("  Yell:500");
				} else {
				    if (num < 520) {
					return ("  Yell:510");
				    } else {
					if (num < 530) {
					    return ("  Yell:520");
					} else {
					    if (num < 540) {
						return ("  Yell:530");
					    } else {
						return ("  Yell:540");
					    }
					}
				    }
				}
			    } else {
				if (num < 560) {
				    return ("  Yell:550");
				} else {
				    if (num < 570) {
					return ("  Yell:560");
				    } else {
					if (num < 580) {
					    return ("  Yell:570");
					} else {
					    if (num < 590) {
						return ("  Yell:580");
					    } else {
						if (num < 600) {
						    return ("  Yell:590");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 700) {
				if (num < 650) {
				    if (num < 610) {
					return ("  Yell:600");
				    } else {
					if (num < 620) {
					    return ("  Yell:610");
					} else {
					    if (num < 630) {
						return ("  Yell:620");
					    } else {
						if (num < 640) {
						    return ("  Yell:630");
						} else {
						    return ("  Yell:640");
						}
					    }
					}
				    }
				} else {
				    if (num < 660) {
					return ("  Yell:650");
				    } else {
					if (num < 670) {
					    return ("  Yell:660");
					} else {
					    if (num < 680) {
						return ("  Yell:670");
					    } else {
						if (num < 690) {
						    return ("  Yell:680");
						} else {
						    if (num < 700) {
							return ("  Yell:690");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 800) {
				    if (num < 750) {
					if (num < 710) {
					    return ("  Yell:700");
					} else {
					    if (num < 720) {
						return ("  Yell:710");
					    } else {
						if (num < 730) {
						    return ("  Yell:720");
						} else {
						    if (num < 740) {
							return ("  Yell:730");
						    } else {
							return ("  Yell:740");
						    }
						}
					    }
					}
				    } else {
					if (num < 760) {
					    return ("  Yell:750");
					} else {
					    if (num < 770) {
						return ("  Yell:760");
					    } else {
						if (num < 780) {
						    return ("  Yell:770");
						} else {
						    if (num < 790) {
							return ("  Yell:780");
						    } else {
							if (num < 800) {
							    return ("  Yell:790");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 900) {
					if (num < 850) {
					    if (num < 810) {
						return ("  Yell:800");
					    } else {
						if (num < 820) {
						    return ("  Yell:810");
						} else {
						    if (num < 830) {
							return ("  Yell:820");
						    } else {
							if (num < 840) {
							    return ("  Yell:830");
							} else {
							    return ("  Yell:840");
							}
						    }
						}
					    }
					} else {
					    if (num < 860) {
						return ("  Yell:850");
					    } else {
						if (num < 870) {
						    return ("  Yell:860");
						} else {
						    if (num < 880) {
							return ("  Yell:870");
						    } else {
							if (num < 890) {
							    return ("  Yell:880");
							} else {
							    if (num < 900) {
								return ("  Yell:890");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 1000) {
					    if (num < 950) {
						if (num < 910) {
						    return ("  Yell:900");
						} else {
						    if (num < 920) {
							return ("  Yell:910");
						    } else {
							if (num < 930) {
							    return ("  Yell:920");
							} else {
							    if (num < 940) {
								return ("  Yell:930");
							    } else {
								return ("  Yell:940");
							    }
							}
						    }
						}
					    } else {
						if (num < 960) {
						    return ("  Yell:950");
						} else {
						    if (num < 970) {
							return ("  Yell:960");
						    } else {
							if (num < 980) {
							    return ("  Yell:970");
							} else {
							    if (num < 990) {
								return ("  Yell:980");
							    } else {
								if (num < 1000) {
								    return ("  Yell:990");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) GreenScoreToString100 =
{
    if (num < 10) {
	if (num < 5) {
	    if (num == 0) {
		return ("  Gren:  0");
	    } else if (num == 1) {
		return ("  Gren:  1");
	    } else if (num == 2) {
		return ("  Gren:  2");
	    } else if (num == 3) {
		return ("  Gren:  3");
	    } else
		return ("  Gren:  4");
	} else {
	    if (num == 5) {
		return ("  Gren:  5");
	    } else if (num == 6) {
		return ("  Gren:  6");
	    } else if (num == 7) {
		return ("  Gren:  7");
	    } else if (num == 8) {
		return ("  Gren:  8");
	    } else if (num == 9) {
		return ("  Gren:  9");
	    }
	}
    } else {
	if (num < 20) {
	    if (num < 15) {
		if (num == 10) {
		    return ("  Gren: 10");
		} else {
		    if (num == 11) {
			return ("  Gren: 11");
		    } else {
			if (num == 12) {
			    return ("  Gren: 12");
			} else {
			    if (num == 13) {
				return ("  Gren: 13");
			    } else {
				return ("  Gren: 14");
			    }
			}
		    }
		}
	    } else {
		if (num == 15) {
		    return ("  Gren: 15");
		} else {
		    if (num == 16) {
			return ("  Gren: 16");
		    } else {
			if (num == 17) {
			    return ("  Gren: 17");
			} else {
			    if (num == 18) {
				return ("  Gren: 18");
			    } else {
				if (num == 19) {
				    return ("  Gren: 19");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 30) {
		if (num < 25) {
		    if (num == 20) {
			return ("  Gren: 20");
		    } else {
			if (num == 21) {
			    return ("  Gren: 21");
			} else {
			    if (num == 22) {
				return ("  Gren: 22");
			    } else {
				if (num == 23) {
				    return ("  Gren: 23");
				} else {
				    return ("  Gren: 24");
				}
			    }
			}
		    }
		} else {
		    if (num == 25) {
			return ("  Gren: 25");
		    } else {
			if (num == 26) {
			    return ("  Gren: 26");
			} else {
			    if (num == 27) {
				return ("  Gren: 27");
			    } else {
				if (num == 28) {
				    return ("  Gren: 28");
				} else {
				    if (num == 29) {
					return ("  Gren: 29");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 40) {
		    if (num < 35) {
			if (num == 30) {
			    return ("  Gren: 30");
			} else {
			    if (num == 31) {
				return ("  Gren: 31");
			    } else {
				if (num == 32) {
				    return ("  Gren: 32");
				} else {
				    if (num == 33) {
					return ("  Gren: 33");
				    } else {
					return ("  Gren: 34");
				    }
				}
			    }
			}
		    } else {
			if (num == 35) {
			    return ("  Gren: 35");
			} else {
			    if (num == 36) {
				return ("  Gren: 36");
			    } else {
				if (num == 37) {
				    return ("  Gren: 37");
				} else {
				    if (num == 38) {
					return ("  Gren: 38");
				    } else {
					if (num == 39) {
					    return ("  Gren: 39");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 50) {
			if (num < 45) {
			    if (num == 40) {
				return ("  Gren: 40");
			    } else {
				if (num == 41) {
				    return ("  Gren: 41");
				} else {
				    if (num == 42) {
					return ("  Gren: 42");
				    } else {
					if (num == 43) {
					    return ("  Gren: 43");
					} else {
					    return ("  Gren: 44");
					}
				    }
				}
			    }
			} else {
			    if (num == 45) {
				return ("  Gren: 45");
			    } else {
				if (num == 46) {
				    return ("  Gren: 46");
				} else {
				    if (num == 47) {
					return ("  Gren: 47");
				    } else {
					if (num == 48) {
					    return ("  Gren: 48");
					} else {
					    if (num == 49) {
						return ("  Gren: 49");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 60) {
			    if (num < 55) {
				if (num == 50) {
				    return ("  Gren: 50");
				} else {
				    if (num == 51) {
					return ("  Gren: 51");
				    } else {
					if (num == 52) {
					    return ("  Gren: 52");
					} else {
					    if (num == 53) {
						return ("  Gren: 53");
					    } else {
						return ("  Gren: 54");
					    }
					}
				    }
				}
			    } else {
				if (num == 55) {
				    return ("  Gren: 55");
				} else {
				    if (num == 56) {
					return ("  Gren: 56");
				    } else {
					if (num == 57) {
					    return ("  Gren: 57");
					} else {
					    if (num == 58) {
						return ("  Gren: 58");
					    } else {
						if (num == 59) {
						    return ("  Gren: 59");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 70) {
				if (num < 65) {
				    if (num == 60) {
					return ("  Gren: 60");
				    } else {
					if (num == 61) {
					    return ("  Gren: 61");
					} else {
					    if (num == 62) {
						return ("  Gren: 62");
					    } else {
						if (num == 63) {
						    return ("  Gren: 63");
						} else {
						    return ("  Gren: 64");
						}
					    }
					}
				    }
				} else {
				    if (num == 65) {
					return ("  Gren: 65");
				    } else {
					if (num == 66) {
					    return ("  Gren: 66");
					} else {
					    if (num == 67) {
						return ("  Gren: 67");
					    } else {
						if (num == 68) {
						    return ("  Gren: 68");
						} else {
						    if (num == 69) {
							return ("  Gren: 69");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 80) {
				    if (num < 75) {
					if (num == 70) {
					    return ("  Gren: 70");
					} else {
					    if (num == 71) {
						return ("  Gren: 71");
					    } else {
						if (num == 72) {
						    return ("  Gren: 72");
						} else {
						    if (num == 73) {
							return ("  Gren: 73");
						    } else {
							return ("  Gren: 74");
						    }
						}
					    }
					}
				    } else {
					if (num == 75) {
					    return ("  Gren: 75");
					} else {
					    if (num == 76) {
						return ("  Gren: 76");
					    } else {
						if (num == 77) {
						    return ("  Gren: 77");
						} else {
						    if (num == 78) {
							return ("  Gren: 78");
						    } else {
							if (num == 79) {
							    return ("  Gren: 79");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 90) {
					if (num < 85) {
					    if (num == 80) {
						return ("  Gren: 80");
					    } else {
						if (num == 81) {
						    return ("  Gren: 81");
						} else {
						    if (num == 82) {
							return ("  Gren: 82");
						    } else {
							if (num == 83) {
							    return ("  Gren: 83");
							} else {
							    return ("  Gren: 84");
							}
						    }
						}
					    }
					} else {
					    if (num == 85) {
						return ("  Gren: 85");
					    } else {
						if (num == 86) {
						    return ("  Gren: 86");
						} else {
						    if (num == 87) {
							return ("  Gren: 87");
						    } else {
							if (num == 88) {
							    return ("  Gren: 88");
							} else {
							    if (num == 89) {
								return ("  Gren: 89");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 100) {
					    if (num < 95) {
						if (num == 90) {
						    return ("  Gren: 90");
						} else {
						    if (num == 91) {
							return ("  Gren: 91");
						    } else {
							if (num == 92) {
							    return ("  Gren: 92");
							} else {
							    if (num == 93) {
								return ("  Gren: 93");
							    } else {
								return ("  Gren: 94");
							    }
							}
						    }
						}
					    } else {
						if (num == 95) {
						    return ("  Gren: 95");
						} else {
						    if (num == 96) {
							return ("  Gren: 96");
						    } else {
							if (num == 97) {
							    return ("  Gren: 97");
							} else {
							    if (num == 98) {
								return ("  Gren: 98");
							    } else {
								if (num == 99) {
								    return ("  Gren: 99");
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
			}
		    }
		}
	    }
	}
    }
};

string (float num) GreenScoreToString1000 =
{
    if (num < 100) {
	if (num < 50) {
	    if (num < 10) {
		return ("  Gren:  0");
	    } else if (num < 20) {
		return ("  Gren: 10");
	    } else if (num < 30) {
		return ("  Gren: 20");
	    } else if (num < 40) {
		return ("  Gren: 30");
	    } else
		return ("  Gren: 40");
	} else if (num < 60) {
	    return ("  Gren: 50");
	} else if (num < 70) {
	    return ("  Gren: 60");
	} else if (num < 80) {
	    return ("  Gren: 70");
	} else if (num < 90) {
	    return ("  Gren: 80");
	} else if (num < 100) {
	    return ("  Gren: 90");
	}
    } else {
	if (num < 200) {
	    if (num < 150) {
		if (num < 110) {
		    return ("  Gren:100");
		} else {
		    if (num < 120) {
			return ("  Gren:110");
		    } else {
			if (num < 130) {
			    return ("  Gren:120");
			} else {
			    if (num < 140) {
				return ("  Gren:130");
			    } else {
				return ("  Gren:140");
			    }
			}
		    }
		}
	    } else {
		if (num < 160) {
		    return ("  Gren:150");
		} else {
		    if (num < 170) {
			return ("  Gren:160");
		    } else {
			if (num < 180) {
			    return ("  Gren:170");
			} else {
			    if (num < 190) {
				return ("  Gren:180");
			    } else {
				if (num < 200) {
				    return ("  Gren:190");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 300) {
		if (num < 250) {
		    if (num < 210) {
			return ("  Gren:200");
		    } else {
			if (num < 220) {
			    return ("  Gren:210");
			} else {
			    if (num < 230) {
				return ("  Gren:220");
			    } else {
				if (num < 240) {
				    return ("  Gren:230");
				} else {
				    return ("  Gren:240");
				}
			    }
			}
		    }
		} else {
		    if (num < 260) {
			return ("  Gren:250");
		    } else {
			if (num < 270) {
			    return ("  Gren:260");
			} else {
			    if (num < 280) {
				return ("  Gren:270");
			    } else {
				if (num < 290) {
				    return ("  Gren:280");
				} else {
				    if (num < 300) {
					return ("  Gren:290");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 400) {
		    if (num < 350) {
			if (num < 310) {
			    return ("  Gren:300");
			} else {
			    if (num < 320) {
				return ("  Gren:310");
			    } else {
				if (num < 330) {
				    return ("  Gren:320");
				} else {
				    if (num < 340) {
					return ("  Gren:330");
				    } else {
					return ("  Gren:340");
				    }
				}
			    }
			}
		    } else {
			if (num < 360) {
			    return ("  Gren:350");
			} else {
			    if (num < 370) {
				return ("  Gren:360");
			    } else {
				if (num < 380) {
				    return ("  Gren:370");
				} else {
				    if (num < 390) {
					return ("  Gren:380");
				    } else {
					if (num < 400) {
					    return ("  Gren:390");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 500) {
			if (num < 450) {
			    if (num < 410) {
				return ("  Gren:400");
			    } else {
				if (num < 420) {
				    return ("  Gren:410");
				} else {
				    if (num < 430) {
					return ("  Gren:420");
				    } else {
					if (num < 440) {
					    return ("  Gren:430");
					} else {
					    return ("  Gren:440");
					}
				    }
				}
			    }
			} else {
			    if (num < 460) {
				return ("  Gren:450");
			    } else {
				if (num < 470) {
				    return ("  Gren:460");
				} else {
				    if (num < 480) {
					return ("  Gren:470");
				    } else {
					if (num < 490) {
					    return ("  Gren:480");
					} else {
					    if (num < 500) {
						return ("  Gren:490");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 600) {
			    if (num < 550) {
				if (num < 510) {
				    return ("  Gren:500");
				} else {
				    if (num < 520) {
					return ("  Gren:510");
				    } else {
					if (num < 530) {
					    return ("  Gren:520");
					} else {
					    if (num < 540) {
						return ("  Gren:530");
					    } else {
						return ("  Gren:540");
					    }
					}
				    }
				}
			    } else {
				if (num < 560) {
				    return ("  Gren:550");
				} else {
				    if (num < 570) {
					return ("  Gren:560");
				    } else {
					if (num < 580) {
					    return ("  Gren:570");
					} else {
					    if (num < 590) {
						return ("  Gren:580");
					    } else {
						if (num < 600) {
						    return ("  Gren:590");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 700) {
				if (num < 650) {
				    if (num < 610) {
					return ("  Gren:600");
				    } else {
					if (num < 620) {
					    return ("  Gren:610");
					} else {
					    if (num < 630) {
						return ("  Gren:620");
					    } else {
						if (num < 640) {
						    return ("  Gren:630");
						} else {
						    return ("  Gren:640");
						}
					    }
					}
				    }
				} else {
				    if (num < 660) {
					return ("  Gren:650");
				    } else {
					if (num < 670) {
					    return ("  Gren:660");
					} else {
					    if (num < 680) {
						return ("  Gren:670");
					    } else {
						if (num < 690) {
						    return ("  Gren:680");
						} else {
						    if (num < 700) {
							return ("  Gren:690");
						    }
						}
					    }
					}
				    }
				}
			    } else {
				if (num < 800) {
				    if (num < 750) {
					if (num < 710) {
					    return ("  Gren:700");
					} else {
					    if (num < 720) {
						return ("  Gren:710");
					    } else {
						if (num < 730) {
						    return ("  Gren:720");
						} else {
						    if (num < 740) {
							return ("  Gren:730");
						    } else {
							return ("  Gren:740");
						    }
						}
					    }
					}
				    } else {
					if (num < 760) {
					    return ("  Gren:750");
					} else {
					    if (num < 770) {
						return ("  Gren:760");
					    } else {
						if (num < 780) {
						    return ("  Gren:770");
						} else {
						    if (num < 790) {
							return ("  Gren:780");
						    } else {
							if (num < 800) {
							    return ("  Gren:790");
							}
						    }
						}
					    }
					}
				    }
				} else {
				    if (num < 900) {
					if (num < 850) {
					    if (num < 810) {
						return ("  Gren:800");
					    } else {
						if (num < 820) {
						    return ("  Gren:810");
						} else {
						    if (num < 830) {
							return ("  Gren:820");
						    } else {
							if (num < 840) {
							    return ("  Gren:830");
							} else {
							    return ("  Gren:840");
							}
						    }
						}
					    }
					} else {
					    if (num < 860) {
						return ("  Gren:850");
					    } else {
						if (num < 870) {
						    return ("  Gren:860");
						} else {
						    if (num < 880) {
							return ("  Gren:870");
						    } else {
							if (num < 890) {
							    return ("  Gren:880");
							} else {
							    if (num < 900) {
								return ("  Gren:890");
							    }
							}
						    }
						}
					    }
					}
				    } else {
					if (num < 1000) {
					    if (num < 950) {
						if (num < 910) {
						    return ("  Gren:900");
						} else {
						    if (num < 920) {
							return ("  Gren:910");
						    } else {
							if (num < 930) {
							    return ("  Gren:920");
							} else {
							    if (num < 940) {
								return ("  Gren:930");
							    } else {
								return ("  Gren:940");
							    }
							}
						    }
						}
					    } else {
						if (num < 960) {
						    return ("  Gren:950");
						} else {
						    if (num < 970) {
							return ("  Gren:960");
						    } else {
							if (num < 980) {
							    return ("  Gren:970");
							} else {
							    if (num < 990) {
								return ("  Gren:980");
							    } else {
								if (num < 1000) {
								    return ("  Gren:990");
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
			}
		    }
		}
	    }
	}
    }
};

string (entity pl) ClipSizeToString100 =
{
    local float num;

    if (pl.current_weapon == WEAP_SHOTGUN) {
	if ((8 - pl.reload_shotgun) > pl.ammo_shells)
	    pl.reload_shotgun = 8 - pl.ammo_shells;
	num = 8 - pl.reload_shotgun;
    } else if (pl.current_weapon == WEAP_SUPER_SHOTGUN) {
	if ((16 - pl.reload_super_shotgun) > pl.ammo_shells)
	    pl.reload_super_shotgun = 16 - pl.ammo_shells;
	num = (16 - pl.reload_super_shotgun);
    } else if (pl.current_weapon == WEAP_GRENADE_LAUNCHER) {
	if ((6 - pl.reload_grenade_launcher) > pl.ammo_rockets)
	    pl.reload_grenade_launcher = (6 - pl.ammo_rockets);
	num = (6 - pl.reload_grenade_launcher);
    } else if (pl.current_weapon == WEAP_ROCKET_LAUNCHER) {
	if ((4 - pl.reload_rocket_launcher) > pl.ammo_rockets)
	    pl.reload_rocket_launcher = (4 - pl.ammo_rockets);
	num = (4 - pl.reload_rocket_launcher);
    } else
	return ("         ");

    if (num < 10) {
	if (num < 5) {
	    if (num == 0) {
		return ("  ÃÌÉÐ: 0");
	    } else if (num == 1) {
		return ("  ÃÌÉÐ: 1");
	    } else if (num == 2) {
		return ("  ÃÌÉÐ: 2");
	    } else if (num == 3) {
		return ("  ÃÌÉÐ: 3");
	    } else
		return ("  ÃÌÉÐ: 4");
	} else {
	    if (num == 5) {
		return ("  ÃÌÉÐ: 5");
	    } else if (num == 6) {
		return ("  ÃÌÉÐ: 6");
	    } else if (num == 7) {
		return ("  ÃÌÉÐ: 7");
	    } else if (num == 8) {
		return ("  ÃÌÉÐ: 8");
	    } else if (num == 9) {
		return ("  ÃÌÉÐ: 9");
	    }
	}
    } else if (num < 20) {
	if (num < 15) {
	    if (num == 10) {
		return ("  ÃÌÉÐ:10");
	    } else if (num == 11) {
		return ("  ÃÌÉÐ:11");
	    } else if (num == 12) {
		return ("  ÃÌÉÐ:12");
	    } else if (num == 13) {
		return ("  ÃÌÉÐ:13");
	    } else
		return ("  ÃÌÉÐ:14");
	} else if (num == 15) {
	    return ("  ÃÌÉÐ:15");
	} else if (num == 16) {
	    return ("  ÃÌÉÐ:16");
	} else if (num == 17) {
	    return ("  ÃÌÉÐ:17");
	} else if (num == 18) {
	    return ("  ÃÌÉÐ:18");
	} else if (num == 19) {
	    return ("  ÃÌÉÐ:19");
	}
    } else if (num < 30) {
	if (num < 25) {
	    if (num == 20) {
		return ("  ÃÌÉÐ:20");
	    } else if (num == 21) {
		return ("  ÃÌÉÐ:21");
	    } else if (num == 22) {
		return ("  ÃÌÉÐ:22");
	    } else if (num == 23) {
		return ("  ÃÌÉÐ:23");
	    } else
		return ("  ÃÌÉÐ:24");
	} else if (num == 25) {
	    return ("  ÃÌÉÐ:25");
	} else if (num == 26) {
	    return ("  ÃÌÉÐ:26");
	} else if (num == 27) {
	    return ("  ÃÌÉÐ:27");
	} else if (num == 28) {
	    return ("  ÃÌÉÐ:28");
	} else if (num == 29) {
	    return ("  ÃÌÉÐ:29");
	}
    } else {
	if (num < 40) {
	    if (num < 35) {
		if (num == 30) {
		    return ("  ÃÌÉÐ:30");
		} else {
		    if (num == 31) {
			return ("  ÃÌÉÐ:31");
		    } else {
			if (num == 32) {
			    return ("  ÃÌÉÐ:32");
			} else {
			    if (num == 33) {
				return ("  ÃÌÉÐ:33");
			    } else {
				return ("  ÃÌÉÐ:34");
			    }
			}
		    }
		}
	    } else {
		if (num == 35) {
		    return ("  ÃÌÉÐ:35");
		} else {
		    if (num == 36) {
			return ("  ÃÌÉÐ:36");
		    } else {
			if (num == 37) {
			    return ("  ÃÌÉÐ:37");
			} else {
			    if (num == 38) {
				return ("  ÃÌÉÐ:38");
			    } else {
				if (num == 39) {
				    return ("  ÃÌÉÐ:39");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 50) {
		if (num < 45) {
		    if (num == 40) {
			return ("  ÃÌÉÐ:40");
		    } else {
			if (num == 41) {
			    return ("  ÃÌÉÐ:41");
			} else {
			    if (num == 42) {
				return ("  ÃÌÉÐ:42");
			    } else {
				if (num == 43) {
				    return ("  ÃÌÉÐ:43");
				} else {
				    return ("  ÃÌÉÐ:44");
				}
			    }
			}
		    }
		} else {
		    if (num == 45) {
			return ("  ÃÌÉÐ:45");
		    } else {
			if (num == 46) {
			    return ("  ÃÌÉÐ:46");
			} else {
			    if (num == 47) {
				return ("  ÃÌÉÐ:47");
			    } else {
				if (num == 48) {
				    return ("  ÃÌÉÐ:48");
				} else {
				    if (num == 49) {
					return ("  ÃÌÉÐ:49");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 60) {
		    if (num < 55) {
			if (num == 50) {
			    return ("  ÃÌÉÐ:50");
			} else {
			    if (num == 51) {
				return ("  ÃÌÉÐ:51");
			    } else {
				if (num == 52) {
				    return ("  ÃÌÉÐ:52");
				} else {
				    if (num == 53) {
					return ("  ÃÌÉÐ:53");
				    } else {
					return ("  ÃÌÉÐ:54");
				    }
				}
			    }
			}
		    } else {
			if (num == 55) {
			    return ("  ÃÌÉÐ:55");
			} else {
			    if (num == 56) {
				return ("  ÃÌÉÐ:56");
			    } else {
				if (num == 57) {
				    return ("  ÃÌÉÐ:57");
				} else {
				    if (num == 58) {
					return ("  ÃÌÉÐ:58");
				    } else {
					if (num == 59) {
					    return ("  ÃÌÉÐ:59");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 70) {
			if (num < 65) {
			    if (num == 60) {
				return ("  ÃÌÉÐ:60");
			    } else {
				if (num == 61) {
				    return ("  ÃÌÉÐ:61");
				} else {
				    if (num == 62) {
					return ("  ÃÌÉÐ:62");
				    } else {
					if (num == 63) {
					    return ("  ÃÌÉÐ:63");
					} else {
					    return ("  ÃÌÉÐ:64");
					}
				    }
				}
			    }
			} else {
			    if (num == 65) {
				return ("  ÃÌÉÐ:65");
			    } else {
				if (num == 66) {
				    return ("  ÃÌÉÐ:66");
				} else {
				    if (num == 67) {
					return ("  ÃÌÉÐ:67");
				    } else {
					if (num == 68) {
					    return ("  ÃÌÉÐ:68");
					} else {
					    if (num == 69) {
						return ("  ÃÌÉÐ:69");
					    }
					}
				    }
				}
			    }
			}
		    } else {
			if (num < 80) {
			    if (num < 75) {
				if (num == 70) {
				    return ("  ÃÌÉÐ:70");
				} else {
				    if (num == 71) {
					return ("  ÃÌÉÐ:71");
				    } else {
					if (num == 72) {
					    return ("  ÃÌÉÐ:72");
					} else {
					    if (num == 73) {
						return ("  ÃÌÉÐ:73");
					    } else {
						return ("  ÃÌÉÐ:74");
					    }
					}
				    }
				}
			    } else {
				if (num == 75) {
				    return ("  ÃÌÉÐ:75");
				} else {
				    if (num == 76) {
					return ("  ÃÌÉÐ:76");
				    } else {
					if (num == 77) {
					    return ("  ÃÌÉÐ:77");
					} else {
					    if (num == 78) {
						return ("  ÃÌÉÐ:78");
					    } else {
						if (num == 79) {
						    return ("  ÃÌÉÐ:79");
						}
					    }
					}
				    }
				}
			    }
			} else {
			    if (num < 90) {
				if (num < 85) {
				    if (num == 80) {
					return ("  ÃÌÉÐ:80");
				    } else {
					if (num == 81) {
					    return ("  ÃÌÉÐ:81");
					} else {
					    if (num == 82) {
						return ("  ÃÌÉÐ:82");
					    } else {
						if (num == 83) {
						    return ("  ÃÌÉÐ:83");
						} else {
						    return ("  ÃÌÉÐ:84");
						}
					    }
					}
				    }
				} else {
				    if (num == 85) {
					return ("  ÃÌÉÐ:85");
				    } else {
					if (num == 86) {
					    return ("  ÃÌÉÐ:86");
					} else {
					    if (num == 87) {
						return ("  ÃÌÉÐ:87");
					    } else {
						if (num == 88) {
						    return ("  ÃÌÉÐ:88");
						} else {
						    if (num == 89) {
							return ("  ÃÌÉÐ:89");
						    }
						}
					    }
					}
				    }
				}
			    } else if (num < 100) {
				if (num < 95) {
				    if (num == 90) {
					return ("  ÃÌÉÐ:90");
				    } else if (num == 91) {
					return ("  ÃÌÉÐ:91");
				    } else if (num == 92) {
					return ("  ÃÌÉÐ:92");
				    } else if (num == 93) {
					return ("  ÃÌÉÐ:93");
				    } else
					return ("  ÃÌÉÐ:94");
				} else if (num == 95) {
				    return ("  ÃÌÉÐ:95");
				} else if (num == 96) {
				    return ("  ÃÌÉÐ:96");
				} else if (num == 97) {
				    return ("  ÃÌÉÐ:97");
				} else if (num == 98) {
				    return ("  ÃÌÉÐ:98");
				} else if (num == 99) {
				    return ("  ÃÌÉÐ:99");
				}
			    }
			}
		    }
		}
	    }
	}
    }
};

string (entity pl) DisguiseToString =
{
    if (pl.is_undercover == 0)
	return ("\n");
    if (pl.is_undercover == 2)
	return ("going undercover                       \n");
    if (invis_only)
	return ("undercover                             \n");

    if (pl.undercover_team == 1) {
	if (!pl.undercover_skin) {
	    return ("Blue                                   \n");
	} else if (pl.undercover_skin == 1) {
	    return ("Blue Scout                             \n");
	} else if (pl.undercover_skin == 2) {
	    return ("Blue Sniper                            \n");
	} else if (pl.undercover_skin == 3) {
	    return ("Blue Soldier                           \n");
	} else if (pl.undercover_skin == 4) {
	    return ("Blue Demoman                           \n");
	} else if (pl.undercover_skin == 5) {
	    return ("Blue Medic                             \n");
	} else if (pl.undercover_skin == 6) {
	    return ("Blue Hvy Wpns                          \n");
	} else if (pl.undercover_skin == 7) {
	    return ("Blue Pyro                              \n");
	} else if (pl.undercover_skin == 8) {
	    return ("Blue Spy                               \n");
	} else
	    return ("Blue Engineer                          \n");
    } else if (pl.undercover_team == 2) {
	if (!pl.undercover_skin) {
	    return ("Red                                    \n");
	} else if (pl.undercover_skin == 1) {
	    return ("Red Scout                              \n");
	} else if (pl.undercover_skin == 2) {
	    return ("Red Sniper                             \n");
	} else if (pl.undercover_skin == 3) {
	    return ("Red Soldier                            \n");
	} else if (pl.undercover_skin == 4) {
	    return ("Red Demoman                            \n");
	} else if (pl.undercover_skin == 5) {
	    return ("Red Medic                              \n");
	} else if (pl.undercover_skin == 6) {
	    return ("Red Hvy Wpns                           \n");
	} else if (pl.undercover_skin == 7) {
	    return ("Red Pyro                               \n");
	} else if (pl.undercover_skin == 8) {
	    return ("Red Spy                                \n");
	} else
	    return ("Red Engineer                           \n");
    } else if (pl.undercover_team == 3) {
	if (!pl.undercover_skin) {
	    return ("Yellow                                 \n");
	} else if (pl.undercover_skin == 1) {
	    return ("Yellow Scout                           \n");
	} else if (pl.undercover_skin == 2) {
	    return ("Yellow Sniper                          \n");
	} else if (pl.undercover_skin == 3) {
	    return ("Yellow Soldier                         \n");
	} else if (pl.undercover_skin == 4) {
	    return ("Yellow Demoman                         \n");
	} else if (pl.undercover_skin == 5) {
	    return ("Yellow Medic                           \n");
	} else if (pl.undercover_skin == 6) {
	    return ("Yellow Hvy Wpns                        \n");
	} else if (pl.undercover_skin == 7) {
	    return ("Yellow Pyro                            \n");
	} else if (pl.undercover_skin == 8) {
	    return ("Yellow Spy                             \n");
	} else
	    return ("Yellow Engineer                        \n");
    } else if (pl.undercover_team == 4) {
	if (!pl.undercover_skin) {
	    return ("Green                                  \n");
	} else if (pl.undercover_skin == 1) {
	    return ("Green Scout                            \n");
	} else if (pl.undercover_skin == 2) {
	    return ("Green Sniper                           \n");
	} else if (pl.undercover_skin == 3) {
	    return ("Green Soldier                          \n");
	} else if (pl.undercover_skin == 4) {
	    return ("Green Demoman                          \n");
	} else if (pl.undercover_skin == 5) {
	    return ("Green Medic                            \n");
	} else if (pl.undercover_skin == 6) {
	    return ("Green Hvy Wpns                         \n");
	} else if (pl.undercover_skin == 7) {
	    return ("Green Pyro                             \n");
	} else if (pl.undercover_skin == 8) {
	    return ("Green Spy                              \n");
	} else
	    return ("Green Engineer                         \n");
    } else {
	if (pl.undercover_skin == 1) {
	    return ("  Scout                                \n");
	} else if (pl.undercover_skin == 2) {
	    return ("  Sniper                               \n");
	} else if (pl.undercover_skin == 3) {
	    return ("  Soldier                              \n");
	} else if (pl.undercover_skin == 4) {
	    return ("  Demoman                              \n");
	} else if (pl.undercover_skin == 5) {
	    return ("  Medic                                \n");
	} else if (pl.undercover_skin == 6) {
	    return ("  Hvy Wpns                             \n");
	} else if (pl.undercover_skin == 7) {
	    return ("  Pyro                                 \n");
	} else if (pl.undercover_skin == 8) {
	    return ("  Spy                                  \n");
	} else
	    return ("  Engineer                             \n");
    }
};

string (entity pl) RangeToString =
{
    local entity te;
    local float num;

    te = find (world, netname, "scanner");
    while ((te != world) && (te.owner != pl))
	te = find (te, netname, "scanner");

    if (pl.ScannerOn != 1)
	return ("");
    else
	num = te.health;

    if (num <= 0)
	return ("");
    else if (num < 10) {
	if (num < 5) {
	    if (num == 0)
		return (" 0 M");
	    else if (num == 1)
		return (" 1 M");
	    else if (num == 2)
		return (" 2 M");
	    else if (num == 3)
		return (" 3 M");
	    else
		return (" 4 M");
	} else if (num == 5)
	    return (" 5 M");
	else if (num == 6)
	    return (" 6 M");
	else if (num == 7)
	    return (" 7 M");
	else if (num == 8)
	    return (" 8 M");
	else if (num == 9)
	    return (" 9 M");
    } else if (num < 20) {
	if (num < 15) {
	    if (num == 10) {
		return ("10 M");
	    } else if (num == 11) {
		return ("11 M");
	    } else if (num == 12) {
		return ("12 M");
	    } else if (num == 13) {
		return ("13 M");
	    } else return ("14 M");
	} else if (num == 15) {
	    return ("15 M");
	} else if (num == 16) {
	    return ("16 M");
	} else if (num == 17) {
	    return ("17 M");
	} else if (num == 18) {
	    return ("18 M");
	} else if (num == 19) {
	    return ("19 M");
	}
    } else if (num < 30) {
	if (num < 25) {
	    if (num == 20) {
		return ("20 M");
	    } else if (num == 21) {
		return ("21 M");
	    } else if (num == 22) {
		return ("22 M");
	    } else if (num == 23) {
		return ("23 M");
	    } else
		return ("24 M");
	} else if (num == 25) {
	    return ("25 M");
	} else if (num == 26) {
	    return ("26 M");
	} else if (num == 27) {
	    return ("27 M");
	} else if (num == 28) {
	    return ("28 M");
	} else if (num == 29) {
	    return ("29 M");
	}
    } else if (num < 40) {
	if (num < 35) {
	    if (num == 30) {
		return ("30 M");
	    } else if (num == 31) {
		return ("31 M");
	    } else if (num == 32) {
		return ("32 M");
	    } else if (num == 33) {
		return ("33 M");
	    } else
		return ("34 M");
	} else if (num == 35) {
	    return ("35 M");
	} else if (num == 36) {
	    return ("36 M");
	} else if (num == 37) {
	    return ("37 M");
	} else if (num == 38) {
	    return ("38 M");
	} else if (num == 39) {
	    return ("39 M");
	}
    } else if (num < 50) {
	if (num < 45) {
	    if (num == 40) {
		return ("40 M");
	    } else if (num == 41) {
		return ("41 M");
	    } else if (num == 42) {
		return ("42 M");
	    } else if (num == 43) {
		return ("43 M");
	    } else
		return ("44 M");
	} else if (num == 45) {
	    return ("45 M");
	} else if (num == 46) {
	    return ("46 M");
	} else if (num == 47) {
	    return ("47 M");
	} else if (num == 48) {
	    return ("48 M");
	} else if (num == 49) {
	    return ("49 M");
	}
    } else if (num < 60) {
	if (num < 55) {
	    if (num == 50) {
		return ("50 M");
	    } else {
		if (num == 51) {
		    return ("51 M");
		} else {
		    if (num == 52) {
			return ("52 M");
		    } else {
			if (num == 53) {
			    return ("53 M");
			} else {
			    return ("54 M");
			}
		    }
		}
	    }
	} else {
	    if (num == 55) {
		return ("55 M");
	    } else {
		if (num == 56) {
		    return ("56 M");
		} else {
		    if (num == 57) {
			return ("57 M");
		    } else {
			if (num == 58) {
			    return ("58 M");
			} else {
			    if (num == 59) {
				return ("59 M");
			    }
			}
		    }
		}
	    }
	}
    } else {
	if (num < 70) {
	    if (num < 65) {
		if (num == 60) {
		    return ("60 M");
		} else {
		    if (num == 61) {
			return ("61 M");
		    } else {
			if (num == 62) {
			    return ("62 M");
			} else {
			    if (num == 63) {
				return ("63 M");
			    } else {
				return ("64 M");
			    }
			}
		    }
		}
	    } else {
		if (num == 65) {
		    return ("65 M");
		} else {
		    if (num == 66) {
			return ("66 M");
		    } else {
			if (num == 67) {
			    return ("67 M");
			} else {
			    if (num == 68) {
				return ("68 M");
			    } else {
				if (num == 69) {
				    return ("69 M");
				}
			    }
			}
		    }
		}
	    }
	} else {
	    if (num < 80) {
		if (num < 75) {
		    if (num == 70) {
			return ("70 M");
		    } else {
			if (num == 71) {
			    return ("71 M");
			} else {
			    if (num == 72) {
				return ("72 M");
			    } else {
				if (num == 73) {
				    return ("73 M");
				} else {
				    return ("74 M");
				}
			    }
			}
		    }
		} else {
		    if (num == 75) {
			return ("75 M");
		    } else {
			if (num == 76) {
			    return ("76 M");
			} else {
			    if (num == 77) {
				return ("77 M");
			    } else {
				if (num == 78) {
				    return ("78 M");
				} else {
				    if (num == 79) {
					return ("79 M");
				    }
				}
			    }
			}
		    }
		}
	    } else {
		if (num < 90) {
		    if (num < 85) {
			if (num == 80) {
			    return ("80 M");
			} else {
			    if (num == 81) {
				return ("81 M");
			    } else {
				if (num == 82) {
				    return ("82 M");
				} else {
				    if (num == 83) {
					return ("83 M");
				    } else {
					return ("84 M");
				    }
				}
			    }
			}
		    } else {
			if (num == 85) {
			    return ("85 M");
			} else {
			    if (num == 86) {
				return ("86 M");
			    } else {
				if (num == 87) {
				    return ("87 M");
				} else {
				    if (num == 88) {
					return ("88 M");
				    } else {
					if (num == 89) {
					    return ("89 M");
					}
				    }
				}
			    }
			}
		    }
		} else {
		    if (num < 100) {
			if (num < 95) {
			    if (num == 90) {
				return ("90 M");
			    } else {
				if (num == 91) {
				    return ("91 M");
				} else {
				    if (num == 92) {
					return ("92 M");
				    } else {
					if (num == 93) {
					    return ("93 M");
					} else {
					    return ("94 M");
					}
				    }
				}
			    }
			} else {
			    if (num == 95) {
				return ("95 M");
			    } else {
				if (num == 96) {
				    return ("96 M");
				} else {
				    if (num == 97) {
					return ("97 M");
				    } else {
					if (num == 98) {
					    return ("98 M");
					} else {
					    if (num == 99) {
						return ("99 M");
					    }
					}
				    }
				}
			    }
			}
		    } else if (num >= 100)
			return ("100+ M");
		}
	    }
	}
    }
};

string (entity pl) ScannerToString =
{
    local entity te;

    te = find (world, netname, "scanner");
    while ((te != world) && (te.owner != pl))
	te = find (te, netname, "scanner");

    if (pl.ScannerOn != 1)
	return ("Scanner off");

    if (te.health > 0) {
	if (te.team_no == 1) {
	    if (!te.playerclass) {
		return ("Blue               Range: ");
	    } else if (te.playerclass == 1) {
		return ("Blue Scout         Range: ");
	    } else if (te.playerclass == 2) {
		return ("Blue Sniper        Range: ");
	    } else if (te.playerclass == 3) {
		return ("Blue Soldier       Range: ");
	    } else if (te.playerclass == 4) {
		return ("Blue Demoman       Range: ");
	    } else if (te.playerclass == 5) {
		return ("Blue Medic         Range: ");
	    } else if (te.playerclass == 6) {
		return ("Blue Hvy Wpns      Range: ");
	    } else if (te.playerclass == 7) {
		return ("Blue Pyro          Range: ");
	    } else if (te.playerclass == 8) {
		return ("Blue Spy           Range: ");
	    } else if (te.playerclass == 9) {
		return ("Blue Engineer      Range: ");
	    } else if (te.playerclass == 11) {
		return ("Blue Civilian      Range: ");
	    } else if (te.playerclass == 13) {
		return ("Blue Sentry Gun    Range: ");
	    } else if (te.playerclass == 14) {
		return ("Blue Goal Item     Range: ");
	    } else {
		return ("                          ");
	    }
	} else if (te.team_no == 2) {
	    if (!te.playerclass) {
		return ("Red                Range: ");
	    } else if (te.playerclass == 1) {
		return ("Red Scout          Range: ");
	    } else if (te.playerclass == 2) {
		return ("Red Sniper         Range: ");
	    } else if (te.playerclass == 3) {
		return ("Red Soldier        Range: ");
	    } else if (te.playerclass == 4) {
		return ("Red Demoman        Range: ");
	    } else if (te.playerclass == 5) {
		return ("Red Medic          Range: ");
	    } else if (te.playerclass == 6) {
		return ("Red Hvy Wpns       Range: ");
	    } else if (te.playerclass == 7) {
		return ("Red Pyro           Range: ");
	    } else if (te.playerclass == 8) {
		return ("Red Spy            Range: ");
	    } else if (te.playerclass == 9) {
		return ("Red Engineer       Range: ");
	    } else if (te.playerclass == 11) {
		return ("Red Civilian       Range: ");
	    } else if (te.playerclass == 13) {
		return ("Red Sentry Gun     Range: ");
	    } else if (te.playerclass == 14) {
		return ("Red Goal Item      Range: ");
	    } else {
		return ("                          ");
	    }
	} else if (te.team_no == 3) {
	    if (!te.playerclass) {
		return ("Yellow             Range: ");
	    } else if (te.playerclass == 1) {
		return ("Yellow Scout       Range: ");
	    } else if (te.playerclass == 2) {
		return ("Yellow Sniper      Range: ");
	    } else if (te.playerclass == 3) {
		return ("Yellow Soldier     Range: ");
	    } else if (te.playerclass == 4) {
		return ("Yellow Demoman     Range: ");
	    } else if (te.playerclass == 5) {
		return ("Yellow Medic       Range: ");
	    } else if (te.playerclass == 6) {
		return ("Yellow Hvy Wpns    Range: ");
	    } else if (te.playerclass == 7) {
		return ("Yellow Pyro        Range: ");
	    } else if (te.playerclass == 8) {
		return ("Yellow Spy         Range: ");
	    } else if (te.playerclass == 9) {
		return ("Yellow Engineer    Range: ");
	    } else if (te.playerclass == 11) {
		return ("Yellow Civilian    Range: ");
	    } else if (te.playerclass == 13) {
		return ("Yellow Sentry Gun  Range: ");
	    } else if (te.playerclass == 14) {
		return ("Yellow Goal Item   Range: ");
	    } else {
		return ("                          ");
	    }
	} else if (te.team_no == 4) {
	    if (!te.playerclass) {
		return ("Green              Range: ");
	    } else if (te.playerclass == 1) {
		return ("Green Scout        Range: ");
	    } else if (te.playerclass == 2) {
		return ("Green Sniper       Range: ");
	    } else if (te.playerclass == 3) {
		return ("Green Soldier      Range: ");
	    } else if (te.playerclass == 4) {
		return ("Green Demoman      Range: ");
	    } else if (te.playerclass == 5) {
		return ("Green Medic        Range: ");
	    } else if (te.playerclass == 6) {
		return ("Green Hvy Wpns     Range: ");
	    } else if (te.playerclass == 7) {
		return ("Green Pyro         Range: ");
	    } else if (te.playerclass == 8) {
		return ("Green Spy          Range: ");
	    } else if (te.playerclass == 9) {
		return ("Blue Engineer      Range: ");
	    } else if (te.playerclass == 11) {
		return ("Green Civilian     Range: ");
	    } else if (te.playerclass == 13) {
		return ("Green Sentry Gun   Range: ");
	    } else if (te.playerclass == 14) {
		return ("Green Goal Item    Range: ");
	    } else {
		return ("                          ");
	    }
	} else if (te.playerclass == 1) {
	    return ("  Scout            Range: ");
	} else if (te.playerclass == 2) {
	    return ("  Sniper           Range: ");
	} else if (te.playerclass == 3) {
	    return ("  Soldier          Range: ");
	} else if (te.playerclass == 4) {
	    return ("  Demoman          Range: ");
	} else if (te.playerclass == 5) {
	    return ("  Medic            Range: ");
	} else if (te.playerclass == 6) {
	    return ("  Hvy Wpns         Range: ");
	} else if (te.playerclass == 7) {
	    return ("  Pyro             Range: ");
	} else if (te.playerclass == 8) {
	    return ("  Spy              Range: ");
	} else if (te.playerclass == 9) {
	    return ("  Engineer         Range: ");
	} else if (te.playerclass == 11) {
	    return ("  Civilian         Range: ");
	} else if (te.playerclass == 13) {
	    return ("  Sentry Gun       Range: ");
	} else if (te.playerclass == 14) {
	    return ("  Goal Item        Range: ");
	} else {
	    return ("                          ");
	}
    } else
	return ("  No Blips.            ");
};

string (entity pl) SentryDetailsToString =
{
    local entity te;

    te = find (world, classname, "building_sentrygun");
    while (te) {
	if (te.real_owner == self) {
	    if (te.ammo_shells == 0) {
		if ((te.ammo_rockets == 0) && (te.weapon == 3))
		    return (" no ammo                   \n");
		else
		    return (" no shells                 \n");
	    } else if ((te.ammo_rockets == 0) && (te.weapon == 3))
		return (" no rockets                \n");
	    else
		return ("                           \n");
	}
	te = find (te, classname, "building_sentrygun");
    }
    return ("                           \n");
};

string (entity pl) SentryHealthToString =
{
    local entity te;
    local float num;

    te = find (world, classname, "building_sentrygun");
    while (te) {
	if (te.real_owner == self) {
	    num = te.health;
	    if (num < 100) {
		if (num < 50) {
		    if (num <= 0)
			return ("SENTRY:   0");
		    else if (num < 10)
			return ("SENTRY:   1");
		    else if (num < 20)
                        return ("SENTRY:  10");
		    else if (num < 30)
			return ("SENTRY:  20");
		    else if (num < 40)
			return ("SENTRY:  30");
		    else
			return ("SENTRY:  40");
		} else if (num < 60)
		    return ("SENTRY:  50");
		else if (num < 70)
		    return ("SENTRY:  60");
		else if (num < 80)
		    return ("SENTRY:  70");
		else if (num < 90)
		    return ("SENTRY:  80");
		else
		    return ("SENTRY:  90");
	    } else if (num < 200) {
		if (num < 150) {
		    if (num < 110)
			return ("SENTRY: 100");
		    else if (num < 120)
                        return ("SENTRY: 110");
		    else if (num < 130)
			return ("SENTRY: 120");
		    else if (num < 140)
			return ("SENTRY: 130");
		    else
			return ("SENTRY: 140");
		} else if (num < 160)
		    return ("SENTRY: 150");
		else if (num < 170)
		    return ("SENTRY: 160");
		else if (num < 180)
		    return ("SENTRY: 170");
		else if (num < 190)
		    return ("SENTRY: 180");
		else
		    return ("SENTRY: 190");
            } else if (num < 300) {
		if (num < 250) {
		    if (num < 210)
                        return ("SENTRY: 200");
		    else if (num < 220)
			return ("SENTRY: 210");
		    else if (num < 230)
			return ("SENTRY: 220");
		    else if (num < 240)
			return ("SENTRY: 230");
		    else 
			return ("SENTRY: 240");
		} else if (num < 260)
		    return ("SENTRY: 250");
		else if (num < 270)
		    return ("SENTRY: 260");
		else if (num < 280)
		    return ("SENTRY: 270");
		else if (num < 290)
		    return ("SENTRY: 280");
		else
		    return ("SENTRY: 290");
	    } else if (num < 400) {
		if (num < 350) {
		    if (num < 310)
			return ("SENTRY: 300");
		    else if (num < 320)
			return ("SENTRY: 310");
		    else if (num < 330)
			return ("SENTRY: 320");
		    else if (num < 340)
			return ("SENTRY: 330");
		    else
			return ("SENTRY: 340");
		} else if (num < 360)
		    return ("SENTRY: 350");
		else if (num < 370)
		    return ("SENTRY: 360");
		else if (num < 380)
		    return ("SENTRY: 370");
		else if (num < 390)
		    return ("SENTRY: 380");
		else
		    return ("SENTRY: 390");
	    } else if (num < 500) {
		if (num < 450) {
		    if (num < 410)
			return ("SENTRY: 400");
		    else if (num < 420)
			return ("SENTRY: 410");
		    else if (num < 430)
			return ("SENTRY: 420");
		    else if (num < 440)
			return ("SENTRY: 430");
		    else
			return ("SENTRY: 440");
		} else if (num < 460)
		    return ("SENTRY: 450");
		else if (num < 470)
		    return ("SENTRY: 460");
		else if (num < 480)
		    return ("SENTRY: 470");
		else if (num < 490)
		    return ("SENTRY: 480");
		else
		    return ("SENTRY: 490");
	    } else if (num < 600) {
		if (num < 550) {
		    if (num < 510) {
			return ("SENTRY: 500");
		    } else if (num < 520) {
			return ("SENTRY: 510");
		    } else if (num < 530) {
			return ("SENTRY: 520");
		    } else if (num < 540) {
			return ("SENTRY: 530");
		    } else {
			return ("SENTRY: 540");
		    }
		} else if (num < 560) {
		    return ("SENTRY: 550");
		} else if (num < 570) {
		    return ("SENTRY: 560");
		} else if (num < 580) {
		    return ("SENTRY: 570");
		} else if (num < 590) {
		    return ("SENTRY: 580");
		} else {
		    return ("SENTRY: 590");
		}
	    } else if (num < 700) {
		if (num < 650) {
		    if (num < 610) {
			return ("SENTRY: 600");
		    } else if (num < 620) {
			return ("SENTRY: 610");
		    } else if (num < 630) {
			return ("SENTRY: 620");
		    } else if (num < 640) {
			return ("SENTRY: 630");
		    } else {
			return ("SENTRY: 640");
		    }
		} else if (num < 660) {
		    return ("SENTRY: 650");
		} else if (num < 670) {
		    return ("SENTRY: 660");
		} else if (num < 680) {
		    return ("SENTRY: 670");
		} else if (num < 690) {
		    return ("SENTRY: 680");
		} else {
		    return ("SENTRY: 690");
		}
	    } else if (num < 800) {
		if (num < 750) {
		    if (num < 710) {
			return ("SENTRY: 700");
		    } else if (num < 720) {
			return ("SENTRY: 710");
		    } else if (num < 730) {
			return ("SENTRY: 720");
		    } else if (num < 740) {
			return ("SENTRY: 730");
		    } else {
			return ("SENTRY: 740");
		    }
		} else if (num < 760) {
		    return ("SENTRY: 750");
		} else if (num < 770) {
		    return ("SENTRY: 760");
		} else if (num < 780) {
		    return ("SENTRY: 770");
		} else if (num < 790) {
		    return ("SENTRY: 780");
		} else {
		    return ("SENTRY: 790");
		}
	    } else if (num < 900) {
		if (num < 850) {
		    if (num < 810) {
			return ("SENTRY: 800");
		    } else if (num < 820) {
			return ("SENTRY: 810");
		    } else if (num < 830) {
			return ("SENTRY: 820");
		    } else if (num < 840) {
			return ("SENTRY: 830");
		    } else {
			return ("SENTRY: 840");
		    }
		} else if (num < 860) {
		    return ("SENTRY: 850");
		} else if (num < 870) {
		    return ("SENTRY: 860");
		} else if (num < 880) {
		    return ("SENTRY: 870");
		} else if (num < 890) {
		    return ("SENTRY: 880");
		} else {
		    return ("SENTRY: 890");
		}
	    } else if (num < 1000) {
		if (num < 950) {
		    if (num < 910)
			return ("SENTRY: 900");
		    else if (num < 920)
			return ("SENTRY: 910");
		    else if (num < 930)
			return ("SENTRY: 920");
		    else if (num < 940)
			return ("SENTRY: 930");
		    else
			return ("SENTRY: 940");
		} else if (num < 960)
		    return ("SENTRY: 950");
		else if (num < 970)
		    return ("SENTRY: 960");
		else if (num < 980)
		    return ("SENTRY: 970");
		else if (num < 990)
		    return ("SENTRY: 980");
		else
		    return ("SENTRY: 990");
	    }
	}
	te = find (te, classname, "building_sentrygun");
    }
    return ("SENTRY: 0 health");
};
