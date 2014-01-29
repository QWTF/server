float (entity Retriever, float AmmoType) TeamFortress_GetMaxAmmo;
float (entity Retriever, float WeaponType) TeamFortress_CanGetWeapon;

void (entity Retriever, entity Items) TeamFortress_AddBackpackItems;

void (entity p) TeamFortress_SetSpeed;

void () tfgoal_touch;

void () SUB_regen = {

   self.model = self.mdl;
   self.solid = 1.000;
   sound (self,2.000,"items/itembk2.wav",1.000,1.000);
   setorigin (self,self.origin);

};

void () noclass = {

   dprint ("noclass spawned at");
   dprint (vtos (self.origin));
   dprint ("\n");
   remove (self);

};

void () q_touch = {

   local string s;

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (other.health <= 0.000) ) {

      return ;

   }
   self.mdl = self.model;
   sound (other,2.000,self.noise,1.000,1.000);
   stuffcmd (other,"bf\n");
   self.solid = 0.000;
   other.items = (other.items | 4194304.000);
   self.model = string_null;
   other.super_time = 1.000;
   other.super_damage_finished = self.cnt;
   s = ftos (rint ((other.super_damage_finished - time)));
   bprint (0.000,other.netname);
   bprint (0.000," recovered a Quad with ");
   bprint (0.000,s);
   bprint (0.000," seconds remaining!\n");
   activator = other;
   SUB_UseTargets ();

};

void (float timeleft) DropQuad = {

   local entity item;

   item = spawn ();
   item.origin = (self.origin - '0.000 0.000 24.000');
   item.velocity_z = 300.000;
   item.velocity_x = (-100.000 + (random () * 200.000));
   item.velocity_y = (-100.000 + (random () * 200.000));
   item.flags = 256.000;
   item.solid = 1.000;
   item.movetype = 6.000;
   item.noise = "items/damage.wav";
   setmodel (item,"progs/quaddama.mdl");
   setsize (item,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   item.cnt = (time + timeleft);
   item.touch = q_touch;
   item.nextthink = (time + timeleft);
   item.think = SUB_Remove;

};

void () r_touch = {

   local string s;

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (other.health <= 0.000) ) {

      return ;

   }
   self.mdl = self.model;
   sound (other,2.000,self.noise,1.000,1.000);
   stuffcmd (other,"bf\n");
   self.solid = 0.000;
   other.items = (other.items | 524288.000);
   self.model = string_null;
   other.invisible_time = 1.000;
   other.invisible_finished = self.cnt;
   s = ftos (rint ((other.invisible_finished - time)));
   bprint (0.000,other.netname);
   bprint (0.000," recovered a Ring with ");
   bprint (0.000,s);
   bprint (0.000," seconds remaining!\n");
   activator = other;
   SUB_UseTargets ();

};

void (float timeleft) DropRing = {

   local entity item;

   item = spawn ();
   item.origin = (self.origin - '0.000 0.000 24.000');
   item.velocity_z = 300.000;
   item.velocity_x = (-100.000 + (random () * 200.000));
   item.velocity_y = (-100.000 + (random () * 200.000));
   item.flags = 256.000;
   item.solid = 1.000;
   item.movetype = 6.000;
   item.noise = "items/inv1.wav";
   setmodel (item,"progs/invisibl.mdl");
   setsize (item,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   item.cnt = (time + timeleft);
   item.touch = r_touch;
   item.nextthink = (time + timeleft);
   item.think = SUB_Remove;

};

void () PlaceItem = {

   local vector oldorg;

   self.mdl = self.model;
   self.flags = 256.000;
   self.solid = 1.000;
   self.movetype = 6.000;

   self.origin_z = (self.origin_z + 6.000);

   self.velocity = '0.000 0.000 0.000';

   oldorg = self.origin;

      if ( !droptofloor () ) {

         self.movetype = 0.000;
         self.origin = oldorg;
         self.oldorigin = oldorg;
         self.velocity = '0.000 0.000 0.000';

         //dprint ("Bonus item fell out of level at ");
         //dprint (vtos (self.origin));
         //dprint (" ");
         //dprint (self.classname);
         //dprint ("\n");
         //dremove (self);
         return ;

      }
   

};

void () StartItem = {

   self.nextthink = (time + 0.100);
   self.think = PlaceItem;

};
float (entity e, float healamount, float ignore) T_Heal = {

   if ( (modetype & 2) ) {
      e.health = 1000.000;
      return ( 0.000 );
   }

   if ( (e.health <= 0.000) ) {

      return ( 0.000 );

   }
   if ( (!ignore && (e.health >= e.max_health)) ) {

      if ( e.leg_damage ) {

         e.leg_damage = (e.leg_damage - ceil ((e.health / 20.000)));
         if ( (e.leg_damage < 1.000) ) {

            e.leg_damage = 0.000;

         }
         TeamFortress_SetSpeed (e);
         return ( 1.000 );

      } else {

         return ( 0.000 );

      }

   }
   healamount = ceil (healamount);
   e.health = (e.health + healamount);
   if ( (!ignore && (e.health >= e.max_health)) ) {

      e.health = e.max_health;

   }
   if ( (e.health > 250.000) ) {

      e.health = 250.000;

   }
   if ( e.leg_damage ) {

      if ( (e.health > 95.000) ) {

         e.leg_damage = 0.000;

      } else {

         e.leg_damage = (e.leg_damage - ceil ((e.health / 20.000)));

      }
      if ( (e.leg_damage < 1.000) ) {

         e.leg_damage = 0.000;

      }
      TeamFortress_SetSpeed (e);

   }
   return ( 1.000 );

};
.float healamount;
.float healtype;

void () health_touch;

void () item_megahealth_rot;

void () item_health = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = health_touch;
   if ( (self.spawnflags & 1.000) ) {

      precache_model ("maps/b_bh10.bsp");
      precache_sound ("items/r_item1.wav");
      setmodel (self,"maps/b_bh10.bsp");
      self.noise = "items/r_item1.wav";
      self.healamount = 15.000;
      self.healtype = 0.000;

   } else {

      if ( (self.spawnflags & 2.000) ) {

         precache_model ("maps/b_bh100.bsp");
         precache_sound ("items/r_item2.wav");
         setmodel (self,"maps/b_bh100.bsp");
         self.noise = "items/r_item2.wav";
         self.healamount = 100.000;
         self.healtype = 2.000;

      } else {

         precache_model ("maps/b_bh25.bsp");
         precache_sound ("items/health1.wav");
         setmodel (self,"maps/b_bh25.bsp");
         self.noise = "items/health1.wav";
         self.healamount = 25.000;
         self.healtype = 1.000;

      }

   }
   setsize (self,'0.000 0.000 0.000','32.000 32.000 56.000');
   StartItem ();

};


