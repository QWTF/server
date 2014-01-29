entity self;
entity other;
entity world;
float time;
float frametime;
entity newmis;
float force_retouch;
string mapname /* = "" */;
float serverflags;
float total_secrets;
float total_monsters;
float found_secrets;
float killed_monsters;
float parm1;
float parm2;
float parm3;
float parm4;
float parm5;
float parm6;
float parm7;
float parm8;
float parm9;
float parm10;
float parm11;
float parm12;
float parm13;
float parm14;
float parm15;
float parm16;
vector v_forward /* = '0.000 0.000 0.000' */;
vector v_up /* = '0.000 0.000 0.000' */;
vector v_right /* = '0.000 0.000 0.000' */;
float trace_allsolid;
float trace_startsolid;
float trace_fraction;
vector trace_endpos /* = '0.000 0.000 0.000' */;
vector trace_plane_normal /* = '0.000 0.000 0.000' */;
float trace_plane_dist;
entity trace_ent;
float trace_inopen;
float trace_inwater;
entity msg_entity;

void () main;

void () StartFrame;

void () PlayerPreThink;

void () PlayerPostThink;

void () ClientKill;

void () ClientConnect;

void () PutClientInServer;

void () ClientDisconnect;

void () SetNewParms;

void () SetChangeParms;
void end_sys_globals;
.float modelindex;
.vector absmin;
.vector absmax;
.float ltime;
.float lastruntime;
.float movetype;
.float solid;
.vector origin;
.vector oldorigin;
.vector velocity;
.vector angles;
.vector avelocity;
.string classname;
.string model;
.float frame;
.float skin;
.float effects;
.vector mins;
.vector maxs;
.vector size;
.void() touch;
.void() use;
.void() think;
.void() blocked;
.float nextthink;
.entity groundentity;
.float health;
.float frags;
.float weapon;
.string weaponmodel;
.float weaponframe;
.float currentammo;
.float ammo_shells;
.float ammo_nails;
.float ammo_rockets;
.float ammo_cells;
.float items;
.float takedamage;
.entity chain;
.float deadflag;
.vector view_ofs;
.float button0;
.float button1;
.float button2;
.float impulse;
.float fixangle;
.vector v_angle;
.string netname;
.entity enemy;
.float flags;
.float colormap;
.float team;
.float max_health;
.float teleport_time;
.float armortype;
.float armorvalue;
.float waterlevel;
.float watertype;
.float ideal_yaw;
.float yaw_speed;
.entity aiment;
.entity goalentity;
.float spawnflags;
.string target;
.string targetname;
.float dmg_take;
.float dmg_save;
.entity dmg_inflictor;
.entity owner;
.vector movedir;
.string message;
.float sounds;
.string noise;
.string noise1;
.string noise2;
.string noise3;
void end_sys_fields;



string string_null;
vector vector_null;
//float empty_float;
entity activator;
entity damage_attacker;
float framecount;
float skill;
float teamplay;
float timelimit;
float fraglimit;
float deathmatch;
//float bspversion;
.string wad;
.string map;
.float worldtype;
.string killtarget;
.float light_lev;
.float style;
.void() th_stand;
.void() th_walk;
.void() th_run;
.void() th_missile;
.void() th_melee;
.void(entity attacker, float damage) th_pain;
.void() th_die;
.entity oldenemy;
.float speed;
.float lefty;
.float search_time;
.float attack_state;
.float walkframe;
.float voided;
.float maxspeed;
.float gravity;
.float attack_finished;
.float pain_finished;
.float invincible_finished;
.float invisible_finished;
.float super_damage_finished;
.float radsuit_finished;
.float invincible_time;
.float invincible_sound;
.float invisible_time;
.float invisible_sound;
.float super_time;
.float super_sound;
.float rad_time;
.float fly_sound;
.float axhitme;
.float show_hostile;
.float jump_flag;
.float swim_flag;
.float air_finished;
.float bubble_count;
.string deathtype;
.string mdl;
.vector mangle;
.float t_length;
.float t_width;
//.vector dest;
.vector dest1;
.vector dest2;
.float wait;
.float delay;
.entity trigger_field;
.string noise4;
.float pausetime;
.entity movetarget;
.float aflag;
.float dmg;
.float cnt;
.float cnt2;
.void() think1;
.vector finaldest;
.vector finalangle;
.float count;
.float lip;
.float state;
.vector pos1;
.vector pos2;
.float height;
.float oldheight;
.float waitmin;
.float waitmax;
.float distance;
.float volume;
//.float flash_flag; // On/off for the flashlight
//.entity flash;   // flash entity
//.float crouch;

void (vector ang) makevectors = #1;
void (entity e, vector o) setorigin = #2;
void (entity e, string m) setmodel = #3;
void (entity e, vector min, vector max) setsize = #4;
void () break = #6;
float () random = #7;
void (entity e, float chan, string samp, float vol, float atten) sound = #8;
vector (vector v) normalize = #9;
void (string e) error = #10;
void (string e) objerror = #11;
float (vector v) vlen = #12;
float (vector v) vectoyaw = #13;
entity () spawn = #14;
void (entity e) remove = #15;
void (vector v1, vector v2, float nomonsters, entity forent) traceline = #16;
entity () checkclient = #17;
entity (entity start, .string fld, string match) find = #18;
string (string s) precache_sound = #19;
string (string s) precache_model = #20;
void (entity client, string s) stuffcmd = #21;
entity (vector org, float rad) findradius = #22;

