*============================================================================*
* TeamFortress v2.9                                               readme.txt *
*============================================================================*
Introduction
=-------------------------=
TeamFortress is a fairly old QuakeC patch which radically changes
team games. It provides far more incentive for teams to 
actually work as a team. Each member of the team has unique
weapons, items, and abilities, and style of play.

TeamFortress works with Quake 1 only. 

=-------------------------=
Installation
=-------------------------=
If you don't have any previous versions of TeamFortress:
    1) Download the TF 2.8 Install package from this page:
         http://www.planetquake.com/teamfortress/download.html
       Run it and simply follow the onscreen prompts.
    2) Download the TF 2.9 Upgrade Zip from this page:
          http://www.planetquake.com/teamfortress/download.html
       Unzip it into your "quake\fortress" directory, and overwrite
       any existing files.

If you have a TeamFortress version 2.7 or earlier:
    1) Download the TF 2.8 Install package from this page:
         http://www.planetquake.com/teamfortress/download.html
       Run it and simply follow the onscreen prompts.
    2) Download the TF 2.9 Upgrade Zip from this page:
          http://www.planetquake.com/teamfortress/download.html
       Unzip it into your "quake\fortress" directory, and overwrite
       any existing files.

If you have TeamFortress 2.8, or 2.81:
    1) Download the TF 2.9 Upgrade Zip from this page:
          http://www.planetquake.com/teamfortress/download.html
       Unzip it into your "quake\fortress" directory, and overwrite
       any existing files.

=-------------------------=
Finding TF Maps
=-------------------------=
Note that _no_ TF maps are included in the TF zip... there are
just too many of them. Use GameSpy or an equivalent program to find out 
what maps are being run by servers, and download them.
You can find TF maps in various archives around the net... 
check out any of these urls for links:
    http://www.warzone.com/tfnewbies
    ftp.cdrom.com/pub/quake/levels/team_fortress
    http://www.planetquake.com/teamfortress/maps.html
After you download a TF map, unzip it into a directory under your
"fortress" directory called "maps".

=-------------------------=
What do you need to know?
=-------------------------=
Well, the interface is a lot friendlier now, so you can just join
in and play around with the various classes until you find one or
two you like the most.
Then we suggest you come back and read about those classes in more
detail. Most of the weapons have a couple of tricks to them which
you should know.
Apart from that, read the excellent FAQ written by Ares of Clan
Erinyes, which has lots of help, ranging from item use to good team tactics. 
A definite must-read.

And if you're running a Clan Battle using TF 2.6, make sure you 
read the clan.txt and qwserver.txt files for info on using the
enhanced Clan Battle features.

Oh, btw, don't run the Promo in high-res modes... the music lags 
behind the action, and since the action was timed to fit the
music it loses a lot of its appeal.

=---------------------------------------------------------------------------=
Player Classes
=---------------------------------------------------------------------------=
TeamFortress uses multiple player classes. Whenever a new map is loaded,
all players start in Observer mode. 
When in Observer mode, players are invisible, and can run around the map
watching the action.
To get out of Observer Mode, players must choose a class.
To choose a class, just pick the class from the on-screen menu. 
Once a player class is chosen, you cannot change class for the rest 
of that level, _unless_ the server admin has allowed you to. To change
your class in the middle of a game, type in the desired class abbreviation at
the console.
The class name abbreviations are as follows:
    SCOUT               : "scout"
    SNIPER              : "sniper"
    SOLDIER             : "soldier"
    DEMOLITIONS MAN     : "demoman"
    COMBAT MEDIC        : "medic"
    HEAVY WEAPONS GUY   : "hwguy"
    PYRO                : "pyro"
    SPY	           : "spy"
    ENGINEER            : "engineer"
    RANDOM CLASS        : "randompc"
If you are allowed the change class, you will see a message telling you
that next time you respawn, you'll be that class.


=---------------------------------------------------------------------------=
Class Descriptions
=---------------------------------------------------------------------------=
Scout
=-------------------------=
The Scout is the fastest moving class of all, and the lightest armored.
He can wear a maximum of 50 green armor.
He only carries the axe, single-barrel shotgun, and the nailgun, and 
has a low ammo-carrying capability.
His grenade types are Flash OR Caltrops, depending on the server settings,
and Concussion. Both not very useful for damaging enemies, but great for 
escaping from enemies. He is the ideal class for swift recon and flag 
capturing, and his grenades are a good way to sow confusion among enemy ranks, 
allowing for easy kills from supporting teammates.
He also carries the Motion Detector:
    The scanner draws lines of electricity from the scout towards any moving
    enemies within the detection distance. The length of the line tells you 
    how far away the enemy is.
    The scout can specify the size in which to detect enemies, using the
    scan10, scan30, scan100 aliases, or the scout can specify the exact 
    size. See the Pre-Impulse section below for details on how to do that.
    The exact radius that entities are detected in is the (size * 25).
    e.g. The scan10 alias scans in a radius of 250 around the scout.
         Players are 56 units high.
    You can toggle detection of friends and enemies using the aliases "scane" 
    and "scanf". 
Commands:
    "autoscan"  : Turn on/off the object detector.
    "scansound" : Set the detector to emmit a sound when it detects something.
    "scane"     : Set the detector to include/exclude scanning for enemy objects.
    "scanf"     : Set the detector to include/exclude scanning for friendly objects.
Other Notes:
    A scout can disarm detpacks by simply standing over them and looking directly at them, although
    it does take a couple of seconds.
    A scout can also detect undercover enemy spies when he comes into contact
    with them.


