///scr_get_path_to_player

if(instance_exists(obj_Player_Knight))
{
    var xx = obj_Player_Knight.x;
    var yy = obj_Player_Knight.y;
    
    if(mp_grid_path(obj_Map_Init.grid_path, path, x, y, xx, yy, true))
    {
        path_start(path, 2, path_action_stop, false);
    }
}