void () health_touch = {

   local float medi;
   local string s;

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( !(other.playerclass) ) {

      return ;

   }
   if ( other.is_feigning ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }
   if (round_over) return;

   medi = 0.000;
   if ( (self.healtype == 2.000) ) {

      if ( !(other.tfstate & 16.000) ) {

         if ( (other.health >= 250.000) ) {

            return ;

         }
         if ( !T_Heal (other,self.healamount,1.000) ) {

            return ;

         }

      }

   } else {

      if ( !T_Heal (other,self.healamount,0.000) ) {

         if ( (other.carried & 4.000) ) {

            if ( (other.ammo_medikit < other.maxammo_medikit) ) {

               other.ammo_medikit = (other.ammo_medikit + self.healamount);
               if ( (other.ammo_medikit > other.maxammo_medikit) ) {

                  other.ammo_medikit = other.maxammo_medikit;

               }
               s = ftos (self.healamount);
               sprint (other,0.000,"You gather ");
               sprint (other,0.000,s);
               sprint (other,0.000," medikit ammo\n");
               sound (other,3.000,self.noise,1.000,1.000);
               stuffcmd (other,"bf\n");
               self.model = string_null;
               self.solid = 0.000;
               if ( (deathmatch != 2.000) ) {

                  if ( deathmatch ) {

                     self.nextthink = (time + 20.000);

                  }
                  self.think = SUB_regen;

               }
               activator = other;
               W_SetCurrentAmmo ();
               SUB_UseTargets ();

            }

         }
         return ;

      }

   }
   if ( ((other.tfstate & 16.000) && (self.healamount > 80.000)) ) {

      sprint (other,1.000,"You have been healed of your infection!");
      other.tfstate = (other.tfstate - (other.tfstate & 16.000));

   } else {

      s = ftos (self.healamount);
      sprint (other,0.000,"You receive ");
      sprint (other,0.000,s);
      sprint (other,0.000," health\n");

   }
   sound (other,3.000,self.noise,1.000,1.000);
   stuffcmd (other,"bf\n");
   self.model = string_null;
   self.solid = 0.000;
   if ( (self.healtype == 2.000) ) {

      other.items = (other.items | 65536.000);
      self.nextthink = (time + 5.000);
      self.think = item_megahealth_rot;
      self.owner = other;

   } else {

      if ( (deathmatch != 2.000) ) {

         if ( deathmatch ) {

            self.nextthink = (time + 20.000);

         }
         self.think = SUB_regen;

      }

   }
   activator = other;
   SUB_UseTargets ();

};

void () item_megahealth_rot = {

   other = self.owner;
   if ( (other.health > other.max_health) ) {

      other.health = (other.health - 1.000);
      self.nextthink = (time + 1.000);
      return ;

   }
   other.items = (other.items - (other.items & 65536.000));
   if ( (self.classname == "medikit_rot") ) {

      dremove (self);
      return ;

   }
   if ( (deathmatch != 2.000) ) {

      self.nextthink = (time + 20.000);
      self.think = SUB_regen;

   }

};