void(float level, string s) bprint		= #23;
void(entity client, float level, string s) sprint 		= #24;

void(float level, string s, string s2) bprint2		= #23;
void(entity client, float level, string s, string s2) sprint2 		= #24;

void(float level, string s, string s2, string s3) bprint3		= #23;
void(entity client, float level, string s, string s2, string s3) sprint3 	= #24;

void(float level, string s, string s2, string s3, string s4) bprint4		= #23;
void(entity client, float level, string s, string s2, string s3, string s4) sprint4 		= #24;

void(float level, string s, string s2, string s3, string s4, string s5) bprint5		= #23;
void(entity client, float level, string s, string s2, string s3, string s4, string s5) sprint5 		= #24;

void(float level, string s, string s2, string s3, string s4, string s5, string s6) bprint6		= #23;
void(entity client, float level, string s, string s2, string s3, string s4, string s5, string s6) sprint6 		= #24;

void(float level, string s, string s2, string s3, string s4, string s5, string s6, string s7) bprint7		= #23;
void(entity client, float level, string s, string s2, string s3, string s4, string s5, string s6, string s7) sprint7 		= #24;

void(float level, string s, string s2, string s3, string s4, string s5, string s6, string s7, string s8) bprint8		= #23;

void (string s) dprint = #25;
string (float f) ftos = #26;
string (vector v) vtos = #27;
void () coredump = #28;
void () traceon = #29;
void () traceoff = #30;
void (entity e) eprint = #31;
float (float yaw, float dist) walkmove = #32;
float() droptofloor= #34;
void (float style, string value) lightstyle = #35;
float (float v) rint = #36;
float (float v) floor = #37;
float (float v) ceil = #38;
float (entity e) checkbottom = #40;
float (vector v) pointcontents = #41;
float (float f) fabs = #43;
vector (entity e, float speed) aim = #44;
float (string s) cvar = #45;
void (string s) localcmd = #46;
entity (entity e) nextent = #47;
void (vector o, vector d, float color, float count) particle = #48;
void () ChangeYaw = #49;
vector (vector v) vectoangles = #51;
void (float to, float f) WriteByte = #52;
void (float to, float f) WriteChar = #53;
void (float to, float f) WriteShort = #54;
void (float to, float f) WriteLong = #55;
void (float to, float f) WriteCoord = #56;
void (float to, float f) WriteAngle = #57;
void (float to, string s) WriteString = #58;
void (float to, entity s) WriteEntity = #59;

//merc added functions
float(float f) sin = #60;
float(float f) cos = #61;
float(float f) sqrt = #62; 
float(float val1, float val2) min = #63;
float(float val1, float val2) max = #64;
//end

void (float step) movetogoal = #67;
string (string s) precache_file = #68;
void (entity e) makestatic = #69;
void (string s) changelevel = #70;
void (string var, string val) cvar_set = #72;

void(entity client, string s) centerprint = #73
void(entity client, string s, string s2) centerprint2 = #73
void(entity client, string s, string s2, string s3) centerprint3 = #73
void(entity client, string s, string s2, string s3, string s4) centerprint4 = #73
void(entity client, string s, string s2, string s3, string s4, string s5) centerprint5 = #73
void(entity client, string s, string s2, string s3, string s4, string s5, string s6) centerprint6 = #73;
void(entity client, string s, string s2, string s3, string s4, string s5, string s6, string s7) centerprint7 = #73;

void (vector pos, string samp, float vol, float atten) ambientsound = #74;
string (string s) precache_model2 = #75;
string (string s) precache_sound2 = #76;
string (string s) precache_file2 = #77;
void (entity e) setspawnparms = #78;
void (entity killer, entity killee) logfrag = #79;
string (entity e, string key) infokey = #80;
float (string s) stof = #81;
void (vector where, float set) multicast = #82;

//mvdsv added functions

//void() executecmd = #83;  // executes buffered text on the server console
void(string str) tokanize = #84; // tokanize text
float() argc = #85; // returns number of tokens
string(float num) argv = #86; // returns token for the given number

//string (.string field) teamfield = #87; 
string (string str, float start, float len) substr = #88;
string (string str1, string str2) strcat = #89;
float (string str) strlen = #90;
float (string str) str2byte = #91;
float (string str) str2short = #92;
string (string str , float size) newstr = #93;
void (string str) freestr = #94;

//void(string str) conprint = #95;   // prints to server console only (no redirects)
string (string str) readcmd = #96; // executes command on server, but result is returned by this function instead of writing to the console
//void(string dst, string src) strcpy = #97;   // copies src to dst
string(string str, string substr) strstr = #98;	// searches for substring in str, returns pointer to it or "" if not found
//void(string dst, string src, float n) strncpy = #99;	// copies max n chars to dst
void(string logname, float console, string text) logname = #100; // prints text to file 'logname', if console is non-zero, prints to the server console as well
void(entity cl, string text) redirectcmd = #101;	// executes string on the console and redirects output to client (eg redirect(self, "status"))
void() calltimeofday = #102;		// force server to call mod function timeofday
float (string s) findmap = #104;
float(entity client, float level, float range, float start, float style, float footer) listmaps = #105; 
string(float id) findmapname = #106;
// fte additions 
//void ext_ShowPicEnt(string slotname, string picname, float x, float y, float zone, entity ent) = #108;
//void ext_HidePicEnt(string slotname, entity ent) = #109;