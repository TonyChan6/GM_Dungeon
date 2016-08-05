//scr_get_input

right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_right);

dash_key = keyboard_check_pressed(ord('C'));
//dash_key = keyboard_check(vk_control);

xaxis = (keyboard_check(vk_right)-keyboard_check(vk_left))*spd;
yaxis = (keyboard_check(vk_down)-keyboard_check(vk_up))*spd;