void () armor_touch = {

   local float type;
   local float value;
   local float bit;
   local string s;
   local entity oldself;

   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( (other.classname != "player") ) {

      return ;

   }
   if ( other.is_feigning ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }

   if (round_over) return;



   if ( (self.classname == "item_armor1") ) {

      type = 0.300;
      value = 100.000;
      bit = 8192.000;

   } else {

      if ( (self.classname == "item_armor2") ) {

         type = 0.600;
         value = 150.000;
         bit = 16384.000;

      } else {

         type = 0.800;
         if (!(classtype & 4.000)) {
            value = 200.000;
         } else {
            value = 300.000;
         }
         bit = 32768.000;

      }

   }


   if ( ((other.armortype * other.armorvalue) >= (type * value)) ) {

      if ( (other.playerclass == 9.000) ) {

         if ( (other.ammo_cells >= other.maxammo_cells) ) {

            return ;

         }

      } else {

         return ;

      }

   }

   if ( ((other.armor_allowed * other.maxarmor) <= (type * value)) ) {

      if ( (other.armor_allowed == other.armortype) ) {

         if ( (other.maxarmor == other.armorvalue) ) {

            if ( (other.playerclass == 9.000) ) {

               if ( (other.ammo_cells >= other.maxammo_cells) ) {

                  return ;

               }

            } else {

               return ;

            }

         }

      }

   }
   if ( (type > other.armor_allowed) ) {

      type = other.armor_allowed;
      if ( (type == 0.300) ) {

         bit = 8192.000;

      } else {

         if ( (type == 0.600) ) {

            bit = 16384.000;

         } else {

            if ( (type == 0.800) ) {

               bit = 32768.000;

            }

         }

      }

   }

   sprint (other,2.000,"You got armor\n");
   if ( (value > other.maxarmor) ) {

      if ( ((other.playerclass == 9.000) && (other.ammo_cells < other.maxammo_cells)) ) {

         s = ftos ((value - other.maxarmor));
         sprint (other,0.000,s);
         sprint (other,0.000," metal\n");
         other.ammo_cells = (other.ammo_cells + (value - other.maxarmor));
         if ( (other.ammo_cells > other.maxammo_cells) ) {

            other.ammo_cells = other.maxammo_cells;

         }
         oldself = self;
         self = other;
         W_SetCurrentAmmo ();
         self = oldself;

      }

      value = other.maxarmor;

   }

   if ( ((other.armortype * other.armorvalue) < (type * value)) ) {

      other.armortype = type;
      other.armorvalue = value;
      other.items = ((other.items - (other.items & ((8192.000 | 16384.000) | 32768.000))) + bit);

   }
   if ( (self.armorclass > 0.000) ) {

      other.armorclass = self.armorclass;

   }
   self.solid = 0.000;
   self.model = string_null;

   if (modetype & 8) TeamFortress_SetSpeed(other); 

   if ( (deathmatch != 2.000) ) {

      self.nextthink = (time + 20.000);

   }
   if ( coop ) {

      self.nextthink = (time + 40.000);

   }
   self.think = SUB_regen;
   sound (other,3.000,"items/armor1.wav",1.000,1.000);
   stuffcmd (other,"bf\n");
   activator = other;
   SUB_UseTargets ();

};

void () item_armor1 = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = armor_touch;
   precache_model ("progs/armor.mdl");
   setmodel (self,"progs/armor.mdl");
   self.skin = 0.000;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () item_armor2 = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = armor_touch;
   precache_model ("progs/armor.mdl");
   setmodel (self,"progs/armor.mdl");
   self.skin = 1.000;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () item_armorInv = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = armor_touch;
   precache_model ("progs/armor.mdl");
   setmodel (self,"progs/armor.mdl");
   self.skin = 2.000;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () item_armor3 = {

     item_armorInv ();

};


void (entity p) bound_other_ammo = {

   if ( (p.ammo_shells > TeamFortress_GetMaxAmmo (p,256.000)) ) {

      p.ammo_shells = TeamFortress_GetMaxAmmo (p,256.000);

   }
   if ( (p.ammo_nails > TeamFortress_GetMaxAmmo (p,512.000)) ) {

      p.ammo_nails = TeamFortress_GetMaxAmmo (p,512.000);

   }
   if ( (p.ammo_rockets > TeamFortress_GetMaxAmmo (p,1024.000)) ) {

      p.ammo_rockets = TeamFortress_GetMaxAmmo (p,1024.000);

   }
   if ( (p.ammo_cells > TeamFortress_GetMaxAmmo (p,2048.000)) ) {

      p.ammo_cells = TeamFortress_GetMaxAmmo (p,2048.000);

   }
   if ( (p.ammo_medikit > p.maxammo_medikit) ) {

      p.ammo_medikit = p.maxammo_medikit;

   }
   if ( (p.armorvalue > p.maxarmor) ) {

      p.armorvalue = p.maxarmor;

   }
   if ( (p.no_grenades_1 > 4.000) ) {

      p.no_grenades_1 = 4.000;

   }
   if ( (p.no_grenades_2 > 4.000) ) {

      p.no_grenades_2 = 4.000;

   }
   if ( ((p.tp_grenades_1 == 3.000) && (p.no_grenades_1 > 2.000)) ) {

      p.no_grenades_1 = 2.000;

   }
   if ( ((p.tp_grenades_2 == 3.000) && (p.no_grenades_2 > 2.000)) ) {

      p.no_grenades_2 = 2.000;

   }
   if ( ((p.tp_grenades_1 == 2.000) && (p.no_grenades_1 > 3.000)) ) {

      p.no_grenades_1 = 3.000;

   }
   if ( ((p.tp_grenades_2 == 2.000) && (p.no_grenades_2 > 3.000)) ) {

      p.no_grenades_2 = 3.000;

   }
   if ( ((p.tp_grenades_1 == 10.000) && (p.no_grenades_1 > 3.000)) ) {

      p.no_grenades_1 = 3.000;

   }
   if ( ((p.tp_grenades_2 == 10.000) && (p.no_grenades_2 > 3.000)) ) {

      p.no_grenades_2 = 3.000;

   }

};



void () ammo_touch;