=-------------------------=
Sniper
=-------------------------=
The Sniper class moves at a medium speed, and wears as little armor as
the Scout: a maximum of 50 green armor.
He carries the axe, nailgun, and Sniper Rifle.
His grenade types are Hand and Flares. 
His sniper rifle makes him the ideal class for long-distance defense, but his 
lack of close-range weaponry means he's got trouble if the opponent should get 
within range.
Sniper Rifle:
    The rifle uses shotgun shells for ammo, and operates in one of two modes:
        - Single Shot. With a reload time of 1.5 seconds, this mode is what
          sniping is all about. One shot from this will kill most players
          except for a heavily armored soldier or heavy weapons guy.
          The longer you aim, the more damage the sniper shot will do.
          To aim, just keep holding down the fire button. 
          When aiming, the view slowly zooms in. 
    	  N.B. You can toggle this feature using the "autozoom" command.
        - Auto Shot. Although this fire mode does a lot less damage than
          single shot and uses a lot of ammo, its great for picking off
          a wounded target, or a fast moving scout.
    The other tricky bit about the sniper rifle is that it is a rifle. You
    can't just snap shot from the hip with it. If you're moving too fast,
    the rifle simply won't fire. 
Commands:
    "autozoom" : Toggle the automatic zooming of the sniper rifle.


=-------------------------=
Soldier
=-------------------------=
The Soldier class is the basis of a TF team. He moves slower than most
classes, but makes up for it with the weaponry and armor he carries.
He can wear a maximum of 200 red armor.
He uses the axe, the shotgun, the super shotgun, and the rocket launcher.
His grenade types are Hand and Nail. 
A versatile class, the soldier has no real specialisation... but he's the
core of any offensive or defensive squad.
Note that the Soldier can only carry a maximum of 2 nail grenades at a time.


=-------------------------=
Demoman
=-------------------------=
The Demolitions Man moves at medium speed, and wears an average amount of armor.
He can wear a maximum of 120 yellow armor.
He uses the axe, the shotgun, and the grenade/pipebomb launcher.
His grenades types are Hand and Mirv.
At close range, the demoman is particularly dangerous... his main weapons
are his launcher and hand/mirv grenades, and with them he can clear rooms
in seconds. But at long range, he's in trouble.
Due to his speed and weaponry, he's a good offensive class... but with his
pipebombs and mirvs, he's often used as the last line of defense.
He carries a dual Grenade/Pipebomb launcher:
    The grenade launcher operates as normal.
    The pipebomb launcher lobs grenades that don't explode until the demoman
    wants them to. Lay some pipebombs around, and when you want to detonate
    them, use the "detpipe" alias.
    Pipebombs explode of their own accord after 2 minutes, and when the
    demoman who set them dies.
    Also, due to Quake's limit on the number of entities, there's a limit on
    the number of pipebombs. It's team based, where each team can only have
    X number of pipebombs in existence at one time. If another pipebomb is
    launched, one of the older pipebombs is automatically detonated. 
    The limit varies depending on the server.
And, of course, he carries the Detpack:
    This is a large-scale explosive device.	
    The timer on the Detpack is set by the demoman.
    The demoman	can use preset timer values using the +det5, +det20, 
    +det50 aliases,	or the demoman can specify the exact amount he wants
    to use. See the Pre-Impulse section below for details on how to do that.
    It takes 4 seconds to set a detpack, and the demoman cannot move during
    that time... but at any time, he can stop priming it, retrieve it, and run.
    To do this, bind a key to one of the detpack aliases.
    Then, when you press that key, you'll start setting a detpack.
    If you hold down the key for 4 seconds, you'll set the detpack.
    While holding down the key, you won't be able to move. But, at any
    time you can release the key, which will make you stop setting the
    detpack. Great if you get attacked while trying to set a detpack.
    And yes, you will keep your detpack if you stop setting it.
Commands:
    "+det5"   : Set the detpack with a 5 second timer.
    "+det20"  : Set the detpack with a 20 second timer.
    "+det50"  : Set the detpack with a 50 second timer.
    "detpipe" : Detonate your pipebombs.
Other Notes:
    The Demoman starts with Blast armor, giving him extra protection
    against explosions.


=-------------------------=
Combat Medic
=-------------------------=
The Combat Medic is a medium speed class with average armor.
He can wear a limit of 100 yellow armor.
He uses the medikit/bioweapon, the shotgun, the super shotgun, and the
super nailgun. 
His grenade types are Hand and Concussion.
A good class in most situations, the medic is good at close or medium
range, and packs enough punch to kill any of the lesser-armored classes.
A good addition to offensive teams, and an even better addition to defensive
groups through his use of the medikit. A great class for clearing out
snipers that are pinning a team down.
Medikit/BioWeapon:
    The medic's axe has two modes: Medikit and BioWeapon. 
    The medikit has "ammunition" which the medic can replenish by collecting
    health boxes when he's already at full health.
    - In Bioweapon mode, when the medic hits someone with the axe, they will 
      become infected, and begin to lose health. Anyone coming into contact 
      with an infected person also becomes infected, although medics are immune 
      to it.
    - In Medikit mode, when the medic hits someone with the axe, he will heal 
      them back to full health, and remove any adverse effects they might be 
      feeling, such as Infection, Concussion, Blindness, Burning, or 
      Hallucination. 
      If the player hit by the Medikit is already at full health, they'll 
      receive 5 Mega-Health. Every time the medic hits the player he'll bestow 
      an extra 5 Mega-Health, upto a limit of 50 over the player's max health. 
      The Mega-Health slowly disappears over time. The Medic uses up 1 medikit 
      ammo for every 5 Mega-Health he applies.
    N.B. On TF net servers, the BioWeapon and Medikit are combined into
      one weapon, to make it easier to use. When you hit someone with
      the Medikit/Bioweapon the effects depend on the person you hit:
      You heal teammates, and you infect enemies.
