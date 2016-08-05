///scr_BSP_Create_Objects(grid, tile_size, room_count, wall, door);

show_debug_message("CREATE OBJECTS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

var grid_w = ds_grid_width(argument[0]);
var grid_h = ds_grid_height(argument[0]);
var ts = argument[1];
var cc = argument[2];

// This script is for creating the objects in your room. How you 
// do this will dpeend largely on what you want and how your game works.
// For convenience it contains the most required objects by the BSP 
// engine, which is walls and doors, but you can add further objects easily.
// For example, you can add values directly to the DS_grid using the 
// the "count" variable and the room array "r" (see the create event 
// of obj_BSP_Generate for more info), and then create the instances 
// by adding a further case.

// To show you how this would work, the DEMO will create a "player" object 
// in the center of a random room, as well as spawn a number of "enemy"
// objects in random rooms. The player object is hard-coded into the script, 
// simply because you always need to have a player object, but can easily be 
// substituted for a player spawner or whatever is required.

// Note that all objects that you wish to spawn WITHOUT the possibility of 
// an overlap should be children of the object "obj_BSP_Collision_Parent"
// as the spwning scripts use this for checking. If having two instances 
// occupy the same space is not an issue, then you need not use this parent.

// This script also shows how you can use TILES to mark the floors of the 
// rooms and the corridors. This is an optional extra but works well and 
// gives a nice touch to the game.


// Create the local vars
var tile = -1;                                                  // This will hold the tile ID
var tile_w = 0;                                                 // This will hold the tile resource width
var tile_h = 0;                                                 // This will hold the tile resource height
var pos = irandom(cc - 1);                                      // This will be the room the player is pawned in
var xx = r[pos, 0] * ts;                                        // The x position of the room to spawn in (and convert to pixels multiplying by the grid tile size)
var yy = r[pos, 1] * ts;                                        // The y position of the room to spawn in
var ww = (r[pos, 2] div 2) * ts;                                // Now get the half width of the room
var hh = (r[pos, 3] div 2) * ts;                                // Now get the half height of the room
instance_create(xx + ww - 8, yy + hh - 8, obj_DEMO_Player);     // Create the player!

// The following adds the walls, doors and floor tiles for the room using loops.
// As you can see we have two sprites for horizontal and vertical doors (you can 
// easily change this), and we use two different tiles for the floors and corridors.
// This gives a nice graphic touch but is not necessary. Note that the tiles do not 
// have to be square, nor power of two, and the script will stretch them to fit the 
// grid size.
for (var i = 0; i < grid_w; i++;)
{
for (var j = 0; j < grid_h; j++;)
    {
    var tile = -1;
    switch(ds_grid_get(argument[0], i, j))
        {
        case -4: // Add floor tiles
            tile_w = background_get_width(bck_Floor);
            tile_h = background_get_height(bck_Floor);
            tile = tile_add(bck_Floor, 0, 0, tile_w, tile_h, i * ts, j * ts, 20000);
            break;
        case 100: //Create wall objects
        //case 150: //Uncomment for the outside edge of the WHOLE room.
            instance_create(i * ts, j * ts, argument[3]);
            break;
        case 200: // Add corridor tiles
            tile_w = background_get_width(bck_Corridor);
            tile_h = background_get_height(bck_Corridor);
            tile = tile_add(bck_Corridor, 0, 0, tile_w, tile_h, i * ts, j * ts, 20000);
            break;
        case 300: //Create horizontal door
            instance_create(i * ts, j * ts, argument[4]);
            //add a floor tile under the door
            tile_w = background_get_width(bck_Corridor);
            tile_h = background_get_height(bck_Corridor);
            tile = tile_add(bck_Corridor, 0, 0, tile_w, tile_h, i * ts, j * ts, 20000); //add a floor tile under the door
            break;
        case 301: //Create vertical door
            with (instance_create(i * ts, j * ts, argument[4])) image_index = 1;
            //add a floor tile under the door
            tile_w = background_get_width(bck_Corridor);
            tile_h = background_get_height(bck_Corridor);
            var tile = tile_add(bck_Corridor, 0, 0, tile_w, tile_h, i * ts, j * ts, 20000);
            break;
        }
    if tile != -1
        {
        // The following scales the tile to suit the global grid cell size.
        // It is not necessary and added for this demo, so you can remove it 
        // if you want to speed things up.
        if tile_w != ts || tile_h != ts
            {
            var xs = (ts / tile_w);
            var ys = (ts / tile_h);
            tile_set_scale(tile, xs, ys);
            }
        }
    }
}

// We now call another set of scripts to create different objects. These scripts 
// assume a couple of things:

// 1) the origin of the sprite for the instance being created has been CENTERED

// 2) the instance being created is NOT scaled, so if you need to scale the instance
// use a new sprite resource and scale that then assign it to the object.

// 3) the order in which you create things is VERY important. Those that don't require 
// collision checks (ie: don't use the BSP collision parent) should be created FIRST
// then any essential instances that MUST be in the game are created next (like the BOSS
// in the example script calls below), then finally any other instances. This is because
// the spawn scripts may not spawn 100% of all instances if the room area being spawned 
// in is too small for the number of instances being created. Imagine trying to spawn 
// 2000 enemies in a 5x5 room! 

// NOTE! These scripts given below are examples only to give you an idea of how to go 
// about things. You will have to adjust and change these script arguments to suit your 
// or write your own scripts and call them here...


// Spawn a potion object in every room area, including the player area. 
// Note that we do this BEFORE we spawn anything else, as it does NOT 
// use the BSP collision parent, and we want to spawn things over them.
scr_BSP_Populate_Rooms(obj_DEMO_Potion, cc, cc, -1, ts, true, true);

// Now spawn a room full of gold that is NOT the player room
var ran = irandom(cc - 1);
while (ran == pos) ran = irandom(cc - 1);
scr_BSP_Populate_Area(obj_DEMO_Gold, 20, ran, ts, false);

// Spawn a boss in a random room that is NOT the player room
var ran = irandom(cc - 1);
while (ran == pos) ran = irandom(cc - 1);
scr_BSP_Populate_Area(obj_DEMO_Boss, 1, ran, ts, true);
    
// Spawn 200 enemies randomly throughout the WHOLE maze, and not just one room
scr_BSP_Populate_Rooms(obj_DEMO_Enemy, 200, cc, pos, ts, false, false);