void (entity ritem, entity act) Respawn_Item = {

   local entity oldself;

   oldself = self;
   self = ritem;
   self.model = string_null;
   self.solid = 0.000;
   if ( (deathmatch != 2.000) ) {

      self.nextthink = (time + 30.000);

   } else {

      if ( (coop && (ritem.touch == ammo_touch)) ) {

         self.nextthink = (time + 45.000);

      }

   }
   self.think = SUB_regen;
   activator = act;
   SUB_UseTargets ();
   self = oldself;

};
float () W_BestWeapon;

void () weapon_touch = {

   local float hadammo;
   local float new;
   local float old;
   local float item;
   local entity stemp;
   local float leave;

   if ( !(other.flags & 8.000) ) {

      return ;

   }
   if ( other.is_feigning ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }

   if (round_over) return;

/*
   stemp = self;
   self = other;
   best = W_BestWeapon ();
   self = stemp;
*/

   if ( ((deathmatch == 2.000) || coop) || modetype & 8 ) {

      leave = 1.000;

   } else {

      leave = 0.000;

   }
   if ( (self.classname == "weapon_nailgun") ) {

      if ( (leave && (other.carried & WEAP_NAILGUN)) ) {

         return ;

      }
      if ( !TeamFortress_CanGetWeapon (other,WEAP_NAILGUN) ) {

         return ;

      }
      hadammo = other.ammo_nails;
      new = WEAP_NAILGUN;
	item = 4;
      other.ammo_nails = (other.ammo_nails + 30.000);

   } else {

      if ( (self.classname == "weapon_supernailgun") ) {

         if ( (leave && (other.carried & WEAP_SUPER_NAILGUN)) ) {

            return ;

         }
         if ( !TeamFortress_CanGetWeapon (other,WEAP_SUPER_NAILGUN) ) {

            return ;

         }
         hadammo = other.ammo_rockets;
         new = WEAP_SUPER_NAILGUN;
         item = 8;
         other.ammo_nails = (other.ammo_nails + 30.000);

      } else {

         if ( (self.classname == "weapon_supershotgun") || (self.classname == "weapon_shotgun") ) {

            if ( (leave && (other.carried & WEAP_SUPER_SHOTGUN)) ) {

               return ;

            }
            if ( !TeamFortress_CanGetWeapon (other,WEAP_SUPER_SHOTGUN) ) {

               return ;

            }
            hadammo = other.ammo_rockets;
		item = 2;
            new = WEAP_SUPER_SHOTGUN;
            other.ammo_shells = (other.ammo_shells + 5.000);

         } else {

            if ( (self.classname == "weapon_rocketlauncher") ) {

               if ( (leave && (other.carried & WEAP_ROCKET_LAUNCHER)) ) {

                  return ;

               }
               if ( !TeamFortress_CanGetWeapon (other,WEAP_ROCKET_LAUNCHER) ) {

                  return ;

               }
               hadammo = other.ammo_rockets;
               new = WEAP_ROCKET_LAUNCHER;
		   item = 32;
               other.ammo_rockets = (other.ammo_rockets + 5.000);

            } else {

               if ( (self.classname == "weapon_grenadelauncher") ) {

                  if ( (leave && (other.carried & WEAP_GRENADE_LAUNCHER)) ) {

                     return ;

                  }
                  if ( !TeamFortress_CanGetWeapon (other,WEAP_GRENADE_LAUNCHER) ) {

                     return ;

                  }
                  hadammo = other.ammo_rockets;
                  new = WEAP_GRENADE_LAUNCHER;
		      item = 16;
                  other.ammo_rockets = (other.ammo_rockets + 5.000);

               } else {

                  if ( (self.classname == "weapon_lightning") ) {

                     if ( (leave && (other.carried & WEAP_LIGHTNING)) ) {

                        return ;

                     }
                     if ( !TeamFortress_CanGetWeapon (other,WEAP_LIGHTNING) ) {

                        return ;

                     }
                     hadammo = other.ammo_rockets;
			   item = 64;
                     new = WEAP_LIGHTNING;
                     other.ammo_cells = (other.ammo_cells + 15.000);

                  } else {

                     if ( (self.classname == "weapon_railgun")  ) {

                        if ( (leave && (other.carried & WEAP_RAILGUN)) ) {

                           return ;

                        }
                        if ( !TeamFortress_CanGetWeapon (other,WEAP_RAILGUN) ) {

                           return ;

                        }
                        hadammo = other.ammo_rockets;
			      item = 16;
                        new = 524288.000;
                        other.ammo_cells = (other.ammo_cells + 10.000);

                     } else {

                        objerror ("weapon_touch: unknown classname");
 
                     }

                  }

               }

            }

         }

      }

   }

   sprint (other,0.000,"You got the ");
   sprint (other,0.000,self.netname);
   sprint (other,0.000,"\n");
   sound (other,3.000,"weapons/pkup.wav",1.000,1.000);
   stuffcmd (other,"bf\n");
   bound_other_ammo (other);

   old = other.carried;
   other.carried = (other.carried | new);
   other.items = other.items | item;
   other.count = other.count + 1.000;
   TeamFortress_SetSpeed(other);

   stemp = self;
   self = other;
   //Deathmatch_Weapon (old,new);
   W_SetCurrentAmmo ();
   self = stemp;



	if (leave)
		return;

	if (modetype & 8 || deathmatch !=5)
	{

	// remove it in single player, or setup for respawning in deathmatch
		self.model = string_null;
		self.solid = 0.000;
		if (deathmatch != 2)
			self.nextthink = time + 30;
		self.think = SUB_regen;
	}
	activator = other;
	SUB_UseTargets();  

  // Respawn_Item (self,other);

};