Other Notes:
    The medic heals himself over time, if he has the available medikit ammo.


=-------------------------=
Heavy Weapons Guy
=-------------------------=
The Heavy Weapons Guy is the slowest moving and most heavily armored class.
He can wear a limit of 300 red armor.
He uses the axe, the shotgun, the super shotgun, and the assault cannon.
His grenade types are Hand and Mirv.
An almost purely defensive class, the heavy weapons guy can kill any fully
armored enemy with a few seconds of concentrated fire from the assault cannon.
Mainly effective in open areas, he can be killed by weaker classes if they've
got plenty of cover, due to the time taken for the assault cannon to spin up
and down.
Assault Cannon:
    It takes 6 cells to power up the assault cannon, and when it begins to fire
    it eats up shotgun ammo at a frightening rate. Due to the weight and kick
    of the weapon, the heavy weapons guy must have both feet on the ground to
    fire it. The Guy cannot move while spinning the cannon, and will be unaffected
    by concussion grenades while it is spinning. 
    Also, the longer the weapon spins, the more unstable the heavy weapon
    guy's aim becomes. 
Other Notes:
    Due to his size and armor, the heavy weapons guy is not fazed much by
    injury. He gets knocked around less.


=-------------------------=
Pyromaniac
=-------------------------=
The Pyro is a medium speed, well armored class.
He can wear a maximum of 150 yellow armor.
He uses the axe, the shotgun, the flamethrower, and the incendiary cannon.
His grenade types are Hand and Napalm.
A good support class, the Pyro often finds it hard to kill enemies on his
own. Given time, most enemies burn to death, but in that time the Pyro's
probably been killed. 
Due to his ability to knock chunks off the enemy, the Pyro is a great 
first line of defense. Any enemy getting past him will almost certainly
be half dead.
Flamethrower:
    The flamethrower is a good close range weapon. Anyone hit by it takes 
    damage and catches on fire. The more times they are hit by the 
    flamethrower, the more they'll burn.
    It uses cells for ammo. 
Incendiary Cannon:
    The incendiary cannon looks and works like a standard rocket launcher,
    albeit with a slightly longer reload time, and the rockets travel slower.
    When the incendiary rocks explode, they do a little damage to everyone
    in their area-of-effect, and then sets them on fire.
    Good for clearing out sniper nests.
    It uses 3 rockets per shot.
Other Stuff:
    The Pyro starts with Asbestos armor, giving him extra protection
    against fire.

=-------------------------=
Spy
=-------------------------=
The Spy is a medium speed, fairly lightly armored class.
He can wear a maximum of 100 green armor.
He uses a knife, a tranquiliser gun, the super shotgun, and the nailgun.
His grenade types are Hand and Hallucogenic.
A fantastic infiltration class, the Spy can often get inside incredibly
well defended bases. His limited weaponry make him a weak fighter if the
enemy is aware of his presence... but if they're unaware, he can kill them
before they can blink.
Knife:
    The knife gives the Spy his ability to work as an Assassin. He does
    2x the damage of the axe with it if he hits an enemy in the front, and
    6x the damage of the axe if he stabs them in the back (ignoring armor).
Tranquiliser Gun:
    The tranquiliser gun fires darts coated with a sedative drug. Anyone
    hit by it suffers a loss in both movement speed and weapon firing speed.
    It uses shotgun shells for ammo.
Undercover:
    The spy's main skill is his ability to go undercover. This does one of
    two things, depending on the server you're playing on. Server admins
    choose which method they want to use.
    - Spies become invisible when they go undercover. While undercover, he
      uses up cells slowly, and if he runs out of them, he becomes visible 
      again. While not undercover, he regenerates cells slowly.
    - Or, the recommended setting, when Spies go undercover, they change their
      skin and/or color. This is a more complex setting than the invisibility,
      but ultimately more fun and allows for more strategy.
    If a spy attacks or shoots while undercover, he'll lose his cover.
    Other things can force a spy to lose his cover too... they depend upon
    the map being played. Grabbing a flag usually removes a spies cover.
Feigning:
    The spy pretends to die. Note that while you're pretending to be dead,
    players will still see you move if you look around.
Commands:
    "disguise"  : Go undercover.
    "feign"	   : Feign/Un-Feign death
    "sfeign"    " Silently Feign/Un-Feign death
Other Notes:
    A Spy can detect undercover enemy spies when he comes into contact
    with them.


=-------------------------=
Engineer
=-------------------------=
The Engineer is a medium speed, fairly lightly armored class.
He can wear a maximum of 50 yellow armor.
He uses a spanner, a railgun, and the super shotgun.
His grenade types are Hand and EMP.
A good defensive class, the engineer works primarily as a support class.
With his ability to repair armor, create ammo, and build structures,
the engineer increases the strength of a group of defenders tenfold.
Metal:
    The engineer does most of his work with scrap metal. To an engineer,
    scrap metal is synonymous with cells. He gets extra metal by collecting
    backpacks and armor.
Spanner:
    The engineer uses the spanner in a two ways:
    - If he hits a teammate with the spanner, he'll repair their armor.
      It costs the engineer 1 metal for every 4 points of armor repaired.
    - If he hits a structure he built, he can perform various operations
      on the structure. These vary based upon the structure, but he'll 
      always be able to Dismantle or Repair the structure.
RailGun:
    The railgun fires small nails at extremely high velocities that punch
    through most things and keep going. It doesn't do a lot of damage, but
    it makes up for that with its fast rate-of-fire.
    It uses nails for ammo.
