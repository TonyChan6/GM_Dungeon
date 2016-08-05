///scr_Move_State

scr_get_input();

// Dash the Player
scr_Player_Move(spd , 2);

// Create the dash effect
var dash = instance_create(x,y,obj_Player_dash);
dash.sprite_index = sprite_index;
dash.image_index = image_index;
dash.image_xscale = faceto;
