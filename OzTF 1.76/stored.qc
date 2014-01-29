void () Initialise_Teams = {

   store_obs = spawn();
   store_obs.team = 0.000;
   store_obs.colormap = 0.000;
   store_obs.netname = "observe";

   //stored_obs.cnt = number_of_teams 
   //store_obs.maxammo_shells = civilianteams
   //store_obs.ammo_nails = illigalclasses

   pteam1 = spawn();
   pteam1.team = 1.000;
   pteam1.colormap = 13.000;
   pteam1.netname = "blue";
   pteam1.frags = 0.000;
   pteam1.real_frags = 0.000;
   pteam1.maxplayers = 100;

   pteam2 = spawn();
   pteam2.team = 2.000;
   pteam2.colormap = 4.000;
   pteam2.netname = "red";
   pteam2.frags = 0.000;
   pteam2.real_frags = 0.000;
   pteam2.maxplayers = 100;


   pteam3 = spawn();
   pteam3.team = 3.000;
   pteam3.colormap = 12.000;
   pteam3.netname = "yellow";
   pteam3.frags = 0.000;
   pteam3.real_frags = 0.000;
   pteam3.maxplayers = 100;


   pteam4 = spawn();
   pteam4.team = 4.000;
   pteam4.colormap = 11.000;
   pteam4.netname = "green";
   pteam4.frags = 0.000;
   pteam4.real_frags = 0.000;
   pteam4.maxplayers = 100;
   

};


 