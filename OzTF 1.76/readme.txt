This is OzTF 1.76 which was released on the quakeworld.nu forums (you can google the link).



The following below is taken from http://www.nisda.net/oztf.php
The website is all that's left of OzTF, and is outdated (latest mention is of 1.45).
-------------------------------------------------------------------------------------



OZTF - That QuakeWorld Mod by Mercury
As the OZTF site is down (http://ap.qgl.org/mercury/), here is a mirror of a lot of the content. The content of this page was written by Mercury.
About

What is Oz Team Fortress (OZTF)?
Oz Team Fortress is a modification made for Quake World by Mercury (myself).

I decided to ask Robin Walker if I could create my own mod using Team Fortress source code. He willingly gave me permission to use the Team Fortress 2.9 source code, under the condition that, "Team Fortress Software is not directly related or Liable, with anything to do with Oz Team Fortress." This means they are separate modifications and are not related in anyway but source code. Please do not in anyway contact Team Fortress Software with any problems or bug reports you have on Oz Team Fortress.

To download Team Fortress visit the Official Team Fortress Web Site

Then I contacted rXr creator of Kombat Teams Pro, who provided me with Kombat Teams 2.1 created by Kombat Teams Software. Omicron with a great coding knowledge created a modified version of Team Fortress called OmiTF, for the Russian TF community. This source was also important in the development in Oztf.

After acquiring a number of different sources with the permission of the Software developers I began working on Oz Team Fortress.

The original idea of Team Fortress was based on Capture the Flag concept. Capture the Flag (CTF) is when mainly two teams try to steal an enemy flag within an area defended by the enemy, such as the enemy base and capture it within the local team's area or base.

With this idea in mind Team Fortress software developed a mod for Quake that uses the idea of Capture the Flag, and adds different types of player classes. The idea is to have the best teamwork and class combination to beat the other team in capturing the flag or any other goal that scores points depending on the map. The fact that Team Fortress has the ability to create many different goal entities make the game-play much more universal. It is much more then just a CTF mod.
Download

    tfbeta.rar Size: 308KB - Oztf 1.76 beta
    Oztf145.zip Size: 1.11MB - This will update Team Fortress 2.8 to Oztf 1.45
    Qwprogs.zip Size: 265KB - This will update the progs from any version of TF. (requires dot sprites, flag model.)
    Oztf122.zip Size: 1.11MB - This will update Team Fortress 2.8 to Oztf 1.22
    Oztf121.zip Size: 1.11MB - This will update Team Fortress 2.8 to Oztf 1.21
    Oztf115.zip Size: 1.07MB - This zip will update Team Fortress 2.8 to Oztf 1.15
    Oztf-sounds.zip Size: 814KB - Sounds required in Oztf 1.13
    Dots.zip Size: 0.77KB - Sniper dot sprites required in Oztf
    Flag.zip Size: 8.66KB - Flag model required in Oztf (for CTF flags)
    Tfstrike-sounds.zip Size: 60KB - Sounds required for TfStrike mode.
    DustFinal.zip Size: 621KB - Dust map for TfStrike mode.
    Oztf113.zip Size: 1.06MB - This zip will update Team Fortress 2.8 to Oztf 1.13
    Oztf106.zip Size: 374KB - This zip will update Team Fortress 2.8 to Oztf 1.06
    Oztf105.zip Size: 374KB - This zip will update Team Fortress 2.8 to Oztf 1.05
    Oztf104.zip Size: 342KB - This zip will update Team Fortress 2.8 to Oztf 1.04 

Documentation
Version 1.45 Released 1/ 07 / 2003

Updates:
Added mvdsv function support, including many features like autorecording.
Added Half life map entities (rotating doors under development).

Additions:
mvd-server commands added, see mvdsv-features.txt
mvd-user commands added, see mvd-cmdfeatures.txt

frjump command to toggle forward rocket jump
Observer menu choice, impulse 6 to observe.
New third person camera angle!
Updated flag cam (will follow player who picks up the flag)

Added support for TFC maps and CS maps. de_maps will add
bomb support. cs_maps allow for hostage support.
It also contains many addition entities like func_breakables etc.

Showstats command added, shows your individual stats including damage.

Localinfos Added:
Localinfo votespercentage added to allow the ability to set the minimum or maximum percentage of votes, to enable someone to gain admin status.
Localinfo demo_auto_left added to set the number of matches you wish to autorecord.

Fixes:
-message printing for all admin commands
-hwguy concussion affect reduced (three times less)
-practice mode updated, flags, resupply's and cap points work
-showfrag print positioning
-cams
-changeteams bug
-current_menu during round_over
-autoteam fix, balance.
-sbar in rounds, prints time to all clients not just players
-reload time, reloading dependant on recoil time like tf2.9
-cs entities - bombsite
-tfc entities
-fixed hwguy water bug
-light dimm match start
-soccer goals working correctly (requires new map)
-lots of other stuff, I cannot remember all
Version 1.21 Released 21/ 03 / 2003

Practice Mode:
New mode added where the player has unlimited ammo, health, grenades, and will not require reloading.

CTF Flag Support:
CTF Flags have been added which includes flag meshing to player model upon grabbing a flag.
Requires flag.mdl

Sentry Gun Updated:
Team Fortress 2.9 Sentries are now the default sentry gun. You can change this using the sgtype command.

Votetime localinfo:
This will disable any players from using the break command with a time specifed. Break and Elec tcommands has also added proctection to prevent spamming.

New Setinfo Key added:
There is a new setinfo key added called "tfk" which intelligently allows you to enable 4 options at once. The reason this was added is to lower the setinfo strings which can cause some problems for many clients. This setinfo will only work on connect, and will not affect any current setinfo setting. The options are:

1 = Class help off
2 = Exec Class script
4 = Exec Map script
8 = Sbar on

To enable more then 1 option, simply add the numbers together. I.e. if you want to enable both class help off, and exec map script, you would set 1 (ch) + 2 (ec) = 3 therefore "setinfo tfk 3".

New Alias Commands:
SHOWFPS - this will show the fps, and current timing speed of all players in the server
SHOWFRAGS - (previously fraglist) will print a list of statistics

New Admin commands:
PRACTICE - this will toggle practice modem, requires map restart.
SGTYPE - toggles tfstrike mode
FLAG_MODEL - this will toggle the flag model between map default, tf flag, tf standard and the new CTF flags.

Localinfos added:
FLAG_SOLID - (on/off) this will make the tf_goal entitiy solid despite what the map setting is.
FLAG_DROP - (on/off) this will allow all tf_goal entities to be droped using the dropitems command. Old keys there could not be dropped in TF2.9 can be dropped in this version.
FLAG_MODEL (0/1/2/3) sets flag model to tf_goals. 0 = map default, 1 = tf flag, 2 = tf standard, 3 = Ctf flag.
PRACTICE - (on/off) will toggle practice mode, requires map restart.
SENTRYTYPE - (0,1) toggles between 0, TF2.9 sentry guns, and 1, Oztf Sentry Guns.
VOTETIME - (minutes) you can set an inital time where a player cannot use the break command, time in minuites.

TEMP1 has been modified so that you can enable the above flag options.
The current oztf temp1 values are:
1 = Class Persistance
2 = Free
4 = 5 Second Respawn Delay
8 = allow flag drop
16 = solid flag
32 = Free
64 = Autoteam On
128 = TeamFrags On
256 = (do not use)
512 = Free (Removed SpyInvis)
1024 = Grapple On
2048 = FullTeamScore
4096 = tf flag
8192 = tf stan
16834 = ctf flag

To enable more then 1 option above, simple add the values together. Ie "localinfo temp1 5120" = Grapple On 1024 + TF flag 4096.

Fixes:
autoteam bug.
ID incorrect numeric values.
Random pc, choosing the same class.
Showfrags positiong.
Version 1.15 Released 19 / 02 / 2003

TfStrike
New mode called TfStrike is a mode which enables Counter Strike gameplay for Oztf. It contains two teams , Terrorist and Counter-Terrorists.

-Any class on the terrorist team can set the bomb
-Any class on the counter team can disarm
-Terrorist are given a bomb randomly on spawn
-Bombs must be placed at bombsite
-Alias '+bomb' sets the bomb
-Alias 'dropbomb' drops the bomb

Tfstrike works with rounds.
For the bomb to work it needs a bombsite. The bombsites are specified by info_bombsite in the map entities. It does not require any information but the origin. Disarming a bomb is similar to disarming a detpack, you simply look at the detback and wait. The person with the bomb is given a topcolor of 0, in order to individualise the player. You cannot change topcolor whilst you are a Terrorist.
Requires tfstrike-sounds.zip

Observer Mode:
On joining you will notice observer mode has changed a bit.
You can enable fly mode enabling tracking. To fly up aim up while moving etc.
There also has been some camera additions...

Observer Camera's:
Below is a list of aliases that allows you to use Observer cams. Cameras are not available inclan mode. You can use these cameras as a spectator as well.

Sentry Gun Updated:
You can now add a delay to the initial targetting of the sentry gun, and also change the firing rate. As a result you can tune the sentry gun to your liking. Default values are as close to TeamFortress version 2.9 as possible.

New Alias Commands:
TRACKING - toggles tracking, and enables fly mode.
TRACK_PLAYER - tracks through players, from its own pov.
TRACK_SENTRY - tracks sentry guns, from its own pov.
TRACK_TFGOAL - tracks flags
+BOMB - sets bomb in tfstrike mode
DROPBOMB - drops the bomb in tfstrike mode
FRAGLIST - prints a list of statistics

New Admin commands:
CALIBRATE - this command will allow you to updated all modified localinfo's, such as sentrydelay, and it will re-calibrate the mod settings. This is useful if you wish to update settings without restarting the map. Modes will still require map restart.

TFSTRIKE - toggles tfstrike mode

Localinfo's Added:
tfstrike - toggles tfstrike mode. Default value is "off"
sentrydelay - sets the sentry gun initial target delay. Default value is 0.3 seconds. You can set betweem 0.1 and 1.0 second(s).
sentryspeed - sets the sentry gun firing rate and yawspeed. Default value is 0.1 seconds. You can set betweem 0.06 and 0.18 second(s).
practconc - toggles the concussion affect. Default value is "off".
noquad - enables/disable touching of quad. Default value is "off".
bombtime - sets the bomb timer. Default value is 50 seconds. You can set betweem 5 and 90 seconds.
bombarmtime - sets the bomb arm time. Default value is 3 seconds. You can set betweem 1 and 10 seconds.
bombdefusetime - sets the bomb defusal time. Default value is 8 seconds. You can set betweem 3 and 15 seconds.
max_pipebombs - maximum number of ammoboxes in world. Default value is 14 pipebombs (7 for 2 teams). You can set between 10 and 24.
max_ammoboxes - maximum number of ammoboxes in world. Default value is 20 ammoboxes (10 for 2 teams). You can set between 12 and 28.
max_flares - maximum number of flares in world. Default value is 8 flares. You can set between 4 and 16.
max_teamsgs - maximum number of sentry guns on a team.

Fixed:
Player cannot move during disarm. (bomb and detpack)
Autoteam localinfo fixed. You can now set a autoteam time.
Rounds remove all grenade properly.
Round idle is calculated on number of teams not players (must be 2 for round to begin)
Tfstrike mode bomb will detonate through walls. (Wont always work because of engine)
Duel invisibilty bug fixed
Fraglist command fixed. Will display the correct statistics
Sentry gun fixed
Observer fly mode updated
Version 1.13 Released 28 / 1 / 2003

15 New Player sounds including 4 menus
New Modes added, Duel mode and SpeedCapture mode.

Rounds for TfStrike, Soccer and Duel and modes added.
*** note this version does not contain tfstrike ***

Added commands:
rounds, duel, speedcap, fraglist, voicemenu, voice_def, voice_off, voice_gen.

localinfo's Added:
rounds
round_time
speedcap
noreturn

Rounds can be turned on automatically by mod if the mod detects a item_soccer_goal for a soccer map. You can also specify a number of rounds e.g. "localinfo rounds 10". Although it is recommended the you set rounds to just on "localinfo rounds on". Rounds will then be unlimited till timelimit ends. Round time works off the localinfo round_time set in minutes. After each round is complete it will begin a countdown which like clan mode is set by the same "count" localinfo.

If everyone dies the rounds is drawn. If there is one player left in the round, that team will win the round. If a player completes a map objective (like captures the flag) he or she will win the round

Rounds currently support 4 teams, and can be used with clan mode. Rounds will not start until clanbattle begins if in clan mode.

The "noreturn" localinfo will force all goalitems to not return to their origin. This is useful for round play where you may not want a flag to return.

Duel will turn rounds on. If you are the player left in the round it will reset your ammo, armor etc without respawning. Normal rounds respawn upon when rounds begin.

Speedcap calulates the time flag is taken from the start of the round to the time you capture the flag, or another goal item. Like above if a player captures he or she will win the round and it will print the time captured. (noreturn is suggested for this mode)

New sentry gun firing mode, Laser. Now has 3 modes. For this reason localinfo "lgsentry" was removed and localinfo "sentryfire" was added, with 0 as normal 1 as lightning and 2 as laser

Updated Ground Speed command. New option to slowly reduced speed when a player is travelling above maxspeed of that class. This is similar to q3 bunnyhop which only reduces at a higher rate at lower speed to prevent manual bunnyhop but doesnt reduce much at higher speed.

You can either use the gspeed command to toggle through speeds or:
Use localinfo gspeed -1 to -3.
Normal gspeed command is 1 to 3.
or gspeed 0 to turn gspeed off.

Soccer goals updated. Now instead of circular radius you can specify the min and max size of the goals using 2 vectors in the map entity's. This will make goals a proper rectangular goal now.

New Alias commands:
FRAGLIST command: to list everyones frags deaths teamkills and effciency. Note this procedure is not complete and will not return correct values for death and efficieny.
VOICEMENU command: will bring up a main menu which you can choose 3 other voice menus as below.
VOICE_DEF command: this menu will allow you to play defensive voice commands.
VOICE_OFF command: this menu will allow you to play offensive voice commands.
VOICE_GEN command: this menu will allow you to play general voice commands

All voices play are heard by everyone around the player. Note this is not a radio.

Updated Spectator Tracking:
Impulse 4 will cycle and track Sentry Guns and stay track.
Impulse 3 cycles info_tfgoals
Impulse 2 cycles item_tfgoals

Admin commands:
ROUNDS: set rounds on
DUEL: set duel mode on (will automatically turn rounds on)
SPEEDCAP: sets speed cap mode on (will automatically turn rounds on)

Fixed:
Respawn time fixed
invisibility bug
maxplayers bug
telefrag bug
soccer goal scores fixed
spy inivibility functions removed (not used / cheatable)
respawn delay works
admin aliases bug (Aliases do not stuff while dead. Will now stuff after respawn)
civilian gren print bug

Known bugs: Fraglist command not completed.
Version 1.06 Released 12 / 12 / 2002

Fixed changeteam command, now removes detpack and engineer buildings and also brings up the playerclass menu so you can choose a legal class.
Added lights command to toggle lighting (for a bit of fun).

Added t1maxplayers, t2maxplayers, t3maxplayers and t4maxplayers localinfo's to specify the maximum amount of players on each team (this overides info_tfdetect map entity).
Added t1illclasses, t2illclasses, t3illclasses and t4illclassess localinfo's to specifiy the illegal classes on each team (this overides info_tfdetect map entity).
Illegal classes uses bitfield to disable more then one class.
Twelve global floats removed.

Break Command now ends the map in normal mode as well as clan mode. This is useful for changing to the next level on the rotation.
Fixed EMP grenade, does not explode primed grenades of players in the area on explosion.
Version 1.05 Released 12 / 11 / 2002

Updated EMP grenade, now explodes surrounding rockets grenades, and also explodes primed grenades of players in the area.
Added model support for Tranquiliser Gun, Incendiary Cannon and Flame Thrower (this will require adding 3 files to pak files or fortress/progs directory)
break not allowed during prematch time or ceasefire time
Countdown and prematch non integer error fixed
Updated concussion effect (same as tf2.9) on jump.
Added changeteam command: You can now change teams without having to reconnect. (It wIll not change team during clan match).
Sentries shooting observers fixed.
Version 1.04 Released 22 / 10 / 2002

Added flag colour glow to team 1 and 2 flags.
Improved changeclass procedure.

Updated Hwguy. Cannon spread increased while moving hence reduces damage while moveing.
Updated Pyro. Flamer speed reduced to 700 velocity.
Added soliddet command to toggle solid detpacks
Added prematch localinfo and pmup pmdown commands
Added overtime commands otup and otdown to toggle overtime.

Fixed adminpwd will allow adminlevel bypass (if you become an admin via adminpwd you have full access regardless of server adminlevel)
Added spectator positioning cams (inpulse 2 for item_tfgoals (flags) impulse 3 for info_tfgoals and imp 4 for sentry guns).
Added fade to black, fade from black for demo editing impulse 9 and 0 while spectating
Fixed admin commands available to non admin's.
Changed impulse commands for sbar_res. This may have fixed sbar printing bug

*note: Moved serverinfo n to localinfo

Updated sentry gun:
Fixed sentry speed error. (Normal sentry speed was set to fast on level 2 and 3)
Added new algorithm for sentry firing angles.
The original code allowed a 10 degree radius from the direction of the sentry gun to allow an enemy to be fired upon. This means as the distance increased, the less the sentry gun depended on being in the correct position. Up close if you run around the sentry gun it will stop firing and move the gun towards the enemy and refire. This is now dependant on distance of the enemy. The greater the distance the smaller the angle is to make a more realistic targeting system. I will release a spreadsheet showing the firing system graphically.
Version 1.03 Released 3 / 10 / 2002

added duel localinfo
fixed admin messages printing when other impulses used
fixed respawn bug
removed golden localinfo.

added duel.cfg

The duel localinfo will give classes full armor on spawn and half their maximum ammo for each ammo type. It also gives them maximum grenades. The golden localinfo is no longer needed as overtime is defined by its value being greater then 1. If 0 overtime is off. If 1 overtime is 1 minute, etc.
Version 1.02 Released 30 / 9 / 2002

added modstatus command
fixed admin election bug
fixed (i think) respawn bug
added special alais will respawn player (if above bug occurs this is a backup)
clansetup and reset command updated
clan mode countdown fixed
tfvsdm reload bug fixed
Version 1.0 Released 26 / 9 / 2002

Fixed soccer goal sound, wasnt full volume around whole level
Added sgfire command, which toggles between firing bullets and lightning :)
(more on that in documentation)
Disallowed sentry building on tflite mode
Modified max_world_pipebombs for 4 teams. Each team is allowed 5 pipebomps, with 2 teams 7 pipebombs as normal. Tf lite has 4 pipes with 4 teams and 5 with 2.
Fixed cuss affect, was too strong on jump
Added pipedelay command to toggle pipebomb delay
Fixed no blips was not printing on no object detected
Version 0.95