Structures:
    The engineer's main skill is his ability to make structures. Currently,
    he can make two different structures:
    Sentry Guns
    	These little beasties a great for defensive support.
    	They have 3 different levels. The higher the level, the more health
    	the sentry has, and the more ammo it can hold. Also, higher levels 
    	have a faster rate-of-fire, and level 3 sentries launch rockets every
    	3 seconds.
    	Engineers can reload and upgrade sentries by using the spanner.
    	Engineers can only have one sentry operational at any one time.
    Ammo/Armor Dispensers
    	These small structures are great for providing ammo for a defensive
    	group. Over time, ammo and armor is created inside them automatically,
    	although engineers can put ammo or armor into the dispenser by using
    	their spanner.
    	Anyone else can get ammo/armor from the dispenser by touching it.
    Engineers can remotely detonate their structures through the build menu.
Commands:
    "build" : Start building.
Other Notes:
    The engineer can create ammo. Use the "dropammo" command to do it. If you
    attempt to drop ammo that you don't have, you will create it instead, if
    you have enough metal to do so.


=---------------------------------------------------------------------------=
Team Details
=---------------------------------------------------------------------------=
TeamFortress can handle upto 4 teams on a map.
When you join a server, if teamplay is on, you'll be asked to join a team.
The map specifies how many teams it will allow, so in some maps you may
only be allowed to play 2 or 3 teams.
You can choose your team from the menu, or you can press 5 to use Autoteam,
in which case the server will assign you to the team that has the least 
number of players in it. Jumping while at the Team Menu will also activate
Autoteam.

Once you've joined a team, you will be shown a list of players that 
are already in that team, and the classes they're playing.
You will then be asked to choose a class.

Once players join a team they cannot change to another team.
Any player who attempts to change their _pants_ color away from the
Team Color will be kicked. Shirt colors can be changed freely.

=-------------------------=
Team Equalisation
=-------------------------=
Team Equalisation is compiled into the patch by default. 
Basically, it subtly alters the "toughness" of team members based upon how 
well that team is doing.
The patch calculates how well a team is doing based upon two things:
    - The number of players in each team
    - The total teamscore of each team
Server admins can set which/both of the two are used.
For each team the patch calculates an equalisation value, and then all damage
done by this team is multiplied by that value, and all damage taken is divided 
by the value.
You can see the values for all teams by using the "query" alias.
N.B. Server admins can also alter the "level" of Team Equalisation.
     They can make equalisation a very subtle change, or they can make
     it so that losing teams are 10 times as tough as winners. If you 
     feel that a server's Equalisation setting is too high/low, take it
     up with the server admin, not us.


=---------------------------------------------------------------------------=
Grenades
=---------------------------------------------------------------------------=
Several new types of grenades now exist, and all classes have access to at
least one of them. They are not to be confused with the grenades used by
the grenade launcher.
These grenades all work like real grenades... after they're primed, they
explode 3 seconds later, regardless of how long you hold onto the grenade
after you pull the pin.
There are two aliases used for the grenades:
    "+gren1"
    "+gren2"
Which prime and throw grenade types 1 and 2 for your class. Bind a key to each
of them. When you press the key, you pull the pin. When you release the key,
you throw the grenade.
The grenade types are as follows:
Hand        :   Hand grenades simply explode. They are twice as powerful
                as those shot from the grenade launcher.

Flare       :   Flares aren't really grenades... they do no damage. Simply
                drop them in dark areas and they'll light them up for a 
                little while.

Concussion  :   Concussion grenades don't actually hurt anyone, they just
                blow everyone away from the grenade explosion at a high
                speed, and then make them woozy. 

Flash       :   Flash grenades do a small amount of damage to everyone in
                range, and blinds them for a short time. 

Caltrops    :   Caltrops are small spikes that can be dropped to deter 
                pursuing enemies. They do a little damage, and slow the enemy
                down, until he/she is healed by a medic or healthbox.

Nail        :   Nail grenades are good in large rooms. Instead of detonating,
                they raise up into the air and hover. They then begin to 
                rotate while firing nails. After doing this for a few seconds
                they explode like a normal grenade.

Mirv        :   Mirv grenades are room-clearers. When one explodes,
                it divides into approximately 15 individual grenades which
                then explode.

Napalm      :   When these explode they throw flames out in all directions,
                setting things, like players, alight.

Hallucinogenic: These explode and emit a large gas cloud, which stays in
                the area for a short time. Anyone within the cloud takes
                a small amount of damage and begins to hallucinate. 
                Hallucination wears off over time.

EMP	        :   ElectroMagneticPulse grenades simply wreck or destroy
                any electrical or explosive items within their range. 
                Backpacks, pipebombs, ammo boxes, players, etc, all explode 
                based upon the amount of explosive ammo they're carrying.


=---------------------------------------------------------------------------=
New Commands
=---------------------------------------------------------------------------=
Special:
    To make playing multiple classes easier, there's a command called "special".
    This command performs the most appropriate action for the player's current
    class. 
    These are:
    	Scout    : Turn object detector on.
    	Sniper	  : Toggle autozoom.
    	Soldier  : Reload weapon.
    	Demoman  : Detonate pipebombs.
    	Medic    : Switch between medikit/bioweapon and Super Nailgun.
    	HvyWeap  : Switch between assault cannon and super shotgun.
    	Pyro     : Switch between flamethrower and Incendiary cannon.
    	Spy      : Go undercover. 
    	Engineer : Build. 

ChangeClass:
    During a game, you can change your class using the "changeclass" command,
    if the server you're connected to allows it.
    The usual class menu will appear, allowing you to pick a class...
    you will become that new class when you die next.

