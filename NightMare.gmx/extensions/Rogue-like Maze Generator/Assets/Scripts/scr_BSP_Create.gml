///scr_BSP_Create(tile_size, split_num);

//Randomise the starting seed
randomize();

//create the tile_size variable
tile_size = argument0;

// DEBUG!!!!!!!!!!!!!!!!!!!!! /////////////////////////////////////////////////////////

// This debug code is required for the script scr_BSP_Draw_Debug and 
// should only be removed when NOT using that script otherwise you 
// will get errors. If you remove the debug code this script will require
// no arguments and the call in the obj_BSP_Create will need to be modified.

for (var i = 0; i < argument1; i++;)
    {
    col[i] = make_color_hsv((i * 12) mod 255, 100 + random(55), 155 + random(100));
    }
show_debug_message(string(random_get_seed()));

///////////////////////////////////////////////////////////////////////////////////////

// Create and clear the grid then return it for future use
var grid = ds_grid_create((room_width div tile_size) - 2, (room_height div tile_size) - 2);
ds_grid_clear(grid, 0);

return grid;