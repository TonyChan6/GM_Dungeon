/// src_Map_Init_Create

///BSP Random Dungeon Generator

var split_width_min = 3;
var split_skip_num = 0;
var split_num = 6;
global.tileSize = 32;
global.roomDelta = 2;

bsp_grid = scr_BSP_Create(global.tileSize, split_num);
scr_BSP_Split_Room(bsp_grid, split_width_min, split_num);
count = scr_BSP_Create_Room_Space(bsp_grid, split_skip_num, split_width_min);
scr_BSP_Create_Internal_Walls(bsp_grid, count, tile_size);
scr_BSP_Create_Corridors(bsp_grid, tile_size, count);

// Controller variable for drawing/playing
debug_draw = true;

scr_BSP_Draw_Debug(bsp_grid, tile_size);

///Glob Left Pressed to Create Test Object

// Here we create the Objects
//scr_BSP_Create_Objects(bsp_grid, tile_size, count, obj_DEMO_Wall, obj_DEMO_Door);
scr_NM_Create_Objects(bsp_grid, tile_size, count);

// 寻路mp
scr_NM_CreatePathFinding(bsp_grid);

// now we clear the BSP stuff
//scr_BSP_Clear(bsp_grid);

window_center();