ID:
    To make teamplay over the net easier, there's a command called "id".
    This command effectively fires an invisible bullet, and tells you the name 
    of the player it hits, and whether or not he's an enemy. It has the same 
    range as the shotgun, so basically, if you can see a player, you can ID him. 

    - If you are a medic, and the player you ID is on your team, you'll also be 
      shown a rough estimate of the player's health.
    - If you are an engineer, and the player you ID is on your team, you'll 
      also be shown a rough estimate of the player's armor level.

    But, everything is different if the player you ID is a spy.
    When a spy changes color, the patch picks a player on the team that the spy
    is disguised as. If the spy has	changed skin, then it tries to find a 
    player on that team with the same skin. When an enemy ID's the spy,
    the name reported to the enemy will be the name of the player the spy is 
    pretending to be, not the spy's	name. If the spy is pretending to be a 
    player on the same team as the enemy, and the enemy is a medic or engineer, 
    then the enemy will be shown the spy's health or armor.	Of course, it is 
    possible for you to ID a player and be told that the player is you... 
    because the spy is pretending to be you :) 

    You can also ID engineer structures, in which case it'll tell you who
    built them. 

    ID will also work in observer mode.

SaveMe:
    To make medics and engineers more effective, there's a command called 
    "saveme" which other players can use to tell them they need healing or
    repairing. Players doing this command yell "Medic!" and a large lightning
    bolt flashes around them. Only medics/engineers on the same team as the
    player who did the command will see the lightning bolt.
    Spies of any team can see it.

DropKey
    This command is only available in Co-Op games.
    Using the "dropkey" command, players can drop any keys they're carrying
    so that teammates can pick them up.

DropAmmo
    You can drop ammo for teammates by using the "dropammo" command.
    Bind a key to it and press the key. A second later, a menu will appear
    showing you a list of ammo types. Just select the type you want and 
    you'll drop a box with some of that ammo in it.
    Note that once you've learnt the menu, you don't need to wait for
    it to appear before selecting the ammo type you want to drop.

DropItems
    You can drop all map-specific items you're carrying by using the
    "dropitems" command. The most common example of a map-specific item
    is a Flag in any capture the flag level.
    N.B. You can only drop items which the map-maker has allowed you
         to drop... if you can't drop a flag on a specific map, it's because
         the map-maker didn't want to allow you to drop it.

Discard:
    To make it easier to supply your teammates with ammo, the "discard" alias
    has been provided. When a player issues the command, he'll drop a backpack
    containing all the ammo that he cannot use.

New Map Information:
    Map Makers can provide a bit of in-game information to players.
    Players can read this information using the following aliases:
        "flaginfo"  :   Display the state of any items the map maker has
                        specified as "flags". In a CTF map, this shows the
                        usual state of the Flags, but in other maps, it might
                        give the status of whatever the map-maker wants.
        "maphelp"   :   Display some help on the goal of the current map.
                        Only works if the map creator has specified a string.

Reload
    All basic weapons except the Nailgun and Super Nailgun have clips. When all
    the ammo in a clip is spent, the weapon is reloaded. This can take anywhere
    from 1 second for the Shotgun to 4 seconds for the Rocket Launcher. Ammo
    amounts in the clips varies between weapons.
    While reloading, you cannot change weapons.
    You can force a reload at any time by using the "reload" alias.
    This is good if you've got a few spare seconds, and you've only got
    one shot left in your rocket launcher clip. The time taken to reload
    in this manner depends on how many shots you fired in the clip.

Class Scripts
    Players can make config files containing their key bindings for each
    class and put them in the fortress directory. Then, they can set their
    setinfo key "exec_class" to "on", as follows:
        setinfo exec_class on
    Then, whenever they change classes, TF will automatically exec the
    cfg file for their chosen class.
    E.g. If a player chooses Sniper, TF will automatically exec sniper.cfg
         when the player spawns.
    The cfg files for the classes are:
        scout.cfg, sniper.cfg, soldier.cfg, demoman.cfg, medic.cfg,
        hwguy.cfg, pyro.cfg, spy.cfg, engineer.cfg

Map Scripts
    Players can make config files containing their key bindings for each
    map and put them in the fortress directory. Then, they can set their
    setinfo key "exec_map" to "on", as follows:
        setinfo exec_map on
    Then, whenever the server's map changes, TF will automatically exec the
    cfg file for the map the player is entering.
    The script "default.cfg" - if it exists - will be exec'ed first and then
    the map cfg file, if that exists.  That way you can have one config file
    for many maps and not have to make one for every map.


=-------------------------=
Command Summary
=-------------------------=
General
    inv           :    Display your inventory
    showtf        :    Display the status of all Toggleflags
    special       :    Do the most appropriate thing for current class.
    id            :    ID the player in your sights.

Class Changing
    scout         :    Change class to Scout
    sniper        :    Change class to Sniper
    soldier       :    Change class to Soldier
    demoman       :    Change class to Demolitions Man
    medic         :    Change class to Combat Medic
    hwguy         :    Change class to Heavy Weapons Guy
    pyro          :    Change class to Pyro
    spy           :    Change class to Spy
    engineer      :    Change class to Engineer
    randompc      :    Change class to Random Class

    changeclass   :    Bring up the Class Changing menu.

Grenades
    primeone      :    Prime a grenade of Type 1
    primetwo      :    Prime a grenade of Type 2
    throwgren     :    Throw whatever grenade you've primed
    +gren1        :    Bind to a key. Press key primes, release key throws.
    +gren2        :    Bind to a key. Press key primes, release key throws.

Pipebombs
    detpipe       :    Detonate all your pipebombs

Reloading         
    reload        :    Forces a weapon reload

Scanner
    autoscan      : Turn on/off the object detector.
    scansound     : Set the detector to emmit a sound when it detects something.
    scane         : Set the detector to include/exclude scanning for enemy objects.
    scanf         : Set the detector to include/exclude scanning for friendly objects.

