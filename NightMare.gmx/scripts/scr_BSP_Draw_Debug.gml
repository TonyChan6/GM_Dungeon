//argument0 : grid to use
//argument1 : base room resolution (ie: 8, 16, 32 etc...)

draw_set_halign(fa_center);
draw_set_font(fnt_BSP_Arial);

var i, j, n, c;
for (j = 0; j < ds_grid_height(argument0); j++;)
    {
    for (i = 0; i < ds_grid_width(argument0); i++;)
        {
        n=ds_grid_get(argument0,i,j);
            {
            if n = -4 || n = -10 //Floor
                {
                c = c_gray;
                }
            else if n > 500 && n < 1000 //Pathfinder position
                {
                c = c_white;
                }
            else if n = 100 //Wall
                {
                c = c_blue;
                }
            else if n = 200 //Corridor
                {
                c = c_aqua;
                }
            else if n = 300 || n = 301//Door
                {
                c = c_yellow;
                }
            else if n = 150 //Room edge
                {
                c = c_maroon;
                }
            else c = col[n]; //Initial split number
            draw_rectangle_color(i * argument1, j * argument1, (i * argument1) + argument1, (j * argument1) + argument1,c,c,c,c,false);
            draw_text((i * argument1) + 8, (j * argument1) + 4, ds_grid_get(argument0, i, j));
            }
        }
    }