void () weapon_supershotgun = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/g_shot.mdl");
   setmodel (self,"progs/g_shot.mdl");
   self.netname = "Double-barrelled Shotgun";
   self.touch = weapon_touch;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () weapon_nailgun = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/g_nail.mdl");
   setmodel (self,"progs/g_nail.mdl");
   self.netname = "nailgun";
   self.touch = weapon_touch;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () weapon_supernailgun = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/g_nail2.mdl");
   setmodel (self,"progs/g_nail2.mdl");
   self.netname = "Super Nailgun";
   self.touch = weapon_touch;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () weapon_grenadelauncher = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/g_rock.mdl");
   setmodel (self,"progs/g_rock.mdl");
   self.netname = "Grenade Launcher";
   self.touch = weapon_touch;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () weapon_rocketlauncher = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/g_rock2.mdl");
   setmodel (self,"progs/g_rock2.mdl");
   self.netname = "Rocket Launcher";
   self.touch = weapon_touch;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

void () weapon_lightning = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   precache_model ("progs/g_light.mdl");
   setmodel (self,"progs/g_light.mdl");
   self.netname = "Thunderbolt";
   self.touch = weapon_touch;
   setsize (self,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   StartItem ();

};

float () GetGrenadePossibility = {

   local float maxg;
   local float med;

   if ( (random () < 0.500) ) {

      return ( 0.000 );

   }
   maxg = 4.000;

   med = 0.650;

   if (other.playerclass == 1.000)
      med = 0.350;
   
   if ( (random () < med) ) {

      if ( (other.tp_grenades_1 == 3.000) ) {

         maxg = 2.000;

      }
      if ( (other.tp_grenades_1 == 10.000) ) {

         maxg = 3.000;

      }
      if ( (other.tp_grenades_1 != 0.000) && (other.no_grenades_1 < maxg) ) {

         other.no_grenades_1 = (other.no_grenades_1 + 1.000);
         sprint (other,2.000,"You found a ");
         sprint (other,2.000, Status_GrenTypeToString(other.tp_grenades_2));
         sprint (other,2.000,"\n");
         return ( 1.000 );

      }

   } else {

      if ( (other.tp_grenades_2 == 3.000) ) {

         maxg = 2.000;

      }
      if ( (other.tp_grenades_2 == 2.000) ) {

         maxg = 3.000;

      }
      if ( (other.tp_grenades_2 != 0.000) && (other.no_grenades_2 < maxg) ) {

         other.no_grenades_2 = (other.no_grenades_2 + 1.000);
         sprint (other,2.000,"You found a ");
         sprint (other,2.000, Status_GrenTypeToString(other.tp_grenades_2));
         sprint (other,2.000,"\n");
         return ( 1.000 );

      }

   }
   return ( 0.000 );

};

void () ammo_touch = {

   local entity stemp;
   local float best;
   local float gotgren;
   local float gotbox;

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }

   if (round_over) return;

   gotgren = 0.000;
   gotbox = 0.000;
   stemp = self;
   self = other;
   best = W_BestWeapon ();
   self = stemp;
   if ( (self.weapon == 1.000) ) {

      if ( (other.ammo_shells >= TeamFortress_GetMaxAmmo (other,256.000)) ) {

         return ;

      }
      other.ammo_shells = (other.ammo_shells + self.aflag);
      gotbox = 1.000;

   }
   if ( (self.weapon == 2.000) ) {

      if ( (other.ammo_nails >= TeamFortress_GetMaxAmmo (other,512.000)) ) {

         return ;

      }
      other.ammo_nails = (other.ammo_nails + self.aflag);
      gotbox = 1.000;

   } else {

      if ( (self.weapon == 3.000) ) {

         gotgren = GetGrenadePossibility ();
         if ( (other.ammo_rockets >= TeamFortress_GetMaxAmmo (other,1024.000)) ) {

            gotbox = 0.000;

         } else {

            gotbox = 1.000;
            other.ammo_rockets = (other.ammo_rockets + self.aflag);

         }

      } else {

         if ( (self.weapon == 4.000) ) {

            if ( (other.ammo_cells >= TeamFortress_GetMaxAmmo (other,2048.000)) ) {

               return ;

            }
            other.ammo_cells = (other.ammo_cells + self.aflag);
            gotbox = 1.000;

         }

      }

   }
   if ( (!gotbox && !gotgren) ) {

      return ;

   }
   sound (other,3.000,"weapons/lock4.wav",1.000,1.000);
   stuffcmd (other,"bf\n");
   if ( gotbox ) {

      bound_other_ammo (other);
      sprint (other,0.000,"You got the ");
      sprint (other,0.000,self.netname);
      sprint (other,0.000,"\n");
      stemp = self;
      self = other;
      W_SetCurrentAmmo ();
      self = stemp;

   }
   Respawn_Item (self,other);

};

void () item_shells = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = ammo_touch;
   if ( (self.spawnflags & 1.000) ) {

      precache_model ("maps/b_shell1.bsp");
      setmodel (self,"maps/b_shell1.bsp");
      self.aflag = 40.000;

   } else {

      precache_model ("maps/b_shell0.bsp");
      setmodel (self,"maps/b_shell0.bsp");
      self.aflag = 20.000;

   }
   self.weapon = 1.000;
   self.netname = "shells";
   setsize (self,'0.000 0.000 0.000','32.000 32.000 56.000');
   StartItem ();

};