Detpack
    +det5          :    Set your detpack for 5 seconds
    +det20         :    Set your detpack for 20 seconds
    +det50         :    Set your detpack for 50 seconds

Team Related
    showscores    :    Display Team Scores
    showclasses   :    Display the Classes of your Team Members
    query         :    Display the current Team Equalisation Factors
    dropammo      :    Drops some ammo
    discard       :    Drops all ammo you can't use
    saveme        :    Indicate you need healing/repairing
    dropkey       :    Drops a key                           (Co-Op only)

Class Specifics
    autozoom      :    Toggle zooming of sniper-rifle        (Sniper only)
    disguise      :    Go undercover.                        (Spy only)
    feign         :    Pretend to die.                       (Spy only)
    sfeign        :    Pretend to die (silently).            (Spy only)
    build         :    Build/Detonate a structure.           (Engineer only)

Map Specifics
    flaginfo      :    Display the state of the flags.
    maphelp       :    Display some help on the goal of the current map.
    dropitems     :    Drop a map-specific item.

Debug Type Stuff
    showloc       :    Shows you your position on the map. Good for map making.


=-------------------------=
Impulse Summary
=-------------------------=
Weapon Selection
    Cycle Forward       :   Impulse 10

    Select Hook         :   Impulse 22 or 39
    Select Axe          :   Impulse 40

=-------------------------=
SetInfo Summary
=-------------------------=
Clients can also set some setinfo keys to tell the TF servers
a bit more about them.

Status Bar
    sbar_size   :   <position>      (See the Status Bar section below
    sbar_res    :   <resolution>     for more info on these two settings)

Classhelp
    classhelp   :   off     // Turn off help displayed after you pick a class
    ch          :   off     // Abbreviation for above

Admin
    adminpwd    :   <password> 

Class Scripts
    exec_class  :   on      // Turn on Auto-Execution of class cfg files

Map Scripts
    exec_map    :   on      // Turn on Auto-Execution of map cfg files

=---------------------------------------------------------------------------=
New Rules
=---------------------------------------------------------------------------=
Armor Classes:
    There are various classes of armor, which protect against various
    different attack types. Each playerclass is restricted to using only
    certain types. 
    There are 5 types:
    	Kevlar	: absorbs 50% damage from Bullets
    	Blast	: absorbs 50% damage from Explosions
    	Wooden	: absorbs 50% damage from Nails
    	Asbestos: absorbs 50% damage from Fire
    	Shock	: absorbs 50% damage from Electricity
    You can find out what class of armor you're wearing using the Inventory
    command. When you pick up armor, the message displayed will tell you
    what armor class it is, if any. 
    It's upto the map designers to put different armor types into their maps.

Player Pushing:
    You can push players who are on your own team. You can do this by
    simply walking into them. You'll push them back slowly. The only real
    advantage of this comes from the fact that anyone with a flag pushes
    much harder. So if an idiot teammate blocks your way when you're running
    home with the flag, you can push him out of the way.

=---------------------------------------------------------------------------=
Status Bar
=---------------------------------------------------------------------------=
Players can turn on a status bar which displays various game details, such as 
the team scores and the number of shots left in your clip, as well as specific 
class details, such as your current skin/color if you're a spy.
It works much like CTF's status bar, with a few refinements. The commands to 
use it are: 

   "sbar_on"
   This turns the status bar on. If it's already on, it toggles the status
   bar between two positions. The two positions are designed to put the status 
   bar at the right place on your screen, depending on how you have your 
   console. If you play with no or half console, you want position 2, and if
   you play with full console you want position 1. 

   "sbar_off"
   Turns the status bar off. 

   "sbar_200" "sbar_240" "sbar_300" "sbar_350" "sbar_384" "sbar_400" 
   "sbar_480" "sbar_600" "sbar_768"
   These commands tell the status bar which screen resolution you're running 
   in, so it knows where to put itself. The res you want to use is the one that 
   corresponds to the Y value in the res you run quake in.
   e.g. if you run quake in 320x200, use "sbar_200"

But, in QuakeWorld there's a much better way to set your status bar position. 
Edit the config.cfg file in your quake\fortress directory and put in the 
following lines: 

   setinfo sbar_size <position>
   setinfo sbar_res <resolution>

Where: 

   <position> is either 1, 2, or 3. The position you should use depends on how 
   much of a console you use:
        1 : Full Console
        2 : Half or No Console

   <resolution> is either 200, 240, 300, 350, 384, 400, 480, 600, or 768. It 
   should correspond to the Y value of the res you run quake in.

Then, whenever you connect to a QW TF server, it'll automatically turn on the 
status bar with these settings. 

For example, I run quake in 320x240, with half the console up. In my 
config.cfg, I've got these two lines: 
   setinfo sbar_size 2
   setinfo sbar_res 240

These commands only work in QuakeWorld.


