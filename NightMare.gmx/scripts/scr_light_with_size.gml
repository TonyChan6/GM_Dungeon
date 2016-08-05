/// scr_light_with_size

lightSize = argument0;
lightColor = argument1;
lightFlash = argument2;

//size = 256;

if lightFlash = true{
    var dif = choose(-lightSize/7, 0, lightSize/7);
    lightSize += dif;
    lightSize = clamp(lightSize, lightSize*0.85, lightSize*1.15);
}

//show_debug_message(size);

draw_set_blend_mode(bm_subtract);
surface_set_target(light);

draw_ellipse_colour(x-lightSize/2-view_xview,y-lightSize/2-view_yview,x+lightSize/2-view_xview,y+lightSize/2-view_yview,lightColor,c_black,false);
//draw_sprite_ext(spr_light, 0, x, y, 1, 1, 0, c_yellow, 1);
surface_reset_target();
draw_set_blend_mode(bm_normal);


