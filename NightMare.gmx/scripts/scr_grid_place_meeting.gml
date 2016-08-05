//scr_grid_place_meeting(x,y)

var xx = argument[0];
var yy = argument[1];

//show_debug_message("x:" + string(argument[0]) + "y:" + string(argument[1]));
//show_debug_message("xx:" + string(xx) + "yy:" + string(yy));


// Rememeber our Position

var xp = x;
var yp = y;

var tilesize = global.tileSize;

// Update the position for the bbox calculations
x = xx;
y = yy;



// Check for x meeting
var bbox_right_top = (obj_Map_Init.bsp_grid[# bbox_right div tilesize, bbox_top div tilesize]);
var bbox_left_top = (obj_Map_Init.bsp_grid[# bbox_left div tilesize, bbox_top div tilesize]);
var bbox_right_bottom = (obj_Map_Init.bsp_grid[# bbox_right div tilesize, bbox_bottom div tilesize]);
var bbox_left_bottom = (obj_Map_Init.bsp_grid[# bbox_left div tilesize, bbox_bottom div tilesize]);

var x_meeting = (bbox_right_top != -4 && (bbox_right_top < 200 || bbox_right_top > 400 ))or
                (bbox_left_top != -4 && (bbox_left_top < 200 || bbox_left_top > 400));

var y_meeting = (bbox_right_bottom != -4 && (bbox_right_bottom < 200 || bbox_right_bottom > 400)) or
                (bbox_left_bottom != -4 && (bbox_left_bottom < 200 || bbox_left_bottom > 400));
                
// Move back

x = xp;
y = yp;



// Return either true or false
return x_meeting || y_meeting;