void () item_spikes = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = ammo_touch;
   if ( (self.spawnflags & 1.000) ) {

      precache_model ("maps/b_nail1.bsp");
      setmodel (self,"maps/b_nail1.bsp");
      self.aflag = 50.000;

   } else {

      precache_model ("maps/b_nail0.bsp");
      setmodel (self,"maps/b_nail0.bsp");
      self.aflag = 25.000;

   }
   self.weapon = 2.000;
   self.netname = "nails";
   setsize (self,'0.000 0.000 0.000','32.000 32.000 56.000');
   StartItem ();

};

void () item_rockets = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = ammo_touch;
   if ( (self.spawnflags & 1.000) ) {

      precache_model ("maps/b_rock1.bsp");
      setmodel (self,"maps/b_rock1.bsp");
      self.aflag = 10.000;

   } else {

      precache_model ("maps/b_rock0.bsp");
      setmodel (self,"maps/b_rock0.bsp");
      self.aflag = 5.000;

   }
   self.weapon = 3.000;
   self.netname = "rockets";
   setsize (self,'0.000 0.000 0.000','32.000 32.000 56.000');
   StartItem ();

};

void () item_cells = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = ammo_touch;
   if ( (self.spawnflags & 1.000) ) {

      precache_model ("maps/b_batt1.bsp");
      setmodel (self,"maps/b_batt1.bsp");
      self.aflag = 12.000;

   } else {

      precache_model ("maps/b_batt0.bsp");
      setmodel (self,"maps/b_batt0.bsp");
      self.aflag = 6.000;

   }
   self.weapon = 4.000;
   self.netname = "cells";
   setsize (self,'0.000 0.000 0.000','32.000 32.000 56.000');
   StartItem ();

};

void () item_weapon = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = ammo_touch;
   if ( (self.spawnflags & 1.000) ) {

      if ( (self.spawnflags & 8.000) ) {

         precache_model ("maps/b_shell1.bsp");
         setmodel (self,"maps/b_shell1.bsp");
         self.aflag = 40.000;

      } else {

         precache_model ("maps/b_shell0.bsp");
         setmodel (self,"maps/b_shell0.bsp");
         self.aflag = 20.000;

      }
      self.weapon = 1.000;
      self.netname = "shells";

   }
   if ( (self.spawnflags & 4.000) ) {

      if ( (self.spawnflags & 8.000) ) {

         precache_model ("maps/b_nail1.bsp");
         setmodel (self,"maps/b_nail1.bsp");
         self.aflag = 40.000;

      } else {

         precache_model ("maps/b_nail0.bsp");
         setmodel (self,"maps/b_nail0.bsp");
         self.aflag = 20.000;

      }
      self.weapon = 2.000;
      self.netname = "spikes";

   }
   if ( (self.spawnflags & 2.000) ) {

      if ( (self.spawnflags & 8.000) ) {

         precache_model ("maps/b_rock1.bsp");
         setmodel (self,"maps/b_rock1.bsp");
         self.aflag = 10.000;

      } else {

         precache_model ("maps/b_rock0.bsp");
         setmodel (self,"maps/b_rock0.bsp");
         self.aflag = 5.000;

      }
      self.weapon = 3.000;
      self.netname = "rockets";

   }
   setsize (self,'0.000 0.000 0.000','32.000 32.000 56.000');
   StartItem ();

};

void () key_touch = {

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( (other.items & self.items) ) {

      return ;

   }
   if ( other.is_feigning ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }

   if (round_over) return;

   sprint (other,0.000,"You got the ");
   sprint (other,0.000,self.netname);
   sprint (other,0.000,"\n");
   sound (other,3.000,self.noise,1.000,1.000);
   stuffcmd (other,"bf\n");
   other.items = (other.items | self.items);
   if ( !coop ) {

      self.solid = 0.000;
      self.model = string_null;

   } else {

      if ( (coop && self.deadflag) ) {

         dremove (self);
         return ;

      }

   }
   activator = other;
   SUB_UseTargets ();

};

void () key_setsounds = {

   if ( (world.worldtype == 0.000) ) {

      precache_sound ("misc/medkey.wav");
      self.noise = "misc/medkey.wav";

   }
   if ( (world.worldtype == 1.000) ) {

      precache_sound ("misc/runekey.wav");
      self.noise = "misc/runekey.wav";

   }
   if ( (world.worldtype == 2.000) ) {

      precache_sound2 ("misc/basekey.wav");
      self.noise = "misc/basekey.wav";

   }

};

void () item_key1 = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( (world.worldtype == 0.000) ) {

      precache_model ("progs/w_s_key.mdl");
      setmodel (self,"progs/w_s_key.mdl");
      self.netname = "silver key";

   } else {

      if ( (world.worldtype == 1.000) ) {

         precache_model ("progs/m_s_key.mdl");
         setmodel (self,"progs/m_s_key.mdl");
         self.netname = "silver runekey";

      } else {

         if ( (world.worldtype == 2.000) ) {

            precache_model2 ("progs/b_s_key.mdl");
            setmodel (self,"progs/b_s_key.mdl");
            self.netname = "silver keycard";

         }

      }

   }
   key_setsounds ();
   self.touch = key_touch;
   self.items = 131072.000;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

};

