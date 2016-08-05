///scr_BSP_Split_Room(grid, split_size, max_split);

// Create "room" areas within each split. These are randomly generated but will never be smaller 
// than the given split size (in grid squares).

// Argument0: Grid to use
// Argument2: Minimum split size in grid sqaures (minimum 3)
// Argument3: Maximum number of splits the room should TRY to achieve (minimum 2)

show_debug_message("CREATE SPLITS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

var grid_w = ds_grid_width(argument0);
var grid_h = ds_grid_height(argument0)
var grid_min = -4;
var split_num = 0;
var split_count = 0;
var grid_max = 1;
var split_real = 0;

var rm;

repeat(max(2, argument2))
{
// Check that the split value exists in the grid
if ds_grid_value_exists(argument0, 0, 0, grid_w - 1, grid_h - 1, split_num)
    {
    // Get area coordinates for the split
    for (var hh = 0; hh < grid_h; hh++;)
        {
        for (var ww = 0; ww < grid_w; ww++;)
            {
            if ds_grid_get(argument0, ww, hh) == split_num
                {
                // Get the top left corner of the split
                if grid_min < split_num
                    {
                    grid_min = split_num;
                    rm[split_num, 0] = ww;
                    rm[split_num, 1] = hh;
                    }
                else
                    {
                    rm[split_num, 2] = ww;
                    rm[split_num, 3] = hh;
                    }
                }
            }
        }
    // get the size of the area to split
    var rm_w = rm[split_num, 2] - rm[split_num, 0];
    var rm_h = rm[split_num, 3] - rm[split_num, 1];
    // Check the size and choose a split
    if  rm_w < rm_h
        {
        var s = 0;
        }
    else
        {
        if rm_w > rm_h
            {
            var s = 1;
            }
        else
            {
            var s = choose(0, 1);
            }
        }
    // Check edge size exit current split if too small...
    if rm_w < argument1 || rm_h < argument1
        {
        split_num++;
        if split_num = grid_max
            {
            split_num = 0;
            grid_max++;
            }
        continue;
        }
    // Set the grid to the new area number depending on the split
    if s == 0 
        {
        var rm_size = rm_h div 3;
        if rm_size > argument1
            {
            var new_y = rm_size + (irandom(rm_size));
            ds_grid_set_region(argument0, rm[split_num, 0], rm[split_num, 1] + new_y, rm[split_num, 2], rm[split_num, 3], split_count++);
            }
        }
    else
        {
        var rm_size = rm_w div 3;
        if rm_size > argument1
            {
            var new_x = rm_size + (irandom(rm_size));
            ds_grid_set_region(argument0, rm[split_num, 0] + new_x, rm[split_num, 1], rm[split_num, 2], rm[split_num, 3], split_count++);
            }
        }
    }
split_num++;
if split_num = grid_max
    {
    split_num = 0;
    grid_max++;
    }
}