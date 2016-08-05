//argument0 : the grid to use
//argument1 : the grid resolution in the room
//argument2 : the number of rooms

show_debug_message("CREATE CORRIDORS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");


var grid_w = ds_grid_width(argument0);
var grid_h = ds_grid_height(argument0);

//Create the mp_grid...
var room_grid = mp_grid_create(0, 0, grid_w, grid_h, argument1, argument1);

//Add the walls into the grid...
for (var j = 0; j < grid_h; j++;)
{
for (var i = 0; i < grid_w; i++;)
    {
    if ds_grid_get(argument0, i, j) = 100 || ds_grid_get(argument0, i, j) = 150 mp_grid_add_cell(room_grid, i, j);
    }
}

//Now create a tunneller at the correct position within the rooms and assign a path...
var inst;
var n = 0;
for (j = 0; j < grid_h; j++;)
{
for (i = 0; i < grid_w; i++;)
    {
    if ds_grid_get(argument0, i, j) > -1
        {
        if ds_grid_get(argument0, i, j) > 500 && ds_grid_get(argument0, i, j) < 1000
            {
            inst[n] = instance_create((i * argument1), (j * argument1), obj_BSP_Tunneler);
            inst[n].num = n;
            path[n] = path_add();
            n++;
            }
        }
    }
}

//CONNECT THE ROOMS
//Create the paths from tunneler instance to tunneler instance...
i = 0;
repeat (n)
{
if i < n - 1
    {
    mp_grid_path(room_grid, path[i], inst[i].x, inst[i].y, inst[i + 1].x, inst[i + 1].y, false);
    }
else
    {
    mp_grid_path(room_grid, path[i], inst[i].x, inst[i].y, inst[0].x, inst[0].y, false);
    }
i++;
}

//Set the path to the grid...
i = 0;
repeat(n)
{
path_num = path_get_number(path[i]);
pos = 0;
for (j = 0; j < path_num; j++;)
    {
    ds_grid_set(argument0, floor(path_get_point_x(path[i], pos) / argument1), floor(path_get_point_y(path[i], pos) / argument1), 200);
    pos++;
    }
i++;
}

//Clean up...
i = 0;
repeat (n)
{
path_delete(path[i]);
i++;
}

mp_grid_destroy(room_grid);

//Add inner walls to the rooms again to fill in any unused door spaces and add doors to the spaces the path uses...
rm = 0;
repeat(argument2)
{
var xx = max(r[rm, 0], 0);
var yy = max(r[rm, 1], 0);
var ww = min(r[rm, 2] + 2, grid_w - 1);
var hh = min(r[rm, 3] + 2, grid_h - 1);
i = xx;
repeat (ww)
    {
    if ds_grid_get(argument0, i, yy) == -4 
        {
        ds_grid_set(argument0, i, yy, 100); //Fill gap with wall
        }
    else
        {
        if ds_grid_get(argument0, i, yy) == 200
            {
            ds_grid_set(argument0, i, yy, 300); //Fill gap with horizontal door
            }
        }
    if ds_grid_get(argument0, i, yy + hh) == -4 
        {
        ds_grid_set(argument0, i, yy + hh, 100);
        }
    else
        {
        if ds_grid_get(argument0, i, yy + hh) == 200 
            {
            ds_grid_set(argument0, i, yy + hh, 300);
            }
        }
    i++;
    }
i = yy;
repeat (hh + 1)
    {
    if ds_grid_get(argument0, xx, i) == -4
        {
        ds_grid_set(argument0, xx, i, 100); //Fill gap with wall
        }
    else
        {
        if ds_grid_get(argument0, xx, i) == 200
            {
            ds_grid_set(argument0, xx, i, 301); //Fill gap with vertical door
            }
        }
    if ds_grid_get(argument0, xx + ww, i) == -4
        {
        ds_grid_set(argument0, xx + ww, i, 100);
        }
    else
        {
        if ds_grid_get(argument0, xx + ww, i) == 200
            {
            ds_grid_set(argument0, xx + ww, i, 301);
            }
        }
    i+=1;
    }
rm++;
}

//Clear the room again to get rid of any unwanted walls...
rm = 0;
repeat(argument2)
{
ds_grid_set_region(argument0, r[rm, 0] + 1, r[rm, 1] + 1, r[rm, 0] + r[rm, 2] + 1, r[rm, 1] + r[rm, 3] + 1, -4);
rm += 1;
}

//Add markers to the grid so that walls are created around the corridors...
for (j = 0; j < grid_h; j++;)
{
for (i = 0; i < grid_w; i++;)
    {
    if ds_grid_get(argument0, i, j) == 200
        {
        if ds_grid_get(argument0, i + 1, j + 1) < 200 && ds_grid_get(argument0, i + 1, j + 1) != -4 
            {
            ds_grid_set(argument0, i + 1, j + 1, 100);
            }
        if ds_grid_get(argument0, i + 1, j) < 200 && ds_grid_get(argument0, i + 1, j) != -4
            {
            ds_grid_set(argument0, i + 1, j, 100);
            }
        if ds_grid_get(argument0, i + 1, j - 1) < 200 && ds_grid_get(argument0, i + 1, j - 1) != -4
            {
            ds_grid_set(argument0, i + 1, j - 1, 100);
            }
        if ds_grid_get(argument0, i - 1, j + 1) < 200 && ds_grid_get(argument0, i - 1, j + 1) != -4
            {
            ds_grid_set(argument0, i - 1, j + 1, 100);
            }
        if ds_grid_get(argument0, i - 1, j) < 200 && ds_grid_get(argument0, i - 1, j) != -4
            {
            ds_grid_set(argument0, i - 1, j, 100);
            }
        if ds_grid_get(argument0, i - 1, j - 1) < 200 && ds_grid_get(argument0, i - 1, j - 1) != -4
            {
            ds_grid_set(argument0, i - 1, j - 1, 100);
            }
        if ds_grid_get(argument0, i, j - 1) < 200 && ds_grid_get(argument0, i , j - 1) != -4
            {
            ds_grid_set(argument0, i, j - 1, 100);
            }
        if ds_grid_get(argument0, i, j + 1) < 200 && ds_grid_get(argument0, i , j + 1) != -4
            {
            ds_grid_set(argument0, i, j + 1, 100);
            }
        }
    if ds_grid_get(argument0, i, j) == 300
        {
        if ds_grid_get(argument0, i - 1, j) != 100 || ds_grid_get(argument0, i + 1, j) != 100 ds_grid_set(argument0, xx, i, 100);
        }
    if ds_grid_get(argument0, i, j) == 301
        {
        if ds_grid_get(argument0, i, j - 1) != 100 || ds_grid_get(argument0, i, j + 1) != 100 ds_grid_set(argument0, i, j, 100); // else ds_grid_set(argument0, i, j, 300);
        }
    }
}

//Add outer walls for the pathfinder
i = 0;
repeat (grid_w)
    {
    if ds_grid_get(argument0, i, 0) != 150 ds_grid_set(argument0, i, 0, 100);
    if ds_grid_get(argument0, i, grid_h - 1) != 150 ds_grid_set(argument0, i, grid_h - 1, 100);
    i++;
    }
i = 0;
repeat (grid_h)
    {
    if ds_grid_get(argument0, 0, i) != 150 ds_grid_set(argument0, 0, i, 100);
    if ds_grid_get(argument0, grid_w - 1, i) != 150 ds_grid_set(argument0, grid_w - 1, i, 100);
    i++;
    }