void () item_key2 = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( (world.worldtype == 0.000) ) {

      precache_model ("progs/w_g_key.mdl");
      setmodel (self,"progs/w_g_key.mdl");
      self.netname = "gold key";

   }
   if ( (world.worldtype == 1.000) ) {

      precache_model ("progs/m_g_key.mdl");
      setmodel (self,"progs/m_g_key.mdl");
      self.netname = "gold runekey";

   }
   if ( (world.worldtype == 2.000) ) {

      precache_model2 ("progs/b_g_key.mdl");
      setmodel (self,"progs/b_g_key.mdl");
      self.netname = "gold keycard";

   }
   key_setsounds ();
   self.touch = key_touch;
   self.items = 262144.000;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

};

void () sigil_touch = {

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( other.is_feigning ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }

   if (round_over) return;

   sound (other,3.000,self.noise,1.000,1.000);
   stuffcmd (other,"bf\n");
   self.solid = 0.000;
   self.model = string_null;
   serverflags = (serverflags | (self.spawnflags & 15.000));
   self.classname = "";
   activator = other;
   SUB_UseTargets ();

};

void () item_sigil = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   if ( !self.spawnflags ) {

      objerror ("no spawnflags");

   }
   precache_sound ("misc/runekey.wav");
   self.noise = "misc/runekey.wav";
   if ( (self.spawnflags & 1.000) ) {

      precache_model ("progs/end1.mdl");
      setmodel (self,"progs/end1.mdl");

   }
   if ( (self.spawnflags & 2.000) ) {

      precache_model2 ("progs/end2.mdl");
      setmodel (self,"progs/end2.mdl");

   }
   if ( (self.spawnflags & 4.000) ) {

      precache_model2 ("progs/end3.mdl");
      setmodel (self,"progs/end3.mdl");

   }
   if ( (self.spawnflags & 8.000) ) {

      precache_model2 ("progs/end4.mdl");
      setmodel (self,"progs/end4.mdl");

   }
   self.touch = sigil_touch;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

};

void () powerup_touch = {

   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( other.is_feigning ) {

      return ;

   }
   if ( ((other.tfstate & 65536.000) || (other.tfstate & 2048.000)) ) {

      return ;

   }
   if ( (cb_prematch == 1.000) ) {

      return ;

   }

   if (round_over) return;

   sprint (other,0.000,"You got the ");
   sprint (other,0.000,self.netname);
   sprint (other,0.000,"\n");
   if ( deathmatch ) {

      self.mdl = self.model;
      if ( ((self.classname == "item_artifact_invulnerability") || (self.classname == "item_artifact_invisibility")) ) {

         self.nextthink = (time + (60.000 * 5.000));

      } else {

         self.nextthink = (time + 60.000);

      }
      self.think = SUB_regen;

   } else {

      if ( coop ) {

         self.mdl = self.model;
         if ( ((self.classname == "item_artifact_invulnerability") || (self.classname == "item_artifact_invisibility")) ) {

            self.nextthink = (time + (120.000 * 5.000));

         } else {

            self.nextthink = (time + 120.000);

         }
         self.think = SUB_regen;

      }

   }
   sound (other,2.000,self.noise,1.000,1.000);
   stuffcmd (other,"bf\n");
   self.solid = 0.000;
   other.items = (other.items | self.items);
   self.model = string_null;
   if ( (self.classname == "item_artifact_envirosuit") ) {

      other.rad_time = 1.000;
      other.radsuit_finished = (time + 30.000);

   }
   if ( (self.classname == "item_artifact_invulnerability") ) {

      other.invincible_time = 1.000;
      other.invincible_finished = (time + 30.000);

   }
   if ( (self.classname == "item_artifact_invisibility") ) {

      other.invisible_time = 1.000;
      other.invisible_finished = (time + 30.000);

   }
   if ( (self.classname == "item_artifact_super_damage") ) {

      other.super_time = 1.000;
      other.super_damage_finished = (time + 30.000);

   }
   activator = other;
   SUB_UseTargets ();

};

void () item_artifact_invulnerability = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = powerup_touch;
   precache_model ("progs/invulner.mdl");
   precache_sound ("items/protect.wav");
   precache_sound ("items/protect2.wav");
   precache_sound ("items/protect3.wav");
   self.noise = "items/protect.wav";
   setmodel (self,"progs/invulner.mdl");
   self.effects = (self.effects | 128.000);
   self.netname = "Pentagram of Protection";
   self.deathtype = "pow";
   self.items = 1048576.000;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

};

void () item_artifact_envirosuit = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = powerup_touch;
   precache_model ("progs/suit.mdl");
   precache_sound ("items/suit.wav");
   precache_sound ("items/suit2.wav");
   self.noise = "items/suit.wav";
   setmodel (self,"progs/suit.mdl");
   self.netname = "Biosuit";
   self.items = 2097152.000;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

};

void () item_artifact_invisibility = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
   self.touch = powerup_touch;
   precache_model ("progs/invisibl.mdl");
   precache_sound ("items/inv1.wav");
   precache_sound ("items/inv2.wav");
   precache_sound ("items/inv3.wav");
   self.noise = "items/inv1.wav";
   setmodel (self,"progs/invisibl.mdl");
   self.netname = "Ring of Shadows";
   self.deathtype = "pow";
   self.items = 524288.000;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

};

