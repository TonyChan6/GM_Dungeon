/// scr_BSP_Populate_Rooms(object, num, room_count, player_pos, tile_size, equal_split, snap);

// This script is used for populating EVERY room area in the game room.
// It can be customised to omit the player room, as well as to divide the 
// instances spawned either equally per room, or randomly over all rooms.

// Should you need more control over the spawns, you should use the script
// "scr_BSP_Populate_Area()", as that permits you to choose the room area
// to spawn the items in on an individual basis.


// Initialise local vars....
var obj = argument0;        // Object to spawn
var num = argument1;        // Number of instances to spawn
var rmc = argument2;        // The number of room areas created (held in the BSP controller "count" variable) 
var pps = argument3;        // The player room, use -1 if you don't want the player room excluded
var tts = argument4;        // The tile size to use (also held in the controller as an instance variable "tile_size")
var equ = argument5;        // Split the spawns equally in all room areas (Ideal for spawning chests etc...)
var snp = argument6;        // Switch on/off grid snapping

var spn = tts / 2;
var spr = object_get_sprite(obj);

sprite_index = spr;

// Check for equal distribution or not....
if equ
{
var rm_split = num / rmc;                   // Get the number to split into each room
var i, j, xx, yy, ww, hh;                   // More local vars
for (i = 0; i < rmc; i++;)
    {
    if i != pps                             // Check to see if the player room should be skipped
        {
        repeat(rm_split)
            {
            xx = (r[i, 0] + 2) * tts;       // Get the start x position of the room, adding two to compensate for the room walls
            yy = (r[i, 1] + 2) * tts;       // Get the starting y for the room
            if snp
                {
                ww = irandom(r[i, 2]) * tts;    // Get the room width snapped to the grid
                hh = irandom(r[i, 3]) * tts;    // Get the room height snapped to the grid
                }
            else
                {
                ww = irandom(r[i, 2] * tts);    // Get the room width
                hh = irandom(r[i, 3] * tts);    // Get the room height
                }
            j = 0;                          // Counter variable to prevent infinite loops
            // Now check the positions for a collision with any other child of the collision parent to prevent over-lapping
            while (place_meeting(xx + ww - spn, yy + hh - spn, obj_BSP_Collision_Parent) && j < 10)
                {
                // We increment the count var to prevent infinite loops
                j++;
                // Reset the random position
                var xx = (r[i, 0] + 2) * tts;
                var yy = (r[i, 1] + 2) * tts;
                if snp
                    {
                    ww = irandom(r[i, 2]) * tts;    // Get the room width snapped to the grid
                    hh = irandom(r[i, 3]) * tts;    // Get the room height snapped to the grid
                    }
                else
                    {
                    ww = irandom(r[i, 2] * tts);    // Get the room width
                    hh = irandom(r[i, 3] * tts);    // Get the room height
                    }
                }
            // The counter hasn't timed out so create an enemy.
            if j < 10 instance_create(xx + ww - spn, yy + hh - spn, obj);
            }
        }
    }
}
else
{
var j, e_pos, xx, yy, ww, hh;                           // Initialise some local vars
for (var i = 0; i < num; i++;)
    {
    e_pos = irandom(rmc - 1);                           // Room to spawn enemies in
    if pps != -1                                        // Check if the player room is to be skipped
        {
        while (e_pos == pps) e_pos = irandom(rmc - 1);  // Make sure it is not the player room (remove if not required!)
        }
    xx = (r[e_pos, 0] + 2) * tts;                       // Get the start x position of the room, adding two to compensate for the room walls
    yy = (r[e_pos, 1] + 2) * tts;                       // Get the starting y for the room
    if snp                                              // Check for grid snapping
        {
        ww = irandom(r[e_pos, 2]) * tts;    // Get the room width snapped to the grid
        hh = irandom(r[e_pos, 3]) * tts;    // Get the room height snapped to the grid
        }
    else
        {
        ww = irandom(r[e_pos, 2] * tts);    // Get the room width
        hh = irandom(r[e_pos, 3] * tts);    // Get the room height
        }
    j = 0;                                  // Counter variable to prevent infinite loops
    // Now check the positions for a collision with an enemy so as to prevent over-lapping
    while (place_meeting(xx + ww - spn, yy + hh - spn, obj_BSP_Collision_Parent) && j < 10)
        {
        // We increment the count var to prevent infinite loops
        j++;
        // Reset the random position
        var xx = (r[e_pos, 0] + 2) * tts;
        var yy = (r[e_pos, 1] + 2) * tts;
        if snp
            {
            ww = irandom(r[e_pos, 2]) * tts;    // Get the room width snapped to the grid
            hh = irandom(r[e_pos, 3]) * tts;    // Get the room height snapped to the grid
            }
        else
            {
            ww = irandom(r[e_pos, 2] * tts);    // Get the room width
            hh = irandom(r[e_pos, 3] * tts);    // Get the room height
            }
        }
    // The counter hasn't timed out so create an enemy.
    if j < 10 instance_create(xx + ww - spn, yy + hh - spn, obj);
    }
}

sprite_index = -1;