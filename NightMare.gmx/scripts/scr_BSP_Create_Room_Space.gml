//argument0 : the argument0 to use
//argument1 : the number of rooms to skip
//argument2 : the minimum room edge

show_debug_message("CREATE ROOM SPACES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

var gw = ds_grid_width(argument0);
var gh = ds_grid_height(argument0);

//Get the number of areas from the argument0
var grid_max = ds_grid_get_max(argument0, 0, 0, gw - 1, gh - 1) + 1;

//Create the skip list
var room_skip_num = min(argument1, grid_max - 1);
var room_skip_list = ds_list_create();

repeat (grid_max)
{
//Add the rooms to skip to the list. True = can be skipped, false = can't
if room_skip_num > 0
    {
    ds_list_add(room_skip_list, true);
    room_skip_num -= 1;
    }
else ds_list_add(room_skip_list, false);
}

//Shuffle the room list to create a random choice
ds_list_shuffle(room_skip_list);

//Setup the room counter
var room_current = 0;
var room_count = 0;

//loop through the areas...
repeat(grid_max)
{
if !ds_list_find_value(room_skip_list, room_current) && ds_grid_value_exists(argument0, 0, 0, gw, gh, room_current)
    {
    //loop through the argument0 to find the current room...
    var area_min = -4;
    for (var hh = 0; hh < gh; hh++;)
        {
        for (var ww = 0; ww < gw; ww++;)
            {
            if ds_grid_get(argument0, ww, hh) == room_current
                {
                if area_min < room_current
                    {
                    area_min = room_current;
                    area_x1 = ww;
                    area_y1 = hh;
                    }
                else
                    {
                    area_x2 = ww;
                    area_y2 = hh;
                    }
                }
            }
        }
    //Get the width and height of the room area...
    var area_w = area_x2 - area_x1;
    var area_h = area_y2 - area_y1;
    
    //Check to see if the area edges are above the minimum size..
    if area_w < argument2 room_w = area_w else room_w = argument2 + (floor(random(area_w - argument2)));
    if area_h < argument2 room_h = area_h else room_h = argument2 + (floor(random(area_h - argument2)));
        
    //Get the x/y values for the room...
//    var room_x = area_x1 + round(random(area_w - room_w));
//    var room_y = area_y1 + round(random(area_h - room_h));
      var room_x = area_x1 + min(round(random(area_w - room_w)),2);
      var room_y = area_y1 + min(round(random(area_h - room_h)),2);

    
    //Move the room area within the split
    while (room_x + room_w > area_x1 + area_w)
        {
        room_w--;
        room_x--;
        if room_x < area_x1
            {
            room_x++;
            }
        }
    while (room_y + room_h > area_y1 + area_h)
        {
        room_h--;
        room_y--;
        if room_y < area_y1
            {
            room_y++;
            }
        }

//Make sure the room spacing is correct for creating the paths...
    var ypos = room_y;
    repeat(room_h)
        {
        trm[0] = max(room_x - 1, 0);
        trm[1] = max(room_x - 2, 0);
        trm[2] = max(room_x - 3, 0);
        if ds_grid_get(argument0, trm[0], ypos) > -4 && ds_grid_get(argument0, trm[1], ypos) > -4 && ds_grid_get(argument0, trm[2], ypos) = -4
            {
            room_x++;
            room_w--;
            }
        trm[0] = min(room_x + room_w + 1, gw - 1);
        trm[1] = min(room_x + room_w + 2, gw - 1);
        trm[2] = min(room_x + room_w + 3, gw - 1);
        if ds_grid_get(argument0, trm[0], ypos) > -4 && ds_grid_get(argument0, trm[1], ypos) > -4 && ds_grid_get(argument0, trm[2], ypos) = -4
            {
            room_w--;
            }
        ypos++;
        }
    var xpos = clamp(room_x, 0, gw - 1);
    repeat(room_w)
        {
        trm[0] = max(room_y - 1, 0);
        trm[1] = max(room_y - 2, 0);
        trm[2] = max(room_y - 3, 0);
        if ds_grid_get(argument0, xpos, trm[0]) > -4 && ds_grid_get(argument0, xpos, trm[1]) > -4 && ds_grid_get(argument0, xpos,trm[2]) = -4
            {
            room_y++;
            room_h--;
            } 
        trm[0] = min(room_y + room_h + 1, gh - 1);
        trm[1] = min(room_y + room_h + 2, gh - 1);
        trm[2] = min(room_y + room_h + 3, gh - 1);
        if ds_grid_get(argument0, xpos, trm[0]) > -4 && ds_grid_get(argument0, xpos, trm[1]) > -4 && ds_grid_get(argument0,xpos,trm[2]) = -4
            {
            room_h--;
            }
        xpos++;
        }
    //Set the ds_grid for the room space to -4...
    ds_grid_set_region(argument0, max(room_x, 0), max(room_y, 0), min(room_x + room_w, gw - 1), min(room_y + room_h, gh - 1), -4);
    
    //Set the pathing point for the room
    ds_grid_set(argument0, min(room_x + floor(random(room_w - 1)), gw), min(room_y + floor(random(room_h - 1)), gh - 1), 501 + room_count);
    
    //Here we set an array with the room details
    r[room_count, 0] = room_x;
    r[room_count, 1] = room_y;
    r[room_count, 2] = room_w;
    r[room_count, 3] = room_h;
    
    room_count++;
    }
room_current++;
}

ds_list_destroy(room_skip_list);

return room_count;