=---------------------------------------------------------------------------=
ToggleAble Game Settings
=---------------------------------------------------------------------------=
Various options can be set by the server, and will come into effect
when the server next changes level. For details on how to change them,
see the server.txt and qwserver.txt files.
The options at the moment are:
    Class Persistance On/Off
    	This option allows you to turn on Class persistance between levels.
    	E.g. If it's on, when you go to a new level each player will stay
    	the same class they were in the last level.
    	This option is automatically turned on in a Co-Op game.
    Cheat Checking On/Off
    	This option toggles whether you want speed checking of players in
    	an attempt to catch people tinkering with their maxspeed. It's not
    	an elegant way of checking, and is by no mean foolproof, so you
    	may wish to turn it off. If you're playing with friends, turn it off
    	and save some of the server's computing time. If you're playing on 
    	the net, you might want to leave it on. It's better than nothing :)
    AutoTeam On/Off
    	When on, AutoTeam will automatically assign players to the team
    	with the least number of people in it, when the player chooses
    	his/her class.
    Respawn Delay
    	When on, players who die cannot respawn for 5 seconds. Suiciding
    	players cannot respawn for 10 seconds.
    TeamFrags On/Off
    	When On, this toggleflag makes each player's frag count equal
    	to the number of points his/her team has. Using TAB key you can
    	then see how each team is going.
        In TeamFrags mode, frags for killing enemies are not counted 
        towards the team's total score.
    Full Team Score On/Off
    	When On, this toggleflag makes each player's frag count equal
    	to the number of points his/her team has. Using TAB key you can
    	then see how each team is going.
        In Full Team Score mode, teams get 1 point for every kill made
        by a team member.
    SpyInvis On/Off
    	When On, spies become invisible when they go undercover. When Off,
    	spies can change their color/skin when they go undercover.
    Grapple On/Off
    	When On, players have access to the Grappling Hook.
    Old Grenades On/Off
      When On, the server will utilize the TF 2.7 cheatable versions of the
      concussion, flash and hallucinogen grenades.


=---------------------------------------------------------------------------=
Pre-Impulses
=---------------------------------------------------------------------------=
A Pre-Impulse is an impulse which must be used before another impulse. 
The second impulse can then be interpreted in a different way.
There are only two pre-impulses being used:
    Scanner Pre-Impulse:	159
    Detpack Pre-Impulse:	168

An example of how to use them:
    The scout's Motion Detector has a Pre-Impulse of 159. You specify the 
    amount of energy you want to spend on the scan with an impulse after it.
    So if you wanted to use 50 energy to scan, you would do Impulse 159
    followed by Impulse 50. The recommended way to do this is to bind
    a key to an alias. In the console, you could do this:
    	alias scan_50 "impulse 159; wait; impulse 50"
    	bind S scan_50
    This would make 'S' do a scan using 50 energy.

Note that Pre-Impulses don't work reliably over high-lag connections.
There are already aliases created for all Pre-Impulses, but you might 
to make your own, for different time/energy usages.


=---------------------------------------------------------------------------=
Other Features
=---------------------------------------------------------------------------=
CTF Support
=-------------------------=
TeamFortress supports CTF maps. If you load any CTF map into a server 
running TF, it'll look and play almost identical to CTF, except you've
got all the usual TF classes, weapons, etc.
You can use the normal impulses for hook and flag info, just like CTF.


=---------------------------------------------------------------------------=
Troubleshooting
=---------------------------------------------------------------------------=
If you have trouble running TF, check out TF Troubleshooting FAQ:
    http://www.planetfortress.com/teamfortress/tf_ts_faq.html

For help on playing TF, check out the TF Newbie's guide:
    http://www.warzone.com/tfnewbies/


=---------------------------------------------------------------------------=
Servers with this Code
=---------------------------------------------------------------------------=
If you run a TF server, make sure you read the text files on how to 
run the server with the options you want.
Read the server.txt file if you're running a LAN or Normal Quake Net server.
Read the qwserver.txt if you're running a QuakeWorld server.

And if you want to really tweak the guts of TeamFortress, changing the
code is the way to do it. But, before you start doing that, _please_
read the options.qc carefully.
That file contains all the compilable options we've got in TF. A lot
of things that servers like to tweak is #defined in there, so you can
change it easily.

Before compiling the code, make sure that you're compiling for QuakeWorld 
if you're running a QuakeWorld server.


=---------------------------------------------------------------------------=
A Note on the multiple TF Versions
=---------------------------------------------------------------------------=
There are essentially 4 different versions of TF:

LAN TF
    This is the base version. It's run when you play a single player
    game on your home computer.	Because there's no limitations on bandwidth,
    limits on the number of flames, pipebombs, etc, are very lax.
    This is the progs.dat in the root directory of the TF zip.

Internet TF
    This version has much the same functionality as the LAN version, but 
    with tighter reins on the number of entities existing, to cut down on lag.
    Pyros cannot lay flames on the floor and walls like they can in LAN.
    The limit on the number of pipebombs is much lower. 
    Many other changes, all along the same line... keep that lag down.
    This is the progs.dat in the \altprogs directory of the TF zip.

QuakeWorld TF
    This version works like the Internet TF does, but with a lot of extra
    functionality that only QuakeWorld allows. QuakeWorld servers are more
    customizable due to the serverinfo capability.
    This is the qwprogs.dat in the root directory of the TF zip.

LAN QuakeWorld TF
    This is the LAN version compiled for QuakeWorld. It has all the LAN
    features and the QuakeWorld features.  
    This is the qwprogs.dat in the \altprogs directory of the TF zip.

Each of these versions are produced from the same source code. Before
compiling, comment out the appropriate lines in the options.qc file
to select the version you want to compile to.


=---------------------------------------------------------------------------=
Copyright and Distribution
=---------------------------------------------------------------------------=
Authors may use this code for the basis of other freeware quakec
code, but not for any for-profit code, such as modification of this 
patch for the purpose of running it on a commercial Quake Server,
without an agreement of some kind with TeamFortress Software.

You may distribute this patch in any electronic format as long as this 
textfile remains unmodified and all of the files in the archive are
present, and as long as no charge is made for it.
You may _not_ include this patch on any Quake compilation CD.

Non-Commercial Quake Servers are free to run this patch.


=---------------------------------------------------------------------------=
Availability
=---------------------------------------------------------------------------=
Web Sites
=-------------------------=
TeamFortress Homepage:
    http://www.planetfortress.com/teamfortress

