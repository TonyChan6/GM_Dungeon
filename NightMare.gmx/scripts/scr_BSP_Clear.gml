///scr_BSP_Clear(grid);

// Remove the tunneler object
with (obj_BSP_Tunneler) instance_destroy();

// Remove the ds_grid
ds_grid_destroy(argument0);