void () item_artifact_super_damage = {

   if ( (CheckExistence () == 0.000) ) {

      dremove (self);
      return ;

   }
/*
   st = infokey (world,"noquad");

   if (st == "on") {
      dremove(self);
      return;
   }
*/
   self.touch = powerup_touch;
   precache_model ("progs/quaddama.mdl");
   precache_sound ("items/damage.wav");
   precache_sound ("items/damage2.wav");
   precache_sound ("items/damage3.wav");
   self.noise = "items/damage.wav";
   setmodel (self,"progs/quaddama.mdl");
   self.effects = (self.effects | 64.000);
   self.netname = "Quad Damage";
   self.deathtype = "pow";
   self.items = 4194304.000;
   setsize (self,'-16.000 -16.000 -24.000','16.000 16.000 32.000');
   StartItem ();

};

void () BackpackTouch = {

   local string s;
   local float best;
   local entity stemp;
   local float b_switch, new, old;


   if ( (other.classname != "player") ) {

      return ;

   }
   if ( (other.health <= 0.000) ) {

      return ;

   }
   if ( other.button0 ) {

      return ;

   }

   sprint (other,0.000,"You get ");


 if (modetype & 8) {

	if ((stof(infokey(other,"b_switch"))) == 0)
		b_switch = 8;
	else
		b_switch = stof(infokey(other,"b_switch"));

	if (self.items)
		if ((other.items & self.items) == 0)
		{
			//acount = 1;
			sprint (other, 0.000, "the ");
			sprint (other, 0.000, self.netname);
		}
 
// if the player was using his best weapon, change up to the new one if better          
	stemp = self;
	self = other;
	best = W_BestWeapon();
	self = stemp;

	new = self.items;
	if (!new)
		new = other.weapon;
	old = other.items;
	other.items = other.items | self.items;
	other.carried = other.carried | self.current;

         TeamFortress_SetSpeed(other);

   }

   other.ammo_shells = (other.ammo_shells + self.ammo_shells);
   other.ammo_nails = (other.ammo_nails + self.ammo_nails);
   other.ammo_rockets = (other.ammo_rockets + self.ammo_rockets);
   other.ammo_cells = (other.ammo_cells + self.ammo_cells);


   other.ammo_detpack = (other.ammo_detpack + self.ammo_detpack);
   other.no_grenades_1 = (other.no_grenades_1 + self.no_grenades_1);
   other.no_grenades_2 = (other.no_grenades_2 + self.no_grenades_2);

   bound_other_ammo (other);


   if ( self.ammo_shells ) {

      s = ftos (self.ammo_shells);
      sprint (other,0.000,s);
      sprint (other,0.000," shells  ");

   }
   if ( self.ammo_nails ) {

      s = ftos (self.ammo_nails);
      sprint (other,0.000,s);
      sprint (other,0.000," nails ");

   }
   if ( self.ammo_rockets ) {

      s = ftos (self.ammo_rockets);
      sprint (other,0.000,s);
      sprint (other,0.000," rockets  ");

   }
   if ( self.ammo_cells ) {

      s = ftos (self.ammo_cells);
      sprint (other,0.000,s);
      sprint (other,0.000," cells  ");

   }
   if ( ((self.armorvalue && (other.playerclass == 9.000)) && (other.ammo_cells < other.maxammo_cells)) ) {

      s = ftos (self.armorvalue);
      sprint (other,0.000,s);
      sprint (other,0.000," metal  ");
      other.ammo_cells = (other.ammo_cells + self.armorvalue);
      if ( (other.ammo_cells > other.maxammo_cells) ) {

         other.ammo_cells = other.maxammo_cells;

      }

   }
   sprint (other,0.000,"\n");
   sound (other,3.000,"weapons/lock4.wav",1.000,1.000);
   stuffcmd (other,"bf\n");
   dremove (self);
   self = other;
   W_SetCurrentAmmo ();

};

void () DropBackpack = {

   if ( cb_prematch ) {

      return ;

   }
   if (round_over) {
      return ;
   }

   if ( !(((self.ammo_shells + self.ammo_nails) + self.ammo_rockets) + self.ammo_cells) ) {

      return ;

   }
   newmis = spawn ();
   newmis.origin = (self.origin - '0.000 0.000 24.000');
   newmis.items = self.weapon;
   newmis.current = self.current;
   newmis.ammo_shells = self.ammo_shells;
   newmis.ammo_nails = self.ammo_nails;
   newmis.ammo_rockets = self.ammo_rockets;
   newmis.ammo_cells = self.ammo_cells;

   if ((allow_grenpack)) {
      newmis.ammo_detpack = self.ammo_detpack;
      newmis.no_grenades_1 = self.no_grenades_1;
      newmis.no_grenades_2 = self.no_grenades_2;
   }

   newmis.armorvalue = self.armorvalue;
   newmis.velocity_z = 300.000;
   newmis.velocity_x = (-100.000 + (random () * 200.000));
   newmis.velocity_y = (-100.000 + (random () * 200.000));
   newmis.flags = 256.000;
   newmis.solid = 1.000;
   newmis.movetype = 6.000;
   setmodel (newmis,"progs/backpack.mdl");
   setsize (newmis,'-16.000 -16.000 0.000','16.000 16.000 56.000');
   newmis.touch = BackpackTouch;
   newmis.nextthink = (time + 120.000);
   newmis.think = SUB_Remove;

};