Added sbar movement on setinfo sbs/sbar_size. With a value it can now move sbar from 1 to 10 linebreaks down for added support. Default is 3.
Fixed setinfo sbar_res
Removed Ban (since all it did was kick the player.)
Fixed countdown printing was conflicting with sbar printing.
Version 0.93

Remove speedcheat code detect and kick (does not exactly work, it wont change anything)
Improved new admin system. Commands added.
Localinfo adminlevel added
adminlevel 3 allows admins to kick players at all times
adminlevel 2 allows all other commands but are not available during a clan match
adminlevel 1 allows only few commands mainly those that do not alter phsyical gameplay
Added gren print on sbar
Removed equalization
Removed class binding
Fixed overtime golden cap.
Impulses work during fire, no more stickies during (attack_finished > 1) of any weapon except hw cannon because it causes a frame error.
Added pyro RJ!
(mvdsvr rounds off to 1 decimal place, can cause problems with commands especially when testing with zquake server that doesnt round off)
fixed gspeed command error.
fixed soccer ball physics ( look down and u will kick the ball with less height look up and more height)
fixed soccer goals not working now u can score goals
fixed no cuss affect on jumps
fixed class help working properly now
fixed gas grenade attempted to remove world bug
fixed random teams picking disabled classes bug
fixed sbar now prints scanner objects and range like before
fixed voting after election doesnt work
fixed scout discarding cells
fixed flashlight working while dead and observing
fixed sg too quick, sg has 2 firing modes normal and fast.
Accreditation

Firstly to Robin Walker and the Team Fortress Software team for making the best mod available.

Fuh, for his dedication to making his client FuhQuake, keeping the QuakeWorld community active.

Kombat Teams Software Team.

rXr and Omicron for acquiring sources.

Masschino for the site images and layout design

Twisted for his sexy movie TFDE (Make one for me!)

Rawhide.

And all the test dummies:

    bliP
    Oops
    dp
    Twisted
    Nevamind
    Spoony
    Nitemare
    Vipee
    Fuh!
    Toules
    Soldier
    Darkmace
    Rt
    Tika
    Huskarl
    Lordy
    Schnozen
    Shoyu
    Donaldo
    Akbal
    UggBoot
    Fat
    Mortal
    Vomit
    Grim
    JBalls
    Cable
    Sparks
    Fydo
    Raptor
    DCx3
    Arsey
    Redfox
    Bangers
    bm
    Ace

Thank you to everyone in the community and the server administrators who are willingly using Oztf on their QW servers (so they should!@)

Thank you to all of the Brazlian, Nztf and Oztf communities for their respective involvement in the Oztf project.

For those I missed, bad luck. :)
Retrieved from archive.org, 2007-03-17.
