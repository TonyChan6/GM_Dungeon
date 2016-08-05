/// scr_BSP_Populate_Area(object, num, room_num, tile_size, snap);

// This script is used for populating EVERY room area in the game room.
// It can be customised to omit the player room, as well as to divide the 
// instances spawned either equally per room, or randomly over all rooms.

// Should you need more control over the spawns, you should use the script
// "scr_BSP_Populate_Area()", as that permits you to choose the room area
// to spawn the items in on an individual basis.


// Initialise local vars....
var obj = argument0;        // Object to spawn
var num = argument1;        // Number of instances to spawn
var rmn = argument2;        // The number of room areas created (held in the BSP controller "count" variable) 
var tts = argument3;        // The tile size to use (also held in the controller as an instance variable "tile_size")
var snp = argument4;        // Switch on/off grid snapping

var spn = tts / 2;
var spr = object_get_sprite(obj);

sprite_index = spr;

// Check for equal distribution or not....

var j, xx, yy, ww, hh;                // More local vars
repeat(num)
{
xx = (r[rmn, 0] + 2) * tts;           // Get the start x position of the room, adding two to compensate for the room walls
yy = (r[rmn, 1] + 2) * tts;           // Get the starting y for the room
if snp                                // Check for grid snapping
    {
    ww = irandom(r[rmn, 2]) * tts;    // Get the room width snapped to the grid
    hh = irandom(r[rmn, 3]) * tts;    // Get the room height snapped to the grid
    }
else
    {
    ww = irandom(r[rmn, 2] * tts);    // Get the room width
    hh = irandom(r[rmn, 3] * tts);    // Get the room height
    }
j = 0;                                // Counter variable to prevent infinite loops
// Now check the positions for a collision with any other child of the collision parent to prevent over-lapping
while (place_meeting(xx + ww - spn, yy + hh - spn, obj_BSP_Collision_Parent) && j < 10)
    {
    // We increment the count var to prevent infinite loops
    j++;
    // Reset the random position
    var xx = (r[rmn, 0] + 2) * tts;
    var yy = (r[rmn, 1] + 2) * tts;
    if snp
        {
        ww = irandom(r[rmn, 2]) * tts;
        hh = irandom(r[rmn, 3]) * tts;
        }
    else
        {
        ww = irandom(r[rmn, 2] * tts);
        hh = irandom(r[rmn, 3] * tts);
        }
    }
// The counter hasn't timed out so create an enemy.
if j < 10 instance_create(xx + ww - spn, yy + hh - spn, obj);
}

sprite_index = -1;