TeamFortress Software's Homepage:
    http://www.teamfortress.com/

TeamFortress Maps can be found on our www site, or in the directory:
    ftp://ftp.cdrom.com/pub/idgames2/levels/team_fortress/


=-------------------------=
Mailing Lists
=-------------------------=
TeamFortress Map Makers List
    Moderated list for discussions/questions on TF's map code.
    - To join, mail:
      fortress-mapmakers-request@shangri-la.dropbear.id.au
      with a subject of "subscribe".
    - To unsubscribe, mail:
      fortress-mapmakers-request@shangri-la.dropbear.id.au
      with a subject of "unsubscribe".
    - Then, to post to it, mail:
      fortress-mapmakers@shangri-la.dropbear.id.au

TeamFortress Administrators List
    UnModerated list for discussions/questions on running a TF server.
    - To join, mail:
      fortress-administrators-request@shangri-la.dropbear.id.au
      with a subject of "subscribe".
    - To unsubscribe, mail:
      fortress-administrators-request@shangri-la.dropbear.id.au
      with a subject of "unsubscribe".
    - Then, to post to it, mail:
      fortress-administrators@shangri-la.dropbear.id.au

TeamFortress General List
    Moderated list for discussions/questions/suggestions/etc on TF itself.
    - To join, mail:
      fortress-request@shangri-la.dropbear.id.au
      with a subject of "subscribe".
    - To unsubscribe, mail:
      fortress-request@shangri-la.dropbear.id.au
      with a subject of "unsubscribe".
    - Then, to post to it, mail:
      fortress@shangri-la.dropbear.id.au


=---------------------------------------------------------------------------=
TF Facts you didn't know you didn't know
=---------------------------------------------------------------------------=
- Version 1.0 of TF was released on the 25th of July, 1996, making TF
  over 2 years old. 

- The "saveme" command's wav files are Ian's voice. Several of our friends 
  have now quit TF forever because they're sick of Ian yelling in their ears
  everytime they play.

- The "dartgun.wav" file is in fact a mix of Morning-Fresh Dishwashing 
  Detergent, a screwdriver, a mousepad, and Ian breathing heavily into a pen.

- The promo dem file was cut together from 14 meg of raw footage, spread
  across 84 separately recorded demos. To create the final demo file, the
  raw footage was cut a total of 127 times. This one big demo file was 
  then cut and spliced 207 times to create the finished promo.
  Filming was done using the camera code built into TF.
  Editing was done using Film-At-11, written by Eric Stern, and Demo Operator,
  written by Robin Walker.


=---------------------------------------------------------------------------=
Credits
=---------------------------------------------------------------------------=
TeamFortress was written by TeamFortress Software.
TFS currently consists of 4 people:
    Robin "Bro" Walker 	 	- Designer & Coder
    John "Jojie" Cook   	- Designer & Coder
    Ian "Scuba" Caughley	- Designer, Coder, Modeller, & Texturer
    Damian "Harsh" Scott	- Scriptwriter

TeamFortress 2.9 is largely the result of many hours of hard work by
Keith "Gudlyf" McDuffee. He spent a lot of time debating necessary changes 
that TFS was hesitant to even approach, and for that we thank him profusely.
We'd even thank Kinlord for his efforts, but we don't like him, so we won't.

The skins for 90% of the classes were done by:
    Peter Wilson, Nick Wilson.

Models were done by various people. Specifically:
    Sentry Model by David "Mr.Black" Eckblad (emporium@quake2fortress.com)
           which was based on an original model by 
           Iikka Keränen (ikeranen@raita.oulu.fi)
    Original Sniper Rifle, and incredible Assault Cannon by James (email?)
    Sniper Rifle by Graves (graves78@bellsouth.net)
    Dispenser Model by Jim Kaufman (jek19@idt.net)
    Dispenser Skin by David "Mr.Black" Eckblad (emporium@quake2fortress.com)
    War Standard by Peter Lewyllie (peter_lewyllie@mail.dotcom.fr)

Skins for the TF Flag and the War Standard were done by:
    Gjermund "SirLiam" Jensvoll (liam@nano.no)

The Pyro class was largely designed and coded by:
    Alexandre Brouaux (brouauxa@micronet.fr)

Some of the code for TeamFortress was influenced by other people's:
    Mirv Grenade code was influenced by code from Steve Bond (wedge@nuc.net)
    Pipebomb code was influenced by code from AsmodeusB (tazq@sos.on.ca)
    Status Bar code was influenced by code from Zoid (zoid@threewave.com)
    Scout Scanner was influenced by Requiem (requiem@powernet.com.au)
    Admin Code by from the ClanRing patch by Steven Possehl (marmot@vt.edu)

The TF Server map cycling pack was put together by Erik "Speedenator" Selberg
(selberg@cs.washington.edu), who also wrote the excellent SpeedStats TF 
statistics gathering program. He worked in combination with the mapman 
himself, Jim "Sgt Thundercok" Kaufman (jek19@idt.net), to produce the 
the vote40 svr cfg pak.

We were also helped by an enormous number of people over the many months
this patch has been worked on. We're sorry, but there's just too many to
list, and since we'd certainly miss some of those that deserve it, we don't
want to try. But, we would like to say thanks to everyone on the TF mailing 
list who've helped with the final versions of 2.5, and to everyone who mailed 
us bug reports.
And finally, we'd like to thank every TF server out there for supporting
our patch, and for putting up with all the betas.

=---------------------------------------------------------------------------=
TEAMFORTRESS v2.                           28/8/98
TeamFortress Software Pty. Ltd.
Company WWW: http://www.teamfortress.com/
TF Web Site: http://www.planetfortress.com/teamfortress