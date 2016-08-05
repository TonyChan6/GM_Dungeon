///scr_NM_Create_Objects(bsp_grid, tile_size, count);

show_debug_message("Create The NM OBJECTS!!!!!!!!!!!!!!!!!!!");

// Copy From scr_BSP_Create_Objects(grid, tile_size, room_count, wall, door);

// -------------------------------------------------------------------------------

var grid_w = ds_grid_width(argument[0]);                        // The Map Grid
var grid_h = ds_grid_height(argument[0]);                       // The Map Grid
var ts = argument[1];                                           // Globe.tilesize
var cc = argument[2];                                           // Num of rooms

// Create the local vars
var tile = -1;                                                  // This will hold the tile ID
var tile_w = 32;                                                // This will hold the tile resource width
var tile_h = 32;                                                // This will hold the tile resource height
var pos = irandom(cc - 1);                                      // This will be the room the player is pawned in
var xx = (r[pos, 0]+1) * ts;                                        // The x position of the room to spawn in (and convert to pixels multiplying by the grid tile size)
var yy = (r[pos, 1]+1) * ts;                                        // The y position of the room to spawn in
var ww = (r[pos, 2] div 2) * ts;                                // Now get the half width of the room
var hh = (r[pos, 3] div 2) * ts;  
                              // Now get the half height of the room
//instance_create(xx + ww + 16 , yy + hh + 16 , obj_Player_Knight);         // Create the player!

if instance_exists(obj_Player_Knight)
{
    obj_Player_Knight.x = xx+ww+16;
    obj_Player_Knight.y = yy+hh+16;
}


// 地图内寻路
grid_path = mp_grid_create(0, 0, grid_w, grid_h, tile_w, tile_h);



/*
-4          - Empty grid cell (ie: "floor")
0 - 99      - A "room" number within the grid that hasn't been assigned
100         - A "wall" for a room area
150         - The outer "wall" of the whole room
200         - A "corridor" between rooms
300 - 301   - A "door" into a room area. 300 = horizontal door, 301 = vertical door
500 - 1000  - The pathfinder start points for making corridors
*/


var gg = argument[0];

// Add the tiles
for (var i = 0 ; i < grid_w ; i++ )
{
    for(var j = 0 ; j < grid_h ; j++ )
    {
        var tile = -1;

        //Draw Black
        if (ds_grid_get(argument[0], i ,j) != -4 && ( ds_grid_get(argument[0], i ,j) < 200 || ds_grid_get(argument[0], i ,j) > 400))
        {
            //tile_add(bg_walltiles2, ts*1 , ts*1 , tile_w, tile_h, i*ts-ts/2, j*ts-ts/2, 20000);
            tile_add(bg_walltiles2, ts*1 , ts*1 , tile_w, tile_h, i*ts, j*ts-ts/2+6, -5000);
            
            /// 地图内寻路
            mp_grid_add_cell(grid_path , i, j);
            
        }
        
        //Draw Wall Side
        if(  ds_grid_get(argument[0], i, j) == 100)
        {
            /// 地图内寻路
            mp_grid_add_cell(grid_path , i, j);
            
            var right = gg[# i+1,j];
            var left = gg[# i-1,j];
            var top = gg[# i,j-1];
            var bottom = gg[# i,j+1];
            
            var top_right = gg[# i+1,j-1];
            var top_left = gg[# i-1,j-1];
            var bottom_right = gg[# i+1,j+1];
            var bottom_left = gg[# i-1,j+1];                   
  
            right = right == -4 || (right >= 200 && right < 400);
            left = left == -4 || (left >= 200 && left < 400);
            top = top == -4 || (top >= 200 && top < 400);
            bottom = bottom == -4 || (bottom >= 200 && bottom < 400);
            top_right = top_right == -4 || (top_right >= 200 && top_right < 400);
            top_left = top_left == -4 || (top_left >= 200 && top_left < 400);
            bottom_right = bottom_right == -4 || (bottom_right >= 200 && bottom_right < 400);
            bottom_left = bottom_left == -4 || (bottom_left >= 200 && bottom_left < 400);            
  
            if(right)
            {
                var rr = instance_create(i*ts, j*ts ,obj_walltiles_side);
                rr.image_index = 5;
                rr.image_speed = 0;
                
            }
            if(left)
            {
                var ll = instance_create(i*ts, j*ts ,obj_walltiles_side);
                ll.image_index = 3;
                ll.image_speed = 0;
            }
            if(top)
            {
                var tt = instance_create(i*ts, j*ts ,obj_walltiles_side);
                tt.image_index = 1;
                tt.image_speed = 0;  
                //tt.depth = -10000; 
            }
            if(bottom)
            {
                instance_create(i*ts, (j+1)*ts-10, obj_walltiles_wall);
                var bb = instance_create(i*ts, j*ts ,obj_walltiles_side);
                bb.image_index = 7;
                bb.image_speed = 0;
            }
            
              
        }
        
        else if( -1 < ds_grid_get(argument[0], i, j) and ds_grid_get(argument[0], i, j) < 99 || ds_grid_get(argument[0], i, j) == 150)
        {
            //tile_add(bck_Floor, 0, 0, tile_w, tile_h, i * ts, j * ts, 20000);
        }
    }
}

